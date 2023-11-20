Return-Path: <bpf+bounces-15335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B80C7F0A01
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 01:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406961C20357
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 00:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EFE1396;
	Mon, 20 Nov 2023 00:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="al54fd/q"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDE9129
	for <bpf@vger.kernel.org>; Sun, 19 Nov 2023 16:22:45 -0800 (PST)
Message-ID: <c1e3db50-50bd-d728-a911-58fa1c77506a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700439764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=plyfbjXCWPnLRRVdcMszQ9r3Y0Q33cJPIt1nNRxE4Ls=;
	b=al54fd/qCsTxCLPQRo+bjKkW3wAmdH5oKZm4BBzBjNO+Bifq88D/CveqESwo9NuXSjruTo
	L4B2svHvcFPSPq+PwQa0pp/zxwhcMLNUQQRUcZqEIyYCJmIFb6H61LLbdhJwtl5x7ATUXW
	aD3rflQV4wt9gCRaHtCowzfgEUmw7l0=
Date: Mon, 20 Nov 2023 00:22:41 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 1/2] bpf: add skcipher API support to TC/XDP
 programs
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Vadim Fedorenko <vadfed@meta.com>, Jakub Kicinski <kuba@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko
 <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Network Development <netdev@vger.kernel.org>,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>
References: <20231118225451.2132137-1-vadfed@meta.com>
 <CAADnVQLBE1ex-B=F07R0xQKo-r22M0L6eiS8DjOAtsur-hEbFQ@mail.gmail.com>
 <862c832a-da98-4bef-80ef-8294be1d4601@linux.dev>
 <CAADnVQJ7__C06a=v0RfMvGQ_ohT21n=-1EUuaxqBe3aYU1izEg@mail.gmail.com>
 <312531ec-aba5-4050-b236-dc9b456c7280@linux.dev>
 <CAADnVQLKsOs7LSFWGbAtJ8WfZjnQ0B_7gwFA-ZMdLPmukMGZ1A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAADnVQLKsOs7LSFWGbAtJ8WfZjnQ0B_7gwFA-ZMdLPmukMGZ1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 19.11.2023 16:56, Alexei Starovoitov wrote:
> On Sat, Nov 18, 2023 at 3:46 PM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
>>
>> On 18/11/2023 18:35, Alexei Starovoitov wrote:
>>> On Sat, Nov 18, 2023 at 3:32 PM Vadim Fedorenko
>>> <vadim.fedorenko@linux.dev> wrote:
>>>>
>>>> On 18/11/2023 18:23, Alexei Starovoitov wrote:
>>>>> On Sat, Nov 18, 2023 at 2:55 PM Vadim Fedorenko <vadfed@meta.com> wrote:
>>>>>>
>>>>>> +/**
>>>>>> + * struct bpf_crypto_lskcipher_ctx - refcounted BPF sync skcipher context structure
>>>>>> + * @tfm:       The pointer to crypto_sync_skcipher struct.
>>>>>> + * @rcu:       The RCU head used to free the crypto context with RCU safety.
>>>>>> + * @usage:     Object reference counter. When the refcount goes to 0, the
>>>>>> + *             memory is released back to the BPF allocator, which provides
>>>>>> + *             RCU safety.
>>>>>> + */
>>>>>> +struct bpf_crypto_lskcipher_ctx {
>>>>>> +       struct crypto_lskcipher *tfm;
>>>>>> +       struct rcu_head rcu;
>>>>>> +       refcount_t usage;
>>>>>> +};
>>>>>> +
>>>>>> +__bpf_kfunc_start_defs();
>>>>>> +
>>>>>> +/**
>>>>>> + * bpf_crypto_lskcipher_ctx_create() - Create a mutable BPF crypto context.
>>>>>
>>>>> Let's drop 'lskcipher' from the kfunc names and ctx struct.
>>>>> bpf users don't need to know the internal implementation details.
>>>>> bpf_crypto_encrypt/decrypt() is clear enough.
>>>>
>>>> The only reason I added it was the existence of AEAD subset of crypto
>>>> API. And this subset can also be implemented in bpf later, and there
>>>> will be inconsistency in naming then if we add aead in future names.
>>>> WDYT?
>>>
>>> You mean future async apis ? Just bpf_crypto_encrypt_async() ?
>>
>> Well, not only async. It's about Authenticated Encryption With
>> Associated Data (AEAD) Cipher API defined in crypto/aead.h. It's
>> ciphers with additional hmac function, like
>> 'authenc(hmac(sha256),cbc(aes))'. It has very similar API with only
>> difference of having Authenticated data in the encrypted block.
> 
> and ? I'm not following what you're trying to say.
> Where is the inconsistency ?
> My point again is that lskcipher vs skcipher vs foo is an implementation
> detail that shouldn't be exposed in the name.

Well, I was trying to follow crypto subsystem naming. It might be easier for
users to understand what part of crypto API is supported by BPF kfuncs.

At the same we can agree that current implementation will be used for simple
buffer encryption/decryption and any further implementations will have additions 
in the name of functions (like 
bpf_crypto_aead_crypt/bpf_crypto_shash_final/bpf_crypto_scomp_compress).
It will be slightly inconsistent, but we will have to expose some implementation
details unfortunately. If you are ok with this way, I'm ok to implement it.

