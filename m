Return-Path: <bpf+bounces-34677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1F99300AB
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 21:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D09B1C21183
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 19:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74101CD25;
	Fri, 12 Jul 2024 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYuhSCO2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102201B5AA
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 19:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720811186; cv=none; b=nrnexHv2D/avzxOmWZjpaw6YushYFu//Tx4I7jBXfJ2TCoQcCGNEly16fGHKc6ceRNEYZ9bJsGaFm8OLmDenccZBtXpUmXLc8J+aU/Imm+FrIhvLo24dUhMB3ZGON6OKCxk6rMDwINE1pKVZNQ+zsRaEoKKvCX0l+82gFXqk6ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720811186; c=relaxed/simple;
	bh=wnbk/zbjeaLI7nG8Y8cE2LkM1OYl79tdhPVq0vFruFg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dyJQxiRmStDBanOpbki2FsSgj50mKH21rcTlBImTfHf1VFQUAE16twMdS8S/oLHaY4+jxYhhBmtZIJn0zvC8G9hVXH0LshZ+6y7ja/Hbq1QP4c0qA7RAnGddbMjA2Ul/gv9N/1hK76CHUGRhBGPgqJ61xkX73KCOH8qO5dhVtWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYuhSCO2; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70b31272a04so2289226b3a.1
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 12:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720811184; x=1721415984; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KjOqzpd2he2vxfaZJpLnesbgzl+RXmalhPYwgKWYnzg=;
        b=YYuhSCO25+H6KQ0IlkNKmIgNE05V9x8/vZ/wY2S0R9HD5LM8UrYiD+yW0R4ymX0JE4
         pgOPd22mtRc8q0LUzPB8mwlnrn/y8JkXWyylhmZX1qhnlT2JTl05yBk4w40Ytat5D9lF
         DC6v2whtTyZN4K65BR562+XdotWvSj6z7kWqsFmpdQCt+TyMVDt4TV83pbl+4K++yRGW
         39km4OIY58p7LMyxROFUlhAXkB2e3cGBX2KjiKlYmRNsCHTJc/I5yBZfrGJe3WBjVcQ5
         pF+AWBYVPfTY5ZCSXBvWG0PtgGlfac1j65pSULTbrUGBUFO6H2U803rT7mseHYrDxbE2
         6VGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720811184; x=1721415984;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KjOqzpd2he2vxfaZJpLnesbgzl+RXmalhPYwgKWYnzg=;
        b=K32Qd2uZ2u98RwDD06bLwwQiOZzzz8SE1tPpG4r48fJ3li4qcdKQpQs7AUMVWrpl91
         yxhYJNQkPwuxd1/Q4PFRLzRVbkBY3AbXY752eV3KJiI6taoF1JIJ9QZ9XpL2z8dPec3M
         EXj7MTsa+MfuUl+7b6o9pqKPdRN1y5W9mST1E65zYLb8eScCoTqgdOO+gjapd8mI9jzp
         vdIasZzLae+EH6ib1kKkzOlFAh8JQa705ypMHjWUXmJ3fDBD1ij1EZxQXZFBkdL8ElZQ
         mcUx2S8amwpQOamGeEBv6x6ByxkhncNEi7CZLlzoLRGW1pQySf/S97QJywg/Q+jgcx1I
         cZEg==
X-Gm-Message-State: AOJu0YwE4BTObr2uA6Uv/QN6p3/3qXCd+gxJZVx6A7BEjZukNT5/Wa9H
	NM1u9x/8iCngf1Q7jG7aLAHIO7KHCs7qK3qcQ7o/fylfISYpLtiGmOGG8Q==
X-Google-Smtp-Source: AGHT+IHFc0zqUpDO7qzhTdcXmsr30vEROF4SQd+FcqNN9RCMXdzsc7ABbNah00AMDSwFHT6XRR0TJw==
X-Received: by 2002:a05:6a20:158b:b0:1c0:ebca:964b with SMTP id adf61e73a8af0-1c3beb1622dmr5038230637.23.1720811184085;
        Fri, 12 Jul 2024 12:06:24 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438eb784sm8078751b3a.95.2024.07.12.12.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 12:06:23 -0700 (PDT)
Message-ID: <4d757f19ac6f7e17da2e87f482f129e75c6decf8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: use auto-dependencies for
 test objects
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, Daniel Borkmann
 <daniel@iogearbox.net>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org"
 <ast@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>, "mykolal@fb.com"
 <mykolal@fb.com>
Date: Fri, 12 Jul 2024 12:06:18 -0700
In-Reply-To: <R36QrBuK6nQziAeE9Xb-8295ISr8B1ofPVAdWaR3rygfaDiHUl2I5EmG2xoCrEskurmOmclGak3JXWwxso43KR9M1LHsdOIt48XS6xe3PVI=@pm.me>
References: 
	<gJIk-oNcUE6_fdrEXMp0YBBlGqfyKiO6fE8KfjPvOeM9sq1eCphOVjbBziDVRWqIZK1gZZzDhbeIEeX41WA34qTz82izpkgG-F6EFTfX4IY=@pm.me>
	 <dcbf532f-bf17-bb8c-f798-987bce607e5d@iogearbox.net>
	 <R36QrBuK6nQziAeE9Xb-8295ISr8B1ofPVAdWaR3rygfaDiHUl2I5EmG2xoCrEskurmOmclGak3JXWwxso43KR9M1LHsdOIt48XS6xe3PVI=@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-12 at 17:48 +0000, Ihor Solodrai wrote:

[...]

> I've made a mistake when I removed $(TRUNNER_BPF_OBJS) as a
> prerequisite for $(TRUNNER_TEST_OBJS:.o=3D.d)
>=20
> I assumed it is covered by:
>=20
>   $(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
>=20
> Apparently there are .bpf.o files for which skels are not generated,
> yet they are used in tests.
>=20
> Fixed in v3.

So, bear with me for a moment please.
We have 3 test_progs/smth.c files that depend on a few .bpf.o files at runt=
ime,
but do not include skel files for those .bpf.o, namely:
- core_reloc.c
- verifier_bitfield_write.c
- pinning.c

And we fix this by adding a dependency:

    $(TRUNNER_TEST_OBJS:.o=3D.d): ... $(TRUNNER_BPF_OBJS)

Which makes all *.test.d files depend on .bpf.o files.
Thus, if progs/some.c file is changed and `make test_progs` is requested:
- because *.test.d files are included into current makefile [1],
  make invokes targets for *.test.d files;
- *.test.d targets depend on *.bpf.o, thus some.bpf.o is rebuilt
  (but only some.bpf.o, dependencies for other *.bpf.o are up to date);
- case A, skel for some.c is not included anywhere (CI failure for v2):
  - nothing happens further, as *.test.d files are unchanged *.test.o
    files are not rebuilt and test_progs is up to date
- case B, skel for some.c is included in prog_tests/other.c:
  - existing other.test.d lists some.skel.h as a dependency;
  - this dependency is not up to date, so other.test.o is rebuilt;
  - test_progs is rebuilt.

Do I understand the above correctly?

An alternative fix would be to specify additional dependencies for
core_reloc.test.o (and others) directly, e.g.:

    core_reloc.test.o: test_core_reloc_module.bpf.o ...

(with correct trunner prefix)

What are pros and cons between these two approaches?

[1] https://make.mad-scientist.net/constructed-include-files/

