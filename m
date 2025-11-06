Return-Path: <bpf+bounces-73903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80571C3D42B
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 20:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3373B1DBC
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 19:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9527933EB06;
	Thu,  6 Nov 2025 19:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h3B2N+bb"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AED86353;
	Thu,  6 Nov 2025 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762457887; cv=none; b=uQY39TdHngM7rEryXP1r5sdUqCOv4MxsFyqSUoxiYONBJTVxfQzoc4vTydv3KNQ2ubrndSIyCIwU3WSIIHF2TYEY5JSgRc3ZrMseXPyaLW2Ta/P1WULVeTUopGp99RtdY1zgpoFJ36+nBVC5pa4LErzrn67wV7w3OswbfSIJbOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762457887; c=relaxed/simple;
	bh=fTFawpEBeEN3E9Du3yS1QFmBq2zY+nhNn+xIkBFqb9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WRlVb2iSN1vf7UEVQpSoCXmKVs41NA1ZxQTCtyRSS1iKoTvNskFv48Qm65JFJNo6BAnv8pDsMerzfU5Y2U9mTkFu3dBjDqzrDGkdEZGKBWOa5lizLe46zSRdTYPxHpwM6LUBmWDdfkDy0kL0X4PYor3qWWxFYAGjNiDf8X8F8bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h3B2N+bb; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <84012d65-e0aa-462f-b62d-14f6ea07e1df@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762457881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P38CHcD31kemSCFmdZiM5BrR5IcpHLHc8tmuVNEmfCI=;
	b=h3B2N+bbrpsmG8AK8DBKAOhi7v8g8QfNgInkNyCGaSLjYmMNBJ1Z4flfc/xXdcazd6VHLG
	IE+njKfrSRsjWWgQr1tnPO6d+F/ns1WRLkSN0r2LTfRs5j/drchjY6hvtwXc4LoxM3oavf
	n/ru66Sqi8fC/sdWCRkgMXYHKtIH2sg=
Date: Thu, 6 Nov 2025 11:37:52 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 3/7] bpf: Pin associated struct_ops when
 registering async callback
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org,
 kernel-team@meta.com, bpf@vger.kernel.org
References: <20251104172652.1746988-1-ameryhung@gmail.com>
 <20251104172652.1746988-4-ameryhung@gmail.com>
 <0a3c4937-e4fd-49b6-a48c-88a4aa83e8a1@linux.dev>
 <CAMB2axPayfZOZnGK83eWxYTg9k0uno_y87_0ePE_FD6V+4tnfA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAMB2axPayfZOZnGK83eWxYTg9k0uno_y87_0ePE_FD6V+4tnfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 11/6/25 9:57 AM, Amery Hung wrote:
> On Wed, Nov 5, 2025 at 6:13 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 11/4/25 9:26 AM, Amery Hung wrote:
>>> Take a refcount of the associated struct_ops map to prevent the map from
>>> being freed when an async callback scheduled from a struct_ops program
>>> runs.
>>>
>>> Since struct_ops programs do not take refcounts on the struct_ops map,
>>> it is possible for a struct_ops map to be freed when an async callback
>>> scheduled from it runs. To prevent this, take a refcount on prog->aux->
>>> st_ops_assoc and save it in a newly created struct bpf_async_res for
>>> every async mechanism. The reference needs to be preserved in
>>> bpf_async_res since prog->aux->st_ops_assoc can be poisoned anytime
>>> and reference leak could happen.
>>>
>>> bpf_async_res will contain a async callback's BPF program and resources
>>> related to the BPF program. The resources will be acquired when
>>> registering a callback and released when cancelled or when the map
>>> associated with the callback is freed.
>>>
>>> Also rename drop_prog_refcnt to bpf_async_cb_reset to better reflect
>>> what it now does.
>>>
>>
>> [ ... ]
>>
>>> +static int bpf_async_res_get(struct bpf_async_res *res, struct bpf_prog *prog)
>>> +{
>>> +     struct bpf_map *st_ops_assoc = NULL;
>>> +     int err;
>>> +
>>> +     prog = bpf_prog_inc_not_zero(prog);
>>> +     if (IS_ERR(prog))
>>> +             return PTR_ERR(prog);
>>> +
>>> +     st_ops_assoc = READ_ONCE(prog->aux->st_ops_assoc);
>>> +     if (prog->type == BPF_PROG_TYPE_STRUCT_OPS &&
>>> +         st_ops_assoc && st_ops_assoc != BPF_PTR_POISON) {
>>> +             st_ops_assoc = bpf_map_inc_not_zero(st_ops_assoc);
>>
>> The READ_ONCE and inc_not_zero is an unusual combo. Should it be
>> rcu_dereference and prog->aux->st_ops_assoc should be "__rcu" tagged?
>>
> 
> Understood the underlying struct_ops map is protected by RCU, but
> prog->aux->st_ops_assoc is not protected by RCU and can change
> anytime.

hmm... at least for BPF_PROG_TYPE_STRUCT_OPS, the struct_ops map refcnt 
is not taken in patch 2. The prog->aux->st_ops_assoc can be used is 
because of the rcu gp.

Another thing I am likely missing is, the refcnted st_ops_assoc is saved 
in res->st_ops_assoc. If I read it correctly, the kfunc is using 
bpf_prog_get_assoc_struct_ops() which is reading from 
[prog->]aux->st_ops_assoc instead of the saved res->st_ops_assoc. Can 
the aux->st_ops_assoc be pointing to another struct_ops map different 
from res->st_ops_assoc?


