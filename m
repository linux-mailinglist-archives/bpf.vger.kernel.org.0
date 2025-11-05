Return-Path: <bpf+bounces-73543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C43C337B5
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 01:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7191427E74
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 00:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C00D50276;
	Wed,  5 Nov 2025 00:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kb0/vgrS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B568127732
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 00:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762302974; cv=none; b=n8C+1HknrY94X9VYCMdGSYupm/VsWc6qybABHY0/pkrq4IN++as9anbmUq12EX/ad5xMzCnCAvjqJqlSb/veLE0Tiv/g7IlAumFYf3P2jOXfePMrhhRE0QTPYq7HJ+Q30QeFNdQsaFLNCGCdthWIuwRF+gHXq3myUUSTT5SXzRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762302974; c=relaxed/simple;
	bh=tMwItzjK7kWEv1l7OAiH2OW0E5juLPcM+RiVo/WuX9Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gIIktmHbQLzouoDI9zPhHXB5gXvAz7nG7Hj3dN1DqBYifJgtNVtym5Bt0T0Bz2w+53u4F3TkTp5V+CcWUwfucG1QUaiuTm/gl6ElkcDpu3ygpgxzi/oDMHLrt/zUvjEWW7W6DLnzrciD7L26WvcLIosXG3fzh2muJiia1SUPVm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kb0/vgrS; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27d3540a43fso61630755ad.3
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 16:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762302972; x=1762907772; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G0p6mEuVP3AqKPTywWAeTUb/q8ogCcHxUwb7jRAr2sE=;
        b=Kb0/vgrSbTsiW6/bGFl/uPZ0bVXkJOCZRUOms8Bz8lc40TOuwu7WZ0XCifKQeN2JWa
         UyJC9cjJIW174/ceEZrRPeRLkWkWnpZupzq9EjUnUP9VHw9yPuhNh4uk8HJ6E1evdexx
         Ci/Q0afXeXPAEoLr+CSnjY1dDMjgCg2acJ42AfcsSTnIp+yR54qhGiF/3XwOxgw/cW07
         bqBjPu4DCbLcH7KcMYGJo+nwsdls7adS9MriDh/kJh2aVaNnBdr+4g5RCFrxqjmKPmts
         Q7gwXWxWCjdtgPT+EFCf6nToJp1UQzicpxDVf7B2P2OQVMkm6kygCDPO6oEfJpG6p4b7
         l3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762302972; x=1762907772;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G0p6mEuVP3AqKPTywWAeTUb/q8ogCcHxUwb7jRAr2sE=;
        b=CckL4kP3GZq4cvpjFk5LCnyVh+Oe7IhR32kV9hcPHThpq9Tjszbl9ceU8UjmvRj8k+
         zAEyAVY4dlmXtZzkYledKX5khwtR1jk1VADVzMBnSbVx+5IiJlM0fhkJRtjb56kruPdI
         JpIjDZtDHfNAT7yfrXAWqasrenQhjwmjG26RQK2QoX3/UaGCmIXOWmUZEBnIDxsKmGED
         zDK3uglomccUC2lV1LuPTkosIJwL2Vs2YhYHoqVQJkRtkTiemAyOlKGUq5ro6KkWhvTQ
         1IpPvoYft75OtCkF7mwTfOem8s2JOhopzhb2MZ30Fvtx93XqWvhd9FVqdlGzN1vslJqE
         dATw==
X-Forwarded-Encrypted: i=1; AJvYcCVHrzM1wsZ8wuQVRTmj8NbuDGCtXsmMeKGvd8vaYL9U7Kt8mpf/HJfrfFCRt71A2flEtm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBwg+kzHRj1FkkYYzYYg1153b3X1snTqP6C1rbEl0mMkxQL+KL
	WsOE3dPaDNDnp/Ls97sce6X5vTsdfKq3pYLIelWnlDfsdK3HY91yw+BB
X-Gm-Gg: ASbGncvEuwTsejkRg/2gDXsbx9vzIsB9+D6Bx1uqjo7bo6vUEPUvfc9uPrUMtUZ6IgW
	YVegA9mL5rH1KSeoko7SaCG2KFZYhufTkFpDYkeximvVDcBaLptRS/bC3Q0Zrkmvo6XhpSUDxqg
	6gRodWa7JrysYDHMp3eXkFwS6AYtcwnuHRblr7TqgRs29Hph4HbJ/6Vboj+3UTva51Cbb8bIJk4
	p9iDpt21U+elU2wA1QuBAmehjU7bBV1gXpLC0xfrVgxsKR/p3tXPdhx+vGlrkuXykMkgQ2ZrwBc
	sbH8dryZFRaz4q7EAvcFsIspOCLWtT08OXwQ+SSUNELywSjHyeDAq9jd6QXngPAzPjzPvIOKawY
	O7fN2of3WE2QyAQRrftq4lx0iY4FRWw4lHW35biin0Dirm1z80MFQEVUZrkqlEUjBrQNhnmGnF8
	FNykhylIw5qePXJetq5ONUkN0=
X-Google-Smtp-Source: AGHT+IGlPtyujRy6YhhYy40c4CQD3gv/OltOc4AIha0FgdRU4iKRhc5I3i1/9QsXvdFjqiG+BuMkTg==
X-Received: by 2002:a17:902:f68a:b0:267:99bf:6724 with SMTP id d9443c01a7336-2962adaf468mr21399025ad.31.1762302972025;
        Tue, 04 Nov 2025 16:36:12 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a643:22b:eb9:c921? ([2620:10d:c090:500::5:99aa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972a92sm41331065ad.7.2025.11.04.16.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 16:36:11 -0800 (PST)
Message-ID: <61e92756ea7f202f2e501747b574e97b2f5bc32f.camel@gmail.com>
Subject: Re: [RFC PATCH v4 1/7] libbpf: Extract BTF type remapping logic
 into helper function
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Donglin Peng
	 <dolinux.peng@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Alan
 Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, pengdonglin
 <pengdonglin@xiaomi.com>
Date: Tue, 04 Nov 2025 16:36:09 -0800
In-Reply-To: <CAEf4BzaPDKJvQtCss4Gm1073wyBGXmixv4s9V5twnF7uEHRhPg@mail.gmail.com>
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
	 <20251104134033.344807-2-dolinux.peng@gmail.com>
	 <CAEf4BzaPDKJvQtCss4Gm1073wyBGXmixv4s9V5twnF7uEHRhPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-04 at 16:11 -0800, Andrii Nakryiko wrote:

[...]

> > @@ -3400,6 +3400,37 @@ int btf_ext__set_endianness(struct btf_ext *btf_=
ext, enum btf_endianness endian)
> >         return 0;
> >  }
> >=20
> > +static int btf_remap_types(struct btf *btf, struct btf_ext *btf_ext,
> > +                          btf_remap_type_fn visit, void *ctx)
>=20
> tbh, my goal is to reduce the amount of callback usage within libbpf,
> not add more of it...
>=20
> I don't like this refactoring. We should convert
> btf_ext_visit_type_ids() into iterators, have btf_field_iter_init +
> btf_field_iter_next usable in for_each() form, and not try to reuse 5
> lines of code. See my comments in the next patch.

Remapping types is a concept.
I hate duplicating code for concepts.
Similarly, having patch #3 =3D=3D patch #5 and patch #4 =3D=3D patch #6 is
plain ugly. Just waiting for a bug because we changed the one but
forgot to change another in a year or two.

[...]

