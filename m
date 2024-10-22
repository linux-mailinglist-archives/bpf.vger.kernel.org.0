Return-Path: <bpf+bounces-42724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 100BE9A95ED
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 04:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE45B1F22C02
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 02:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8149E132124;
	Tue, 22 Oct 2024 02:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiec+uBo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183601870
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 02:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729562610; cv=none; b=a3CZmeSKVUqxLbmT/8hJHtvrPZxFKvPbnE/ZhD//+s7z/vwheEGL3DQozZnjUYXKxe0sEsoBMG3duK1kAoFtOTnvSaltdae7iW1UuuKiD5/1H4TiWcniRTllVnMjlghKNnlOO3S6uSBe0fJfSRMW3QZ9lqtu+h2biQPxKIPVHpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729562610; c=relaxed/simple;
	bh=yMt7Gtfb1Lw6iDtjNxGQ5+5xv2as6fh2oJ6Vqcc8aGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPpTy0uXXag9rM8MkLNQMA459BFexdftRtlLw3xh2qmL3OMYHF3hPYZy5/Yii5FIs7lb1JW/3MA1P9knoVlJD0HLCVHujJkQFIUhJOhlShCo3wDVxElry1xPFCRxRe/JVpFYRItIlXGUP5khMwPjqDIF28z08siDmgvr/Sj4F2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiec+uBo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so56751295e9.1
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 19:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729562606; x=1730167406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYV91Y4xSShuKsn/rEE0t4AHUFj6vO6jPPaEi5VFCFA=;
        b=kiec+uBoERtRnAE+qjG1fpP1OIwt23qrHSDgSe3SqJ7+Dn102F7yUGIFm4OMkdNnWX
         E/TkRB9/22EVXycZLK8ZRgERsTynopXZq3qKEt9CghDrUkiSePmjx4lARr06mO9JH553
         VD0MdTad8otCath5ZpJUskn7NPz+phza4U77F9awf74nK733FF2p0kyFXFMTw2qWpCz9
         ad97QvB+j7z7rkj82/0Qn1a3VVySezn+NxeL/B4oO6BUFX0BOWeT0rjOEReanwOvgNXj
         9C1n9UpvLao9a/676OrO6NLhQOML1s3P4fq5WHtr7hk0RmA0J0l0qSRkmMWtOK9VWZZU
         osoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729562606; x=1730167406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYV91Y4xSShuKsn/rEE0t4AHUFj6vO6jPPaEi5VFCFA=;
        b=LbqGv3PYmjoL+C1EeCb48Pzllb2OtwbradJLb0gjYIBNOD5T8fQzh8/ZWPwpJuiTWf
         qjIBYlQ4cnrD1WanQjxywQqLGtE6B0LaQsCPrYZTgOtHvMwlYihQBNWYSFqXiFd5Tpzc
         hZyOwGJfRCXStphkBdsgRTtuzG+IUWRq2V/ZOT5wU8ihRawWLoiAilB8z2N8doHiyW0O
         vrfQJuQQnGALRBnsJa5p0/IUO7l8mw97YyB6MyPtwXP9rgotaUlx0r168U/lxoDQ+Qhk
         fQ6gIX1Q3J+hJ43wlI3u3JgHw5bzQfdLY6l7zsE9AWuib4CLf7Gd+c/itLKQjj716asI
         Wm2w==
X-Forwarded-Encrypted: i=1; AJvYcCUQPvmbpgqqCqDQjGtH8X286uobe6G3UnRWJZwe/f0BCtqD0Sptp+N2ZAboccahLEE1MOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6kxJPrUNH+VlzUqh4QSSBmviiUywdPD+7WYVpi2n6gh6XEb0f
	nvd7U1ksSBdEWO3TzEd0NcAS5oSZgxLgz0IPJ8WJGV6TLbuvS9lIouXPOJ8wYkNdCCY0+pkzIm9
	mN86WiJNvVDlTDJ4wJvdqX0WhALk=
X-Google-Smtp-Source: AGHT+IFP0bIXK5Xrph155yJvRWQFGqP0QqJY+9D/J8oku+8H4XzIVlozH2WRgWIeZvnDyn78+dErvr77qcmHlWSI4x4=
X-Received: by 2002:a05:600c:6747:b0:430:5356:ac92 with SMTP id
 5b1f17b1804b1-4316161fb1dmr100062725e9.7.1729562606042; Mon, 21 Oct 2024
 19:03:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018020307.1766906-1-eddyz87@gmail.com> <CAEf4BzavO=EX45+rGdL3PPHS+ba-SKp_VvE6c8zUYmcvjYXP3Q@mail.gmail.com>
In-Reply-To: <CAEf4BzavO=EX45+rGdL3PPHS+ba-SKp_VvE6c8zUYmcvjYXP3Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 21 Oct 2024 19:03:14 -0700
Message-ID: <CAADnVQKd3hgtK1zi3DgSYqDR_NFU1OKWxeXph+reKzXHO9hxGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: force checkpoint when jmp history is
 too long
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 1:23=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Oct 17, 2024 at 7:03=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > A specifically crafted program might trick verifier into growing very
> > long jump history within a single bpf_verifier_state instance.
> > Very long jump history makes mark_chain_precision() unreasonably slow,
> > especially in case if verifier processes a loop.
> >
> > Mitigate this by forcing new state in is_state_visited() in case if
> > current state's jump history is too long.
> >
> > Use same constant as in `skip_inf_loop_check`, but multiply it by
> > arbitrarily chosen value 2 to account for jump history containing not
> > only information about jumps, but also information about stack access.
> >
> > For an example of problematic program consider the code below,
> > w/o this patch the example is processed by verifier for ~15 minutes,
> > before failing to allocate big-enough chunk for jmp_history.
> >
> >     0: r7 =3D *(u16 *)(r1 +0);"
> >     1: r7 +=3D 0x1ab064b9;"
> >     2: if r7 & 0x702000 goto 1b;
> >     3: r7 &=3D 0x1ee60e;"
> >     4: r7 +=3D r1;"
> >     5: if r7 s> 0x37d2 goto +0;"
> >     6: r0 =3D 0;"
> >     7: exit;"
> >
> > Perf profiling shows that most of the time is spent in
> > mark_chain_precision() ~95%.
> >
> > The easiest way to explain why this program causes problems is to
> > apply the following patch:
> >
> >     diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >     index 0c216e71cec7..4b4823961abe 100644
> >     \--- a/include/linux/bpf.h
> >     \+++ b/include/linux/bpf.h
> >     \@@ -1926,7 +1926,7 @@ struct bpf_array {
> >             };
> >      };
> >
> >     -#define BPF_COMPLEXITY_LIMIT_INSNS      1000000 /* yes. 1M insns *=
/
> >     +#define BPF_COMPLEXITY_LIMIT_INSNS      256 /* yes. 1M insns */
> >      #define MAX_TAIL_CALL_CNT 33
> >
> >      /* Maximum number of loops for bpf_loop and bpf_iter_num.
> >     diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >     index f514247ba8ba..75e88be3bb3e 100644
> >     \--- a/kernel/bpf/verifier.c
> >     \+++ b/kernel/bpf/verifier.c
> >     \@@ -18024,8 +18024,13 @@ static int is_state_visited(struct bpf_ve=
rifier_env *env, int insn_idx)
> >      skip_inf_loop_check:
> >                             if (!force_new_state &&
> >                                 env->jmps_processed - env->prev_jmps_pr=
ocessed < 20 &&
> >     -                           env->insn_processed - env->prev_insn_pr=
ocessed < 100)
> >     +                           env->insn_processed - env->prev_insn_pr=
ocessed < 100) {
> >     +                               verbose(env, "is_state_visited: sup=
pressing checkpoint at %d, %d jmps processed, cur->jmp_history_cnt is %d\n"=
,
> >     +                                       env->insn_idx,
> >     +                                       env->jmps_processed - env->=
prev_jmps_processed,
> >     +                                       cur->jmp_history_cnt);
> >                                     add_new_state =3D false;
> >     +                       }
> >                             goto miss;
> >                     }
> >                     /* If sl->state is a part of a loop and this loop's=
 entry is a part of
> >     \@@ -18142,6 +18147,9 @@ static int is_state_visited(struct bpf_ver=
ifier_env *env, int insn_idx)
> >             if (!add_new_state)
> >                     return 0;
> >
> >     +       verbose(env, "is_state_visited: new checkpoint at %d, reset=
ting env->jmps_processed\n",
> >     +               env->insn_idx);
> >     +
> >             /* There were no equivalent states, remember the current on=
e.
> >              * Technically the current state is not proven to be safe y=
et,
> >              * but it will either reach outer most bpf_exit (which mean=
s it's safe)
> >
> > And observe verification log:
> >
> >     ...
> >     is_state_visited: new checkpoint at 5, resetting env->jmps_processe=
d
> >     5: R1=3Dctx() R7=3Dctx(...)
> >     5: (65) if r7 s> 0x37d2 goto pc+0     ; R7=3Dctx(...)
> >     6: (b7) r0 =3D 0                        ; R0_w=3D0
> >     7: (95) exit
> >
> >     from 5 to 6: R1=3Dctx() R7=3Dctx(...) R10=3Dfp0
> >     6: R1=3Dctx() R7=3Dctx(...) R10=3Dfp0
> >     6: (b7) r0 =3D 0                        ; R0_w=3D0
> >     7: (95) exit
> >     is_state_visited: suppressing checkpoint at 1, 3 jmps processed, cu=
r->jmp_history_cnt is 74
> >
> >     from 2 to 1: R1=3Dctx() R7_w=3Dscalar(...) R10=3Dfp0
> >     1: R1=3Dctx() R7_w=3Dscalar(...) R10=3Dfp0
> >     1: (07) r7 +=3D 447767737
> >     is_state_visited: suppressing checkpoint at 2, 3 jmps processed, cu=
r->jmp_history_cnt is 75
> >     2: R7_w=3Dscalar(...)
> >     2: (45) if r7 & 0x702000 goto pc-2
> >     ... mark_precise 152 steps for r7 ...
> >     2: R7_w=3Dscalar(...)
> >     is_state_visited: suppressing checkpoint at 1, 4 jmps processed, cu=
r->jmp_history_cnt is 75
> >     1: (07) r7 +=3D 447767737
> >     is_state_visited: suppressing checkpoint at 2, 4 jmps processed, cu=
r->jmp_history_cnt is 76
> >     2: R7_w=3Dscalar(...)
> >     2: (45) if r7 & 0x702000 goto pc-2
> >     ...
> >     BPF program is too large. Processed 257 insn
> >
> > The log output shows that checkpoint at label (1) is never created,
> > because it is suppressed by `skip_inf_loop_check` logic:
> > a. When 'if' at (2) is processed it pushes a state with insn_idx (1)
> >    onto stack and proceeds to (3);
> > b. At (5) checkpoint is created, and this resets
> >    env->{jmps,insns}_processed.
> > c. Verification proceeds and reaches `exit`;
> > d. State saved at step (a) is popped from stack and is_state_visited()
> >    considers if checkpoint needs to be added, but because
> >    env->{jmps,insns}_processed had been just reset at step (b)
> >    the `skip_inf_loop_check` logic forces `add_new_state` to false.
> > e. Verifier proceeds with current state, which slowly accumulates
> >    more and more entries in the jump history.
> >
> > The accumulation of entries in the jump history is a problem because
> > of two factors:
> > - it eventually exhausts memory available for kmalloc() allocation;
> > - mark_chain_precision() traverses the jump history of a state,
> >   meaning that if `r7` is marked precise, verifier would iterate
> >   ever growing jump history until parent state boundary is reached.
> >
> > (note: the log also shows a REG INVARIANTS VIOLATION warning
> >        upon jset processing, but that's another bug to fix).
> >
> > With this patch applied, the example above is rejected by verifier
> > under 1s of time, reaching 1M instructions limit.
> >
> > The program is a simplified reproducer from syzbot report [1].
> > Previous discussion could be found at [2].
> > The patch does not cause any changes in verification performance,
> > when tested on selftests from veristat.cfg and cilium programs taken
> > from [3].
> >
> > [1] https://lore.kernel.org/bpf/670429f6.050a0220.49194.0517.GAE@google=
.com/
> > [2] https://lore.kernel.org/bpf/20241009021254.2805446-1-eddyz87@gmail.=
com/
> > [3] https://github.com/anakryiko/cilium
> >
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index f514247ba8ba..f64c831a9278 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -17873,13 +17873,23 @@ static bool iter_active_depths_differ(struct =
bpf_verifier_state *old, struct bpf
> >         return false;
> >  }
> >
> > +#define MAX_JMPS_PER_STATE 20
> > +
> >  static int is_state_visited(struct bpf_verifier_env *env, int insn_idx=
)
> >  {
> >         struct bpf_verifier_state_list *new_sl;
> >         struct bpf_verifier_state_list *sl, **pprev;
> >         struct bpf_verifier_state *cur =3D env->cur_state, *new, *loop_=
entry;
> >         int i, j, n, err, states_cnt =3D 0;
> > -       bool force_new_state =3D env->test_state_freq || is_force_check=
point(env, insn_idx);
> > +       bool force_new_state =3D env->test_state_freq || is_force_check=
point(env, insn_idx) ||
> > +                              /* - Long jmp history hinders mark_chain=
_precision performance,
> > +                               *   so force new state if jmp history o=
f current state exceeds
> > +                               *   a threshold.
> > +                               * - Jmp history records not only jumps,=
 but also stack access,
> > +                               *   so keep this constant 2x times the =
limit imposed on
> > +                               *   env->jmps_processed for loop cases =
(see skip_inf_loop_check).
> > +                               */
> > +                              cur->jmp_history_cnt > MAX_JMPS_PER_STAT=
E * 2;
>
> this feels like a wrong place to add this heuristic. Just few lines
> below there is:
>
>
> if (env->jmps_processed - env->prev_jmps_processed >=3D 2 &&
>     env->insn_processed - env->prev_insn_processed >=3D 8)
>         add_new_state =3D true;
>
> Please add jmp_history_cnt check here, as it conceptually fits with
> jmps_processed and insn_processed check. It also has a huge comment
> with justification already, so might as well just extend that for
> jmp_history_cnt.

I think adding if (cur->jmp_history_cnt > 20) add_new_state =3D true;
won't help. It will get back to false.
But I agree that tweaking force_new_state also is not quite clean.

btw the "huge comment" may need to be revised :)
bpf progs today probably look different than they were in 2019.

>
> pw-bot: cr
>
> >         bool add_new_state =3D force_new_state;
> >         bool force_exact;
> >
> > @@ -18023,7 +18033,7 @@ static int is_state_visited(struct bpf_verifier=
_env *env, int insn_idx)
> >                          */
> >  skip_inf_loop_check:
> >                         if (!force_new_state &&
> > -                           env->jmps_processed - env->prev_jmps_proces=
sed < 20 &&
> > +                           env->jmps_processed - env->prev_jmps_proces=
sed < MAX_JMPS_PER_STATE &&
> >                             env->insn_processed - env->prev_insn_proces=
sed < 100)
> >                                 add_new_state =3D false;
>
> and then this one is logically matching add_new_state =3D true; case
> above that I mentioned.
>
>
> With these changes, I'd drop * 2 factor for one of the checks. If
> necessary, just bump it to 30 or so, if you are afraid of stack
> accesses. But let's keep it simple with one threshold, if possible?

+1

2/8 heuristic is working together with 20/100.

Instead of tweaking force_new_state earlier, it's better to do:
if (!force_new_state && cur->jmp_history_cnt < N &&
    env->jmps_processed - env->prev_jmps_processed < 20 && ..)
    add_new_state =3D false;

You're essentially proposing N =3D=3D 40.
Just add your existing comment next to the check.
# define MAX_JMPS_PER_STATE is imo overkill.

