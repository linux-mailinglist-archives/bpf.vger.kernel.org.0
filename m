Return-Path: <bpf+bounces-32555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F36790FB6D
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 04:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598351C21147
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 02:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5627A1CFA9;
	Thu, 20 Jun 2024 02:56:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3CC171A1;
	Thu, 20 Jun 2024 02:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718852191; cv=none; b=fb7bSi18O5dDJ/Vx68WgnZyLru/my6PwEej6KV6NbJR/ca7XgDJh+3rU62xG78H3DM7Y3xuRAtDZ2tswTXdC1j2KKc1IVBYDa0g0NTXSF2Idvu1o3yjFM2swEBaadwkSyB/RSNvTTcc+4oJq1S30Is8gBafpRovqur3D54h6LZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718852191; c=relaxed/simple;
	bh=1Xmnfgp1ItF0jRXSWd8jcVkwr7/r+9fxi3baqS1IOtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qI3x4NDVS65XdQ3gwLwv4sST4JBPaxr3iUKZ52eJNOv6iz32btqk4qHRunEaiPRFZ7IFWSgcVlXGcX2yd7gw7jZ0GtG3ItrP8EkEMUwCYSGbtULDGWwKJXaDWnN92cgHMTpggJOrLrq9BzSbDJ5DDxX6hVeCztAyQkG0T+J2s8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4W4Pj972xmz2Ck5J;
	Thu, 20 Jun 2024 10:35:09 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 5AEC91A016C;
	Thu, 20 Jun 2024 10:39:04 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 10:39:03 +0800
Message-ID: <7cfa9f1f-d9ce-b6bb-3fe0-687fae9c77c4@huawei.com>
Date: Thu, 20 Jun 2024 10:39:03 +0800
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
To: Oleg Nesterov <oleg@redhat.com>
CC: <jolsa@kernel.org>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<nathan@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<mark.rutland@arm.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20240619013411.756995-1-liaochang1@huawei.com>
 <20240619143852.GA24240@redhat.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20240619143852.GA24240@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200013.china.huawei.com (7.221.188.133)

Hi, Oleg

在 2024/6/19 22:38, Oleg Nesterov 写道:
> On 06/19, Liao Chang wrote:
>>
>> When the new uretprobe system call was added [1], the xol slots reserved
>> for the uretprobe trampoline might be insufficient on some architecture.
> 
> Confused... this doesn't depend on the change above?

You are right, the uretprobe syscall is specifc to x86_64. This patch wouldn't
address that issue. However, when i asm porting uretprobe trampoline to arm64
to explore its benefits on that architecture, i discovered the problem that
single slot is not large enought for trampoline code.

> 
>> For example, on arm64, the trampoline is consist of three instructions
>> at least. So it should mark enough bits in area->bitmaps and
>> and area->slot_count for the reserved slots.
> 
> Do you mean that on arm64 UPROBE_SWBP_INSN_SIZE > UPROBE_XOL_SLOT_BYTES ?
> 
>>From arch/arm64/include/asm/uprobes.h
> 
> 	#define MAX_UINSN_BYTES		AARCH64_INSN_SIZE
> 
> 	#define UPROBE_SWBP_INSN	cpu_to_le32(BRK64_OPCODE_UPROBES)
> 	#define UPROBE_SWBP_INSN_SIZE	AARCH64_INSN_SIZE
> 	#define UPROBE_XOL_SLOT_BYTES	MAX_UINSN_BYTES
> 
> 	typedef __le32 uprobe_opcode_t;
> 
> 	struct arch_uprobe_task {
> 	};
> 
> 	struct arch_uprobe {
> 		union {
> 			u8 insn[MAX_UINSN_BYTES];
> 			u8 ixol[MAX_UINSN_BYTES];
> 
> So it seems that UPROBE_SWBP_INSN_SIZE == MAX_UINSN_BYTES and it must
> be less than UPROBE_XOL_SLOT_BYTES, otherwise
> 
> arch_uprobe_copy_ixol(..., uprobe->arch.ixol, sizeof(uprobe->arch.ixol))
> in xol_get_insn_slot() won't fit the slot as well?
This real reason is that the current implmentation seems to assume the
ixol slot has enough space for the uretprobe trampoline. This assumption
is true for x86_64, since the ixol slot is size of 128 bytes.

From arch/x86/include/asm/uprobes.h
	#define UPROBE_XOL_SLOT_BYTES	128

However, it is not large enough for arm64, the size of which is MAX_UINSN_BYTES
(4bytes).

From arch/arm64/include/asm/uprobes.h

 	#define MAX_UINSN_BYTES		AARCH64_INSN_SIZE // 4bytes
 	...
 	#define UPROBE_XOL_SLOT_BYTES	MAX_UINSN_BYTES

Here is an exmample of the uretprobe trampoline code used for arm64:

uretprobe_trampoline_for_arm64:
	str x8, [sp, #-8]!
	mov x8, __NR_uretprobe
	svc #0

Above code is 12 bytes in size, exceeding the capacity of single ixol slot
on arm64, so three slots are necessary to be reserved for the entire trampoline.

Thanks.

> 
> OTOH, it look as if UPROBE_SWBP_INSN_SIZE == UPROBE_XOL_SLOT_BYTES, so
> I don't understand the problem...
> 
> Oleg.
> 
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
> 
> 

-- 
BR
Liao, Chang

