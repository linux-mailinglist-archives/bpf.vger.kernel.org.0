Return-Path: <bpf+bounces-42595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAAD9A65EC
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 13:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46CF1B2DFE0
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 10:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2339D1EF93A;
	Mon, 21 Oct 2024 10:43:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933691E3DF0;
	Mon, 21 Oct 2024 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507417; cv=none; b=QbMHQdsqPNQ2PGUx2+gWHUeTPuJwf/ln5HNC51q43yle6aRc7AIwVhPJ8YgbbK1z//eAz+239CRD7fCgiQCh0nXmWIZSsB9qeZtlJUpTJhHEX+WkFS258VsKORpdzoD7aHFribDlt9Zf/A0DbqTwL1amNK8iYZorBaKcrcLbzHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507417; c=relaxed/simple;
	bh=buLKXm6cCkcUiAYpZYOIARBPH7jt7aQ/KF4wNCowmyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FXViWLfuAsKpdi2rUWfRCQwYSOyKFVCnCiIeD/uNe7F8PTmXhw+NRM1Lwvd/2wfycCYuILVVlYdpvpgrXk7qs4Mmt23ti6jMt4TNj1REdF6Rs91K3OV8l+UmCUmBLQ5M6c3XsniW+wLuXrSsQfuaSJIXQ3PR9xferBiuH9rLbqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XXBhK716Jz2Fb3H;
	Mon, 21 Oct 2024 18:42:09 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 91DCD1A0190;
	Mon, 21 Oct 2024 18:43:30 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 21 Oct 2024 18:43:29 +0800
Message-ID: <e62dbebc-d366-453a-b305-67f50baeff05@huawei.com>
Date: Mon, 21 Oct 2024 18:43:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] uprobes: Improve scalability by reducing the
 contention on siglock
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Oleg Nesterov
	<oleg@redhat.com>
References: <20240815014629.2685155-1-liaochang1@huawei.com>
 <cfa88a34-617b-9a24-a648-55262a4e8a4c@huawei.com>
 <20240915151803.GD27726@redhat.com>
 <c5765c03-a584-3527-8ca4-54b646f49433@huawei.com>
 <CAEf4BzbWLf3K4C7GT58nXZ0FJfnoeCdLeRvKtwA76oM9Jdm7jg@mail.gmail.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <CAEf4BzbWLf3K4C7GT58nXZ0FJfnoeCdLeRvKtwA76oM9Jdm7jg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/10/12 3:34, Andrii Nakryiko 写道:
> On Tue, Sep 17, 2024 at 7:05 PM Liao, Chang <liaochang1@huawei.com> wrote:
>>
>> Hi, Peter and Masami
>>
>> I look forward to your inputs on these series. Andrii has proven they are
>> hepful for uprobe scalability.
>>
>> Thanks.
>>
>> 在 2024/9/15 23:18, Oleg Nesterov 写道:
>>> Hi Liao,
>>>
>>> On 09/14, Liao, Chang wrote:
>>>>
>>>> Hi, Oleg
>>>>
>>>> Kindly ping.
>>>>
>>>> This series have been pending for a month. Is thre any issue I overlook?
>>>
>>> Well, I have already acked both patches.
>>>
>>> Please resend them to Peter/Masami, with my acks included.
>>>
> 
> Hey Liao,
> 
> I didn't see v4 from you for this patch set with Oleg's acks. Did you
> get a chance to rebase, add acks, and send the latest version?

Andrii,

I am ready to send v4 based on the latest kernel from next tree. Otherwise,
I haven't heard back from any of maintainers except Oleg, so I'm a bit unsure
if I should make further changes to this series.

> 
>>> Oleg.
>>>
>>>
>>
>> --
>> BR
>> Liao, Chang

-- 
BR
Liao, Chang


