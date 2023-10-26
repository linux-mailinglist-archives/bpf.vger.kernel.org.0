Return-Path: <bpf+bounces-13379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36E57D8C37
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 01:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8271C21025
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 23:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AAA3FE34;
	Thu, 26 Oct 2023 23:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OqFKwPbv"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A463FB21
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 23:29:35 +0000 (UTC)
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87184194
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 16:29:33 -0700 (PDT)
Message-ID: <a10cdab4-ab67-1cd2-0827-52c3755a464f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698362971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/vD4m///Wah32XHL20WV/cRw7R5yf/dyW/xE90Gxa08=;
	b=OqFKwPbv10VTup2IIqvHcPc3hNELxPtynDKMYW3gEna5ZQ7hQwAMMvftehhfSgUjxDpCzn
	3wyg2ZjHnMkncfmEUGYjLnfp5tstlMG439f8dq/P4nfL1jqe2XOEHFDRZd1nfYyf6grO16
	EYy6MkAYZ5B3KQFCnt/ZmTBzlyEdVpw=
Date: Fri, 27 Oct 2023 00:29:29 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: add skcipher API support to TC/XDP
 programs
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Vadim Fedorenko <vadfed@meta.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20231026015938.276743-1-vadfed@meta.com>
 <20231026144759.5ce20f4c@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20231026144759.5ce20f4c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 26.10.2023 22:47, Jakub Kicinski wrote:
> On Wed, 25 Oct 2023 18:59:37 -0700 Vadim Fedorenko wrote:
>> Add crypto API support to BPF to be able to decrypt or encrypt packets
>> in TC/XDP BPF programs. Only symmetric key ciphers are supported for
>> now. Special care should be taken for initialization part of crypto algo
>> because crypto_alloc_sync_skcipher() doesn't work with preemtion
>> disabled, it can be run only in sleepable BPF program. Also async crypto
>> is not supported because of the very same issue - TC/XDP BPF programs
>> are not sleepable.
> 
> Do CC crypto@ for the next version, please.

Sure

>> +/**
>> + * struct bpf_crypto_skcipher_ctx - refcounted BPF sync skcipher context structure
>> + * @tfm:	The pointer to crypto_sync_skcipher struct.
>> + * @rcu:	The RCU head used to free the crypto context with RCU safety.
>> + * @usage:	Object reference counter. When the refcount goes to 0, the
>> + *		memory is released back to the BPF allocator, which provides
>> + *		RCU safety.
>> + */
>> +
> 
> spurious newline?

yeah, will fix it

>> +struct bpf_crypto_skcipher_ctx {
> 
>> +/**
>> + * bpf_crypto_skcipher_ctx_acquire() - Acquire a reference to a BPF crypto context.
> 
> The contexts are refcounted and can be placed in maps?

Yes, the idea was to avoid allocation of algo object and setting the key on hot
path. And for now there is no way to allocate crypto cipher object in TC/XDP
hook because it uses GFP_KERNEL and delayed module load.

> Does anything prevent them from being used simultaneously
> by difference CPUs?

The algorithm configuration and the key can be used by different CPUs
simultaneously

>> +	case BPF_DYNPTR_TYPE_SKB:
>> +		return skb_pointer_if_linear(ptr->data, ptr->offset, __bpf_dynptr_size(ptr));
> 
> dynptr takes care of checking if skb can be written to?

dynptr is used to take care of size checking, but this particular part is used
to provide plain buffer from skb. I'm really sure if we can (or should) encrypt
or decrypt in-place, so API now assumes that src and dst are different buffers.



