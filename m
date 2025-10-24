Return-Path: <bpf+bounces-71979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABE2C041BD
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 04:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6DE33B3C78
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 02:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E19224B05;
	Fri, 24 Oct 2025 02:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgwS8e1W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FA51D63EF
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 02:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761272635; cv=none; b=CBEv6wq5SKEvIckqUV8MfqWoz6kiiBpuij8OgnLjNuctA+epo+TfYDNkaf2+Q7TbepD9wr+gq//nKfCacO03pcC/t1sByMR5ijOXqbOLfnS2cxPZPGFeBnbl9MyILcJ0UOwzBbGUYvqW/LQTNaDF/UTxXJYiBMh6r+5qKyo05xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761272635; c=relaxed/simple;
	bh=MvBRELTpZJB9EN/yRUyxPpKkvejcpGN9o4m6U2z3ehM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1fN85Vy7RtUPHJWTV48zwywC5/ytGRHgUiTJMkuAqR+mmGURvoTue8fl45MCdU2/SjtkDiHSmQ9IzD3cuohXRLHWA4cxY0sdkKFrVrXXIC9nN8e4Oitss3uQfxKH+NGReRn+hedEkcd+rS6f7MQvSGVVNGTCXJyv5Q6XcJ2kWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgwS8e1W; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-637e9f9f9fbso2705411a12.0
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 19:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761272632; x=1761877432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZh+zi6hTv4cYK1c608em3piLhhdyqVRCT70vhOdcnE=;
        b=OgwS8e1WRRLh7fVDL8MH4gMn7wIohovmF2qCo39uRxIzr+mtoClvh53GbzgEThSxrD
         7FoQit1wH4WVcEB7VIKvO2ErHJY3vM7AIGwgJUSkMiMsUaQIEqjg3qXYN3f3AqTBC5Sr
         jV6cvkVi+/DsJdQTSCKAMsiSE5yxqhX8DDh+YmaqSvmfjWpowwteJtCuribdLYyG9/wy
         Q6FLn+g0MrqMzptedFCn7fsLU4OPtMcX6wLFjyRNI8I9wW1loBXtoJckk1vPS0LbomFO
         enqf2pm9+OgbfKL6SP/SBdhVyOQXClKe5qYBs+z+uqAh0pr1K47TJfaGOGX0fuHVwKTu
         Mhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761272632; x=1761877432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZh+zi6hTv4cYK1c608em3piLhhdyqVRCT70vhOdcnE=;
        b=aeb55dNDothJKkTCLmeMI/6zM2T2QhzwtKKWOxPG/ZRg40wZ4BJ7TtXGXWd5pgsd3m
         6tB28+htoxvY3PY7rQM7TndoBSMlrpRq0lq6XfUgUP2BtEgSZturySvvc7CxXeQdDMJd
         B0HfbiAHAIeTv4ay0+KSOczaATd0CZJfSBjp227jAOdvirHTsW1OqcDF/C6EF6AtYZS0
         uoa1cGP6HqqfLxO/m9S/GNilhkTbo39iXfDsSZPnlAerJQ0ObIEqnQKqwsdWN8XaalII
         OOl4+Af9Mxp3I73AXNxtelIlmCkPh0QDKBA+U3yhnrDGwPtxb8qbuqP93Fq2AMb5Gw99
         32kg==
X-Forwarded-Encrypted: i=1; AJvYcCVwUXtAI0jI+5VRoHt0nlHeStEciyqpzBB06Mi8U72YJL575eyvG46mvOpFssk30gBRCfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt3Galysi/BgR9stZRdZJ5O/cl7QjGcELcZ1Wjw5NdnHEzd+dM
	7VjKfokXIozl1AMOgTy/XkbPuQLfpYhQGRr3NZ9d8kZJdTALYDADR3QGUWtGGBkDpAO/IcN4LHw
	pBhvzpTxZCi5dTU+jBx51sv5n35sok9s=
X-Gm-Gg: ASbGncuXQ0X9PE08Iz+ju9qw7zglVcSTfgtBc/dnCR0PPHiKUK7Fv9CKa2YhQwnTKbY
	xl/8p5VUeA97D+Wv5yWLlsrGa4nWXonJDTTSl/c6D8e0ic0/r5N4dnUYyX++d2P+risYFlub12p
	EQVZ9J3bNU89EA6hVgwJkDTleu7uTdQSWZV8Z9GFC3uSQaxQ/C/4D6wjfebah383+LuZqUUExf/
	KuTraDWx9eCScayNl2E8pZcdTqfZ7Q+MNjZjiPmihxhf+H6k1MvuHkjfz+879UujMhnH5YP
X-Google-Smtp-Source: AGHT+IEdg6XV0zpN5Veb7eFadURiN/MtmxSvYmJqvEmAdfmSFomoXWicHPRhzY9ko70FAmX9zwFmvz1tkSn06Pr5g7k=
X-Received: by 2002:a05:6402:847:b0:63c:18e:1dee with SMTP id
 4fb4d7f45d1cf-63e3e4791a6mr4296529a12.24.1761272631640; Thu, 23 Oct 2025
 19:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
 <20251020093941.548058-3-dolinux.peng@gmail.com> <174642a334760af39a5e7bacdd8b977b392a82c7.camel@gmail.com>
 <CAErzpmusSgOaROhEO25fKenvxQJU1oSPKKzUA4h67ptdQxWM7A@mail.gmail.com>
 <7651ac9cc74e135f04ecfee8660bea0a0d3883ab.camel@gmail.com>
 <CAErzpmtWLLYuFk3npTiOgGOKcEcH1QUGGEHLvPncVT+z261C1A@mail.gmail.com>
 <CAADnVQKU0MnQHxxvnp9WCu_UO4fEtd_D6ckNmOd7pLg90ecF4A@mail.gmail.com>
 <CAEf4Bzajdv3Rd1xAxm_UZWBxPc8M0=VuUkfjJvOFSObOs19GbQ@mail.gmail.com>
 <CAADnVQJG_tK18oxmjW37cbrxF2zPKPk_dvqXUTnOjUue7J0tLQ@mail.gmail.com>
 <CAEf4BzYLyi6=Fyz9ziOAwkFOjUPyJmTj4c6g247XBwgwJ8m-qw@mail.gmail.com> <CAErzpmtMPuGBhisLOaZMyzM5u3=0QrmZcuWqNgbMrceEEPN3TA@mail.gmail.com>
In-Reply-To: <CAErzpmtMPuGBhisLOaZMyzM5u3=0QrmZcuWqNgbMrceEEPN3TA@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 24 Oct 2025 10:23:39 +0800
X-Gm-Features: AWmQ_bkC4xdw2yGYslKqH7ZVLYpLTye2qQswRzzeoZn5CysMf6rFPXCEvTpy8SY
Message-ID: <CAErzpmsCJAWVjWnV2LWAnYCouynYZbUupS08LUuhixiT2do3sg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/5] btf: sort BTF types by kind and name to enable
 binary search
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <ast@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 9:59=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> On Fri, Oct 24, 2025 at 3:40=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Oct 23, 2025 at 11:37=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Oct 23, 2025 at 9:28=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > >
> > > > Speaking of flags, though. I think adding BTF_F_SORTED flag to
> > > > btf_header->flags seems useful, as that would allow libbpf (and use=
r
> > > > space apps working with BTF in general) to use more optimal
> > > > find_by_name implementation. The only gotcha is that old kernels
> > > > enforce this btf_header->flags to be zero, so pahole would need to
> > > > know not to emit this when building BTF for old kernels (or, rather=
,
> > > > we'll just teach pahole_flags in kernel build scripts to add this
> > > > going forward). This is not very important for kernel, because kern=
el
> > > > has to validate all this anyways, but would allow saving time for u=
ser
> > > > space.
> > >
> > > Thinking more about it... I don't think it's worth it.
> > > It's an operational headache. I'd rather have newer pahole sort it
> > > without on/off flags and detection, so that people can upgrade
> > > pahole and build older kernels.
> > > Also BTF_F_SORTED doesn't spell out the way it's sorted.
> > > Things may change and we will need a new flag and so on.
> > > I think it's easier to check in the kernel and libbpf whether
> > > BTF is sorted the way they want it.
> > > The check is simple, fast and done once. Then both (kernel and libbpf=
) can
> > > set an internal flag and use different functions to search
> > > within a given BTF.
> >
> > I guess that's fine. libbpf can do this check lazily on the first
> > btf__find_by_name() to avoid unnecessary overhead. Agreed.
>
> Thank you for all the feedback. Based on the suggestions above, the sorti=
ng
> implementation will be redesigned in the next version as follows:
>
> 1. The sorting operation will be fully handled by pahole, with no depende=
ncy on
> libbpf. This means users can benefit from sorting simply by upgrading the=
ir
> pahole version.

I suggest that libbpf provides a sorting function, such as the
btf__permute suggested
by Andrii, for pahole to call. This approach allows pahole to leverage
libbpf's existing
helper functions and avoids code duplication.

>
> 2. The kernel and libbpf will only be responsible for:
>     2.1. Checking whether the BTF data is sorted
>     2.2. Implementing binary search for sorted BTF
>
> Regarding the sorting check overhead: if the runtime cost is sufficiently=
 small,
> it can be performed during BTF parsing. Based on my local testing with vm=
linux
>  BTF (containing 143,484 btf_types), this check takes at most 1.5 millise=
conds
> during boot. Is this 1.5ms overhead acceptable?
>
> Are there any other suggestions?

