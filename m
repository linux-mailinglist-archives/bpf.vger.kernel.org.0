Return-Path: <bpf+bounces-57300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF7CAA7D66
	for <lists+bpf@lfdr.de>; Sat,  3 May 2025 01:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20D81C04F0A
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 23:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC4B2222DB;
	Fri,  2 May 2025 23:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jPF1vZmT"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19281F9CB
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 23:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746229273; cv=none; b=fZoHYTaVIvA6hkqJLYvqlX5iLEhtquWSBsf8bATFeHpiJ5Ei69le1CByrTw4p+Re2lM0s19mvvz2EflraHFKzwYYw9OCY0pA/JZeN8/XPDvow6EgXUuck6zHZUNd0GuopmSo1PP5V0Ycd9k6/A5SzvZJ1DQdRc3ZewzKZ4/2JkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746229273; c=relaxed/simple;
	bh=czGIM+H4eLlZESV3HJ64VTl1tY7CpAwcyCHYi9ICIxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GcLedLHHzfD54oZANRlgL4GJ5YhM4JmUsq14XMhNd/y2ns2skilpdZvqP0/nt+XD2VqJWo/a+jthtaXU1o59fKUXmpVVmN1CJW81IQ0NzTv2rvLtCL8nyvTqTWVwgFf20sCrCmqTHDx1YX+1PUH4ADwRJu9bLNrDuD96GRQjqic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jPF1vZmT; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCUwVU6hdotyiTHhbi3/6YWY9Z7Wv+L4aR0RthUhjaLSF/7yBRl+Jo3LYRi/7m2ANGkwNDoSCJB6aPBKIERk@vger.kernel.org, AJvYcCVB7NYAkyDp7jcZpEtIrF3OHd5eHZD50kNzmNLi0Da144oy79cdwaUmVu8HqZFs1j95I0A=@vger.kernel.org, AJvYcCWOevjYC4hMwclEccIMkElfPYiPeREKgc1uZDBWtINbwYli20FK8raB+oRT3bkGNAWLwnTXnF2t1w==@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746229267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1iZ6FskvjswHgkYHQhuRfrsF7UvHUOVUeCTo8/6mqlQ=;
	b=jPF1vZmTfACmtd03QAwd2HqmDyzdPieZyHRp2pDGTU9xdVhdUNLj3bBdhyEIxEmkzu7bqs
	VSwTbufFvZZ2ReXtwj0MAfIj4DSeURKtRMUnZfAy4Voqf1ZvMt0B+Fp2TOIrnIiyX2EXOH
	mHdYKAilmCdUMVawEL2/JeJr47syAyM=
X-Gm-Message-State: AOJu0YyWuPOIRkFEXs/8BXaVG9TgA8N7u/V3jAApQqPmIjSSPi/v96r6
	W6naUMg15UWKXSrku/9+8QC00PNLCeufN3NtZ9JWH5qhbOmLCcypQuNCCByYbOIQW9aZnBFVHHm
	8M4SjMqktWPW5p8Nh7OYiCRgPbIo=
X-Google-Smtp-Source: AGHT+IFTCZDG1vWbE2TphPGvigDBoOv0TL+ojP/zRtmlOP4pijef2XIcrq7nTs0Tkb1kQWWyHHoL1nsLTn2sZ5lSqAY=
X-Received: by 2002:a05:6122:4281:b0:523:eb47:2884 with SMTP id
 71dfb90a1353d-52adedabf74mr6322156e0c.6.1746229264756; Fri, 02 May 2025
 16:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502001742.3087558-1-shakeel.butt@linux.dev>
 <20250502001742.3087558-4-shakeel.butt@linux.dev> <CAADnVQJ-XEEwVppk-qY2mmGB4R18_nqH-wdv5nuJf2LST5=Aaw@mail.gmail.com>
 <CAGj-7pWqvtWj2nSOaQwoLbwUrVcLfKc0U2TcmxuSB87dWmZcgQ@mail.gmail.com> <CAADnVQ+dhiuvrmTiKeGCnjDk9=4ygETJXR+E4zQr5H2MzBLBCQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+dhiuvrmTiKeGCnjDk9=4ygETJXR+E4zQr5H2MzBLBCQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Fri, 2 May 2025 16:40:53 -0700
X-Gmail-Original-Message-ID: <CAGj-7pXrKBr+LC_Mbj+xyud=tXpR3bCYwzOQTUgM8aSZ0qNnhA@mail.gmail.com>
X-Gm-Features: ATxdqUFYlzigjs82EjrKHhRoE1vnHFOUKUQOL1fcOT0yG0kjvzFLy9bjym4kI_8
Message-ID: <CAGj-7pXrKBr+LC_Mbj+xyud=tXpR3bCYwzOQTUgM8aSZ0qNnhA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] memcg: no irq disable for memcg stock lock
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Meta kernel team <kernel-team@meta.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Fri, May 2, 2025 at 4:28=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
[...]
> > >
> > > I don't think it works.
> > > When there is a normal irq and something doing regular GFP_NOWAIT
> > > allocation gfpflags_allow_spinning() will be true and
> > > local_lock() will reenter and complain that lock->acquired is
> > > already set... but only with lockdep on.
> >
> > Yes indeed. I dropped the first patch and didn't fix this one
> > accordingly. I think the fix can be as simple as checking for
> > in_task() here instead of gfp_mask. That should work for both RT and
> > non-RT kernels.
>
> Like:
> if (in_task())
>   local_lock(...);
> else if (!local_trylock(...))
>
> Most of the networking runs in bh, so it will be using
> local_trylock() path which is probably ok in !PREEMPT_RT,
> but will cause random performance issues in PREEMP_RT,
> since rt_spin_trylock() will be randomly failing and taking
> slow path of charging. It's not going to cause permanent
> nginx 3x regression :), but unlucky slowdowns will be seen.
> A task can grab that per-cpu rt_spin_lock and preempted
> by network processing.

Does networking run in bh for PREEMPT_RT as well?

I think I should get networking & RT folks opinion on this one. I will
decouple this irq patch from the decoupling lock patches and start a
separate discussion thread.

