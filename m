Return-Path: <bpf+bounces-15388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993077F1BFC
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 19:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7001C2113D
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 18:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D112630350;
	Mon, 20 Nov 2023 18:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q0MX+guX"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DA493
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 10:09:05 -0800 (PST)
Message-ID: <87f5aa88-c2f2-4fce-95f9-39b04b2950de@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700503741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WuFo4Me8efhhswGKB4Vga4SYeHZboEX/eRXFfU3FvpA=;
	b=Q0MX+guXc/q7Hw5xZgQo7sruoUAQd+cESI+PNlUCmq2S66iTZSeyWZLeHcxQINpg2lsiwu
	m+7FynVsmY9l6TM3RXIfvXFV32RtGHw++XijEQWeb43bclMWCcvCAQhCjtTEkSBxqtPy88
	WEJwjC3wSrmqHqqssiHApELq3hIb75w=
Date: Mon, 20 Nov 2023 18:08:59 +0000
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
 <c1e3db50-50bd-d728-a911-58fa1c77506a@linux.dev>
 <CAADnVQJvfdPh7YXj30vsqkUF7a9M5SCaAkaB9qkmndS892Fu+w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAADnVQJvfdPh7YXj30vsqkUF7a9M5SCaAkaB9qkmndS892Fu+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 20/11/2023 20:13, Alexei Starovoitov wrote:
> On Sun, Nov 19, 2023 at 4:22 PM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
>>
>> On 19.11.2023 16:56, Alexei Starovoitov wrote:
>>> On Sat, Nov 18, 2023 at 3:46 PM Vadim Fedorenko
>>> <vadim.fedorenko@linux.dev> wrote:
>>>>
>>>> On 18/11/2023 18:35, Alexei Starovoitov wrote:
>>>>> On Sat, Nov 18, 2023 at 3:32 PM Vadim Fedorenko
>>>>> <vadim.fedorenko@linux.dev> wrote:
>>>>>>
>>>>>> On 18/11/2023 18:23, Alexei Starovoitov wrote:
>>>>>>> On Sat, Nov 18, 2023 at 2:55 PM Vadim Fedorenko <vadfed@meta.com> wrote:
>>>>>>>>
>>>>>>>> +/**
>>>>>>>> + * struct bpf_crypto_lskcipher_ctx - refcounted BPF sync skcipher context structure
>>>>>>>> + * @tfm:       The pointer to crypto_sync_skcipher struct.
>>>>>>>> + * @rcu:       The RCU head used to free the crypto context with RCU safety.
>>>>>>>> + * @usage:     Object reference counter. When the refcount goes to 0, the
>>>>>>>> + *             memory is released back to the BPF allocator, which provides
>>>>>>>> + *             RCU safety.
>>>>>>>> + */
>>>>>>>> +struct bpf_crypto_lskcipher_ctx {
>>>>>>>> +       struct crypto_lskcipher *tfm;
>>>>>>>> +       struct rcu_head rcu;
>>>>>>>> +       refcount_t usage;
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +__bpf_kfunc_start_defs();
>>>>>>>> +
>>>>>>>> +/**
>>>>>>>> + * bpf_crypto_lskcipher_ctx_create() - Create a mutable BPF crypto context.
>>>>>>>
>>>>>>> Let's drop 'lskcipher' from the kfunc names and ctx struct.
>>>>>>> bpf users don't need to know the internal implementation details.
>>>>>>> bpf_crypto_encrypt/decrypt() is clear enough.
>>>>>>
>>>>>> The only reason I added it was the existence of AEAD subset of crypto
>>>>>> API. And this subset can also be implemented in bpf later, and there
>>>>>> will be inconsistency in naming then if we add aead in future names.
>>>>>> WDYT?
>>>>>
>>>>> You mean future async apis ? Just bpf_crypto_encrypt_async() ?
>>>>
>>>> Well, not only async. It's about Authenticated Encryption With
>>>> Associated Data (AEAD) Cipher API defined in crypto/aead.h. It's
>>>> ciphers with additional hmac function, like
>>>> 'authenc(hmac(sha256),cbc(aes))'. It has very similar API with only
>>>> difference of having Authenticated data in the encrypted block.
>>>
>>> and ? I'm not following what you're trying to say.
>>> Where is the inconsistency ?
>>> My point again is that lskcipher vs skcipher vs foo is an implementation
>>> detail that shouldn't be exposed in the name.
>>
>> Well, I was trying to follow crypto subsystem naming. It might be easier for
>> users to understand what part of crypto API is supported by BPF kfuncs.
>>
>> At the same we can agree that current implementation will be used for simple
>> buffer encryption/decryption and any further implementations will have additions
>> in the name of functions (like
>> bpf_crypto_aead_crypt/bpf_crypto_shash_final/bpf_crypto_scomp_compress).
>> It will be slightly inconsistent, but we will have to expose some implementation
>> details unfortunately. If you are ok with this way, I'm ok to implement it.
> 
> but shash vs scomp is the name of the algo ? Didn't you use it as
> the 1st arg to bpf_crypto_create() ?
> Take a look at AF_ALG. It's able to express all kinds of cryptos
> through the same socket abstraction without creating a new name for
> every algo. Everything is read/write through the socket fd.
> In our case it will be bpf_crypto_encrypt/decrypt() kfuncs.

Ok, I got the idea. I'll make v6 more general, like AF_ALG, but it will
support only one type (skcipher) for now. Thanks!


