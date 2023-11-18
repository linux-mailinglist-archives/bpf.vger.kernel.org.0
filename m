Return-Path: <bpf+bounces-15321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B467F039C
	for <lists+bpf@lfdr.de>; Sun, 19 Nov 2023 00:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163641C208A8
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 23:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA136208B2;
	Sat, 18 Nov 2023 23:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eOunu6o9"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [IPv6:2001:41d0:203:375::b5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B711A1
	for <bpf@vger.kernel.org>; Sat, 18 Nov 2023 15:32:45 -0800 (PST)
Message-ID: <862c832a-da98-4bef-80ef-8294be1d4601@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700350363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NJq+8rInXFQz0lQ5RedVfwAKfNaq1CdVOdaBUu0zwDc=;
	b=eOunu6o9eh2HAOVwUzToUPbtngfYq9c7o0HHrg6B4Htko0qMJuZoS/1SkvWcZtrIPMvycF
	Csj3NAmyZpkZbvyZwk4nTk3dkxgIVXVYZ0/IRcG2SnTdWzR+mwb1LKhi6UcuD9jBqKK6IG
	7Xg9+CFaQ2eWPGj6xVdhGfcuQQvVrXA=
Date: Sat, 18 Nov 2023 23:32:39 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 1/2] bpf: add skcipher API support to TC/XDP
 programs
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Vadim Fedorenko <vadfed@meta.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Network Development <netdev@vger.kernel.org>,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>
References: <20231118225451.2132137-1-vadfed@meta.com>
 <CAADnVQLBE1ex-B=F07R0xQKo-r22M0L6eiS8DjOAtsur-hEbFQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAADnVQLBE1ex-B=F07R0xQKo-r22M0L6eiS8DjOAtsur-hEbFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 18/11/2023 18:23, Alexei Starovoitov wrote:
> On Sat, Nov 18, 2023 at 2:55 PM Vadim Fedorenko <vadfed@meta.com> wrote:
>>
>> +/**
>> + * struct bpf_crypto_lskcipher_ctx - refcounted BPF sync skcipher context structure
>> + * @tfm:       The pointer to crypto_sync_skcipher struct.
>> + * @rcu:       The RCU head used to free the crypto context with RCU safety.
>> + * @usage:     Object reference counter. When the refcount goes to 0, the
>> + *             memory is released back to the BPF allocator, which provides
>> + *             RCU safety.
>> + */
>> +struct bpf_crypto_lskcipher_ctx {
>> +       struct crypto_lskcipher *tfm;
>> +       struct rcu_head rcu;
>> +       refcount_t usage;
>> +};
>> +
>> +__bpf_kfunc_start_defs();
>> +
>> +/**
>> + * bpf_crypto_lskcipher_ctx_create() - Create a mutable BPF crypto context.
> 
> Let's drop 'lskcipher' from the kfunc names and ctx struct.
> bpf users don't need to know the internal implementation details.
> bpf_crypto_encrypt/decrypt() is clear enough.

The only reason I added it was the existence of AEAD subset of crypto 
API. And this subset can also be implemented in bpf later, and there 
will be inconsistency in naming then if we add aead in future names.
WDYT?

