Return-Path: <bpf+bounces-19080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBE4824BAD
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 00:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9344DB237BB
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 23:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0112D049;
	Thu,  4 Jan 2024 23:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YO1sTj53"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60152D021
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 23:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55642663ac4so1207872a12.1
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 15:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704409790; x=1705014590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTCD0rYi89xQS99aF05cXwW3Lr+HVczkmO/TBpxG1Ns=;
        b=YO1sTj53Tjx9aaL6QLeZ63VRtFaEWCS0xxgZD6DDemPfAU+LcED05HZdd74Z7rKiof
         j4j+IF8yf/5yUVMYf+SkiiC24zeE7eGqHOOCvgvzsUGxi3y2CKvvW5DUwaaw8IlxQLxp
         Xwpzm/sgX43PZUasjl4ShPCSmSVq9PJfOJITQl7pROygw02JaXw+EZ35D2Sb7sVEI7uO
         FWAezqYBRqLb2ems830X6kjMZx7qx+8mtHeEaiXacvKyLq9fegyF31IqOBCyLxd96Adk
         GBLE0KHkFElGFYwFGk/mYJXUtffpXJ588abHghRJ4ZeKvAV2+kTqC/sEmJL5QPPS5tgC
         XWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704409790; x=1705014590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTCD0rYi89xQS99aF05cXwW3Lr+HVczkmO/TBpxG1Ns=;
        b=pKLjOL8ryA3g1k3I8x986LlVgjAPpZZFyRjd2dYZOS9Y7/0pr0/7xVpsxcO5Waw0f9
         ZnN+5+kAx2eZFp+WhA3n+BTPikF8JEUyxECsdGfw4PJlJSrENuIUomUWfN55O2HVZNjX
         Jn1/ESuWfDv5ZN5vKuDD4PkO9QopwPbIUHccOmcZnvx600HM99c8xHLnNxTbHVUMJxPv
         7aQVj3/6XXHDWYvY6z43ZcgldhvejObw9ecBLfrR2bBt6M6ZO08QJW4SMGccQX8QkAfh
         I1cSqSjj90nh43bSfs3c9rk5jukPGDBi5hKEp00GgkisurPX4uCKBwfZvhETp0FRzYf+
         yH7Q==
X-Gm-Message-State: AOJu0YwiPEtKulxCUb+jjsdvljeEa0XDwLx4ch5EacB9B02URH7zv9xK
	FauPN6dJtkNsds9XKm23EGzTmagq0axfPtZGX6XKx6U7
X-Google-Smtp-Source: AGHT+IHx1fNJVA/MffOLkBwR2MSSM8tU9SilYBSYK4u+opgPNipiEn5CX5jrE3lEjIM72FTTFuzTFPH+fXry/np3YCI=
X-Received: by 2002:a05:6402:794:b0:553:97fd:c42e with SMTP id
 d20-20020a056402079400b0055397fdc42emr712378edy.31.1704409789848; Thu, 04 Jan
 2024 15:09:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103232617.3770727-1-yonghong.song@linux.dev>
 <f4c1ebf73ccf4099f44045e8a5b053b7acdffeed.camel@gmail.com>
 <cbff1224-39c0-4555-a688-53e921065b97@linux.dev> <69410e766d68f4e69400ba9b1c3b4c56feaa2ca2.camel@gmail.com>
In-Reply-To: <69410e766d68f4e69400ba9b1c3b4c56feaa2ca2.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Jan 2024 15:09:37 -0800
Message-ID: <CAEf4Bzb0LdSPnFZ-kPRftofA6LsaOkxXLN4_fr9BLR3iG-te-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Track aligned st store as imprecise
 spilled registers
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 1:11=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Thu, 2024-01-04 at 12:12 -0800, Yonghong Song wrote:
> [...]
> > > > @@ -4613,11 +4613,28 @@ static int check_stack_write_var_off(struct=
 bpf_verifier_env *env,
> > > >
> > > >           /* Variable offset writes destroy any spilled pointers in=
 range. */
> > > >           for (i =3D min_off; i < max_off; i++) {
> > > > +         struct bpf_reg_state *spill_reg;
> > > >                   u8 new_type, *stype;
> > > > -         int slot, spi;
> > > > +         int slot, spi, j;
> > > >
> > > >                   slot =3D -i - 1;
> > > >                   spi =3D slot / BPF_REG_SIZE;
> > > > +
> > > > +         /* If writing_zero and the the spi slot contains a spill =
of value 0,
> > > > +          * maintain the spill type.
> > > > +          */
> > > > +         if (writing_zero && !(i % BPF_REG_SIZE) && is_spilled_sca=
lar_reg(&state->stack[spi])) {
> > > Talked to Andrii today, and he noted that spilled reg should be marke=
d
> > > precise at this point.
> >
> > Could you help explain why?
> >
> > Looks we did not mark reg as precise with fixed offset as below:
> >
> >          if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &=
& env->bpf_capable) {
> >                  save_register_state(env, state, spi, reg, size);
> >                  /* Break the relation on a narrowing spill. */
> >                  if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
> >                          state->stack[spi].spilled_ptr.id =3D 0;
> >          } else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn=
) &&
> >                     insn->imm !=3D 0 && env->bpf_capable) {
> >
> > I probably missed something about precision tracking...
>
> The discussed justification was that if verifier assumes something
> about the value of scalar (in this case that it is 0) such scalar
> should be marked precise (e.g. this is done for value_regno in
> check_stack_write_var_off()).
>
> This seemed logical at the time of discussion, however, I can't figure
> a counter example at the moment. It appears that whatever are
> assumptions in check_stack_write_var_off() if spill is used in the
> precise context it would be marked eventually.
> E.g. the following is correctly rejected:
>
> SEC("raw_tp")
> __log_level(2) __flag(BPF_F_TEST_STATE_FREQ)
> __failure
> __naked void var_stack_1(void)
> {
>         asm volatile (
>                 "call %[bpf_get_prandom_u32];"
>                 "r9 =3D 100500;"
>                 "if r0 > 42 goto +1;"
>                 "r9 =3D 0;"
>                 "*(u64 *)(r10 - 16) =3D r9;"
>                 "call %[bpf_get_prandom_u32];"
>                 "r0 &=3D 0xf;"
>                 "r1 =3D -1;"
>                 "r1 -=3D r0;"
>                 "r2 =3D r10;"
>                 "r2 +=3D r1;"
>                 "r0 =3D 0;"
>                 "*(u8 *)(r2 + 0) =3D r0;"
>                 "r1 =3D %[two_byte_buf];"
>                 "r2 =3D *(u32 *)(r10 -16);"
>                 "r1 +=3D r2;"
>                 "*(u8 *)(r1 + 0) =3D r2;" /* this should not be fine */
>                 "exit;"
>         :
>         : __imm_ptr(two_byte_buf),
>           __imm(bpf_get_prandom_u32)
>         : __clobber_common);
> }
>
> So now I'm not sure :(
> Sorry for too much noise.


hm... does that test have to do so many things and do all these u64 vs
u32 vs u8 conversions? Can we try a simple test were we spill u64
SCALAR (imprecise) zero register to fp-8 or fp-16, and then use those
fp-8|fp-16 slot as an index into an array in precise context. Then
have a separate delayed branch that will write non-zero to fp-8|fp-16.
States shouldn't converge and this should be rejected.


Yonghong, the reason fixed offset stack write works is because we know
exactly the stack slot in which spilled register is and we can
backtrack and mark it as precise, if necessary. With variable offset
stack access there is no single stack slot (in general case), so we
lose the link to that spilled register. So we need to either eagerly
mark spilled registers as precise or just do STACK_MISC kind of logic.

