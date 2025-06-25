Return-Path: <bpf+bounces-61518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D99BCAE81D7
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 13:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61061188C9B3
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 11:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6695C25D1EA;
	Wed, 25 Jun 2025 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqEipO6T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA6F25D1E3
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851950; cv=none; b=DRtUgABihTAYlpsNA85jFy12vviozSMwKKCSfMKdXvhjB2ojM1v27OdxTJXzLd3trdQggzY3Gb06qskteHRQWnR5gqKPfRXqOS8/6EAZX5AT7i/vcpamsFrYgRYecmgcX77lALl21KAn6+rbET2iIYzyP5596dvFZh4exp2bSqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851950; c=relaxed/simple;
	bh=5uEeE8bBQ9+05qywCXdNkg2bT1q6byo/bI+ApFg8rRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSCjPznEPyR/UuU8droGM0KM/xFdto4sJ0Cit/MxHry4S0thh0DHNwF241PUz0YUTjpsKHdnnG8lgz7SV2Z4vmAdJcgEReEF551vHO7uTjBeOITfp+CXYMdN0UwLQwQL+FGKxo99JNoQ9JzB+0qRfHhgDcFKRy0m7DeL5Y59XMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqEipO6T; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ade58ef47c0so171408466b.1
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 04:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750851945; x=1751456745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ewi5rSgWTJl1J4144tcM8CaaVSFEC2T8+PecTVWWii0=;
        b=dqEipO6TyY7/895fxg0SdBV/Y0jHzAk71jxfaz3syYv6SfedGW33WvTIdrulwwfDUk
         IJd8OPqP1rGrFuctO7om1jY9wsOEYjquPWck7DZhdpPvcbEOPGYs7bs+h0Vg28MDX0a5
         4VR6Tai63VdIgLz25YZq7aqm870nS34qrZMB/w5kvQ96m6M8XNepIQw+CyrTu8BWXRK1
         OOMF4DA7KxjDPSitAbGE7g2owsxWYrVwDeLVYTE/kQvkA24/6QardR2WRjmoipe6nnqk
         yDD5/sTzLDNVxPg0yG/y5WYmdgnp6alYseW68oyzyYTAoAKSqP8UGIwvWuqAF5vs57lg
         gbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750851945; x=1751456745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ewi5rSgWTJl1J4144tcM8CaaVSFEC2T8+PecTVWWii0=;
        b=X75DsAwdxqBN3HRzxVovx1cylw1VvcX8copYWL9hleLNXp0GBvs5XblT32tQg/Esaj
         PYWN+zG+uPB9Nir3ecQFNJoXe2TLLVKKe9YJtgdy4HWSLEambQtWgKsxG4n1kwtqKUvR
         38Cr4QHTuNC7fEUZ/cjI/MR7IRJMLKcNpyQKA4x+HKK9d/ODuP0b1WPHH7qidGI6Z9zn
         8yBvGDjkC4QZQMTKUvlR7IrIJYwT/ieJ7LGveIBoKxzUjbXWXYmsX7Gw5lPmp07REgnQ
         CtXCJkyukeWcCs7ZphL+Gmmk1asFvI65VLILjQYVyB87dpok/s5qDui6Yo67eEcAVnOj
         +QSA==
X-Forwarded-Encrypted: i=1; AJvYcCXcbM5P9B+ej2HLmuKwQurR3bBmw8RAfYLaxjxuXFbJc0N9Ftvx5SKXUqn/1WBSus6oSIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/flhhaDgGOhz5tuarkNP0BBxLeKPI6fhZd3GbApnGjd38LhXV
	S6KM1Co/6iaw6R2XAjfaxBT6qI3wq/sXJul0Owp4i1iixCP+Rehfvn+6
X-Gm-Gg: ASbGncuXeZl1ZrcnMODvYo6eS+xCua41z4Emw2FYUhPr8vhEUbrCN8FmYnTX6EbU80p
	wkuts+iIdHhmDvViQYRZs195N4er5QSehcIk2dmI1CHZRYIQK07QbFJihwzFCcnyQlZXQvzd9FK
	mJ89A7J4DIhh2Vgkg6CDQD1n1a/pZVDNkoBfdYn68RsF4YDwOBr74Amky2hIv5YHOHlypfk9ZnG
	4JCSp+YicjPWF389e2XijSvFTNbmZr2mm9S/WbmYa97XL8HmkhFrGSIrWXxcDeGTg2pt7/Py87B
	mjJJ8Y0EoSe4xIYxohtDOo5pN7dTtiF6yOsOOUdiO8N9oPDt+KWxc7X3ETnuXLag7JmzHqz/Ukl
	V+4lF9viXuZ5+4mikTnF3nQ==
X-Google-Smtp-Source: AGHT+IEfOOm56TZ+/T/zcQDnfoasIKi6B4SNQnbhqUzOrmRX+XLTy9AqLwVHStOHjM4xGOIcSLaBQw==
X-Received: by 2002:a17:907:3f90:b0:ae0:af09:315b with SMTP id a640c23a62f3a-ae0c066c79emr258752466b.8.1750851945234;
        Wed, 25 Jun 2025 04:45:45 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:a86b:88c6:73bf:c6e4? ([2620:10d:c092:500::5:606])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0bc2fdeb4sm148595866b.4.2025.06.25.04.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 04:45:44 -0700 (PDT)
Message-ID: <5f00c508-5150-4e69-b006-d15b0e6b2d23@gmail.com>
Date: Wed, 25 Jun 2025 12:45:43 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: add test cases for
 bpf_dynptr_memset()
To: ihor.solodrai@linux.dev, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 kernel-team@meta.com
References: <20250624205240.1311453-1-isolodrai@meta.com>
 <20250624205240.1311453-3-isolodrai@meta.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250624205240.1311453-3-isolodrai@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/25 21:52, Ihor Solodrai wrote:
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
>   .../selftests/bpf/progs/dynptr_success.c      | 164 ++++++++++++++++++
>   2 files changed, 172 insertions(+)
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
> index a0391f9da2d4..61d9ae2c6a52 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
> @@ -681,6 +681,170 @@ int test_dynptr_copy_xdp(struct xdp_md *xdp)
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
> +SEC("xdp")
> +int test_dynptr_memset_xdp_chunks(struct xdp_md *xdp)
> +{
> +	const int max_chunks = 200;
> +	struct bpf_dynptr ptr_xdp;
> +	u32 data_sz, offset = 0;
> +	char expected_buf[32];
nit: expected_buf[32] = {DYNPTR_MEMSET_VAL};
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
Maybe we can calculate max_chunks instead of hardcoding, something like:
max_chunks = data_sz / sizeof(expected_buf) + (data_sz % 
sizeof(expected_buf) ? 1 : 0);
> +	bpf_for(i, 0, max_chunks) {
> +		offset = i * sizeof(buf);
> +		err = bpf_dynptr_read(&buf, sizeof(buf), &ptr_xdp, offset, 0);

handle_tail seems unnecessary, maybe handle tail in the main loop:
__u32 sz = min_t(data_sz - offset : sizeof(buf));
bpf_dynptr_read(&buf, sz, &ptr_xdp, offset, 0);

> +		switch (err) {
> +		case 0:
> +			break;
> +		case -E2BIG:
> +			goto handle_tail;
> +		default:
> +			goto out;
> +		}
> +		err = bpf_memcmp(buf, expected_buf, sizeof(buf));
> +		if (err)
> +			goto out;
> +	}
> +
> +handle_tail:
> +	if (data_sz - offset < sizeof(buf)) {
> +		err = bpf_dynptr_read(&buf, data_sz - offset, &ptr_xdp, offset, 0);
> +		if (err)
> +			goto out;
> +		err = bpf_memcmp(buf, expected_buf, data_sz - offset);
> +	}
> +out:
> +	return XDP_DROP;
> +}
> +
>   void *user_ptr;
>   /* Contains the copy of the data pointed by user_ptr.
>    * Size 384 to make it not fit into a single kernel chunk when copying


