Return-Path: <bpf+bounces-79581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D70D3C41E
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 10:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F28CA544FA4
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 09:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667383D2FF9;
	Tue, 20 Jan 2026 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nb8xuAM7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hf7cWmdW"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5B13D1CB2
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901456; cv=none; b=BAHFPljD/EVInV2XIESHflcZM0ENzPdmFrFMyRbZVFECE+Q8J0UAJAXmlKJlLbw18eT/GXXndEPDEyYEkS6IE3WCwSbcZ4dftvSye+nklo9y8k0d3KquUqbd9M3ldnHYItEa2iw1MRaCXEEgTX1TxysQu2lwxUj7gdqRfui6zJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901456; c=relaxed/simple;
	bh=7zXCQbXCqo1rKwIeWOHUQuU/2IS0w1HcF7sW1fwZDuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lKrZ2qjYMbog5I8UWjmzWiBYtqsseRFjbtzdQD77dryHDj9rwCQEUQwWycBm7skxSKnxPwcMkcZynQe/ojYdf/IEMQ0zohcpAkc1lK28zaqCvxeA4zlw0uyYTo6sX3vycoSbZreP42oQD06X1C5wEz0vXlumMUjyCVCmCeglE8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nb8xuAM7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hf7cWmdW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768901453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mjsmqMs+6ZBVzHda5xQ25EQLd8+19N5Soiv3QyRip88=;
	b=Nb8xuAM71sPt7Eh9rHLse2rhWBlZEfgiR4guA1CDGtjYpMR77y7nIdyZNMgcNQXXg3j13Z
	gF2MAF97gPIi05WT2KduBMq5l8+cb4u/7M0bKkmC3mvBihP/bU3u92MAfN0oN+1siElYsJ
	MMguzrTV6Bc/vkcX0jcsIjnkzYBpxtE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-dhbg9PNgP_SI8t-zk75hYQ-1; Tue, 20 Jan 2026 04:30:51 -0500
X-MC-Unique: dhbg9PNgP_SI8t-zk75hYQ-1
X-Mimecast-MFC-AGG-ID: dhbg9PNgP_SI8t-zk75hYQ_1768901451
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43591aacca2so278356f8f.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 01:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768901450; x=1769506250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mjsmqMs+6ZBVzHda5xQ25EQLd8+19N5Soiv3QyRip88=;
        b=Hf7cWmdWijqWvePVXAi3+u5PftRSylAi2WYVDEbVyHm3w/QTn2gVPrpXFhYVTHlwSg
         BBkGHNB0yxjdtJlZBgthwQMgqSVr28aau4VVY2IsOLrq0qs0JnK27S6WTORs4mAbyL0t
         qOyDqB4EIBMcNRUejRTSHyf3z1GE+mC0VRwIZ7AayRa9cI2fYslkTBdXxyvOlhqExI/o
         4u7aWJwW4CIRQocVMSjgRf3aCNhFPvbQ2ltxzABA/RYVYJAZ5RAHfT9wUgFtuXai3c4C
         9Bb7rBqsXBeawwBOn3bCeKNZ7uc9DPy9yOqPjeUxDGLvrlUsZL78f4FxHjFl8IQ17ZPT
         K31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768901450; x=1769506250;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mjsmqMs+6ZBVzHda5xQ25EQLd8+19N5Soiv3QyRip88=;
        b=pB7s34U0hvtqakBapJz0aIExd8UFUOjyJdxXwXLwSz7Mb48E4R1TpGymitwzfXckMq
         EstkYU8Vq2VMJfGyieIDu7zr8nsunx0Cpud100VHZio18n7VCnRfdg+QPi+4yRDGpqoU
         45HWA8WwA5VjPFDj+B9Jibr7jgtUX6x6/Jk5SYqA/C35DdHxJ4bRuQId/DT6sXuIv5PT
         Xr8vDhP9zi9O987sc/NNN79/FDEGkbvfKIXjhp9yZpz+NoAG/5/MkhiIW5mitPm7yqhq
         44XCNoRDjdRG2uE/0yDQbOLEdX53rp74maN48Ht8sucaoAZs+V7WQPc7ZIxbh2kuWdLt
         t0QA==
X-Forwarded-Encrypted: i=1; AJvYcCXuTuOnZO1VkxtzEYtWDgTBvSXeoNHes7kwLeT+OC2cJzby62hOyjZnmNQW3mcE4SSO3/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAr+F4Y1pc6dh2m1C98e+DWn0M4jVueUCw9xzwSngOkbJHISl0
	4V6Nh7yF40ShBy2DME2PlQ0KfPWKwi0KxGVInbn/4xrm1LHQGIEL4h89OySJqDe/ez+sP8X9Qpl
	4SKeHyh+0QBRV8IJE6qzw/RklFScFH/pceROaXal6iO/DbAEM+9bq9i4EGVnN
X-Gm-Gg: AZuq6aJ4EX8tkjQbHu/ic8uuLrMBEOQz0EDkr03WKZDyOy1fl9iZ6e+H5dpfb0XIFns
	V9DjQhXwOkDZy/UHczuLJQEaWppOf35xNnWrETl8dTpTlKJlMSt7fHj8fpH5VtKFWyC4Re4rKWk
	t5jsE81M/nuWG4D6zURLk3Qx3FI18xJKHVMbssDKBgBZK8l0JrlZQC79JgDSpmE6xDQ36npIQDP
	ePl2wLeZzvRE/doRqtvI+D1w9FVX+bO7INmIxNX/ggl14NOEADF2tnZRm8uS5lORHulhwrzl/Ea
	OtIPZLUZ14m9jfhpRwLpR/usY6x3tQey56e+dmKfXz3fBVIA1hfgTZ+gT/JevCUfHo0Z8LBE
X-Received: by 2002:a05:6000:178c:b0:42f:ba58:6599 with SMTP id ffacd0b85a97d-4358ff56df1mr1791702f8f.35.1768901450378;
        Tue, 20 Jan 2026 01:30:50 -0800 (PST)
X-Received: by 2002:a05:6000:178c:b0:42f:ba58:6599 with SMTP id ffacd0b85a97d-4358ff56df1mr1791642f8f.35.1768901449818;
        Tue, 20 Jan 2026 01:30:49 -0800 (PST)
Received: from [10.43.17.17] ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992201csm29135888f8f.2.2026.01.20.01.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 01:30:49 -0800 (PST)
Message-ID: <794ca04e-5562-4874-ac54-7ab4cc239378@redhat.com>
Date: Tue, 20 Jan 2026 10:30:48 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Test kfunc bpf_strncasecmp
To: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>, bpf@vger.kernel.org
Cc: mykyta.yatsenko5@gmail.com, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev
References: <20260120070336.188850-1-ishiyama@hpc.is.uec.ac.jp>
 <20260120070336.188850-3-ishiyama@hpc.is.uec.ac.jp>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <20260120070336.188850-3-ishiyama@hpc.is.uec.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/20/26 08:03, Yuzuki Ishiyama wrote:
> Add testsuites for kfunc bpf_strncasecmp.
> 
> Signed-off-by: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>

Please include my ack from v2 (unless you change the patch significantly):

Acked-by: Viktor Malik <vmalik@redhat.com>

> ---
>  tools/testing/selftests/bpf/prog_tests/string_kfuncs.c     | 1 +
>  tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c | 6 ++++++
>  tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c | 1 +
>  tools/testing/selftests/bpf/progs/string_kfuncs_success.c  | 7 +++++++
>  4 files changed, 15 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
> index 0f3bf594e7a5..300032a19445 100644
> --- a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
> @@ -9,6 +9,7 @@
>  static const char * const test_cases[] = {
>  	"strcmp",
>  	"strcasecmp",
> +	"strncasecmp",
>  	"strchr",
>  	"strchrnul",
>  	"strnchr",
> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> index 826e6b6aff7e..bddc4e8579d2 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> @@ -33,6 +33,8 @@ SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_null1(void *ctx) { return
>  SEC("syscall")  __retval(USER_PTR_ERR)int test_strcmp_null2(void *ctx) { return bpf_strcmp("hello", NULL); }
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_null1(void *ctx) { return bpf_strcasecmp(NULL, "HELLO"); }
>  SEC("syscall")  __retval(USER_PTR_ERR)int test_strcasecmp_null2(void *ctx) { return bpf_strcasecmp("HELLO", NULL); }
> +SEC("syscall") __retval(USER_PTR_ERR)int test_strncasecmp_null1(void *ctx) { return bpf_strncasecmp(NULL, "HELLO", 5); }
> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strncasecmp_null2(void *ctx) { return bpf_strncasecmp("HELLO", NULL, 5);	 }
>  SEC("syscall")  __retval(USER_PTR_ERR)int test_strchr_null(void *ctx) { return bpf_strchr(NULL, 'a'); }
>  SEC("syscall")  __retval(USER_PTR_ERR)int test_strchrnul_null(void *ctx) { return bpf_strchrnul(NULL, 'a'); }
>  SEC("syscall")  __retval(USER_PTR_ERR)int test_strnchr_null(void *ctx) { return bpf_strnchr(NULL, 1, 'a'); }
> @@ -57,6 +59,8 @@ SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr1(void *ctx) { ret
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr2(void *ctx) { return bpf_strcmp("hello", user_ptr); }
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_user_ptr1(void *ctx) { return bpf_strcasecmp(user_ptr, "HELLO"); }
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_user_ptr2(void *ctx) { return bpf_strcasecmp("HELLO", user_ptr); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strncasecmp_user_ptr1(void *ctx) { return bpf_strncasecmp(user_ptr, "HELLO", 5); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strncasecmp_user_ptr2(void *ctx) { return bpf_strncasecmp("HELLO", user_ptr, 5);	 }
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strchr_user_ptr(void *ctx) { return bpf_strchr(user_ptr, 'a'); }
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strchrnul_user_ptr(void *ctx) { return bpf_strchrnul(user_ptr, 'a'); }
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strnchr_user_ptr(void *ctx) { return bpf_strnchr(user_ptr, 1, 'a'); }
> @@ -83,6 +87,8 @@ SEC("syscall") __retval(-EFAULT) int test_strcmp_pagefault1(void *ctx) { return
>  SEC("syscall") __retval(-EFAULT) int test_strcmp_pagefault2(void *ctx) { return bpf_strcmp("hello", invalid_kern_ptr); }
>  SEC("syscall") __retval(-EFAULT) int test_strcasecmp_pagefault1(void *ctx) { return bpf_strcasecmp(invalid_kern_ptr, "HELLO"); }
>  SEC("syscall") __retval(-EFAULT) int test_strcasecmp_pagefault2(void *ctx) { return bpf_strcasecmp("HELLO", invalid_kern_ptr); }
> +SEC("syscall") __retval(-EFAULT) int test_strncasecmp_pagefault1(void *ctx) { return bpf_strncasecmp(invalid_kern_ptr, "HELLO", 5); }
> +SEC("syscall") __retval(-EFAULT) int test_strncasecmp_pagefault2(void *ctx) { return bpf_strncasecmp("HELLO", invalid_kern_ptr, 5);	 }
>  SEC("syscall") __retval(-EFAULT) int test_strchr_pagefault(void *ctx) { return bpf_strchr(invalid_kern_ptr, 'a'); }
>  SEC("syscall") __retval(-EFAULT) int test_strchrnul_pagefault(void *ctx) { return bpf_strchrnul(invalid_kern_ptr, 'a'); }
>  SEC("syscall") __retval(-EFAULT) int test_strnchr_pagefault(void *ctx) { return bpf_strnchr(invalid_kern_ptr, 1, 'a'); }
> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> index 05e1da1f250f..412c53b87b18 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> @@ -8,6 +8,7 @@ char long_str[XATTR_SIZE_MAX + 1];
>  
>  SEC("syscall") int test_strcmp_too_long(void *ctx) { return bpf_strcmp(long_str, long_str); }
>  SEC("syscall") int test_strcasecmp_too_long(void *ctx) { return bpf_strcasecmp(long_str, long_str); }
> +SEC("syscall") int test_strncasecmp_too_long(void *ctx) { return bpf_strncasecmp(long_str, long_str, sizeof(long_str)); }
>  SEC("syscall") int test_strchr_too_long(void *ctx) { return bpf_strchr(long_str, 'b'); }
>  SEC("syscall") int test_strchrnul_too_long(void *ctx) { return bpf_strchrnul(long_str, 'b'); }
>  SEC("syscall") int test_strnchr_too_long(void *ctx) { return bpf_strnchr(long_str, sizeof(long_str), 'b'); }
> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> index a8513964516b..3ccfae4d27d3 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> @@ -17,6 +17,13 @@ __test(0) int test_strcasecmp_eq2(void *ctx) { return bpf_strcasecmp(str, "HELLO
>  __test(0) int test_strcasecmp_eq3(void *ctx) { return bpf_strcasecmp(str, "HELLO world"); }
>  __test(1) int test_strcasecmp_neq1(void *ctx) { return bpf_strcasecmp(str, "hello"); }
>  __test(1) int test_strcasecmp_neq2(void *ctx) { return bpf_strcasecmp(str, "HELLO"); }
> +__test(0) int test_strncasecmp_eq1(void *ctx) { return bpf_strncasecmp(str, "hello world", 11); }
> +__test(0) int test_strncasecmp_eq2(void *ctx) { return bpf_strncasecmp(str, "HELLO WORLD", 11); }
> +__test(0) int test_strncasecmp_eq3(void *ctx) { return bpf_strncasecmp(str, "HELLO world", 11); }
> +__test(0) int test_strncasecmp_eq4(void *ctx) { return bpf_strncasecmp(str, "hello", 5); }
> +__test(0) int test_strncasecmp_eq6(void *ctx) { return bpf_strncasecmp(str, "hello world!", 11); }
> +__test(-1) int test_strncasecmp_neq1(void *ctx) { return bpf_strncasecmp(str, "hello!", 6); }
> +__test(1) int test_strncasecmp_neq2(void *ctx) { return bpf_strncasecmp(str, "abc", 3); }
>  __test(1) int test_strchr_found(void *ctx) { return bpf_strchr(str, 'e'); }
>  __test(11) int test_strchr_null(void *ctx) { return bpf_strchr(str, '\0'); }
>  __test(-ENOENT) int test_strchr_notfound(void *ctx) { return bpf_strchr(str, 'x'); }


