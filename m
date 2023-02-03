Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F6B6898F7
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 13:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjBCMlV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 07:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjBCMlV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 07:41:21 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED75F9AFE5;
        Fri,  3 Feb 2023 04:41:19 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j25so999608wrc.4;
        Fri, 03 Feb 2023 04:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wUsSYIJ5Tz555F5M3p6Mkzprl0XwwXoQ6mbWmaeqKQ4=;
        b=lqg4jWZOLPMDuJUevwiU3PKXstpBRIxEztaJwC+/yyTe29SI53b7xwTHpHzacE/H3w
         3GynsjnonNpm+qayq+h7WeEz8mPjMgGEVohgiDrEL2lWfGy7a5n+3TBQapLN0SXP5FVt
         a4FmdJ7s06Aj0LJJ3W+7V92jU8r6vyWHTVebYnuuXu/nYtMl34/i4xyeTfwyForqoRl4
         WLyAMFpVx/vsvKW+UN1rmHeUNGIzI2KeHdniOjybE6zZtD5ti305Vc1YH5brRfKVIdSs
         EB0Ngzpr3hC2u97MsHsP1faEPZ+aCrWpj8E+GPn7Tfh709DSzySLLU5sUNku2s3cp4Y/
         bRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUsSYIJ5Tz555F5M3p6Mkzprl0XwwXoQ6mbWmaeqKQ4=;
        b=GuyGvAGsCCbiWbq7TaQKw9d8+HRk1bUUbC4cpd4Bg1tUfBxvwDNticnHBgS7zMC9Ad
         42NR3myaRHKI4sMR1a6rNbceNw7yudL41vXEmA3xtAsaVqWkVp26RclJiXScY2BOPsi5
         SRRNd362//7yIsNh9AnxERgbaXYi1eCi27IaRvnglFcqt905GstJIYubxlLR8T9IzN8j
         T/ttB366tNEE+XhPZ0OKuxuCW6ArZOyNuOBT5DxhCQMWgxq/OEkitDEF5SOIkUnnYYZk
         7kxGE/1vgOpkgAT1+sj+K44x3CQnveGygfjGeq35r3nXBd10X8IbQ7VUHt8JqAFq1pbf
         gySA==
X-Gm-Message-State: AO0yUKWGatGa7wmQnLR1x/sSMJxtAu0UOe8smzv8nmb1zY4EX03qzfSS
        pP29B/T9EZ9IifhfdQtWI68=
X-Google-Smtp-Source: AK7set/u6ucZ4Xt1/4vhI8xwGCRElt/NfY8y9mqBkVFA5PRChrvrq8xGZRUL81CyHImK8iM11KON6Q==
X-Received: by 2002:a5d:5958:0:b0:2bf:cfc0:ac71 with SMTP id e24-20020a5d5958000000b002bfcfc0ac71mr7975159wri.53.1675428078335;
        Fri, 03 Feb 2023 04:41:18 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id c12-20020adffb4c000000b002b6bcc0b64dsm1913495wrs.4.2023.02.03.04.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 04:41:17 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 3 Feb 2023 13:41:15 +0100
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
Subject: Re: [PATCH v1] tools/resolve_btfids: Tidy HOST_OVERRIDES
Message-ID: <Y90A67/wRUXMMsHt@krava>
References: <20230202224253.40283-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202224253.40283-1-irogers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 02, 2023 at 02:42:53PM -0800, Ian Rogers wrote:
> Don't set EXTRA_CFLAGS to HOSTCFLAGS, ensure CROSS_COMPILE isn't
> passed through.
> 
> This patch is based on top of:
> https://lore.kernel.org/bpf/20230202112839.1131892-1-jolsa@kernel.org/
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/bpf/resolve_btfids/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> index abdd68ac08f4..2abdd85b4a08 100644
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -17,9 +17,9 @@ else
>    MAKEFLAGS=--no-print-directory
>  endif
>  
> -# always use the host compiler
> +# Overrides for the prepare step libraries.
>  HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
> -		  EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
> +		  CROSS_COMPILE=""
>  
>  RM      ?= rm
>  HOSTCC  ?= gcc
> -- 
> 2.39.1.519.gcb327c4b5f-goog
> 
