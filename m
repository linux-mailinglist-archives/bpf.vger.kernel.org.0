Return-Path: <bpf+bounces-43142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E729AFB84
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 09:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1FD1C2278B
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 07:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB281C07F7;
	Fri, 25 Oct 2024 07:51:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3631C7B7C
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 07:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729842681; cv=none; b=TOlzpYIKryZ7Ksurf9wFeKMS8ApY7rshNqQrbxkRU9dHGHL9IT5DF1APX8rDeFfYGnL6OlAa4PKZBRzSCLW2bk8PlQyEkcfTzSqQJ6DJbwiV1hKyXETOEMwpiR2w/ZNXVZ+wf+Omx+BjP7UMy0JuTAeRn9wR/YsNLDT0fQSiWhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729842681; c=relaxed/simple;
	bh=mrXUNWtuWaN72O2CNzRFUpa0PkbCNu+QX8jXhsThS88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k55iWTg+Bb54k+E0rPlJP775qrmY/WUTVLWdt0Kn1XQau30Q6/3/9Nwec2IQYRWOuzQjibETua1NBuJMRHp1CtKlrkt9kNadKWEWBTVouROKvhhcClMPF0rNpY0M1trka7typoflX5+HSGsZqIrwX/oI8XQ3m+ZJzvOeASRwgks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XZZhx47zxz4f3m6g
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 15:50:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DF1E21A058E
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 15:51:15 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgB398PyTRtnzlhEFA--.3489S2;
	Fri, 25 Oct 2024 15:51:15 +0800 (CST)
Message-ID: <32bf0704-d178-4728-8b70-5f6603723250@huaweicloud.com>
Date: Fri, 25 Oct 2024 15:51:14 +0800
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
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, bpf <bpf@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Puranjay Mohan <puranjay@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20241019092709.128359-1-xukuohai@huaweicloud.com>
 <CAADnVQLOY-eHby6CMNXr3FvwPm85W-tWDxiWnRaR_U_=71ADuA@mail.gmail.com>
 <CANk7y0jiuiHSMTEZ_JCb4QpEPzhkK4ikicDGFa1F30DinZta8A@mail.gmail.com>
 <7226e7b8-ed73-4adb-9016-30031f1121ca@huaweicloud.com>
 <47082e78-e234-4487-95f2-0066e19f21dd@huaweicloud.com>
 <CAADnVQKcwTstR5y3e1wNj-Agq7DuPNYOdQWkf33cLOBYiYGiug@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAADnVQKcwTstR5y3e1wNj-Agq7DuPNYOdQWkf33cLOBYiYGiug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB398PyTRtnzlhEFA--.3489S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1xKF4kXF15Ar43KrW7Arb_yoWrGw1kpr
	yrXFWYkr4jvryqkw1qgr15ZFySyr4DX345WrZ8tw4fC3Z0qr1fJr17ta13urn3Gr1vkr12
	qr4DtFZrJF4DAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 10/25/2024 12:24 AM, Alexei Starovoitov wrote:
> On Thu, Oct 24, 2024 at 6:48 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> On 10/23/2024 11:16 AM, Xu Kuohai wrote:
>>> On 10/23/2024 7:37 AM, Puranjay Mohan wrote:
>>>> On Wed, Oct 23, 2024 at 12:50 AM Alexei Starovoitov
>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>>
>>>>> On Sat, Oct 19, 2024 at 2:15 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>>>>>
>>>>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>>>>
>>>>>> The callsite layout for arm64 fentry is:
>>>>>>
>>>>>> mov x9, lr
>>>>>> nop
>>>>>>
>>>>>> When a bpf prog is attached, the nop instruction is patched to a call
>>>>>> to bpf trampoline:
>>>>>>
>>>>>> mov x9, lr
>>>>>> bl <bpf trampoline>
>>>>>>
>>>>>> This passes two return addresses to bpf trampoline: the return address
>>>>>> for the traced function/prog, stored in x9, and the return address for
>>>>>> the bpf trampoline, stored in lr. To ensure stacktrace works properly,
>>>>>> the bpf trampoline constructs two fake function stack frames using x9
>>>>>> and lr.
>>>>>>
>>>>>> However, struct_ops progs are used as function callbacks and are invoked
>>>>>> directly, without x9 being set as the fentry callsite does. Therefore,
>>>>>> only one stack frame should be constructed using lr for struct_ops.
>>>>>
>>>>> Are you saying that currently stack unwinder on arm64 is
>>>>> completely broken for struct_ops progs ?
>>>>> or it shows an extra frame that doesn't have to be shown ?
>>>>>
>>>>> If former then it's certainly a bpf tree material.
>>>>> If latter then bpf-next will do.
>>>>> Pls clarify.
>>>>
>>>> It is not completely broken, only an extra garbage frame is shown
>>>> between the caller of the trampoline and its caller.
>>>>
>>>
>>> Yep, exactly. Here is a perf script sample, where tcp_ack+0x404
>>> is the garbage frame.
>>>
>>> ffffffc0801a04b4 bpf_prog_50992e55a0f655a9_bpf_cubic_cong_avoid+0x98 (bpf_prog_50992e55a0f655a9_bpf_cubic_cong_avoid)
>>> ffffffc0801a228c [unknown] ([kernel.kallsyms]) // bpf trampoline
>>> ffffffd08d362590 tcp_ack+0x798 ([kernel.kallsyms]) // caller for bpf trampoline
>>> ffffffd08d3621fc tcp_ack+0x404 ([kernel.kallsyms]) // garbage frame
>>> ffffffd08d36452c tcp_rcv_established+0x4ac ([kernel.kallsyms])
>>> ffffffd08d375c58 tcp_v4_do_rcv+0x1f0 ([kernel.kallsyms])
>>> ffffffd08d378630 tcp_v4_rcv+0xeb8 ([kernel.kallsyms])
>>> ...
>>>
>>> And this sample also shows that there is no symbol for the
>>> struct_ops bpf trampoline. Maybe we should add symbol for it?
>>>
>>
>> Emm, stack unwinder on x86 is completely broken for struct_ops
>> progs.
>>
>> It's because the following function returns 0 for a struct_ops
>> bpf trampoline address as there is no corresponding kernel symbol,
>> which causes the address not to be recognized as kerneltext. As
>> a result, the winder stops on ip == 0.
>>
>> unsigned long unwind_get_return_address(struct unwind_state *state)
>> {
>>           if (unwind_done(state))
>>                   return 0;
>>
>>           return __kernel_text_address(state->ip) ? state->ip : 0;
>> }
>>
>> Here is an example of broken stack trace from perf sampling, where
>> only one stack frame is captured:
>>
>> ffffffffc000cfb4 bpf_prog_e60d93d3ec88d5ef_bpf_cubic_cong_avoid+0x78 (bpf_prog_e60d93d3ec88d5ef_bpf_cubic_cong_avoid)
>> (no more frames)
> 
> you mean arch_stack_walk() won't see anything after ip=0,
> but dump_stack() will still print the rest with "?" (as unreliable).
>

Yes, dump_stack() does not stop on !__kernel_text_address

> That's bad indeed.
> 
>> To fix it, I think kernel symbol should be added for struct_ops
>> trampoline.
> 
> Makes sense. Pls send a patch.
> 
> 
> As far as this patch please add an earlier example of double tcp_ack trace
> to commit log and resubmit targeting bpf-next.
>

Sure


