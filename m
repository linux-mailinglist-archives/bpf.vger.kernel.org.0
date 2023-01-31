Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55836833D2
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 18:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjAaR0L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 12:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjAaR0J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 12:26:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B96530F5;
        Tue, 31 Jan 2023 09:26:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A3CAB81E23;
        Tue, 31 Jan 2023 17:21:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49748C433EF;
        Tue, 31 Jan 2023 17:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675185659;
        bh=+pvUZxvhRwxJP5MRWV/FG2QALpGhPM4yg4kJFt4ZFlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FPKZBNkr4YMaum4++SVy1d+KjqgdDu04hJDzmRHOeWM9Rw4g69HGsE+J50iv0S43P
         052q+53XWlexnd48eQqCpsIJNW1uEY7PVJhPoNzXFw2DiD04IXHXB0faQNuLHaSuPS
         smV8LoJamcPlIQuTxPiKxxEKhyj0NdF9NuypU1FuTHfDnNzma/AfnksxfnhP5Y4LVV
         w9d2T0xHZWqXIz3nqK2rmYe4yx1tiSzdBBmXLj3vR6waNmcPhyc+MT3Vv3bVGkPzvn
         sQdaiCVDl566Z+33gbNAQX8emOTxTkm8eUac3GQTTfup+SH+Lit1/NHy5rX/WOiy0a
         sJYZdK5NKel9A==
Date:   Tue, 31 Jan 2023 10:20:56 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Connor OBrien <connoro@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v4 2/2] tools/resolve_btfids: Alter how HOSTCC is forced
Message-ID: <Y9lN+H3ModGwwKV6@dev-arch.thelio-3990X>
References: <20230124064324.672022-1-irogers@google.com>
 <20230124064324.672022-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124064324.672022-2-irogers@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Ian,

On Mon, Jan 23, 2023 at 10:43:24PM -0800, Ian Rogers wrote:
> HOSTCC is always wanted when building. Setting CC to HOSTCC happens
> after tools/scripts/Makefile.include is included, meaning flags are
> set assuming say CC is gcc, but then it can be later set to HOSTCC
> which may be clang. tools/scripts/Makefile.include is needed for host
> set up and common macros in objtool's Makefile. Rather than override
> CC to HOSTCC, just pass CC as HOSTCC to Makefile.build, the libsubcmd
> builds and the linkage step. This means the Makefiles don't see things
> like CC changing and tool flag determination, and similar, work
> properly.
> 
> Also, clear the passed subdir as otherwise an outer build may break by
> inadvertently passing an inappropriate value.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/bpf/resolve_btfids/Makefile | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> index 1fe0082b2ecc..daed388aa5d7 100644
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -18,14 +18,11 @@ else
>  endif
>  
>  # always use the host compiler
> -AR       = $(HOSTAR)
> -CC       = $(HOSTCC)
> -LD       = $(HOSTLD)
> -ARCH     = $(HOSTARCH)
> +HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
> +		  EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
> +
>  RM      ?= rm
>  CROSS_COMPILE =
> -CFLAGS  := $(KBUILD_HOSTCFLAGS)
> -LDFLAGS := $(KBUILD_HOSTLDFLAGS)
>  
>  OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
>  
> @@ -56,12 +53,12 @@ $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
>  
>  $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
>  	$(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(SUBCMD_OUT) \
> -		    DESTDIR=$(SUBCMD_DESTDIR) prefix= \
> +		    DESTDIR=$(SUBCMD_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
>  		    $(abspath $@) install_headers
>  
>  $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUT)
>  	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(LIBBPF_OUT)    \
> -		    DESTDIR=$(LIBBPF_DESTDIR) prefix= EXTRA_CFLAGS="$(CFLAGS)" \
> +		    DESTDIR=$(LIBBPF_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
>  		    $(abspath $@) install_headers
>  
>  LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
> @@ -80,11 +77,11 @@ export srctree OUTPUT CFLAGS Q
>  include $(srctree)/tools/build/Makefile.include
>  
>  $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
> -	$(Q)$(MAKE) $(build)=resolve_btfids
> +	$(Q)$(MAKE) $(build)=resolve_btfids $(HOST_OVERRIDES)
>  
>  $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
>  	$(call msg,LINK,$@)
> -	$(Q)$(CC) $(BINARY_IN) $(LDFLAGS) -o $@ $(BPFOBJ) $(SUBCMDOBJ) $(LIBS)
> +	$(Q)$(HOSTCC) $(BINARY_IN) $(KBUILD_HOSTLDFLAGS) -o $@ $(BPFOBJ) $(SUBCMDOBJ) $(LIBS)
>  
>  clean_objects := $(wildcard $(OUTPUT)/*.o                \
>                              $(OUTPUT)/.*.o.cmd           \
> -- 
> 2.39.0.246.g2a6d74b583-goog
> 

I just bisected a linking failure when building resolve_btfids with
clang to this change as commit 13e07691a16f ("tools/resolve_btfids:
Alter how HOSTCC is forced") in the bpf-next tree.

It appears to be related to whether or not CROSS_COMPILE is specified,
which we have to do for certain architectures and configurations still.
arm64 is not one of those but it helps demonstrate the issue.

  # Turn off CONFIG_DEBUG_INFO_REDUCED and turn on CONFIG_DEBUG_INFO_BTF
  $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- HOSTLDFLAGS=-fuse-ld=lld LLVM=1 defconfig menuconfig

  $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- HOSTLDFLAGS=-fuse-ld=lld LLVM=1 prepare
  ld.lld: error: $LINUX_SRC/tools/bpf/resolve_btfids//resolve_btfids-in.o is incompatible with elf64-x86-64
  clang-17: error: linker command failed with exit code 1 (use -v to see invocation)
  ...

Before your change, with V=1, I see:

clang -Wp,-MD,$LINUX_SRC/tools/bpf/resolve_btfids/.main.o.d -Wp,-MT,$LINUX_SRC/tools/bpf/resolve_btfids/main.o -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu11 -Wdeclaration-after-statement -g -I$LINUX_SRC/tools/include -I$LINUX_SRC/tools/include/uapi -I$LINUX_SRC/tools/bpf/resolve_btfids/libbpf/include -I$LINUX_SRC/tools/bpf/resolve_btfids/libsubcmd/include -D"BUILD_STR(s)=#s" -c -o $LINUX_SRC/tools/bpf/resolve_btfids/main.o main.c

After, I see:

clang -Wp,-MD,$LINUX_SRC/tools/bpf/resolve_btfids/.main.o.d -Wp,-MT,$LINUX_SRC/tools/bpf/resolve_btfids/main.o --target=aarch64-linux-gnu -g -I$LINUX_SRC/tools/include -I$LINUX_SRC/tools/include/uapi -I$LINUX_SRC/tools/bpf/resolve_btfids/libbpf/include -I$LINUX_SRC/tools/bpf/resolve_btfids/libsubcmd/include -D"BUILD_STR(s)=#s" -c -o $LINUX_SRC/tools/bpf/resolve_btfids/main.o main.c

We seem to have taken on a '--target=aarch64-linux-gnu' (changing the
target of resolve_btfids-in.o) and we dropped the warning flags.

I think this comes from the clang block in
tools/scripts/Makefile.include, which is included into the
resolve_btfids Makefile via tools/lib/bpf/Makefile.

I am not super familiar with the tools build system, otherwise I would
try to provide a patch. I tried moving CROSS_COMPILE from a recursive to
simple variable ('=' -> ':=') and moving it to HOST_OVERRIDES but those
did not appear to resolve it for me.

If there is any other information I can provide or patches I can test,
please let me know.

Cheers,
Nathan
