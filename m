Return-Path: <bpf+bounces-16917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C80807856
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 20:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E287C282187
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 19:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C8949F73;
	Wed,  6 Dec 2023 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCSAdT06"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E1CD5A
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 11:04:27 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2ca208940b3so1430751fa.1
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 11:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701889466; x=1702494266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2l8pjmuTc8xbY4ZIK8D/0LplLwlIhOzVvZTgVWtp2w=;
        b=cCSAdT06JdsnYqGuZy5OIMoOesovfJt/xAs+r99a2YhzJEl6GqHx35P10JOSB/T3Vk
         m8Fp4SylGrRwrMbqL8G03vPbGGB8VYrfMkhawYdRIwdHaLzjAtoIn8XlkRMSCi1no/aZ
         cEv8kXaVlNJRAhH4jwp6mMOwiMJNOwDrP4o1c+LU4Kd19q2Bs8USLn1tKamr5vSaeHhv
         KtDK5JQZNHlDgdXYW8ZZA7iCJZT0Vf7v5CmRnV7R9zlvAdigrvhKrftb9blJlDuK0ubI
         BpVwe42B2XX77EiBN6nfHZZlHJfjsVlUskrHOHJXz1VhOc9XOJv0WMSb9L3HyC4139F+
         veCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701889466; x=1702494266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2l8pjmuTc8xbY4ZIK8D/0LplLwlIhOzVvZTgVWtp2w=;
        b=ZlT8cMvM9cPGnUFetkp+uBh279CSI2mDl2Xf1mLfc7DEeEWgZNHNQBtmJYZ2y4L0JH
         cisMkJIlEMK62OByMfG+jejPXwOz6ajixZ4MjuW+acN1frPfyy8Hwuxx8Q11r1s4BKxR
         lLriw0SIO4M8UkYTxasNpcRaeMCXjiejEDusfzRPRJ87OGscuZN91N2wtals6wvH7tlr
         u/0kKYGg9v35l5izNhmkpaCFhcQ2aFIf0mxsks0MMb41t9iOI7JUYv7pHjp4UnYbp4Hb
         /EaM64O5y4CEBkQJtP9+1lAUkUE9FQNOeivCrfXDNoiUxwCF2a14/Hjznf4C+mBEMZRb
         C1Fg==
X-Gm-Message-State: AOJu0YzuXoJwLwah92tqCBV3dKyLyQH3RNPebXRGTBfYxo6SEBtVFkCD
	KkATX0p+rtbp1HNfxKQ0YXJbmzId1OvBcQDGGJI=
X-Google-Smtp-Source: AGHT+IHI4vqOqFmR9xSKZR2hxdf9buNaqIlSzTO3NfRyD+cKpP4UIkRzsp29ExE/yjP6dI4ScEspgpkZTk2FC+HLPPo=
X-Received: by 2002:a2e:a417:0:b0:2ca:1420:aa5 with SMTP id
 p23-20020a2ea417000000b002ca14200aa5mr985444ljn.6.1701889465458; Wed, 06 Dec
 2023 11:04:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206165802.380626-1-andreimatei1@gmail.com> <20231206165802.380626-3-andreimatei1@gmail.com>
In-Reply-To: <20231206165802.380626-3-andreimatei1@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Dec 2023 11:04:13 -0800
Message-ID: <CAEf4BzY+TgZGz9QSZEremGCVjTEEaynnXNMOgtwCv3NVFcOLBQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] bpf: guard stack limits against 32bit overflow
To: Andrei Matei <andreimatei1@gmail.com>
Cc: bpf@vger.kernel.org, sunhao.th@gmail.com, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 8:58=E2=80=AFAM Andrei Matei <andreimatei1@gmail.com=
> wrote:
>
> This patch promotes the arithmetic around checking stack bounds to be
> done in the 64-bit domain, instead of the current 32bit. The arithmetic
> implies adding together a 64-bit register with a int offset. The
> register was checked to be below 1<<29 when it was variable, but not
> when it was fixed. The offset either comes from an instruction (in which
> case it is 16 bit), from another register (in which case the caller
> checked it to be below 1<<29 [1]), or from the size of an argument to a
> kfunc (in which case it can be a u32 [2]). Between the register being
> inconsistently checked to be below 1<<29, and the offset being up to an
> u32, it appears that we were open to overflowing the `int`s which were
> currently used for arithmetic.
>
> [1] https://github.com/torvalds/linux/blob/815fb87b753055df2d9e50f6cd80eb=
10235fe3e9/kernel/bpf/verifier.c#L7494-L7498
> [2] https://github.com/torvalds/linux/blob/815fb87b753055df2d9e50f6cd80eb=
10235fe3e9/kernel/bpf/verifier.c#L11904
>
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> Reported-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> ---
>  kernel/bpf/verifier.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 137240681fa9..6832ed743765 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6577,7 +6577,7 @@ static int check_ptr_to_map_access(struct bpf_verif=
ier_env *env,
>   * The minimum valid offset is -MAX_BPF_STACK for writes, and
>   * -state->allocated_stack for reads.
>   */
> -static int check_stack_slot_within_bounds(int off,
> +static int check_stack_slot_within_bounds(s64 off,
>                                           struct bpf_func_state *state,
>                                           enum bpf_access_type t)
>  {
> @@ -6606,7 +6606,7 @@ static int check_stack_access_within_bounds(
>         struct bpf_reg_state *regs =3D cur_regs(env);
>         struct bpf_reg_state *reg =3D regs + regno;
>         struct bpf_func_state *state =3D func(env, reg);
> -       int min_off, max_off;
> +       s64 min_off, max_off;
>         int err;
>         char *err_extra;
>
> @@ -6619,7 +6619,7 @@ static int check_stack_access_within_bounds(
>                 err_extra =3D " write to";
>
>         if (tnum_is_const(reg->var_off)) {
> -               min_off =3D reg->var_off.value + off;
> +               min_off =3D (s64)reg->var_off.value + off;
>                 max_off =3D min_off + access_size;
>         } else {
>                 if (reg->smax_value >=3D BPF_MAX_VAR_OFF ||
> --
> 2.39.2
>

