Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1B367A6A1
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 00:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjAXXFE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 18:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjAXXFE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 18:05:04 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04984AA63;
        Tue, 24 Jan 2023 15:05:02 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id vw16so43131833ejc.12;
        Tue, 24 Jan 2023 15:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LFmKISUEP4KMKksliNnDW8AAbwgCUx4p8IWA7pxHiq8=;
        b=pYl9Sv/vilxPNHDWR0TOktdrbscAf7wTpiE/As+ZQ+8c2it13bdNN7Ddyk+Y7JI1oQ
         QVVyf4ZME0aXFz+NUUphEnBxEOObUuOeJgZGqRWa+7FOgDJM8rJ41sdw/LHgtnfTAArO
         /iuFRe3off73GWeK7x6LwojsnO+jbwf0fycgy5Z4y68oNfPA8NZzBy9QJkrlz+Fpkh7L
         Kkg3ji3izc5KkKHh/ZRgmM0r2ce11j7xfqMKPVXGO92YA5iwo9fxze5ZRjOMfzAtCIL4
         fzVMf/xgJTG9/G9gxQtv2oGtXigJTQFN9smWwKM6ZiAx/nUJKc5xBgI5BWBHgiJJiiBr
         ADXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFmKISUEP4KMKksliNnDW8AAbwgCUx4p8IWA7pxHiq8=;
        b=zuKehliS+DoQol3uXzohXlg3G4vN9nD19hAHYedtlO8vjXhX6LvBpRn8ziq7X24+kw
         bqTeHMN+Ir4Z0VzTeWIuTa2nTcO1l/VsXrifS5SkHvCXY2N8sEk2HwWMIijdoupRBwAI
         QmkNPhkTnpdawahe/A7GGozXHy6fGuli2N0nK/gMdhVsTm5eB8fexL2ZlW/gQJurSkdw
         /+cRcPZqZtARfFzeosXP+rZZ5DrM0Kyz1s5Vol7qNw/FsvSLYwMII3UytscR9d7+rVJC
         fsnYQsfAbwaZgMOcdQqxoj8VPwSPsGhH3QQ1AHVVqumIolrjPshNdIe/OcoznTw8W0bU
         f/Cw==
X-Gm-Message-State: AFqh2kqXJfx9tmuwxUn6GX/6gFJOjWN8tHjkhDfZfWMlsk4OIWdLIM2J
        raA/woQpC3iE7+eKmtK+Ifk=
X-Google-Smtp-Source: AMrXdXveaCF5SJskLiomc3lMHSStv0NhioAVOI3d2VT+5OEGZYo9xjWAP63yTJ42xtolAElwMtrbtg==
X-Received: by 2002:a17:906:2308:b0:870:709e:169d with SMTP id l8-20020a170906230800b00870709e169dmr32337303eja.35.1674601500929;
        Tue, 24 Jan 2023 15:05:00 -0800 (PST)
Received: from krava ([83.240.61.48])
        by smtp.gmail.com with ESMTPSA id p16-20020a1709060e9000b008779570227bsm1464215ejf.112.2023.01.24.15.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 15:05:00 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 25 Jan 2023 00:04:57 +0100
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
Subject: Re: [PATCH v4 1/2] tools/resolve_btfids: Install subcmd headers
Message-ID: <Y9BkGR8me2T7CWoT@krava>
References: <20230124064324.672022-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124064324.672022-1-irogers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 23, 2023 at 10:43:23PM -0800, Ian Rogers wrote:
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
> index f7375a119f54..1fe0082b2ecc 100644
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
> @@ -63,7 +71,7 @@ CFLAGS += -g \
>            -I$(srctree)/tools/include \
>            -I$(srctree)/tools/include/uapi \
>            -I$(LIBBPF_INCLUDE) \
> -          -I$(SUBCMD_SRC) \
> +          -I$(SUBCMD_INCLUDE) \
>            $(LIBELF_FLAGS)
>  
>  LIBS = $(LIBELF_LIBS) -lz
> @@ -71,7 +79,7 @@ LIBS = $(LIBELF_LIBS) -lz
>  export srctree OUTPUT CFLAGS Q
>  include $(srctree)/tools/build/Makefile.include
>  
> -$(BINARY_IN): $(BPFOBJ) fixdep FORCE | $(OUTPUT)
> +$(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
>  	$(Q)$(MAKE) $(build)=resolve_btfids
>  
>  $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
> @@ -83,7 +91,8 @@ clean_objects := $(wildcard $(OUTPUT)/*.o                \
>                              $(OUTPUT)/.*.o.d             \
>                              $(LIBBPF_OUT)                \
>                              $(LIBBPF_DESTDIR)            \
> -                            $(OUTPUT)/libsubcmd          \
> +                            $(SUBCMD_OUT)                \
> +                            $(SUBCMD_DESTDIR)            \
>                              $(OUTPUT)/resolve_btfids)
>  
>  ifneq ($(clean_objects),)
> @@ -100,4 +109,4 @@ tags:
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
> 2.39.0.246.g2a6d74b583-goog
> 
