Return-Path: <bpf+bounces-67161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D98B3FAF9
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 11:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD1617E2F5
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 09:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AFD2ECE84;
	Tue,  2 Sep 2025 09:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSJMcf0s"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967112EC572
	for <bpf@vger.kernel.org>; Tue,  2 Sep 2025 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806351; cv=none; b=qBvQmrYbIZz5V27gFOmhXDLNgYvNfZMRg+0aJxjhX1SUKt2bSDL370bOcthFWyhnWDTVMSZIfn12MmQSgyKLN1NrV66j6Rf7KlPWCtqW8lL1LyztL5BkBgEMzwHnYpJJNaw1emqF/Mxmfqs5J7G4FvIzhNoNet/hlHCja3M80mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806351; c=relaxed/simple;
	bh=bmdHYgxlrSJ4C+/l7uub89+wrMG6ofKMt8evfvkO93g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=arfLV482P4+/Huu57rG8973pytZzqPg8BVOfho9/LOObiscfJKE13mVlus7n7nigv3boXy0PhDq9iqiXeGr7SinujQDtOZR9NYthawKLi4/VoC4WtSDUcRp7tpWIML/ZA/x9Ap3MEqvON8p8ydI/GHmzvVoS25rXLjE4SaqNgdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bSJMcf0s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756806346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C2Ve4CgS6Jqh9ORpRtoAAIe0w/LUc4ir/s41Tz+S/dE=;
	b=bSJMcf0siIUmz4LWRF60tE3ps7OlPiKqPci3o79iSw+2N4clLIjm3ThSb5LLJteMC5+P73
	/b3O9EfDulkjTw0TvCmvGkdbi5dClKnjyuZvdnnU6sO/MA46tFf3C8A/rn3o29pFqntTnd
	xVI7lcX3MG79U5EpPi/N4pggU3FUWdY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-BpaItr8mMLK99igHYQ8s_Q-1; Tue, 02 Sep 2025 05:45:45 -0400
X-MC-Unique: BpaItr8mMLK99igHYQ8s_Q-1
X-Mimecast-MFC-AGG-ID: BpaItr8mMLK99igHYQ8s_Q_1756806345
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b3298c585bso29373651cf.0
        for <bpf@vger.kernel.org>; Tue, 02 Sep 2025 02:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756806345; x=1757411145;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2Ve4CgS6Jqh9ORpRtoAAIe0w/LUc4ir/s41Tz+S/dE=;
        b=tQKqgCySUAkUk8T05A1iEmhqX8euphFXQ0adTSJ06E/DO9aTydUIe+2xA5Wv7KDaJM
         TgbZTuJDCoF8b+/+cgMh+tbZWyY/NZuebPMdfOGF0XPmuLdfMcfqOfuhug3pCg79x4zC
         9kLAPeepya+n80qyuWnipII6gaOgRQE8mtUeyOQ3WSXlRgTMkfCZ2n8lH08M0TWuMoOk
         8rTKFdToyJG+aCkzfo651fl1sIZGYmcSVlnpF52YLpx4t0c9+UejMdtagxDMlTwLYp+v
         Dk/BSqE5DbRoZv9tbo10rempCrm0HZyomi1cSE3aQwYiH/sMsKeqQSYu5R4EtwXDJJKF
         c98Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsS8ri6s2Ql7CxoSgodLiVTclqUlmlqwVJvT4lEsVjMfAfxRgna3oZHvQHi63NHw6WOWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFiarHPzNc02ZED7ruOQ18s4Gz8Q57lrjvY7pgWHisLLZ8M1Ay
	iOayG4h5bwebjLtw5OgJpcREkAoQrfSAcqH4pvqHr9inJsERVW76XhdVRatmvfhcmdNDWj7rO6A
	LZXTA52dq2CyyK8oq+l87nGNWYpBkOjs8dXGDwuJA/tqcn4rO/08G
X-Gm-Gg: ASbGnct08WjW3VjcVvejIFD/iHSztkyZe50ssAnd9r4rQebg8U/JpfzHXJhSqRAFPOO
	iczNYqKZ4hefV/uwGe93aDPkPOLEBM7G8LnGzvtswZDH/DiZmBqi/uBJYG/2Z9ScT1j9W0o1+nU
	4yq/eSbIOPj/K1lknEp1nPtqTFaIThzgtrHkvelCebJVWK0T3Fzknk1t98UBBUVrenmsGXPcEX4
	F9XBw5IwyQS7wDqfXAqp7RLXBtoKZc9sibd7+VX15z95QgTEdeyukx/lB+FBmJGTQsW++0wpldf
	xh7Cu3PE0rrYE8kRLNuuK009bHDZzdHxwQk=
X-Received: by 2002:ac8:5dc8:0:b0:4b0:71e7:2d7e with SMTP id d75a77b69052e-4b31b85ea03mr128189521cf.8.1756806344644;
        Tue, 02 Sep 2025 02:45:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrXB5u8zkFeeKDAOLeeb1BWItMmJbWssZqtK3k4jcmoOb1/w6NiXzFGMOyMKcLcHSLWa38dA==
X-Received: by 2002:ac8:5dc8:0:b0:4b0:71e7:2d7e with SMTP id d75a77b69052e-4b31b85ea03mr128189311cf.8.1756806344112;
        Tue, 02 Sep 2025 02:45:44 -0700 (PDT)
Received: from [10.43.17.17] ([85.93.96.130])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b3461e04f5sm9734241cf.19.2025.09.02.02.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 02:45:43 -0700 (PDT)
Message-ID: <3c75ce2b-a863-40e0-9280-120cafc3542e@redhat.com>
Date: Tue, 2 Sep 2025 11:45:40 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_strcasecmp kfunc
To: Rong Tao <rtoax@foxmail.com>, andrii@kernel.org, ast@kernel.org
Cc: Rong Tao <rongtao@cestc.cn>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>,
 "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)"
 <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <cover.1756804522.git.rtoax@foxmail.com>
 <tencent_0E0C830021A02CBCCB6D95AE57CFD100C407@qq.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <tencent_0E0C830021A02CBCCB6D95AE57CFD100C407@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/25 11:19, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> bpf_strcasecmp() function performs same like bpf_strcmp() except ignoring
> the case of the characters.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

For the series:

Acked-by: Viktor Malik <vmalik@redhat.com>

> ---
>  kernel/bpf/helpers.c | 68 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 48 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 401b4932cc49..238fd992c786 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3349,45 +3349,72 @@ __bpf_kfunc void __bpf_trap(void)
>   * __get_kernel_nofault instead of plain dereference to make them safe.
>   */
>  
> -/**
> - * bpf_strcmp - Compare two strings
> - * @s1__ign: One string
> - * @s2__ign: Another string
> - *
> - * Return:
> - * * %0       - Strings are equal
> - * * %-1      - @s1__ign is smaller
> - * * %1       - @s2__ign is smaller
> - * * %-EFAULT - Cannot read one of the strings
> - * * %-E2BIG  - One of strings is too large
> - * * %-ERANGE - One of strings is outside of kernel address space
> - */
> -__bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
> +int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
>  {
>  	char c1, c2;
>  	int i;
>  
> -	if (!copy_from_kernel_nofault_allowed(s1__ign, 1) ||
> -	    !copy_from_kernel_nofault_allowed(s2__ign, 1)) {
> +	if (!copy_from_kernel_nofault_allowed(s1, 1) ||
> +	    !copy_from_kernel_nofault_allowed(s2, 1)) {
>  		return -ERANGE;
>  	}
>  
>  	guard(pagefault)();
>  	for (i = 0; i < XATTR_SIZE_MAX; i++) {
> -		__get_kernel_nofault(&c1, s1__ign, char, err_out);
> -		__get_kernel_nofault(&c2, s2__ign, char, err_out);
> +		__get_kernel_nofault(&c1, s1, char, err_out);
> +		__get_kernel_nofault(&c2, s2, char, err_out);
> +		if (ignore_case) {
> +			c1 = tolower(c1);
> +			c2 = tolower(c2);
> +		}
>  		if (c1 != c2)
>  			return c1 < c2 ? -1 : 1;
>  		if (c1 == '\0')
>  			return 0;
> -		s1__ign++;
> -		s2__ign++;
> +		s1++;
> +		s2++;
>  	}
>  	return -E2BIG;
>  err_out:
>  	return -EFAULT;
>  }
>  
> +/**
> + * bpf_strcmp - Compare two strings
> + * @s1__ign: One string
> + * @s2__ign: Another string
> + *
> + * Return:
> + * * %0       - Strings are equal
> + * * %-1      - @s1__ign is smaller
> + * * %1       - @s2__ign is smaller
> + * * %-EFAULT - Cannot read one of the strings
> + * * %-E2BIG  - One of strings is too large
> + * * %-ERANGE - One of strings is outside of kernel address space
> + */
> +__bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
> +{
> +	return __bpf_strcasecmp(s1__ign, s2__ign, false);
> +}
> +
> +/**
> + * bpf_strcasecmp - Compare two strings, ignoring the case of the characters
> + * @s1__ign: One string
> + * @s2__ign: Another string
> + *
> + * Return:
> + * * %0       - Strings are equal
> + * * %-1      - @s1__ign is smaller
> + * * %1       - @s2__ign is smaller
> + * * %-EFAULT - Cannot read one of the strings
> + * * %-E2BIG  - One of strings is too large
> + * * %-ERANGE - One of strings is outside of kernel address space
> + */
> +__bpf_kfunc int bpf_strcasecmp(const char *s1__ign, const char *s2__ign)
> +{
> +	return __bpf_strcasecmp(s1__ign, s2__ign, true);
> +}
> +
>  /**
>   * bpf_strnchr - Find a character in a length limited string
>   * @s__ign: The string to be searched
> @@ -3832,6 +3859,7 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
>  #endif
>  BTF_ID_FLAGS(func, __bpf_trap)
>  BTF_ID_FLAGS(func, bpf_strcmp);
> +BTF_ID_FLAGS(func, bpf_strcasecmp);
>  BTF_ID_FLAGS(func, bpf_strchr);
>  BTF_ID_FLAGS(func, bpf_strchrnul);
>  BTF_ID_FLAGS(func, bpf_strnchr);


