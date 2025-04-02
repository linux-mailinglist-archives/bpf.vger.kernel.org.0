Return-Path: <bpf+bounces-55131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA802A78A95
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 11:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24BF18954DA
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 09:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E023C236420;
	Wed,  2 Apr 2025 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="up426dt/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VbQzgEAU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="up426dt/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VbQzgEAU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC5E23535B
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743584575; cv=none; b=OVx4cceIKutD+2FxtURnabtI3Yjw5X7kNIMWJZN8v6dPOQLJYi3N/lx+X3TImXNvWRLCAe+OOg4l04wjuWTX1sQWLMu9j/uKggyuC/TmaEVTs8bHBMgEHnuvUJBcJKX/nA0FNHvp2+znwMmbMfy0hP7tFRZwRoxOv7B/mFsg0Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743584575; c=relaxed/simple;
	bh=ktTx9xtc4Slo5Czxl/jNm8Y83TVDmYTQOH/8R2zzeRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QodoXGv8og2b9AivQX2Ut2VrlWTitdsA3WKP0HBnadWeZqeiK5S7mx23Puxh35PscJDIaWRG8+Y2dGKeo4l57aEFLb6fPiImypRc8lcy2LTw9DkOCkM549AJEU116LKXkO1f29g6CNISj9c2xRksfeQoPdaBezdjgKIMZbwG28s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=up426dt/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VbQzgEAU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=up426dt/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VbQzgEAU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E0FA1F455;
	Wed,  2 Apr 2025 09:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743584571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EOMQWK3ChVizaeK2FCjKPQYIKHNhrgOGcfTl9Rl4IG0=;
	b=up426dt/AtPt3hmLYqxGQxSjgFbEJYSohTG3yILtK3WfJ5UrbJNAPo0wWePFvfrb/pW5OB
	gBma+zH2pG8IHjJspy4E09Gsx9MpJB4lpaTaBRmCZ3yVCu65FeiWOX2rRnMdAgwPIVS68b
	KhnxpNl2CPrwxqPZSR4xmD6F304dNT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743584571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EOMQWK3ChVizaeK2FCjKPQYIKHNhrgOGcfTl9Rl4IG0=;
	b=VbQzgEAUmcVoZNz5Sp8WYo5xWccRjKSP5mWDZOCQhhyTSr2MXXCvEDeK0m/5HQy6a+MaWO
	4GNaTbPkr76+NwAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="up426dt/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VbQzgEAU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743584571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EOMQWK3ChVizaeK2FCjKPQYIKHNhrgOGcfTl9Rl4IG0=;
	b=up426dt/AtPt3hmLYqxGQxSjgFbEJYSohTG3yILtK3WfJ5UrbJNAPo0wWePFvfrb/pW5OB
	gBma+zH2pG8IHjJspy4E09Gsx9MpJB4lpaTaBRmCZ3yVCu65FeiWOX2rRnMdAgwPIVS68b
	KhnxpNl2CPrwxqPZSR4xmD6F304dNT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743584571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EOMQWK3ChVizaeK2FCjKPQYIKHNhrgOGcfTl9Rl4IG0=;
	b=VbQzgEAUmcVoZNz5Sp8WYo5xWccRjKSP5mWDZOCQhhyTSr2MXXCvEDeK0m/5HQy6a+MaWO
	4GNaTbPkr76+NwAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EA5B13A4B;
	Wed,  2 Apr 2025 09:02:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LHa2Gjv97GdOPAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 02 Apr 2025 09:02:51 +0000
Message-ID: <62dd026d-1290-49cb-a411-897f4d5f6ca7@suse.cz>
Date: Wed, 2 Apr 2025 11:02:51 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/local_lock, mm: Replace localtry_ helpers with
 local_trylock_t type
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 akpm@linux-foundation.org, peterz@infradead.org, rostedt@goodmis.org,
 shakeel.butt@linux.dev, mhocko@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250401005134.14433-1-alexei.starovoitov@gmail.com>
 <20250402073032.rqsmPfJs@linutronix.de>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250402073032.rqsmPfJs@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9E0FA1F455
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[linutronix.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 4/2/25 09:30, Sebastian Andrzej Siewior wrote:
> On 2025-03-31 17:51:34 [-0700], Alexei Starovoitov wrote:
>> From: Alexei Starovoitov <ast@kernel.org>
>> 
>> Partially revert commit 0aaddfb06882 ("locking/local_lock: Introduce localtry_lock_t").
>> Remove localtry_*() helpers, since localtry_lock() name might
>> be misinterpreted as "try lock".
> 
> So we back to what you suggested initially. I was more a fan of
> explicitly naming things but if this is misleading so be it. So
> 
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> While at it, could you look at the hunk below and check if it worth it?
> The struct duplication and hoping that the first part remains the same,
> is hoping. This still relies that the first part remains the same but…

I've updated your fixups to v2
https://lore.kernel.org/all/20250401205245.70838-1-alexei.starovoitov@gmail.com/

and to support runtime local_trylock_init(), and it's at the end of my e-mail

But I also thought we could go all the way with removing casting in
that way and stop relying on the same layout implicitly.

So I rewrote this:

#define __local_lock_acquire(lock)                                      \
        do {                                                            \
                local_trylock_t *tl;                                    \
                local_lock_t *l;                                        \
                                                                        \
                _Generic((lock),                                        \
                        local_lock_t *: ({                      	\
                                l = this_cpu_ptr(lock);                 \
                        }),                                             \
                        local_trylock_t *: ({                   	\
                                tl = this_cpu_ptr(lock);                \
                                l = &tl->llock;                         \
                                lockdep_assert(tl->acquired == 0);      \
                                WRITE_ONCE(tl->acquired, 1);            \
                        }),                                             \
                        default:(void)0);                               \
                local_lock_acquire(l);                                  \
        } while (0)

But I'm getting weird errors:

./include/linux/local_lock_internal.h:107:36: error: assignment to ‘local_trylock_t *’ from incompatible pointer type ‘local_lock_t *’ [-Wincompatible-pointer-types]
  107 |                                 tl = this_cpu_ptr(lock);                \

coming from the guard expansions. I don't understand why it goes to the
_Generic() "branch" of local_trylock_t * with a local_lock_t *.

----8<----
From eeeb928ccc6d86e93cb573fb93ce4f6aeb8576fb Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 2 Apr 2025 10:13:28 +0200
Subject: [PATCH] fixup! locking/local_lock, mm: Replace localtry_ helpers with
 local_trylock_t type

---
 include/linux/local_lock.h          |  5 +++++
 include/linux/local_lock_internal.h | 23 +++++++++++++----------
 mm/memcontrol.c                     |  2 +-
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 7ac9385cd475..16a2ee4f8310 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -51,6 +51,11 @@
 #define local_unlock_irqrestore(lock, flags)			\
 	__local_unlock_irqrestore(lock, flags)
 
+/**
+ * local_lock_init - Runtime initialize a lock instance
+ */
+#define local_trylock_init(lock)	__local_trylock_init(lock)
+
 /**
  * local_trylock - Try to acquire a per CPU local lock
  * @lock:	The lock variable
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 2389ae4f69a6..6ccb2c4ef86f 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -17,15 +17,8 @@ typedef struct {
 
 /* local_trylock() and local_trylock_irqsave() only work with local_trylock_t */
 typedef struct {
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lockdep_map	dep_map;
-	struct task_struct	*owner;
-#endif
-	/*
-	 * Same layout as local_lock_t with 'acquired' field at the end.
-	 * (local_trylock_t *) will be cast to (local_lock_t *).
-	 */
-	int acquired;
+	local_lock_t	llock;
+	int		acquired;
 } local_trylock_t;
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -37,6 +30,9 @@ typedef struct {
 	},						\
 	.owner = NULL,
 
+# define LOCAL_TRYLOCK_DEBUG_INIT(lockname)		\
+	.llock = { LOCAL_LOCK_DEBUG_INIT((lockname).llock) },
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
@@ -71,6 +68,7 @@ static inline void local_lock_debug_init(local_lock_t *l) { }
 #endif /* !CONFIG_DEBUG_LOCK_ALLOC */
 
 #define INIT_LOCAL_LOCK(lockname)	{ LOCAL_LOCK_DEBUG_INIT(lockname) }
+#define INIT_LOCAL_TRYLOCK(lockname)	{ LOCAL_TRYLOCK_DEBUG_INIT(lockname) }
 
 #define __local_lock_init(lock)					\
 do {								\
@@ -80,9 +78,11 @@ do {								\
 	lockdep_init_map_type(&(lock)->dep_map, #lock, &__key,  \
 			      0, LD_WAIT_CONFIG, LD_WAIT_INV,	\
 			      LD_LOCK_PERCPU);			\
-	local_lock_debug_init((local_lock_t *)lock);		\
+	local_lock_debug_init(lock);				\
 } while (0)
 
+#define __local_trylock_init(lock) __local_lock_init(lock.llock)
+
 #define __spinlock_nested_bh_init(lock)				\
 do {								\
 	static struct lock_class_key __key;			\
@@ -215,12 +215,15 @@ typedef spinlock_t local_lock_t;
 typedef spinlock_t local_trylock_t;
 
 #define INIT_LOCAL_LOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
+#define INIT_LOCAL_TRYLOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
 
 #define __local_lock_init(l)					\
 	do {							\
 		local_spin_lock_init((l));			\
 	} while (0)
 
+#define __local_trylock_init(l)			__local_lock_init(l)
+
 #define __local_lock(__lock)					\
 	do {							\
 		migrate_disable();				\
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bca86961754e..0401fb7b6c6a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1754,7 +1754,7 @@ struct memcg_stock_pcp {
 #define FLUSHING_CACHED_CHARGE	0
 };
 static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock) = {
-	.stock_lock = INIT_LOCAL_LOCK(stock_lock),
+	.stock_lock = INIT_LOCAL_TRYLOCK(stock_lock),
 };
 static DEFINE_MUTEX(percpu_charge_mutex);
 
-- 
2.49.0



