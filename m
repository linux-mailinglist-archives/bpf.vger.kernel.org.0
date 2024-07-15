Return-Path: <bpf+bounces-34790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B06930C54
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 03:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39111C20B66
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 01:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E694A35;
	Mon, 15 Jul 2024 01:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Lur5Vyne"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F2C20EB
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 01:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721006251; cv=none; b=kWNIhfiwBlAPPyZ4p5rCX7Vmuk1rH7SCdB6AFe/JXNlz6ZDs7Zn7KmdFPq1Q1uyF0+ou7x9lwB4BouEeJpvM7qoQtURVyS+rSJEu/afeM4pFyN/RGWpWPQ2U0HlVwEz4YSdB5DElkzS3Tqs3l7QMeEWNNwRKvSDaXQoATBsj9IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721006251; c=relaxed/simple;
	bh=2o+AEWreyDt67GdO7ciYLhU1oqbp5kZsekY/MDMmSWo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b5Jc14plC/wajQMkMvyHOZaAV98oJam7Q0MID7QUYgi5zFGfpvnS/q2tCYmIiM1QAV/PXvoqp+/AkSqMegaTOxo3SgLvf6RnAbwQKxpnwuXT9zrchFUsV7H84zTog7yebTSdQvnMc3AYYWju+oqGtJNuugu1kaQELGBo4q6s4MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Lur5Vyne; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1721006242; x=1721265442;
	bh=aXn8GNr+NUykbkeODKwhVUJc5y7XO8QVjK2P25X6rV8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Lur5VyneXMVAcMmAaNI8HOR3PSbHYLQZjrRPDeA44PRNmJyzpOLbXk3sBtFpoSNle
	 a7nBApuykWdhHpUjgvuNn7qJjY2RrLudJu6iJLCJrQ9Je7fvBAVWQCpxSaxUmQOSeB
	 eS84f5Dn7DKaAy7Vr9VbZZJ3THydOLCC1jZx1OfZAipwPBczN5Kf4+U0B6B2TYjn0U
	 RbGPW3GVbDKHcLOWiUi2sxNvW+UDt1etBexZg6G5yXl8+3eXNHNxk5+RsYmIiyGD2x
	 i5Fq84/JazOVkpvd6sFMNWmUZfVxNAtY73/JID8hGLOo/CTJGj6CBOz8ewO9NsXpQ0
	 XIly5uYjwv7JQ==
Date: Mon, 15 Jul 2024 01:17:17 +0000
To: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Daniel Borkmann <daniel@iogearbox.net>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>, "mykolal@fb.com" <mykolal@fb.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: use auto-dependencies for test objects
Message-ID: <k7SpuAM7weZyfgdgXEHzOiDkk8iBsBrl7ZsTpvhKQNvijS8cWjJrBN9DVOxF45edRXxA2POvIu9cZce3bF2FmoFOEbfevr09X-1c1pKgZrw=@pm.me>
In-Reply-To: <CAEf4BzYFad_hhk+ju1_Y+JeDGmOeD-Ur=+Yvfu2vkbR3frR6SQ@mail.gmail.com>
References: <gJIk-oNcUE6_fdrEXMp0YBBlGqfyKiO6fE8KfjPvOeM9sq1eCphOVjbBziDVRWqIZK1gZZzDhbeIEeX41WA34qTz82izpkgG-F6EFTfX4IY=@pm.me> <dcbf532f-bf17-bb8c-f798-987bce607e5d@iogearbox.net> <R36QrBuK6nQziAeE9Xb-8295ISr8B1ofPVAdWaR3rygfaDiHUl2I5EmG2xoCrEskurmOmclGak3JXWwxso43KR9M1LHsdOIt48XS6xe3PVI=@pm.me> <4d757f19ac6f7e17da2e87f482f129e75c6decf8.camel@gmail.com> <CAEf4BzY4kXRSci3Lb6ZFT7++6fics-w4_8rYMB4vCEHgrCWEnQ@mail.gmail.com> <b97340645b9a730df46e69b03b3ccba39816c414.camel@gmail.com> <CAEf4BzYFad_hhk+ju1_Y+JeDGmOeD-Ur=+Yvfu2vkbR3frR6SQ@mail.gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 751999219b789d8366b5e1323fb1192cbdd63f9a
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, July 12th, 2024 at 12:06 PM, Eduard Zingerman <eddyz87@gmail.com=
> wrote:

> So, bear with me for a moment please.
> We have 3 test_progs/smth.c files that depend on a few .bpf.o files at ru=
ntime,
> but do not include skel files for those .bpf.o, namely:
> - core_reloc.c
> - verifier_bitfield_write.c
> - pinning.c

Is this an exhaustive list, or did you mean it just as an example?

I tried to figure out what tests reference or depend on .bpf.o files
directly, and there seems to be much more of those.

I added some prints to the makefile, and across all TRUNNERs 291
generated .bpf.o objects do not have a corresponding (by name) .skel.h
file. Part of them are blacklisted btf__% and alike.

A grep of ".bpf.o" over the code gives 186 references:

    $ grep -r '\.bpf\.o' --include=3D"*.[ch]" | wc -l
    186 # number of references
    $ grep -rl '\.bpf\.o' --include=3D"*.[ch]" | wc -l
    58 # number of files

For example, bpf_prog_test_load helper is sometimes used to load
.bpf.o files, which introduces a direct dependency, as far as I
understand.

Of course we are talking about a subset of these dependencies: we want
those cases where a relevant skel is not included, while .bpf.o is
required. But we'd have to review each individual test (at least from
the grep list) to filter the subset. Or am I wrong about this?

I thought maybe to simply remove the dependency on $(TRUNNER_BPF_OBJS)
and see what breaks, but I have doubts it's a good approach.

> And we fix this by adding a dependency:
>=20
> $(TRUNNER_TEST_OBJS:.o=3D.d): ... $(TRUNNER_BPF_OBJS)
>=20
> Which makes all *.test.d files depend on .bpf.o files.
> Thus, if progs/some.c file is changed and `make test_progs` is requested:
> - because *.test.d files are included into current makefile [1],
> make invokes targets for *.test.d files;
> - *.test.d targets depend on *.bpf.o, thus some.bpf.o is rebuilt
> (but only some.bpf.o, dependencies for other *.bpf.o are up to date);
> - case A, skel for some.c is not included anywhere (CI failure for v2):
> - nothing happens further, as *.test.d files are unchanged *.test.o
> files are not rebuilt and test_progs is up to date
> - case B, skel for some.c is included in prog_tests/other.c:
> - existing other.test.d lists some.skel.h as a dependency;
> - this dependency is not up to date, so other.test.o is rebuilt;
> - test_progs is rebuilt.
>=20
> Do I understand the above correctly?

Yes. This is my understanding as well.

>=20
> An alternative fix would be to specify additional dependencies for
> core_reloc.test.o (and others) directly, e.g.:
>=20
> core_reloc.test.o: test_core_reloc_module.bpf.o ...
>=20
> (with correct trunner prefix)
>=20
> What are pros and cons between these two approaches?

Well, this is a common issue of whether to "include everything" or to
write an explicit list of dependencies.

So far the tests depended on "everything", and the idea of this patch
was to reduce repetitive tests compilation time by leveraging
auto-generated explicit dependencies.

However in the case with dynamically loaded .bpf.o, if we split the
dependency of %.test.d on $(TRUNNER_BPF_OBJS), it's not clear to me
what the benefits of that would be.

I can't think of a situation when all BPF objs have to be rebuilt from
scratch because of this dependency. And it was this way without the
patch too.

The only benefit I can see is that dependencies will be clearly listed
in the makefile. It's a good thing of course, but is it worth the
effort?


On Friday, July 12th, 2024 at 12:52 PM, Andrii Nakryiko <andrii.nakryiko@gm=
ail.com> wrote:

> I don't particularly care. If we don't do that, then we waste some
> effort to specify dependencies manually, just to remove them later. So
> it might be worth it to do a quick switch to <skel>__elf_bytes(),
>=20
> ending up with a better end state earlier. But I don't feel strongly
> about any of this, so it's up to you guys.

If there are plans to eventually migrate all tests to use skels, then
I agree with Andrii that figuring out dependencies would be a wasted
effort.

But then the same can be said about switching to <skel>__elf_bytes(),
right?

I don't mind going over the tests to clear out dependencies or modify
the tests in some way. I just want to be sure it'll be in line with
the project goals. Obviously, I am new to the codebase and don't know
much about anything here, so I'm relying on your input.


