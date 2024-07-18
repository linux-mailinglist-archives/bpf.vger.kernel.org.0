Return-Path: <bpf+bounces-35008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D83934FF6
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 17:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E740EB2199D
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 15:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C56144307;
	Thu, 18 Jul 2024 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/v3WT7E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED12013E8B6
	for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721316889; cv=none; b=haXHlLSjvQy4Z2Jsc4s4n1+K4pyaBCcupXojwtZtyoloVF0u2UJ0sNP0AGOG91i0IjsXuvwN47ZH+3lqAhqY7+rJvCy/BVi6qM4gtvPIbJWDrzfiL7ynL2FE7ZE400KjW0wU5/mNI9tHL7bTma+1kG5pDN5nTrMgY1roXYTkQng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721316889; c=relaxed/simple;
	bh=PqJlpev1oM2YR5sXsaTbqWbE88qRsopxpPDnZnFmcV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2mpMw9URNulk2KYqocuerxfHfSJfiqQvttpbzoAZFenIKH+L/9hRrt2RuD9GrF3n7iG/Bq+At42SnGX8KhG4CE/DV8UBd2aFB2EsyEB7ZDM3WzsyCHSG1qd3yr1wZ7+Vb7gGAkpXiJG0MABNjY7obARtsSjcy7vD4mFj1XhcDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/v3WT7E; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58b447c513aso870399a12.2
        for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 08:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721316886; x=1721921686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4M0EAyYGC0vGT87bPwxcIOWCEognj4r49CNuqm4qLUY=;
        b=T/v3WT7EFdubpfNhRPrZi2oW+SBVAqiQoiPltc/qONnw7sFwjcoOT0Q1jTyOqUwZba
         21xD4y6oZACGKx4J2GfoEfXm4B88e1MecvM2blnEtE6o8XQL7GKzPgiYS3WVvTk4j6qv
         5RGVNCjpiLOZgA7PGKuuRbbcmtxrPalLJbsLbecyU4wRp8CvVQiGHJD8d1PDxzFxwOJd
         PviMRYVUNw3VqXT+QbADtdzCs5zWC+X8+cz9Kss9idmegG19BK3JYZrejfP7mUll5gmV
         /42GWAWQFXtuhp0YZ0/TU8qf0qW0sO0yLyvEt3Xry0b57QPH+8IzQi1+Gjy/pDM8QwI0
         WEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721316886; x=1721921686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4M0EAyYGC0vGT87bPwxcIOWCEognj4r49CNuqm4qLUY=;
        b=nEiciS8q2JsvIwlV/qnmskD8fqyhBDwAyfoBMe4HIErPY90zNwFQvMp8ALCZ2fICBI
         lMf23cn8o0OEXNJIh+98zE4s1SGkuYKgO+CQiR5jIKpucUzbhd3gtsgwOIRw3tTeX0Nk
         /YYzRbE7eYiGwhDh2GZ1iQGYBhPtQNrCHBb+VoQF7KpUtZ+/Trvte6HQaerpmEgVc2rr
         R7whz5WjM8FUU8vVvmdQKdu3t2edwC9f+Zcm5V0irIF0T1UF6DhyzFXU6Nc+LQ5GkeEc
         9pEGMhLbAtXH3Qf+lgziz9jsnlHQwSB1BmLeqPbYRZacc1wdsveCM/jCK6Xdf+LVHyQM
         6pAA==
X-Forwarded-Encrypted: i=1; AJvYcCUInlCBKkR0O/Sdn7vbpGaFHE0qpHmD09Vu0Z819FVLaNlNHBMqixn40tiQv89SC7gQP9Wm0ZzugsuJMceJVs5WMTw4
X-Gm-Message-State: AOJu0YznthURfFETXaPN+ImACXX81wEg1+lwLPfjYim06Ul7UDkCLiLH
	Wz9zw4usol+oLVi9fv/pmUWhHui74au3PqbXqcg/ZIskkYPyukKvApaVp5Ww5aT5/CjskpP5KWG
	QSyVIvat+LrhYLFvmLhzmFhrl3HE=
X-Google-Smtp-Source: AGHT+IHWXGYvwA8bBhqUDptJEFFELLQNkj4bUFPUP5WkvBWQnR501lcm0xEpZhj5cIRoLX+MzKkzuetV4z+JWmk3kiM=
X-Received: by 2002:a17:906:408b:b0:a72:6375:5fca with SMTP id
 a640c23a62f3a-a7a01115fdamr351067566b.15.1721316885961; Thu, 18 Jul 2024
 08:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <gJIk-oNcUE6_fdrEXMp0YBBlGqfyKiO6fE8KfjPvOeM9sq1eCphOVjbBziDVRWqIZK1gZZzDhbeIEeX41WA34qTz82izpkgG-F6EFTfX4IY=@pm.me>
 <dcbf532f-bf17-bb8c-f798-987bce607e5d@iogearbox.net> <R36QrBuK6nQziAeE9Xb-8295ISr8B1ofPVAdWaR3rygfaDiHUl2I5EmG2xoCrEskurmOmclGak3JXWwxso43KR9M1LHsdOIt48XS6xe3PVI=@pm.me>
 <4d757f19ac6f7e17da2e87f482f129e75c6decf8.camel@gmail.com>
 <CAEf4BzY4kXRSci3Lb6ZFT7++6fics-w4_8rYMB4vCEHgrCWEnQ@mail.gmail.com>
 <b97340645b9a730df46e69b03b3ccba39816c414.camel@gmail.com>
 <CAEf4BzYFad_hhk+ju1_Y+JeDGmOeD-Ur=+Yvfu2vkbR3frR6SQ@mail.gmail.com>
 <k7SpuAM7weZyfgdgXEHzOiDkk8iBsBrl7ZsTpvhKQNvijS8cWjJrBN9DVOxF45edRXxA2POvIu9cZce3bF2FmoFOEbfevr09X-1c1pKgZrw=@pm.me>
 <CAEf4Bzatg_CsKf7HeekaO3ZroXWg1ceJBgZ9KPWf2VkK1yKQ6Q@mail.gmail.com>
 <bcee1451ef43fd08675e1296b1ce82058cd29d94.camel@gmail.com>
 <CAEf4BzaLatHkXGZ5pmNSC+b5_iZKBeeGqkS-VE8SwXQySviUHg@mail.gmail.com> <e33b186a5f728a96987347964a622cab64543189.camel@gmail.com>
In-Reply-To: <e33b186a5f728a96987347964a622cab64543189.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Jul 2024 08:34:28 -0700
Message-ID: <CAEf4BzZ+eDUAN8LE4duRqY+W4BkXoVx_TZbWj6fVLNzm9EeVsg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: use auto-dependencies for test objects
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, Daniel Borkmann <daniel@iogearbox.net>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, 
	"andrii@kernel.org" <andrii@kernel.org>, "mykolal@fb.com" <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 4:24=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2024-07-17 at 09:41 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > > I don't really see a point in migrating tests to use skels or
> > > elf_bytes if such migration does not simplify the test case itself.
> >
> > Hm... "simplify tests" isn't the goal of this change. The goal is to
> > speed up the build process (while not breaking dependencies). So I
> > don't see simplification of any kind as a requirement. I'd say we
> > shouldn't complicate tests (too much) just for this, but some light
> > changes seem fine to me.
>
> My point is that we don't need to update *any* tests to get 99.9% of
> the speed up. Thus, the tests update should have some additional net
> benefit. And I don't see much gains after looking through the tests.
>

Fair enough, I'm fine with that.

> > > By test simplification I mean at-least removal of some
> > > bpf_object__find_{map,program}_by_name() calls.
> >
> > Some tests are generic and need (or at least are more natural)
> > lookup-by-name kind of APIs. Sure we can completely rewrite tests, but
> > why?
>
> Sure, I meant the tests where the above APIs were used to find a
> single program or map etc, there are a few such tests.
>
> [...]
>
> > > - by adding a catch-all clause in the makefile, e.g. making test
> > >   runner depend on all .bpf.o files.
> >
> > do we actually need to rebuild final binary if we are still just
> > loading .bpf.o from disk? We are not embedding such .bpf.o (embedding
> > is what skeleton headers are adding), so why rebuild .bpf.o?
> >
> > Actually thinking about this again, I guess, if we don't want to add
> > skel.h to track precise dependencies, we don't really need to do
> > anything extra for those progs/*.c files that are not used through
> > skeletons. We just need to make sure that they are rebuilt if they are
> > changed. The rest will work as is because test runner binary will just
> > load them from disk at the next run (and user space part doesn't have
> > to be rebuilt, unless it itself changed).
>
> Good point. This can be achieved by making $(OUTPUT)/$(TRUNNER_BINARY)
> dependency on $(TRUNNER_BPF_OBJS) order-only, e.g. here is a modified
> version of the v2: https://tinyurl.com/4wnhkt32

+1

>
> [...]
>
> > > I assume that the goal here is to encode dependencies via skel.h file=
s
> > > inclusion. For bpf selftests presence of skel.h guarantees presence o=
f
> > > the freshly built object file. Why bother with elf_bytes rework if
> > > just including the skel files would be sufficient?
> >
> > see above, just because there is no guarantee that we use all the
> > dependencies and we didn't miss any. It's not a high risk, but it's
> > also trivial to switch to elf_bytes.
> >
> > another side benefit of completely switching to .skel.h is that we can
> > stop copying all .bpf.o files into BPF CI, because test_progs will be
> > self-contained (thought that's not 100% true due to btf__* and maybe a
> > few files more, which is sad and a bit different problem)
>
> Hm, this might make sense.
> There are 410Mb of .bpf.o files generated currently.
> On the other hand, as you note, one would still need a list of some
> .bpf.o files, because there are at-least several tests that verify
> operation on ELF files, not ELF bytes.

still an improvement and will get us close. Right now there is no
incentive to do anything about those few special cases (like btf__*)
because of all the other .bpf.o dependencies.

>
> [...]
>
> > keep in mind that we do want to rebuild .bpf.o if libbpf's BPF-side
> > headers changed, so let's make sure that stays (or happens, if we
> > don't do it already)
>
> Commands below cause full rebuild (.test.o, .bpf.o) on v2 of this
> patch-set:
> $ touch tools/lib/bpf/bpf.h
> $ touch tools/lib/bpf/libbpf.h

yeah, ideally they wouldn't cause bpf.o rebuilds... I think we should
tune .bpf.o to depend only on BPF-side headers (we'd need to hard-code
them, but they don't change often: usdt.bpf.h, bpf_tracing.h,
bpf_helpers.h, etc). I don't think we can get rid of BPF skeletons'
dependency on bpftool (which depends on *any* libbpf change), though,
so .skel.h will be regenerated due to any tiny libbpf change, but
that's still better, as bpf.o building is probably the slowest part.

So. Many. Opportunities. :)

>
> [...]

