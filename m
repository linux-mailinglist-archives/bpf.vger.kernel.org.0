Return-Path: <bpf+bounces-73696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F75C37858
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 20:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B8A54E5F67
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 19:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CBB342C8C;
	Wed,  5 Nov 2025 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuha9v5z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25745340A64
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762371668; cv=none; b=NEsf14MRli7JbsknkzyuML6pMOzyu1CSSa1eGQ5/6+9T/MInqrJeNCMZ0iGAVlKzM10lX0Ftj+AyfCEdfcNYPsfmnVxqigz9M1RYXm50EczhJGILu09nJkCYQhNBzzc1CuGJN1ECvF8v1DtS6Dd0gXLeu0mFdAni3Y8/MmEgeYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762371668; c=relaxed/simple;
	bh=C5B9GxGKynn/bGUHoRkkgvCg0pIh/B+Fhjizl4WzJJk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lqJ8/R3kyo2FQDFNg7BYmSCqx28S37CkGESEJDbXxuK0+vQD8K4VtD5yaaKY8+bCTmYoJZCjdvba1ovDK8hMCwM/PpRyZrHDm2A5qioBxYHv++ZZ8xdEl4KBKJN2bdTdvHNdR3vHxIWYeIA9R+Am4a4aYEmuVaJECL3+RrYR+n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuha9v5z; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-294fb21b160so1737885ad.1
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 11:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762371664; x=1762976464; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C5B9GxGKynn/bGUHoRkkgvCg0pIh/B+Fhjizl4WzJJk=;
        b=iuha9v5zBNFWYaSMXmyzZW+Mvr7qqeqpNEa34QQvaNRuSUC8Qcd/B43jY/zfpPdm0U
         VeKgpXsUpSpmMGLCDDYKJyPTESOeVLSU2oGWYC/dZAelJRTooKHOMpiktegfWtBQtGo/
         Yhk/NuxbFS3aIToRflOHpGKUVLgIckdVYGdpB5tIIEjGX3EnD7PK+yjVdZUhPkBFJxl3
         Eb9IwGvllFMNFwZiZI8H79E3O5aquGVCoGCjiEkTah4s+icqAVFtwd8pgfkca1G4Ji7e
         vcbevePC+eNg+f4c3WMrDJgt1To2d7QfRdR3pXosERZyg0Nrlp3jPPfJvb1MaKqEFEvO
         Jxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762371664; x=1762976464;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C5B9GxGKynn/bGUHoRkkgvCg0pIh/B+Fhjizl4WzJJk=;
        b=RudQeCUTt6m/yo4voTTEkg0po1oa8T5UOnQj4fZVvw2iK3bRs7mXQGd3LUAqxzyKW8
         pu1X5RUnOEeVTqGtK+tmz/kgovCrhiXBDjYYeQ6ENYqQDSwiHxQKef7DiFoe6p3EWJ2O
         oEOnRdq1V3MIPaKKWNc/AtWFHG04jWdmbJKpQBZ7mkNWW1qtX11uy84vPjp8YMdnHV8T
         wYMkr6v0Sy4tfc1tUb0Ava2atAAtqFkj3JEFvocJ657slOwEKrEkTz1O/jeRl5sfYqFv
         JkX1P9P94NHQcIpIlnn9qz92NaWZ7CQpU4QP4WQdP1/RPvpuG/Ij/hN5sr+1BXShVN/q
         2whw==
X-Forwarded-Encrypted: i=1; AJvYcCVXyh6k7AMeR73PhlX4qc16SypPUnbbWHmQRG9khfWIfN6B9eGb8iWLrXXp50QVuIxbhZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6OBoyCrW6c5SQXyUi488n2Nhy6ckBdJZ6xd6QYdCHw8oSCAoO
	vPbsFAIdlHIavJeMo9GCryF4rwk2UeQ2c12ijaFNOPy8YOscRyMk5XSf
X-Gm-Gg: ASbGncvXH3qrCZyJeWAAP3P2c5NxT7DNZSiFMxK8wyZ4/rtf00titl97hB26Wpyf9CP
	Q4WJIWgxSJ3Lto/MoVDwhbSZwJLWIY5yJgGcjnQFEo3P6JADLgria17F5U4TpOIJUqvaPghQjkP
	uFL8sZ6rCyH7j5ZWmJqT6NNQd+tnXY4b/r0gG8TH4jPQctNBrK7XDTX+ElkltzAHQG93b5fPJ+P
	Y1Tj7kzYhH35BDBi8sD0BmcBW3vBN0VdXfOMxsbouKcHHPAtWHL4673vS9xulL/G2z3pT1IL1Hh
	Dd3HtRhdEUTvbifatVJHKuZr0Wcz0QLkSOikR+J6nwqqF94YY48X/uDmwLaeowjXSep9u0zqF6l
	2EYN7DhEJSVfPwgBgZJKW3oGkZQak2UakjUQUSzTYk1lhumlLX/7++b1b5kxFy3+Af8nLuXd0Lj
	tYu7fQYCyxMN1y3bZ3h31QJtoF
X-Google-Smtp-Source: AGHT+IFlDfByK8EQR3VsU/N7Fktp4sRb4vaWqlmdg9izLxvSHW9VykP1tI0nh0Yuf2migfAoNWhLFw==
X-Received: by 2002:a17:903:19cc:b0:269:aba0:f0a7 with SMTP id d9443c01a7336-2962adb32acmr61556695ad.2.1762371664315;
        Wed, 05 Nov 2025 11:41:04 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:cdf2:29c1:f331:3e1? ([2620:10d:c090:500::6:8aee])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5d0c1sm3413535ad.27.2025.11.05.11.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 11:41:03 -0800 (PST)
Message-ID: <7f3586157e17d0ab2c34b16d2f7daf4955d0692f.camel@gmail.com>
Subject: Re: [RFC PATCH v4 1/7] libbpf: Extract BTF type remapping logic
 into helper function
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Alan Maguire
	 <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, pengdonglin
	 <pengdonglin@xiaomi.com>
Date: Wed, 05 Nov 2025 11:41:02 -0800
In-Reply-To: <CAEf4BzZffw1sTJUBxwUnhx8XjQNMRf2-e+vUzOfyMqgMTpYsdA@mail.gmail.com>
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
	 <20251104134033.344807-2-dolinux.peng@gmail.com>
	 <CAEf4BzaPDKJvQtCss4Gm1073wyBGXmixv4s9V5twnF7uEHRhPg@mail.gmail.com>
	 <61e92756ea7f202f2e501747b574e97b2f5bc32f.camel@gmail.com>
	 <CAEf4BzanAmmSe84GnvWSR_KLFVmeEvrxVVJAvApFNRjgeRXk8Q@mail.gmail.com>
	 <61f94d36d6777b9b84e9bf865edd17476a278e73.camel@gmail.com>
	 <CAEf4BzZffw1sTJUBxwUnhx8XjQNMRf2-e+vUzOfyMqgMTpYsdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-05 at 10:20 -0800, Andrii Nakryiko wrote:

[...]

> You don't like that I ask people to improve implementation?

Not at all.

> You don't like the implementation itself? Or are you suggesting that
> we should add a "generic" C implementation of
> lower_bound/upper_bound and use callbacks for comparison logic? What
> are you ranting about, exactly?

Actually, having it as a static inline function in a header would be
nice. I just tried that, and gcc is perfectly capable of inlining the
comparison function in -O2 mode.

I'm ranting about patch #5 being 101 insertions(+), 10 deletions(-)
and patch #4 being 119 insertions(+), 23 deletions(-),
while doing exactly the same thing.

And yes, this copy of binary search routine probably won't ever
change. But changes to the comparator logic are pretty much possible,
if we decide to include 'kind' as a secondary key one day.
And that change will have to happen twice.

> As I said, once binary search (of whatever kind, bounds or exact) is
> written for something like this, it doesn't have to ever be modified.
> I don't see this as a maintainability hurdle at all. But sharing code
> between libbpf and kernel is something to be avoided. Look at #ifdef
> __KERNEL__ sections of relo_core.c as one reason why.

