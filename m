Return-Path: <bpf+bounces-44227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7189C0438
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 12:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD252818FD
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 11:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2457820F5A3;
	Thu,  7 Nov 2024 11:35:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E544A20ADD6;
	Thu,  7 Nov 2024 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979354; cv=none; b=K7qPsoByOiERW6hpd27gN+dSKafxj416HJ5mlyrc1YpSaDSCvemuXElKODSvb4hjPAAWKtlIoetw6ae71pl34eUjRHs2dlRwjlMFNYew3RnXxKvK+SHAxbx8Mn4sOmASRnpfyOvnwytWV+7dJVgPYqgPycZPwH0HbukF47WMzfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979354; c=relaxed/simple;
	bh=+45rwzHHzZwHpCDhjeT7gGDIbLU7KOJsi00kkm4HAck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgvuOg56E1mq3BHo29rSB3teZWMMIrZ0ReoF++MMFn6lBChwT5KRI071BFo66zID3yhg0DkKZKGwMKmKbthb7e+A4Gpu6WeI6m1yBOcGlWgwx5O5P/MhFPulj5kzFumObWUJ5BYrLD5ryYZUze+DN0mGpkj6gzATXjdRSOCbPvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cf04f75e1aso663850a12.1;
        Thu, 07 Nov 2024 03:35:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730979351; x=1731584151;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=se/Mp7TgFQ1n2wTANvee737jkMqUK/eE4DjvvRz1c2U=;
        b=aYwF8zkHhBC8KFmCFyv+mdkJb/Gsfv0FGiDzHxecbVDIMcHNTvW/21/XpNpBrSdlWp
         6L5hKWWsar6SA+9L4JiuB9miZaWnh0nnpis8bMfM4VMWErT3JOkXgXNBUyItnb9J8AD1
         HpD2g5mgXI/W2lbc/ykQg9+HNqiWyoi8F9IZbVHjSnOCBpjVBRZ56D1eT1LEYA6P1DSp
         fWNPoVB5xOceYwf3zgZ2Ua2wpPvBRLpVwaVLpqWMJXGwbXNMJfBjS+flSSwbT7pxA0w9
         2N69TgDPMwo25eUN+Obp9IWmAfi92mID1kqXj5CiZPE7FvnvCNNnLmCh7gxUSYe7P9n+
         HrkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb5F1DGCAUSQdYMwAA8zVWOkh//Gy3L/lZcoIHBTosO1aRVlOIKavJ+afSh5I21BpIVpvqDkRg3/HAXH5EgxXNvTHN@vger.kernel.org, AJvYcCXWFCgcQOXxHl9FGHbzJ4OuwbeqpJ4TMPpz7ymb/+U0ylukAJAjhwWBtIo0RkKyvFCBlS7x5NwDuNKWklTb@vger.kernel.org, AJvYcCXvsFHDRZpDVA/iU3r6vXVfvhcW03Yu6NvNstt2zO7tNV1zMGJ/fpjU4qg3KbFmO0ksj2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz0cRjZCU0IHhDacO/FnY64o3JKZtod1fwTXx8eukdXG9/r7ja
	jb2ZrfWprTps3aX66Rp1zs3ItJqN93A7eWEmB1aCK9ZzP+hlNQ57
X-Google-Smtp-Source: AGHT+IEtW2euZBjaf0HPobx7Tu/xvypqIcN8DQqJ7iuwfQr9wuHzlcMR9PCSG7w/pviG4WSUGR3VMw==
X-Received: by 2002:a05:6402:2712:b0:5cf:4f2:e062 with SMTP id 4fb4d7f45d1cf-5cf04f2eb00mr1263365a12.8.1730979350939;
        Thu, 07 Nov 2024 03:35:50 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03b7e7f8sm683615a12.23.2024.11.07.03.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 03:35:50 -0800 (PST)
Date: Thu, 7 Nov 2024 03:35:47 -0800
From: Breno Leitao <leitao@debian.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org,
	mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v5 4/8] uprobes: travers uprobe's consumer list
 locklessly under SRCU protection
Message-ID: <20241107-uncovered-swinging-bull-1e812e@leitao>
References: <20240903174603.3554182-1-andrii@kernel.org>
 <20240903174603.3554182-5-andrii@kernel.org>
 <20241106-transparent-athletic-ammonite-586af8@leitao>
 <CAEf4Bza3+WYN8dstn1v99yeh+G0cjAeRQy8d5GAbvvecLmbO0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza3+WYN8dstn1v99yeh+G0cjAeRQy8d5GAbvvecLmbO0A@mail.gmail.com>

Hello Andrii,

On Wed, Nov 06, 2024 at 08:25:25AM -0800, Andrii Nakryiko wrote:
> On Wed, Nov 6, 2024 at 4:03 AM Breno Leitao <leitao@debian.org> wrote:
> > On Tue, Sep 03, 2024 at 10:45:59AM -0700, Andrii Nakryiko wrote:
> > > uprobe->register_rwsem is one of a few big bottlenecks to scalability of
> > > uprobes, so we need to get rid of it to improve uprobe performance and
> > > multi-CPU scalability.
> > >
> > > First, we turn uprobe's consumer list to a typical doubly-linked list
> > > and utilize existing RCU-aware helpers for traversing such lists, as
> > > well as adding and removing elements from it.
> > >
> > > For entry uprobes we already have SRCU protection active since before
> > > uprobe lookup. For uretprobe we keep refcount, guaranteeing that uprobe
> > > won't go away from under us, but we add SRCU protection around consumer
> > > list traversal.
> >
> > I am seeing the following message in a kernel with RCU_PROVE_LOCKING:
> >
> >         kernel/events/uprobes.c:937 RCU-list traversed without holding the required lock!!
> >
> > It seems the SRCU is not held, when coming from mmap_region ->
> > uprobe_mmap. Here is the message I got in my debug kernel. (sorry for
> > not decoding it, but, the stack trace is clear enough).
> >
> >          WARNING: suspicious RCU usage
> >            6.12.0-rc5-kbuilder-01152-gc688a96c432e #26 Tainted: G        W   E    N
> >            -----------------------------
> >            kernel/events/uprobes.c:938 RCU-list traversed without holding the required lock!!
> >
> > other info that might help us debug this:
> >
> > rcu_scheduler_active = 2, debug_locks = 1
> >            3 locks held by env/441330:
> >             #0: ffff00021c1bc508 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x84/0x1d0
> >             #1: ffff800089f3ab48 (&uprobes_mmap_mutex[i]){+.+.}-{3:3}, at: uprobe_mmap+0x20c/0x548
> >             #2: ffff0004e564c528 (&uprobe->consumer_rwsem){++++}-{3:3}, at: filter_chain+0x30/0xe8
> >
> > stack backtrace:
> >            CPU: 4 UID: 34133 PID: 441330 Comm: env Kdump: loaded Tainted: G        W   E    N 6.12.0-rc5-kbuilder-01152-gc688a96c432e #26
> >            Tainted: [W]=WARN, [E]=UNSIGNED_MODULE, [N]=TEST
> >            Hardware name: Quanta S7GM 20S7GCU0010/S7G MB (CG1), BIOS 3D22 07/03/2024
> >            Call trace:
> >             dump_backtrace+0x10c/0x198
> >             show_stack+0x24/0x38
> >             __dump_stack+0x28/0x38
> >             dump_stack_lvl+0x74/0xa8
> >             dump_stack+0x18/0x28
> >             lockdep_rcu_suspicious+0x178/0x2c8
> >             filter_chain+0xdc/0xe8
> >             uprobe_mmap+0x2e0/0x548
> >             mmap_region+0x510/0x988
> >             do_mmap+0x444/0x528
> >             vm_mmap_pgoff+0xf8/0x1d0
> >             ksys_mmap_pgoff+0x184/0x2d8
> >
> >
> > That said, it seems we want to hold the SRCU, before reaching the
> > filter_chain(). I hacked a bit, and adding the lock in uprobe_mmap()
> > solves the problem, but, I might be missing something, since I am not familiar
> > with this code.
> >
> > How does the following patch look like?
> >
> > commit 1bd7bcf03031ceca86fdddd8be2e5500497db29f
> > Author: Breno Leitao <leitao@debian.org>
> > Date:   Mon Nov 4 06:53:31 2024 -0800
> >
> >     uprobes: Get SRCU lock before traverseing the list
> >
> >     list_for_each_entry_srcu() is being called without holding the lock,
> >     which causes LOCKDEP (when enabled with RCU_PROVING) to complain such
> >     as:
> >
> >             kernel/events/uprobes.c:937 RCU-list traversed without holding the required lock!!
> >
> >     Get the SRCU uprobes_srcu lock before calling filter_chain(), which
> >     needs to have the SRCU lock hold, since it is going to call
> >     list_for_each_entry_srcu().
> >
> >     Signed-off-by: Breno Leitao <leitao@debian.org>
> >     Fixes: cc01bd044e6a ("uprobes: travers uprobe's consumer list locklessly under SRCU protection")
> >
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 4b52cb2ae6d62..cc9d4ddeea9a6 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -1391,6 +1391,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
> >         struct list_head tmp_list;
> >         struct uprobe *uprobe, *u;
> >         struct inode *inode;
> > +       int srcu_idx;
> >
> >         if (no_uprobe_events())
> >                 return 0;
> > @@ -1409,6 +1410,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
> >
> >         mutex_lock(uprobes_mmap_hash(inode));
> >         build_probe_list(inode, vma, vma->vm_start, vma->vm_end, &tmp_list);
> > +       srcu_idx = srcu_read_lock(&uprobes_srcu);
> 
> Thanks for catching that (production testing FTW, right?!).

Correct. I am running some hosts with RCU_PROVING and I am finding some
cases where RCU protected areas are touched without holding the RCU read
lock.

> But I think you a) adding wrong RCU protection flavor (it has to be
> rcu_read_lock_trace()/rcu_read_unlock_trace(), see uprobe_apply() for
> an example) and b) I think this is the wrong place to add it. We
> should add it inside filter_chain(). filter_chain() is called from
> three places, only one of which is already RCU protected (that's the
> handler_chain() case). But there is also register_for_each_vma(),
> which needs RCU protection as well.

Thanks for the guidance!

My initial plan was to protect filter_chain(), but, handler_chain()
already has the lock. Is it OK to get into a critical section in a
nested form?

The code will be something like:

handle_swbp() {
	rcu_read_lock_trace();
	handler_chain() {
		filter_chain() {
			rcu_read_lock_trace();
			list_for_each_entry_rcu()
			rcu_read_lock_trace();
		}
	}
	rcu_read_lock_trace();
}

Is this nested locking fine?

Thanks
--breno

