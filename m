Return-Path: <bpf+bounces-45394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821D19D510E
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 17:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0745C1F269CC
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 16:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659691AB6CE;
	Thu, 21 Nov 2024 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcibVyPa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777CD1A01C6
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732208261; cv=none; b=fM5Nn0ZKjopMKeor+HQuoCjQGPGuLB/3U05yY7RG5AHNA5xvRv0zBc78IeUntLT6d0uQg55afsQcenmL/9vaiAukTO9hXYlCMalZMy53vzt4Cyx53yJiKXGbvU0ls+Kz4I66OkyeDz4KZ1McDijR4Nv/Ro9EmvN2pJZh34IiGsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732208261; c=relaxed/simple;
	bh=qJ4GwyGBFzsCJk0aKw/+Pp7ix2ShBQRrtvHkGRJB1Eg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X4a5XobXaWmBhoZhfZrUXAQMwx2/5fC8WzDYyl6/NJwNEN3APlo0wynaOLa5zEV7JC2lzJ5AC7OICLd5euYCmJUt6jiaxS9RND5Zf0n5teZInxtVw5wntUu+I2V3mq2UhqEJ9/bk71AkvHV9lMmzB4tXoSndX40AD57W4GYVA6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcibVyPa; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21290973bcbso9321335ad.3
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 08:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732208259; x=1732813059; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X3EaFkrdQ70NXzttkdtKI+m1NqX8mWOBFoj9dLRyGKA=;
        b=EcibVyPahIjtSOtJvIT2lQgiiJFvVX7vKH2SkEnv4rMRPfPmwvJIiUgX0PTA0CBSNu
         BwD6/clznyLMRrokYk2r3Oc0pd+F+fQDDSDqK2oupmYYs2UBx9rX/+50kngxCyPSEGhl
         KWNAzBQOgoxkbibEjaBnpXVfbIguZGE7Rdbq9SLNTNLdioVAjX4yZklDXaqdBFU1RPm2
         2Ol2NwPvOq7r+xtEAR7KWlRlea4iJ+Fo7+Bq/YpKP+tC9diHO3XNVV/AZ8BzEEVnFNxn
         Vj/dgl2mJoLpBbrRkX7cFTnofmUBc0w3bjrYLt/pJxs5WQTC9Q1McH0J+irb0sTBt3U5
         FsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732208259; x=1732813059;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X3EaFkrdQ70NXzttkdtKI+m1NqX8mWOBFoj9dLRyGKA=;
        b=Ry8XOUZJ9+AmxTMBFY8Gukfh8hdbKBa5WFgArzZeVT/DcIjsWBcIKE9hswN48q40qz
         QxXwRGJz9g2ZBNZMFjmiV0GKUfDpkvi0WYLZ76WWyEId4do2ZLHeQDo4R3RvvBjRrnEo
         VDiACU8m/UUx4Fn14ui/wJ5eOsDcy26m8SVk6Crow9eSb95KxBMKQjK2jJDmpVVAXrax
         j6PfvHKD0VxtDggDjjnSP2JB1JN1gL3+dSnRNHt7FVaXbXVnFCjkQ4S6yRyeUfe7gXEe
         3twNNml/6NAv8PegQ4cw4nrFsKclKEcNRMyXkGNRxu+RHaQDzhqiae7AIvwkLutZFNkZ
         U9Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXSHA0BenVOUWU1VURYKKE4LoXw5BlyNBmZWQ+SXCPskSi4SBC314kk/qb6wvT/rQc4biE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7StY6pmle4ElaoSNDnlhTtkobT5SHHoMdcNEsJnrhLCtRT8mN
	9PWX6NZB2Kk1cbm1Gf8SB2IVtiqEyd3EaKT6omUUn1Q4kzIRnZrj
X-Gm-Gg: ASbGncuKjfmQP20MbLpRyCTHZWbt+CbXM4KOD4c19K76LEhbaqxrnYOQns177+iRr2p
	doxMFP/5CscKjdumKMbH/4NcxRsPY7sGSNE5e8Y6gXpTU7apqECjoApQUI7IU1FU/FKRq2r1I1p
	EucAkuFaZE0l+mRqdVzdu+QZe6meci4NKv3T7ogktRwInmNhb6W8S/OOk9TN6ntTjsOtpCb3cyi
	kuntWLYY0KAK98S1a+CyCeTJw6ClFw87EGtcVxWA8QofY8=
X-Google-Smtp-Source: AGHT+IE630HPbMIB0EpEyKAJ67D+zqZ1x8O74AJ3SIhkT+f/lTm0uWW7nb8vbVUu1KbK0s2ILHYzpw==
X-Received: by 2002:a17:902:cec7:b0:212:1abb:fe65 with SMTP id d9443c01a7336-2126fd89c77mr81484575ad.35.1732208258076;
        Thu, 21 Nov 2024 08:57:38 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc13a14sm433755ad.204.2024.11.21.08.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 08:57:37 -0800 (PST)
Message-ID: <4be3db522e31ea88119751d4e2d64a9e90397f6c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/7] bpf: Refactor and rename resource
 management
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, kernel-team@fb.com
Date: Thu, 21 Nov 2024 08:57:32 -0800
In-Reply-To: <20241121005329.408873-2-memxor@gmail.com>
References: <20241121005329.408873-1-memxor@gmail.com>
	 <20241121005329.408873-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-20 at 16:53 -0800, Kumar Kartikeya Dwivedi wrote:
> With the commit f6b9a69a9e56 ("bpf: Refactor active lock management"),
> we have begun using the acquired_refs array to also store active lock
> metadata, as a way to consolidate and manage all kernel resources that
> the program may acquire.
>=20
> This is beginning to cause some confusion and duplication in existing
> code, where the terms references now both mean lock reference state and
> the references for acquired kernel object pointers. To clarify and
> improve the current state of affairs, as well as reduce code duplication,
> make the following changes:
>=20
> Rename bpf_reference_state to bpf_resource_state, and begin using
> resource as the umbrella term. This terminology matches what we use in
> check_resource_leak. Next, "reference" now only means RES_TYPE_PTR, and
> the usage and meaning is updated accordingly.
>=20
> Next, factor out common code paths for managing addition and removal of
> resource state in acquire_resource_state and erase_resource_state, and
> then implement type specific resource handling on top of these common
> functions. Overall, this patch improves upon the confusion and minimizes
> code duplication, as we prepare to introduce new resource types in
> subsequent patches.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Tbh, I like the old name a bit more.
The patch itself looks good.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -1342,6 +1342,25 @@ static int grow_stack_state(struct bpf_verifier_en=
v *env, struct bpf_func_state
>  	return 0;
>  }
> =20
> +static struct bpf_resource_state *acquire_resource_state(struct bpf_veri=
fier_env *env, int insn_idx, int *id)

Nit: there is no need to pass `int *id`, as it is available as (returned)->=
id.

> +{
> +	struct bpf_func_state *state =3D cur_func(env);
> +	int new_ofs =3D state->acquired_res;
> +	struct bpf_resource_state *s;
> +	int err;
> +
> +	err =3D resize_resource_state(state, state->acquired_res + 1);
> +	if (err)
> +		return NULL;
> +	s =3D &state->res[new_ofs];
> +	s->type =3D RES_TYPE_INV;
> +	if (id)
> +		*id =3D s->id =3D ++env->id_gen;
> +	s->insn_idx =3D insn_idx;
> +
> +	return s;
> +}
> +
>  /* Acquire a pointer id from the env and update the state->refs to inclu=
de
>   * this new pointer reference.
>   * On success, returns a valid pointer id to associate with the register

[...]

> @@ -1349,55 +1368,52 @@ static int grow_stack_state(struct bpf_verifier_e=
nv *env, struct bpf_func_state

[...]

> -/* release function corresponding to acquire_reference_state(). Idempote=
nt. */
> +static void erase_resource_state(struct bpf_func_state *state, int res_i=
dx)

Nit: why not "release_..." to be consistent with the rest of the functions?

> +{
> +	int last_idx =3D state->acquired_res - 1;
> +
> +	if (last_idx && res_idx !=3D last_idx)
> +		memcpy(&state->res[res_idx], &state->res[last_idx], sizeof(*state->res=
));
> +	memset(&state->res[last_idx], 0, sizeof(*state->res));
> +	state->acquired_res--;
> +}
> +
>  static int release_reference_state(struct bpf_func_state *state, int ptr=
_id)
>  {
> -	int i, last_idx;
> +	int i;
> =20
> -	last_idx =3D state->acquired_refs - 1;
> -	for (i =3D 0; i < state->acquired_refs; i++) {
> -		if (state->refs[i].type !=3D REF_TYPE_PTR)
> +	for (i =3D 0; i < state->acquired_res; i++) {
> +		if (state->res[i].type !=3D RES_TYPE_PTR)
>  			continue;
> -		if (state->refs[i].id =3D=3D ptr_id) {
> -			if (last_idx && i !=3D last_idx)
> -				memcpy(&state->refs[i], &state->refs[last_idx],
> -				       sizeof(*state->refs));
> -			memset(&state->refs[last_idx], 0, sizeof(*state->refs));
> -			state->acquired_refs--;
> +		if (state->res[i].id =3D=3D ptr_id) {
> +			erase_resource_state(state, i);
>  			return 0;
>  		}
>  	}

[...]


