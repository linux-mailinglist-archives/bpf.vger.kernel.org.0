Return-Path: <bpf+bounces-64679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C835B155AD
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 01:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C4F3B21A0
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 23:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60A02874EA;
	Tue, 29 Jul 2025 22:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brpAD2eV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE12285C9D;
	Tue, 29 Jul 2025 22:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753829957; cv=none; b=ctPls+uyt3gNJsEjXDeavrbOx8p4T/obk2VpKuqdE3prvI2uC6nbAN0AjXirqIrc0xMek42MbsbdayUKfJpEMi5JClXaIBdy4Hw3qN6BFvhq8yBtxYLLFrpOAHfFEXTAc1v3Sk2kNRHdla5Wf2t6wt6jnWzV9icUOvsNSmZWZGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753829957; c=relaxed/simple;
	bh=AeqlxgSP0AGtO/TvPtzxt8x6uRvAeolIH549hkTwI/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DrCM1j4iHzkS0tcvr52eq6yw5K39qyC1GuHwy3Xu5XIcS5+Kw4MGYVtWanuna2q8+XHeGsnxJdM37/CoxQjegZM2zQe/aFqR7AlkELpAURw9SsLM0wgQruWygTGRbvv0Ifi/B+3r/erk2BCwQpd7m5bPg2bg7yOoSx0Gy88fTS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brpAD2eV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F1DC4CEFA;
	Tue, 29 Jul 2025 22:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753829956;
	bh=AeqlxgSP0AGtO/TvPtzxt8x6uRvAeolIH549hkTwI/4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=brpAD2eVjFnTUgXpe1TzjQcuGQM72+lzU2U9sE4FO4sdKE2kpZlvhuPQrM1HkUovN
	 vQS//L0JdNRvDvQzbKdel1Ryfa9tbZXQe+RgsRBVeDHqDMIeqRTTnuslnPrsK5m8vC
	 s/4oImyOOmLjvbxXHLNeGZ4RCrTEYZW1+83f/YDCrb16Heo96Xo8PzsVmw6BKBaKm6
	 c44FGhZAmQayF/loUm5uEu1QBinZrPSdHZg9Wx06QKt3j93stO16maJdzfZWbOjhfv
	 6op7AIrJEV4ctUzQEgyts5av4TW1hDqBu7Ueij8zJEoGfrqFBB+gU19LEFiobLz9dt
	 uZ7PDnsUVVatA==
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e8e03314c41so3098753276.2;
        Tue, 29 Jul 2025 15:59:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVod+kz1Je2/NVDOidoL+wTEwCP1PP15IWcmYsPE6lYyhwP9mk0A31BnxSE57Un1o6L9zbr1B/eWs49Lfzb7tB8oWH2zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrI9Cxhk7uGZkFm5mm9I3gr9IQYksQ0LfGEfbOiPSPpLmkzLSi
	WaeYtV6JfnX8T0xZvkjVJVtwE0C6lOULdI/pf61fglATF07GdLE+aVMtSMKYSsgEewUzrtKduG9
	slEcdnNHAFuV/SucwTC8SuQfvn2QtbTw=
X-Google-Smtp-Source: AGHT+IGGmIsZJB5AYWz2/Y2SL904E6/q1QXWwvK/uDN0ZTbQ+WMEDVi3+Pp4T1rK+3ZEB+zMaHFVwu8ztDOu/Bhkafw=
X-Received: by 2002:a05:6902:2e09:b0:e8e:124:5a3d with SMTP id
 3f1490d57ef6-e8e314fa1bamr1791609276.17.1753829956007; Tue, 29 Jul 2025
 15:59:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721211958.1881379-1-kpsingh@kernel.org> <20250721211958.1881379-3-kpsingh@kernel.org>
In-Reply-To: <20250721211958.1881379-3-kpsingh@kernel.org>
From: Fan Wu <wufan@kernel.org>
Date: Tue, 29 Jul 2025 15:59:05 -0700
X-Gmail-Original-Message-ID: <CAKtyLkGOBMBF_d1=qUTa=Fxj5HE6_GRWaE6tVgxyEe3WP1oNPg@mail.gmail.com>
X-Gm-Features: Ac12FXyKU4FJZEoyQD18YRQtXstEftEJjcW-UWk2rB0F1S-sxHHWjRzgQkaptI4
Message-ID: <CAKtyLkGOBMBF_d1=qUTa=Fxj5HE6_GRWaE6tVgxyEe3WP1oNPg@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] bpf: Implement exclusive map creation
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 2:35=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> Exclusive maps allow maps to only be accessed by program with a
> program with a matching hash which is specified in the excl_prog_hash
> attr.
>
> For the signing use-case, this allows the trusted loader program
> to load the map and verify the integrity
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       |  2 ++
>  kernel/bpf/syscall.c           | 32 ++++++++++++++++++++++++++++----
>  kernel/bpf/verifier.c          |  6 ++++++
>  tools/include/uapi/linux/bpf.h |  2 ++
>  5 files changed, 39 insertions(+), 4 deletions(-)
>

...

> -static int map_create(union bpf_attr *attr, bool kernel)
> +static int map_create(union bpf_attr *attr, bpfptr_t uattr)
>  {
>         const struct bpf_map_ops *ops;
>         struct bpf_token *token =3D NULL;
> @@ -1527,7 +1528,30 @@ static int map_create(union bpf_attr *attr, bool k=
ernel)
>                         attr->btf_vmlinux_value_type_id;
>         }
>
> -       err =3D security_bpf_map_create(map, attr, token, kernel);
> +       if (attr->excl_prog_hash) {
> +               bpfptr_t uprog_hash =3D make_bpfptr(attr->excl_prog_hash,=
 uattr.is_kernel);
> +
> +               map->excl_prog_sha =3D kzalloc(SHA256_DIGEST_SIZE, GFP_KE=
RNEL);
> +               if (!map->excl_prog_sha) {
> +                       err =3D -ENOMEM;
> +                       goto free_map;
> +               }
> +
> +               if (attr->excl_prog_hash_size !=3D SHA256_DIGEST_SIZE) {
> +                       err =3D -EINVAL;
> +                       goto free_map;
> +               }

Nit: Maybe check the size first to avoid unncessary kzalloc?

-Fan

> +
> +               if (copy_from_bpfptr(map->excl_prog_sha, uprog_hash,
> +                                    SHA256_DIGEST_SIZE)) {
> +                       err =3D -EFAULT;
> +                       goto free_map;
> +               }
> +       } else if (attr->excl_prog_hash_size) {
> +               return -EINVAL;
> +       }
> +
> +       err =3D security_bpf_map_create(map, attr, token, uattr.is_kernel=
);
>         if (err)
>                 goto free_map_sec;
>

