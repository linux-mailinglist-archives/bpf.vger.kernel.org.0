Return-Path: <bpf+bounces-20307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B0B83BA7D
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 08:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0107D1F22781
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 07:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F070811724;
	Thu, 25 Jan 2024 07:18:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30FB125AC;
	Thu, 25 Jan 2024 07:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706167093; cv=none; b=robchwaiK2c9jojkAA4ZS+bExMv51Qv2/O596/Av1hmCDT78Xea0UAPFyD7IGqV8KLxnOOoZGwr9edKvOl3SC292a8zZ6Ja903rCgefz0tKX8qkOfOtQ2c0OZHLxlIBNU1JM/BDuFlydCsbDyY7iNJH5Faeo+TiT5xmv02/4MCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706167093; c=relaxed/simple;
	bh=v9CmbAhgiwRyHdIyDJQME8LxQd+xB3pL3KsdDf+BcCw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XMfwQ+h0Q4RpVR9DhEr/UceYOc/M/j8GZY0G0ibTAA+3BMO69vGAWGmrcMgnojvqa/Lbh96UV2n/O8wo50dz7BC+JgaHGvMVenMaWP3vV9AvTgenK+p+9pj6npfe2kvEpCGI+Kg25MlQuJJz03lqTajAJ244tm44R7c4WQuDpe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TLBxS5mf5z4f3k6C;
	Thu, 25 Jan 2024 15:18:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2D4C91A0171;
	Thu, 25 Jan 2024 15:18:07 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgBXXG4rC7JlVenABw--.25628S2;
	Thu, 25 Jan 2024 15:18:06 +0800 (CST)
Subject: Re: [PATCH bpf 2/3] x86/mm: Disallow vsyscall page read for
 copy_from_kernel_nofault()
To: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org, bpf@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, xingwei lee <xrivendell7@gmail.com>,
 Jann Horn <jannh@google.com>, houtao1@huawei.com
References: <20240119073019.1528573-1-houtao@huaweicloud.com>
 <20240119073019.1528573-3-houtao@huaweicloud.com>
 <e83eb3e8-6d08-462b-9ffe-d843e439d7da@intel.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <6f1aa71b-13f3-0972-3cb0-62f431de7e48@huaweicloud.com>
Date: Thu, 25 Jan 2024 15:18:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e83eb3e8-6d08-462b-9ffe-d843e439d7da@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgBXXG4rC7JlVenABw--.25628S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4rGr1ktw4DXFWkKw17ZFb_yoW7Jw45pw
	18A3yUtFW8Ar1rAFsFq34qqFyrJ348Ja15Grn5tF1rZw1jgF1YqrWDWa4jgF17Jr4xKw1x
	tw4UXr1qvw1UJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 1/23/2024 8:18 AM, Sohil Mehta wrote:
> On 1/18/2024 11:30 PM, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> When trying to use copy_from_kernel_nofault() to read vsyscall page
>> through a bpf program, the following oops was reported:
>>
>>   BUG: unable to handle page fault for address: ffffffffff600000
>>   #PF: supervisor read access in kernel mode
>>   #PF: error_code(0x0000) - not-present page
>>   PGD 3231067 P4D 3231067 PUD 3233067 PMD 3235067 PTE 0
>>   Oops: 0000 [#1] PREEMPT SMP PTI
>>   CPU: 1 PID: 20390 Comm: test_progs ...... 6.7.0+ #58
>>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996) ......
>>   RIP: 0010:copy_from_kernel_nofault+0x6f/0x110
>>   ......
>>   Call Trace:
>>    <TASK>
>>    ? copy_from_kernel_nofault+0x6f/0x110
>>    bpf_probe_read_kernel+0x1d/0x50
>>    bpf_prog_2061065e56845f08_do_probe_read+0x51/0x8d
>>    trace_call_bpf+0xc5/0x1c0
>>    perf_call_bpf_enter.isra.0+0x69/0xb0
>>    perf_syscall_enter+0x13e/0x200
>>    syscall_trace_enter+0x188/0x1c0
>>    do_syscall_64+0xb5/0xe0
>>    entry_SYSCALL_64_after_hwframe+0x6e/0x76
>>    </TASK>
>>   ......
>>   ---[ end trace 0000000000000000 ]---
>>
>> The oops happens as follows: A bpf program uses bpf_probe_read_kernel()
>> to read from vsyscall page, bpf_probe_read_kernel() invokes
>> copy_from_kernel_nofault() in turn and then invokes __get_user_asm(). A
>> page fault exception is triggered accordingly, but handle_page_fault()
>> considers the vsyscall page address as a userspace address instead of
>> a kernel space address, so the fix-up set-up by bpf isn't applied.
> This comment and the one in the code below seem contradictory and
> confusing. Do we want the vsyscall page address to be considered as a
> userspace address or not?

Now handle_page_fault() has already considered the vsyscall page as a
userspace address, and in the patch we update copy_from_kernel_nofault()
to consider vsyscall page as a userspapce address as well.
>
> IIUC, the issue here is that the vsyscall page (in xonly mode) is not
> really mapped and therefore running copy_from_kernel_nofault() on this
> address is incorrect. This patch fixes this by making
> copy_from_kernel_nofault() return an error for a vsyscall address.
>

Yes, but the issue may occur for vsyscall=none case as well. Because
fault_in_kernel_space() invoked by handle_page_fault() will return
false, so in do_user_addr_fault(), when smap feature is enabled, the
invocation of copy_from_kernel_nofault() will trigger oops due to the
following code snippet:

        if (unlikely(cpu_feature_enabled(X86_FEATURE_SMAP) &&
                     !(error_code & X86_PF_USER) &&
                     !(regs->flags & X86_EFLAGS_AC))) {
                /*
                 * No extable entry here.  This was a kernel access to an
                 * invalid pointer.  get_kernel_nofault() will not get here.
                 */
                page_fault_oops(regs, error_code, address);
                return;
        }

>> Because the exception happens in kernel space and page fault handling is
>> disabled, page_fault_oops() is invoked and an oops happens.
>>
>> Fix it by disallowing vsyscall page read for copy_from_kernel_nofault().
>>
> [Maybe I have misunderstood the issue here and following questions are
> not even relevant.]
>
> But, what about vsyscall=emulate? In that mode the page is actually
> mapped. Would we want the page read to go through then?

Er, Now the vsyscall page is considered as a userspace address, I think
we should reject its read through copy_from_kernel_nofault() even it is
mapped.

>
>> Originally-from: Thomas Gleixner <tglx@linutronix.de>
> Documentation/process/maintainer-tip.rst says to use "Originally-by:"

Thanks for the tip. Will update.
>
>
>> diff --git a/arch/x86/mm/maccess.c b/arch/x86/mm/maccess.c
>> index 6993f026adec9..bb454e0abbfcf 100644
>> --- a/arch/x86/mm/maccess.c
>> +++ b/arch/x86/mm/maccess.c
>> @@ -3,6 +3,8 @@
>>  #include <linux/uaccess.h>
>>  #include <linux/kernel.h>
>>  
>> +#include "mm_internal.h"
>> +
>>  #ifdef CONFIG_X86_64
>>  bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
>>  {
>> @@ -15,6 +17,10 @@ bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
>>  	if (vaddr < TASK_SIZE_MAX + PAGE_SIZE)
>>  		return false;
>>  
>> +	/* vsyscall page is also considered as userspace address. */
> A bit more explanation about why this should happen might be useful.
>
>> +	if (is_vsyscall_vaddr(vaddr))
>> +		return false;
>> +
>>  	/*
>>  	 * Allow everything during early boot before 'x86_virt_bits'
>>  	 * is initialized.  Needed for instruction decoding in early


