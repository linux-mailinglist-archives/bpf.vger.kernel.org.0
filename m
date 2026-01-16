Return-Path: <bpf+bounces-79242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 212CAD31174
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 13:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DCB13062D71
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 12:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF701D95A3;
	Fri, 16 Jan 2026 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPErZThM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297D31C4A20
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768566542; cv=none; b=DhxTblK/BPha/b3Gm9c0r1y2L7uslDqtITEWXW3mFxpCcHrq+VMrSMc1ty6eflMU+P0oesbx4ghLlIZf1UaePRUCcCDUvHBBLwGvzMGW/1yguypojmM6wafccgbMiMelKk97/n547uhQQ7aNBR3XNKcPn7wBExMx+4zcbp0EtYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768566542; c=relaxed/simple;
	bh=zSRS1EpM7i5QhWexXsaKUGtAU8M9RGiL5TMpVSu7boA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4JqmzfLhhfraPLSBRleO8WadFMpGXbezu+xYtPjiiN8aT+1DAZc9IDSfIvnp5MTBv8P0y63JDC6iQNwoHMd11MqIZ/dEJwf0Mnk6JwkbYxBaCnzypCxyyXuIrUL+kuWVrJxH4+4NeqJ8bZPkxjFf3PIwGvW/02znGyK5anU0ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPErZThM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47ee807a4c5so14600335e9.2
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 04:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768566539; x=1769171339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R55B3tyhUuFn3BBEBWa2yD4pGZ5gFo/ePFSVXsSn81k=;
        b=lPErZThMI3lLUnZAW77PGcDA+xJKwXUSOE5i75WjK7y56t9wata3/4DIeySINJW3ib
         hFonPzH0yktBY3+LTu8fnXoPN4sGj2b4azgl5+meHOEkqj0CEsSiOGYbpXfNrponZw0T
         VIqaDgy0RhaVdLzYT+KQuJrz2YGQ45KJiNcT4kElt67SWHaPrSnIsjgleNE+6xxPvcKJ
         6RVxAUCfb1MLT16f/LEsIrmPMRCCEQmjd/Ruzz44jnPpahe3/bpVqlUTOvO7KkzjPoaV
         lN/MryeXBy0bQRsI7WKV9Vpvd2bSqWIeYhgO5xmuMptIIIIAR1A7xcTh8p3S6Sf0XmcM
         RoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768566539; x=1769171339;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R55B3tyhUuFn3BBEBWa2yD4pGZ5gFo/ePFSVXsSn81k=;
        b=M4VqWUWDvFTWOHtCvvV4kpgqM6MdtaAxKxGbyatQ3qV2Q6B+wMo+2cWibdkAAZgaew
         gPzyVq1EtcmsY0sxD89McWSGv5QZ+vZtnrK1pUAikbHLh3IitSSSJftQhgItnLyvmOYV
         p3ffO0sGNOmxahsHKiIrrAM1gZGPU0qTigoRToFrCuV8tNjLXv1kB4sbV8cQ3hxdnmVa
         KmCZv0Kf6SwDfxGd2mRonxv9JbT+FHouKt9WnNuj3HfllR2v7uMEMzWIBWDzLa6KLbB+
         cL7xeFQzdr25KOwYvXMoGT27ts27HU2yH6IDRh4atJ/IXx7XQZrlrBvDVziiZnK2QdEQ
         zLCw==
X-Forwarded-Encrypted: i=1; AJvYcCWePRROCOtjQmbJo8QaXIi32Cj+H69AMZLro4VJsOZlZpFxqrsL/Co3kArujtYIfCi+dw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+g/ckOJTQzRtSWTMhq2FEuz2mkBzRBFZA1eUX2oZkwdd4p+e8
	yYVC60IP+K0Ok55CAzWkWh6VDiBsK4G7IajfLEmg1vgqIX0VGcb0TLFt
X-Gm-Gg: AY/fxX6ZIiKFs06gYqOJG0RjoHpGldnAEpkIwACbuuviWP/vVNyGeiM6iZN646z0Ka4
	e88OywzZfnPDdhD4Wv7vzwqr6R9B5RXRgoo2ABr5FPdqGMML7P/+3msTWpVKLZWYO0BNLMc4upo
	P60nkXfM0l5vU1XCfJq6RFNFlr5HmggbMBGT6GlVhh2aVN0ZoBWZ2iU8/5zuwmjgdMFn29KTqVQ
	JdMIYaXmqlPXXaWFh/AEH/oggrR84EzLNZhlzrbTkJTdHA5H4sxZVB5lhNl3BLa6sbli8mnbBJQ
	cZWVJgB6hcvE1nXHj9DaBsEG+FGhvvOrGCe5R3XQPzm/BJDHynIf+U5G0s+Bq1QxAnU6+VDYMEY
	9NCKzFfwBDqqR5o2icCfl63e2FjAKeDQbjO/ghD46XqXLnCfM5BAwbadDxOqNHM/TcH+VUGkw58
	4EJwLk2CUdS4QIL+4uyykdferagK20DAE=
X-Received: by 2002:a05:600c:1552:b0:47e:e946:3a72 with SMTP id 5b1f17b1804b1-4801eb0e021mr28550255e9.27.1768566539258;
        Fri, 16 Jan 2026 04:28:59 -0800 (PST)
Received: from ?IPV6:2620:10d:c0c3:1131::11fd? ([2620:10d:c092:400::5:2520])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e86c197sm42258595e9.1.2026.01.16.04.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 04:28:58 -0800 (PST)
Message-ID: <46799ba9-d292-494e-b9b1-658448993538@gmail.com>
Date: Fri, 16 Jan 2026 12:28:58 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_strncasecmp kfunc
To: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev
References: <20260115173717.2060746-1-ishiyama@hpc.is.uec.ac.jp>
 <20260115173717.2060746-2-ishiyama@hpc.is.uec.ac.jp>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260115173717.2060746-2-ishiyama@hpc.is.uec.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/26 17:37, Yuzuki Ishiyama wrote:
> bpf_strncasecmp() function performs same like bpf_strcasecmp() except
> limiting the comparison to a specific length.
>
> Signed-off-by: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
> ---
>   kernel/bpf/helpers.c | 31 ++++++++++++++++++++++++++++---
>   1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 9eaa4185e0a7..2b275eaa3cac 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3406,7 +3406,7 @@ __bpf_kfunc void __bpf_trap(void)
>    * __get_kernel_nofault instead of plain dereference to make them safe.
>    */
>   
> -static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
> +static int __bpf_strncasecmp(const char *s1, const char *s2, bool ignore_case, size_t len)
>   {
>   	char c1, c2;
>   	int i;
> @@ -3416,6 +3416,9 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
>   		return -ERANGE;
>   	}
>   
> +	if (len == 0)
> +		return 0;
> +
>   	guard(pagefault)();
>   	for (i = 0; i < XATTR_SIZE_MAX; i++) {
>   		__get_kernel_nofault(&c1, s1, char, err_out);
> @@ -3428,6 +3431,8 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
>   			return c1 < c2 ? -1 : 1;
>   		if (c1 == '\0')
>   			return 0;
> +		if (len < XATTR_SIZE_MAX && i == len - 1)
> +			return 0;
Maybe rewrite this loop next way: u32 max_sz = min_t(u32, 
XATTR_SIZE_MAX, len); for (i=0; i < max_sz; i++) { ... } if (len < 
XATTR_SIZE_MAX) return 0; return -E2BIG; This way we eliminate that 
entire if statement from the loop body, which should be positive for 
performance.
>   		s1++;
>   		s2++;
>   	}
> @@ -3451,7 +3456,7 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
>    */
>   __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
>   {
> -	return __bpf_strcasecmp(s1__ign, s2__ign, false);
> +	return __bpf_strncasecmp(s1__ign, s2__ign, false, XATTR_SIZE_MAX);
>   }
>   
>   /**
> @@ -3469,7 +3474,26 @@ __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
>    */
>   __bpf_kfunc int bpf_strcasecmp(const char *s1__ign, const char *s2__ign)
>   {
> -	return __bpf_strcasecmp(s1__ign, s2__ign, true);
> +	return __bpf_strncasecmp(s1__ign, s2__ign, true, XATTR_SIZE_MAX);
> +}
> +
> +/*
> + * bpf_strncasecmp - Compare two length-limited strings, ignoring case
> + * @s1__ign: One string
> + * @s2__ign: Another string
> + * @len: The maximum number of characters to compare
Let's also add that len is limited by XATTR_SIZE_MAX
> +
> + * Return:
> + * * %0       - Strings are equal
> + * * %-1      - @s1__ign is smaller
> + * * %1       - @s2__ign is smaller
> + * * %-EFAULT - Cannot read one of the strings
> + * * %-E2BIG  - One of strings is too large
> + * * %-ERANGE - One of strings is outside of kernel address space
> + */
> +__bpf_kfunc int bpf_strncasecmp(const char *s1__ign, const char *s2__ign, size_t len)
> +{
> +	return __bpf_strncasecmp(s1__ign, s2__ign, true, len);
>   }
>   
>   /**
> @@ -4521,6 +4545,7 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
>   BTF_ID_FLAGS(func, __bpf_trap)
>   BTF_ID_FLAGS(func, bpf_strcmp);
>   BTF_ID_FLAGS(func, bpf_strcasecmp);
> +BTF_ID_FLAGS(func, bpf_strncasecmp);
>   BTF_ID_FLAGS(func, bpf_strchr);
>   BTF_ID_FLAGS(func, bpf_strchrnul);
>   BTF_ID_FLAGS(func, bpf_strnchr);


