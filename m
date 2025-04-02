Return-Path: <bpf+bounces-55128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6FBA788D8
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 09:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B3E188D52B
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 07:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3B2231A3F;
	Wed,  2 Apr 2025 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mR42XT3s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DVtYkEV4"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1162E336E;
	Wed,  2 Apr 2025 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743579044; cv=none; b=WWKlOCoT6hw6bDYl0+5/ujpXnjs6VxvPPbh8zbMJGZgCb3XpIRviNyazlWT4uPRXaufP8xty8xgPv7EKL7+cRSZjkEYKGfFezFtP0aRJb2qn8qkzuOItAAm+9RqWcAjlAW9zL6/ZjRYSmoBdGTbD1PFMeoqpZHBJ3kFbyVRFOhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743579044; c=relaxed/simple;
	bh=v5zkqEonCtECUJpYGWnOiiMbx0cPhRk/iIGkb3DE+TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNgtxsJVgaMcP20dqx89tHYzYdzKAp+ClyQ7MyaDO3EEMyA3NP3QYxvcZoWx9Sxc59IdRBhT/VU7yluXmevza+r7R7Z+hwQiqvkGlvaIxOchiCh9X6DyKcsMnwaVP2v0X5wU0rSz+pEAAocO8Kpz5PP44nnzd42+gnI/FsXNOrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mR42XT3s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DVtYkEV4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 2 Apr 2025 09:30:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743579034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXtcAx1AeN+/JvHrdAZySYO4yqdnChpgf0vNyoi5guY=;
	b=mR42XT3sDNPjCgp877WuXrC4rpRnJI0KAzQ6SozV5L6dyk2q634cKnhSx10IViUw1meTgV
	O1zdMkAWxhcqSm80BdEbAtg3U9p7X0wE9gCgWfo+62s4XiIVTObB0Ug9aAk2tEWL+R4v+s
	WKgW+lXVlq3t0TLRrSmAILiGrcIHzAbC3fhrWxge7gvySOTzZ6EdFVipxzyNSZr53iAxlX
	4VFVdLuyeWC/FOqs6Nhmj1/ChZ6g0t0SvEpuRJ8oeKutQ0krOACsfHM0hi9nkMBmsGL9+B
	hpDf0Wu7Gskcc7qbLVgSOPPBtTAlxDYcBDZ51SrQakXEv+lEbr3APlzz4y7ztA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743579034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXtcAx1AeN+/JvHrdAZySYO4yqdnChpgf0vNyoi5guY=;
	b=DVtYkEV4s4clT/TiIJhH098C/kbVMfv0xsbvYmhu/GtOrxdlRvAOatc0Lv8r4dWRm+NM/f
	xJ8FUa5dDEUYrnCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz,
	rostedt@goodmis.org, shakeel.butt@linux.dev, mhocko@suse.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/local_lock, mm: Replace localtry_ helpers with
 local_trylock_t type
Message-ID: <20250402073032.rqsmPfJs@linutronix.de>
References: <20250401005134.14433-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250401005134.14433-1-alexei.starovoitov@gmail.com>

On 2025-03-31 17:51:34 [-0700], Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Partially revert commit 0aaddfb06882 ("locking/local_lock: Introduce loca=
ltry_lock_t").
> Remove localtry_*() helpers, since localtry_lock() name might
> be misinterpreted as "try lock".

So we back to what you suggested initially. I was more a fan of
explicitly naming things but if this is misleading so be it. So

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

While at it, could you look at the hunk below and check if it worth it?
The struct duplication and hoping that the first part remains the same,
is hoping. This still relies that the first part remains the same but=E2=80=
=A6

Sebastian

diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock=
_internal.h
index cc79854206dff..dfdeded54348d 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -17,15 +17,8 @@ typedef struct {
=20
 /* local_trylock() and local_trylock_irqsave() only work with local_tryloc=
k_t */
 typedef struct {
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lockdep_map	dep_map;
-	struct task_struct	*owner;
-#endif
-	/*
-	 * Same layout as local_lock_t with 'acquired' field at the end.
-	 * (local_trylock_t *) will be casted to (local_lock_t *).
-	 */
-	int acquired;
+	local_lock_t	llock;
+	int		acquired;
 } local_trylock_t;
=20
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -37,6 +30,9 @@ typedef struct {
 	},						\
 	.owner =3D NULL,
=20
+# define LOCAL_TRYLOCK_DEBUG_INIT(lockname)		\
+	.llock =3D { LOCAL_LOCK_DEBUG_INIT((lockname).llock) },
+
 static inline void local_lock_acquire(local_lock_t *l)
 {
 	lock_map_acquire(&l->dep_map);
@@ -64,6 +60,7 @@ static inline void local_lock_debug_init(local_lock_t *l)
 }
 #else /* CONFIG_DEBUG_LOCK_ALLOC */
 # define LOCAL_LOCK_DEBUG_INIT(lockname)
+# define LOCAL_TRYLOCK_DEBUG_INIT(lockname)
 static inline void local_lock_acquire(local_lock_t *l) { }
 static inline void local_trylock_acquire(local_lock_t *l) { }
 static inline void local_lock_release(local_lock_t *l) { }
@@ -71,6 +68,7 @@ static inline void local_lock_debug_init(local_lock_t *l)=
 { }
 #endif /* !CONFIG_DEBUG_LOCK_ALLOC */
=20
 #define INIT_LOCAL_LOCK(lockname)	{ LOCAL_LOCK_DEBUG_INIT(lockname) }
+#define INIT_LOCAL_TRYLOCK(lockname)	{ LOCAL_TRYLOCK_DEBUG_INIT(lockname) }
=20
 #define __local_lock_init(lock)					\
 do {								\
@@ -198,6 +196,7 @@ typedef spinlock_t local_lock_t;
 typedef spinlock_t local_trylock_t;
=20
 #define INIT_LOCAL_LOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
+#define INIT_LOCAL_TRYLOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
=20
 #define __local_lock_init(l)					\
 	do {							\
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 813f5b73e7c8c..c96c1f2b9cf57 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1774,7 +1774,7 @@ struct memcg_stock_pcp {
 #define FLUSHING_CACHED_CHARGE	0
 };
 static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock) =3D {
-	.stock_lock =3D INIT_LOCAL_LOCK(stock_lock),
+	.stock_lock =3D INIT_LOCAL_TRYLOCK(stock_lock),
 };
 static DEFINE_MUTEX(percpu_charge_mutex);
=20


