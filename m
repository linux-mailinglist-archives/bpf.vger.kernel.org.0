Return-Path: <bpf+bounces-36439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F803948716
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 03:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94DFE1F234BC
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 01:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B544DAD51;
	Tue,  6 Aug 2024 01:50:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB5B5680;
	Tue,  6 Aug 2024 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722909047; cv=none; b=ZNSS8dPowttkFzEwsp4/ysCghyvVFZ2Egijk8iySlDF0tu75HV+QLksZjBqdCWiXPW8Frw9VRtJ2LMgwlrCkYLk0ktH+tl8L1XR+tVWuwBRakeeFhXMvvRWN+OBg7hcgXt1eRgLnkbFZ/3O/I1lmrF4DfyVoa227ONFEBNKxI28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722909047; c=relaxed/simple;
	bh=CbFPcbzdUucTRMFRAZx+VAj9onOepdSbvwXioYnWy7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cvbdSxn39hvvmK5c2yOTVYhxjf4Rkjs9KbQP6spjPXu/Eltupp/TdfXIYETiTanXdlQ2bzUSrmdUKPjtIejELAsy7MZ9IUm+APM0rPhft95xc4ZuocZdIoZFVeu09mjvTnFxdwoQIRPSje9rBZZlv9Lp+SrlLAp0Epqn6vklRyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WdGTn6DrwzyNty;
	Tue,  6 Aug 2024 09:50:21 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id D5DF91400CF;
	Tue,  6 Aug 2024 09:50:40 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 6 Aug 2024 09:50:39 +0800
Message-ID: <103e02a3-8dab-f1a4-0b2d-e84915df14fe@huawei.com>
Date: Tue, 6 Aug 2024 09:50:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 6/8] perf/uprobe: split uprobe_unregister()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: Andrii Nakryiko <andrii@kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<peterz@infradead.org>, <oleg@redhat.com>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>, <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jolsa@kernel.org>, <paulmck@kernel.org>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240731214256.3588718-7-andrii@kernel.org>
 <eb6d1474-a292-af20-b8b1-1c2de61405f4@huawei.com>
 <CAEf4BzZR6a4OSqsvyci0_-P+_o2PErM_PyC9y9eSc4J4A+Uabw@mail.gmail.com>
 <CAEf4BzYuGo572m+zi3KD51zp82a63mL9f5F2kz1w8ZvEBQB_VA@mail.gmail.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <CAEf4BzYuGo572m+zi3KD51zp82a63mL9f5F2kz1w8ZvEBQB_VA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/8/6 4:01, Andrii Nakryiko 写道:
> On Fri, Aug 2, 2024 at 8:05 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Thu, Aug 1, 2024 at 7:41 PM Liao, Chang <liaochang1@huawei.com> wrote:
>>>
>>>
>>>
>>> 在 2024/8/1 5:42, Andrii Nakryiko 写道:
>>>> From: Peter Zijlstra <peterz@infradead.org>
>>>>
>>>> With uprobe_unregister() having grown a synchronize_srcu(), it becomes
>>>> fairly slow to call. Esp. since both users of this API call it in a
>>>> loop.
>>>>
>>>> Peel off the sync_srcu() and do it once, after the loop.
>>>>
>>>> With recent uprobe_register()'s error handling reusing full
>>>> uprobe_unregister() call, we need to be careful about returning to the
>>>> caller before we have a guarantee that partially attached consumer won't
>>>> be called anymore. So add uprobe_unregister_sync() in the error handling
>>>> path. This is an unlikely slow path and this should be totally fine to
>>>> be slow in the case of an failed attach.
>>>>
>>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>> Co-developed-by: Andrii Nakryiko <andrii@kernel.org>
>>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>>>> ---
>>>>  include/linux/uprobes.h                        |  8 ++++++--
>>>>  kernel/events/uprobes.c                        | 18 ++++++++++++++----
>>>>  kernel/trace/bpf_trace.c                       |  5 ++++-
>>>>  kernel/trace/trace_uprobe.c                    |  6 +++++-
>>>>  .../selftests/bpf/bpf_testmod/bpf_testmod.c    |  3 ++-
>>>>  5 files changed, 31 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
>>>> index a1686c1ebcb6..8f1999eb9d9f 100644
>>>> --- a/include/linux/uprobes.h
>>>> +++ b/include/linux/uprobes.h
>>>> @@ -105,7 +105,8 @@ extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
>>>>  extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
>>>>  extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
>>>>  extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
>>>> -extern void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc);
>>>> +extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
>>>> +extern void uprobe_unregister_sync(void);
>>>
>>> [...]
>>>
>>>>  static inline void
>>>> -uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
>>>> +uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc)
>>>> +{
>>>> +}
>>>> +static inline void uprobes_unregister_sync(void)
>>>
>>> *uprobes*_unregister_sync, is it a typo?
>>>
>>
>> I think the idea behind this is that you do a lot of individual uprobe
>> unregistrations with multiple uprobe_unregister() calls, and then
>> follow with a single *uprobes*_unregister_sync(), because in general
>> it is meant to sync multiple uprobes unregistrations.
> 
> Ah, I think you were trying to say that only static inline
> implementation here is called uprobes_unregister_sync, while all the
> other ones are uprobe_unregister_sync(). I fixed it up, kept it as
> singular uprobe_unregister_sync().
> 

Yes, that's exactly what i meant :)

>>
>>>>  {
>>>>  }
>>>>  static inline int uprobe_mmap(struct vm_area_struct *vma)
>>>> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
>>>> index 3b42fd355256..b0488d356399 100644
>>>> --- a/kernel/events/uprobes.c
>>>> +++ b/kernel/events/uprobes.c
> 
> [...]

-- 
BR
Liao, Chang

