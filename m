Return-Path: <bpf+bounces-33656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBEC9246B9
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 19:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05051283B54
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 17:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1C61C8FA2;
	Tue,  2 Jul 2024 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLooFOTV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B8B15B104;
	Tue,  2 Jul 2024 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719942906; cv=none; b=Ibn6//pzvK4NTmNUZlM3OFonnONL60WbE6yfoTt+ivawve/5SirlTQJDcNehaVCwuZBch/e5idT89SmSe3u1pqH2xVd2Y17zUyoXak8wMrjQN+n4jDqPZTWQ9VA/P/Xazj4KmRjkxB8GXpXXO3DXoRVauZFTQf8C6SejjvOjRLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719942906; c=relaxed/simple;
	bh=oRQApVEe2s158r1wJospfawwOp3o/XpQXXhOYr/y7IE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aNHvNqe3kaDIdDu2uZdCqQDrlJQHVu4fk7cY8+9ynJV6IaxRDu44lN6VVEoqDNXrvnyfRVy9iqefwbX2EIqTIe38JBSs5U7diTbQk9r4SXy6fcnRCdJbAakQgLdg30+BKHJlquCiCJrWhJatd8k/DtufR9ubkJ708VYJRF8Xrys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLooFOTV; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-25d8ab4f279so2560804fac.3;
        Tue, 02 Jul 2024 10:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719942904; x=1720547704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKUGvgpI83xD4b3uGOJIjYtXHI59r73b7qdVFPeKbA0=;
        b=DLooFOTVJJuyoheooTPAuwKAvGaUsUZcI5D4pHomvb+yODXSiuiIUmNa/scI6lkhXM
         ioIpoHW8qMwqDYofSDLvhGoIzzsHJ0mVFyzoPoLcmU2HdKzo8pheZ9tPMzzE/XrRgaY/
         uQAoHRHi68AceNa5w5p9rGQ5QQheNegp0742aiON5QlGoqS+wZSgMOjQGGJuN+//fFGW
         GaaB5FGvZCvgEykHjmdgZKpZiHA7jbQjWxHw38YKmHQ6/Lt/GZ+uoP9WOa+a9qi6vaDg
         hNz0IMX5t+SqhJjtM3Fy8AoVgKA4uwQ+Wivlkcd8IygkTn/mvxt1NLRCSmltkcUkxvxs
         GRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719942904; x=1720547704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKUGvgpI83xD4b3uGOJIjYtXHI59r73b7qdVFPeKbA0=;
        b=Pc7DW0Osuri7jG2R6Syf7jafEgK84yvSfgemsC2sgTaDjGf4fcWzSYDXUJqoCkXsXM
         skH2CRiMhIzVjYMXfVafIEUFp4m76X6tKTswRWq6hmc83fSFrf9Vsx4zuJe3Nhc2OzxJ
         0uimfbJcsKsmqrA/4TnBKBcHAESSVFlA9hCFilUqCScN5qT0b+eK14l1dJys6Dd/V3Zc
         0tmBzXByFfXQEdfOBEUnHVZYVakIDCJk6lSvTm8YnqzeUwMYMhUFUV6Ijd95MA5UL4DM
         vPhAb719ZmtomfLdTlOoaQAkoNFnhZI2vnq8rnLuRkPtcJpJ2EOfl+Kc48dsHR8bCQkk
         oyDA==
X-Forwarded-Encrypted: i=1; AJvYcCWYGNr60kzNJv8Elt1yNU2XVoQZhLz7pesHvQA+zdVZRkZnoVWQ2U0E2TwaWFn7+lwXNMWK7ycq1Lf4QaKEN8fH4ES2vCHZvRtjCeX6DqtIWxrznfz2WpJuQykcaD270uolP5RjLvRPLHyjhhP5z3fHutuyIsiFxwm5CizESMWBJG3tKbks
X-Gm-Message-State: AOJu0YxhYnPGGG7nCbAu8BYPK+455O4ALvCxA9APSrz8r32QpNoyFoL6
	R64kwSpJEjdmlrsvnCcr1Omgl6Ji3KqL7XbS5qgZCK0Lz4Vn3chzms9JKx9g4TAp/Lz8OrlG+hK
	P3W+wANwpZ9jQdfsZSIpa86n2x3yjzSBv
X-Google-Smtp-Source: AGHT+IEZgIAQE0Oa6Z3JyHRrDUyaBxqoyHRtKtZmJVmhLd42aC/XcYZy6Wc4NlLDIGDDNh+w2CshSw5enyRJhIY99BI=
X-Received: by 2002:a05:6871:3a13:b0:254:b5d7:f469 with SMTP id
 586e51a60fabf-25db351715amr8168306fac.31.1719942904058; Tue, 02 Jul 2024
 10:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701223935.3783951-1-andrii@kernel.org> <20240702102353.GG11386@noisy.programming.kicks-ass.net>
 <20240702115447.GA28838@noisy.programming.kicks-ass.net>
In-Reply-To: <20240702115447.GA28838@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 10:54:51 -0700
Message-ID: <CAEf4BzaQUzQdba2=F2NoV7=Th98fxz2EN62QX2Ej92bazt1GAg@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] uprobes: add batched register/unregister APIs
 and per-CPU RW semaphore
To: Peter Zijlstra <peterz@infradead.org>, "Paul E . McKenney" <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, oleg@redhat.com, mingo@redhat.com, 
	bpf@vger.kernel.org, jolsa@kernel.org, clm@meta.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 4:54=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
>
> +LKML
>
> On Tue, Jul 02, 2024 at 12:23:53PM +0200, Peter Zijlstra wrote:
> > On Mon, Jul 01, 2024 at 03:39:23PM -0700, Andrii Nakryiko wrote:
> > > This patch set, ultimately, switches global uprobes_treelock from RW =
spinlock
> > > to per-CPU RW semaphore, which has better performance and scales bett=
er under
> > > contention and multiple parallel threads triggering lots of uprobes.
> >
> > Why not RCU + normal lock thing?
>
> Something like the *completely* untested below.
>
> ---
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 2c83ba776fc7..03b38f3f7be3 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -40,6 +40,7 @@ static struct rb_root uprobes_tree =3D RB_ROOT;
>  #define no_uprobe_events()     RB_EMPTY_ROOT(&uprobes_tree)
>
>  static DEFINE_RWLOCK(uprobes_treelock);        /* serialize rbtree acces=
s */
> +static seqcount_rwlock_t uprobes_seqcount =3D SEQCNT_RWLOCK_ZERO(uprobes=
_seqcount, &uprobes_treelock);
>
>  #define UPROBES_HASH_SZ        13
>  /* serialize uprobe->pending_list */
> @@ -54,6 +55,7 @@ DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem);
>  struct uprobe {
>         struct rb_node          rb_node;        /* node in the rb tree */
>         refcount_t              ref;
> +       struct rcu_head         rcu;
>         struct rw_semaphore     register_rwsem;
>         struct rw_semaphore     consumer_rwsem;
>         struct list_head        pending_list;
> @@ -67,7 +69,7 @@ struct uprobe {
>          * The generic code assumes that it has two members of unknown ty=
pe
>          * owned by the arch-specific code:
>          *
> -        *      insn -  copy_insn() saves the original instruction here f=
or
> +        *      insn -  copy_insn() saves the original instruction here f=
or
>          *              arch_uprobe_analyze_insn().
>          *
>          *      ixol -  potentially modified instruction to execute out o=
f
> @@ -593,6 +595,12 @@ static struct uprobe *get_uprobe(struct uprobe *upro=
be)
>         return uprobe;
>  }
>
> +static void uprobe_free_rcu(struct rcu_head *rcu)
> +{
> +       struct uprobe *uprobe =3D container_of(rcu, struct uprobe, rcu);
> +       kfree(uprobe);
> +}
> +
>  static void put_uprobe(struct uprobe *uprobe)
>  {
>         if (refcount_dec_and_test(&uprobe->ref)) {
> @@ -604,7 +612,8 @@ static void put_uprobe(struct uprobe *uprobe)

right above this we have roughly this:

percpu_down_write(&uprobes_treelock);

/* refcount check */
rb_erase(&uprobe->rb_node, &uprobes_tree);

percpu_up_write(&uprobes_treelock);


This writer lock is necessary for modification of the RB tree. And I
was under impression that I shouldn't be doing
percpu_(down|up)_write() inside the normal
rcu_read_lock()/rcu_read_unlock() region (percpu_down_write has
might_sleep() in it). But maybe I'm wrong, hopefully Paul can help to
clarify.

But actually what's wrong with RCU Tasks Trace flavor? I will
ultimately use it anyway to avoid uprobe taking unnecessary refcount
and to protect uprobe->consumers iteration and uc->handler() calls,
which could be sleepable, so would need rcu_read_lock_trace().

>                 mutex_lock(&delayed_uprobe_lock);
>                 delayed_uprobe_remove(uprobe, NULL);
>                 mutex_unlock(&delayed_uprobe_lock);
> -               kfree(uprobe);
> +
> +               call_rcu(&uprobe->rcu, uprobe_free_rcu);
>         }
>  }
>
> @@ -668,12 +677,25 @@ static struct uprobe *__find_uprobe(struct inode *i=
node, loff_t offset)
>  static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
>  {
>         struct uprobe *uprobe;
> +       unsigned seq;
>
> -       read_lock(&uprobes_treelock);
> -       uprobe =3D __find_uprobe(inode, offset);
> -       read_unlock(&uprobes_treelock);
> +       guard(rcu)();
>
> -       return uprobe;
> +       do {
> +               seq =3D read_seqcount_begin(&uprobes_seqcount);
> +               uprobes =3D __find_uprobe(inode, offset);
> +               if (uprobes) {
> +                       /*
> +                        * Lockless RB-tree lookups are prone to false-ne=
gatives.
> +                        * If they find something, it's good. If they do =
not find,
> +                        * it needs to be validated.
> +                        */
> +                       return uprobes;
> +               }
> +       } while (read_seqcount_retry(&uprobes_seqcount, seq));
> +
> +       /* Really didn't find anything. */
> +       return NULL;
>  }

Honest question here, as I don't understand the tradeoffs well enough.
Is there a lot of benefit to switching to seqcount lock vs using
percpu RW semaphore (previously recommended by Ingo). The latter is a
nice drop-in replacement and seems to be very fast and scale well.
Right now we are bottlenecked on uprobe->register_rwsem (not
uprobes_treelock anymore), which is currently limiting the scalability
of uprobes and I'm going to work on that next once I'm done with this
series.

>
>  static struct uprobe *__insert_uprobe(struct uprobe *uprobe)
> @@ -702,7 +724,9 @@ static struct uprobe *insert_uprobe(struct uprobe *up=
robe)
>         struct uprobe *u;
>
>         write_lock(&uprobes_treelock);
> +       write_seqcount_begin(&uprobes_seqcount);
>         u =3D __insert_uprobe(uprobe);
> +       write_seqcount_end(&uprobes_seqcount);
>         write_unlock(&uprobes_treelock);
>
>         return u;
> @@ -936,7 +960,9 @@ static void delete_uprobe(struct uprobe *uprobe)
>                 return;
>
>         write_lock(&uprobes_treelock);
> +       write_seqcount_begin(&uprobes_seqcount);
>         rb_erase(&uprobe->rb_node, &uprobes_tree);
> +       write_seqcount_end(&uprobes_seqcount);
>         write_unlock(&uprobes_treelock);
>         RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
>         put_uprobe(uprobe);

