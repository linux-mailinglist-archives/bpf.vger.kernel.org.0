Return-Path: <bpf+bounces-31537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 846758FF59D
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 22:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB57E1F25532
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 20:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB04F61FE2;
	Thu,  6 Jun 2024 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Au8EwlHY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B531845012
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717704180; cv=none; b=a3TRZ2Dj612IivmNdT38zU6l3XzH/jdT4biYXaykmPyNBkYEmpoRm6FJj8Gx5/OoUZm3BjLvxntSaiYtUvCXa20ykMAwuC8cpqf4GDgbtj2L+6N6yjnHLTarzOaX6503P2fSpxPczZXtOfDhNd1SeLuWtvWP4bNLlV7aJcKCjyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717704180; c=relaxed/simple;
	bh=b4bXW2kBgLDT/mSHERfHAJfyaaWZShx90p6srXthDt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGqoiJWem0/05ODPnT+bWKjw3bFoRpZRI84/qxc6/gsO5g47pDlE/d4vJehskXVn1l3/sEzyJTA3qlsvsPhi8ySUxW4LzLzvIXZDPCqXGrTcHOhkbyz/BtDPiT+axWBn9gK6hMtD0zSkxw1ChOpsCJ0UDNEFuoZGQkawQDLuW0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Au8EwlHY; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-35e573c0334so1480992f8f.1
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2024 13:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717704177; x=1718308977; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FB/DlJD7GLX9u6ZAKnDvQ2Upqu0KDPCGcQVaH0zzp4s=;
        b=Au8EwlHYesCsiBNtr6iTHr9fc6Yt0MGe56RR560isXyS8+k6GwZOR1Xt0L02hTlScJ
         yAAoLik9HdcuTy2JCO62sf/xUsZ1TlGHbb/IKO09SqnSPi0R96yqRHHGDsU1dhF/2AOL
         NcKkC0p7x31tDGAzPcyVKkgM7lYjnn/5mJRHxwyofCKexPOJoJ3L9nBZZd259N5Y3Omr
         Bm79OAkfPwx6ymTkkhVYguUqe2IRR+Klj2E7WQOO/h6x4Oz8JIoVy8ajBzHeoQ2IHAv6
         ms1OCbN3ZKwuzoq7BFxyQNswwwzrAlu00DmC0V6oU7kf+Yizrp6AtXed3i2ClGWJwwvJ
         kX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717704177; x=1718308977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FB/DlJD7GLX9u6ZAKnDvQ2Upqu0KDPCGcQVaH0zzp4s=;
        b=aHSr231LyvUxVs09QrHfx1CWhspWME/gHSExKvAOKjoOm1UL0UQoUp1XNPbBhqGYaU
         5I78CIaBpGE3CJVxKcIXP2HcfLgyHz7yj5Qv/QfCGhSppD3gBGDH4RpBIPre/K297HPc
         X4+AnPl3ufuGsiwjVN7bm+Wkl2ZWzhf42OdkTaEC17LVN2zp2hkWAOqKGDx3oTWEK7NW
         4lI8xJh7KGqQmgvF3LDg+3KT8UjXztepA7f4JxtLa+AfIHfzxFSPrUWow6+5lUnyvmLI
         iDl+IMq0Fs1Dag6POgTDx45AdwKB6UfW8QHP0DED8Vu+045kZXbHYJPCAXkyOMqNmgZN
         6xEg==
X-Gm-Message-State: AOJu0YxdBAoxYp3W5CUVjvL+VoozZUy+IskNV6SOVdclx9Dkj2qji8JV
	VI06AREYfBEIu4Mh2AkhwQvo0ZW2WFdkegTEBh3OUd/whxsrudWB4miiNEiIaeG/tFVu+8nieX1
	+Hh0d9AU2AJvZ+dyBr1muU0LbW/8=
X-Google-Smtp-Source: AGHT+IHa9Oik+btKG7WZIXYfEw/pOWra5Y2q1GO2hdGk+O1ysg0OWo2uA60yxOS/CZBtj6jvl1EXzZOIkcX5TsLuTOI=
X-Received: by 2002:adf:f302:0:b0:34d:8d11:f8c0 with SMTP id
 ffacd0b85a97d-35efea26b9emr629967f8f.18.1717704176520; Thu, 06 Jun 2024
 13:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606005425.38285-1-alexei.starovoitov@gmail.com>
 <20240606005425.38285-2-alexei.starovoitov@gmail.com> <6dbfd5e14ffbf9d828d63c5855f9bb783ac2506a.camel@gmail.com>
In-Reply-To: <6dbfd5e14ffbf9d828d63c5855f9bb783ac2506a.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 6 Jun 2024 13:02:45 -0700
Message-ID: <CAADnVQ+KFoNW-yJCa5fFmNzXjoEN4ECvPeQ1YoCeSZpyR9uO5Q@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/3] bpf: Relax precision marking in open
 coded iters and may_goto loop.
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: multipart/mixed; boundary="000000000000457df0061a3e2b48"

--000000000000457df0061a3e2b48
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 4:08=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2024-06-05 at 17:54 -0700, Alexei Starovoitov wrote:
>
> [...]
>
> This looks interesting, need a bit more time to think about it.
> A few minor notes below.
>
> [...]
>
> > @@ -14704,6 +14705,165 @@ static u8 rev_opcode(u8 opcode)
> >       }
> >  }
> >
> > +/* Similar to mark_reg_unknown() and should only be called from cap_bp=
f path */
> > +static void mark_unknown(struct bpf_reg_state *reg)
> > +{
> > +     u32 id =3D reg->id;
> > +
> > +     __mark_reg_unknown_imprecise(reg);
> > +     reg->id =3D id;
> > +}
> > +/*
> > + * Similar to regs_refine_cond_op(), but instead of tightening the ran=
ge
> > + * widen the upper bound of reg1 based on reg2 and
> > + * lower bound of reg2 based on reg1.
> > + */
> > +static void widen_reg_bounds(struct bpf_reg_state *reg1,
> > +                          struct bpf_reg_state *reg2,
> > +                          u8 opcode, bool is_jmp32)
> > +{
> > +     switch (opcode) {
> > +     case BPF_JGE:
> > +     case BPF_JGT:
> > +     case BPF_JSGE:
> > +     case BPF_JSGT:
> > +             opcode =3D flip_opcode(opcode);
> > +             swap(reg1, reg2);
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     switch (opcode) {
> > +     case BPF_JLE:
> > +             if (is_jmp32) {
> > +                     reg1->u32_max_value =3D reg2->u32_max_value;
> > +                     reg1->s32_max_value =3D S32_MAX;
> > +                     reg1->umax_value =3D U64_MAX;
> > +                     reg1->smax_value =3D S64_MAX;
> > +
> > +                     reg2->u32_min_value =3D reg1->u32_min_value;
> > +                     reg2->s32_min_value =3D S32_MIN;
> > +                     reg2->umin_value =3D 0;
> > +                     reg2->smin_value =3D S64_MIN;
> > +             } else {
> > +                     reg1->umax_value =3D reg2->umax_value;
> > +                     reg1->smax_value =3D S64_MAX;
> > +                     reg1->u32_max_value =3D U32_MAX;
> > +                     reg1->s32_max_value =3D S32_MAX;
> > +
> > +                     reg2->umin_value =3D reg1->umin_value;
> > +                     reg2->smin_value =3D S64_MIN;
> > +                     reg2->u32_min_value =3D U32_MIN;
> > +                     reg2->s32_min_value =3D S32_MIN;
> > +             }
> > +             reg1->var_off =3D tnum_unknown;
> > +             reg2->var_off =3D tnum_unknown;
> > +             break;
>
> Just a random thought: suppose that one of the registers in question
> is used as an index int the array of ints, and compiler increments it
> using +=3D 4. Would it be interesting to preserve alignment info in the
> var_off in such case? (in other words, preserve known trailing zeros).

Well, the verifier cannot figure out which register is
an induction variable. Compiler can generate a code where
would be multiple such registers too.
But even if it was one rX +=3D 4
it's nor clear how to figure out the size of the increment.

Also the above code is called at the time of comparison like "if 2 < 100".
I figured I will try a heuristic at that time.
See attached diff.
It computes alignment of LHS and RHS and
then heuristically adjusts the range.
After spending all morning on it and various heuristics
I'm convinced that this is a dead end.
It cannot be made to work with i +=3D 2 loops.

> [...]
>
> > @@ -15177,8 +15339,78 @@ static int check_cond_jmp_op(struct bpf_verifi=
er_env *env,
> >       }
> >
> >       is_jmp32 =3D BPF_CLASS(insn->code) =3D=3D BPF_JMP32;
> > +     if (dst_reg->type !=3D SCALAR_VALUE || src_reg->type !=3D SCALAR_=
VALUE ||
> > +         /* Widen scalars only if they're constants */
> > +         !is_reg_const(dst_reg, is_jmp32) || !is_reg_const(src_reg, is=
_jmp32))
> > +             do_widen =3D false;
> > +     else if (reg_const_value(dst_reg, is_jmp32) =3D=3D reg_const_valu=
e(src_reg, is_jmp32))
> > +             /* And not equal */
> > +             do_widen =3D false;
> > +     else
> > +             do_widen =3D (get_loop_entry(this_branch) ||
> > +                         this_branch->may_goto_depth) &&
> > +                             /* Gate widen_reg() logic */
> > +                             env->bpf_capable;
> > +
> >       pred =3D is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
> > -     if (pred >=3D 0) {
> > +
> > +     if (do_widen && ((opcode =3D=3D BPF_JNE && pred =3D=3D 1) ||
> > +                      (opcode =3D=3D BPF_JEQ && pred =3D=3D 0))) {
> > +             /*
> > +              * !=3D is too vague. let's try < and > and widen. Exampl=
e:
> > +              *
> > +              * R6=3D2
> > +              * 21: (15) if r6 =3D=3D 0x3e8 goto pc+14
> > +              * Predicted =3D=3D not-taken, but < is also true
> > +              * 21: R6=3Dscalar(smin=3Dumin=3Dsmin32=3Dumin32=3D2,smax=
=3Dumax=3Dsmax32=3Dumax32=3D999,var_off=3D(0x0; 0x3ff))
> > +              */
> > +             int refine_pred;
> > +             u8 opcode2 =3D BPF_JLT;
> > +
> > +             refine_pred =3D is_branch_taken(dst_reg, src_reg, BPF_JLT=
, is_jmp32);
> > +             if (refine_pred =3D=3D 1) {
> > +                     widen_reg(env, dst_reg, src_reg, BPF_JLT, is_jmp3=
2, true);
> > +
> > +             } else {
>
> nit: would it be possible to avoid second call to is_branch_taken()
>      by checking that refine_pred =3D=3D 0 and assuming opcode2 =3D=3D BP=
F_JGE?

I considered it, but it's too fragile, since it will depend
on both sides being constant (thought the algorithm currently requires it)
and on both sides not being equal (though the algorithm also
checks that beforehand).

Much easier to reason about and experiment with the algorithm
when < and > are checked explicitly.
So I prefer to keep it this way.

> > +                     opcode2 =3D BPF_JGT;
> > +                     refine_pred =3D is_branch_taken(dst_reg, src_reg,=
 BPF_JGT, is_jmp32);
> > +                     if (refine_pred =3D=3D 1)
> > +                             widen_reg(env, dst_reg, src_reg, BPF_JGT,=
 is_jmp32, true);
> > +             }
> > +
> > +             if (refine_pred =3D=3D 1) {
> > +                     if (dst_reg->id)
> > +                             find_equal_scalars(this_branch, dst_reg);
>
> I think it is necessary to do find_equal_scalars() for src_reg as well,
> since widen_reg() could change both registers.

Kinda.
Doing find_equal_scalars(dst_reg) makes zero difference in tests.
I've added it for completeness,
but decided to avoid spending extra cycles on src_reg,
since most of the time it's BPF_K anyway.
We can add it later when there is clear evidence that it helps.

--000000000000457df0061a3e2b48
Content-Type: application/octet-stream; name="mask.diff"
Content-Disposition: attachment; filename="mask.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lx3opfot0>
X-Attachment-Id: f_lx3opfot0

ZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvdmVyaWZpZXIuYyBiL2tlcm5lbC9icGYvdmVyaWZpZXIu
YwppbmRleCA3OWUzNTZhYzAyYWIuLmQ2ZjY0ZTI0YjAxNSAxMDA2NDQKLS0tIGEva2VybmVsL2Jw
Zi92ZXJpZmllci5jCisrKyBiL2tlcm5lbC9icGYvdmVyaWZpZXIuYwpAQCAtMTQ3MjIsNiArMTQ3
MjIsOSBAQCBzdGF0aWMgdm9pZCB3aWRlbl9yZWdfYm91bmRzKHN0cnVjdCBicGZfcmVnX3N0YXRl
ICpyZWcxLAogCQkJICAgICBzdHJ1Y3QgYnBmX3JlZ19zdGF0ZSAqcmVnMiwKIAkJCSAgICAgdTgg
b3Bjb2RlLCBib29sIGlzX2ptcDMyKQogeworCWludCBiaXQxID0gZmZzKHJlZ19jb25zdF92YWx1
ZShyZWcxLCBpc19qbXAzMikpOworCWludCBiaXQyID0gZmZzKHJlZ19jb25zdF92YWx1ZShyZWcy
LCBpc19qbXAzMikpOworCiAJc3dpdGNoIChvcGNvZGUpIHsKIAljYXNlIEJQRl9KR0U6CiAJY2Fz
ZSBCUEZfSkdUOgpAQCAtMTQ4MzgsNiArMTQ4NDEsNjcgQEAgc3RhdGljIHZvaWQgd2lkZW5fcmVn
X2JvdW5kcyhzdHJ1Y3QgYnBmX3JlZ19zdGF0ZSAqcmVnMSwKIAlkZWZhdWx0OgogCQlicmVhazsK
IAl9CisKKwlpZiAoMSkgeworCQlpbnQgYml0ID0gNjQ7CisKKwkJaWYgKHJlZzEtPnVtYXhfdmFs
dWUgIT0gVTY0X01BWCkgeworCQkJYml0ID0gbWluKGJpdCwgZmZzKHJlZzEtPnVtYXhfdmFsdWUp
KTsKKwkJCXJlZzEtPnVtYXhfdmFsdWUgJj0gcmVnMS0+dW1heF92YWx1ZSAtIDE7CisJCX0KKwkJ
aWYgKHJlZzEtPnUzMl9tYXhfdmFsdWUgIT0gVTMyX01BWCkgeworCQkJYml0ID0gbWluKGJpdCwg
ZmZzKHJlZzEtPnUzMl9tYXhfdmFsdWUpKTsKKwkJCXJlZzEtPnUzMl9tYXhfdmFsdWUgJj0gcmVn
MS0+dTMyX21heF92YWx1ZSAtIDE7CisJCX0KKwkJaWYgKHJlZzEtPnNtYXhfdmFsdWUgIT0gUzY0
X01BWCkgeworCQkJYml0ID0gbWluKGJpdCwgZmZzKHJlZzEtPnNtYXhfdmFsdWUpKTsKKwkJCXJl
ZzEtPnNtYXhfdmFsdWUgJj0gcmVnMS0+c21heF92YWx1ZSAtIDE7CisJCX0KKwkJaWYgKHJlZzEt
PnMzMl9tYXhfdmFsdWUgIT0gUzMyX01BWCkgeworCQkJYml0ID0gbWluKGJpdCwgZmZzKHJlZzEt
PnMzMl9tYXhfdmFsdWUpKTsKKwkJCXJlZzEtPnMzMl9tYXhfdmFsdWUgJj0gcmVnMS0+czMyX21h
eF92YWx1ZSAtIDE7CisJCX0KKworCQlyZWcxLT52YXJfb2ZmID0gdG51bV9sc2hpZnQocmVnMS0+
dmFyX29mZiwgbWF4KGJpdDEsIGJpdCkpOworCQlpZiAocmVnMS0+dW1heF92YWx1ZSAhPSBVNjRf
TUFYKQorCQkJcmVnMS0+dW1heF92YWx1ZSAmPSByZWcxLT52YXJfb2ZmLm1hc2s7CisJCWlmIChy
ZWcxLT51MzJfbWF4X3ZhbHVlICE9IFUzMl9NQVgpCisJCQlyZWcxLT51MzJfbWF4X3ZhbHVlICY9
IHJlZzEtPnZhcl9vZmYubWFzazsKKwkJaWYgKHJlZzEtPnNtYXhfdmFsdWUgIT0gUzY0X01BWCkK
KwkJCXJlZzEtPnNtYXhfdmFsdWUgJj0gcmVnMS0+dmFyX29mZi5tYXNrOworCQlpZiAocmVnMS0+
czMyX21heF92YWx1ZSAhPSBTMzJfTUFYKQorCQkJcmVnMS0+czMyX21heF92YWx1ZSAmPSByZWcx
LT52YXJfb2ZmLm1hc2s7CisJfQorCWlmICgxKSB7CisJCWludCBiaXQgPSA2NDsKKworCQlpZiAo
cmVnMi0+dW1pbl92YWx1ZSAhPSBVNjRfTUFYKSB7CisJCQliaXQgPSBtaW4oYml0LCBmZnMocmVn
Mi0+dW1pbl92YWx1ZSkpOworCQkJcmVnMi0+dW1pbl92YWx1ZSAmPSByZWcyLT51bWluX3ZhbHVl
IC0gMTsKKwkJfQorCQlpZiAocmVnMi0+dTMyX21pbl92YWx1ZSAhPSBVMzJfTUFYKSB7CisJCQli
aXQgPSBtaW4oYml0LCBmZnMocmVnMi0+dTMyX21pbl92YWx1ZSkpOworCQkJcmVnMi0+dTMyX21p
bl92YWx1ZSAmPSByZWcyLT51MzJfbWluX3ZhbHVlIC0gMTsKKwkJfQorCQlpZiAocmVnMi0+c21p
bl92YWx1ZSAhPSBTNjRfTUFYKSB7CisJCQliaXQgPSBtaW4oYml0LCBmZnMocmVnMi0+c21pbl92
YWx1ZSkpOworCQkJcmVnMi0+c21pbl92YWx1ZSAmPSByZWcyLT5zbWluX3ZhbHVlIC0gMTsKKwkJ
fQorCQlpZiAocmVnMi0+czMyX21pbl92YWx1ZSAhPSBTMzJfTUFYKSB7CisJCQliaXQgPSBtaW4o
Yml0LCBmZnMocmVnMi0+czMyX21pbl92YWx1ZSkpOworCQkJcmVnMi0+czMyX21pbl92YWx1ZSAm
PSByZWcyLT5zMzJfbWluX3ZhbHVlIC0gMTsKKwkJfQorCisJCXJlZzItPnZhcl9vZmYgPSB0bnVt
X2xzaGlmdChyZWcyLT52YXJfb2ZmLCBtYXgoYml0MiwgYml0KSk7CisJCWlmIChyZWcyLT51bWlu
X3ZhbHVlICE9IFU2NF9NQVgpCisJCQlyZWcyLT51bWluX3ZhbHVlICY9IHJlZzItPnZhcl9vZmYu
bWFzazsKKwkJaWYgKHJlZzItPnUzMl9taW5fdmFsdWUgIT0gVTMyX01BWCkKKwkJCXJlZzItPnUz
Ml9taW5fdmFsdWUgJj0gcmVnMi0+dmFyX29mZi5tYXNrOworCQlpZiAocmVnMi0+c21pbl92YWx1
ZSAhPSBTNjRfTUFYKQorCQkJcmVnMi0+c21pbl92YWx1ZSAmPSByZWcyLT52YXJfb2ZmLm1hc2s7
CisJCWlmIChyZWcyLT5zMzJfbWluX3ZhbHVlICE9IFMzMl9NQVgpCisJCQlyZWcyLT5zMzJfbWlu
X3ZhbHVlICY9IHJlZzItPnZhcl9vZmYubWFzazsKKwl9CiB9CiAKIC8qCmRpZmYgLS1naXQgYS90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvaXRlcnNfdGFza192bWEuYyBiL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy9pdGVyc190YXNrX3ZtYS5jCmluZGV4IDMxYzRl
N2Q5ZWFhMy4uZTQ5YTBlNTk0MzVhIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9icGYvcHJvZ3MvaXRlcnNfdGFza192bWEuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9icGYvcHJvZ3MvaXRlcnNfdGFza192bWEuYwpAQCAtODgsNyArODgsNyBAQCBpbnQgbG9vcF9p
bnNpZGVfaXRlcihjb25zdCB2b2lkICpjdHgpCiAJYnBmX2l0ZXJfbnVtX25ldygmaXQsIDAsIEFS
Ul9TWik7CiAJd2hpbGUgKCh2ID0gYnBmX2l0ZXJfbnVtX25leHQoJml0KSkpIHsKIAkJaWYgKGkg
PCBBUlJfU1opCi0JCQlzdW0gKz0gYXJyW2krK107CisJCQlzdW0gKz0gYXJyW2kgKz0gNF07CiAJ
fQogCWJwZl9pdGVyX251bV9kZXN0cm95KCZpdCk7CiAJcmV0dXJuIHN1bTsKQEAgLTE1OCw3ICsx
NTgsNyBAQCBpbnQgdG91Y2hfYXJyX2dsb2JhbChfX3UzMiBpKQogCiBTRUMoInNvY2tldCIpCiBf
X3N1Y2Nlc3MKLWludCBsb29wX2luc2lkZV9pdGVyX3N1YnByb2coY29uc3Qgdm9pZCAqY3R4KQor
aW50IG1heV9nb3RvX3N1YnByb2coY29uc3Qgdm9pZCAqY3R4KQogewogCWxvbmcgaTsKIApAQCAt
MTcwLDQgKzE3MCwyNiBAQCBpbnQgbG9vcF9pbnNpZGVfaXRlcl9zdWJwcm9nKGNvbnN0IHZvaWQg
KmN0eCkKIAogCXJldHVybiAwOwogfQorCitfX25vaW5saW5lCitzdGF0aWMgdm9pZCB0b3VjaF9h
cnJfbXVsdGkoaW50IGkpCit7CisJaWYgKGkgPj0gQVJSX1NaIC0gNCkKKwkJcmV0dXJuOworCWFy
cltpXSA9IGk7CisJYXJyW2kgKyAxXSA9IGk7CisJYXJyW2kgKyAyXSA9IGk7CisJYXJyW2kgKyAz
XSA9IGk7Cit9CisKK1NFQygic29ja2V0IikKK19fc3VjY2VzcworaW50IG1heV9nb3RvX3N1YnBy
b2dfbWFzayhjb25zdCB2b2lkICpjdHgpCit7CisJbG9uZyBpOworCisJZm9yIChpID0gMDsgaSA8
PSAxMDAwMDAwICYmIGNhbl9sb29wOyBpICs9IDQpCisJCXRvdWNoX2Fycl9tdWx0aShpKTsKKwly
ZXR1cm4gMDsKK30KIGNoYXIgX2xpY2Vuc2VbXSBTRUMoImxpY2Vuc2UiKSA9ICJHUEwiOwo=
--000000000000457df0061a3e2b48--

