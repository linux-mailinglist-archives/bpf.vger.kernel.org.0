Return-Path: <bpf+bounces-72937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1001C1DD5F
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 00:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231B53B1D15
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 23:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E08C322DCB;
	Wed, 29 Oct 2025 23:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKYt5kR0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45293218A6
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 23:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761782389; cv=none; b=pjktC78mMZM2H1E4SMMAT2T1S0kdLd9Lr+045immV5rR1Drkpb0XWVAV5wwH7Wi2NYrj6zwwR54bMnW2ORti/DZPyQbXtE5H40gLn3q8WYvhY8qm+X+k392wHapldYqO2LaSkgCBpZpVz2ey56WDtsqjDATkbVE++s4RZrKP5qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761782389; c=relaxed/simple;
	bh=i2Tu3OERxIJU94p32GIwdUPm1ZC3DaalkCjMsoAxGjU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rNRbwNTwmZ7rXa/LUjrAkFM88523jWCFfE69LBJPcJ7hen/WgKj5Uj6/7ZCP2YwZkszGBWkW5gcHIb7HQ9BynEKrn5aXAXxnREugS1oPobVRcJ3Xp3kkNDRgZrutPHS+u1CpG39L9W+iim3rVgMYAtkbuPLG1lWmlwZF6qW+zdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKYt5kR0; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b679450ecb6so276578a12.2
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 16:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761782387; x=1762387187; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zZPMEQHhY1SKu3WdzqqY8qEY3DLdmoW5FkRBPOLzvVI=;
        b=IKYt5kR0fPd44ZDSqWQQPVzfPFlbmyTJxr90zGnO8cLdZb5/Hj9J1BoZAz0uitouW+
         L/wzPVWo3X1njsazf3j31K/HhjbaGdHJ/3jlKPElzMU6r79HXDuKjaBUilXySA+8jy2I
         l1VqpmTdRZV/M8bSKnt73JkmE2aq6EC+r6u81A/lSjSSw8QHYRbUDDc4xvBMg3i7aw77
         cTgeN4b2z0SkFPrF299cJ8JxJ5cAs0iumXUj27SCUtq//ghwxq4qKQBixiXCv7HHUJmU
         Rw3DmVbu58LaNHhjH4A7p+XOJBuIceKPW0CnG/d3wkUsXXY2ZakMO2/PctTYBepkI9BA
         NDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761782387; x=1762387187;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZPMEQHhY1SKu3WdzqqY8qEY3DLdmoW5FkRBPOLzvVI=;
        b=ZkIxK36sj98IwBvPn3b4J+AwvTukkuQrz2/ILBHpF26SBDqdUKyYdZuguMq1rGyYdl
         4ZQiqPt8kXORIJohCxNyzXULfXj4C8iczBqwn3yG4uvP+qfUki32OlOoDYUeCbHtNXxD
         LS1F8hmd/6flqvi94g9Lpe3ITeJGwwlyslF1PURx90LL44EIyEyQq4Reo1a947hBa3wt
         qq5I/1H3kMMn6KPdrl1905Nkij1aTJpx6wcQbS87/MrI7Yp/lz79NY/ulkjqOaDbYCk/
         AGSQsyqT2a/rxQvkof85uNGupjLYWCTQA0QgRB6jpOJZO+oIBDfFWHLk3klmu4U4E1eb
         PWGA==
X-Forwarded-Encrypted: i=1; AJvYcCVesfLQZkh0V9txND9qPBM7YyyW3Henr90Z+OQDoHCyTEfh7vY2wXUp4ZX1djdn5UsQZs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi9mOrxHE91RUvhbqYulSUl9VAaJLea3ieBqRzeEpNpY6DYGi5
	5QvObUzvztgby21kx108BxexT0O2R3XlpB6bcZcNfU42Po37IpvPzTNk
X-Gm-Gg: ASbGncv7M8T33txjHPBEJwzfa3K6AgJqgjzrAAz8DIbub0B4rlwo6CTEVzY4kfAu7jq
	M8Mwo1EEjEAWuCd1eZFjB6fVyEHxkKCL86k4r3Yrt/drByd5k5j/AN7JhKhW2veiztUH23uLbBh
	ETwrzpOx8or2+Hnqs/9UB5UbzlKXWjA6PKCG/ZtxT5W68xOZ54m7gn3KWxZPCRn8oAyiIj99hrg
	bSEO8p7PJLhcQtYRrbwGwJlj9AULnovkYtE3eB4q2ZmtftiJunKCykkeczx2UhN5t/ps9iShPpr
	IBoxh5HyjHOkD26ZclxMoasmoADb+VbqRCBz+ljQFR8tNoV+IHapaQk5Qo1fbGBQUtZ3FPA0LeH
	y2stRBmVCVTvHynEDXElxdVWZf7LhBBVFQQhyX9JKb7QcK2vvu2bQRlO/jp5RoUp3HexRAnLHrA
	Q+qbD58Q28kyygstT9CVPhrxWIaw==
X-Google-Smtp-Source: AGHT+IHLbqeKvJCQVr9MgwbQlo3UdbesRz5XASNZWgWFJ9mDBLDnX0HY1mebpt8cJ+csaC0o6OoFsw==
X-Received: by 2002:a17:903:234d:b0:290:7e29:f59f with SMTP id d9443c01a7336-294dee60875mr55661805ad.27.1761782386986;
        Wed, 29 Oct 2025 16:59:46 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:3086:7e8a:8b32:fa24? ([2620:10d:c090:500::5:6b34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e42afdsm162121235ad.99.2025.10.29.16.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 16:59:46 -0700 (PDT)
Message-ID: <36befdc138d8f1b15fab46c3d2c4d9f8b313779b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/8] bpf: Support for kfuncs with
 KF_MAGIC_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bot+bpf-ci@kernel.org, 
	bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org, 
	tj@kernel.org, kernel-team@meta.com, daniel@iogearbox.net,
 martin.lau@kernel.org, 	yonghong.song@linux.dev, clm@meta.com
Date: Wed, 29 Oct 2025 16:59:45 -0700
In-Reply-To: <c974f5ed-b6d2-4716-a119-7efab07e2e8e@linux.dev>
References: <20251029190113.3323406-4-ihor.solodrai@linux.dev>
	 <39bb0d21fffe3855c246dd85b2e69524c8e31bc9d84b441b063f365e5cbf220c@mail.kernel.org>
	 <c974f5ed-b6d2-4716-a119-7efab07e2e8e@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-29 at 13:49 -0700, Ihor Solodrai wrote:

[...]

> > > +static s32 impl_by_magic_kfunc(s32 func_id)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i =3D 0; i < BTF_ID_LIST_SIZE(magic_kfuncs); i +=3D 2) {
> > > +		if (magic_kfuncs[i] =3D=3D func_id)
> > > +			return magic_kfuncs[i + 1];
> >                                     ^^^^^^^^^^^^^^^^^
> >=20
> > Can impl_by_magic_kfunc() overflow magic_kfuncs[]? With the current
> > initialization using BTF_ID_UNUSED, BTF_ID_LIST_SIZE(magic_kfuncs)
> > equals 1. The loop condition checks i < 1, so when i=3D0 it executes an=
d
> > accesses magic_kfuncs[i+1], which is magic_kfuncs[1]. This is outside
> > the array bounds.
>=20
> Hmm... Given we do i +=3D 2, this can't happen if magic_kfuncs table is
> defined correctly. Also if BTF_ID_UNUSED is passed in here, we have
> bigger problems.
>=20
> I guess changing the loop condition to size-1 wouldn't hurt.

The code is fine and there is no need to bow to the AI overlord.
That time will come, but it hasn't come yet.

[...]

