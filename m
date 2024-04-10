Return-Path: <bpf+bounces-26404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9DA89F002
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 12:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B13282F18
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 10:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCC41598E9;
	Wed, 10 Apr 2024 10:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cub5Yho1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781FD1598E3;
	Wed, 10 Apr 2024 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745499; cv=none; b=SKsmZ9PmFBsXiguF140GK5V6cRH1Iu8zliw2bt/MN7DT9N6CcRw6hRNiZI1zWnr8uVa21cuwtrGXS4/ZfYbQM9I5O+ouqesBpn9tI4AFf3zL+Hb1QTOk9M/01HhGEaohkgATfOJmfnl96hm4KEFLj0YB4aDcSapQHQi3xY7wwrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745499; c=relaxed/simple;
	bh=MU97HWzzufib2i+BTEe30Fyq72OAe6GNJD9wg7v4RMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtfGbvh0J8zk9/IqUEosTW6tWtMKURcSXBIu3R0Hjy10v2CgOmXnWgMW09VaD9H6nwzceW71RLnYaYByZM7tQiA+x1DtHbEZyStgSAWh90NQSyq9DD/LPdecYglEODsXmWmRt3Zcsx1RofJBnYePX378myXaxFRw1nvtVrf5Cws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cub5Yho1; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so1087646966b.1;
        Wed, 10 Apr 2024 03:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712745496; x=1713350296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U50Al2xpMhqhfVIBtuFt5jjA3qV5pu0Q+vEvtqqKYBA=;
        b=Cub5Yho138qWP13ChK40+3DqWO3aJsDva/Jz/scBjoYLmz83k9miUYIZM40EO1E7WY
         jMnSfaH2SRwS0NH6O9+5+tLbhpP/5C2C7Wa8w5mV5a2VYGkDbR74C/BEHARIVbNNALt2
         sT9Ko1YzYs/Gw8xj7Pc4zEci2Zf7BNOhlSmoL1QPp48lV7HNn6eCgroiJhQdVveS84kg
         ZQQXFbnSeyOMoaBys8DWzLi+hjs/kUdj0che7L2iykQAC0iK8sUkod1ROUbkxu6R/Jql
         cm9GJlC5bqEK3X8BBIH3+8ME8DeUe25clENaND/AG6XD60aO3VdYjRk3GQe4BCMOi3qy
         046Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712745496; x=1713350296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U50Al2xpMhqhfVIBtuFt5jjA3qV5pu0Q+vEvtqqKYBA=;
        b=r49RMxBlLiPLsvZRWerxZDKEMGxhvPV/5eQZeLSV66+qntWP+DDx8syNeKN5fpwRW4
         Pg3QkfrB3cK+yIvrc4ZhrjxQbT3Yet+r6xgFuYyrcDsN74skPqvh5OwwHCGo3REoeNyp
         vRkaBdOPpWHQd23IN6PDd6kTvjorFm+UO574UhNd5//SQkGJmktHZxtLLz21pTAl4aRD
         k7wDfolORj5LmymXYsd6RsruOfl9FriVXaxQAzTXJUd4BnqK57rVkq5ltE3gjdXWP7La
         Ki1MX7KCpe0v39Q7H7AxaWl/swAGzaecjrUPv5BdxVq0mVS01+D4DQ4kGckCSy9aFE/X
         IteA==
X-Forwarded-Encrypted: i=1; AJvYcCU7vF68sCxLN7BJSe6FRul43LX+kGj4Ls7xrNBbTxk+SILm0UWP2o5hF4kh95iAG+MNgSYZ/2H5Sd/lEHvWb2B2ZMO51AMHAo77maDyY4LBRCgCLl7BenQkNhstE1HYYD59mHD1viZAZShbJ2Fb+KlMEDJGD2r0wCxZIJRLlTyCnmB4TvMF6VpFiSQ715jMn57/wdZPQ+dB8dsJgLDNA5WpZ6KgxSZWlw==
X-Gm-Message-State: AOJu0Yxob5PBSnOPlhVX6v4XdPBmlmwBqAt98CMv7Z1CXdDHsACZB4/T
	99O6vQtS9hnIVTa8Nk3Eq9rBLbc255hzIP3kH5+Ex7FfP2DwsJXZ/tAqohJgogI=
X-Google-Smtp-Source: AGHT+IFwLjKjWVfy1fTAk3eO+Dlpfj9SGsTOE9DETZJW8nYLdZEvisol9IihxQ+jq8jG7jUIa6NRyw==
X-Received: by 2002:a17:907:7d8f:b0:a52:68f:d141 with SMTP id oz15-20020a1709077d8f00b00a52068fd141mr2419289ejc.4.1712745495515;
        Wed, 10 Apr 2024 03:38:15 -0700 (PDT)
Received: from jonhaslam-mbp.dhcp.thefacebook.com ([2620:10d:c092:500::5:e0d6])
        by smtp.gmail.com with ESMTPSA id se1-20020a170906ce4100b00a51a9d87570sm6530946ejb.17.2024.04.10.03.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 03:38:14 -0700 (PDT)
Date: Wed, 10 Apr 2024 11:38:11 +0100
From: Jonthan Haslam <jonathan.haslam@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	linux-trace-kernel@vger.kernel.org, andrii@kernel.org, bpf@vger.kernel.org, rostedt@goodmis.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: reduce contention on uprobes_tree access
Message-ID: <lcc6lnkbfnyr6yjvybckevhzaafvh7jmpse6tnviq5bjar3y6z@yvz6cuzjzrky>
References: <20240321145736.2373846-1-jonathan.haslam@gmail.com>
 <20240325120323.ec3248d330b2755e73a6571e@kernel.org>
 <CAEf4BzZS_QCsSY0oGY_3pGveGfXKK_TkVURyNq=UQXVXSqi2Fw@mail.gmail.com>
 <20240327084245.a890ae12e579f0be1902ae4a@kernel.org>
 <54jakntmdyedadce7yrf6kljcjapbwyoqqt26dnllrqvs3pg7x@itra4a2ikgqw>
 <20240328091841.ce9cc613db375536de843cfb@kernel.org>
 <CAEf4BzYCJWXAzdV3q5ex+8hj5ZFCnu5CT=w8eDbZCGqm+CGYOQ@mail.gmail.com>
 <CAEf4BzbSvMa2+hdTifMKTsNiOL6X=P7eor4LpPKfHM=Y9-71fw@mail.gmail.com>
 <20240330093631.72273967ba818cb16aeb58b6@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240330093631.72273967ba818cb16aeb58b6@kernel.org>

Hi Masami,

> > > Which is why I was asking to land this patch as is, as it relieves the
> > > scalability pains in production and is easy to backport to old
> > > kernels. And then we can work on batched APIs and switch to per-CPU rw
> > > semaphore.
> 
> OK, then I'll push this to for-next at this moment.
> Please share if you have a good idea for the batch interface which can be
> backported. I guess it should involve updating userspace changes too.

Did you (or anyone else) need anything more from me on this one so that it
can be pushed? I provided some benchmark numbers but happy to provide
anything else that may be required.

Thanks!

Jon.

> 
> Thank you!
> 
> > >
> > > So I hope you can reconsider and accept improvements in this patch,
> > > while Jonathan will keep working on even better final solution.
> > > Thanks!
> > >
> > > > I look forward to your formalized results :)
> > > >
> > 
> > BTW, as part of BPF selftests, we have a multi-attach test for uprobes
> > and USDTs, reporting attach/detach timings:
> > $ sudo ./test_progs -v -t uprobe_multi_test/bench
> > bpf_testmod.ko is already unloaded.
> > Loading bpf_testmod.ko...
> > Successfully loaded bpf_testmod.ko.
> > test_bench_attach_uprobe:PASS:uprobe_multi_bench__open_and_load 0 nsec
> > test_bench_attach_uprobe:PASS:uprobe_multi_bench__attach 0 nsec
> > test_bench_attach_uprobe:PASS:uprobes_count 0 nsec
> > test_bench_attach_uprobe: attached in   0.120s
> > test_bench_attach_uprobe: detached in   0.092s
> > #400/5   uprobe_multi_test/bench_uprobe:OK
> > test_bench_attach_usdt:PASS:uprobe_multi__open 0 nsec
> > test_bench_attach_usdt:PASS:bpf_program__attach_usdt 0 nsec
> > test_bench_attach_usdt:PASS:usdt_count 0 nsec
> > test_bench_attach_usdt: attached in   0.124s
> > test_bench_attach_usdt: detached in   0.064s
> > #400/6   uprobe_multi_test/bench_usdt:OK
> > #400     uprobe_multi_test:OK
> > Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> > Successfully unloaded bpf_testmod.ko.
> > 
> > So it should be easy for Jonathan to validate his changes with this.
> > 
> > > > Thank you,
> > > >
> > > > >
> > > > > Jon.
> > > > >
> > > > > >
> > > > > > Thank you,
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > BTW, how did you measure the overhead? I think spinlock overhead
> > > > > > > > will depend on how much lock contention happens.
> > > > > > > >
> > > > > > > > Thank you,
> > > > > > > >
> > > > > > > > >
> > > > > > > > > [0] https://docs.kernel.org/locking/spinlocks.html
> > > > > > > > >
> > > > > > > > > Signed-off-by: Jonathan Haslam <jonathan.haslam@gmail.com>
> > > > > > > > > ---
> > > > > > > > >  kernel/events/uprobes.c | 22 +++++++++++-----------
> > > > > > > > >  1 file changed, 11 insertions(+), 11 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > > > > > > > index 929e98c62965..42bf9b6e8bc0 100644
> > > > > > > > > --- a/kernel/events/uprobes.c
> > > > > > > > > +++ b/kernel/events/uprobes.c
> > > > > > > > > @@ -39,7 +39,7 @@ static struct rb_root uprobes_tree = RB_ROOT;
> > > > > > > > >   */
> > > > > > > > >  #define no_uprobe_events()   RB_EMPTY_ROOT(&uprobes_tree)
> > > > > > > > >
> > > > > > > > > -static DEFINE_SPINLOCK(uprobes_treelock);    /* serialize rbtree access */
> > > > > > > > > +static DEFINE_RWLOCK(uprobes_treelock);      /* serialize rbtree access */
> > > > > > > > >
> > > > > > > > >  #define UPROBES_HASH_SZ      13
> > > > > > > > >  /* serialize uprobe->pending_list */
> > > > > > > > > @@ -669,9 +669,9 @@ static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
> > > > > > > > >  {
> > > > > > > > >       struct uprobe *uprobe;
> > > > > > > > >
> > > > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > > > +     read_lock(&uprobes_treelock);
> > > > > > > > >       uprobe = __find_uprobe(inode, offset);
> > > > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > > > +     read_unlock(&uprobes_treelock);
> > > > > > > > >
> > > > > > > > >       return uprobe;
> > > > > > > > >  }
> > > > > > > > > @@ -701,9 +701,9 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
> > > > > > > > >  {
> > > > > > > > >       struct uprobe *u;
> > > > > > > > >
> > > > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > > > +     write_lock(&uprobes_treelock);
> > > > > > > > >       u = __insert_uprobe(uprobe);
> > > > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > > > +     write_unlock(&uprobes_treelock);
> > > > > > > > >
> > > > > > > > >       return u;
> > > > > > > > >  }
> > > > > > > > > @@ -935,9 +935,9 @@ static void delete_uprobe(struct uprobe *uprobe)
> > > > > > > > >       if (WARN_ON(!uprobe_is_active(uprobe)))
> > > > > > > > >               return;
> > > > > > > > >
> > > > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > > > +     write_lock(&uprobes_treelock);
> > > > > > > > >       rb_erase(&uprobe->rb_node, &uprobes_tree);
> > > > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > > > +     write_unlock(&uprobes_treelock);
> > > > > > > > >       RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
> > > > > > > > >       put_uprobe(uprobe);
> > > > > > > > >  }
> > > > > > > > > @@ -1298,7 +1298,7 @@ static void build_probe_list(struct inode *inode,
> > > > > > > > >       min = vaddr_to_offset(vma, start);
> > > > > > > > >       max = min + (end - start) - 1;
> > > > > > > > >
> > > > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > > > +     read_lock(&uprobes_treelock);
> > > > > > > > >       n = find_node_in_range(inode, min, max);
> > > > > > > > >       if (n) {
> > > > > > > > >               for (t = n; t; t = rb_prev(t)) {
> > > > > > > > > @@ -1316,7 +1316,7 @@ static void build_probe_list(struct inode *inode,
> > > > > > > > >                       get_uprobe(u);
> > > > > > > > >               }
> > > > > > > > >       }
> > > > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > > > +     read_unlock(&uprobes_treelock);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > >  /* @vma contains reference counter, not the probed instruction. */
> > > > > > > > > @@ -1407,9 +1407,9 @@ vma_has_uprobes(struct vm_area_struct *vma, unsigned long start, unsigned long e
> > > > > > > > >       min = vaddr_to_offset(vma, start);
> > > > > > > > >       max = min + (end - start) - 1;
> > > > > > > > >
> > > > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > > > +     read_lock(&uprobes_treelock);
> > > > > > > > >       n = find_node_in_range(inode, min, max);
> > > > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > > > +     read_unlock(&uprobes_treelock);
> > > > > > > > >
> > > > > > > > >       return !!n;
> > > > > > > > >  }
> > > > > > > > > --
> > > > > > > > > 2.43.0
> > > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > >
> > > >
> > > > --
> > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

