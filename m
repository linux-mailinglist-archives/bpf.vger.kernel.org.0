Return-Path: <bpf+bounces-35125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20798937E02
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 01:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD001F21B76
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 23:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229F9147C91;
	Fri, 19 Jul 2024 23:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHlZi7LD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295342D03B
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 23:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721431639; cv=none; b=KhYxqfTDg6tacsHZ438o0pTqhdxFu5LHb0MlGYTIIRnA9oh5mPTGXxx8rMKArbG3weKGGwNWrqYYHbwHhQ2zB3j18sMIjStMdQRxhGBE7nPPydAcgojx5ZZbRAgYgUFqsdupCSeqszbHGnzNtPCrkykVit5bxvpe3XdsZW/+jIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721431639; c=relaxed/simple;
	bh=70CquhmyU5nLKcIgdGpr7QAnsMj8bNjl6Ua9F1pz2vQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/fYiFK1VaGbQ/TZIhB8HtEj+rRSHbu1DlTh5GtFlx5Zck0/WfyeH+tisCeRK2VNx51RccDdfpv9K/883BwGFNjH84p+9OOFYl9SU3+DBRH531ZYFvge7pLprlZ2/yvs0sRAwMmQMJyAZBBHoD7Q9CbFqgc7zFoXYWeRHf30C9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHlZi7LD; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8036ce6631bso93500339f.1
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 16:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721431637; x=1722036437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLWkyUrDz/3xM1jTd5vKz9olyIGvh6LxRqprKku41ac=;
        b=UHlZi7LDljCfvSmeqTuyyclDS595c7dF7M37NypsftY2oSS1hu0Bt0PJemIJB1SjyZ
         Na/6SWfcOJ42LaFKJMiSnfXmutlMYp4hGmLS12iWWYGg8AqVs1JtCkZ1Z/lVnfHAaF0b
         zwfv7ItNweKNy17sp+kIkfue8qXtUOH3l4lALpcIYKuoHRsvbu0m8lxD2zGKwTJ0gwq1
         sm+qUaeIFdjZps0XFgqyZ0WbYO3hdPomXqlAcKmd/crPg7p6O+89bpuAPgHL3QrcHPxe
         CAEW4G+NknODX2J6w3QRp1+byGjtHgXYNoJ++6KP4F/Lp7szcjANKJIZXl9+vzcrcaHt
         jONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721431637; x=1722036437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLWkyUrDz/3xM1jTd5vKz9olyIGvh6LxRqprKku41ac=;
        b=TsEwDsQW1gYby/cYtNdACqgwGllMz9QvluE7UhX5qIKzbwqE3YU5QRBbz9wUCv4zCq
         JqnNsFAw2zE9MlCVp+MvYgWbSe5rhd5CrRq4BX+xubuv0eaLP9It24Du20Boi/268MKa
         H2RG6qMXiOaM/H7SOb+GBBHb8VyiQznpDO6ShMg3d8okpnn7cddV8aXfMHiQCFV9KFoQ
         14jek3jSm2t0LDT+CSatqQb9wbOw3BAA6hLtEXl3CGrb9/g8rN5DnMqO5jT2F4oBjgeE
         QR8Brw3+5ceKMcMarxWf9wJFYrJooZ/6s549MpzveBAyYhpXgh9w65uVzUAWih2/1LXs
         Q5Vg==
X-Gm-Message-State: AOJu0YxGdkEagACsgV/9X5+1DjqXtcocHsbtw3y3OyA6Nmm+kL8mRF/P
	LZmoF9RT5OtNDutc5ZviurtUgE6qTeTmxQrbvlSh8KGkxE2rtdaCoAjj7om5+ysH5P/YxNDWgUk
	/gvaK6lYHFTHM62QzNPdzGIXbVLw=
X-Google-Smtp-Source: AGHT+IHfHqHoycELfWJY8m2lsIqADvLguVl48DcrFItWnqh5jDjTttb07qtXXeDtyZNzJMdaRd7ptkaTQshuAb3dMMw=
X-Received: by 2002:a05:6602:3fc8:b0:7eb:7f2e:5b3a with SMTP id
 ca18e2360f4ac-8170fd5f4d8mr1255628139f.2.1721431637080; Fri, 19 Jul 2024
 16:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718202357.1746514-1-eddyz87@gmail.com> <20240718202357.1746514-2-eddyz87@gmail.com>
In-Reply-To: <20240718202357.1746514-2-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Jul 2024 16:27:04 -0700
Message-ID: <CAEf4BzYFNLEtk3BXvAM0QV26apXY19C7CjanPpwf+VndAM8BqQ@mail.gmail.com>
Subject: Re: [bpf-next v3 1/4] bpf: track equal scalars history on
 per-instruction level
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 1:24=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Use bpf_verifier_state->jmp_history to track which registers were
> updated by find_equal_scalars() (renamed to collect_linked_regs())
> when conditional jump was verified. Use recorded information in
> backtrack_insn() to propagate precision.
>
> E.g. for the following program:
>
>             while verifying instructions
>   1: r1 =3D r0              |
>   2: if r1 < 8  goto ...  | push r0,r1 as linked registers in jmp_history
>   3: if r0 > 16 goto ...  | push r0,r1 as linked registers in jmp_history
>   4: r2 =3D r10             |
>   5: r2 +=3D r0             v mark_chain_precision(r0)
>
>             while doing mark_chain_precision(r0)
>   5: r2 +=3D r0             | mark r0 precise
>   4: r2 =3D r10             |
>   3: if r0 > 16 goto ...  | mark r0,r1 as precise
>   2: if r1 < 8  goto ...  | mark r0,r1 as precise
>   1: r1 =3D r0              v
>
> Technically, do this as follows:
> - Use 10 bits to identify each register that gains range because of
>   sync_linked_regs():
>   - 3 bits for frame number;
>   - 6 bits for register or stack slot number;
>   - 1 bit to indicate if register is spilled.
> - Use u64 as a vector of 6 such records + 4 bits for vector length.
> - Augment struct bpf_jmp_history_entry with a field 'linked_regs'
>   representing such vector.
> - When doing check_cond_jmp_op() remember up to 6 registers that
>   gain range because of sync_linked_regs() in such a vector.
> - Don't propagate range information and reset IDs for registers that
>   don't fit in 6-value vector.
> - Push a pair {instruction index, linked registers vector}
>   to bpf_verifier_state->jmp_history.
> - When doing backtrack_insn() check if any of recorded linked
>   registers is currently marked precise, if so mark all linked
>   registers as precise.
>
> This also requires fixes for two test_verifier tests:
> - precise: test 1
> - precise: test 2
>
> Both tests contain the following instruction sequence:
>
> 19: (bf) r2 =3D r9                      ; R2=3Dscalar(id=3D3) R9=3Dscalar=
(id=3D3)
> 20: (a5) if r2 < 0x8 goto pc+1        ; R2=3Dscalar(id=3D3,umin=3D8)
> 21: (95) exit
> 22: (07) r2 +=3D 1                      ; R2_w=3Dscalar(id=3D3+1,...)
> 23: (bf) r1 =3D r10                     ; R1_w=3Dfp0 R10=3Dfp0
> 24: (07) r1 +=3D -8                     ; R1_w=3Dfp-8
> 25: (b7) r3 =3D 0                       ; R3_w=3D0
> 26: (85) call bpf_probe_read_kernel#113
>
> The call to bpf_probe_read_kernel() at (26) forces r2 to be precise.
> Previously, this forced all registers with same id to become precise
> immediately when mark_chain_precision() is called.
> After this change, the precision is propagated to registers sharing
> same id only when 'if' instruction is backtracked.
> Hence verification log for both tests is changed:
> regs=3Dr2,r9 -> regs=3Dr2 for instructions 25..20.
>
> Fixes: 904e6ddf4133 ("bpf: Use scalar ids in mark_chain_precision()")
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Closes: https://lore.kernel.org/bpf/CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt=
+_Lf0kcFEut2Mg@mail.gmail.com/
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  include/linux/bpf_verifier.h                  |   4 +
>  kernel/bpf/verifier.c                         | 248 ++++++++++++++++--
>  .../bpf/progs/verifier_subprog_precision.c    |   2 +-
>  .../testing/selftests/bpf/verifier/precise.c  |  20 +-
>  4 files changed, 242 insertions(+), 32 deletions(-)
>

[...]

> +/* For all R being scalar registers or spilled scalar registers
> + * in verifier state, save R in linked_regs if R->id =3D=3D id.
> + * If there are too many Rs sharing same id, reset id for leftover Rs.
> + */
> +static void collect_linked_regs(struct bpf_verifier_state *vstate, u32 i=
d,
> +                               struct linked_regs *linked_regs)
> +{
> +       struct bpf_func_state *func;
> +       struct bpf_reg_state *reg;
> +       int i, j;
> +
> +       id =3D id & ~BPF_ADD_CONST;
> +       for (i =3D vstate->curframe; i >=3D 0; i--) {
> +               func =3D vstate->frame[i];
> +               for (j =3D 0; j < BPF_REG_FP; j++) {
> +                       reg =3D &func->regs[j];
> +                       __collect_linked_regs(linked_regs, reg, id, i, j,=
 true);
> +               }
> +               for (j =3D 0; j < func->allocated_stack / BPF_REG_SIZE; j=
++) {
> +                       if (!is_spilled_reg(&func->stack[j]))
> +                               continue;
> +                       reg =3D &func->stack[j].spilled_ptr;
> +                       __collect_linked_regs(linked_regs, reg, id, i, j,=
 false);
> +               }
> +       }
> +
> +       if (linked_regs->cnt =3D=3D 1)
> +               linked_regs->cnt =3D 0;

We discussed this rather ugly condition w/ Eduard offline. I agreed to
drop it and change the condition `linked_regs.cnt > 0` below to
`linked_regs.cnt > 1`. It's unfortunate we can have one "self-linked"
register, but it seems like unlinking the last remaining register
would be prohibitively expensive (as we don't track how many linked
registers for a given ID is there).

Anyways, if we ever come to solve this, we can update `> 1` condition
to a proper `> 0` one. For now they are equivalent, so it doesn't
really matter much.

> +}
> +
> +/* For all R in linked_regs, copy known_reg range into R
> + * if R->id =3D=3D known_reg->id.
> + */
> +static void sync_linked_regs(struct bpf_verifier_state *vstate, struct b=
pf_reg_state *known_reg,
> +                            struct linked_regs *linked_regs)
>  {
>         struct bpf_reg_state fake_reg;
> -       struct bpf_func_state *state;
>         struct bpf_reg_state *reg;
> +       struct linked_reg *e;
> +       int i;
>
> -       bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> +       for (i =3D 0; i < linked_regs->cnt; ++i) {
> +               e =3D &linked_regs->entries[i];
> +               reg =3D e->is_reg ? &vstate->frame[e->frameno]->regs[e->r=
egno]
> +                               : &vstate->frame[e->frameno]->stack[e->sp=
i].spilled_ptr;
>                 if (reg->type !=3D SCALAR_VALUE || reg =3D=3D known_reg)
>                         continue;
>                 if ((reg->id & ~BPF_ADD_CONST) !=3D (known_reg->id & ~BPF=
_ADD_CONST))

[...]

