Return-Path: <bpf+bounces-79301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 612A6D335D9
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 17:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 956DD30285EA
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 16:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C402A33B6E1;
	Fri, 16 Jan 2026 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2f3hJoU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kdyxSYiN"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15E88F4A
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768579286; cv=none; b=f2H2CQ7EMtODdavWZ0BvYeT+z+RguBuDv+d8KyL6HkMrrHpM1NY1MDw8YccViszPURk3So3XtiggeWtFOXz/dThWbH8b24k4X2gkJukWJZtjs6ufU3CZtA77dcK0SoLuTndHV91wezokwnng2eXMBAtktz8TA3LirKqLQc0Rln0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768579286; c=relaxed/simple;
	bh=5jtlEKaXKTaP4jZNuDQvrTbk3E1/vpiyIZ5c2i0KSzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWY8t0ejViP1GKCqkJh0HPiAp6JoIslv8IW4WtvltNGGdcmideo3UhDdCQ1k9inN945A+SccPl8D9K0ScODVuLpGsJ1H4IPrIs/4LQQEMlhjt+W8uJLwkrqgGkSghkdAEuEAm3vuriglwqMwJsnqm3eB4nMRsQTvD5+JT/mXORE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2f3hJoU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kdyxSYiN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768579283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VqGZUBz3KHjr54Z28tv4jDgC5h1Zhyo++szoOU3x76k=;
	b=M2f3hJoUQ1OGE/x8OzDW0fUKO4UnrhB0zvF6PoA2CVlq9QBtfzlGRgTp5zWEo/dV+j5dbX
	f93bOhTlVYLYZeyCt56qQt/OoLwM5K6UxEqiUui7NRVgVHuqQpgPJVN8qnxQC14mJXtk+d
	zgePV/WXI45F3L+5A6cMfRco6D+EPTg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-1fYccEGdPUOZrsp-zDakmg-1; Fri, 16 Jan 2026 11:01:16 -0500
X-MC-Unique: 1fYccEGdPUOZrsp-zDakmg-1
X-Mimecast-MFC-AGG-ID: 1fYccEGdPUOZrsp-zDakmg_1768579275
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430fc83f58dso1757732f8f.2
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 08:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768579275; x=1769184075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VqGZUBz3KHjr54Z28tv4jDgC5h1Zhyo++szoOU3x76k=;
        b=kdyxSYiNjW98qJ9PgKTIlBS6jniBivl8hCI0I4kA5kocTFl0pBPmTViZxzJx3k+qg2
         HxjkvvLE339uzar2JekfoxiSf3msCg5enDIfIxJ7ukT4M9LC0j20ZQPL4CULAPc8zRoS
         gGGkSa6B7cYSI0URDQvVUkTGwvwulXwNAmjtWlbKh/zm/opJsjt3CfLxulrMtoXq6AHY
         6n5rDIXErXQdmtC/43Nq93QTJ6o+JPf+bGugJ22du7/YcvxoidR8Pyd6dHFIthDaz9zI
         8fd2ivwUpgp9tevCUiq95R3u4uu9crDfnClyRCq+FQu7DkaYLBAeOoMIajOl7VxQbuxm
         WdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768579275; x=1769184075;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VqGZUBz3KHjr54Z28tv4jDgC5h1Zhyo++szoOU3x76k=;
        b=PGhMrj1VVlEt0MinUDSZ/QxBniXjzUPC8fHZPV3AdtGhQ9B3mdOb8kHxN7Qc3+wblk
         nvj29P0iq4IiwnMddMDyNAt2kOVOCoNTKUaOnz6jgGjWFh0i7qVIVSveYj17GYFMKGRx
         1g7jgp82UFedYTVxqJSCiUv7ANRy7y87UpJLBSyvqTCZC6HUe3v3Y5Q7WA8U0cqVvjdQ
         DyuuRgOHpYbQaqVDZCsX1YCDTgqtPfgJieo7GR2eAoCQ3ftytGgCbQvu8qJNYDuiqlJT
         3nJX5wrjSVl2wamRzix25chN3wcot+gTQ/ncNJNW/yR1z5A7zo7LpXRt1j6U/yksS+1F
         A3og==
X-Forwarded-Encrypted: i=1; AJvYcCU1Y8PD9YCgIdndQrV10jHJGtMa99/P4TIMQDbZCnts4MmRHoxaeUzlTF98QmTovnzYfCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfJMrtuvsv4NpbbVFO/cFZoh5oo9NCzr+EofZgyVhwsg9dX09j
	OT8Up3LsqeOOLu02yXHui+X+AbqJySsY9zqvBeJ51Y5RQZyZlydkNA24iJVaOZhw1xRm/7oyHh5
	AhYZLpUh2EBdooTOlZAnxCLk/JkM9mzui7gJZMSYB4r1m4Nwxp+Iw
X-Gm-Gg: AY/fxX67Wo2euhJmwcrCEA+4Q85huVjIlWgCFQsM4UhSEEPcJr8Brdff17ujylNKud3
	hZp/MnAxTj23+k1oD+qNLj4VK9r8TitJh0wgw0EYkcs0J+6lg2e4CMQnss3WNad9Vx/o302uiZy
	02PNmsalPK5EqZCsvBC2A3fx6FwdHwQ4p3t9RdXaEY54pscG36zlE0QJoGZ2BsbNu9uwufgv+y7
	V93DW6pZa3R+YY0pmNYkJFyu13+mwta4tY47fiu0uhtpgRrfFPa7kmiBKpB90IR4EX/iaXrkmR/
	cwj3QlkVuciGhZJIFklk7uPzkPSgoZiGCu6DnfgcYWmPjBowm4D3orIvzm2krC9oDfbiDzDZw1/
	KJM3nIi91IIT8UfEMmnqpc7iJWC644evuVr8ZqbTyTjX22Q==
X-Received: by 2002:a05:6000:613:b0:432:586f:2ab9 with SMTP id ffacd0b85a97d-435699787cdmr4697799f8f.5.1768579274738;
        Fri, 16 Jan 2026 08:01:14 -0800 (PST)
X-Received: by 2002:a05:6000:613:b0:432:586f:2ab9 with SMTP id ffacd0b85a97d-435699787cdmr4697742f8f.5.1768579274258;
        Fri, 16 Jan 2026 08:01:14 -0800 (PST)
Received: from [192.168.0.199] (bband-dyn169.95-103-216.t-com.sk. [95.103.216.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569927163sm5692561f8f.12.2026.01.16.08.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 08:01:13 -0800 (PST)
Message-ID: <54e3bcd7-be63-4604-9935-028da6a1216a@redhat.com>
Date: Fri, 16 Jan 2026 17:01:12 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpf: add bpf_strncasecmp kfunc
To: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, mykyta.yatsenko5@gmail.com
References: <20260116142455.3526150-1-ishiyama@hpc.is.uec.ac.jp>
 <20260116142455.3526150-2-ishiyama@hpc.is.uec.ac.jp>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <20260116142455.3526150-2-ishiyama@hpc.is.uec.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/26 15:24, Yuzuki Ishiyama wrote:
> bpf_strncasecmp() function performs same like bpf_strcasecmp() except
> limiting the comparison to a specific length.
> 
> Signed-off-by: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
> ---
>  kernel/bpf/helpers.c | 37 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 9eaa4185e0a7..bdd76209cfcf 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3406,18 +3406,23 @@ __bpf_kfunc void __bpf_trap(void)
>   * __get_kernel_nofault instead of plain dereference to make them safe.
>   */
>  
> -static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
> +static int __bpf_strncasecmp(const char *s1, const char *s2, bool ignore_case, size_t len)
>  {
>  	char c1, c2;
> -	int i;
> +	int i, max_sz;
>  
>  	if (!copy_from_kernel_nofault_allowed(s1, 1) ||
>  	    !copy_from_kernel_nofault_allowed(s2, 1)) {
>  		return -ERANGE;
>  	}
>  
> +	if (len == 0)
> +		return 0;

This check is not necessary since for len == 0, max_sz == 0 and the
below loop will not run.

> +
> +	max_sz = min_t(int, len, XATTR_SIZE_MAX);
> +
>  	guard(pagefault)();
> -	for (i = 0; i < XATTR_SIZE_MAX; i++) {
> +	for (i = 0; i < max_sz; i++) {
>  		__get_kernel_nofault(&c1, s1, char, err_out);
>  		__get_kernel_nofault(&c2, s2, char, err_out);
>  		if (ignore_case) {
> @@ -3431,6 +3436,8 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
>  		s1++;
>  		s2++;
>  	}
> +	if (len < XATTR_SIZE_MAX)
> +		return 0;
>  	return -E2BIG;

Nit: we could respect the style of the other string kfuncs and do

    return i == XATTR_SIZE_MAX ? -E2BIG : 0;

>  err_out:
>  	return -EFAULT;
> @@ -3451,7 +3458,7 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
>   */
>  __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
>  {
> -	return __bpf_strcasecmp(s1__ign, s2__ign, false);
> +	return __bpf_strncasecmp(s1__ign, s2__ign, false, XATTR_SIZE_MAX);
>  }
>  
>  /**
> @@ -3469,7 +3476,26 @@ __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
>   */
>  __bpf_kfunc int bpf_strcasecmp(const char *s1__ign, const char *s2__ign)
>  {
> -	return __bpf_strcasecmp(s1__ign, s2__ign, true);
> +	return __bpf_strncasecmp(s1__ign, s2__ign, true, XATTR_SIZE_MAX);
> +}
> +
> +/*
> + * bpf_strncasecmp - Compare two length-limited strings, ignoring case
> + * @s1__ign: One string
> + * @s2__ign: Another string
> + * @len: The maximum number of characters to compare (limited by XATTR_SIZE_MAX)
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
>  }
>  
>  /**
> @@ -4521,6 +4547,7 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, __bpf_trap)
>  BTF_ID_FLAGS(func, bpf_strcmp);
>  BTF_ID_FLAGS(func, bpf_strcasecmp);
> +BTF_ID_FLAGS(func, bpf_strncasecmp);
>  BTF_ID_FLAGS(func, bpf_strchr);
>  BTF_ID_FLAGS(func, bpf_strchrnul);
>  BTF_ID_FLAGS(func, bpf_strnchr);


