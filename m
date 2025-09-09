Return-Path: <bpf+bounces-67843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA49EB4A1F1
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 08:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923AF16D68B
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 06:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5250B302149;
	Tue,  9 Sep 2025 06:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FDX7WNT6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07D82550CA
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 06:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398855; cv=none; b=Tmo3D1Yb9wCbZisvnIWaKlRI64R7g7F6ehdo6/oMo/6u4F9OH8QWG2YIsgyVZRrJjlOLq/Nn3labPUGccncZ5a5TYFQSIC3Jvi0T6yNstDbiAN9igxJaPcl4B6WBAGljqh130vl2/eG+vPSkUbZbNrdGrWgj5VDytWvH99j82lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398855; c=relaxed/simple;
	bh=KDyF09UmSmfPauYAR4WrsCS2uIoJPzqHmaa7An4Iit8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zns6o49zkfyYIOFd+uooNXURalc715DkeQ13bf5QKPRBEd8MQcBk4UeA1CgqWv0yBA3lnmQWuOh0vJbqmxtEeN4lcm2y+1pEjYS+1bGw/mu3Sdz8Vu8CaFQh6IgJ5u7C0vgJaG4VW9i2TuoPE4FWidZbs4NykJIXMwr0ZxVBOrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FDX7WNT6; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6263d0e4b94so5501999a12.3
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 23:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757398852; x=1758003652; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w/59r4nKFKoXQCTnkJhQgP9ynEgR8S9O7tupwQt0EUM=;
        b=FDX7WNT63QzmMdBxju2WHlEx2glRjl/hjZGck3s5+ltCi1YBdvqu1hxq6xjozW0NdF
         mUlh1tssDngmh7fmqw1cEmaLYa36SNvP60CvE8Ky1uOogv3L4Xg0hjCl1OhCBbxs8kiG
         r3W+jV5h3j7Ru510MmKcqrPcCxMd2vDS6pfnKkuLevq7yHYozuM/FjhnmCUbAuNw1M0r
         H0oj1vE9/Bn22goyGSG1oN4tpKg41R/Exzp9I5sSGyL8PV4QzcebsNvS2jwlsifGDgeS
         6E0WyvTF/JPToNlU2hd9LDijvFh1UlfOwod6RSytUo1DQ52ZgGkBoFqj2yKbkr98Q9MV
         P5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757398852; x=1758003652;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/59r4nKFKoXQCTnkJhQgP9ynEgR8S9O7tupwQt0EUM=;
        b=RrPf4IoFpbLwFld2xMljsB/cmIPddrPyv7D765s4furaZi85aXepD3nhvSP1OdFPg5
         NTFeMkKpDVqC501sGKJj8HvObvGCQA3idKVhn4xNBbx3XD9VNe1n6M2D0LdjUJ75WUEW
         7lYuVSQPW5oao4LBR2XHI51xGPqgtrFtVvRG4hT/2Hg31+odKISa7YXrH4Fi+prbowxK
         aY5T1w9ccprHiNcGlbhifOxHU8QFDcYhEHTlxsmGFIp84jRDj86cmsz1+SXhb1jCAHS+
         GTiUY0WemaUFgdNQhU/JI9wcnxj1BXie9UJF0ZuYCniNtdGpiEf8ieKNfMjhlXChvrao
         poSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWW1BZvu1zZs94p08YcrU+bN67NJTxJbtCPcbIwJDAgR0aEam597lx1m3s1kHMt7s25vw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1xnz0BOZM/r2ojZRoVz6lSbAmbPRvIUcdFnjKY2bqSXnWX/D7
	n0TcWcKhotRKnI1cHc6mFhtuUXNAjNgLzKpBoiMBoV/fwom4O34cg8fuSKCMLAN+lhc=
X-Gm-Gg: ASbGncuBjgfAWJoC8l/z5c17k/dDze9SYCnjTIrO7goUgLE/zUsTw1943wpe9f8ac1t
	gNC+Pk4d7nKc/m4wb/d1hq9wFn7Ea6dmPTdw+ZWI5aMN0K2baMxbUVrLbwMt52ZHu8VcKrgnGFn
	vAxGeqd3QZXWgTB0IAlTDD5HZyDcQDm+yIoe3uyEIznoDTMcerdjtLq3UTg9Ty/pHX+xeip9uxM
	/gwct7HjQZp3kcgw3+fOmT6faGGw4TNdUOpvDGLlnsVEEqrC2AmWHpp8/c7Uvpms6t2C92iJVZ1
	C4xtoinlavFyPrXlQukviEv+Fwy8/lgDDkfuJdKgSNd1OaFkoLfA8aDRpnXrYbuRYgJNuv7pxnA
	45rkJI7h9c5AD5jCemFKFrowpNb+fYjeFlQ==
X-Google-Smtp-Source: AGHT+IEy7r+3IQg6FyahElzQLsyWsCN+nac3o89gK9QMZ1U0RxA6rWKjSJAXvBlojXrZGYl7wLf9pA==
X-Received: by 2002:a17:907:1c10:b0:b04:1a80:35b9 with SMTP id a640c23a62f3a-b04b13cd575mr1019442566b.12.1757398852041;
        Mon, 08 Sep 2025 23:20:52 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b0761c9314esm150029966b.33.2025.09.08.23.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 23:20:51 -0700 (PDT)
Date: Tue, 9 Sep 2025 08:20:50 +0200
From: Michal Hocko <mhocko@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peilin Ye <yepeilin@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
Message-ID: <aL_HQn9gZjbt4zLl@tiehlicka>
References: <20250905201606.66198-1-shakeel.butt@linux.dev>
 <aLtMrlSDP7M5GZ27@google.com>
 <aL6dBivokIeBApj8@tiehlicka>
 <CAADnVQLtc+OOQ67AS_1+u-sRmO+bDLWJrrihASXMrDNnvrmNSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLtc+OOQ67AS_1+u-sRmO+bDLWJrrihASXMrDNnvrmNSw@mail.gmail.com>

On Mon 08-09-25 10:11:29, Alexei Starovoitov wrote:
> On Mon, Sep 8, 2025 at 2:08 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Fri 05-09-25 20:48:46, Peilin Ye wrote:
> > > On Fri, Sep 05, 2025 at 01:16:06PM -0700, Shakeel Butt wrote:
> > > > Generally memcg charging is allowed from all the contexts including NMI
> > > > where even spinning on spinlock can cause locking issues. However one
> > > > call chain was missed during the addition of memcg charging from any
> > > > context support. That is try_charge_memcg() -> memcg_memory_event() ->
> > > > cgroup_file_notify().
> > > >
> > > > The possible function call tree under cgroup_file_notify() can acquire
> > > > many different spin locks in spinning mode. Some of them are
> > > > cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
> > > > just skip cgroup_file_notify() from memcg charging if the context does
> > > > not allow spinning.
> > > >
> > > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > >
> > > Tested-by: Peilin Ye <yepeilin@google.com>
> > >
> > > The repro described in [1] no longer triggers locking issues after
> > > applying this patch and making __bpf_async_init() use __GFP_HIGH
> > > instead of GFP_ATOMIC:
> > >
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -1275,7 +1275,7 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
> > >         }
> > >
> > >         /* allocate hrtimer via map_kmalloc to use memcg accounting */
> > > -       cb = bpf_map_kmalloc_node(map, size, GFP_ATOMIC, map->numa_node);
> > > +       cb = bpf_map_kmalloc_node(map, size, __GFP_HIGH, map->numa_node);
> >
> > Why do you need to consume memory reserves? Shouldn't kmalloc_nolock be
> > used instead here?
> 
> Yes. That's a plan. We'll convert most of bpf allocations to kmalloc_nolock()
> when it lands.

OK, I thought this was merged already. I suspect __GFP_HIGH is used here
as a result of manual GFP_ATOMIC & ~GFP_RECLAIM. A TODO/FIXME referring
to kmalloc_nolock would clarify the situation.

-- 
Michal Hocko
SUSE Labs

