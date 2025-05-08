Return-Path: <bpf+bounces-57749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80BEAAF832
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 12:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C423AE4B7
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 10:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F299720C46F;
	Thu,  8 May 2025 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/7u9tje"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FA11D7E41
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 10:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700878; cv=none; b=gYzPmtHlJqvDpaEuPdXt01YXEjTQa7BTgmmAfBvkljFs4jbQj0Ur+aMXlWVaaeHD7ekGgEhQfMqJGICyW0/X2ihgdIh+M6I6Sz3rCf2nX/4CCtQ4F9KjY8o91gSdGdkUlaUkQftU6P8WkpCDMDIwPIO4MIQLdQVgP/5X34cHnLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700878; c=relaxed/simple;
	bh=Owbk7mAqmPPe0u0JAC5nr1czd+F5oCVR8Wde5XNJv6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMyC5vPszxgWFdpQPwxp1ujPLAnBTmhc9YSt6u2ZjgloRnPYvVyWEVs2XEVcesjakNMGHM5hleH7ba1NXd5LagIwpwripJblIDEAVQc2r1IQZ+JfovzkdoDBXiK6yFhKsCVJsKYnxrOh1T/1qgiNfR3oSB2/7S4s1VcXD/PgiDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/7u9tje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3F7C4CEE7;
	Thu,  8 May 2025 10:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746700876;
	bh=Owbk7mAqmPPe0u0JAC5nr1czd+F5oCVR8Wde5XNJv6Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D/7u9tjeN5t9JY9jo/YWT+YubJuwkkjt4ps6NPlaGyKJfQZADKoR7WcLlA1BH+LY5
	 y0hhE0AUgvFxhKzTpK7SEFboUfTVXNNcHUq+55mVvy9q2Q0TawaH8y0STdaycla0pd
	 lmel1sD4HLs5qm3qFVRq0NY0SMDMlc73GH1L8ULOBoQH+UWiLqSK0xuJ+4g32myc16
	 Z6z7WP+JDD/S6HSJ5b8orhbs+qJ89XmY8WMw8VFXMoAVS3xNRqjBYSDRaO8ZuUGC2a
	 p7iu9uW2m046ceteM4fuegiryKoUn8QfDojnzUn38HJ2dgYpmo/3vDIomeGOYBJ5El
	 fSAB/ypqSW9KQ==
Message-ID: <207edc31-38ac-49e8-ade0-d8529be61890@kernel.org>
Date: Thu, 8 May 2025 11:41:13 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 10/11] bpftool: Add support for dumping
 streams
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis
 <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>,
 Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, kernel-team@meta.com
References: <20250507171720.1958296-1-memxor@gmail.com>
 <20250507171720.1958296-11-memxor@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250507171720.1958296-11-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/05/2025 18:17, Kumar Kartikeya Dwivedi wrote:
> Add bpftool support for dumping streams of a given BPF program.
> The syntax is `bpftool prog tracelog { stdout | stderr } PROG`.
> The stdout is dumped to stdout, stderr is dumped to stderr.
> 
> Cc: Quentin Monnet <qmo@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../bpftool/Documentation/bpftool-prog.rst    |  6 ++
>  tools/bpf/bpftool/Makefile                    |  2 +-
>  tools/bpf/bpftool/bash-completion/bpftool     | 16 +++-
>  tools/bpf/bpftool/prog.c                      | 88 ++++++++++++++++++-
>  tools/bpf/bpftool/skeleton/stream.bpf.c       | 69 +++++++++++++++
>  5 files changed, 178 insertions(+), 3 deletions(-)
>  create mode 100644 tools/bpf/bpftool/skeleton/stream.bpf.c
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> index d6304e01afe0..258e16ee8def 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> @@ -173,6 +173,12 @@ bpftool prog tracelog
>      purposes. For streaming data from BPF programs to user space, one can use
>      perf events (see also **bpftool-map**\ (8)).
>  
> +bpftool prog tracelog { stdout | stderr } *PROG*
> +    Dump the BPF stream of the program. BPF programs can write to these streams
> +    at runtime with the **bpf_stream_vprintk**\ () kfunc. The kernel may write
> +    error messages to the standard error stream. This facility should be used
> +    only for debugging purposes.


Thanks! The syntax "bpftool prog tracelog stdout/stderr <prog>" works
well for me.

Can you also update the short description line at the top of the file
too? Should be:

    | **bpftool** **prog tracelog** [ { **stdout** | **stderr** } *PROG* ]


> +
>  bpftool prog run *PROG* data_in *FILE* [data_out *FILE* [data_size_out *L*]] [ctx_in *FILE* [ctx_out *FILE* [ctx_size_out *M*]]] [repeat *N*]
>      Run BPF program *PROG* in the kernel testing infrastructure for BPF,
>      meaning that the program works on the data and context provided by the
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 9e9a5f006cd2..eb908223c3bb 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -234,7 +234,7 @@ $(OUTPUT)%.bpf.o: skeleton/%.bpf.c $(OUTPUT)vmlinux.h $(LIBBPF_BOOTSTRAP)
>  $(OUTPUT)%.skel.h: $(OUTPUT)%.bpf.o $(BPFTOOL_BOOTSTRAP)
>  	$(QUIET_GEN)$(BPFTOOL_BOOTSTRAP) gen skeleton $< > $@
>  
> -$(OUTPUT)prog.o: $(OUTPUT)profiler.skel.h
> +$(OUTPUT)prog.o: $(OUTPUT)profiler.skel.h $(OUTPUT)stream.skel.h
>  
>  $(OUTPUT)pids.o: $(OUTPUT)pid_iter.skel.h
>  
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index 1ce409a6cbd9..c7c0bf3aee24 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -518,7 +518,21 @@ _bpftool()
>                      esac
>                      ;;
>                  tracelog)
> -                    return 0
> +                    case $prev in
> +                        $command)
> +                            COMPREPLY+=( $( compgen -W "stdout stderr" -- \
> +                                "$cur" ) )
> +                            return 0
> +                            ;;
> +                        stdout|stderr)
> +                            COMPREPLY=( $( compgen -W "$PROG_TYPE" -- \
> +                                "$cur" ) )
> +                            return 0
> +                            ;;
> +                        *)
> +                            return 0
> +                            ;;
> +                    esac


Works well, thanks for this!


>                      ;;
>                  profile)
>                      case $cword in
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index f010295350be..7abe4698c86c 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -35,6 +35,8 @@
>  #include "main.h"
>  #include "xlated_dumper.h"
>  
> +#include "stream.skel.h"
> +
>  #define BPF_METADATA_PREFIX "bpf_metadata_"
>  #define BPF_METADATA_PREFIX_LEN (sizeof(BPF_METADATA_PREFIX) - 1)
>  
> @@ -697,6 +699,15 @@ static int do_show(int argc, char **argv)
>  	return err;
>  }
>  
> +static int process_stream_sample(void *ctx, void *data, size_t len)
> +{
> +	FILE *file = ctx;
> +
> +	fprintf(file, "%s", (char *)data);
> +	fflush(file);
> +	return 0;
> +}
> +
>  static int
>  prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
>  	  char *filepath, bool opcodes, bool visual, bool linum)
> @@ -1113,6 +1124,80 @@ static int do_detach(int argc, char **argv)
>  	return 0;
>  }
>  
> +enum prog_tracelog_mode {
> +	TRACE_STDOUT,
> +	TRACE_STDERR,
> +};
> +
> +static int
> +prog_tracelog_stream(struct bpf_prog_info *info, enum prog_tracelog_mode mode)
> +{
> +	FILE *file = mode == TRACE_STDOUT ? stdout : stderr;
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	struct ring_buffer *ringbuf;
> +	struct stream_bpf *skel;
> +	int map_fd, ret = -1;
> +
> +	__u32 prog_id = info->id;
> +	__u32 stream_id = mode == TRACE_STDOUT ? 1 : 2;
> +
> +	skel = stream_bpf__open_and_load();
> +	if (!skel)
> +		return -errno;
> +	skel->bss->prog_id = prog_id;
> +	skel->bss->stream_id = stream_id;
> +
> +	map_fd = bpf_map__fd(skel->maps.ringbuf);
> +	ringbuf = ring_buffer__new(map_fd, process_stream_sample, file, NULL);
> +	if (!ringbuf) {
> +		ret = -errno;
> +		goto end;
> +	}
> +	do {
> +		skel->bss->written_count = skel->bss->written_size = 0;
> +		ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.bpftool_dump_prog_stream), &opts);
> +		if (ring_buffer__consume_n(ringbuf, skel->bss->written_count) != skel->bss->written_count) {
> +			ret = -EINVAL;
> +			goto end;
> +		}
> +	} while (!ret && opts.retval == EAGAIN);
> +
> +	if (opts.retval != 0)
> +		ret = -EINVAL;
> +end:
> +	stream_bpf__destroy(skel);
> +	return ret;
> +}
> +
> +
> +static int do_tracelog_any(int argc, char **argv)
> +{
> +	enum prog_tracelog_mode mode;
> +	struct bpf_prog_info info;
> +	__u32 info_len = sizeof(info);
> +	int fd, err;
> +
> +	if (argc == 0)
> +		return do_tracelog(argc, argv);
> +	if (!is_prefix(*argv, "stdout") && !is_prefix(*argv, "stderr"))
> +		usage();
> +	mode = is_prefix(*argv, "stdout") ? TRACE_STDOUT : TRACE_STDERR;
> +	NEXT_ARG();
> +
> +	if (!REQ_ARGS(2))
> +		return -1;
> +
> +	fd = prog_parse_fd(&argc, &argv);
> +	if (fd < 0)
> +		return -1;
> +
> +	err = bpf_prog_get_info_by_fd(fd, &info, &info_len);
> +	if (err < 0)
> +		return -1;
> +
> +	return prog_tracelog_stream(&info, mode);
> +}
> +
>  static int check_single_stdin(char *file_data_in, char *file_ctx_in)
>  {
>  	if (file_data_in && file_ctx_in &&
> @@ -2483,6 +2568,7 @@ static int do_help(int argc, char **argv)
>  		"                         [repeat N]\n"
>  		"       %1$s %2$s profile PROG [duration DURATION] METRICs\n"
>  		"       %1$s %2$s tracelog\n"
> +		"       %1$s %2$s tracelog { stdout | stderr } PROG\n"
>  		"       %1$s %2$s help\n"
>  		"\n"
>  		"       " HELP_SPEC_MAP "\n"
> @@ -2522,7 +2608,7 @@ static const struct cmd cmds[] = {
>  	{ "loadall",	do_loadall },
>  	{ "attach",	do_attach },
>  	{ "detach",	do_detach },
> -	{ "tracelog",	do_tracelog },
> +	{ "tracelog",	do_tracelog_any },
>  	{ "run",	do_run },
>  	{ "profile",	do_profile },
>  	{ 0 }
> diff --git a/tools/bpf/bpftool/skeleton/stream.bpf.c b/tools/bpf/bpftool/skeleton/stream.bpf.c
> new file mode 100644
> index 000000000000..910315959144
> --- /dev/null
> +++ b/tools/bpf/bpftool/skeleton/stream.bpf.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_RINGBUF);
> +	__uint(max_entries, 1024 * 1024);
> +} ringbuf SEC(".maps");
> +
> +int written_size;
> +int written_count;
> +int stream_id;
> +int prog_id;
> +
> +#define ENOENT 2
> +#define EAGAIN 11
> +#define EFAULT 14
> +
> +SEC("syscall")
> +int bpftool_dump_prog_stream(void *ctx)
> +{
> +	struct bpf_stream_elem *elem;
> +	struct bpf_stream *stream;
> +	bool cont = false;
> +	bool ret = 0;
> +
> +	stream = bpf_prog_stream_get(stream_id, prog_id);


Recalling discussion from RFC:

>> Calls to these new kfuncs will break compilation on older systems that
>> don't support them yet (and don't have the definition in their
>> vmlinux.h). We should provide fallback definitions to make sure that the
>> program compiles.
> 
> This is the only thing I haven't yet addressed in v2, because it
> seemed a bit ugly.
> I tried adding kfunc declarations, but those aren't enough.
> We rely on structs introduced and read in this patch.
> So I think vmlinux.h needs to be dropped, but it means adding a lot
> more than just the declarations, all types, plus any types they
> transitively depend on.
> Maybe there is a better way (like detecting compilation failure and skipping?).
> But if not, I will address like above in v3.

We do have to provide a workaround, or bpftool won't be able to compile 
on any machine that doesn't know the new kfuncs yet.

I don't think there are so many definitions to add (we don't need to
drop the vmlinux.h), CO-RE should help and if my understanding is
correct, we should be able to do something like this (on top of your
patch):

    diff --git a/tools/bpf/bpftool/skeleton/stream.bpf.c b/tools/bpf/bpftool/skeleton/stream.bpf.c
    index 910315959144..5e3d8f4f68a5 100644
    --- a/tools/bpf/bpftool/skeleton/stream.bpf.c
    +++ b/tools/bpf/bpftool/skeleton/stream.bpf.c
    @@ -1,6 +1,7 @@
     // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
     /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
     #include <vmlinux.h>
    +#include <bpf/bpf_core_read.h>
     #include <bpf/bpf_tracing.h>
     #include <bpf/bpf_helpers.h>

    @@ -18,10 +19,31 @@ int prog_id;
     #define EAGAIN 11
     #define EFAULT 14

    +
    +struct bpf_mem_slice___local {
    +	u32 len;
    +} __attribute__((preserve_access_index));
    +struct bpf_stream_elem___local {
    +	struct bpf_mem_slice___local mem_slice;
    +} __attribute__((preserve_access_index));
    +
    +extern struct bpf_stream *bpf_prog_stream_get(int stream_id,
    +					      u32 prog_id) __ksym;
    +extern struct bpf_stream_elem___local *
    +bpf_stream_next_elem(struct bpf_stream *stream) __ksym;
    +extern int bpf_dynptr_from_mem_slice(struct bpf_mem_slice___local *mem_slice,
    +				     u64 flags,
    +				     struct bpf_dynptr *dptr__uninit) __ksym;
    +extern void bpf_stream_free_elem(struct bpf_stream_elem___local *elem) __ksym;
    +extern void bpf_prog_stream_put(struct bpf_stream *stream) __ksym;
    +extern int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u32 dst_off,
    +			   struct bpf_dynptr *src_ptr, u32 src_off,
    +			   u32 size) __ksym;
    +
     SEC("syscall")
     int bpftool_dump_prog_stream(void *ctx)
     {
    -	struct bpf_stream_elem *elem;
    +	struct bpf_stream_elem___local *elem;
        struct bpf_stream *stream;
        bool cont = false;
        bool ret = 0;
    @@ -38,6 +60,7 @@ int bpftool_dump_prog_stream(void *ctx)
            if (!elem)
                break;
            size = elem->mem_slice.len;
    +		bpf_core_read(&size, sizeof(u32), &elem->mem_slice.len);

            if (bpf_dynptr_from_mem_slice(&elem->mem_slice, 0, &src_dptr))
                ret = EFAULT;


The diff above allowed me to compile on a box with a 6.10 kernel,
although I didn't check that the feature still works with a vmlinux
generated after applying your changes - please try it.

We should probably find workarounds for older struct and helpers too,
such as struct bpf_dynptr and bpf_ringbuf_(reserve|discard)_dynptr, but
I didn't look into it.


> +	if (!stream)
> +		return ENOENT;
> +
> +	bpf_repeat(BPF_MAX_LOOPS) {
> +		struct bpf_dynptr dst_dptr, src_dptr;
> +		int size;
> +
> +		elem = bpf_stream_next_elem(stream);
> +		if (!elem)
> +			break;
> +		size = elem->mem_slice.len;
> +
> +		if (bpf_dynptr_from_mem_slice(&elem->mem_slice, 0, &src_dptr))
> +			ret = EFAULT;
> +		if (bpf_ringbuf_reserve_dynptr(&ringbuf, size, 0, &dst_dptr))
> +			ret = EFAULT;
> +		if (bpf_dynptr_copy(&dst_dptr, 0, &src_dptr, 0, size))
> +			ret = EFAULT;
> +		bpf_ringbuf_submit_dynptr(&dst_dptr, 0);
> +
> +		written_count++;
> +		written_size += size;
> +
> +		bpf_stream_free_elem(elem);
> +
> +		/* Probe and exit if no more space, probe for twice the typical size. */
> +		if (bpf_ringbuf_reserve_dynptr(&ringbuf, 2048, 0, &dst_dptr))
> +			cont = true;
> +		bpf_ringbuf_discard_dynptr(&dst_dptr, 0);
> +
> +		if (ret || cont)
> +			break;
> +	}
> +
> +	bpf_prog_stream_put(stream);
> +
> +	return ret ? ret : (cont ? EAGAIN : 0);
> +}
> +
> +char _license[] SEC("license") = "Dual BSD/GPL";

Thanks!

