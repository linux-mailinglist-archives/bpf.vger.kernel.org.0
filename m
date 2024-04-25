Return-Path: <bpf+bounces-27821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C77A8B25D4
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 17:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6EB71F21757
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 15:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E623214C59C;
	Thu, 25 Apr 2024 15:59:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD7C14C587
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714060760; cv=none; b=ujVsFlrGrnk/9LnJEhe63NkI9G93MFE4rzkagoE2ZejxBE3cuZBZSsqEYHLUxjK+xKRjwOW2o7/bo/5hzsdBq3o6CcZidUZnuQEX9Qnd7KcnwJuDLtq6805EOBWOG5CUHrzistCLdYJpog5gYXa9dpwA0MY24hAQEf3KHZArVpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714060760; c=relaxed/simple;
	bh=hxgZFo1dl8BLbbGKv+mVTYiUr9CgJEFD50rASCMbcDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2cggXdhXh0EvQUVjIxWd94CEWz67GR1CbjzKZs4C0tYO+t1ZOZcrnEW7RmCEXKwMT6ygOV4GhR9EZWRv2UQEgIjeoI1NDWfsp6toFborybbt2ZRcbFGQ1wbTw3LuCCNLB7CHlZn9rnMVf9TSsdF+DlhqGlKtEZ6y3swhfa6fAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d6bc8d4535so49559439f.2
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 08:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714060758; x=1714665558;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KR+BUux4flvSscHbSXDH2fti4hUFzwPBNwC8E9yOOAQ=;
        b=h6fbgbJDmmy3maaKE6Jg3BLVwfbLxzNoiNbBYK3Bd1MUC6tUSLFozlyyWcIiPVnJkj
         ToLSSu0+1fqgDaCS7xSQjEGTLCKPideSl/y54U9gDzbPAs9As+euMdqNel+OtMCqhx+K
         3o8qN9D0iBiaBacpbgkyG7hG5TlWEXUG5E84QYhDUB3hpwI5w/VLHOu3XLzcpVcoK47P
         dSzoFgIG7kyQAHLhR26WJLc0JlqvoxcwLuhmLD98q4WEOaf6zdbLv7u3P6v9HCpdEYT6
         736GBmuoGanCIJSWeHcaJ0I25aFmjJluqmMsO26gewyFgCBWujdL5QRJ+6ChVnbkocQe
         Fsdw==
X-Forwarded-Encrypted: i=1; AJvYcCVQDwgGnwbsM0w64WvwILrOVbn3cHX7Fsga8I0zp2uwJJ4Ujb5maoVGkaoULIntGt2OoGy8/uO4KHAHYO1tulDoHGIJ
X-Gm-Message-State: AOJu0YzATlh5HGrJidvzzocRaUY62gzx84qZWQA3lo4MzIkxZcT5Xq2f
	IGa5jKP4DP5595ahHqhcJYbM2z5xBddntFdc6HqCQ5+268cAmUci
X-Google-Smtp-Source: AGHT+IFc0p8+tqepHkPliahVbK1YbmP9t3h+zoxgQSS+RC8pRRcin/CDt4WBC4dh6Ojcyt23LnIiyg==
X-Received: by 2002:a05:6602:10a:b0:7d3:3e40:626c with SMTP id s10-20020a056602010a00b007d33e40626cmr81397iot.12.1714060757945;
        Thu, 25 Apr 2024 08:59:17 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id fg1-20020a056638620100b004872a283f46sm147912jab.87.2024.04.25.08.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 08:59:17 -0700 (PDT)
Date: Thu, 25 Apr 2024 10:59:14 -0500
From: David Vernet <void@manifault.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC] bpf: allowing PTR_TO_BTF_ID | PTR_TRUSTED w/ non-zero
 fixed offset to selected KF_TRUSTED_ARGS BPF kfuncs
Message-ID: <20240425155914.GA11295@maniforge>
References: <ZhkbrM55MKQ0KeIV@google.com>
 <3f8a481e-0dfe-468f-8c87-6610528f9009@linux.dev>
 <ZiAu6YDi-F_pxLOV@google.com>
 <dbba17cf-4351-45ca-9f43-090a0923a2bb@linux.dev>
 <CAADnVQ+z5w4GaMudrLXw3LAq1B3Ong7FhQHdkJN7m8svkCpMgA@mail.gmail.com>
 <20240424055005.GA170502@maniforge>
 <CAADnVQ+xPgOCYsMk8Tot0PPTWgY5Yqat9V-qZGaWXAF+BpxCow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DYZSdPU9XbIG0Ccc"
Content-Disposition: inline
In-Reply-To: <CAADnVQ+xPgOCYsMk8Tot0PPTWgY5Yqat9V-qZGaWXAF+BpxCow@mail.gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--DYZSdPU9XbIG0Ccc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 11:36:51AM -0700, Alexei Starovoitov wrote:

[...]

> > The OBJ_RELEASE causes check_func_arg_reg_off() to fail to verify if
> > there's a nonzero offset. In reality, I _think_ we only need to check
> > for a nonzero offset for KF_RELEASE, and possibly KF_ACQUIRE.
>=20
> Why special case KF_RELEASE/ACQUIRE ?
> I think they're no different from kfuncs with KF_TRUSTED_ARGS.
> Should be safe to allow non-zero offset trusted arg in all cases.

Yeah, after thinking about this some more I agree with you. All we need
to do is verify that the object at the non-zero offset has a
ref_obj_id > 0 if being passed to KF_RELEASE. No different than at
offset 0. This will be a nice usability improvement. The offset=3D0
restriction really does seem pointless and arbitrary, unless I'm
completely missing something.

> > > We can allow off!=3D0 and it won't confuse btf_type_ids_nocast_alias.
> > >
> > >     struct  nf_conn___init {
> > >             int another_field_at_off_zero;
> > >             struct nf_conn ct;
> > >     };
> > >
> > > will still trigger strict_type_match as expected.
> >
> > Yes, this should continue to just work, but I think we may also have to
> > be cognizant to not allow this type of pattern:
> >
> > struct some_other_type {
> >         int field_at_off_zero;
> >         struct nf_conn___init ct;
> > };
> >
> > In this case, we don't want to allow &other_type->ct to be passed to a
> > kfunc expecting a struct nf_conn. So we'd also have to compare the type
> > at the register offset to make sure it's not a nocast alias, not just
> > the type in the register itself. I'm not sure if this is a problem in
> > practice. I expect it isn't. struct nf_conn___init exists solely to
> > allow the struct nf_conn kfuncs to enforce calling semantics so that an
> > uninitialized struct nf_conn object can't be passed to specific kfuncs
> > that are expecting an initialized object. I don't see why we'd ever
> > embed a wrapper type like that inside of another type. But still
> > something to be cognizant of.
>=20
> Agree that it's not a problem now and I wouldn't proactively
> complicate the verifier.  __init types are in the kernel code and it
> gets code reviewed.  So 'struct some_other_type' won't happen out of
> nowhere.

Makes sense

--DYZSdPU9XbIG0Ccc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZip90gAKCRBZ5LhpZcTz
ZFuWAP4//sHzQ1giAukrrtw/mmq8vSHsZ9SmEGuvNIVZN1uV7wD/RAsH9arw6YUt
1MyN7TztbNOkXzDIm8LpAZ4tRaGVQwo=
=tWjk
-----END PGP SIGNATURE-----

--DYZSdPU9XbIG0Ccc--

