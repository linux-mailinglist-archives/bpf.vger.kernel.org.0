Return-Path: <bpf+bounces-43406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6473D9B5227
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 19:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1161B21FAB
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 18:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9BE201020;
	Tue, 29 Oct 2024 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpeqM5Ll"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2192A2107
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 18:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227954; cv=none; b=cLVWsWy6BuUggNSYySzyTvEGFOhU2UaDkhohiKpNsTV0nbfZuW4cw7EQbWprtkd4VDC5lfBUzWP71jM+lhgFdv2MbS5fd2dxHS9+5yqsz0WLm98+dFJ0nJESWU5AgAIWMEKwQK6LqGstlvyTW1FwJXbBOf64N0hFZAADPtxeWUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227954; c=relaxed/simple;
	bh=/EVWPPr8PkEEbop/Y66mxwrKePqUuOcGyWEsxAoPrVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxM3eXUnbP7Tdw29pmgWqaDXP5XRqyG90yvafojhFKgFa2CZ+L9JOcKTPMAWl5VHF6KZXu5MsMZKP3HTBst68JZcdnPiLamUuhS6G0UORtO8Kq+yyKIUoksC4kquoe2k9Ng+rrKis2amrzamt1lopujJGdcJ8SKZ3YZvI8ogEjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpeqM5Ll; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e6cec7227so4821569b3a.0
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 11:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730227951; x=1730832751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3tjWOrfPm8RQRf7oB7RO5P67Yb8UW4LvurZkvpDrx8=;
        b=OpeqM5Ll8TFRBrQ/Zcg90+HNTlckWUPR2RiER+vU7QniKI3SNSTFise2RrGz28vPP3
         zC+Q1ouIPcQkmn5CKk3ZzYGtcoivPwcce+fZEPqlphPNT2W0dQMuGucb9ECKU8AZ3oYj
         M1+ak8iNXUNQbvGRomMOqsiMNx6zEGxzNypdMK1jksePSliFUJzrjitYs66vDsTOKDQS
         k7JR3X/6O3TwxlP1x0ClRZemJWwTUU8Hhs37gUR9T6eQTdSTlr42+J6FOg70wzZmj1g9
         XOrZO1Y1Rcb9e9xNIhSozz36E1/aAbNZRqzzd4zHSps7QqBZ5mpsZAG4lXkFPwEOScdp
         BirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730227951; x=1730832751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3tjWOrfPm8RQRf7oB7RO5P67Yb8UW4LvurZkvpDrx8=;
        b=mQg6UwTbiPkGWgnIIKY8wpGQppt0AhSyCJPSL70sXdtu0cYicUpPzhWoExE3wVKZwR
         WIAzTqkGlGuZcz3KzI5/94wdgM69f7oYtJ76Nw8aQAgDMYbGojPwaUYzfpijIY98csPk
         C3PiiRc5EkHOsKUPUO3WrFfd7O7f9eDTXIy6IJuMlbuxcGcknC6DITdvvI3X+HJDWAwJ
         2ESuY5g6dr70O3+YfH0FDcasvBEJmpq9UPS70EO6sZUj2M2l2mFRRYbLBaK7nth2yz4z
         LMoIIqWjglvBd7mQcRVsVsbAfVAbaBeM8CmXGek5PeTpUDfzh3a62H/EaA0zl0f7OMAG
         m8Zg==
X-Gm-Message-State: AOJu0YwP7/6jf9ZkPv7xyH1Nrrv/8ygC+kF9lzTlLmW3dCbcFerHy6Cf
	NbEvonuLz4pdJMT/lV9X7/Vieijl6QZeh6vNXr/HlcQBdEA0ewsZmoyeglg+1jUMu2ofxXf5YQS
	bvgh3Hthu7DXG1IqnOhJgrISSiPs=
X-Google-Smtp-Source: AGHT+IG7/JrhCiixeNecIN9mHaVjUA3a0IaK3KTsg0gBq9ieNRl07Xbo6HFFBegK/3IXzr+JTjojouzk9Y7wMo48z+c=
X-Received: by 2002:a05:6a00:1817:b0:70b:176e:b3bc with SMTP id
 d2e1a72fcca58-720630aaa03mr19408820b3a.28.1730227951294; Tue, 29 Oct 2024
 11:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029172641.1042523-1-eddyz87@gmail.com>
In-Reply-To: <20241029172641.1042523-1-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 29 Oct 2024 11:52:18 -0700
Message-ID: <CAEf4BzZpAE7AyisQRererZTv6BEgKAdUzaq6LVMYftG5qFrQqw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: force checkpoint when jmp history is too long
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, 
	syzbot+7e46cdef14bf496a3ab4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 10:27=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> A specifically crafted program might trick verifier into growing very
> long jump history within a single bpf_verifier_state instance.
> Very long jump history makes mark_chain_precision() unreasonably slow,
> especially in case if verifier processes a loop.
>
> Mitigate this by forcing new state in is_state_visited() in case if
> current state's jump history is too long.
>
> Use same constant as in `skip_inf_loop_check`, but multiply it by
> arbitrarily chosen value 2 to account for jump history containing not
> only information about jumps, but also information about stack access.
>
> For an example of problematic program consider the code below,
> w/o this patch the example is processed by verifier for ~15 minutes,
> before failing to allocate big-enough chunk for jmp_history.
>
>     0: r7 =3D *(u16 *)(r1 +0);"
>     1: r7 +=3D 0x1ab064b9;"
>     2: if r7 & 0x702000 goto 1b;
>     3: r7 &=3D 0x1ee60e;"
>     4: r7 +=3D r1;"
>     5: if r7 s> 0x37d2 goto +0;"
>     6: r0 =3D 0;"
>     7: exit;"
>
> Perf profiling shows that most of the time is spent in
> mark_chain_precision() ~95%.
>
> The easiest way to explain why this program causes problems is to
> apply the following patch:
>
>     diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>     index 0c216e71cec7..4b4823961abe 100644
>     \--- a/include/linux/bpf.h
>     \+++ b/include/linux/bpf.h
>     \@@ -1926,7 +1926,7 @@ struct bpf_array {
>             };
>      };
>
>     -#define BPF_COMPLEXITY_LIMIT_INSNS      1000000 /* yes. 1M insns */
>     +#define BPF_COMPLEXITY_LIMIT_INSNS      256 /* yes. 1M insns */
>      #define MAX_TAIL_CALL_CNT 33
>
>      /* Maximum number of loops for bpf_loop and bpf_iter_num.
>     diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>     index f514247ba8ba..75e88be3bb3e 100644
>     \--- a/kernel/bpf/verifier.c
>     \+++ b/kernel/bpf/verifier.c
>     \@@ -18024,8 +18024,13 @@ static int is_state_visited(struct bpf_veri=
fier_env *env, int insn_idx)
>      skip_inf_loop_check:
>                             if (!force_new_state &&
>                                 env->jmps_processed - env->prev_jmps_proc=
essed < 20 &&
>     -                           env->insn_processed - env->prev_insn_proc=
essed < 100)
>     +                           env->insn_processed - env->prev_insn_proc=
essed < 100) {
>     +                               verbose(env, "is_state_visited: suppr=
essing checkpoint at %d, %d jmps processed, cur->jmp_history_cnt is %d\n",
>     +                                       env->insn_idx,
>     +                                       env->jmps_processed - env->pr=
ev_jmps_processed,
>     +                                       cur->jmp_history_cnt);
>                                     add_new_state =3D false;
>     +                       }
>                             goto miss;
>                     }
>                     /* If sl->state is a part of a loop and this loop's e=
ntry is a part of
>     \@@ -18142,6 +18147,9 @@ static int is_state_visited(struct bpf_verif=
ier_env *env, int insn_idx)
>             if (!add_new_state)
>                     return 0;
>
>     +       verbose(env, "is_state_visited: new checkpoint at %d, resetti=
ng env->jmps_processed\n",
>     +               env->insn_idx);
>     +
>             /* There were no equivalent states, remember the current one.
>              * Technically the current state is not proven to be safe yet=
,
>              * but it will either reach outer most bpf_exit (which means =
it's safe)
>
> And observe verification log:
>
>     ...
>     is_state_visited: new checkpoint at 5, resetting env->jmps_processed
>     5: R1=3Dctx() R7=3Dctx(...)
>     5: (65) if r7 s> 0x37d2 goto pc+0     ; R7=3Dctx(...)
>     6: (b7) r0 =3D 0                        ; R0_w=3D0
>     7: (95) exit
>
>     from 5 to 6: R1=3Dctx() R7=3Dctx(...) R10=3Dfp0
>     6: R1=3Dctx() R7=3Dctx(...) R10=3Dfp0
>     6: (b7) r0 =3D 0                        ; R0_w=3D0
>     7: (95) exit
>     is_state_visited: suppressing checkpoint at 1, 3 jmps processed, cur-=
>jmp_history_cnt is 74
>
>     from 2 to 1: R1=3Dctx() R7_w=3Dscalar(...) R10=3Dfp0
>     1: R1=3Dctx() R7_w=3Dscalar(...) R10=3Dfp0
>     1: (07) r7 +=3D 447767737
>     is_state_visited: suppressing checkpoint at 2, 3 jmps processed, cur-=
>jmp_history_cnt is 75
>     2: R7_w=3Dscalar(...)
>     2: (45) if r7 & 0x702000 goto pc-2
>     ... mark_precise 152 steps for r7 ...
>     2: R7_w=3Dscalar(...)
>     is_state_visited: suppressing checkpoint at 1, 4 jmps processed, cur-=
>jmp_history_cnt is 75
>     1: (07) r7 +=3D 447767737
>     is_state_visited: suppressing checkpoint at 2, 4 jmps processed, cur-=
>jmp_history_cnt is 76
>     2: R7_w=3Dscalar(...)
>     2: (45) if r7 & 0x702000 goto pc-2
>     ...
>     BPF program is too large. Processed 257 insn
>
> The log output shows that checkpoint at label (1) is never created,
> because it is suppressed by `skip_inf_loop_check` logic:
> a. When 'if' at (2) is processed it pushes a state with insn_idx (1)
>    onto stack and proceeds to (3);
> b. At (5) checkpoint is created, and this resets
>    env->{jmps,insns}_processed.
> c. Verification proceeds and reaches `exit`;
> d. State saved at step (a) is popped from stack and is_state_visited()
>    considers if checkpoint needs to be added, but because
>    env->{jmps,insns}_processed had been just reset at step (b)
>    the `skip_inf_loop_check` logic forces `add_new_state` to false.
> e. Verifier proceeds with current state, which slowly accumulates
>    more and more entries in the jump history.
>
> The accumulation of entries in the jump history is a problem because
> of two factors:
> - it eventually exhausts memory available for kmalloc() allocation;
> - mark_chain_precision() traverses the jump history of a state,
>   meaning that if `r7` is marked precise, verifier would iterate
>   ever growing jump history until parent state boundary is reached.
>
> (note: the log also shows a REG INVARIANTS VIOLATION warning
>        upon jset processing, but that's another bug to fix).
>
> With this patch applied, the example above is rejected by verifier
> under 1s of time, reaching 1M instructions limit.
>
> The program is a simplified reproducer from syzbot report.
> Previous discussion could be found at [1].
> The patch does not cause any changes in verification performance,
> when tested on selftests from veristat.cfg and cilium programs taken
> from [2].
>
> [1] https://lore.kernel.org/bpf/20241009021254.2805446-1-eddyz87@gmail.co=
m/
> [2] https://github.com/anakryiko/cilium
>
> Changelog:
> - v1 -> v2:
>   - moved patch to bpf tree;
>   - moved force_new_state variable initialization after declaration and
>     shortened the comment.
> v1: https://lore.kernel.org/bpf/20241018020307.1766906-1-eddyz87@gmail.co=
m/
>
> Reported-by: syzbot+7e46cdef14bf496a3ab4@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/bpf/670429f6.050a0220.49194.0517.GAE@goog=
le.com/
> Fixes: 2589726d12a1 ("bpf: introduce bounded loops")
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/verifier.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 587a6c76e564..ca8d7b054163 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17886,10 +17886,14 @@ static int is_state_visited(struct bpf_verifier=
_env *env, int insn_idx)
>         struct bpf_verifier_state_list *sl, **pprev;
>         struct bpf_verifier_state *cur =3D env->cur_state, *new, *loop_en=
try;
>         int i, j, n, err, states_cnt =3D 0;
> -       bool force_new_state =3D env->test_state_freq || is_force_checkpo=
int(env, insn_idx);
> -       bool add_new_state =3D force_new_state;
> +       bool force_new_state;
> +       bool add_new_state;
>         bool force_exact;

I've combined three bools into a single line.

>
> +       force_new_state =3D env->test_state_freq || is_force_checkpoint(e=
nv, insn_idx) ||
> +                         /* Avoid accumulating infinitely long jmp histo=
ry */
> +                         cur->jmp_history_cnt > 40;
> +
>         /* bpf progs typically have pruning point every 4 instructions
>          * http://vger.kernel.org/bpfconf2019.html#session-1
>          * Do not add new state for future pruning if the verifier hasn't=
 seen
> @@ -17898,6 +17902,7 @@ static int is_state_visited(struct bpf_verifier_e=
nv *env, int insn_idx)
>          * In tests that amounts to up to 50% reduction into total verifi=
er
>          * memory consumption and 20% verifier time speedup.
>          */
> +       add_new_state =3D force_new_state;
>         if (env->jmps_processed - env->prev_jmps_processed >=3D 2 &&
>             env->insn_processed - env->prev_insn_processed >=3D 8)
>                 add_new_state =3D true;
> --
> 2.47.0
>

