Return-Path: <bpf+bounces-52232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86200A40519
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 03:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF69426FCF
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 02:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162A31FC118;
	Sat, 22 Feb 2025 02:37:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC9F78F30;
	Sat, 22 Feb 2025 02:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740191839; cv=none; b=nW6bOaJep6wwGwKKljs/owtQqHWuZscGsfb+EWy1pynWdryXTxc5bL1Sih+3u2gVlg8styv2EMlADFDKcYElGhin7Ijy3cd+ZI+SiwLWG7CQ81dfrSuK1BpJ/RTcG4i5hcQRDKAQm+tLkZWyXpQrhZkch5JSrUndpRI30b9t0RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740191839; c=relaxed/simple;
	bh=CRpZK6q8SrYcHotmyuWWZk0Z+oWiyCVtnIgJEJD0Lbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ElOcUR8SkFu8o94U0/FVx1l5clb0ibCyG18umiz6PzzpR8+WZB6gFUN55qBPlTt66NeA/8vKCm/aQv0YhIZMbIs0FHoQCJmE7vpR9RWl+1WDBvckkqlI8LeFistz8YBSnX6numyBkJv6sBBtJbVoUbzzx9/iCYBekZ5t6coQ7LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z09yz4xwfz1ltY1;
	Sat, 22 Feb 2025 10:33:15 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id A89D81A016C;
	Sat, 22 Feb 2025 10:37:13 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 22 Feb 2025 10:37:12 +0800
Message-ID: <46a48eb4-5245-81ba-9779-ace8f162c31b@huawei.com>
Date: Sat, 22 Feb 2025 10:37:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v2] uprobes: fix two zero old_folio bugs in
 __replace_page()
To: Oleg Nesterov <oleg@redhat.com>
CC: David Hildenbrand <david@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Peter Xu <peterx@redhat.com>, Ian Rogers
	<irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan"
	<kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-trace-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <wangkefeng.wang@huawei.com>, Guohanjun
	<guohanjun@huawei.com>
References: <20250221015056.1269344-1-tongtiangen@huawei.com>
 <20250221152841.GA24705@redhat.com>
From: Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <20250221152841.GA24705@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk500005.china.huawei.com (7.202.194.90)



在 2025/2/21 23:28, Oleg Nesterov 写道:
> On 02/21, Tong Tiangen wrote:
>>
>> --- a/kernel/events/uprobes.c
>> +++ b/kernel/events/uprobes.c
>> @@ -506,6 +506,11 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>>   	if (ret <= 0)
>>   		goto put_old;
>>
>> +	if (is_zero_page(old_page)) {
>> +		ret = -EINVAL;
>> +		goto put_old;
>> +	}
> 
> I agree with David, the subject looks a bit misleading.
> 
> And. I won't insist, this is cosmetic, but if you send V2 please consider
> moving the "verify_opcode()" check down, after the is_zero_page/PageCompound
> checks.
> 
> Oleg.

OK, check the validity of the old page first and modify the subject in
v3 .

Thanks.

> 
> 
> .

