Return-Path: <bpf+bounces-43048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA959AE6F9
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 15:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E5E1C21BCA
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 13:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBE91DD0E6;
	Thu, 24 Oct 2024 13:48:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107511D31AA
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729777706; cv=none; b=b4EDD3EJukVLUZpiH7O6Nq3296rZ+efeslfIp4P30Z/JiQvSkF6Eiw42jE7FNIi/Q9NaHEDl7U9yQfdd5R16wO9fBwYNRMOR+gJuJW7bmStxyFNbw/P/U+jHYewyNb40wiPoyo95ZABI9whK/1TsC6TfYpyXvrVnkAkJUJcNyu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729777706; c=relaxed/simple;
	bh=8yJ6nToOkeni8o/zbjbiZcaZUIdY5m1Pn2m20iOKnA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GcMN6NzPAu/7J0sOpOGutPzZ5NcO8JtSmwBSJ03eNlEhEbXH+P3xGOUZt3zZGCSU7LBnwtCm3bb7PKlrpdFX+IWp4Sr0kFgW/nCxvwo5T2bOEdGoYSflkF/wB30yA5ZWn2pHgmugUR79GdjyvtgNeQnK+JKckKWwvgbOmLPGEgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XZ6gV5pQmz4f3m88
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 21:48:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3282D1A0196
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 21:48:19 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgD3bSohUBpnHkdvEw--.45951S2;
	Thu, 24 Oct 2024 21:48:19 +0800 (CST)
Message-ID: <47082e78-e234-4487-95f2-0066e19f21dd@huaweicloud.com>
Date: Thu, 24 Oct 2024 21:48:17 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf, arm64: Fix stack frame construction for
 struct_ops trampoline
Content-Language: en-US
To: Puranjay Mohan <puranjay12@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Puranjay Mohan <puranjay@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20241019092709.128359-1-xukuohai@huaweicloud.com>
 <CAADnVQLOY-eHby6CMNXr3FvwPm85W-tWDxiWnRaR_U_=71ADuA@mail.gmail.com>
 <CANk7y0jiuiHSMTEZ_JCb4QpEPzhkK4ikicDGFa1F30DinZta8A@mail.gmail.com>
 <7226e7b8-ed73-4adb-9016-30031f1121ca@huaweicloud.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <7226e7b8-ed73-4adb-9016-30031f1121ca@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgD3bSohUBpnHkdvEw--.45951S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4kXF1DCw47Xw1UJFykGrg_yoW5Zw4Dpr
	y5ZFZIkF40vryIkw1qg3y5ZFySyr4DZ345XrZ8tw4rC3Z0gr1fAr17tay7urn3Gr1vkr1I
	qrWqqrsrJF4DAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 10/23/2024 11:16 AM, Xu Kuohai wrote:
> On 10/23/2024 7:37 AM, Puranjay Mohan wrote:
>> On Wed, Oct 23, 2024 at 12:50 AM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>>
>>> On Sat, Oct 19, 2024 at 2:15 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>>>
>>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>>
>>>> The callsite layout for arm64 fentry is:
>>>>
>>>> mov x9, lr
>>>> nop
>>>>
>>>> When a bpf prog is attached, the nop instruction is patched to a call
>>>> to bpf trampoline:
>>>>
>>>> mov x9, lr
>>>> bl <bpf trampoline>
>>>>
>>>> This passes two return addresses to bpf trampoline: the return address
>>>> for the traced function/prog, stored in x9, and the return address for
>>>> the bpf trampoline, stored in lr. To ensure stacktrace works properly,
>>>> the bpf trampoline constructs two fake function stack frames using x9
>>>> and lr.
>>>>
>>>> However, struct_ops progs are used as function callbacks and are invoked
>>>> directly, without x9 being set as the fentry callsite does. Therefore,
>>>> only one stack frame should be constructed using lr for struct_ops.
>>>
>>> Are you saying that currently stack unwinder on arm64 is
>>> completely broken for struct_ops progs ?
>>> or it shows an extra frame that doesn't have to be shown ?
>>>
>>> If former then it's certainly a bpf tree material.
>>> If latter then bpf-next will do.
>>> Pls clarify.
>>
>> It is not completely broken, only an extra garbage frame is shown
>> between the caller of the trampoline and its caller.
>>
> 
> Yep, exactly. Here is a perf script sample, where tcp_ack+0x404
> is the garbage frame.
> 
> ffffffc0801a04b4 bpf_prog_50992e55a0f655a9_bpf_cubic_cong_avoid+0x98 (bpf_prog_50992e55a0f655a9_bpf_cubic_cong_avoid)
> ffffffc0801a228c [unknown] ([kernel.kallsyms]) // bpf trampoline
> ffffffd08d362590 tcp_ack+0x798 ([kernel.kallsyms]) // caller for bpf trampoline
> ffffffd08d3621fc tcp_ack+0x404 ([kernel.kallsyms]) // garbage frame
> ffffffd08d36452c tcp_rcv_established+0x4ac ([kernel.kallsyms])
> ffffffd08d375c58 tcp_v4_do_rcv+0x1f0 ([kernel.kallsyms])
> ffffffd08d378630 tcp_v4_rcv+0xeb8 ([kernel.kallsyms])
> ...
> 
> And this sample also shows that there is no symbol for the
> struct_ops bpf trampoline. Maybe we should add symbol for it?
>

Emm, stack unwinder on x86 is completely broken for struct_ops
progs.

It's because the following function returns 0 for a struct_ops
bpf trampoline address as there is no corresponding kernel symbol,
which causes the address not to be recognized as kerneltext. As
a result, the winder stops on ip == 0.

unsigned long unwind_get_return_address(struct unwind_state *state)
{
         if (unwind_done(state))
                 return 0;

         return __kernel_text_address(state->ip) ? state->ip : 0;
}

Here is an example of broken stack trace from perf sampling, where
only one stack frame is captured:

ffffffffc000cfb4 bpf_prog_e60d93d3ec88d5ef_bpf_cubic_cong_avoid+0x78 (bpf_prog_e60d93d3ec88d5ef_bpf_cubic_cong_avoid)
(no more frames)

To fix it, I think kernel symbol should be added for struct_ops
trampoline.

>> So, this can go from the bpf-next tree. But let's wait for Xu to
>> provide more information.
>>
>> Thanks,
>> Puranjay
>>
> 


