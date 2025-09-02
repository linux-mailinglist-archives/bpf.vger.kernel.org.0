Return-Path: <bpf+bounces-67155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FCFB3F93F
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 10:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B1647A83FF
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 08:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F772E8E10;
	Tue,  2 Sep 2025 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnoFV1VV"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D885121FF38
	for <bpf@vger.kernel.org>; Tue,  2 Sep 2025 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803402; cv=none; b=VyD14VqJI0UVnMkG0WSGDDnD6UXmK8mLZ8NoWnfrkpb8xaXgSnm0CGdWJ13FSFFWs4VAkEAe/j0yb/CzjTWTf1KEpFXb3X6rExib5pHUTwrE9mFI6IFoEUg+nMhRLIy1NZYTSjHW0pzxgR9jJm92iWjki8/SkNF1VDd1w1nFsz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803402; c=relaxed/simple;
	bh=A6K88WcChbCNhfKxt/hC71H+aKecDXN0yZaU+lUMOEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nCt8hJW8sMic8EcMrIagnG94fUS0YbbGwQHAADF4qyBsKAdmzIBN4/SJUxZzxipVME8UujQGUEquAGnDuFbHe5iMltYPEXcS8m9jS3nPLCK6idEKAf2WoOMkMAwC3AVlOo3nT3F7n0x4jbxI5sJLbhOqgbc6nuer4k805Jy9O0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dnoFV1VV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756803399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lImTkCvs1XMwtayZpeMnD+gBReBeYA5Sp6xX4F8BQTI=;
	b=dnoFV1VV1VxsAwdtg6336RSRmbwUrxJw3lFYh1AaK1f8l72aF1vALwhcNJ9H5VBO7BDUPG
	raYlJQt+AuY1k3p3uXBcKGONTxA+QJxrFZIOn+fyAmBzX1fxmg4g3IMJokhsOVF6Y9iN+l
	9lVYr6qGOdrakvFRb0o+NqrqxST3SYQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-yAEyqiujOJqk1t2ZkJEl-A-1; Tue, 02 Sep 2025 04:56:36 -0400
X-MC-Unique: yAEyqiujOJqk1t2ZkJEl-A-1
X-Mimecast-MFC-AGG-ID: yAEyqiujOJqk1t2ZkJEl-A_1756803396
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70de52d2904so126167866d6.0
        for <bpf@vger.kernel.org>; Tue, 02 Sep 2025 01:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756803396; x=1757408196;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lImTkCvs1XMwtayZpeMnD+gBReBeYA5Sp6xX4F8BQTI=;
        b=Jow7LlO31e+D995aY9GYTRrELw3CvHainFqyP22769P3OzdyiF2+uVUtL1xIOiSGDU
         ko1BAV0axfZ8/BTrYrbotwM9t9NeP+oGyLCQd0d88wL5SZA/0Yfna85FO0c6AFsPnFG+
         Wd7iiXNDjZl/rBsQycmcvxTv2U+IsbxOj0a2n7uW0zQAnS0UKnYBAWO3qmjrQ1N/XTog
         7E94xENpOm8dubZNa6MzqbQBLbyDyAlU13GCkiJbAE+5CkkUgeyE6Enu9ueMYO1R2kJL
         K+v3RK14h7gEdGaSs6bnNH1qtVInv8BJw8oPXw8DwbHwYoH877IooDFI56TUsmdR2EmO
         WiZw==
X-Forwarded-Encrypted: i=1; AJvYcCVkyPgNheUbghuPIjNdH7nicaiHwuuduc1Pp1dXJunKKZtvRciyn8J4E0SiOy+wm4ZE4Kg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztr+SlZ8gwbG1+k8QprkzgsX0uFgszMzBlNcSFfFZI0DOIvJ6Z
	SNKVZqj/QAEFiR6pHa5aEah+bcE36R/04W+fHFMQwwk9kbPWw6l/OlFZXzI6X87fvLRkwKv/4pK
	0A0rt201X9Lu9axHH7vAAywAIN+OrDOr0jtZ0agZs9/61nqiOjEEq
X-Gm-Gg: ASbGncvotx/VkFCf7m3r36KTVPe9In4L/uy9K4SS1mUUJvxo4tOFGnyXMMQZoqnlYUY
	/HeeAtZ72zmpvvRYOmU7HjTvPsTTSuXqBf4cb1YT+Prt5e88cUpmbw45AP4YGqNn1g8JgWbbPiL
	KSI02vQtWrl99VDkvoJG6bJir66Cxmi2GNXzkY+pgAmtHFe/h2iQIzi51KAqc8OUUXux45aFeaN
	Esau6cvYFh5AQZdw15COCJNmXoPWFUDhCaS8+Ldj8i4KeDdx3ZDPcOEoD2HZPIud50gGirgGqpJ
	WjD7d0RaW+ut0/cnGyxBgm0etD85Lw3CeQs=
X-Received: by 2002:ad4:5c4c:0:b0:718:ee5e:a360 with SMTP id 6a1803df08f44-718ee5ea558mr69268746d6.30.1756803396247;
        Tue, 02 Sep 2025 01:56:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6gmfnqL14RyPQXyc1ORuNcdh31l1y3psF0bOrlARcUXY0vC+jQr5wYcNzKa22lIpYqk2Gbg==
X-Received: by 2002:ad4:5c4c:0:b0:718:ee5e:a360 with SMTP id 6a1803df08f44-718ee5ea558mr69268596d6.30.1756803395793;
        Tue, 02 Sep 2025 01:56:35 -0700 (PDT)
Received: from [10.43.17.17] ([85.93.96.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b5b9c7e1sm8312216d6.58.2025.09.02.01.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 01:56:35 -0700 (PDT)
Message-ID: <76f6ed83-48a2-4dad-9229-1169050e9552@redhat.com>
Date: Tue, 2 Sep 2025 10:56:31 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test kfunc bpf_strcasecmp
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
References: <cover.1756798860.git.rtoax@foxmail.com>
 <tencent_00107416F7259ACAC62BF8681F22B5C19D06@qq.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <tencent_00107416F7259ACAC62BF8681F22B5C19D06@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/25 09:55, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Add testsuites for kfunc bpf_strcasecmp.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c | 6 ++++++
>  tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c | 1 +
>  tools/testing/selftests/bpf/progs/string_kfuncs_success.c  | 5 +++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> index 53af438bd998..99d72c68f76a 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> @@ -31,6 +31,8 @@ char *invalid_kern_ptr = (char *)-1;
>  /* Passing NULL to string kfuncs (treated as a userspace ptr) */
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_null1(void *ctx) { return bpf_strcmp(NULL, "hello"); }
>  SEC("syscall")  __retval(USER_PTR_ERR)int test_strcmp_null2(void *ctx) { return bpf_strcmp("hello", NULL); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_null1(void *ctx) { return bpf_strcasecmp(NULL, "HELLO"); }
> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strcasecmp_null2(void *ctx) { return bpf_strcasecmp("HELLO", NULL); }
>  SEC("syscall")  __retval(USER_PTR_ERR)int test_strchr_null(void *ctx) { return bpf_strchr(NULL, 'a'); }
>  SEC("syscall")  __retval(USER_PTR_ERR)int test_strchrnul_null(void *ctx) { return bpf_strchrnul(NULL, 'a'); }
>  SEC("syscall")  __retval(USER_PTR_ERR)int test_strnchr_null(void *ctx) { return bpf_strnchr(NULL, 1, 'a'); }
> @@ -49,6 +51,8 @@ SEC("syscall")  __retval(USER_PTR_ERR)int test_strnstr_null2(void *ctx) { return
>  /* Passing userspace ptr to string kfuncs */
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr1(void *ctx) { return bpf_strcmp(user_ptr, "hello"); }
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr2(void *ctx) { return bpf_strcmp("hello", user_ptr); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_user_ptr1(void *ctx) { return bpf_strcasecmp(user_ptr, "HELLO"); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_user_ptr2(void *ctx) { return bpf_strcasecmp("HELLO", user_ptr); }
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strchr_user_ptr(void *ctx) { return bpf_strchr(user_ptr, 'a'); }
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strchrnul_user_ptr(void *ctx) { return bpf_strchrnul(user_ptr, 'a'); }
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strnchr_user_ptr(void *ctx) { return bpf_strnchr(user_ptr, 1, 'a'); }
> @@ -69,6 +73,8 @@ SEC("syscall") __retval(USER_PTR_ERR) int test_strnstr_user_ptr2(void *ctx) { re
>  /* Passing invalid kernel ptr to string kfuncs should always return -EFAULT */
>  SEC("syscall") __retval(-EFAULT) int test_strcmp_pagefault1(void *ctx) { return bpf_strcmp(invalid_kern_ptr, "hello"); }
>  SEC("syscall") __retval(-EFAULT) int test_strcmp_pagefault2(void *ctx) { return bpf_strcmp("hello", invalid_kern_ptr); }
> +SEC("syscall") __retval(-EFAULT) int test_strcasecmp_pagefault1(void *ctx) { return bpf_strcasecmp(invalid_kern_ptr, "HELLO"); }
> +SEC("syscall") __retval(-EFAULT) int test_strcasecmp_pagefault2(void *ctx) { return bpf_strcasecmp("HELLO", invalid_kern_ptr); }
>  SEC("syscall") __retval(-EFAULT) int test_strchr_pagefault(void *ctx) { return bpf_strchr(invalid_kern_ptr, 'a'); }
>  SEC("syscall") __retval(-EFAULT) int test_strchrnul_pagefault(void *ctx) { return bpf_strchrnul(invalid_kern_ptr, 'a'); }
>  SEC("syscall") __retval(-EFAULT) int test_strnchr_pagefault(void *ctx) { return bpf_strnchr(invalid_kern_ptr, 1, 'a'); }
> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> index 89fb4669b0e9..e41cc5601994 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> @@ -7,6 +7,7 @@
>  char long_str[XATTR_SIZE_MAX + 1];
>  
>  SEC("syscall") int test_strcmp_too_long(void *ctx) { return bpf_strcmp(long_str, long_str); }
> +SEC("syscall") int test_strcasecmp_too_long(void *ctx) { return bpf_strcasecmp(long_str, long_str); }

This is not sufficient, you also need to update
prog_tests/string_kfuncs.c so that the test case is actually triggered.

Viktor

>  SEC("syscall") int test_strchr_too_long(void *ctx) { return bpf_strchr(long_str, 'b'); }
>  SEC("syscall") int test_strchrnul_too_long(void *ctx) { return bpf_strchrnul(long_str, 'b'); }
>  SEC("syscall") int test_strnchr_too_long(void *ctx) { return bpf_strnchr(long_str, sizeof(long_str), 'b'); }
> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> index 46697f381878..67830456637b 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> @@ -12,6 +12,11 @@ char str[] = "hello world";
>  /* Functional tests */
>  __test(0) int test_strcmp_eq(void *ctx) { return bpf_strcmp(str, "hello world"); }
>  __test(1) int test_strcmp_neq(void *ctx) { return bpf_strcmp(str, "hello"); }
> +__test(0) int test_strcasecmp_eq1(void *ctx) { return bpf_strcasecmp(str, "hello world"); }
> +__test(0) int test_strcasecmp_eq2(void *ctx) { return bpf_strcasecmp(str, "HELLO WORLD"); }
> +__test(0) int test_strcasecmp_eq3(void *ctx) { return bpf_strcasecmp(str, "HELLO world"); }
> +__test(1) int test_strcasecmp_neq1(void *ctx) { return bpf_strcasecmp(str, "hello"); }
> +__test(1) int test_strcasecmp_neq2(void *ctx) { return bpf_strcasecmp(str, "HELLO"); }
>  __test(1) int test_strchr_found(void *ctx) { return bpf_strchr(str, 'e'); }
>  __test(11) int test_strchr_null(void *ctx) { return bpf_strchr(str, '\0'); }
>  __test(-ENOENT) int test_strchr_notfound(void *ctx) { return bpf_strchr(str, 'x'); }


