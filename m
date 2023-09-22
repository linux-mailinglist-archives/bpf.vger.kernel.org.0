Return-Path: <bpf+bounces-10646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09B07AB520
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 17:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 517AC2821A3
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 15:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E8241230;
	Fri, 22 Sep 2023 15:50:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6682E65E
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 15:50:07 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4E719E
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 08:50:05 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690bc3f82a7so2147579b3a.0
        for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 08:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695397805; x=1696002605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kjDy5OSCF7yLkj7euFiTOoaO+slE+Y2FxPf45PENuII=;
        b=HEZzUCAkkQvJ2N1CC2jf2rv0nZmofjok0nwgWiJ2uNXxNR/rFl+sDzuKySJ7eolN5Z
         Djqk5Wekbol0L6slEANuHFJI31facKBlzyK4E6MaLDTjqRQv3idpAE6hJEVTqp3cSQDQ
         /mr2SrQmQ7btUkYTHN56/GmxBWxmU9KeCR9DY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695397805; x=1696002605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjDy5OSCF7yLkj7euFiTOoaO+slE+Y2FxPf45PENuII=;
        b=pJGG2m+L7rGrzi4AOa+chTxU7v8AleIyiNs7dxiBM3DJlJ3KwWdqNQ5JJ/RuqjhT1n
         +2Wg2jsz7EluZJ+QNPaOjAwunAWS6kDlPaNX+XyVjZZ2H+QXHpBvhqt3X1YG3VtdPaEs
         q9zeHAVcMIR3Pn1sC31Rr6tszUSesRuWCEhe6EszFKgg+iR3Mq30Zn0APNGxjbG4aSDF
         lP7ftRTS+15R1Vfw3map7vV5veFMVfO1IRqEgNE44uJndTdIOOwkeNR6j6nmU2i/5YM6
         bjQ02w5hzWv4FEEhyrU/Ll2taMDAQ4r78xknpcZ1Kk1YjJhMXSK4xhgIAyq/g6oBzWIU
         /AwA==
X-Gm-Message-State: AOJu0YzaoszjXg/3VLhrQsR52HJ7FCS6gUbBIvajYmKOKps3Oh//RRgn
	qn3eeAkKt+JPkxlN6hGoV1QbcQ==
X-Google-Smtp-Source: AGHT+IEyyf+eoxkS475t1c2a/GoGX7CVxeb+OCII96IfP6uUaUp7ghV1v6M46ZydurIEd8ewkEU02Q==
X-Received: by 2002:a05:6a20:564c:b0:15d:8b15:8266 with SMTP id is12-20020a056a20564c00b0015d8b158266mr3389008pzc.32.1695397805085;
        Fri, 22 Sep 2023 08:50:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x18-20020a62fb12000000b0068fe6ad4e18sm3362264pfm.157.2023.09.22.08.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 08:50:04 -0700 (PDT)
Date: Fri, 22 Sep 2023 08:50:03 -0700
From: Kees Cook <keescook@chromium.org>
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
	daniel@iogearbox.net, ast@kernel.org, renauld@google.com,
	Kui-Feng Lee <sinquersw@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v4 2/5] security: Count the LSMs enabled at compile time
Message-ID: <202309220848.010A198E7@keescook>
References: <20230922145505.4044003-1-kpsingh@kernel.org>
 <20230922145505.4044003-3-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922145505.4044003-3-kpsingh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 04:55:02PM +0200, KP Singh wrote:
> These macros are a clever trick to determine a count of the number of
> LSMs that are enabled in the config to ascertain the maximum number of
> static calls that need to be configured per LSM hook.
> 
> Without this one would need to generate static calls for the total
> number of LSMs in the kernel (even if they are not compiled) times the
> number of LSM hooks which ends up being quite wasteful.
> 
> Suggested-by: Kui-Feng Lee <sinquersw@gmail.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Thought below, but regardless of result:

Reviewed-by: Kees Cook <keescook@chromium.org>


> ---
>  include/linux/lsm_count.h | 107 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 include/linux/lsm_count.h
> 
> diff --git a/include/linux/lsm_count.h b/include/linux/lsm_count.h
> new file mode 100644
> index 000000000000..4d6dac6efb75
> --- /dev/null
> +++ b/include/linux/lsm_count.h
> @@ -0,0 +1,107 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (C) 2023 Google LLC.
> + */
> +
> +#ifndef __LINUX_LSM_COUNT_H
> +#define __LINUX_LSM_COUNT_H
> +
> +#include <linux/args.h>
> +
> +#ifdef CONFIG_SECURITY
> +
> +/*
> + * Macros to count the number of LSMs enabled in the kernel at compile time.
> + */
> +
> +/*
> + * Capabilities is enabled when CONFIG_SECURITY is enabled.
> + */
> +#if IS_ENABLED(CONFIG_SECURITY)
> +#define CAPABILITIES_ENABLED 1,
> +#else
> +#define CAPABILITIES_ENABLED
> +#endif

We're in an #ifdef CONFIG_SECURITY, so CAPABILITIES_ENABLED will always
be set. As such, we could leave off the trailing comma and list it
_last_ in the macro, and then ...

> +/*
> + *  There is a trailing comma that we need to be accounted for. This is done by
> + *  using a skipped argument in __COUNT_LSMS
> + */
> +#define __COUNT_LSMS(skipped_arg, args...) COUNT_ARGS(args)
> +#define COUNT_LSMS(args...) __COUNT_LSMS(args)

This wouldn't be needed...

> +
> +#define MAX_LSM_COUNT			\
> +	COUNT_LSMS(			\
> +		CAPABILITIES_ENABLED	\
> +		SELINUX_ENABLED		\
> +		SMACK_ENABLED		\
> +		APPARMOR_ENABLED	\
> +		TOMOYO_ENABLED		\
> +		YAMA_ENABLED		\
> +		LOADPIN_ENABLED		\
> +		LOCKDOWN_ENABLED	\
> +		BPF_LSM_ENABLED		\
> +		LANDLOCK_ENABLED)


	COUNT_ARGS(			\
		SELINUX_ENABLED		\
		SMACK_ENABLED		\
		...
		CAPABILITIES_ENABLED)

-Kees

-- 
Kees Cook

