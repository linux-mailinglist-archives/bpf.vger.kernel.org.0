Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654FA670BA8
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 23:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjAQWa7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 17:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjAQWaT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 17:30:19 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12FB8457B;
        Tue, 17 Jan 2023 14:07:51 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id u19so78732843ejm.8;
        Tue, 17 Jan 2023 14:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pHpBgzz2TyntaCuelGSjfnrcPlqXNF+vqKQrNZrAODM=;
        b=eRYpAhoxDWf5HFXYDDYfknEL3ta3VKqz6SZMs44VMSkSuz5vU5jmKhXCX2ra/aODsg
         R2L0QWjOP+jH8V/0PJ4Y5kmjj7l4dC+nnejw15x+8OhRzKX+RXmhHUoXwgLPQY3hnLB5
         lEOMPKAY3f/fIhbqgSd+w+NEbWiSpIwiSUrfCQz8Ln1r1SdVHLTOlXiScGw77bH+pvND
         t/d4u5uPK1r8PZuxZCq1lu8YL7ecj9mto/VeHpLVccDIu2iRaGavvX+hhPe06neeQLTv
         Vdg9EepUvlQGbH8jsc+CVj9ZjI7Fb6kBjJ7cQ1hJBWl7v7ZlOO5CDQOzqu+GsdJ26xWF
         mkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHpBgzz2TyntaCuelGSjfnrcPlqXNF+vqKQrNZrAODM=;
        b=D60pPb9Jxfx7c/KAyFtN+Tlb4uS6OR/epyzIJRdhQTAHtvEUeGJ3sKmBo34noCkePZ
         p/k0Aga8hKNhu4qnF8gXtPvHLxgn0o/iUB6XltPNpiwa80cSJH5tvQoJyEHyejE8XsuX
         b16bQj3LEIDqRw7DbkH1YtzIwrGRBYhN2zDGWzg7KttdqjFCW/iCrt0g7Ioip3nc//IU
         f8Yi1U6N5Voy9829/VjdEzSOzpZi4ZZ+HsJ4HJRGTFsKjaHQiTP+pI2zGPypCbOe2IuB
         /mV9iiJIOltrNNVgrf0ISpGMgFqPYfM0I4N653LnXWFQGKciq5f2ijx9M3gp5ITc5JVy
         blsw==
X-Gm-Message-State: AFqh2kqbKj7qvXqexLx5i+WVZ+wYp7YVMPeE5shoLaF30vrayX1Yq7fn
        xwmx4mL3tUXcDehDKdLleKY=
X-Google-Smtp-Source: AMrXdXuvL1ML2iDRl7dGWvDDTyRuBJ+VE8rGMHvqd72KQ7RW4unJlDTl1yFKDwJ8hvvs9cjC/YCbqQ==
X-Received: by 2002:a17:906:1417:b0:86d:f880:5193 with SMTP id p23-20020a170906141700b0086df8805193mr4292822ejc.38.1673993269822;
        Tue, 17 Jan 2023 14:07:49 -0800 (PST)
Received: from krava ([83.240.63.124])
        by smtp.gmail.com with ESMTPSA id rf26-20020a1709076a1a00b00871a4ab4736sm2376181ejc.97.2023.01.17.14.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 14:07:49 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 17 Jan 2023 23:07:47 +0100
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
Subject: Re: [PATCH v2 2/2] tools/resolve_btfids: Alter how HOSTCC is forced
Message-ID: <Y8ccM3pkCsp1XAnw@krava>
References: <20230116215751.633675-1-irogers@google.com>
 <20230116215751.633675-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116215751.633675-2-irogers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 16, 2023 at 01:57:51PM -0800, Ian Rogers wrote:
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

lgtm did you try cross build and build with clang?

jirka

> ---
>  tools/bpf/resolve_btfids/Makefile | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> index 76b737b2560d..515d87b32fb8 100644
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
> +HOST_OVERRIDES := AR=$(HOSTAR) CC="$(HOSTCC)" LD="$(HOSTLD)" AR="$(HOSTAR)" \
> +		  ARCH=$(HOSTARCH) EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
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
>  CFLAGS += -g \
> @@ -76,11 +73,11 @@ export srctree OUTPUT CFLAGS Q
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
> 2.39.0.314.g84b9a713c41-goog
> 
