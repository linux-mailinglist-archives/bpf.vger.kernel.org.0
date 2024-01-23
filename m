Return-Path: <bpf+bounces-20106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 982B283979E
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 19:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF101F22464
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 18:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594A881AC3;
	Tue, 23 Jan 2024 18:26:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3499781AB9
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 18:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706034384; cv=none; b=pkTCf+1Iyax2ETcG7BWp5sHGCHcaDJaEEBCDrzhRy53npUNl19lrMb3m9MfsE0i8p3vMezgkIcoC/ym74TJXjfgx6s6F/3rB3yJNqvyzrz8EdWW1EGHLWG8ViF0iSFoeEgKhpUmaKi2Sb5UzaK9HjLMLJDPprgzIm3yHuSskgQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706034384; c=relaxed/simple;
	bh=sklRYXsrWatD0LfImm3XwKgOhgfv2CCmj0iXWcUVozw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPfV+TXyLZgbomj61qnPWPuDMfGHJP8+Drs+oDDM9eOBKjkheA6uWRJ3z4QpKw13UCfrP8olwRWYEOZ/VoDoPdwB9LgEfAP1taCyxLJS09OqAhM7FPTM+MS9+rZErDjr+zpSnfpEFW2la0S+ZuQctMgUBAmpyDafr7q5eop7gpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bd5c4cffefso4566713b6e.1
        for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 10:26:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706034381; x=1706639181;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebqGzu96Kuc9gGZxIyJVkci09G3Y1oLR5hv9cSycIKA=;
        b=CR4CYZqxwvJCTkIgP4GX1KcyrnFvyTZWoQvyEMZh864KkluAzjfW7mLm1Y1hVJvYyR
         D84ZlQz4isHIh2rIAPy0evkBycv06mBdm97V+7rLKugwZd06h3n4lsnuBz9xHbltoeyO
         pxhYAbng4pA42lYty+fuc30m02aMXiKD+RDaCop35RQzEBqBxjc3p6nz/KE2Dvie9e+B
         LMgvHVbCf+JlgIZ5D1ZxyUpvoMQGqWXiNJELu3Bk8Yd1yY/00EVEguWmwYhrQQafSQiq
         l7lqhfi47811qNnd3tIAjupyZYJM0Z+7ykAu2bn0k/+X7MOQINZnmUd9svG8d2CH/AdR
         ysDQ==
X-Gm-Message-State: AOJu0YwKP9ytYTgrjo6BPp1WdxV+styit2pC12KoGSdUTIKDoAd+hyzk
	YRKnuyD0cSOuXb31XUZu9vxx2xWKj+AHoDddgZsdZZqZ12O1MpyC
X-Google-Smtp-Source: AGHT+IFQFuIlHuRg+UJIRN7s5xFv2PITfSHohZhnnGgkfP+/tYPSUWUSmDfM1PjlZ+99IhQ41Dn22g==
X-Received: by 2002:a05:6870:890a:b0:204:371:f5a9 with SMTP id i10-20020a056870890a00b002040371f5a9mr1940071oao.38.1706034380854;
        Tue, 23 Jan 2024 10:26:20 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id cc21-20020a05622a411500b00429acfe5bb4sm3693026qtb.40.2024.01.23.10.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 10:26:20 -0800 (PST)
Date: Tue, 23 Jan 2024 12:26:17 -0600
From: David Vernet <void@manifault.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 1/3] bpf: Add bpf_iter_cpumask kfuncs
Message-ID: <20240123182617.GA30071@maniforge>
References: <20240123152716.5975-1-laoar.shao@gmail.com>
 <20240123152716.5975-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gXgZBRmmdpPcPr0u"
Content-Disposition: inline
In-Reply-To: <20240123152716.5975-2-laoar.shao@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--gXgZBRmmdpPcPr0u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 11:27:14PM +0800, Yafang Shao wrote:
> Add three new kfuncs for bpf_iter_cpumask.
> - bpf_iter_cpumask_new
>   KF_RCU is defined because the cpumask must be a RCU trusted pointer
>   such as task->cpus_ptr.
> - bpf_iter_cpumask_next
> - bpf_iter_cpumask_destroy
>=20
> These new kfuncs facilitate the iteration of percpu data, such as
> runqueues, psi_cgroup_cpu, and more.
>=20
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Thanks for working on this, this will be nice to have!

> ---
>  kernel/bpf/cpumask.c | 82 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>=20
> diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> index 2e73533a3811..474072a235d6 100644
> --- a/kernel/bpf/cpumask.c
> +++ b/kernel/bpf/cpumask.c
> @@ -422,6 +422,85 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpum=
ask *cpumask)
>  	return cpumask_weight(cpumask);
>  }
> =20
> +struct bpf_iter_cpumask {
> +	__u64 __opaque[2];
> +} __aligned(8);
> +
> +struct bpf_iter_cpumask_kern {
> +	struct cpumask *mask;
> +	int cpu;
> +} __aligned(8);

Why do we need both of these if we're not going to put the opaque
iterator in UAPI?

> +
> +/**
> + * bpf_iter_cpumask_new() - Create a new bpf_iter_cpumask for a specifie=
d cpumask
> + * @it: The new bpf_iter_cpumask to be created.
> + * @mask: The cpumask to be iterated over.
> + *
> + * This function initializes a new bpf_iter_cpumask structure for iterat=
ing over
> + * the specified CPU mask. It assigns the provided cpumask to the newly =
created
> + * bpf_iter_cpumask @it for subsequent iteration operations.
> + *
> + * On success, 0 is returen. On failure, ERR is returned.
> + */
> +__bpf_kfunc int bpf_iter_cpumask_new(struct bpf_iter_cpumask *it, const =
struct cpumask *mask)
> +{
> +	struct bpf_iter_cpumask_kern *kit =3D (void *)it;
> +
> +	BUILD_BUG_ON(sizeof(struct bpf_iter_cpumask_kern) > sizeof(struct bpf_i=
ter_cpumask));
> +	BUILD_BUG_ON(__alignof__(struct bpf_iter_cpumask_kern) !=3D
> +		     __alignof__(struct bpf_iter_cpumask));

Why are we checking > in the first expression instead of just plain
equality?

> +
> +	kit->mask =3D bpf_mem_alloc(&bpf_global_ma, sizeof(struct cpumask));

Probably better to use cpumask_size() here.

> +	if (!kit->mask)
> +		return -ENOMEM;
> +
> +	cpumask_copy(kit->mask, mask);
> +	kit->cpu =3D -1;
> +	return 0;
> +}
> +
> +/**
> + * bpf_iter_cpumask_next() - Get the next CPU in a bpf_iter_cpumask
> + * @it: The bpf_iter_cpumask
> + *
> + * This function retrieves a pointer to the number of the next CPU withi=
n the
> + * specified bpf_iter_cpumask. It allows sequential access to CPUs withi=
n the
> + * cpumask. If there are no further CPUs available, it returns NULL.
> + *
> + * Returns a pointer to the number of the next CPU in the cpumask or NUL=
L if no
> + * further CPUs.
> + */
> +__bpf_kfunc int *bpf_iter_cpumask_next(struct bpf_iter_cpumask *it)
> +{
> +	struct bpf_iter_cpumask_kern *kit =3D (void *)it;
> +	const struct cpumask *mask =3D kit->mask;
> +	int cpu;
> +
> +	if (!mask)
> +		return NULL;
> +	cpu =3D cpumask_next(kit->cpu, mask);
> +	if (cpu >=3D nr_cpu_ids)
> +		return NULL;
> +
> +	kit->cpu =3D cpu;
> +	return &kit->cpu;
> +}
> +
> +/**
> + * bpf_iter_cpumask_destroy() - Destroy a bpf_iter_cpumask
> + * @it: The bpf_iter_cpumask to be destroyed.
> + *
> + * Destroy the resource assiciated with the bpf_iter_cpumask.
> + */
> +__bpf_kfunc void bpf_iter_cpumask_destroy(struct bpf_iter_cpumask *it)
> +{
> +	struct bpf_iter_cpumask_kern *kit =3D (void *)it;
> +
> +	if (!kit->mask)
> +		return;
> +	bpf_mem_free(&bpf_global_ma, kit->mask);
> +}
> +
>  __bpf_kfunc_end_defs();
> =20
>  BTF_SET8_START(cpumask_kfunc_btf_ids)
> @@ -450,6 +529,9 @@ BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
>  BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
>  BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
>  BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
> +BTF_ID_FLAGS(func, bpf_iter_cpumask_new, KF_ITER_NEW | KF_RCU)
> +BTF_ID_FLAGS(func, bpf_iter_cpumask_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_cpumask_destroy, KF_ITER_DESTROY)
>  BTF_SET8_END(cpumask_kfunc_btf_ids)
> =20
>  static const struct btf_kfunc_id_set cpumask_kfunc_set =3D {
> --=20
> 2.39.1
>=20
>=20

--gXgZBRmmdpPcPr0u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZbAEyQAKCRBZ5LhpZcTz
ZNWjAQCE2QULLNttQYYy1fW6yEz2EDYr/3/J6mkdlQ6sYqzWyQEArUIDUHVeqKdh
+WoRInWc3i0bc17ZT4UYR2j8HXPSdQ4=
=DCzJ
-----END PGP SIGNATURE-----

--gXgZBRmmdpPcPr0u--

