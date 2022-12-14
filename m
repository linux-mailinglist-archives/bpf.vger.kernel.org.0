Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F0A64D450
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 01:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiLOAEQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 19:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiLOADw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 19:03:52 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B9367A0F
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 15:57:18 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id a16so24887925edb.9
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 15:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=thaXdVueci+r5sqyA5xVeUTaBKUvqAGWedyW0FRwr2I=;
        b=a9feacFuBkE2OqXrR7oMx1pL3/VjcC9263BK0ZFshyV+5a9Xg2sI5s/eNzl9bPRfvl
         iv2Sa9ABsUmrGsfnuhGGNwDkERr1fFQTLwzf+zc2KiFCPXRZ4V8sJJ0PVw5fp8zOu/cl
         tYy+OSqtbMp5SP1+mYbFbipi+N21Ewtg5Usx4Pnutq2ibUU1+mifeCG8zqtfeQX3gqyT
         KIurDlqxFL0XCttPn8iUToKtlGCVC0nv5QUIOofjNwqog8Ce86c7+WaolHFSsdfkgHmd
         2MyUHDv5+uAH8wm382utTojTpvdfOHlBa9dOujcwrSMZukBh/Nrl19tC+n2w/yIa59sO
         wOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thaXdVueci+r5sqyA5xVeUTaBKUvqAGWedyW0FRwr2I=;
        b=GZikCX9+pP7IYKDxr/I/B4w1lnvFZd0JrploBbsc040usVsPLnV8OP2+HpSdP3YkXE
         1/vuBaLrXlLvZeGrrpQB0cnnVEOlLc72bcOqtRZJSbAi5oUJZAFb6fBC/LKiRWFUsZBO
         dUj7xHFY8UY03jkzLhF2P8bS8LYZjhFMCj89By6cTVnoCyTjRD0KLWJKwDMj63btouQ0
         M7TVpjEIZVbrPEaZ07Nm1fUqPBmenK73zU0PwgLlCN/8eXxewaGCRVq4Ltnuy3DmZ2mb
         cld6lNChsaMcX4wCgtE+evVPgTLx1D7S8hXfDoqmW7UMPINJWyd4u2D6l+0Zl+X/CpQ0
         FM2Q==
X-Gm-Message-State: ANoB5pm6E09c5LsnGceLpE5DgMDTVIfNXwwe43vtVPmXjSPbHX6ktnon
        Y+On1pyuL+NFrwf79Tq9+vI=
X-Google-Smtp-Source: AA0mqf74xKRgJ2BtSAzpdVpfWCD+IEsUeDm4rZ2wxR3z7Vw7a6f7pN/Zb/cGxa0M2pnruS/S5OaKrQ==
X-Received: by 2002:a50:cbcd:0:b0:46a:331:8e72 with SMTP id l13-20020a50cbcd000000b0046a03318e72mr22383431edi.37.1671062197353;
        Wed, 14 Dec 2022 15:56:37 -0800 (PST)
Received: from krava ([83.240.63.35])
        by smtp.gmail.com with ESMTPSA id v2-20020aa7d802000000b0046892e493dcsm6734807edq.26.2022.12.14.15.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 15:56:36 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 15 Dec 2022 00:56:35 +0100
To:     Shen Jiamin <shen_jiamin@comp.nus.edu.sg>
Cc:     bpf@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] tools/resolve_btfids: Use pkg-config to locate libelf
Message-ID: <Y5pis0BEBZB7PsBh@krava>
References: <20221214152037.395772-1-shen_jiamin@comp.nus.edu.sg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214152037.395772-1-shen_jiamin@comp.nus.edu.sg>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 14, 2022 at 11:20:37PM +0800, Shen Jiamin wrote:
> When libelf was not installed in the standard location, it cannot be
> located by the current building config.
> 
> Use pkg-config to help locate libelf in such cases.
> 
> Signed-off-by: Shen Jiamin <shen_jiamin@comp.nus.edu.sg>
> ---
>  tools/bpf/resolve_btfids/Makefile | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> index 19a3112e271a..5dcc31e01149 100644
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -56,11 +56,17 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
>  		    DESTDIR=$(LIBBPF_DESTDIR) prefix= EXTRA_CFLAGS="$(CFLAGS)" \
>  		    $(abspath $@) install_headers
> 
> +LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
> +LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
> +
>  CFLAGS += -g \
>            -I$(srctree)/tools/include \
>            -I$(srctree)/tools/include/uapi \
>            -I$(LIBBPF_INCLUDE) \
> -          -I$(SUBCMD_SRC)
> +          -I$(SUBCMD_SRC) \
> +          $(LIBELF_FLAGS)
> +
> +LDFLAGS +=  $(LIBELF_LIBS)
> 
>  LIBS = -lelf -lz

now we can remove -lelf from LIBS.. or we could do:

  LIBS = $(LIBELF_LIBS) -lz

jirka
