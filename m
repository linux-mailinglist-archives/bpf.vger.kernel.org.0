Return-Path: <bpf+bounces-35723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4206F93D2ED
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 14:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663251C23133
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 12:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5374F17A939;
	Fri, 26 Jul 2024 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbEZNJdI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEF4E57E
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996832; cv=none; b=f2yCDmTt/bHsl/7BakfkNrBRLq190NVv5noCQ8dfQlrudYrjzmQp4ZF7CdJQf46/yVjO3ObXlyTHBGeKMOYMNgVL6mjCJyK4q0qeqxJt185OyKHyvyWZAoRvNwB9FMDk0nY+7SF8IrK0tt4QMyFMqcFAUbVTanVylSismYy1UW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996832; c=relaxed/simple;
	bh=QL7WXE61J+/3KVPe9dBHCjkNIXx1vWdY+2GDe5OYMDs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hye6q8QTPgm3Bo//kdduisIX/+nPoVeu2Nm6YSX/ASDRVF49m0PUW7ZmQ41cE3soMGrFuVHZukfMQ6MXpck5yc2AADC4oSX9kdI9gl88uoMdAlMq1WwcjMxLPfeVXNmhhT/XWS3MWl1zbYRHAM3Oy4aVoELgpNTp8jpfySHszm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbEZNJdI; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso177615766b.0
        for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 05:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721996829; x=1722601629; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZCrMnr3m2dJfLfYaOkFL0+o4FnC8Eb7sKPzJDJllzk8=;
        b=kbEZNJdIuBmqinSp7LZxAXNyYP9GMar0ASAxnjruuXj0/R0z8btjlFqO03+yZTDa6A
         tSgU8C/S3M6zDdImYkyOkaSgTz8xuOVk0kx89x4sF4EY4sPr7+mo0JX9uAssHUOP+5m8
         GY686WSpc4j2LozUS+F/DBPqQMGBtNy8zF1lzJQ7ZgB5w/YKXNkkwuVRFcvtBigOrPcL
         1J7dHR63/7ombncebdW5toBqCnEgtjainx/fnoBFAqkp+5aCQK8QEXgCILYaf2sPng4i
         TfBkruIY9ZT7HE7RXbrmEZdY0Tt8Ppjg9uCjNs8A+VmpN6bXRg9oWajfkZYyx0AOqN8T
         bfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721996829; x=1722601629;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCrMnr3m2dJfLfYaOkFL0+o4FnC8Eb7sKPzJDJllzk8=;
        b=YkFE6XXfE0vaVvzEKZbUGSP3XxrsRqLhxIDKaCeCtFg1EA4znh6E/EL+rHbsekG0Xn
         78JDMZ/LD5b8kLE1DGeCDXw1Zj1PJK6765ROnICPX2jXon19Nb3X/rwj+YTa+TuGMr2d
         R0F7s9RkALB1TZaeOy+5No4kjgfW3JugHNCjlZlK/636qPVzupP965p20ihsFlkD/ObO
         F7FpI3mvq3dOp9Dxr43pnVxVKrscqvWBYcASaxyFESSfCnFz8Bf9UAqENDs+wg7/OCsv
         1ujCFjk1+iKLTFkc5HkkPc94GNxZPMaG4xRP4rY5GVg5e0PwmpskaAbgdZ3pG03L5kwu
         8+xg==
X-Forwarded-Encrypted: i=1; AJvYcCXJPZyYztOKuRUfd1kVSL8JF0ViOeS2OPeZhD93bBZlJD1iN6rFmpYT5aO/05kpm31GMwUUKRoOvZpN8wQV2TLXFHkr
X-Gm-Message-State: AOJu0Ywn5fLAJhkkvJvc1hXGevTKwpfTJc3/P/GjVh0yV7NOjXx3av2S
	FiaXp6ROvclyewWt02Pms/3xqChjg72kJk48uXTiP3OEjECt9NozPXtzTg==
X-Google-Smtp-Source: AGHT+IGazZ59kYJhYy4mSMc2usBi0QO3Zjos/v5bRFYjwZc/g8KUTaV9+eTukLHftbKfzGl+5vikhg==
X-Received: by 2002:a17:907:98b:b0:a77:cbe5:413f with SMTP id a640c23a62f3a-a7acb3d6a15mr350472166b.4.1721996829213;
        Fri, 26 Jul 2024 05:27:09 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acac63795sm172206166b.95.2024.07.26.05.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 05:27:08 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 26 Jul 2024 14:27:06 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
	adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	ak@linux.intel.com, osandov@osandov.com, song@kernel.org
Subject: Re: [PATCH v2 bpf-next 10/10] selftests/bpf: add build ID tests
Message-ID: <ZqOWGvrrubXbVDlY@krava>
References: <20240724225210.545423-1-andrii@kernel.org>
 <20240724225210.545423-11-andrii@kernel.org>
 <ZqJBK4loBv030jj_@krava>
 <CAEf4BzZkGur_zPrPCEo6=asFGO1uBShvf1wwEoBhaKk-46ctAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZkGur_zPrPCEo6=asFGO1uBShvf1wwEoBhaKk-46ctAQ@mail.gmail.com>

On Thu, Jul 25, 2024 at 01:03:55PM -0700, Andrii Nakryiko wrote:
> On Thu, Jul 25, 2024 at 5:12 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Wed, Jul 24, 2024 at 03:52:10PM -0700, Andrii Nakryiko wrote:
> > > Add a new set of tests validating behavior of capturing stack traces
> > > with build ID. We extend uprobe_multi target binary with ability to
> > > trigger uprobe (so that we can capture stack traces from it), but also
> > > we allow to force build ID data to be either resident or non-resident in
> > > memory (see also a comment about quirks of MADV_PAGEOUT).
> > >
> > > That way we can validate that in non-sleepable context we won't get
> > > build ID (as expected), but with sleepable uprobes we will get that
> > > build ID regardless of it being physically present in memory.
> > >
> > > Also, we add a small add-on linker script which reorders
> > > .note.gnu.build-id section and puts it after (big) .text section,
> > > putting build ID data outside of the very first page of ELF file. This
> > > will test all the relaxations we did in build ID parsing logic in kernel
> > > thanks to freader abstraction.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > one of my bpf selftests runs showed:
> >
> > test_build_id:PASS:parse_build_id 0 nsec
> > subtest_nofault:PASS:skel_open 0 nsec
> > subtest_nofault:PASS:link 0 nsec
> > subtest_nofault:PASS:trigger_uprobe 0 nsec
> > subtest_nofault:PASS:res 0 nsec
> > subtest_nofault:FAIL:build_id_status unexpected build_id_status: actual 1 != expected 2
> > #42/1    build_id/nofault-paged-out:FAIL
> > #42/2    build_id/nofault-paged-in:OK
> > #42/3    build_id/sleepable:OK
> > #42      build_id:FAIL
> >
> > I could never reproduce again.. but I wonder the the page could sneak
> > in before the bpf program is hit and the buildid will get parsed?
> >
> 
> Yes, and I just realized that I forgot to mark this test as serial. If
> there is parallel test that also runs uprobe_multi and that causes
> build_id page to be paged in into page cache, then this might succeed.
> So I need to mark the test itself serial.
> 
> Another issue which I was debugging (and fixed) yesterday was that if
> the memory passed for MADV_PAGEOUT is not yet memory mapped into the
> current process, then it won't be really removed from the page cache.
> I avoid that by first paging it in, and then MADV_PAGEOUT.

ok, I triggered that in serial run, so I probably hit this one

jirka

> 
> 
> > or maybe likely madvise might just ignore that:
> >
> >        MADV_PAGEOUT (since Linux 5.4)
> >               Reclaim a given range of pages.  This is done to free up memory occupied by these pages.  If a page is anonymous, it will be swapped out.  If
> >               a  page  is  file-backed  and dirty, it will be written back to the backing storage.  The advice might be ignored for some pages in the range
> >               when it is not applicable.
> >
> > jirka
> >
> >
> > > ---
> > >  tools/testing/selftests/bpf/Makefile          |   5 +-
> > >  .../selftests/bpf/prog_tests/build_id.c       | 118 ++++++++++++++++++
> > >  .../selftests/bpf/progs/test_build_id.c       |  31 +++++
> > >  tools/testing/selftests/bpf/uprobe_multi.c    |  41 ++++++
> > >  tools/testing/selftests/bpf/uprobe_multi.ld   |  11 ++
> > >  5 files changed, 204 insertions(+), 2 deletions(-)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/build_id.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/test_build_id.c
> > >  create mode 100644 tools/testing/selftests/bpf/uprobe_multi.ld
> > >
> 
> [...]

