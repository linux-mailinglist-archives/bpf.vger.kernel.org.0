Return-Path: <bpf+bounces-34117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB9D92A85F
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 19:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8411C21152
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 17:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480BA1494A9;
	Mon,  8 Jul 2024 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuG90d/o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1A61487ED;
	Mon,  8 Jul 2024 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720460862; cv=none; b=rAzFHwFOMZzoZlyl4iqbUxC/zJr0onXN8o0jPnJpPo32/XSrAFsjGI8MHas3zvAb3mKtXYqRtM2n31rn8CfsGcaKxPAmI5sMIohaQwYe5zE9lMuBCUm4dFwFVyElZwNhB8Dt42FYqoReAyGqa5vYUCEddlVaF20Qy/hCyWeJa78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720460862; c=relaxed/simple;
	bh=TTIwKXrfRM3jtCVLcjazwTO8XYxyxLLTkrUHhlJozDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EnAV+TEYEWlWDMgdsrZLCLK0/7pPcoH+4NebNk+6DmKTeU5+Oe20KCjCyihIyCGtU9hJ0Xz3OGHsAYp9RVNJoXqUQG0CYEoXZfNwXpepBvbpn7g5QcR2c51+4p6yL2CHJkHnXmj1Dww4cdczwIRAOLqfZd8+GuGnLqsslaZrM4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuG90d/o; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c98a97d1ccso3278292a91.0;
        Mon, 08 Jul 2024 10:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720460860; x=1721065660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNSeth6vTNr/yOF6EgcxcahgVZmkv2SeYwnOfRc0Wvs=;
        b=YuG90d/oYm9pI5CBPBxdB1VIka4DZuFaqWTpHoI5DsKItORQv6xRimHhtKHm4WYup1
         EzB+gTT7v1H+JbVmVyOngMda+JvamzS6bg5fpwc85j3Mc3EoMWN33oMZ5R7+BzjNP8Jm
         IgGe0knUn/+9M1NI1RoGFItnWXvw6o6SHyePFrE2FCJQJKiNp+xKNz/nInPjNASUVQBi
         gnfxmDwOmvAT9rS0q0dT0j1DurYBCrMvdiT0lVRUiWqSuHlfmYsfMInUO+zNrzSwJmA/
         rVHiRFmZnLYJXHF7zQH8EYEWXtl4HEKC1djt6c4SQmjRVd+yP1J4wa4wJ0tkgnxEBMQB
         Eydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720460860; x=1721065660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNSeth6vTNr/yOF6EgcxcahgVZmkv2SeYwnOfRc0Wvs=;
        b=AO1L1m77Rb1OkyShjb4CqrV7K6C1U8q6F5hwF0eG2TddvhZvXzFsbfDFHDx+gagA50
         ynkmHk22jQwBH+XOEIJYR7rHOS/1DuikJKup5y5inm1nZZGOrbbKyrdFtKA/D3T+04Hr
         1+YnorWGA9OSzfX8WVeUM0AhEp4rLZ4wTHMikXlG5Leqw/LfG+xHVjK+9Xl0whwX7Xcf
         QE/J01j6svuSeET6IGCyQclB+7TXm9bn5Y6v/I/O3cHZWhIltHWZ+/KTq8WQXACHK0pA
         oevBgqTOcTs+R9OzHWGjHKN4AWJ3tb/Khqb90C7EbBNlQ4IBtAKs/yHg+H8S3sHVxHEF
         qfDg==
X-Forwarded-Encrypted: i=1; AJvYcCWL0F6PZRTifgMrYZi1Keu5y1PqL7Uh+MHMbQVvOu/TWw99+fJAhSNPWhMhJR4lh/CNGWwFmblLzjhjsUvCo9h2k3FH8t5dTaCZuvbKwn0G0+BtdEx/5+KbiN+8G5FbAGTfKC2u7BgHK/2h+ZrQ6UNIF00JLj1av88RGc8i40UBWVyQQRGg
X-Gm-Message-State: AOJu0YxDmvQD/sPuVrF/h2RpWJF1AqWI546x8PBxFEvwmF6KgMGUWOkZ
	ZJeB7EuvnzxeyUij/RYRuYL0TP5Yws9w2SEMzHJCINt+elIOc0scw/8Si6ZmpS2jCa6uPx2pk++
	ZgOFweXLKbh+j7zWgTElZyKBrNf5KOA==
X-Google-Smtp-Source: AGHT+IGP3HK7056mYzfOrqXGXM8tf5moqT23lLFAtsMhfp/L4mEf5UaBf9e4iC09bfr7MY8pJCvVnlF8Zci0dr7jS0c=
X-Received: by 2002:a17:90a:c293:b0:2c7:c5f5:1c72 with SMTP id
 98e67ed59e1d1-2c99f34a7abmr18576700a91.13.1720460860487; Mon, 08 Jul 2024
 10:47:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701223935.3783951-1-andrii@kernel.org> <CAEf4BzaZhi+_MZ0M4Pz-1qmej6rrJeLO9x1+nR5QH9pnQXzwdw@mail.gmail.com>
 <20240704091559.GS11386@noisy.programming.kicks-ass.net> <2d3676e7-6b79-4b99-911f-a5cc0c061406@paulmck-laptop>
In-Reply-To: <2d3676e7-6b79-4b99-911f-a5cc0c061406@paulmck-laptop>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jul 2024 10:47:27 -0700
Message-ID: <CAEf4BzbQHNMJvDsoXRf7DkYGNm+WFGo_suLZ3dbz0Rf6XD-tZg@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] uprobes: add batched register/unregister APIs
 and per-CPU RW semaphore
To: paulmck@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	oleg@redhat.com, mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org, 
	clm@meta.com, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 8:44=E2=80=AFAM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> On Thu, Jul 04, 2024 at 11:15:59AM +0200, Peter Zijlstra wrote:
> > On Wed, Jul 03, 2024 at 02:33:06PM -0700, Andrii Nakryiko wrote:
> >
> > > 2. More tactically, RCU protection seems like the best way forward. W=
e
> > > got hung up on SRCU vs RCU Tasks Trace. Thanks to Paul, we also
> > > clarified that RCU Tasks Trace has nothing to do with Tasks Rude
> > > flavor (whatever that is, I have no idea).
> > >
> > > Now, RCU Tasks Trace were specifically designed for least overhead
> > > hotpath (reader side) performance, at the expense of slowing down muc=
h
> > > rarer writers. My microbenchmarking does show at least 5% difference.
> > > Both flavors can handle sleepable uprobes waiting for page faults.
> > > Tasks Trace flavor is already used for tracing in the BPF realm,
> > > including for sleepable uprobes and works well. It's not going away.
> >
> > I need to look into this new RCU flavour and why it exists -- for
> > example, why can't SRCU be improved to gain the same benefits. This is
> > what we've always done, improve SRCU.
>
> Well, it is all software.  And I certainly pushed SRCU hard.  If I recall
> correctly, it took them a year to convince me that they needed something
> more than SRCU could reasonably be convinced to do.
>
> The big problem is that they need to be able to hook a simple BPF program
> (for example, count the number of calls with given argument values) on
> a fastpath function on a system running in production without causing
> the automation to decide that this system is too slow, thus whacking it
> over the head.  Any appreciable overhead is a no-go in this use case.
> It is not just that the srcu_read_lock() function's smp_mb() call would
> disqualify SRCU, its other added overhead would as well.  Plus this needs
> RCU Tasks Trace CPU stall warnings to catch abuse, and SRCU doesn't
> impose any limits on readers (how long to set the stall time?) and
> doesn't track tasks.
>
> > > Now, you keep pushing for SRCU instead of RCU Tasks Trace, but I
> > > haven't seen a single argument why. Please provide that, or let's
> > > stick to RCU Tasks Trace, because uprobe's use case is an ideal case
> > > of what Tasks Trace flavor was designed for.
> >
> > Because I actually know SRCU, and because it provides a local scope.
> > It isolates the unregister waiters from other random users. I'm not
> > going to use this funky new flavour until I truly understand it.
>
> It is only a few hundred lines of code on top of the infrastructure
> that also supports RCU Tasks and RCU Tasks Rude.  If you understand
> SRCU and preemptible RCU, there will be nothing exotic there, and it is
> simpler than Tree SRCU, to say nothing of preemptible RCU.  I would be
> more than happy to take you through it if you would like, but not before
> this coming Monday.
>
> > Also, we actually want two scopes here, there is no reason for the
> > consumer unreg to wait for the retprobe stuff.
>
> I don't know that the performance requirements for userspace retprobes ar=
e
> as severe as for function-call probes -- on that, I must defer to Andrii.

uretprobes are just as important (performance-wise and just in term of
functionality), as they are often used simultaneously (e.g., to time
some user function or capture input args and make decision whether to
log them based on return value). uretprobes are inherently slower
(because they are entry probe + some extra bookkeeping and overhead),
but we should do the best we can to ensure they are as performant as
possible


> To your two-scopes point, it is quite possible that SRCU could be used
> for userspace retprobes and RCU Tasks Trace for the others.  It certainly
> seems to me that SRCU would be better than explicit reference counting,
> but I could be missing something.  (Memory footprint, perhaps?  Though
> maybe a single srcu_struct could be shared among all userspace retprobes.
> Given the time-bounded reads, maybe stall warnings aren't needed,
> give or take things like interrupts, preemption, and vCPU preemption.
> Plus it is not like it would be hard to figure out which read-side code
> region was at fault when the synchronize_srcu() took too long.)
>
>                                                         Thanx, Paul
>
> > > 3. Regardless of RCU flavor, due to RCU protection, we have to add
> > > batched register/unregister APIs, so we can amortize sync_rcu cost
> > > during deregistration. Can we please agree on that as well? This is
> > > the main goal of this patch set and I'd like to land it before workin=
g
> > > further on changing and improving the rest of the locking schema.
> >
> > See my patch here:
> >
> >   https://lkml.kernel.org/r/20240704084524.GC28838@noisy.programming.ki=
cks-ass.net
> >
> > I don't think it needs to be more complicated than that.
> >
> > > I won't be happy about it, but just to move things forward, I can dro=
p
> > > a) custom refcounting and/or b) percpu RW semaphore. Both are
> > > beneficial but not essential for batched APIs work. But if you force
> > > me to do that, please state clearly your reasons/arguments.
> >
> > The reason I'm pushing RCU here is because AFAICT uprobes doesn't
> > actually need the stronger serialisation that rwlock (any flavour)
> > provide. It is a prime candidate for RCU, and I think you'll find plent=
y
> > papers / articles (by both Paul and others) that show that RCU scales
> > better.
> >
> > As a bonus, you avoid that horrific write side cost that per-cpu rwsem
> > has.
> >
> > The reason I'm not keen on that refcount thing was initially because I
> > did not understand the justification for it, but worse, once I did read
> > your justification, your very own numbers convinced me that the refcoun=
t
> > is fundamentally problematic, in any way shape or form.
> >
> > > No one had yet pointed out why refcounting is broken
> >
> > Your very own numbers point out that refcounting is a problem here.
> >
> > > and why percpu RW semaphore is bad.
> >
> > Literature and history show us that RCU -- where possible -- is
> > always better than any reader-writer locking scheme.
> >
> > > 4. Another tactical thing, but an important one. Refcounting schema
> > > for uprobes. I've replied already, but I think refcounting is
> > > unavoidable for uretprobes,
> >
> > I think we can fix that, I replied here:
> >
> >   https://lkml.kernel.org/r/20240704083152.GQ11386@noisy.programming.ki=
cks-ass.net
> >
> > > and current refcounting schema is
> > > problematic for batched APIs due to race between finding uprobe and
> > > there still being a possibility we'd need to undo all that and retry
> > > again.
> >
> > Right, I've not looked too deeply at that, because I've not seen a
> > reason to actually change that. I can go think about it if you want, bu=
t
> > meh.

