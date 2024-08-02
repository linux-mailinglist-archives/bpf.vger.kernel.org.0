Return-Path: <bpf+bounces-36247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 831F69455FE
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 03:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DEFB1F23528
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 01:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4F918B1A;
	Fri,  2 Aug 2024 01:31:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0AD4C9D;
	Fri,  2 Aug 2024 01:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722562266; cv=none; b=NFrO1/9MkibxDkWoJyer2U0iiBYNen8KHkQyvd7txbOCKJnq1lz8eMyGOB3wKOeSoUTTMK2ulePJnq6P1GLYfQt37DTDL89ZmNeixzcUp63KBNR7RSQ7aXg5CZKO5mx7mfdB8Nn/HjP71Lsl79wrfsf0VJCv+xabB9AfcMv2CBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722562266; c=relaxed/simple;
	bh=WRTBl5tZuoCzj2joN/rr56sMEY2AcntMrQulsLgvhMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hr+7WZZmtl752OBtsr4BrhmNdzrRixeJlz2jvOUyW4Cy4NfGoKY9HJy194UmOgIEiBMsEszQ7JKYB/5ZMDqCjx83pDuBANDtAGvGbKJLPEb6hHptobBORZMsfrTawLjBSE2ijUmugIbF+xXo3nBJVcguOBVR+EvsMZSsdSWSR9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WZp9t6fDDz1HFp5;
	Fri,  2 Aug 2024 09:28:02 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id A234914037D;
	Fri,  2 Aug 2024 09:30:53 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 2 Aug 2024 09:30:52 +0800
Message-ID: <175e2c47-ad81-cc1d-18b9-d9644bc15925@huawei.com>
Date: Fri, 2 Aug 2024 09:30:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/8] uprobes: protected uprobe lifetime with SRCU
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: Andrii Nakryiko <andrii@kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<peterz@infradead.org>, <oleg@redhat.com>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>, <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jolsa@kernel.org>, <paulmck@kernel.org>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240731214256.3588718-4-andrii@kernel.org>
 <5cf9866c-28bc-8654-07c2-269a95219ada@huawei.com>
 <CAEf4BzYzqw7zO1dBXSgh1sQoFtdg2sa5avOch8jJW=_iRJuquQ@mail.gmail.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <CAEf4BzYzqw7zO1dBXSgh1sQoFtdg2sa5avOch8jJW=_iRJuquQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/8/2 0:49, Andrii Nakryiko 写道:
> On Thu, Aug 1, 2024 at 5:23 AM Liao, Chang <liaochang1@huawei.com> wrote:
>>
>>
>>
>> 在 2024/8/1 5:42, Andrii Nakryiko 写道:
>>> To avoid unnecessarily taking a (brief) refcount on uprobe during
>>> breakpoint handling in handle_swbp for entry uprobes, make find_uprobe()
>>> not take refcount, but protect the lifetime of a uprobe instance with
>>> RCU. This improves scalability, as refcount gets quite expensive due to
>>> cache line bouncing between multiple CPUs.
>>>
>>> Specifically, we utilize our own uprobe-specific SRCU instance for this
>>> RCU protection. put_uprobe() will delay actual kfree() using call_srcu().
>>>
>>> For now, uretprobe and single-stepping handling will still acquire
>>> refcount as necessary. We'll address these issues in follow up patches
>>> by making them use SRCU with timeout.
>>>
>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>>> ---
>>>  kernel/events/uprobes.c | 93 ++++++++++++++++++++++++-----------------
>>>  1 file changed, 55 insertions(+), 38 deletions(-)
>>>
> 
> [...]
> 
>>>
>>> @@ -2258,12 +2275,12 @@ static void handle_swbp(struct pt_regs *regs)
>>>       if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
>>>               goto out;
>>>
>>> -     if (!pre_ssout(uprobe, regs, bp_vaddr))
>>> -             return;
>>> +     if (pre_ssout(uprobe, regs, bp_vaddr))
>>> +             goto out;
>>>
>>
>> Regardless what pre_ssout() returns, it always reach the label 'out', so the
>> if block is unnecessary.
> 
> yep, I know, but I felt like
> 
> if (something is wrong)
>     goto out;
> 
> pattern was important to keep for each possible failing step for consistency.
> 
> so unless this is a big deal, I'd keep it as is, as in the future
> there might be some other steps after pre_ssout() before returning, so
> this is a bit more "composable"
> 
OK, I would say this conditional-check pattern is likely to be optimized away by
modern compiler.

Thanks.

> 
>>
>>
>>> -     /* arch_uprobe_skip_sstep() succeeded, or restart if can't singlestep */
>>>  out:
>>> -     put_uprobe(uprobe);
>>> +     /* arch_uprobe_skip_sstep() succeeded, or restart if can't singlestep */
>>> +     srcu_read_unlock(&uprobes_srcu, srcu_idx);
>>>  }
>>>
>>>  /*
>>
>> --
>> BR
>> Liao, Chang

-- 
BR
Liao, Chang

