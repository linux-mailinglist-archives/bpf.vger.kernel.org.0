Return-Path: <bpf+bounces-50165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43948A23562
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 21:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991F716510D
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 20:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0964319DF60;
	Thu, 30 Jan 2025 20:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZImzZU8o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF63139B
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 20:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738270295; cv=none; b=gSV4mc29m2v04OCNVQG984kLeeTlv6DLooZHjJV/5nqIClToff0PSEu2TUcxYUqu0rdLQzLvOJOmBePds8Krn2YJ0Z0lPqtWcXwPAh/OSd0HTTuR/FK1eHn1t2iJL+jreyDsucRgUeLonCetq1Zcn+lf/FSFNL9Ue+FQWWjqyrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738270295; c=relaxed/simple;
	bh=6l3Y4C3NeQMyUBZMU0kEVOYjqF2Je7wz/lh06nPPbn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bc5MUnU58g6L8Fyzqzp2S7/jXVOzvAzMwKnhZJxzJTdsnNxefB6zyo/io0g6KyCPvDu2pMkWuV25uOIgm+uMQWSXE0sShtdRkHfiE37fAC79GePdGNFi+RPuRiUkEVdub5+9ugGLU0KNvdgzyIAMHq4T6UHo9XhdHbxKwT0CJEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZImzZU8o; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4368a293339so14659135e9.3
        for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 12:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738270292; x=1738875092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IH/8TrCiRgxZ8RtDowE/KkPCrgCmcjbd0L4EmhGvgGM=;
        b=ZImzZU8ou+Mdvplk7bM7DYIoiIkR5WuYX1H3ig3KM8Edm7BV7kzEfWFwn64qqF3WZE
         TRlVXDkAD7PEhfvRPJtOCqYkicw2Vj4dIjbq8bBZxLM5EKs7oJHxIvCCm+JV1VlPpBhQ
         bYxLcUVRbulC5jWrFK7ZD59S5bUc6q4Ep7+5oEjET8XX9fMvV0+tPUhFoHUIc9oNoNQX
         DG73bHHk7QgZqJjUmtqUpz9vmylyidYIj8BvJilNGLpni7tIIWRTMQAHwFPYXrAKHYnd
         oJHsL+eoGdn2sQS5a4hWVZFhW4D6OqhxeImL1bgMrWmEGnZTCU/uhNCBSppdueZjyp38
         ksAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738270292; x=1738875092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IH/8TrCiRgxZ8RtDowE/KkPCrgCmcjbd0L4EmhGvgGM=;
        b=Wp11RhXWuUifMPkfXYk2hAyv0balKM7pjwHnyLbcIBCR8ng0X7yrvRXLxnaKWTpXLr
         Q4tMadCotV1GtghJKH6L/Mt74ulSftmX4GWLou0dpMtKNjD/8RhrGvNpEN4jYbF6PeiO
         ajA6aMW0xW/BxW6P4RGOWCoai2ablBoL9JVgoYpusvp4XQ1Em4RCFyrAyrO5YILpXDNX
         J325H4SiWh7zeGxNcJrFys9eveQtykhyHcuvmZbPYJMMlvNCAXEmk2ole6N0gO9K4/B0
         Qxsbun1iXEAmjKI1adEX2jmHOjyBB1lkKIcHoqcwib1NAOz0HmNfh2MfI2SAt1/1k3Zb
         W9/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXk82LqUjZuL8wL/tNhnTELrh/VqWH+HBDNPeULtkw7boqpR9sUZMfU43TD5nglZhGdmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0RcIxuW7kQOqu//xXLipV7o8b+cCdHLChxsojFSz7jc3G8noq
	po32jWmLQLawLIpcL7kU76plzbONWAWFwiuQWkW5EbIGn2ysSaQuaVKClbcwMZa8kNWuO6BSngN
	ettCOH3vB3GCmD9xRqkm+bhpZrCw=
X-Gm-Gg: ASbGncu7JLHaFUl0ilxael267cIa1zVB2m99i5t29c8FtAe7Hr6kIaKU1UgEznEYvZY
	aotBcNULS8jzgBZhbyVIyxn7Y39n6aEPBPMRd53R8EBziQePf17DRYmv1CAor8OkpKgIEVmpR
X-Google-Smtp-Source: AGHT+IEOlaqSZ26LiLus8bxkkm85sJ7AvNT2Z2/6QoPYkT/iOcJCC3z7flMxohiKT60ClGJYCOyBEWba2etDyE4Vw7o=
X-Received: by 2002:a05:600c:1f10:b0:435:192:63fb with SMTP id
 5b1f17b1804b1-438dc3ae816mr72407065e9.3.1738270292086; Thu, 30 Jan 2025
 12:51:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124035655.78899-1-alexei.starovoitov@gmail.com>
 <20250124035655.78899-4-alexei.starovoitov@gmail.com> <20250128172137.bLPGqHth@linutronix.de>
 <CAADnVQ+6YD=jzx08ynUDo=ptFbD62o17ozymFfycF5WbPb9GbA@mail.gmail.com> <20250129081726.vGHs_2kD@linutronix.de>
In-Reply-To: <20250129081726.vGHs_2kD@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 30 Jan 2025 12:51:21 -0800
X-Gm-Features: AWEUYZkhE-B06g2m7IyMZB5sMrPrZgb9Bh5RS-XTaq_UVfaMB4fRt5FnVh61r7w
Message-ID: <CAADnVQJ4nBFt1KSp7bwTbwWZgrAv6PKxtgJfm5e0J6dSG9BVwg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 3/6] locking/local_lock: Introduce
 local_trylock_t and local_trylock_irqsave()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 12:17=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> PeterZ, may I summon you.
>
> On 2025-01-28 10:50:33 [-0800], Alexei Starovoitov wrote:
> > On Tue, Jan 28, 2025 at 9:21=E2=80=AFAM Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > >
> > > On 2025-01-23 19:56:52 [-0800], Alexei Starovoitov wrote:
> > > > Usage:
> > > >
> > > > local_lock_t lock;                     // sizeof(lock) =3D=3D 0 in =
!RT
> > > > local_lock_irqsave(&lock, ...);        // irqsave as before
> > > > if (local_trylock_irqsave(&lock, ...)) // compilation error
> > > >
> > > > local_trylock_t lock;                  // sizeof(lock) =3D=3D 4 in =
!RT
> > > > local_lock_irqsave(&lock, ...);        // irqsave and active =3D 1
> > > > if (local_trylock_irqsave(&lock, ...)) // if (!active) irqsave
> > >
> > > so I've been looking at this for a while and I don't like the part wh=
ere
> > > the type is hidden away. It is then casted back. So I tried something
> > > with _Generics but then the existing guard implementation complained.
> > > Then I asked myself why do we want to hide much of the implementation
> > > and not make it obvious.
> >
> > Well, the idea of hiding extra field with _Generic is to avoid
> > the churn:
> >
> > git grep -E 'local_.*lock_irq'|wc -l
> > 42
>
> This could be also hidden with a macro defining the general body and
> having a place holder for "lock primitive".

How would that look like?

> > I think the api is clean enough and _Generic part is not exposed
> > to users.
> > Misuse or accidental usage is not possible either.
> > See the point:
> > if (local_trylock_irqsave(&lock, ...)) // compilation error
> >
> > So imo it's a better tradeoff.
> >
> > > is this anywhere near possible to accept?
> >
> > Other than churn it's fine.
> > I can go with it if you insist,
> > but casting and _Generic() I think is cleaner.
> > Certainly a bit unusual pattern.
> > Could you sleep on it?
>
> The cast there is somehow=E2=80=A6 We could have BUILD_BUG_ON() to ensure=
 a
> stable the layout of the structs=E2=80=A6 However all this is not my call=
.
>
> PeterZ, do you have any preferences or an outline what you would like to
> see here?

I still don't get the objection.
This is a normal function polymorphism that is present
in many languages.
Consider spin_lock().
It's already vastly different in PREEMPT_RT vs not.
This is polymorphism. The same function has different
implementations depending on config and argument type.
This patch makes local_lock_irqsave() polymorphic
not only in PREEMPT_RT vs not,
but also depending on local_lock_t vs localtry_lock_t
argument type in !PREEMPT_RT.

Anyway, if I don't hear back from Peter or you soon
I'll just take your localtry_lock_t version of the patch
with you being an author and your SOB (ok ?) and
will make the next patch 4 to suffer all the code churn.
We cannot afford to get stuck on something as trivial
as this for days.

