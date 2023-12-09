Return-Path: <bpf+bounces-17302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759F180B1AC
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 03:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52447B20BE8
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 02:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392FE10E4;
	Sat,  9 Dec 2023 02:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSDkvZW/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EC110EA
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 18:15:52 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a1f0616a15bso271331166b.2
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 18:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702088151; x=1702692951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZBFyF+ozTxEisU4ahwbGCca6SmQW5mXu7mq+8sNozE=;
        b=BSDkvZW/G3AQZd4qlUOVlKd+9Z0aErlzCs00hlsagbDhwAsBkT+UXN61X9OV6zgxXb
         PNti/P7KcflwZsTGL3Ho60hLXkIwWhwQnMLBj3Xo555Ee1e5lsQ8AVUCu4hHTWZTDwE9
         /DgzsOsvawtqYo9wI5+IpMMbiNG6DN3AZHoaeny5ikj7s5TPwKisaVjFGrhAYXaRPEJO
         JsRcfSrzg5dIOBKGBa/vLAvJvdGdT87FlYo2CX/YVmG9Z97pbgiKS2ptS/X7v9SIcz0W
         Q3ZI477d0kJQe+4ot26Tgma64q3bm1IMbTA26oWjNmIwi9i4sDGaIK366ZusnV14L3Ul
         A1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702088151; x=1702692951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZBFyF+ozTxEisU4ahwbGCca6SmQW5mXu7mq+8sNozE=;
        b=ZP6j7A3RK21zCGbeZfaYhJbblLYe029TtEXxJCNCKaliHA3T9L2g92EAz5fz72mFMU
         rK3y3O28hZkGfQ4errKqYwm7NT9MQ1NEMUX81RTtxGva4Q4zrIFZQyl7rbDiFMj9zzYp
         TVzSQQbvck9jN7A73FLAdWTBUQGbnmcF2FTGz939AB5B1NPz067G1CDQqjBbw7ig4gCA
         P2+U+wxgFpxHCjf8yHt9M5pwRPSayewW4je5JGLBRF5dojma8kPLV/CQiGewqyXIPoxn
         Wpx91xB1nZWC4YpziHGG3PEzmsbUUrx4JUJB1EbFX/DxQfCWBuW9MPxnlpIxSKuLMv7O
         11NA==
X-Gm-Message-State: AOJu0YzJ7ZsZ4lTisJY0MFsidL0dZHT2TOS5wpVpq59IYma7mfG7mWyY
	ctO+T5e9W0vDVjQ9ZBG1WM3Fskf/KybM5IzJzg4=
X-Google-Smtp-Source: AGHT+IH5nkAvOq1mwv6w6u92airwangADpSscqOGfEG1QWX7F7wxVXysxLQyR2wKIEO1KOyJEhvzazgPPadWbzuW2zA=
X-Received: by 2002:a17:906:738f:b0:a18:6d75:212e with SMTP id
 f15-20020a170906738f00b00a186d75212emr409838ejl.57.1702088150783; Fri, 08 Dec
 2023 18:15:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231209010958.66758-1-andrii@kernel.org> <bff7a93dc02d42f71882d023179a1b481f5c884b.camel@gmail.com>
In-Reply-To: <bff7a93dc02d42f71882d023179a1b481f5c884b.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Dec 2023 18:15:38 -0800
Message-ID: <CAEf4BzaE6TiThSaq7+=KERW=zP4G6vJz1nQ6-EWQrpnF4Np=-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: handle fake register spill to stack
 with BPF_ST_MEM instruction
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 6:01=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Fri, 2023-12-08 at 17:09 -0800, Andrii Nakryiko wrote:
> > When verifier validates BPF_ST_MEM instruction that stores known
> > constant to stack (e.g., *(u64 *)(r10 - 8) =3D 123), it effectively spi=
lls
> > a fake register with a constant (but initially imprecise) value to
> > a stack slot. Because read-side logic treats it as a proper register
> > fill from stack slot, we need to mark such stack slot initialization as
> > INSN_F_STACK_ACCESS instruction to stop precision backtracking from
> > missing it.
> >
> > Fixes: 41f6f64e6999 ("bpf: support non-r10 register spill/fill to/from =
stack in precision tracking")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/bpf/verifier.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index fb690539d5f6..727a59e4a647 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -4498,7 +4498,6 @@ static int check_stack_write_fixed_off(struct bpf=
_verifier_env *env,
> >               __mark_reg_known(&fake_reg, insn->imm);
> >               fake_reg.type =3D SCALAR_VALUE;
> >               save_register_state(env, state, spi, &fake_reg, size);
> > -             insn_flags =3D 0; /* not a register spill */
> >       } else if (reg && is_spillable_regtype(reg->type)) {
> >               /* register containing pointer is being spilled into stac=
k */
> >               if (size !=3D BPF_REG_SIZE) {
>
> So, the problem is that for some 'r5 =3D r10; *(u64 *)(r5 - 8) =3D 123'
> backtracking won't reset precision mark for -8, right?

no, the problem is that we won't stop at the right instruction. Let's
say we have this sequence

1: *(u64 *)(r10 - 8) =3D 123;
2: r1 =3D *(u64 *)(r10 - 8);
3: if r1 =3D=3D 123 goto +10;
...

At 3: we want to set r1 to precise. We go back, see that at 2: we set
r1 from fp-8 slot, so instead of looking for r1, we start looking for
what set fp-8 now. So we go to 1:, and because it actually is not
marked as INSN_F_STACK_ACCESS, we skip it, and keep looking further
for what set fp-8. At some point we can go to parent state that didn't
even have fp-8 stack slot allocated (or we can get out and then see
that we haven't cleared all stack slot bits in our masks). So this
patch makes it so that 1: is marked as setting fp-8 slot, and
precision propagation will clear fp-8 from the mask.

Now, the subtle thing here is that this doesn't happen with STACK_ZERO
or STACK_MISC. Let's look at STACK_MISC/STACK_INVALID case.

1: *(u8 *)(r10 -1) =3D 123; /* now fp-8=3Dm??????? */
2: r1 =3D *(u64 *)(r10 - 8); /* STACK_MISC read, r1 is set to unknown scala=
r */
3: if r1 =3D=3D 123 goto +10;

Let's do analysis again. At 3: we mark r1 as precise, go back to 2:.
Here 2: instruction is not marked as INSN_F_STACK_ACCESS because it
wasn't stack fill due to STACK_MISC (that's handled in
check_read_fixed_off logic). So mark_chain_precision() stops here
because that instruction is resetting r1, so we clear r1 from the
mask, but this instruction isn't STACK_ACCESS, so we don't look for
fp-8 here.

I think check_stack_write_fixed_off() can always set
INSN_F_STACK_ACCESS, actually, maybe that would be easier to follow.
Even when we write STACK_ZERO/STACK_MISC. It's only
check_stack_read_fixed_off() that has to be careful and drop
INSN_F_STACK_ACCESS if we didn't really fill the register state from
the stack slot.


> That's not a tragedy we just get more precision marks than needed,
> however, I think that same logic applies to the MISC/ZERO case below.

See above, MISC/ZERO is fine as is due to check_stack_read_fixed_off()
not setting STACK_ACCESS bit, but I can also send a version that
unconditionally sets INSNS_F_STACK_ACCESS in
check_stack_write_fixed_off().

> I'll look through the tests in the morning.

Thanks, no rush!

