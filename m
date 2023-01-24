Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978D567A6A6
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 00:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjAXXIa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 18:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjAXXI3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 18:08:29 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670911C318;
        Tue, 24 Jan 2023 15:08:28 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y11so19914851edd.6;
        Tue, 24 Jan 2023 15:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ktp4rc+3UNsiXd/iPytPkn47V/aRmQPBCwpETc+73Yg=;
        b=j2XLS/FAPeQmrtx1MOIMDVgSRAtlUQCZ6ytplK/Ur+LniGGhpmnr6hs7T+JQx/pIhy
         /9fEIcpCs22P97GgoabauNJUkq++SpnxqDtqE0gRgvMyk/dFd0virPAAO9cO6DJXX23N
         jkL56JDhKhO477YCpKkuWCWmNYxptX2iZ3j6vwSbSxaCqtmCohvyydv+iEJZVoESI+zU
         2L+VLF0FXNKWWtVxzmp9GjZ9mXLX6boBCnFGwjceQNVHMvfovPhP4L0g0ZmcMmrFAZVk
         64NrKiEScZ5rcZ2HahROpgMxKdggb0bSJw5/fyMamhNCzpGDzZuX6wjR/qCNBSY6sWcg
         QA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktp4rc+3UNsiXd/iPytPkn47V/aRmQPBCwpETc+73Yg=;
        b=tEWskQsJBBPKlw4mhLEdhE6WrnEu74EMz9f7wjLDBTFcbRH/T+w4gtE7zhOKmKsBpE
         pqnO0Ir2vqipeR0+nEcdRXNeoJmb1+UP2l6I5qaACr7HtXQiGwQ4an1n1aeQEsWUdvJ8
         50jRZb1DjYXDKPAOp5RyB1786ab053lE/Wh3UfmhgRTkKN3+8YXQNpRPRM8goFQxUMqj
         XS/CozPDqBo3HaR9SbmvgjtluOi5dV/IOfOShLtJ0q0KksVL5OtVYy+Q9UnVx8UyZ1Na
         Wx6DAVsGnhMbklmiMhbgYZ7pMzulpgVAX29bGfXH/HUF5xPO5Mr7smYo/wqm56df70LS
         0o5A==
X-Gm-Message-State: AFqh2krkLlN+huW4dwEueYSrGdX4EzIth6/ye3xR4mdeQiqWJiF1TEFU
        ovgGMw4huJhF8CiSRCMeBxQ=
X-Google-Smtp-Source: AMrXdXtsiDkNL0ZtJNAIs8KU3GuFjQfoj8pDxHyPnhhENQbv9JVc6b/cNNUol5zjOQSLRNaIJI/MuQ==
X-Received: by 2002:a05:6402:2026:b0:49e:9751:2f0e with SMTP id ay6-20020a056402202600b0049e97512f0emr21239060edb.27.1674601706794;
        Tue, 24 Jan 2023 15:08:26 -0800 (PST)
Received: from krava ([83.240.61.48])
        by smtp.gmail.com with ESMTPSA id i2-20020a05640200c200b0046ac017b007sm1578947edu.18.2023.01.24.15.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 15:08:25 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 25 Jan 2023 00:08:24 +0100
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
Subject: Re: [PATCH v4 2/2] tools/resolve_btfids: Alter how HOSTCC is forced
Message-ID: <Y9Bk6PNTsCRlHqCo@krava>
References: <20230124064324.672022-1-irogers@google.com>
 <20230124064324.672022-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124064324.672022-2-irogers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

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

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

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
