Return-Path: <bpf+bounces-45650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4010B9D9E7B
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 21:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8153F283E2B
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 20:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28A41DE894;
	Tue, 26 Nov 2024 20:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G5owxmzd"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B237946C
	for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 20:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732654045; cv=none; b=F3/BkOhuBd0DSxwNXlr9EGN2F09zEf02h/yo0bXvJ1727f71QFkBJ2Am50nOaPcvePz9fvcoZ0NwRLj0NbaITZqhyqRxPr3xuE9Yjf+aq+gVeu20F+XseyBWUP5aOGxSRzJwDPYVQnZTqYDnd9g1WTc0aMwyzkhUiNmlpaCIGYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732654045; c=relaxed/simple;
	bh=FIia/oFgoYgTPmWJEwc2RG/vMD107Mo/Xpj8VQpALKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eesca2BlvbM4pMKi8z7/cHJc+udITz+hjlb5g10JnTepoMsm7mp69cljKLNNBQY6xToTb53G0rwU3Uyy5LD2+3OEjVzvfq7n29nSa08luqoir7WbVnJ2TUeCgY+0G/FQgbALBJe/lMIfbkCLy9Y5nnLbEOqzlJRA3UaiuAVXMTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G5owxmzd; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d854688a-9d2d-4fed-9cb8-3e5c4498f165@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732654037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ny763s+VIVujHWlzTNtT0/Iu+N9U6biECa5OkIrTiJs=;
	b=G5owxmzdXjcLZM1J2ekI35mWD4wFyHgV64w8CQVjGe7kLuxBtUySt56sp5LZU7gFYraCnP
	jVRcuC0g8fg3MjSxhb6thLS5+Eupd6ZE+Vqch7XK+69Ptc+ItIAaKHn7HZPveE0e7lKEd+
	7RlEQCai2/wE2tKzCbEkISkXNdfNBq0=
Date: Tue, 26 Nov 2024 12:47:09 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [External] Storing sk_buffs as kptrs in map
To: Amery Hung <amery.hung@bytedance.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, sreedevi.joshi@intel.com,
 ast@kernel.org
References: <Z0X/9PhIhvQwsgfW@boxer>
 <CAONe225n=HosL1vBOOkzaOnG9jTYpQwDH6hwyQRAu0Cb=NBymA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAONe225n=HosL1vBOOkzaOnG9jTYpQwDH6hwyQRAu0Cb=NBymA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/26/24 11:56 AM, Amery Hung wrote:
>> I have a use case where I would like to store sk_buff pointers as kptrs in
>> eBPF map. To do so, I am borrowing skb kfuncs for acquire/release/destroy
>> from Amery Hung's bpf qdisc set [0], but they are registered for
>> BPF_PROG_TYPE_SCHED_CLS programs.
>>
>> TL;DR - due to following callstack:
>>
>> do_check()
>>    check_kfunc_call()
>>      check_kfunc_args()
>>        get_kfunc_ptr_arg_type()
>>            btf_is_prog_ctx_type()
>>                btf_is_projection_of() -- return true
>>
>> sk_buff argument is being interpreted as KF_ARG_PTR_TO_CTX, but what we
>> have there is KF_ARG_PTR_TO_BTF_ID. Verifier is unhappy about it. Should

I don't think I fully understand "what we have there is KF_ARG_PTR_TO_BTF_ID". I 
am trying to guess you meant what we have there in the reg->type is in 
(PTR_TO_BTF_ID | PTR_TRUSTED).

It makes sense to have "struct sk_buff __kptr *" instead of "struct __sk_buff 
__kptr *". However, the get_kfunc_ptr_arg_type() is expecting KF_ARG_PTR_TO_CTX 
because the prog type is BPF_PROG_TYPE_SCHED_CLS.

 From a very quick look, under the "case KF_ARG_PTR_TO_CTX:" in 
check_kfunc_args(), I think it needs to teach the verifier that the reg->type 
with a trusted PTR_TO_BTF_ID ("struct sk_buff *") can be used as the PTR_TO_CTX.

>> this be workarounded via some typedef or adding mentioned kfuncs to
>> special_kfunc_list ? If the latter, then what else needs to be handled?
>>
>> Commenting out sk_buff part from btf_is_projection_of() makes it work, but
>> that probably is not a solution:)
>>
>> Another question is in case bpf qdisc set lands, could we have these
>> kfuncs not being limited to BPF_PROG_TYPE_STRUCT_OPS ?

Similar to Amery's comment. Please share the patch and user case. It will be 
easier to discuss.

> In bpf qdisc case, we are still working on
> releasing skb kptrs in maps or graphs automatically when .reset is
> called so that we don't hold the resources forever.

Regarding specifically the bpf qdisc case, the .reset should do the right thing 
to release the queued skb. imo, after sleeping on it, if the bpf prog missed 
releasing the skb, it is fine to depend on the map destruction to finally 
release them. It is the same as other kptrs type stored in the map which will 
also be finally released during map_free.

In the future, for the struct_ops case, it can be improved by allowing to define 
the sch->privdata. May be allow to define the layout of this privdata, e.g. the 
whole privdata is a one element map backed by a btf id. The implementation will 
need to be generic enough for any bpf_struct_ops instead of something specific 
to the bpf-qdisc. This can be a follow up improvement as a more seamless per sch 
instance cleanup after the core bpf-qdisc pieces landed.


