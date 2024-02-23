Return-Path: <bpf+bounces-22606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 421DE861BB1
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 19:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7353E1C21180
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 18:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A6F73F25;
	Fri, 23 Feb 2024 18:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VhVS4UIB"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0008C79E1
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708713175; cv=none; b=h4h4IxMFYvbt8GwTbgtdYONHxpWATdiZyecyGX9yfuBJT+d5YK8+EVc2z4t9m6W5oCQtkBcRKaDL/X2aNNe2/uXvKwV2Soej6GvBwymnMECY1HMzg+MBXXJUl5JmKDvZYg/5+NNKV69LG7GoAIGjqidg/Nk7fUtDkUDd6fAFFyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708713175; c=relaxed/simple;
	bh=DpCtDv4PnlkPQV7VcsCIMiCWqOzG4CMzmoh31r4iWtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JmIkB7EtMfZd6wXHaUjYWflSosngHOxLcrn43eaMFffbFSQCgV86BCd/oTVCikevtIRlaMSAOa7T/cSDVMeSgAhtnVoYD1/C4iUxvBY4fX2ZfDVHfe+eUWLP8/PIDcKgS9JMRHrEkA9y61rG4bUnTGCqqNmw4lqD4GcQggfnwlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VhVS4UIB; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c22500d7-b7b8-4073-ad91-f2a4213314aa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708713171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvKhPTaPhjV0Aagxsr31doXg0HoylnFcl+ogmncoVFo=;
	b=VhVS4UIB8d+JvWwNNEB3Sd+RDTuzRekzHkNQTUUiby40uI4t0zkxsmc+BjEX24WZHigs+5
	7v4H/V078AEQG2T/HjAmH49B5la7A7SEck6LxR63takfpH5R9Ju1CcqeKuoIiWyJuQ7G/D
	wQjN1b55m7Be3MfFGzEyDdGll5N9iq4=
Date: Fri, 23 Feb 2024 10:32:43 -0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <33c2317c-fde0-4503-991b-314f20d9e7f7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/23/24 9:36 AM, Kui-Feng Lee wrote:
> 
> To be clear, we are not talking computation or memory complexity here.
> I consider the complexity in another way. When I look at the code of
> bpf_dummy_ops, and see it free the memory at the very end of a function.
> I have to guess who allocate the memory by looking around without a
> clear sign or hint if we move the allocation to
> bpf_struct_ops_prepare_trampoline(). It is a source of complexity.

It still sounds like a naming perception issue more than a practical code-wise 
complexity/readability. Rename it to 
bpf_struct_ops_"s/alloc/prepare/"_trampoline() if it can make it more obvious 
that it is an alloc function. imo, that function returning a page is a clear 
sign that it can alloc but I don't mind renaming it if it can help to make it 
sounds more like alloc and free pair.

> Very often, a duplication is much more simple and easy to understand.
> Especially, when the duplication is in a very well know/recognized
> pattern. Here will create a unusual way to replace a well recognized one
> to simplify the code.

Sorry, I don't agree on this where this patch is duplicating lines of code which 
is not obvious like setting BPF_TRAMP_F_*. At least I often have to go back to 
arch_prepare_bpf_trampoline() to understand how it works.

Not copy-and-pasting this piece of codes everywhere is more important than 
making bpf_dummy_ops looks better.

> 
> My reason of duplicating the code from
> bpf_struct_ops_prepare_trampoline() was we don't need
> bpf_struct_ops_prepare_trampoline() in future if we were going to move
> bpf_dummy_ops out. But, just like you said, we still have bpf_dummy_ops

Yep, it will be great to move bpf_dummy_ops out but how it can be done and 
whether it can remove its bpf_struct_ops_prepare_trampoline() usage is still 
TBD. I think it should be possible. Even it is moved out in the future, 
bpf_struct_ops_(prepare|alloc)_trampoline() can be keep as is.

> now, so it is a good trade of to move memory allocation into
> bpf_struct_ops_prepare_trampoline() to avoid the duplication the code
> about flags and tlinks. But, the trade off we are talking here goes to
> an opposite way.


