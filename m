Return-Path: <bpf+bounces-33810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E05926A51
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 23:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8A82B2151B
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 21:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050F6191F7C;
	Wed,  3 Jul 2024 21:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTpvtQuY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220742BD19;
	Wed,  3 Jul 2024 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042400; cv=none; b=FKif15ODrKXHq8Ha8NgOUZUkoKsa98BANk+Pz90NZrR8cQZ0gU3OjlgEGRNjfkNF9ZpMM50rIFSU023fDtkOTFdR7/igIoG4bCOgFd6kNKAI04SLmdPTMy+cNibItMy+olCyUFY5y1uzIro9JfLf3HHnBoUG0g+SUAhl7IbPaZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042400; c=relaxed/simple;
	bh=ppambdjBN1x/jfaPWwxdWSSQGBavG6iU4iRd7/NpFhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcrnSWz5uB2MpYe1vq9Q8hCzOcx0Yyd4fZPyPJ60WIUH/S9ZWyyvZWhDY/xKFpFhFfQ/vAYMNgUC0zb/ftXUX5V+31unkfIf4FYIYcb3A3JgpKvPTQS58PWA0YOFgjf+6xcnUpilm4sHHivjABCYHsKy4BZR0n8CQczkLj5sTww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTpvtQuY; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-75ee39f1ffbso83675a12.2;
        Wed, 03 Jul 2024 14:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720042398; x=1720647198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOUZe3r2B6mT9OCJJ4ifXJWPwhJCaL9FAWnv8DZDhpY=;
        b=dTpvtQuYaHY4n3q+vF1C+zy/644MVxyT6aOVhVICZC+Wc4pDWdnpHDsborP1iypTrq
         9+JDcsaLc/Uwh2TR3uUyLA5kb06ZzgOeLoZnYD2BxW0sRgRBptXP/YltnAdC0U4gfVM/
         X6uARBivG400f3m0DhLK0a8r+SBtn+CRiB5Op+T000TvNlAMxpf/b/h993cq05c3i2Dk
         F5y15Vu4g1IExPhkSSf/rZQGngf3FFvPz31lcpP6OC2sx+zWv1eCA7irdZVtSauQ8HTq
         22sKrKdcnIm2xOVhxX3g8HieOaLFghnvv6x8DcWgwZGUrRSUOIdVAGaP5/1lNsnI53s0
         X5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042398; x=1720647198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOUZe3r2B6mT9OCJJ4ifXJWPwhJCaL9FAWnv8DZDhpY=;
        b=QSyXQaObN390GcylYTMAVDSl7gyCnxm2sSQV096idrAYIjBrIVa3YZzo8LjlPQFZQE
         CFA4jnXxQUmMSlEvOFwKkpkTkQwPrLMz+gXuwJ1ni0mxQvjFi4TTylnQ/QVEGVMqG5R5
         t2KRrsygZjSXU/xcla407Ok8inDcVQ0alY4VYzMoY2NuOTJy2+1jiIYMz9w9Mdom8K58
         WyLdjjz+ZqJEyR2ZLtDCu0jP5S/fpaLJm+6WC2W+c4qD952QRi21dlrfKrdC0wkQfd75
         aCpNcNrIGQvm/ZWsmOyiN9w5l2SWK+DcjJ9kAZ5dbp/FNtsU/mew2pJ2m5h4vRlttRrM
         OdFw==
X-Forwarded-Encrypted: i=1; AJvYcCXl74wCEUwaduVANF/YWTNw9aGtuqKm1VHdrNfuMEkfuT3uSU9/k2LB6SsaPkaOlhf0P9WFZIQar0w4zoTNLgRPzc1KmdD7xJg9kJYk6l0FqaMagFkWvpWdoja2Pi36utmE
X-Gm-Message-State: AOJu0YxpXEpU09k8XKw5RmQZ+wI/tdFuEJmu+sHS3wgSW/2eh4mzyrxS
	OqO0aOU6tEZmnH3sIAIB9Hc6CYPqBzHsLDcOn6vGEBltPCLnYhWPD0suRvt6PNJAKTjRkyE0TdT
	nDa0P/OaizEYArxnUZ3QREs7D28k=
X-Google-Smtp-Source: AGHT+IEbRDOgmzoLDAS+K8tbfmLzybGoB1JV3AcBepgRQ+8qzf44GY8OAor4QYpSOrUa12pg0XKDlGt2gYWiTa3U7k8=
X-Received: by 2002:a05:6a20:ce4d:b0:1bd:2ae7:792e with SMTP id
 adf61e73a8af0-1bef61ed474mr18464736637.49.1720042398195; Wed, 03 Jul 2024
 14:33:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701223935.3783951-1-andrii@kernel.org>
In-Reply-To: <20240701223935.3783951-1-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jul 2024 14:33:06 -0700
Message-ID: <CAEf4BzaZhi+_MZ0M4Pz-1qmej6rrJeLO9x1+nR5QH9pnQXzwdw@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] uprobes: add batched register/unregister APIs
 and per-CPU RW semaphore
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org, mingo@redhat.com, 
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, clm@meta.com, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 3:39=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> This patch set, ultimately, switches global uprobes_treelock from RW spin=
lock
> to per-CPU RW semaphore, which has better performance and scales better u=
nder
> contention and multiple parallel threads triggering lots of uprobes.
>
> To make this work well with attaching multiple uprobes (through BPF
> multi-uprobe), we need to add batched versions of uprobe register/unregis=
ter
> APIs. This is what most of the patch set is actually doing. The actual sw=
itch
> to per-CPU RW semaphore is trivial after that and is done in the very las=
t
> patch #12. See commit message with some comparison numbers.
>

Peter,

I think I've addressed all the questions so far, but I wanted to take
a moment and bring all the discussions into a single palace, summarize
what I think are the main points of contention and hopefully make some
progress, or at least get us to a bit more constructive discussion
where *both sides* provide arguments. Right now there is a lot of "you
are doing X, but why don't you just do Y" with no argument for a) why
X is bad/wrong/inferior and b) why Y is better (and not just
equivalent or, even worse, inferior).

I trust you have the best intentions in mind for this piece of kernel
infrastructure, so do I, so let's try to find a path forward.

1. Strategically, uprobes/uretprobes have to be improved. Customers do
complain more and more that "uprobes are slow", justifiably so. Both
single-threaded performance matters, but also, critically, uprobes
scalability. I.e., if the kernel can handle N uprobe per second on a
single uncontended CPU, then triggering uprobes across M CPUs should,
ideally and roughly, give us about N * M total throughput.

This doesn't seem controversial, but I wanted to make it clear that
this is the end goal of my work. And no, this patch set alone doesn't,
yet, get us there. But it's a necessary step, IMO. Jiri Olsa took
single-threaded performance and is improving it with sys_uretprobe and
soon sys_uprobe, I'm looking into scalability and other smaller
single-threaded wins, where possible.

2. More tactically, RCU protection seems like the best way forward. We
got hung up on SRCU vs RCU Tasks Trace. Thanks to Paul, we also
clarified that RCU Tasks Trace has nothing to do with Tasks Rude
flavor (whatever that is, I have no idea).

Now, RCU Tasks Trace were specifically designed for least overhead
hotpath (reader side) performance, at the expense of slowing down much
rarer writers. My microbenchmarking does show at least 5% difference.
Both flavors can handle sleepable uprobes waiting for page faults.
Tasks Trace flavor is already used for tracing in the BPF realm,
including for sleepable uprobes and works well. It's not going away.

Now, you keep pushing for SRCU instead of RCU Tasks Trace, but I
haven't seen a single argument why. Please provide that, or let's
stick to RCU Tasks Trace, because uprobe's use case is an ideal case
of what Tasks Trace flavor was designed for.

3. Regardless of RCU flavor, due to RCU protection, we have to add
batched register/unregister APIs, so we can amortize sync_rcu cost
during deregistration. Can we please agree on that as well? This is
the main goal of this patch set and I'd like to land it before working
further on changing and improving the rest of the locking schema.

I won't be happy about it, but just to move things forward, I can drop
a) custom refcounting and/or b) percpu RW semaphore. Both are
beneficial but not essential for batched APIs work. But if you force
me to do that, please state clearly your reasons/arguments. No one had
yet pointed out why refcounting is broken and why percpu RW semaphore
is bad. On the contrary, Ingo Molnar did suggest percpu RW semaphore
in the first place (see [0]), but we postponed it due to the lack of
batched APIs, and promised to do this work. Here I am, doing the
promised work. Not purely because of percpu RW semaphore, but
benefiting from it just as well.

  [0] https://lore.kernel.org/linux-trace-kernel/Zf+d9twfyIDosINf@gmail.com=
/

4. Another tactical thing, but an important one. Refcounting schema
for uprobes. I've replied already, but I think refcounting is
unavoidable for uretprobes, and current refcounting schema is
problematic for batched APIs due to race between finding uprobe and
there still being a possibility we'd need to undo all that and retry
again.

I think the main thing is to agree to change refcounting to avoid this
race, allowing for simpler batched registration. Hopefully we can
agree on that.

But also, refcount_inc_not_zero() which is another limiting factor for
scalability (see above about the end goal of scalability) vs
atomic64_add()-based epoch+refcount approach I took, which is
noticeably better on x86-64, and I don't think hurts any other
architecture, to say the least. I think the latter could be
generalized as an alternative flavor of refcount_t, but I'd prefer to
land it in uprobes in current shape, and if we think it's a good idea
to generalize, we can always do that refactoring once things stabilize
a bit.

You seem to have problems with the refcounting implementation I did
(besides overflow detection, which I'll address in the next revision,
so not a problem). My arguments are a) performance and b) it's well
contained within get/put helpers and doesn't leak outside of them *at
all*, while providing a nice always successful get_uprobe() primitive.

Can I please hear the arguments for not doing it, besides "Everyone is
using refcount_inc_not_zero", which isn't much of a reason (we'd never
do anything novel in the kernel if that was a good enough reason to
not do something new).

Again, thanks for engagement, I do appreciate it. But let's try to
move this forward. Thanks!

