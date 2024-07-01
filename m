Return-Path: <bpf+bounces-33537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8C691EA93
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 23:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD141C20C7C
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 21:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DB8171E47;
	Mon,  1 Jul 2024 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSdpOimW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB29171655;
	Mon,  1 Jul 2024 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719871188; cv=none; b=Mca0B65R1AkoAwero1lMpXg9wbo0aH63loqBRWy/V0c8VlC/Gh8tDwFGk2RmxLlhYfNL75k+Y0F2lD9f3jjwBKbIMdgFJfaOcZf16vrFEVmHyKx4SUXUfTWxItmtwoEu5uVo1u9K8uoo0OoL41bknUaFBfLdv329gjctbouU7X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719871188; c=relaxed/simple;
	bh=1M1p8C4/P0V0oUAe+3ZaIwYJGfBKdAJBqZvfGOUsTMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdkt4L3efVQ+yvFVQKCt3rknIVT5HAC5FRlE2jtR5YJrjTk945dswSLXlmuygXEnUxxLz7K06iszTEbX66IMeO8rX/G0bMsqBo8h13PSVAc0QHx9NeE607UZTuZmrPC+xllcoT71LIhRQHWoixpmmkU+3Z9IxY1tM0K/u2JCLX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSdpOimW; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-706a1711ee5so1975070b3a.0;
        Mon, 01 Jul 2024 14:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719871186; x=1720475986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EljLqQqy+0CdCrAAg1oogk23N4XDa9105icf5+m+XY0=;
        b=aSdpOimWuInlSBs8Ln1Il2ibEbLXh11jJAyHbFIyd1hfX74+50uLxcJcAwcVckAoDr
         0r4fvqd7Lvy+N/XpF1jya37sUtttxwEf9Kom7UlQiQkFHzJnKVZbhQBWfgfPV7ieA9QT
         TgNWsttOGJI0cOk1iwIsNPMr/g0mEWn8m3HhFFwnSWkMXlNgyRz+Dfrkd3P56Fe9aztI
         vrZS7wOR01eHZ97AiwAzcLxT6fnLAU7lqLAPFxKoIwVQb9IftunYjXlULLO5ebPnTtfB
         AvN/el5s+5mef9OxtUl+wNVaiPcrknq0LCgrq+Pald04kSg6bRUgZUzl5IW96pBIzlG8
         8SzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719871186; x=1720475986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EljLqQqy+0CdCrAAg1oogk23N4XDa9105icf5+m+XY0=;
        b=G7BKMKYEoOXiLMxZ9kboI8o6NSsi3cDU7RHpYnUB9/zjGC6pyUq/R/+1hCTLVylIcc
         oO19pMOjtTNfarRWevE3UrhVst+JRqmG+UyucbzAfXmyAvircavBnl4qgzpBnggS5BXX
         e7POaSE2vmYr38fwbbKKrfMcZvxGFJYNtX/xd5vZJLY73VQY2lVNwoFOiM5JDVw3hqY/
         Uw4Dl4ATWUdKf3TKngDB3sJcTTJRjryV9yFyZZN7z0hrZGfPMl1AoGFfSbCDiqSOZ59i
         z93mF/a7apKSTp3TDz+3B5Vs5W1aYuQGyEPsOkLs3+mU0TZNodqMYLTcX5dOWXbNA6Hr
         Hjpg==
X-Forwarded-Encrypted: i=1; AJvYcCVgjnuOD6CTMxtjs5gSeN17fQTa6Ej5ZUAqm7lVLfzAPRU/jYxXdcJLPkIF0LzmECVZXGY6tBibVT/CngbIl2BQroBdkwQRiL/rp0JQKxWV5u68uk2yf4MYV+KIe7vlYk6IgxGqd+ZJ
X-Gm-Message-State: AOJu0YybxOpYIYUYNuZG41WuJ8fH1GiD1+vZNvtcdWaG+kjwEIOx/5eB
	XlTdWRMmSCkvS5sSTZ0M7rly2+c3GMH95STlka8ixuHuISniCBYLCVBe2ilOZe6Chr/+l+UeBgP
	mSI+FGjyaxA4g4JmxdLimU3xAtS6LNA==
X-Google-Smtp-Source: AGHT+IFh0SMlO6O4GwT1wx93kEAD+FtucK7bJ+5egpBda+XvANY6b1ym1NAZS+6J4kj4BwAJk4RZXDX73L5PmrXujcA=
X-Received: by 2002:a05:6a00:1792:b0:706:5a4a:dcd0 with SMTP id
 d2e1a72fcca58-70aaaf530c2mr5135536b3a.34.1719871186375; Mon, 01 Jul 2024
 14:59:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625002144.3485799-1-andrii@kernel.org> <20240625002144.3485799-5-andrii@kernel.org>
 <20240627112958.0e4aa22fe5a694a2feb11e06@kernel.org> <CAEf4BzYF4kyWoY9qz2KV0iUDnNO6xEHMaTpZQPTDe2Dqa0_Fyg@mail.gmail.com>
In-Reply-To: <CAEf4BzYF4kyWoY9qz2KV0iUDnNO6xEHMaTpZQPTDe2Dqa0_Fyg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Jul 2024 14:59:34 -0700
Message-ID: <CAEf4BzaQrEbitAM1cCsLpO=VkWPUzV0tc2ozVVXNmNpj1rbaNw@mail.gmail.com>
Subject: Re: [PATCH 04/12] uprobes: revamp uprobe refcounting and lifetime management
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, oleg@redhat.com, peterz@infradead.org, mingo@redhat.com, 
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 9:43=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jun 26, 2024 at 7:30=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel=
.org> wrote:
> >
> > On Mon, 24 Jun 2024 17:21:36 -0700
> > Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > > Anyways, under exclusive writer lock, we double-check that refcount
> > > didn't change and is still zero. If it is, we proceed with destructio=
n,
> > > because at that point we have a guarantee that find_active_uprobe()
> > > can't successfully look up this uprobe instance, as it's going to be
> > > removed in destructor under writer lock. If, on the other hand,
> > > find_active_uprobe() managed to bump refcount from zero to one in
> > > between put_uprobe()'s atomic_dec_and_test(&uprobe->ref) and
> > > write_lock(&uprobes_treelock), we'll deterministically detect this wi=
th
> > > extra atomic_read(&uprobe->ref) check, and if it doesn't hold, we
> > > pretend like atomic_dec_and_test() never returned true. There is no
> > > resource freeing or any other irreversible action taken up till this
> > > point, so we just exit early.
> > >
> > > One tricky part in the above is actually two CPUs racing and dropping
> > > refcnt to zero, and then attempting to free resources. This can happe=
n
> > > as follows:
> > >   - CPU #0 drops refcnt from 1 to 0, and proceeds to grab uprobes_tre=
elock;
> > >   - before CPU #0 grabs a lock, CPU #1 updates refcnt as 0 -> 1 -> 0,=
 at
> > >     which point it decides that it needs to free uprobe as well.
> > >
> > > At this point both CPU #0 and CPU #1 will believe they need to destro=
y
> > > uprobe, which is obviously wrong. To prevent this situations, we augm=
ent
> > > refcount with epoch counter, which is always incremented by 1 on eith=
er
> > > get or put operation. This allows those two CPUs above to disambiguat=
e
> > > who should actually free uprobe (it's the CPU #1, because it has
> > > up-to-date epoch). See comments in the code and note the specific val=
ues
> > > of UPROBE_REFCNT_GET and UPROBE_REFCNT_PUT constants. Keep in mind th=
at
> > > a single atomi64_t is actually a two sort-of-independent 32-bit count=
ers
> > > that are incremented/decremented with a single atomic_add_and_return(=
)
> > > operation. Note also a small and extremely rare (and thus having no
> > > effect on performance) need to clear the highest bit every 2 billion
> > > get/put operations to prevent high 32-bit counter from "bleeding over=
"
> > > into lower 32-bit counter.
> >
> > I have a question here.
> > Is there any chance to the CPU#1 to put the uprobe before CPU#0 gets
> > the uprobes_treelock, and free uprobe before CPU#0 validate uprobe->ref
> > again? e.g.
> >
> > CPU#0                                                   CPU#1
> >
> > put_uprobe() {
> >         atomic64_add_return()
> >                                                         __get_uprobe();
> >                                                         put_uprobe() {
> >                                                                 kfree(u=
probe)
> >                                                         }
> >         write_lock(&uprobes_treelock);
> >         atomic64_read(&uprobe->ref);
> > }
> >
> > I think it is very rare case, but I could not find any code to prevent
> > this scenario.
> >
>
> Yes, I think you are right, great catch!
>
> I concentrated on preventing double kfree() in this situation, and
> somehow convinced myself that eager kfree() is fine. But I think I'll
> need to delay freeing, probably with RCU. The problem is that we can't
> use rcu_read_lock()/rcu_read_unlock() because we take locks, so it has
> to be a sleepable variant of RCU. I'm thinking of using
> rcu_read_lock_trace(), the same variant of RCU we use for sleepable
> BPF programs (including sleepable uprobes). srcu might be too heavy
> for this.
>
> I'll try a few variants over the next few days and see how the
> performance looks.
>

So I think I'm going with the changes below, incorporated into this
patch (nothing else changes). __get_uprobe() doesn't need any added
RCU protection (we know that uprobe is alive). It's only put_uprobe()
that needs to guarantee RCU protection before we drop refcount all the
way until we know whether we are the winning destructor or not.

Good thing is that the changes are pretty minimal in code and also
don't seem to regress performance/scalability. So I'm pretty happy
about that, will send v2 soon.


diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 07ad8b2e7508..41d9e37633ca 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -56,6 +56,7 @@ struct uprobe {
        atomic64_t              ref;            /* see
UPROBE_REFCNT_GET below */
        struct rw_semaphore     register_rwsem;
        struct rw_semaphore     consumer_rwsem;
+       struct rcu_head         rcu;
        struct list_head        pending_list;
        struct uprobe_consumer  *consumers;
        struct inode            *inode;         /* Also hold a ref to inode=
 */
@@ -623,7 +624,7 @@ set_orig_insn(struct arch_uprobe *auprobe, struct
mm_struct *mm, unsigned long v
 #define UPROBE_REFCNT_GET ((1LL << 32) | 1LL)
 #define UPROBE_REFCNT_PUT (0xffffffffLL)

-/**
+/*
  * Caller has to make sure that:
  *   a) either uprobe's refcnt is positive before this call;
  *   b) or uprobes_treelock is held (doesn't matter if for read or write),
@@ -657,10 +658,26 @@ static inline bool uprobe_is_active(struct uprobe *up=
robe)
        return !RB_EMPTY_NODE(&uprobe->rb_node);
 }

+static void uprobe_free_rcu(struct rcu_head *rcu)
+{
+       struct uprobe *uprobe =3D container_of(rcu, struct uprobe, rcu);
+
+       kfree(uprobe);
+}
+
 static void put_uprobe(struct uprobe *uprobe)
 {
        s64 v;

+       /*
+        * here uprobe instance is guaranteed to be alive, so we use Tasks
+        * Trace RCU to guarantee that uprobe won't be freed from under us,=
 if
+        * we end up being a losing "destructor" inside uprobe_treelock'ed
+        * section double-checking uprobe->ref value below.
+        * Note call_rcu_tasks_trace() + uprobe_free_rcu below.
+        */
+       rcu_read_lock_trace();
+
        v =3D atomic64_add_return(UPROBE_REFCNT_PUT, &uprobe->ref);

        if (unlikely((u32)v =3D=3D 0)) {
@@ -691,6 +708,8 @@ static void put_uprobe(struct uprobe *uprobe)
                        rb_erase(&uprobe->rb_node, &uprobes_tree);
                write_unlock(&uprobes_treelock);

+               rcu_read_unlock_trace();
+
                /* uprobe got resurrected, pretend we never tried to free i=
t */
                if (!destroy)
                        return;
@@ -704,7 +723,7 @@ static void put_uprobe(struct uprobe *uprobe)
                delayed_uprobe_remove(uprobe, NULL);
                mutex_unlock(&delayed_uprobe_lock);

-               kfree(uprobe);
+               call_rcu_tasks_trace(&uprobe->rcu, uprobe_free_rcu);
                return;
        }

@@ -716,6 +735,8 @@ static void put_uprobe(struct uprobe *uprobe)
         */
        if (unlikely(v < 0))
                (void)atomic64_cmpxchg(&uprobe->ref, v, v & ~(1ULL << 63));
+
+       rcu_read_unlock_trace();
 }

 static __always_inline



> > Thank you,
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >

