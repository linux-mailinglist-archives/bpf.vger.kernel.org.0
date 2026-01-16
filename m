Return-Path: <bpf+bounces-79303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CD7D3368E
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 17:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13B0C30A28CC
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 16:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B4B341059;
	Fri, 16 Jan 2026 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQNtjksU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lx+hVR0/"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AD5279907
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768579892; cv=none; b=dNDsYWSfStpnnwW9AGKfwWeXpAYaLM5jGYV6KFiGjBKz6JhD2uNKEgSNq6oJrbsH7FX3Qk2Er3ZzcTbXmEbpskGZhyb0U8AzM5IJhIE8iE1k3G/52aIWPXP8vlokg76ds4YOBz3jkkYveC0qHu5gssEliq8fgt68otEi5lZDXRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768579892; c=relaxed/simple;
	bh=pmipuDVRwoziO6rN2I8jFmVxQk2ZU2f/meT/Da/v3nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7ynmjOA1yfTfKNTXF4xoVoaOd64lwQD8FnqkQIaJWUqmofWRL55+fCzKpDfg9Y1KDjoW8rppPNAVrs6zHNXRdZvt0+M7+ugRnFBchxThMS2iz01e99Bx/1Pw1CUuQZxh12s3wbyrYTxrh10zP9hbe+xliHH1qBMwc3Q8mKWy5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQNtjksU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lx+hVR0/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768579889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KOrR5+RfAAC85/n9nKRjwndKvJEuOoRVh6QL8WMSRnE=;
	b=dQNtjksUtYzMYc88kHIi1cYX7dnXTR1QUqimAXBuDxv3EA6mDLi/Y3oZl4MjRF5D3iGbw5
	UqzpxfeQ0PwYTfOoaTvsfgYXM3BJi75S2xQwA6Im6VgpyjvbUJy1v5bnlwcRybo8jZRzmv
	HTmuFf6nUZeSS4xswrGIOFbck13fbC4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-9_4WKO1wNjKFZtQADNiIkw-1; Fri, 16 Jan 2026 11:11:27 -0500
X-MC-Unique: 9_4WKO1wNjKFZtQADNiIkw-1
X-Mimecast-MFC-AGG-ID: 9_4WKO1wNjKFZtQADNiIkw_1768579887
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4801ad6e51cso16825765e9.2
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 08:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768579886; x=1769184686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KOrR5+RfAAC85/n9nKRjwndKvJEuOoRVh6QL8WMSRnE=;
        b=lx+hVR0/7hdeBvBFHZ/6WglMgYlBexdw+jQDtiRkdYz4C5wdhVV9VoR8zmroBGqTz8
         lVOnLsPOtUTfXCGLEK2WJA2Y/2vB91saBjMdewPdn7VtpxNS9e3AT25hq4e60DNQnjx9
         wf628JaB2hcETjo06MYTs9lB++pr5Id8yRPLa6yIdqhelOykHQZu0w8pjPsGBVaUpVQc
         +zXHSdCr7vO7XYuGSA8bsEooynNmLzodjQf/m/6dGeHj+ENhKixv9+G9m3IR2Sx0jUXP
         s/rn0v+WcVPMOGI7bDktl44MRlcmEw7P671oeJ9QeckqHaxKybYjw0VpjNuX3a+PapiA
         QGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768579886; x=1769184686;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOrR5+RfAAC85/n9nKRjwndKvJEuOoRVh6QL8WMSRnE=;
        b=wDVcCnf4vqOWFdtZw2Jec4qslPJDGiHNNRB2i6pUpa/4lfVAUOlJ3L7Eg+uUEStUOl
         srCLkNC61prmi3Br8nIMYO6rYlVHnXHyhE4QPJlOg3z/oA/UgC1Vc9KILvsok5BMfU2C
         6WrzoxBjrjtHqYHSYOYBD/tL9bndJVraJpiC2C40qsu9bFBzHYNZXigJqJqwThYeW8n6
         SHAh2NIIV/HAt9MyrkhfXVxYzMGl/t1XnT9HmmqTkemiUjJ21ygWvL/dSHk19SCyArdT
         38N2lsUZwa33wyuXEzXzRiARCiRCftVeHboQ4P2No93Vwws8LXedmgTn83aI3BNMyCke
         hQZw==
X-Forwarded-Encrypted: i=1; AJvYcCWN17Ritau/YtqKvIxav4hRXUNrZlZT5/fPXDdq/rfvyXCcZ1wvk+0bMjVZzSL0m6LHgdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5alkU5BM+TbmWPpC7YAOlI8817n5vjqbzas9Xj+k1VUhUAiYN
	QXBLIFfuGJjj0Btp1/rqP1PefDw4vC32bDPS8Xhhcrf2Gn1JWdQZFgIXdUhDhLCOkLUgCZDAiCE
	Qv/nLGyiBWuA5mIJqL4U6XbJEGit5VrXKvGuwGfqps7RgOSz3ZFey
X-Gm-Gg: AY/fxX4SGXbTaxxnbZfj6XX2fVpgI7KfoftDmerhwoUrpkBPOvw2NcX4mooHGgTa2lW
	eNvJ7gxDIvZqZ7TWw+xTMWbNXowiLdGp+tsb6cttPmal4hywlIKVAuQAd6EoVMQTcLFhqpv/84m
	xb/jg5HAkKQQIEBwxL8N0AZQMVfI53yByeXh4lDvQW5ZSumbWQcpdNsgDDH4Uuh9tlVb6UmxDIM
	vT440K5FsQTDbnxgQe7i1sLtHBoGdzsiHqZ4FNMcGBqwcNLom0clOaaGoNccsHXS7mXGIuMZrc8
	zTdwzjVAPEIrv428Ugxv+AcuvESupjh0qj+JedLnN/9kBbDyunmk/QoJUAVuR22VoXlpgt45W/k
	ZaLMmyuf3R/7/XHl1Vtq6E62YhlS8DOFZKdvjNQ9NMelTxg==
X-Received: by 2002:a05:600c:4e43:b0:47e:d943:ec08 with SMTP id 5b1f17b1804b1-4801e33dc26mr38942205e9.28.1768579886533;
        Fri, 16 Jan 2026 08:11:26 -0800 (PST)
X-Received: by 2002:a05:600c:4e43:b0:47e:d943:ec08 with SMTP id 5b1f17b1804b1-4801e33dc26mr38941825e9.28.1768579886100;
        Fri, 16 Jan 2026 08:11:26 -0800 (PST)
Received: from [192.168.0.199] (bband-dyn169.95-103-216.t-com.sk. [95.103.216.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe7bc14sm18579325e9.20.2026.01.16.08.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 08:11:25 -0800 (PST)
Message-ID: <7af9b5a5-5022-404a-8759-e091bf44bffe@redhat.com>
Date: Fri, 16 Jan 2026 17:11:24 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test kfunc bpf_strncasecmp
To: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, mykyta.yatsenko5@gmail.com
References: <20260116142455.3526150-1-ishiyama@hpc.is.uec.ac.jp>
 <20260116142455.3526150-3-ishiyama@hpc.is.uec.ac.jp>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <20260116142455.3526150-3-ishiyama@hpc.is.uec.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/26 15:24, Yuzuki Ishiyama wrote:
> Add testsuites for kfunc bpf_strncasecmp.
> 
> Signed-off-by: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>

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


