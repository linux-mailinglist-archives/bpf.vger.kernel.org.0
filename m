Return-Path: <bpf+bounces-10395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6117A6B07
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 21:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D21281609
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 19:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6225128E23;
	Tue, 19 Sep 2023 18:59:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FD528DA6
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 18:59:38 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0154E1
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 11:59:36 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso96859081fa.1
        for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 11:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695149975; x=1695754775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LQZ2EvR7RLB2e97bjPWCYOB0UZWwiCEV++yIC5jli0=;
        b=j94xfLaazi4p0zXYs1Q6wsSVk9kpg8PUJ79OcmPoq4JIiUMh9OBp6COfJeN5z9MBvh
         VCztP7TuHuSThk+yW6M8pI6NuGfS9aJ4FE1W7jh4NtbCzVE2+n2y6kREkpemPO844LXa
         0zjVxT9a9OpuviHKGovvDP29NmSt4yKnnJykoPWTl02SFtLiCKP/arX8M2Jx5WVhwFa4
         dNKQ65cgdGxKcxfGM1UJuoSkevFPSVcLXp11KsEgVvR6I62h4VcaNWeCCM+5JQ/AnN8y
         iaQOViXBtqO35IupWIsuMMHKdUhj3W5/+71Pe2IfB3+VPqfjaUFaEQhxz6BVyJvhUDTA
         rJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695149975; x=1695754775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LQZ2EvR7RLB2e97bjPWCYOB0UZWwiCEV++yIC5jli0=;
        b=ZRYU+ENfEsKTYo8dVr54ffybv+IJ4wmjAKKrMgiuClnWPpqZi3kgc78V23Nrt2YABT
         VrsNWSS2nnCm7Y4OAbwinlNa+Y/y01qG0P9QRayXwaqoKutxx8kmek7yRLTbgd1nKQZV
         7OAUK1IB+FWItomjerg4V5DneKzzmUwV6HEfCX3p2Xcq2FsmM9FPxfVJRr1vKhmm31Rv
         NEORSatqRUcG8iHIXL4N7yGzMoOrG2OU8DVDNJ9pjOU9HNpA9dREc6KWQ+5QD13xHtaT
         u+EIfegDk6BN+1B+LIp5ydmwN0fKD03ZNQ4fR5a2pZhI0Cj1SuyFtanjaGAVt8G5Zzbi
         ZVdQ==
X-Gm-Message-State: AOJu0YwYx2rrGrjitLDoX+ZarEFz7BvmXYuyggBtkcx2Tluw+zghS9sD
	IfgyNPei/Jp+yQJ+WspUq7pBXcPvodB0lckNAnU=
X-Google-Smtp-Source: AGHT+IEF+1L873VEUoSWJSVuY/7j7oCWJ61Ds8UcytuRv7ss4k4dUL7RsC5aJpcL6skugzO6JRoqCxgVMIeQU5jL0Qk=
X-Received: by 2002:a2e:8545:0:b0:2b5:9d2a:ab51 with SMTP id
 u5-20020a2e8545000000b002b59d2aab51mr279017ljj.5.1695149974708; Tue, 19 Sep
 2023 11:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918210110.2241458-1-andrii@kernel.org> <CAADnVQ+w4e2K06tPdV8J-TuEvY6ysGv_45PJZe2AkOpYFrx7Og@mail.gmail.com>
In-Reply-To: <CAADnVQ+w4e2K06tPdV8J-TuEvY6ysGv_45PJZe2AkOpYFrx7Og@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Sep 2023 11:59:23 -0700
Message-ID: <CAEf4BzY9_0RCfXQdPL65W182jaQ3uHo7RUEkZ3JQaOfA5NXXMg@mail.gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 2:06=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Sep 18, 2023 at 2:01=E2=80=AFPM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> >
> > In mark_chain_precision() logic, when we reach the entry to a global
> > func, it is expected that R1-R5 might be still requested to be marked
> > precise. This would correspond to some integer input arguments being
> > tracked as precise. This is all expected and handled as a special case.
> >
> > What's not expected is that we'll leave backtrack_state structure with
> > some register bits set. This is because for subsequent precision
> > propagations backtrack_state is reused without clearing masks, as all
> > code paths are carefully written in a way to leave empty backtrack_stat=
e
> > with zeroed out masks, for speed.
> >
> > The fix is trivial, we always clear register bit in the register mask, =
and
> > then, optionally, set reg->precise if register is SCALAR_VALUE type.
> >
> > Reported-by: Chris Mason <clm@meta.com>
> > Fixes: be2ef8161572 ("bpf: allow precision tracking for programs with s=
ubprogs")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/bpf/verifier.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index bb78212fa5b2..c0c7d137066a 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -4047,11 +4047,9 @@ static int __mark_chain_precision(struct bpf_ver=
ifier_env *env, int regno)
> >                                 bitmap_from_u64(mask, bt_reg_mask(bt));
> >                                 for_each_set_bit(i, mask, 32) {
> >                                         reg =3D &st->frame[0]->regs[i];
> > -                                       if (reg->type !=3D SCALAR_VALUE=
) {
> > -                                               bt_clear_reg(bt, i);
> > -                                               continue;
> > -                                       }
> > -                                       reg->precise =3D true;
> > +                                       bt_clear_reg(bt, i);
> > +                                       if (reg->type =3D=3D SCALAR_VAL=
UE)
> > +                                               reg->precise =3D true;
>
> Looks good, but is there a selftest that can demonstrate the issue?

I'll see if I can write something small and reliable.

