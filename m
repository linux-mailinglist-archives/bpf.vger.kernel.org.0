Return-Path: <bpf+bounces-22611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04470861C56
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 20:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A05284ADA
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 19:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C40143C67;
	Fri, 23 Feb 2024 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nkomk8hO"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504FF101CA
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 19:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708715731; cv=none; b=HXwU0W6fo03vVkCjJp8hxXKh0kwmCiHYV/cjyuuKOeBxzl/AptOM3PyLqpzMOlxf9BDNrrx80hqu2T9pNSWLEfJTG9f3Pw1BPi+enxivKPbudKeYBVd5sqDX20tyP/8zoluC4vyPcY/rzGp43/XmDLt6AmohsUmQbejpcNNd27Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708715731; c=relaxed/simple;
	bh=T2soKAOo3mqK2a1xP/BzF21uwuTE2G2W0RnJ2mIb6/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fqSQie2u486Is3CjBynyN7/iKs8yW7MNY65A5/Pj7em6LXeqbd3MO/Q4wLnY857oc8eSbbTv1m3iULbWYiMdn/m7tWvFD2x2BSt7TkPlvupPC0RAn7rA0vwxDyw447ldl1XfaTUK9djBsu288nlctKm2yK1rKSDNqyNmmsPfLFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nkomk8hO; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <363c4377-f668-49fd-978d-73864c293b4e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708715727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nIslIAnDT86/nNrLRinTSb0cAl34kXZfFoLeBJhiN6w=;
	b=Nkomk8hOIaFH09o2FGBaZ09p21XrHmdSJ0ERTYGGUhfjq+wGTj8rRaqG1DlvXhQedRP+44
	HRmBsztVOmZ5ycnpjQzPXwlkTzFHOO/mwB+ACIHgPQzNXYo416Ru+kZgHneVXN6K8jpCW8
	p2k++h6n7VhT5Jnd5oWeyAaxDpcW0OE=
Date: Fri, 23 Feb 2024 11:15:22 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/3] bpf: struct_ops supports more than one
 page for trampolines.
Content-Language: en-US
To: Kui-Feng Lee <sinquersw@gmail.com>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20240221225911.757861-1-thinker.li@gmail.com>
 <20240221225911.757861-3-thinker.li@gmail.com>
 <c59cc446-531b-4b4a-897d-3b298ac72dd2@linux.dev>
 <3e4cc350-34c9-42c1-944f-303a466022d2@gmail.com>
 <7402facf-5f2e-4506-a381-6a84fe1ba841@linux.dev>
 <25982f53-732e-4ce8-bbb2-3354f5684296@gmail.com>
 <b8bac273-27c7-485a-8e45-8825251d6d5a@linux.dev>
 <33c2317c-fde0-4503-991b-314f20d9e7f7@gmail.com>
 <c938c3b1-8cce-4563-930d-7e8150365117@gmail.com>
 <ded8001c-2437-48f4-88ff-4c0633f1da7c@linux.dev>
 <30ffb867-ee0e-4573-b9e7-9fc0f4430adb@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <30ffb867-ee0e-4573-b9e7-9fc0f4430adb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/23/24 11:05 AM, Kui-Feng Lee wrote:
> 
> 
> 
> On 2/23/24 10:42, Martin KaFai Lau wrote:
>> On 2/23/24 10:29 AM, Kui-Feng Lee wrote:
>>> One thing I forgot to mention is that bpf_dummy_ops has to call
>>> bpf_jit_uncharge_modmem(PAGE_SIZE) as well. The other option is to move
>>> bpf_jit_charge_modmem() out of bpf_struct_ops_prepare_trampoline(),
>>> meaning bpf_struct_ops_map_update_elem() should handle the case that the
>>> allocation in bpf_struct_ops_prepare_trampoline() successes, but
>>> bpf_jit_charge_modmem() fails.
>>
>> Keep the charge/uncharge in bpf_struct_ops_prepare_trampoline().
>>
>> It is fine to have bpf_dummy_ops charge and then uncharge a PAGE_SIZE. There 
>> is no need to optimize for bpf_dummy_ops. Use bpf_struct_ops_free_trampoline() 
>> in bpf_dummy_ops to uncharge and free.
> 
> 
> Then, I don't get the point here.
> I agree with moving the allocation into
> bpf_struct_ops_prepare_trampoline() to avoid duplication of the code
> about flags and tlinks. It really simplifies the code with the fact
> that bpf_dummy_ops is still there. So, I tried to pass a st_map to
> bpf_struct_ops_prepare_trampoline() to keep page managements code
> together. But, you said to simplify the code of bpf_dummy_ops by
> allocating pages in bpf_struct_ops_prepare_trampoline(), do bookkeeping
> in bpf_struct_ops_map_update_elem(), so bpf_dummy_ops doesn't have to

I don't think I ever mentioned to do book keeping in 
bpf_struct_ops_map_update_elem(). Have you looked at my earlier code in 
bpf_struct_ops_prepare_trampoline() which also does the memory charging also?

> allocate memory. But, we have to move a bpf_jit_uncharge_modmem() to
> bpf_dummy_ops. For me, this trade-off that include removing an
> allocation and adding a bpf_jit_uncharge_modmem() make no sense.

Which part make no sense? Having bpf_dummy_ops charge/uncharge memory also?

The bpf_dummy_ops() uses the below bpf_struct_ops_free_trampoline() which does 
uncharge and free. bpf_struct_ops_prepare_trampoline() does charge and alloc.
charge/alloc matches with uncharge/free.

> 
>>
>>
>>>>> void bpf_struct_ops_free_trampoline(void *image)
>>>>> {
>>>>>      bpf_jit_uncharge_modmem(PAGE_SIZE);
>>>>>      arch_free_bpf_trampoline(image, PAGE_SIZE);
>>>>> }
>>>>>
>>


