Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2884C670BAE
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 23:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjAQWbq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 17:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjAQWbA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 17:31:00 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930712BF1E;
        Tue, 17 Jan 2023 14:08:18 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id v6so47055885edd.6;
        Tue, 17 Jan 2023 14:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L6iofbbwZHLgCsKlgr1rNIbEck8OSQGQnY2PcA0tm8E=;
        b=RfD3OG5eaRLuot2OBFZQHHIQ0bEFoq9pfKVZzo/Ewahcf2cbpeGKTZowv7I3GNKUVa
         YUGoWK04JmBXW4Mrp6jS1eQiiPLBxcGJZHKf14gRE9d4K2Ow3BVKmd0qxTQPvyjsq+vg
         rt94uF4eg3M3J3i/dF+UBYxdcc65YMWaDFa7d73K2UnWykOR6FLMlkOEHrsdGfTs0wM/
         02KA7EIRqR8G114NhqItCGGRJ4hf8pIWPWq9AGyjqnZSBzR6qpWaD8D8vKm9An5T2b4N
         e7mdlpzjxjgBObflxSlpZhjni1FP+iGVW0yh3y4YDAU/eNbDKqPrhqxrzDV0Jd6pyu1m
         75yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6iofbbwZHLgCsKlgr1rNIbEck8OSQGQnY2PcA0tm8E=;
        b=qF1QnEM1O1n7cilgJF2Lq1sfYy8C/p8HeWzN3LyAVIA+iBfRYYv5HYBnlfW1j6OhHg
         G+Czh+PDzS43nfYoehXQkb9Af/YNinWZ42CEfl3Kj5PZ1Yt2jdmd1Se+KduL36ybX7L0
         hs6qS9qPJ0+L0OdvwUBGbOMz6KJTh36MZ92ZE166Q96mhM1kFOPUT0CtWNWTbakbb59x
         elvXblAV0h5wlOBPU9PmydpmNuJ9zNaL5auUta1dp/EkrTvJUgeOgp3Tybh11foxquOS
         9q/kayO+pE9zunydNjjgmurcrvq4s209QifyzzF7SMMZInU893fRz3tQwVOTiz4HRRUY
         ZbSw==
X-Gm-Message-State: AFqh2kqkIEVdnWsDSLHLOrfYIwmODzPTPDwqkw5y+x4G3bFzRdd/jUDR
        YoMq61CTIWfXwFeFHDiHImM=
X-Google-Smtp-Source: AMrXdXvebIZG5RejqLTEny7PNMVO11/Jdt0IfqvnaZeQq/vDjGif74IcBwgPwECAukq6s87NONNG3Q==
X-Received: by 2002:aa7:cc8f:0:b0:492:8207:f2ba with SMTP id p15-20020aa7cc8f000000b004928207f2bamr15164877edt.1.1673993297309;
        Tue, 17 Jan 2023 14:08:17 -0800 (PST)
Received: from krava ([83.240.63.124])
        by smtp.gmail.com with ESMTPSA id d2-20020a056402000200b0049e09105705sm3613073edu.62.2023.01.17.14.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 14:08:16 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 17 Jan 2023 23:08:14 +0100
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
Subject: Re: [PATCH v2 1/2] tools/resolve_btfids: Install subcmd headers
Message-ID: <Y8ccTrSfHi3VRm2h@krava>
References: <20230116215751.633675-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116215751.633675-1-irogers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 16, 2023 at 01:57:50PM -0800, Ian Rogers wrote:
> Previously tools/lib/subcmd was added to the include path, switch to
> installing the headers and then including from that directory. This
> avoids dependencies on headers internal to tools/lib/subcmd. Add the
> missing subcmd directory to the affected #include.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: iri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/bpf/resolve_btfids/Makefile | 19 ++++++++++++++-----
>  tools/bpf/resolve_btfids/main.c   |  2 +-
>  2 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> index 19a3112e271a..76b737b2560d 100644
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -35,21 +35,29 @@ SUBCMD_SRC := $(srctree)/tools/lib/subcmd/
>  BPFOBJ     := $(OUTPUT)/libbpf/libbpf.a
>  LIBBPF_OUT := $(abspath $(dir $(BPFOBJ)))/
>  SUBCMDOBJ  := $(OUTPUT)/libsubcmd/libsubcmd.a
> +SUBCMD_OUT := $(abspath $(dir $(SUBCMDOBJ)))/
>  
>  LIBBPF_DESTDIR := $(LIBBPF_OUT)
>  LIBBPF_INCLUDE := $(LIBBPF_DESTDIR)include
>  
> +SUBCMD_DESTDIR := $(SUBCMD_OUT)
> +SUBCMD_INCLUDE := $(SUBCMD_DESTDIR)include
> +
>  BINARY     := $(OUTPUT)/resolve_btfids
>  BINARY_IN  := $(BINARY)-in.o
>  
>  all: $(BINARY)
>  
> +prepare: $(BPFOBJ) $(SUBCMDOBJ)
> +
>  $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
>  	$(call msg,MKDIR,,$@)
>  	$(Q)mkdir -p $(@)
>  
>  $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
> -	$(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(abspath $(dir $@))/ $(abspath $@)
> +	$(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(SUBCMD_OUT) \
> +		    DESTDIR=$(SUBCMD_DESTDIR) prefix= \
> +		    $(abspath $@) install_headers
>  
>  $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUT)
>  	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(LIBBPF_OUT)    \
> @@ -60,14 +68,14 @@ CFLAGS += -g \
>            -I$(srctree)/tools/include \
>            -I$(srctree)/tools/include/uapi \
>            -I$(LIBBPF_INCLUDE) \
> -          -I$(SUBCMD_SRC)
> +          -I$(SUBCMD_INCLUDE)
>  
>  LIBS = -lelf -lz
>  
>  export srctree OUTPUT CFLAGS Q
>  include $(srctree)/tools/build/Makefile.include
>  
> -$(BINARY_IN): $(BPFOBJ) fixdep FORCE | $(OUTPUT)
> +$(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
>  	$(Q)$(MAKE) $(build)=resolve_btfids
>  
>  $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
> @@ -79,7 +87,8 @@ clean_objects := $(wildcard $(OUTPUT)/*.o                \
>                              $(OUTPUT)/.*.o.d             \
>                              $(LIBBPF_OUT)                \
>                              $(LIBBPF_DESTDIR)            \
> -                            $(OUTPUT)/libsubcmd          \
> +                            $(SUBCMD_OUT)                \
> +                            $(SUBCMD_DESTDIR)            \
>                              $(OUTPUT)/resolve_btfids)
>  
>  ifneq ($(clean_objects),)
> @@ -96,4 +105,4 @@ tags:
>  
>  FORCE:
>  
> -.PHONY: all FORCE clean tags
> +.PHONY: all FORCE clean tags prepare
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index 80cd7843c677..77058174082d 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -75,7 +75,7 @@
>  #include <linux/err.h>
>  #include <bpf/btf.h>
>  #include <bpf/libbpf.h>
> -#include <parse-options.h>
> +#include <subcmd/parse-options.h>
>  
>  #define BTF_IDS_SECTION	".BTF_ids"
>  #define BTF_ID		"__BTF_ID__"
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 
