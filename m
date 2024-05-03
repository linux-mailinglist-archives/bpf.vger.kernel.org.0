Return-Path: <bpf+bounces-28553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E098BB68A
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 00:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35391C22F65
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 22:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E907453E16;
	Fri,  3 May 2024 21:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hnl3Wyv0"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDF93398A
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 21:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714773599; cv=none; b=eVEE4h2G7ZxTHhC5q83bX4lAud6SLj8vpFW84v7l8+Q4kbmY+aPq2hU8BLbc2Loig/4JpAn3ZGH5WoTgAh2TGDyh6cDehMXWAqi9vBOn3BJlJ1oJskyFuDJ//N75XC66cCl41GKCtk7XYNXsLgFa+GoFUdbSdmmtyWyxOp4SpE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714773599; c=relaxed/simple;
	bh=+bhVJQd6yRL8sAFo7HzyhG4ZpfJL5icS4x31Rw29reI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WrX3nQprkPlJSftcyvYaW2afMKabRokXJOK7AA2v+5XMergj4KTh+z/CM8BiDIYypRI3gH0wWjqNfv5IpMUCo1j9h3bKAhGGY6wXY/RORounY2TDKV5tI+LHDHHfOkHIq1t6vZzFYjkJoKbJj50oxWXS4jaOwZySME30x7quQKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hnl3Wyv0; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <14a618ca-636f-420c-9356-034b1557e26d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714773595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X4bY47uGXIAljRAjYSDkvr58iphg01qtE8sgSkRAgXY=;
	b=hnl3Wyv0wIZ8Ju8gVI95KvhgoOuFnPwVRMDg91bks/fnZ49Sij71KdIpGtoOd6nXPbWKu4
	bRQQJTUBK9efG00B1UVzM5keaQ4yjjd4XCCFNLe++afPwF82QoOcPL6khSiVeBEzIRbBdE
	oI8dhouo0+o8L659AWG8AMUQjOoJS+A=
Date: Fri, 3 May 2024 14:59:51 -0700
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
 <4f54cc5e-6864-4ff8-b840-1f93000cb7a7@linux.dev>
 <33bded73-703d-443d-b428-48a03b3d395d@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <33bded73-703d-443d-b428-48a03b3d395d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/3/24 2:34 PM, Kui-Feng Lee wrote:
> 
> 
> On 5/3/24 12:15, Martin KaFai Lau wrote:
>> On 5/3/24 11:34 AM, Kui-Feng Lee wrote:
>>>
>>>
>>> On 5/2/24 11:15, Martin KaFai Lau wrote:
>>>> On 4/29/24 2:36 PM, Kui-Feng Lee wrote:
>>>>> @@ -572,6 +576,12 @@ static int bpf_dummy_reg(void *kdata)
>>>>>       if (ops->test_2)
>>>>>           ops->test_2(4, ops->data);
>>>>> +    if (ops->do_unreg) {
>>>>> +        rcu_read_lock();
>>>>> +        bpf_struct_ops_kvalue_unreg(kdata);
>>>>
>>>> Instead of unreg() immediately before the reg() has returned, the test 
>>>> should reflect more on how the subsystem can use it in practice. The 
>>>> subsystem does not do unreg() during reg().
>>>>
>>>> It also needs to test a case when the link is created and successfully 
>>>> registered to the subsystem. The user space does BPF_LINK_DETACH first and  
>>>> >> then the subsystem does link->ops->detach() by itself later.
>>
>>>
>>> agree
>>>
>>>>
>>>> It can create a kfunc in bpf_testmod.c to trigger the subsystem to do 
>>>> link->ops->detach(). The kfunc can be called by a SEC("syscall") bpf prog 
>>>> which is run by bpf_prog_test_run_opts(). The test_progs can then decide on 
>>>> the timing when to do link->ops->detach() to test different cases.
>>>
>>> What is the purpose of this part?
>>> If it goes through link->ops->detach(), it should work just like to call
>>> bpf_link_detach() twice on the same link from the user space. Do you
>>> want to make sure detaching a link twice work?
>>
>> It is not quite what I meant and apparently link detach twice on the same 
>> valid (i.e. refcnt non zero) link won't work.
>>
>> Anyhow, the idea is to show how the racing case may work in patch 3 (when 
>> userspace tries to detach and the subsystem tries to detach/unreg itself 
>> also). I was suggesting the kfunc idea such that the test_progs can have 
>> better control on the timing on when to ask the subsystem to unreg/detach 
>> itself instead of having to do the unreg() during the reg() as in patch 6 
>> here. If kfunc does not make sense and there is a better way to do this, feel 
>> free to ignore.
>>
> 
> Ok! I think the case you are talking more like to happen when the link
> is destroyed, but bpf_struct_ops_map_link_dealloc() has not finished
> yet. Calling link->ops->detach() at this point may cause a racing since
> bpf_struct_ops_map_link_dealloc() doesn't acquire update_mutex.

Yes, adding link_dealloc() (i.e. close the link) in between will be a good test too.

With or without link_dealloc()/close(), the idea is to test this race (user 
space detach and/or dealloc vs subsystem detach/unreg) or at least show how the 
subsystem should do it. I was merely suggesting to use kfunc (may be there is a 
better way and feel free to ignore). The details of the testing steps could be 
adjusted based on how patch 3 will look like.

> 
> Calling link->ops->detach() immediately after BPF_LINK_DETACH would not
> cause any racing since bpf_struct_ops_map_link_detach() always acquires
> update_mutex. They will be executed sequentially, and call
> st_map->ops->reg() sequentially as well.

I didn't meant the detach() itself is racy or not. That part is fine. It is more 
about the link that the subsystem is holding. I feel how patch 3 will look like 
may be something different from my current thinking. If this test does not make 
sense based on how patch 3 will look like, feel free to ignore also.

> 
> I will add a test case to call link->ops->detach() after close the fd of
> the link.
> 


