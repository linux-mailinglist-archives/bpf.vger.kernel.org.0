Return-Path: <bpf+bounces-67147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D0BB3F648
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 09:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C7D1767F2
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 07:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133B62E7166;
	Tue,  2 Sep 2025 07:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHSDlBL0"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7882E62B9
	for <bpf@vger.kernel.org>; Tue,  2 Sep 2025 07:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797144; cv=none; b=nN6uyPqa0t5dHA6lR2IH9Jax1YGN04aA31OnXDqQi5qX3u7J6U8j854E5+KOi+y456dMGQA0iOSfj+4ul5d1S8512Hk6HoJ+wAF+pqi1a1BeNanPi2j1nzdxHQEJ7GBpLfLzrXWCGWh0KfzEwQOmirMmbE1MCG2Tz+RYpbsvN38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797144; c=relaxed/simple;
	bh=f+48EFYEOK9/gGYBAFjpEmvOnGj2KBHajmq99DNwCko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X66AM7ruQQtOa0Hy1P+ZVGVQLLUTGjqao+oNs3DyDH+j8VuvLRRBi1LdDCnistbxx78+cW3M4NrJgtJRSJr+fxI5TAedvh/Tyrncrz2yUOCKKhGhAbwnjmhHDyqOtlFm1irjZ2j2L5AFA5M3FVxGtGfYvGAtHdm4VGNW4RuJOJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DHSDlBL0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756797142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHW+XNkDvyAQgiNT8kPrrATrI02cqYINz991u5aP3yk=;
	b=DHSDlBL0N6bmXMtsI5c8Eh7VYLHcp5Enyng7Im+I8QDaKjLhL7KKt3BvHOdaF5UgPc0QmH
	+5Zn4RHezNky0MF2tgBYbOqzO+6xIUYShO251iGiDQbm7SLQr9ydx8uZLG0J41XYu0HT+K
	GZ9JHCADXQFNB9Mydp8VY1Yg8cyWqbs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-TY87iszlM5eZDlWL6u4Y1g-1; Tue, 02 Sep 2025 03:12:21 -0400
X-MC-Unique: TY87iszlM5eZDlWL6u4Y1g-1
X-Mimecast-MFC-AGG-ID: TY87iszlM5eZDlWL6u4Y1g_1756797140
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7188e3c2073so35946106d6.1
        for <bpf@vger.kernel.org>; Tue, 02 Sep 2025 00:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756797140; x=1757401940;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHW+XNkDvyAQgiNT8kPrrATrI02cqYINz991u5aP3yk=;
        b=REP56DxuJZz4rGArJbl0dQ/E0lOI1Q8h7GoWmyY/kuE7omRU+YegWXwbV/kor8c43M
         wdWBio54MJKASq0Pca4/3dzWX+k+i8/FjdGYospUUrAEcL/RqRGFygowwXfgxsws8K8Y
         NphO6kjFBFwWCzVHSTAej1MKj/DFESh3GwWQdBYx5stTt7BA1zyaXkT1BCZMNEWTHljZ
         VWorrY/CjpqtEaoj6Pb89PYVYGYCPwdYapBlrY8005B0vnP5RKTAoPPIG2Cy1FNCc+2Q
         Sk8aXHKx1+thraygqn73RY7oi+QK93dx0CCjNYaoTmHUmZ2FxP6qausoC5h4UO2F46OZ
         B7gw==
X-Forwarded-Encrypted: i=1; AJvYcCWClLhiYe65DHGLrz/9Ylgs+r4fesvfkrYqYyWU6Oplx5sfJKhIalc7bFWeA5XhpUGwYGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXhka2V8fCIYdU3PjNMPckff4XBae+dSL/dTgH9VXPovuzyYYb
	eSmclbw1DnpbWZNY6ZDrvVR81j8MOHRNpnb0G37GT0Gegs6TWX6bvTWBkSKscpJUiMbR+IvZXHd
	UEE/jXtRodegeGzgLQzS5z77gErWnLB6CVqqaVTUOYjllhwO48k6/
X-Gm-Gg: ASbGnctpeZsOIhHCg5aHdtHYGgPwdW3MQtZCloTjsXQUup9Zm7y+/xCoRkgZ3y+2RVV
	h8fpVeepj0O9AaTzGMN9u0wIaiSppbdIc9qoVdKhVki2oQaPVFTCFZgKKYzPolHmPapkB8csxik
	wikMZBsy9G3vo8S3YPUnhllB71hDSwGFuVyOW2vCdA/uSt9D9/IlPxLSmgX8WOUJrgdKP5nYdca
	xXhI1Yta9dIrSHf7+xApeK/Y3vmJ8rkIFD0objBGbQTlJs/kk1zOquQ2dFgRoynWASotrltazd+
	2wG25Nn3u+a7itDax9rsDzliLyQiDsnmT1U=
X-Received: by 2002:a05:6214:cc4:b0:71c:f018:1b21 with SMTP id 6a1803df08f44-71cf0181cd6mr52071146d6.22.1756797140310;
        Tue, 02 Sep 2025 00:12:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoL5TadHGzK08pwU/ofCObqH2WsXKq8YA1zY1Tl8IaVjo2XXnBRLdtwWSMQvO3JfMuxQi9Pw==
X-Received: by 2002:a05:6214:cc4:b0:71c:f018:1b21 with SMTP id 6a1803df08f44-71cf0181cd6mr52070936d6.22.1756797139943;
        Tue, 02 Sep 2025 00:12:19 -0700 (PDT)
Received: from [10.43.17.17] ([85.93.96.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ad2cbc78sm7520936d6.23.2025.09.02.00.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 00:12:19 -0700 (PDT)
Message-ID: <7b7e28e4-f04b-44dc-a478-e4c07e51067f@redhat.com>
Date: Tue, 2 Sep 2025 09:12:08 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test kfunc bpf_strcasecmp
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
 <tencent_4142FE591497F42A5FAF5EA36A8861068708@qq.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <tencent_4142FE591497F42A5FAF5EA36A8861068708@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/25 08:18, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Add testsuites for kfunc bpf_strcasecmp.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c | 6 ++++++
>  tools/testing/selftests/bpf/progs/string_kfuncs_success.c  | 5 +++++
>  2 files changed, 11 insertions(+)
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

Missing a test for returning -E2BIG in
tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c.

Viktor


