Return-Path: <bpf+bounces-34118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD38992A863
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 19:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716FC281E28
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 17:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6B01487FF;
	Mon,  8 Jul 2024 17:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huxJos3v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7716684A4E;
	Mon,  8 Jul 2024 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720460954; cv=none; b=j/KQ2sWMsMC78rb12892klPIp0Uzo7hUi9aJ7z3LbH/HFrv+FzcL2kXtTB+Tm8G8UTzey5Qt9Vc+vTD7wIPueZOpveviM1wOKtD1qfijCPE0eYriNReRLa2/oQikmOm8Y3SM7jlMbrrM9I48pCmce4YZvk9qZaycGYOQBgwO1zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720460954; c=relaxed/simple;
	bh=ljvA7ZGwe6cs5dyKfeIfRfczHOFZV0hYLnUVsKu+hfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m96j8pakXq1TtHts+7f1b9eW/zXzi4h1A+nQe+eHQFEIjd0DXt+s+1AfCnbXuMpdzIyLVWfHWruVv5eb5cy3U578Cb0/9zkh234j3GCVTwtCwB62Wk0lUg99g8NcICrBqKPQtFhNDYXLOKLcHDFI4p2pmWrojrplkcRgwEM5l4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huxJos3v; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b9776123a3so1974848eaf.0;
        Mon, 08 Jul 2024 10:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720460951; x=1721065751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLr4VpzoU0x7SxOx86Qw7mNibo7Vi7FJZVfERxotGP8=;
        b=huxJos3vbmZL66pGQoTBn96BDZPd7cBxwGvF/v7q5MDmNwzwH+eNEgKC3GTh1R6Sd+
         rtZxgTRxVyzmZS42zY5l8JHdtuzR8FpA/7HWrE86AacEuobO9QS/Pzwv6mQYVbAWIDC4
         5yspSe3Nm5QOQ8t7GbSi3eAlKsLAo0mU5BKYeB7/Azd4CNRZrXFK7DIEauEVbOedoctg
         uJoCVRi3L7Y9uWwOC4Esq1RRSvbskI5nXOpBdtso/AtOGvfBO/Qh8RBlguWY1P1PFSKM
         5y1weAZ8WOk9cGwAj5+hQxDfggKOD0yOfoiZ00TMYGoZE+yRgRwrLOIey2MkBCdA7elO
         f11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720460951; x=1721065751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLr4VpzoU0x7SxOx86Qw7mNibo7Vi7FJZVfERxotGP8=;
        b=EIP1tHwXAxKYqEvIEHgV/ht/kTsRJG7N9BnCxJgOO0CfrVSG6R72msdXQ+NykR5+pI
         R8Fu7uoQVrPbYVdSFCF1sbiK+znAgBRLs0kSuwWpOHU6VkFxuRwxOA04eZj47JFqzZPa
         bdrxmEvtw/QiSIXevNXpxGkt8JApEVF7+SoU2slAaw4k+ckHfAuTnDpBiQ396dW1UF6K
         FIZIIwle/W3ma6pxY6cnP87bEK0AGy4cTHf8QgPTY3YCcO/hieo3diNAJFHQ5fUcbaMG
         ZxdrbaLCesVQqc71G5QQoxaSFkxt45gifVRsJ10ifgitK8oK9OGkADJgREPhG6KyEKQO
         KPcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0jNQFwsELbLO10qGh1ydITVPZMypdhmJBsDNhxKYKs1wXAUwc0w2/lHuSTe1G42xsfz0xrWHqnZ5XZPgsjhdxdf86zBvs56kiAfAyyojt/sZNrgzN1DB0sqou9DgSu1JtrzVkqEoPU7ChBAmho15yM86K01ojURe52Fy+ywZ2cEBoD7YG
X-Gm-Message-State: AOJu0YxwwIKeT8x1P+gFsVgpRlxonXJX8Y7xC2wMHPZmTXhcwFoeaZya
	JsGi99WnVUk/o1Ljutl1+q/pzF0nHsDA5rJGaz2/NhfWrD9yxFACJuUHbRRRppd2EXc9qJHzWSq
	acqgcCQu32teM6tJe7KfQW9dtKzO6Ew==
X-Google-Smtp-Source: AGHT+IF3c3QRj8KXZ6xxR6LBcvnTrzUiRqpzoC/ZXbD4Pnmk7miQM7eU6tFAb1TgHTykhdnMryUbw68YNkeujU+eYCg=
X-Received: by 2002:a05:6870:ac24:b0:254:963e:cc3f with SMTP id
 586e51a60fabf-25eae755eb3mr83265fac.1.1720460951456; Mon, 08 Jul 2024
 10:49:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701223935.3783951-1-andrii@kernel.org> <CAEf4BzaZhi+_MZ0M4Pz-1qmej6rrJeLO9x1+nR5QH9pnQXzwdw@mail.gmail.com>
 <20240704091559.GS11386@noisy.programming.kicks-ass.net>
In-Reply-To: <20240704091559.GS11386@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jul 2024 10:48:59 -0700
Message-ID: <CAEf4BzZxsyFGy9Ny5ekc=hvso7vu3=1toq0hW+jR_EukMn3M_Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] uprobes: add batched register/unregister APIs
 and per-CPU RW semaphore
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, oleg@redhat.com, mingo@redhat.com, 
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, clm@meta.com, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 2:16=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Wed, Jul 03, 2024 at 02:33:06PM -0700, Andrii Nakryiko wrote:
>
> > 2. More tactically, RCU protection seems like the best way forward. We
> > got hung up on SRCU vs RCU Tasks Trace. Thanks to Paul, we also
> > clarified that RCU Tasks Trace has nothing to do with Tasks Rude
> > flavor (whatever that is, I have no idea).
> >
> > Now, RCU Tasks Trace were specifically designed for least overhead
> > hotpath (reader side) performance, at the expense of slowing down much
> > rarer writers. My microbenchmarking does show at least 5% difference.
> > Both flavors can handle sleepable uprobes waiting for page faults.
> > Tasks Trace flavor is already used for tracing in the BPF realm,
> > including for sleepable uprobes and works well. It's not going away.
>
> I need to look into this new RCU flavour and why it exists -- for
> example, why can't SRCU be improved to gain the same benefits. This is
> what we've always done, improve SRCU.

Yes, that makes sense, in principle. But if it takes too much time to
improve SRCU, I'd say it's reasonable to use the faster solution until
it can be unified (if at all, of course).

>
> > Now, you keep pushing for SRCU instead of RCU Tasks Trace, but I
> > haven't seen a single argument why. Please provide that, or let's
> > stick to RCU Tasks Trace, because uprobe's use case is an ideal case
> > of what Tasks Trace flavor was designed for.
>
> Because I actually know SRCU, and because it provides a local scope.
> It isolates the unregister waiters from other random users. I'm not
> going to use this funky new flavour until I truly understand it.
>
> Also, we actually want two scopes here, there is no reason for the
> consumer unreg to wait for the retprobe stuff.
>

Uprobe attachment/detachment (i.e., register/unregister) is a very
rare operation. Its performance doesn't really matter in the great
scheme of things. In the sense that whether it takes 1, 10, or 200
milliseconds is immaterial compared to uprobe/uretprobe triggering
performance. The only important thing is that it doesn't take multiple
seconds and minutes (or even hours, if we do synchronize_rcu
unconditionally after each unregister) to attach/detach 100s/1000s+
uprobes.

I'm just saying this is the wrong target to optimize for if we just
ensure that it's reasonably performant in the face of multiple uprobes
registering/unregistering. (so one common SRCU scope for
registration/unregistration is totally fine, IMO)


> > 3. Regardless of RCU flavor, due to RCU protection, we have to add
> > batched register/unregister APIs, so we can amortize sync_rcu cost
> > during deregistration. Can we please agree on that as well? This is
> > the main goal of this patch set and I'd like to land it before working
> > further on changing and improving the rest of the locking schema.
>
> See my patch here:
>
>   https://lkml.kernel.org/r/20240704084524.GC28838@noisy.programming.kick=
s-ass.net
>
> I don't think it needs to be more complicated than that.

Alright, I'll take a closer look this week and will run it through my
tests and benchmarks, thanks for working on this and sending it out!

>
> > I won't be happy about it, but just to move things forward, I can drop
> > a) custom refcounting and/or b) percpu RW semaphore. Both are
> > beneficial but not essential for batched APIs work. But if you force
> > me to do that, please state clearly your reasons/arguments.
>
> The reason I'm pushing RCU here is because AFAICT uprobes doesn't
> actually need the stronger serialisation that rwlock (any flavour)
> provide. It is a prime candidate for RCU, and I think you'll find plenty
> papers / articles (by both Paul and others) that show that RCU scales
> better.
>
> As a bonus, you avoid that horrific write side cost that per-cpu rwsem
> has.
>
> The reason I'm not keen on that refcount thing was initially because I
> did not understand the justification for it, but worse, once I did read
> your justification, your very own numbers convinced me that the refcount
> is fundamentally problematic, in any way shape or form.
>
> > No one had yet pointed out why refcounting is broken
>
> Your very own numbers point out that refcounting is a problem here.

Yes, I already agreed on avoiding refcounting if possible. The
question above was why the refcounting I added was broken by itself.
But it's a moot point (at least for now), let me go look at your
patches.

>
> > and why percpu RW semaphore is bad.
>
> Literature and history show us that RCU -- where possible -- is
> always better than any reader-writer locking scheme.
>
> > 4. Another tactical thing, but an important one. Refcounting schema
> > for uprobes. I've replied already, but I think refcounting is
> > unavoidable for uretprobes,
>
> I think we can fix that, I replied here:
>
>   https://lkml.kernel.org/r/20240704083152.GQ11386@noisy.programming.kick=
s-ass.net
>
> > and current refcounting schema is
> > problematic for batched APIs due to race between finding uprobe and
> > there still being a possibility we'd need to undo all that and retry
> > again.
>
> Right, I've not looked too deeply at that, because I've not seen a
> reason to actually change that. I can go think about it if you want, but
> meh.

Ok, let's postpone that if we can get away with just sync/nosync
uprobe_unregister.

