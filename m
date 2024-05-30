Return-Path: <bpf+bounces-30957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3EB8D5273
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 21:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB761C225BC
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 19:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FDF158878;
	Thu, 30 May 2024 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tj3g2rNs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370E312E6D
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717098160; cv=none; b=giyweDwmZjYo00l8F5sagsoqBiNMjyWb6vNfHkmfMblO9wy3kbAF81T+fEUtEq236/yuYwtr7vWw0lsM85OmyphY8AYMTgKizi5cozrPKrHTDmvznP15d/hcYDjGK439kcmZS4emv2BX4yB0+nqgUEf6+nz2FUK6f+sX2mC2OTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717098160; c=relaxed/simple;
	bh=XKvtfNGw2UA9uV27wtb/XFtxnWeAJGDdIjuB9BFuYT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJPjsr4ZnWodE1iEXci1gPxAJhNt3eSR2J5i3RNrF4zg1qPz2Kz4kxftoEOlmOQ7IyqH6IWU2CEONKr1SW5s8HBzcRYy9EsAFQ9Dlix38MRBnezXjnB3jya6h/gD9VBuJZzTCGan3GPB/iDD8oMc+HdcqV1wbm1Ya/E+6cSMsBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tj3g2rNs; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5785f7347cdso1261572a12.0
        for <bpf@vger.kernel.org>; Thu, 30 May 2024 12:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717098157; x=1717702957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pawGJZKwA7w4hA03rmBsSJE4UfIb8L42LOJ9HIJ1n6E=;
        b=Tj3g2rNspxdrfCU0Getx1/5jh0KsDyA+QbOTeKds6fRt2idUrd8iAk3Xan/kP4v0pY
         lNFQNYf/lscSBlx1aEiTU3A3mYJZkc6j65bNP55NMCyg4JEUPCsaoMFs53Ax1eodGfm9
         AvpciTfLZpM3xDufnBNZpOUbTM1ZgmUxISWW1mE4g6YEODT78dt6sogiMBgLxMiK5dKx
         tFuZfeG5DFGEdkyrVjDMOZ7MSDZdRznt3Bh7xTkz2MrSHs0rcM4aoD0Zdev5Q0BXMNxs
         ITJCezXHKtXTsKcaDys2S6W9W/mruLjbG0gjGYdqIFQI1jPIcpR1Oq/Cm0gY+bXx9/hn
         uVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717098157; x=1717702957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pawGJZKwA7w4hA03rmBsSJE4UfIb8L42LOJ9HIJ1n6E=;
        b=kLxKKNKqRrjuXJdnwD3MkIpaDMrnNe4LjDY73JVeFnq7ZjzXfOfYzEvUumR29Lnli3
         /zV2fEf+NZmZE7XL4Rt7tsZ2nq8H7XbBW2kghFqVRzpFzABQgY0z2qZtfJ60uX1dPopq
         Z0FIvymlR84DP0YnZPGgRzFFyyi3O/tjEtW4z1/K8bUQ7+hgTaOaw7IbzuDPTBMICDQX
         Qb8nvV4h3hUu9DTk3nu9YQh+DNgv2HiwWiZCMcnQobr+uPHRCMVnM6yxiqyCjYpKnPCg
         NhD2/CEqByg4BHsT67CD4smEAmXux8YKOzEkbfWaC8JdJzuuM3Rct6v5EdpiyR3MMFdv
         up/g==
X-Forwarded-Encrypted: i=1; AJvYcCVxdSuwA0bVnTwHCJ53sXUyWXzkf0ApqioMgkeerhtxynJqMT7Rzzg46D5DDb+y930F1fSStMc6N1Kh8DEluCmCp+No
X-Gm-Message-State: AOJu0YwTbsaQeKl/MFfHGuJepypzycCtlJGb5wDo+q/HkJ/WOL2Axv+z
	IZj0wZ9zCD1ER0aAa6Cb8ZzYn0UMpCgIF/C1WxsO5hTZKC+SUn12jkEwZVAk356eFxaDMJDBCbK
	UQHTAiQRn6waaPdx/+zpTsCx8qKlEctNgFME=
X-Google-Smtp-Source: AGHT+IHOsZPraVPxx8JY0Qje8sv40bOMmH4Um9TJLxzI8/Kbd+TeWKQkOqgJEG4vQlRS3taoIgAXLCm+a0Qug2xIK2c=
X-Received: by 2002:a50:d55b:0:b0:579:d01a:938b with SMTP id
 4fb4d7f45d1cf-57a17989942mr2093919a12.35.1717098157305; Thu, 30 May 2024
 12:42:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524223036.318800-1-thinker.li@gmail.com> <20240524223036.318800-7-thinker.li@gmail.com>
 <f0b0e283-9312-4f11-9636-2ea690262180@linux.dev> <CAHE2DV0RBf9JbkmngsdKdER5F2KmUXwY_JH44Z09DsY0VNa37A@mail.gmail.com>
 <8818eaa4-b32c-41a6-82c9-6230d635e89f@linux.dev> <CAHE2DV2r=RYYp=G5BBSB7Cinab25J+JxcFWXwb_GbZcpxgwVGg@mail.gmail.com>
In-Reply-To: <CAHE2DV2r=RYYp=G5BBSB7Cinab25J+JxcFWXwb_GbZcpxgwVGg@mail.gmail.com>
From: Kuifeng Lee <sinquersw@gmail.com>
Date: Thu, 30 May 2024 12:42:26 -0700
Message-ID: <CAHE2DV1CnFdMobG0q5bSJyfide1LcDjfQUXLVd5Ooq55Ncpb+A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 6/8] selftests/bpf: detach a struct_ops link
 from the subsystem managing it.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	song@kernel.org, kernel-team@meta.com, andrii@kernel.org, 
	Kui-Feng Lee <kuifeng@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 12:34=E2=80=AFPM Kuifeng Lee <sinquersw@gmail.com> =
wrote:
>
> On Thu, May 30, 2024 at 10:53=E2=80=AFAM Martin KaFai Lau <martin.lau@lin=
ux.dev> wrote:
> >
> > [ The mailing list got dropped in your reply, so CC back the list ]
> >
> > On 5/29/24 11:05 PM, Kuifeng Lee wrote:
> > > On Wed, May 29, 2024 at 2:51=E2=80=AFPM Martin KaFai Lau <martin.lau@=
linux.dev> wrote:
> > >>
> > >> On 5/24/24 3:30 PM, Kui-Feng Lee wrote:
> > >>> @@ -832,11 +865,20 @@ static int bpf_dummy_reg(void *kdata, struct =
bpf_link *link)
> > >>>        if (ops->test_2)
> > >>>                ops->test_2(4, ops->data);
> > >>>
> > >>> +     spin_lock(&detach_lock);
> > >>> +     if (!link_to_detach)
> > >>> +             link_to_detach =3D link;
> > >>
> > >> bpf_testmod_ops is used in a few different tests now. Can you check =
if
> > >> "./test_progs -j <num_of_parallel_workers>" will work considering li=
nk_to_detach
> > >> here is the very first registered link.
> > >
> > > Yes, it works.  Since the test in test_struct_ops_modules.c is serial=
,
> > > no other test will
> > > be run simultaneously. And its subtests are run one after another.
> >
> > just did a quick search on "bpf_map__attach_struct_ops", how about the =
other
> > tests like struct_ops_autocreate.c and test_struct_ops_multi_pages.c ?
>
> Got it!
> I will put all these test to serial. WDYT?

By the way, even without putting all these tests to serial, it still works.
The serial ones will be performed without other tests running at
the background. This test is the only test replying to the notification fea=
ture
so far.

>
> >
> >
> > >
> > >>
> > >>> +     spin_unlock(&detach_lock);
> > >>> +
> > >>>        return 0;
> > >>>    }
> > >>
> >

