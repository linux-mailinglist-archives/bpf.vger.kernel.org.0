Return-Path: <bpf+bounces-52243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C959EA4060C
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 08:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90153BEADC
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 07:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033AA20127A;
	Sat, 22 Feb 2025 07:19:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A6F7494;
	Sat, 22 Feb 2025 07:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740208774; cv=none; b=PPjmr5SfCOdQB/hd+pnikGrIxQ3Kd4FINq28Nw8VoJb9lpir1KekZrPoerRn5mwz7VPtN4ALvFY3v5SO0pf8GhJVWeoOUj2SRYMtAHlJyxQs19AWx74WnoDKkncnCH1FSw8eAELeq1V8qRFfxL6h/8bEPCRXdg7VPSpzXNwlFvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740208774; c=relaxed/simple;
	bh=R5+4K/Nzsi5fbnQc0W9jCxIEubmmJjFdB88aAxqxfu4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=bBGUPKogrHrAOHemJpl+KK7xRxKV33rElJ6ts6dqHaiHBHyOFsuJXwzK3COkMJvnAFVGT64wu01bxzN3uVlpp8d4HnqMQj7k/UuIYnj9mq0uPXbX0b/zDSS+hhI5PngDrF5n1ME1qH9SHwIK95y5mAl4bX10NfGq/VQ57JJigvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Z0JDw3nVGzvWpS;
	Sat, 22 Feb 2025 15:15:44 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 20EC4140154;
	Sat, 22 Feb 2025 15:19:27 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 22 Feb 2025 15:19:25 +0800
Message-ID: <ef999493-cac0-68bb-2684-97da0fb8b583@huawei.com>
Date: Sat, 22 Feb 2025 15:19:24 +0800
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
From: Tong Tiangen <tongtiangen@huawei.com>
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
 <46a48eb4-5245-81ba-9779-ace8f162c31b@huawei.com>
In-Reply-To: <46a48eb4-5245-81ba-9779-ace8f162c31b@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk500005.china.huawei.com (7.202.194.90)



在 2025/2/22 10:37, Tong Tiangen 写道:
> 
> 
> 在 2025/2/21 23:28, Oleg Nesterov 写道:
>> On 02/21, Tong Tiangen wrote:
>>>
>>> --- a/kernel/events/uprobes.c
>>> +++ b/kernel/events/uprobes.c
>>> @@ -506,6 +506,11 @@ int uprobe_write_opcode(struct arch_uprobe 
>>> *auprobe, struct mm_struct *mm,
>>>       if (ret <= 0)
>>>           goto put_old;
>>>
>>> +    if (is_zero_page(old_page)) {
>>> +        ret = -EINVAL;
>>> +        goto put_old;
>>> +    }
>>
>> I agree with David, the subject looks a bit misleading.
>>
>> And. I won't insist, this is cosmetic, but if you send V2 please consider
>> moving the "verify_opcode()" check down, after the 
>> is_zero_page/PageCompound
>> checks.
>>
>> Oleg.
> 
> OK, check the validity of the old page first and modify the subject in
> v3 .
> 
> Thanks.

I'm going to add a new patch to moving the "verify_opcode()" check down
, IIUC that "!PageAnon(old_page)" below also needs to be moved together,
and as David said this can be triggered by user space, so delete the use
  of "WARN", as follows:


@@ -502,20 +502,16 @@ int uprobe_write_opcode(struct arch_uprobe 
*auprobe, struct mm_struct *mm,
         if (IS_ERR(old_page))
                 return PTR_ERR(old_page);

-       ret = verify_opcode(old_page, vaddr, &opcode);
-       if (ret <= 0)
+       ret = -EINVAL;
+       if (is_zero_page(old_page))
                 goto put_old;

-       if (is_zero_page(old_page)) {
-               ret = -EINVAL;
+       if (!is_register && (PageCompound(old_page) || !PageAnon(old_page)))
                 goto put_old;
-       }

-       if (WARN(!is_register && PageCompound(old_page),
-                "uprobe unregister should never work on compound 
page\n")) {
-               ret = -EINVAL;
+       ret = verify_opcode(old_page, vaddr, &opcode);
+       if (ret <= 0)
                 goto put_old;
-       }

         /* We are going to replace instruction, update ref_ctr. */
         if (!ref_ctr_updated && uprobe->ref_ctr_offset) {
@@ -526,10 +522,6 @@ int uprobe_write_opcode(struct arch_uprobe 
*auprobe, struct mm_struct *mm,
                 ref_ctr_updated = 1;
         }

-       ret = 0;
-       if (!is_register && !PageAnon(old_page))
-               goto put_old;
-
         ret = anon_vma_prepare(vma);

Thanks.
> 
>>
>>
>> .
> 
> .

