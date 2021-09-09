Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F52E4054DA
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 15:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351710AbhIINDv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 09:03:51 -0400
Received: from www62.your-server.de ([213.133.104.62]:50340 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357081AbhIIM7h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 08:59:37 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mOJdC-000Bd2-VY; Thu, 09 Sep 2021 14:58:19 +0200
Received: from [85.5.47.65] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mOJdC-000NqE-Pe; Thu, 09 Sep 2021 14:58:18 +0200
Subject: Re: [PATCH v3 bpf-next] libbpf: add LIBBPF_DEPRECATED_SINCE macro for
 scheduling API deprecations
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, quentin@isovalent.com
Cc:     kernel-team@fb.com
References: <20210908213226.1871016-1-andrii@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <af17df18-73ae-ad25-0803-3dc37a4cc02c@iogearbox.net>
Date:   Thu, 9 Sep 2021 14:58:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210908213226.1871016-1-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26289/Thu Sep  9 10:20:35 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/8/21 11:32 PM, Andrii Nakryiko wrote:
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
> v2->v3:
>    - adding `sleep 10` revealed two more missing dependencies in resolve_btfids
>      and selftest/bpf's bench, which were fixed (BPF CI);
> v1->v2:
>    - fix bpf_preload build by adding dependency for iterators/iterators.o on
>      libbpf.a generation (caught by BPF CI);
> 
>   kernel/bpf/preload/Makefile          |  7 +++++--
>   tools/bpf/bpftool/Makefile           |  4 ++++
>   tools/bpf/resolve_btfids/Makefile    |  6 ++++--
>   tools/lib/bpf/Makefile               | 24 +++++++++++++++++-------
>   tools/lib/bpf/btf.h                  |  2 ++
>   tools/lib/bpf/libbpf_common.h        | 19 +++++++++++++++++++
>   tools/testing/selftests/bpf/Makefile |  4 ++--
>   7 files changed, 53 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/bpf/preload/Makefile b/kernel/bpf/preload/Makefile
> index 1951332dd15f..ac29d4e9a384 100644
> --- a/kernel/bpf/preload/Makefile
> +++ b/kernel/bpf/preload/Makefile
> @@ -10,12 +10,15 @@ LIBBPF_OUT = $(abspath $(obj))
>   $(LIBBPF_A):
>   	$(Q)$(MAKE) -C $(LIBBPF_SRCS) O=$(LIBBPF_OUT)/ OUTPUT=$(LIBBPF_OUT)/ $(LIBBPF_OUT)/libbpf.a
>   
> -userccflags += -I $(srctree)/tools/include/ -I $(srctree)/tools/include/uapi \
> +userccflags += -I$(LIBBPF_OUT) -I $(srctree)/tools/include/ \
> +	-I $(srctree)/tools/include/uapi \
>   	-I $(srctree)/tools/lib/ -Wno-unused-result
>   
>   userprogs := bpf_preload_umd
>   
> -clean-files := $(userprogs) bpf_helper_defs.h FEATURE-DUMP.libbpf staticobjs/ feature/
> +clean-files := $(userprogs) libbpf_version.h bpf_helper_defs.h FEATURE-DUMP.libbpf staticobjs/ feature/
> +
> +$(obj)/iterators/iterators.o: $(LIBBPF_A)
>   
>   bpf_preload_umd-objs := iterators/iterators.o
>   bpf_preload_umd-userldlibs := $(LIBBPF_A) -lelf -lz

One small issue I ran into by accident while testing:

[root@linux bpf-next]# make -j8 kernel/bpf/
   SYNC    include/config/auto.conf.cmd
   DESCEND objtool
   CALL    scripts/atomic/check-atomics.sh
   CALL    scripts/checksyscalls.sh
   CC      kernel/bpf/syscall.o
   AR      kernel/bpf/preload/built-in.a
   CC [M]  kernel/bpf/preload/bpf_preload_kern.o
   CC [U]  kernel/bpf/preload/iterators/iterators.o
In file included from ./tools/lib/bpf/libbpf.h:20,
                  from kernel/bpf/preload/iterators/iterators.c:10:
./tools/lib/bpf/libbpf_common.h:13:10: fatal error: libbpf_version.h: No such file or directory
    13 | #include "libbpf_version.h"
       |          ^~~~~~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.userprogs:43: kernel/bpf/preload/iterators/iterators.o] Error 1
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:540: kernel/bpf/preload] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [scripts/Makefile.build:540: kernel/bpf] Error 2
make: *** [Makefile:1872: kernel] Error 2

For me it was the case where tools/lib/bpf/ was already built _before_ this patch
was applied, then I applied it, and just ran make -j8 kernel/bpf/ where the above
can then be reproduced. I'd assume that as-is, this would affect many folks on update.

Thanks,
Daniel
