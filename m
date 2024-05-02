Return-Path: <bpf+bounces-28455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8378B9E58
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 18:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373A71F22E9E
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 16:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A7C15CD52;
	Thu,  2 May 2024 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVaarcyh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDBA1586D5;
	Thu,  2 May 2024 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714666690; cv=none; b=T5D+1JYx/6oSpkfewmj4dpZRlsN4p1eTD5ZOkbMp0jW778rKvVghAi0MTKzCxajiaslVQh16335TxoTdR0Mg98JqFl77zvamXLrwbucEKeUpBWilcQUbmDVjkB5IKC0ITNWjxkNdvoyT9oSqAIRXaMfHLSaC9UaSER/+2Si82Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714666690; c=relaxed/simple;
	bh=6NQhuMcNkmpWazM0HHYky5tZ2j68IK0b4aybNOPTBRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NDbCq2WaNR2SrJk8hc3plMcHa79Gu4mt39KOJXfNp9NMwRdRpG1FSGG1OBHaYSUJaQy0TomJf6CgeIxqS8Xy3JUqYgA1i72FOATD7INZyhmvHUmchnJR8G+S5X1e5WvLgebfia5AIlGDphSBq3Bnn0Rgd+xTsFvrV6TGUjZYloA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVaarcyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE04C113CC;
	Thu,  2 May 2024 16:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714666690;
	bh=6NQhuMcNkmpWazM0HHYky5tZ2j68IK0b4aybNOPTBRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DVaarcyhyqTPFst4peTVuc9ArbfOqACLBdPeQH2p0+rqkOhyOVV9Xh7OIoX4FknVF
	 Sn7+gecM7Sz2oICS+8bVUzPW07FGUfDKOPvxD8TmgTuEA5XZEG81KISdQ20CO4ZomE
	 M41E8o8MPBSi10WXCPXPdoqB3wxlXwYidlLSQFevLud01ck5Q34NJdqluekPKBsAmO
	 LgNBL0JWTFWd+X3yljpjs2+pQscTMvQ1icWonnkskJYDbFHVjHM7xGVzJwo8bqmkV9
	 nwtSs7vru4n/aufQYAj5IYbSkIEykr+3lvf/Em5TCttCsNh5CvAJLZ6F8X72dNCbZk
	 nSwTGsVhdrjuQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Puranjay Mohan
 <puranjay@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Pu Lehui <pulehui@huawei.com>,
 puranjay12@gmail.com
Subject: Re: [PATCH bpf-next v2 1/2] riscv, bpf: add internal-only MOV
 instruction to resolve per-CPU addrs
In-Reply-To: <CAEf4Bzb2NY+wuK159Xb8F9Nu4CuVoYJ6WWR3_0LeTAi+zONewQ@mail.gmail.com>
References: <20240430175834.33152-1-puranjay@kernel.org>
 <20240430175834.33152-2-puranjay@kernel.org>
 <CAEf4Bzb2NY+wuK159Xb8F9Nu4CuVoYJ6WWR3_0LeTAi+zONewQ@mail.gmail.com>
Date: Thu, 02 May 2024 18:18:06 +0200
Message-ID: <87jzkcw5kx.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Tue, Apr 30, 2024 at 10:58=E2=80=AFAM Puranjay Mohan <puranjay@kernel.=
org> wrote:
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
>> task_struct is struct thread_info, and we can get the cpu number by
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
>>
>> [1] https://github.com/anakryiko/linux/commit/8dec900975ef
>>
>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>> ---
>>  arch/riscv/net/bpf_jit_comp64.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_co=
mp64.c
>> index 15e482f2c657..99d7006f1420 100644
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

No biggie, but you did not fold this check into emit_mv().

>> +#ifdef CONFIG_SMP
>> +                               /* Load current CPU number in T1 */
>> +                               emit_ld(RV_REG_T1, offsetof(struct threa=
d_info, cpu),
>> +                                       RV_REG_TP, ctx);
>> +                               /* << 3 because offsets are 8 bytes */
>> +                               emit_slli(RV_REG_T1, RV_REG_T1, 3, ctx);
>> +                               /* Load address of __per_cpu_offset arra=
y in T2 */
>> +                               emit_addr(RV_REG_T2, (u64)&__per_cpu_off=
set, extra_pass, ctx);
>> +                               /* Add offset of current CPU to  __per_c=
pu_offset */
>> +                               emit_add(RV_REG_T1, RV_REG_T2, RV_REG_T1=
, ctx);
>> +                               /* Load __per_cpu_offset[cpu] in T1 */
>> +                               emit_ld(RV_REG_T1, 0, RV_REG_T1, ctx);
>> +                               /* Add the offset to Rd */
>> +                               emit_add(rd, rd, RV_REG_T1, ctx);
>
> is this the right level of code indentation?

Looks wrong.

When the indent is fixed, feel free to add:

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

