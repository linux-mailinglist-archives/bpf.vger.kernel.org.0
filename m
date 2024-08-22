Return-Path: <bpf+bounces-37888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4F595BD6B
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 19:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFCEB1C21B1F
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 17:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A49E1CCB36;
	Thu, 22 Aug 2024 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QKzhPwev"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FEA1D12E4
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724348300; cv=none; b=ieZ6opbNhUpsnR0n2BSVzSBTjnqESTz32j/U8xkt4dIe6zkbg8APfMYCmuyv/DYe8NFAsSFnJ1gZmmbW2UCyQf16MXO0vMhfckYZ+uC8/LYB7ySLHus8lazcGiPo81tUbRgPaMck9bGBi9TxPGDHY0Elk/2Raa8gLVlOrXCjyxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724348300; c=relaxed/simple;
	bh=r68lShoy++LFDQgSaNRQcpcKUrRr3oEq3F2KUOjXFAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z3qE/gQKslhU1nXGgwyiBrCIRpY5J+3F/qDI8V2LhWTH5KH4G0tW21p7ydpvlKEfF/sW5rCWhbdF+5FpZVQdCKfO6nlh0ttFk+4Z1Pc0vDa7qlDBg8UwOSr20i398MSRzL+pZvSvXFI+LL0+W/PNmq30Ptj8xQzG7PprBNq/oh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QKzhPwev; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8bb13887-ba3e-4814-b342-219313d734e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724348296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvCxbipjZLuqbLdj8IFvMVk9k4b3xD3EU+XjK8P1+6w=;
	b=QKzhPwev+KlSquu6sB9ltymHZYBd+51lTHX42egajlNanG5NdIIoF0BEif1NGN+aSrd7la
	ATENdWW8l8N2oSuYLhoVHk4d7cw94UrJh76HhoAAZ/n71lKo5nvzl1XbNLiGVRnkeIzXsE
	uJ0kIe6MOo/R3fcmV6PfqiX7XBHA0xI=
Date: Thu, 22 Aug 2024 10:38:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 7/8] bpf: Allow pro/epilogue to call kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song
 <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>,
 Kernel Team <kernel-team@meta.com>
References: <20240821233440.1855263-1-martin.lau@linux.dev>
 <20240821233440.1855263-8-martin.lau@linux.dev>
 <CAADnVQK4LUVsKQYHdaw0x9-CryA0wQX6stkvhFnNoDh1tt0jhg@mail.gmail.com>
 <7a4aa80b-b5fe-4f9a-95a3-743d2a218927@linux.dev>
 <CAADnVQ+b1Y3cb4mEMWMPw32=+q5_Gb26Ejuqj+=_LMwGvjROkw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAADnVQ+b1Y3cb4mEMWMPw32=+q5_Gb26Ejuqj+=_LMwGvjROkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/22/24 6:47 AM, Alexei Starovoitov wrote:
> On Wed, Aug 21, 2024 at 11:10 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 8/21/24 6:32 PM, Alexei Starovoitov wrote:
>>> On Wed, Aug 21, 2024 at 4:35 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>
>>>> From: Martin KaFai Lau <martin.lau@kernel.org>
>>>>
>>>> The existing prologue has been able to call bpf helper but not a kfunc.
>>>> This patch allows the prologue/epilogue to call the kfunc.
>>>>
>>>> The subsystem that implements the .gen_prologue and .gen_epilogue
>>>> can add the BPF_PSEUDO_KFUNC_CALL instruction with insn->imm
>>>> set to the btf func_id of the kfunc call. This part is the same
>>>> as the bpf prog loaded from the sys_bpf.
>>>
>>> I don't understand the value of this feature, since it seems
>>> pretty hard to use.
>>> The module (qdisc-bpf or else) would need to do something
>>> like patch 8/8:
>>> +BTF_ID_LIST(st_ops_epilogue_kfunc_list)
>>> +BTF_ID(func, bpf_kfunc_st_ops_inc10)
>>> +BTF_ID(func, bpf_kfunc_st_ops_inc100)
>>>
>>> just to be able to:
>>>     BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0,
>>>                  st_ops_epilogue_kfunc_list[0]);
>>>
>>> So a bunch of extra work on the module side and
>>> a bunch of work in this patch to enable such a pattern,
>>> but what is the value?
>>>
>>> gen_epilogue() can call arbitrary kernel function.
>>> It doesn't have to be a helper.
>>> kfunc-s provide calling convention conversion from bpf to native,
>>> but the same thing is achieved by BPF_CALL_N macro.
>>> The module can use that macro without adding an actual bpf helper
>>> to uapi bpf.h.
>>> Then in gen_epilogue() the extra bpf insn can use:
>>> BPF_EMIT_CALL(module_provided_helper_that_is_not_helper)
>>> which will use
>>> BPF_CALL_IMM(x) ((void *)(x) - (void *)__bpf_call_base)
>>
>> BPF_EMIT_CALL() was my earlier thought. I switched to the kfunc in this patch
>> because of the bpf_jit_supports_far_kfunc_call() support for the kernel module.
>> Using kfunc call will make supporting it the same.
> 
> I believe far calls are typically slower,
> so it may be a foot gun.
> If something like qdisc-bpf adding a function call to bpf_exit
> it will be called every time the program is called, so
> it needs to be really fast.
> Allowing such callable funcs in modules may be a performance issue
> that we'd need to fix.
> So imo making a design requirement that such funcs for gen_epilogoue()
> need to be in kernel text is a good thing.

Agreed. Make sense.

> 
>> I think the future bpf-qdisc can enforce built-in. bpf-tcp-cc has already been
>> built-in only also. I think the hid_bpf is built-in only also.
> 
> I don't think hid_bpf has any need for such gen_epilogue() adjustment.
> tcp-bpf-cc probably doesn't need it either.
> it's cleaner to fix up on the kernel side, no?

tcp-bpf-cc can use it to fix snd_cwnd. We have seen a mistake that snd_cwnd was 
set to 0 (or negative, can't remember which one). >1 ops of the 
tcp_congestion_ops may update the snd_cwnd, so there will be multiple places it 
needs to do an extra check/fix in the kernel. It is usually not the fast path, 
so may be ok.

It is not catastrophic as skb->dev. kfunc was not introduced at that time also. 
Otherwise, having a kfunc to set the snd_cwnd instead could have been an option.

> qdisc-bpf and ->dev stuff is probably the only upcoming user.

For skb->dev, may be having a dedicated kfuncs for skb->dev manipulation is the 
way to go? The example could be operations that need to touch the 
skb->rbnode/dev sharing pointer.

For fixing ->dev in the kernel, there are multiple places doing ->dequeue and 
not sure if we need to include the child->dequeue also. This fixing could be 
refactored to a kernel function and probably need to a static key in this fast 
path case.

> And that's a separate discussion. I'm not sure such gen_epilogoue()
> concept is really that great.
> Especially considering all the complexity involved.

I am curious on the problem you pointed out at patch 1 regardless, I am going to 
give it a try and remove the kfunc call. I made kfunc call separated at patch 7 
and 8 :)

If it still looks too complex or there is no value on gen_epilogue, I am fine to 
table this set.


