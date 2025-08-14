Return-Path: <bpf+bounces-65686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E551DB26F44
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 20:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABBA4188D8E3
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 18:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB4E225791;
	Thu, 14 Aug 2025 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Led2VQRk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C33A319871;
	Thu, 14 Aug 2025 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755197210; cv=none; b=UuE276wwG2w5fC3M1utrPIgYXWB1wjaeV4ohYIylAZZBxuUxLSymHByu3IL118nkppYxi8PLMR13jX+kwdhxQtGFFI0DhcNEpGONijBmdc+AUFGkfdUxO48+Znn00p1iEKXRrBb5GcRUT504SPGlfEBugtogHkfmCbjxPvNn+1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755197210; c=relaxed/simple;
	bh=x6H1sCYrMWBlO1+FTMUCZHCK+Sy0NuMWhlPxt+LwaCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppOCx2jvS4NZHbafDJ6/mQQjaPw1OlcJKOu5JarcS2FJRWqL0pj7hXPQfTcs0u9FYgjvrWQSDqlvjuxnW3lSyfhVm323DdsQIP3kUrhB28Fdg4egyLMvM47Bq5sGifOVKikJ7fRxLxbX2XOdHywDEIB7LnpeBHtfbdqlXVjyoQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Led2VQRk; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b471aaa085aso588896a12.0;
        Thu, 14 Aug 2025 11:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755197208; x=1755802008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZt2FwqUJYFYMhgC46MMPPWX4x96r4daHxoYBQIix9M=;
        b=Led2VQRkHeE8V/TN3SXq9NVhhz9t0YaBo3aKls7cLkjA0CvMfc/+e7lFkj9zgjvCHR
         kFKDVOv388jQjdnSpNdgXB3sFVJOYve4IDICdVggwmpAXU7S7xgQFRto13p7/xxdTqtQ
         ci4mODxKxd/plI32Mi5Jv2rPgM3wCoRpTtKlfLF26Kvc26lHI/JD33MYSBlPu4hBEdkE
         seqt01OtWWk9Ya2KaZTsoo0FoZTy28Ahr+wjrlRK9Npy3mpeYwBjT71SLeDH+vvfdYWI
         eC0MrpihgCkKAadRFORIFbCld5/abTgLLiJ/uqYV5CdYXEzYcohvcOXNetWVqjTjOjuC
         4O0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755197208; x=1755802008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZt2FwqUJYFYMhgC46MMPPWX4x96r4daHxoYBQIix9M=;
        b=fP5RyB2DkJ/QL2IQtphxwUUDJ2oM6FrqvydKkPN6qaxNuR8wscUfeQxWVe6DmQFqFx
         DMdwvCe+qchmWaCr/OiO5aQ58m/LYVJJvlE8rTo97TBQa06+U+Tlt1k1fjTYUZGMVaHA
         oWRWNfPkEN3tiAnXgWoIK0keUwGhfWSd9yrs16PuxvdAfhYoGIokuSZNh8UUx0y1XdDH
         1ML8txBEl3vGEgHyPpPFhHv7CbP8f/ZCRHjYIVvzOi1PJV0gOtz5k4NUTb7YFksOgnaa
         vzp/NHFEK+VPnjzYLlcZrZ7jBJqMrnpRzUp+XAg45GeOe6+621Rib/sdTMu7sV0761Xj
         63mg==
X-Forwarded-Encrypted: i=1; AJvYcCXEUAPp9sqL6e98Vl0Z+kxd9FGVICpAzetvVqT2527GIbG3BFpxLfllbb2mMPSNfbqd1GJC95UNoJonLZJIPH0Rz9HVg/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3JxxU+pIWI3TRW/KyVLiqNKzClWKO1x1tn92EGm40CU4fG+tf
	Wh1jjiyxTqQTfeZXjA2BFVAITBsIamhfDjDgvtkWVxs/Zf/8YWhN9GqZFM3lHnWiWzpXC85tj0o
	FX5+3GrCOR4U6Jc31Rk4aA6AEBKMEnzw=
X-Gm-Gg: ASbGnctbZs+BdA+imN8GZM2NiCz19hNNm/TbGxs43C+dqpP7OkTjGfqeKctr6zkLZ7W
	KWR6hUIPqaCWV7exO8u0lJBjHAtRq8n2q2SyVCKR3Stop5m1DZD6zMmHqMdmQLKfgHTUROze89O
	MZxByT+rEg86A35OdvDDogFOEU3K4VmIxUk3SB22B0VELIFsv3pQI+udwIQhr0aoKVLDbNLl3xA
	RJJsYffvsUIBOQ=
X-Google-Smtp-Source: AGHT+IFECgDEj9+FHO3K4h++ME+N1wfAf8p+Alx12ZcLfHK2jqqfHF47I9PQx1a/IxaPeS7DbpJ0Lbg7CyUaTrmXxsY=
X-Received: by 2002:a17:90b:2241:b0:31f:2bbb:e6a8 with SMTP id
 98e67ed59e1d1-3232978cf5emr5315329a91.12.1755197208313; Thu, 14 Aug 2025
 11:46:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813205526.2992911-1-kpsingh@kernel.org> <20250813205526.2992911-10-kpsingh@kernel.org>
In-Reply-To: <20250813205526.2992911-10-kpsingh@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Aug 2025 11:46:36 -0700
X-Gm-Features: Ac12FXw-apthRBOTCJyBjTyEFha5FW2vzP0wxRecJbbdzQMLKo8D6HDQ-b34S2s
Message-ID: <CAEf4BzbYUPLH97fkFQ3oHqKok=OEREyd1VVkmqfVh0rUvX_1sQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/12] libbpf: Update light skeleton for signing
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 1:55=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> * The metadata map is created with as an exclusive map (with an
> excl_prog_hash) This restricts map access exclusively to the signed
> loader program, preventing tampering by other processes.
>
> * The map is then frozen, making it read-only from userspace.
>
> * BPF_OBJ_GET_INFO_BY_ID instructs the kernel to compute the hash of the
>   metadata map (H') and store it in bpf_map->sha.
>
> * The loader is then loaded with the signature which is then verified by
>   the kernel.
>
> The sekeleton currently uses the session keyring
> (KEY_SPEC_SESSION_KEYRING) by default but this can
> be overridden by the user of the skeleton.
>
> loading signed programs prebuilt into the kernel are not currently
> supported. These can supported by enabling BPF_OBJ_GET_INFO_BY_ID to be
> called from the kernel.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  tools/lib/bpf/skel_internal.h | 75 +++++++++++++++++++++++++++++++++--
>  1 file changed, 71 insertions(+), 4 deletions(-)
>

[...]

> +static inline int skel_obj_get_info_by_fd(int fd)
> +{
> +       const size_t attr_sz =3D offsetofend(union bpf_attr, info);
> +       __u8 sha[SHA256_DIGEST_LENGTH];
> +       struct bpf_map_info info =3D {};

memset(0) this instead of relying on =3D {}

> +       __u32 info_len =3D sizeof(info);
> +       union bpf_attr attr;
> +
> +       info.hash =3D (long) &sha;
> +       info.hash_size =3D SHA256_DIGEST_LENGTH;
> +
> +       memset(&attr, 0, attr_sz);
> +       attr.info.bpf_fd =3D fd;
> +       attr.info.info =3D (long) &info;
> +       attr.info.info_len =3D info_len;
> +       return skel_sys_bpf(BPF_OBJ_GET_INFO_BY_FD, &attr, attr_sz);
> +}

[...]

