Return-Path: <bpf+bounces-34681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D66D93011A
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 21:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 004D8B219E7
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 19:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F23E2EAE6;
	Fri, 12 Jul 2024 19:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdvJ1J5G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63837381A4
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720813942; cv=none; b=TZdmdWDwIuuGOkkIat0/POElsEt52ek2fNe+r3iFL+cS64Aw1nLe53LRNvUKsOUj8NVRt01Ed0fSJE220i+e5jEyGIDhN18iF3VX0bmETm5aAep4o3Whk7Mk56ok0BAf3/9xkWMYaJEmmJLBbUh9+z5SdkZ7F9vAe+Xw50vLGOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720813942; c=relaxed/simple;
	bh=Oe5PnbKUelMedbuo5c1MkmdVOUZgC4XZDWqn27Vby5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SC+zOY7RWthD7GGr4XTuneo/0VEnEXYuBA6P8xQiSBMKa5mHGL2yHgfj7Q/r0Wnw2cqFXlg7pOUSV44Vqby6wiYfeZRbsJnpyToGut3OWFdSVLgxOSorwpbl9QfkR/ObR3hGuEkhOKqfU0bS1jrfWuThPCA9ChbCKOdkGzeBlgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdvJ1J5G; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6bce380eb96so1581087a12.0
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 12:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720813941; x=1721418741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OrePBhuYms/CwgBq5vAld6yuJ/oWFTcqZal28XGUxQ=;
        b=jdvJ1J5GrIYQIdECdjAtIlgwZgbQMEuf69GssM+zfVzanfVxCK2lfrWUAwjjDw9WLs
         tawZHGIv/CLOahNQigi2kNfP/JHsH2gucCe7P/3GqegVJUthnlm0J031+mOhGOqgeYcD
         U8S9w4ct0FZa8XPTYFjMTKM3ilf/S8u5+ZAZ5ehKLqHXzQQSH0JuV5MxZiPwQS7f47oQ
         D2B+ZMw7jZWZtpiaevHMjO+znpRcb8uu+8auomZBNU0odYrnq3nrNbEDgAtCvOQgp/bw
         sy7Z4O4tiCNxTwmD9p9s6SCkxRS/aJKR4Prra+VO2c9LTByHmBQi3+HdXNrnfi2WP273
         E+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720813941; x=1721418741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OrePBhuYms/CwgBq5vAld6yuJ/oWFTcqZal28XGUxQ=;
        b=o3s3KPpNT2wNqc+ZATHKSDr4zJNZvrzpC0EtehucurP+AHM7ye/fX0kIneFZCCppfq
         xOVPCyUdZrwDAzldShr8wI2FZ2lilDDi9DDSLGr9rAFO/zmxhaSNyT5XwHW0jHE3Ey1H
         b3YT26WnBw16v1g+OLNaCyh9QTezStQuZ1IdYcRx1AUWtkWxcr2YX355ziwsRgc7zZg5
         rY17VVGkJkMqLThWyS5TA5WJ8nPr1e57BH849rf8pYXEPK93fCxT02uIHMB5s35KK4s3
         nqtBZfjp5cETTbJSCUAHLLsZ/l19ZMqq9jwhg1r/jbyu1NLqJ9li5358AhS90iHdmvNY
         FiGA==
X-Forwarded-Encrypted: i=1; AJvYcCW/OF3hec354sRIOdrJZFWRR+2QSzuXabdaypxDlONo+DYefh+kfDxgjfZvBu3suAdUe0JKi5wfulccDXsHM/8REE6S
X-Gm-Message-State: AOJu0YxqYwcIsURTrLeU6uF+d+I6vhuPCoMWOwGgTg8mq+cGP8AMWtL9
	LOyXCZfN3ZWpXzm3cPP5Jfmq2PSQrZ62VWyqIF2k2LNq2q63WXmUBF3JppkPnqMxHHXez10Rnfr
	5hgTxUj37e5C70XEssxTrdQTB/azk3g==
X-Google-Smtp-Source: AGHT+IHO4sVWNDzPlD2cBpfBvTCFQJIXqSFcQnyhYJHVxO68TVmIF7Qr7bjClo5WSHHVz9jkhvvxtm3RHCusDOpVamE=
X-Received: by 2002:a05:6a21:670f:b0:1c2:8bcf:a38e with SMTP id
 adf61e73a8af0-1c29824a910mr13900147637.37.1720813940607; Fri, 12 Jul 2024
 12:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <gJIk-oNcUE6_fdrEXMp0YBBlGqfyKiO6fE8KfjPvOeM9sq1eCphOVjbBziDVRWqIZK1gZZzDhbeIEeX41WA34qTz82izpkgG-F6EFTfX4IY=@pm.me>
 <dcbf532f-bf17-bb8c-f798-987bce607e5d@iogearbox.net> <R36QrBuK6nQziAeE9Xb-8295ISr8B1ofPVAdWaR3rygfaDiHUl2I5EmG2xoCrEskurmOmclGak3JXWwxso43KR9M1LHsdOIt48XS6xe3PVI=@pm.me>
 <4d757f19ac6f7e17da2e87f482f129e75c6decf8.camel@gmail.com>
 <CAEf4BzY4kXRSci3Lb6ZFT7++6fics-w4_8rYMB4vCEHgrCWEnQ@mail.gmail.com> <b97340645b9a730df46e69b03b3ccba39816c414.camel@gmail.com>
In-Reply-To: <b97340645b9a730df46e69b03b3ccba39816c414.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 12 Jul 2024 12:52:08 -0700
Message-ID: <CAEf4BzYFad_hhk+ju1_Y+JeDGmOeD-Ur=+Yvfu2vkbR3frR6SQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: use auto-dependencies for test objects
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, Daniel Borkmann <daniel@iogearbox.net>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, 
	"andrii@kernel.org" <andrii@kernel.org>, "mykolal@fb.com" <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 12:47=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Fri, 2024-07-12 at 12:20 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > > An alternative fix would be to specify additional dependencies for
> > > core_reloc.test.o (and others) directly, e.g.:
> > >
> > >     core_reloc.test.o: test_core_reloc_module.bpf.o ...
> > >
> > > (with correct trunner prefix)
> >
> > I was about to say that not all tests use BPF skeleton headers just
> > yet, so we have to have a way to explicitly specify dependencies. I
> > think a separate list should be good enough for now, and in parallel
> > we should try to switch remaining tests to skeleton headers. Even if
> > we don't want to convert tests themselves to using skeleton structs,
> > we can convert them to use elf_bytes from skeleton headers instead of
> > loading .bpf.o files from disk. That should eliminate the need for
> > extra dependencies.
>
> For the scope of this patch-set, I'd say specifying dependencies
> in the Makefile should be ok.
> Or would you prefer migrating tests to use elf bytes?

I don't particularly care. If we don't do that, then we waste some
effort to specify dependencies manually, just to remove them later. So
it might be worth it to do a quick switch to <skel>__elf_bytes(),
ending up with a better end state earlier. But I don't feel strongly
about any of this, so it's up to you guys.

>
> [...]

