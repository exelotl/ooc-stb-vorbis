use stb-vorbis
include ./stb_vorbis

StbVorbisAlloc: cover from stb_vorbis_alloc {
   alloc_buffer: extern Char*
   alloc_buffer_length_in_bytes: extern Int
}

StbVorbisInfo: cover from stb_vorbis_info {
   sample_rate: extern UInt
   channels: extern Int
   setup_memory_required: extern UInt
   setup_temp_memory_required: extern UInt
   temp_memory_required: extern UInt
   max_frame_size: extern Int
}

StbVorbis: cover from stb_vorbis* {

	getInfo: extern(stb_vorbis_get_info) func -> StbVorbisInfo
	getError: extern(stb_vorbis_get_error) func -> StbVorbisError
	close: extern(stb_vorbis_close) func

	getSampleOffset: extern(stb_vorbis_get_sample_offset) func -> Int
	getFileOffset: extern(stb_vorbis_get_file_offset) func -> UInt

	openPushdata: extern(stb_vorbis_open_pushdata) static func(  \
		datablock:UInt8*, len:Int, memoryConsumed:Int*,          \
		error:StbVorbisError*, allocBuffer:StbVorbisAlloc*) -> StbVorbis

	decodeFramePushdata: extern(stb_vorbis_decode_frame_pushdata) func( \
    	datablock:UInt8*, len:Int, channels:Int*, output:Float***, samples:Int*) -> Int

	flushPushdata: extern(stb_vorbis_flush_pushdata) func
	

	decodeFilename: extern(stb_vorbis_decode_filename) static func( \
		filename:CString, channels:Int*, output:Short**) -> Int

	decodeMemory: extern(stb_vorbis_decode_memory) static func( \
		mem:UInt8*, len:Int, channels:Int*, output:Short**) -> Int

	openMemory: extern(stb_vorbis_open_memory) static func( \
		data:UInt8*, len:Int, error:StbVorbisError*, buffer:StbVorbisAlloc*) -> StbVorbis
	
	openFilename: extern(stb_vorbis_open_filename) static func(
		filename:CString, error:StbVorbisError*, buffer:StbVorbisAlloc*) -> StbVorbis
	
	openFile: extern(stb_vorbis_open_file) static func( \
		f:FStream, closeHandle:Int, error:StbVorbisError*, buffer:StbVorbisAlloc*) -> StbVorbis
	
	openFileSection: extern(stb_vorbis_open_file_section) static func( \
		f:FStream, closeHandle:Int, error:StbVorbisError*, buffer:StbVorbisAlloc*, len:UInt) -> StbVorbis
	
	
	// NOTE: these two aren't implemented in stb_vorbis yet
	//seekFrame: extern(stb_vorbis_seek_frame) func (sampleNum:UInt) -> Int
	//seek: extern(stb_vorbis_seek) func (sampleNum:UInt) -> Int
	
	seekStart: extern(stb_vorbis_seek_start) func
	
	getLengthInSamples: extern(stb_vorbis_stream_length_in_samples) func -> UInt
	getLengthInSeconds: extern(stb_vorbis_stream_length_in_seconds) func -> Float
	
	getFrame: extern(stb_vorbis_get_frame_float) func ~float (channels:Int*, output:Float***) -> Int
	
	
	getFrameInterleaved: extern(stb_vorbis_get_frame_short_interleaved) func ~short ( \
		numC:Int, buffer:Short*, numShorts:Int) -> Int
	
	getFrame: extern(stb_vorbis_get_frame_short) func ~short ( \
		numC:Int, buffer:Short**, numSamples:Int) -> Int
	
	
	getSamplesInterleaved: extern(stb_vorbis_get_samples_float_interleaved) func ~float( \
		numC:Int, buffer:Float*, numFloats:Int) -> Int
	
	getSamples: extern(stb_vorbis_get_samples_float) func ~float( \
		numC:Int, buffer:Float**, numSamples:Int) -> Int
	
	
	getSamplesInterleaved: extern(stb_vorbis_get_samples_short_interleaved) func ~short( \
		channels:Int, buffer:Short*, numShorts:Int) -> Int
	
	getSamples: extern(stb_vorbis_get_samples_short) func ~short( \
		channels:Int, buffer:Short**, numSamples:Int) -> Int
	
}
	
StbVorbisError: enum {
	
	NONE                             : extern (VORBIS__no_error)
	NEED_MORE_DATA                   : extern (VORBIS_need_more_data)
	INVALID_API_MIXING               : extern (VORBIS_invalid_api_mixing)
	OUT_OF_MEMORY                    : extern (VORBIS_outofmem)
	FEATURE_NOT_SUPPORTED            : extern (VORBIS_feature_not_supported)
	TOO_MANY_CHANNELS                : extern (VORBIS_too_many_channels)
	FILE_OPEN_FAILURE                : extern (VORBIS_file_open_failure)
	SEEK_WITHOUT_LENGTH              : extern (VORBIS_seek_without_length)
	UNEXPECTED_EOF                   : extern (VORBIS_unexpected_eof)
	SEEK_INVALID                     : extern (VORBIS_seek_invalid)
	INVALID_SETUP                    : extern (VORBIS_invalid_setup)
	INVALID_STREAM                   : extern (VORBIS_invalid_stream)
	MISSING_CAPTURE_PATTERN          : extern (VORBIS_missing_capture_pattern)
	INVALID_STREAM_STRUCTURE_VERSION : extern (VORBIS_invalid_stream_structure_version)
	CONTINUED_PACKET_FLAG_INVALID    : extern (VORBIS_continued_packet_flag_invalid)
	INCORRECT_STREAM_SERIAL_NUMBER   : extern (VORBIS_incorrect_stream_serial_number)
	INVALID_FIRST_PAGE               : extern (VORBIS_invalid_first_page)
	BAD_PACKET_TYPE                  : extern (VORBIS_bad_packet_type)
	CANT_FIND_LAST_PAGE              : extern (VORBIS_cant_find_last_page)
	SEEK_FAILED                      : extern (VORBIS_seek_failed)
	
	toString: func -> String {
		match this {
			case NONE => "none"
			case NEED_MORE_DATA => "need more data"
			case INVALID_API_MIXING => "invalid api mixing"
			case OUT_OF_MEMORY => "out of memory"
			case FEATURE_NOT_SUPPORTED => "feature not supported"
			case TOO_MANY_CHANNELS => "too many channels"
			case FILE_OPEN_FAILURE => "file open failure"
			case SEEK_WITHOUT_LENGTH => "seek without length"
			case UNEXPECTED_EOF => "unexpected eof"
			case SEEK_INVALID => "seek invalid"
			case INVALID_SETUP => "invalid setup"
			case INVALID_STREAM => "invalid stream"
			case MISSING_CAPTURE_PATTERN => "missing capture pattern"
			case INVALID_STREAM_STRUCTURE_VERSION => "invalid stream structure version"
			case CONTINUED_PACKET_FLAG_INVALID => "continued packet flag invalid"
			case INCORRECT_STREAM_SERIAL_NUMBER => "incorrect stream serial number"
			case INVALID_FIRST_PAGE => "invalid first page"
			case BAD_PACKET_TYPE => "bad packet type"
			case CANT_FIND_LAST_PAGE => "can't find last page"
			case SEEK_FAILED => "seek failed"
			case => "unknown error code '%d'" format(this)
		}
	}
}
