Return-Path: <bpf+bounces-17303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FAA80B1AE
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 03:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88F6281965
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 02:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4837710E4;
	Sat,  9 Dec 2023 02:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAlqBpSx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C761010EA
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 18:17:10 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c317723a8so17082985e9.3
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 18:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702088229; x=1702693029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lg9YDb3ecFidJfiDf/82cHzmMp0k17JL+DG1VKvCkFA=;
        b=DAlqBpSx3zcq6pjGlKyBEDtTPHBawFDLbf1C1yA3a3qlgKLf/BvGVNjRb8m8tJS/WW
         7CTqcPaISooM8D6a4K//7BkKdIrNTJqf/Djiycn0QM5Asyu6eqvhxpT6Nysg9gke2zGc
         DYLecu/BCpcMqhiO93NZpzqn5SUEcWJIYBmgvuf+UNQE9DanTe7a2NP6nDKmLTleZ2E1
         +Bag+VJSCjB9F2WbnLuzXQnwJ9rVgmW3rG3qYzpvv06wRv00BrBPAozAOvE/wkL1iM7v
         kxLMgvUFIU5VzaZg2JS8GChvRuRSTAZF3HoUwM5yR8dMHslfZ2s3Vgtxm5wkDV5rbGn4
         IvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702088229; x=1702693029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lg9YDb3ecFidJfiDf/82cHzmMp0k17JL+DG1VKvCkFA=;
        b=qX6UnyRC4ggH1/aFbc3IVkJJPI9nH/ZPeL4SUAry/S6K4k0z8ICH6TMsfs8s2SVpmu
         /z9tLU9VKryf8vBEdmdo2NbcmM0vlRvutXKslLvOyaDbMltDYKUsJI3JsNdv44E7y5zP
         rB3oda3QTR+IzT5O+I56berWXRSDD9vATRjlc9Y/nRYvGjOfzBfArKt3BTpCZ9AnoDJY
         qDda/nnOR/FmeWJ+9Z/eR6JIhnXICJvMXyzJimhkiE+V+iVBixt2YlvJOEED9DXQ4pZY
         a9YUnrr8C2FkJ+hIuGMd9VIJamoLFdBF7VPKgd80c5x/qOn+K2wtfTaFHgFBpz9YFFKt
         jvag==
X-Gm-Message-State: AOJu0Yw65k/0saTD6g97OxS4UxNcVfAQG1UgjLPnbuJA5JTwQGcKEfIk
	cEXZY1y/Kiec7Gg2lOp0KuQdOfBK4+H0UPnxmYFturYB
X-Google-Smtp-Source: AGHT+IE9WPPCFuT2fRfmDmK1P9EFOHBUwbiOKpfuHgmxJNnMNtsMLpVOG39QGYL9ERyXHJ3ELzJJry9X1ON0eHkgOd0=
X-Received: by 2002:a05:600c:28c:b0:40c:2b68:dccc with SMTP id
 12-20020a05600c028c00b0040c2b68dcccmr381088wmk.134.1702088229144; Fri, 08 Dec
 2023 18:17:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231209010958.66758-1-andrii@kernel.org> <bff7a93dc02d42f71882d023179a1b481f5c884b.camel@gmail.com>
 <CAEf4BzaE6TiThSaq7+=KERW=zP4G6vJz1nQ6-EWQrpnF4Np=-w@mail.gmail.com>
In-Reply-To: <CAEf4BzaE6TiThSaq7+=KERW=zP4G6vJz1nQ6-EWQrpnF4Np=-w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Dec 2023 18:16:57 -0800
Message-ID: <CAEf4BzYjM8JM9Jygw98kVmUAid_-+Z8UwsXMX=1j3nHNuy9frQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: handle fake register spill to stack
 with BPF_ST_MEM instruction
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 6:15=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Dec 8, 2023 at 6:01=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >
> > On Fri, 2023-12-08 at 17:09 -0800, Andrii Nakryiko wrote:
> > > When verifier validates BPF_ST_MEM instruction that stores known
> > > constant to stack (e.g., *(u64 *)(r10 - 8) =3D 123), it effectively s=
pills
> > > a fake register with a constant (but initially imprecise) value to
> > > a stack slot. Because read-side logic treats it as a proper register
> > > fill from stack slot, we need to mark such stack slot initialization =
as
> > > INSN_F_STACK_ACCESS instruction to stop precision backtracking from
> > > missing it.
> > >
> > > Fixes: 41f6f64e6999 ("bpf: support non-r10 register spill/fill to/fro=
m stack in precision tracking")
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  kernel/bpf/verifier.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index fb690539d5f6..727a59e4a647 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -4498,7 +4498,6 @@ static int check_stack_write_fixed_off(struct b=
pf_verifier_env *env,
> > >               __mark_reg_known(&fake_reg, insn->imm);
> > >               fake_reg.type =3D SCALAR_VALUE;
> > >               save_register_state(env, state, spi, &fake_reg, size);
> > > -             insn_flags =3D 0; /* not a register spill */
> > >       } else if (reg && is_spillable_regtype(reg->type)) {
> > >               /* register containing pointer is being spilled into st=
ack */
> > >               if (size !=3D BPF_REG_SIZE) {
> >
> > So, the problem is that for some 'r5 =3D r10; *(u64 *)(r5 - 8) =3D 123'
> > backtracking won't reset precision mark for -8, right?
>
> no, the problem is that we won't stop at the right instruction. Let's
> say we have this sequence
>
> 1: *(u64 *)(r10 - 8) =3D 123;
> 2: r1 =3D *(u64 *)(r10 - 8);
> 3: if r1 =3D=3D 123 goto +10;
> ...
>
> At 3: we want to set r1 to precise. We go back, see that at 2: we set
> r1 from fp-8 slot, so instead of looking for r1, we start looking for
> what set fp-8 now. So we go to 1:, and because it actually is not
> marked as INSN_F_STACK_ACCESS, we skip it, and keep looking further
> for what set fp-8. At some point we can go to parent state that didn't
> even have fp-8 stack slot allocated (or we can get out and then see
> that we haven't cleared all stack slot bits in our masks). So this
> patch makes it so that 1: is marked as setting fp-8 slot, and
> precision propagation will clear fp-8 from the mask.
>
> Now, the subtle thing here is that this doesn't happen with STACK_ZERO
> or STACK_MISC. Let's look at STACK_MISC/STACK_INVALID case.
>
> 1: *(u8 *)(r10 -1) =3D 123; /* now fp-8=3Dm??????? */
> 2: r1 =3D *(u64 *)(r10 - 8); /* STACK_MISC read, r1 is set to unknown sca=
lar */
> 3: if r1 =3D=3D 123 goto +10;

small correction, with STACK_MISC conditional jump won't mark_precise,
we'd need some other instruction to trigger precision, but hopefully
the point is still clear

>
> Let's do analysis again. At 3: we mark r1 as precise, go back to 2:.
> Here 2: instruction is not marked as INSN_F_STACK_ACCESS because it
> wasn't stack fill due to STACK_MISC (that's handled in
> check_read_fixed_off logic). So mark_chain_precision() stops here
> because that instruction is resetting r1, so we clear r1 from the
> mask, but this instruction isn't STACK_ACCESS, so we don't look for
> fp-8 here.
>
> I think check_stack_write_fixed_off() can always set
> INSN_F_STACK_ACCESS, actually, maybe that would be easier to follow.
> Even when we write STACK_ZERO/STACK_MISC. It's only
> check_stack_read_fixed_off() that has to be careful and drop
> INSN_F_STACK_ACCESS if we didn't really fill the register state from
> the stack slot.
>
>
> > That's not a tragedy we just get more precision marks than needed,
> > however, I think that same logic applies to the MISC/ZERO case below.
>
> See above, MISC/ZERO is fine as is due to check_stack_read_fixed_off()
> not setting STACK_ACCESS bit, but I can also send a version that
> unconditionally sets INSNS_F_STACK_ACCESS in
> check_stack_write_fixed_off().
>
> > I'll look through the tests in the morning.
>
> Thanks, no rush!

