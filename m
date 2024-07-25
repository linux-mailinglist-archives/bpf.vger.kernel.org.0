Return-Path: <bpf+bounces-35664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE9E93C949
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 22:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4FB31F22E93
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 20:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E7D762EB;
	Thu, 25 Jul 2024 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMP52Rg1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C06A76048
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721937855; cv=none; b=NNPoFsfhVkPJjDXdJQq7iK6KheZiCxpIx/spcucmwz4xlK+YY+iwvYzozH8VrcSQykySWuXuw4CSpGhh8D5DN/v7Rge8Gt/yME1J2grVfW2BBJlR7zh4od3inKBL1KZ5RGAp+2MlJiOaewhcyvtMl8NQMloD9vHsVFi35IupCXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721937855; c=relaxed/simple;
	bh=hLodcI5K7tTqlKYOG1CbhTfEVOurvaSler9Tgo4TY2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgdJ0M1xhwOIVl5KZyrZeE5Qb6evo3Vnl3bfRq4KUfRToInTzgNOlZcFzJYgfrtHhEjo9bbFQUI3FN3SQALZfKKtJ1jxaqz2GjR8x4otVbBY6FNYgfua/1V9weP7bJoUeQKC7kRGLF7moSmqpqLAigERRrLpak2Ddwl1nBIqLkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMP52Rg1; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7ac449a0e6so93664966b.1
        for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 13:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721937852; x=1722542652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keV/f2SuMyG9IehGIqscrvt7JW23HPRIqoZZs3j3whE=;
        b=iMP52Rg1xm1yvuFRyy+dZCO0R6Y2ChkkkLwiS69r1Wz1oS7nT9bmUw2ox8Oanw12Uh
         BwOxh33gWlh2mFzr+5NPg60E4lDezBxse24YIG+R0X1Hxd3HhmOLfcp84X+qd9H4nUj0
         sgeNn5JbGVXx6L9q+L2gspFssbbMIyekmLd6XzGofnAI6HRb+IN2/2We4NHSQR5NY2ZA
         Wr9b2uSkdRGhftJzJAYmIPrPjE3SNGrGCVc7kNl+80pl584uoyVcQgRu3rteWcl/+tag
         8HiV+jSCUiDBJ8BVatbyjAQx3jrtvH7UPs0mHuvUw8rqR1AgXhRTJk5T33pJqlYgM9TN
         IBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721937852; x=1722542652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=keV/f2SuMyG9IehGIqscrvt7JW23HPRIqoZZs3j3whE=;
        b=hV1hIQgMSbOHNWSFtVhFGy+lcceVfEhSUbMYGTdP4bFEvTPFuqYooqRS9p4UR9Yt0e
         wuCrtBct5Mo+v7cgVrrMPcviGMUAruEhn565lG6sK9l4C3XJck+fFRCy/o8vSKYf0zUm
         3AfdGHeCN+DGfe2s7hBSrV8mQcAH2NBAX0m6MUHGnA4cZh3i7pwN7nt973x8M8lqoNX6
         zMLojYjHF3/jRRHL1LmY3VutPyc17+vq7KDsC13hVDHxzaBSp3g26tAUG6fxd01x57CS
         rPsC5vrvSoOxjxbszhnzPdJePYcdVo7LWoWQVY1K2ze1vg8uaKAxxk21tVc5HM2RsqZU
         ErRA==
X-Forwarded-Encrypted: i=1; AJvYcCXxAYwlDzbL7DQ7NLl+5gu8HZSAPyU9vWSe5sV3koWC5GhUAuUou5+KLUXA637CYSGimXvu9L0QEveS3wOzdvGe9nmK
X-Gm-Message-State: AOJu0YyWBgxZBuwH2ZtqzH16wIfthCDJnxMCbm6mRoRpvf+ATjmJpy6L
	BMAULF0IyrQtUJabdEk0l+IkMINXBxmQ4H+nYVHdRbo3HEgWtHOy+1SuXy0ncjOiajVBOeA33cG
	JiGoZBTWARB2Ot/qEgGMBQiQECFI=
X-Google-Smtp-Source: AGHT+IFQuNq4+ITcXQALOODQTbirZQmDVSWKplJTCsq20BRgNzMCoo+CUfEi/wFOHqzNVaUmwOAYb6PpsLB7bM/WmBM=
X-Received: by 2002:a17:907:d86:b0:a7a:9ca6:527 with SMTP id
 a640c23a62f3a-a7acb3d9eb3mr237670866b.8.1721937851452; Thu, 25 Jul 2024
 13:04:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724225210.545423-1-andrii@kernel.org> <20240724225210.545423-11-andrii@kernel.org>
 <ZqJBK4loBv030jj_@krava>
In-Reply-To: <ZqJBK4loBv030jj_@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Jul 2024 13:03:55 -0700
Message-ID: <CAEf4BzZkGur_zPrPCEo6=asFGO1uBShvf1wwEoBhaKk-46ctAQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 10/10] selftests/bpf: add build ID tests
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 5:12=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Jul 24, 2024 at 03:52:10PM -0700, Andrii Nakryiko wrote:
> > Add a new set of tests validating behavior of capturing stack traces
> > with build ID. We extend uprobe_multi target binary with ability to
> > trigger uprobe (so that we can capture stack traces from it), but also
> > we allow to force build ID data to be either resident or non-resident i=
n
> > memory (see also a comment about quirks of MADV_PAGEOUT).
> >
> > That way we can validate that in non-sleepable context we won't get
> > build ID (as expected), but with sleepable uprobes we will get that
> > build ID regardless of it being physically present in memory.
> >
> > Also, we add a small add-on linker script which reorders
> > .note.gnu.build-id section and puts it after (big) .text section,
> > putting build ID data outside of the very first page of ELF file. This
> > will test all the relaxations we did in build ID parsing logic in kerne=
l
> > thanks to freader abstraction.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> one of my bpf selftests runs showed:
>
> test_build_id:PASS:parse_build_id 0 nsec
> subtest_nofault:PASS:skel_open 0 nsec
> subtest_nofault:PASS:link 0 nsec
> subtest_nofault:PASS:trigger_uprobe 0 nsec
> subtest_nofault:PASS:res 0 nsec
> subtest_nofault:FAIL:build_id_status unexpected build_id_status: actual 1=
 !=3D expected 2
> #42/1    build_id/nofault-paged-out:FAIL
> #42/2    build_id/nofault-paged-in:OK
> #42/3    build_id/sleepable:OK
> #42      build_id:FAIL
>
> I could never reproduce again.. but I wonder the the page could sneak
> in before the bpf program is hit and the buildid will get parsed?
>

Yes, and I just realized that I forgot to mark this test as serial. If
there is parallel test that also runs uprobe_multi and that causes
build_id page to be paged in into page cache, then this might succeed.
So I need to mark the test itself serial.

Another issue which I was debugging (and fixed) yesterday was that if
the memory passed for MADV_PAGEOUT is not yet memory mapped into the
current process, then it won't be really removed from the page cache.
I avoid that by first paging it in, and then MADV_PAGEOUT.


> or maybe likely madvise might just ignore that:
>
>        MADV_PAGEOUT (since Linux 5.4)
>               Reclaim a given range of pages.  This is done to free up me=
mory occupied by these pages.  If a page is anonymous, it will be swapped o=
ut.  If
>               a  page  is  file-backed  and dirty, it will be written bac=
k to the backing storage.  The advice might be ignored for some pages in th=
e range
>               when it is not applicable.
>
> jirka
>
>
> > ---
> >  tools/testing/selftests/bpf/Makefile          |   5 +-
> >  .../selftests/bpf/prog_tests/build_id.c       | 118 ++++++++++++++++++
> >  .../selftests/bpf/progs/test_build_id.c       |  31 +++++
> >  tools/testing/selftests/bpf/uprobe_multi.c    |  41 ++++++
> >  tools/testing/selftests/bpf/uprobe_multi.ld   |  11 ++
> >  5 files changed, 204 insertions(+), 2 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/build_id.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_build_id.c
> >  create mode 100644 tools/testing/selftests/bpf/uprobe_multi.ld
> >

[...]

