Return-Path: <bpf+bounces-63742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B437DB0A84A
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 18:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91FD5A3538
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 16:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DE82E11D1;
	Fri, 18 Jul 2025 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8umVjmU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE9C1D88D0;
	Fri, 18 Jul 2025 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752855540; cv=none; b=iO2uzA1/TYbDUJs0YbVoHaKo5hQg3EuEOlYsCf3Se5vX8oVu1mSEZFvrmstSjDrlCP8Ql7OKeG0NYrdA/o6it4HjQHX33RKOWneq7v90QTuXWfI01Iy3z3KHZ7z1KUfsbvIScrERfmmuJjKy22gyWar9XBy4U25iVTp80M7e2Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752855540; c=relaxed/simple;
	bh=JsGI4d1WgsQxQwDTlELaaQan2DJyyq7rBgqt3cAK84Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Si/sHFB7RYI+G/P/WysEJdg9hwRd1ECdKhhPJzzjz0g55e43IFbkUFx/xi8hF64lWH1/HVHQyPNNfWK0+Cpk7lvVQdMOJXIOme22BkA0AVCYeiNZ5cHu/DR4+a4pZUwTIa2hOYERmuWozs9mEibuIhRJ3ziRJHyGEFWUzATvORs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8umVjmU; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2ebb72384dbso769250fac.1;
        Fri, 18 Jul 2025 09:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752855538; x=1753460338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsGI4d1WgsQxQwDTlELaaQan2DJyyq7rBgqt3cAK84Q=;
        b=M8umVjmUuWh/O0qn+XkrvkRM7EMUOEUcg4Cl934gRYWM1RHs7BG41Z8Ib6pWnsqQ4M
         L5NOfNwMy8ROv1ecjagO2tonOk/lW3E+Iv+qyCAlUm3NIoIe9tj3yw5VpcXIDceI1vNv
         fINWq2zwInZ98tALlqp9C8Jsb6A5f0rhgVjdNF7GSOBCa3I2kw72Fj/qRa0cwpzrGKiH
         JhA53Aa7cC61E4xJ8N1UtkXpl4X29vZEYKUYm6PD5Ws6D2d+LWiDqZc0sRJ3CdF30tX8
         CcBp91wYGODHteKsS7IdPkCL2+OGXxWdJ4BtVqNG5a+1X9KJZfeO1RJTijsZd8fg65LD
         o3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752855538; x=1753460338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsGI4d1WgsQxQwDTlELaaQan2DJyyq7rBgqt3cAK84Q=;
        b=hDxTGeJYN5v3e/qvlLTytbCRnigNN0unGLTGqz89rMJv6LdTJNrMZJoD1Nx069mq7P
         karfvYwWmaOTGXTg9+16kTKA+nQtZ0ToQpcO9idVzqGNdEsVx4mTbGvWZ34SCeRTZYi0
         SEdrM9f4llcX886sX/jbKaFP6Xd11NeGB+vgOhsGYqesEE14iRbc/h6Y/Rbm/Cob4oFm
         JIyFsuGEDl5XMp2kk9htPS83/u2wX7OarFBanXbFDYXC4WYEWOPMf4rd6TSGpThJI3md
         8AQFWunw90fbc35pXShCQylY6s6IDvLHQym8J1wps/Z+nkU2ZClZ3bnPlfcJw7LBNC9l
         c29Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAXNmDSDhv13ZDO0kCueieVjX8OiZIYogRwmklGuH3JujzFJFVYDXXLvFFi/hmMOfvWhDXL2bIGkZxYBEI@vger.kernel.org, AJvYcCXDe6fdSoI4OhSKUrU0j8lZ9DQ1iKGs14Gi4ymjtJy8tcAD2vhfrZq3hWQ26DTBurGWFhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVyYSLQu/+TDik1rJgO/IW1RNInKEayirjd45FmdPdA2x2OMWL
	cZda8NCWKMmzZmPfqdWUpgKCW3rT32k6n7+X0tkyXgLkhj6B6QQ/kgg/nfL5ClUIz2UxZI/KnqE
	ospECGUWTFqr/XZtMJwSZS5+u6fuxaCY=
X-Gm-Gg: ASbGncvOqUBd0F36jd/uG9aOCBPDl2nCn+KuuP//8txFyKHfdZi0uLY4e8DZK8/yhuX
	ifzpz4+7u2aZqKa1gNkqW4JbklsDsbnUZSSm74u89+ygf9DMoUcmCn54dVcKIzPzIXBLGGNpLCJ
	F7izAPpvSrvpSA73JRiukii7VVxxCsxaEtVsMXb2bItcT+Ba6TbxH7Yx2kPQXoe6SykT9oue7mT
	7HyZgVN
X-Google-Smtp-Source: AGHT+IGe4Yj5ws/qqsi0APF23sRi0Iv9xe2xK91Wy35K93f2vavegXJAkOTU2w+EaE+/G0T1B+A6VAnk+FODlxkSWOk=
X-Received: by 2002:a05:6870:a40a:b0:2c1:bc87:9bd7 with SMTP id
 586e51a60fabf-300ea49dbd9mr2765849fac.35.1752855537239; Fri, 18 Jul 2025
 09:18:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717115936.7025-1-suchitkarunakaran@gmail.com>
 <CAEf4BzZ+OTkaXmtWPbOGB0OWz5xmj-d06UWchooO+iUyDHar4g@mail.gmail.com>
 <CAO9wTFgLOymS+VDcUTCHZ7niu_gEgN-N-F1uX-Kpm+uqvaMrQg@mail.gmail.com> <CAEf4Bzayn6UNjjbtgA8i2n4-_kuyERnOZAZMfc4cXTDKrSFr+w@mail.gmail.com>
In-Reply-To: <CAEf4Bzayn6UNjjbtgA8i2n4-_kuyERnOZAZMfc4cXTDKrSFr+w@mail.gmail.com>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Fri, 18 Jul 2025 21:48:42 +0530
X-Gm-Features: Ac12FXwjJnu7p3rh_Nm1Hf80A9R6X2OQXnzsdSC58X3ar7pRz68vSsoQRwmvdJo
Message-ID: <CAO9wTFgGgoEs08PazyWvnRyEQ4tvdCgjvtLNnzX_6Ov-RjU4Rg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Replace strcpy() with memcpy() in bpf_object__new()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Jul 2025 at 21:09, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Thu, Jul 17, 2025 at 10:33=E2=80=AFAM Suchit K <suchitkarunakaran@gmai=
l.com> wrote:
> >
> > > This is user-space libbpf code, where the API contract mandates that
> > > the path argument is a well-formed zero-terminated C string. Plus, if
> > > you look at the few lines above, we allocate just enough space to fit
> > > the entire contents of the string without truncation.
> > >
> > > In other words, there is nothing to fix or improve here.
> > >
> >
> > Even though it=E2=80=99s safe in this context, would it still be a good=
 idea
> > to replace strcpy() with something like memcpy() since it's
>
> no, there is no need. And keep in mind that this is libbpf library
> source code, which is developed as part of kernel repo, but isn't
> running inside the kernel itself
>

Yup got it. Thank you so much for the clarification.

