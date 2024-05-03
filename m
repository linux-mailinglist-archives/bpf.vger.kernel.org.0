Return-Path: <bpf+bounces-28540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1368BB3C8
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 21:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0548E1C23AE5
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 19:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8691581E0;
	Fri,  3 May 2024 19:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EKBIjP/v"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6163057CBE
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 19:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714763770; cv=none; b=PSqmEbUmVoFbGs834CKhIETk/BpAV+AL23SNZeZ1YuWhkXmNgZrCBai3Utsbr3WZ2jXHdLOjGbnJbfdN0lhCFe3nG3Mg/A6Za9mUReKZv5B8HuI2Yf9NTCjkva31257d2jnyKOscqjw01k8nSnIQDejJFihzzkZ5qY2jHay+6fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714763770; c=relaxed/simple;
	bh=4IoWqGRSZy3famSC1nEd8rAap+KcNgG8YyuLdyG49/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jyi4FUMXpZirIbHk2pLpiDQiutIIv+O5Z2KzRvkp0/C9XD11Z0dmZSdIwNn6WNl3FFeRQKLxAiuFA7BHeDGkNtZ1Pk6E3fEwmn4fEyyh1GKqECtpTa4zzUOYsvwkgx5Od1xV0e5DHG13jQsGNsvgE3o7nd1Bi+a54uKl9MDHa9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EKBIjP/v; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4f54cc5e-6864-4ff8-b840-1f93000cb7a7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714763764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pi8/AWqR4+V5NeRRoXcBt5wdaGy3ZIxwXASAcOM7MWw=;
	b=EKBIjP/vewAxchLV81iNAKCMU0kdm+UzwDFkcPLXJscerDdhK/WEjNJtpO3h4i3UXLEaLf
	anlVArhmWO3WgD5BRjEn733NnmfPku4p8pTUMULK0vBSZUkOSIkvjuiT6nreVDiS7Ym0Ln
	NHtbBmg9fXwqNEEyYhpFF0/1iHhtqv8=
Date: Fri, 3 May 2024 12:15:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 6/6] selftests/bpf: test detaching struct_ops
 links.
To: Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20240429213609.487820-1-thinker.li@gmail.com>
 <20240429213609.487820-7-thinker.li@gmail.com>
 <d7d50210-bc21-4de4-9b2b-01b299a15bd0@linux.dev>
 <4462086b-c01a-4733-8a15-7ef0d1f91c2f@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <4462086b-c01a-4733-8a15-7ef0d1f91c2f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/3/24 11:34 AM, Kui-Feng Lee wrote:
> 
> 
> On 5/2/24 11:15, Martin KaFai Lau wrote:
>> On 4/29/24 2:36 PM, Kui-Feng Lee wrote:
>>> @@ -572,6 +576,12 @@ static int bpf_dummy_reg(void *kdata)
>>>       if (ops->test_2)
>>>           ops->test_2(4, ops->data);
>>> +    if (ops->do_unreg) {
>>> +        rcu_read_lock();
>>> +        bpf_struct_ops_kvalue_unreg(kdata);
>>
>> Instead of unreg() immediately before the reg() has returned, the test should 
>> reflect more on how the subsystem can use it in practice. The subsystem does 
>> not do unreg() during reg().
>>
>> It also needs to test a case when the link is created and successfully 
>> registered to the subsystem. The user space does BPF_LINK_DETACH first and  >> then the subsystem does link->ops->detach() by itself later.

> 
> agree
> 
>>
>> It can create a kfunc in bpf_testmod.c to trigger the subsystem to do 
>> link->ops->detach(). The kfunc can be called by a SEC("syscall") bpf prog 
>> which is run by bpf_prog_test_run_opts(). The test_progs can then decide on 
>> the timing when to do link->ops->detach() to test different cases.
> 
> What is the purpose of this part?
> If it goes through link->ops->detach(), it should work just like to call
> bpf_link_detach() twice on the same link from the user space. Do you
> want to make sure detaching a link twice work?

It is not quite what I meant and apparently link detach twice on the same valid 
(i.e. refcnt non zero) link won't work.

Anyhow, the idea is to show how the racing case may work in patch 3 (when 
userspace tries to detach and the subsystem tries to detach/unreg itself also). 
I was suggesting the kfunc idea such that the test_progs can have better control 
on the timing on when to ask the subsystem to unreg/detach itself instead of 
having to do the unreg() during the reg() as in patch 6 here. If kfunc does not 
make sense and there is a better way to do this, feel free to ignore.


