Return-Path: <bpf+bounces-36936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE95394F76E
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 21:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F481F22F5F
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 19:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E12418F2F6;
	Mon, 12 Aug 2024 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ij67TtUe"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5F813BC02
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 19:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723490500; cv=none; b=ub2mEKAjWF/VKpyF5toGBfVktYdaSfm46PWQ7tQK47B9R6NHId7rvLwxzwTrf9vc0N+fAmFwa0ptCDmHrWWqvHEheqxQluj2V7q3SPIHkFeNvJ/EiSwxJSRncMWYBkU43ne6bvg9IKfcwLZZ0cYyDjpL4X4yKlhuek3wEkz7qQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723490500; c=relaxed/simple;
	bh=dAFvYebHKRGGI5NXUJ/BTfTht+SfsxpxegflYGYgUKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6UOLOKLkGHrr5sr/aY9RCbowrX9oygga9ZA9hxwRJep8MXERHa7Yl0cCI8ATH0Sa8DOWSXNEVnzkmW4DEtD5x5ES+9GVcSLP5D8hbEuEh/M9PrRUKFMktzIwzWp13WxgYIs/9sKsnRfVsV6eFrrZjhKrjcWoQY55+apRc2GzBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ij67TtUe; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3d2c1c38-653f-495b-ac56-782fe9619f74@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723490497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5SfJQrYi+6mehU9I9xYMGzEw1MWqQBMNmdfQoT6TvuQ=;
	b=Ij67TtUeTiXe1Ucdkde68PxDK+LF+9fOHl0YOdx27OSsaWnRuKc2nycTS16ZdrEWIvm7lZ
	h63kAxcHkYpJA3fbVBWRuIGIl+NxADVcd7Wb2olfVEBKRS5OMpi9r/pgsbhmU9jBpY0WOt
	SwcWXKlU7kA9GQy+75J/4ji8tnvnOEs=
Date: Mon, 12 Aug 2024 12:21:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/2] bpf: Fix a kernel verifier crash in stacksafe()
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Daniel Hodges <hodgesd@meta.com>
References: <20240812052106.3980303-1-yonghong.song@linux.dev>
 <ffac004eab4bfe98c5323a62c6e47b25354589bb.camel@gmail.com>
 <CAADnVQ+-om1OWRyUvWoiVg5pKM7cxOCVw4wZqdZM1JTRTg4-5g@mail.gmail.com>
 <d2ca7ec0b51fef86ef8cd71202ee5b6de7dc42cf.camel@gmail.com>
 <CAADnVQJjY9NU7WBxUNqOnLEpm6KhgHL0M_YobQ=2ZjMUHq3_eA@mail.gmail.com>
 <a4af06f9-5ea7-4541-90fd-1241043d5659@linux.dev>
 <0b305ca5045a1adceec313b20f912f9666c1705c.camel@gmail.com>
 <69654617-c97e-48cb-8317-15567a46365a@linux.dev>
 <bce93894f4db4f2d80d735fc35246e047b677ea8.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <bce93894f4db4f2d80d735fc35246e047b677ea8.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/12/24 11:41 AM, Eduard Zingerman wrote:
> On Mon, 2024-08-12 at 11:36 -0700, Yonghong Song wrote:
>
> [...]
>
>> Sorry, I copy-paste from 'git diff' result to my email window. Not sure
>> why it caused the format issue after I sent out.
> Sure, no problem
>
>> Anyway, the following is the patch I suggested:
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index df3be12096cf..1906798f1a3d 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -17338,10 +17338,13 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
>>            */
>>           for (i = 0; i < old->allocated_stack; i++) {
>>                   struct bpf_reg_state *old_reg, *cur_reg;
>> +               bool cur_exceed_bound;
>>    
>>                   spi = i / BPF_REG_SIZE;
>>    
>> -               if (exact != NOT_EXACT &&
>> +               cur_exceed_bound = i >= cur->allocated_stack;
> idk, I think C compiler would do this anyways,
> to me the code is fine both with and without this additional variable.

Okay, I will keep the original (simpler) patch then.

>
>> +
>> +               if (exact != NOT_EXACT && !cur_exceed_bound &&
>>                       old->stack[spi].slot_type[i % BPF_REG_SIZE] !=
>>                       cur->stack[spi].slot_type[i % BPF_REG_SIZE])
>>                           return false;
>> @@ -17363,7 +17366,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
>>                   /* explored stack has more populated slots than current stack
>>                    * and these slots were used
>>                    */
>> -               if (i >= cur->allocated_stack)
>> +               if (cur_exceed_bound)
>>                           return false;
>>    
>>                   /* 64-bit scalar spill vs all slots MISC and vice versa.
>>
>

