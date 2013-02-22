use stb-vorbis, sdl2
import stb/vorbis
import sdl2/[Core, Audio]

error: StbVorbisError
ogg: StbVorbis
buffer: Short*

mix: func (userdata:Pointer, stream:UInt8*, len:Int) {
	memset(stream, 0, len)
	ogg getSamplesInterleaved(2, buffer, len/2)	
	SdlAudio mix(stream, buffer, len, SDL_MIX_MAXVOLUME)
}


main: func(argc:Int, argv:CString*) {
	
	ogg = StbVorbis openFilename("commensualism.ogg", error&, null)
	if (ogg == null)
		Exception new("[Failed to load ogg file] %s" format(error toString())) throw()
	
	SDL init(SDL_INIT_AUDIO)
	spec: SdlAudioSpec
	spec freq = 44100
	spec format = AUDIO_S16
	spec channels = 2
	spec samples = 512
	spec callback = mix
	
	if (SdlAudio open(spec&, null) < 0)
		Exception new("[Failed to open audio device!] %s" format(SDL getError())) throw()
	
	buffer = gc_malloc(spec size)
	SdlAudio setPaused(false)
	
	while (ogg getSampleOffset() < ogg getLengthInSamples())
		SDL delay(50)
	
	SdlAudio close()
	ogg close()
	SDL quit()
}
