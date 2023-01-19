Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3265D673CCD
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 15:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjASOvb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 09:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjASOv3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 09:51:29 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FF1AF;
        Thu, 19 Jan 2023 06:51:27 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id b7so2121582wrt.3;
        Thu, 19 Jan 2023 06:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3MOWjLgerih44eb2IhlC3xN7d1/OgboMF3L7Yw/Sz9s=;
        b=UKLn3NuwU8jNfGwSS+Zl9ru3zKeKrYe74d8m6w0umcr7JYtPbr9Lo7rDqWHKqPf6HC
         +Fw0WNMOqL9mOiVu+zWoWbTWXlAPPEnfcXdw1vboWzGWVNpk+EPiJ97qdJ5RyXK4wSp6
         BQKc+86C4tiSb08Pmn1c4tOdabHeaRy4WiUj+SuqRltTT9/EEb5eT7Nz+gwBIrOTirIv
         oLj9R4+kuElA5PHDRRwApMjUFJpKrQQONPUBH10KSZpvFV8i027e/ME7hYeoaFbruUTF
         EhPAEUGniCpNB9cnpBPzSXJMAQdHNr/nE48afvG36cpJgQGO/DAA4qirc9crLRG8Gi5t
         +Evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MOWjLgerih44eb2IhlC3xN7d1/OgboMF3L7Yw/Sz9s=;
        b=sCJuvOjLSQxILAh3Ph/WVXOHOmv/l3+jfBGjIJ1Jf+SVvZ7U/RC2yHSYN87O7cjdZk
         5J/YqkbFJ2PhaYCbho7krK2H/TW5g4LugwNYATOxzljK+yo8FzyrQGfie0HPqMZbkfft
         ERT/TVFnY/fRq4hz9S45k4bWusdRXLeLx6gVv53zHgQ6Zg1w8RjALyBE2W9cSFm1lOWE
         +M95Uq1C0e0KSp8IP/FTwa93R3H1S7KstTE16DC14U6LJ4QvYyYUMegxxGmDSMugJiAl
         dFMmvCPxeCSQZB+/Eh96bmPOpCobbIdRUv8wvK4FOzESOyLPmnpTEHVVjTizhaMnmmrm
         bIig==
X-Gm-Message-State: AFqh2kp6Ipae8LPqs0jIPC0JweVAhGL2+SAEOZxH6pZeiaEXIX3sQaqn
        sDopCB9iiXYMvxWiApK1u/E=
X-Google-Smtp-Source: AMrXdXs97cBZEinuOjEk6HszHHJPOjOYoErRkwOQkBBd34PHxu3oD8NtkYkq1qmL4HFFs6crkRk9HQ==
X-Received: by 2002:a5d:5512:0:b0:2bd:bb55:e48d with SMTP id b18-20020a5d5512000000b002bdbb55e48dmr18602476wrv.66.1674139885482;
        Thu, 19 Jan 2023 06:51:25 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id e1-20020adfdbc1000000b002b8fe58d6desm34308255wrj.62.2023.01.19.06.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 06:51:24 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 19 Jan 2023 15:51:22 +0100
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
Message-ID: <Y8lY6r0g6AvVwcQq@krava>
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

I tested with cross builds for s390/ppc/arm64 and it was ok

some comments below

thanks,
jirka


> 
> Signed-off-by: Ian Rogers <irogers@google.com>
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

I wonder all the tools should use HOSTCC in the first place?
seems more clear than forcing it from other makefiles

subcmd even has:

CC ?= $(CROSS_COMPILE)gcc
LD ?= $(CROSS_COMPILE)ld
AR ?= $(CROSS_COMPILE)ar

which seems wrong unless I'm missing something.. should be always
the host compiler, right?

> +HOST_OVERRIDES := AR=$(HOSTAR) CC="$(HOSTCC)" LD="$(HOSTLD)" AR="$(HOSTAR)" \
> +		  ARCH=$(HOSTARCH) EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"

there's extra AR set and ARCH value is not in ""

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
