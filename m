Return-Path: <bpf+bounces-73531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 041A5C3369F
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 00:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F78C18C5688
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 23:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E868934A780;
	Tue,  4 Nov 2025 23:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FneBviBs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996EC2E1F1F
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 23:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762299908; cv=none; b=CG0NxJ/vyeegOrv+OpP1SQ+l1+8/NcZRF8g588gr7kT/sd2zuHkm+2K7koI7uQFLXAR6FjTSXfvmSJR7oacURtwsk6kI9gho9VU12dPAZnqXE43kTSrorrnLssz3pmwa4ySB3zehs7D8Y4qOOETG7btKf7yptvIsi5bIav15gF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762299908; c=relaxed/simple;
	bh=60Le1zZOwSYB0h4p5WegnydYbxsMfqCb1n7BDEfRK/k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mwDzINK6t16FJ3jIudh776Dp5B+PMatAZJWvhfyrItY1wajqyXzWCh7xuvdFHxTgmyP47oavImTDMol40A05L6OXSD7ZrOwa9QwvcDw9wA0qLtnevBo+5Ilk08IKE7CsL9wvKiDq3a5QiVeVZ3DqlRbGnkZ5AagvC5ULXxl+urc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FneBviBs; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-78125ed4052so7871938b3a.0
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 15:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762299906; x=1762904706; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8YDObtp5Hii+eUkvK68R56JH6ps+cp0j/ZReQQq/vps=;
        b=FneBviBsSVEnFjZk4aQ66yqGPXVfjRlIy6YDNrpEPbmIeUEZPiiZAI/86d5QSTS8K4
         NvTyAAc0EZzy05Kp9C8+m1TcXN59oKb4GR3Ulp41xgD5Y93LkWEbTEsB0yYrFuWIWe85
         umoH2KSmzn4u/q6TbIPKWxc41jsAlTaYFxy6nStXcf9Ip/cFZRInexNJ3Hf8bkeD1Ybr
         HaG5LFakagjLvJWOIoxFuAlbsZWXHMnge71UUZDVsTFarsV17qJJegvj37SRyHIv0Xnp
         uNKhygB0O7hIxVaG/Kcfpmvoal2KcMBBVp9CLRrSjtPuy/H/u/zRPvkjSvKI9K3ihX4a
         /esQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762299906; x=1762904706;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8YDObtp5Hii+eUkvK68R56JH6ps+cp0j/ZReQQq/vps=;
        b=PpqaI2feB6ZacGyS3cFrOR0svO6cynu1VSQ9Jl//Pqn//a3nWknWzZ0bArZdevdGYF
         umYIEITNkojWMkFG9Zd2RB5JXM1eFrQFGwMO3BBha4p4dOMmc2MctovbIH1VKcMEUrxj
         u59EU5qThCkODoWyjPga5XV3shn8BBg5yqJ/qFa7DuIG0+yS5r/5o4S8UXMXSp+odNex
         Equleb9+SSOrnz2YFpykEEefksYrfX9y3oIW0ISIca1hsX5+voj3FihBuaJwd6GXr4iF
         1l7j+QHHbXSqMoOFgSZePSUCXqsbcqMpyi7HP15zsZm58WBLceoWU4yZQ6A0N1vI5/iN
         ziJw==
X-Forwarded-Encrypted: i=1; AJvYcCU2gDqLGnK8PzAvFbH7WaPTSXoMYwxlYl+JVtqaNVLo+qVhuPeVr/VCaUGphLbe9v/QCK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsQbXS3tpFbayzHP1jK7Lfzx02fkZQrhG+y6c5rIayuu+iwnyX
	soRfiVvrIhOgYkoGwXI6vhC+Xq4gpcFucawMoTN4qwYNLYIBeSd9vhCv
X-Gm-Gg: ASbGncsZgtcN5eA3Ayq0AdR3PUoW9eJYVZfl/4fyLTVRk2JLTmJecJlvw2oE2ZJUxn4
	1cEOdDCNh782TnoL41KeanslYfFiiodtMsHpMOfQybKzWHFONIlUJtR/JMwQaNDuFtfn8PRSiY+
	R4DD2+cv7uNj/v2HweJtzBqtt25vmDDRqliLTp86/mGQiUjPdl6s9m7iHcgkFrWzlu06rxFxEKa
	wuvo3DsZI342Zr26N3m1e+5kG2d07pxwhdcHJcR6Zu4lYmP0C3jyEq3X5n+BIsv0tsetiTsCMmh
	LGfULTS1heany+1kO9g46v/jWv1b6+KLGqJZ0Pl7GfCKhDkbFoEbUKdY0QfqAHCmYgTI/8xkZ2C
	wMYcdD/1GdLwPozmnda+OF8ULR1PHvOSZMo8vkXjBI21WhF/pmCt9YquAxxl/zcWx8CAeZ1YaTL
	eYzqk97DPb6bgU29QJ81cZaeI=
X-Google-Smtp-Source: AGHT+IG0wN1/ICg8yWAxSeyGag0gkgugs5xQY54czh3FFL/Hn2a2yBmFXRsdH2j3PsFXuDxVKA4yQQ==
X-Received: by 2002:a05:6a00:c83:b0:7ad:c017:171e with SMTP id d2e1a72fcca58-7ae1c7685ecmr1429721b3a.2.1762299905889;
        Tue, 04 Nov 2025 15:45:05 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a643:22b:eb9:c921? ([2620:10d:c090:500::5:99aa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd633bf6bsm4190456b3a.56.2025.11.04.15.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 15:45:05 -0800 (PST)
Message-ID: <f16e34ac93438c9ccb9b174d45060c3b06b45e9d.camel@gmail.com>
Subject: Re: [RFC PATCH v4 2/7] libbpf: Add BTF permutation support for type
 reordering
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Andrii Nakryiko	
 <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song
 Liu	 <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Date: Tue, 04 Nov 2025 15:45:04 -0800
In-Reply-To: <20251104134033.344807-3-dolinux.peng@gmail.com>
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
	 <20251104134033.344807-3-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-04 at 21:40 +0800, Donglin Peng wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>=20
> Introduce btf__permute() API to allow in-place rearrangement of BTF types=
.
> This function reorganizes BTF type order according to a provided array of
> type IDs, updating all type references to maintain consistency.
>=20
> The permutation process involves:
> 1. Shuffling types into new order based on the provided ID mapping
> 2. Remapping all type ID references to point to new locations
> 3. Handling BTF extension data if provided via options
>=20
> This is particularly useful for optimizing type locality after BTF
> deduplication or for meeting specific layout requirements in specialized
> use cases.
>=20
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -273,6 +273,40 @@ LIBBPF_API int btf__dedup(struct btf *btf, const str=
uct btf_dedup_opts *opts);
>   */
>  LIBBPF_API int btf__relocate(struct btf *btf, const struct btf *base_btf=
);
> =20
> +struct btf_permute_opts {
> +	size_t sz;
> +	/* optional .BTF.ext info along the main BTF info */
> +	struct btf_ext *btf_ext;
> +	size_t :0;
> +};
> +#define btf_permute_opts__last_field btf_ext
> +
> +/**
> + * @brief **btf__permute()** rearranges BTF types in-place according to =
specified mapping
> + * @param btf BTF object to permute
> + * @param ids Array defining new type order. Must contain exactly btf->n=
r_types elements,
> + *        each being a valid type ID in range [btf->start_id, btf->start=
_id + btf->nr_types - 1]
> + * @param opts Optional parameters, including BTF extension data for ref=
erence updates
> + * @return 0 on success, negative error code on failure
> + *
> + * **btf__permute()** performs an in-place permutation of BTF types, rea=
rranging them
> + * according to the order specified in @p ids array. After reordering, a=
ll type references
> + * within the BTF data and optional BTF extension are updated to maintai=
n consistency.
> + *
> + * The permutation process consists of two phases:
> + * 1. Type shuffling: Physical reordering of type data in memory
> + * 2. Reference remapping: Updating all type ID references to new locati=
ons

Nit: Please drop this paragraph: it is an implementation detail, not
     user-facing behavior, and it is obvious from the function code.

> + *
> + * This is particularly useful for optimizing type locality after BTF de=
duplication
> + * or for meeting specific layout requirements in specialized use cases.

Nit: Please drop this paragraph as well.

> + *
> + * On error, negative error code is returned and errno is set appropriat=
ely.
> + * Common error codes include:
> + *   - -EINVAL: Invalid parameters or invalid ID mapping (e.g., duplicat=
e IDs, out-of-range IDs)
> + *   - -ENOMEM: Memory allocation failure during permutation process
> + */
> +LIBBPF_API int btf__permute(struct btf *btf, __u32 *ids, const struct bt=
f_permute_opts *opts);
> +
>  struct btf_dump;
> =20
>  struct btf_dump_opts {

[...]

