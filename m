Return-Path: <bpf+bounces-21693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6207F8502E3
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 08:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0349C1F23966
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 07:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE20C16435;
	Sat, 10 Feb 2024 07:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZRldGd8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06DF12E7B
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 07:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707548624; cv=none; b=HUMWWHUOBfMgqs3uSFCIi1Lp7KFcQKoaxL4OJV2/YOluVN31dXZ6SaNi5Zttab9KEOjvnSGA0ZpgXrnIlcW9ldTTYJUY4bT+ncD9qdkkJaiO3aPd62uFXZ934x4O240XJa2Dtc+AyTiODenPuI1E3VyDiZUGnO40w1tMpqw2LWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707548624; c=relaxed/simple;
	bh=dY4bAgmiPdR3pX90/8kcNfhDxfuMVD8H6PrgM0fXk5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sov/QmTXvIlln/kKU63ArYa9b4XBaTd4r/bzbZseHPMxyrVLfbmwtpmOiccDdkU0pfgOJKv89GnyOdS4qa4sLV8ok/NSSQxbUz0bEMPUSTsd7DLCew7FgCNudYWIPDN1XRV5TVobPMc89/OQJDXxiQs0D9MPe9KNnnoFmK7KaRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZRldGd8; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-561587ce966so1151078a12.1
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 23:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707548621; x=1708153421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dY4bAgmiPdR3pX90/8kcNfhDxfuMVD8H6PrgM0fXk5c=;
        b=kZRldGd8JQBlyWzaDMmQCQtBXagfs88Gvhgp9hseAKmgWDgxxuZm3vQu49Kcbokbu+
         bYu/MZs7uEebYBAUNVinx5H56BikYHgN4/yOZAx1UuFLJcON3ag/0U74xgEI8cC2kLrY
         F5IkDAPO3M1dlObCd5DYahqq+tSA8+YFvIidXXPbBvDBm8QGJg+8NK2kGPBzYnXq3C9I
         HmTL0/1S494dGnySkn0pyW+EUISrZczIqe/O5OHw1qTa6sc37HH8pqq6MmQtRg3OcIa8
         qnPmQFu/RS5zxQ7Rtk3eL7ZXGXcKmG6Nn4AL24/WDCtxp87/EYdfbNjWlyp2Spzsgco8
         Edfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707548621; x=1708153421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dY4bAgmiPdR3pX90/8kcNfhDxfuMVD8H6PrgM0fXk5c=;
        b=JofpcaItczySrrOuMJlbGwNiFx919SO7151sLU6S/ZxnMV1TLC6efwfPKfYVz+Sj+q
         MhlIITH6UKMBMvhHar7b3xIvKjTCFhIUJ/fLOo/wTGiIWJqSdHBYEOtrZl9xRrL5yqc5
         dGjmZ3kolMmyITsanSMARaZx5S9DRyCMtM1gfUNNrIX7gUJd+FoqpQq5I1dJGa3R/H2Y
         q0tUdvI5Z12jxONzaRKrlvre1TQx1++7H4u1/NVvM6T2vmuP9GsjoyaxoVCNFRCzIIAP
         9GUuzrzajVLfmw2AGFaYevLtBMln4TQjWsqhyvWLwQByG/r+/maJ4m7o0Xjvltp0zP1h
         YCsQ==
X-Gm-Message-State: AOJu0Yw6xu+4hDaBG1J6jm6dkwek79thVrMdbh0aHWofjHAMylm+qW/M
	m3XYTd6dO+n049aeDUjxQzok1h+QuOTQ/DaqgmJZ2tZ62RDxjLJiJPV0VgWL/XcZuH807nwBsYi
	NHRh2zpOQUKIxSl9ke438yoDZ7IM=
X-Google-Smtp-Source: AGHT+IE0rdJyg8Tk3BWL1yiBubD/Dr7uxRA6OE/CslCveFezFgZR/Uab1Yot7fUO0bEYDKx+47yUMMNlfZceAyKpMjc=
X-Received: by 2002:aa7:ccc6:0:b0:561:2f3b:7213 with SMTP id
 y6-20020aa7ccc6000000b005612f3b7213mr1089783edt.13.1707548619999; Fri, 09 Feb
 2024 23:03:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-18-alexei.starovoitov@gmail.com> <20240209231433.GE975217@maniforge.lan>
 <CAADnVQJsdbUuvkp67_z5xprA+UP=O9rTcwm3xRkpqSArrGqNaA@mail.gmail.com>
In-Reply-To: <CAADnVQJsdbUuvkp67_z5xprA+UP=O9rTcwm3xRkpqSArrGqNaA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 10 Feb 2024 08:03:03 +0100
Message-ID: <CAP01T75qCUabu4-18nYwRDnSyTTgeAgNN3kePY5PXdnoTKt+Cg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 17/20] selftests/bpf: Add unit tests for bpf_arena_alloc/free_pages
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Vernet <void@manifault.com>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 10 Feb 2024 at 05:35, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Feb 9, 2024 at 3:14=E2=80=AFPM David Vernet <void@manifault.com> =
wrote:
> >
> > > +
> > > +#ifndef arena_container_of
> >
> > Why is this ifndef required if we have a pragma once above?
>
> Just a habit to check for a macro before defining it.
>
> > Obviously it's way better for us to actually have arenas in the interim
> > so this is fine for now, but UAF bugs could potentially be pretty
> > painful until we get proper exception unwinding support.
>
> Detection that arena access faulted doesn't have to come after
> exception unwinding. Exceptions vs cancellable progs are also different.

What do you mean exactly by 'cancellable progs'? That they can be
interrupted at any (or well-known) points and stopped? I believe
whatever plumbing was done to enable exceptions will be useful there
as well. The verifier would just need to know e.g. that a load into
PTR_TO_ARENA may fault, and thus generate descriptors for all frames
for that pc. Then, at runtime, you could technically release all
resources by looking up the frame descriptor and unwind the stack and
return back to the caller of the prog.

> A record of the line in bpf prog that caused the first fault is probably
> good enough for prog debugging.
>

I think it would make more sense to abort the program by default,
because use-after-free in the arena most certainly means a bug in the
program.
There is no speed up from zeroing faults, it only papers over
potential problems in the program.
Something is being accessed in a page that has since been unallocated,
or the pointer is bad/access is out-of-bounds.
If not for all UAFs, especially for guard pages. In that case it is
100% a problem in the program.
Unlike PROBE_MEM where we cannot reason about what kernel memory
tracing programs may read from, there is no need for a best-effort
continuation here.

Now that the verifier will stop reasoning precisely about object
lifetimes unlike bpf_obj_new objects, all bugs that happen in normal C
have a possibility of surfacing in a BPF program using arenas as
heaps, so it is more likely that these cases are hit.

> [...]

