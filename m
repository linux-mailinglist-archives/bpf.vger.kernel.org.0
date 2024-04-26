Return-Path: <bpf+bounces-27949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB148B3D98
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 19:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 694D5B221B1
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 17:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594EC15B579;
	Fri, 26 Apr 2024 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcUaN9qs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE4615A4BE;
	Fri, 26 Apr 2024 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714151214; cv=none; b=G6EqKaWlLDX/az60WElUzdFuBVDWpt4yc1Wu3oFQFLE3YK+UHgjnRH33y+ymahleR5a9KVvIoOeW5tQio6yjOMt3CHgrBCeMhRpPuSD64yclDgpL5GExrvMKw/MmPFojCu0+MZxotELw85WY1ekhucVKtbcL3llqjxLXRgcVJZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714151214; c=relaxed/simple;
	bh=09NdAbWR/BLtK6lbUCey7vstmTIMgsOSSq3Yz9q528c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TsRWJB6ox4Ve0doRImsPR8x38QUgRTm2Mj+jejywju1LV7SJAViMEYndi3WtO1u/80xkFlL9t9wfR/rYFU3BHAifLXXNNKHeo8PbE5x+XEjSxlM8NOpumZ9Q5ETknNY+NX04wfiyrOV/xvVWfxvkX9Xgh14Hwcj1z1FbNmR0/q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcUaN9qs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D857C116B1;
	Fri, 26 Apr 2024 17:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714151214;
	bh=09NdAbWR/BLtK6lbUCey7vstmTIMgsOSSq3Yz9q528c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XcUaN9qshZw1p9fPgu+96aFUN619FikB2yN0B0sbB6zqz5ientRrM+j2M6bfYAxDz
	 jDQmc8jTsMe51HVJH7QrZPSo1yNawnWcnQsmLr1/Rzenjb1669QGNKl7gY5PV+WXIs
	 X1XlKQoD6jK5OANOk42v3gDLQOGtqlwa7LlAsl029gzhMiFWtS165mtrlyUjwwSB+n
	 ByJvXQO2YlTq1/xUn63kqrNk42eBPmC+nbgQQx6iBdFV6JPF6rjr6F0g8GZcrFaKmB
	 XWpDP8neWaOA/cqvabzHOF6WB+6hzBYTZxZ2PS7kMujUFpm52XuSyD0RFl1m7mqAE1
	 8jZ/nQOnfLPYw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>, Xu Kuohai
 <xukuohai@huawei.com>, Florent Revest <revest@chromium.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 2/2] bpf, arm64: inline
 bpf_get_smp_processor_id() helper
In-Reply-To: <CAEf4BzaNM5H3Ad2=Syhhq1cbfuB5FrtuFTZHPTdQP3QME3naKA@mail.gmail.com>
References: <20240426121349.97651-1-puranjay@kernel.org>
 <20240426121349.97651-3-puranjay@kernel.org>
 <CAEf4BzaNM5H3Ad2=Syhhq1cbfuB5FrtuFTZHPTdQP3QME3naKA@mail.gmail.com>
Date: Fri, 26 Apr 2024 17:06:51 +0000
Message-ID: <mb61pplucvys4.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Apr 26, 2024 at 5:14=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
>>
>> As ARM64 JIT now implements BPF_MOV64_PERCPU_REG instruction, inline
>> bpf_get_smp_processor_id().
>>
>> ARM64 uses the per-cpu variable cpu_number to store the cpu id.
>>
>> Here is how the BPF and ARM64 JITed assembly changes after this commit:
>>
>>                                          BPF
>>                                         =3D=3D=3D=3D=3D
>>               BEFORE                                       AFTER
>>              --------                                     -------
>>
>> int cpu =3D bpf_get_smp_processor_id();           int cpu =3D bpf_get_sm=
p_processor_id();
>> (85) call bpf_get_smp_processor_id#229032       (18) r0 =3D 0xffff800082=
072008
>>                                                 (bf) r0 =3D &(void __per=
cpu *)(r0)
>>                                                 (61) r0 =3D *(u32 *)(r0 =
+0)
>>
>>                                       ARM64 JIT
>>                                      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>>               BEFORE                                       AFTER
>>              --------                                     -------
>>
>> int cpu =3D bpf_get_smp_processor_id();           int cpu =3D bpf_get_sm=
p_processor_id();
>> mov     x10, #0xfffffffffffff4d0                mov     x7, #0xffff8000f=
fffffff
>> movk    x10, #0x802b, lsl #16                   movk    x7, #0x8207, lsl=
 #16
>> movk    x10, #0x8000, lsl #32                   movk    x7, #0x2008
>> blr     x10                                     mrs     x10, tpidr_el1
>> add     x7, x0, #0x0                            add     x7, x7, x10
>>                                                 ldr     w7, [x7]
>>
>> Performance improvement using benchmark[1]
>>
>>              BEFORE                                       AFTER
>>             --------                                     -------
>>
>> glob-arr-inc   :   23.817 =C2=B1 0.019M/s      glob-arr-inc   :   24.631=
 =C2=B1 0.027M/s
>> arr-inc        :   23.253 =C2=B1 0.019M/s      arr-inc        :   23.742=
 =C2=B1 0.023M/s
>> hash-inc       :   12.258 =C2=B1 0.010M/s      hash-inc       :   12.625=
 =C2=B1 0.004M/s
>>
>> [1] https://github.com/anakryiko/linux/commit/8dec900975ef
>>
>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>> ---
>>  kernel/bpf/verifier.c | 24 +++++++++++++++++-------
>>  1 file changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 4e474ef44e9c..6ff4e63b2ef2 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -20273,20 +20273,31 @@ static int do_misc_fixups(struct bpf_verifier_=
env *env)
>>                         goto next_insn;
>>                 }
>>
>> -#ifdef CONFIG_X86_64
>>                 /* Implement bpf_get_smp_processor_id() inline. */
>>                 if (insn->imm =3D=3D BPF_FUNC_get_smp_processor_id &&
>>                     prog->jit_requested && bpf_jit_supports_percpu_insn(=
)) {
>>                         /* BPF_FUNC_get_smp_processor_id inlining is an
>> -                        * optimization, so if pcpu_hot.cpu_number is ev=
er
>> +                        * optimization, so if cpu_number_addr is ever
>>                          * changed in some incompatible and hard to supp=
ort
>>                          * way, it's fine to back out this inlining logic
>>                          */
>> -                       insn_buf[0] =3D BPF_MOV32_IMM(BPF_REG_0, (u32)(u=
nsigned long)&pcpu_hot.cpu_number);
>> -                       insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, =
BPF_REG_0);
>> -                       insn_buf[2] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, BP=
F_REG_0, 0);
>> -                       cnt =3D 3;
>> +                       u64 cpu_number_addr;
>>
>> +#if defined(CONFIG_X86_64)
>> +                       cpu_number_addr =3D (u64)&pcpu_hot.cpu_number;
>> +#elif defined(CONFIG_ARM64)
>> +                       cpu_number_addr =3D (u64)&cpu_number;
>> +#else
>> +                       goto next_insn;
>> +#endif
>> +                       struct bpf_insn ld_cpu_number_addr[2] =3D {
>> +                               BPF_LD_IMM64(BPF_REG_0, cpu_number_addr)
>> +                       };
>
> here we are violating C89 requirement to have a single block of
> variable declarations by mixing variables and statements. I'm
> surprised this is not triggering any build errors on !arm64 &&
> !x86_64.
>
> I think we can declare this BPF_LD_IMM64 instruction with zero "addr".
> And then update
>
> ld_cpu_number_addr[0].imm =3D (u32)cpu_number_addr;
> ld_cpu_number_addr[1].imm =3D (u32)(cpu_number_addr >> 32);
>
> WDYT?
>
> nit: I'd rename ld_cpu_number_addr to ld_insn or something short like that

I agree with you,
What do you think about the following diff:

--- 8< ---

-#ifdef CONFIG_X86_64
                /* Implement bpf_get_smp_processor_id() inline. */
                if (insn->imm =3D=3D BPF_FUNC_get_smp_processor_id &&
                    prog->jit_requested && bpf_jit_supports_percpu_insn()) {
                        /* BPF_FUNC_get_smp_processor_id inlining is an
-                        * optimization, so if pcpu_hot.cpu_number is ever
+                        * optimization, so if cpu_number_addr is ever
                         * changed in some incompatible and hard to support
                         * way, it's fine to back out this inlining logic
                         */
-                       insn_buf[0] =3D BPF_MOV32_IMM(BPF_REG_0, (u32)(unsi=
gned long)&pcpu_hot.cpu_number);
-                       insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF=
_REG_0);
-                       insn_buf[2] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_R=
EG_0, 0);
-                       cnt =3D 3;
+                       u64 cpu_number_addr;
+                       struct bpf_insn ld_insn[2] =3D {
+                               BPF_LD_IMM64(BPF_REG_0, 0)
+                       };
+
+#if defined(CONFIG_X86_64)
+                       cpu_number_addr =3D (u64)&pcpu_hot.cpu_number;
+#elif defined(CONFIG_ARM64)
+                       cpu_number_addr =3D (u64)&cpu_number;
+#else
+                       goto next_insn;
+#endif
+                       ld_insn[0].imm =3D (u32)cpu_number_addr;
+                       ld_insn[1].imm =3D (u32)(cpu_number_addr >> 32);
+                       insn_buf[0] =3D ld_insn[0];
+                       insn_buf[1] =3D ld_insn[1];
+                       insn_buf[2] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF=
_REG_0);
+                       insn_buf[3] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_R=
EG_0, 0);
+                       cnt =3D 4;

                        new_prog =3D bpf_patch_insn_data(env, i + delta, in=
sn_buf, cnt);
                        if (!new_prog)
@@ -20296,7 +20310,6 @@ static int do_misc_fixups(struct bpf_verifier_env *=
env)
                        insn      =3D new_prog->insnsi + i + delta;
                        goto next_insn;
                }
-#endif
                /* Implement bpf_get_func_arg inline. */

--- >8---

Thanks,
Puranjay

