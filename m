Return-Path: <bpf+bounces-34937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173C79334C3
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 02:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48BBC1C225E7
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 00:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E54FEDC;
	Wed, 17 Jul 2024 00:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="VRmas4vc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51129EC5
	for <bpf@vger.kernel.org>; Wed, 17 Jul 2024 00:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721176616; cv=none; b=D6vnPpQc3WzcAe4tJbmzSnqnk9vmqTPLnO7nwLdohZAF3aa1Yp8DtPHKqacNZ/SRmjzBogdea+yZ53WUxn4Fihwm9iHGg4vB1yeA3S8GWNmiCPoxqhllAE1aiZcedE63PPHkE3o5v4qeqWKi5ksgp1v7XlVwS3Y7jxasmC/YZsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721176616; c=relaxed/simple;
	bh=SiG+ybYWYn3f0uXUJ7ZdRpzfXHRaVGg7Th7ZpFl4oXA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TfbSp8kMHqJQo3n0V/NmN6eg3D0ScrGiw9TFkCIMmfJ1RPycwsWmIQcGF9uFfKNuBeHm+yPmqvoRyfeChoikqJ8F7HSZBepNDTV8eFVhlGDWD1EyLvnAieu8LHgInDyC+QIo4NkPdiuqTVx6/iu7xGP/2XmPfL8rbu0x1DFGtiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=VRmas4vc; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1721176606; x=1721435806;
	bh=9h3beaJR1eqw51XOuwx3NdlPir+wzyJrFCw31HF+kXM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VRmas4vcmO8yNE9Kzi7RBpATf+VKGnkIS5SFU/LoX+EryTQcLwfTsfn3T4hjDuR8I
	 0B+ujIPGRH1UyVrSgW/XCbmRJ8LANypuVhNzDpdybTwA/eIrLwtfMP6FL+aqxogswp
	 1eBHqTaeFasWZId/XhlFeHzaj8ONaHdr8g8irmtGoibwl30k/Ckwv7MFeBhghNmod4
	 +y585UV4GhIE+fSJ53eOKErE0AhTDkKc8bek3f1GX53JDaj3wbGTX66sCgah2aChDA
	 ralaH0ILFeHB5gpmQ/yrDJAXf5hjHDqAbFedNvERVQ3fV5xL/9uV2DMKDWKWiAXPbA
	 zYJBuede1Th0w==
Date: Wed, 17 Jul 2024 00:36:44 +0000
To: Eduard Zingerman <eddyz87@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>, "mykolal@fb.com" <mykolal@fb.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: use auto-dependencies for test objects
Message-ID: <erDl1cz7tCQTTy5Z2SJzdqYmOTcoUjvgaU4m6Nq2ZlbMvUQxP0xnS2y90zhgQUQm6ygMN9dZdnXiiQrRkaia4WsX9E2wULrvngXmeTTggNU=@pm.me>
In-Reply-To: <bcee1451ef43fd08675e1296b1ce82058cd29d94.camel@gmail.com>
References: <gJIk-oNcUE6_fdrEXMp0YBBlGqfyKiO6fE8KfjPvOeM9sq1eCphOVjbBziDVRWqIZK1gZZzDhbeIEeX41WA34qTz82izpkgG-F6EFTfX4IY=@pm.me> <dcbf532f-bf17-bb8c-f798-987bce607e5d@iogearbox.net> <R36QrBuK6nQziAeE9Xb-8295ISr8B1ofPVAdWaR3rygfaDiHUl2I5EmG2xoCrEskurmOmclGak3JXWwxso43KR9M1LHsdOIt48XS6xe3PVI=@pm.me> <4d757f19ac6f7e17da2e87f482f129e75c6decf8.camel@gmail.com> <CAEf4BzY4kXRSci3Lb6ZFT7++6fics-w4_8rYMB4vCEHgrCWEnQ@mail.gmail.com> <b97340645b9a730df46e69b03b3ccba39816c414.camel@gmail.com> <CAEf4BzYFad_hhk+ju1_Y+JeDGmOeD-Ur=+Yvfu2vkbR3frR6SQ@mail.gmail.com> <k7SpuAM7weZyfgdgXEHzOiDkk8iBsBrl7ZsTpvhKQNvijS8cWjJrBN9DVOxF45edRXxA2POvIu9cZce3bF2FmoFOEbfevr09X-1c1pKgZrw=@pm.me> <CAEf4Bzatg_CsKf7HeekaO3ZroXWg1ceJBgZ9KPWf2VkK1yKQ6Q@mail.gmail.com> <bcee1451ef43fd08675e1296b1ce82058cd29d94.camel@gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: e07cbd846ba72a92e8ecc09244d397a93ec8f34f
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, July 16th, 2024 at 4:21 PM, Eduard Zingerman <eddyz87@gmail.com=
> wrote:

[...]

> The catch-all clause in the current makefile looks as follows:
>=20
> $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o: \
> $(TRUNNER_BPF_PROGS_DIR)/%.c \
> $(TRUNNER_BPF_PROGS_DIR)/*.h \
> ...
>=20
> This makes all .bpf.o files dependent on all BPF .c files.
> .bpf.o files rebuild is the main time consumer, at-least for me.

I might be nit-picking, but just so it's clear this target makes each
individual %.bpf.o dependent on corresponding progs/%.c, and also on
all the headers (because of *.h).

I don't think we can easily remove/replace the $(TRUNNER_BPF_OBJS)
target, as it also defines a compilation recipe for .bpf.o files.

>=20
> I think that simply replacing this catch all by something like:
>=20
> $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_BPF_OBJS)
>=20

Using a catch-all dependency (each %.test.o depends on *all* .bpf.o)
is the current state of the Makefile, without the auto-dependencies
patch:

$(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:=09=09=09\
=09=09      $(TRUNNER_TESTS_DIR)/%.c=09=09=09=09\
=09=09      $(TRUNNER_EXTRA_HDRS)=09=09=09=09\
=09=09      $(TRUNNER_BPF_OBJS)=09=09=09=09\  # this line
=09=09      $(TRUNNER_BPF_SKELS)=09=09=09=09\
   ...

In the v3 of the patch this dependency simply moved, such that each
%.test.d file depends on *all* %.bpf.o, so essentially nothing changed
there.

So what we've been discussing so far is whether it's worth spending
effort on removing/replacing this dependency, and how.

Eduard's point about simplification of test cases seems reasonable.
However it looks to me that whatever way of handling direct .bpf.o
dependencies we might agree on, it would lead to an independent patch
series.

And settling on catch-all solution (even "for now") means settling on
v3 of the patch.



