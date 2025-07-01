Return-Path: <bpf+bounces-62014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1503AF0570
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 23:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68A916B52A
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 21:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE1627E052;
	Tue,  1 Jul 2025 21:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bh1BfRNJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846813D69
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 21:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751404045; cv=none; b=u5QSZdYlrzkJRAeJ61AluJAtIvwfQYV9yndpkUAVAw5Rag49jbTYIsZlwqio9lGI5/v0UWnhkk7xSitQBvMpGMP0C2aeIx73SkDCTobGTs9Z2SopbhDsuwRUYox2WWjePEZ2/82oC9MFWtzAyq39xYKIsht0fPEKLxeTgiPHkC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751404045; c=relaxed/simple;
	bh=uVjK5VCFRfxr24BUBuPDizy10zR+oYhY7GpZxM/o87k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZzXJV2Rr4JDKrJiEYGgnZxYkS7GhEF99+BseSwOnY5FeoCyJ3oVBkbLPChYb3KPHm/Wm2I05x0LhtNOh9xM86Ey94H7NxYZ4lYWhlubat5mDu9w+te6ptsfcmHKniwr3yfUjfMDTfBfr4AZB7wdjKlvOO7uDWTsQTQ/i7NZYCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bh1BfRNJ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748da522e79so2415040b3a.1
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 14:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751404043; x=1752008843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVjK5VCFRfxr24BUBuPDizy10zR+oYhY7GpZxM/o87k=;
        b=bh1BfRNJQ4HlJZ3nEAx/ZuFnpHTp/m3d4Q+jivAkOMSizolnI0dllKhWrohTaniNNN
         FZNXDSvuDvX274oSyMc47XCf8LLXf1yZSpxoiozhrD/MhPOJLMlgRFKqEYTmOhdndbRX
         boYuTF6ja99WprqJiElekGGH4+PM5eX42twtD88vfBqkhM6iet4NJ+Jt4HOLy0xZVwEj
         IPJqVCFi4Cfym2EzmorFng+yTZEz9p2PdMbQMEk1y6TJX1C4w7jpTDCwSpXtFJEQPbSp
         sWM9azl7pxUTXhIfiJiwtb+XQvQQ+K8vmFWLm34SCicJGs5KYGLLxmgZuVvyLLbwWexf
         wrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751404043; x=1752008843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVjK5VCFRfxr24BUBuPDizy10zR+oYhY7GpZxM/o87k=;
        b=SnA6WFeQwz/4KlJvMpmrwSJ6qdSppVKzcE41ASuEYey7h/kP2bDfUnfkIv5Eqa3cLG
         srygrLTtW/AsWnpIYRiXGa1hQllPyvx0pq/+OkgUgLtaeoAxfCoMZ5kUl4yJbBpXn7oz
         +4GngWOVbtskkEMvvVQdJ6sWNGOyo8BzZuoOgwnaRWgUyePk+RqJHpxOpZONl3pVd6g+
         LU2BEtNV3wDcNM0XNoioiMait8qVQ/AonxnLT3veep42Rj8C4vgjKWqJ3Y4DWVMSeDWz
         S/k+lR2EhQ0KyHhUCU2kYgJ0dUe0wXDDFnryLK2+zBF/EU+tzjA0lDDzN6ZqAOsp+qlF
         EGTg==
X-Forwarded-Encrypted: i=1; AJvYcCXOWseKifey4m9h5h3W+pVt66SrQI19qPgsqXbfLw5CIixzaffgHQMOsRIsv5xFn96SuyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD81ufSXddj5s6jbhj0d5ylssIyQFHXtReOEhBF0WS3361szpa
	kb79s2QCjeXf8QB9TtW6R853iKd55lbk8YpZ+ZSGEZ1D2wCBUCXyPvD7qKSFnJjwvQwsb37AEsk
	WSbaENVauksk81dleI5Kj/kzaEsVDJUI=
X-Gm-Gg: ASbGncu0gZig4Optrt0X2BD1Aujz1ZWDp9CNGsAWsMvQNNFURvzubN7GRiem823Lcq4
	mmRTnvQ46mES6j3wCOeMeuS2ueFAmuIG3bXnEsvjgyfuKfzhULlJYTAHWyQzGDi355fvBXTjyiD
	Bd1pJcQZ1qp3f6/cYRnxnbnMWxopjuZ1WNaf8kI5i+WN3qK15kGt3gZ+srnmD1HmpmSKjjUg==
X-Google-Smtp-Source: AGHT+IFMjGWnD/G/1TX7tGR5knSU5rMIs1bHzK+4BQ3v7mLy81CYTE2x11A2Fr6Jh9pTu780P0s/M1jw3Vac4mTZNBo=
X-Received: by 2002:a05:6a00:22ca:b0:748:ff4d:b585 with SMTP id
 d2e1a72fcca58-74b50f683a8mr413831b3a.19.1751404042609; Tue, 01 Jul 2025
 14:07:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630133524.364236-1-vmalik@redhat.com> <CAADnVQJF8-8zHV75Cf7v8XWGVrJwU5JaQjBm0B-Q3JUUMqNmcQ@mail.gmail.com>
 <49fcc6c3-8075-4134-bdbd-fbd8a40f4202@redhat.com> <CAADnVQKQTLDP1W1ao-mCPfLDbZWykW1TdcouJPSVapNWu=bCBw@mail.gmail.com>
 <CAEf4BzaM9_RbUfi2Gk-=_2D3OC8GiDS-vT5-9CHOd07r=+wyeg@mail.gmail.com> <36400b83-1a6f-4da0-9561-073bd268c58e@redhat.com>
In-Reply-To: <36400b83-1a6f-4da0-9561-073bd268c58e@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Jul 2025 14:07:07 -0700
X-Gm-Features: Ac12FXzvn8QE5v3FEUuoNJ-rYs2E068ZlcYUITxQJekp0ygSCf1cc9CHTZPhmVk
Message-ID: <CAEf4BzZZ2f1cP8zDDsqME5wcOYUECh6UKwxtTWbDfSjmdJD60Q@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Re-add kfunc declarations to qdisc tests
To: Viktor Malik <vmalik@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Feng Yang <yangfeng@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 1:54=E2=80=AFPM Viktor Malik <vmalik@redhat.com> wro=
te:
>
> On 7/1/25 22:28, Andrii Nakryiko wrote:
> > On Tue, Jul 1, 2025 at 12:50=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> On Tue, Jul 1, 2025 at 12:43=E2=80=AFPM Viktor Malik <vmalik@redhat.co=
m> wrote:
> >>>
> >>> On 7/1/25 19:46, Alexei Starovoitov wrote:
> >>>> On Mon, Jun 30, 2025 at 6:35=E2=80=AFAM Viktor Malik <vmalik@redhat.=
com> wrote:
> >>>>>
> >>>>> BPF selftests compilation fails on systems with CONFIG_NET_SCH_BPF=
=3Dn.
> >>>>> The reason is that qdisc-related kfuncs are included via vmlinux.h =
but
> >>>>> when qdisc is disabled, they are not defined and do not appear in
> >>>>> vmlinux.h.
> >>>>
> >>>> Yes and that's expected behavior. It's not a bug.
> >>>> That's why we have CONFIG_NET_SCH_BPF=3Dy in
> >>>> selftests/bpf/config
> >>>> and CI picks it up automatically.
> >>>>
> >>>> If we add these kfuncs to bpf_qdisc_common.h where would we
> >>>> draw the line when the kfuncs should be added or not ?
> >>>
> >>> I'd say that we should add kfuncs which are only included in vmlinux.=
h
> >>> under certain configurations. Obviously stuff like CONFIG_BPF=3Dy can=
 be
> >>> presumed but there're tons of configs options which may be disabled o=
n a
> >>> system and it still makes sense to compile and run at least a part of
> >>> test_progs on them.
> >>>
> >>>> Currently we don't add any new kfuncs, since they all
> >>>> should be in vmlinux.h
> >>>
> >>> This way, we're preventing people to build and therefore run *any*
> >>> test_progs on systems which do not have all the configs required in
> >>> selftests/bpf/config. Running selftests on such systems may reveal bu=
gs
> >>> not captured by the CI so I think that it may be eventually beneficia=
l
> >>> for everyone.
> >>
> >> Not quite. What's stopping people to build selftests
> >> with 'make -k' ?
> >> Some bpf progs will not compile, but test_progs binary will be built a=
nd
> >> it will run the rest of the tests.
>
> I don't think test_progs will be built if some of the objects from
> progs/ do not build. I just tried to run `make -k` on a kernel with
> CONFIG_NET_SCH_BPF=3Dn. The compilation finished, some test binaries
> exist, but not test_progs.
>
> In addition, we generally don't want to ignore all the errors as some of
> them may be important.
>
> >>
> >> We can take this patch, but let's define the rules for adding
> >> kfuncs explicitly.
> >
> > Note, we have a VMLINUX_H argument that can be passed into BPF
> > selftests' makefile. We used to use this for libbpf CI to build latest
> > selftests against (very) old kernels, and it worked well.
> >
> > I don't think we need to make exceptions for a few kfuncs, all it
> > takes is to have vmlinux.h generated from kernel image built from
> > proper configuration.
> >
> > Also note, that "proper configuration" only applies to *built* kernel,
> > not the actually running host kernel. See how VMLINUX_BTF_PATHS is
> > defined and handled: host kernel is the last thing we use for
> > vmlinux.h generation, only if all other options are unavailable.
>
> This is a good point but the problem here is the extra kernel build. If
> you want to check that BPF in your kernel is working properly, you don't
> want to do another kernel build with a different config just for the
> sake of being able to build selftests.

What exactly is problematic? That's what I and others do all the time.
If kernel build time is a concern, then pre-generate/pre-package
vmlinux.h separately and use it to avoid building the kernel. (but BPF
selftest *expects* kernel to be built first, we also build bpf_testmod
against that kernel). Or just build/package test_progs itself, if
that's what works better.

Basically, we have that selftest/bpf/config file for a reason: so that
we don't guard every single thing that might not build or work
properly if some of the Kconfig value is not set.

>
> >> What are you proposing exactly ?
> >> Anything that is gated by some CONFIG_FOO _must_ be added explicitly ?
> >> Assuming we won't be going back and retroactively adding them ?
>
> Yes, exactly like that. Except for this qdisc one, we haven't run into

we should be getting rid of all those __ksym __weak kfunc
redefinitions because they now should come from vmlinux.h, not add
more of that, IMO.

> any issues for a long time, so I don't think that it's necessary to
> retroactively add the kfuncs.
>
> But if you prefer to have it unified, I can take some time to clean it
> up - add config-gated kfuncs where they are missing and replace
> universally-available kfuncs by vmlinux.h.
>

