Return-Path: <bpf+bounces-71976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A321C04110
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 03:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EF9A4E68D5
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 01:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26C01E98EF;
	Fri, 24 Oct 2025 01:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7K31CFr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EBF1DF755
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 01:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761271186; cv=none; b=fQOh6pQ5ke06q0t3t16bDgvhqvzND6NZbaPY3GdQIqHpDchS4KFJSWFH7LbjZ72AQ4SEBAfihnWZ3ZHIaofwL2N6ihHZuR9QkbW75p4QGFz3CuB5TnFZ+ZR+KVLJRMjx99Frd6WpOihKYoZqoba11yB7BZiJfIVDvZ5KxfxOuGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761271186; c=relaxed/simple;
	bh=aeWewlhGQ0C6l2wHmmqYhcrMOrNsxoaaBwSfmH+Hy5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LncqwD8jYKNkfOaI1psUV24jy5aMPW9HNsdVltx8Z0rCwppRo2YKdslQ0Ps+TjNW9UFzoWk3ZB23PNYN/glsGHnFghj5b/r3QKv2lsl8qI1d4kVsML/7BeWg5jnWRNIUeTGUfScfXopAepYWEFv+Qa/R2M7kOcD+BOqlfXUYjkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7K31CFr; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63bad3cd668so2839238a12.3
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 18:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761271183; x=1761875983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rB4FXl5hyvE6TowvU8+Yj1ALYmBSYmfZvdeiCwkdjI=;
        b=F7K31CFrev1YOLGkw/BYW+QnT9lGr9+gokUGwxWe5m3kCpSCwBMRAjFIcp3yyfH+3R
         aYQcc/0B0nR26FiEPbCJVr4f+FFUMmezJInHKUTFLZT+tYPYdclm/qRSEfz8Pz01WZ6+
         xTJT/iz1rrCq9JdS+E0epJyh1k0vCbkyqb42js5yC62pJSDZ4zzVXfuVySYDpBDaGMFg
         mU6wdiKm1B1yVB+8N7Bw2kWSNeSLZp88OPJ8YkbihsViMIYk7WRwlSq2FRQ5JIg6NRQ5
         EhJn1Nb1c13VFOTwW0uBjoYk6qSEl9DSiF8IqAXqyK09Sqk0JIAtsfbOikRq1BzysJKp
         slcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761271183; x=1761875983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rB4FXl5hyvE6TowvU8+Yj1ALYmBSYmfZvdeiCwkdjI=;
        b=PWPa7f6MWrXAtOLHAGAF7iBlf0RbsHwHeDCsV7daLtC6fJmsr3CbCqLyOZuJF3N7i5
         fUrO8rLhwXe6mqhV8rbcWhEboI2gI1KSJ1ykJYm4eToHtSjUopY2PqJ5YEO+gs2kKCB6
         IBQ9jI1b83es6HndoygRlqFv9J9au40lmj9UIAzxGlsiELWFF7bhYORG97X332A76R46
         z4YbAsSzjZsOtGn9iyUogBur6w8yu7JjwIJqW5d7JjsssEgTTHiT0pK1kJYzufHO8NFU
         z/puplpGxpQexKQEkJLW+oHl/7rOvGZHOKwZo+NfrWxd7fD++6tJ98100mJDF9EX3nuD
         2MBw==
X-Forwarded-Encrypted: i=1; AJvYcCUBIY/yCIicPA+2BEdyT+wfBjrP36JZ5GLrieP8AvZzmwqC22OaKYqkfm1xijxdmmKNf5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqjzKqloVA46oBlFnDDOYyUmC8PZ4yRX6yj25H4PFVWXINbZ4x
	F96q328GGUXhSUJUyLhPgL4KeYXhN7zlVjMhyd8PEzq2TPm8Wd51pugV6jX55fO6hjGV4fNBnDU
	Xohnby3LCEjOPxnH593bYBLuJLRDalS4=
X-Gm-Gg: ASbGncuNkiCFg7i1oABWqLizmzK55usLzDVwS1wSQ8Nlid08GQgB/gQTiAzX1nZ1IzM
	pfzfXvKqTZWsUM9X4mY1X7BiM3T8/pgsrcjHjLAxjnoOC2p19OWk9sfDoP+Zww42Zi/cmjyWJII
	ZRTIGZbxG+9S1tp6le14ZZwuRd/ncT6ZVtuAFqWYzApHfYJ4E4n6qAyVcEYHFK/AGh19yf8ta37
	7MIaEaQiTWGxQHgst2Q4MHp4WnuhhxCOZmbATMTX1pD7pIqhm7X8yhsES18Z9vu2vR84YAt
X-Google-Smtp-Source: AGHT+IFAdu5tYoXGsiciHSKWPq7w8AF+ekApybceaHvXUAVQHFQ/qsK4oBOnm6T+K20KSc4r3DBCR+JBRtu4RApd2/o=
X-Received: by 2002:a05:6402:524c:b0:639:ff5f:bdfb with SMTP id
 4fb4d7f45d1cf-63c1f6b0b58mr27634437a12.19.1761271182583; Thu, 23 Oct 2025
 18:59:42 -0700 (PDT)
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
 <CAADnVQJG_tK18oxmjW37cbrxF2zPKPk_dvqXUTnOjUue7J0tLQ@mail.gmail.com> <CAEf4BzYLyi6=Fyz9ziOAwkFOjUPyJmTj4c6g247XBwgwJ8m-qw@mail.gmail.com>
In-Reply-To: <CAEf4BzYLyi6=Fyz9ziOAwkFOjUPyJmTj4c6g247XBwgwJ8m-qw@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 24 Oct 2025 09:59:29 +0800
X-Gm-Features: AWmQ_bl5c-H7_mPtbkQyyIYah1HW3fReM7rZN1BaHNNaBN4HCCBC6bsrF_EF6EI
Message-ID: <CAErzpmtMPuGBhisLOaZMyzM5u3=0QrmZcuWqNgbMrceEEPN3TA@mail.gmail.com>
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

On Fri, Oct 24, 2025 at 3:40=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Oct 23, 2025 at 11:37=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Oct 23, 2025 at 9:28=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > >
> > > Speaking of flags, though. I think adding BTF_F_SORTED flag to
> > > btf_header->flags seems useful, as that would allow libbpf (and user
> > > space apps working with BTF in general) to use more optimal
> > > find_by_name implementation. The only gotcha is that old kernels
> > > enforce this btf_header->flags to be zero, so pahole would need to
> > > know not to emit this when building BTF for old kernels (or, rather,
> > > we'll just teach pahole_flags in kernel build scripts to add this
> > > going forward). This is not very important for kernel, because kernel
> > > has to validate all this anyways, but would allow saving time for use=
r
> > > space.
> >
> > Thinking more about it... I don't think it's worth it.
> > It's an operational headache. I'd rather have newer pahole sort it
> > without on/off flags and detection, so that people can upgrade
> > pahole and build older kernels.
> > Also BTF_F_SORTED doesn't spell out the way it's sorted.
> > Things may change and we will need a new flag and so on.
> > I think it's easier to check in the kernel and libbpf whether
> > BTF is sorted the way they want it.
> > The check is simple, fast and done once. Then both (kernel and libbpf) =
can
> > set an internal flag and use different functions to search
> > within a given BTF.
>
> I guess that's fine. libbpf can do this check lazily on the first
> btf__find_by_name() to avoid unnecessary overhead. Agreed.

Thank you for all the feedback. Based on the suggestions above, the sorting
implementation will be redesigned in the next version as follows:

1. The sorting operation will be fully handled by pahole, with no dependenc=
y on
libbpf. This means users can benefit from sorting simply by upgrading their
pahole version.

2. The kernel and libbpf will only be responsible for:
    2.1. Checking whether the BTF data is sorted
    2.2. Implementing binary search for sorted BTF

Regarding the sorting check overhead: if the runtime cost is sufficiently s=
mall,
it can be performed during BTF parsing. Based on my local testing with vmli=
nux
 BTF (containing 143,484 btf_types), this check takes at most 1.5 milliseco=
nds
during boot. Is this 1.5ms overhead acceptable?

Are there any other suggestions?

