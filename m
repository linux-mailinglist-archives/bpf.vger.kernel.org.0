Return-Path: <bpf+bounces-28-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6461F6F77CA
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 23:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B681C21426
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 21:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3161FC12E;
	Thu,  4 May 2023 21:08:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1E9156C7
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 21:08:57 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A6E1493C
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 14:08:56 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1aaff9c93a5so6997425ad.2
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 14:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683234536; x=1685826536;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CSrtxoiWSzz+nli3KgBaerC/iOnk8e3RYGOINnRN5U8=;
        b=oYLrCH7TqpX3s7hDqjxu2zNHQO2GjqKtcjVzj/TEyB00tJdXGRO5uCNZEfd0TDIYZB
         xn4aRCWlHNi+M2Gt0ykHq7o2xrsWkR5r04sA4ktQ3evFp3V2l3a9iKgAqRt1MSE+KXWe
         fA6CYVcJxy7O0mYpwblqHcq4BcbZ9wP5BXNNzxmc2ofp1I2JaRM8ea7oAx8aAtHwM5wN
         T1KXXuGummWJsMmvlWvhaI1+W3mIUYe/jd42Lwa8rcSo42Ok7+RpI1jjrfzPkOGQ1vK3
         0p3n/iw0P6xm042UzA252dRAAeo2gNnpaoafRQuGnFXEfnbXf9eD97S4Qlj8t5CbadeM
         ChHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683234536; x=1685826536;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSrtxoiWSzz+nli3KgBaerC/iOnk8e3RYGOINnRN5U8=;
        b=Yr48niYD+qcqdZazJoh/mPwLQRPgdV+byy4XQZx5WpGxXC4HgRirbndK5XraIUuN7D
         mb5lOI2LgDOQI3D3iBm37uvROjbRuSylhGJQINSaqBeACoKjiDaZ1i9MbczcZH676Cqp
         Zp/Zl798fBqHoFy+fkXzSK4zj2Z1qOddtWGehyOOIFCWf4pupn988xLSoKnvDGe4bGXW
         otzrVSqROJvzkzzzTNwr/+/QxyM7a/DmovVfphGf41I9hWAfEbV8ciC/HdvAf9NjEiCT
         6JbX/pyaFf/2lsEXgEBt0RvtKd0aW9GCAaacLzj3BAwV0NyHITU9jqhckD6Qv7SuDjtp
         GFJw==
X-Gm-Message-State: AC+VfDzeKpgmz6opLGF40QiGWNz4PNbY5A5ToI78qfgzmbPvv9k4FBva
	CKHKsjO+JvjJPo0Qfr887l4=
X-Google-Smtp-Source: ACHHUZ5S8QbfPVcHsBW2dRvet8xmVDP1e3n/Wib9vlIi41/jgT7UicpXuuwaBL5CMi2OrOyhkAjwIA==
X-Received: by 2002:a17:902:8f97:b0:1a9:2c70:e1eb with SMTP id z23-20020a1709028f9700b001a92c70e1ebmr4678517plo.36.1683234535814;
        Thu, 04 May 2023 14:08:55 -0700 (PDT)
Received: from MacBook-Pro-6.local ([2620:10d:c090:500::6:168f])
        by smtp.gmail.com with ESMTPSA id c22-20020a17090ab29600b0024e49b53c24sm3444488pjr.10.2023.05.04.14.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 14:08:54 -0700 (PDT)
Date: Thu, 4 May 2023 14:08:52 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next 06/10] bpf: fix propagate_precision() logic for
 inner frames
Message-ID: <20230504210852.rzsjgz27ybrq7t4t@MacBook-Pro-6.local>
References: <20230425234911.2113352-1-andrii@kernel.org>
 <20230425234911.2113352-7-andrii@kernel.org>
 <20230504031401.pdfcnkjwke6bpjur@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CAEf4Bzauinm2cCtnFe3tqSHB3W-N-OCgJ1ihUaVeb1ETKM1ajA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzauinm2cCtnFe3tqSHB3W-N-OCgJ1ihUaVeb1ETKM1ajA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 04, 2023 at 01:57:15PM -0700, Andrii Nakryiko wrote:
> On Wed, May 3, 2023 at 8:14 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Apr 25, 2023 at 04:49:07PM -0700, Andrii Nakryiko wrote:
> > > Fix propagate_precision() logic to perform propagation of all necessary
> > > registers and stack slots across all active frames *in one batch step*.
> > >
> > > Doing this for each register/slot in each individual frame is wasteful,
> > > but the main problem is that backtracking of instruction in any frame
> > > except the deepest one just doesn't work. This is due to backtracking
> > > logic relying on jump history, and available jump history always starts
> > > (or ends, depending how you view it) in current frame. So, if
> > > prog A (frame #0) called subprog B (frame #1) and we need to propagate
> > > precision of, say, register R6 (callee-saved) within frame #0, we
> > > actually don't even know where jump history that corresponds to prog
> > > A even starts. We'd need to skip subprog part of jump history first to
> > > be able to do this.
> > >
> > > Luckily, with struct backtrack_state and __mark_chain_precision()
> > > handling bitmasks tracking/propagation across all active frames at the
> > > same time (added in previous patch), propagate_precision() can be both
> > > fixed and sped up by setting all the necessary bits across all frames
> > > and then performing one __mark_chain_precision() pass. This makes it
> > > unnecessary to skip subprog parts of jump history.
> > >
> > > We also improve logging along the way, to clearly specify which
> > > registers' and slots' precision markings are propagated within which
> > > frame.
> > >
> > > Fixes: 529409ea92d5 ("bpf: propagate precision across all frames, not just the last one")
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  kernel/bpf/verifier.c | 49 +++++++++++++++++++++++++++----------------
> > >  1 file changed, 31 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 0b19b3d9af65..66d64ac10fb1 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -3885,14 +3885,12 @@ int mark_chain_precision(struct bpf_verifier_env *env, int regno)
> > >       return __mark_chain_precision(env, env->cur_state->curframe, regno, -1);
> > >  }
> > >
> > > -static int mark_chain_precision_frame(struct bpf_verifier_env *env, int frame, int regno)
> > > +static int mark_chain_precision_batch(struct bpf_verifier_env *env, int frame)
> > >  {
> > > -     return __mark_chain_precision(env, frame, regno, -1);
> > > -}
> > > -
> > > -static int mark_chain_precision_stack_frame(struct bpf_verifier_env *env, int frame, int spi)
> > > -{
> > > -     return __mark_chain_precision(env, frame, -1, spi);
> > > +     /* we assume env->bt was set outside with desired reg and stack masks
> > > +      * for all frames
> > > +      */
> > > +     return __mark_chain_precision(env, frame, -1, -1);
> > >  }
> > >
> > >  static bool is_spillable_regtype(enum bpf_reg_type type)
> > > @@ -15308,20 +15306,25 @@ static int propagate_precision(struct bpf_verifier_env *env,
> > >       struct bpf_reg_state *state_reg;
> > >       struct bpf_func_state *state;
> > >       int i, err = 0, fr;
> > > +     bool first;
> > >
> > >       for (fr = old->curframe; fr >= 0; fr--) {
> > >               state = old->frame[fr];
> > >               state_reg = state->regs;
> > > +             first = true;
> > >               for (i = 0; i < BPF_REG_FP; i++, state_reg++) {
> > >                       if (state_reg->type != SCALAR_VALUE ||
> > >                           !state_reg->precise ||
> > >                           !(state_reg->live & REG_LIVE_READ))
> > >                               continue;
> > > -                     if (env->log.level & BPF_LOG_LEVEL2)
> > > -                             verbose(env, "frame %d: propagating r%d\n", fr, i);
> > > -                     err = mark_chain_precision_frame(env, fr, i);
> > > -                     if (err < 0)
> > > -                             return err;
> > > +                     if (env->log.level & BPF_LOG_LEVEL2) {
> > > +                             if (first)
> > > +                                     verbose(env, "frame %d: propagating r%d", fr, i);
> > > +                             else
> > > +                                     verbose(env, ",r%d", i);
> > > +                     }
> > > +                     bt_set_frame_reg(&env->bt, fr, i);
> > > +                     first = false;
> > >               }
> > >
> > >               for (i = 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
> > > @@ -15332,14 +15335,24 @@ static int propagate_precision(struct bpf_verifier_env *env,
> > >                           !state_reg->precise ||
> > >                           !(state_reg->live & REG_LIVE_READ))
> > >                               continue;
> > > -                     if (env->log.level & BPF_LOG_LEVEL2)
> > > -                             verbose(env, "frame %d: propagating fp%d\n",
> > > -                                     fr, (-i - 1) * BPF_REG_SIZE);
> > > -                     err = mark_chain_precision_stack_frame(env, fr, i);
> > > -                     if (err < 0)
> > > -                             return err;
> > > +                     if (env->log.level & BPF_LOG_LEVEL2) {
> > > +                             if (first)
> > > +                                     verbose(env, "frame %d: propagating fp%d",
> > > +                                             fr, (-i - 1) * BPF_REG_SIZE);
> > > +                             else
> > > +                                     verbose(env, ",fp%d", (-i - 1) * BPF_REG_SIZE);
> > > +                     }
> > > +                     bt_set_frame_slot(&env->bt, fr, i);
> > > +                     first = false;
> > >               }
> > > +             if (!first)
> > > +                     verbose(env, "\n");
> > >       }
> > > +
> > > +     err = mark_chain_precision_batch(env, old->curframe);
> >
> > The optimization makes sense, sort-of, but 'first' flag is to separate frames on
> > different lines ?
> 
> Yes, first is purely for formatting. Each frame will have a separate
> line, but all registers and stack frames for that frame will be on
> that single line, like so:
> 
> frame 1: propagating r1,r2,r3,fp-8,fp-16
> frame 0: propagating r3,r9,fp-120

I see. The example of the output helped a lot.
Now the code makes sense. Pls include it in a commit or a comment.

