Return-Path: <bpf+bounces-42677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E539A910D
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 22:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000131C20E89
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 20:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EB51FE114;
	Mon, 21 Oct 2024 20:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTBePEOk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7AC1E9087
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729542214; cv=none; b=IFidsHlc5fUsewUMEwf5IrIo3fYov+sAMGcxjfG7xH9LtD+LuBz70V+tPolp28PaCRmaQegYnCQm1Luc850KLtDG9tYPi3zSSABLTrvzyCAkC9z0iuBDml8pt+bTm3EZVbz6gqFBlJS/wzrEs6x6n5JdZ5wUKUV+EHlgqzS/Rp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729542214; c=relaxed/simple;
	bh=cRqWuwyzWaoVWFHB2Ex1omtK6TbZqfiNFhEua5yu2Hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgOC4x4musNF7TP5ulLhv/ret7eLPEeEWCfFqwyo+t3KrGfqHiBOBUvNQs3ZnG7VuYTnmwFKsHwanEmKTkugFvBn6Jy2rA6bCbBCLyyWLk3Z5i6Drw9ZDXOytcsAhBWkcYhUJKlWSTALB7P5cL6EQV3UrtmnYZWtNYbb+6P7XEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTBePEOk; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e579abb99so3489266b3a.2
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 13:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729542211; x=1730147011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqjKJy6jDHcp3Vz5v15LkTgBureCLjprVsYDanHBJIY=;
        b=LTBePEOko6PmbUS2fNTnUAxi/ourgjXZBpPOMhXqYPGY0sGnkGePzCEruQn1LWu4mx
         chkSZk5R9DCwFFVCZ35G9ALBK4/sPQHlXqW+J1m+VdKKPVJPYiw8EdtU4eNW+4JMqhuu
         gU+UACN09kB4fF+oI4agnio+chPAZFF9EiHNiQBn5W/9G6Cshmz4dd59Q4mos/Mm0Oni
         aBsGAR07FTkgKUFa9+KB1T06SgwAWXIQJl5NNrxA0WWqXbOfGscmLDHDNSb/AT5+BbC1
         hHxLsUyd5tjTEdtDDoAP5jiAPOTAzaN6HWma3bA3wpeYDpw6BGRfUbjNVFJ4bnR1SaJ8
         BRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729542211; x=1730147011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqjKJy6jDHcp3Vz5v15LkTgBureCLjprVsYDanHBJIY=;
        b=Kc4UtJxiIgb4tG3C/VzQHszWYCq/SSNCuWsJ+FbWFsjCDRU1WWTxvF8CGMGwJNb39V
         1i2WZMml3wq2kEEhGLYGrD/0/iYqAxrbB8AF/32LNvGSwsyzxR2SlyyFyFpo0/y+G9TN
         THuVjftMceQg3DmKTm50FQHZI/sKR58+t8Fpq9i5rJr9ToK1d0aGoxCb0VZ15P2t3jGO
         /SwyV15RLUegWp0eKYt/XzKK/ttXbunksO7GO/LG49HwRqZZn3ayVQcwkLC0V3goS9R/
         95BzUZCaNjE79aRv0tlzZbLwSnrYgZCqZRJa/XNwHtXZmjqGQ/cnujh/7QvQs5FvVfBy
         6biQ==
X-Gm-Message-State: AOJu0YzzNIPoBWBJ1kTCX0nJazF7w4E2OFIp23rusncddHXi+PJ+9o4e
	4kR7j/dOKgTjKteX8GahAvHW6i8PRtH/d7G07YEJmpxSt4Z0dTUlUxfXYfIQqOE/ynejrBsVvip
	RxfVjBaQMWOnhBABZKxYsh/noFVg=
X-Google-Smtp-Source: AGHT+IFlxdV5AekxFYcNVSeptI26AkQkHj1O9T1x6z4/CHbLwZVUTivWtwx8A1jZCTx4vZKeN8fO16utLpXs+sDmsSU=
X-Received: by 2002:a05:6a00:17a9:b0:71d:eb7d:20d5 with SMTP id
 d2e1a72fcca58-71ea31ae82dmr19114538b3a.8.1729542210968; Mon, 21 Oct 2024
 13:23:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018020307.1766906-1-eddyz87@gmail.com>
In-Reply-To: <20241018020307.1766906-1-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 21 Oct 2024 13:23:19 -0700
Message-ID: <CAEf4BzavO=EX45+rGdL3PPHS+ba-SKp_VvE6c8zUYmcvjYXP3Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: force checkpoint when jmp history is
 too long
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 7:03=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
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
> The program is a simplified reproducer from syzbot report [1].
> Previous discussion could be found at [2].
> The patch does not cause any changes in verification performance,
> when tested on selftests from veristat.cfg and cilium programs taken
> from [3].
>
> [1] https://lore.kernel.org/bpf/670429f6.050a0220.49194.0517.GAE@google.c=
om/
> [2] https://lore.kernel.org/bpf/20241009021254.2805446-1-eddyz87@gmail.co=
m/
> [3] https://github.com/anakryiko/cilium
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/verifier.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f514247ba8ba..f64c831a9278 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17873,13 +17873,23 @@ static bool iter_active_depths_differ(struct bp=
f_verifier_state *old, struct bpf
>         return false;
>  }
>
> +#define MAX_JMPS_PER_STATE 20
> +
>  static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
>  {
>         struct bpf_verifier_state_list *new_sl;
>         struct bpf_verifier_state_list *sl, **pprev;
>         struct bpf_verifier_state *cur =3D env->cur_state, *new, *loop_en=
try;
>         int i, j, n, err, states_cnt =3D 0;
> -       bool force_new_state =3D env->test_state_freq || is_force_checkpo=
int(env, insn_idx);
> +       bool force_new_state =3D env->test_state_freq || is_force_checkpo=
int(env, insn_idx) ||
> +                              /* - Long jmp history hinders mark_chain_p=
recision performance,
> +                               *   so force new state if jmp history of =
current state exceeds
> +                               *   a threshold.
> +                               * - Jmp history records not only jumps, b=
ut also stack access,
> +                               *   so keep this constant 2x times the li=
mit imposed on
> +                               *   env->jmps_processed for loop cases (s=
ee skip_inf_loop_check).
> +                               */
> +                              cur->jmp_history_cnt > MAX_JMPS_PER_STATE =
* 2;

this feels like a wrong place to add this heuristic. Just few lines
below there is:


if (env->jmps_processed - env->prev_jmps_processed >=3D 2 &&
    env->insn_processed - env->prev_insn_processed >=3D 8)
        add_new_state =3D true;

Please add jmp_history_cnt check here, as it conceptually fits with
jmps_processed and insn_processed check. It also has a huge comment
with justification already, so might as well just extend that for
jmp_history_cnt.

pw-bot: cr

>         bool add_new_state =3D force_new_state;
>         bool force_exact;
>
> @@ -18023,7 +18033,7 @@ static int is_state_visited(struct bpf_verifier_e=
nv *env, int insn_idx)
>                          */
>  skip_inf_loop_check:
>                         if (!force_new_state &&
> -                           env->jmps_processed - env->prev_jmps_processe=
d < 20 &&
> +                           env->jmps_processed - env->prev_jmps_processe=
d < MAX_JMPS_PER_STATE &&
>                             env->insn_processed - env->prev_insn_processe=
d < 100)
>                                 add_new_state =3D false;

and then this one is logically matching add_new_state =3D true; case
above that I mentioned.


With these changes, I'd drop * 2 factor for one of the checks. If
necessary, just bump it to 30 or so, if you are afraid of stack
accesses. But let's keep it simple with one threshold, if possible?

>                         goto miss;
> --
> 2.46.2
>

