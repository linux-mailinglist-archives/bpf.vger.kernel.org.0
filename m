Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7CA6871F6
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 00:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjBAXbO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 18:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjBAXbN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 18:31:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E87729164;
        Wed,  1 Feb 2023 15:31:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 396D6619A5;
        Wed,  1 Feb 2023 23:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4084C433EF;
        Wed,  1 Feb 2023 23:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675294271;
        bh=V9gprzgmbvi8bC/coWIi2VjjnWJVdWisCvTYoxmGqxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p5J/M1AzPsq+HM9CVhPDjiMvjlGPPXrHdK7jMCYR0ZZuEjW7+5p9Nd7tI1zFKA4mc
         2CCyLmTNWesJtoy+ZfHsfjCJsfCrG4nKBIowGJ2wzmjfIALEChY/vh880IX0FMa8cb
         LoNM+/PAX6074YXAJobMuJL22MK/qjSa0bI/TBqh22sy/2yYPcRbGi2Dzkc+GJTC6W
         QOp6/tjEm1bfyJcbK4NGS9yNDHO9cHVA+Gc/L+MakGJTZlcf+xZIewfDakfgcpmWPQ
         SVhTbM1JdxjIsg/sOZQmzrDPsf/kgbqbjPJm118bNjX96fKzX/EnGMl7Nofq1zYxf1
         kNIrecgk0fNQw==
Date:   Wed, 1 Feb 2023 16:31:09 -0700
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
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools/resolve_btfids: Tidy host CFLAGS forcing
Message-ID: <Y9r2Paqbn6PP+EsM@dev-arch.thelio-3990X>
References: <20230201213743.44674-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201213743.44674-1-irogers@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 01, 2023 at 01:37:43PM -0800, Ian Rogers wrote:
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

Tested-by: Nathan Chancellor <nathan@kernel.org>

I can test alternative solutions as well.

> ---
>  tools/bpf/resolve_btfids/Makefile | 49 ++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> index daed388aa5d7..3ed4e3be4e06 100644
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
> @@ -43,8 +38,31 @@ SUBCMD_INCLUDE := $(SUBCMD_DESTDIR)include
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
>  all: $(BINARY)
>  
> +export srctree OUTPUT Q
> +include $(srctree)/tools/build/Makefile.include
> +
>  prepare: $(BPFOBJ) $(SUBCMDOBJ)
>  
>  $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
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
> 2.39.1.519.gcb327c4b5f-goog
> 
