Return-Path: <bpf+bounces-29-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECF16F77CC
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 23:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1D81C214CE
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 21:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9373EC131;
	Thu,  4 May 2023 21:10:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F488156FC
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 21:10:22 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E862714363
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 14:10:18 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1aaf91ae451so9106975ad.1
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 14:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683234618; x=1685826618;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HYYQKfrsQp4V86BmxlykKO1KPs3cEfV/decr0o6U0CY=;
        b=YU8qw8GsdOnYBXysSCrMPxFXIlVX+hwVJmzzhEDv154Pnv+L7Ta1rlGkmSnPAnCgC0
         itiZLF8JgnVDwdRpIbFBoy43lDjyFEAWUwfnYSL7fQHViub/e8V2XibAEnNLgLohQBeh
         I/SCulxwmhsxPg2bKmExu9ArzirBHLbnbt41gASYP6ZEIFbIINTKDHJHvS+jdjZLZRSG
         3r3eWpNXiMxqGniDihA3DUIjw9rcLvzFRqyEr2gAwlARNcT3z3Co8tvQeb0IVpKCadqX
         78T8Us7wz/3Uylf1ek0cjsbHkJEgFq07CPzHiJfD957uUQV+h5DDGqgw16XTNI+KCGVJ
         GNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683234618; x=1685826618;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HYYQKfrsQp4V86BmxlykKO1KPs3cEfV/decr0o6U0CY=;
        b=iv9zusF4+ce73evTPItifg8zHFn0B7eZNab9XCjaXFa26AmwIGsBYEih+VqZYdF7eH
         hnjbfEkXymKLFJvnZFhARKSo6SKGhmPvGerv4S6WfFSzwj4u/2ayg6bgSzFrQSylLIdp
         z/qNXXDrGphC5JQlLI/CQjUEbFA8cxpxY0PNX1KRiuBRklHE5XZUklRtM4+x81qUanuS
         wmYM6uEscpw3bz/1Y7Z0gT51Zc/DbU2UPrAkFr1pMNPuO9M5BqEaidBpg7FxlveBtCXj
         lQMu0KIJJtk7bdhBkGJEIo1k4jttrUFrlDYl+OrcS/wQiIMs+Om4rUAqr1z3V9XnA3/6
         Uv4w==
X-Gm-Message-State: AC+VfDyJz1yvs+5hvqH/CyDUpkFysKwfnxye/T1Jt6ZWkYCniW2wNs/D
	v/Ec9JIjWKNJBV0WiZuq2CU=
X-Google-Smtp-Source: ACHHUZ4svweVHdj+G/AFfIm8oD2DmzjHsP6gwUfbgGl78LS75K4EvLNtjYxw1/51ucTkWpiX3JFeew==
X-Received: by 2002:a17:902:f54e:b0:1a6:be37:22e1 with SMTP id h14-20020a170902f54e00b001a6be3722e1mr6141549plf.15.1683234618350;
        Thu, 04 May 2023 14:10:18 -0700 (PDT)
Received: from MacBook-Pro-6.local ([2620:10d:c090:500::6:168f])
        by smtp.gmail.com with ESMTPSA id z31-20020a630a5f000000b0052873a7cecesm144796pgk.0.2023.05.04.14.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 14:10:17 -0700 (PDT)
Date: Thu, 4 May 2023 14:10:15 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next 05/10] bpf: maintain bitmasks across all active
 frames in __mark_chain_precision
Message-ID: <20230504211015.a2yewhi73ehtjy7w@MacBook-Pro-6.local>
References: <20230425234911.2113352-1-andrii@kernel.org>
 <20230425234911.2113352-6-andrii@kernel.org>
 <20230504030730.expcb6z4w2l5buna@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CAEf4BzaUaniRdknKgCFODZCXOH=ADB7XyL=5Q4EoZD7KgRnuxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaUaniRdknKgCFODZCXOH=ADB7XyL=5Q4EoZD7KgRnuxA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 04, 2023 at 01:50:29PM -0700, Andrii Nakryiko wrote:
> On Wed, May 3, 2023 at 8:07 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Apr 25, 2023 at 04:49:06PM -0700, Andrii Nakryiko wrote:
> > > Teach __mark_chain_precision logic to maintain register/stack masks
> > > across all active frames when going from child state to parent state.
> > > Currently this should be mostly no-op, as precision backtracking usually
> > > bails out when encountering subprog entry/exit.
> > >
> > > It's not very apparent from the diff due to increased indentation, but
> > > the logic remains the same, except everything is done on specific `fr`
> > > frame index. Calls to bt_clear_reg() and bt_clear_slot() are replaced
> > > with frame-specific bt_clear_frame_reg() and bt_clear_frame_slot(),
> > > where frame index is passed explicitly, instead of using current frame
> > > number.
> > >
> > > We also adjust logging to emit affected frame number. And we also add
> > > better logging of human-readable register and stack slot masks, similar
> > > to previous patch.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  kernel/bpf/verifier.c                         | 101 ++++++++++--------
> > >  .../testing/selftests/bpf/verifier/precise.c  |  18 ++--
> > >  2 files changed, 63 insertions(+), 56 deletions(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 8faf9170acf0..0b19b3d9af65 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -3703,7 +3703,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
> > >       struct bpf_func_state *func;
> > >       struct bpf_reg_state *reg;
> > >       bool skip_first = true;
> > > -     int i, err;
> > > +     int i, fr, err;
> > >
> > >       if (!env->bpf_capable)
> > >               return 0;
> > > @@ -3812,56 +3812,63 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
> > >               if (!st)
> > >                       break;
> > >
> > > -             func = st->frame[frame];
> > > -             bitmap_from_u64(mask, bt_reg_mask(bt));
> > > -             for_each_set_bit(i, mask, 32) {
> > > -                     reg = &func->regs[i];
> > > -                     if (reg->type != SCALAR_VALUE) {
> > > -                             bt_clear_reg(bt, i);
> > > -                             continue;
> > > +             for (fr = bt->frame; fr >= 0; fr--) {
> >
> > I'm lost.
> > 'frame' arg is now unused and the next patch passes -1 into it anyway?
> 
> Patch #3 has `bt_init(bt, frame);` which sets bt->frame = frame, so
> since patch #3 we maintain a real frame number, it's just that the
> rest of backtrack_insn() logic makes sure we never change frame (which
> is why there should be no detectable change in behavior). Only in
> patch #8 I add inter-frame bits propagation and generally changing
> frame number with going into/out of subprog.

Got it, but then remove 'frame' arg in this patch too, since it's unused
here and anything passed into it the later patches is also ignored.

