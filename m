Return-Path: <bpf+bounces-27483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3CC8AD6B9
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 23:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9BD6B21782
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 21:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3DC1CF8B;
	Mon, 22 Apr 2024 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iNvJhfzS"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05FA1BC44
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 21:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713822139; cv=none; b=d7sa74EQB+aG643U6Z8FxhkxAs6GIHr8Veuq1Z1lJFepMIh18B+3IIerbfBEkYTfnj7D0xhkEZp8PLVywOUhWJM44XX1vk0HfmoeLyiX4iXg6j0wq9ZbdOUhDzQoH2WVmlXDnPAluIK+dsMzyU+SV9gq2v9y3ojjI7RF5qKUYwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713822139; c=relaxed/simple;
	bh=4hA5sBeUci6cwYvvfoMdxfwPxqjWRzzNuWkrAp4FGEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQ3jAMvPOZFdDSATjzz3G2RmWr0dc1s0iLT500KMT5hT1SxnogjKh68kNhgxaasyb76JbDyZCXc+PuzkMZ1OiCTkZUjNBE5yk28ls68uwxJ0z4+VpI8HVr2GZ5vsjlBmFMnYZJab8IFlHmzHMFBaof1FcsyUmCGVQOQMh4YtUeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iNvJhfzS; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1a9240ba-7279-405d-be37-2cdacb518579@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713822136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B1jpWzTuiZI+ImKer+LozaEgfhA2ALBaIlWPA+Onbjc=;
	b=iNvJhfzSEGGGCd4ihcbSBtRsPtJtjk27hxQ4mm6gABgsUJt4mXpFYnSc+lZAGamICZYeZd
	BwiWJ+xh05eO37FO2jc7puSgxeeDfcOp5/mCY1yV2vi9YDrAoII0ohzCYQpG/EHY59vEYE
	w3omx/TdHHj/2aR0VXA+3csiMK/AZjI=
Date: Mon, 22 Apr 2024 14:42:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 1/4] bpf: make common crypto API for TC/XDP
 programs
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Vadim Fedorenko <vadfed@meta.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
 linux-crypto@vger.kernel.org, bpf@vger.kernel.org
References: <20240416204004.3942393-1-vadfed@meta.com>
 <20240416204004.3942393-2-vadfed@meta.com>
 <adf36f26-76b7-4c57-8caf-82f4bb98f017@linux.dev>
 <89a92b51-fbfe-4eab-840c-c27174b7f3a1@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <89a92b51-fbfe-4eab-840c-c27174b7f3a1@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/19/24 5:24 PM, Vadim Fedorenko wrote:
>>> +/**
>>> + * bpf_crypto_ctx_create() - Create a mutable BPF crypto context.
>>> + *
>>> + * Allocates a crypto context that can be used, acquired, and released by
>>> + * a BPF program. The crypto context returned by this function must either
>>> + * be embedded in a map as a kptr, or freed with bpf_crypto_ctx_release().
>>> + * As crypto API functions use GFP_KERNEL allocations, this function can
>>> + * only be used in sleepable BPF programs.
>>> + *
>>> + * bpf_crypto_ctx_create() allocates memory for crypto context.
>>> + * It may return NULL if no memory is available.
>>> + * @params: pointer to struct bpf_crypto_params which contains all the
>>> + *          details needed to initialise crypto context.
>>> + * @err:    integer to store error code when NULL is returned.
>>> + */
>>> +__bpf_kfunc struct bpf_crypto_ctx *
>>> +bpf_crypto_ctx_create(const struct bpf_crypto_params *params, int *err)
>>
>> Add a "u32 params__sz" arg in case that the params struct will have addition.
>> Take a look at how opts__sz is checked in nf_conntrack_bpf.c.
>>
> 
> nf_conntrack uses hard-coded value, while xfrm code uses
> sizeof(struct bpf_xfrm_state_opts), which one is better?

If it is about the enum NF_BPF_CT_OPTS_SZ in nf_conntrack, I don't think it is a 
must have. bpf_core_type_size() should have the same effect to figure out the 
sizeof a struct in the running kernel.

afaik, sizeof() should do.

