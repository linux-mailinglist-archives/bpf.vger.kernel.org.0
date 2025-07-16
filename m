Return-Path: <bpf+bounces-63486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E90B07F1F
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 22:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72CEE3ACC19
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 20:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA51828A727;
	Wed, 16 Jul 2025 20:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VP5z/cQK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0BC1DB95E;
	Wed, 16 Jul 2025 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752698918; cv=none; b=b46OPGz/PkNt6GJ7AeaeJ3oHqjC8QEG0aOwPVtLyn12ce0XWFOiXa+A9gTq8yPqQi/tyVPKdjv/K6SEoODpu2d4GPBGutY4IMpsxgc5PJmbh7QPXg2VWmg4hfi1DqY8l13aCLZ99r2iR3xRJR/BvPvZCpy++TwkjLbHJVY7x7WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752698918; c=relaxed/simple;
	bh=KWKo2w+wYwVfdyFZDx/jBU8IPRmVKs+hPfl6brd0isY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJd5fd7diSTAD2N3xbB4q2THqDpGcbjGBiXd6XJO+4gYs5Mhzj8lh74HpJ0Sbc9Ri3e/9kWCEsqoOUMHGuv1rpT+mQdXIJ/1YchOZl2g8esh4c3CtCwp/JsJyag6sCcb6WvaeeK6S2XkUYesaIYD9Y6eJRQiAQ4reHAaAEtjO80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VP5z/cQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21B8C4CEF1;
	Wed, 16 Jul 2025 20:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752698917;
	bh=KWKo2w+wYwVfdyFZDx/jBU8IPRmVKs+hPfl6brd0isY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VP5z/cQKOPCn/r3vv9+72jaepxRsE2fVUw7USa7Z0eUzHtJR8HdQIHofcMzIOS+Mi
	 +xAXQfWkxMj3wLKadT34Z00sPyqSLecipoUN1ap8bQboB7TENrIHBokQ3hH+LKjiIn
	 KQTjNPGJAaJ0fwIFn4gMFPXONQU6mTRpPNNi2A5fuh2i+Qxu3g9nUjHMQtvK36ilf0
	 TWvxVdgKevFr2NmgO1N0EHd10H/RkVfCU54mGK8kaNNCNZ08ic6ugyjYeLuyNZHXf7
	 7LAdmVuWDBU/Wb8mnuiuY62L451+Ywzc2JItY4w3dxCCupeHsMw0dwzMd2xPUZFzpm
	 ekiXjitFSxq1A==
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6fabe9446a0so3297476d6.2;
        Wed, 16 Jul 2025 13:48:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV71TukagYAO55SW3kVNhejkGVoqnjO8dyfofwcxNnoTaIQIIwK0fbtAUAhoRzuUegMx8w=@vger.kernel.org, AJvYcCXIzxlVCQVi/BhGbDI9B3Ezdc2vJXdTJ+UfuzhhhrPWGFDX+WNo04qRcDTy+nBGw8fmO1FAX50sVLQXI8dl@vger.kernel.org, AJvYcCXYuQXvKqKW1kL96Aq3HQzntG7xzFHD4p0IKM8Ld06yKuGyPN7ykkZEaj8SF84mjMaYLwob/tbCnr0uEQ5rAkX88kDpy5zq@vger.kernel.org, AJvYcCXrAzR57XMMeH7inoNh0DKNUwxEey/eYZMlNcSETuU1v+aUr2BoU/90X8h45HU/5HAmMbRS6w8C+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqU8hFdhRWScMtMX/w2mB6sPMZrmW2beF2Pv3UpqQAt3Nb7xHx
	xPfZpm/wUxqJBUmjrPhHwQ4tFB8CE7qXZRyXBnhZJD9HRLcvByJsKpQZ5v+IeISRROvXmQUGbb7
	EgixVlUzQ8jgSR9wgMM4GmTvy2o9C3TE=
X-Google-Smtp-Source: AGHT+IHu6/IQepea9HxVbCNKNm9Zv8JKQ4BJFdjhKn8ljv9Xd85L/HFi3gcN4fvSjm2ixDXQFRpDYWACaO6UbTFnoS8=
X-Received: by 2002:a05:6214:300e:b0:704:e5fe:f257 with SMTP id
 6a1803df08f44-704f4ab6610mr50065046d6.30.1752698916802; Wed, 16 Jul 2025
 13:48:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715222655.705241-1-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250715222655.705241-1-bboscaccy@linux.microsoft.com>
From: Song Liu <song@kernel.org>
Date: Wed, 16 Jul 2025 13:48:25 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6K95bnGvRVOKj-qBJT7DX8JsaO6WZMNauMi1GEqVT1FA@mail.gmail.com>
X-Gm-Features: Ac12FXyIg4ONVoNlLp3htfda_3Ao19PzwYItR0iusBKSFl_zDde2_33L59ClXxE
Message-ID: <CAPhsuW6K95bnGvRVOKj-qBJT7DX8JsaO6WZMNauMi1GEqVT1FA@mail.gmail.com>
Subject: Re: [PATCH] lsm,selinux: Add LSM blob support for BPF objects
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	John Johansen <john.johansen@canonical.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 3:27=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
[...]
> +/**
> + * lsm_bpf_map_alloc - allocate a composite bpf_map blob
> + * @map: the bpf_map that needs a blob
> + *
> + * Allocate the bpf_map blob for all the modules
> + *
> + * Returns 0, or -ENOMEM if memory can't be allocated.
> + */
> +static int lsm_bpf_map_alloc(struct bpf_map *map)
> +{
> +       if (blob_sizes.lbs_bpf_map =3D=3D 0) {
> +               map->security =3D NULL;
> +               return 0;
> +       }
> +
> +       map->security =3D kzalloc(blob_sizes.lbs_bpf_map, GFP_KERNEL);
> +       if (!map->security)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +/**
> + * lsm_bpf_prog_alloc - allocate a composite bpf_prog blob
> + * @prog: the bpf_prog that needs a blob
> + *
> + * Allocate the bpf_prog blob for all the modules
> + *
> + * Returns 0, or -ENOMEM if memory can't be allocated.
> + */
> +static int lsm_bpf_prog_alloc(struct bpf_prog *prog)
> +{
> +       if (blob_sizes.lbs_bpf_prog =3D=3D 0) {
> +               prog->aux->security =3D NULL;
> +               return 0;
> +       }
> +
> +       prog->aux->security =3D kzalloc(blob_sizes.lbs_bpf_prog, GFP_KERN=
EL);
> +       if (!prog->aux->security)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +/**
> + * lsm_bpf_token_alloc - allocate a composite bpf_token blob
> + * @token: the bpf_token that needs a blob
> + *
> + * Allocate the bpf_token blob for all the modules
> + *
> + * Returns 0, or -ENOMEM if memory can't be allocated.
> + */
> +static int lsm_bpf_token_alloc(struct bpf_token *token)
> +{
> +       if (blob_sizes.lbs_bpf_token =3D=3D 0) {
> +               token->security =3D NULL;
> +               return 0;
> +       }
> +
> +       token->security =3D kzalloc(blob_sizes.lbs_bpf_token, GFP_KERNEL)=
;
> +       if (!token->security)
> +               return -ENOMEM;
> +
> +       return 0;
> +}

We need the above 3 functions inside #ifdef CONFIG_BPF_SYSCALL.

Also, can we use lsm_blob_alloc() in these functions?

Thanks,
Song

[...]

