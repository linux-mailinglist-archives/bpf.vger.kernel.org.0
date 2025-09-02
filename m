Return-Path: <bpf+bounces-67146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EB9B3F636
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 09:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB883A8A1A
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 07:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE79F26A0BD;
	Tue,  2 Sep 2025 07:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Il/g5DiC"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3FB21C16A
	for <bpf@vger.kernel.org>; Tue,  2 Sep 2025 07:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756796934; cv=none; b=a0iF4zqDdottJVqoBsMVg3yS8rj5w6stuT9Yf4Ktkn3i+y4GIRFfoVLHJp42TLjqo2A78AWmjCmSjbRlKp7X0btLJs7xdI5dnJV+ALVZnD+HA6j2K6wvakaSkVyb29+IvYkUVgqhU46o8gTxpoWBjjLzbcHJTep1INmR1OqIBmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756796934; c=relaxed/simple;
	bh=im7NYadRTHyEfmXv2PI4/RAof9Bxr0cUGhtOOsLLb0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ikvPXNCZ/REf+L0kme3AmWrDU4mhXk4ilQzliOJZl867psldhU290Ix/I7AwJcurgEyqkb1ZSmMspZT9GGwWCWbjFntUp7phu3/lf/lit071lZAbacjXak+BgONZuRewDm0i6tGC0rqCf4tHn5JaCmZUo6zSYgEqMYmow2xuvEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Il/g5DiC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756796931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwnQVLWw3r5ceJM7DV94g3HH/db+9QctDZGqRZqZzX8=;
	b=Il/g5DiCkND9j6cnuw94wDsygMEHeNPe5IC07rqUwfnzDKm8ReAV5HSMtzOY2XvSoz1zsA
	ev28lh2vd3qRqgMdYupdnEPrk4luSYsR6O1imEKdu87Qi1KRdn8E132mtmEuUahpgGX6R7
	coHtEuDJekKHC29Kj9MgOD1WD7pb9lA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-Oon4pSGVPK6pZbVJkOTZcQ-1; Tue, 02 Sep 2025 03:08:50 -0400
X-MC-Unique: Oon4pSGVPK6pZbVJkOTZcQ-1
X-Mimecast-MFC-AGG-ID: Oon4pSGVPK6pZbVJkOTZcQ_1756796930
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70faf8b375cso54074986d6.0
        for <bpf@vger.kernel.org>; Tue, 02 Sep 2025 00:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756796930; x=1757401730;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwnQVLWw3r5ceJM7DV94g3HH/db+9QctDZGqRZqZzX8=;
        b=HrhIwbAqUol3ZqexpA7OP6QpcmnTW77hyEiNnLRgk2SKB2iXGqMxL+EfwjSK1xfbMY
         pwhxOQieSy0gt46aZWDnxVC6Y/YLEN+FG95YuiZir4iPrGojvJtAS69vvaRxTxMUT4XU
         OFwWpY5KAGdVg+HwmvcX/vGs80avR+4h6xcCJsB2bxKRwYWGkRT/KaNAxL0w9a5CW1IT
         9s+SP2vy4mt3sZcQT+QKShrS7onIWy2JfS6zj7RgmFkRFWeZf74VWsXusIVjnmLwP1iY
         xAJOBVP7IvubjHhgrITTqlPaiHnmAmjC07yh0MUYGv+VchAHWZNhwzdOa7j0tnPDO+5v
         kzVg==
X-Forwarded-Encrypted: i=1; AJvYcCUWHOog9lpEOHK4i2Qcubc4vWmU8KvvI9yIn/08Lb6Ku2Mn5CkeKThmsjX1SV+fQxpD0wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUPbspEqp+OlUF1+hP+TmHJJ+IomT0r8qTEl6JZHNkCsqsPcta
	LgzJDzCxL+20NgtaQbTA47Huf9K6QiJ+v2lVQDAebCf5yxPxXWOCFeZpOxELd0OlRkRkTvb3pcs
	grnA4QMs+620EPlCCGYYb8XpNnYkCyIbbkY/L/dmMkYJXKrpcOswE
X-Gm-Gg: ASbGncvjpbZiUzSxfaMfOWFpXkYi+eSZymgwzifSwga2bDpwUx92nZobb8v9dUcApfm
	6jwHZsQPOKAtN+Xlp5/KHDAI0dPdA2Q+SNvFYXOjbwGx8JTcMqR5UzQcFqVDRC028Y68BBTgkzg
	korTBuKqNa5q0mvCQEgBX16U2/s2pX95IWPQCWTKG7O3mX+gMspf0pAC8dTvnJ5n0Gu5mRmVXov
	9SZAQSFRBNflxJaxvqbYBk8FiZ9LTTBKpvWMwXmkQ5He0pkS/Zxd3uqlLGwaLTInj3i6XeRFfXO
	YKrPv0JeyUrgvPVdTdRxrRcAGFrycwEFFu8=
X-Received: by 2002:a05:6214:5188:b0:719:12cf:50ef with SMTP id 6a1803df08f44-71912cf57e2mr76132006d6.28.1756796929688;
        Tue, 02 Sep 2025 00:08:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGl9dp0yJxUygzcGwWlW4JH2MFXqf3SrOHhhWvvJyY3BMT7iNsAbljAlYrABN+Qx91wFDHhzQ==
X-Received: by 2002:a05:6214:5188:b0:719:12cf:50ef with SMTP id 6a1803df08f44-71912cf57e2mr76131696d6.28.1756796929288;
        Tue, 02 Sep 2025 00:08:49 -0700 (PDT)
Received: from [10.43.17.17] ([85.93.96.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b644f2c9sm7383546d6.63.2025.09.02.00.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 00:08:48 -0700 (PDT)
Message-ID: <f0194235-19ae-43de-b73d-b2d8b7f77035@redhat.com>
Date: Tue, 2 Sep 2025 09:08:42 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_strcasecmp kfunc
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
References: <cover.1756793624.git.rongtao@cestc.cn>
 <tencent_5AE811A28781BE106AD6CDE59F4ADD2BFA06@qq.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <tencent_5AE811A28781BE106AD6CDE59F4ADD2BFA06@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/25 08:17, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> bpf_strcasecmp() function performs same like bpf_strcmp() except ignoring
> the case of the characters.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  kernel/bpf/helpers.c | 56 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 42 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 401b4932cc49..e807a708e5fc 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3349,20 +3349,7 @@ __bpf_kfunc void __bpf_trap(void)
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
> +int __bpf_strcasecmp(const char *s1__ign, const char *s2__ign, bool ignore_case)

No need to use the `__ign` suffix here.

Otherwise LGTM. I guess that it could be useful in some applications.

Viktor

>  {
>  	char c1, c2;
>  	int i;
> @@ -3376,6 +3363,10 @@ __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
>  	for (i = 0; i < XATTR_SIZE_MAX; i++) {
>  		__get_kernel_nofault(&c1, s1__ign, char, err_out);
>  		__get_kernel_nofault(&c2, s2__ign, char, err_out);
> +		if (ignore_case) {
> +			c1 = tolower(c1);
> +			c2 = tolower(c2);
> +		}
>  		if (c1 != c2)
>  			return c1 < c2 ? -1 : 1;
>  		if (c1 == '\0')
> @@ -3388,6 +3379,42 @@ __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
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


