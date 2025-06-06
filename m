Return-Path: <bpf+bounces-59914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBD2AD07F6
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 20:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7A23B1A43
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 18:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C471F0994;
	Fri,  6 Jun 2025 18:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAxRVTfv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747CC1EF092
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749234110; cv=none; b=GOj1r1iUWhz/+MPwkcftsOYYOJ1TH9hEgs5eTDpYUhMqVzGd6lPU2UsF6eKXWgCRIuizIwUNsvDsfBeYJtMXQUYZ5Als289LU4fK7suGsRPndYWPvkMAljeee5/npAICQQNwngk2yIXWZFTwjbOWqHd3cGz6sMD/8QYrXnvZfpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749234110; c=relaxed/simple;
	bh=LSb8gbfmgM6oxHI3hpEdSh0jWI0kfx0xiJSxrD1lnzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OH1aXFwOVSrX2VH9rMuX9PWqsxAOqdswuslq4ST9mBKUjb9YxVTN63w3NmJXtdPapAyWGJaaEgD6r8TRESYgoJaAUmE7NgoNL4ucPJKMQ04XVpM1N3ne3zeOnO6/v4vWKoeyPkUuc66Ho3v5ptPUtbX9MRpldAVGkxqHw8dC0Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAxRVTfv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2350b1b9129so15796425ad.0
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 11:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749234108; x=1749838908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdE//DoHn7WIYzDXpPpiovMo2LSFdj/zCDpxeY88hWY=;
        b=VAxRVTfvqyWbncc/BLr8KPbhjExYNXAWowa3nKDaO1dvRz0BSuYpN4SGEMWjyfR8RO
         vEJnroRV6MQn5KB2w/MJT4zA0xxTglneb0F4VBaDMc5+w6i+YLCcGnOSCHM+oamn11W3
         z8RdMy6lvg1pG+k19/WRIwmgimPIlTdVyEo/Z79m3nUg5JTqiYwFYdVSUE/rwJBUybbS
         4zE7GyuV/TCMRkH2Yj4ao8Els4y6zR6U//FsJyblvVOXhGZS8u3NESAPTZ5yZNbWdxBU
         m/04dwoJ5CAC3f3X2R660IDvA743+SA/WWRrLQ4sTApRVs+j9wfzLYsN3hJjYsOgPNLw
         xZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749234108; x=1749838908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdE//DoHn7WIYzDXpPpiovMo2LSFdj/zCDpxeY88hWY=;
        b=GCoZAGzlip3LxxyhidPFeEZrVRrqv3+4OCW5pbGlNYcjjHMmyAw5Q/I+iK6ZPIydH0
         9vEC38+7+t8ZHQ4HIw0Pa5cfSaa/ZUk8ev7SAqX6l0JF5IuCQIM1WNu7aYor+l5qh1Jw
         mBIrsWQKktoxhw54V818SdnjwRNV5kvIOuH4NWgDeCalbuEfhMDCfCUaV0QKJXsUU8HK
         Oj3xba9QEbj/zUa0IMLoJqQ0f2iquIaPCtTmxGX81lxZL4vTNMIui32Hv6k6qJvU5PXP
         gZQ65kulQPPyTw5HKehzRLJvwcBvUFRcc1rtzuieDqgvZuLv2AvXbi8txWQk03bgtMlp
         Gt4w==
X-Forwarded-Encrypted: i=1; AJvYcCV7EK46fPW6HEWrTX2elQ0PhI9ITr0iCgtyKaZiMuh5VvFfobZao5iqDKRPUevz9p6isec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1BBazVb/eqplE1fkTH46AUcx0dhLjeB7BwIO9BlsLThO0qFKx
	8oarKUVNCJCrVQ/AHQsgzJnm/Q0+k982UuZjKBHhDzzgMnINVDuGmlPYKBVNLmWqnhQ0rrNBP/Y
	wgz//84kLX3k0Traz/vKgZTHpW7OZiNc=
X-Gm-Gg: ASbGncvaUOsTz4tmuJYyfRRojyh1sbqkOUgkrVhiNe7QSVuyIiGyYU6OTOhlEOR050u
	8u6VWW/pyXq0fqR9IJRchLO9ecixGeONLLQUwTt5nMCe0rTW7f40NYClfbIcvXmstVPwky1O1r+
	zo8Z6DZ7E2MXw1AuT5/gZo27cxTKnqKJ4iGGb/HaFgmw==
X-Google-Smtp-Source: AGHT+IGVn2aqKJuqBawJNaY1lZSuCyjPXeNSjRNe2+NcqyrUNzYxGqFrKgUjLQRLrkwh34K9m1rCOMD0nvi32jddgFk=
X-Received: by 2002:a17:90b:554d:b0:311:c5d9:2c79 with SMTP id
 98e67ed59e1d1-31346c50561mr5468634a91.21.1749234107658; Fri, 06 Jun 2025
 11:21:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606032309.444401-1-yonghong.song@linux.dev>
 <CAEf4Bzb+rPo6bfYe71vOzAsqQb4JM6Gu-Hi66qPj0ioF=PFF9g@mail.gmail.com>
 <8ff0934e-3073-4535-9ec1-f9ee1379ff4e@linux.dev> <9e9d08a4-6e27-4cab-959d-e730cacd75f4@linux.dev>
 <CAEf4BzYDkYiJdBJyPv4P_3jYJg8JegkvDOYWTam-vBgDQHOQtA@mail.gmail.com> <4d010777-ecce-4cf5-933f-121e1dde6bf2@linux.dev>
In-Reply-To: <4d010777-ecce-4cf5-933f-121e1dde6bf2@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Jun 2025 11:21:34 -0700
X-Gm-Features: AX0GCFtRveIXPe_ROBJfKp2O9q_HhjTzb15dykwlq2X3H5eduYEll7ewa7_EVp4
Message-ID: <CAEf4BzYLiDstXhjh75zbs3OR5Komw9j_-qmqj-nDsj6pckW4xw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] selftests/bpf: Fix a few test failures with
 arm64 64KB page
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 10:15=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 6/6/25 9:57 AM, Andrii Nakryiko wrote:
> > On Fri, Jun 6, 2025 at 9:49=E2=80=AFAM Ihor Solodrai <ihor.solodrai@lin=
ux.dev> wrote:
> >>
> >> On 6/6/25 9:43 AM, Yonghong Song wrote:
> >>>
> >>>
> >>> On 6/6/25 9:30 AM, Andrii Nakryiko wrote:
> >>>> On Thu, Jun 5, 2025 at 8:23=E2=80=AFPM Yonghong Song <yonghong.song@=
linux.dev>
> >>>> wrote:
> >>>>> My local arm64 host has 64KB page size and the VM to run test_progs
> >>>>> also has 64KB page size. There are a few self tests assuming 4KB pa=
ge
> >>>>> and hence failed in my envorinment. Patch 1 tries to reduce long as=
sert
> >>>> typo: environment
> >>>>
> >>>>> logs when tail failed. Patches 2-4 fixed three selftest failures.
> >>>> How come our BPF CI doesn't catch this on aarch64?.. Ihor, any thoug=
hts?
> >>>
> >>> In CI for aarch64, the page size is 4KB. For example, for this link:
> >>>
> >>> https://github.com/kernel-patches/bpf/actions/runs/15482212552/
> >>> job/43590176563?pr=3D9053
> >>>
> >>> Find the kconfig, and we have
> >>>
> >>>     CONFIG_ARM64_4K_PAGES=3Dy
> >>>     # CONFIG_ARM64_16K_PAGES is not set
> >>>     # CONFIG_ARM64_64K_PAGES is not set
> >>>
> >>> and for 4K page, all these tests are fine, but not for 64K page.
> >>
> >> Ah right, I just realized the host pagesize doesn't matter, the kernel
> >> we are running tests against needs to be re-compiled with the right
> >> config.
> >>
> >> If this is important to test on CI, it can be another matrix dimension
> >> with customized kconfig. Do we want to do that?
> >>
> >
> > Can we just use 64KB page size for aarch64 (no 4KB variant for arm64)?
>
> We certainly can, but *not* testing 4k pages on any arch seems like a
> bad idea to me.

No-no, x86 should stay 4KB (can it even be 64KB page size on x86?).
But if it's hard to do 64KB on AWS arm64, so be it.

>
> If we think a step further, there are many permutations of important
> configs that we do not test. And it's impractical to test *everything*
> for each pending patch.
>
> What we could do is split BPF CI into two domains:
> * test most important configurations on every patch like we do now
> * test other config permutations on base branches (bpf-next, bpf)
> *sometimes*
>
> We have reserved hardware that is often idle when there is low
> activity on the list, and it could be used to run other things:
> older/newer compilers, different page sizes, particular kconfigs etc.
>
> This way we would catch problems earlier without overloading/expanding
> the CI infra.
>
> It's an effort to setup of course, but that's how I would approach it
> if we're serious about testing uncommon things.
>
>
> >>
> >>>
> >>>
> >>>>
> >>>>> Yonghong Song (4):
> >>>>>     selftests/bpf: Reduce test_xdp_adjust_frags_tail_grow logs
> >>>>>     selftests/bpf: Fix bpf_mod_race test failure with arm64 64KB pa=
ge
> >>>>> size
> >>>>>     selftests/bpf: Fix ringbuf/ringbuf_write test failure with arm6=
4 64KB
> >>>>>       page size
> >>>>>     selftests/bpf: Fix a user_ringbuf failure with arm64 64KB page =
size
> >>>>>
> >>>>>    .../selftests/bpf/prog_tests/bpf_mod_race.c    |  2 +-
> >>>>>    .../testing/selftests/bpf/prog_tests/ringbuf.c |  5 +++--
> >>>>>    .../selftests/bpf/prog_tests/user_ringbuf.c    |  6 ++++--
> >>>>>    .../selftests/bpf/prog_tests/xdp_adjust_tail.c | 18 ++++++++++++=
------
> >>>>>    .../selftests/bpf/progs/test_ringbuf_write.c   |  5 +++--
> >>>>>    5 files changed, 23 insertions(+), 13 deletions(-)
> >>>>>
> >>>>> --
> >>>>> 2.47.1
> >>>>>
> >>>
> >>
>

