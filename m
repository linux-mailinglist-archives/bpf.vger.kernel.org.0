Return-Path: <bpf+bounces-22379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BCF85D044
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 07:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7E91F243F5
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 06:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032DE39FE8;
	Wed, 21 Feb 2024 06:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xjl6EOBf"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC1739FCC
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 06:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708495960; cv=none; b=gm+GJxhmi81noxZNdhc3TXUIJKlwdK+ecTcT/G0Pbk4Si3oakJZL2V2QPA7uzrUNPt4GXJhm5CsoPtLLa+Ppy8p3nGQcM4MHiepL5hbHM2yH/16bC6JS/9oyD5rehc1r4vBfD0oND35GmpBulMJiUVB1u9/h/GWErF+raEzm0wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708495960; c=relaxed/simple;
	bh=LmiO0+KsUbduHRiEIEV11DpTdlk5gEPbETd8ZHml1+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a5frknp1L5hGbj91fjP5PO5ckuPQztMPBNOzBSv+onJDxaiaKX2CC9mKltKbNJDSuJk1F8RW5XJ9i74GLWCZZolb0C1wTvt0yQnQ0xldcjn8pBAwvVzf0AJHGC/oBljb8qUKnTR9Bz+BOI3FLNE2dL5XdQYYYGlHPsVYDIzRLig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xjl6EOBf; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <00a55f84-d6ad-480e-9479-d38f454c067b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708495956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aopWvGCT6qzYBcdNBKZ4Rm93b6emQJ3NOd8ujYyL8Ew=;
	b=xjl6EOBfuTO+w3vZYLKCH8cxmVj2BFW6xTL9BMUAeMdXUYdqDIrcNn3jLksVk3jyWu5ScY
	dl191T9kzQmU3RI9dxo535ISlSwL81CMnCkCluYoT/mFnhJ/8PL9PwjCxBe8X5b8cysZau
	bRAmcOKXnrR4pHQSwHjh6umC7GADPUk=
Date: Tue, 20 Feb 2024 22:12:27 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] libbpf: clarify batch lookup semantics
Content-Language: en-GB
To: Martin Kelly <martin.kelly@crowdstrike.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
References: <20240221010057.1061333-1-martin.kelly@crowdstrike.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240221010057.1061333-1-martin.kelly@crowdstrike.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/20/24 5:00 PM, Martin Kelly wrote:
> The batch lookup APIs copy key memory into out_batch, which is then

The above 'key memory' is not precise. The 'in_batch' and 'out_batch'
intends to be opaque and its size is map specific. So maybe we could
reword the description like below:

The batch lookup and lookup_and_delete APIs have two parameters,
in_batch and out_batch, to facilitate iterative lookup/lookup_and_deletion
operations for supported maps. Except NULL for in_batch at the start
of these two batch operations, both parameters need to point to memory
equal or larger than the respective map size, except for various hashmaps
(hash, percpu_hash, lru_hash, lru_percpu_hash) where the in_batch/out_batch
memory size should be at least 4 bytes.

Please also change your patch subject to
   [PATCH bpf-next] bpf: Clarify batch lookup/lookup_and_delete semantics

> supplied in later calls to in_batch. Thus both parameters need to point
> to memory large enough to hold a single key (other than an initial NULL
> in_batch). For many maps, keys are pointer sized or less, but for larger
> maps, it's important to point to a larger block of memory to avoid
> memory corruption.
>
> Document these semantics to clarify the API.
>
> Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
> ---
>   include/uapi/linux/bpf.h |  5 ++++-
>   tools/lib/bpf/bpf.h      | 15 ++++++++++-----
>   2 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index d96708380e52..dae613b8778a 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -617,7 +617,10 @@ union bpf_iter_link_info {
>    *		to NULL to begin the batched operation. After each subsequent
>    *		**BPF_MAP_LOOKUP_BATCH**, the caller should pass the resultant
>    *		*out_batch* as the *in_batch* for the next operation to
> - *		continue iteration from the current point.
> + *		continue iteration from the current point. Both *in_batch* and
> + *		*out_batch* must point to memory large enough to hold a key,
> + *		except for maps of type **BPF_MAP_TYPE_HASH**, for which batch

Not just BPF_MAP_TYPE_HASH. It should be
BPF_MAP_TYPE_{HASH, PERCPU_HASH, LRU_HASH, LRU_PERCPU_HASH}.
Similar for some changes below.

> + *		parameters must be at least 4 bytes wide regardless of key size.
>    *
>    *		The *keys* and *values* are output parameters which must point
>    *		to memory large enough to hold *count* items based on the key

Please also sync updated include/uapi/linux/bpf.h to tools/include/uapi/linux/bpf.h.

> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index ab2570d28aec..c7e918ab0a60 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -190,10 +190,13 @@ LIBBPF_API int bpf_map_delete_batch(int fd, const void *keys,
>   /**
>    * @brief **bpf_map_lookup_batch()** allows for batch lookup of BPF map elements.
>    *
> - * The parameter *in_batch* is the address of the first element in the batch to read.
> - * *out_batch* is an output parameter that should be passed as *in_batch* to subsequent
> - * calls to **bpf_map_lookup_batch()**. NULL can be passed for *in_batch* to indicate
> - * that the batched lookup starts from the beginning of the map.
> + * The parameter *in_batch* is the address of the first element in the batch to
> + * read. *out_batch* is an output parameter that should be passed as *in_batch*
> + * to subsequent calls to **bpf_map_lookup_batch()**. NULL can be passed for
> + * *in_batch* to indicate that the batched lookup starts from the beginning of
> + * the map. Both *in_batch* and *out_batch* must point to memory large enough to
> + * hold a single key, except for maps of type **BPF_MAP_TYPE_HASH**, for which
> + * the memory pointed to must be at least 4 bytes wide regardless of key size.
>    *
>    * The *keys* and *values* are output parameters which must point to memory large enough to
>    * hold *count* items based on the key and value size of the map *map_fd*. The *keys*
> @@ -226,7 +229,9 @@ LIBBPF_API int bpf_map_lookup_batch(int fd, void *in_batch, void *out_batch,
>    *
>    * @param fd BPF map file descriptor
>    * @param in_batch address of the first element in batch to read, can pass NULL to
> - * get address of the first element in *out_batch*
> + * get address of the first element in *out_batch*. If not NULL, must be large
> + * enough to hold a key. For **BPF_MAP_TYPE_HASH**, must be large enough to hold
> + * 4 bytes.
>    * @param out_batch output parameter that should be passed to next call as *in_batch*
>    * @param keys pointer to an array of *count* keys
>    * @param values pointer to an array large enough for *count* values

