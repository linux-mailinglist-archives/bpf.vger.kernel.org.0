Return-Path: <bpf+bounces-36081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196D7942141
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 22:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5C11C23F02
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 20:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D298B18B470;
	Tue, 30 Jul 2024 20:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fgt4eO1+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010041AA3C1
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722369812; cv=none; b=W0ZfgsQ2bRjTS3P81fq2t/Q6P5VpFWKH2sAsWgFcXX+2XtV6A9IuGcr1G6YYNp+BogkCMFsAo5s3LRXKHAFk5uzWgD5L3URhZJUPAXexzNQfVL4Tgre07n/9XNZpmIzhCeCMKLM5Dt1Eb2sZTj4ejLzFV/Zr2ekvK3CCtL1WdJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722369812; c=relaxed/simple;
	bh=yw8b+rZTordYgmSwSwt0mw9vgOA6i0cMbTd3qONAiZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKQKoDq1NgLd0tcaSFQJbkp+3kkm8xfFXz7PO1KJF7TGCTFbvCACG/ir4c6igDmJg4brePLIugXzd4xDiAV62WnIydf2ulU4cfBWlOmwgNQhkUAlPAyEh3MVFgY08MzBCRzHBGCQeYHNmiwTfbORs9K/a9XHjzkTEmY5iMUNKj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fgt4eO1+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fd66cddd07so33742335ad.2
        for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 13:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722369810; x=1722974610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dy2vTUicnHvciea9CSXO+764BDpH/BVQTzGJckestek=;
        b=Fgt4eO1+lhMQYxqZjUG8cZ8r8Q+IqMJKEX1i5fNK9Ib0OT6J4k23qR2Uh7K37eeJ5T
         /Zf867jUXLRkZkg1uuoF7LkaGX/Ke1LS3EvXB8KHmFl5JeuGepVvdf485xe/nyNuIura
         XR+BoyW8ppfqw+ehak8RCttThE8Ay5G5nglBEu1PAi4QfZAxIZSvcZAYW8VUa55qAnOP
         X/dEK+CHjhy3YdUEyVRUmyVk3+949IZ72h6l1vDqsJAFMlglt2x0bG2qNRGW4h2+VAkt
         DYsM+R2T4RCITACidD/fb0WSu6SG4VjcJBEk3t9bM36V7KCEum49kT7iLXhgRkqczf6x
         lTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722369810; x=1722974610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dy2vTUicnHvciea9CSXO+764BDpH/BVQTzGJckestek=;
        b=lSpCEIW/Vked4sjjAnp3ERUveR0x/e+KKd1cW3wi8pvBFbGhNwOdaT4Z25IY0fVwlS
         ZyE/wGNNv/uwRGnidoJ6eQIEz6CBAlBb0DQDUybHIYogm+i0I588AMiC5ZBvmc9CyX5V
         NRbqwFgwyW015CGTii3siiWAh5KCuc4oDWj5eEb5a8R6QSB+g0N1Md5hct6f6u9ku+bk
         cKVPwe/iDzO7XqLH/ZPjzbnKclKSrHIiNIpR7Mpjp4MGp0WuKI9nOBknQf39O+1RA56i
         mcP81tZpNYrKzuGjRXbJDv9PRENj7zqMdavugE4kix/Mx2K8+qC4H9//GdKSiZGydpQX
         Dm9g==
X-Forwarded-Encrypted: i=1; AJvYcCXnTPAUaqU7DNh4flMNVj6ofAdnhRrxDrKYR5ZgB0sdWqnAKkDeGG3iKTUGaOxb/M6mXJMsOjFylff/CgjfhZiLlGS0
X-Gm-Message-State: AOJu0YwvsHBg+T1MBlpFJkY7QoavrP6lXDAB1/OvR3BNpusKyj9Oq0NL
	Pl6JoW7COxeC7pX1iK6+Fnh7xW7oKuDEa4Vev0If1FynQe49T7GIFM8tbJGUOgVwR5omZb4tMG2
	gbtX8J9dDaWa6rfmc2eDejB/hbdA=
X-Google-Smtp-Source: AGHT+IEvOjsZXQDGU8kRbaQAy59V/K7H1ZwkhbsU+r+qcbBiffGBSjzlXNMFzQv5WcAQE3q1OuTxf9cENGYJElH64EU=
X-Received: by 2002:a17:90a:db95:b0:2c9:6514:39ff with SMTP id
 98e67ed59e1d1-2cf7e5e0d2bmr10351002a91.33.1722369810016; Tue, 30 Jul 2024
 13:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724225210.545423-1-andrii@kernel.org> <20240724225210.545423-11-andrii@kernel.org>
 <ZqJBK4loBv030jj_@krava> <CAEf4BzZkGur_zPrPCEo6=asFGO1uBShvf1wwEoBhaKk-46ctAQ@mail.gmail.com>
 <ZqOWGvrrubXbVDlY@krava> <CAEf4BzbF+Q14fW-z2Fg02AEcFaF+dU53FVpDO_K_Tz-xQP_k5g@mail.gmail.com>
 <ZqaeOl8c_Jwl3ieR@krava>
In-Reply-To: <ZqaeOl8c_Jwl3ieR@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 30 Jul 2024 13:03:17 -0700
Message-ID: <CAEf4BzZtu_LWu82z9RFDf00a77uJuEpqYtuJWqz2zvm8jG3UWA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 10/10] selftests/bpf: add build ID tests
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2024 at 12:38=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> On Fri, Jul 26, 2024 at 05:37:55PM -0700, Andrii Nakryiko wrote:
> > On Fri, Jul 26, 2024 at 5:27=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Thu, Jul 25, 2024 at 01:03:55PM -0700, Andrii Nakryiko wrote:
> > > > On Thu, Jul 25, 2024 at 5:12=E2=80=AFAM Jiri Olsa <olsajiri@gmail.c=
om> wrote:
> > > > >
> > > > > On Wed, Jul 24, 2024 at 03:52:10PM -0700, Andrii Nakryiko wrote:
> > > > > > Add a new set of tests validating behavior of capturing stack t=
races
> > > > > > with build ID. We extend uprobe_multi target binary with abilit=
y to
> > > > > > trigger uprobe (so that we can capture stack traces from it), b=
ut also
> > > > > > we allow to force build ID data to be either resident or non-re=
sident in
> > > > > > memory (see also a comment about quirks of MADV_PAGEOUT).
> > > > > >
> > > > > > That way we can validate that in non-sleepable context we won't=
 get
> > > > > > build ID (as expected), but with sleepable uprobes we will get =
that
> > > > > > build ID regardless of it being physically present in memory.
> > > > > >
> > > > > > Also, we add a small add-on linker script which reorders
> > > > > > .note.gnu.build-id section and puts it after (big) .text sectio=
n,
> > > > > > putting build ID data outside of the very first page of ELF fil=
e. This
> > > > > > will test all the relaxations we did in build ID parsing logic =
in kernel
> > > > > > thanks to freader abstraction.
> > > > > >
> > > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > >
> > > > > one of my bpf selftests runs showed:
> > > > >
> > > > > test_build_id:PASS:parse_build_id 0 nsec
> > > > > subtest_nofault:PASS:skel_open 0 nsec
> > > > > subtest_nofault:PASS:link 0 nsec
> > > > > subtest_nofault:PASS:trigger_uprobe 0 nsec
> > > > > subtest_nofault:PASS:res 0 nsec
> > > > > subtest_nofault:FAIL:build_id_status unexpected build_id_status: =
actual 1 !=3D expected 2
> > > > > #42/1    build_id/nofault-paged-out:FAIL
> > > > > #42/2    build_id/nofault-paged-in:OK
> > > > > #42/3    build_id/sleepable:OK
> > > > > #42      build_id:FAIL
> > > > >
> > > > > I could never reproduce again.. but I wonder the the page could s=
neak
> > > > > in before the bpf program is hit and the buildid will get parsed?
> > > > >
> > > >
> > > > Yes, and I just realized that I forgot to mark this test as serial.=
 If
> > > > there is parallel test that also runs uprobe_multi and that causes
> > > > build_id page to be paged in into page cache, then this might succe=
ed.
> > > > So I need to mark the test itself serial.
> > > >
> > > > Another issue which I was debugging (and fixed) yesterday was that =
if
> > > > the memory passed for MADV_PAGEOUT is not yet memory mapped into th=
e
> > > > current process, then it won't be really removed from the page cach=
e.
> > > > I avoid that by first paging it in, and then MADV_PAGEOUT.
> > >
> > > ok, I triggered that in serial run, so I probably hit this one
> > >
> >
> > you did it with v2 of the patch set? I had this bug in v1, but v2
> > should be fine, as far as I understand (due to unconditional
> > madvise(addr, page_sz, MADV_POPULATE_READ); before madvise(addr,
> > page_sz, MADV_PAGEOUT)). At least I haven't been able to reproduce
> > that anymore and BPF CI is now happy as well.
>
> yes, it's with v2 and I can still see that.. but only for the first run o=
f
> the test after reboot.. so far I have no clue.. I can see the successful
> page-out madvise (still not sure how much is that telling about the page
> being paged out), and then the build id code sees the page just fine
>
> attaching my .config in case
>

I wasn't able to repro this, sorry. It works very reliably for me with
your or my config. Given it also seems to work reliably in BPF CI, I'm
still inclined to add this tests, I think it's good to have that
coverage.

I'll monitor, and if it becomes flaky, we'll need to reassess this, of cour=
se.


> jirka
>
>
> ----
> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/x86 6.10.0 Kernel Configuration
> #

[...]

