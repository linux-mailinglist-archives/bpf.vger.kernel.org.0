Return-Path: <bpf+bounces-75137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F02C71FC0
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 04:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E2724E331E
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 03:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78018281531;
	Thu, 20 Nov 2025 03:24:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48006256C9E;
	Thu, 20 Nov 2025 03:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763609082; cv=none; b=KZ02EphBfjsx8IIOYWsFgbZn2UJ4ZJ3zgv4B7UgvZ4+wkRgLOCF9wg8aaXgqMI8zniRzlV/cYZPphVqIZ83pvgqiUjppW/0GB56+vZjJanGE4j0vr5X1R0cKHitTSWlrDufo8VPPtxoWJeTuvFvzp/BsPGwUWW6U32vIFPzPlLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763609082; c=relaxed/simple;
	bh=nzp7hEXicszkxmno/Issp9ZXfxDY+fpAtUze3FfjAO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ekNZL+2+EmOwIyRUeEhI4/NQfh+LB6QPCzzV7VdKIcOUwQUqDEuRU+sp8xPQGcZgwRvcNqoBHxWAuwtD3PDT8NZ9ZttmFu23twd70on5+81EokeyrH4WEybXWgEZVTzZthfGK8gzFROLiQM/wfsayuF+dqLK5TblnykdyMYxog4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dBkGb2TGmzKHMl1;
	Thu, 20 Nov 2025 11:24:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 6BC9C1A1887;
	Thu, 20 Nov 2025 11:24:36 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgBH8XfuiR5p8IpyBQ--.36973S2;
	Thu, 20 Nov 2025 11:24:32 +0800 (CST)
Message-ID: <492671cd-eb35-4510-929c-20586c8a6ab6@huaweicloud.com>
Date: Thu, 20 Nov 2025 11:24:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 0/6] bpf trampoline support "jmp" mode
Content-Language: en-US
To: Leon Hwang <leon.hwang@linux.dev>, Menglong Dong
 <menglong.dong@linux.dev>, Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, jiang.biao@linux.dev,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
 <CAADnVQJF5qkT8J=VJW00pPX7=hVdwn2545BzZPEi=mPwFouThw@mail.gmail.com>
 <8606158.T7Z3S40VBb@7950hx> <97c8e49c-ca27-40ec-8ff6-18b1b9061240@linux.dev>
 <5f4d0bf9-9c74-44ce-8f29-c43fa5e8810a@huaweicloud.com>
 <e3c8daef-5267-4dda-9009-209a94224374@linux.dev>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <e3c8daef-5267-4dda-9009-209a94224374@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBH8XfuiR5p8IpyBQ--.36973S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr1fJw4xXw4kKryUuFWUCFg_yoW5ZFW8pa
	1xJa4YkF4DJrWkCrnFyw48AFySvw47JFZ8Xrn5G348C3s09r97tF1xKryYkFy3ur4F9F12
	vr4Y934fXF4UZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 11/20/2025 10:07 AM, Leon Hwang wrote:
> 
> 
> On 19/11/25 20:36, Xu Kuohai wrote:
>> On 11/19/2025 10:55 AM, Leon Hwang wrote:
>>>
>>>
>>> On 19/11/25 10:47, Menglong Dong wrote:
>>>> On 2025/11/19 08:28, Alexei Starovoitov wrote:
>>>>> On Tue, Nov 18, 2025 at 4:36 AM Menglong Dong
>>>>> <menglong8.dong@gmail.com> wrote:
>>>>>>
>>>>>> As we can see above, the performance of fexit increase from
>>>>>> 80.544M/s to
>>>>>> 136.540M/s, and the "fmodret" increase from 78.301M/s to 159.248M/s.
>>>>>
>>>>> Nice! Now we're talking.
>>>>>
>>>>> I think arm64 CPUs have a similar RSB-like return address predictor.
>>>>> Do we need to do something similar there?
>>>>> The question is not targeted to you, Menglong,
>>>>> just wondering.
>>>>
>>>> I did some research before, and I find that most arch
>>>> have such RSB-like stuff. I'll have a look at the loongarch
>>>> later(maybe after the LPC, as I'm forcing on the English practice),
>>>> and Leon is following the arm64.
>>>
>>> Yep, happy to take this on.
>>>
>>> I'm reviewing the arm64 JIT code now and will experiment with possible
>>> approaches to handle this as well.
>>>
>>
>> Unfortunately, the arm64 trampoline uses a tricky approach to bypass BTI
>> by using ret instruction to invoke the patched function. This conflicts
>> with the current approach, and seems there is no straightforward solution.
>>
> Hi Kuohai,
> 
> Thanks for the explanation.
> 
> Do you recall the original reason for using a ret instruction to bypass
> BTI in the arm64 trampoline? I'm trying to understand whether that
> constraint is fundamental or historical.

arm64 direct jump instructions (b and bl) support only a ±128 MB range.
But the distance between the trampoline and the patched function may
exceed this range. So an indirect jump is required.

With BTI enabled, indirect jump instructions (br and blr) require a landing
pad at the jump target. The target is the instruction immediately after
the call site in the patched function. It may be any instruction, including
non-landing-pad instructions. If it is ot a landing pad, a BTI exception
occurs when trampline jump back using BR/BLR.

Since the RET instruction does not require landing pad, it is chosen to
return to the patched function.

See [1] for reference.

[1] https://lore.kernel.org/bpf/20230401234144.3719742-1-xukuohai@huaweicloud.com/

> I'm wondering if we could structure the control flow like this:
> 
> foo "bl" bar -> bar:
>    bar "br" trampoline -> trampoline:
>      trampoline "bl" -> bar func body:

As mentioned above, the problem is that the bl may be out of range.

If blr instruction is used instead, the target instruction must be a landing
pad when BTI is enabled. One approach is to reserve an extra nop at the call
site and patch it into a bti instruction at runtime when needed.

>        bar func body "ret" -> trampoline
>      trampoline "ret" -> foo
> 
> This would introduce two "bl"s and two "ret"s, keeping the RAS balanced
> in a way similar to the x86 approach.
> 
> With this structure, we could also shrink the frame layout:
> 
> 	 * SP + retaddr_off [ self ip           ]
> 	 *                  [ FP                ]
> 
> And then store the "self" return address elsewhere on the stack.
> 
> Do you think something along these lines could work?
> 
> Thanks,
> Leon


