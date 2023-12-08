Return-Path: <bpf+bounces-17206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7430680AADD
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 18:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0FD1C20AEF
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 17:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6B03A26E;
	Fri,  8 Dec 2023 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W8jvXcuV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D97285
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 09:36:06 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d048c171d6so21420365ad.1
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 09:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702056966; x=1702661766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7HSNZHOju8hpOrntNygE/eIZPol1N9ffLpPl4Rg7zEI=;
        b=W8jvXcuVbAC1oUPpxfzfrjvOSzglR5lNYEjnlM2rEGVpCQpAD/UTTs6SpbC6aIm029
         Wj/mNifzUZrYp9Q5FHUTybwudRg3gzHyNyjx7pRkHcfpl6P6YKr84V8IrzFon/TzfVp3
         ZAjV10+lfDR4+/h39+RNnvxE0XLbaIP65Z3d4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702056966; x=1702661766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HSNZHOju8hpOrntNygE/eIZPol1N9ffLpPl4Rg7zEI=;
        b=V5qfagekYpRQGVv1e68fkXe8cOD2z0Xhrj5MUXcCuKoYqkfsMsXsDUkHdbOQrJ0F47
         fPIZnUe1zcZ/Al+21ndKt3Okz1/UrvK8HRghVHLS5hsnb/r6oe0W0CrN97jTn5fyJgHi
         P16vh79dFJze6inMcBhDmc0JEfYXlH8lmanJxAP/owea6BbwuD6chcmnVBFd9NhZYI0o
         fDs6PAxMyhOGz2j+srvR9v4q5cFr7b/Kxsaq2SymsVgjzd03l+KDjJESY/X3FrZvFVHw
         QA+qN0txr8iyj5JSe/r3bY9yZP1CaGPtV8yzt6DWDYafHQNmOyBHlurZcMyOGV8nhXO4
         PD5Q==
X-Gm-Message-State: AOJu0YxDQH7wjbFVxDL1vCWJbRVtHm3QoUzukxtDLBs8vBfs+xZZHzrs
	/hCdHg+FpO034mXYJ9HlfgG29bWw578gExNKEBA=
X-Google-Smtp-Source: AGHT+IHxQc38xaqFtxteKnGXqtS4Iokq2hriYY7PcPCuC9PkObHcOWIxyx8llEN3YoWlhlGbGPJb4g==
X-Received: by 2002:a17:903:1205:b0:1d0:af43:9354 with SMTP id l5-20020a170903120500b001d0af439354mr377168plh.100.1702056966093;
        Fri, 08 Dec 2023 09:36:06 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jf18-20020a170903269200b001d087d2c42fsm1961961plb.24.2023.12.08.09.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:36:05 -0800 (PST)
Date: Fri, 8 Dec 2023 09:36:05 -0800
From: Kees Cook <keescook@chromium.org>
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
	daniel@iogearbox.net, ast@kernel.org, renauld@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH v8 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
Message-ID: <202312080934.6D172E5@keescook>
References: <20231110222038.1450156-1-kpsingh@kernel.org>
 <20231110222038.1450156-6-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110222038.1450156-6-kpsingh@kernel.org>

On Fri, Nov 10, 2023 at 11:20:37PM +0100, KP Singh wrote:
> [...]
> ---
>  security/Kconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Did something go missing from this patch? I don't see anything depending
on CONFIG_SECURITY_HOOK_LIKELY (I think this was working in v7, though?)

Regardless, Paul, please take patches 1-4, they bring us measurable
speed-ups across the board.

-Kees

> 
> diff --git a/security/Kconfig b/security/Kconfig
> index 52c9af08ad35..317018dcbc67 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -32,6 +32,17 @@ config SECURITY
>  
>  	  If you are unsure how to answer this question, answer N.
>  
> +config SECURITY_HOOK_LIKELY
> +	bool "LSM hooks are likely to be initialized"
> +	depends on SECURITY && EXPERT
> +	default SECURITY_SELINUX || SECURITY_SMACK || SECURITY_TOMOYO || SECURITY_APPARMOR
> +	help
> +	  This controls the behaviour of the static keys that guard LSM hooks.
> +	  If LSM hooks are likely to be initialized by LSMs, then one gets
> +	  better performance by enabling this option. However, if the system is
> +	  using an LSM where hooks are much likely to be disabled, one gets
> +	  better performance by disabling this config.
> +
>  config SECURITYFS
>  	bool "Enable the securityfs filesystem"
>  	help
> -- 
> 2.42.0.869.gea05f2083d-goog
> 

-- 
Kees Cook

