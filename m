Return-Path: <bpf+bounces-61699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8EDAEA588
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 20:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0509177F2E
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 18:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70802ED860;
	Thu, 26 Jun 2025 18:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXjyN1ne"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899451DF739
	for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750963310; cv=none; b=PKUN7rFtU98UqrxyDC7XR4Wy18TgIlYAyTkTgJldZrr5t+3o1KFAqCdLLjYXqn1OaHMX3o/ISgAHbWbNSKSgkWByFWR5a5Rdmjm4/pYqw7N5IDyRu3rxQBbu0Cn4tM8f9nf4BYeipgcQKv/nlu24snABncWB6v5oCtlQl2YOTJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750963310; c=relaxed/simple;
	bh=s21gCJhFNFViWebXJcWfm72/UVwuH3P4XHmKjmBNDSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzgwXudVaUkxGU8Bbj8DQ2ZBghJpEGOnuXIG0i4EVttm4MAO7Gb/7MXiqooQoGI03xXwwV1o5jGLD+w5AKmdJU9I/YkKccQUVH4KKTl08tLItpp2ThWVXk/5hyAwYT8dOrG1sDh6XSIEsS68x9+Y/EPXx1KtRg1/5rlIFFH9iKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXjyN1ne; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso1024617f8f.1
        for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 11:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750963307; x=1751568107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GBiMuAnlPzRtTQ1k4vuvcqOJ9KDgzw/tqRE4o2Co0E=;
        b=KXjyN1nepTubyXtN9K33mLkco0aw9ou0CDs8PdUX3miYPrK2XP6n35Uuz6Gjh9zC02
         yiengknKnHxWgNa1ZdxMY6SCjzObx8JO8Tf7RefzzWzEFBnTSeeeGRSpLLPUt9RK+eo9
         EVz0MtZ27GdTVgzzAd/lM5iqRklkhLMjO8pcCwq8d29UHp1jVtpuiP2E1Lj8JlEjfm7v
         8Y+Xs2wLwXxZj8kwp2bDdFGeXILSsI9vZk1uPWLAUaaHulUBcJJ72ig5UvrRb9WZyqc5
         l3aU4YGoVXkXgiFZ6z6sTKHqyJbMcjX5UMElUKnwi2KrT6Inj9kNvZMn2/1wzgbIICUs
         HqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750963307; x=1751568107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GBiMuAnlPzRtTQ1k4vuvcqOJ9KDgzw/tqRE4o2Co0E=;
        b=DEPvvhcixFzCNEaRIR1MWM7HXGS1R/pILf3vqi8gYKfOeb7HsNHBpFLKCDDvGfUTdO
         Jkl4Y+jr4pGQ/C9zKd9srXtcrjsEP7vN39CXRs7BTqupn4JkoAhRB9iyHkU2416XagdB
         BZcNzcLlvPpnQu12hqICcpGDE7lNkrG5kdkdLOLVOOTtJ7p7Je5cAwOgqSQ2mKGxRfjI
         nTI+YFVLMmTwqGGJP9xJgKrekuPD6BEewjfnnx5/0LgOOeOW0PV6NxQ06DPxRG7mmvTJ
         gNmF5pTKq3rhOR3JMhCYzFtNGIRIgmlQ4KctPtC/Gyvx5v6LMqXpA+N9qNwfyjLh11u1
         2oIw==
X-Forwarded-Encrypted: i=1; AJvYcCUjgLiwcujAxabGbYK401BI+rEKrSJ9UU7WMyo6GxEAF3ilVfRXExiiQrk+fZDcmm1IKFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9PZNT2CR5p2aDsxW56GvjPLKzwAALdZxhRlAQ4V0uoMlrYj+t
	/NODsb99VsnzaEGdbPPPlm7qNL7ibmM+TUJGyhWhXezGlZnDK3kZ2slxtYrQ3adWmgq2g+fUPC0
	+XtcuFnhN9FYqnTX2gLmZou9UK95OGYI=
X-Gm-Gg: ASbGncse1rO3Mf8TXRkdh9UFQ/ZWb6tIXLZHn72gZJfESH+FCF1Qf8GW5PZsSf9Y9A1
	AhCryO6cU750oRWo5syr9rJiz/AXQ6ffmz7UkBJzawOSkknBRFBS6L7MEbT08615+BBsu2KLX5F
	W1DXj0GtZzDLNjMJi8VOaeOiQre2BOq62rsicEL5K+RYjmtnIecXvs3BkyfmJKpd010JFAdMpt
X-Google-Smtp-Source: AGHT+IFxCz3X/NiuL9l3GU69L+ELY65+WyrxMj5UStSNJsNFkzaTv6I66mJ+v8iby9DMJIHXzaHmF5wLxQsI3EPxKaw=
X-Received: by 2002:a05:6000:440d:b0:3a4:ef33:e60 with SMTP id
 ffacd0b85a97d-3a8ff51fc03mr355996f8f.40.1750963306620; Thu, 26 Jun 2025
 11:41:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8734bmoemx.fsf@fau.de> <20250626124933.13250-1-luis.gerhorst@fau.de>
In-Reply-To: <20250626124933.13250-1-luis.gerhorst@fau.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 26 Jun 2025 11:41:35 -0700
X-Gm-Features: Ac12FXx82L6ohGAunqifMz-Uc5pWwIrwFxb2RzZhw8B4U-G1-CkTsh6Ji-JdaBI
Message-ID: <CAADnVQJn5CXOpr6XWUh=8zbaG4u6pAD75xJ6jqHyTD6hx3QTfQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] bpf: Fix aux usage after do_check_insn()
To: Luis Gerhorst <luis.gerhorst@fau.de>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Paul Chaignon <paul.chaignon@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	syzbot+dc27c5fb8388e38d2d37@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 5:50=E2=80=AFAM Luis Gerhorst <luis.gerhorst@fau.de=
> wrote:
>
> We must terminate the speculative analysis if the just-analyzed insn had
> nospec_result set. Using cur_aux() here is wrong because insn_idx might
> have been incremented by do_check_insn().
>
> Reported-by: Paul Chaignon <paul.chaignon@gmail.com>
> Reported-by: Eduard Zingerman <eddyz87@gmail.com>
> Reported-by: syzbot+dc27c5fb8388e38d2d37@syzkaller.appspotmail.com
> Fixes: d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1")
> Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
> ---
>  kernel/bpf/verifier.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f403524bd215..88613fb71b16 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19955,11 +19955,11 @@ static int do_check(struct bpf_verifier_env *en=
v)
>                         /* Prevent this speculative path from ever reachi=
ng the
>                          * insn that would have been unsafe to execute.
>                          */
> -                       cur_aux(env)->nospec =3D true;
> +                       env->insn_aux_data[prev_insn_idx].nospec =3D true=
;

May be introduce prev_aux() similar to cur_aux() ?

In the future don't bother with RFC tag, since CI won't test them.

>                         /* If it was an ADD/SUB insn, potentially remove =
any
>                          * markings for alu sanitization.
>                          */
> -                       cur_aux(env)->alu_state =3D 0;
> +                       env->insn_aux_data[prev_insn_idx].alu_state =3D 0=
;
>                         goto process_bpf_exit;
>                 } else if (err < 0) {
>                         return err;
> @@ -19968,7 +19968,7 @@ static int do_check(struct bpf_verifier_env *env)
>                 }
>                 WARN_ON_ONCE(err);
>
> -               if (state->speculative && cur_aux(env)->nospec_result) {
> +               if (state->speculative && env->insn_aux_data[prev_insn_id=
x].nospec_result) {
>                         /* If we are on a path that performed a jump-op, =
this
>                          * may skip a nospec patched-in after the jump. T=
his can
>                          * currently never happen because nospec_result i=
s only
> @@ -19977,6 +19977,8 @@ static int do_check(struct bpf_verifier_env *env)
>                          * never skip the following insn. Still, add a wa=
rning
>                          * to document this in case nospec_result is used
>                          * elsewhere in the future.
> +                        *
> +                        * Therefore, no special case for ldimm64/call re=
quired.
>                          */
>                         WARN_ON_ONCE(env->insn_idx !=3D prev_insn_idx + 1=
);

While at it replace with verifier_bug_if().

