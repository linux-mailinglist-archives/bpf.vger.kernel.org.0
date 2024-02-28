Return-Path: <bpf+bounces-22916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3702286B880
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 20:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E64DB231D8
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 19:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3415E077;
	Wed, 28 Feb 2024 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGHSKaRQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EC75E069
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709149592; cv=none; b=g16if/8oq/ZM2IEj0e8PWRcFI+GiulReg8ULQsijFjpwmqjrLiFbB4zPhtU4ufl7ctgijQmE6KUXg+o33Zapup1ICfsFnlWMVX47ygO7K2H2LzwaAgbzr6JRlT6efONO0LvPtrx/CR8r/Gk7ONi8Z8ky4pvI1i1BKpgZ5H5EsEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709149592; c=relaxed/simple;
	bh=UKA2aTVGnmSMois2Dq8cvQXu+hWdugdK4WlsDG28hSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHEu62TVPBiHSA9PStWg++J5sSu/Qe6e+qizTbeq4RZMMyuY/fRRtKhOIf3U3avtGVBEli7imkD7rY6OKtQ/gxoCmDDYFZXvDQZwcJHP6J65Xw9ddzqNciQghPVEXP+VXME2uxHrzbMQ3hnoXsnR9dzZmxVuYwaWHv2FB35UYUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGHSKaRQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dc1ff3ba1aso1570965ad.3
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 11:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709149590; x=1709754390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLG1twq3Kyp37XfymApurkXn3bh8FS5tr7khPSftUyU=;
        b=jGHSKaRQ6oUmalglkJLksvakAZXCfKcMKCXmtAe96VrfmvZMzO7u2Tx8uym3V/NOQp
         WAjvzz+gSu3AeEYayPcgMJ6r3jN62Lg30k6f2cvcs6Rz8uukuv6L5xnU8eG0Ts/fMQtk
         JcU4MwJXT3Y1t/E9vxYW0FEq2bWTYs2WLdBxj5r4o3qE67/fDHJIrNbPb4qCPvPfKdVj
         fwJxbPBEqxDtcxcHMrXFHgwG1iM3EFdHa1k/b7VU2e9V8yFwxbeXhpd0OQ8sJIu6qe1f
         EmlF6x2kErZRlsBtoyTHtWFvqsOQzinuLKF7D3t2tc+PkSij3d20gD3EkfFFvla3ILpo
         EXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709149590; x=1709754390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLG1twq3Kyp37XfymApurkXn3bh8FS5tr7khPSftUyU=;
        b=F+KZd6GbdaCaS67455hwBkfSvzaWeXPSl+zs8RcFv7Hi6qFzgRibz08hU2QLHgvWVx
         cMjgt75pcWRFpg9X3HcBJOwIpl6NGiPv6iP7mKk6eQBU7NAcJBPOqf90qmz697sNHh0c
         o4NkGsgV4tMU3yUrsSa3HtajYc+VMIYRG1LP693RJ8a851vHvzN7RdCGBTsalge7VzGi
         JdZyRwIRqB49RTJTqvll6MlMFyRvIUYYps8ei4F0LD1QFgsxs9iVtaoWDTDYUbK++7ZN
         jEJ4ycwdohMe3Grh1VKGXWQ7zCd/GKeV8+cj9iSW7GYk4Ga9IhZ80WooX2i8ksic/D5x
         TIPQ==
X-Gm-Message-State: AOJu0YytcfYkpK7Y6REVQ20ShKdKCsnXG7U89WoYZOMQLqQZE3xpv2cy
	EftsCAt2YyZyCpDXc5ecaxFDY/XNJkzOpw1RZqFVKfDxWolRau1YxHNl4xP20BM+UZy5MWSKAjP
	OqIeOkAr/cQIbzx1Ll5TD1MHZxS0=
X-Google-Smtp-Source: AGHT+IFwf73dYMq7XeQrTb8iIeR0NS1QRPOh0MdQDX9O5m6KXFuksFetWWh1w9kCpCNhVdd+ooMVS2Qb8xzAiwiEDnE=
X-Received: by 2002:a17:902:e542:b0:1dc:b382:da8d with SMTP id
 n2-20020a170902e54200b001dcb382da8dmr535314plf.38.1709149589772; Wed, 28 Feb
 2024 11:46:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222005005.31784-1-eddyz87@gmail.com> <20240222005005.31784-2-eddyz87@gmail.com>
In-Reply-To: <20240222005005.31784-2-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Feb 2024 11:46:17 -0800
Message-ID: <CAEf4BzYDtaLU6qXdfVz5gw-Z8Dug35PFDqzBzsbnVXDnP=6X6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: replace env->cur_hist_ent with a getter function
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 4:50=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Let push_jmp_history() peek current jump history entry basing on the
> passed bpf_verifier_state. This replaces a "global" variable in
> bpf_verifier_env allowing to use push_jmp_history() for states other
> than env->cur_state.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  1 -
>  kernel/bpf/verifier.c        | 34 ++++++++++++++++------------------
>  2 files changed, 16 insertions(+), 19 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 84365e6dd85d..cbfb235984c8 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -705,7 +705,6 @@ struct bpf_verifier_env {
>                 int cur_stack;
>         } cfg;
>         struct backtrack_state bt;
> -       struct bpf_jmp_history_entry *cur_hist_ent;
>         u32 pass_cnt; /* number of times do_check() was called */
>         u32 subprog_cnt;
>         /* number of instructions analyzed by the verifier */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 011d54a1dc53..759ef089b33c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3304,24 +3304,34 @@ static bool is_jmp_point(struct bpf_verifier_env =
*env, int insn_idx)
>         return env->insn_aux_data[insn_idx].jmp_point;
>  }
>
> +static struct bpf_jmp_history_entry *get_jmp_hist_entry(struct bpf_verif=
ier_state *st,
> +                                                       u32 hist_end, int=
 insn_idx)
> +{
> +       if (hist_end > 0 && st->jmp_history[hist_end - 1].idx =3D=3D insn=
_idx)
> +               return &st->jmp_history[hist_end - 1];
> +       return NULL;
> +}
> +
>  /* for any branch, call, exit record the history of jmps in the given st=
ate */
>  static int push_jmp_history(struct bpf_verifier_env *env, struct bpf_ver=
ifier_state *cur,
>                             int insn_flags)
>  {
> +       struct bpf_jmp_history_entry *p, *cur_hist_ent;
>         u32 cnt =3D cur->jmp_history_cnt;
> -       struct bpf_jmp_history_entry *p;
>         size_t alloc_size;
>
> +       cur_hist_ent =3D get_jmp_hist_entry(cur, cnt, env->insn_idx);
> +

This is, generally speaking, not correct to do. You can have a tight
loop where the instruction with the same insn_idx is executed multiple
times and so we'll get multiple consecutive entries in jmp_history
with the same insn_idx. We shouldn't reuse hist_ent for all of them,
each simulated instruction execution should have its own entry in jump
history.

It's fine to use get_jmp_hist_entry() in backtracking, though.

I'll look through the rest of patches more closely first before
suggesting any alternatives. But what you do in this patch is not 100%
correct.

>         /* combine instruction flags if we already recorded this instruct=
ion */
> -       if (env->cur_hist_ent) {
> +       if (cur_hist_ent) {
>                 /* atomic instructions push insn_flags twice, for READ an=
d
>                  * WRITE sides, but they should agree on stack slot
>                  */
> -               WARN_ONCE((env->cur_hist_ent->flags & insn_flags) &&
> -                         (env->cur_hist_ent->flags & insn_flags) !=3D in=
sn_flags,
> +               WARN_ONCE((cur_hist_ent->flags & insn_flags) &&
> +                         (cur_hist_ent->flags & insn_flags) !=3D insn_fl=
ags,
>                           "verifier insn history bug: insn_idx %d cur fla=
gs %x new flags %x\n",
> -                         env->insn_idx, env->cur_hist_ent->flags, insn_f=
lags);
> -               env->cur_hist_ent->flags |=3D insn_flags;
> +                         env->insn_idx, cur_hist_ent->flags, insn_flags)=
;
> +               cur_hist_ent->flags |=3D insn_flags;
>                 return 0;
>         }
>
> @@ -3337,19 +3347,10 @@ static int push_jmp_history(struct bpf_verifier_e=
nv *env, struct bpf_verifier_st
>         p->prev_idx =3D env->prev_insn_idx;
>         p->flags =3D insn_flags;
>         cur->jmp_history_cnt =3D cnt;
> -       env->cur_hist_ent =3D p;
>
>         return 0;
>  }
>
> -static struct bpf_jmp_history_entry *get_jmp_hist_entry(struct bpf_verif=
ier_state *st,
> -                                                       u32 hist_end, int=
 insn_idx)
> -{
> -       if (hist_end > 0 && st->jmp_history[hist_end - 1].idx =3D=3D insn=
_idx)
> -               return &st->jmp_history[hist_end - 1];
> -       return NULL;
> -}
> -
>  /* Backtrack one insn at a time. If idx is not at the top of recorded
>   * history then previous instruction came from straight line execution.
>   * Return -ENOENT if we exhausted all instructions within given state.
> @@ -17437,9 +17438,6 @@ static int do_check(struct bpf_verifier_env *env)
>                 u8 class;
>                 int err;
>
> -               /* reset current history entry on each new instruction */
> -               env->cur_hist_ent =3D NULL;
> -
>                 env->prev_insn_idx =3D prev_insn_idx;
>                 if (env->insn_idx >=3D insn_cnt) {
>                         verbose(env, "invalid insn idx %d insn_cnt %d\n",
> --
> 2.43.0
>

