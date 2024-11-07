Return-Path: <bpf+bounces-44249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 415749C0AA9
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 17:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0DAAB2295F
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 16:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B8E2144D6;
	Thu,  7 Nov 2024 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0Pdl6im"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABCC6FB0;
	Thu,  7 Nov 2024 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995279; cv=none; b=ZanktVT5XKAthJol2LM+Xazd7UcdjTouaSXV/BkaA0UOdxFgQ1Ohz5FeaNykAX/Z/UIw8VA8wGy0TrfKDF2GIrO9mI2OiSj6QeW30j8q2w5QS2x8Nm1yqRcBHeHNzeR9+J10IBXY14EozCCHz0X/SYOt31xoqmOoCTNHopJw1BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995279; c=relaxed/simple;
	bh=+DNeMhf4/QAjfH4tX1M2fXMMTGcpvoQmFrscaEi7qVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4yAvgeuTH4hpeQSvxlH72w8LE15aHz1ki9vYZRDxExdmoWstGIRdvTK9VmYbb87EE1pI/T46pvYI+xxfxdjwxJupQg9Ex+YwcTCfgkggycfJJxApwQeXizXPYOiqkUiG6t2mweDm1aEQZ3aklUzVz8YA0dK7gwet1dujXS1/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0Pdl6im; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2cc469c62so829479a91.2;
        Thu, 07 Nov 2024 08:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730995277; x=1731600077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GsBpHXBN7WYjyLsOqeXFU2jUxVAbP9Ec9maZf8+ATk=;
        b=Q0Pdl6imViz34D+aJ8EyfMe9OIniEUZ4+Tx+Zp9P+jHE6kHKcDDuRe6o9rv1vQ1utB
         QlS9gpL9gysvPWEtjkTM8/R/rppQ+3e1sOMeOFpCcgLWkF//vm+rCC3n9t54RtwzdTQv
         i+Z9OuC0Jpd5AxLFpjyEdFtu6o9RU8R1/095INlJVIHjjrKUjgPS1Oj0uQQz48MmBMa2
         Wti73LZkNegeOqTUvNstWZCsrNcWVPeGrDNwz0X6eHspa7WxvttTtW6ob7wXqsSDorX4
         1iZM9oJKgGyKunQrwkDsj8Jg294rKF+dGMd86nZzDNnnQiDj4pSSff9xZxSy5HmYX7je
         DHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730995277; x=1731600077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9GsBpHXBN7WYjyLsOqeXFU2jUxVAbP9Ec9maZf8+ATk=;
        b=CKmxOuuSJ0NaxPH0Pl12izHJ+RJ4pqPmyXCev/27QO0ujLRkqxGzY+5kbrdEY9uoiQ
         YLGKW41bZ1SNcLgyS5hXvwoWSYqdrdkGKbsoF37rGgQRS0iWsCHm9ToG7pLuT6Pe6U/A
         ndFjcm9eh4/j0OK+AWn+B9CzBsj/+uAgQU3mNy0u0MqBfgPzUdtEYquACS9Tf2iMCALD
         y5XSe1ywcB6l9Tpnr6CbrmpnuNpre9bOU0hPrlWJwoh076NyZsLyqZuYO557mqjkqykj
         lBXq9FPaYlChxpQQko6LA5On4N3iHt/ZfJUdWhDQ8eFllsWQyl4FNUIvW+CdGih3Gs0z
         HQxg==
X-Forwarded-Encrypted: i=1; AJvYcCU82lnNXjpqtq4zRewbuztBq5UTu9NxR/wgPvHReeLFVwcIWrCSUfMT5YrOf1f0xyGaolw=@vger.kernel.org, AJvYcCW8wyeXPGwXMWCsJdc1h/D6bHIRHjyWUUlV6ugWhF2ndJoqO6G6lb8id23svI6iUOgBLksQhPrlJK/Hdg+SvmAxvRgV@vger.kernel.org, AJvYcCXpfJ7gqEbC+vjOLjc8zX3sdOz6vp2fA5DPcmQ0l2A6yNqWHPJdVFSB8GOlZbgZSkwM5y6RXY9Gel4HJVDq@vger.kernel.org
X-Gm-Message-State: AOJu0YzBe/kEfNB5RDwaBEtd3wD+sSKAMJeQyizHXatvrP6a6qFgmvIM
	8i+4KkaqKL5noCMFvX0fctfNnWlRB811YtRlsriR8yLdyhsy96/XQ9GfY3q7DvcznJPHZ83W8v8
	RiJWq/DhyZGHtn2LGidLMi0Om0xNlM8/E
X-Google-Smtp-Source: AGHT+IEB2f7SlTnpo6K8Xm46OWu/LpB+oG0oeij4NBEcfG4ee4/a4WvRtBx8gMEgYRVXPQe/sna3Y/rLtNIYBwjZFTQ=
X-Received: by 2002:a17:90b:2d8c:b0:2e2:d3f6:6efc with SMTP id
 98e67ed59e1d1-2e94c50d05amr32746040a91.28.1730995277245; Thu, 07 Nov 2024
 08:01:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903174603.3554182-1-andrii@kernel.org> <20240903174603.3554182-5-andrii@kernel.org>
 <20241106-transparent-athletic-ammonite-586af8@leitao> <CAEf4Bza3+WYN8dstn1v99yeh+G0cjAeRQy8d5GAbvvecLmbO0A@mail.gmail.com>
 <20241107-uncovered-swinging-bull-1e812e@leitao>
In-Reply-To: <20241107-uncovered-swinging-bull-1e812e@leitao>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 7 Nov 2024 08:01:05 -0800
Message-ID: <CAEf4BzanXs4yAexVXdAp-Q-0anmOVCYx+GObvaHPVDnXobkdSA@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] uprobes: travers uprobe's consumer list locklessly
 under SRCU protection
To: Breno Leitao <leitao@debian.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, surenb@google.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 3:35=E2=80=AFAM Breno Leitao <leitao@debian.org> wro=
te:
>
> Hello Andrii,
>
> On Wed, Nov 06, 2024 at 08:25:25AM -0800, Andrii Nakryiko wrote:
> > On Wed, Nov 6, 2024 at 4:03=E2=80=AFAM Breno Leitao <leitao@debian.org>=
 wrote:
> > > On Tue, Sep 03, 2024 at 10:45:59AM -0700, Andrii Nakryiko wrote:
> > > > uprobe->register_rwsem is one of a few big bottlenecks to scalabili=
ty of
> > > > uprobes, so we need to get rid of it to improve uprobe performance =
and
> > > > multi-CPU scalability.
> > > >
> > > > First, we turn uprobe's consumer list to a typical doubly-linked li=
st
> > > > and utilize existing RCU-aware helpers for traversing such lists, a=
s
> > > > well as adding and removing elements from it.
> > > >
> > > > For entry uprobes we already have SRCU protection active since befo=
re
> > > > uprobe lookup. For uretprobe we keep refcount, guaranteeing that up=
robe
> > > > won't go away from under us, but we add SRCU protection around cons=
umer
> > > > list traversal.
> > >
> > > I am seeing the following message in a kernel with RCU_PROVE_LOCKING:
> > >
> > >         kernel/events/uprobes.c:937 RCU-list traversed without holdin=
g the required lock!!
> > >
> > > It seems the SRCU is not held, when coming from mmap_region ->
> > > uprobe_mmap. Here is the message I got in my debug kernel. (sorry for
> > > not decoding it, but, the stack trace is clear enough).
> > >
> > >          WARNING: suspicious RCU usage
> > >            6.12.0-rc5-kbuilder-01152-gc688a96c432e #26 Tainted: G    =
    W   E    N
> > >            -----------------------------
> > >            kernel/events/uprobes.c:938 RCU-list traversed without hol=
ding the required lock!!
> > >
> > > other info that might help us debug this:
> > >
> > > rcu_scheduler_active =3D 2, debug_locks =3D 1
> > >            3 locks held by env/441330:
> > >             #0: ffff00021c1bc508 (&mm->mmap_lock){++++}-{3:3}, at: vm=
_mmap_pgoff+0x84/0x1d0
> > >             #1: ffff800089f3ab48 (&uprobes_mmap_mutex[i]){+.+.}-{3:3}=
, at: uprobe_mmap+0x20c/0x548
> > >             #2: ffff0004e564c528 (&uprobe->consumer_rwsem){++++}-{3:3=
}, at: filter_chain+0x30/0xe8
> > >
> > > stack backtrace:
> > >            CPU: 4 UID: 34133 PID: 441330 Comm: env Kdump: loaded Tain=
ted: G        W   E    N 6.12.0-rc5-kbuilder-01152-gc688a96c432e #26
> > >            Tainted: [W]=3DWARN, [E]=3DUNSIGNED_MODULE, [N]=3DTEST
> > >            Hardware name: Quanta S7GM 20S7GCU0010/S7G MB (CG1), BIOS =
3D22 07/03/2024
> > >            Call trace:
> > >             dump_backtrace+0x10c/0x198
> > >             show_stack+0x24/0x38
> > >             __dump_stack+0x28/0x38
> > >             dump_stack_lvl+0x74/0xa8
> > >             dump_stack+0x18/0x28
> > >             lockdep_rcu_suspicious+0x178/0x2c8
> > >             filter_chain+0xdc/0xe8
> > >             uprobe_mmap+0x2e0/0x548
> > >             mmap_region+0x510/0x988
> > >             do_mmap+0x444/0x528
> > >             vm_mmap_pgoff+0xf8/0x1d0
> > >             ksys_mmap_pgoff+0x184/0x2d8
> > >
> > >
> > > That said, it seems we want to hold the SRCU, before reaching the
> > > filter_chain(). I hacked a bit, and adding the lock in uprobe_mmap()
> > > solves the problem, but, I might be missing something, since I am not=
 familiar
> > > with this code.
> > >
> > > How does the following patch look like?
> > >
> > > commit 1bd7bcf03031ceca86fdddd8be2e5500497db29f
> > > Author: Breno Leitao <leitao@debian.org>
> > > Date:   Mon Nov 4 06:53:31 2024 -0800
> > >
> > >     uprobes: Get SRCU lock before traverseing the list
> > >
> > >     list_for_each_entry_srcu() is being called without holding the lo=
ck,
> > >     which causes LOCKDEP (when enabled with RCU_PROVING) to complain =
such
> > >     as:
> > >
> > >             kernel/events/uprobes.c:937 RCU-list traversed without ho=
lding the required lock!!
> > >
> > >     Get the SRCU uprobes_srcu lock before calling filter_chain(), whi=
ch
> > >     needs to have the SRCU lock hold, since it is going to call
> > >     list_for_each_entry_srcu().
> > >
> > >     Signed-off-by: Breno Leitao <leitao@debian.org>
> > >     Fixes: cc01bd044e6a ("uprobes: travers uprobe's consumer list loc=
klessly under SRCU protection")
> > >
> > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > index 4b52cb2ae6d62..cc9d4ddeea9a6 100644
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -1391,6 +1391,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
> > >         struct list_head tmp_list;
> > >         struct uprobe *uprobe, *u;
> > >         struct inode *inode;
> > > +       int srcu_idx;
> > >
> > >         if (no_uprobe_events())
> > >                 return 0;
> > > @@ -1409,6 +1410,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
> > >
> > >         mutex_lock(uprobes_mmap_hash(inode));
> > >         build_probe_list(inode, vma, vma->vm_start, vma->vm_end, &tmp=
_list);
> > > +       srcu_idx =3D srcu_read_lock(&uprobes_srcu);
> >
> > Thanks for catching that (production testing FTW, right?!).
>
> Correct. I am running some hosts with RCU_PROVING and I am finding some
> cases where RCU protected areas are touched without holding the RCU read
> lock.
>
> > But I think you a) adding wrong RCU protection flavor (it has to be
> > rcu_read_lock_trace()/rcu_read_unlock_trace(), see uprobe_apply() for
> > an example) and b) I think this is the wrong place to add it. We
> > should add it inside filter_chain(). filter_chain() is called from
> > three places, only one of which is already RCU protected (that's the
> > handler_chain() case). But there is also register_for_each_vma(),
> > which needs RCU protection as well.
>
> Thanks for the guidance!
>
> My initial plan was to protect filter_chain(), but, handler_chain()
> already has the lock. Is it OK to get into a critical section in a
> nested form?
>
> The code will be something like:
>
> handle_swbp() {
>         rcu_read_lock_trace();
>         handler_chain() {
>                 filter_chain() {
>                         rcu_read_lock_trace();
>                         list_for_each_entry_rcu()
>                         rcu_read_lock_trace();
>                 }
>         }
>         rcu_read_lock_trace();
> }
>
> Is this nested locking fine?
>

Yes, it's totally fine to nest RCU lock regions.

> Thanks
> --breno

