Return-Path: <bpf+bounces-20743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A218428AF
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 17:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B651F2193A
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 16:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0059A86151;
	Tue, 30 Jan 2024 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrbbTJ07"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FCE54656;
	Tue, 30 Jan 2024 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630633; cv=none; b=uLC5floItpenvX6nJQtf25smvGN2qMg18VV1ridOA9HAg/RD52f/2KvD3QA9oIhfNBZa7I9Bgrt5HTtZsBCEZZDqXjWudPEM4YnpTIpzzzyVvXj24UOOQt/AOTYGunF4kSkc+Pt+29uCg9sQauE6BMd4jFByHuqvjwCbTB+I9BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630633; c=relaxed/simple;
	bh=0OAd4/SGcsXtRJucrF8w9F4Yv4qA0oFmytL+aja1oCI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YlZjjL5ASKMZI+If/vsvAlVSICc805FMlzk3wnYVTZ0ubn0OBkqP44bsIq7EaKLiZ560UX57K3uk4As1FfYWlxhHZ8YDbVTGsQM2GDsQA/LtA97pBRmV9ajGte8pS4KscIOzAjSF/F3o8Lx3ZAE850j4BQU30/zeBVcPuPWxkF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrbbTJ07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E90C433C7;
	Tue, 30 Jan 2024 16:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706630632;
	bh=0OAd4/SGcsXtRJucrF8w9F4Yv4qA0oFmytL+aja1oCI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JrbbTJ07iy3fISOtBKNwGJMdtKzfHoUc5ee0NEJiI65vu4fevP7DeP4XHwHHtCvsa
	 ai6lAYJFiHrwcl3IY5X5hgMNE0UxWYROdjWIsKjahokMNHsUYbdT7fORM15vBn99oN
	 lQpOmJaZ4ayJvzGih2hPvKv4FHr5X0pCxF2WHKGbkS4hZPNoLNiYkMNrNVi9WKscLv
	 8vgJY6+d2gWzui5REpKfUy+L+G7u1GyPdCu6wTt1OTrSgLYqRb/v4jDdCzTFZGsN/M
	 UN7Ba/Ow8Q4EdAlctsfH4OSLbvru1kj/DXIILcBpHJXpSP9h/r4QfjF8PihfiQzJGz
	 AS6NQxJWoZJew==
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
In-Reply-To: <5a30caa3-3351-41e7-a77f-91e5959b2da6@huawei.com>
References: <20230919035711.3297256-1-pulehui@huaweicloud.com>
 <20230919035711.3297256-5-pulehui@huaweicloud.com>
 <87lecqobyb.fsf@all.your.base.are.belong.to.us>
 <4e73b095-0c08-4a6f-b2ee-8f7a071b14ee@huaweicloud.com>
 <87cytjusud.fsf@all.your.base.are.belong.to.us>
 <5d776261-338b-4ebb-bb9b-1dbc91cd06c3@huawei.com>
 <87zfwnympo.fsf@all.your.base.are.belong.to.us>
 <5a30caa3-3351-41e7-a77f-91e5959b2da6@huawei.com>
Date: Tue, 30 Jan 2024 17:03:49 +0100
Message-ID: <87le86q04a.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huawei.com> writes:

> On 2024/1/30 21:28, Bj=C3=B6rn T=C3=B6pel wrote:
>> Pu Lehui <pulehui@huawei.com> writes:
>>=20
>>> On 2024/1/30 16:29, Bj=C3=B6rn T=C3=B6pel wrote:
>>>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>>>
>>>>> On 2023/9/28 17:59, Bj=C3=B6rn T=C3=B6pel wrote:
>>>>>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>>>>>
>>>>>>> From: Pu Lehui <pulehui@huawei.com>
>>>>>>>
>>>>>>> In the current RV64 JIT, if we just don't initialize the TCC in sub=
prog,
>>>>>>> the TCC can be propagated from the parent process to the subprocess=
, but
>>>>>>> the TCC of the parent process cannot be restored when the subprocess
>>>>>>> exits. Since the RV64 TCC is initialized before saving the callee s=
aved
>>>>>>> registers into the stack, we cannot use the callee saved register to
>>>>>>> pass the TCC, otherwise the original value of the callee saved regi=
ster
>>>>>>> will be destroyed. So we implemented mixing bpf2bpf and tailcalls
>>>>>>> similar to x86_64, i.e. using a non-callee saved register to transf=
er
>>>>>>> the TCC between functions, and saving that register to the stack to
>>>>>>> protect the TCC value. At the same time, we also consider the scena=
rio
>>>>>>> of mixing trampoline.
>>>>>>
>>>>>> Hi!
>>>>>>
>>>>>> The RISC-V JIT tries to minimize the stack usage, e.g. it doesn't ha=
ve a
>>>>>> fixed pro/epilogue like some of the other JITs. I think we can do be=
tter
>>>>>> here, so that the pass-TCC-via-register can be used, and the additio=
nal
>>>>>> stack access can be avoided.
>>>>>>
>>>>>> Today, the TCC is passed via a register (a6) and can be viewed as a
>>>>>> "state" variable/transparent argument/return value. As you point out=
, we
>>>>>> loose this when we do a call. On (any) calls we move the TCC to a
>>>>>> callee-saved register.
>>>>>>
>>>>>> WDYT about the following scheme:
>>>>>>
>>>>>> 1 Pickup the arm64 bpf2bpf/tailmix mechanism of just clearing the TCC
>>>>>>      for the main program.
>>>>>> 2 For BPF helper calls, move TCC to s6, perform the call, and restore
>>>>>>      a6. Dito for kfunc calls (BPF_PSEUDO_KFUNC_CALL).
>>>>>> 3 For all other calls, a6 is passed transparently.
>>>>>>
>>>>>> For 2 bpf_jit_get_func_addr() can be used to determine if the callee=
 is
>>>>>> a BPF helper or not.
>>>>>>
>>>>>> In summary; Determine in the JIT if we're leaving BPF-land, and need=
 to
>>>>>> move the TCC to a callee-saved reg, or not, and save us a bunch of s=
tack
>>>>>> store/loads.
>>>>>>
>>>>>
>>>>> Valuable scheme. But we need to consider TCC back propagation. Let me
>>>>> show an example of calling subprog with TCC stored in A6:
>>>>>
>>>>> prog1(TCC=3D=3D1){
>>>>>        subprog1(TCC=3D=3D1)
>>>>>            -> tailcall1(TCC=3D=3D0)
>>>>>                -> subprog2(TCC=3D=3D0)
>>>>>        subprog3(TCC=3D=3D0) <--- should be TCC=3D=3D1
>>>>>            -\-> tailcall2 <--- can't be called
>>>>> }
>>>
>>> Let's back with this example again. Imagine that the tailcall chain is a
>>> list limited to 33 elements. When the list has 32 elements, we call
>>> subprog1 and then tailcall1. At this time, the list elements count
>>> becomes 33. Then we call subprog2 and return prog1. At this time, the
>>> list removes 1 element and becomes 32 elements. At this time, there
>>> still can perform 1 tailcall.
>>>
>>> I've attached a diagram that shows mixing tailcall and subprogs is
>>> nearly a "call". It can return to caller function.
>>=20
>> Hmm. Let me put my Q in another way.
>>=20
>> The kernel calls into BPF_PROG_RUN() (~a BPF context). Would it ever be
>> OK to do more than 33 tail calls, regardless of subprogs or not?
>>=20
>> In your example, TCC is 1. You are allowed to perform one tail call. In
>> your example prog1 performs two.
>>=20
>> My view of TCC has always been ~a counter of the number of tailcalls~.
>>=20
>> With your example expanded:
>> prog1(TCC=3D=3D33){
>>        subprog1(TCC=3D=3D33)
>>            -> tailcall1(TCC=3D=3D33) -> tailcall1(TCC=3D=3D32) -> tailca=
ll1(TCC=3D=3D31) -> ... // 33 times
>>        // Lehui says TCC should be 33 again.
>>        // Bj=C3=B6rn says "it's the number of tailcalls", and subprog3 c=
annot perform a tail call
>>        subprog3(TCC=3D=3D?)
>
> Yes, my view is take this something like a stack=EF=BC=8Cwhile you take t=
his as=20
> a fixed global value.
>
> prog1(TCC=3D=3D33){
>      subprog1(TCC=3D=3D33)
>          -> tailcall1(TCC=3D=3D33) -> tailcall1(TCC=3D=3D32) ->=20
> tailcall1(TCC=3D=3D31) -> ... // 33 times -> subprog2(TCC=3D=3D0)
>      subprog3(TCC=3D=3D33)
> 	-> tailcall1(TCC=3D=3D33) -> tailcall1(TCC=3D=3D32) -> tailcall1(TCC=3D=
=3D31) ->=20
> ... // 33 times
>
>>=20=20=20=20=20=20=20=20=20=20=20=20
>> My view has, again, been than TCC is a run-time count of the number
>> tailcalls (fentry/fexit patch bpf-programs included).
>>=20
>> What does x86 and arm64 do?
>
> When subprog return back to caller bpf program, they both restore TCC to=
=20
> the value when enter into subprog. The ARM64 uses the callee saved=20
> register to store the TCC. When the ARM64 exits, the TCC is restored to=20
> the value when it enter. The while x86 uses the stack to do the same thin=
g.

Ok! Thanks for clarifying. I'll continue reviewing the v2 of your
series!

BTW, I wonder if we can trigger this [1] on RV64 -- i.e. calling the
main prog, will reset the tcc count.

[1] https://lore.kernel.org/bpf/20240104142226.87869-1-hffilwlqm@gmail.com/

