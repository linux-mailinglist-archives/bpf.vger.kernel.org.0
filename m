Return-Path: <bpf+bounces-26150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC8789B89D
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 09:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862C11F21F7D
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 07:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27FF28DC1;
	Mon,  8 Apr 2024 07:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWAQhQUo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5390825619;
	Mon,  8 Apr 2024 07:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562051; cv=none; b=OHr3biGOi0ZSp6IYi7k7TeH238Yc9f45wybGVBkc8CwN6UJUQ3dbXMz/SHTONNoCIN6949LC2+ahUeH+Jcz+FVTdGU2QjJrrle/HKMnV44TUnliM6ZnG4N7i2aQZfTDi6JjxHewBSEautoRQrMHh4eoFZa8HSJLCAqf62fP6v+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562051; c=relaxed/simple;
	bh=/PwTXAMc4qIagsONctj643hd2NRLVGHlttgBejgG8j8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ae0nXd5WctShqAezhHvsSeHqNIdU85UkFIdxkZTGNGxOzmQ76pRFrJb5jsMuF7YzdNPqyP7wSgGASiS4COw7Xl62OO+nLc19gO4QTwy3qmN3d+O4DFRt/DLk0huM5CNEf7WHe8wTKhgRbiyPbVpZ/VwNDpci+N2lmw/XI02BPSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWAQhQUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69ACAC433C7;
	Mon,  8 Apr 2024 07:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712562050;
	bh=/PwTXAMc4qIagsONctj643hd2NRLVGHlttgBejgG8j8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BWAQhQUo/m+lzgIsUQVYBAOxqNr0gy9VJuIhOQqc7fdK4j0ctn1Sxzf4CRuItOoiy
	 jgpzyy+pHdhB2WKLtO2xFcc9s02F7jHdZVTkZnOO2dqk/RC2+t2LLrLyG7mAp1B6z5
	 373vOlk+ZNrKklfkwiAUxs5KRrurYxlW/oBozWhr7SV6vZrSxLDOHgm3cGt1JYQb7a
	 M0q6ZpuEAYDx12xXCE48O43Di0EDP3W1Tn9WDbh8I8Zd5NTE6rBwCSueFDhgVBsdcv
	 zh7jeBA0lttsxUDDgCdFKw1p1ZQ/Y0j5LyUgCQoAdhxteAZgiKvVnRPXgZVXPAP7k7
	 1NeFBuUS+RpFw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Puranjay Mohan
 <puranjay12@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next] riscv, bpf: add internal-only MOV instruction
 to resolve per-CPU addrs
In-Reply-To: <CAEf4BzZ2Tz5-GwbQKYg7KoGwqN8ewPBakmghHaH20MfoATe74g@mail.gmail.com>
References: <20240405124348.27644-1-puranjay12@gmail.com>
 <CAEf4BzZ2Tz5-GwbQKYg7KoGwqN8ewPBakmghHaH20MfoATe74g@mail.gmail.com>
Date: Mon, 08 Apr 2024 09:40:47 +0200
Message-ID: <87cyr0uwsg.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Apr 5, 2024 at 5:44=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.c=
om> wrote:
>>
>> Support an instruction for resolving absolute addresses of per-CPU
>> data from their per-CPU offsets. This instruction is internal-only and
>> users are not allowed to use them directly. They will only be used for
>> internal inlining optimizations for now between BPF verifier and BPF
>> JITs.
>>
>> RISC-V uses generic per-cpu implementation where the offsets for CPUs
>> are kept in an array called __per_cpu_offset[cpu_number]. RISCV stores
>> the address of the task_struct in TP register. The first element in
>> tast_struct is struct thread_info, and we can get the cpu number by
>> reading from the TP register + offsetof(struct thread_info, cpu).
>>
>> Once we have the cpu number in a register we read the offset for that
>> cpu from address: &__per_cpu_offset + cpu_number << 3. Then we add this
>> offset to the destination register.
>>
>> To measure the improvement from this change, the benchmark in [1] was
>> used on Qemu:
>>
>> Before:
>> glob-arr-inc   :    1.127 =C2=B1 0.013M/s
>> arr-inc        :    1.121 =C2=B1 0.004M/s
>> hash-inc       :    0.681 =C2=B1 0.052M/s
>>
>> After:
>> glob-arr-inc   :    1.138 =C2=B1 0.011M/s
>> arr-inc        :    1.366 =C2=B1 0.006M/s
>> hash-inc       :    0.676 =C2=B1 0.001M/s
>
> TBH, I don't trust benchmarks done inside QEMU. Can you try running
> this on some real hardware?

I just ran it on a "VisionFive2" SBC:

BEFORE
=3D=3D=3D=3D=3D=3D
glob-arr-inc   :   11.586 =C2=B1 0.021M/s=20
arr-inc        :   10.892 =C2=B1 0.005M/s=20
hash-inc       :    1.517 =C2=B1 0.001M/s=20

AFTER
=3D=3D=3D=3D=3D
glob-arr-inc   :   11.893 =C2=B1 0.017M/s  (+2.6%)
arr-inc        :   11.630 =C2=B1 0.020M/s  (+6.8%)
hash-inc       :    1.543 =C2=B1 0.002M/s  (+1.7%)

(It's early, and the coffee haven't kicked in, so I hope the
calculations are correct...)

>>
>> [1] https://github.com/anakryiko/linux/commit/8dec900975ef
>>
>> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>> ---
>>  arch/riscv/net/bpf_jit_comp64.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_co=
mp64.c
>> index 15e482f2c657..e95bd1d459a4 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/stop_machine.h>
>>  #include <asm/patch.h>
>>  #include <asm/cfi.h>
>> +#include <asm/percpu.h>
>>  #include "bpf_jit.h"
>>
>>  #define RV_FENTRY_NINSNS 2
>> @@ -1089,6 +1090,24 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn=
, struct rv_jit_context *ctx,
>>                         emit_or(RV_REG_T1, rd, RV_REG_T1, ctx);
>>                         emit_mv(rd, RV_REG_T1, ctx);
>>                         break;
>> +               } else if (insn_is_mov_percpu_addr(insn)) {
>> +                       if (rd !=3D rs)
>> +                               emit_mv(rd, rs, ctx);
>
> Is this an unconditional move instruction? in x86-64, EMIT_mov checks
> whether source and destination registers are the same and doesn't emit
> anything if they match (which makes sense, right)?

Yeah, it is. Folding the check into the emit sounds like a good idea.


Bj=C3=B6rn

