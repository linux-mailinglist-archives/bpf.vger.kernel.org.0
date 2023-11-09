Return-Path: <bpf+bounces-14605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6E67E7084
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 18:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DBB21F21871
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 17:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B55249FC;
	Thu,  9 Nov 2023 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQ+7qMU4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B022031E
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 17:41:33 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF8E2D69
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 09:41:33 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9de7a43bd1aso185717566b.3
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 09:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699551692; x=1700156492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSCyDgYMto0ZvJEnGxWLSDXHMrB8gYF6M6CmNaUphVI=;
        b=fQ+7qMU4ifLdCVnOYLa0gsUOENz9NGt5aZZbpAc6kk0HRlUMjvgW73mD0JYwOWsCZb
         eSwBalBkcnQamSivPPHshB9cTuyF2pYd8TxPbhhqyf/fUVgW/3LbECcvSE5+V0tAN/an
         S8i4ygTI68osIccwiNrJGHv9rhHjQsao8x5dgXWFDdmgBfI1CuL01EBk9aFLAtd7q3IU
         eJ6/TBwz1lm+BRRQvaciSJGazRC78T9wh2QWF4Bgo3pVag5Gum/Gv8AUUgCzfltQWj7r
         HMxlmxd9lnu07L/Sc1SgbaH618mVkZr8ZZiTYRWmKrlONCX+Wzk4gvjlaeLcVtq72Wod
         HEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699551692; x=1700156492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSCyDgYMto0ZvJEnGxWLSDXHMrB8gYF6M6CmNaUphVI=;
        b=boLAthAVyskMovvx9bF5WQToTpxDChXYFX4WtpFsXqjyQXdFQYXu/qCD1ATWRjK8dq
         FoCLWZvLhzpocySGpH5+/IEV7m3wJv0+tZD2l/a6e1kCT9lWPf7n13ausOi+QqrEiktX
         33ty0ifv65ZXW9noABlzxJNq94D45VX4PCDY7VYjftnHPvC/D0uZ1EHU8ZO5kKsaGiy8
         YIppoZl3xgPqBq6n/jF14kZdUCqF48maq9JR6hqePGUfOeYJiHOlyMzE75boq2lh2je/
         AFwmmK0CC1pOXhSrNPeJuQfi/AS8IxLjwXPg+IVOUxao9Vr2h5917ubVYcm5Z/Lep07B
         6cIA==
X-Gm-Message-State: AOJu0Yyoc9J6mA3sh/KXd6/5YcbLfdInz1pRoIoFH5N/L27GJ+trodhQ
	FxhwcpevjDaTNl63oR+1B3LHGvXKOTfZFH5/jIpBX//W
X-Google-Smtp-Source: AGHT+IHzawwm7xNamyTpBDo9pwqIjpllgxSx+nl/ucy4qlbrXUxLt3OjgAcR05ZaZ4SlPNPGmdfx5jXht4vg+rB83N0=
X-Received: by 2002:a17:907:2da5:b0:9c1:9b3a:4cd1 with SMTP id
 gt37-20020a1709072da500b009c19b3a4cd1mr4916537ejc.3.1699551691501; Thu, 09
 Nov 2023 09:41:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031050324.1107444-1-andrii@kernel.org> <20231031050324.1107444-7-andrii@kernel.org>
 <891df9e42aee4ce7c46010cd93744e2b90819502.camel@gmail.com>
In-Reply-To: <891df9e42aee4ce7c46010cd93744e2b90819502.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Nov 2023 09:41:20 -0800
Message-ID: <CAEf4BzbmCngJeThcwUt52f7nNqOUtfOury3KfCrr+QiYKVX74w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] bpf: preserve constant zero when doing
 partial register restore
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 7:21=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2023-10-30 at 22:03 -0700, Andrii Nakryiko wrote:
> > Similar to special handling of STACK_ZERO, when reading 1/2/4 bytes fro=
m
> > stack from slot that has register spilled into it and that register has
> > a constant value zero, preserve that zero and mark spilled register as
> > precise for that. This makes spilled const zero register and STACK_ZERO
> > cases equivalent in their behavior.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Could you please add a test case?
>

There is already at least one test case that relies on this behavior
:) But yep, I'll add a dedicated test.

> [...]
>
> > ---
> >  kernel/bpf/verifier.c | 25 +++++++++++++++++++++----
> >  1 file changed, 21 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 0eecc6b3109c..8cfe060e4938 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -4958,22 +4958,39 @@ static int check_stack_read_fixed_off(struct bp=
f_verifier_env *env,
> >                               copy_register_state(&state->regs[dst_regn=
o], reg);
> >                               state->regs[dst_regno].subreg_def =3D sub=
reg_def;
> >                       } else {
> [...]
> > +
> > +                             if (spill_cnt =3D=3D size &&
> > +                                 tnum_is_const(reg->var_off) && reg->v=
ar_off.value =3D=3D 0) {
> > +                                     __mark_reg_const_zero(&state->reg=
s[dst_regno]);
> > +                                     /* this IS register fill, so keep=
 insn_flags */
> > +                             } else if (zero_cnt =3D=3D size) {
> > +                                     /* similarly to mark_reg_stack_re=
ad(), preserve zeroes */
> > +                                     __mark_reg_const_zero(&state->reg=
s[dst_regno]);
> > +                                     insn_flags =3D 0; /* not restorin=
g original register state */
> > +                             } else {
> > +                                     mark_reg_unknown(env, state->regs=
, dst_regno);
> > +                                     insn_flags =3D 0; /* not restorin=
g original register state */
> > +                             }
>
> Condition for this branch is (off % BPF_REG_SIZE !=3D 0) || size !=3D spi=
ll_size,
> is it necessary to check for some unusual offsets, e.g. off % BPF_REG_SIZ=
E =3D=3D 7
> or something like that?

I don't think so. We rely on all bytes we are reading to be either
spills (and thus spill_cnt =3D=3D size), in which case verifier logic
makes sure we have spill at slot boundary (off % BPF_REG_SIZE =3D=3D 0).
Or it's all STACK_ZERO, and then zero_cnt =3D=3D size, in which case we
know it's zero.

Unless I missed something else?

>
> [...]
>
>

