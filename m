Return-Path: <bpf+bounces-65082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E47BBB1B911
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 19:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF13623EE7
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 17:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE5F293C67;
	Tue,  5 Aug 2025 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buCjQPph"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F4D292B36;
	Tue,  5 Aug 2025 17:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754414068; cv=none; b=ChkffV5944aysZgcN1okqGsV+nktBxyTTKmxHbP1mUrHqBPIpApMiDVdwLFmrmsNB4j3EhRS0vJwrqQx04itlZMjeU4Ji2dpbWPmeUHggl1Bv4WDHKgKAHmPVNuvAGPMgOgrmO1b/+WT0KjU5to84UmhXegbEVASs6R3DZp7cHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754414068; c=relaxed/simple;
	bh=6lbYw/Td/NTUPgIOaVNkmO7VINv3ZdqXK0a+RuwbjxU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Istc4ttuE47mzvfCXLioYQXPwkIHgkHNA3LZsA52Rb7hKjsRdr75/PjmZ1GPvz6ON2iIfbQATl9MHzgx26r+ZOK/j8peXDsLTYS4Jjx7dhKwa/imH1VHviUPJAPpuGBiOQ+HEYYrYkHl5HG9r286/hSzYEZSjBerVbnIikha/bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buCjQPph; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31effad130bso3668071a91.3;
        Tue, 05 Aug 2025 10:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754414066; x=1755018866; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z5OOTXzGWVVgmVRg0X1KfTB1dkMRMeD/PW1OHO9QcZE=;
        b=buCjQPphA11cw06j2PTN3dB4UoVSQWIIOElUcnsgLkEI+RIajm887p2kkzkRbPSqLs
         mlugGFML7oDl7HS9AmXrbQ+/EN4aHsNyVQefuZ6rEIhvWHXhotmSIihLJkZF24xFGMlq
         4PBf0/SN/u8UE4eWTiO6a9E4kTH1cE7saN/ltbcLjvO1Y8jnvmpoy72Rhr/ihB8G0GPq
         emGtQJO6FJw2AmMpXvU9R0I9cmi9+7WeuUDPKraUvFaKcB5BfmgbrpvIPKnXhr3oaOlb
         lP1fgg+/u2aKlKbV42Y4IrNU7ew2htvBAH4i4WUX2cN/LDkwVFVPbvZC2hB+cDQ4Hhpo
         kKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754414066; x=1755018866;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z5OOTXzGWVVgmVRg0X1KfTB1dkMRMeD/PW1OHO9QcZE=;
        b=Z7Xd03uU4vjaQfdUDlSY1iC5SyJsirt3wnjuQNHdgAcoZ1ron71c04d/m9kUbHFaOA
         R0MTD5cjPZaf1Yq6xAf7phIr1tMTr2X/tPFu/RjvrrMkbGJ0txYVElQlkQzoy33rAdXw
         ML2kqX+JxVz2KqZjqTI8g6i7PFXenAR5eUWRrFIXhAyAVJbVFtNHChc6cd2Vn6lH9YhH
         uAo2R915Q5OwIO1Yp6Js6EmkOrYvW+4SuYv6EA3jcBMyYFR3Da3Yux7ZZyFwFu1f9+2j
         3xqssXSUbVyH8maTWcbz486njxAY6wQf16hOR1ueB5DXnFmTLqYQ7fgalxO9HmZ7XVjQ
         Y4Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUE72zlH2HGUkotJqcdiPNGIYjobPmNj6NxIQ8qCH56VxnIui2EueIxMzQG7uhcM5tzl6q8zuM62GPmSZ4bwNFVMw==@vger.kernel.org, AJvYcCUnq+G0bC/8YY/eZMv0Z+mSwhOv0U8uhqerwBYGXH9sKLybk6v2gY/qufNulACqvC5OeLO/bvxOe7EIfQ==@vger.kernel.org, AJvYcCWwn1pUPiADufwKji5qkuaLPWeX3agPHdymzTVmBixq4Y5//G8HtpNr80Zl17PNdCgW8xc=@vger.kernel.org, AJvYcCXmFW72r7DAESUCVOtosFsQYzv/iN4GnzePO3s778hbSDe5nufqTsA1AIvCo5vK4UpTykesvHzX3zEz5J51@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3OJVmpWHQo2PmXgi4T/2K9W6Wk2agxxAuEUSCdmJM9XplcNxs
	VysRuJB4d/s+MkU4N4wYV1vjUHaw3N5Q8tYceEeY4Q/PYDf1mc/nOR1/EbMOCft3
X-Gm-Gg: ASbGncsOut6KLYqepuAZln6oPYDFLWbFqEla7zCMc4czko2nDEAtMC4BMv7pnbx/0V1
	/E4p4sgWo5qm6XByxkxd4ivi7U/+TJd870atCcogFy+le6NkSUr4EpGsRNHUm+mCaQ5pY2Y0ja9
	OUh1ojXPBiYaevsaq/6t1JN9F2lwaBCUjysozHwnHZqPJzbeDovoDoQN/wJ2hs82DpktrMVC8eq
	V8Is4xZkZC3UNsjmvDLwAmpifRnhWEFA4lwXchGyftmV8RbVLKHn9qWPbWiAY1/k1cEnYoTnSaU
	LsTEY9dv/WdHSVj5tgVERV+Z1QOSaF2+5tkDhdGpxp9/gNCG9gI9x7pYO4oFMekz2OgdiLKQn27
	uIv5u10mEVp4r7JW524AAZhtVpQ==
X-Google-Smtp-Source: AGHT+IFo45A+ox/+HcyhDozQVdTe0ElxogJQCoID3RNAqDuP/D63LOZ2vEtEwf7P4gdQW62O97NqaQ==
X-Received: by 2002:a17:90b:58c4:b0:31e:cb1a:3dc5 with SMTP id 98e67ed59e1d1-3211620acdfmr21293942a91.11.1754414066250;
        Tue, 05 Aug 2025 10:14:26 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::6? ([2620:10d:c090:600::1:255e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da5719sm17523330a91.6.2025.08.05.10.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 10:14:25 -0700 (PDT)
Message-ID: <d71dc18f397becb9e7120a0f3253828d045e1ae0.camel@gmail.com>
Subject: Re: [PATCH v3 1/2] libbpf: Add the ability to suppress perf event
 enablement
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Ilya Leoshkevich
	 <iii@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Ian Rogers
 <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,  bpf
 <bpf@vger.kernel.org>, "linux-perf-use."
 <linux-perf-users@vger.kernel.org>, LKML	 <linux-kernel@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,  Thomas Richter
 <tmricht@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>, Heiko Carstens
 <hca@linux.ibm.com>,  Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>
Date: Tue, 05 Aug 2025 10:14:23 -0700
In-Reply-To: <CAADnVQ+6WuHrrAg1bQ+-6p1zZAWQVC_EGtt9ocv5aZE9=CxB5g@mail.gmail.com>
References: <20250805130346.1225535-1-iii@linux.ibm.com>
	 <20250805130346.1225535-2-iii@linux.ibm.com>
	 <CAADnVQ+6WuHrrAg1bQ+-6p1zZAWQVC_EGtt9ocv5aZE9=CxB5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-05 at 09:45 -0700, Alexei Starovoitov wrote:
> On Tue, Aug 5, 2025 at 6:04=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
> >=20
> > Automatically enabling a perf event after attaching a BPF prog to it is
> > not always desirable.
> >=20
> > Add a new no_ioctl_enable field to struct bpf_perf_event_opts. While
> > introducing ioctl_enable instead would be nicer in that it would avoid
> > a double negation in the implementation, it would make
> > DECLARE_LIBBPF_OPTS() less efficient.
> >=20
> > Suggested-by: Jiri Olsa <jolsa@kernel.org>
> > Co-developed-by: Thomas Richter <tmricht@linux.ibm.com>
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -499,9 +499,11 @@ struct bpf_perf_event_opts {
> >         __u64 bpf_cookie;
> >         /* don't use BPF link when attach BPF program */
> >         bool force_ioctl_attach;
> > +       /* don't automatically enable the event */
> > +       bool no_ioctl_enable;
>=20
> The patch logic looks fine, but I feel the knob name is too
> implementation oriented.
> imo "dont_auto_enable" is more descriptive and easier
> to reason about.
>=20
> Let's wait for Eduard/Andrii reviews. This patch has to go
> via bpf trees first while the latter via perf.

Agree with Alexei,
something like "dont_enable" should be simpler to read.

