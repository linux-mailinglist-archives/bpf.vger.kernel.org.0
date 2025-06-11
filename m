Return-Path: <bpf+bounces-60410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B096FAD6266
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 00:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14981BC0CDE
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 22:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9675A2494F0;
	Wed, 11 Jun 2025 22:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQfdrNK/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A237CDF49;
	Wed, 11 Jun 2025 22:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681420; cv=none; b=t4lR7xU09EkAfZuBCjB8a3C8cAhxc1ZJ8I3QOMDfIvSAWZvX7fdBzJ5OHQAuCik6OJ2GFjlrDrwLwyM9Bcp+40BHGYY0x01uKm8xS3fQGAw4hZofemgmAaUFOyjG2txcfo6h6QjPStEIIxMjtfXEkkPkDltZKdpcUOcaYX2IILk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681420; c=relaxed/simple;
	bh=5f2E+EXc2DZqW2oloEm8WkZhdeV5+LJ4dcl1CoRMOg0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TjU63BvjuaXbF7J9JYPSsMXJrt2uJPUtpUyPdkodT3AhNqDy/q6W4o+7QwPBhk2eidLS+zgQi9UhVYF60q2le0AwmzDHcNdhJvUVyk0s0S27n2PJ+dfgc31zhzZEYuuJJse0auC7yngRzdHmT0VImZL1XhkMbKs/1jvIqOhN8VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQfdrNK/; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso514492b3a.2;
        Wed, 11 Jun 2025 15:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749681418; x=1750286218; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hhf1uehRjhJs5pv4ny+0Okf/DqV+mB2pWhG99O6ENKM=;
        b=TQfdrNK/xB86puW5hbroBeMBYJ07plLtHEdDCmhixNsIXYzRDQoVAgXoyIbWTEVkSE
         JANnbz6MytiwiTagFgyBclmIZ4ppD+Tkgo9K/TbhV4cFrxO5OhgDvxAZ30Cs/QanoWbU
         GDaFIGDlzQ5I1jxSbopl9Cxye/ksf9CBKhwlKz9wvtXK3LjBeSRBsm06AKLJdlK3Kf09
         XRE904xc9XSuz4pcWFARpPf9zcymJUdSCVJsvACWlYhG51k8GM5xrsEBaXWzyToV8cgQ
         9FoeKSlcHjIfeFoGOmkE/Nr2+QAJyZWTFvoDPSZj/eZpo7cEAwv15MxwIb2kwiw7FipV
         7eMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681418; x=1750286218;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hhf1uehRjhJs5pv4ny+0Okf/DqV+mB2pWhG99O6ENKM=;
        b=K8Dz4dkKQkF6fj3d/rdwFfL5f3OcuRbsXhAy9vxTjBmFdUa2qb/EfYYkt9sqsj580k
         L9LCVoXM4yIkQ3ppISqeuWTZu1nQj4pu38zVnNCWUh5e1Zoih8EXtHV+agTGl+NHtuon
         ohE/MkpJIyf1a/Egxq3uXvXVl7B8V7dSmgt+lVJAPxAfZk/tgZjK0YXWCgZqhtqWnA3T
         mofmH5QRaLS8M2MaraLDLSMW2Qi7yz3h8gKmG1TPvfaYPkv3ZaXxh54zey5i7N+yJErz
         RiLSTMr73z0zq3DxD1VbWcJI+DGhOL8Hm5XsZeD/umVRxxfmLOWhDcUHYcfshk6YJBE0
         veYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqARl7ZYGpFvV2Ed/EpbbRHpVCuMUMvTuNxhkd0WtBzejrOIc6igU8mmYenQFWQSLEhR3BPikXtxEFEZX5@vger.kernel.org, AJvYcCVWkMd+7kxs6FotXINQ0Mdz96Xpegwzux8Qx5OUmIVQfSAYeGshgvCgB1Fw0FeA9QEpeE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmtaPntukkx6it4V3r7isqF95Z+KFZCzTBXXs0FVQ6ka2syhvr
	4Jv1a9lrUeD8Y8pTzz2LQVxkbMdF3JUzE9t3NkHJgAB2q8YKvF5GagKo
X-Gm-Gg: ASbGncsxCNQ6mfoySKK56Gwk7cGTBpid/SC8R8beX7ucoA8w+HfmnFDvn9eMwgSuRxA
	Dj5+wagw77WhT/G50K49kGi3x1kILI3RQto8/4PPagRCwrEO275yfD8Bm8EIEh/EwnK2NHsBwZh
	zW+gGFKtR/UG/t5FfciddqSo5G32L+Ak7HT5eg7sLlmLVuasu92dwr/r0Das8mULyvqeLhDrFbb
	W3c+YPJUm7ZRLEZoTimrAm3pD0tEcMh1k/EX/pWgvL1hCM/o4/xV8H66ZYPGootFAGzrXk/Nc4k
	l4D7V/irw3mv6hguH3f24mG/sqPHLzVYMuONz2d4Nr477Uq4flPSv72HFSiardEx3TXAAAglg5d
	pVSY+Si9qaYq3mJJ5l8mb
X-Google-Smtp-Source: AGHT+IFUg1MKtIofsyQGj6cN0ii/Cuud84cId2ClEBQrDGWE4i/ezu24W10KwuWVwTNnzAYpfc4CcQ==
X-Received: by 2002:a05:6a21:a45:b0:1f5:6e71:e55 with SMTP id adf61e73a8af0-21f866000c9mr7364924637.6.1749681417811;
        Wed, 11 Jun 2025 15:36:57 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:b1d2:545:de25:d977? ([2620:10d:c090:500::7:d234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488087a260sm97152b3a.17.2025.06.11.15.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:36:57 -0700 (PDT)
Message-ID: <19f50af28e3a90cbd24b2325da8025e47f221739.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Remove redundant
 free_verifier_state()/pop_stack()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Luis Gerhorst <luis.gerhorst@fau.de>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko	 <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu	 <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh	 <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Wed, 11 Jun 2025 15:36:55 -0700
In-Reply-To: <20250611211431.275731-1-luis.gerhorst@fau.de>
References: <b6931bd0dd72327c55287862f821ca6c4c3eb69a.camel@gmail.com>
	 <20250611211431.275731-1-luis.gerhorst@fau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-11 at 23:14 +0200, Luis Gerhorst wrote:
> This patch removes duplicated code.
>=20
> Eduard points out [1]:
>=20
>     Same cleanup cycles are done in push_stack() and push_async_cb(),
>     both functions are only reachable from do_check_common() via
>     do_check() -> do_check_insn().
>=20
>     Hence, I think that cur state should not be freed in push_*()
>     functions and pop_stack() loop there is not needed.
>=20
> This would also fix the 'symptom' for [2], but the issue also has a
> simpler fix which was sent separately. This fix also makes sure the
> push_*() callers always return an error for which
> error_recoverable_with_nospec(err) is false. This is required because
> otherwise we try to recover and access the stale `state`.
>=20
> [1] https://lore.kernel.org/all/b6931bd0dd72327c55287862f821ca6c4c3eb69a.=
camel@gmail.com/
> [2] https://lore.kernel.org/all/68497853.050a0220.33aa0e.036a.GAE@google.=
com/
>=20
> Reported-by: Eduard Zingerman <eddyz87@gmail.com>
> Link: https://lore.kernel.org/all/b6931bd0dd72327c55287862f821ca6c4c3eb69=
a.camel@gmail.com/
> Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  kernel/bpf/verifier.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d3bff0385a55..fa147c207c4b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2066,10 +2066,10 @@ static struct bpf_verifier_state *push_stack(stru=
ct bpf_verifier_env *env,
>  	}
>  	return &elem->st;
>  err:
> -	free_verifier_state(env->cur_state, true);
> -	env->cur_state =3D NULL;
> -	/* pop all elements and return */
> -	while (!pop_stack(env, NULL, NULL, false));
> +	/* free_verifier_state() and pop_stack() loop will be done in
> +	 * do_check_common(). Caller must return an error for which
> +	 * error_recoverable_with_nospec(err) is false.
> +	 */

Nit: I think these comments are unnecessary as same logic applies to many p=
laces.

>  	return NULL;
>  }
> =20
> @@ -2838,10 +2838,10 @@ static struct bpf_verifier_state *push_async_cb(s=
truct bpf_verifier_env *env,
>  	elem->st.frame[0] =3D frame;
>  	return &elem->st;
>  err:
> -	free_verifier_state(env->cur_state, true);
> -	env->cur_state =3D NULL;
> -	/* pop all elements and return */
> -	while (!pop_stack(env, NULL, NULL, false));
> +	/* free_verifier_state() and pop_stack() loop will be done in
> +	 * do_check_common(). Caller must return an error for which
> +	 * error_recoverable_with_nospec(err) is false.
> +	 */
>  	return NULL;
>  }
> =20
> @@ -22904,13 +22904,9 @@ static int do_check_common(struct bpf_verifier_e=
nv *env, int subprog)
> =20
>  	ret =3D do_check(env);
>  out:
> -	/* check for NULL is necessary, since cur_state can be freed inside
> -	 * do_check() under memory pressure.
> -	 */
> -	if (env->cur_state) {
> -		free_verifier_state(env->cur_state, true);
> -		env->cur_state =3D NULL;
> -	}
> +	WARN_ON_ONCE(!env->cur_state);
> +	free_verifier_state(env->cur_state, true);
> +	env->cur_state =3D NULL;
>  	while (!pop_stack(env, NULL, NULL, false));

Nit: while at it, I'd push both free_verifier_state() and pop_stack()
     into free_states() a few lines below.

>  	if (!ret && pop_log)
>  		bpf_vlog_reset(&env->log, 0);
>=20
> base-commit: 1d251153a480fc7467d00a8c5dabc55cc6166c43

