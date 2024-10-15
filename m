Return-Path: <bpf+bounces-41975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDB999E032
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 10:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7A21C20F6C
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 08:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70571B4F02;
	Tue, 15 Oct 2024 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZnTg+VYs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F821A7AF1
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 08:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979414; cv=none; b=f/x7As/oPoSEdE4goTvt333GT01dxbZDHIlDjDcP5gkjvq5a+VvfSXpVRjqSd3ZkBiJFnT06bSzl1GBAQuFmgsAA7lHPKY04onWlEJefBGeGoDDS2S2ZfrYOzKDnCK0rip++YlXquxyaiIEsH6Bh6jbFEj/5oG4LKZ+ywP5lkc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979414; c=relaxed/simple;
	bh=EInbJTWQIXN5jkIPg2sKpT7dUQFA8FtF+mTLVVrhm0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGo/zUNio4aOPWwvQkOI1MKAyGuofMefBSRP6rdjPowFwYOcW34hw1i6p6nNGW9dsnRsV8K8yh1bDYBC6qXPQ8tRUBQkkQy38DmTq4776dbsPT56lhXzLKxJ2RAz1MuZRt1OPwN1Pnp0NK5f05lGg9RDs969AWxvPvs1RjkWbeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZnTg+VYs; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f7606199so1875185e87.0
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 01:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979411; x=1729584211; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N3sV+MUjmkm/3ouMm/VZqChWo6gbDHYg+6Mp7oGExyw=;
        b=ZnTg+VYsSV6PHM8jxNR3P1xYZp8uLraKqunRH4V5w56zdABWefNOwupQnEUEDokEJ/
         JGCs06aLbiTyCj4lHR8qDBvCz1WWy9zCK14d9bZUBjr0cNi2oIOPdDHq+sHsWbX/8Qlq
         usqWvHz5azFz1PdoB/NY9c530kHkgNdQOS2Hu54DeHUfZUprH0XBBmRWufQqqKTYThmN
         GUosmVrPkJZH1U0gfdXBPi9xrcITtwTt5qCV5AIQlNEwIc5xpvZ/hC6fDRTKMlTV3PZK
         RbE9E2sY8ZPCDn5DWr7ou/dIxsnIouZutGXv2MzXnCf6b6wyhhRhhWtu6/Y76rJGcR7i
         KQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979411; x=1729584211;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N3sV+MUjmkm/3ouMm/VZqChWo6gbDHYg+6Mp7oGExyw=;
        b=fxigyOSuwhVWLAHYREqXf/yJ6duWdGhJOEOmWfg/wTeh/XUvOOplEEAEkvxfVVr85C
         EYfZNbdI/lsqS9IdIkrHLvggF+Dmf0KQA5BF710V8qFIjiDFWkppbEOqEPQ5VREm4wcv
         jSAC69zYqkMpmRtQjRtvtWDS6vVuWV/WJpyNhKPwmhvnmg8rjmogK1HUlOcp9J2M5jB5
         7J/SaPean89w6X3SlkxVLIKkdqiDBehX6KXwyQaTVODurCC0hAkeLirDYX5mSGbzXrmn
         kivTpUPAxLP0qpa9t6nTIu0HoeEUawu4amBYI+VZHWW9UQne9Qd3XhDwLSN73l3fkHyj
         Op1A==
X-Forwarded-Encrypted: i=1; AJvYcCXlM74VmkKJM2buKqPLsZ/vZv70nUnq84BxiOQfjikt15eYkSfK4ehzCUolRpa1v9MR54g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt0n5v3yJsgFvTEXmWwW3OolNErZcGAJf5zV8tYG1UR4Qj9MC9
	sKWS+uwj/zuIjhKUvbw7A1DR6QZSgcEEQI/ZesnweX0yn+RjWYyYZyb//A2jfhTi40O6FtYbPmx
	nxABakUc60sHb3xQsQhYH/VxPGG10zmSHkTzv
X-Google-Smtp-Source: AGHT+IFuAWCk0O3DiGt2jLIMMRZ+47uA58eN9z+L/2D1jR0fxGLSvk7WvgKy8tyjVoe9CKGvpjScJIML7omeA5rPTic=
X-Received: by 2002:a05:6512:3f02:b0:536:5625:511a with SMTP id
 2adb3069b0e04-539da59516cmr7172856e87.47.1728979410474; Tue, 15 Oct 2024
 01:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010003550.3695245-1-shakeel.butt@linux.dev>
 <CAJD7tkYq+dduc7+M=9TkR6ZAiBYrVyUsF_AuwPqaQNrsfH_qfg@mail.gmail.com>
 <20241009210848.43adb0c3@gandalf.local.home> <CAJD7tkaLQwVphoLiwh8-NTyav36_gAVdzB=gC_qXzv7ti9TzmA@mail.gmail.com>
 <mt474r4yn346in5akhyziwxrh4ip5wukh4fjbhwzfl26wq64nf@xgbv4dtfs3ak>
 <CAJD7tkYzo_K9uF7GOO3yoKzTSbFWuNTUG3O6w1VrGCQvgWhsoQ@mail.gmail.com> <cwibnvqnbtfc7sgpkidh24dcnj2xdb462rf6hndgynqezbzbaf@qog4zl25sqry>
In-Reply-To: <cwibnvqnbtfc7sgpkidh24dcnj2xdb462rf6hndgynqezbzbaf@qog4zl25sqry>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 15 Oct 2024 01:02:52 -0700
Message-ID: <CAJD7tkYhYiDj5RSvRnK7uLG82pPLv_f5c4nBgQQCGNJWn9qRjw@mail.gmail.com>
Subject: Re: [PATCH] memcg: add tracing for memcg stat updates
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"

> > > > > > > @@ -682,7 +686,9 @@ void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
> > > > > > >                 return;
> > > > > > >
> > > > > > >         __this_cpu_add(memcg->vmstats_percpu->state[i], val);
> > > > > > > -       memcg_rstat_updated(memcg, memcg_state_val_in_pages(idx, val));
> > > > > > > +       val = memcg_state_val_in_pages(idx, val);
> > > > > > > +       memcg_rstat_updated(memcg, val);
> > > > > > > +       trace_mod_memcg_state(memcg, idx, val);
> > > > > >
> > > > > > Is it too unreasonable to include the stat name?
> > > > > >
> > > > > > The index has to be correlated with the kernel config and perhaps even
> > > > > > version. It's not a big deal, but if performance is not a concern when
> > > > > > tracing is enabled anyway, maybe we can lookup the name here (or in
> > > > > > TP_fast_assign()).
> > > > >
> > > > > What name? Is it looked up from idx? If so, you can do it on the reading of
> > >
> > > Does reading side mean the one reading /sys/kernel/tracing/trace will do
> > > the translation from enums to string?
> > >
> > > > > the trace event where performance is not an issue. See the __print_symbolic()
> > > > > and friends in samples/trace_events/trace-events-sample.h
> > > >
> > > > Yeah they can be found using idx. Thanks for referring us to
> > > > __print_symbolic(), I suppose for this to work we need to construct an
> > > > array of {idx, name}. I think we can replace the existing memory_stats
> > > > and memcg1_stats/memcg1_stat_names arrays with something that we can
> > > > reuse for tracing, so we wouldn't need to consume extra space.
> > > >
> > > > Shakeel, what do you think?
> > >
> > > Cc Daniel & Martin
> > >
> > > I was planning to use bpftrace which can use dwarf/btf to convert the
> > > raw int to its enum string. Martin provided the following command to
> > > extract the translation from the kernel.
> > >
> > > $ bpftool btf dump file /sys/kernel/btf/vmlinux | grep -A10 node_stat_item
> > > [2264] ENUM 'node_stat_item' encoding=UNSIGNED size=4 vlen=46
> > >         'NR_LRU_BASE' val=0
> > >         'NR_INACTIVE_ANON' val=0
> > >         'NR_ACTIVE_ANON' val=1
> > >         'NR_INACTIVE_FILE' val=2
> > >         'NR_ACTIVE_FILE' val=3
> > >         'NR_UNEVICTABLE' val=4
> > >         'NR_SLAB_RECLAIMABLE_B' val=5
> > >         'NR_SLAB_UNRECLAIMABLE_B' val=6
> > >         'NR_ISOLATED_ANON' val=7
> > >         'NR_ISOLATED_FILE' val=8
> > > ...
> > >
> > > My point is userspace tools can use existing infra to extract this
> > > information.
> > >
> > > However I am not against adding __print_symbolic() (but without any
> > > duplication), so users reading /sys/kernel/tracing/trace directly can
> > > see more useful information as well. Please post a follow up patch after
> > > this one.
> >
> > I briefly looked into this and I think it would be annoying to have
> > this, unfortunately. Even if we rework the existing arrays with memcg
> > stat names to be in a format conforming to tracing, we would need to
> > move them out to a separate header to avoid a circular dependency.
> >
> > Additionally, for __count_memcg_events() things will be more
> > complicated because the names are not in an array in memcontrol.c, but
> > we use vm_event_name() and the relevant names are part of a larger
> > array, vmstat_text, which we would need to rework similarly.
> >
> > I think this would be easier to implement if we can somehow provide a
> > callback that returns the name based on the index, rather than an
> > array. But even then, we would need to specify a different callback
> > for each event, so it won't be as simple as specifying the callback in
> > the event class.
> >
> > All in all, unless we realize there is something that is fundamentally
> > more difficult to do in userspace, I think it's not worth adding this
> > unfortunately :/
>
> Turned out to be quite straightforward to do in userspace:
> https://github.com/bpftrace/bpftrace/pull/3515 .
>
> A nice property is the resolution occurs out of line and saves the
> kernel some cycles in the fast path.

This is really neat, thanks for doing this! Native support in bpftrace
is definitely better than manually correlating the values, especially
with large enums with 10s of values like the ones we are talking about
here.

