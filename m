Return-Path: <bpf+bounces-10398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4366C7A6C8F
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 22:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0062814BE
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 20:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9A437149;
	Tue, 19 Sep 2023 20:56:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7CB8831
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 20:56:50 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE52B3
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 13:56:49 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9adc75f6f09so666221466b.0
        for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 13:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695157007; x=1695761807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyqvUbhubobdp/cVAZlOt3LK2aN2iqW+unTWk1/sHo4=;
        b=X3fksyNRYEXyLrdlZAuREoYk5c/gYDjjW43XJ9JAER0fXB6stI3lLls4VPH9wlybaA
         sq0R6YiReFlNhnNwAwN3H6dYK3WHS9cR8vTSTUQ745H/Lsb5etpU6mPts739auCnQeOT
         aIV20Od2bJ6nndmBX1wnFYoJeOu6RoWEsui8hjpuXgZ043y5znFc17hr372evnK1Qfie
         +pBqpr6gmNy+zfrtu+6aBwYGrLIs8QnrzLCRhQI8sL50fAHqWvSbQsHhPUCaqEgQwcUq
         gmVjx4KWVys3i8R4nNixvJ1sFCaygUibcAHtvj/ZWl7frOP2Ls48UjwBw3P0VQ38wXoI
         LcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695157007; x=1695761807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyqvUbhubobdp/cVAZlOt3LK2aN2iqW+unTWk1/sHo4=;
        b=mZhGLyr/AffQOkPzaV8ryHyB+/SAUwLX4mSymJv/Kc6PRCXjs2qW64LbIcwo6I3laL
         RH4L0fH5595nGZ1Ori06BO0e8gV6SExvhwSlrcFC27ju9Yig1H/+/PQkvUEVM9OKkHPV
         /IgmjULhPITpScze5DZD8GBRvBHKnrk+DNu5gZrfU13gXPWBkY3aU/SQbg6gxBmQ08tD
         9CPDoG4yuBW8WdixVcU+7i4ZxHtvthEM6U9SIMAHnC7smD8B6Q2E0g0wxDQzI4z+saO2
         XyuYfU4bHaeDCd8M9MSolkBUmiJl3oDDxZ+smcyrSI0rlpuroo5cf9zhp8unGhFfO4Kn
         Ucpg==
X-Gm-Message-State: AOJu0YyFrNhuM9W6ja2gSYnf01d19WsT8k21Hcrxfvb4dRkLOXClSiLA
	MwmifmYK0FImXeg61gHkmLiMI6FvSlfX90mvdMs=
X-Google-Smtp-Source: AGHT+IGguTYf4ByjMAPqzH+eUYRlueWE/dAGy62aMB2cxzRMrt/FV/tZRQ929bLLNEdrPTCx7Y+q0jL42aPCdt0XGJk=
X-Received: by 2002:a17:907:1dcf:b0:9ad:e711:89b6 with SMTP id
 og15-20020a1709071dcf00b009ade71189b6mr441187ejc.38.1695157007235; Tue, 19
 Sep 2023 13:56:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918210110.2241458-1-andrii@kernel.org> <CAADnVQ+w4e2K06tPdV8J-TuEvY6ysGv_45PJZe2AkOpYFrx7Og@mail.gmail.com>
 <CAEf4BzY9_0RCfXQdPL65W182jaQ3uHo7RUEkZ3JQaOfA5NXXMg@mail.gmail.com>
In-Reply-To: <CAEf4BzY9_0RCfXQdPL65W182jaQ3uHo7RUEkZ3JQaOfA5NXXMg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Sep 2023 13:56:35 -0700
Message-ID: <CAEf4BzYYm8enhZBw3QYxpPYGQEJTJ_0onDVAH4N8CvCsoxY+=A@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: unconditionally reset backtrack_state masks on
 global func exit
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 11:59=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Sep 19, 2023 at 2:06=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Sep 18, 2023 at 2:01=E2=80=AFPM Andrii Nakryiko <andrii@kernel.=
org> wrote:
> > >
> > > In mark_chain_precision() logic, when we reach the entry to a global
> > > func, it is expected that R1-R5 might be still requested to be marked
> > > precise. This would correspond to some integer input arguments being
> > > tracked as precise. This is all expected and handled as a special cas=
e.
> > >
> > > What's not expected is that we'll leave backtrack_state structure wit=
h
> > > some register bits set. This is because for subsequent precision
> > > propagations backtrack_state is reused without clearing masks, as all
> > > code paths are carefully written in a way to leave empty backtrack_st=
ate
> > > with zeroed out masks, for speed.
> > >
> > > The fix is trivial, we always clear register bit in the register mask=
, and
> > > then, optionally, set reg->precise if register is SCALAR_VALUE type.
> > >
> > > Reported-by: Chris Mason <clm@meta.com>
> > > Fixes: be2ef8161572 ("bpf: allow precision tracking for programs with=
 subprogs")
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  kernel/bpf/verifier.c | 8 +++-----
> > >  1 file changed, 3 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index bb78212fa5b2..c0c7d137066a 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -4047,11 +4047,9 @@ static int __mark_chain_precision(struct bpf_v=
erifier_env *env, int regno)
> > >                                 bitmap_from_u64(mask, bt_reg_mask(bt)=
);
> > >                                 for_each_set_bit(i, mask, 32) {
> > >                                         reg =3D &st->frame[0]->regs[i=
];
> > > -                                       if (reg->type !=3D SCALAR_VAL=
UE) {
> > > -                                               bt_clear_reg(bt, i);
> > > -                                               continue;
> > > -                                       }
> > > -                                       reg->precise =3D true;
> > > +                                       bt_clear_reg(bt, i);
> > > +                                       if (reg->type =3D=3D SCALAR_V=
ALUE)
> > > +                                               reg->precise =3D true=
;
> >
> > Looks good, but is there a selftest that can demonstrate the issue?
>
> I'll see if I can write something small and reliable.

I give up. It seems like lots of conditions have to come together to
trigger this. In production it was an application that happened to
finish global func validation with that r1 set as precise in
backtrack_state, and then proceeded to have some equivalent state
matched immediately, which triggered propagate_precision() ->
mark_chain_precision_batch(), but doing propagation of r9. Then with
this bug we were looking to propagate r1 and r9, but the code path
under verification didn't have any instruction touching r1 until we
bubbled back up to helper call instruction, where verifier complained
about r1 being required to be precise right after helper call (which
is illegal, as r1-r5 are clobbered).

Few simple tests I tried failed to set up all the necessary conditions
to trigger this in the exact sequence necessary. The fix is simple and
well understood, I'd vote for landing it, given crafting a test is
highly non-trivial.

