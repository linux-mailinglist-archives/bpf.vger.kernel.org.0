Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954B4403A2E
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 15:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344476AbhIHNCg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 09:02:36 -0400
Received: from www62.your-server.de ([213.133.104.62]:36434 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbhIHNCg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Sep 2021 09:02:36 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mNxCh-0005Yd-88; Wed, 08 Sep 2021 15:01:27 +0200
Received: from [85.5.47.65] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mNxCh-0002gn-2z; Wed, 08 Sep 2021 15:01:27 +0200
Subject: Re: [PATCH v2 bpf-next] libbpf: add LIBBPF_DEPRECATED_SINCE macro for
 scheduling API deprecations
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, quentin@isovalent.com
Cc:     kernel-team@fb.com
References: <20210908065538.1725496-1-andrii@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8ca16967-cba4-6a0c-89e7-6d774d3706b1@iogearbox.net>
Date:   Wed, 8 Sep 2021 15:01:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210908065538.1725496-1-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26288/Wed Sep  8 10:22:21 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/8/21 8:55 AM, Andrii Nakryiko wrote:
> From: Quentin Monnet <quentin@isovalent.com>
> 
> Introduce a macro LIBBPF_DEPRECATED_SINCE(major, minor, message) to prepare
> the deprecation of two API functions. This macro marks functions as deprecated
> when libbpf's version reaches the values passed as an argument.
> 
> As part of this change libbpf_version.h header is added with recorded major
> (LIBBPF_MAJOR_VERSION) and minor (LIBBPF_MINOR_VERSION) libbpf version macros.
> They are now part of libbpf public API and can be relied upon by user code.
> libbpf_version.h is installed system-wide along other libbpf public headers.
> 
> Due to this new build-time auto-generated header, in-kernel applications
> relying on libbpf (resolve_btfids, bpftool, bpf_preload) are updated to
> include libbpf's output directory as part of a list of include search paths.
> Better fix would be to use libbpf's make_install target to install public API
> headers, but that clean up is left out as a future improvement. The build
> changes were tested by building kernel (with KBUILD_OUTPUT and O= specified
> explicitly), bpftool, libbpf, selftests/bpf, and resolve_btfids builds. No
> problems were detected.
> 
> Note that because of the constraints of the C preprocessor we have to write
> a few lines of macro magic for each version used to prepare deprecation (0.6
> for now).
> 
> Also, use LIBBPF_DEPRECATED_SINCE() to schedule deprecation of
> btf__get_from_id() and btf__load(), which are replaced by
> btf__load_from_kernel_by_id() and btf__load_into_kernel(), respectively,
> starting from future libbpf v0.6. This is part of libbpf 1.0 effort ([0]).
> 
>    [0] Closes: https://github.com/libbpf/libbpf/issues/278
> 
> Co-developed-by: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
> 
> v1->v2:
>    - fix bpf_preload build by adding dependency for iterators/iterators.o on
>      libbpf.a generation (caught by BPF CI);
[...]
> @@ -136,7 +140,7 @@ all: fixdep
>   
>   all_cmd: $(CMD_TARGETS) check
>   
> -$(BPF_IN_SHARED): force $(BPF_HELPER_DEFS)
> +$(BPF_IN_SHARED): force $(BPF_GENERATED)
>   	@(test -f ../../include/uapi/linux/bpf.h -a -f ../../../include/uapi/linux/bpf.h && ( \
>   	(diff -B ../../include/uapi/linux/bpf.h ../../../include/uapi/linux/bpf.h >/dev/null) || \
>   	echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'" >&2 )) || true
> @@ -154,13 +158,19 @@ $(BPF_IN_SHARED): force $(BPF_HELPER_DEFS)
>   	echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' differs from latest version at 'include/uapi/linux/if_xdp.h'" >&2 )) || true
>   	$(Q)$(MAKE) $(build)=libbpf OUTPUT=$(SHARED_OBJDIR) CFLAGS="$(CFLAGS) $(SHLIB_FLAGS)"
>   
> -$(BPF_IN_STATIC): force $(BPF_HELPER_DEFS)
> +$(BPF_IN_STATIC): force $(BPF_GENERATED)
>   	$(Q)$(MAKE) $(build)=libbpf OUTPUT=$(STATIC_OBJDIR)
>   
>   $(BPF_HELPER_DEFS): $(srctree)/tools/include/uapi/linux/bpf.h
>   	$(QUIET_GEN)$(srctree)/scripts/bpf_doc.py --header \
>   		--file $(srctree)/tools/include/uapi/linux/bpf.h > $(BPF_HELPER_DEFS)
>   
> +$(VERSION_HDR): force
> +	$(QUIET_GEN)echo "/* This file was auto-generated. */" > $@
> +	@echo "" >> $@
> +	@echo "#define LIBBPF_MAJOR_VERSION $(LIBBPF_MAJOR_VERSION)" >> $@
> +	@echo "#define LIBBPF_MINOR_VERSION $(LIBBPF_MINOR_VERSION)" >> $@
> +

Looks like CI caught a different issue this time with v2 where it cannot find libbpf_version.h:

   [...]
     CC       bench_count.o
     GEN     /home/runner/work/bpf/bpf/tools/testing/selftests/bpf/bpf-helpers.rst
   In file included from /home/runner/work/bpf/bpf/tools/lib/bpf/bpf.h:31,
                    from /home/runner/work/bpf/bpf/tools/testing/selftests/bpf/bench.h:8,
                    from benchs/bench_count.c:3:
   /home/runner/work/bpf/bpf/tools/lib/bpf/libbpf_common.h:13:10: fatal error: libbpf_version.h: No such file or directory
      13 | #include "libbpf_version.h"
         |          ^~~~~~~~~~~~~~~~~~
   compilation terminated.
   make: *** [Makefile:517: /home/runner/work/bpf/bpf/tools/testing/selftests/bpf/bench_count.o] Error 1
   make: *** Waiting for unfinished jobs....
     GEN     /home/runner/work/bpf/bpf/tools/testing/selftests/bpf/bpf-syscall.rst
   In file included from /home/runner/work/bpf/bpf/tools/lib/bpf/bpf.h:31,
                    from bench.h:8,
                    from bench.c:13:
   /home/runner/work/bpf/bpf/tools/lib/bpf/libbpf_common.h:13:10: fatal error: libbpf_version.h: No such file or directory
      13 | #include "libbpf_version.h"
         |          ^~~~~~~~~~~~~~~~~~
   compilation terminated.
   make: *** [Makefile:162: /home/runner/work/bpf/bpf/tools/testing/selftests/bpf/bench.o] Error 1

Thanks,
Daniel
