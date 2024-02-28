Return-Path: <bpf+bounces-22947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0552186BBDF
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712711F29420
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241F67293F;
	Wed, 28 Feb 2024 23:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7Lvi0/P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B51137740
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 23:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161305; cv=none; b=YSTG4PAWi6TCJbTQppv4ireu+il4CKWjbgpT+B/ajwcTwlmdgwk7c6VuulnZlr88Rbl58p1FG/4pw9btJiAEQYAWcmcSkOcJae4I3hnr6Qf6qXfMBw/l9wRjVtMrgEkhzzMn1izWRtpqTfLkv2Xg8wRbWmF1uyG98kIIpdxIkrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161305; c=relaxed/simple;
	bh=bz7CetVgC35Jc2nKDIbfAw8czOq4u4pHukSBFy3Ynts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RDkeYhDHTBzu47G/V/582CQ9exdVYhuHZYKkAIOAbBggi2DpcUI0yG5HnX4m3j6V4Rr+tyHaDxaqaqjMlMiGoeAiv+PMNbQqDeQ9gEPuatQLhRhW6FIWTzsuuCQo5Cx02MwscjEQN9Zls2noTxHYSeRYjWwTy93jsINSWyUScLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7Lvi0/P; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5e152c757a5so168202a12.2
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 15:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709161303; x=1709766103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LC1/LsdTHjqFPO8JamkCKP0abqK0WdAYK5URSNQpQ4=;
        b=E7Lvi0/Ppdcq/SsTAYO349CYYfB6fXFr8uQJaq20zKQX38549R4b3Dv0uNI380qJPF
         fkOmLSXj6bHYcRHJq07lMAYeiJrVkMu43WQrXq0Ywy8lFMzt6LGmmUAiaiLlRAUJagdw
         8ZhC6UkwdfK17yXeHyqFT5AO+vyC/KsJp5VIkilN6p5xXAlbjYefmXAd8kAjrYcWk76V
         dR+XsSqWyfmSw+6nPwS3vOkQlLr3M638vGtce+pFDcaovYwiHDfWCxz5HV4MbZ8rVeVZ
         Qz3I8Fn8+nFisO0Fz8qyAbyQ8H8xbZYSd47Xt1DnQwyEunFHwALcvibqyMXIYUbDUGME
         GQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709161303; x=1709766103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1LC1/LsdTHjqFPO8JamkCKP0abqK0WdAYK5URSNQpQ4=;
        b=el7F6JYSSgTh9LTLeFY7jydt2WRUghAmJaWk96rvrvCugynVFqSKHCyagANrlG1T/h
         N2IccEs8Xe2g0z1gl01NyNXcSTcXEtKaZACxDataFWdkmzZ3dK1DmjRRJSf3bN3Ynv7M
         ssyOphXirgZfREqlEp9fH8nlxvsu9mzp2ubbf1+Z0yg6WaDuGvh1mBwwkmMDZw9Rj2Ez
         zANTGc7rOO3VgAC/8aRJjJ7FOd0FdejXWjiLiUyKIMbS2Tg5CNgyCMVUSIQjlpGrqi8d
         85rM/DTXNlGbz8ew9mSdf2Vh6Vq1P8kcftmRIMO2a8bLNUOBrvrj3xkHsxsmo4NrJWBm
         D0IQ==
X-Gm-Message-State: AOJu0YyDXaD1YHbXnjOXVxUfJlfxh+gO3R4abNxxPezleRvJ/EJ3iFYS
	B4hH/7+R1gHwccLP1y3+ur+F+rPTLXQFrkcspjDan96cIkSa43YzjrmD/FlkP+V/jULIwDc/oSh
	Nslz8gbxNR5h+U+7x3NTnhYW8epr1fhqp
X-Google-Smtp-Source: AGHT+IEfUdm7mCcA4w6DTJuQt4DNOPngEechoX1x4sBF2YYs/SQjDPI0h3wSEZtRIcl+EAOoGyhoQSPori5Rpwekqcw=
X-Received: by 2002:a17:90a:49cc:b0:29a:9952:67b7 with SMTP id
 l12-20020a17090a49cc00b0029a995267b7mr540243pjm.48.1709161303123; Wed, 28 Feb
 2024 15:01:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222005005.31784-1-eddyz87@gmail.com> <20240222005005.31784-3-eddyz87@gmail.com>
In-Reply-To: <20240222005005.31784-3-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Feb 2024 15:01:30 -0800
Message-ID: <CAEf4BzZdDoaVw28RahC+8hV+kReYjTdfJQdaMXJEkUUgih8j2Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: track find_equal_scalars history on
 per-instruction level
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 4:50=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Use bpf_verifier_state->jmp_history to track which registers were
> updated by find_equal_scalars() when conditional jump was verified.
> Use recorded information in backtrack_insn() to propagate precision.
>
> E.g. for the following program:
>
>             while verifying instructions
>   r1 =3D r0              |
>   if r1 < 8  goto ...  | push r0,r1 as equal_scalars in jmp_history
>   if r0 > 16 goto ...  | push r0,r1 as equal_scalars in jmp_history
>   r2 =3D r10             |
>   r2 +=3D r0             v mark_chain_precision(r0)
>
>             while doing mark_chain_precision(r0)
>   r1 =3D r0              ^
>   if r1 < 8  goto ...  | mark r0,r1 as precise
>   if r0 > 16 goto ...  | mark r0,r1 as precise
>   r2 =3D r10             |
>   r2 +=3D r0             | mark r0 precise
>
> Technically achieve this in following steps:
> - Use 10 bits to identify each register that gains range because of
>   find_equal_scalars():
>   - 3 bits for frame number;
>   - 6 bits for register or stack slot number;
>   - 1 bit to indicate if register is spilled.
> - Use u64 as a vector of 6 such records + 4 bits for vector length.
> - Augment struct bpf_jmp_history_entry with field 'equal_scalars'
>   representing such vector.
> - When doing check_cond_jmp_op() for remember up to 6 registers that
>   gain range because of find_equal_scalars() in such a vector.
> - Don't propagate range information and reset IDs for registers that
>   don't fit in 6-value vector.
> - Push collected vector to bpf_verifier_state->jmp_history for
>   instruction index of conditional jump.
> - When doing backtrack_insn() for conditional jumps
>   check if any of recorded equal scalars is currently marked precise,
>   if so mark all equal recorded scalars as precise.
>
> Fixes: 904e6ddf4133 ("bpf: Use scalar ids in mark_chain_precision()")
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Closes: https://lore.kernel.org/bpf/CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt=
+_Lf0kcFEut2Mg@mail.gmail.com/
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  include/linux/bpf_verifier.h                  |   1 +
>  kernel/bpf/verifier.c                         | 207 ++++++++++++++++--
>  .../bpf/progs/verifier_subprog_precision.c    |   2 +-
>  .../testing/selftests/bpf/verifier/precise.c  |   2 +-
>  4 files changed, 195 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index cbfb235984c8..26e32555711c 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -361,6 +361,7 @@ struct bpf_jmp_history_entry {
>         u32 prev_idx : 22;
>         /* special flags, e.g., whether insn is doing register stack spil=
l/load */
>         u32 flags : 10;
> +       u64 equal_scalars;
>  };
>

[...]

> @@ -3314,7 +3384,7 @@ static struct bpf_jmp_history_entry *get_jmp_hist_e=
ntry(struct bpf_verifier_stat
>
>  /* for any branch, call, exit record the history of jmps in the given st=
ate */
>  static int push_jmp_history(struct bpf_verifier_env *env, struct bpf_ver=
ifier_state *cur,
> -                           int insn_flags)
> +                           int insn_flags, u64 equal_scalars)
>  {
>         struct bpf_jmp_history_entry *p, *cur_hist_ent;
>         u32 cnt =3D cur->jmp_history_cnt;
> @@ -3332,6 +3402,12 @@ static int push_jmp_history(struct bpf_verifier_en=
v *env, struct bpf_verifier_st
>                           "verifier insn history bug: insn_idx %d cur fla=
gs %x new flags %x\n",
>                           env->insn_idx, cur_hist_ent->flags, insn_flags)=
;
>                 cur_hist_ent->flags |=3D insn_flags;
> +               if (cur_hist_ent->equal_scalars !=3D 0) {
> +                       verbose(env, "verifier bug: insn_idx %d equal_sca=
lars !=3D 0: %#llx\n",
> +                               env->insn_idx, cur_hist_ent->equal_scalar=
s);
> +                       return -EFAULT;
> +               }

let's do WARN_ONCE() just like we do for flags? why deviating?

> +               cur_hist_ent->equal_scalars =3D equal_scalars;
>                 return 0;
>         }
>
> @@ -3346,6 +3422,7 @@ static int push_jmp_history(struct bpf_verifier_env=
 *env, struct bpf_verifier_st
>         p->idx =3D env->insn_idx;
>         p->prev_idx =3D env->prev_insn_idx;
>         p->flags =3D insn_flags;
> +       p->equal_scalars =3D equal_scalars;
>         cur->jmp_history_cnt =3D cnt;
>
>         return 0;

[...]

>  static bool calls_callback(struct bpf_verifier_env *env, int insn_idx);
>
>  /* For given verifier state backtrack_insn() is called from the last ins=
n to
> @@ -3802,6 +3917,7 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx, int subseq_idx,
>                          */
>                         return 0;
>                 } else if (BPF_SRC(insn->code) =3D=3D BPF_X) {
> +                       bt_set_equal_scalars(bt, hist);
>                         if (!bt_is_reg_set(bt, dreg) && !bt_is_reg_set(bt=
, sreg))
>                                 return 0;
>                         /* dreg <cond> sreg
> @@ -3812,6 +3928,9 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx, int subseq_idx,
>                          */
>                         bt_set_reg(bt, dreg);
>                         bt_set_reg(bt, sreg);
> +                       bt_set_equal_scalars(bt, hist);
> +               } else if (BPF_SRC(insn->code) =3D=3D BPF_K) {
> +                       bt_set_equal_scalars(bt, hist);

Can you please elaborate why we are doing bt_set_equal_scalars() in
these three places and not everywhere else? I'm trying to understand
whether we should do it more generically for any instruction either
before or after all the bt_set_xxx() calls...

>                          /* else dreg <cond> K
>                           * Only dreg still needs precision before
>                           * this insn, so for the K-based conditional
> @@ -4579,7 +4698,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
>         }
>
>         if (insn_flags)
> -               return push_jmp_history(env, env->cur_state, insn_flags);
> +               return push_jmp_history(env, env->cur_state, insn_flags, =
0);
>         return 0;
>  }
>

[...]

