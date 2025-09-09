Return-Path: <bpf+bounces-67891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA34DB502CF
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 18:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52982364EC6
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 16:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58C0350D5B;
	Tue,  9 Sep 2025 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqRYXB4R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D92A274B29;
	Tue,  9 Sep 2025 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435949; cv=none; b=Nfu/hPom/67Rvi7FUDA8xfmJYzFMp2+ujDSGTmkRIGcoQxv+Mq3t1Hxff3drpC6eo0y0LG0Ji5ESqyqwck2KyhFVw1wmgEbw7Z4uXvQvEuUn/aAblCT9ZTq3QZkuUSF/kNxZjqNans1ykPSWj/zQJQOIuKGuaNq1xsocQbFnCXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435949; c=relaxed/simple;
	bh=VloP65NkSd3Zg2ql4Ajk7Ic3j/6MT0ZjCUyShEmI8ko=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jh41w2TEeuqCXBhRZkDcrfUaBNXirUQjTtVnLO1wp5QVQveNMj0SAxFcP+ED0ktP7eCUIJuUgKP5le9Y/209eC7aI3TznqGwAg7h7B2fvMoEnA8nTj6P4rKJCYUMxTtWZkeip1KHcC7Dug6uVD+nzMsuf1zmKGQV7KgQlolHxdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqRYXB4R; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45de6ab6ce7so15716895e9.1;
        Tue, 09 Sep 2025 09:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757435946; x=1758040746; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P2Uku8TU34XQJJFzBct703dmoWJVtTS3G666iVLYjPg=;
        b=WqRYXB4Rs49nxflbsRWZMuEdC5McEzCHNThKNCqBsyCUTvdRQaxfNFr5FfU0te/m/A
         HNsskCXfTWuSO4r+qCHPMjcbl/EdXfcQsWkftkEaWhbhcofKAeEngVz9ZVb4nI42qE67
         UDxh5Pn+sbttQ50NQCn0sDuZ2By8GwHONAOLDjDJvz4KLjAKIUUDGPLe8l8hAgRbGHSZ
         eMB9apivaI/XvwDwd3R/qJXWfKCBHJZjEWjjLiAFA+aNPnMtDMQl0LZBqQaPxxSd1OuV
         gUNHflJFrm4s3M3C3ngTM+ck7Y13Cz/AJtfBW2Sl5s0N/WZgFSlWHCk0FSwJk7jdfDXk
         nzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757435946; x=1758040746;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P2Uku8TU34XQJJFzBct703dmoWJVtTS3G666iVLYjPg=;
        b=dS46u4bewjbAW2nFCFa7dnOWAzUFdBi2bLoStCvfSjV7Fa0ttcYKnExosfIt00plMU
         CrbWoheIK846qK6NyBGP76OVPXwbY4gIA7XO96XaSJwtlIZb3opmxsK2+ldnPcVkLM/K
         tHhJGzYToEvKnXecwreYK6Zf8gJEGh2cyFv20KMXE9JYolrzNW9TAkc24LX3Q1eFmB+a
         FhIa7Kc4okU1eu8YTQjOwCPvcHBowyk6/yyV27a/Fd+VHZ58U4nAltU517UpjLSeWCFk
         gv+RoB6TteoOQl2ZZvkLjXmD+TI/kh57vLg+QtZMxRCU1DxConCUzUCaqCH0/y3kRC4n
         dRNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJkhZatL4CHo+V/PXBO5RjsfyLnXIn02wbkvjMyOnB9SpMbo+gjJFupMqZjLw9tADeCw8bPnyU/HVmYM8kq1VKnMq9@vger.kernel.org, AJvYcCUoqf7vwOEwv0JDcmEcbRtmDdKSJmPYuGJ5tZb3zrf3Qxyt64SRG1XNPl8Q1tb4bSNyYvU=@vger.kernel.org, AJvYcCVNAFxwP31FGpi4ZOdIrqcDor4dmG+NQoKero1n1Ivv2VXCBJig4YG2wBs0Bvza8DJ55dWV9Xyvm2upRyfp@vger.kernel.org
X-Gm-Message-State: AOJu0YyUdnLC54fhrYj6IVDcJEF9ABMcDiflB1K1bASaIGSlnOkPsPUR
	6iOHSlIljRkKnpn9I0WzhsNYyppXoNEe0wa5eg942fVerYDX+z/z21uf
X-Gm-Gg: ASbGncuI1ZhkBuoSrlaiOJKYRhiuRgUUjALh64AUSGTGutFlKZMHPfT9wKBNitK4i8N
	JII4GAQY8GpIusfQ9QwvJu7KIb6t+JZg9KRiSl+km2Px+oLd/CsGgHGTfz7RVu8BKTPDcJgJeWB
	Kvv6FJmGQklmBpvye6mqH61nRng6pi9ztQ6nc2BNRrJcmMwUUCDWu/BxCCARR3TEslzb0/pgZvN
	CLz+8qh3UZRxDDJbYWeLK5iP0OUsVrelCBr/El3KsG9jCc9opjAq/xn47oUnqWF4W8RB9O2lgGP
	BuOOu8YpaBAu01XhoLYCmAohaH+b/1Qpk/WKSi6yAVOI4TrvGSrrrKBEYqfa0G4d0rfTlGogi+N
	2C0/Gf45b6ACAQw3zWzJ/AQ==
X-Google-Smtp-Source: AGHT+IG7y1sbIDdOG0mV0MkzBgOk/+sS0sjVjV3LNFIoI1TOYgEb04LKrhl4CEQN36OfP7pQ4cIVKg==
X-Received: by 2002:a05:6000:250c:b0:3e4:ea11:f7d8 with SMTP id ffacd0b85a97d-3e642da5105mr10519911f8f.20.1757435945622;
        Tue, 09 Sep 2025 09:39:05 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de18f4824sm146031215e9.10.2025.09.09.09.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 09:39:05 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 9 Sep 2025 18:39:02 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, andrii@kernel.org,
	Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com,
	mhiramat@kernel.org, linux-kernel@vger.kernel.org, alx@kernel.org,
	eyal.birger@gmail.com, kees@kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	haoluo@google.com, rostedt@goodmis.org, alan.maguire@oracle.com,
	David.Laight@aculab.com, thomas@t-8ch.de, mingo@kernel.org,
	rick.p.edgecombe@intel.com, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH 0/6] uprobes/x86: Cleanups and fixes
Message-ID: <aMBYJvtvR7c-Srkb@krava>
References: <20250821122822.671515652@infradead.org>
 <aKcqm023mYJ5Gv2l@krava>
 <aKgtaXHtQvJ0nm_b@krava>
 <CAEf4BzYg9jsEK1XdKW4dKFdOSrY4CAspaCAAv6ZJZScHxkHSyA@mail.gmail.com>
 <aMAiMrLlfmG9FbQ3@krava>
 <CAEf4BzZnvWH-X-7qKvx2LxzR+xkFfvjj27Tfjoui5xnph-urMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZnvWH-X-7qKvx2LxzR+xkFfvjj27Tfjoui5xnph-urMw@mail.gmail.com>

On Tue, Sep 09, 2025 at 11:20:13AM -0400, Andrii Nakryiko wrote:
> On Tue, Sep 9, 2025 at 8:48 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Fri, Aug 22, 2025 at 11:05:59AM -0700, Andrii Nakryiko wrote:
> > > On Fri, Aug 22, 2025 at 1:42 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > On Thu, Aug 21, 2025 at 04:18:03PM +0200, Jiri Olsa wrote:
> > > > > On Thu, Aug 21, 2025 at 02:28:22PM +0200, Peter Zijlstra wrote:
> > > > > > Hi,
> > > > > >
> > > > > > These are cleanups and fixes that I applied on top of Jiri's patches:
> > > > > >
> > > > > >   https://lkml.kernel.org/r/20250720112133.244369-1-jolsa@kernel.org
> > > > > >
> > > > > > The combined lot sits in:
> > > > > >
> > > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core
> > > > > >
> > > > > > Jiri was going to send me some selftest updates that might mean rebasing that
> > > > > > tree, but we'll see. If this all works we'll land it in -tip.
> > > > > >
> > > > >
> > > > > hi,
> > > > > sent the selftest fix in here:
> > > > >   https://lore.kernel.org/bpf/20250821141557.13233-1-jolsa@kernel.org/T/#u
> > > >
> > > > Andrii,
> > > > do we want any special logistic for the bpf/selftest changes or it could
> > > > go through the tip tree?
> > >
> > > let's route selftest changes through tip together with the rest of
> > > uprobe changes, it's unlikely to conflict
> >
> > fyi, there's conflict now between tip/perf/core and bpf-next/master
> > in the selftests.. due to usdt SIB argument support changes
> >
> > please let me know if you need any help in resolving that
> 
> so selftest change hasn't landed in tip/perf/core just yet, is that
> right? If there is a conflict, I guess that changes equation a bit.
> I'd land it in bpf-next and for now disable that test in BPF CI until
> the trees converge. WDYT?

I can see the selftests changes in tip/perf/core already

jirka


16ed38922765 (HEAD -> tip/perf/core) perf: Skip user unwind if the task is a kernel thread
d77e3319e310 perf: Simplify get_perf_callchain() user logic
90942f9fac05 perf: Use current->flags & PF_KTHREAD|PF_USER_WORKER instead of current->mm == NULL
153f9e74dec2 perf: Have get_perf_callchain() return NULL if crosstask and user are set
e649bcda25b5 perf: Remove get_perf_callchain() init_nr argument
f49e1be19542 perf/x86: Print PMU counters bitmap in x86_pmu_show_pmu_cap()
2676dbf9f4fb perf/x86/intel: Add ICL_FIXED_0_ADAPTIVE bit into INTEL_FIXED_BITS_MASK
9b3e119784bc perf/x86/intel: Change macro GLOBAL_CTRL_EN_PERF_METRICS to BIT_ULL(48)
0c5caea762de perf/x86: Add PERF_CAP_PEBS_TIMING_INFO flag
43796f305078 perf/x86/intel: Fix IA32_PMC_x_CFG_B MSRs access error
d9cf9c6884d2 perf/x86/intel: Use early_initcall() to hook bts_init()
e173287b5d21 uprobes: Remove redundant __GFP_NOWARN
9ffc7a635c35 selftests/seccomp: validate uprobe syscall passes through seccomp
89d1d8434d24 seccomp: passthrough uprobe systemcall without filtering
52718438af2a selftests/bpf: Fix uprobe syscall shadow stack test
3abf4298c613 selftests/bpf: Change test_uretprobe_regs_change for uprobe and uretprobe
275eae678986 selftests/bpf: Add uprobe_regs_equal test
875e1705ad99 selftests/bpf: Add optimized usdt variant for basic usdt test
c11661bd9adf selftests/bpf: Add uprobe syscall sigill signal test
c8be59667cf1 selftests/bpf: Add hit/attach/detach race optimized uprobe test
d5c86c337010 selftests/bpf: Add uprobe/usdt syscall tests
7932c4cf5771 selftests/bpf: Rename uprobe_syscall_executed prog to test_uretprobe_multi
4e7005223e6d selftests/bpf: Reorg the uprobe_syscall test function
17c3b0015764 selftests/bpf: Import usdt.h from libbpf/usdt project
354492a0e1bc uprobes/x86: Add SLS mitigation to the trampolines
60ed85b7e469 uprobes/x86: Make asm style consistent
...

