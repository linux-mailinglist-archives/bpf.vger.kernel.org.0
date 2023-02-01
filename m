Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD8B68633F
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 11:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjBAKAG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 05:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjBAKAF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 05:00:05 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC1C9EFF;
        Wed,  1 Feb 2023 02:00:04 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h16so16712311wrz.12;
        Wed, 01 Feb 2023 02:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BKfh9kZGElcfQInb66dRg3ol6kfpsJxnbo3jF82lBXI=;
        b=ngTdsopF2Lt3IMkGAvokGNOWGyDedIG+/NulC4t3fl0VNjQtpIeOWRqteDnZSahr8d
         hVOEVJhVHHUorpTZu3uhNIddSiIzQISCCarhstFS3D/ZwmgiVB22+OqbmFryU4xMYVpY
         GHn65HbGBnd3ECaC1hAVabrtc7x3r2Jtr/gF5BbEuw3YPkqd8MvTiSuP591danWPELEG
         wwhWvpJkMcZeY3ifXZYzo3uOoGhFlYFuaIbEkuc43It5tJTX+KOX8ceVdu11jKz3lEXK
         u86m3qHHDIQHNhN/TKCIYiyvk6UmgTB8YsTow+AQXv0ddPixqbkdU0uDN91VsL5JmdUs
         252g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKfh9kZGElcfQInb66dRg3ol6kfpsJxnbo3jF82lBXI=;
        b=WeYaoR5iSEaynYY4Yf6saxCh+r738hlt9P/C8z5+3CFNb7IPVuDmX76DDAIGV8iH6r
         pItUtvA4yu4DS6rKwBGclWoAnz3J0Z3HIl/PeCEVZaB7SlJHXJ3GmvnsgT3iSzdc8xs6
         aBs8XpgAcbjAl9e7jzMFfmIKq3HX3ywqwgCVCsW4nHw4cDkbQmG+AZOS+dzdNM/CSpMP
         C9tDuEITWMtINUDG2TBvgoTyy+x8LqT2ChL2m72F8YHf1KV3ed8Pgoco74G02Baj/sjV
         4F2KnsLn9MuhErC1cvplZKuIIbm8NMmmxa8z6aJjGhZhMXohCObFKjJp80B9v3qucsO/
         FeAw==
X-Gm-Message-State: AO0yUKVqdDCJpbaKxlinCoFqEb8xsxhUPuIEGThXL460uWR4lXWeaKwc
        wRcWhgoCJNhSSaXi/FNFdFw=
X-Google-Smtp-Source: AK7set8z6aiBJ/s82yYGH4jou6LkYbW7zLskl+Jbb4ipBXbhcRpMG8VaW6cMoTMaAMZCrP6s9WveDA==
X-Received: by 2002:a5d:67cd:0:b0:2bf:b839:c48b with SMTP id n13-20020a5d67cd000000b002bfb839c48bmr2108650wrw.51.1675245602411;
        Wed, 01 Feb 2023 02:00:02 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id p8-20020adff208000000b002423edd7e50sm17124908wro.32.2023.02.01.02.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 02:00:01 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 1 Feb 2023 10:59:59 +0100
To:     Ian Rogers <irogers@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Connor OBrien <connoro@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] tools/resolve_btfids: Tidy host CFLAGS forcing
Message-ID: <Y9o4H61YmbOSCDOG@krava>
References: <20230201015015.359535-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201015015.359535-1-irogers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 31, 2023 at 05:50:15PM -0800, Ian Rogers wrote:
> Avoid passing CROSS_COMPILE to submakes and ensure CFLAGS is forced to
> HOSTCFLAGS for submake builds. This fixes problems with cross
> compilation.
> 
> Tidy to not unnecessarily modify/export CFLAGS, make the override for
> prepare and build clearer.
> 
> Fixes: 13e07691a16f ("tools/resolve_btfids: Alter how HOSTCC is forced")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Ian Rogers <irogers@google.com>

hum, that seems to build just the fixdep and skip the resolve_btfids binary

make[1]: Entering directory '/home/jolsa/kernel/linux-qemu/build'
  GEN     Makefile
  CALL    ../scripts/checksyscalls.sh
  DESCEND bpf/resolve_btfids
  HOSTCC  /home/jolsa/kernel/linux-qemu/build/tools/bpf/resolve_btfids/fixdep.o
  HOSTLD  /home/jolsa/kernel/linux-qemu/build/tools/bpf/resolve_btfids/fixdep-in.o
  LINK    /home/jolsa/kernel/linux-qemu/build/tools/bpf/resolve_btfids/fixdep
  UPD     include/generated/utsversion.h
  CC      init/version-timestamp.o
  LD      .tmp_vmlinux.btf
  BTF     .btf.vmlinux.bin.o
die__process_unit: DW_TAG_label (0xa) @ <0x4f0d4> not handled!

  ...

die__process_unit: DW_TAG_label (0xa) @ <0xaf91cc3> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0xb032fa7> not handled!
  LD      .tmp_vmlinux.kallsyms1
  NM      .tmp_vmlinux.kallsyms1.syms
  KSYMS   .tmp_vmlinux.kallsyms1.S
  AS      .tmp_vmlinux.kallsyms1.S
  LD      .tmp_vmlinux.kallsyms2
  NM      .tmp_vmlinux.kallsyms2.syms
  KSYMS   .tmp_vmlinux.kallsyms2.S
  AS      .tmp_vmlinux.kallsyms2.S
  LD      .tmp_vmlinux.kallsyms3
  NM      .tmp_vmlinux.kallsyms3.syms
  KSYMS   .tmp_vmlinux.kallsyms3.S
  AS      .tmp_vmlinux.kallsyms3.S
  LD      vmlinux
  BTFIDS  vmlinux
../scripts/link-vmlinux.sh: line 277: ./tools/bpf/resolve_btfids/resolve_btfids: No such file or directory
make[2]: *** [../scripts/Makefile.vmlinux:35: vmlinux] Error 127
make[2]: *** Deleting file 'vmlinux'
make[1]: *** [/home/jolsa/kernel/linux-qemu/Makefile:1264: vmlinux] Error 2
make[1]: Leaving directory '/home/jolsa/kernel/linux-qemu/build'
make: *** [Makefile:242: __sub-make] Error 2

we actually have the hostprogs support in tools/build and we use it for
fixdep, I think we should use it also here, I'll check

jirka

> ---
>  tools/bpf/resolve_btfids/Makefile | 49 ++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> index daed388aa5d7..c9b6cf1fb844 100644
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -17,12 +17,7 @@ else
>    MAKEFLAGS=--no-print-directory
>  endif
>  
> -# always use the host compiler
> -HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
> -		  EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
> -
>  RM      ?= rm
> -CROSS_COMPILE =
>  
>  OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
>  
> @@ -43,6 +38,29 @@ SUBCMD_INCLUDE := $(SUBCMD_DESTDIR)include
>  BINARY     := $(OUTPUT)/resolve_btfids
>  BINARY_IN  := $(BINARY)-in.o
>  
> +LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
> +LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
> +
> +RESOLVE_BTFIDS_CFLAGS = -g \
> +          -I$(srctree)/tools/include \
> +          -I$(srctree)/tools/include/uapi \
> +          -I$(LIBBPF_INCLUDE) \
> +          -I$(SUBCMD_INCLUDE) \
> +          $(LIBELF_FLAGS)
> +
> +# Overrides for the prepare step libraries.
> +HOST_OVERRIDES_PREPARE := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" \
> +	  ARCH="$(HOSTARCH)" CROSS_COMPILE=""
> +
> +# Overrides for Makefile.build C targets.
> +HOST_OVERRIDES_BUILD := $(HOST_OVERRIDES_PREPARE) \
> +	  CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS) $(RESOLVE_BTFIDS_CFLAGS)" \
> +
> +LIBS = $(LIBELF_LIBS) -lz
> +
> +export srctree OUTPUT Q
> +include $(srctree)/tools/build/Makefile.include
> +
>  all: $(BINARY)
>  
>  prepare: $(BPFOBJ) $(SUBCMDOBJ)
> @@ -53,31 +71,16 @@ $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
>  
>  $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
>  	$(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(SUBCMD_OUT) \
> -		    DESTDIR=$(SUBCMD_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
> +		    DESTDIR=$(SUBCMD_DESTDIR) $(HOST_OVERRIDES_PREPARE) prefix= subdir= \
>  		    $(abspath $@) install_headers
>  
>  $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUT)
>  	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(LIBBPF_OUT)    \
> -		    DESTDIR=$(LIBBPF_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
> +		    DESTDIR=$(LIBBPF_DESTDIR) $(HOST_OVERRIDES_PREPARE) prefix= subdir= \
>  		    $(abspath $@) install_headers
>  
> -LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
> -LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
> -
> -CFLAGS += -g \
> -          -I$(srctree)/tools/include \
> -          -I$(srctree)/tools/include/uapi \
> -          -I$(LIBBPF_INCLUDE) \
> -          -I$(SUBCMD_INCLUDE) \
> -          $(LIBELF_FLAGS)
> -
> -LIBS = $(LIBELF_LIBS) -lz
> -
> -export srctree OUTPUT CFLAGS Q
> -include $(srctree)/tools/build/Makefile.include
> -
>  $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
> -	$(Q)$(MAKE) $(build)=resolve_btfids $(HOST_OVERRIDES)
> +	$(Q)$(MAKE) $(build)=resolve_btfids $(HOST_OVERRIDES_BUILD)
>  
>  $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
>  	$(call msg,LINK,$@)
> -- 
> 2.39.1.456.gfc5497dd1b-goog
> 
