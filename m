Return-Path: <bpf+bounces-20682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBAD841AF2
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 05:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718382849FD
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 04:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF5637712;
	Tue, 30 Jan 2024 04:19:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBBA374C9;
	Tue, 30 Jan 2024 04:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706588342; cv=none; b=VJYqkUkuJZX/s4Nx0+V3KlRsX7tGlMh+6BN1awUFahINJ6T+hOm/5Y77LjapG8Nqm9ffU0+SOS1t1UH72XiLRyLvbpSuBWDim3Sxow865u/I9WfYi8XlrFMY5bbIgALj/7Nq+KRafM7gKVy6slBBM+eQwZkfTF884tW4ew20WPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706588342; c=relaxed/simple;
	bh=h6snNFdka27Mpzx+nJnLZ5KYtjZX57yK9AQSgiGflu4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HkAwhXURzI6rbr193HSUEwPIH2tW6oHrwrQbla3EAZHWfI2A5ztjpcFdLuMuuEQ54RQmwxYpxB1DcQA+p2e53xXyMfdwSjZkGQl7i8S1DAbKKXkoEv+ycZOtzFjJ5xZlHNXclje6Mm4lGOjHv439Ta2nunAw70AcLjYuyXIE+d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TPBkM1VJBz4f3m7Z;
	Tue, 30 Jan 2024 12:18:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A7CFE1A0199;
	Tue, 30 Jan 2024 12:18:57 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBXdA2reLhluSSoCQ--.26777S2;
	Tue, 30 Jan 2024 12:18:54 +0800 (CST)
Subject: Re: [PATCH bpf v2 2/3] x86/mm: Disallow vsyscall page read for
 copy_from_kernel_nofault()
To: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org, bpf@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, xingwei lee <xrivendell7@gmail.com>,
 Jann Horn <jannh@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 houtao1@huawei.com
References: <20240126115423.3943360-1-houtao@huaweicloud.com>
 <20240126115423.3943360-3-houtao@huaweicloud.com>
 <51d92a32-3d0b-41c5-96ad-0739c6f80256@intel.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <930bbcfe-6697-e8e8-5198-8d9d57beb6b2@huaweicloud.com>
Date: Tue, 30 Jan 2024 12:18:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <51d92a32-3d0b-41c5-96ad-0739c6f80256@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBXdA2reLhluSSoCQ--.26777S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKF18tF1UWry8tr4rXw48Crg_yoW7Xryfpa
	98Ca17KF4jkr18AanrX34v9ayrJa4ktF45WryvyFWrZ39IgFnIyrWDuas3XrZrtFnrKw4x
	Xr43Aryqvw1DJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 1/30/2024 7:50 AM, Sohil Mehta wrote:
> Hi Hou Tao,
>
> I agree to your approach in this patch. Please see some comments below.
>
> On 1/26/2024 3:54 AM, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> When trying to use copy_from_kernel_nofault() to read vsyscall page
>> through a bpf program, the following oops was reported:

[SNIP]
>> It seems the occurrence of oops depends on SMAP feature of CPU. It
>> happens as follow: a bpf program uses bpf_probe_read_kernel() to read
>> from vsyscall page, bpf_probe_read_kernel() invokes
>> copy_from_kernel_nofault() in turn and then invokes __get_user_asm().
>> Because the vsyscall page address is not readable for kernel space,
>> a page fault exception is triggered accordingly, handle_page_fault()
>> considers the vsyscall page address as a userspace address instead of a
>> kernel space address, so the fix-up set-up by bpf isn't applied. Because
>> the CPU has SMAP feature and the access happens in kernel mode, so
>> page_fault_oops() is invoked and an oops happens. If these is no SMAP
>> feature, the fix-up set-up by bpf will be applied and
>> copy_from_kernel_nofault() will return -EFAULT instead.
>>
> I find this paragraph to be a bit hard to follow. I think we can
> minimize the reference to SMAP here since it is only helping detect
> cross address space accesses.  How about something like the following:
>
> The oops is triggered when:
>
> 1) A bpf program uses bpf_probe_read_kernel() to read from the vsyscall
> page and invokes copy_from_kernel_nofault() which in turn calls
> __get_user_asm().
>
> 2) Because the vsyscall page address is not readable from kernel space,
> a page fault exception is triggered accordingly.
>
> 3) handle_page_fault() considers the vsyscall page address as a user
> space address instead of a kernel space address. This results in the
> fix-up setup by bpf not being applied and a page_fault_oops() is invoked
> due to SMAP.

Thanks for the rephrasing. It is much better now.
>> Considering handle_page_fault() has already considered the vsyscall page
>> address as a userspace address, fix the problem by disallowing vsyscall
>> page read for copy_from_kernel_nofault().
>>
> I agree, following the same approach as handle_page_fault() seems
> reasonable.
>
>> Originally-by: Thomas Gleixner <tglx@linutronix.de>
>> Reported-by: syzbot+72aa0161922eba61b50e@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/bpf/CAG48ez06TZft=ATH1qh2c5mpS5BT8UakwNkzi6nvK5_djC-4Nw@mail.gmail.com
>> Reported-by: xingwei lee <xrivendell7@gmail.com>
>> Closes: https://lore.kernel.org/bpf/CABOYnLynjBoFZOf3Z4BhaZkc5hx_kHfsjiW+UWLoB=w33LvScw@mail.gmail.com
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  arch/x86/mm/maccess.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/x86/mm/maccess.c b/arch/x86/mm/maccess.c
>> index 6993f026adec9..d9272e1db5224 100644
>> --- a/arch/x86/mm/maccess.c
>> +++ b/arch/x86/mm/maccess.c
>> @@ -3,6 +3,8 @@
>>  #include <linux/uaccess.h>
>>  #include <linux/kernel.h>
>>  
>> +#include <asm/vsyscall.h>
>> +
>>  #ifdef CONFIG_X86_64
>>  bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
>>  {
>> @@ -15,6 +17,13 @@ bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
>>  	if (vaddr < TASK_SIZE_MAX + PAGE_SIZE)
>>  		return false;
>>  
>> +	/* Also consider the vsyscall page as userspace address. Otherwise,
>> +	 * reading the vsyscall page in copy_from_kernel_nofault() may
>> +	 * trigger an oops due to an unhandled page fault.
>> +	 */
> x86 prefers a slightly different style for multi-line comments. Please
> refer to https://docs.kernel.org/process/maintainer-tip.html#comment-style.

I see. Will update.
>
> How about rewording the above as:
>
> /*
>  * Reading from the vsyscall page may cause an unhandled fault in
>  * certain cases.  Though it is at an address above TASK_SIZE_MAX, it is
>  * usually considered as a user space address.
>  */

Thanks for the rewording. Will do in v3.
>
>> +	if (is_vsyscall_vaddr(vaddr))
>> +		return false;
>> +
> It would have been convenient if we had a common check for whether a
> particular address is a kernel address or not. fault_in_kernel_space()
> serves that purpose to an extent in other places.
>
> I thought we could rename fault_in_kernel_space() to
> vaddr_in_kernel_space() and use it here. But the check in
> copy_from_kernel_nofault_allowed() includes the user guard page as well.
> So the checks wouldn't exactly be the same.
>
> I am unsure of the implications if we get rid of that difference. Maybe
> we can leave it as-is for now unless someone else chimes in.

There is other difference between fault_in_kernel_space() and
copy_from_kernel_nofault_allowed(). fault_in_kernel_space() uses address
>= TASK_SIZE_MAX to check the kernel space address, but
copy_from_kernel_nofault_allowed() uses vaddr >= TASK_SIZE_MAX +
PAGE_SIZE to check the kernel space address, so I prefer to keep it as-is.
>
> Sohil


