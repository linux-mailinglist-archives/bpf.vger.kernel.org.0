Return-Path: <bpf+bounces-22646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C322F8628CD
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 03:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746C428218D
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 02:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233E82F41;
	Sun, 25 Feb 2024 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7GMT4Rj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3666863B
	for <bpf@vger.kernel.org>; Sun, 25 Feb 2024 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708828229; cv=none; b=i993m5wRcOMkmvSCFR/Bl57lE3gHIzHVcP1E0BlYiJ0vmBLpR6wYh/bkn+7ZV8ni6nUxdfDDpW/VKqwqhDUVHop2zBDwHWxQbVIEtogcGgGcs0ENKJmOvgdMUGDcZywrQ2x5Qxy79PkGxvLYMbbph2H9jQBqVtXYNHTd6WgIU90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708828229; c=relaxed/simple;
	bh=8HEsAFLKJTaB0sVah9wViLytYv4pZC4CiAt7OsSiYp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCgGj7UMzw+LvQTF9L9S3pAGd/mKM/LntNvTg5vPzFxFfWQkFmdWrsgaYczfwFF+2dzb8Ds5qTyjAmBOCGI6UwVrc69BEVfXa5jiXtncICbY5qP4PPkklDF1VC+28EJayu9YRLTTsHJp7s0qypnKlV6EwBJKaWZrYy4FUJHBZZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7GMT4Rj; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-68fef04c5c1so2777376d6.0
        for <bpf@vger.kernel.org>; Sat, 24 Feb 2024 18:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708828227; x=1709433027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lupij2p6irhx7TuT5GelzfGEwZ0M24AVQ7A25UPMedQ=;
        b=I7GMT4RjWAgCx4wNzu5UHI+s4SPxosZCKcKWw78pEy4UyKceHRf042zaxengQMebLC
         M0DLdapJ3CvrM8fVFj9SY4s9G98XJtV7JJvkd6h7l1fw6Ywzng47P0H9z3IfumrEz+ol
         ioCYF0ImfVzgc8UAoKg8a+GokrudcENGsXE+73Fy7X8DoYhZZICyqqb1gc8eBG+G9IpJ
         jpMiuFVIn9NOlFZxHpgHRxcDayXIIBoQEULU90Agh1Fd6osUKhLvWpq7Dv6kTvU3mbXy
         W35toxvixOJBZgXer4hJs2RGkd5Ytb/Wo6HB+dI0n5ZNEWt2hKOLF0AKqlA2Hd+/UVbf
         K0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708828227; x=1709433027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lupij2p6irhx7TuT5GelzfGEwZ0M24AVQ7A25UPMedQ=;
        b=I8F0fu918pSnpmFiRiBitpMnJFtAvMy+ld5heHuE7lQsgxUsrbFsZxm8r1IYZ9WnbX
         j4iwX7dZbtu+nvvkSmFqyvkbibzbelnGvDjHMDmh4P2S+Wk/xnxbmuQNuXkVlexbUeOC
         H/pvw/ZtHEfA30vV6qOmAbHVikB60/hn302uIVBr3HKPBEuMNNxvl4iP84rNz2HP/aFR
         IMu9mzhtmge4oH+ItJhfIPIeRECc9ILHMHB/j3V4RL6B0JJC7WfQWCbiPTz0/ulGaCr6
         VZofRtcYfxceiMXmgJhH/IwLp9fBcZz7KPZ0KidxUG3iRUC6OAyElU+bGNTTEGRLQkSM
         UvnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTpr7t7s5gBGqwL/P2fXd9Y6KJIikjIJcrOqQ1gYs/o4sEo0kIBdK5NZE0Hezk/bB6hY+lxQHn7DsOlhesUKB3SKuY
X-Gm-Message-State: AOJu0YwTWlZath95BaFMcQGLHQb+HRRMOUukFavtCRfWxiUiykQEd9Om
	8/CW5ohzTSNFVUYEg6ByM0/EBKHmVOtcXWhG8uMSphwkkGIdU/E6rtYa+6FqOO8ZprCajfpQIGa
	OLqlQwPzzGXloiENLf5R51gU9apA=
X-Google-Smtp-Source: AGHT+IHPt0YqTPCge2Jc/XCAg1mZXNCXSsBEfoZrSaSznhyU8s+T2Ywcy8gRDoLty9z47UCJwwhgqBbEm113g7Chkd0=
X-Received: by 2002:a05:6214:20e3:b0:68f:eca7:2ee4 with SMTP id
 3-20020a05621420e300b0068feca72ee4mr3501528qvk.20.1708828227086; Sat, 24 Feb
 2024 18:30:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240218114818.13585-1-laoar.shao@gmail.com> <20240218114818.13585-3-laoar.shao@gmail.com>
 <CAADnVQKYWm0PrkZH05q133FwaD5zrDSuBH1sJ5aXxGrVua2SsQ@mail.gmail.com>
 <CALOAHbCSXrX-igGH0TJTWcKSGg7u6KOfGQrqpwymxf4y1+f2kQ@mail.gmail.com> <26ceafc98a4408884e707314d3eb9cbf8c0b6d58.camel@gmail.com>
In-Reply-To: <26ceafc98a4408884e707314d3eb9cbf8c0b6d58.camel@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 25 Feb 2024 10:29:50 +0800
Message-ID: <CALOAHbDV_KRhbPVsLbfuiDL=iF3eceR0cOdJUo0cuaO_G_=V=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add selftest for bits iter
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 7:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2024-02-23 at 10:29 +0800, Yafang Shao wrote:
>
> [...]
>
> > > The patch 1 looks good, but this test fails on s390.
> > >
> > > read_percpu_data:FAIL:nr_cpus unexpected nr_cpus: actual 0 !=3D expec=
ted 2
> > > verify_iter_success:FAIL:read_percpu_data unexpected error: -1 (errno=
 95)
> > >
> > > Please see CI.
> > >
> > > So either add it to DENYLIST.s390x in the same commit or make it work=
.
> > >
> > > pw-bot: cr
> >
> > The reason for the failure on s390x architecture is currently unclear.
> > One plausible explanation is that total_nr_cpus remains 0 when
> > executing the following code:
> >
> >     bpf_for_each(bits, cpu, p->cpus_ptr, total_nr_cpus)
> >
> > This is despite setting total_nr_cpus to the value obtained from
> > libbpf_num_possible_cpus():
> >
> >     skel->bss->total_nr_cpus =3D libbpf_num_possible_cpus();
> >
> > A potential workaround could involve using a hardcoded number of CPUs,
> > such as 8192, instead of relying on total_nr_cpus. This approach might
> > mitigate the issue temporarily.
>
> I'm sorry, but is it really necessary to deal with total number of
> CPUs in a test for bit iterator?

The CPU number verification is served to validate the functionality of
bpf_iter_bits_next(). However, I believe we can streamline the logic
by removing the surrounding code.

> Tbh, cpumask_iter / verify_iter_success seem to be over-complicated.
> Would it be possible to reuse test_loader.c's RUN_TESTS for this feature?
> It supports __retval(...) annotation, so it should be possible to:
> - create a map (even a constant map) with some known data;
> - peek a BPF program type that supports BPF_PROG_TEST_RUN syscall command=
;
> - organize test BPF programs so that they create bit iterators for
>   this test data and return some expected quantities (e.g. a sum),
>   verified by __retval.
>
> This should limit the amount of code on prog_tests/*.c side
> to the bare minimum.

Thank you for your suggestion. I will consider it carefully.

--=20
Regards
Yafang

