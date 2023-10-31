Return-Path: <bpf+bounces-13756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 082B57DD768
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 21:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABEAE281940
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 20:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA919225DB;
	Tue, 31 Oct 2023 20:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jODBsKVb"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEE61D69C
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 20:56:00 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF782A3
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 13:55:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9c2a0725825so973804866b.2
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 13:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698785756; x=1699390556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgWummPW4Bw/KhT9fGmdEN3KFkLA93LJUGY7Z2watGE=;
        b=jODBsKVbwEmaqEaSHs9XXNdmrk0lWUnpUoTGIFlmEuA/AAGrq4CvMtnVxJlOVFXc/W
         TdaRQPfGSruH5GPzFOlv0/jH8RbesI6tOPCAMV8XSKNDPwJYsYah8PphJ5230lZ8yrik
         nGHgYvJuV5O56mwkau9YEXhRTh8211mlIjSvm4XBP/mcAwKUaFxrIyTLp4pwJZGGzdZH
         YWZwCOkP9cEt1t7EI4agh+cO0v5sKH7UXREIC9Pip8v/Ny/Vbi9AkiBQ5Dq0OtOOQ4ZD
         WF2kln/z5oo2wPaQKHqIxD34HFrhaC2vLDrZBvpeqLkF7tkIFmo8X+pfNwlf+5pgdd9W
         QrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698785756; x=1699390556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgWummPW4Bw/KhT9fGmdEN3KFkLA93LJUGY7Z2watGE=;
        b=Q0na8tEMdcsWA9QdmCP6d3UNFDO1A2gwOTyuGSfbmZMZyUsnmDtO3D1mWZ6b19DH8p
         cSPl4tS8csusbw65S3Pzh+aYTeASGXz9gBeKc1wtFZqXISyQ7cCtnsUgXX9LMmxxiRf5
         5xzK9e0HoVuGoAXozf2Eowd8/meDEVc1qhaua32ELvpsBJ5Lxh+HZQCeqyZnJRvOAigT
         dBcg93AhtwcNlbYP0p/O0NF+XxYDTA18RdR7hXpLVyP3Wqi2cRDjEkJMeTJzhnBQg2/q
         emdQuNL2MJDrTJXSXhONkq5n3eGKJB+40Yiyk+Mj5gp+GQ9Cz7JOkCdJ+sWA2i0Y5x4r
         Qedg==
X-Gm-Message-State: AOJu0YzaaxX7ObEGnXyIF3OR9a+QLv01g0k/R/9pGIQy352EjCQ1CzI1
	Fd4mnnDiO9StFOg3Q/fV/RYJYP/zC2CK0CNJVaQ=
X-Google-Smtp-Source: AGHT+IFimllBXwuARrt6K5B2TxBr1e9r7r5aDi/F+9gM/S8zzHA7nHphV6PKcgWSIlIevUtA0NRK/vvYvrB3ccPDPY4=
X-Received: by 2002:a17:907:3f96:b0:9ae:5be8:ff90 with SMTP id
 hr22-20020a1709073f9600b009ae5be8ff90mr402779ejc.68.1698785755895; Tue, 31
 Oct 2023 13:55:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027181346.4019398-1-andrii@kernel.org> <20231027181346.4019398-20-andrii@kernel.org>
 <20231031021200.lryk4xjudptseasm@MacBook-Pro-49.local> <CAEf4BzZ0oPHe8p96OjY=o7R+=cMn9utk9K5YgYQp8Ai=T6fPCQ@mail.gmail.com>
 <CAADnVQKOYk7emThHsRxuPVVAZFfE7U6qngcM+L=gt6JQfLgcLg@mail.gmail.com>
 <CAEf4BzYurVB-6J-1oAVuPj8BbtzfKRYue6ajOUeofchAYCrNjA@mail.gmail.com> <CAEf4BzaOygre08BW=Ma_jsg5Eir=b4COcx8j1xv2qwtcRtHcnQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaOygre08BW=Ma_jsg5Eir=b4COcx8j1xv2qwtcRtHcnQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 31 Oct 2023 13:55:44 -0700
Message-ID: <CAEf4BzYUPueT_ngrw81VMp-cnSsZFHeNdDROsVR1T9u094d+6A@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 19/23] bpf: generalize is_scalar_branch_taken()
 logic
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 1:53=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 31, 2023 at 11:01=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Oct 31, 2023 at 9:35=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Oct 30, 2023 at 11:12=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Mon, Oct 30, 2023 at 7:12=E2=80=AFPM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Fri, Oct 27, 2023 at 11:13:42AM -0700, Andrii Nakryiko wrote:
> > > > > > Generalize is_branch_taken logic for SCALAR_VALUE register to h=
andle
> > > > > > cases when both registers are not constants. Previously support=
ed
> > > > > > <range> vs <scalar> cases are a natural subset of more generic =
<range>
> > > > > > vs <range> set of cases.
> > > > > >
> > > > > > Generalized logic relies on straightforward segment intersectio=
n checks.
> > > > > >
> > > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > > ---
> > > > > >  kernel/bpf/verifier.c | 104 ++++++++++++++++++++++++++--------=
--------
> > > > > >  1 file changed, 64 insertions(+), 40 deletions(-)
> > > > > >
> > > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > > index 4c974296127b..f18a8247e5e2 100644
> > > > > > --- a/kernel/bpf/verifier.c
> > > > > > +++ b/kernel/bpf/verifier.c
> > > > > > @@ -14189,82 +14189,105 @@ static int is_scalar_branch_taken(st=
ruct bpf_reg_state *reg1, struct bpf_reg_sta
> > > > > >                                 u8 opcode, bool is_jmp32)
> > > > > >  {
> > > > > >       struct tnum t1 =3D is_jmp32 ? tnum_subreg(reg1->var_off) =
: reg1->var_off;
> > > > > > +     struct tnum t2 =3D is_jmp32 ? tnum_subreg(reg2->var_off) =
: reg2->var_off;
> > > > > >       u64 umin1 =3D is_jmp32 ? (u64)reg1->u32_min_value : reg1-=
>umin_value;
> > > > > >       u64 umax1 =3D is_jmp32 ? (u64)reg1->u32_max_value : reg1-=
>umax_value;
> > > > > >       s64 smin1 =3D is_jmp32 ? (s64)reg1->s32_min_value : reg1-=
>smin_value;
> > > > > >       s64 smax1 =3D is_jmp32 ? (s64)reg1->s32_max_value : reg1-=
>smax_value;
> > > > > > -     u64 val =3D is_jmp32 ? (u32)tnum_subreg(reg2->var_off).va=
lue : reg2->var_off.value;
> > > > > > -     s64 sval =3D is_jmp32 ? (s32)val : (s64)val;
> > > > > > +     u64 umin2 =3D is_jmp32 ? (u64)reg2->u32_min_value : reg2-=
>umin_value;
> > > > > > +     u64 umax2 =3D is_jmp32 ? (u64)reg2->u32_max_value : reg2-=
>umax_value;
> > > > > > +     s64 smin2 =3D is_jmp32 ? (s64)reg2->s32_min_value : reg2-=
>smin_value;
> > > > > > +     s64 smax2 =3D is_jmp32 ? (s64)reg2->s32_max_value : reg2-=
>smax_value;
> > > > > >
> > > > > >       switch (opcode) {
> > > > > >       case BPF_JEQ:
> > > > > > -             if (tnum_is_const(t1))
> > > > > > -                     return !!tnum_equals_const(t1, val);
> > > > > > -             else if (val < umin1 || val > umax1)
> > > > > > +             /* const tnums */
> > > > > > +             if (tnum_is_const(t1) && tnum_is_const(t2))
> > > > > > +                     return t1.value =3D=3D t2.value;
> > > > > > +             /* const ranges */
> > > > > > +             if (umin1 =3D=3D umax1 && umin2 =3D=3D umax2)
> > > > > > +                     return umin1 =3D=3D umin2;
> > > > >
> > > > > I don't follow this logic.
> > > > > umin1 =3D=3D umax1 means that it's a single constant and
> > > > > it should have been handled by earlier tnum_is_const check.
> > > >
> > > > I think you follow the logic, you just think it's redundant. Yes, i=
t's
> > > > basically the same as
> > > >
> > > >           if (tnum_is_const(t1) && tnum_is_const(t2))
> > > >                 return t1.value =3D=3D t2.value;
> > > >
> > > > but based on ranges. I didn't feel comfortable to assume that if um=
in1
> > > > =3D=3D umax1 then tnum_is_const(t1) will always be true. At worst w=
e'll
> > > > perform one redundant check.
> > > >
> > > > In short, I don't trust tnum to be as precise as umin/umax and othe=
r ranges.
> > > >
> > > > >
> > > > > > +             if (smin1 =3D=3D smax1 && smin2 =3D=3D smax2)
> > > > > > +                     return umin1 =3D=3D umin2;
> > > > >
> > > > > here it's even more confusing. smin =3D=3D smax -> singel const,
> > > > > but then compare umin1 with umin2 ?!
> > > >
> > > > Eagle eyes! Typo, sorry :( it should be `smin1 =3D=3D smin2`, of co=
urse.
> > > >
> > > > What saves us is reg_bounds_sync(), and if we have umin1 =3D=3D uma=
x1 then
> > > > we'll have also smin1 =3D=3D smax1 =3D=3D umin1 =3D=3D umax1 (and c=
orresponding
> > > > relation for second register). But I fixed these typos in both BPF_=
JEQ
> > > > and BPF_JNE branches.
> > >
> > > Not just 'saves us'. The tnum <-> bounds sync is mandatory.
> > > I think we have a test where a function returns [-errno, 0]
> > > and then we do if (ret < 0) check. At this point the reg has
> > > to be tnum_is_const and zero.
> > > So if smin1 =3D=3D smax1 =3D=3D umin1 =3D=3D umax1 it should be tnum_=
is_const.
> > > Otherwise it's a bug in sync logic.
> > > I think instead of doing redundant and confusing check may be
> > > add WARN either here or in sync logic to make sure it's all good ?
> >
> > Ok, let's add it as part of register state sanity checks we discussed
> > on another patch. I'll drop the checks and will re-run all the test to
> > make sure we are not missing anything.
>
> So I have this as one more patch for the next revision (pending local
> testing). If you hate any part of it, I'd appreciate early feedback :)
> I'll wait for Eduard to finish going through the series (probably
> tomorrow), and then will post the next version based on all the
> feedback I got (and whatever might still come).
>
> Note, in the below, I don't output the actual register state on
> violation, which is unfortunate. But to make this happen I need to
> refactor print_verifier_state() to allow me to print register state.
> I've been wanting to move print_verifier_state() into kernel/bpf/log.c
> for a while now, and fix how we print the state of spilled registers
> (and maybe few more small things), so I'll do that separately, and
> then add register state printing to sanity check error.
>
>
> Author: Andrii Nakryiko <andrii@kernel.org>
> Date:   Tue Oct 31 13:34:33 2023 -0700
>
>     bpf: add register bounds sanity checks
>
>     Add simple sanity checks that validate well-formed ranges (min <=3D m=
ax)
>     across u64, s64, u32, and s32 ranges. Also for cases when the value i=
s
>     constant (either 64-bit or 32-bit), we validate that ranges and tnums
>     are in agreement.
>
>     These bounds checks are performed at the end of BPF_ALU/BPF_ALU64
>     operations, on conditional jumps, and for LDX instructions (where sub=
reg
>     zero/sign extension is probably the most important to check). This
>     covers most of the interesting cases.
>
>     Also, we validate the sanity of the return register when manually
> adjusting it
>     for some special helpers.
>
>     Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c85d974ba21f..b29c85089bc9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2615,6 +2615,46 @@ static void reg_bounds_sync(struct bpf_reg_state *=
reg)
>         __update_reg_bounds(reg);
>  }
>
> +static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
> struct bpf_reg_state *reg)
> +{
> +       const char *msg;
> +
> +       if (reg->umin_value > reg->umax_value ||
> +           reg->smin_value > reg->smax_value ||
> +           reg->u32_min_value > reg->u32_max_value ||
> +           reg->s32_min_value > reg->s32_max_value) {
> +                   msg =3D "range bounds violation";
> +                   goto out;
> +       }
> +
> +       if (tnum_is_const(reg->var_off)) {
> +               u64 uval =3D reg->var_off.value;
> +               s64 sval =3D (s64)uval;
> +
> +               if (reg->umin_value !=3D uval || reg->umax_value !=3D uva=
l ||
> +                   reg->smin_value !=3D sval || reg->smax_value !=3D sva=
l) {
> +                       msg =3D "const tnum out of sync with range bounds=
";
> +                       goto out;
> +               }
> +       }
> +
> +       if (tnum_subreg_is_const(reg->var_off)) {
> +               u32 uval32 =3D tnum_subreg(reg->var_off).value;
> +               s32 sval32 =3D (s32)uval32;
> +
> +               if (reg->u32_min_value !=3D uval32 || reg->u32_max_value
> !=3D uval32 ||
> +                   reg->s32_min_value !=3D sval32 || reg->s32_max_value
> !=3D sval32) {
> +                       msg =3D "const tnum (subreg) out of sync with
> range bounds";
> +                       goto out;
> +               }
> +       }
> +
> +       return 0;
> +out:
> +       verbose(env, "%s\n", msg);
> +       return -EFAULT;
> +}
> +
>  static bool __reg32_bound_s64(s32 a)
>  {
>         return a >=3D 0 && a <=3D S32_MAX;
> @@ -9928,14 +9968,15 @@ static int prepare_func_exit(struct
> bpf_verifier_env *env, int *insn_idx)
>         return 0;
>  }
>
> -static void do_refine_retval_range(struct bpf_reg_state *regs, int ret_t=
ype,
> -                                  int func_id,
> -                                  struct bpf_call_arg_meta *meta)
> +static int do_refine_retval_range(struct bpf_verifier_env *env,
> +                                 struct bpf_reg_state *regs, int ret_typ=
e,
> +                                 int func_id,
> +                                 struct bpf_call_arg_meta *meta)
>  {
>         struct bpf_reg_state *ret_reg =3D &regs[BPF_REG_0];
>
>         if (ret_type !=3D RET_INTEGER)
> -               return;
> +               return 0;
>
>         switch (func_id) {
>         case BPF_FUNC_get_stack:
> @@ -9961,6 +10002,8 @@ static void do_refine_retval_range(struct
> bpf_reg_state *regs, int ret_type,
>                 reg_bounds_sync(ret_reg);
>                 break;
>         }
> +
> +       return reg_bounds_sanity_check(env, ret_reg);
>  }
>
>  static int
> @@ -10612,7 +10655,9 @@ static int check_helper_call(struct
> bpf_verifier_env *env, struct bpf_insn *insn
>                 regs[BPF_REG_0].ref_obj_id =3D id;
>         }
>
> -       do_refine_retval_range(regs, fn->ret_type, func_id, &meta);
> +       err =3D do_refine_retval_range(env, regs, fn->ret_type, func_id, =
&meta);
> +       if (err)
> +               return err;
>
>         err =3D check_map_func_compatibility(env, meta.map_ptr, func_id);
>         if (err)
> @@ -14079,13 +14124,12 @@ static int check_alu_op(struct
> bpf_verifier_env *env, struct bpf_insn *insn)
>
>                 /* check dest operand */
>                 err =3D check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK)=
;
> +               err =3D err ?: adjust_reg_min_max_vals(env, insn);
>                 if (err)
>                         return err;
> -
> -               return adjust_reg_min_max_vals(env, insn);
>         }
>
> -       return 0;
> +       return reg_bounds_sanity_check(env, &regs[insn->dst_reg]);
>  }
>
>  static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
> @@ -14600,18 +14644,21 @@ static void regs_refine_cond_op(struct
> bpf_reg_state *reg1, struct bpf_reg_state
>   * Technically we can do similar adjustments for pointers to the same ob=
ject,
>   * but we don't support that right now.
>   */
> -static void reg_set_min_max(struct bpf_reg_state *true_reg1,
> -                           struct bpf_reg_state *true_reg2,
> -                           struct bpf_reg_state *false_reg1,
> -                           struct bpf_reg_state *false_reg2,
> -                           u8 opcode, bool is_jmp32)
> +static int reg_set_min_max(struct bpf_verifier_env *env,
> +                          struct bpf_reg_state *true_reg1,
> +                          struct bpf_reg_state *true_reg2,
> +                          struct bpf_reg_state *false_reg1,
> +                          struct bpf_reg_state *false_reg2,
> +                          u8 opcode, bool is_jmp32)
>  {
> +       int err;
> +
>         /* If either register is a pointer, we can't learn anything about=
 its
>          * variable offset from the compare (unless they were a pointer i=
nto
>          * the same object, but we don't bother with that).
>          */
>         if (false_reg1->type !=3D SCALAR_VALUE || false_reg2->type !=3D
> SCALAR_VALUE)
> -               return;
> +               return 0;
>
>         /* fallthrough (FALSE) branch */
>         regs_refine_cond_op(false_reg1, false_reg2,
> rev_opcode(opcode), is_jmp32);
> @@ -14622,6 +14669,12 @@ static void reg_set_min_max(struct
> bpf_reg_state *true_reg1,
>         regs_refine_cond_op(true_reg1, true_reg2, opcode, is_jmp32);
>         reg_bounds_sync(true_reg1);
>         reg_bounds_sync(true_reg2);
> +
> +       err =3D reg_bounds_sanity_check(env, true_reg1);
> +       err =3D err ?: reg_bounds_sanity_check(env, true_reg2);
> +       err =3D err ?: reg_bounds_sanity_check(env, false_reg1);
> +       err =3D err ?: reg_bounds_sanity_check(env, false_reg2);
> +       return err;
>  }
>
>  static void mark_ptr_or_null_reg(struct bpf_func_state *state,
> @@ -14915,15 +14968,20 @@ static int check_cond_jmp_op(struct
> bpf_verifier_env *env,
>         other_branch_regs =3D other_branch->frame[other_branch->curframe]=
->regs;
>
>         if (BPF_SRC(insn->code) =3D=3D BPF_X) {
> -               reg_set_min_max(&other_branch_regs[insn->dst_reg],
> -                               &other_branch_regs[insn->src_reg],
> -                               dst_reg, src_reg, opcode, is_jmp32);
> +               err =3D reg_set_min_max(env,
> +                                     &other_branch_regs[insn->dst_reg],
> +                                     &other_branch_regs[insn->src_reg],
> +                                     dst_reg, src_reg, opcode, is_jmp32)=
;
>         } else /* BPF_SRC(insn->code) =3D=3D BPF_K */ {
> -               reg_set_min_max(&other_branch_regs[insn->dst_reg],
> -                               src_reg /* fake one */,
> -                               dst_reg, src_reg /* same fake one */,
> -                               opcode, is_jmp32);
> +               err =3D reg_set_min_max(env,
> +                                     &other_branch_regs[insn->dst_reg],
> +                                     src_reg /* fake one */,
> +                                     dst_reg, src_reg /* same fake one *=
/,
> +                                     opcode, is_jmp32);
>         }
> +       if (err)
> +               return err;
> +
>         if (BPF_SRC(insn->code) =3D=3D BPF_X &&
>             src_reg->type =3D=3D SCALAR_VALUE && src_reg->id &&
>             !WARN_ON_ONCE(src_reg->id !=3D other_branch_regs[insn->src_re=
g].id)) {
> @@ -17426,10 +17484,8 @@ static int do_check(struct bpf_verifier_env *env=
)
>                                                insn->off, BPF_SIZE(insn->=
code),
>                                                BPF_READ, insn->dst_reg, f=
alse,
>                                                BPF_MODE(insn->code) =3D=
=3D
> BPF_MEMSX);
> -                       if (err)
> -                               return err;
> -
> -                       err =3D save_aux_ptr_type(env, src_reg_type, true=
);
> +                       err =3D err ?: save_aux_ptr_type(env, src_reg_typ=
e, true);
> +                       err =3D reg_bounds_sanity_check(env,
> &regs[insn->dst_reg]);

this should obviously be `err =3D err ?: reg_bounds_sanity_check(...)`
(somehow it gets obvious in the email, not locally)

>                         if (err)
>                                 return err;
>                 } else if (class =3D=3D BPF_STX) {

