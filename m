Return-Path: <bpf+bounces-73868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFAEC3C451
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 17:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10ECB3B51B9
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 16:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B5B2BE051;
	Thu,  6 Nov 2025 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfxTiQ/f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A831285CBC
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445017; cv=none; b=Z2kD2id5vrTNYU8C6IPcVgNp8UnaUmaRZI0h6yz7JfpZjPA1DqEgQaHK2+PHHy+JxmrjuNLC3gHQNhZ663Dsq2vvi9e+4AB3CREzQkiJhB/hLYL51oQtWfaS6gOaZZvwE/2p3P5XcWgKyl4g/fLj3GDHO5QOV6116QZ+LkJ7IK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445017; c=relaxed/simple;
	bh=jxxY/V7I7Lg0tRhN/zYFfE+zYQjh2/ExgpaOEMq413U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=liyjBCoQKahOidljVzvfnZafhLdR166gJ1FuLt12NjnphqPGHJEfQiGxbeHnaFi8ErUXHGPnjPIXRy1q2Fd8YzCIWQAJapQDPKhFYdcJDLLU+CIKCcdEd7/uuiF3OjKSSVJsKTIGqnDJjqg5qgob7swguQhnAXNBBh7wl/uHKIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfxTiQ/f; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477632d45c9so6671065e9.2
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 08:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762445013; x=1763049813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=98FNYdxWtgAVLrdCklXVrdgT9A4fZEk601wUNRIMCh8=;
        b=BfxTiQ/f3cVOsiIUlx4CF+6ilVeJ2CuValEHWO02W3ZLkjPWMbQ9iBBe+ckI3bqXjs
         Z8kOJBE+Ndfng2PCIXmCoxJHjBUn4bzdKpYxgiOJzBQ0KtvV4aPWUAYZgJTHTFk5gsC7
         /BAEIwSlgFkWoEXq+I79cwkKenJ3L6EJf67Shl1JZlWL0mK+R3O50pfcROdZRFnXn0Kg
         qtp/GdirLjdD6fshvUf1nvXm9rVtGrDe2pBu9PCWGqNcUsCCN6M8P4Sobhk8d2aN6r7n
         nm76gN9DdKm95qk5KNSZnEdgkOT6fBaB7xXjszD/dT5EKlxJKIsGxNFv24vmdOYMhS4f
         njhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445013; x=1763049813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=98FNYdxWtgAVLrdCklXVrdgT9A4fZEk601wUNRIMCh8=;
        b=GekG3nKNr+U7e9vLVw8xgwmg5ZOEtISgT6UyGMStkyt3lZBj4US0tHSDMtoyjE/all
         3turVzSf9E1Oe7QaAv5cWqQpVUY0PY/3Yq6zCr0uylbonJfPgygPJGS52+XU1VIu1sGA
         HmwtOBgPDw5QiXHLfgMDq8TXzd8IleHsynDWOO0UsaOVHittZg6Rrz8PcjYmrVx5TXmc
         yD070RunptKIm7hlppond/M6YrNhL1JyTVubLgFwAczvC4wrGwKECJBILjqLo27Yv2y3
         b5v/qoSHoT92RSpC4hiLgXMWKq7xlZyG5VimEBTg15YzglRUSccwIGfrvAZKxr30vdWQ
         RaGA==
X-Forwarded-Encrypted: i=1; AJvYcCX34FBixT/iyKjuhGcFuCgqGAVZbOG3xHDUIVJWDpE3PdEVrWaGGpVlNRMV3NV+GlPMdlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUrV+4AIiFFF1atdbIs1TDoSH9+RQV6ptxp81JalcQsXZaEjMC
	EWpVd17IjYYpbxLLdKCpnOJJa2Rwvs/sjdKxAto0EHdvHBbl0lIyA7MG
X-Gm-Gg: ASbGnctCMmOy9xWWWzY/3TQ1xjPjOjrdiLtfdCjDlFFXjYgGUmfPIsRqIoMQuZAtZkY
	bgbETMclDev36AKKkj0nGYAVedArG+uGWQTbqJH87w1zw4tZd+mnsuH4QFu/qx4jYfQDlnEVx/x
	kBXEr/g5La6ozr3Tt4xfpful4Gc0M69AEm0K73irKkjKS8RDecGxVIz+HokNTraCtQhyH75qYSQ
	PUQJRM14iVN/xoCCMdSUzmCf5jLzFRn4eG56FULduAHG2MlNzHvEA0FZZn9u+lWKx28o3VOHHn2
	v7/wXfPgi0Ml4l+/Kkgi+ORneFtPnB5u/Dg9229XpnCSPr+6Bsos2pBlIZrrH8v9C3XKVQrjpnr
	TlIKGNUKOGHnScQWJs+n5W8VzIV8s1e44lL5DIhxhvpKJx333S4jXVUTaTuD/4lBI6nye7yqy33
	vI4CuiD5AoVp9FWsbd30omvVepGYKCqxRFY1ClKNLpXQrM9GdYFauwAzFuvlP6hA==
X-Google-Smtp-Source: AGHT+IFWRP8y/NyM444Y+0D0rXNBaoSkXZwHl1OLah3ak5bm/B4pFr0rb2KO0zqaXzMOcIa5k7cjIA==
X-Received: by 2002:a05:600c:8216:b0:46e:432f:32ab with SMTP id 5b1f17b1804b1-4775ce20fe1mr60031375e9.33.1762445012535;
        Thu, 06 Nov 2025 08:03:32 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb4ad993sm5838542f8f.47.2025.11.06.08.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 08:03:31 -0800 (PST)
Message-ID: <58c0e697-2f6a-4b06-bf04-c011057cd6c7@gmail.com>
Date: Thu, 6 Nov 2025 16:03:29 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] io_uring: add IORING_OP_BPF for extending io_uring
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 Caleb Sander Mateos <csander@purestorage.com>,
 Akilesh Kailash <akailash@google.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>
References: <20251104162123.1086035-1-ming.lei@redhat.com>
 <891f4413-9556-4f0d-87e2-6b452b08a83f@gmail.com> <aQtz-dw7t7jtqALc@fedora>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aQtz-dw7t7jtqALc@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/25 15:57, Ming Lei wrote:
> On Wed, Nov 05, 2025 at 12:47:58PM +0000, Pavel Begunkov wrote:
>> On 11/4/25 16:21, Ming Lei wrote:
>>> Hello,
>>>
>>> Add IORING_OP_BPF for extending io_uring operations, follows typical cases:
>>
>> BPF requests were tried long time ago and it wasn't great. Performance
> 
> Care to share the link so I can learn from the lesson? Maybe things have
> changed now...

https://lore.kernel.org/io-uring/a83f147b-ea9d-e693-a2e9-c6ce16659749@gmail.com/T/#m31d0a2ac6e2213f912a200f5e8d88bd74f81406b

There were some extra features and testing from folks, but I don't
think it was ever posted to the list.

>> for short BPF programs is not great because of io_uring request handling
>> overhead. And flexibility was severely lacking, so even simple use cases
> 
> What is the overhead? In this patch, OP's prep() and issue() are defined in

The overhead of creating, freeing and executing a request. If you use
it with links, it's also overhead of that. That prototype could also
optionally wait for completions, and it wasn't free either.

> bpf prog, but in typical use case, the code size is pretty small, and bpf
> prog code is supposed to run in fast path.> 
>> were looking pretty ugly, internally, and for BPF writers as well.
> 
> I am not sure what `simple use cases` you are talking about.

As an example, creating a loop reading a file:
read N bytes; wait for completion; repeat

>> I'm not so sure about your criteria, but my requirement was to at least
>> being able to reuse all io_uring IO handling, i.e. submitting requests,
>> and to wait/process completions, otherwise a lot of opportunities are
>> wasted. My approach from a few months back [1] controlling requests from
> 
> Please read the patchset.
> 
> This patchset defines new IORING_BPF_OP code, which's ->prep(), ->issue(), ...,
> are hooked with struct_ops prog, so all io_uring core code is used, just the
> exact IORING_BPF_OP behavior is defined by struct_ops prog.

Right, but I'm talking about what the io_uring BPF program is capable
of doing.

>> the outside was looking much better. At least it covered a bunch of needs
>> without extra changes. I was just wiring up io_uring changes I wanted
>> to make BPF writer lifes easier. Let me resend the bpf series with it.
>>
>> It makes me wonder if they are complementary, but I'm not sure what
> 
> I think the two are orthogonal in function, and they can co-exist.
> 
>> your use cases are and what capabilities it might need.
> 
> The main use cases are described in cover letter and the 3rd patch, please
> find the details there.
> 
> So far the main case is to access the registered (kernel)buffer
> from issue() callback of struct_ops, because the buffer doesn't have
> userspace mapping. The last two patches adds support to provide two
> buffers(fixed, plain) for IORING_BPF_OP, and in future vectored buffer
> will be added too, so IORING_BPF_OP can handle buffer flexibly, such as:
> 
> - use exported compress kfunc to compress data from kernel buffer
> into another buffer or inplace, then the following linked SQE can be submitted
> to write the built compressed data into storage
> 
> - in raid use case, calculate IO data parity from kernel buffer, and store
> the parity data to another plain user buffer, then the following linked SQE
> can be submitted to write the built parity data to storage
> 
> Even for userspace buffer, the BPF_OP can support similar handling for saving
> one extra io_uring_enter() syscall.

Sure, registered buffer handling was one of the use cases for
that recent re-itarations as well, and David Wei had some thoughts
for it as well. Though, it was not exactly about copying.

>> [1] https://lore.kernel.org/io-uring/cover.1749214572.git.asml.silence@gmail.com/
> 
> I looked at your patches, in which SQE is generated in bpf prog(kernel),

Quick note: userspace and BPF are both allowed to submit
requests / generate SQEs.

> and it can't be used in my case.
Hmm, how so? Let's say ublk registers a buffer and posts a
completion. Then BPF runs, it sees the completion and does the
necessary processing, probably using some kfuncs like the ones
you introduced. After it can optionally queue up requests
writing it to the storage or anything else.

The reason I'm asking is because it's supposed to be able to
do anything the userspace can already achieve (and more). So,
if it can't be used for this use cases, there should be some
problem in my design.

-- 
Pavel Begunkov


