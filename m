Return-Path: <bpf+bounces-62132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C33AF5D54
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8A71885A56
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 15:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391C02D7815;
	Wed,  2 Jul 2025 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ql0Uto42"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437F12D77EA
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470156; cv=none; b=CezshXXGWjyoMgMmBzhCWCDlE/x8I1pMAzAqspdw05Uv9z3tpv+wRQVDJw+0vKn4dDueR4WncQXmykKPwaopr3mNxlypFAr2lQmVtoYtgZfloLJm2suf2rt6C9EsHPsfKHcqqbP60VSKjku/eDhgv3VPY7dRfCyqn5YK+99hD5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470156; c=relaxed/simple;
	bh=BwuoJ6FqqNC6UvwTl956BdnHkxQZ0GV2qgQOkdcGyrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+D/q0UQbK4vj+ZxcUN7LDMCQ0wWv7TD8U8J6U25srxmoyMaVeNSE349Y+CuBh7YGTUaIbjDYBJQA2QLuYdW47ht59A14KSTaoopeQTBvPTGUVYCegGEYG2LpiiSDkJyGT4m+5D75Yl98pSoWwd17N16JCZ140JBneRLc1ulNP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ql0Uto42; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2214fd27-743a-4d50-8ca1-587998b0cc06@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751470151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6h7wy/RY5GHzQz0hJefZU4L/MJueAFsPYoZyuwq3sy8=;
	b=Ql0Uto42tbTZbwzqYzWJGufc/lSDPkPvWv5FBXn4HpukMTLHWi2T9dpuwRug9nggfCF1Kg
	AgO0gxJS3gxmY3X78vYwHdocVBKkzHj76G56lc/G6Ed2BqsbGHCR0yuPcwVchHvOBn3kYw
	bPSNRQDp9Rg1ooHGkGBn1lZf1e1DPGo=
Date: Wed, 2 Jul 2025 08:29:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Reduce stack frame size by using
 env->insn_buf for bpf insns
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Arnd Bergmann <arnd@kernel.org>
References: <20250702053332.1991516-1-yonghong.song@linux.dev>
 <CAADnVQ+DDozRPgFpFzBZ2NcZJ8WwOUxAY77CSOzkJ8QG=LpaVQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+DDozRPgFpFzBZ2NcZJ8WwOUxAY77CSOzkJ8QG=LpaVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/2/25 8:09 AM, Alexei Starovoitov wrote:
> On Tue, Jul 1, 2025 at 10:33 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Arnd Bergmann reported an issue ([1]) where clang compiler (less than
>> llvm18) may trigger an error where the stack frame size exceeds the limit.
>> I can reproduce the error like below:
>>    kernel/bpf/verifier.c:24491:5: error: stack frame size (2552) exceeds limit (1280) in 'bpf_check'
>>        [-Werror,-Wframe-larger-than]
>>    kernel/bpf/verifier.c:19921:12: error: stack frame size (1368) exceeds limit (1280) in 'do_check'
>>        [-Werror,-Wframe-larger-than]
>>
>> Use env->insn_buf for bpf insns instead of putting these insns on the
>> stack. This can resolve the above 'bpf_check' error. The 'do_check' error
>> will be resolved in the next patch.
>>
>>    [1] https://lore.kernel.org/bpf/20250620113846.3950478-1-arnd@kernel.org/
>>
>> Reported-by: Arnd Bergmann <arnd@kernel.org>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   kernel/bpf/verifier.c | 194 ++++++++++++++++++++----------------------
>>   1 file changed, 91 insertions(+), 103 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 90e688f81a48..29faef51065d 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -20939,26 +20939,27 @@ static bool insn_is_cond_jump(u8 code)
>>   static void opt_hard_wire_dead_code_branches(struct bpf_verifier_env *env)
>>   {
>>          struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
>> -       struct bpf_insn ja = BPF_JMP_IMM(BPF_JA, 0, 0, 0);
>> +       struct bpf_insn *ja = env->insn_buf;
> This one replaces 8 bytes on stack with an 8 byte pointer.
> Does it actually make a difference in stack usage?
> I have my doubts.

Probably no difference. I just made change here just to remove
*all* 'struct bpf_insn var/var[]' on the stack. But as you suggested,
I will remove this change.

>
>>          struct bpf_insn *insn = env->prog->insnsi;
>>          const int insn_cnt = env->prog->len;
>>          int i;
>>
>> +       *ja = BPF_JMP_IMM(BPF_JA, 0, 0, 0);
>>          for (i = 0; i < insn_cnt; i++, insn++) {
>>                  if (!insn_is_cond_jump(insn->code))
>>                          continue;
>>
>>                  if (!aux_data[i + 1].seen)
>> -                       ja.off = insn->off;
>> +                       ja->off = insn->off;
>>                  else if (!aux_data[i + 1 + insn->off].seen)
>> -                       ja.off = 0;
>> +                       ja->off = 0;
>>                  else
>>                          continue;
>>
>>                  if (bpf_prog_is_offloaded(env->prog->aux))
>> -                       bpf_prog_offload_replace_insn(env, i, &ja);
>> +                       bpf_prog_offload_replace_insn(env, i, ja);
>>
>> -               memcpy(insn, &ja, sizeof(ja));
>> +               memcpy(insn, ja, sizeof(*ja));
>>          }
>>   }
>>
>> @@ -21017,7 +21018,9 @@ static int opt_remove_nops(struct bpf_verifier_env *env)
>>   static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
>>                                           const union bpf_attr *attr)
>>   {
>> -       struct bpf_insn *patch, zext_patch[2], rnd_hi32_patch[4];
>> +       struct bpf_insn *patch;
>> +       struct bpf_insn *zext_patch = env->insn_buf;
>> +       struct bpf_insn *rnd_hi32_patch = &env->insn_buf[2];
>>          struct bpf_insn_aux_data *aux = env->insn_aux_data;
>>          int i, patch_len, delta = 0, len = env->prog->len;
>>          struct bpf_insn *insns = env->prog->insnsi;
>> @@ -21195,13 +21198,12 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>>
>>                  if (env->insn_aux_data[i + delta].nospec) {
>>                          WARN_ON_ONCE(env->insn_aux_data[i + delta].alu_state);
>> -                       struct bpf_insn patch[] = {
>> -                               BPF_ST_NOSPEC(),
>> -                               *insn,
>> -                       };
>> +                       struct bpf_insn *patch = &insn_buf[0];
> why &..[0] ? Can it just be patch = insn_buf ?

There are a couple of cases in the existing code, e.g.,

$ grep -C 2 "&insn_buf\[0\]" verifier.c
                     (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
                      BPF_MODE(insn->code) == BPF_PROBE_MEMSX)) {
                         struct bpf_insn *patch = &insn_buf[0];
                         u64 uaddress_limit = bpf_arch_uaddress_limit();

--
                         const u8 code_add = BPF_ALU64 | BPF_ADD | BPF_X;
                         const u8 code_sub = BPF_ALU64 | BPF_SUB | BPF_X;
                         struct bpf_insn *patch = &insn_buf[0];
                         bool issrc, isneg, isimm;
                         u32 off_reg;

I was using '... = &insn_buf[0]' to make code consistent.

Will change to use '... = insn_buf' including the above two cases.

>
>> -                       cnt = ARRAY_SIZE(patch);
>> -                       new_prog = bpf_patch_insn_data(env, i + delta, patch, cnt);
>> +                       *patch++ = BPF_ST_NOSPEC();
>> +                       *patch++ = *insn;
>> +                       cnt = patch - insn_buf;
>> +                       new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
>>                          if (!new_prog)
>>                                  return -ENOMEM;
>>
>> @@ -21269,13 +21271,12 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>>                          /* nospec_result is only used to mitigate Spectre v4 and
>>                           * to limit verification-time for Spectre v1.
>>                           */
>> -                       struct bpf_insn patch[] = {
>> -                               *insn,
>> -                               BPF_ST_NOSPEC(),
>> -                       };
>> +                       struct bpf_insn *patch = &insn_buf[0];
>>
>> -                       cnt = ARRAY_SIZE(patch);
>> -                       new_prog = bpf_patch_insn_data(env, i + delta, patch, cnt);
>> +                       *patch++ = *insn;
>> +                       *patch++ = BPF_ST_NOSPEC();
>> +                       cnt = patch - insn_buf;
>> +                       new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
>>                          if (!new_prog)
>>                                  return -ENOMEM;
>>
>> @@ -21945,13 +21946,12 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>>          u16 stack_depth_extra = 0;
>>
>>          if (env->seen_exception && !env->exception_callback_subprog) {
>> -               struct bpf_insn patch[] = {
>> -                       env->prog->insnsi[insn_cnt - 1],
>> -                       BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
>> -                       BPF_EXIT_INSN(),
>> -               };
>> +               struct bpf_insn *patch = &insn_buf[0];
>>
>> -               ret = add_hidden_subprog(env, patch, ARRAY_SIZE(patch));
>> +               *patch++ = env->prog->insnsi[insn_cnt - 1];
>> +               *patch++ = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
>> +               *patch++ = BPF_EXIT_INSN();
>> +               ret = add_hidden_subprog(env, insn_buf, patch - insn_buf);
>>                  if (ret < 0)
>>                          return ret;
>>                  prog = env->prog;
>> @@ -21987,20 +21987,18 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>>                      insn->off == 1 && insn->imm == -1) {
>>                          bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
>>                          bool isdiv = BPF_OP(insn->code) == BPF_DIV;
>> -                       struct bpf_insn *patchlet;
>> -                       struct bpf_insn chk_and_sdiv[] = {
>> -                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
>> -                                            BPF_NEG | BPF_K, insn->dst_reg,
>> -                                            0, 0, 0),
>> -                       };
>> -                       struct bpf_insn chk_and_smod[] = {
>> -                               BPF_MOV32_IMM(insn->dst_reg, 0),
>> -                       };
>> +                       struct bpf_insn *patch = &insn_buf[0];
>> +
>> +                       if (isdiv)
>> +                               *patch++ = BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
>> +                                                       BPF_NEG | BPF_K, insn->dst_reg,
>> +                                                       0, 0, 0);
>> +                       else
>> +                               *patch++ = BPF_MOV32_IMM(insn->dst_reg, 0);
>>
>> -                       patchlet = isdiv ? chk_and_sdiv : chk_and_smod;
>> -                       cnt = isdiv ? ARRAY_SIZE(chk_and_sdiv) : ARRAY_SIZE(chk_and_smod);
>> +                       cnt = patch - insn_buf;
>>
>> -                       new_prog = bpf_patch_insn_data(env, i + delta, patchlet, cnt);
>> +                       new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
>>                          if (!new_prog)
>>                                  return -ENOMEM;
>>
>> @@ -22019,83 +22017,73 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>>                          bool isdiv = BPF_OP(insn->code) == BPF_DIV;
>>                          bool is_sdiv = isdiv && insn->off == 1;
>>                          bool is_smod = !isdiv && insn->off == 1;
>> -                       struct bpf_insn *patchlet;
>> -                       struct bpf_insn chk_and_div[] = {
>> -                               /* [R,W]x div 0 -> 0 */
>> -                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
>> -                                            BPF_JNE | BPF_K, insn->src_reg,
>> -                                            0, 2, 0),
>> -                               BPF_ALU32_REG(BPF_XOR, insn->dst_reg, insn->dst_reg),
>> -                               BPF_JMP_IMM(BPF_JA, 0, 0, 1),
>> -                               *insn,
>> -                       };
>> -                       struct bpf_insn chk_and_mod[] = {
>> -                               /* [R,W]x mod 0 -> [R,W]x */
>> -                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
>> -                                            BPF_JEQ | BPF_K, insn->src_reg,
>> -                                            0, 1 + (is64 ? 0 : 1), 0),
>> -                               *insn,
>> -                               BPF_JMP_IMM(BPF_JA, 0, 0, 1),
>> -                               BPF_MOV32_REG(insn->dst_reg, insn->dst_reg),
>> -                       };
>> -                       struct bpf_insn chk_and_sdiv[] = {
>> +                       struct bpf_insn *patch = &insn_buf[0];
>> +
>> +                       if (is_sdiv) {
>>                                  /* [R,W]x sdiv 0 -> 0
>>                                   * LLONG_MIN sdiv -1 -> LLONG_MIN
>>                                   * INT_MIN sdiv -1 -> INT_MIN
>>                                   */
>> -                               BPF_MOV64_REG(BPF_REG_AX, insn->src_reg),
>> -                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
>> -                                            BPF_ADD | BPF_K, BPF_REG_AX,
>> -                                            0, 0, 1),
>> -                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
>> -                                            BPF_JGT | BPF_K, BPF_REG_AX,
>> -                                            0, 4, 1),
>> -                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
>> -                                            BPF_JEQ | BPF_K, BPF_REG_AX,
>> -                                            0, 1, 0),
>> -                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
>> -                                            BPF_MOV | BPF_K, insn->dst_reg,
>> -                                            0, 0, 0),
>> +                               *patch++ = BPF_MOV64_REG(BPF_REG_AX, insn->src_reg);
>> +                               *patch++ = BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
>> +                                                       BPF_ADD | BPF_K, BPF_REG_AX,
>> +                                                       0, 0, 1);
>> +                               *patch++ = BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
>> +                                                       BPF_JGT | BPF_K, BPF_REG_AX,
>> +                                                       0, 4, 1);
>> +                               *patch++ = BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
>> +                                                       BPF_JEQ | BPF_K, BPF_REG_AX,
>> +                                                       0, 1, 0);
>> +                               *patch++ = BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
>> +                                                       BPF_MOV | BPF_K, insn->dst_reg,
>> +                                                       0, 0, 0);
>>                                  /* BPF_NEG(LLONG_MIN) == -LLONG_MIN == LLONG_MIN */
>> -                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
>> -                                            BPF_NEG | BPF_K, insn->dst_reg,
>> -                                            0, 0, 0),
>> -                               BPF_JMP_IMM(BPF_JA, 0, 0, 1),
>> -                               *insn,
>> -                       };
>> -                       struct bpf_insn chk_and_smod[] = {
>> +                               *patch++ = BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
>> +                                                       BPF_NEG | BPF_K, insn->dst_reg,
>> +                                                       0, 0, 0);
>> +                               *patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
>> +                               *patch++ = *insn;
>> +                               cnt = patch - insn_buf;
>> +                       } else if (is_smod) {
>>                                  /* [R,W]x mod 0 -> [R,W]x */
>>                                  /* [R,W]x mod -1 -> 0 */
>> -                               BPF_MOV64_REG(BPF_REG_AX, insn->src_reg),
>> -                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
>> -                                            BPF_ADD | BPF_K, BPF_REG_AX,
>> -                                            0, 0, 1),
>> -                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
>> -                                            BPF_JGT | BPF_K, BPF_REG_AX,
>> -                                            0, 3, 1),
>> -                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
>> -                                            BPF_JEQ | BPF_K, BPF_REG_AX,
>> -                                            0, 3 + (is64 ? 0 : 1), 1),
>> -                               BPF_MOV32_IMM(insn->dst_reg, 0),
>> -                               BPF_JMP_IMM(BPF_JA, 0, 0, 1),
>> -                               *insn,
>> -                               BPF_JMP_IMM(BPF_JA, 0, 0, 1),
>> -                               BPF_MOV32_REG(insn->dst_reg, insn->dst_reg),
>> -                       };
>> -
>> -                       if (is_sdiv) {
>> -                               patchlet = chk_and_sdiv;
>> -                               cnt = ARRAY_SIZE(chk_and_sdiv);
>> -                       } else if (is_smod) {
>> -                               patchlet = chk_and_smod;
>> -                               cnt = ARRAY_SIZE(chk_and_smod) - (is64 ? 2 : 0);
>> +                               *patch++ = BPF_MOV64_REG(BPF_REG_AX, insn->src_reg);
>> +                               *patch++ = BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
>> +                                                       BPF_ADD | BPF_K, BPF_REG_AX,
>> +                                                       0, 0, 1);
>> +                               *patch++ = BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
>> +                                                       BPF_JGT | BPF_K, BPF_REG_AX,
>> +                                                       0, 3, 1);
>> +                               *patch++ = BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
>> +                                                       BPF_JEQ | BPF_K, BPF_REG_AX,
>> +                                                       0, 3 + (is64 ? 0 : 1), 1);
>> +                               *patch++ = BPF_MOV32_IMM(insn->dst_reg, 0);
>> +                               *patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
>> +                               *patch++ = *insn;
>> +                               *patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
>> +                               *patch++ = BPF_MOV32_REG(insn->dst_reg, insn->dst_reg);
>> +                               cnt = (patch - insn_buf) - (is64 ? 2 : 0);
>> +                       } else if (isdiv) {
>> +                               /* [R,W]x div 0 -> 0 */
>> +                               *patch++ = BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
>> +                                                       BPF_JNE | BPF_K, insn->src_reg,
>> +                                                       0, 2, 0);
>> +                               *patch++ = BPF_ALU32_REG(BPF_XOR, insn->dst_reg, insn->dst_reg);
>> +                               *patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
>> +                               *patch++ = *insn;
>> +                               cnt = patch - insn_buf;
>>                          } else {
>> -                               patchlet = isdiv ? chk_and_div : chk_and_mod;
>> -                               cnt = isdiv ? ARRAY_SIZE(chk_and_div) :
>> -                                             ARRAY_SIZE(chk_and_mod) - (is64 ? 2 : 0);
>> +                               /* [R,W]x mod 0 -> [R,W]x */
>> +                               *patch++ = BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
>> +                                                       BPF_JEQ | BPF_K, insn->src_reg,
>> +                                                       0, 1 + (is64 ? 0 : 1), 0);
>> +                               *patch++ = *insn;
>> +                               *patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
>> +                               *patch++ = BPF_MOV32_REG(insn->dst_reg, insn->dst_reg);
>> +                               cnt = (patch - insn_buf) - (is64 ? 2 : 0);
> hmm. why populate two extra insn just to drop them ?
> Don't add the last two insn instead.
> I would also simplify the previous jmp32 vs jmp generation by
> testing if (is64) once and at the end cnt = patch - insn_buf;

Make sense. Will do.

>
> --
> pw-bot: cr
>


