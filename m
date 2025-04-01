Return-Path: <bpf+bounces-55081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F28A77D83
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 16:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFDFD161C1C
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 14:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC762054E4;
	Tue,  1 Apr 2025 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C5WyKFjS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v6R1h9rj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rexuW2xe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ox2DFSQo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC79204F94
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743517086; cv=none; b=t/cu3wz7SoKJSfHhUMcGO+a7x/aeWqfHAbGV9FtKnCNtO5k1blEsdX8Q6XZ/1Ub7J11VHyMIj0v7luM6XoK0ZdhDrCvKOYd/EbUpi7ISszGf8SiH9i5P4B92g1SXMAzJrMfrzoyP30VLW3DV5bx7mmwEdc8mw9jxyrR0wG6a0W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743517086; c=relaxed/simple;
	bh=Y7jsjWBuwe702oaNOkC97s4Or584AGrSbN/Xz5jZVD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JGKe8IscJCQ3cb2WvMdDbZ3K5SBPzWhgqGnYI98ATKM+gecyJ+yTELI2Y/Ez6u93zKnfwC2LKYN43HRBheYbVzDVC1wFOpJ80D9L0nrZhXamkpNxIaoUEEWu2YtfYlmTANoWxN0zzocGorWqEaNRld7siAlKGv2en7CJaCX51sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C5WyKFjS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v6R1h9rj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rexuW2xe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ox2DFSQo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D73E01F38E;
	Tue,  1 Apr 2025 14:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743517083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nywPJHY2aHhWmHc5HhX/rKXrnwGvUOpqsHuTYIcbA00=;
	b=C5WyKFjSDfbaNutXxOR/HxhlJmLNxMLgxyHZFw1NRBkk5fU88H0Lq0jepsNJ96whYsq6iW
	NhcIi1qUnHSChVxYyIodAXKrE+7wcwmQGmv0UIAd01UAW5mscRrTsmSHgbB59Zr6g/Xc0R
	G3p35QxwcctvNSJON2FsEgsgBbrp64w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743517083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nywPJHY2aHhWmHc5HhX/rKXrnwGvUOpqsHuTYIcbA00=;
	b=v6R1h9rj4oS8/e2fhSL9kNuk1eXhhrSb0BPcPtPch1mZdXRbgJKayr9JGeJd2n22X9s3mg
	NJosxdkShOW/AsAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743517082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nywPJHY2aHhWmHc5HhX/rKXrnwGvUOpqsHuTYIcbA00=;
	b=rexuW2xecf84ysFcxOqbSoc6+fKYd/mGtit4u1qmSZ/TNPX6FwI7vlOzPSI4sxHkpapP2C
	t8IYfkM2a+ni2XPqK4NVUZTMcIAx0DSY5vo7exDtteLJpldiNyWAScgpkOaaUis6YqiAgz
	AkpLe8G8NHCXeLtWH3l41BRAt2pX0qA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743517082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nywPJHY2aHhWmHc5HhX/rKXrnwGvUOpqsHuTYIcbA00=;
	b=ox2DFSQoWModJPYitU5WGDaL97dFUOlKEzgMme2fD7QKyi+WRl8uO7b/0YpixmZ1AlsZDN
	V9m81qIaY0sF3eBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B664113A43;
	Tue,  1 Apr 2025 14:18:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 72kxLJr162ceYgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 01 Apr 2025 14:18:02 +0000
Message-ID: <84d7adee-fa83-4a8b-8476-820212dc929e@suse.cz>
Date: Tue, 1 Apr 2025 16:18:02 +0200
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
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, akpm@linux-foundation.org, peterz@infradead.org,
 bigeasy@linutronix.de, rostedt@goodmis.org, shakeel.butt@linux.dev,
 mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250401005134.14433-1-alexei.starovoitov@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250401005134.14433-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 4/1/25 02:51, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Partially revert commit 0aaddfb06882 ("locking/local_lock: Introduce localtry_lock_t").
> Remove localtry_*() helpers, since localtry_lock() name might
> be misinterpreted as "try lock".
> 
> Introduce local_trylock_irqsave() helper that only works

Introduce local_trylock[_irqsave]() helpers that only work

?

> with newly introduced local_trylock_t type.
> Note that attempt to use local_trylock_irqsave() with local_lock_t
> will cause compilation failure.
> 
> Usage and behavior in !PREEMPT_RT:
> 
> local_lock_t lock;                     // sizeof(lock) == 0

local_lock(&lock, ...);			// preempt disable

> local_lock_irqsave(&lock, ...);        // irq save
> if (local_trylock_irqsave(&lock, ...)) // compilation error
> 
> local_trylock_t lock;                  // sizeof(lock) == 4

ditto

> local_lock_irqsave(&lock, ...);        // irq save and acquired = 1
> if (local_trylock_irqsave(&lock, ...)) // if (!acquired) irq save
> 
> The existing local_lock_*() macros can be used either with
> local_lock_t or local_trylock_t.
> With local_trylock_t they set acquired = 1 while local_unlock_*() clears it.
> 
> In !PREEMPT_RT local_lock_irqsave(local_lock_t *) disables interrupts
> to protect critical section, but it doesn't prevent NMI, so the fully
> reentrant code cannot use local_lock_irqsave(local_lock_t *) for
> exclusive access.
> 
> The local_lock_irqsave(local_trylock_t *) helper disables interrupts
> and sets acquired=1, so local_trylock_irqsave(local_trylock_t *) from
> NMI attempting to acquire the same lock will return false.
> 
> In PREEMPT_RT local_lock_irqsave() maps to preemptible spin_lock().
> Map local_trylock_irqsave() to preemptible spin_trylock().
> When in hard IRQ or NMI return false right away, since
> spin_trylock() is not safe due to explicit locking in the underneath
> rt_spin_trylock() implementation. Removing this explicit locking and
> attempting only "trylock" is undesired due to PI implications.

And something like:

The local_trylock() without _irqsave can be used to avoid the cost of
disabling/enabling interrupts by only disabling preemption, so
local_trylock() in an interrupt attempting to acquire the same
lock will return false.

> Note there is no need to use local_inc for acquired variable,
> since it's a percpu variable with strict nesting scopes.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Is there a chance this refactoring will make it to -rc1? It would make
basing the further usage of the lock in mm and slab trees much easier.

But squash in the following fixups please:
----8<----
From bc9098ebb58a2958010428c9294547934852ffa2 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 1 Apr 2025 15:25:21 +0200
Subject: [PATCH] fixup! locking/local_lock, mm: Replace localtry_ helpers with
 local_trylock_t type

---
 include/linux/local_lock.h          |  5 ++---
 include/linux/local_lock_internal.h | 21 +++++++++++++++++++--
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 9262109cca51..7ac9385cd475 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -52,15 +52,14 @@
 	__local_unlock_irqrestore(lock, flags)
 
 /**
- * local_trylock_irqsave - Try to acquire a per CPU local lock
+ * local_trylock - Try to acquire a per CPU local lock
  * @lock:	The lock variable
- * @flags:	Storage for interrupt flags
  *
  * The function can be used in any context such as NMI or HARDIRQ. Due to
  * locking constrains it will _always_ fail to acquire the lock in NMI or
  * HARDIRQ context on PREEMPT_RT.
  */
-#define local_trylock(lock, flags)	__local_trylock(lock, flags)
+#define local_trylock(lock)		__local_trylock(lock)
 
 /**
  * local_trylock_irqsave - Try to acquire a per CPU local lock, save and disable
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index cc79854206df..5634383c8e9e 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -23,7 +23,7 @@ typedef struct {
 #endif
 	/*
 	 * Same layout as local_lock_t with 'acquired' field at the end.
-	 * (local_trylock_t *) will be casted to (local_lock_t *).
+	 * (local_trylock_t *) will be cast to (local_lock_t *).
 	 */
 	int acquired;
 } local_trylock_t;
@@ -80,7 +80,7 @@ do {								\
 	lockdep_init_map_type(&(lock)->dep_map, #lock, &__key,  \
 			      0, LD_WAIT_CONFIG, LD_WAIT_INV,	\
 			      LD_LOCK_PERCPU);			\
-	local_lock_debug_init(lock);				\
+	local_lock_debug_init((local_lock_t *)lock);		\
 } while (0)
 
 #define __spinlock_nested_bh_init(lock)				\
@@ -128,6 +128,23 @@ do {								\
 		__local_lock_acquire(lock);			\
 	} while (0)
 
+#define __local_trylock(lock)					\
+	({							\
+		local_trylock_t *tl;				\
+								\
+		preempt_disable();				\
+		tl = this_cpu_ptr(lock);			\
+		if (READ_ONCE(tl->acquired) == 1) {		\
+			preempt_enable();			\
+			tl = NULL;				\
+		} else {					\
+			WRITE_ONCE(tl->acquired, 1);		\
+			local_trylock_acquire(			\
+				(local_lock_t *)tl);		\
+		}						\
+		!!tl;						\
+	})
+
 #define __local_trylock_irqsave(lock, flags)			\
 	({							\
 		local_trylock_t *tl;				\
-- 
2.49.0



