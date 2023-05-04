Return-Path: <bpf+bounces-27-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E58C6F7795
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 22:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ACBD1C2142C
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 20:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E91A156FC;
	Thu,  4 May 2023 20:58:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D347C
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 20:58:47 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6DA11576
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 13:58:20 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-958bb7731a9so172142566b.0
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 13:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683233847; x=1685825847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcAY7sqolL1Hw7iZwoMdp6sMSde2Fu6R51CkjRCZVOs=;
        b=mrURztLKFoAO2bJ24+/c015Xca6z66YedjAU1Ab79zkCkCwNS1gcHPFdeYuMO8zLm/
         mQgwL4UmLPHsQwFR1arGsXsNcGW/PqIu704/Qfoj9OcMvdavMMLXucWqqDdCgEzWvZxE
         42b8Nxn85+4ps8MLbRsQnStCwt0q7mf+FBYFpW2kbyZz6WI1RSJOlsdsaE/5VYpMHGVW
         InMf9yON3VnBXVEPtIdcrWNiIIfDWluBwlgPzlIFr/JWG745nn2pu78OKJPipLPZWN0B
         gA5G5dJeH9CAniL1+dpBby8/mlcd3vC3Bjhu0wgaPt/pQadCMN8qMr8L6LWyb8MXKTSk
         onSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683233847; x=1685825847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcAY7sqolL1Hw7iZwoMdp6sMSde2Fu6R51CkjRCZVOs=;
        b=WszaF0UHqzxTlBClv8CFjz/IOxx7Q9ClFNFbGeKwrY4/R1Vco3Clyz0ZvB9AoWCuTt
         C/i47/Lzw/p9ezCMcUxMLYEfn8AspSLhDoKehSLcA0nAGt2jX7VBiNDHPf67Tm35BWCV
         dF+rz2zADUIrQlKYKpU3pyiZWj2BqMrzz/aXlVfVV+JQqGl64bq/u7dde8dG8Bv5jm9N
         sit/5AYwfIbzvDWlErETqBSMp01obzIcWhJm+FFeAEPGjuZU6Fd7SWwokwBaN7G6revR
         VFBF+kDpjQmPEfcdLLWbzyrOT2CGiLMuyyv4k5fJeTshvPpCLXK3SUkZDxcJlYUUoTgM
         YrNA==
X-Gm-Message-State: AC+VfDw2+5hsSzANZR07OsZdVB91O6YT18OLbw2qKreDWr1EMAoOkxtn
	sUGuwSxZh181P0M6ETkMlcM7goqWpzPEZMdjTJs=
X-Google-Smtp-Source: ACHHUZ4OtXNqW3eJEAasC26o+4l2uBCxGgq2rW7SdkFoMkxD2zWsaa/u0jXslMYeIoI6/y03aYoxVjoPsOH9NO3BJoY=
X-Received: by 2002:a17:907:6d09:b0:961:8d21:a471 with SMTP id
 sa9-20020a1709076d0900b009618d21a471mr145516ejc.58.1683233846999; Thu, 04 May
 2023 13:57:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230425234911.2113352-1-andrii@kernel.org> <20230425234911.2113352-7-andrii@kernel.org>
 <20230504031401.pdfcnkjwke6bpjur@dhcp-172-26-102-232.dhcp.thefacebook.com>
In-Reply-To: <20230504031401.pdfcnkjwke6bpjur@dhcp-172-26-102-232.dhcp.thefacebook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 May 2023 13:57:15 -0700
Message-ID: <CAEf4Bzauinm2cCtnFe3tqSHB3W-N-OCgJ1ihUaVeb1ETKM1ajA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 06/10] bpf: fix propagate_precision() logic for
 inner frames
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 3, 2023 at 8:14=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 25, 2023 at 04:49:07PM -0700, Andrii Nakryiko wrote:
> > Fix propagate_precision() logic to perform propagation of all necessary
> > registers and stack slots across all active frames *in one batch step*.
> >
> > Doing this for each register/slot in each individual frame is wasteful,
> > but the main problem is that backtracking of instruction in any frame
> > except the deepest one just doesn't work. This is due to backtracking
> > logic relying on jump history, and available jump history always starts
> > (or ends, depending how you view it) in current frame. So, if
> > prog A (frame #0) called subprog B (frame #1) and we need to propagate
> > precision of, say, register R6 (callee-saved) within frame #0, we
> > actually don't even know where jump history that corresponds to prog
> > A even starts. We'd need to skip subprog part of jump history first to
> > be able to do this.
> >
> > Luckily, with struct backtrack_state and __mark_chain_precision()
> > handling bitmasks tracking/propagation across all active frames at the
> > same time (added in previous patch), propagate_precision() can be both
> > fixed and sped up by setting all the necessary bits across all frames
> > and then performing one __mark_chain_precision() pass. This makes it
> > unnecessary to skip subprog parts of jump history.
> >
> > We also improve logging along the way, to clearly specify which
> > registers' and slots' precision markings are propagated within which
> > frame.
> >
> > Fixes: 529409ea92d5 ("bpf: propagate precision across all frames, not j=
ust the last one")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/bpf/verifier.c | 49 +++++++++++++++++++++++++++----------------
> >  1 file changed, 31 insertions(+), 18 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 0b19b3d9af65..66d64ac10fb1 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -3885,14 +3885,12 @@ int mark_chain_precision(struct bpf_verifier_en=
v *env, int regno)
> >       return __mark_chain_precision(env, env->cur_state->curframe, regn=
o, -1);
> >  }
> >
> > -static int mark_chain_precision_frame(struct bpf_verifier_env *env, in=
t frame, int regno)
> > +static int mark_chain_precision_batch(struct bpf_verifier_env *env, in=
t frame)
> >  {
> > -     return __mark_chain_precision(env, frame, regno, -1);
> > -}
> > -
> > -static int mark_chain_precision_stack_frame(struct bpf_verifier_env *e=
nv, int frame, int spi)
> > -{
> > -     return __mark_chain_precision(env, frame, -1, spi);
> > +     /* we assume env->bt was set outside with desired reg and stack m=
asks
> > +      * for all frames
> > +      */
> > +     return __mark_chain_precision(env, frame, -1, -1);
> >  }
> >
> >  static bool is_spillable_regtype(enum bpf_reg_type type)
> > @@ -15308,20 +15306,25 @@ static int propagate_precision(struct bpf_ver=
ifier_env *env,
> >       struct bpf_reg_state *state_reg;
> >       struct bpf_func_state *state;
> >       int i, err =3D 0, fr;
> > +     bool first;
> >
> >       for (fr =3D old->curframe; fr >=3D 0; fr--) {
> >               state =3D old->frame[fr];
> >               state_reg =3D state->regs;
> > +             first =3D true;
> >               for (i =3D 0; i < BPF_REG_FP; i++, state_reg++) {
> >                       if (state_reg->type !=3D SCALAR_VALUE ||
> >                           !state_reg->precise ||
> >                           !(state_reg->live & REG_LIVE_READ))
> >                               continue;
> > -                     if (env->log.level & BPF_LOG_LEVEL2)
> > -                             verbose(env, "frame %d: propagating r%d\n=
", fr, i);
> > -                     err =3D mark_chain_precision_frame(env, fr, i);
> > -                     if (err < 0)
> > -                             return err;
> > +                     if (env->log.level & BPF_LOG_LEVEL2) {
> > +                             if (first)
> > +                                     verbose(env, "frame %d: propagati=
ng r%d", fr, i);
> > +                             else
> > +                                     verbose(env, ",r%d", i);
> > +                     }
> > +                     bt_set_frame_reg(&env->bt, fr, i);
> > +                     first =3D false;
> >               }
> >
> >               for (i =3D 0; i < state->allocated_stack / BPF_REG_SIZE; =
i++) {
> > @@ -15332,14 +15335,24 @@ static int propagate_precision(struct bpf_ver=
ifier_env *env,
> >                           !state_reg->precise ||
> >                           !(state_reg->live & REG_LIVE_READ))
> >                               continue;
> > -                     if (env->log.level & BPF_LOG_LEVEL2)
> > -                             verbose(env, "frame %d: propagating fp%d\=
n",
> > -                                     fr, (-i - 1) * BPF_REG_SIZE);
> > -                     err =3D mark_chain_precision_stack_frame(env, fr,=
 i);
> > -                     if (err < 0)
> > -                             return err;
> > +                     if (env->log.level & BPF_LOG_LEVEL2) {
> > +                             if (first)
> > +                                     verbose(env, "frame %d: propagati=
ng fp%d",
> > +                                             fr, (-i - 1) * BPF_REG_SI=
ZE);
> > +                             else
> > +                                     verbose(env, ",fp%d", (-i - 1) * =
BPF_REG_SIZE);
> > +                     }
> > +                     bt_set_frame_slot(&env->bt, fr, i);
> > +                     first =3D false;
> >               }
> > +             if (!first)
> > +                     verbose(env, "\n");
> >       }
> > +
> > +     err =3D mark_chain_precision_batch(env, old->curframe);
>
> The optimization makes sense, sort-of, but 'first' flag is to separate fr=
ames on
> different lines ?

Yes, first is purely for formatting. Each frame will have a separate
line, but all registers and stack frames for that frame will be on
that single line, like so:

frame 1: propagating r1,r2,r3,fp-8,fp-16
frame 0: propagating r3,r9,fp-120

> The code in propagate_precision() before mark_chain_precision_batch()
> will only print '... propagating...' few times.
> regs and stack will be on one line anyway.
> Is it that ugly to print all frames on one line in practice?
> The 2nd and 3rd frames will be on one line too. Only 1st frame is on its =
own line?
> I'm not getting the idea of 'first'.

So the above example shows how it looks now. Same situation without
this formatting would look like:

frame 1: propagating r1
frame 1: propagating r2
frame 1: propagating r3
frame 1: propagating fp-8
frame 1: propagating fp-16
frame 0: propagating r3
frame 0: propagating r9
frame 0: propagating fp-120

I wanted to have the same formatted set of registers and stack slots,
so make it more succinct and printing entire sets of registers/stack
slots, consistent with the backtrack log format.

