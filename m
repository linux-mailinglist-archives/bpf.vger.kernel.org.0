Return-Path: <bpf+bounces-78011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B49F3CFB2DA
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 22:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 064E93026AC2
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 21:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4842D77FF;
	Tue,  6 Jan 2026 21:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jNrA9/Yd"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4462D46A2
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 21:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767736632; cv=none; b=VDJY1zLWYR1TK3ouIVl/XBL7MuNfFAGSPjeKrkHZ4hPfXQ7fExpXeTvvK0Gf52PMzgz2v7lhDpsGkOuvO3zadZzSOyNNxOQyG7JPzcdc5nroyJWaYaqokOr1hRH37eznotSTJ10dukvGipi3dCQHVprdPpaWrRq5axC6e7FJF4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767736632; c=relaxed/simple;
	bh=5Kx8sPVkdEgFHyq5JH6CyK6VfnW7WDelVG/DbvY6yFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+KeGdu+hVRcaIEuFkcyrQ4aTusbmpQO5wvQbZFo0b1mvss5MOcdN2nYaZRtZ8BA0ZcGEYjVqsc9gqX/1Yd0MQcQY3f/vivnihlXbq0JX+PLk9j5MbkW2lp7/7nsaSYNMVQICJfgOunnD9J9KFVc4fEBwQuwNuhrOfxcF53vntE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jNrA9/Yd; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7a780c0a-a710-43d3-8d73-7bbb19090b30@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767736628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7V+XpFQT1OKE/UKASlM2bEpZoG7m8XWGtFpX5+YX3yw=;
	b=jNrA9/Yd+I6JnLyWbWCN9jWP3nBdgYcSL6jc50X12TUQwSfoZXH/VHl5kx1GSVj6QXnr26
	6UMsOg8ZW8aAbOAw7CXaun0XLVoEj+EH4nUoxtQdAT5tsv83gPRirklq4oSyt5Vqv1Ou1b
	Klg3lbjx1A304IrpMPAOmzrhNFG96FU=
Date: Tue, 6 Jan 2026 21:57:05 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/6] crypto: Add BPF hash algorithm type
 registration module
To: Daniel Hodges <git@danielhodges.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Mykyta Yatsenko <yatsenko@meta.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Yonghong Song
 <yonghong.song@linux.dev>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260105173755.22515-1-git@danielhodges.dev>
 <20260105173755.22515-2-git@danielhodges.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260105173755.22515-2-git@danielhodges.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05/01/2026 17:37, Daniel Hodges wrote:
> Add bpf_crypto_shash module that registers a hash type with the BPF
> crypto infrastructure, enabling BPF programs to access kernel hash
> algorithms through a unified interface.
> 
> Update the bpf_crypto_type interface with hash-specific callbacks:
>     - alloc_tfm: Allocates crypto_shash context with proper descriptor size
>     - free_tfm: Releases hash transform and context memory
>     - has_algo: Checks algorithm availability via crypto_has_shash()
>     - hash: Performs single-shot hashing via crypto_shash_digest()
>     - digestsize: Returns the output size for the hash algorithm
>     - get_flags: Exposes transform flags to BPF programs
> 
> Update bpf_shash_ctx to contain crypto_shash transform and shash_desc
> descriptor to accommodate algorithm-specific descriptor requirements.
> 
> Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> ---
>   MAINTAINERS               |  1 +
>   crypto/Makefile           |  3 ++
>   crypto/bpf_crypto_shash.c | 95 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 99 insertions(+)
>   create mode 100644 crypto/bpf_crypto_shash.c

[...]

> +static const struct bpf_crypto_type bpf_crypto_shash_type = {
> +	.alloc_tfm	= bpf_crypto_shash_alloc_tfm,
> +	.free_tfm	= bpf_crypto_shash_free_tfm,
> +	.has_algo	= bpf_crypto_shash_has_algo,
> +	.hash		= bpf_crypto_shash_hash,

I don't see a definition of hash() callback in struct bpf_crypto_type

> +	.digestsize	= bpf_crypto_shash_digestsize,
> +	.get_flags	= bpf_crypto_shash_get_flags,
> +	.owner		= THIS_MODULE,
> +	.name		= "hash",
> +};

