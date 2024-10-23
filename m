Return-Path: <bpf+bounces-42863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7659ABC0E
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 05:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D86B1C224F6
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 03:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735E653363;
	Wed, 23 Oct 2024 03:16:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D032139E
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 03:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729653416; cv=none; b=ea74J0wM8YLRlGUWlBgWroIaxUJ5ptrl17IcDkB5vJupX0UKLUf0RhkdBWjy7LUEIvEWpbptdtML5b0vynrMjg8vcuHL+hpVa++UjgMt93uan9OtExV8q9+LZVK0d//BUIm5Vky604/q63Hlm0JZjbZkgLeGdfUbZZTLsLskDQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729653416; c=relaxed/simple;
	bh=OzkqW5jjKmdUy7KkviyPPExSVANAaFBqGYWmQr1x/So=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1837rGu5r+Z+W3QwAaT42JnMKF8MM0GOc6DTIY7OaMB1suzTXkuwz6P2CyGc4ZwdJnocuhCqAG35Q62JdKCh13SH8UqcRZ6deh0CPjHzUcdz/vsorRXJoAg+OoEp+ASQ947BTNKKXftcb8iiV8VS/I4DLcOOm1ZElqBM48kXeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XYDj46dNTz4f3jd2
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 11:16:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 585641A0568
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 11:16:42 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgBnm2CZahhnvu1kEw--.7756S2;
	Wed, 23 Oct 2024 11:16:42 +0800 (CST)
Message-ID: <7226e7b8-ed73-4adb-9016-30031f1121ca@huaweicloud.com>
Date: Wed, 23 Oct 2024 11:16:41 +0800
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
Cc: Xu Kuohai <xukuohai@huaweicloud.com>, bpf <bpf@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Puranjay Mohan <puranjay@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20241019092709.128359-1-xukuohai@huaweicloud.com>
 <CAADnVQLOY-eHby6CMNXr3FvwPm85W-tWDxiWnRaR_U_=71ADuA@mail.gmail.com>
 <CANk7y0jiuiHSMTEZ_JCb4QpEPzhkK4ikicDGFa1F30DinZta8A@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CANk7y0jiuiHSMTEZ_JCb4QpEPzhkK4ikicDGFa1F30DinZta8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBnm2CZahhnvu1kEw--.7756S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uryrKryrAr18AFWftr13Jwb_yoW8KryDpr
	y5ZFZIkF40vrZ7Kw4qgw45XFySywsrZ343G3WDtr4fC3Z0gr1fXr17tay7urn3Gr1vkr1x
	X34qqFZrJF1DAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
	04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
	73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 10/23/2024 7:37 AM, Puranjay Mohan wrote:
> On Wed, Oct 23, 2024 at 12:50 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Sat, Oct 19, 2024 at 2:15 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>>
>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>
>>> The callsite layout for arm64 fentry is:
>>>
>>> mov x9, lr
>>> nop
>>>
>>> When a bpf prog is attached, the nop instruction is patched to a call
>>> to bpf trampoline:
>>>
>>> mov x9, lr
>>> bl <bpf trampoline>
>>>
>>> This passes two return addresses to bpf trampoline: the return address
>>> for the traced function/prog, stored in x9, and the return address for
>>> the bpf trampoline, stored in lr. To ensure stacktrace works properly,
>>> the bpf trampoline constructs two fake function stack frames using x9
>>> and lr.
>>>
>>> However, struct_ops progs are used as function callbacks and are invoked
>>> directly, without x9 being set as the fentry callsite does. Therefore,
>>> only one stack frame should be constructed using lr for struct_ops.
>>
>> Are you saying that currently stack unwinder on arm64 is
>> completely broken for struct_ops progs ?
>> or it shows an extra frame that doesn't have to be shown ?
>>
>> If former then it's certainly a bpf tree material.
>> If latter then bpf-next will do.
>> Pls clarify.
> 
> It is not completely broken, only an extra garbage frame is shown
> between the caller of the trampoline and its caller.
>

Yep, exactly. Here is a perf script sample, where tcp_ack+0x404
is the garbage frame.

ffffffc0801a04b4 bpf_prog_50992e55a0f655a9_bpf_cubic_cong_avoid+0x98 (bpf_prog_50992e55a0f655a9_bpf_cubic_cong_avoid)
ffffffc0801a228c [unknown] ([kernel.kallsyms]) // bpf trampoline
ffffffd08d362590 tcp_ack+0x798 ([kernel.kallsyms]) // caller for bpf trampoline
ffffffd08d3621fc tcp_ack+0x404 ([kernel.kallsyms]) // garbage frame
ffffffd08d36452c tcp_rcv_established+0x4ac ([kernel.kallsyms])
ffffffd08d375c58 tcp_v4_do_rcv+0x1f0 ([kernel.kallsyms])
ffffffd08d378630 tcp_v4_rcv+0xeb8 ([kernel.kallsyms])
...

And this sample also shows that there is no symbol for the
struct_ops bpf trampoline. Maybe we should add symbol for it?

> So, this can go from the bpf-next tree. But let's wait for Xu to
> provide more information.
>
> Thanks,
> Puranjay
> 


