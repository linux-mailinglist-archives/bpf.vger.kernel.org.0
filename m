Return-Path: <bpf+bounces-13715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E462B7DD0AD
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 16:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D06A281434
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 15:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C500B1E533;
	Tue, 31 Oct 2023 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkDEAytF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EC31E530
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 15:38:22 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE054102
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 08:38:20 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53e08b60febso9316549a12.1
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 08:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698766699; x=1699371499; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q5fJmltUfh5IjWMM8+TEmcayJir5+79RYy5YZcyxu8M=;
        b=MkDEAytFnQon4tK8OizpUqz2/IH/x7ZP/E0M/4zwV0JYLK7/hjZSzD5e7t1mLxUT0S
         g6zUCyCd5v6yk19ThhWmrzKRhK7fcvdMs/YbCBJU6kh888NacIuCjKEIJWvjreuJ0uck
         pRGcfsQlxr20UILbWUzqNaYPdLiIXKv7zRw4h04f1pU/6oOb3PHse289SCnf5AKkfm3o
         EWtpdhHaCyiJBYi39kBo4mIulJdIt+jm7fYpWgzKzRzR4f39B3jLYQrRzJ1IaAPPE89i
         LyjCn64YQ7BQ7OJTogIOpX9rBpqtNsXi3JoTtfSUTIw1Eb15X2/vNnecEXHS7pvte9Sj
         MYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698766699; x=1699371499;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5fJmltUfh5IjWMM8+TEmcayJir5+79RYy5YZcyxu8M=;
        b=OqENLLkdpG0Xo5dAMF2VZE14yX658KXh99pvmSVaPOihyiv05siTZTBPHrS26ULBGA
         oqGIh0fOec70etU7CmYB+PWTgIS8bmNF+Z/i6qEl3lWlFKw6ohzm2C9IJX7WX7UdqmL/
         XyJ9C/kt/Uu8NRNXpZ4VPFHqypsyxnNJ/4/gAPQ3C2srdO/idZD6BgMcqqMDvxSP0ffo
         wCWSyCZmLWXXW0LWB7fvE4b9qh5BEM08HLSut5wVtZPJ8J6WFBV2d3mUSNOKJ3Q4b36G
         ZdgJB3UPp+Ng9psulW1hDxE/JDsXcrKkld8wtQyQWYWuX5aH28oVqO6BRxIGEekGTMB8
         j7lA==
X-Gm-Message-State: AOJu0Yyp7HTEiLSZ9R6tfBgtzrtCMY1qOfU0qyyjMC3aMi6Yt9Zu2FKX
	LbG0DfQEyM1jeNxtnMfUS6s=
X-Google-Smtp-Source: AGHT+IGhtvoChvLUvbBiNO7I1YVIvtvE+OAcQfw5YY4F/igiDSBI+OlqbTjBZIKLhCEa/3GNMGwx5w==
X-Received: by 2002:a05:6402:95b:b0:53f:aa86:e839 with SMTP id h27-20020a056402095b00b0053faa86e839mr9422171edz.30.1698766698959;
        Tue, 31 Oct 2023 08:38:18 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v3-20020a50d583000000b0054365426621sm1346370edi.73.2023.10.31.08.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 08:38:18 -0700 (PDT)
Message-ID: <776179259164573a1c3b9f588c77082750014734.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 12/23] bpf: generalize is_branch_taken() to
 work with two registers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Tue, 31 Oct 2023 17:38:17 +0200
In-Reply-To: <20231027181346.4019398-13-andrii@kernel.org>
References: <20231027181346.4019398-1-andrii@kernel.org>
	 <20231027181346.4019398-13-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-10-27 at 11:13 -0700, Andrii Nakryiko wrote:
> > While still assuming that second register is a constant, generalize
> > is_branch_taken-related code to accept two registers instead of registe=
r
> > plus explicit constant value. This also, as a side effect, allows to
> > simplify check_cond_jmp_op() by unifying BPF_K case with BPF_X case, fo=
r
> > which we use a fake register to represent BPF_K's imm constant as
> > a register.
> >=20
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Please see a nitpick below.

> > ---
> >  kernel/bpf/verifier.c | 58 ++++++++++++++++++++++++-------------------
> >  1 file changed, 33 insertions(+), 25 deletions(-)
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index aa13f32751a1..fd328c579f10 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -14169,8 +14169,13 @@ static void find_good_pkt_pointers(struct bpf_=
verifier_state *vstate,
> >  	}));
> >  }
> > =20
> > -static int is_branch32_taken(struct bpf_reg_state *reg1, u32 val, u8 o=
pcode)
> > +/*
> > + * <reg1> <op> <reg2>, currently assuming reg2 is a constant
> > + */
> > +static int is_branch32_taken(struct bpf_reg_state *reg1, struct bpf_re=
g_state *reg2, u8 opcode)
> >  {
> > +	struct tnum subreg =3D tnum_subreg(reg1->var_off);
> > +	u32 val =3D (u32)tnum_subreg(reg2->var_off).value;
> >  	s32 sval =3D (s32)val;
> > =20
> >  	switch (opcode) {
> > @@ -14250,8 +14255,12 @@ static int is_branch32_taken(struct bpf_reg_st=
ate *reg1, u32 val, u8 opcode)
> >  }
> > =20
> > =20
> > -static int is_branch64_taken(struct bpf_reg_state *reg1, u64 val, u8 o=
pcode)
> > +/*
> > + * <reg1> <op> <reg2>, currently assuming reg2 is a constant
> > + */
> > +static int is_branch64_taken(struct bpf_reg_state *reg1, struct bpf_re=
g_state *reg2, u8 opcode)
> >  {
> > +	u64 val =3D reg2->var_off.value;
> >  	s64 sval =3D (s64)val;
> > =20
> >  	switch (opcode) {
> > @@ -14330,16 +14339,23 @@ static int is_branch64_taken(struct bpf_reg_s=
tate *reg1, u64 val, u8 opcode)
> >  	return -1;
> >  }
> > =20
> > -/* compute branch direction of the expression "if (reg opcode val) got=
o target;"
> > +/* compute branch direction of the expression "if (<reg1> opcode <reg2=
>) goto target;"
> >   * and return:
> >   *  1 - branch will be taken and "goto target" will be executed
> >   *  0 - branch will not be taken and fall-through to next insn
> > - * -1 - unknown. Example: "if (reg < 5)" is unknown when register valu=
e
> > + * -1 - unknown. Example: "if (reg1 < 5)" is unknown when register val=
ue
> >   *      range [0,10]
> >   */
> > -static int is_branch_taken(struct bpf_reg_state *reg1, u64 val, u8 opc=
ode,
> > -			   bool is_jmp32)
> > +static int is_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_=
state *reg2,
> > +			   u8 opcode, bool is_jmp32)
> >  {
> > +	struct tnum reg2_tnum =3D is_jmp32 ? tnum_subreg(reg2->var_off) : reg=
2->var_off;
> > +	u64 val;
> > +
> > +	if (!tnum_is_const(reg2_tnum))
> > +		return -1;
> > +	val =3D reg2_tnum.value;
> > +
> >  	if (__is_pointer_value(false, reg1)) {
> >  		if (!reg_not_null(reg1))
> >  			return -1;
> > @@ -14361,8 +14377,8 @@ static int is_branch_taken(struct bpf_reg_state=
 *reg1, u64 val, u8 opcode,
> >  	}
> > =20
> >  	if (is_jmp32)
> > -		return is_branch32_taken(reg1, val, opcode);
> > -	return is_branch64_taken(reg1, val, opcode);
> > +		return is_branch32_taken(reg1, reg2, opcode);
> > +	return is_branch64_taken(reg1, reg2, opcode);
> >  }
> > =20
> >  static int flip_opcode(u32 opcode)
> > @@ -14833,6 +14849,7 @@ static int check_cond_jmp_op(struct bpf_verifie=
r_env *env,
> >  	struct bpf_reg_state *regs =3D this_branch->frame[this_branch->curfra=
me]->regs;
> >  	struct bpf_reg_state *dst_reg, *other_branch_regs, *src_reg =3D NULL;
> >  	struct bpf_reg_state *eq_branch_regs;
> > +	struct bpf_reg_state fake_reg;

Nitpick:
bpf_reg_state has a lot of fields, e.g. 'parent' pointer. While it looks li=
ke
the use within this patch-set is safe, I suggest to change the declaration =
to
include '=3D {}' initializer. Just to err on a safe side for future modific=
ations.

> >  	u8 opcode =3D BPF_OP(insn->code);
> >  	bool is_jmp32;
> >  	int pred =3D -1;
> > @@ -14873,36 +14890,27 @@ static int check_cond_jmp_op(struct bpf_verif=
ier_env *env,
> >  			verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
> >  			return -EINVAL;
> >  		}
> > +		src_reg =3D &fake_reg;
> > +		src_reg->type =3D SCALAR_VALUE;
> > +		__mark_reg_known(src_reg, insn->imm);
> >  	}
> > =20
> >  	is_jmp32 =3D BPF_CLASS(insn->code) =3D=3D BPF_JMP32;
> > =20
> >  	if (BPF_SRC(insn->code) =3D=3D BPF_K) {
> > -		pred =3D is_branch_taken(dst_reg, insn->imm, opcode, is_jmp32);
> > +		pred =3D is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
> >  	} else if (src_reg->type =3D=3D SCALAR_VALUE &&
> >  		   is_jmp32 && tnum_is_const(tnum_subreg(src_reg->var_off))) {
> > -		pred =3D is_branch_taken(dst_reg,
> > -				       tnum_subreg(src_reg->var_off).value,
> > -				       opcode,
> > -				       is_jmp32);
> > +		pred =3D is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
> >  	} else if (src_reg->type =3D=3D SCALAR_VALUE &&
> >  		   !is_jmp32 && tnum_is_const(src_reg->var_off)) {
> > -		pred =3D is_branch_taken(dst_reg,
> > -				       src_reg->var_off.value,
> > -				       opcode,
> > -				       is_jmp32);
> > +		pred =3D is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
> >  	} else if (dst_reg->type =3D=3D SCALAR_VALUE &&
> >  		   is_jmp32 && tnum_is_const(tnum_subreg(dst_reg->var_off))) {
> > -		pred =3D is_branch_taken(src_reg,
> > -				       tnum_subreg(dst_reg->var_off).value,
> > -				       flip_opcode(opcode),
> > -				       is_jmp32);
> > +		pred =3D is_branch_taken(src_reg, dst_reg, flip_opcode(opcode), is_j=
mp32);
> >  	} else if (dst_reg->type =3D=3D SCALAR_VALUE &&
> >  		   !is_jmp32 && tnum_is_const(dst_reg->var_off)) {
> > -		pred =3D is_branch_taken(src_reg,
> > -				       dst_reg->var_off.value,
> > -				       flip_opcode(opcode),
> > -				       is_jmp32);
> > +		pred =3D is_branch_taken(src_reg, dst_reg, flip_opcode(opcode), is_j=
mp32);
> >  	} else if (reg_is_pkt_pointer_any(dst_reg) &&
> >  		   reg_is_pkt_pointer_any(src_reg) &&
> >  		   !is_jmp32) {


