Return-Path: <bpf+bounces-21914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF48853FEF
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 00:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96A0DB21FA4
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 23:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BF762A10;
	Tue, 13 Feb 2024 23:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9rIYpS0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEE462A02
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 23:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866362; cv=none; b=UrueRdHkfyhQhWrmmIvcrxHXuSQ2pnzE5bOVyNS5wkE7xoCWWqoLqIWoBBm0IlUIIoGeFfdxQN3Dx5BvZL2jWt+snb18VXOMK4xSMhALL8WzAnbz9bfmkXhbyhqqUxau0ky0oaaUKT4wajVqk1DDacCHWA8ASwFPkUw6jNqnHWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866362; c=relaxed/simple;
	bh=kt6s6Ej8MuqAWc5N8F6CKBIyyqaP8ka39LFQocmEaRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PveH04VVWkUkQqaokxHkHvU+KWUufzuKpvQBYsITg2ZFyMVjTcWfpF8L3pERltQ1VG5uNVv3Je6U0psFjAB93x98MD3hMtKtEfkF2i9HxqxhzwBgr9hHxs/igoho1ag5SlvYs6EqM35qmv/US8HWLT2KCH9/kKurA4LGuMT0WVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9rIYpS0; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3394ca0c874so3319100f8f.2
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 15:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707866359; x=1708471159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kt6s6Ej8MuqAWc5N8F6CKBIyyqaP8ka39LFQocmEaRA=;
        b=P9rIYpS0K7wYFs2Nn8Ihqx33EbP7wqhITKKyYnUp92YCsoIggD7xW9Pl2W1Ql+7drX
         GQkQTsq1mBPQOjwwD9NVoQZ/ngCTYzk10eyTFa4/PLtfug1aIvrXx6CbO4zRsEpjSJNN
         acVckeCdyL+nR0dXy/nplZWwyPRU982kn7/yuAP+itxaHRW1CpcfsmuknlsOjJsnDy7y
         r9HKnAOx1o0dbQu2QX8VKvZ0AhFxOFX0gh+y+KZLSjE3+GXLz2sXAnaz4EvqXXazkUHZ
         NFUmiUIhHOfOhPmNDNhy25yhbXn8Qysb6gl74+fnjVXwVE9MCzYJPgTLHHjFNpDL7nsY
         ZciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707866359; x=1708471159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kt6s6Ej8MuqAWc5N8F6CKBIyyqaP8ka39LFQocmEaRA=;
        b=fsQlnkwis345EDm/wBIqrMZ0xSFOMTEJiFzhJ3acunIHcfq5dL7M0vdnsWUrPpSx3W
         FIAcY86R9TGW1oP21EUo94fT3vKeo+DXLwXPUdRa+B/ixzNyFBHv0a+TI57QLE/A4l/t
         9uhHYbBQ/VSPO6YhZ4dCOps5Sw+cNQAgA2Z436GP+oL4JnSACEPVEk7T1Z9GbFluUHvk
         Cnml6pAbcVTkUWnmevbFBERfBGAYtwP+q1ETYC8TIMk0N4F6NEzj848TFITC0lWZmJDv
         kFf4vPvP3UTxc8I/I6CFrDYiQbqQMi1hR+35VoHMDpmKXefnpTeFSrvM3TGwTRzsxN42
         jC/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6HpR/rbwsOh3ceJ0wnaFgLvGl53QI5XzwKA57rYjSDKNwoC8h9xgzGLQa0VkAZRfqn3HsyTC6Wf2WstV7rq8P6HFK
X-Gm-Message-State: AOJu0YxXPnojitKW/3OiHTYR9cyREjs2oKQ/TONlNy9w9AD8ImmWwNOQ
	kedo517DxYi+A4CVWSL2nsvYNneq9xjFeQ1qSJMDtkFCHS7POfsNssAK78LZb8Po1m9b1fj0r2y
	EGQBw4tG2ASU9oLXqhCZYHO64GTk=
X-Google-Smtp-Source: AGHT+IFeaxIzToO5yxCQ5kY53F+O0bhe/SExpv3DP7CqPn60+/5hu71SPjam9EDDcJRFQ4HTIzlYj0ca5txX5Zrz/fA=
X-Received: by 2002:a5d:6510:0:b0:33b:1588:2250 with SMTP id
 x16-20020a5d6510000000b0033b15882250mr561440wru.8.1707866358558; Tue, 13 Feb
 2024 15:19:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-18-alexei.starovoitov@gmail.com> <20240209231433.GE975217@maniforge.lan>
 <CAADnVQJsdbUuvkp67_z5xprA+UP=O9rTcwm3xRkpqSArrGqNaA@mail.gmail.com> <CAP01T75qCUabu4-18nYwRDnSyTTgeAgNN3kePY5PXdnoTKt+Cg@mail.gmail.com>
In-Reply-To: <CAP01T75qCUabu4-18nYwRDnSyTTgeAgNN3kePY5PXdnoTKt+Cg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Feb 2024 15:19:07 -0800
Message-ID: <CAADnVQLEpADj=BSzCqf69mMTm2Q4dWLOd=VjGEJSW68Qha=9yQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 17/20] selftests/bpf: Add unit tests for bpf_arena_alloc/free_pages
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: David Vernet <void@manifault.com>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 11:03=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sat, 10 Feb 2024 at 05:35, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Feb 9, 2024 at 3:14=E2=80=AFPM David Vernet <void@manifault.com=
> wrote:
> > >
> > > > +
> > > > +#ifndef arena_container_of
> > >
> > > Why is this ifndef required if we have a pragma once above?
> >
> > Just a habit to check for a macro before defining it.
> >
> > > Obviously it's way better for us to actually have arenas in the inter=
im
> > > so this is fine for now, but UAF bugs could potentially be pretty
> > > painful until we get proper exception unwinding support.
> >
> > Detection that arena access faulted doesn't have to come after
> > exception unwinding. Exceptions vs cancellable progs are also different=
.
>
> What do you mean exactly by 'cancellable progs'? That they can be
> interrupted at any (or well-known) points and stopped? I believe
> whatever plumbing was done to enable exceptions will be useful there
> as well. The verifier would just need to know e.g. that a load into
> PTR_TO_ARENA may fault, and thus generate descriptors for all frames
> for that pc. Then, at runtime, you could technically release all
> resources by looking up the frame descriptor and unwind the stack and
> return back to the caller of the prog.

I don't think it's a scalable approach.
I'm still trying to understand your exceptions part 2 series,
but from what I understand so far the scalability is a real concern.

>
> > A record of the line in bpf prog that caused the first fault is probabl=
y
> > good enough for prog debugging.
> >
>
> I think it would make more sense to abort the program by default,
> because use-after-free in the arena most certainly means a bug in the
> program.

yes, but aborting vs safe continue and remember the first wrong access
from debuggability pov is the same thing.
aborting by itself also doesn't mean that the prog is auto-detached.
It may run again a split second later and won't hit abort condition.

Recording of first wrong access (either abort or pf in arena) is
must have regardless.

