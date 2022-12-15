Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA57164D7BD
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 09:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiLOI3v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 03:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiLOI3u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 03:29:50 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCE260F1
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 00:29:48 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id d20so26085758edn.0
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 00:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wLEGeT8/4YW4h+1RDov8QjWfXH3FGxYM0BH0jD9o9ug=;
        b=U3oLrEajca9BuL6/9FiGfDIfS/HbCMGmGHljI6Y1vibyJ2KGJRtg7DmBTytZ4GBiwR
         kUTcB88YVTtq5/+ByHdGjfNUtyKgZe0/h3RQ5nEmKzUanh3YnKy5ihh3N16iHG7wQkms
         X11tG4XVgjp1VGY83ysakpVRQpBNfStYwQS1y1cinMKUV2giGZvG4/USsEADBY7UYqTV
         46++ltQ4QNCY0RYvGYhx72FmTobCwVe4CYMSVQnsAsLwmoRNA5wG5ODLzSViHkhLoTIT
         l8PZoB5j3ypMvQFeh1lZm3R5D2zvJSaIHuM7Oiomh0oJOQRiZBG6pgp0LmhjEsl06Zwb
         ryhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLEGeT8/4YW4h+1RDov8QjWfXH3FGxYM0BH0jD9o9ug=;
        b=WbB+9y1L66hZ8O43EQyMxikJdL1dRB3LrSoD55UAI8V0AdQHtDRU4ICmZeaAxoRGih
         brgjFP4uv7eXoGMvMUVhVCp54DbhfL1t8gFXT7XxXZPmhXEzSQa+bUv47OU1PODRt9F1
         IREu344yOADN1T27owCxYVM9F85ffPnYbb07cmbU+sXHv8S4sWIHeDfjsQx5mVffj0sL
         M7ni0D4RFGo+aSr2xIVRDp5ij4tMJthAV5xz4Rosyap1CT2w6QfsfgmVF3YAaCWwqIOj
         ehmXGK4qDc142X46aq3cVRtUa9j0+opfz5uOZR7lQlUxX8EMHiOogKB4Y614g0ss9ZTx
         YWCg==
X-Gm-Message-State: ANoB5plJV8UNfV9onBuuRSTibnkoC+SX0N3cRbus5fGS3o+B6jnOUGTa
        HdVMYLF1FSap4K7MmV905aA=
X-Google-Smtp-Source: AA0mqf4Egy+174zgnEJkkJVcXP9jBwnd0yHDYQucts8E4KQVozGyJHzOMJ97lrKgFT5yp341mDo+Lw==
X-Received: by 2002:a05:6402:320e:b0:46c:fabe:837b with SMTP id g14-20020a056402320e00b0046cfabe837bmr24514726eda.41.1671092986832;
        Thu, 15 Dec 2022 00:29:46 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id d21-20020a50fe95000000b0046f73b46c5csm6151517edt.23.2022.12.15.00.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 00:29:46 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 15 Dec 2022 09:29:44 +0100
To:     Shen Jiamin <shen_jiamin@comp.nus.edu.sg>
Cc:     bpf@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2] tools/resolve_btfids: Use pkg-config to locate libelf
Message-ID: <Y5ra+O280ehBxILH@krava>
References: <20221215044703.400139-1-shen_jiamin@comp.nus.edu.sg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215044703.400139-1-shen_jiamin@comp.nus.edu.sg>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 15, 2022 at 12:47:03PM +0800, Shen Jiamin wrote:
> When libelf was not installed in the standard location, it cannot be
> located by the current building config.
> 
> Use pkg-config to help locate libelf in such cases.
> 
> Signed-off-by: Shen Jiamin <shen_jiamin@comp.nus.edu.sg>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/bpf/resolve_btfids/Makefile | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> index 19a3112e271a..f7375a119f54 100644
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -56,13 +56,17 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
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
> 
> -LIBS = -lelf -lz
> +LIBS = $(LIBELF_LIBS) -lz
> 
>  export srctree OUTPUT CFLAGS Q
>  include $(srctree)/tools/build/Makefile.include
> --
> 2.34.1
