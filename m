Return-Path: <bpf+bounces-42733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0A99A96F6
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 05:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687EF1F27032
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 03:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB82815A84A;
	Tue, 22 Oct 2024 03:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCloffDC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA05F13B5B7
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 03:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729567188; cv=none; b=Sn5ZXnq7hCd5FxdJqrPIglBTW0UZx/0n961Yb7/xa30iuyinpd+czLguH2cAqf4fjIW8CFeKOmAPWwC4uy64rtbaU5zme5R+5MxxhbGGc1QPBr0i39Vl+gnbtuCIcAz9WHaOnDsWs23IwQVcI4fRhV/aPBff7jp4lco9RNUG/34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729567188; c=relaxed/simple;
	bh=kyuv8mtQno4ueanNj2PWKbkz8vr2m3NgLjfA5CVjhHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OcW0WtM/dx0GRSt7ZeheTq2nB7cVCnEN6Gn8DKLa5tJpYJ6WVrHWFEIFo1yp6/8g2qdMvARcEsEEYHvIgOc65peTRfyWRxTvq3ISgXMXQNL0POnWlf5TUz0sSbEd5f7lKYepf/AMW9CfN4bdC3ERLpJ4OnTYzaoXbZs872A9Tho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCloffDC; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7163489149eso3922271a12.1
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 20:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729567185; x=1730171985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVIri3wTzURkjdj60j/xh3E1ErhTgpRkJnqjt+RY1FM=;
        b=nCloffDCnFXi8Heh/HZmvpoP/sKxR+ZY0Ma7DRu4ntI/YB5HRDJEbEVIeR5i56wBrH
         /2el4+XFmdWH5qgu4uIEHjt+afP+TB6JGnq6UNl1X99eG33szA/0HlfzWHWZjYNQ8xs3
         +HEttocqKoWU//rH/+UzDIR4PCDPgaULZHWnoP41L3bccx8mJKTTz6wcY0/9ak63bZOv
         kEOhvYaiVqPIdaoT2zW9+oSiiHHkP443Tzxy4j55Tovy9hBHgMLBoN0Np3h3xsJmdw9j
         ElFY3opJU2bqKDU737xZc//ufjnhGCWlKpHyAbpAW2o0b60cbdMQJ0R1rWxJUSslF8lt
         WAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729567185; x=1730171985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVIri3wTzURkjdj60j/xh3E1ErhTgpRkJnqjt+RY1FM=;
        b=HSPnh30XdEFh9cU9nySGlDSCWLynSICK54zfUULE85I71Ne0tUNlojQLbCmlBSzWzT
         6faGQ0oYS2KhkinAz+TJVW99kHrRhUW55rp7s1dXgr3YP1rnscGTpmGEbhV9SJY+oU+R
         LsHbkfKMGe9RYAFxypddzPUrFkvW1H+hrFdx7lSnv95j70vXozHsUr6gLwrIzD9OraUY
         NIybjKvdp0+hklflhBJfgQ7zCbirjeTuU7CFQQZbaIRB+N78gbLQwEftsWb39Df4uhgP
         y4Dfy/6eKy+deoIOhPtgqim2klYCxqSXua2nV++lgGG+vLsRCFPhQzmNEIvy7V9FsTyO
         7Gqw==
X-Forwarded-Encrypted: i=1; AJvYcCVNBPrGfpQA7Rd5jm1PDyAY+YwGwhbh6935ZdO0Rqeah66qsRk/5pugvDTlwEFMgV7Qwz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAHomvpdT9rOpChi9yGI+6VmyqcgSfBKILoeERuYcZne9cCjK/
	JgntqUQSRrGNrUpmIZoxWLH/Nyqy9IppZvPWOE/LKqJIk1URiu/Jc/AUovurTehMSK0j3UurDXo
	qTZenQpcS89Hp6wPkvaoRUyR0pe2+ChAd
X-Google-Smtp-Source: AGHT+IFRbSVGNNbD6aWNQk4Sxp2vtsnY0tk3uPNkpWbF+Gd+jVq4DWcM9vdcesFpC/dgVzQVqKBOsHDTE5mQDtJtB98=
X-Received: by 2002:a05:6a20:ac43:b0:1d8:b962:6087 with SMTP id
 adf61e73a8af0-1d92c4bad75mr20673287637.10.1729567184777; Mon, 21 Oct 2024
 20:19:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018020307.1766906-1-eddyz87@gmail.com> <CAEf4BzavO=EX45+rGdL3PPHS+ba-SKp_VvE6c8zUYmcvjYXP3Q@mail.gmail.com>
 <CAADnVQKd3hgtK1zi3DgSYqDR_NFU1OKWxeXph+reKzXHO9hxGw@mail.gmail.com>
In-Reply-To: <CAADnVQKd3hgtK1zi3DgSYqDR_NFU1OKWxeXph+reKzXHO9hxGw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 21 Oct 2024 20:19:32 -0700
Message-ID: <CAEf4BzbMbmhCATfe21LgGXsCPaYLFgR3sNqkGw-eVcGn1wjB2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: force checkpoint when jmp history is
 too long
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 7:03=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Oct 21, 2024 at 1:23=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Oct 17, 2024 at 7:03=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > A specifically crafted program might trick verifier into growing very
> > > long jump history within a single bpf_verifier_state instance.
> > > Very long jump history makes mark_chain_precision() unreasonably slow=
,
> > > especially in case if verifier processes a loop.
> > >
> > > Mitigate this by forcing new state in is_state_visited() in case if
> > > current state's jump history is too long.
> > >
> > > Use same constant as in `skip_inf_loop_check`, but multiply it by
> > > arbitrarily chosen value 2 to account for jump history containing not
> > > only information about jumps, but also information about stack access=
.
> > >
> > > For an example of problematic program consider the code below,
> > > w/o this patch the example is processed by verifier for ~15 minutes,
> > > before failing to allocate big-enough chunk for jmp_history.
> > >
> > >     0: r7 =3D *(u16 *)(r1 +0);"
> > >     1: r7 +=3D 0x1ab064b9;"
> > >     2: if r7 & 0x702000 goto 1b;
> > >     3: r7 &=3D 0x1ee60e;"
> > >     4: r7 +=3D r1;"
> > >     5: if r7 s> 0x37d2 goto +0;"
> > >     6: r0 =3D 0;"
> > >     7: exit;"
> > >
> > > Perf profiling shows that most of the time is spent in
> > > mark_chain_precision() ~95%.
> > >
> > > The easiest way to explain why this program causes problems is to
> > > apply the following patch:
> > >
> > >     diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > >     index 0c216e71cec7..4b4823961abe 100644
> > >     \--- a/include/linux/bpf.h
> > >     \+++ b/include/linux/bpf.h
> > >     \@@ -1926,7 +1926,7 @@ struct bpf_array {
> > >             };
> > >      };
> > >
> > >     -#define BPF_COMPLEXITY_LIMIT_INSNS      1000000 /* yes. 1M insns=
 */
> > >     +#define BPF_COMPLEXITY_LIMIT_INSNS      256 /* yes. 1M insns */
> > >      #define MAX_TAIL_CALL_CNT 33
> > >
> > >      /* Maximum number of loops for bpf_loop and bpf_iter_num.
> > >     diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > >     index f514247ba8ba..75e88be3bb3e 100644
> > >     \--- a/kernel/bpf/verifier.c
> > >     \+++ b/kernel/bpf/verifier.c
> > >     \@@ -18024,8 +18024,13 @@ static int is_state_visited(struct bpf_=
verifier_env *env, int insn_idx)
> > >      skip_inf_loop_check:
> > >                             if (!force_new_state &&
> > >                                 env->jmps_processed - env->prev_jmps_=
processed < 20 &&
> > >     -                           env->insn_processed - env->prev_insn_=
processed < 100)
> > >     +                           env->insn_processed - env->prev_insn_=
processed < 100) {
> > >     +                               verbose(env, "is_state_visited: s=
uppressing checkpoint at %d, %d jmps processed, cur->jmp_history_cnt is %d\=
n",
> > >     +                                       env->insn_idx,
> > >     +                                       env->jmps_processed - env=
->prev_jmps_processed,
> > >     +                                       cur->jmp_history_cnt);
> > >                                     add_new_state =3D false;
> > >     +                       }
> > >                             goto miss;
> > >                     }
> > >                     /* If sl->state is a part of a loop and this loop=
's entry is a part of
> > >     \@@ -18142,6 +18147,9 @@ static int is_state_visited(struct bpf_v=
erifier_env *env, int insn_idx)
> > >             if (!add_new_state)
> > >                     return 0;
> > >
> > >     +       verbose(env, "is_state_visited: new checkpoint at %d, res=
etting env->jmps_processed\n",
> > >     +               env->insn_idx);
> > >     +
> > >             /* There were no equivalent states, remember the current =
one.
> > >              * Technically the current state is not proven to be safe=
 yet,
> > >              * but it will either reach outer most bpf_exit (which me=
ans it's safe)
> > >
> > > And observe verification log:
> > >
> > >     ...
> > >     is_state_visited: new checkpoint at 5, resetting env->jmps_proces=
sed
> > >     5: R1=3Dctx() R7=3Dctx(...)
> > >     5: (65) if r7 s> 0x37d2 goto pc+0     ; R7=3Dctx(...)
> > >     6: (b7) r0 =3D 0                        ; R0_w=3D0
> > >     7: (95) exit
> > >
> > >     from 5 to 6: R1=3Dctx() R7=3Dctx(...) R10=3Dfp0
> > >     6: R1=3Dctx() R7=3Dctx(...) R10=3Dfp0
> > >     6: (b7) r0 =3D 0                        ; R0_w=3D0
> > >     7: (95) exit
> > >     is_state_visited: suppressing checkpoint at 1, 3 jmps processed, =
cur->jmp_history_cnt is 74
> > >
> > >     from 2 to 1: R1=3Dctx() R7_w=3Dscalar(...) R10=3Dfp0
> > >     1: R1=3Dctx() R7_w=3Dscalar(...) R10=3Dfp0
> > >     1: (07) r7 +=3D 447767737
> > >     is_state_visited: suppressing checkpoint at 2, 3 jmps processed, =
cur->jmp_history_cnt is 75
> > >     2: R7_w=3Dscalar(...)
> > >     2: (45) if r7 & 0x702000 goto pc-2
> > >     ... mark_precise 152 steps for r7 ...
> > >     2: R7_w=3Dscalar(...)
> > >     is_state_visited: suppressing checkpoint at 1, 4 jmps processed, =
cur->jmp_history_cnt is 75
> > >     1: (07) r7 +=3D 447767737
> > >     is_state_visited: suppressing checkpoint at 2, 4 jmps processed, =
cur->jmp_history_cnt is 76
> > >     2: R7_w=3Dscalar(...)
> > >     2: (45) if r7 & 0x702000 goto pc-2
> > >     ...
> > >     BPF program is too large. Processed 257 insn
> > >
> > > The log output shows that checkpoint at label (1) is never created,
> > > because it is suppressed by `skip_inf_loop_check` logic:
> > > a. When 'if' at (2) is processed it pushes a state with insn_idx (1)
> > >    onto stack and proceeds to (3);
> > > b. At (5) checkpoint is created, and this resets
> > >    env->{jmps,insns}_processed.
> > > c. Verification proceeds and reaches `exit`;
> > > d. State saved at step (a) is popped from stack and is_state_visited(=
)
> > >    considers if checkpoint needs to be added, but because
> > >    env->{jmps,insns}_processed had been just reset at step (b)
> > >    the `skip_inf_loop_check` logic forces `add_new_state` to false.
> > > e. Verifier proceeds with current state, which slowly accumulates
> > >    more and more entries in the jump history.
> > >
> > > The accumulation of entries in the jump history is a problem because
> > > of two factors:
> > > - it eventually exhausts memory available for kmalloc() allocation;
> > > - mark_chain_precision() traverses the jump history of a state,
> > >   meaning that if `r7` is marked precise, verifier would iterate
> > >   ever growing jump history until parent state boundary is reached.
> > >
> > > (note: the log also shows a REG INVARIANTS VIOLATION warning
> > >        upon jset processing, but that's another bug to fix).
> > >
> > > With this patch applied, the example above is rejected by verifier
> > > under 1s of time, reaching 1M instructions limit.
> > >
> > > The program is a simplified reproducer from syzbot report [1].
> > > Previous discussion could be found at [2].
> > > The patch does not cause any changes in verification performance,
> > > when tested on selftests from veristat.cfg and cilium programs taken
> > > from [3].
> > >
> > > [1] https://lore.kernel.org/bpf/670429f6.050a0220.49194.0517.GAE@goog=
le.com/
> > > [2] https://lore.kernel.org/bpf/20241009021254.2805446-1-eddyz87@gmai=
l.com/
> > > [3] https://github.com/anakryiko/cilium
> > >
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> > >  kernel/bpf/verifier.c | 14 ++++++++++++--
> > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index f514247ba8ba..f64c831a9278 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -17873,13 +17873,23 @@ static bool iter_active_depths_differ(struc=
t bpf_verifier_state *old, struct bpf
> > >         return false;
> > >  }
> > >
> > > +#define MAX_JMPS_PER_STATE 20
> > > +
> > >  static int is_state_visited(struct bpf_verifier_env *env, int insn_i=
dx)
> > >  {
> > >         struct bpf_verifier_state_list *new_sl;
> > >         struct bpf_verifier_state_list *sl, **pprev;
> > >         struct bpf_verifier_state *cur =3D env->cur_state, *new, *loo=
p_entry;
> > >         int i, j, n, err, states_cnt =3D 0;
> > > -       bool force_new_state =3D env->test_state_freq || is_force_che=
ckpoint(env, insn_idx);
> > > +       bool force_new_state =3D env->test_state_freq || is_force_che=
ckpoint(env, insn_idx) ||
> > > +                              /* - Long jmp history hinders mark_cha=
in_precision performance,
> > > +                               *   so force new state if jmp history=
 of current state exceeds
> > > +                               *   a threshold.
> > > +                               * - Jmp history records not only jump=
s, but also stack access,
> > > +                               *   so keep this constant 2x times th=
e limit imposed on
> > > +                               *   env->jmps_processed for loop case=
s (see skip_inf_loop_check).
> > > +                               */
> > > +                              cur->jmp_history_cnt > MAX_JMPS_PER_ST=
ATE * 2;
> >
> > this feels like a wrong place to add this heuristic. Just few lines
> > below there is:
> >
> >
> > if (env->jmps_processed - env->prev_jmps_processed >=3D 2 &&
> >     env->insn_processed - env->prev_insn_processed >=3D 8)
> >         add_new_state =3D true;
> >
> > Please add jmp_history_cnt check here, as it conceptually fits with
> > jmps_processed and insn_processed check. It also has a huge comment
> > with justification already, so might as well just extend that for
> > jmp_history_cnt.
>
> I think adding if (cur->jmp_history_cnt > 20) add_new_state =3D true;
> won't help. It will get back to false.
> But I agree that tweaking force_new_state also is not quite clean.
>
> btw the "huge comment" may need to be revised :)
> bpf progs today probably look different than they were in 2019.
>
> >
> > pw-bot: cr
> >
> > >         bool add_new_state =3D force_new_state;
> > >         bool force_exact;
> > >
> > > @@ -18023,7 +18033,7 @@ static int is_state_visited(struct bpf_verifi=
er_env *env, int insn_idx)
> > >                          */
> > >  skip_inf_loop_check:
> > >                         if (!force_new_state &&
> > > -                           env->jmps_processed - env->prev_jmps_proc=
essed < 20 &&
> > > +                           env->jmps_processed - env->prev_jmps_proc=
essed < MAX_JMPS_PER_STATE &&
> > >                             env->insn_processed - env->prev_insn_proc=
essed < 100)
> > >                                 add_new_state =3D false;
> >
> > and then this one is logically matching add_new_state =3D true; case
> > above that I mentioned.
> >
> >
> > With these changes, I'd drop * 2 factor for one of the checks. If
> > necessary, just bump it to 30 or so, if you are afraid of stack
> > accesses. But let's keep it simple with one threshold, if possible?
>
> +1
>
> 2/8 heuristic is working together with 20/100.
>
> Instead of tweaking force_new_state earlier, it's better to do:
> if (!force_new_state && cur->jmp_history_cnt < N &&
>     env->jmps_processed - env->prev_jmps_processed < 20 && ..)
>     add_new_state =3D false;

Yep, I actually had *exactly* this in mind, ack.


Basically all these heuristics are expressing the idea of doing just
the right amount of work between checkpoints, not too little, not too
much. Jump history size (accumulated in the current state) will be a
third  measure of "enough useful work", basically.

>
> You're essentially proposing N =3D=3D 40.
> Just add your existing comment next to the check.
> # define MAX_JMPS_PER_STATE is imo overkill.

