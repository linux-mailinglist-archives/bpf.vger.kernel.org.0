Return-Path: <bpf+bounces-27133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BAD8A9851
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 13:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EA7EB24561
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 11:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FA715F304;
	Thu, 18 Apr 2024 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZn6QWcC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C7715E81D;
	Thu, 18 Apr 2024 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713438664; cv=none; b=Vk7hDLwaelOG3I2DxdutcZphjCaE5ohOI/td8nTmy/CufCRIjkj4I7tZtFwb0w9P373Jn6estdiRqVrtsOYvh5dYRYy7fnknKxNgggVT6m4YfU+fOPAvLNuGr0FwXIE0VnCd4by67ANG6ejDIUVi9PgHR5x/SN/DeM81zzt9S40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713438664; c=relaxed/simple;
	bh=jbkjH0oMfHSOLsZFAKrCDRnqKRYEKhNM61Mt/WQOWPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbhtEsb/u+nOIwNOamTExtXH/0Nnc6xkjwRIu75kVOm4wEF3hBneweZNceaiYdr1dwk1MgySwJGYFk763LIV0Q4+e54cAc+trLXRqlzaq3DnsDDFW2RQLwRPIG8T1opOROoXSMps850Vh2ck+A8aLIa480QUrlG6sTOL/4QoWvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZn6QWcC; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a554afec54eso81772066b.1;
        Thu, 18 Apr 2024 04:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713438661; x=1714043461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ajRcHzOO+dTeV5Ygaxyp7yiGlFkKEfT94A9BqR9K7GI=;
        b=bZn6QWcCtu8HyFyjmVBv67KQzxlyE6cBoJb3SmHM/zcH9QzEHrB56+Ya6nZRUyk2jB
         /qQKg1oAiU3vxZAHyO9AaTWfpYS+vborsV/+Bwdg6dUm1IBlF25acF/dhrmzQd3wNCPF
         u0hYXkQ6kQ90S1b/Sl8q1x75SpJ96THddiMFKw1y8LUgQ6sdIYCs3M9/HBVQzXiSsIkX
         wOAhl9WSsNRVEEb6UPaVU1BInBFpoBkFLI3hotgEy7utdIk1uqA73VJvG2LD0xTFvYTu
         fKwUWYIzhIoRLguGC5x4tD1U4D3XSMtOiifScps2caxw+0RsI1j8tz7zOAQjLOVQk6E9
         bwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713438661; x=1714043461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajRcHzOO+dTeV5Ygaxyp7yiGlFkKEfT94A9BqR9K7GI=;
        b=WQeAveBW5FwFwCf03YFSMivblTDhjNyAdpcdq1YokBp0gql9zvMrKem1sL8LD/K4yO
         SIY2MqCNy1oJlWRkcAbCM9mONQl/+T0c5bjHNsdMRnJrDb0CSum60e0IdCnZGiohCBww
         pD6C45AJOqRnB0tR0R9ZJhT0tiVTcQkqUiEejtfoBSvvU7iQhnEgivWFvDXJ5AUnHrCE
         ykm7QGeiJvqHEgCPHoe4VhN/xuv06h03ieE/Qyb2z6/O6IDa+ZrFtaZj5046uDAEktEk
         DP63NjHoTh29TsYE/y3HPqy+XZG0LKbm/M2q6XM1aWHDA7KleS0Jp5H/X1s/sG+JREmy
         OYpA==
X-Forwarded-Encrypted: i=1; AJvYcCUNFIchAa0EjfLUhubPWYNWrW33DMSbnEqZvc6PPNUURM14FO4JOYfttwgz2ri/sMhXoDKnZIJlOuT4l5YOGAqp3ugcStZcuD6f3AgTt2NDMUdqe8rFNTsa8Q+A6AKIE+EnOP4yn7poDNAjAu0poXN5Tkz2q1tOH/aLODb4eZVp2k7BJKXXmP4JbAWjGF7fXTo/M4ubMopMmKHi8yJ/RF9cz7IxGBW7yA==
X-Gm-Message-State: AOJu0YxSY1vMGw7pyaK/15nXuLFXavTdv8DpHASQwrmtnrTawgABdZ37
	534KR1FUUPorusJtbVsFBP8d2Pbbb72xrvRp/WU9/dhShKi+i10I
X-Google-Smtp-Source: AGHT+IHrKOeN/AH8DZsWKCyxRbOMxHQnpvQ/kEy1CAgntia3tbrsbxSyKBmd2sApDc6dRfvjP4HPGw==
X-Received: by 2002:a17:906:aa54:b0:a51:f463:cfa6 with SMTP id kn20-20020a170906aa5400b00a51f463cfa6mr1420963ejb.29.1713438660622;
        Thu, 18 Apr 2024 04:11:00 -0700 (PDT)
Received: from jonhaslam-mbp.dhcp.thefacebook.com ([2620:10d:c092:500::4:6637])
        by smtp.gmail.com with ESMTPSA id q27-20020a17090622db00b00a520b294d9dsm742333eja.150.2024.04.18.04.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 04:11:00 -0700 (PDT)
Date: Thu, 18 Apr 2024 12:10:59 +0100
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
Message-ID: <u6rrbsrjxpu43re5vb5o6vzvpxoto42wq47av3hagge6mfjsaj@25pujxi7z3u7>
References: <20240325120323.ec3248d330b2755e73a6571e@kernel.org>
 <CAEf4BzZS_QCsSY0oGY_3pGveGfXKK_TkVURyNq=UQXVXSqi2Fw@mail.gmail.com>
 <20240327084245.a890ae12e579f0be1902ae4a@kernel.org>
 <54jakntmdyedadce7yrf6kljcjapbwyoqqt26dnllrqvs3pg7x@itra4a2ikgqw>
 <20240328091841.ce9cc613db375536de843cfb@kernel.org>
 <CAEf4BzYCJWXAzdV3q5ex+8hj5ZFCnu5CT=w8eDbZCGqm+CGYOQ@mail.gmail.com>
 <CAEf4BzbSvMa2+hdTifMKTsNiOL6X=P7eor4LpPKfHM=Y9-71fw@mail.gmail.com>
 <20240330093631.72273967ba818cb16aeb58b6@kernel.org>
 <lcc6lnkbfnyr6yjvybckevhzaafvh7jmpse6tnviq5bjar3y6z@yvz6cuzjzrky>
 <20240411082156.6613cf4dc03129ea1183ab88@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411082156.6613cf4dc03129ea1183ab88@kernel.org>

Hi Masami,

> > > OK, then I'll push this to for-next at this moment.
> > > Please share if you have a good idea for the batch interface which can be
> > > backported. I guess it should involve updating userspace changes too.
> > 
> > Did you (or anyone else) need anything more from me on this one so that it
> > can be pushed? I provided some benchmark numbers but happy to provide
> > anything else that may be required.
> 
> Yeah, if you can update with the result, it looks better to me.
> Or, can I update the description?

Just checking if you need me to do anything on this so that it can be
pushed to for-next? Would be really great if we can get this in. Thanks
for all your help.

Jon.

> 
> Thank you,
> 
> > 
> > Thanks!
> > 
> > Jon.
> > 
> > > 
> > > Thank you!
> > > 
> > > > >
> > > > > So I hope you can reconsider and accept improvements in this patch,
> > > > > while Jonathan will keep working on even better final solution.
> > > > > Thanks!
> > > > >
> > > > > > I look forward to your formalized results :)
> > > > > >
> > > > 
> > > > BTW, as part of BPF selftests, we have a multi-attach test for uprobes
> > > > and USDTs, reporting attach/detach timings:
> > > > $ sudo ./test_progs -v -t uprobe_multi_test/bench
> > > > bpf_testmod.ko is already unloaded.
> > > > Loading bpf_testmod.ko...
> > > > Successfully loaded bpf_testmod.ko.
> > > > test_bench_attach_uprobe:PASS:uprobe_multi_bench__open_and_load 0 nsec
> > > > test_bench_attach_uprobe:PASS:uprobe_multi_bench__attach 0 nsec
> > > > test_bench_attach_uprobe:PASS:uprobes_count 0 nsec
> > > > test_bench_attach_uprobe: attached in   0.120s
> > > > test_bench_attach_uprobe: detached in   0.092s
> > > > #400/5   uprobe_multi_test/bench_uprobe:OK
> > > > test_bench_attach_usdt:PASS:uprobe_multi__open 0 nsec
> > > > test_bench_attach_usdt:PASS:bpf_program__attach_usdt 0 nsec
> > > > test_bench_attach_usdt:PASS:usdt_count 0 nsec
> > > > test_bench_attach_usdt: attached in   0.124s
> > > > test_bench_attach_usdt: detached in   0.064s
> > > > #400/6   uprobe_multi_test/bench_usdt:OK
> > > > #400     uprobe_multi_test:OK
> > > > Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> > > > Successfully unloaded bpf_testmod.ko.
> > > > 
> > > > So it should be easy for Jonathan to validate his changes with this.
> > > > 
> > > > > > Thank you,
> > > > > >
> > > > > > >
> > > > > > > Jon.
> > > > > > >
> > > > > > > >
> > > > > > > > Thank you,
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > BTW, how did you measure the overhead? I think spinlock overhead
> > > > > > > > > > will depend on how much lock contention happens.
> > > > > > > > > >
> > > > > > > > > > Thank you,
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > [0] https://docs.kernel.org/locking/spinlocks.html
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Jonathan Haslam <jonathan.haslam@gmail.com>
> > > > > > > > > > > ---
> > > > > > > > > > >  kernel/events/uprobes.c | 22 +++++++++++-----------
> > > > > > > > > > >  1 file changed, 11 insertions(+), 11 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > > > > > > > > > index 929e98c62965..42bf9b6e8bc0 100644
> > > > > > > > > > > --- a/kernel/events/uprobes.c
> > > > > > > > > > > +++ b/kernel/events/uprobes.c
> > > > > > > > > > > @@ -39,7 +39,7 @@ static struct rb_root uprobes_tree = RB_ROOT;
> > > > > > > > > > >   */
> > > > > > > > > > >  #define no_uprobe_events()   RB_EMPTY_ROOT(&uprobes_tree)
> > > > > > > > > > >
> > > > > > > > > > > -static DEFINE_SPINLOCK(uprobes_treelock);    /* serialize rbtree access */
> > > > > > > > > > > +static DEFINE_RWLOCK(uprobes_treelock);      /* serialize rbtree access */
> > > > > > > > > > >
> > > > > > > > > > >  #define UPROBES_HASH_SZ      13
> > > > > > > > > > >  /* serialize uprobe->pending_list */
> > > > > > > > > > > @@ -669,9 +669,9 @@ static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
> > > > > > > > > > >  {
> > > > > > > > > > >       struct uprobe *uprobe;
> > > > > > > > > > >
> > > > > > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > > > > > +     read_lock(&uprobes_treelock);
> > > > > > > > > > >       uprobe = __find_uprobe(inode, offset);
> > > > > > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > > > > > +     read_unlock(&uprobes_treelock);
> > > > > > > > > > >
> > > > > > > > > > >       return uprobe;
> > > > > > > > > > >  }
> > > > > > > > > > > @@ -701,9 +701,9 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
> > > > > > > > > > >  {
> > > > > > > > > > >       struct uprobe *u;
> > > > > > > > > > >
> > > > > > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > > > > > +     write_lock(&uprobes_treelock);
> > > > > > > > > > >       u = __insert_uprobe(uprobe);
> > > > > > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > > > > > +     write_unlock(&uprobes_treelock);
> > > > > > > > > > >
> > > > > > > > > > >       return u;
> > > > > > > > > > >  }
> > > > > > > > > > > @@ -935,9 +935,9 @@ static void delete_uprobe(struct uprobe *uprobe)
> > > > > > > > > > >       if (WARN_ON(!uprobe_is_active(uprobe)))
> > > > > > > > > > >               return;
> > > > > > > > > > >
> > > > > > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > > > > > +     write_lock(&uprobes_treelock);
> > > > > > > > > > >       rb_erase(&uprobe->rb_node, &uprobes_tree);
> > > > > > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > > > > > +     write_unlock(&uprobes_treelock);
> > > > > > > > > > >       RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
> > > > > > > > > > >       put_uprobe(uprobe);
> > > > > > > > > > >  }
> > > > > > > > > > > @@ -1298,7 +1298,7 @@ static void build_probe_list(struct inode *inode,
> > > > > > > > > > >       min = vaddr_to_offset(vma, start);
> > > > > > > > > > >       max = min + (end - start) - 1;
> > > > > > > > > > >
> > > > > > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > > > > > +     read_lock(&uprobes_treelock);
> > > > > > > > > > >       n = find_node_in_range(inode, min, max);
> > > > > > > > > > >       if (n) {
> > > > > > > > > > >               for (t = n; t; t = rb_prev(t)) {
> > > > > > > > > > > @@ -1316,7 +1316,7 @@ static void build_probe_list(struct inode *inode,
> > > > > > > > > > >                       get_uprobe(u);
> > > > > > > > > > >               }
> > > > > > > > > > >       }
> > > > > > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > > > > > +     read_unlock(&uprobes_treelock);
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > >  /* @vma contains reference counter, not the probed instruction. */
> > > > > > > > > > > @@ -1407,9 +1407,9 @@ vma_has_uprobes(struct vm_area_struct *vma, unsigned long start, unsigned long e
> > > > > > > > > > >       min = vaddr_to_offset(vma, start);
> > > > > > > > > > >       max = min + (end - start) - 1;
> > > > > > > > > > >
> > > > > > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > > > > > +     read_lock(&uprobes_treelock);
> > > > > > > > > > >       n = find_node_in_range(inode, min, max);
> > > > > > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > > > > > +     read_unlock(&uprobes_treelock);
> > > > > > > > > > >
> > > > > > > > > > >       return !!n;
> > > > > > > > > > >  }
> > > > > > > > > > > --
> > > > > > > > > > > 2.43.0
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > 
> > > -- 
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

