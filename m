Return-Path: <bpf+bounces-13025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465E07D3C03
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 18:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664581C20A20
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 16:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D861CFAC;
	Mon, 23 Oct 2023 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7w3Mi3K"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3020A18E36
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 16:16:32 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2975FC1
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 09:16:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53d9b94731aso5460277a12.1
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 09:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698077788; x=1698682588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qosx42NeaOPmIgDoyNbbF0BF7CKum3BQ0R1L0lFYSpU=;
        b=Q7w3Mi3Ky2LVJso6Zg4OgFb+Z8mXBHF7fymb4J/3vy6PiWRZJViH9ZNqCm1RISrHP/
         4DRce73PcP2hacHw90QjVrZDrkKvTcgs0ySzgbNn8rzUe+xAIU/duSqF9JR0lHUCzVr5
         pTUNugvgpPlky6zRhhZ4SAV/gozET1nhI4LN4t+dmEKa2FiPhRZPT5imYP+cB+nCrBpr
         A7TnZiFLVHMv/UMVbJZ9mz1xzN3EYUXw4UGWB6TpGTDR1sqAYeM5zrDuHNvlfuk0B9o1
         kGP0x5AA4My4IhI3LF3oyRG/1J0CGOU6pP0el0xyZesDl365+Cn+6A2317SeNcCAIr6K
         bipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698077788; x=1698682588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qosx42NeaOPmIgDoyNbbF0BF7CKum3BQ0R1L0lFYSpU=;
        b=QMQYRHW7fpf+W3BPSJDQy9g8j1YoZonPbZltI+elcUdpzaZxu1PLb+MpDhec5rTTqs
         nUju6br3ZDC2ef2oY6JXQUu+da/3sKJqtxPiRGjIZhGE/R7BeeS3N/GECT65ptrHJOB0
         8vOBn4s+yCTTnRfykE4aNRv5oGV5RFtd2FYOBWdJj69a36dOjVkypvx8h+pU0CiWn8OX
         kzX3s9yldfbetiYRJTI7bcTowUcTli87IyPWX1nDKGkSzFL1cI7PbjaQD2gbnQh/cbQX
         uS6ZG0bazWi9oMjavRaJkyEswUPIQYxFzEWZgdyit5EQsn3EqiQklRNBe1OWz20h7vIH
         zXdQ==
X-Gm-Message-State: AOJu0YyEShyYmSEy1HE8cvLhsNDM1zwOfRny0J+T+2pwMPaJMzpp8dXm
	WNDHHUPc7tN3KQmYI2hNkypyNFv51AJRNhdMDyA=
X-Google-Smtp-Source: AGHT+IFOO0J96kf67Z/qatuHoXBxEdGNo8SLnxAlrDlbNbF2yZ9zJWCAmxCAcjqrFYTce9Rp/GpoNDZ/QVfZdVxgvlU=
X-Received: by 2002:a05:6402:3492:b0:531:1455:7528 with SMTP id
 v18-20020a056402349200b0053114557528mr5753498edc.40.1698077788319; Mon, 23
 Oct 2023 09:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231022010812.9201-1-eddyz87@gmail.com> <20231022010812.9201-6-eddyz87@gmail.com>
 <CAEf4BzZwEx3P+u+J_4P1trf6=ChQ7cQWEkDjZ2aNLQzoNhz1jA@mail.gmail.com> <ff3368b1c03468b6e67738f2745954403cbe0bc9.camel@gmail.com>
In-Reply-To: <ff3368b1c03468b6e67738f2745954403cbe0bc9.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 23 Oct 2023 09:16:16 -0700
Message-ID: <CAEf4Bzbt9MQwYsbmfMh0Eh+mkh9BejspCAZ+Fw6jrxdP=XG2QA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/7] bpf: correct loop detection for iterators convergence
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com, 
	john.fastabend@gmail.com, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 7:47=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Sat, 2023-10-21 at 21:28 -0700, Andrii Nakryiko wrote:
> > On Sat, Oct 21, 2023 at 6:08=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > It turns out that .branches > 0 in is_state_visited() is not a
> > > sufficient condition to identify if two verifier states form a loop
> > > when iterators convergence is computed. This commit adds logic to
> > > distinguish situations like below:
> > >
> > >  (I)            initial       (II)            initial
> > >                   |                             |
> > >                   V                             V
> > >      .---------> hdr                           ..
> > >      |            |                             |
> > >      |            V                             V
> > >      |    .------...                    .------..
> > >      |    |       |                     |       |
> > >      |    V       V                     V       V
> > >      |   ...     ...               .-> hdr     ..
> > >      |    |       |                |    |       |
> > >      |    V       V                |    V       V
> > >      |   succ <- cur               |   succ <- cur
> > >      |    |                        |    |
> > >      |    V                        |    V
> > >      |   ...                       |   ...
> > >      |    |                        |    |
> > >      '----'                        '----'
> > >
> > > For both (I) and (II) successor 'succ' of the current state 'cur' was
> > > previously explored and has branches count at 0. However, loop entry
> > > 'hdr' corresponding to 'succ' might be a part of current DFS path.
> > > If that is the case 'succ' and 'cur' are members of the same loop
> > > and have to be compared exactly.
> > >
> > > Co-developed-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > Co-developed-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> > >  include/linux/bpf_verifier.h |  15 +++
> > >  kernel/bpf/verifier.c        | 207 +++++++++++++++++++++++++++++++++=
+-
> > >  2 files changed, 218 insertions(+), 4 deletions(-)
> > >
> >
> > LGTM, but see the note below about state being its own loop_entry. It
> > feels like a bit better approach would be to use "loop_entry_ref_cnt"
> > instead of just a bool used_as_loop_entry, and do a proper accounting
> > when child state is freed and when propagating loop_entries. But
> > perhaps that can be done in a follow up, if you think it's a good
> > idea.
>
> I though about reference counting but decided to use flag instead
> because it's a bit simpler. In any case the full mechanism is
> opportunistic and having a few stale states shouldn't be a big deal,
> those would be freed when syscall exits.
> I'll make ref_cnt version and send it as a follow-up, so we can decide
> looking at the code whether to peek it or drop it.
>
> >
> > Reviewed-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifie=
r.h
> > > index 38b788228594..24213a99cc79 100644
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> >
> [...]
> > > @@ -16825,7 +17023,8 @@ static int is_state_visited(struct bpf_verifi=
er_env *env, int insn_idx)
> > >                          * speed up verification
> > >                          */
> > >                         *pprev =3D sl->next;
> > > -                       if (sl->state.frame[0]->regs[0].live & REG_LI=
VE_DONE) {
> > > +                       if (sl->state.frame[0]->regs[0].live & REG_LI=
VE_DONE &&
> > > +                           !sl->state.used_as_loop_entry) {
> >
> > In get_loop_entry() you have an additional `topmost !=3D
> > topmost->loop_entry` check, suggesting that state can be its own
> > loop_entry. Can that happen?
>
> It can, e.g. in the following loop:
>
>     loop: r1 =3D r10;
>           r1 +=3D -8;
>        --- checkpoint here ---
>           call %[bpf_iter_num_next];
>           goto loop;
>
>
> > And if yes, should we account for that here?
>
> With flag I don't think we need to account for it here because it's a
> best-effort thing anyways. (E.g. it misses situation when something
> was marked as loop entry initially than entry upper in DFS chain had
> been found). With reference count -- yes, it would me more important.
>

OK, no big deal, I wanted to make sure we won't leak some states, if
they are their own loop_entry.

