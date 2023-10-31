Return-Path: <bpf+bounces-13733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCE37DD4CD
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 18:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 475F7B20FCD
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 17:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3692208C2;
	Tue, 31 Oct 2023 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfY/w0rc"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEADB7491
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 17:41:42 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA5791
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 10:41:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9d242846194so448076466b.1
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 10:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698774100; x=1699378900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxKHmktgpVOVuTIRJVKQZan2VJBgq5Kt/3RsnVwNB4c=;
        b=WfY/w0rclWQOrg/UESDDWmvaOtX4Lg7H4cmWv4ALydB1/F806wyCDBr7IbGxZ6Jy4h
         i7mIaTzj+J8zStmDSOf4E+Ne2Egr+WWPhmIhsZzIepTTJ+rWS6YKQmADlbdzIJ0PbP8o
         kjMDxk5a11i6PL/qjkQmzAQ6w6mAxI702KnD/3Vcv31huErVEACDkQSnH197KiUAsLh9
         YaaatFcK7lLu2J/T+xDv0jixZXQ55xStozhBBwNvF8WP8GVTGEbNcGs9smlCL9U3VC6q
         7kfNQkKbI2IKNZOVVklB5Et66+edGZNn3RBBMsiLo/BlIcNQR0XK0vR9pGqVwuACjiG2
         Xwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774100; x=1699378900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxKHmktgpVOVuTIRJVKQZan2VJBgq5Kt/3RsnVwNB4c=;
        b=mghcIlSK7Eag8hX63bpFKNdgmn2RvrV+EmbcF7PzFPNomUGslO4tDsFytBl8X23Xb0
         DLgbIg6TdfSVRzSe5YbwiBcWzFgIJ8+QT7/ILui7JCFjr4tYVooPg2kE/KbpXyGkrKla
         I+Z0J4rP5dNlQgOgOfu4Ja3e4ZWT8nBDcnahThHNlzs28ZJfFW/MkkQ1RsQUKnB67Z0a
         +TdSG+1UMubJ7Ajrn1lqFf9une24fBFlayiWfgYlzG15XI2IRiXHVEIhsrvNwvAuy9dG
         k+mFCuzvwcq7/pCnZJMqfw1YUyAburappBmySEYh5NQCKofvDfHAMqhZWUvUNL49pc88
         +jqg==
X-Gm-Message-State: AOJu0Yy4Kx1afEoYem1/77kcvc3WLWnq8JJ3MroOu3VdjaZRo24uyjWP
	KAyyIyLkD8ByxOaS3bKpc+t1Bme1Mm7tJbolLveg3Z4A
X-Google-Smtp-Source: AGHT+IF41UnXeW3go1c7G0EHEjdShMOVMsWR1Dj/Kz3lxfEoBFvsEYWLGguYNMG1i74qAT/DKvq53vNndlCrJ6KjQN4=
X-Received: by 2002:a17:907:d2a:b0:9d2:fe04:b19a with SMTP id
 gn42-20020a1709070d2a00b009d2fe04b19amr43047ejc.27.1698774099699; Tue, 31 Oct
 2023 10:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027181346.4019398-1-andrii@kernel.org> <20231027181346.4019398-13-andrii@kernel.org>
 <776179259164573a1c3b9f588c77082750014734.camel@gmail.com>
In-Reply-To: <776179259164573a1c3b9f588c77082750014734.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 31 Oct 2023 10:41:28 -0700
Message-ID: <CAEf4BzYer4jW+XXOBhDojRM9DfqM=JANb5S6Y-Vk2XbjHJ5OPw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 12/23] bpf: generalize is_branch_taken() to
 work with two registers
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 8:38=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2023-10-27 at 11:13 -0700, Andrii Nakryiko wrote:
> > > While still assuming that second register is a constant, generalize
> > > is_branch_taken-related code to accept two registers instead of regis=
ter
> > > plus explicit constant value. This also, as a side effect, allows to
> > > simplify check_cond_jmp_op() by unifying BPF_K case with BPF_X case, =
for
> > > which we use a fake register to represent BPF_K's imm constant as
> > > a register.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> Please see a nitpick below.
>
> > > ---
> > >  kernel/bpf/verifier.c | 58 ++++++++++++++++++++++++-----------------=
--
> > >  1 file changed, 33 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index aa13f32751a1..fd328c579f10 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -14169,8 +14169,13 @@ static void find_good_pkt_pointers(struct bp=
f_verifier_state *vstate,
> > >     }));
> > >  }
> > >
> > > -static int is_branch32_taken(struct bpf_reg_state *reg1, u32 val, u8=
 opcode)
> > > +/*
> > > + * <reg1> <op> <reg2>, currently assuming reg2 is a constant
> > > + */
> > > +static int is_branch32_taken(struct bpf_reg_state *reg1, struct bpf_=
reg_state *reg2, u8 opcode)
> > >  {
> > > +   struct tnum subreg =3D tnum_subreg(reg1->var_off);
> > > +   u32 val =3D (u32)tnum_subreg(reg2->var_off).value;
> > >     s32 sval =3D (s32)val;
> > >
> > >     switch (opcode) {
> > > @@ -14250,8 +14255,12 @@ static int is_branch32_taken(struct bpf_reg_=
state *reg1, u32 val, u8 opcode)
> > >  }
> > >
> > >
> > > -static int is_branch64_taken(struct bpf_reg_state *reg1, u64 val, u8=
 opcode)
> > > +/*
> > > + * <reg1> <op> <reg2>, currently assuming reg2 is a constant
> > > + */
> > > +static int is_branch64_taken(struct bpf_reg_state *reg1, struct bpf_=
reg_state *reg2, u8 opcode)
> > >  {
> > > +   u64 val =3D reg2->var_off.value;
> > >     s64 sval =3D (s64)val;
> > >
> > >     switch (opcode) {
> > > @@ -14330,16 +14339,23 @@ static int is_branch64_taken(struct bpf_reg=
_state *reg1, u64 val, u8 opcode)
> > >     return -1;
> > >  }
> > >
> > > -/* compute branch direction of the expression "if (reg opcode val) g=
oto target;"
> > > +/* compute branch direction of the expression "if (<reg1> opcode <re=
g2>) goto target;"
> > >   * and return:
> > >   *  1 - branch will be taken and "goto target" will be executed
> > >   *  0 - branch will not be taken and fall-through to next insn
> > > - * -1 - unknown. Example: "if (reg < 5)" is unknown when register va=
lue
> > > + * -1 - unknown. Example: "if (reg1 < 5)" is unknown when register v=
alue
> > >   *      range [0,10]
> > >   */
> > > -static int is_branch_taken(struct bpf_reg_state *reg1, u64 val, u8 o=
pcode,
> > > -                      bool is_jmp32)
> > > +static int is_branch_taken(struct bpf_reg_state *reg1, struct bpf_re=
g_state *reg2,
> > > +                      u8 opcode, bool is_jmp32)
> > >  {
> > > +   struct tnum reg2_tnum =3D is_jmp32 ? tnum_subreg(reg2->var_off) :=
 reg2->var_off;
> > > +   u64 val;
> > > +
> > > +   if (!tnum_is_const(reg2_tnum))
> > > +           return -1;
> > > +   val =3D reg2_tnum.value;
> > > +
> > >     if (__is_pointer_value(false, reg1)) {
> > >             if (!reg_not_null(reg1))
> > >                     return -1;
> > > @@ -14361,8 +14377,8 @@ static int is_branch_taken(struct bpf_reg_sta=
te *reg1, u64 val, u8 opcode,
> > >     }
> > >
> > >     if (is_jmp32)
> > > -           return is_branch32_taken(reg1, val, opcode);
> > > -   return is_branch64_taken(reg1, val, opcode);
> > > +           return is_branch32_taken(reg1, reg2, opcode);
> > > +   return is_branch64_taken(reg1, reg2, opcode);
> > >  }
> > >
> > >  static int flip_opcode(u32 opcode)
> > > @@ -14833,6 +14849,7 @@ static int check_cond_jmp_op(struct bpf_verif=
ier_env *env,
> > >     struct bpf_reg_state *regs =3D this_branch->frame[this_branch->cu=
rframe]->regs;
> > >     struct bpf_reg_state *dst_reg, *other_branch_regs, *src_reg =3D N=
ULL;
> > >     struct bpf_reg_state *eq_branch_regs;
> > > +   struct bpf_reg_state fake_reg;
>
> Nitpick:
> bpf_reg_state has a lot of fields, e.g. 'parent' pointer. While it looks =
like
> the use within this patch-set is safe, I suggest to change the declaratio=
n to
> include '=3D {}' initializer. Just to err on a safe side for future modif=
ications.

yes, good point. One other place where we use "fake_reg" doesn
zero-initialize with =3D {}, will fix.

>
> > >     u8 opcode =3D BPF_OP(insn->code);
> > >     bool is_jmp32;
> > >     int pred =3D -1;
> > > @@ -14873,36 +14890,27 @@ static int check_cond_jmp_op(struct bpf_ver=
ifier_env *env,
> > >                     verbose(env, "BPF_JMP/JMP32 uses reserved fields\=
n");
> > >                     return -EINVAL;
> > >             }
> > > +           src_reg =3D &fake_reg;
> > > +           src_reg->type =3D SCALAR_VALUE;
> > > +           __mark_reg_known(src_reg, insn->imm);
> > >     }
> > >
> > >     is_jmp32 =3D BPF_CLASS(insn->code) =3D=3D BPF_JMP32;
> > >
> > >     if (BPF_SRC(insn->code) =3D=3D BPF_K) {
> > > -           pred =3D is_branch_taken(dst_reg, insn->imm, opcode, is_j=
mp32);
> > > +           pred =3D is_branch_taken(dst_reg, src_reg, opcode, is_jmp=
32);
> > >     } else if (src_reg->type =3D=3D SCALAR_VALUE &&
> > >                is_jmp32 && tnum_is_const(tnum_subreg(src_reg->var_off=
))) {
> > > -           pred =3D is_branch_taken(dst_reg,
> > > -                                  tnum_subreg(src_reg->var_off).valu=
e,
> > > -                                  opcode,
> > > -                                  is_jmp32);
> > > +           pred =3D is_branch_taken(dst_reg, src_reg, opcode, is_jmp=
32);
> > >     } else if (src_reg->type =3D=3D SCALAR_VALUE &&
> > >                !is_jmp32 && tnum_is_const(src_reg->var_off)) {
> > > -           pred =3D is_branch_taken(dst_reg,
> > > -                                  src_reg->var_off.value,
> > > -                                  opcode,
> > > -                                  is_jmp32);
> > > +           pred =3D is_branch_taken(dst_reg, src_reg, opcode, is_jmp=
32);
> > >     } else if (dst_reg->type =3D=3D SCALAR_VALUE &&
> > >                is_jmp32 && tnum_is_const(tnum_subreg(dst_reg->var_off=
))) {
> > > -           pred =3D is_branch_taken(src_reg,
> > > -                                  tnum_subreg(dst_reg->var_off).valu=
e,
> > > -                                  flip_opcode(opcode),
> > > -                                  is_jmp32);
> > > +           pred =3D is_branch_taken(src_reg, dst_reg, flip_opcode(op=
code), is_jmp32);
> > >     } else if (dst_reg->type =3D=3D SCALAR_VALUE &&
> > >                !is_jmp32 && tnum_is_const(dst_reg->var_off)) {
> > > -           pred =3D is_branch_taken(src_reg,
> > > -                                  dst_reg->var_off.value,
> > > -                                  flip_opcode(opcode),
> > > -                                  is_jmp32);
> > > +           pred =3D is_branch_taken(src_reg, dst_reg, flip_opcode(op=
code), is_jmp32);
> > >     } else if (reg_is_pkt_pointer_any(dst_reg) &&
> > >                reg_is_pkt_pointer_any(src_reg) &&
> > >                !is_jmp32) {
>

