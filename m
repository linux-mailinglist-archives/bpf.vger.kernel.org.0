Return-Path: <bpf+bounces-32556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C69F190FB70
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 04:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47281282A5A
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 02:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD881D540;
	Thu, 20 Jun 2024 02:59:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB2617721;
	Thu, 20 Jun 2024 02:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718852351; cv=none; b=mKnJsdacpKyHjOeCRVIaI5D4MkZGhqAVX6t7ejEVpdIJmn3ow2fw1p8aLxkZVPkfsOPz96SZOS8ACGMYR2wLL+qtaLu2HcMGeCthDauaKTOMmdHiWB3oW/ZyBeSVfu8tP8XHRikuwIYO2ExffshEqs0pCQa83nsW78Xy5s+FWd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718852351; c=relaxed/simple;
	bh=vuTW9cPwOPrJ7ddPWRGrsEOT4sKaReYqjycgd8vf8ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rrW24zCCxdcOcb9nmDAyFK4tlEc0THPsAURfXcZvjZ+6mJHoM7NRPWQTPXhxfNs3zfSIyYZQe7UxhO/1i5mjH703yaCUbIg7CS4C8d4yBgSo37C5IXrEohhSxcJGP7vpXVAZ03yQdktyp1/v1cQPfZb5aHdA9laBGTO1egle0Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4W4Q8851z6z1X3tr;
	Thu, 20 Jun 2024 10:55:04 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 690F2140153;
	Thu, 20 Jun 2024 10:58:59 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 10:58:58 +0800
Message-ID: <5cb622c9-46f4-c1e4-9932-774be4ed0735@huawei.com>
Date: Thu, 20 Jun 2024 10:58:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH bpf-next] uprobes: Fix the xol slots reserved for
 uretprobe trampoline
To: Jiri Olsa <olsajiri@gmail.com>
CC: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <oleg@redhat.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<nathan@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<mark.rutland@arm.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20240619013411.756995-1-liaochang1@huawei.com>
 <ZnMFtCsRCVZ6pkp8@krava>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <ZnMFtCsRCVZ6pkp8@krava>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200013.china.huawei.com (7.221.188.133)

Hi, Jiri

在 2024/6/20 0:22, Jiri Olsa 写道:
> On Wed, Jun 19, 2024 at 01:34:11AM +0000, Liao Chang wrote:
>> When the new uretprobe system call was added [1], the xol slots reserved
>> for the uretprobe trampoline might be insufficient on some architecture.
> 
> hum, uretprobe syscall is x86_64 specific, nothing was changed wrt slots
> or other architectures.. could you be more specific in what's changed?

I observed a significant performance degradation when using uprobe to trace Redis
on arm64 machine. redis-benchmark showed a decrease of around 7% with uprobes
attached to two hot functions, and a much worse result with uprobes on more hot
functions. Here is a samll snapshot of benchmark result.

No uprobe
---------
SET: 73686.54 rps
GET: 73702.83 rps

Uprobes on two hot functions
----------------------------
SET: 68441.59 rps, -7.1%
GET: 68951.25 rps, -6.4%

Uprobes at three hot functions
------------------------------
SET: 40953.39 rps，-44.4%
GET: 41609.45 rps，-43.5%

To investigate the potential improvements, i ported the uretprobe syscall and
trampoline feature for arm64. The trampoline code used on arm64 looks like this:

uretprobe_trampoline_for_arm64:
	str x8, [sp, #-8]!
	mov x8, __NR_uretprobe
	svc #0

Due to arm64 uses fixed-lenghth instruction of 4 bytes, the total size of the trampoline
code is 12 bytes, since the ixol slot size is typical 4 bytes, the misfit bewteen the
slot size of trampoline size requires more than one slot to reserve.

Thanks.

> 
> thanks,
> jirka
> 
>> For example, on arm64, the trampoline is consist of three instructions
>> at least. So it should mark enough bits in area->bitmaps and
>> and area->slot_count for the reserved slots.
>>
>> [1] https://lore.kernel.org/all/20240611112158.40795-4-jolsa@kernel.org/
>>
>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>> ---
>>  kernel/events/uprobes.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
>> index 2816e65729ac..efd2d7f56622 100644
>> --- a/kernel/events/uprobes.c
>> +++ b/kernel/events/uprobes.c
>> @@ -1485,7 +1485,7 @@ void * __weak arch_uprobe_trampoline(unsigned long *psize)
>>  static struct xol_area *__create_xol_area(unsigned long vaddr)
>>  {
>>  	struct mm_struct *mm = current->mm;
>> -	unsigned long insns_size;
>> +	unsigned long insns_size, slot_nr;
>>  	struct xol_area *area;
>>  	void *insns;
>>  
>> @@ -1508,10 +1508,13 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
>>  
>>  	area->vaddr = vaddr;
>>  	init_waitqueue_head(&area->wq);
>> -	/* Reserve the 1st slot for get_trampoline_vaddr() */
>> -	set_bit(0, area->bitmap);
>> -	atomic_set(&area->slot_count, 1);
>>  	insns = arch_uprobe_trampoline(&insns_size);
>> +	/* Reserve enough slots for the uretprobe trampoline */
>> +	for (slot_nr = 0;
>> +	     slot_nr < max((insns_size / UPROBE_XOL_SLOT_BYTES), 1);
>> +	     slot_nr++)
>> +		set_bit(slot_nr, area->bitmap);
>> +	atomic_set(&area->slot_count, slot_nr);
>>  	arch_uprobe_copy_ixol(area->pages[0], 0, insns, insns_size);
>>  
>>  	if (!xol_add_vma(mm, area))
>> -- 
>> 2.34.1
>>

-- 
BR
Liao, Chang

