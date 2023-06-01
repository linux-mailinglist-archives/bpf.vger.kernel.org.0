Return-Path: <bpf+bounces-1605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A010371F064
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 19:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A358281844
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 17:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE464253A;
	Thu,  1 Jun 2023 17:13:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987A142529
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 17:13:25 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05793D1
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 10:13:23 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b1a66e71f9so9234901fa.2
        for <bpf@vger.kernel.org>; Thu, 01 Jun 2023 10:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685639601; x=1688231601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tjKsaIbTjMYKIh3fXAnApHoteE1QLOhgO5qxPHe7dY=;
        b=CSrKNVT+mI+Llpf+3j6IiQ8hGBS4zF91WzgURc1P2ySk9qHDJ3Nx3JL5eDLaU0Qk0/
         mAlo0YE6LTjBZKXLb6MTC000zKnA2QDuo32fOsr3Oz07nBGhbrFCAUSy+MrOAh22IrPL
         YUwwqzCFUbqPQV28ViQ3hk0SL6liRIs85/rqUp1HM4o85onyZgWPjU4946zKNopULFV7
         G+Ytdjd/9VtJLG5aZ0FF7/n9eGyqvkE1f1uoYkVHWOEt6NR+tnXn4kmuX8IBlz/cgX4N
         2+Q6ch5OpyU8q9hYryuE13IUUkzjeao6lGSfsK7XiwtALXiVostIl6ozzAr1m2bJ/CVh
         pckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685639601; x=1688231601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tjKsaIbTjMYKIh3fXAnApHoteE1QLOhgO5qxPHe7dY=;
        b=MnXkpPH9z66XOOrDUg17l4uu4WAIRfFa2i6sYLEM0U2rXWkqS4Q6+uQAe8mU2vBhe+
         wa2blTP+oEyLal+khOXhGwm9su5oJAhe3iJ22QDWcuTRrd+hALB7a80uJUJMJRLZzOKI
         uxFQoHyDP/ScK3frRraa5cIOjj8aymwpoBHKrKRxfFb6G/CrT+WeY5XSHjK4moO+JqLM
         Gm09dikaFybqFmsNjGWoXHG0eRTwwyReMVBC86EPbQx16GyfoaOpS0ZDhltNZnZDaBgv
         w3YVbsH3oNyZj4XHCTwMBTLHB4GkdhoOqMpiZvdrRnYNIbZylq5MtpDCerWf2oYVfNie
         dJzw==
X-Gm-Message-State: AC+VfDxAcUE8cYn8JkiQNVtxl1JylkZXm6SrH+KIhjF6Ijt0eleF500y
	Pxeb+Q96nqHiJ1+tduEISFaf9P1Gt86TwMeCMX8=
X-Google-Smtp-Source: ACHHUZ5R3N6qqjGHyDPEkgM9a0eNbpwvETj8CEery5duyuWsOfpi8eqckADb2+ewxH5OPftfrXb/XU/z9VZJVmSgzlY=
X-Received: by 2002:a2e:988a:0:b0:2af:2b8c:3455 with SMTP id
 b10-20020a2e988a000000b002af2b8c3455mr65343ljj.32.1685639600842; Thu, 01 Jun
 2023 10:13:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230530172739.447290-1-eddyz87@gmail.com> <20230530172739.447290-2-eddyz87@gmail.com>
 <CAEf4BzYJbzR0f5HyjLMJEmBdHkydQiOjdkk=K4AkXWTwnXsWEg@mail.gmail.com>
 <8b0da2244a328f23a78dc73306177ebc6f0eabfd.camel@gmail.com>
 <20230601020514.vhnlnmowbo6dxwfj@MacBook-Pro-8.local> <81e2e47c71b6a0bc014c204e18c6be2736fed338.camel@gmail.com>
In-Reply-To: <81e2e47c71b6a0bc014c204e18c6be2736fed338.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 1 Jun 2023 10:13:08 -0700
Message-ID: <CAADnVQJY4TR3hoDUyZwGxm10sBNvpLHTa_yW-T6BvbukvAoypg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 1, 2023 at 9:57=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2023-05-31 at 19:05 -0700, Alexei Starovoitov wrote:
> > [...]
> > > Suppose that current verification path is 1-7:
> > > - On a way down 1-6 r7 will not be marked as precise, because
> > >   condition (r7 > X) is not predictable (see check_cond_jmp_op());
> > > - When (7) is reached mark_chain_precision() will start moving up
> > >   marking the following registers as precise:
> > >
> > >   4: if (r6 > r7) goto +1 ; r6, r7
> > >   5: r7 =3D r6              ; r6
> > >   6: if (r7 > X) goto ... ; r6
> > >   7: r9 +=3D r6             ; r6
> > >
> > > - Thus, if checkpoint is created for (6) r7 would be marked as read,
> > >   but will not be marked as precise.
> > >
> > > Next, suppose that jump from 4 to 6 is verified and checkpoint for (6=
)
> > > is considered:
> > > - r6 is not precise, so check_ids() is not called for it and it is no=
t
> > >   added to idmap;
> > > - r7 is precise, so check_ids() is called for it, but it is a sole
> > >   register in the idmap;
> >
> > typos in above?
> > r6 is precise and r7 is not precise.
>
> Yes, it should be the other way around in the description:
> r6 precise, r7 not precise. Sorry for confusion.
>
> > > - States are considered equal.
> > >
> > > Here is the log (I added a few prints for states cache comparison):
> > >
> > >   from 10 to 13: safe
> > >     steq hit 10, cur:
> > >       R0=3Dscalar(id=3D2) R6=3Dscalar(id=3D2) R7=3Dscalar(id=3D1) R9=
=3Dfp-8 R10=3Dfp0 fp-8=3D00000000
> > >     steq hit 10, old:
> > >       R6_rD=3DPscalar(id=3D2) R7_rwD=3Dscalar(id=3D2) R9_rD=3Dfp-8 R1=
0=3Dfp0 fp-8_rD=3D00000000
> >
> > the log is correct, thouhg.
> > r6_old =3D Pscalar which will go through check_ids() successfully and b=
oth are unbounded.
> > r7_old is not precise. different id-s don't matter and different ranges=
 don't matter.
> >
> > As another potential fix...
> > can we mark_chain_precision() right at the time of R1 =3D R2 when we do
> > src_reg->id =3D ++env->id_gen
> > and copy_register_state();
> > for both regs?
>
> This won't help, e.g. for the original example precise markings would be:
>
>   4: if (r6 > r7) goto +1 ; r6, r7
>   5: r7 =3D r6              ; r6, r7
>   6: if (r7 > X) goto ... ; r6     <-- mark for r7 is still missing
>   7: r9 +=3D r6             ; r6

Because 6 is a new state and we do mark_all_scalars_imprecise() after 5 ?

> What might help is to call mark_chain_precision() from
> find_equal_scalars(), but I expect this to be very expensive.

maybe worth giving it a shot?

> > I think
> > if (rold->precise && !check_ids(rold->id, rcur->id, idmap))
> > would be good property to have.
> > I don't like u32_hashset either.
> > It's more or less saying that scalar id-s are incompatible with precisi=
on.
> >
> > I hope we don't need to do:
> > +       u32 reg_ids[MAX_CALL_FRAMES];
> > for backtracking either.
> > Hacking id-s into jmp history is equally bad.
> >
> > Let's figure out a minimal fix.
>
> Solution discussed with Andrii yesterday seems to work.

The thread is long. Could you please describe it again in pseudo code?

> There is still a performance regression, but much less severe:
>
> $ ./veristat -e file,prog,states -f "states_pct>5" -C master-baseline.log=
 current.log
> File                      Program                         States (A)  Sta=
tes (B)  States     (DIFF)
> ------------------------  ------------------------------  ----------  ---=
-------  -----------------
> bpf_host.o                cil_to_host                            188     =
    198       +10 (+5.32%)
> bpf_host.o                tail_handle_ipv4_from_host             225     =
    243       +18 (+8.00%)
> bpf_host.o                tail_ipv6_host_policy_ingress           98     =
    104        +6 (+6.12%)
> bpf_xdp.o                 tail_handle_nat_fwd_ipv6               648     =
    806     +158 (+24.38%)
> bpf_xdp.o                 tail_lb_ipv4                          2491     =
   2930     +439 (+17.62%)
> bpf_xdp.o                 tail_nodeport_nat_egress_ipv4          749     =
    868     +119 (+15.89%)
> bpf_xdp.o                 tail_nodeport_nat_ingress_ipv4         375     =
    477     +102 (+27.20%)
> bpf_xdp.o                 tail_rev_nodeport_lb4                  398     =
    486      +88 (+22.11%)
> loop6.bpf.o               trace_virtqueue_add_sgs                226     =
    251      +25 (+11.06%)
> pyperf600.bpf.o           on_event                             22200     =
  45095  +22895 (+103.13%)
> pyperf600_nounroll.bpf.o  on_event                             34169     =
  37235     +3066 (+8.97%)
>
> I need to add a bunch of tests and take a look at pyperf600.bpf.o
> before submitting next patch-set version.

Great. Looking forward.

