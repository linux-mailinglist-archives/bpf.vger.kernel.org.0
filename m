Return-Path: <bpf+bounces-52126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D17BA3E984
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 02:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90201755DD
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 00:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB101917E3;
	Fri, 21 Feb 2025 00:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqYLH4n5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A148B18D643
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 00:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099392; cv=none; b=aIAL0Hr5wNCYrsqeMmC5d8SUECknEOYv9URzNZpaFEPmVPiE5OCNi6GuHEBuge/2Q/SDJ1Z1QPCWJkcZmTa0IGeWrOj3Dchj7MsTfueHw3OeHcGJ2lIl6qrtHQgYuUAc7dN+3bHVuocIntE4Jz/co02+fofgg7lkq/dQxNCOiFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099392; c=relaxed/simple;
	bh=cCw5BLHzkEcERvBdEjPeKkx7cH02FaNNIFFQDOWUwtg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fE9vgw+Obobggcz6R4dLA74UWHCtVswTvJ372aEOVvdBWQWCSNjFDoflPoMAlUEXsb5JGsCW87JAyaMA5FXrQPCwv6j5UQK6o7H0ijie3b1+yMFlKYnbUiLF6XJwesZL/J54O2/bxYk+dvT/xezBWcS5KINf4o8dKeoCUlX+tZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqYLH4n5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2211cd4463cso31664535ad.2
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 16:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740099390; x=1740704190; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GLsK7XaZEJiesHU83JnO+UOwVGD1O++qwj4jjG+lCT8=;
        b=QqYLH4n5ddGdQVngvDvPH+Sd0W/13UivGJTzZqR4DCPCN69oOASteSisu71p3CjASW
         Lui1WJj/3UQWUQYX344j/r7uRBf8nJgQM9cvh6QNhwquTHIeVWWlsf1zTxOO596bdJ8l
         0bOJIMQh1DYK++BFKIckl8I6dSVoHU7vbDlHZgHkcG8jmV87CKmCmL4POzNjTT++Y9et
         khJG4EQ4KDAtjmOel86WQ0vEJBqCjpRLumUtJ5yVtBWWsJyl8OA4IzQzrmA2npF9Mr69
         lu+Q2fVsJDpEm4CWM/T4vpXYLQVKiMU5iWUwF3n6qDWS7r2jA7DJheKCzi0CltFnVfmy
         K2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740099390; x=1740704190;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GLsK7XaZEJiesHU83JnO+UOwVGD1O++qwj4jjG+lCT8=;
        b=Jl0eb2Xs5vRZwW4MQDtkMbgLFIBhl5Gak9jc7cP3YbgbA3+mIHzPZ6EVodt9TxVFmY
         1N5AGfXcjaxol9JeTB1fbKwRNoKuIGZwiExEtF7XU2b4LvZRxisxAlcMBBWP2MhMscI7
         QUDPS8FB34k/tc0PraHrx0lkxHU+vq7Jd2XaNbRoIYpm1kZGy8ccmEKpL1g/jZzAAz4c
         Kw9PF8tMMcglVkHCwVYMK6GPX9uMURXq3MJySEMnJ0trunf7s1kRbsqLPnxZjZl5mUjI
         m9Pe1EVmINkmd1ujbrSMRYy4nMi3exbqLAr7HUnnlaPysaQ2i8JIXP5DeA8jZcMHM3ab
         D2rA==
X-Gm-Message-State: AOJu0YwsXrrTkTHEfIzVhF9etGQmXnGQ6pU9033+MZ9sdXtpFvBVH9u3
	U6tHxbShgg7bIIvtmsGYt/B61bvxG11yI4z9mWC6mKcSKfh+PO9Z
X-Gm-Gg: ASbGncvQON2cFibYl6iDdpeN62QutKzpARceag+qboc9NOGmstCmVD6wTwZqHOvjHBY
	bFkT67o8/mJTRTHRvB5OCALh4aU3ARtgE2fTNYXwCYvRz1U5DKU5pIEGemIq3Lr++bjyalmbBLA
	iHFOQj39egpDXp/gzfMyHCIx8xpIx/PS55+Rp84JU8gG/d9z/PIVvlClIgCRLWWjdQUhmlKu5Y9
	h1CdDilUAIJAOu0/Z+rArjHakwMVlCyIYIlSizvWcF/+0zLJvIr+F06FpQeS2WdGcX4ThmFBSsx
	1pG7mMrCf7za
X-Google-Smtp-Source: AGHT+IGZK7uF/oauZMwlbBET6zUQGPyrF44TIk0yHnFxGpac1qKawgoTSRxxYEuu2A47VvingkorCg==
X-Received: by 2002:a05:6a00:1392:b0:732:5a8f:f51a with SMTP id d2e1a72fcca58-73426cb1e67mr1977091b3a.8.1740099389903;
        Thu, 20 Feb 2025 16:56:29 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73414be6fa4sm2189502b3a.36.2025.02.20.16.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 16:56:29 -0800 (PST)
Message-ID: <e65f6a87ca81fd92dec31575e917f9cd4af94c14.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: add tests for
 bpf_dynptr_copy
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Mykyta Yatsenko
	 <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	kafai@meta.com, kernel-team@meta.com, Mykyta
 Yatsenko <yatsenko@meta.com>
Date: Thu, 20 Feb 2025 16:56:24 -0800
In-Reply-To: <CAEf4BzaxYL1y4wR0KuSouDzmrt610CBwtv0dKp4xbO9LD-t9qg@mail.gmail.com>
References: <20250218190027.135888-1-mykyta.yatsenko5@gmail.com>
	 <20250218190027.135888-4-mykyta.yatsenko5@gmail.com>
	 <CAEf4BzaxYL1y4wR0KuSouDzmrt610CBwtv0dKp4xbO9LD-t9qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-20 at 16:52 -0800, Andrii Nakryiko wrote:
> On Tue, Feb 18, 2025 at 11:01=E2=80=AFAM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
> >=20
> > From: Mykyta Yatsenko <yatsenko@meta.com>
> >=20
> > Add XDP setup type for dynptr tests, enabling testing for
> > non-contiguous buffer.
> > Add 2 tests:
> >  - test_dynptr_copy - verify correctness for the fast (contiguous
> >  buffer) code path.
> >  - test_dynptr_copy_xdp - verifies code paths that handle
> >  non-contiguous buffer.
> >=20
> > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > ---
> >  tools/testing/selftests/bpf/bpf_kfuncs.h      |  8 ++
> >  .../testing/selftests/bpf/prog_tests/dynptr.c | 25 ++++++
> >  .../selftests/bpf/progs/dynptr_success.c      | 77 +++++++++++++++++++
> >  3 files changed, 110 insertions(+)
> >=20
> > diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/s=
elftests/bpf/bpf_kfuncs.h
> > index 8215c9b3115e..e9c193036c82 100644
> > --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> > +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> > @@ -43,6 +43,14 @@ extern bool bpf_dynptr_is_rdonly(const struct bpf_dy=
nptr *ptr) __ksym __weak;
> >  extern __u32 bpf_dynptr_size(const struct bpf_dynptr *ptr) __ksym __we=
ak;
> >  extern int bpf_dynptr_clone(const struct bpf_dynptr *ptr, struct bpf_d=
ynptr *clone__init) __ksym __weak;
> >=20
> > +/* Description
> > + *  Copy data from one dynptr to another
> > + * Returns
> > + *  Error code
> > + */
> > +extern int bpf_dynptr_copy(struct bpf_dynptr *dst, __u32 dst_off,
> > +                          struct bpf_dynptr *src, __u32 src_off, __u32=
 size) __ksym __weak;
> > +
>=20
> Do we *need* this? Doesn't all this come from vmlinux.h nowadays?

It does come from vmlinux.h, but this test does not include vmlinux.h
(and compiles a bit faster because of that).

[...]


