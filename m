Return-Path: <bpf+bounces-71981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 067A1C04205
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 04:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97D4F4F082B
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 02:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9FD25FA3B;
	Fri, 24 Oct 2025 02:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFKZqeGi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DE31A9F94
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 02:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761273171; cv=none; b=U+MFZxcBG57f3Uo4/gIUwMrAmiUj0aHSffpjba+J3LdPds48j6X64wYNe8xxoJzHMVSzuKBrXHVxGQB3BcND9QF7+VwF2Ai50xVNJTNF31MYNacrA83znQJJoG38qrpZv1Ttg67/6ncFUUwP6A2kFrZhJkefPdXSFhik0CWEbEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761273171; c=relaxed/simple;
	bh=vPG3a4hyOHJvHMWu+yLrW5rtrL6w0p7z3FURndaIuB4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZZDAyf8siymrqiChwdOvNwgKdEvcBTUkFZ+DjLtdDrQ96GbdvuN/HAuFisA7tUlP4vvn8wB7aeTvkUFc8ZLt+ZzAUoXXHzxX5QQjUQeUNbwPEEdkyw2rOxBnrmtMmg6hyBc03G97X/Xl9w2GKsjVHaO1TiBHJF/aAok0uKaJWoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFKZqeGi; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a26ea3bf76so2044119b3a.2
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 19:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761273169; x=1761877969; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1BCjyoqVBOEFqTALONU11nUkdwL79cqW25g9s7nVg6Y=;
        b=VFKZqeGi2WDBcVA/aOn2OQnwvTvCOw64cZDa12/Nq+81DPP3Jn6+J4UoRz7uUa9nu3
         0r1p3sUknYnBEEbOaH5epp8DYEADOhnnf/vzzG8iKNiXzCez9BUgR27h5hBvJAT2UYhR
         Y4g4pFcJXmAbccZw+0T2HHPcBF2xlIX02vohzeObpBK1q+B9e4JtT0A9c9P+T+1gvxyU
         BNiL+5SIxDKsDlLfeYYvKDF/bCpI1UJVkrSc5Vvhe9/lqeHVbhWb1jx7l1rZjhxE+Cpj
         orb1klBl5kAbQOOzNpIerJl/gT+YWqs9U5ROXJjzNKvLbcsrSOJf9Y+iXKAwODu11oWp
         crsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761273169; x=1761877969;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1BCjyoqVBOEFqTALONU11nUkdwL79cqW25g9s7nVg6Y=;
        b=m9q1o6vc3JFiYl139kR/PWnmb5SkrPLLYGaZrLNY2psLyeyC4BDgNXxpt1KScMNhti
         WqacJRL9a3iWR8b2+wW0T3DAshqjfoLMJUgFK6sbBFwI0ldOBsUEOEqL/Kn6EAzsrOvj
         iUaXnPk/Y6QURfWEElk61c62U9OF1e7uOZF7KfPq9dLMDlzuBozSZ4eB8r1cgJIWnPw0
         srKoDRcbz6kkqcgB3OX7Q1AIYgi9dWvt/kVugg1LnKuVOQoQpsf40ff+hqhis5yYtuA2
         3XB++iVaojFB5dpWsjoFWlcQ1dCPhgBLMmYWuiBB82A0VtSeDVqgyTYDuwz94Dp+aRgz
         RXRw==
X-Forwarded-Encrypted: i=1; AJvYcCVt2D7f3Y6e981N/o3a15c8sf3vbZEmFGwLs9su99K5MhS7wqnNCttJdf2stXjrUaLE1pc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw41Bs6tUyOTA/Q+hJs6XqQnMnV/lJyEuf/JWiQqJSfISD8g4fQ
	L7lAOkcVynffly4ssIt9vNXmXxoH4e/JEiPL45EgZzY8A7BYDHEINM8c
X-Gm-Gg: ASbGnctrtba2FQjTJ0whffDLMzl4wPrZ3c4fNen0DchjEbrD7JkXaroLgzkdWGwkE22
	bOr+IUWbEyuZ0HMYV5cHsWop1bExiaoyoZcwtaLPOBfTE+z/1YsTlNXloufpL3K8cjCZp6mVrOx
	asHuJCyOkxPdvNs1i4nRVnwcwIfsQAgnKMzYY2DVo6ETvz89SyiSe+KpYZgETUMBinFfDB5Qbmf
	VRqaHVPv6SvarfmCDIEr+9lysR0Yz5Ek5zxLja2CfEJwf34tWBjsqbcTrxFRUhlnGxR4UvxuE1K
	fAx6deHq/MhG5/Yoaqr4ymLzg81VM4lXJDyX9oArN3RjPuTAEuB2glbPAa/uaGb2dcxrFq19EPx
	t0SwnhNoFzmAr2G45NY2eG6KeiFuo+bWJ0VTeUqTv/NS6YP4A2OJz2tEgNjW21iOJydjJ0WiLOI
	NQvE8IuynFkfCG5hNRj30=
X-Google-Smtp-Source: AGHT+IEWzefBMWHhbT3A3+27++kBjN34XpUbub5vApRotaEGAlnzC0h0kH5iwJYKPszI79kOOb+cOQ==
X-Received: by 2002:a05:6a00:2e85:b0:77f:50df:df36 with SMTP id d2e1a72fcca58-7a286803147mr817035b3a.18.1761273169435;
        Thu, 23 Oct 2025 19:32:49 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21e8::149f? ([2620:10d:c090:400::5:c9ef])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274a602c8sm4174451b3a.7.2025.10.23.19.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 19:32:49 -0700 (PDT)
Message-ID: <7d9e373c7f0f3b7a50ee6a719375410da452b7ba.camel@gmail.com>
Subject: Re: [RFC PATCH v2 2/5] btf: sort BTF types by kind and name to
 enable binary search
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, Andrii Nakryiko	
 <andrii.nakryiko@gmail.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>,  Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <ast@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>,  bpf <bpf@vger.kernel.org>, Song Liu
 <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Date: Thu, 23 Oct 2025 19:32:47 -0700
In-Reply-To: <CAErzpmsCJAWVjWnV2LWAnYCouynYZbUupS08LUuhixiT2do3sg@mail.gmail.com>
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
	 <20251020093941.548058-3-dolinux.peng@gmail.com>
	 <174642a334760af39a5e7bacdd8b977b392a82c7.camel@gmail.com>
	 <CAErzpmusSgOaROhEO25fKenvxQJU1oSPKKzUA4h67ptdQxWM7A@mail.gmail.com>
	 <7651ac9cc74e135f04ecfee8660bea0a0d3883ab.camel@gmail.com>
	 <CAErzpmtWLLYuFk3npTiOgGOKcEcH1QUGGEHLvPncVT+z261C1A@mail.gmail.com>
	 <CAADnVQKU0MnQHxxvnp9WCu_UO4fEtd_D6ckNmOd7pLg90ecF4A@mail.gmail.com>
	 <CAEf4Bzajdv3Rd1xAxm_UZWBxPc8M0=VuUkfjJvOFSObOs19GbQ@mail.gmail.com>
	 <CAADnVQJG_tK18oxmjW37cbrxF2zPKPk_dvqXUTnOjUue7J0tLQ@mail.gmail.com>
	 <CAEf4BzYLyi6=Fyz9ziOAwkFOjUPyJmTj4c6g247XBwgwJ8m-qw@mail.gmail.com>
	 <CAErzpmtMPuGBhisLOaZMyzM5u3=0QrmZcuWqNgbMrceEEPN3TA@mail.gmail.com>
	 <CAErzpmsCJAWVjWnV2LWAnYCouynYZbUupS08LUuhixiT2do3sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-24 at 10:23 +0800, Donglin Peng wrote:
> On Fri, Oct 24, 2025 at 9:59=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >=20
> > On Fri, Oct 24, 2025 at 3:40=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >=20
> > > On Thu, Oct 23, 2025 at 11:37=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >=20
> > > > On Thu, Oct 23, 2025 at 9:28=E2=80=AFAM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >=20
> > > > >=20
> > > > > Speaking of flags, though. I think adding BTF_F_SORTED flag to
> > > > > btf_header->flags seems useful, as that would allow libbpf (and u=
ser
> > > > > space apps working with BTF in general) to use more optimal
> > > > > find_by_name implementation. The only gotcha is that old kernels
> > > > > enforce this btf_header->flags to be zero, so pahole would need t=
o
> > > > > know not to emit this when building BTF for old kernels (or, rath=
er,
> > > > > we'll just teach pahole_flags in kernel build scripts to add this
> > > > > going forward). This is not very important for kernel, because ke=
rnel
> > > > > has to validate all this anyways, but would allow saving time for=
 user
> > > > > space.
> > > >=20
> > > > Thinking more about it... I don't think it's worth it.
> > > > It's an operational headache. I'd rather have newer pahole sort it
> > > > without on/off flags and detection, so that people can upgrade
> > > > pahole and build older kernels.
> > > > Also BTF_F_SORTED doesn't spell out the way it's sorted.
> > > > Things may change and we will need a new flag and so on.
> > > > I think it's easier to check in the kernel and libbpf whether
> > > > BTF is sorted the way they want it.
> > > > The check is simple, fast and done once. Then both (kernel and libb=
pf) can
> > > > set an internal flag and use different functions to search
> > > > within a given BTF.
> > >=20
> > > I guess that's fine. libbpf can do this check lazily on the first
> > > btf__find_by_name() to avoid unnecessary overhead. Agreed.
> >=20
> > Thank you for all the feedback. Based on the suggestions above, the sor=
ting
> > implementation will be redesigned in the next version as follows:
> >=20
> > 1. The sorting operation will be fully handled by pahole, with no depen=
dency on
> > libbpf. This means users can benefit from sorting simply by upgrading t=
heir
> > pahole version.
>=20
> I suggest that libbpf provides a sorting function, such as the
> btf__permute suggested
> by Andrii, for pahole to call. This approach allows pahole to leverage
> libbpf's existing
> helper functions and avoids code duplication.

Could you please enumerate the functions you'd have to reimplement in
pahole?

> >=20
> > 2. The kernel and libbpf will only be responsible for:
> >     2.1. Checking whether the BTF data is sorted
> >     2.2. Implementing binary search for sorted BTF
> >=20
> > Regarding the sorting check overhead: if the runtime cost is sufficient=
ly small,
> > it can be performed during BTF parsing. Based on my local testing with =
vmlinux
> >  BTF (containing 143,484 btf_types), this check takes at most 1.5 milli=
seconds
> > during boot. Is this 1.5ms overhead acceptable?
> >=20
> > Are there any other suggestions?

