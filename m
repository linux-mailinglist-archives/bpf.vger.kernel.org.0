Return-Path: <bpf+bounces-74948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FF5C6951E
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 13:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F30A4F28BD
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 12:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C27334F259;
	Tue, 18 Nov 2025 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kaa0j4bq"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEAA351FA3
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763468028; cv=none; b=Jd2cmro/qg8rQNXP0tmEIc6MPYbbbbiZezbtnA+WfjvczE/aj23LLpMsQna8EZyiGWnzpEXWdp4vcvdckT7C/nSGNQdD5Xb0TFzvlGw2iyIYrF5CxzX8mwqBKrBzQLXCR5o/gBYP4J4KApUUD8/wInDtgB9m0DNIXl1DeuKOYMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763468028; c=relaxed/simple;
	bh=cldJh+D1bjbxu/2MTDXVRGp6C7nKPCHXwJINkvJZQcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pDwzSxyENAEsmWsvqcIjlQotGH7HpId9fBKeH3eFdptcaz2TNCA8zWDQottcasOLdvSURH5VplD1qBMjATROBXoqXiMPFHn/HQmtqRSwaSW4G2tkRrWc3c+DX/4Z3p5iX0/SpMbdr5fx4spcrYQ7gJzZjFMKeG+RIZrNpdLRIkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kaa0j4bq; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1f313f86-c0be-4d29-aa90-5c95afa92827@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763468023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DdzhoZH3NR8Ep51OQAMEdgwgttikfFQ5UBUROZBxzNg=;
	b=Kaa0j4bqQxsgRk3yOVkVUBromUSJlGF27wX7cBEMeDIIHSFMWkhrXPfqo1rZ4qmVnXHOvA
	+oGea/z+ucEjfGGyb5KYDGr0qJ6ocXNgk54dKbAo5HrB7WufagsOgMSRpnyt508UFe4HCd
	sbOXK+MEF1SvB/cuIVrxTT5CGlt3Zk8=
Date: Tue, 18 Nov 2025 12:13:39 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/4] bpf: Add SHA hash kfuncs for cryptographic
 hashing
To: Daniel Hodges <git@danielhodges.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "open list:BPF [CRYPTO]"
 <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20251117211413.1394-1-git@danielhodges.dev>
 <20251117211413.1394-2-git@danielhodges.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251117211413.1394-2-git@danielhodges.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 17/11/2025 21:13, Daniel Hodges wrote:
> Add three new kfuncs for computing cryptographic hashes in BPF programs:
> - bpf_sha256_hash(): Computes SHA-256 hash (32-byte output)
> - bpf_sha384_hash(): Computes SHA-384 hash (48-byte output)
> - bpf_sha512_hash(): Computes SHA-512 hash (64-byte output)
> 
> These kfuncs leverage the kernel's existing crypto library (sha256/sha384/
> sha512 functions) and use bpf_dynptr for safe memory access without risk
> of page faults. The functions validate input parameters including checking
> for read-only output buffers and ensuring sufficient buffer sizes.
> 
> This enables BPF programs to compute cryptographic hashes for use cases
> such as content verification, integrity checking, and data authentication.
> 
> Signed-off-by: Daniel Hodges <git@danielhodges.dev>

[...]

> +#if IS_ENABLED(CONFIG_CRYPTO_LIB_SHA256)
> +/**
> + * bpf_sha256_hash() - Compute SHA-256 hash using kernel crypto library
> + * @data: bpf_dynptr to the input data to hash. Must be a trusted pointer.
> + * @out: bpf_dynptr to the output buffer (must be at least 32 bytes). Must be a trusted pointer.
> + *
> + * Computes SHA-256 hash of the input data. Uses bpf_dynptr to ensure safe memory access
> + * without risk of page faults.
> + */
> +__bpf_kfunc int bpf_sha256_hash(const struct bpf_dynptr *data, const struct bpf_dynptr *out)
> +{
> +	const struct bpf_dynptr_kern *data_kern = (struct bpf_dynptr_kern *)data;
> +	const struct bpf_dynptr_kern *out_kern = (struct bpf_dynptr_kern *)out;
> +	u32 data_len, out_len;
> +	const u8 *data_ptr;
> +	u8 *out_ptr;
> +
> +	if (__bpf_dynptr_is_rdonly(out_kern))
> +		return -EINVAL;

__bpf_dynptr_data_rw() contains __bpf_dynptr_is_rdonly() check, no need
to do it again explicitly. This applies to all helpers

> +
> +	data_len = __bpf_dynptr_size(data_kern);
> +	out_len = __bpf_dynptr_size(out_kern);
> +
> +	if (data_len == 0 || out_len < 32)
> +		return -EINVAL;
> +
> +	data_ptr = __bpf_dynptr_data(data_kern, data_len);
> +	if (!data_ptr)
> +		return -EINVAL;
> +
> +	out_ptr = __bpf_dynptr_data_rw(out_kern, out_len);
> +	if (!out_ptr)
> +		return -EINVAL;
> +
> +	sha256(data_ptr, data_len, out_ptr);
> +
> +	return 0;
> +}

