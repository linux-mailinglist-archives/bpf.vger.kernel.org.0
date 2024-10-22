Return-Path: <bpf+bounces-42748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FDA9A99BB
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 08:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E77A1F23D76
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 06:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A544145B07;
	Tue, 22 Oct 2024 06:19:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE821E495;
	Tue, 22 Oct 2024 06:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729577942; cv=none; b=bCJZIHCzR/89jL2QPXW/vo+STiB3ODI/Y4W73rTh5B2lnOb+uJyEKtgPWnMczxTKCYDHeglhPUiQ0DM8kmJs4A5IV6bQ/gTvF/lWhCKbvoA3aDHpM35WDwJ9aCsqqgHp4VTYavaG5etBETIx6Rxvnuu4TwlrRb6sqBVIrY52yZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729577942; c=relaxed/simple;
	bh=tLiAn0BeLFoim24NopHHPe7F7XmfCPa+lJJMTWGqkMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=piqLs/HJjdMZ59EUKWw8geKvJBI4b1zd6gzjioxN6R/wk48hkB+0AzN+cSM5WMUa/Et6FItpoB7VALh8CNaXem5LF44c7E5K4+9AM/bZLw3zFqZlxWArAhavEsW315i/OBtD7D0yRFbqNfgmW1zt3LFui0f30pDn1jhvknaZpVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XXhmX0DYXz1jBJk;
	Tue, 22 Oct 2024 14:17:32 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C7B11A016C;
	Tue, 22 Oct 2024 14:18:53 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 22 Oct 2024 14:18:52 +0800
Message-ID: <04cecf07-85c0-4830-9f98-ffe96923d440@huawei.com>
Date: Tue, 22 Oct 2024 14:18:52 +0800
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
 <e62dbebc-d366-453a-b305-67f50baeff05@huawei.com>
 <CAEf4BzYUdPJrgy1Dqinxk5ATPxA8WCTzQW3QcWobZpXjiYDZNw@mail.gmail.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <CAEf4BzYUdPJrgy1Dqinxk5ATPxA8WCTzQW3QcWobZpXjiYDZNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/10/22 1:18, Andrii Nakryiko 写道:
> On Mon, Oct 21, 2024 at 3:43 AM Liao, Chang <liaochang1@huawei.com> wrote:
>>
>>
>>
>> 在 2024/10/12 3:34, Andrii Nakryiko 写道:
>>> On Tue, Sep 17, 2024 at 7:05 PM Liao, Chang <liaochang1@huawei.com> wrote:
>>>>
>>>> Hi, Peter and Masami
>>>>
>>>> I look forward to your inputs on these series. Andrii has proven they are
>>>> hepful for uprobe scalability.
>>>>
>>>> Thanks.
>>>>
>>>> 在 2024/9/15 23:18, Oleg Nesterov 写道:
>>>>> Hi Liao,
>>>>>
>>>>> On 09/14, Liao, Chang wrote:
>>>>>>
>>>>>> Hi, Oleg
>>>>>>
>>>>>> Kindly ping.
>>>>>>
>>>>>> This series have been pending for a month. Is thre any issue I overlook?
>>>>>
>>>>> Well, I have already acked both patches.
>>>>>
>>>>> Please resend them to Peter/Masami, with my acks included.
>>>>>
>>>
>>> Hey Liao,
>>>
>>> I didn't see v4 from you for this patch set with Oleg's acks. Did you
>>> get a chance to rebase, add acks, and send the latest version?
>>
>> Andrii,
>>
>> I am ready to send v4 based on the latest kernel from next tree. Otherwise,
>> I haven't heard back from any of maintainers except Oleg, so I'm a bit unsure
>> if I should make further changes to this series.
>>
> 
> Let's just rebase to the latest tip/perf/core and resend with Oleg's
> ack. Hopefully this should be enough.

OK, the v4 is on the way with Masami's Acked-by.

> 
>>>
>>>>> Oleg.
>>>>>
>>>>>
>>>>
>>>> --
>>>> BR
>>>> Liao, Chang
>>
>> --
>> BR
>> Liao, Chang
>>

-- 
BR
Liao, Chang


