Return-Path: <bpf+bounces-65403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E89D5B218B5
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 00:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115F0170899
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 22:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492C6228C99;
	Mon, 11 Aug 2025 22:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjrakOEK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C372E21B9F5
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 22:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754952522; cv=none; b=pVEDgrTzrv0zM8qhhFAUMuBg0Iiyb3rYqZZs0PNjTSJ5Hpsy5CyktzjH+XIFm9Apiq8HCU+ZcrT4Z0uJIn7dTkyaJuSsNVFuHCtdJpj34KtERxY1BO4LLNpd8nRAlsnIBPGRa2TIvVU5pQWAg1j2YADezb+y34TNcp3Rgp5yESE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754952522; c=relaxed/simple;
	bh=CR+piw1nSlTb56tUWLPg3HrUiMch7K3t3vJzftJs9yI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JoQ2B/qAzYGE/d2Mveg/c9VxB1hl47dW05tiKNtBT+38stFJhsHRG5BBqWdUfKdD2j7pmuantuCxhpQuVbDg3213AZefE0JuHthXxp2W2NSqY2PHucuS6qRpPgX31gVRsbdFNXVEAadpSPJp4vgg/jkmhYBGAV/IIlVoSyD40YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjrakOEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFF4C4CEF6
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 22:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754952522;
	bh=CR+piw1nSlTb56tUWLPg3HrUiMch7K3t3vJzftJs9yI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VjrakOEKJvi6vLnwqkHFj/nr8C7bLkQoC2B1u8XNKQGfWfQd+kQdvG2SpWBi2Jhr0
	 Wlesx7iak/xy1get1n76DiRqEa8u9uBcO32msUd1IqF09CdSrO9hlHxe6NqOWUR72I
	 8M/11XParhzv/VU9dnWmPgy937Kmpf1TI1GxEclgtW2aN8pRJNlynOxbOdUrxzdea4
	 EJUVkFTmJvw+hnmO8Z8ZtVgEtN/YSjIDu6vbsuo7X6PHXmnHjKApgLae0YXwnl8iKO
	 cn+3H36VP9LkPuhlaDrr0tKNh89sp8rIclCMR0/oagw5KUY9TfBIxIFlroQ/fLAodT
	 sBR19jk6KAg5w==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-617b36cc489so9487478a12.0
        for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 15:48:42 -0700 (PDT)
X-Gm-Message-State: AOJu0YxAHUdcVHuAK/4mq87cSfXJA/Lv+dxqR3aa05Cvv1LmoR56Alhc
	ZUQSA5SgUS6zhkLLl9Q7Jq1erQdjqk9ESE8dZnHCcM1s68ruYv82TYS2BklGQusgX8X3z9CGTke
	ghulZS/x3pPXq+HxLhh+DzeDDX3QwZdhmjxZ2O75+
X-Google-Smtp-Source: AGHT+IHPXiFturS5wj58BEw8njsdnBaZv37fH5gNQ4g4I/F8t6TCBnpHZbxmcG1Mv9ycNbPx6F3TtMGbphTCiSEXXfE=
X-Received: by 2002:a05:6402:5210:b0:617:d024:9e75 with SMTP id
 4fb4d7f45d1cf-6184e3c0d5fmr924962a12.0.1754952520768; Mon, 11 Aug 2025
 15:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721211958.1881379-1-kpsingh@kernel.org> <20250721211958.1881379-3-kpsingh@kernel.org>
 <CAKtyLkGOBMBF_d1=qUTa=Fxj5HE6_GRWaE6tVgxyEe3WP1oNPg@mail.gmail.com>
In-Reply-To: <CAKtyLkGOBMBF_d1=qUTa=Fxj5HE6_GRWaE6tVgxyEe3WP1oNPg@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 12 Aug 2025 00:48:30 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4R0MALU65waf0L=eu1ethmM3dHrSMzi3q64cc=ni=_iA@mail.gmail.com>
X-Gm-Features: Ac12FXw-2UfEpYvQXWC3hl9wVuMao5rpS2KZ0Led54t_HzacdgAuOFbLECQc99k
Message-ID: <CACYkzJ4R0MALU65waf0L=eu1ethmM3dHrSMzi3q64cc=ni=_iA@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] bpf: Implement exclusive map creation
To: Fan Wu <wufan@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 12:59=E2=80=AFAM Fan Wu <wufan@kernel.org> wrote:
>
> On Mon, Jul 21, 2025 at 2:35=E2=80=AFPM KP Singh <kpsingh@kernel.org> wro=
te:
> >
> > Exclusive maps allow maps to only be accessed by program with a
> > program with a matching hash which is specified in the excl_prog_hash
> > attr.
> >
> > For the signing use-case, this allows the trusted loader program
> > to load the map and verify the integrity
> >
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  include/linux/bpf.h            |  1 +
> >  include/uapi/linux/bpf.h       |  2 ++
> >  kernel/bpf/syscall.c           | 32 ++++++++++++++++++++++++++++----
> >  kernel/bpf/verifier.c          |  6 ++++++
> >  tools/include/uapi/linux/bpf.h |  2 ++
> >  5 files changed, 39 insertions(+), 4 deletions(-)
> >
>
> ...
>
> > -static int map_create(union bpf_attr *attr, bool kernel)
> > +static int map_create(union bpf_attr *attr, bpfptr_t uattr)
> >  {
> >         const struct bpf_map_ops *ops;
> >         struct bpf_token *token =3D NULL;
> > @@ -1527,7 +1528,30 @@ static int map_create(union bpf_attr *attr, bool=
 kernel)
> >                         attr->btf_vmlinux_value_type_id;
> >         }
> >
> > -       err =3D security_bpf_map_create(map, attr, token, kernel);
> > +       if (attr->excl_prog_hash) {
> > +               bpfptr_t uprog_hash =3D make_bpfptr(attr->excl_prog_has=
h, uattr.is_kernel);
> > +
> > +               map->excl_prog_sha =3D kzalloc(SHA256_DIGEST_SIZE, GFP_=
KERNEL);
> > +               if (!map->excl_prog_sha) {
> > +                       err =3D -ENOMEM;
> > +                       goto free_map;
> > +               }
> > +
> > +               if (attr->excl_prog_hash_size !=3D SHA256_DIGEST_SIZE) =
{
> > +                       err =3D -EINVAL;
> > +                       goto free_map;
> > +               }
>
> Nit: Maybe check the size first to avoid unncessary kzalloc?

Thanks, fixed.

- KP
>
> -Fan
>
> > +
> > +               if (copy_from_bpfptr(map->excl_prog_sha, uprog_hash,
> > +                                    SHA256_DIGEST_SIZE)) {
> > +                       err =3D -EFAULT;
> > +                       goto free_map;
> > +               }
> > +       } else if (attr->excl_prog_hash_size) {
> > +               return -EINVAL;
> > +       }
> > +
> > +       err =3D security_bpf_map_create(map, attr, token, uattr.is_kern=
el);
> >         if (err)
> >                 goto free_map_sec;
> >

