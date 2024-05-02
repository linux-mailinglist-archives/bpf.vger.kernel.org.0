Return-Path: <bpf+bounces-28442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6148D8B9B6F
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 15:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928511C22100
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 13:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADE284A51;
	Thu,  2 May 2024 13:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sY3nTQsk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D13DC8F3;
	Thu,  2 May 2024 13:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714655816; cv=none; b=PbKkaky+STJAoIRcQ9dYkEccmfdJCVTplv/AV/cRPwIBeuGpAB5ENNkpfyLwjSq8DTF7h7wBvFxNG4LBjObvlQWhgKsLXUPHGkGFQPastsFI8cI1YUtLnnH00BFN2csHQAK74gmjHPnWfAZQHEY3Q7nO/6z7qj03hM4l5nHci2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714655816; c=relaxed/simple;
	bh=w6H08j+R8foRTFOw41AFNnzrEJ9YvknLQmjZmPzZqeg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NVIbvCFdGtKlhLHRj9P+xdiJeFlOGoCrTy6/l33aC3ZkNPQ5NfcOwLsGSMWvWipeZ6NxS14JLQK3sl4caZ8Re93heZSabjoBCDDxOoSz4+e3v0ya8tFN8km8v/jPtwHSVEFS0MtL4uzrkMn1Qm8yNJZvM4vAjxfMoMasuOdVTBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sY3nTQsk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E1DC113CC;
	Thu,  2 May 2024 13:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714655815;
	bh=w6H08j+R8foRTFOw41AFNnzrEJ9YvknLQmjZmPzZqeg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sY3nTQskk7vNgYeyYTzpB4pbuFH03SPkrPHSPWha53MbJ2I9QaBvetSVC9FLQA9Cb
	 Rr16e80Wxtm36HemMa8595Zrk4tAH5ovpMruDcdGy5KOBYXJb9OtvnEU+U9eEmwLkM
	 KK9Q5afWGBJsY+cjlw2SnJ55eLFALNedVkBi51lX+7vrDSkzYsidf/Cw0FJ+HPQmAE
	 PDFWs2L2tv/NanO2s55if5kvu+W3hreqLwmbDXH/WdYuJQs7vKA4/EJYBn1yJac+gq
	 Ycl4ToG9I5wqlQ0G6/TU7M88c7ns413EvU0ChjaMOSyhqRm7/0TXCPiZfRZWOXtxxI
	 ekb0tn/7bVlqA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Pu Lehui
 <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next v2 2/2] riscv, bpf: inline
 bpf_get_smp_processor_id()
In-Reply-To: <CAEf4Bzb4FYVNjuoghCcDxLgQCOT9Mb=nbjgNktqDarPHkOsuog@mail.gmail.com>
References: <20240430175834.33152-1-puranjay@kernel.org>
 <20240430175834.33152-3-puranjay@kernel.org>
 <CAEf4Bzb4FYVNjuoghCcDxLgQCOT9Mb=nbjgNktqDarPHkOsuog@mail.gmail.com>
Date: Thu, 02 May 2024 13:16:52 +0000
Message-ID: <mb61pcyq45p6j.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Tue, Apr 30, 2024 at 10:59=E2=80=AFAM Puranjay Mohan <puranjay@kernel.=
org> wrote:
>>
>> Inline the calls to bpf_get_smp_processor_id() in the riscv bpf jit.
>>
>> RISCV saves the pointer to the CPU's task_struct in the TP (thread
>> pointer) register. This makes it trivial to get the CPU's processor id.
>> As thread_info is the first member of task_struct, we can read the
>> processor id from TP + offsetof(struct thread_info, cpu).
>>
>>           RISCV64 JIT output for `call bpf_get_smp_processor_id`
>>           =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>>                 Before                           After
>>                --------                         -------
>>
>>          auipc   t1,0x848c                  ld    a5,32(tp)
>>          jalr    604(t1)
>>          mv      a5,a0
>>
>
> Nice, great find! Would you be able to do similar inlining for x86-64
> as well? Disassembling bpf_get_smp_processor_id for x86-64 shows this:
>
> Dump of assembler code for function bpf_get_smp_processor_id:
>    0xffffffff810f91a0 <+0>:     0f 1f 44 00 00  nopl   0x0(%rax,%rax,1)
>    0xffffffff810f91a5 <+5>:     65 8b 05 60 79 f3 7e    mov
> %gs:0x7ef37960(%rip),%eax        # 0x30b0c <pcpu_hot+12>
>    0xffffffff810f91ac <+12>:    48 98   cltq
>    0xffffffff810f91ae <+14>:    c3      ret
> End of assembler dump.
> We should be able to do the same in x86-64 BPF JIT. (it's actually how
> I started initially, I had a dedicated instruction reading per-cpu
> memory, but ended up with more general "calculate per-cpu address").

I feel in x86-64's case JIT can not do a (much) better job compared to the
current approach in the verifier.

On RISC-V and ARM64, JIT was able to do it better because both of these
architectures save a pointer to the task struct in a special CPU
register. As x86-64 doesn't have enough extra registers, it uses a
percpu variable to store task struct, thread_info, and the cpu
number.

P.S. - While doing this for BPF, I realized that ARM64 kernel code is
also not optimal as it is using the percpu variable and is not reading
the CPU register directly. So, I sent a patch[1] to fix it in the kernel
and get rid of the per-cpu variable in ARM64.


[1] https://lore.kernel.org/all/20240502123449.2690-2-puranjay@kernel.org/

> Anyways, great work, a small nit below.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks,
Puranjay

