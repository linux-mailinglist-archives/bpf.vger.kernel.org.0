Return-Path: <bpf+bounces-34938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8159334DD
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 02:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34F7A283376
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 00:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA3DEDF;
	Wed, 17 Jul 2024 00:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEn4/8TX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F047EC7
	for <bpf@vger.kernel.org>; Wed, 17 Jul 2024 00:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721177880; cv=none; b=Q4nBRja+qXBam/+ZQPKpjA0M1dPZdA0jWY83i0mTL8LM2ob18TkJRCF5MHq7lewgr74zNYVdoSV+NeNbiBeuSw4grE2o1N/+VPm/1kesTyiP3JhV0eLcKTRq8U9XRiFF/kgAMSUqJUrc7AiLjB3pprN3bKHD/nYrhsYgVZHkdmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721177880; c=relaxed/simple;
	bh=q4Adue5l9rS2/BYqd4VMglysoy13LZaMPIjSlY9kUII=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dRBEKxzOgozKuKQzPYvbX0scZFSFQSq97WE1jf6qzZBi5Il1c4BuOmr4wEqEic7rKA3EjMRoEEcs4SiuxLFkdrQttQo4q3o5JaU2FK3XSdGC+AD2XorDN7SpQVeIYNPVD8h32rwT4VNG/cgQpMWKbvzWTfdDh95ICRMV8x4+PZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEn4/8TX; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70b09cb7776so4372622b3a.1
        for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 17:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721177878; x=1721782678; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6KG+vCfRExYH4Ss2ZLgZhLveHaLJHAT6MBGIDee7xX0=;
        b=KEn4/8TXA5j9qw2aqqnVpCkVgUUz1MkzUbirxVHjrBJkH+8KqAttdupMsZwc4bRK3H
         uvf2D/YNpoNjjdmFSpQpTFdBzzhJwVW8LfMZC88t6TGAMz/MrVyCag62bHGk0LtGDG9p
         0lAT72Gmsen7jNa5mSd9ljhRvKAQuoMdBqqijzmhp2A8Luvy0lE/pPFXD45t66mLCj9q
         6i6Mg3x/nOZO2qHYbx/jjwIp+vEgkNAV9FEP44fyB12+Oph/1mK3GDbxEFhcPL3lS8Bf
         ztJZOHkYguP+E8VPFGCwqhO+fxjPsaSbe+n6RSDgqZplAS5VOED3dDgLuJpn8g4YN9eb
         tNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721177878; x=1721782678;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6KG+vCfRExYH4Ss2ZLgZhLveHaLJHAT6MBGIDee7xX0=;
        b=lX1YumVyTMm1IBUYjERZ0WbyprFCRyOBXv9QFQkXZAzsKZhsp78Vc4NZGNDkphzySG
         duOnt8wtj7giPPhRJMjD4hvtW27kH8M4AHSp2P3rfHNq2n77XgnWlhhP9Sq61qC1JTgs
         xhqWPDLGiphHkDsUEIAd61tihY2Zo41KPnmt8REaA4wXa62a0OUx/ACTQ5Hq3kgtMKrG
         TskTNT6iwrCIEiyiMahT45Ut7pSOetiJnM8OeUbJR8qfW4SQ8oFOQ+5uzvJl1QFea07V
         5BsiU5GelkZY1brpARaQr8lGGW90WXTlUHJVpL+gUnezieWzwQcbMfRe+2G9rgPN+IW9
         tR2A==
X-Forwarded-Encrypted: i=1; AJvYcCUZKH2B+hTr/Qr9+ZvzrNxeOu2TC1AiFk3SfLeTWVwXUbZ92JmL/+WPi+4HNFRPBYr/JrePkC+VUM+W3f1DggQJHTZ6
X-Gm-Message-State: AOJu0Yy1g33jh6opZUmLS4Qqa45VmIO39HCIUZG5QiM4fPb958z5C+pz
	bZAMhGM7JMa394xuzekqWcrvuKJZZRajpVjwhUurf9HR3dXC5S5s
X-Google-Smtp-Source: AGHT+IFdFcChYzsW4cCWqAhufX5z8WiCSm6Is/8fSDeI2D7fOrXKfE04z+Z5WRJtPGErPVc0jJUFww==
X-Received: by 2002:a05:6a00:1403:b0:70a:fdd8:51f2 with SMTP id d2e1a72fcca58-70ce4e17a39mr220873b3a.15.1721177878139;
        Tue, 16 Jul 2024 17:57:58 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eccc1c3sm6939588b3a.208.2024.07.16.17.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 17:57:57 -0700 (PDT)
Message-ID: <d52ab2026b37ac9e19a3181f7b81da1e1afb9365.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: use auto-dependencies for
 test objects
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>,
 "mykolal@fb.com" <mykolal@fb.com>
Date: Tue, 16 Jul 2024 17:57:52 -0700
In-Reply-To: <erDl1cz7tCQTTy5Z2SJzdqYmOTcoUjvgaU4m6Nq2ZlbMvUQxP0xnS2y90zhgQUQm6ygMN9dZdnXiiQrRkaia4WsX9E2wULrvngXmeTTggNU=@pm.me>
References: 
	<gJIk-oNcUE6_fdrEXMp0YBBlGqfyKiO6fE8KfjPvOeM9sq1eCphOVjbBziDVRWqIZK1gZZzDhbeIEeX41WA34qTz82izpkgG-F6EFTfX4IY=@pm.me>
	 <dcbf532f-bf17-bb8c-f798-987bce607e5d@iogearbox.net>
	 <R36QrBuK6nQziAeE9Xb-8295ISr8B1ofPVAdWaR3rygfaDiHUl2I5EmG2xoCrEskurmOmclGak3JXWwxso43KR9M1LHsdOIt48XS6xe3PVI=@pm.me>
	 <4d757f19ac6f7e17da2e87f482f129e75c6decf8.camel@gmail.com>
	 <CAEf4BzY4kXRSci3Lb6ZFT7++6fics-w4_8rYMB4vCEHgrCWEnQ@mail.gmail.com>
	 <b97340645b9a730df46e69b03b3ccba39816c414.camel@gmail.com>
	 <CAEf4BzYFad_hhk+ju1_Y+JeDGmOeD-Ur=+Yvfu2vkbR3frR6SQ@mail.gmail.com>
	 <k7SpuAM7weZyfgdgXEHzOiDkk8iBsBrl7ZsTpvhKQNvijS8cWjJrBN9DVOxF45edRXxA2POvIu9cZce3bF2FmoFOEbfevr09X-1c1pKgZrw=@pm.me>
	 <CAEf4Bzatg_CsKf7HeekaO3ZroXWg1ceJBgZ9KPWf2VkK1yKQ6Q@mail.gmail.com>
	 <bcee1451ef43fd08675e1296b1ce82058cd29d94.camel@gmail.com>
	 <erDl1cz7tCQTTy5Z2SJzdqYmOTcoUjvgaU4m6Nq2ZlbMvUQxP0xnS2y90zhgQUQm6ygMN9dZdnXiiQrRkaia4WsX9E2wULrvngXmeTTggNU=@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-17 at 00:36 +0000, Ihor Solodrai wrote:
> On Tuesday, July 16th, 2024 at 4:21 PM, Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
>=20
> [...]
>=20
> > The catch-all clause in the current makefile looks as follows:
> >=20
> > $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o: \
> > $(TRUNNER_BPF_PROGS_DIR)/%.c \
> > $(TRUNNER_BPF_PROGS_DIR)/*.h \
> > ...
> >=20
> > This makes all .bpf.o files dependent on all BPF .c files.
> > .bpf.o files rebuild is the main time consumer, at-least for me.
>=20
> I might be nit-picking, but just so it's clear this target makes each
> individual %.bpf.o dependent on corresponding progs/%.c, and also on
> all the headers (because of *.h).

On current master touch progs/verifier_and.c leads to complete rebuild
of all bpf.o and test.o files. And here is one of the targets:

$ make test_progs -p | grep tools/testing/selftests/bpf/sockmap_listen.test=
.o: | tr ' ' '\n' | head
/home/eddy/work/bpf-next/tools/testing/selftests/bpf/sockmap_listen.test.o:
prog_tests/sockmap_listen.c
flow_dissector_load.h
ip_check_defrag_frags.h
/home/eddy/work/bpf-next/tools/testing/selftests/bpf/access_map_in_map.bpf.=
o
/home/eddy/work/bpf-next/tools/testing/selftests/bpf/arena_atomics.bpf.o
/home/eddy/work/bpf-next/tools/testing/selftests/bpf/arena_htab_asm.bpf.o
/home/eddy/work/bpf-next/tools/testing/selftests/bpf/arena_htab.bpf.o
/home/eddy/work/bpf-next/tools/testing/selftests/bpf/arena_list.bpf.o
/home/eddy/work/bpf-next/tools/testing/selftests/bpf/async_stack_depth.bpf.=
o
17:57:16 bpf$ make test_progs -p | grep tools/testing/selftests/bpf/sockmap=
_listen.test.o: | tr ' ' '\n' | grep bpf\.o | wc -l
760

> I don't think we can easily remove/replace the $(TRUNNER_BPF_OBJS)
> target, as it also defines a compilation recipe for .bpf.o files.

I don't think removing $(TRUNNER_BPF_OBJS) was suggested in the thread.

> > I think that simply replacing this catch all by something like:
> >=20
> > $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_BPF_OBJS)
> >=20
>=20
> Using a catch-all dependency (each %.test.o depends on *all* .bpf.o)
> is the current state of the Makefile, without the auto-dependencies
> patch:
>=20
> $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
> 		      $(TRUNNER_TESTS_DIR)/%.c				\
> 		      $(TRUNNER_EXTRA_HDRS)				\
> 		      $(TRUNNER_BPF_OBJS)				\  # this line
> 		      $(TRUNNER_BPF_SKELS)				\
>    ...

Yes, sure, but this is bad, because it forces rebuild of all .test.o files.
Having auto-dependencies allows to get rid of this.

> In the v3 of the patch this dependency simply moved, such that each
> %.test.d file depends on *all* %.bpf.o, so essentially nothing changed
> there.
>=20
> So what we've been discussing so far is whether it's worth spending
> effort on removing/replacing this dependency, and how.
>=20
> Eduard's point about simplification of test cases seems reasonable.
> However it looks to me that whatever way of handling direct .bpf.o
> dependencies we might agree on, it would lead to an independent patch
> series.
>=20
> And settling on catch-all solution (even "for now") means settling on
> v3 of the patch.

I don't like .test.d dependency on all .bpf.o files (the v3 change)
as it does not encode the dependency we have:
test_progs depends on core_reloc.bpf.o at runtime.

