Return-Path: <bpf+bounces-62299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E15EAF7C87
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 17:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFFA01888997
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 15:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B9C1A2545;
	Thu,  3 Jul 2025 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETbY+Sgt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A213814B092
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 15:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556850; cv=none; b=PoMyEtWFf+obM9SfPmodMMg/pyx3E9kQiU/yeBUBxnXBabqPLrC7fZr1d1eiCaiSONfhlqzK+dpAUtfZZCisMsQhlfmaxrFBN3/VLBb3nEsVHmKuFVH/s/Jfme6iZq9gRH/AS4klbaVbQQaZ3PyefkZSemPfZCgBW8MZccJj6Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556850; c=relaxed/simple;
	bh=IM4xmrT/d2FQ0KfogLLnHw6i3mTo/16G73mOopUZ5Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AAug9O9R0KFgO1TI0NKeBy7A5QDPDUUApSVPc57YOYes077bWh7wfZ0DAY0lVCWEExsb8RB8DAWLmITmqqzQQ966f850b3Pm0yvT3DywHwxb/Z5jjICs6uIgcl27JiCjuuVVYc56Hy+4ATY2oo9jnziA4x0cd64eF48KLXzzTEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETbY+Sgt; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0ccfd5ca5so826343066b.3
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 08:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751556847; x=1752161647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D/UGyXzTpj/1OWCpchEevLa5jexJqRnoqDVcHgMs7uc=;
        b=ETbY+Sgtb2G0REjRZUSyTNaC7BYZkCF4n1YgT6rmeci7Rq5eBWbEtuGw3uzOlLBvyp
         2zm8OLs6EEWuBlo3gTYCHr0eKRnbTuP5VAnpX9OSAs5UWRYt+XID24VQ2+ta0brcypDX
         ow8Jo0V+p2f9kUM5kOGDhRhAd4AvgZ3NscczXTlTA56gtlZc4NYvjkTm94Qp2j7JERhp
         Jh5qdYfDA30MvSOxp86Y1heig9CUpWBgcpTwomdLDULbz1trofIO8xG0HpAG144dTSH/
         /83DZLlkgmyKJvQs8gjzXZIZ07ch7iUbOA28Zkq4ZgMOfBduKdqpGba1EMzKdrwezlNQ
         GkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751556847; x=1752161647;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D/UGyXzTpj/1OWCpchEevLa5jexJqRnoqDVcHgMs7uc=;
        b=HRVMeFVmRTRtw5j0O3bBYs1C7WBkpWGc23NmhFZgFLEfZJdCHBqeFrrsY8KvNhorQ+
         kMMKFWqaspwf87WVvWYClXnCCQ29tPMpDmfuMmAnf3ttt7yYPRMO8RStC/fA2p3k5Elx
         tWg3lzZPvLYKucevnf89drbNNYntevbMlDA353iT9nmPBYyr8IwvZ+hnbUiH0ZfK0OfP
         djrkZCM9HmrfNpXKocew4kD2Szksrlc/279qt9eqoKUHtTKTdm6EEMbfSSFCrIGbuozm
         suB/9WCJu6AiHpoTzAn1ATcVIZWrBiT6gvZTjCIjE88Tzw3AP5kFh5id9JgxqoS7MRmC
         MwEg==
X-Forwarded-Encrypted: i=1; AJvYcCX40qKpPGb19Kk53yW77154b03Ws57v8bX7oFL4wZZQetkMEQx+zsD6ZMYgUZkYGTwpok0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPglZ4Tbik3wm+7Bo70ouymZxAERvVd+R5i5WpBN/mv+yfMvjs
	bvZvGVMbBLicADUaV6gWOUbUMFqTS8ze4f2aQjTBXhYGhJQL5fFX8y5u
X-Gm-Gg: ASbGncvcHBCkKPEN8jHCj7snkjqaOAcPqRdnYm1qVx0RxoMyhz2T2ro381ed3sjWU8O
	2WS/5yCDjLJLT6OrqvGOPgH3X8AtIqeknI5PSEesFjOVDpFZDm45FGrWdjouESW68L2KFPiJSHF
	vTQpfVhzkZf3sf+x2R8IBXkB8Sz6w5muWXHbdVZRT8Zg5tTIe6wM50OKZ/6C09xYDCcUYZoGSO6
	+dxOqSdywaBKekEbubxcqGHE9KMbEWrQbjcyE2WXLXT+/Qh2mVRX2KtfV1ozP42ylecnty0wLFh
	zirirxlnIoOFvqFJwFyma1hheb1bdFJKTajURyxgD0Y617aYLmAFGZoobB4BvP7VhQr1hDSxqZE
	3pnHEJzFFXqlle/BrWE8O6w4=
X-Google-Smtp-Source: AGHT+IEvcHBQdgJVE5AgJa8WaxQzvnKiD+v0EdQRXzPlKcgD7CPeO0/zeZcfYXQ4tmUqWbMFQpyrxw==
X-Received: by 2002:a17:906:ef0c:b0:ae3:ce75:afd8 with SMTP id a640c23a62f3a-ae3ce75b156mr585454766b.30.1751556846603;
        Thu, 03 Jul 2025 08:34:06 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:adf5:792c:cb08:e1b0? ([2620:10d:c092:500::4:b191])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c014fbsm1270100066b.86.2025.07.03.08.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 08:34:06 -0700 (PDT)
Message-ID: <d711d0b7-01a5-4ae8-9549-f30997aeebec@gmail.com>
Date: Thu, 3 Jul 2025 16:34:05 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: add test cases for
 bpf_dynptr_memset()
To: ihor.solodrai@linux.dev, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 kernel-team@meta.com
References: <20250702210309.3115903-1-isolodrai@meta.com>
 <20250702210309.3115903-3-isolodrai@meta.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250702210309.3115903-3-isolodrai@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/25 22:03, Ihor Solodrai wrote:
> Add tests to verify the behavior of bpf_dynptr_memset():
>    * normal memset 0
>    * normal memset non-0
>    * memset with an offset
>    * memset in dynptr that was adjusted
>    * error: size overflow
>    * error: offset+size overflow
>    * error: readonly dynptr
>    * memset into non-linear xdp dynptr
>
> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
> ---
>   .../testing/selftests/bpf/prog_tests/dynptr.c |   8 +
>   .../selftests/bpf/progs/dynptr_success.c      | 158 ++++++++++++++++++
>   2 files changed, 166 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> index 62e7ec775f24..f2b65398afce 100644
> --- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
> +++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> @@ -21,6 +21,14 @@ static struct {
>   	{"test_dynptr_data", SETUP_SYSCALL_SLEEP},
>   	{"test_dynptr_copy", SETUP_SYSCALL_SLEEP},
>   	{"test_dynptr_copy_xdp", SETUP_XDP_PROG},
> +	{"test_dynptr_memset_zero", SETUP_SYSCALL_SLEEP},
> +	{"test_dynptr_memset_notzero", SETUP_SYSCALL_SLEEP},
> +	{"test_dynptr_memset_zero_offset", SETUP_SYSCALL_SLEEP},
> +	{"test_dynptr_memset_zero_adjusted", SETUP_SYSCALL_SLEEP},
> +	{"test_dynptr_memset_overflow", SETUP_SYSCALL_SLEEP},
> +	{"test_dynptr_memset_overflow_offset", SETUP_SYSCALL_SLEEP},
> +	{"test_dynptr_memset_readonly", SETUP_SKB_PROG},
> +	{"test_dynptr_memset_xdp_chunks", SETUP_XDP_PROG},
>   	{"test_ringbuf", SETUP_SYSCALL_SLEEP},
>   	{"test_skb_readonly", SETUP_SKB_PROG},
>   	{"test_dynptr_skb_data", SETUP_SKB_PROG},
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
> index a0391f9da2d4..7d7081d05d47 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
> @@ -681,6 +681,164 @@ int test_dynptr_copy_xdp(struct xdp_md *xdp)
>   	return XDP_DROP;
>   }
>   
> +char memset_zero_data[] = "data to be zeroed";
> +
> +SEC("?tp/syscalls/sys_enter_nanosleep")
> +int test_dynptr_memset_zero(void *ctx)
> +{
> +	__u32 data_sz = sizeof(memset_zero_data);
> +	char zeroes[32] = {'\0'};
> +	struct bpf_dynptr ptr;
> +
> +	err = bpf_dynptr_from_mem(memset_zero_data, data_sz, 0, &ptr);
> +	err = err ?: bpf_dynptr_memset(&ptr, 0, data_sz, 0);
> +	err = err ?: bpf_memcmp(zeroes, memset_zero_data, data_sz);
> +
> +	return 0;
> +}
> +
> +#define DYNPTR_MEMSET_VAL 42
> +
> +char memset_notzero_data[] = "data to be overwritten";
> +
> +SEC("?tp/syscalls/sys_enter_nanosleep")
> +int test_dynptr_memset_notzero(void *ctx)
> +{
> +	u32 data_sz = sizeof(memset_notzero_data);
> +	struct bpf_dynptr ptr;
> +	char expected[32];
> +
> +	__builtin_memset(expected, DYNPTR_MEMSET_VAL, data_sz);
> +
> +	err = bpf_dynptr_from_mem(memset_notzero_data, data_sz, 0, &ptr);
> +	err = err ?: bpf_dynptr_memset(&ptr, 0, data_sz, DYNPTR_MEMSET_VAL);
> +	err = err ?: bpf_memcmp(expected, memset_notzero_data, data_sz);
> +
> +	return 0;
> +}
> +
> +char memset_zero_offset_data[] = "data to be zeroed partially";
> +
> +SEC("?tp/syscalls/sys_enter_nanosleep")
> +int test_dynptr_memset_zero_offset(void *ctx)
> +{
> +	char expected[] = "data to \0\0\0\0eroed partially";
> +	__u32 data_sz = sizeof(memset_zero_offset_data);
> +	struct bpf_dynptr ptr;
> +
> +	err = bpf_dynptr_from_mem(memset_zero_offset_data, data_sz, 0, &ptr);
> +	err = err ?: bpf_dynptr_memset(&ptr, 8, 4, 0);
> +	err = err ?: bpf_memcmp(expected, memset_zero_offset_data, data_sz);
> +
> +	return 0;
> +}
> +
> +char memset_zero_adjusted_data[] = "data to be zeroed partially";
> +
> +SEC("?tp/syscalls/sys_enter_nanosleep")
> +int test_dynptr_memset_zero_adjusted(void *ctx)
> +{
> +	char expected[] = "data\0\0\0\0be zeroed partially";
> +	__u32 data_sz = sizeof(memset_zero_adjusted_data);
> +	struct bpf_dynptr ptr;
> +
> +	err = bpf_dynptr_from_mem(memset_zero_adjusted_data, data_sz, 0, &ptr);
> +	err = err ?: bpf_dynptr_adjust(&ptr, 4, 8);
> +	err = err ?: bpf_dynptr_memset(&ptr, 0, bpf_dynptr_size(&ptr), 0);
> +	err = err ?: bpf_memcmp(expected, memset_zero_adjusted_data, data_sz);
> +
> +	return 0;
> +}
> +
> +char memset_overflow_data[] = "memset overflow data";
> +
> +SEC("?tp/syscalls/sys_enter_nanosleep")
> +int test_dynptr_memset_overflow(void *ctx)
> +{
> +	__u32 data_sz = sizeof(memset_overflow_data);
> +	struct bpf_dynptr ptr;
> +	int ret;
> +
> +	err = bpf_dynptr_from_mem(memset_overflow_data, data_sz, 0, &ptr);
> +	ret = bpf_dynptr_memset(&ptr, 0, data_sz + 1, 0);
> +	if (ret != -E2BIG)
> +		err = 1;
> +
> +	return 0;
> +}
> +
> +SEC("?tp/syscalls/sys_enter_nanosleep")
> +int test_dynptr_memset_overflow_offset(void *ctx)
> +{
> +	__u32 data_sz = sizeof(memset_overflow_data);
> +	struct bpf_dynptr ptr;
> +	int ret;
> +
> +	err = bpf_dynptr_from_mem(memset_overflow_data, data_sz, 0, &ptr);
> +	ret = bpf_dynptr_memset(&ptr, 1, data_sz, 0);
> +	if (ret != -E2BIG)
> +		err = 1;
> +
> +	return 0;
> +}
> +
> +SEC("?cgroup_skb/egress")
> +int test_dynptr_memset_readonly(struct __sk_buff *skb)
> +{
> +	struct bpf_dynptr ptr;
> +	int ret;
> +
> +	err = bpf_dynptr_from_skb(skb, 0, &ptr);
> +
> +	/* cgroup skbs are read only, memset should fail */
> +	ret = bpf_dynptr_memset(&ptr, 0, bpf_dynptr_size(&ptr), 0);
> +	if (ret != -EINVAL)
> +		err = 1;
> +
> +	return 0;
> +}
> +
> +#define min_t(type, x, y) ({		\
> +	type __x = (x);			\
> +	type __y = (y);			\
> +	__x < __y ? __x : __y; })
> +
> +SEC("xdp")
> +int test_dynptr_memset_xdp_chunks(struct xdp_md *xdp)
> +{
> +	u32 data_sz, chunk_sz, offset = 0;
> +	const int max_chunks = 200;
> +	struct bpf_dynptr ptr_xdp;
> +	char expected_buf[32];
> +	char buf[32];
> +	int i;
> +
> +	__builtin_memset(expected_buf, DYNPTR_MEMSET_VAL, sizeof(expected_buf));
> +
> +	/* ptr_xdp is backed by non-contiguous memory */
> +	bpf_dynptr_from_xdp(xdp, 0, &ptr_xdp);
> +	data_sz = bpf_dynptr_size(&ptr_xdp);
> +
> +	err = bpf_dynptr_memset(&ptr_xdp, 0, data_sz, DYNPTR_MEMSET_VAL);
> +	if (err)
> +		goto out;
> +
> +	bpf_for(i, 0, max_chunks) {
> +		offset = i * sizeof(buf);
> +		if (offset >= data_sz)
> +			goto out;
> +		chunk_sz = min_t(u32, sizeof(buf), data_sz - offset);
> +		err = bpf_dynptr_read(&buf, chunk_sz, &ptr_xdp, offset, 0);
> +		if (err)
> +			goto out;
> +		err = bpf_memcmp(buf, expected_buf, sizeof(buf));
> +		if (err)
> +			goto out;
> +	}
> +out:
> +	return XDP_DROP;
> +}
> +
>   void *user_ptr;
>   /* Contains the copy of the data pointed by user_ptr.
>    * Size 384 to make it not fit into a single kernel chunk when copying
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

