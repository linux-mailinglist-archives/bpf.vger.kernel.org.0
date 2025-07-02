Return-Path: <bpf+bounces-62130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F70AF5C51
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFD1D7A6F62
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 15:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BCF2D372D;
	Wed,  2 Jul 2025 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+tOuX/D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE922D3729
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751469000; cv=none; b=Wg4epdcoU9Ct4YHNckEvbjD7Y7FT14MEQFiWMtNxfwIh8dkwjdjQznOm3zcP8s0WAWd2oDI0VB/yfKHZZ6JlNHIcBrjko8Zplo9J6qzobuUCu3tJuyBgoUWkrMtsC/P3fVMmwAHz7dJg5Eovxk/0ZI/nlELgE9oDQJIdeDjbmXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751469000; c=relaxed/simple;
	bh=z3BK+eH3qvDWkVMnXectM4fwsaSMbdswfBSoWH+cQVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUY11g1q+5dkrh0CXS6KA3joRCGXlGGiRUXIpXe5qowoDvpPC6n44EJRT/4LQyu13O9FmYxuLJH4wbFkO99eCRH1G1ar1qL94C6kl8vVI7xYoYtN7KeDZCpsFcqnBoX7dX8hG980e9FC2F/vWwg4vj3/xGSu7iiSzZ9zmmQ+iBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+tOuX/D; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a50fc819f2so4930003f8f.2
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 08:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751468996; x=1752073796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKHqDIDCyJvwri6q4RJAldr9w3avBuHlm+l6gi0F8LY=;
        b=B+tOuX/DcS4GYiqhhW/dQ97EbkuV8TjIm9qybHDk7+7ukF8aTNaSw8inO2RVLCaMI0
         M/oVTj2PrrT+QTCoJ8YqvuJ5ru2lehRNPGYx3LDSN6T41kRW9gbrSViT1BJcIAI9w+Qq
         c6TzNwUUrAou7RfeB/hArHMObeTaBZ/y5m33/orWxRQOnRYswIAsFom+jeROsDEabJD2
         hnMCqoHkTcFLd8G3hpKWF+6hOg/BVhpgbR2plqWvDgjxSd2L93QSIK6HpQUqptig5UCl
         0qJpthzV2yK9wS6pmqm8WNsuK+0bkG50raOCmwyV+BGx2aosITeslEdVtIO0ndQSFo6P
         fB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751468996; x=1752073796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKHqDIDCyJvwri6q4RJAldr9w3avBuHlm+l6gi0F8LY=;
        b=pmvLv/z3gZkl++d5mDfUFC4R4kN+2K21PRmPGtU9XtABvgVdejsVZfXy7KAdbzDUQ+
         /1mafHyH9kOgVnq5j2fKTbFsTSfk2EPBHRgo5UWz9jYWesJ+xJ5e9MGl0LRDk8UVICBH
         EXJmEQilxrZKpTqs7xcdw78gq01G+Ld/O2Q8HKrO+MaL4Q33FvGd7rU/nalkAcyAt0I4
         XGFK68bGBaTqlAHheizy4jfXPhB/+vJ9lYlMOc1jB6c4v+4D4smCktDGFu7BitkV8tyd
         S/Fjw+uPe506fxVkQaSGQm0L4jXpPgDWCl7d1lgAWM6ArRRwr/yiLWV1Zca8jPpXuuiz
         Adbg==
X-Gm-Message-State: AOJu0YxnkfH3neU7VFhnlxrkV9S09eGNeX0C0XQM2wERt75oq0uMmFGz
	2kVaRhnXk2opAmGSZj4vkdWzObdDEZr2KC46sYCl4BqiZgL2MjRy5igG39Ev9YCJjYLe/qjOkqG
	MFmrzURtAwni5q0z+xZLd1eqoPCCWRIc=
X-Gm-Gg: ASbGncv/J16VH7t0bzA1I7DhlWhbBave93nY4HuUtzPgvJ/T+yTWAdia5gKLV9crC75
	dKUdHXNOFcNBDRaD/DkZFioplwE5S+7LTz8hs8PSWMQf0wNqv3wvvIydDGEijngmZyadgVP60/G
	FVKFiOUbmoe7OUMzHlz0lwRTVfDb1ZAIRNNT/1gdTBI8wl57KMU1cQswPlBBA=
X-Google-Smtp-Source: AGHT+IHpL6VCY8Nuvipc21hNc6Ie9NTjvS4NwljQyB4s6Y//++tBLl5zs1sonYMAzn4+wpkHc2Ygz3pt8hXvqEPHqLk=
X-Received: by 2002:a05:6000:41de:b0:3a5:2949:6c38 with SMTP id
 ffacd0b85a97d-3b2012033e3mr3041450f8f.52.1751468995691; Wed, 02 Jul 2025
 08:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702053332.1991516-1-yonghong.song@linux.dev>
In-Reply-To: <20250702053332.1991516-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 2 Jul 2025 08:09:43 -0700
X-Gm-Features: Ac12FXyiPsCkNOCQMEJIB13At-M4FZhv-jf_mpMqkcWze6yu4NWn5IYnq0EYhg8
Message-ID: <CAADnVQ+DDozRPgFpFzBZ2NcZJ8WwOUxAY77CSOzkJ8QG=LpaVQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Reduce stack frame size by using
 env->insn_buf for bpf insns
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 10:33=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Arnd Bergmann reported an issue ([1]) where clang compiler (less than
> llvm18) may trigger an error where the stack frame size exceeds the limit=
.
> I can reproduce the error like below:
>   kernel/bpf/verifier.c:24491:5: error: stack frame size (2552) exceeds l=
imit (1280) in 'bpf_check'
>       [-Werror,-Wframe-larger-than]
>   kernel/bpf/verifier.c:19921:12: error: stack frame size (1368) exceeds =
limit (1280) in 'do_check'
>       [-Werror,-Wframe-larger-than]
>
> Use env->insn_buf for bpf insns instead of putting these insns on the
> stack. This can resolve the above 'bpf_check' error. The 'do_check' error
> will be resolved in the next patch.
>
>   [1] https://lore.kernel.org/bpf/20250620113846.3950478-1-arnd@kernel.or=
g/
>
> Reported-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/verifier.c | 194 ++++++++++++++++++++----------------------
>  1 file changed, 91 insertions(+), 103 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 90e688f81a48..29faef51065d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20939,26 +20939,27 @@ static bool insn_is_cond_jump(u8 code)
>  static void opt_hard_wire_dead_code_branches(struct bpf_verifier_env *en=
v)
>  {
>         struct bpf_insn_aux_data *aux_data =3D env->insn_aux_data;
> -       struct bpf_insn ja =3D BPF_JMP_IMM(BPF_JA, 0, 0, 0);
> +       struct bpf_insn *ja =3D env->insn_buf;

This one replaces 8 bytes on stack with an 8 byte pointer.
Does it actually make a difference in stack usage?
I have my doubts.

>         struct bpf_insn *insn =3D env->prog->insnsi;
>         const int insn_cnt =3D env->prog->len;
>         int i;
>
> +       *ja =3D BPF_JMP_IMM(BPF_JA, 0, 0, 0);
>         for (i =3D 0; i < insn_cnt; i++, insn++) {
>                 if (!insn_is_cond_jump(insn->code))
>                         continue;
>
>                 if (!aux_data[i + 1].seen)
> -                       ja.off =3D insn->off;
> +                       ja->off =3D insn->off;
>                 else if (!aux_data[i + 1 + insn->off].seen)
> -                       ja.off =3D 0;
> +                       ja->off =3D 0;
>                 else
>                         continue;
>
>                 if (bpf_prog_is_offloaded(env->prog->aux))
> -                       bpf_prog_offload_replace_insn(env, i, &ja);
> +                       bpf_prog_offload_replace_insn(env, i, ja);
>
> -               memcpy(insn, &ja, sizeof(ja));
> +               memcpy(insn, ja, sizeof(*ja));
>         }
>  }
>
> @@ -21017,7 +21018,9 @@ static int opt_remove_nops(struct bpf_verifier_en=
v *env)
>  static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
>                                          const union bpf_attr *attr)
>  {
> -       struct bpf_insn *patch, zext_patch[2], rnd_hi32_patch[4];
> +       struct bpf_insn *patch;
> +       struct bpf_insn *zext_patch =3D env->insn_buf;
> +       struct bpf_insn *rnd_hi32_patch =3D &env->insn_buf[2];
>         struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
>         int i, patch_len, delta =3D 0, len =3D env->prog->len;
>         struct bpf_insn *insns =3D env->prog->insnsi;
> @@ -21195,13 +21198,12 @@ static int convert_ctx_accesses(struct bpf_veri=
fier_env *env)
>
>                 if (env->insn_aux_data[i + delta].nospec) {
>                         WARN_ON_ONCE(env->insn_aux_data[i + delta].alu_st=
ate);
> -                       struct bpf_insn patch[] =3D {
> -                               BPF_ST_NOSPEC(),
> -                               *insn,
> -                       };
> +                       struct bpf_insn *patch =3D &insn_buf[0];

why &..[0] ? Can it just be patch =3D insn_buf ?

>
> -                       cnt =3D ARRAY_SIZE(patch);
> -                       new_prog =3D bpf_patch_insn_data(env, i + delta, =
patch, cnt);
> +                       *patch++ =3D BPF_ST_NOSPEC();
> +                       *patch++ =3D *insn;
> +                       cnt =3D patch - insn_buf;
> +                       new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, cnt);
>                         if (!new_prog)
>                                 return -ENOMEM;
>
> @@ -21269,13 +21271,12 @@ static int convert_ctx_accesses(struct bpf_veri=
fier_env *env)
>                         /* nospec_result is only used to mitigate Spectre=
 v4 and
>                          * to limit verification-time for Spectre v1.
>                          */
> -                       struct bpf_insn patch[] =3D {
> -                               *insn,
> -                               BPF_ST_NOSPEC(),
> -                       };
> +                       struct bpf_insn *patch =3D &insn_buf[0];
>
> -                       cnt =3D ARRAY_SIZE(patch);
> -                       new_prog =3D bpf_patch_insn_data(env, i + delta, =
patch, cnt);
> +                       *patch++ =3D *insn;
> +                       *patch++ =3D BPF_ST_NOSPEC();
> +                       cnt =3D patch - insn_buf;
> +                       new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, cnt);
>                         if (!new_prog)
>                                 return -ENOMEM;
>
> @@ -21945,13 +21946,12 @@ static int do_misc_fixups(struct bpf_verifier_e=
nv *env)
>         u16 stack_depth_extra =3D 0;
>
>         if (env->seen_exception && !env->exception_callback_subprog) {
> -               struct bpf_insn patch[] =3D {
> -                       env->prog->insnsi[insn_cnt - 1],
> -                       BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
> -                       BPF_EXIT_INSN(),
> -               };
> +               struct bpf_insn *patch =3D &insn_buf[0];
>
> -               ret =3D add_hidden_subprog(env, patch, ARRAY_SIZE(patch))=
;
> +               *patch++ =3D env->prog->insnsi[insn_cnt - 1];
> +               *patch++ =3D BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
> +               *patch++ =3D BPF_EXIT_INSN();
> +               ret =3D add_hidden_subprog(env, insn_buf, patch - insn_bu=
f);
>                 if (ret < 0)
>                         return ret;
>                 prog =3D env->prog;
> @@ -21987,20 +21987,18 @@ static int do_misc_fixups(struct bpf_verifier_e=
nv *env)
>                     insn->off =3D=3D 1 && insn->imm =3D=3D -1) {
>                         bool is64 =3D BPF_CLASS(insn->code) =3D=3D BPF_AL=
U64;
>                         bool isdiv =3D BPF_OP(insn->code) =3D=3D BPF_DIV;
> -                       struct bpf_insn *patchlet;
> -                       struct bpf_insn chk_and_sdiv[] =3D {
> -                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU)=
 |
> -                                            BPF_NEG | BPF_K, insn->dst_r=
eg,
> -                                            0, 0, 0),
> -                       };
> -                       struct bpf_insn chk_and_smod[] =3D {
> -                               BPF_MOV32_IMM(insn->dst_reg, 0),
> -                       };
> +                       struct bpf_insn *patch =3D &insn_buf[0];
> +
> +                       if (isdiv)
> +                               *patch++ =3D BPF_RAW_INSN((is64 ? BPF_ALU=
64 : BPF_ALU) |
> +                                                       BPF_NEG | BPF_K, =
insn->dst_reg,
> +                                                       0, 0, 0);
> +                       else
> +                               *patch++ =3D BPF_MOV32_IMM(insn->dst_reg,=
 0);
>
> -                       patchlet =3D isdiv ? chk_and_sdiv : chk_and_smod;
> -                       cnt =3D isdiv ? ARRAY_SIZE(chk_and_sdiv) : ARRAY_=
SIZE(chk_and_smod);
> +                       cnt =3D patch - insn_buf;
>
> -                       new_prog =3D bpf_patch_insn_data(env, i + delta, =
patchlet, cnt);
> +                       new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, cnt);
>                         if (!new_prog)
>                                 return -ENOMEM;
>
> @@ -22019,83 +22017,73 @@ static int do_misc_fixups(struct bpf_verifier_e=
nv *env)
>                         bool isdiv =3D BPF_OP(insn->code) =3D=3D BPF_DIV;
>                         bool is_sdiv =3D isdiv && insn->off =3D=3D 1;
>                         bool is_smod =3D !isdiv && insn->off =3D=3D 1;
> -                       struct bpf_insn *patchlet;
> -                       struct bpf_insn chk_and_div[] =3D {
> -                               /* [R,W]x div 0 -> 0 */
> -                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32)=
 |
> -                                            BPF_JNE | BPF_K, insn->src_r=
eg,
> -                                            0, 2, 0),
> -                               BPF_ALU32_REG(BPF_XOR, insn->dst_reg, ins=
n->dst_reg),
> -                               BPF_JMP_IMM(BPF_JA, 0, 0, 1),
> -                               *insn,
> -                       };
> -                       struct bpf_insn chk_and_mod[] =3D {
> -                               /* [R,W]x mod 0 -> [R,W]x */
> -                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32)=
 |
> -                                            BPF_JEQ | BPF_K, insn->src_r=
eg,
> -                                            0, 1 + (is64 ? 0 : 1), 0),
> -                               *insn,
> -                               BPF_JMP_IMM(BPF_JA, 0, 0, 1),
> -                               BPF_MOV32_REG(insn->dst_reg, insn->dst_re=
g),
> -                       };
> -                       struct bpf_insn chk_and_sdiv[] =3D {
> +                       struct bpf_insn *patch =3D &insn_buf[0];
> +
> +                       if (is_sdiv) {
>                                 /* [R,W]x sdiv 0 -> 0
>                                  * LLONG_MIN sdiv -1 -> LLONG_MIN
>                                  * INT_MIN sdiv -1 -> INT_MIN
>                                  */
> -                               BPF_MOV64_REG(BPF_REG_AX, insn->src_reg),
> -                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU)=
 |
> -                                            BPF_ADD | BPF_K, BPF_REG_AX,
> -                                            0, 0, 1),
> -                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32)=
 |
> -                                            BPF_JGT | BPF_K, BPF_REG_AX,
> -                                            0, 4, 1),
> -                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32)=
 |
> -                                            BPF_JEQ | BPF_K, BPF_REG_AX,
> -                                            0, 1, 0),
> -                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU)=
 |
> -                                            BPF_MOV | BPF_K, insn->dst_r=
eg,
> -                                            0, 0, 0),
> +                               *patch++ =3D BPF_MOV64_REG(BPF_REG_AX, in=
sn->src_reg);
> +                               *patch++ =3D BPF_RAW_INSN((is64 ? BPF_ALU=
64 : BPF_ALU) |
> +                                                       BPF_ADD | BPF_K, =
BPF_REG_AX,
> +                                                       0, 0, 1);
> +                               *patch++ =3D BPF_RAW_INSN((is64 ? BPF_JMP=
 : BPF_JMP32) |
> +                                                       BPF_JGT | BPF_K, =
BPF_REG_AX,
> +                                                       0, 4, 1);
> +                               *patch++ =3D BPF_RAW_INSN((is64 ? BPF_JMP=
 : BPF_JMP32) |
> +                                                       BPF_JEQ | BPF_K, =
BPF_REG_AX,
> +                                                       0, 1, 0);
> +                               *patch++ =3D BPF_RAW_INSN((is64 ? BPF_ALU=
64 : BPF_ALU) |
> +                                                       BPF_MOV | BPF_K, =
insn->dst_reg,
> +                                                       0, 0, 0);
>                                 /* BPF_NEG(LLONG_MIN) =3D=3D -LLONG_MIN =
=3D=3D LLONG_MIN */
> -                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU)=
 |
> -                                            BPF_NEG | BPF_K, insn->dst_r=
eg,
> -                                            0, 0, 0),
> -                               BPF_JMP_IMM(BPF_JA, 0, 0, 1),
> -                               *insn,
> -                       };
> -                       struct bpf_insn chk_and_smod[] =3D {
> +                               *patch++ =3D BPF_RAW_INSN((is64 ? BPF_ALU=
64 : BPF_ALU) |
> +                                                       BPF_NEG | BPF_K, =
insn->dst_reg,
> +                                                       0, 0, 0);
> +                               *patch++ =3D BPF_JMP_IMM(BPF_JA, 0, 0, 1)=
;
> +                               *patch++ =3D *insn;
> +                               cnt =3D patch - insn_buf;
> +                       } else if (is_smod) {
>                                 /* [R,W]x mod 0 -> [R,W]x */
>                                 /* [R,W]x mod -1 -> 0 */
> -                               BPF_MOV64_REG(BPF_REG_AX, insn->src_reg),
> -                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU)=
 |
> -                                            BPF_ADD | BPF_K, BPF_REG_AX,
> -                                            0, 0, 1),
> -                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32)=
 |
> -                                            BPF_JGT | BPF_K, BPF_REG_AX,
> -                                            0, 3, 1),
> -                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32)=
 |
> -                                            BPF_JEQ | BPF_K, BPF_REG_AX,
> -                                            0, 3 + (is64 ? 0 : 1), 1),
> -                               BPF_MOV32_IMM(insn->dst_reg, 0),
> -                               BPF_JMP_IMM(BPF_JA, 0, 0, 1),
> -                               *insn,
> -                               BPF_JMP_IMM(BPF_JA, 0, 0, 1),
> -                               BPF_MOV32_REG(insn->dst_reg, insn->dst_re=
g),
> -                       };
> -
> -                       if (is_sdiv) {
> -                               patchlet =3D chk_and_sdiv;
> -                               cnt =3D ARRAY_SIZE(chk_and_sdiv);
> -                       } else if (is_smod) {
> -                               patchlet =3D chk_and_smod;
> -                               cnt =3D ARRAY_SIZE(chk_and_smod) - (is64 =
? 2 : 0);
> +                               *patch++ =3D BPF_MOV64_REG(BPF_REG_AX, in=
sn->src_reg);
> +                               *patch++ =3D BPF_RAW_INSN((is64 ? BPF_ALU=
64 : BPF_ALU) |
> +                                                       BPF_ADD | BPF_K, =
BPF_REG_AX,
> +                                                       0, 0, 1);
> +                               *patch++ =3D BPF_RAW_INSN((is64 ? BPF_JMP=
 : BPF_JMP32) |
> +                                                       BPF_JGT | BPF_K, =
BPF_REG_AX,
> +                                                       0, 3, 1);
> +                               *patch++ =3D BPF_RAW_INSN((is64 ? BPF_JMP=
 : BPF_JMP32) |
> +                                                       BPF_JEQ | BPF_K, =
BPF_REG_AX,
> +                                                       0, 3 + (is64 ? 0 =
: 1), 1);
> +                               *patch++ =3D BPF_MOV32_IMM(insn->dst_reg,=
 0);
> +                               *patch++ =3D BPF_JMP_IMM(BPF_JA, 0, 0, 1)=
;
> +                               *patch++ =3D *insn;
> +                               *patch++ =3D BPF_JMP_IMM(BPF_JA, 0, 0, 1)=
;
> +                               *patch++ =3D BPF_MOV32_REG(insn->dst_reg,=
 insn->dst_reg);
> +                               cnt =3D (patch - insn_buf) - (is64 ? 2 : =
0);
> +                       } else if (isdiv) {
> +                               /* [R,W]x div 0 -> 0 */
> +                               *patch++ =3D BPF_RAW_INSN((is64 ? BPF_JMP=
 : BPF_JMP32) |
> +                                                       BPF_JNE | BPF_K, =
insn->src_reg,
> +                                                       0, 2, 0);
> +                               *patch++ =3D BPF_ALU32_REG(BPF_XOR, insn-=
>dst_reg, insn->dst_reg);
> +                               *patch++ =3D BPF_JMP_IMM(BPF_JA, 0, 0, 1)=
;
> +                               *patch++ =3D *insn;
> +                               cnt =3D patch - insn_buf;
>                         } else {
> -                               patchlet =3D isdiv ? chk_and_div : chk_an=
d_mod;
> -                               cnt =3D isdiv ? ARRAY_SIZE(chk_and_div) :
> -                                             ARRAY_SIZE(chk_and_mod) - (=
is64 ? 2 : 0);
> +                               /* [R,W]x mod 0 -> [R,W]x */
> +                               *patch++ =3D BPF_RAW_INSN((is64 ? BPF_JMP=
 : BPF_JMP32) |
> +                                                       BPF_JEQ | BPF_K, =
insn->src_reg,
> +                                                       0, 1 + (is64 ? 0 =
: 1), 0);
> +                               *patch++ =3D *insn;
> +                               *patch++ =3D BPF_JMP_IMM(BPF_JA, 0, 0, 1)=
;
> +                               *patch++ =3D BPF_MOV32_REG(insn->dst_reg,=
 insn->dst_reg);
> +                               cnt =3D (patch - insn_buf) - (is64 ? 2 : =
0);

hmm. why populate two extra insn just to drop them ?
Don't add the last two insn instead.
I would also simplify the previous jmp32 vs jmp generation by
testing if (is64) once and at the end cnt =3D patch - insn_buf;

--
pw-bot: cr

