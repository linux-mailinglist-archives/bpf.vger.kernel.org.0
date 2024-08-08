Return-Path: <bpf+bounces-36668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CD394B841
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 09:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C684BB25552
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 07:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB63188CB8;
	Thu,  8 Aug 2024 07:51:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFD018757F;
	Thu,  8 Aug 2024 07:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723103482; cv=none; b=S1zMUZ7agLV9TdTl+M9hcoRf3aGGfcBb/pnrla+8DXZcTAjXzEmKQqsfvECsgr/X9ijuXky2Sb+8k+iLc3ZVpMdrOyz/jWNKFxZ+ltqT+LiK3Yfy4RlkMGs5rkhz1ko80gZJftBYIEqR2DOsPlSphYTirqPR81pzh1EyOxl8BMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723103482; c=relaxed/simple;
	bh=09O4r9EWnA9fBBPf0wUEsoQhth3c4eUChCAPVHAa68U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cdlZP0TtiKtXiVQqI+K2qAaAMpZqX1koDSQ52jNxJuNDcdgvzypLK4Zmsj6+1AN17Pi+uBgPUJtqIUPmccXFzUEOhyQ1p5myfHnLbRI53F/TaXR8Kkt5MCkg80y7HIpv8p8R/CVQonUwxvc09H2ca2mkXp9tXfKNx7gpLYpxqe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WffM02F3RzDqbF;
	Thu,  8 Aug 2024 15:49:16 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 91A4F140360;
	Thu,  8 Aug 2024 15:51:10 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 8 Aug 2024 15:51:09 +0800
Message-ID: <3a43c363-427c-65d4-bc74-42ce13793331@huawei.com>
Date: Thu, 8 Aug 2024 15:51:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 0/8] uprobes: RCU-protected hot path optimizations
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Oleg Nesterov
	<oleg@redhat.com>
CC: Andrii Nakryiko <andrii@kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<peterz@infradead.org>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <jolsa@kernel.org>,
	<paulmck@kernel.org>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240807132922.GC27715@redhat.com>
 <CAEf4BzZSyuFexZfwZs1bA9S=O0FHejw_tE6PXm5h8ftMsuSROw@mail.gmail.com>
 <20240807171113.GD27715@redhat.com>
 <CAEf4BzZ8SaFK4iMtPPxYZQjHOvaPqpKApE8=Bz+h29xq+xMEsA@mail.gmail.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <CAEf4BzZ8SaFK4iMtPPxYZQjHOvaPqpKApE8=Bz+h29xq+xMEsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/8/8 1:31, Andrii Nakryiko 写道:
> On Wed, Aug 7, 2024 at 10:11 AM Oleg Nesterov <oleg@redhat.com> wrote:
>>
>> On 08/07, Andrii Nakryiko wrote:
>>>
>>> Yes, I was waiting for more of Peter's comments, but I guess I'll just
>>> send a v2 today.
>>
>> OK,
>>
>>> I'll probably include the SRCU+timeout logic for
>>> return_instances, and maybe lockless VMA parts as well.
>>
>> Well, feel free to do what you think right, but perhaps it would be
>> better to push this series first? at least 1-4.
> 
> Ok, I can send those first 4 patches first and hopefully we can land
> them soon and move to the next part. I just also wrote up details
> about that crash in rb_find_rcu().
> 
>>
>> As for lockless VMA. To me this needs more discussions. I didn't read
> 
> We are still discussing, feel free to join the conversation.
> 
>> your conversation with Peter and Suren carefully, but I too have some
>> concerns. Most probably I am wrong, and until I saw this thread I didn't
>> even know that vm_area_free() uses call_rcu() if CONFIG_PER_VMA_LOCK,
>> but still.
>>
>>>> As for 8/8 - I leave it to you and Peter. I'd prefer SRCU though ;)
>>>
>>> Honestly curious, why the preference?
>>
>> Well, you can safely ignore me, but since you have asked ;)
>>
>> I understand what SRCU does, and years ago I even understood (I hope)
>> the implementation. More or less the same for rcu_tasks. But as for
>> the _trace flavour, I simply fail to understand its semantics.
> 
> Ok, I won't try to repeat Paul's explanations. If you are curious you
> can find them in comments to my previous batch register/unregister API
> patches.
> 
>>
>>> BTW, while you are here :) What can you say about
>>> current->sighand->siglock use in handle_singlestep()?
>>
>> It should die, and this looks simple. I disagree with the patches
>> from Liao, see the
>> https://lore.kernel.org/all/20240801082407.1618451-1-liaochang1@huawei.com/
>> thread, but I agree with the intent.
> 
> I wasn't aware of this patch, thanks for mentioning it. Strange that
> me or at least bpf@vger.kernel.org wasn't CC'ed.
> 
> Liao, please cc bpf@ mailing list for future patches like that.

OK, sorry about that.

> 
>>
>> IMO, we need a simple "bool restore_sigpending" in uprobe_task, it will make the
>> necessary changes really simple.
> 

[...]

>>
>> (To clarify. In fact I think that a new TIF_ or even PF_ flag makes more sense,
>>  afaics it can have more users. But I don't think that uprobes can provide enough
>>  justification for that right now)

I also face the same choice when Oleg suggested me to add new flag to track the denied
flag, due to I haven't encountered scenarios outside of uprobe that would deny signal,
so I'm not confident of introduce new TIF_ flag without a fully understanding of potential
potential impacts.

>>
>> Oleg.
>>

-- 
BR
Liao, Chang

