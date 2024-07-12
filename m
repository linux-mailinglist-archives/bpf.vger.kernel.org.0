Return-Path: <bpf+bounces-34678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6A89300C6
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 21:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16090B21D58
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 19:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C0C208D1;
	Fri, 12 Jul 2024 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McX/Q+L3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C26B1B95B
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720812046; cv=none; b=sFKfv6elTWm9Mil1OptPNTRqM1QVhxrcprJ2H/HVzmSSQA3j8dRWzhHkVNCDDyICKaDRGkPOVXRlE9PwYKMa1f6etRKdXujbz5P3MyWK2FoOnVzpYIPXTodzt6mFy+Ac4tBPeowppueTkvp/JrhqVyBZ7hJlSXR/TFhXxA89CeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720812046; c=relaxed/simple;
	bh=VtCisGjNiGN04m1B2hta6l7DT1Q73BI3bJCPZdrjW98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OqT2ftXR06GI7qgaXe0YJppsV11+AzIO9wV55dbqqTkswXh2f0OFqQPVD6Qm/1JVkESMMBBNSrN1cT8roi2cCODggqNfkAbPMJOJLaRX9c1IQJGufCI/HvsY340KoUcRaNSM50hOln/tLoVrlvEYUW5i+LqFS0GqeGG9MLaofSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McX/Q+L3; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ca8dfa2cceso1806975a91.2
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 12:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720812045; x=1721416845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzAJv6ImE6mvT6eBAHtmTGyc0qqSnVqG2hm/gCDqIJc=;
        b=McX/Q+L3lptHmw6+pKnQjFvYDI2zVHuw8kiIVqvyvOkyhSe2mAAUWpKjQD5cIGvn4u
         wT/Mr0lVVH/idq9njnrt/rFAKxV/t7qBr3Iaor6C7Ih+Ldiaq7AbFGR6U7u0pb2Xs9ns
         kynaJGQiQdutr1nnUfVDGzXJjcrwiT9HICHz1MGv7P4cjHPPKGdnX6Nct9tJZVCIOJhL
         LyK3VQnd4bsDch7PHBlaKUezuUpzU+AXIg05re5JTZ43745xRKptnXNMogBx9lHcxaPU
         7bKSGKOW+HJg9VNTm+GocBujvvviLiH3TpRZ+E54t7DHkP/T9LAzCwtumwDWnT5yFp5Q
         IX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720812045; x=1721416845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzAJv6ImE6mvT6eBAHtmTGyc0qqSnVqG2hm/gCDqIJc=;
        b=SdgFu+p0EZ3a1QA/KQvPM4Jie77CoBCVp3Qd+X/E1J4v0ybrHjAkIDM6zfdM2B+qdE
         Lb2eVE0MrVifn5GEY0GWV0XlEZaPMSlbeSfXjmTS8N4jNg3IMJ5mT2EHFaF0hG8AWxrN
         rCzCxe9cT+090Ea510yfszdcRVkFISYJcXCDI0uVSYKlCdxhUueFfDrdgaxvD7rBDrqW
         040YNvjBLRn4hZKWB9GJPm95OYgCKokC3OnxAgEst4Srz7oWOkE7hJinQx2QtROPftqw
         Z5sCvL66twFc2funTeBCwlqsJvnK7e2xUYg6M4AI/Q5zMwG6L/AVO8hgH2knzhlta2sg
         zZ1w==
X-Forwarded-Encrypted: i=1; AJvYcCVHF+yA8UYGn2r8ruZ6gOzwTNdxDjx/SzY2UuSBGUuyOc/+E9WGv2DOrsV0TLqXUGoI5MqJ1mlQ+/2gc3hoRhy0v4vF
X-Gm-Message-State: AOJu0YyjFz1GfyKOGC7K2AdanFwli2u0goxG52Y6Wvg8YzIjV3a1Lmep
	VhRcQcN/upRHESqnAEjojsPZ8WS6R1PGotcvrqbsJGYyKWiC7bcLzUXCkhZQSLfoZJA4bRezA1h
	q101cJQ+IqG45lXy9K5IDRjycMsE=
X-Google-Smtp-Source: AGHT+IFiTZg/qY6OgImEeonp3bmzAHdKordKBZaoN+Et3brRKa6VshdLCtBajJW56nUVbFAGzKoUVjk5xR8I3LUQJl8=
X-Received: by 2002:a17:90b:1243:b0:2c3:7e3:6be0 with SMTP id
 98e67ed59e1d1-2ca35d4b167mr10468077a91.31.1720812044624; Fri, 12 Jul 2024
 12:20:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <gJIk-oNcUE6_fdrEXMp0YBBlGqfyKiO6fE8KfjPvOeM9sq1eCphOVjbBziDVRWqIZK1gZZzDhbeIEeX41WA34qTz82izpkgG-F6EFTfX4IY=@pm.me>
 <dcbf532f-bf17-bb8c-f798-987bce607e5d@iogearbox.net> <R36QrBuK6nQziAeE9Xb-8295ISr8B1ofPVAdWaR3rygfaDiHUl2I5EmG2xoCrEskurmOmclGak3JXWwxso43KR9M1LHsdOIt48XS6xe3PVI=@pm.me>
 <4d757f19ac6f7e17da2e87f482f129e75c6decf8.camel@gmail.com>
In-Reply-To: <4d757f19ac6f7e17da2e87f482f129e75c6decf8.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 12 Jul 2024 12:20:32 -0700
Message-ID: <CAEf4BzY4kXRSci3Lb6ZFT7++6fics-w4_8rYMB4vCEHgrCWEnQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: use auto-dependencies for test objects
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, Daniel Borkmann <daniel@iogearbox.net>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, 
	"andrii@kernel.org" <andrii@kernel.org>, "mykolal@fb.com" <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 12:06=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Fri, 2024-07-12 at 17:48 +0000, Ihor Solodrai wrote:
>
> [...]
>
> > I've made a mistake when I removed $(TRUNNER_BPF_OBJS) as a
> > prerequisite for $(TRUNNER_TEST_OBJS:.o=3D.d)
> >
> > I assumed it is covered by:
> >
> >   $(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT=
)
> >
> > Apparently there are .bpf.o files for which skels are not generated,
> > yet they are used in tests.
> >
> > Fixed in v3.
>
> So, bear with me for a moment please.
> We have 3 test_progs/smth.c files that depend on a few .bpf.o files at ru=
ntime,
> but do not include skel files for those .bpf.o, namely:
> - core_reloc.c
> - verifier_bitfield_write.c
> - pinning.c
>
> And we fix this by adding a dependency:
>
>     $(TRUNNER_TEST_OBJS:.o=3D.d): ... $(TRUNNER_BPF_OBJS)
>
> Which makes all *.test.d files depend on .bpf.o files.
> Thus, if progs/some.c file is changed and `make test_progs` is requested:
> - because *.test.d files are included into current makefile [1],
>   make invokes targets for *.test.d files;
> - *.test.d targets depend on *.bpf.o, thus some.bpf.o is rebuilt
>   (but only some.bpf.o, dependencies for other *.bpf.o are up to date);
> - case A, skel for some.c is not included anywhere (CI failure for v2):
>   - nothing happens further, as *.test.d files are unchanged *.test.o
>     files are not rebuilt and test_progs is up to date
> - case B, skel for some.c is included in prog_tests/other.c:
>   - existing other.test.d lists some.skel.h as a dependency;
>   - this dependency is not up to date, so other.test.o is rebuilt;
>   - test_progs is rebuilt.
>
> Do I understand the above correctly?
>
> An alternative fix would be to specify additional dependencies for
> core_reloc.test.o (and others) directly, e.g.:
>
>     core_reloc.test.o: test_core_reloc_module.bpf.o ...
>
> (with correct trunner prefix)

I was about to say that not all tests use BPF skeleton headers just
yet, so we have to have a way to explicitly specify dependencies. I
think a separate list should be good enough for now, and in parallel
we should try to switch remaining tests to skeleton headers. Even if
we don't want to convert tests themselves to using skeleton structs,
we can convert them to use elf_bytes from skeleton headers instead of
loading .bpf.o files from disk. That should eliminate the need for
extra dependencies.


>
> What are pros and cons between these two approaches?
>
> [1] https://make.mad-scientist.net/constructed-include-files/
>

