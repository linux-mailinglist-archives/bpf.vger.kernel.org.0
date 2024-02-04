Return-Path: <bpf+bounces-21173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAA08490AF
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 22:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DCD71F2185F
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 21:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E7A28E09;
	Sun,  4 Feb 2024 21:33:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0FB2C684
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707082400; cv=none; b=UI2979ip75LBwhjmYyQfcxg+u0dUxD5WLPIhr5T2lnqyWMul8cb9KW5Sc3n6rUQrZofoeyR+StAQ84M1OMv1UV+AKOMnKST+3aWyneZ30EwFBrzvdhme1KpuD+Zx3T2Sn1AVMjYn09q6W2vhE5Y4kNAmweEaQEa3psook6JzhNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707082400; c=relaxed/simple;
	bh=FzvZxnGjZIcpEjN3LHtpwr3DhjKFGlzst/hrHmTb8Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asaItaGI9OA49G3ZYG14WCO90QrkJapI8RVS2xObGRnUw8Es51iqdIETgM7rqUnburbsN3DE4tv08fddjLgpkCMIyhzr69U960VWdKGaaZuQMacggI5YKrbbgGVvgDA1ixKaQ1jKS1KuT/VveJUUN8wKbCeqZCIScyV4ldM20GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-210c535a19bso2389676fac.1
        for <bpf@vger.kernel.org>; Sun, 04 Feb 2024 13:33:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707082397; x=1707687197;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHaYQ5uQKUvt1qByjtK7LhatkwqLGqGODCxeMrSl//0=;
        b=QGOXyP2eGJfaam1qWo6CTvBHPqGHcvZwlkTw92stDnNqpKnxoyNnm71N8lb6Rh8Kqo
         p6pmgaUXF6mwJDjUr8gonDtn3RgBLsnjr8Rg1zvZh3yI0SGzYwy9d8SRSeH5XKVbaJUE
         6ny7ftQ4hMdByIDpvmTm8bJB1Wvt9dHujQZEijF1y8+ksb4CqPjcguoGdP54oY7iXfxK
         OyX3zTUED8mN/DFgMOPeavmByCQq9YPaMueUnb+kvoQHXdQirQuiVPTc/na1diU/pwlB
         moxKP9frN+SomFkgHwtcvMV6YjNacMnhmOqufblzBcalG+9/+hxzg0bXF+g1ODcQap/v
         23eQ==
X-Gm-Message-State: AOJu0YzV1iQjo/BuGpb77D+ujt3bVulHtCk9649OsEyRX6Kjk/1+l5xB
	GwxM1GCh1R8qZQcCiKC7jpji1hGvfW4A2m7gn5P7CTyQtdgYQcwm
X-Google-Smtp-Source: AGHT+IHZsVXik/nItP9CgOOoF8X5V1pQzBjE5TSVsCKDkNNpxPPbQEqeTX2kSUz0NTfVhO23/4bbuQ==
X-Received: by 2002:a05:6870:d0c7:b0:210:b468:6a5d with SMTP id k7-20020a056870d0c700b00210b4686a5dmr6454078oaa.16.1707082397009;
        Sun, 04 Feb 2024 13:33:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWiD5O2eDuTI8e4ahSZ1Gzcymvhj8uh+FEHXDgPozwHf0YRaG0NelfbzqCtiGdMay+Ha7h0MX0FmFE4Sm3UWt/mOmsmhqXV8GA5KTZ5Z/nqQxU7QB4Q/ttXJ2v+56tXtAbpjl99RSbgX0ZZySPfYMcrkj13MStOGQUs7q0JajCdC0dISAnFu4nzW+rcePDdiaBs/7GewlQBj45SMg6DJg==
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id od17-20020a0562142f1100b0068c89d8eb53sm2577103qvb.81.2024.02.04.13.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 13:33:16 -0800 (PST)
Date: Sun, 4 Feb 2024 15:33:13 -0600
From: David Vernet <void@manifault.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Barret Rhoden <brho@google.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Allow calling static subprogs while
 holding a bpf_spin_lock
Message-ID: <20240204213313.GB120243@maniforge>
References: <20240204120206.796412-1-memxor@gmail.com>
 <20240204120206.796412-2-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k2IFLOOOgVGlbSVG"
Content-Disposition: inline
In-Reply-To: <20240204120206.796412-2-memxor@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--k2IFLOOOgVGlbSVG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 04, 2024 at 12:02:05PM +0000, Kumar Kartikeya Dwivedi wrote:
> Currently, calling any helpers, kfuncs, or subprogs except the graph
> data structure (lists, rbtrees) API kfuncs while holding a bpf_spin_lock
> is not allowed. One of the original motivations of this decision was to
> force the BPF programmer's hand into keeping the bpf_spin_lock critical
> section small, and to ensure the execution time of the program does not
> increase due to lock waiting times. In addition to this, some of the
> helpers and kfuncs may be unsafe to call while holding a bpf_spin_lock.
>=20
> However, when it comes to subprog calls, atleast for static subprogs,
> the verifier is able to explore their instructions during verification.
> Therefore, it is similar in effect to having the same code inlined into
> the critical section. Hence, not allowing static subprog calls in the
> bpf_spin_lock critical section is mostly an annoyance that needs to be
> worked around, without providing any tangible benefit.
>=20
> Unlike static subprog calls, global subprog calls are not safe to permit
> within the critical section, as the verifier does not explore them
> during verification, therefore whether the same lock will be taken
> again, or unlocked, cannot be ascertained.
>=20
> Therefore, allow calling static subprogs within a bpf_spin_lock critical
> section, and only reject it in case the subprog linkage is global.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Looks good, thanks for this improvement. I had the same suggestion as
Yonghong in [0], and also left a question below.

[0]: https://lore.kernel.org/all/2e008ab1-44b8-4d1b-a86d-1f347d7630e6@linux=
=2Edev/

Acked-by: David Vernet <void@manifault.com>

> ---
>  kernel/bpf/verifier.c                                  | 10 +++++++---
>  tools/testing/selftests/bpf/progs/verifier_spin_lock.c |  2 +-
>  2 files changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 64fa188d00ad..f858c959753b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9493,6 +9493,12 @@ static int check_func_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
>  	if (subprog_is_global(env, subprog)) {
>  		const char *sub_name =3D subprog_name(env, subprog);
> =20
> +		/* Only global subprogs cannot be called with a lock held. */
> +		if (env->cur_state->active_lock.ptr) {
> +			verbose(env, "function calls are not allowed while holding a lock\n");
> +			return -EINVAL;
> +		}
> +
>  		if (err) {
>  			verbose(env, "Caller passes invalid args into func#%d ('%s')\n",
>  				subprog, sub_name);
> @@ -17644,7 +17650,6 @@ static int do_check(struct bpf_verifier_env *env)
> =20
>  				if (env->cur_state->active_lock.ptr) {
>  					if ((insn->src_reg =3D=3D BPF_REG_0 && insn->imm !=3D BPF_FUNC_spin=
_unlock) ||
> -					    (insn->src_reg =3D=3D BPF_PSEUDO_CALL) ||
>  					    (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&
>  					     (insn->off !=3D 0 || !is_bpf_graph_api_kfunc(insn->imm)))) {
>  						verbose(env, "function calls are not allowed while holding a lock\=
n");
> @@ -17692,8 +17697,7 @@ static int do_check(struct bpf_verifier_env *env)
>  					return -EINVAL;
>  				}
>  process_bpf_exit_full:
> -				if (env->cur_state->active_lock.ptr &&
> -				    !in_rbtree_lock_required_cb(env)) {
> +				if (env->cur_state->active_lock.ptr && !env->cur_state->curframe) {

Can we do the same thing here for the RCU check below? It seems like the
exact same issue, as we're already allowed to call subprogs from within
an RCU read region, but the verifier will get confused and think we
haven't unlocked by the time we return to the caller.

Assuming that's the case, we can take care of it in a separate patch
set.

>  					verbose(env, "bpf_spin_unlock is missing\n");
>  					return -EINVAL;
>  				}
> diff --git a/tools/testing/selftests/bpf/progs/verifier_spin_lock.c b/too=
ls/testing/selftests/bpf/progs/verifier_spin_lock.c
> index 9c1aa69650f8..fb316c080c84 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
> @@ -330,7 +330,7 @@ l1_%=3D:	r7 =3D r0;					\
> =20
>  SEC("cgroup/skb")
>  __description("spin_lock: test10 lock in subprog without unlock")
> -__failure __msg("unlock is missing")
> +__success
>  __failure_unpriv __msg_unpriv("")
>  __naked void lock_in_subprog_without_unlock(void)
>  {
> --=20
> 2.40.1
>=20

--k2IFLOOOgVGlbSVG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcACmQAKCRBZ5LhpZcTz
ZMTfAQDengrt816+YYHpRVwYQByScEMYDLsspBssIZ/RG435mgEAnNgoQKbFLiMC
KpUSn4E8q+N0dYSQ4aA6ua/HZVqJMgc=
=GK00
-----END PGP SIGNATURE-----

--k2IFLOOOgVGlbSVG--

