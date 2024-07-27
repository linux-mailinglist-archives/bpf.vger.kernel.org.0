Return-Path: <bpf+bounces-35788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B8593DCA2
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 02:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8582838C7
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 00:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB30110A;
	Sat, 27 Jul 2024 00:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJLUZ10T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B867E8
	for <bpf@vger.kernel.org>; Sat, 27 Jul 2024 00:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722040690; cv=none; b=NhZLISp0XlD9F6NZ4aF2DUh9vC6uX9oKniPU1IUOBZwfqtYbonje/u7IwTFbCAZ7P8jdG2uRC4kxSEyhFiEdk9DQsXLpUtd5JlK2MPvP5l9tl0p4qAIHTeO5hPU5UG1WtTIMX1o6D9JnEUeUIS2y8iSPYMoEtWegVr5WcwtaJAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722040690; c=relaxed/simple;
	bh=lcOGx1Pwo5/f1wZZuVH/zwoHtNcVjWe8qE4QDNb8vd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWLd1i6Vf7V87pHEMGaZ7tK9NMjz4oTbf3T5cWRzYUPjRRKlauOrUlonIOIU3NZgMs2QX4mCIW1idVLJmmYFKPHnkAwly5fhEICdKz8zcxYwp729xtuDuKjkHWtEEQ4qCZHOsknncQGrttyttsHSQdVT9zn+xSOPBJcXuG2xKsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJLUZ10T; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7928d2abe0aso1057321a12.0
        for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 17:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722040688; x=1722645488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C04Scg6I7CABHPEjc8V3MN/P08PTu2wPz8zjUnSZGdA=;
        b=aJLUZ10TZjM3Y5L51sv3xQ1PrtkenVUDvUjAUikgTNvu4yIuq/8z8TAxpPmORISPVl
         6PwXvWv1q0G09RAAXtEsr0oAtBMAGDXihgCC8EfvZORdu7klTgb+9yIgHXODoc1Vcnk0
         CJrDW0I0NjuQZt90Sol6XDIgsmAGJmTC13ynuQ1vNuhBvNmkLALA5mqCl35sdB9g+8dO
         g7hu490FrGsTmR8AaMddiMX207MTghAvD60Bx+nqz68aX4SUcVSUqHRLssFJyMtOblWj
         lLVHM9eMeoUZ83/5gBoeV3rxHyNiJeU2ytE2Ri/yFZnC+5C1tapLUvI5pU7S4DSS/s+t
         RYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722040688; x=1722645488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C04Scg6I7CABHPEjc8V3MN/P08PTu2wPz8zjUnSZGdA=;
        b=jjQcRP8vvkz5QFYNQHDM4/a/tDL52eNm7MSzLYLXSPj6LgfdjxOkBdScZ4H+1oRIIg
         q0HS5PqUwM0AUBXta3qOcrfvYEUc0GaMC3IAsyfjqBUeXMqwRWbJgjBDuVf2m5+OgwT5
         apTCv/4gVbPCt4djUkc3osv0qul2tkloPO46qJQ1+w2ovgXWvZgxkZ7cYoNXBMmN98aU
         bp8OIETvwE7q8SQI1cFuEjSJuNUhVp30c5azvWsqrfX0MbUeXX4GBjJnoji+oBl2VWen
         A1Qayqrt3MEwi68GZ4rmGUVu1IQ4WofMoMfxeppkSWf+xBqclIsulqnobE6rO1JcyAPg
         swhg==
X-Forwarded-Encrypted: i=1; AJvYcCUM8KwFGlGeUGhhERPElrXx1r/stFeWR35xH8l5rTt52jNBP+lqdbwCfEyR4SgXMnop+n0TarFkfMonfxeOvnNNK23Q
X-Gm-Message-State: AOJu0YwVGMN1WZONFJLia7DxXE1DqFoZX6WQ/KJ0fqGtXB/kmyy/Mm2k
	I34Pe2KRmd0KZhG3AUVYE+YJCpURJsIrnDyVbYamsp3G0dZStsDEx5jUDgGa/1VYrxAhyRBj8z1
	KQIXyz5BD0+C1tT9QB4QnLzf4mpk=
X-Google-Smtp-Source: AGHT+IGDaXyFN5/aNyXrQppfxXb+HtLbGx8WKfn8WTn3itrECa199GUlOuZ+kBayq+PY6WOZA6/jL+emVLC+52+ns70=
X-Received: by 2002:a17:90a:ec0c:b0:2cb:5883:8fb0 with SMTP id
 98e67ed59e1d1-2cf7cf7fd03mr1873756a91.14.1722040687978; Fri, 26 Jul 2024
 17:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724225210.545423-1-andrii@kernel.org> <20240724225210.545423-11-andrii@kernel.org>
 <ZqJBK4loBv030jj_@krava> <CAEf4BzZkGur_zPrPCEo6=asFGO1uBShvf1wwEoBhaKk-46ctAQ@mail.gmail.com>
 <ZqOWGvrrubXbVDlY@krava>
In-Reply-To: <ZqOWGvrrubXbVDlY@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Jul 2024 17:37:55 -0700
Message-ID: <CAEf4BzbF+Q14fW-z2Fg02AEcFaF+dU53FVpDO_K_Tz-xQP_k5g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 10/10] selftests/bpf: add build ID tests
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 5:27=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Jul 25, 2024 at 01:03:55PM -0700, Andrii Nakryiko wrote:
> > On Thu, Jul 25, 2024 at 5:12=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Wed, Jul 24, 2024 at 03:52:10PM -0700, Andrii Nakryiko wrote:
> > > > Add a new set of tests validating behavior of capturing stack trace=
s
> > > > with build ID. We extend uprobe_multi target binary with ability to
> > > > trigger uprobe (so that we can capture stack traces from it), but a=
lso
> > > > we allow to force build ID data to be either resident or non-reside=
nt in
> > > > memory (see also a comment about quirks of MADV_PAGEOUT).
> > > >
> > > > That way we can validate that in non-sleepable context we won't get
> > > > build ID (as expected), but with sleepable uprobes we will get that
> > > > build ID regardless of it being physically present in memory.
> > > >
> > > > Also, we add a small add-on linker script which reorders
> > > > .note.gnu.build-id section and puts it after (big) .text section,
> > > > putting build ID data outside of the very first page of ELF file. T=
his
> > > > will test all the relaxations we did in build ID parsing logic in k=
ernel
> > > > thanks to freader abstraction.
> > > >
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > >
> > > one of my bpf selftests runs showed:
> > >
> > > test_build_id:PASS:parse_build_id 0 nsec
> > > subtest_nofault:PASS:skel_open 0 nsec
> > > subtest_nofault:PASS:link 0 nsec
> > > subtest_nofault:PASS:trigger_uprobe 0 nsec
> > > subtest_nofault:PASS:res 0 nsec
> > > subtest_nofault:FAIL:build_id_status unexpected build_id_status: actu=
al 1 !=3D expected 2
> > > #42/1    build_id/nofault-paged-out:FAIL
> > > #42/2    build_id/nofault-paged-in:OK
> > > #42/3    build_id/sleepable:OK
> > > #42      build_id:FAIL
> > >
> > > I could never reproduce again.. but I wonder the the page could sneak
> > > in before the bpf program is hit and the buildid will get parsed?
> > >
> >
> > Yes, and I just realized that I forgot to mark this test as serial. If
> > there is parallel test that also runs uprobe_multi and that causes
> > build_id page to be paged in into page cache, then this might succeed.
> > So I need to mark the test itself serial.
> >
> > Another issue which I was debugging (and fixed) yesterday was that if
> > the memory passed for MADV_PAGEOUT is not yet memory mapped into the
> > current process, then it won't be really removed from the page cache.
> > I avoid that by first paging it in, and then MADV_PAGEOUT.
>
> ok, I triggered that in serial run, so I probably hit this one
>

you did it with v2 of the patch set? I had this bug in v1, but v2
should be fine, as far as I understand (due to unconditional
madvise(addr, page_sz, MADV_POPULATE_READ); before madvise(addr,
page_sz, MADV_PAGEOUT)). At least I haven't been able to reproduce
that anymore and BPF CI is now happy as well.

> jirka
>
> >
> >
> > > or maybe likely madvise might just ignore that:
> > >
> > >        MADV_PAGEOUT (since Linux 5.4)
> > >               Reclaim a given range of pages.  This is done to free u=
p memory occupied by these pages.  If a page is anonymous, it will be swapp=
ed out.  If
> > >               a  page  is  file-backed  and dirty, it will be written=
 back to the backing storage.  The advice might be ignored for some pages i=
n the range
> > >               when it is not applicable.
> > >
> > > jirka
> > >
> > >
> > > > ---
> > > >  tools/testing/selftests/bpf/Makefile          |   5 +-
> > > >  .../selftests/bpf/prog_tests/build_id.c       | 118 ++++++++++++++=
++++
> > > >  .../selftests/bpf/progs/test_build_id.c       |  31 +++++
> > > >  tools/testing/selftests/bpf/uprobe_multi.c    |  41 ++++++
> > > >  tools/testing/selftests/bpf/uprobe_multi.ld   |  11 ++
> > > >  5 files changed, 204 insertions(+), 2 deletions(-)
> > > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/build_id=
.c
> > > >  create mode 100644 tools/testing/selftests/bpf/progs/test_build_id=
.c
> > > >  create mode 100644 tools/testing/selftests/bpf/uprobe_multi.ld
> > > >
> >
> > [...]

