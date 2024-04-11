Return-Path: <bpf+bounces-26497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B958A0B87
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 10:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4761C22AC7
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 08:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30C1140367;
	Thu, 11 Apr 2024 08:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSpXMg93"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718FF140365;
	Thu, 11 Apr 2024 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824920; cv=none; b=qtWzUsSX+HpwKB0IC1x5A1DkO6m2u8UWADK4to95FDyeJAwmic14nYG4eyGl7SpgnhVmwSe4DVDC54NJtst0rfvVIF/wpA62z5xKtadWg3joQ31EsLBgzj69h2/cfrGvyV2u9JrA0swLkN/bssGP/rBa8oifzQ4+7SL3R8xThPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824920; c=relaxed/simple;
	bh=6DLQjsDEoSjNb9shH07V2fDjm+hPN7/FwwywkB/Dbs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsOzC6UD7nCrNP0Yw4XwLPdqo7owpfJssYSnsZMQ9HFe0oW4Ob59sy4HUoavfpu4StGWPska0camzyz0Ygf71fiwn4l10+Zi+TQNejkZhLwYZDK9yk2PNdP2B98ZzAqsJ+jEN48OyUK07H4EbM2NexkwtueiSN9Koa5mrf7p88Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSpXMg93; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a44ad785a44so877089466b.3;
        Thu, 11 Apr 2024 01:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712824917; x=1713429717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r//gg2KSb9Ti8gfST7aix5NRc6L6yFLnnGwq82C2L10=;
        b=nSpXMg93imPAXb07HTeBndHBTn+xLMUmxEP9WutFbfIoDtI+nZhUxPXEMkE0b4AkCo
         rsxszotnlAImLoye80yoeiJ8Lx3qsp+stgyrzV+hTYQKdtiL4yj399tCBOxhxe+1EQqG
         Tw9ZYw+gkbViU4a0SUl7W/8IMuLnOtOOAOTLPKB+kLrLjINya3R2jHh9tPgMy5EnSdeL
         7VtAuGfQg+R8bACOiEIWZB37+L4y/0OKViBNqt7LtcRMSzGplRl+9IJU/PEGgNEA62hq
         p5GjAtSWjnSCCZddzRAvU4HLTzzVt543q4AyOWDszfgGH1KoyJ2Q2WGFH7AcJY8U3F8F
         bCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712824917; x=1713429717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r//gg2KSb9Ti8gfST7aix5NRc6L6yFLnnGwq82C2L10=;
        b=vCtrcRCdXKOXnTGQeplHbwS/jSzix43QBOf18E6QI/ieXXNY/r38gyTUjZx3PfVCgU
         tcDt91kEe7NTlJ1I2nbfdcKLkjYOKz4cR2dcgGSdNy1fHPYpx8NLYekYLVkzHvG0yEVF
         99v855UeRfFcMaS6J/HUYx4kbj0zLES5ByfpYlL012EJS2UMPMTgEwJ32iBTyE9s7M30
         P6gIYSBrYAt2Em5lR4zOczxsfhp1kHBghYKwZFB5CHwWnTetlkNQfW7QZZXSevtKRqd5
         sPkUEdb+wSEmoINfgxQi3iG7t2Dd7jdAHaCgikVs9I2bINxkALAXldJtm9mtS/k95803
         8kSA==
X-Forwarded-Encrypted: i=1; AJvYcCVhZeWkY3AYxk+d0DBs5E12q1qb+cB6OUWpcP0QQ8IiqO7bofV6xCmAirO/dr1QuDkrWqxHG3JpxKJcX82ydDUvnBEZoNwp7Shg9X+TyRAL7eVtNWg/oseWBYoMQ8I7dAjiIFgCmwJCOGvqPPr+dx3ONWPN1l80pCfjHl1p75U2ucCD9gMS2azANnVhHSXOYqW1BU6Sjb89FKuZMTz51GDXstWn6sUJ1w==
X-Gm-Message-State: AOJu0YyovyEBl7kAO3pTP+va/bo7oRId66VqEGvW4gWBbq66wJmnj/vp
	ly7kzqSmfQAg2trJ/sybj0/YYGyCnO+HOPF5K+T7Kx4FHgm0kKAK
X-Google-Smtp-Source: AGHT+IGqGgVnhw9T3C2cjrpjiSkw1plCEeVAAkZFNqECee+J0+pkm8IWce7nSX0D0vzHz9Ua82AKyw==
X-Received: by 2002:a17:906:af1b:b0:a51:9304:19fa with SMTP id lx27-20020a170906af1b00b00a51930419famr2655626ejb.70.1712824916519;
        Thu, 11 Apr 2024 01:41:56 -0700 (PDT)
Received: from jonhaslam-mbp.dhcp.thefacebook.com ([2620:10d:c092:400::5:8908])
        by smtp.gmail.com with ESMTPSA id x26-20020a170906711a00b00a521591ffacsm538312ejj.34.2024.04.11.01.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 01:41:55 -0700 (PDT)
Date: Thu, 11 Apr 2024 09:41:54 +0100
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
Message-ID: <cxm3f7buumd3vfybbd436zkroskecvyn46rm6pqtdad6rayeog@zzn2u6irogi7>
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

Sure, please feel free to update the description yourself.

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

