Return-Path: <bpf+bounces-20731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0232B84262F
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 14:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC48D285ACB
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 13:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A66D6BB54;
	Tue, 30 Jan 2024 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9YdX0Am"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7656BB3D;
	Tue, 30 Jan 2024 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706621319; cv=none; b=bJ8RAallZI8u+Ge5uGRLyw28P2Ds2X3JvttlXbahYe6OHU9SM+NHihpxREcHGBYsK0R0PF/YMR+9WRal4RUl9X2rQ+ixHwo75Ah5Cd0FAQoRh5RApxBl6vhZrb2W9/pGvadTUw/kKvNYKx3hg1Io6mvs1te4d9zjhdCXa29ZDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706621319; c=relaxed/simple;
	bh=P4Ed6bty5NrlB1PskKxS7173sQNawPnBy3pGH9uH4KI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UALbTQu7xD+AmvUz25yy9CYdpIBaXl49p7IFpvUyUzsPPTMtApxQ5pDc/9HCE5qZTMbRVtWnJsZVSYxFcdl5EUuwugGXtPsRPD9vLYE9BDCFbMjrcUqaWlp06qwsjv9lK96RrYSX1CBUkefgxWVHKGDa25eUbYFc8zz5/VGNF0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9YdX0Am; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C23C433F1;
	Tue, 30 Jan 2024 13:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706621318;
	bh=P4Ed6bty5NrlB1PskKxS7173sQNawPnBy3pGH9uH4KI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=U9YdX0AmBvQjbRCYBpRWPZQk8hXkRG2jvIgTquEFRwrJ0rsxgMk5QeRn01hHnY1zc
	 MYimbZyLY5TwEqgIPOrExIPMljS1+qiF7y9o/HUXD4YHk7WK7qKaxMY5EsuTk8jicK
	 VG0beVWkm0sP9uRgo5pcCwt2+TxwFoU/w/cc308x0MoBDB8AzOG6I2JO6vG54AOI9H
	 oc/dlWwQgc9+cM9vBVZQIsiVuYZ6BTHW/+5GezF+CAKMibhEfB3k7wZzG3lWtc5j+F
	 TT3+j2zXNPHrGgWH/gfkP6vvj05GSr7Or9XGfQPY3lw7xUo/oTT8KsRztwMzBi+4Fk
	 cFfn9t8MbZoIA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huawei.com>, Pu Lehui <pulehui@huaweicloud.com>,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, Luke Nelson
 <luke.r.nels@gmail.com>
Subject: Re: [PATCH bpf-next 4/4] riscv, bpf: Mixing bpf2bpf and tailcalls
In-Reply-To: <5d776261-338b-4ebb-bb9b-1dbc91cd06c3@huawei.com>
References: <20230919035711.3297256-1-pulehui@huaweicloud.com>
 <20230919035711.3297256-5-pulehui@huaweicloud.com>
 <87lecqobyb.fsf@all.your.base.are.belong.to.us>
 <4e73b095-0c08-4a6f-b2ee-8f7a071b14ee@huaweicloud.com>
 <87cytjusud.fsf@all.your.base.are.belong.to.us>
 <5d776261-338b-4ebb-bb9b-1dbc91cd06c3@huawei.com>
Date: Tue, 30 Jan 2024 14:28:35 +0100
Message-ID: <87zfwnympo.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huawei.com> writes:

> On 2024/1/30 16:29, Bj=C3=B6rn T=C3=B6pel wrote:
>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>=20
>>> On 2023/9/28 17:59, Bj=C3=B6rn T=C3=B6pel wrote:
>>>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>>>
>>>>> From: Pu Lehui <pulehui@huawei.com>
>>>>>
>>>>> In the current RV64 JIT, if we just don't initialize the TCC in subpr=
og,
>>>>> the TCC can be propagated from the parent process to the subprocess, =
but
>>>>> the TCC of the parent process cannot be restored when the subprocess
>>>>> exits. Since the RV64 TCC is initialized before saving the callee sav=
ed
>>>>> registers into the stack, we cannot use the callee saved register to
>>>>> pass the TCC, otherwise the original value of the callee saved regist=
er
>>>>> will be destroyed. So we implemented mixing bpf2bpf and tailcalls
>>>>> similar to x86_64, i.e. using a non-callee saved register to transfer
>>>>> the TCC between functions, and saving that register to the stack to
>>>>> protect the TCC value. At the same time, we also consider the scenario
>>>>> of mixing trampoline.
>>>>
>>>> Hi!
>>>>
>>>> The RISC-V JIT tries to minimize the stack usage, e.g. it doesn't have=
 a
>>>> fixed pro/epilogue like some of the other JITs. I think we can do bett=
er
>>>> here, so that the pass-TCC-via-register can be used, and the additional
>>>> stack access can be avoided.
>>>>
>>>> Today, the TCC is passed via a register (a6) and can be viewed as a
>>>> "state" variable/transparent argument/return value. As you point out, =
we
>>>> loose this when we do a call. On (any) calls we move the TCC to a
>>>> callee-saved register.
>>>>
>>>> WDYT about the following scheme:
>>>>
>>>> 1 Pickup the arm64 bpf2bpf/tailmix mechanism of just clearing the TCC
>>>>     for the main program.
>>>> 2 For BPF helper calls, move TCC to s6, perform the call, and restore
>>>>     a6. Dito for kfunc calls (BPF_PSEUDO_KFUNC_CALL).
>>>> 3 For all other calls, a6 is passed transparently.
>>>>
>>>> For 2 bpf_jit_get_func_addr() can be used to determine if the callee is
>>>> a BPF helper or not.
>>>>
>>>> In summary; Determine in the JIT if we're leaving BPF-land, and need to
>>>> move the TCC to a callee-saved reg, or not, and save us a bunch of sta=
ck
>>>> store/loads.
>>>>
>>>
>>> Valuable scheme. But we need to consider TCC back propagation. Let me
>>> show an example of calling subprog with TCC stored in A6:
>>>
>>> prog1(TCC=3D=3D1){
>>>       subprog1(TCC=3D=3D1)
>>>           -> tailcall1(TCC=3D=3D0)
>>>               -> subprog2(TCC=3D=3D0)
>>>       subprog3(TCC=3D=3D0) <--- should be TCC=3D=3D1
>>>           -\-> tailcall2 <--- can't be called
>>> }
>
> Let's back with this example again. Imagine that the tailcall chain is a=
=20
> list limited to 33 elements. When the list has 32 elements, we call=20
> subprog1 and then tailcall1. At this time, the list elements count=20
> becomes 33. Then we call subprog2 and return prog1. At this time, the=20
> list removes 1 element and becomes 32 elements. At this time, there=20
> still can perform 1 tailcall.
>
> I've attached a diagram that shows mixing tailcall and subprogs is=20
> nearly a "call". It can return to caller function.

Hmm. Let me put my Q in another way.

The kernel calls into BPF_PROG_RUN() (~a BPF context). Would it ever be
OK to do more than 33 tail calls, regardless of subprogs or not?

In your example, TCC is 1. You are allowed to perform one tail call. In
your example prog1 performs two.

My view of TCC has always been ~a counter of the number of tailcalls~.

With your example expanded:
prog1(TCC=3D=3D33){
      subprog1(TCC=3D=3D33)
          -> tailcall1(TCC=3D=3D33) -> tailcall1(TCC=3D=3D32) -> tailcall1(=
TCC=3D=3D31) -> ... // 33 times
      // Lehui says TCC should be 33 again.
      // Bj=C3=B6rn says "it's the number of tailcalls", and subprog3 canno=
t perform a tail call
      subprog3(TCC=3D=3D?)
=20=20=20=20=20=20=20=20=20=20
My view has, again, been than TCC is a run-time count of the number
tailcalls (fentry/fexit patch bpf-programs included).

What does x86 and arm64 do?


Bj=C3=B6rn

