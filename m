Return-Path: <bpf+bounces-63349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2F6B06524
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 19:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6285B179441
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 17:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6CA27BF89;
	Tue, 15 Jul 2025 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKw31uuT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF23C272E43
	for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752600576; cv=none; b=tczlaMUq0g6CDqCSDzv2aG90+H0yeNWCQ5VmIWkllB2oOpOsVkS4fyI4vDHUH7VHyZLdsMAW+FeXWJXqa7ilozSKhlKtaMWHSngtTeSj1ErC3Ly0o7XeMAN2yK0b9IM9jt3OICmI9JfkNzKcPy1ab/LsDFCTY1JPzgfDp8Rm+Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752600576; c=relaxed/simple;
	bh=Il8kjokkfqu4kCN4ROicHOAK/MLLzKO5lyB9l2umNs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0xI/RJFUAwYjIDR4hTJL+2100KzVgzfeffGkc/cJihZP9RqOLenX10XxEdQwsB1U1tqCgOxT6e/O1Lyg1HyYURGpWJUvqjg7G0v9mdsb1yWJFdv4aNfzlz0wjsBJhrg04K665QWsc5eoh4x0uAPPxNX9zAHLF9b+KjnMYGF+1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKw31uuT; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23694cec0feso53200675ad.2
        for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 10:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752600574; x=1753205374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RzvA+upP7N+xmyl3rKQjK7wKukGDrRXLQFpGIH1dIN4=;
        b=TKw31uuTx3lh+4giHMNTT/D1V1lhEc4IJyzbUNL/55LtiXz3Ee9OYnMI4NcJYmZcMG
         cMNKC+T1uVg5Rg8b/x/ww8brkJSdLBWTHfgvMs80wfuhCZ60z71dPPs5I53uu7zm6HZm
         V8bUdJf0hp7SUwoAA8F92y1zbJ1HWmNouRjfuMdIOhor+XlTQToIsr7YJPOpOpyb73RG
         cdFk07L2gkJGF5C9DlW1WN2FtJifBgfLc9adqF57QeCBHI8+4Cjs1cionY0HLf8Ugzuq
         XBfsGIA892bvDclF7NF/Zc8C9H4H88+sBdDb+m4K3XFveT99JEpeI9q9uHGlQBH6eVIh
         V8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752600574; x=1753205374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzvA+upP7N+xmyl3rKQjK7wKukGDrRXLQFpGIH1dIN4=;
        b=UpvEOoPeRxIvrmHd9v53sFpQKtL2ZuE5WvBrWFNdGoO9KxL8f5iG/Qq8HO5Iy7T89t
         vVbXfqIGkPXPl5u6Sre0SwM0Qc1aSJiwKq6xivGzRYVm30hWU55bDwNSPKEKQBOFQ8Tz
         VLwmLRMgjmu2gPmwyXAwOmhKa2nS7Se1ekH0xC2GaGvsGZJj+aVj0IPvAJZlYQ+ZRihZ
         XvLQJOJVlA5qYe14KDb2xDvkvGPMN1MpOV6+hw4SZbeD7mZKIB+Wqn1Ei0EqJAQdqMBe
         97zG0dWLeW+nNkJXx8HqlKLXtn4QfDksPAY9sahcCHs62KFiA9QhQ+1eSRYxvdE4Gugx
         IQRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXpVi73mFGzzehJXRFnmfEFWYXgpvkKYA8OQg3igrLEzC4je1G9JDoAPQfI0F90wsfFgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhZz3yLAHeikytTjjX9qOSNo+gP6wyGBkZVxsUk1CTsch+277o
	Q5ms+D+ZbIZGANEcDz85nKpPwqewNLkQLbwNuBKuoNLD7SRfIRarc9oQ
X-Gm-Gg: ASbGncvXXcFJM+NAry6u2ZaVwjBDfmMy+dVNqKMhQTkK10bl7Br/EtLJFMwOMPffNAf
	CG7eh/IbCLBkhYBoKMfg0uV+V67XZQp1S3pWmCh7rNdt5oEGxvRnaOwcsjwgt5mDgGLrw4NDeHb
	cZJKC8nIUKjK0PBopfmI24cjCKSoHuHjJxzVdL3e5Zql9wwZyCeDLgPW8Q6K8N7Wpkh75uXR4k0
	uqztv+Rf/oUILH4m92aoSEmbZHgCO0LCv5p8VJG/2q1Xo6dUdY8p71mrAwfLYHF3FM9qcGNL4sR
	ErHiyAnvvbKVG+PY6zbaZ2gwak4ZTu9IDOoJRjL08KUfz6PmE9Lb99BK7+oUm2ug+8pqxjnrFPd
	cq3tT/UJefi8QkT0ZUUXjSHXZEBkbOJg=
X-Google-Smtp-Source: AGHT+IG+94srJz5lZkl9mh3K1Oa0+wlS3LVpvh/lQZV3IAVp64fuuVdfR64LE/Xar9ig3W/fHDiLrA==
X-Received: by 2002:a17:902:ea0e:b0:235:779:edea with SMTP id d9443c01a7336-23e1b195f18mr55245305ad.38.1752600573864;
        Tue, 15 Jul 2025 10:29:33 -0700 (PDT)
Received: from ast-mac ([2620:10d:c090:500::6:249f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4332cdcsm111929315ad.145.2025.07.15.10.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 10:29:33 -0700 (PDT)
Date: Tue, 15 Jul 2025 10:29:27 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Harry Yoo <harry.yoo@oracle.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 3/6] locking/local_lock: Introduce
 local_lock_lockdep_start/end()
Message-ID: <mb6gbhm7f6xflrtzkjjz4rsapudg55ushyzqqo2uw7intdqmcc@4ess725k2gjj>
References: <20250709015303.8107-4-alexei.starovoitov@gmail.com>
 <20250711075001.fnlMZfk6@linutronix.de>
 <1adbee35-6131-49de-835b-2c93aacfdd1e@suse.cz>
 <20250711151730.rz_TY1Qq@linutronix.de>
 <CAADnVQKF=U+Go44fpDYOoZp+3e0xrLYXE4yYLm82H819WqnpnA@mail.gmail.com>
 <20250714110639.uOaKJEfL@linutronix.de>
 <CAADnVQLORq64ezK+gaU=Q2F2KyCYOBZiVE0aaJuqK=xfUwMFiw@mail.gmail.com>
 <d556c4fb-ddc2-4bf0-9510-5c682cd717f5@suse.cz>
 <CAADnVQK3B4ToOOuWOWQdvHO-1as3X2YMGkj45vYQ0Nxoe55Nsw@mail.gmail.com>
 <6835614d-c316-4ecf-ae2b-52687a66ae7c@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6835614d-c316-4ecf-ae2b-52687a66ae7c@suse.cz>

On Tue, Jul 15, 2025 at 08:56:21AM +0200, Vlastimil Babka wrote:
> > the addresses of the locks are different and they're different
> > kmalloc buckets, but lockdep cannot understand this without
> > explicit local_lock_lockdep_start().
> > The same thing I'm trying to explain in the commit log.
> 
> Thanks for the explanation and sorry for being so dense.
> Maybe lockdep's lock classes can be used here somehow instead of having to
> teach lockdep completely new tricks, but I don't know enough about those to
> know for sure.

I tried that with a separate lock_key for each local_trylock_t
and it's sort-of kinda works for 16 cpus, but doesn't scale
when number of cpus is large.
There is no good way to pick LOCKDEP_BITS.

It can be made optional on PREEMP_RT only
and used for kmalloc buckets only that kmalloc_nolock() is using,
but still feels less clean than
local_lock_lockdep_start/end()
since it makes lockdep work harder.

Better ideas?

From da2b3bac08950929da105836fbff7e2ea4ecbc0e Mon Sep 17 00:00:00 2001
From: Alexei Starovoitov <ast@kernel.org>
Date: Tue, 15 Jul 2025 10:16:42 -0700
Subject: [PATCH] lockdep

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 lib/Kconfig.debug |  2 +-
 mm/slub.c         | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ebe33181b6e6..94c07b84ecd0 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1526,7 +1526,7 @@ config LOCKDEP_BITS
 	int "Size for MAX_LOCKDEP_ENTRIES (as Nth power of 2)"
 	depends on LOCKDEP && !LOCKDEP_SMALL
 	range 10 24
-	default 15
+	default 16
 	help
 	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_ENTRIES too low!" message.
 
diff --git a/mm/slub.c b/mm/slub.c
index 2f30b85fbf68..2ae6bf3ebcd0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -395,6 +395,7 @@ struct kmem_cache_cpu {
 	struct slab *partial;	/* Partially allocated slabs */
 #endif
 	local_trylock_t lock;	/* Protects the fields above */
+	struct lock_class_key lock_key;
 #ifdef CONFIG_SLUB_STATS
 	unsigned int stat[NR_SLUB_STAT_ITEMS];
 #endif
@@ -3083,6 +3084,8 @@ static void init_kmem_cache_cpus(struct kmem_cache *s)
 	for_each_possible_cpu(cpu) {
 		c = per_cpu_ptr(s->cpu_slab, cpu);
 		local_trylock_init(&c->lock);
+		lockdep_register_key(&c->lock_key);
+		lockdep_set_class(&c->lock, &c->lock_key);
 		c->tid = init_tid(cpu);
 	}
 }
@@ -5953,6 +5956,16 @@ void __kmem_cache_release(struct kmem_cache *s)
 {
 	cache_random_seq_destroy(s);
 #ifndef CONFIG_SLUB_TINY
+	{
+		int cpu;
+
+		for_each_possible_cpu(cpu) {
+			struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab,
+							       cpu);
+
+			lockdep_unregister_key(&c->lock_key);
+		}
+	}
 	free_percpu(s->cpu_slab);
 #endif
 	free_kmem_cache_nodes(s);
-- 
2.47.1


