Return-Path: <bpf+bounces-61476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64492AE73BF
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 02:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B4919210E9
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 00:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772AB38FB0;
	Wed, 25 Jun 2025 00:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFyhKi6J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC0C1C69D
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 00:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750810917; cv=none; b=uIHA3FoXf8slkZNxe2qbGv6NhNqH6ckeK9mRNC23AyeIBN37gRmGfUxRxUqmR4VUBos/7XyjTldGQx+7Wl+V4/6a14uPY3lQz5ew1vFZG7iLkv6oQyDjOg6ERCHNPD5tbLG+X0klqZtTpJVvI5I42N5i/zffhU8TtLFtJ19D8lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750810917; c=relaxed/simple;
	bh=xN2B0XXCpxlvEtmv/rIcjR2zd+P+LgsEBjSdHM2f/e8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/Rb5fvLjK9vT7O5pM4RrrItMHZKNYFso6jd07qMeN6pbKPrSbhOe6FhzZAfB7iqI7abccwh/tguImTESmKzUyOcWVuzmHsDS+JLiU06YUubHEDTQmO4Iq+Hbk7rvGtb+k9EOXet+nWzoI1u5SAFJW2q0as8uorY9FqH3iCPFgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFyhKi6J; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4537deebb01so7570185e9.0
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 17:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750810914; x=1751415714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFmo4zCtBcLHT8ekr4Vw4kevj33rtg3FGdaW2RbPSIk=;
        b=DFyhKi6J/S+gEkLVP8N5QHT0K3aTDKPwdklCHN32+xQuoA0kpkeowKmTSKW5tC+3gG
         sG9M4dmOqnHtAlo17LTyFDbuOIv0wWvu6oCsvNKeNOoZVBd7pSPPIxII+G36FKQq/ZS/
         a/OvdE1ajWzd+2edeVDFBip7JoI5vawp/82zMwvtdd/s5ZYyiPeuihnFE2zw/5f9SsVv
         nnYJ/tceXlULGKxfcjV0J8a7GQp2DQKZzETyfHaIveAsEZ8M3015CF6ZHF5G36+KQmik
         r1Jb4OXCjjBwcOu78b3uUvEELWEbe3xp0Cy1+35dmqUmPsNtaHJpr8Dms94aF/BJ6GwZ
         lPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750810914; x=1751415714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFmo4zCtBcLHT8ekr4Vw4kevj33rtg3FGdaW2RbPSIk=;
        b=NXjm6gSw0uBQJ4GDyyttKitquRI+04NhVDugA/Z/sZ2d1o/B5s+AhtMLS5Ny8D+ZLt
         VkVRmsxgqGAkxwo3B4Z5fMA7wcRoouE5TAiEHfE9f4uWSHQntaYkLOr0kiI9xnifMwvx
         hZs52TxcY7/FblRSuEFA0QJ8PzcZ4KPh6upCaueflrgRv7yk8bHaWb++24fbqYSVhbTr
         KE76yojF6PHCJCl5VhcApGLcE2C2+qD0/70fFxMwu+qDwkvJPRU0ckNHrEE482q65/6h
         Sod5CLt7scPyC/IFEEEp840NXbwyKOxeDlZ9p9B2HG59/6rG8eQxEovbbyHuhDa3yxll
         eY7A==
X-Gm-Message-State: AOJu0YyR59I6fgz2cLU1NE8Jx1AyVNEC6rOLKF6WpeRObN0NRON8ZmeB
	ilpq6dUhzXUMabDC94vv/rWaKUDtbtLIb3fDCeGyxPOAFxrgKXEuJj4GjKmmMBUY+wKM+0d/p3w
	oRcNn4amGMxFKlNBqDXpdrCVznVrSF+k=
X-Gm-Gg: ASbGncud/eOyh7iYLgDTeDP/2t9XKJ5AkWIHPtXja8QTBJTrh+e5QplJDtJ2ZVvPbPq
	c4lQ2zmGEGn9VDmA6Bvkbw8xXLkBs14JkEVtFOT8AKqpDFIsK/ez3R+sk3vqQWvaeX1gNqXYfV1
	5DQ0JLTtF6OyiEugE91kKUzHT4TJyDQ9WZyTOZcNavdA6b15CBA9B/xDdhUpwkkm3hpcS+8ZWSk
	+AudoxcfPE=
X-Google-Smtp-Source: AGHT+IGAWjfLw6S1TzZmWzgwS4eqyfrzxFJH+0cTKP5f2y6iHGNAAjhZusINqYaf3gzRR2wzQa+Fle129/kqMj4dK8U=
X-Received: by 2002:a05:600c:a407:b0:43c:f8fc:f697 with SMTP id
 5b1f17b1804b1-45382a1d307mr1686185e9.9.1750810913465; Tue, 24 Jun 2025
 17:21:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625000520.2700423-1-eddyz87@gmail.com> <20250625000520.2700423-3-eddyz87@gmail.com>
 <CAADnVQ+OjowmcVdYkAR-VLZUWNbvkG=i78gV4-76YdFJL2DJ6Q@mail.gmail.com> <63fa058d2be2c91cd8c2835ee7d88b745dad2849.camel@gmail.com>
In-Reply-To: <63fa058d2be2c91cd8c2835ee7d88b745dad2849.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Jun 2025 17:21:42 -0700
X-Gm-Features: Ac12FXygxcgeE5VD_-5PeEc-jNOsj4b3RVnNpY38gYYHCUwWnx0vwNbDXOiAhdA
Message-ID: <CAADnVQ+1h49trJcsobzPN=YnnbsaidJi98vMeGeBKpxh-nV2Hw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: allow void* cast using bpf_rdonly_cast()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 5:15=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2025-06-24 at 17:11 -0700, Alexei Starovoitov wrote:
>
> [...]
>
> > >  enum bpf_features {
> > > -       __MAX_BPF_FEAT =3D 0,
> > > +       BPF_FEAT_RDONLY_CAST_TO_VOID =3D 0,
> > > +       __MAX_BPF_FEAT =3D 1,
> >
> > and the idea is to manually adjust it every time?!
> > That's way too much churn.
> > Either remove it or keep it without assignment.
> > Just as __MAX_BPF_FEAT. Like similar thing in enum /.
>
> I probably did not understand your previous message:
>
>    > > +enum bpf_features {
>    > > +       BPF_FEAT_RDONLY_CAST_TO_VOID =3D 0,
>    > > +       BPF_FEAT_TOTAL,
>    >
>    > I don't see the value of 'total', but not strongly against it.
>    > But pls be consistent with __MAX_BPF_CMD, __MAX_BPF_MAP_TYPE, ...
>    > Say, __MAX_BPF_FEAT ?
>    >
>    >
>    > Also it's better to introduce this enum in some earlier patch,
>    > and then always add BTF_FEAT_... to this enum
>    > in the same patch that adds the feature to make
>    > sure backports won't screw it up.
>    > Another rule should be to always assign a number to it.
>
>
> Specifically: "Another rule should be to always assign a number to it."
> The BPF_FEAT_RDONLY_CAST_TO_VOID already had a number, so I assumed
> you were talking about __MAX_BPF_FEAT.
> What did you mean?

I mean to add " =3D 123," to actual features, so when they're
backported the number stays the same.
Not to __MAX_BPF_FEAT.

I doubt it matters though,
since bpf progs suppose to use
bpf_core_enum_value_exists(enum bpf_features, name)
that doesn't care about the actual id.

In bpf helpers we got burned by broken backports and added
constants to ___BPF_FUNC_MAPPER macro.
Here I don't see it ever matter.
Just like I don't think __MAX_BPF_FEAT is needed,
but if we follow old steps, then let's do both __MAX_BPF_FEAT
without number and every feature with the number.
The end result will look like bpf_link_type.

