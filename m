Return-Path: <bpf+bounces-34839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7989319C0
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 19:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 230052833F1
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 17:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9917D4D8C6;
	Mon, 15 Jul 2024 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/67cAKL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A434142A9D
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721065492; cv=none; b=eRHvfj06e5ON2CMeGobs7sSs6eNA7/hgsBLYpF49ukvvuXvnenbUqGqvTga8TXK7UWE2bAk2nSy3NjT0WpJHq6pTsBjjtnP8mcVOu9l3m9fmRrTpi1gqp6BzFgTbmxFUz4oO5nobz6XCfBjPTrxOeHz1GbhBfPaZ8YvA9GY8GUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721065492; c=relaxed/simple;
	bh=cGJ2CA9bomkbD+UyCBGrJ3cohTgnbtS28/5szmYGirc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4HB1szo2N/4lGtcQWKhnSFOWJYh7BHBUuGGHz+yFsUCSy/lW8srcrx549ACte/aitnJYzCl4QkzjaJWOWHB0M81bScSZkds4KYgbmRY6w5N51PRbpPvUQVPUF1iDidN3SYMnzAR9qktpJMCdZWUyM6xjj8uTDPT6/2gVaE3IOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/67cAKL; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c9d161affbso2978623a91.2
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 10:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721065490; x=1721670290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4i+EQgwoPw/oa6F5L8QzakcVyPBJqXsLiXImbisZIg=;
        b=M/67cAKL2JAUSoeFoBFMcoi68QjcxSoxw5ZfZRYUKb22Gp/nDtzRxT3jypENvUhhTB
         Zhsyziwk56er+kDr0xymcHCY1CKM1KzfmNsmx/LW9TzWNqINPY2LV8Cu0RPba5/mBd2d
         CvioLSZJsaul53VWe1PtdzvZJfSIIcUHHJSS2ucO5ILvlViQifnjDZbiY3IoUPYVEMTH
         hfhNoGZfMeVdfIxSQq7dzWdTe0d1X8UWk+dcTxYB+rkNyxnRHIZV3FTbqPIS6gj9gU4H
         MVknG2P3AAxsGxBsH+s+bIOkxb3oBHd5CpaKEQKJg1hY52Fzpa7l5wE3o47FvnGm9YX9
         QA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721065490; x=1721670290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4i+EQgwoPw/oa6F5L8QzakcVyPBJqXsLiXImbisZIg=;
        b=JAvQ5/Fes9WVNgbI+ERROy58VnPbq8+y9rxaGUh1f2/dj/LsuV2ifuaNnRZYgAM9vK
         38kdBnCZGsOsiPMjC/nD5cwESlKPo06VA+1LnqPcUyfPDiHC+T2QZVGnfrfm+WYzHjhL
         4S0L0OIxhPC/CyZp1FJVMBE16AtCKAnK28MBZE5vvobS7OkEqbzt89sfHxlAN7hKMt5R
         5fcvzAPJpFPBR6Ot9BwGaucPGmoIyPK7gupOkWUEDRgj1MvgBBhY1XHlp3Zpv2enaG3p
         z1EMFdlK5h5mlY0l55zR6B2kV6eBRfaqG0KgL/xTM0lGsC/J9eq3jUI3qGs5bQyX70fp
         Dz6g==
X-Forwarded-Encrypted: i=1; AJvYcCUuLrLDpukVf494ixOdc6SbV7zYze/w1ovQVZWJl4S7XngtPZqNxvc/8ISS6R1qwWWKlz4AVNz7A5Dv1g6MSsKJW/Kb
X-Gm-Message-State: AOJu0YzYLYCxmbTGqTf/un3AkxZlPqpSoTuwB5U9JCvu6rcMvh1023kt
	fCpAPnNJCk2MAExaIlZ9uNJefDxiAGZTCYTLNjvftc5rDOCARfB9+9sQqPsH2uFJiiz6mV0gfhg
	e7P2fQ28ur7Wxc2ielX7s6Xwz/NG8Ovsd
X-Google-Smtp-Source: AGHT+IFELJUY0CBXAjmqRFCMNA1ODe2KK1ioLCtvJCmDdDm96D1TeeSEouxKHspsdzSms3HHJL9ZOn8y+cpAYuJYnkk=
X-Received: by 2002:a17:90b:2d43:b0:2c9:73ff:6a0c with SMTP id
 98e67ed59e1d1-2cb3407933emr428883a91.20.1721065489853; Mon, 15 Jul 2024
 10:44:49 -0700 (PDT)
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
 <CAEf4BzYFad_hhk+ju1_Y+JeDGmOeD-Ur=+Yvfu2vkbR3frR6SQ@mail.gmail.com> <k7SpuAM7weZyfgdgXEHzOiDkk8iBsBrl7ZsTpvhKQNvijS8cWjJrBN9DVOxF45edRXxA2POvIu9cZce3bF2FmoFOEbfevr09X-1c1pKgZrw=@pm.me>
In-Reply-To: <k7SpuAM7weZyfgdgXEHzOiDkk8iBsBrl7ZsTpvhKQNvijS8cWjJrBN9DVOxF45edRXxA2POvIu9cZce3bF2FmoFOEbfevr09X-1c1pKgZrw=@pm.me>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 15 Jul 2024 10:44:37 -0700
Message-ID: <CAEf4Bzatg_CsKf7HeekaO3ZroXWg1ceJBgZ9KPWf2VkK1yKQ6Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: use auto-dependencies for test objects
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, 
	"andrii@kernel.org" <andrii@kernel.org>, "mykolal@fb.com" <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 14, 2024 at 6:17=E2=80=AFPM Ihor Solodrai <ihor.solodrai@pm.me>=
 wrote:
>
> On Friday, July 12th, 2024 at 12:06 PM, Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
>
> > So, bear with me for a moment please.
> > We have 3 test_progs/smth.c files that depend on a few .bpf.o files at =
runtime,
> > but do not include skel files for those .bpf.o, namely:
> > - core_reloc.c
> > - verifier_bitfield_write.c
> > - pinning.c
>
> Is this an exhaustive list, or did you mean it just as an example?
>
> I tried to figure out what tests reference or depend on .bpf.o files
> directly, and there seems to be much more of those.
>
> I added some prints to the makefile, and across all TRUNNERs 291
> generated .bpf.o objects do not have a corresponding (by name) .skel.h
> file. Part of them are blacklisted btf__% and alike.
>
> A grep of ".bpf.o" over the code gives 186 references:
>
>     $ grep -r '\.bpf\.o' --include=3D"*.[ch]" | wc -l
>     186 # number of references
>     $ grep -rl '\.bpf\.o' --include=3D"*.[ch]" | wc -l
>     58 # number of files
>
> For example, bpf_prog_test_load helper is sometimes used to load
> .bpf.o files, which introduces a direct dependency, as far as I
> understand.
>
> Of course we are talking about a subset of these dependencies: we want
> those cases where a relevant skel is not included, while .bpf.o is
> required. But we'd have to review each individual test (at least from
> the grep list) to filter the subset. Or am I wrong about this?

We do seem to have quite a bit of such dependencies indeed, roughly:

$ rg '\.bpf\.o' | wc -l
233

>
> I thought maybe to simply remove the dependency on $(TRUNNER_BPF_OBJS)
> and see what breaks, but I have doubts it's a good approach.

Well, what would happen is that now you can never rely on make to
build the right thing when you modify something in progs/*.c, and so
paranoidally one would have to do `make clean && make -j$(nproc)` to
make sure all relevant object files are rebuilt.

>
> > And we fix this by adding a dependency:
> >
> > $(TRUNNER_TEST_OBJS:.o=3D.d): ... $(TRUNNER_BPF_OBJS)
> >
> > Which makes all *.test.d files depend on .bpf.o files.
> > Thus, if progs/some.c file is changed and `make test_progs` is requeste=
d:
> > - because *.test.d files are included into current makefile [1],
> > make invokes targets for *.test.d files;
> > - *.test.d targets depend on *.bpf.o, thus some.bpf.o is rebuilt
> > (but only some.bpf.o, dependencies for other *.bpf.o are up to date);
> > - case A, skel for some.c is not included anywhere (CI failure for v2):
> > - nothing happens further, as *.test.d files are unchanged *.test.o
> > files are not rebuilt and test_progs is up to date
> > - case B, skel for some.c is included in prog_tests/other.c:
> > - existing other.test.d lists some.skel.h as a dependency;
> > - this dependency is not up to date, so other.test.o is rebuilt;
> > - test_progs is rebuilt.
> >
> > Do I understand the above correctly?
>
> Yes. This is my understanding as well.
>
> >
> > An alternative fix would be to specify additional dependencies for
> > core_reloc.test.o (and others) directly, e.g.:
> >
> > core_reloc.test.o: test_core_reloc_module.bpf.o ...
> >
> > (with correct trunner prefix)
> >
> > What are pros and cons between these two approaches?
>
> Well, this is a common issue of whether to "include everything" or to
> write an explicit list of dependencies.
>
> So far the tests depended on "everything", and the idea of this patch
> was to reduce repetitive tests compilation time by leveraging
> auto-generated explicit dependencies.
>
> However in the case with dynamically loaded .bpf.o, if we split the
> dependency of %.test.d on $(TRUNNER_BPF_OBJS), it's not clear to me
> what the benefits of that would be.
>
> I can't think of a situation when all BPF objs have to be rebuilt from
> scratch because of this dependency. And it was this way without the
> patch too.
>
> The only benefit I can see is that dependencies will be clearly listed
> in the makefile. It's a good thing of course, but is it worth the
> effort?
>

I think we'll end up having small amount of explicit dependencies, at
least for these cases (and any other similar ones):

$ rg '\.bpf\.o' | rg __btf_path
progs/verifier_bitfield_write.c:__btf_path("btf__core_reloc_bitfields.bpf.o=
")
progs/verifier_bitfield_write.c:__btf_path("btf__core_reloc_bitfields.bpf.o=
")
progs/verifier_bitfield_write.c:__btf_path("btf__core_reloc_bitfields.bpf.o=
")
progs/verifier_bitfield_write.c:__btf_path("btf__core_reloc_bitfields.bpf.o=
")


But I think the right direction is to get rid of file-based loading of
.bpf.o in favor of a) proper skeleton usage (lots of work to rewrite
portions of file, so not very hopeful here) or b) a quick-fix-like
equivalent and pretty straightforward <skel>___elf_bytes() replacement
everywhere where we currently load the same bytes from file on the
disk.

>
> On Friday, July 12th, 2024 at 12:52 PM, Andrii Nakryiko <andrii.nakryiko@=
gmail.com> wrote:
>
> > I don't particularly care. If we don't do that, then we waste some
> > effort to specify dependencies manually, just to remove them later. So
> > it might be worth it to do a quick switch to <skel>__elf_bytes(),
> >
> > ending up with a better end state earlier. But I don't feel strongly
> > about any of this, so it's up to you guys.
>
> If there are plans to eventually migrate all tests to use skels, then
> I agree with Andrii that figuring out dependencies would be a wasted
> effort.

I don't think there are plans, but it's definitely a desirable
outcome. Just no one signed up to do this rather mundane part of work.
So if you don't mind helping with this, that would be very much
appreciated (at least by me).

>
> But then the same can be said about switching to <skel>__elf_bytes(),
> right?

see above, elf_bytes is a quick and dirty way to get rid of file
dependencies and turn them into .skel.h dependency without having to
change existing tests significantly (which otherwise would be tons of
work).

>
> I don't mind going over the tests to clear out dependencies or modify
> the tests in some way. I just want to be sure it'll be in line with
> the project goals. Obviously, I am new to the codebase and don't know
> much about anything here, so I'm relying on your input.
>

+1 from me to convert to elf_bytes(), but let's see what other maintainers =
think

