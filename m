Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B215466BCC6
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 12:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjAPLWl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 06:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjAPLWk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 06:22:40 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF59A1C33A;
        Mon, 16 Jan 2023 03:22:38 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ud5so67347757ejc.4;
        Mon, 16 Jan 2023 03:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mDYnpMLjl8fAmkTS+znYTtl7s92kfNE7ldCeYDukpPI=;
        b=PYNclnm8mkcmdm6hcI4zRGZ0FAOXtgDONWNFY5tyXVKm8NQHo1U/F/AkML2C3WjSDM
         v/yJvfKc+8AtDZnXRqaPAGtyjCWqV3hGwvoQTAJ+VdTMJrLK8ILv+0K3xqZ/1Bz423dT
         zT9bxvvy7qEBLDyLVXyouOqFJMLQvhGEUNTAnlT2RF9/YotoGry1onbr8FTtzKvMoQQX
         88RCXkgf3HK8hOw1Qq9UgmjYYzn3oWJzbGkRcGGU3KAYUrgjTdcscnK+k4wG5t9lrCEj
         13RxvZgwGY7nkAGv+j8PIW7FVHgANUPtssBNkKpaqbOpMJmwcHd3iMx1RvCNnqEL52AJ
         LUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDYnpMLjl8fAmkTS+znYTtl7s92kfNE7ldCeYDukpPI=;
        b=mSjEdxQH//GBs+7vKGzObCHq0aDg42aJn3b4/XtOcT66u8TjvB0u4Pfco/cMVlApfu
         nnbaXdN2EvlWInQjyXa5JYziK0YrSz0lOeWdSX0mxfJlSAPL9kR4hcZMSBSUSf759++z
         VJ7Jt5YO/PW19ctp+1frHCudivLx9IgqqkztY9pjxWq9Zf+fVJdAaPwA3urYf/ZgHQLu
         xMP0jzLwoCtSuF61vxDjvmWPbWfPs2exGfcWXPNQfwdmzkbA1COPysA+BIiYppKmbEz3
         TNrFgwZDlJx5klTD7fey81MqiWWaB/hBsQja+iSiQmOIQ/sEMBzq6qXjijEgE2sXFYZA
         MeAw==
X-Gm-Message-State: AFqh2kpr3xY6wb1lNThtPI/XQU5IWEmXWSpd6szARjedD/YCom/jPZUh
        oSDxE7DQ9tdbWpbVBWF1x7I=
X-Google-Smtp-Source: AMrXdXu8qyN3uRoTUmLxxU+xStvu1H/yAY2P84lAeHVTBia8PCGBApU/X+rhRQ51y+D7J8ZCaa81aA==
X-Received: by 2002:a17:906:158c:b0:7c4:f752:e959 with SMTP id k12-20020a170906158c00b007c4f752e959mr72454757ejd.33.1673868157182;
        Mon, 16 Jan 2023 03:22:37 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ss5-20020a170907038500b00856ad9108e7sm7536518ejb.70.2023.01.16.03.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 03:22:36 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 16 Jan 2023 12:22:34 +0100
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
Subject: Re: [PATCH v1] tools/resolve_btfids: Install subcmd headers
Message-ID: <Y8Uzet0cNtDo8kHe@krava>
References: <20230112004024.1934601-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112004024.1934601-1-irogers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 11, 2023 at 04:40:24PM -0800, Ian Rogers wrote:
> Previously tools/lib/subcmd was added to the include path, switch to
> installing the headers and then including from that directory. This
> avoids dependencies on headers internal to tools/lib/subcmd. Add the
> missing subcmd directory to the affected #include.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/bpf/resolve_btfids/Makefile | 19 ++++++++++++++-----
>  tools/bpf/resolve_btfids/main.c   |  2 +-
>  2 files changed, 15 insertions(+), 6 deletions(-)

this depends on changes that went to Arnaldo's tree right?
I can't apply this on bpf-next/master

> 
> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> index 19a3112e271a..de7d29cf43d6 100644
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
> +prepare: $(SUBCMDOBJ)

do we need special target for that? we already have BPFOBJ dependency
placed in the BINARY_IN as prereq

why not place both as BINARY_IN prereq, or is there some other reason
for new 'prepare' target?

jirka

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
> +$(BINARY_IN): $(BPFOBJ) fixdep FORCE prepare | $(OUTPUT)
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
