Return-Path: <bpf+bounces-68864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E48B8702C
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 23:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93ABC166990
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 21:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF22F2E0937;
	Thu, 18 Sep 2025 21:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOLg5oRe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D469E26C3A7
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 21:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229776; cv=none; b=jnfBKgppsZI9vKH7Coo0HsgFU0RlUIdqZ8DKtpGaElvsMsiXrvWZR5F131tJfly+xbekQKqWKlRHjOzvkovYRNK/lcURttF3cum5M5v1hR+KpaxVlHem1HHlshr2ZYv8p0WI8WGT9SU/3OkdhAzph/V9SwRSj6T+bKsk0PjnMdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229776; c=relaxed/simple;
	bh=BUBhRHQYachcUfHM2JE8WYVTtxGN7nE0eOSCfVzYoB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HggOrFmj77JhoV9dqXtfqV3/u6+rjm9XyrDHvwQRj0h7aOWQyaHg6jYZxrhu1eRwU/nBB4294x8Ccu7zQpeQIgqZmxLlm+5HuxmHvwIeFDt7LYvHCw4mlLuy4L/wm2acQcvU2ZFA8gycFRZpPh6J+wvV349wwJ633bjbHvw1CCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOLg5oRe; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b49b56a3f27so874499a12.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 14:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758229774; x=1758834574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lZuEpjO+uICzOSM+LTukobLFvVeO80Y+qoR/gMqzSuk=;
        b=VOLg5oRefmZ1a9XDq9diWMx8QliafxO2ko1WUqIEd2kVNcbrWGq9DwNJNZK1i2mpqK
         shaY+38qZ7uiZiWpp2kyULoSSeHHm3Kr4CsqMYHxRFSpYLYHO0Np/uf8Lq7ozsTrui3h
         dTGmDOoOBqLibZJO9f5Ukn2BOf1yNqoFTnZhJHx5T2cXWiGBEKIP9FqQclQBySat4SM+
         dYyNrx17HhjMhyFno/soyDyzT2ohq3InaCnWyuLDo8kTFnCB7hutCoXIrlOa4kZJRxzh
         Wc2moecgZ0lBVcFuFyQ8OoNpHFHAIFcNWui6uQ0C6XGtXRVyd4tJnJ6zUn0xJVSmWbND
         HLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758229774; x=1758834574;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZuEpjO+uICzOSM+LTukobLFvVeO80Y+qoR/gMqzSuk=;
        b=iv4KEkuClj69Naz7Nzbyj4Gs4M5NqOpudnXcX9OZ4UMJiSQwP3z97iMmZpCOMo61Bu
         rUdPnid0Ru3gk0tIPM7bQxap/lFxXVku3ggGBtS9Ek9TBN8h02Ym2zzSV7lHFsc8ET/+
         SB2C4Jnb2pcOJIoKdDXd+E9UmuJnQoK7Vw/LzwURp3rUY7SKx4c0WSnLmccjaaCVuKbR
         x+hocjb3UIkqv9t8MqE/eGyj0EajI/1JG094NHXDGUmscWreAWeimZyFZIZD9uANupvh
         JDhXjUlJDtyPW8303HfDaTlmM3mItIsIQRP2uRDklIZgIxJ/AB5YEX92uT5nMgjL7Tgb
         q2ig==
X-Forwarded-Encrypted: i=1; AJvYcCWof8hha18U+vVC5iukxm9makRa0ZM2cZe3hidEfSKdHi8Ds+w0cRE85luGdJkQfDSJHI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4beA11RJI7q9ltpUNG8hVNXVPMS4M/wkBIHTlqLlmit7rkN3q
	MfVN8+Ca12M3v8sUa6YR5UlE6kUjMcnbUi61K/lS2FCojShrQF3V4P9n
X-Gm-Gg: ASbGncuyb/ws1JM09oMvkP/JjDjmZeSeWEz8M1xgpaPmcA1tiwzYF+PknHLHBeyZC/y
	uJfD0GGjfIvjGlalhjYEH6n+g2ZMTF0H37KiaKTMlfFnb/xvv6l4YUStVM5wJQ5cCkHw/j2vSlU
	9WoN+lYhHfcnz1+MVJAw0gDWueUeryb5fVQWwk11+dI0liyqm62iafVBO3CQT9BehkJSBZn9zqU
	r8iwqpkeIk5d2yMhQGhUDWLE7Dld9SiNIkeNZgTy+7/RugP6/ZSe8NV3b3x6/ZQUq9eRFjP98Ri
	OsUKgU5Esuj4vGCg/MGXZJx+FlMAAOukdKWe32JoiXSfO0qGJ5I9WMyBGHcvCgt6JQuPcAu55Qe
	88CNN84NXhjRxz2AqTj3kgvZD5Sn3JqtH0We4yRq/XOo7sMjk2pGLOrwyhxPTeYjuiiEdmut3Zq
	K9sjvQUmb5+g==
X-Google-Smtp-Source: AGHT+IH6VFShmK0xRMZw5ZVuoigO9a0jb7JDOaG0QqbueMw9wvD47CsQiUtCzasafcgw6arTr6Jbdw==
X-Received: by 2002:a05:6a20:7347:b0:249:f8ac:2e6e with SMTP id adf61e73a8af0-2925a2c7cffmr1363504637.5.1758229774004;
        Thu, 18 Sep 2025 14:09:34 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:a:1c9c:f459:a4f0:f86a? ([2620:10d:c090:500::4:d5f1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfe66995esm3287952b3a.50.2025.09.18.14.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 14:09:33 -0700 (PDT)
Message-ID: <395da6e0-15ed-47b8-88b7-93df61061e7d@gmail.com>
Date: Thu, 18 Sep 2025 14:09:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 1/8] bpf: refactor special field-type
 detection
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250918132615.193388-1-mykyta.yatsenko5@gmail.com>
 <20250918132615.193388-2-mykyta.yatsenko5@gmail.com>
Content-Language: en-US
From: Amery Hung <ameryhung@gmail.com>
In-Reply-To: <20250918132615.193388-2-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/18/25 6:26 AM, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Reduce code duplication in detection of the known special field types in
> map values. This refactoring helps to avoid copying a chunk of code in
> the next patch of the series.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   kernel/bpf/btf.c | 56 +++++++++++++++++-------------------------------
>   1 file changed, 20 insertions(+), 36 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 64739308902f..a1a9bc589518 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3488,44 +3488,28 @@ static int btf_get_field_type(const struct btf *btf, const struct btf_type *var_
>   			      u32 field_mask, u32 *seen_mask,
>   			      int *align, int *sz)
>   {
> -	int type = 0;
> +	const struct {
> +		enum btf_field_type type;
> +		const char *const name;
> +	} field_types[] = { { BPF_SPIN_LOCK, "bpf_spin_lock" },
> +			    { BPF_RES_SPIN_LOCK, "bpf_res_spin_lock" },
> +			    { BPF_TIMER, "bpf_timer" },
> +			    { BPF_WORKQUEUE, "bpf_wq" }};
> +	int type = 0, i;
>   	const char *name = __btf_name_by_offset(btf, var_type->name_off);
> +	const char *field_type_name;
> +	enum btf_field_type field_type;
>   
> -	if (field_mask & BPF_SPIN_LOCK) {
> -		if (!strcmp(name, "bpf_spin_lock")) {
> -			if (*seen_mask & BPF_SPIN_LOCK)
> -				return -E2BIG;
> -			*seen_mask |= BPF_SPIN_LOCK;
> -			type = BPF_SPIN_LOCK;
> -			goto end;
> -		}
> -	}
> -	if (field_mask & BPF_RES_SPIN_LOCK) {
> -		if (!strcmp(name, "bpf_res_spin_lock")) {
> -			if (*seen_mask & BPF_RES_SPIN_LOCK)
> -				return -E2BIG;
> -			*seen_mask |= BPF_RES_SPIN_LOCK;
> -			type = BPF_RES_SPIN_LOCK;
> -			goto end;
> -		}
> -	}
> -	if (field_mask & BPF_TIMER) {
> -		if (!strcmp(name, "bpf_timer")) {
> -			if (*seen_mask & BPF_TIMER)
> -				return -E2BIG;
> -			*seen_mask |= BPF_TIMER;
> -			type = BPF_TIMER;
> -			goto end;
> -		}
> -	}
> -	if (field_mask & BPF_WORKQUEUE) {
> -		if (!strcmp(name, "bpf_wq")) {
> -			if (*seen_mask & BPF_WORKQUEUE)
> -				return -E2BIG;
> -			*seen_mask |= BPF_WORKQUEUE;
> -			type = BPF_WORKQUEUE;
> -			goto end;
> -		}
> +	for (i = 0; i < ARRAY_SIZE(field_types); ++i) {
> +		field_type = field_types[i].type;
> +		field_type_name = field_types[i].name;
> +		if (!(field_mask & field_type) || strcmp(name, field_type_name))
> +			continue;
> +		if (*seen_mask & field_type)
> +			return -E2BIG;
> +		*seen_mask |= field_type;
> +		type = field_type;
> +		goto end;
>   	}
>   	field_mask_test_name(BPF_LIST_HEAD, "bpf_list_head");

How about extending the scope of the refactor by also handling 
btf_get_field_type in the loop? For example, add a "bool is_unique" to 
field_types and check seen_mask when is_unique == true.

>   	field_mask_test_name(BPF_LIST_NODE, "bpf_list_node");


