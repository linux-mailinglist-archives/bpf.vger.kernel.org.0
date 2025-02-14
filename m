Return-Path: <bpf+bounces-51563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CD4A35D52
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 13:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D175D7A218C
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 12:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A7A263C73;
	Fri, 14 Feb 2025 12:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t3yVCudC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T2N2PqOx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c5zmAyGW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U+CEmb/O"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7EA2139A8
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739535100; cv=none; b=uEAM28KyUwl0FJjbyJou/FV8JtTUeznmA1wWAPgqTc8cTCnGeh7JjZFsg1mPb5oosXMQtDIqh4GPFTJejFJNM1jOl9nszRAqBz0x+vaRw2lYOOTx/72mucLO+L6MO+K8lS4Cyauczpjg6W3oYXZqelVeszR2DObhN3vldZdc2aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739535100; c=relaxed/simple;
	bh=g+opLRlvl1TXBQyaULfPhhwGsbKBmjcBMDNwTaixuDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3GuMQ7A2gvoaNKa3ytEjuxH5aVwHdJMUNptV8vvGV+CAD3/h4cDLERRvIPvJnABvmMoceJ/TPfibDjtnhJACUUFPZKht8Kp1etvdmewzIkRlCawm9T6cO/vLMySky7sEUdyGHfYN4XG9qRGYI7ML7i/r3+N8EQwo9E0ZBBB4FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t3yVCudC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T2N2PqOx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c5zmAyGW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U+CEmb/O; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 038B42116D;
	Fri, 14 Feb 2025 12:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739535092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=z4K+C9Eqk0Vm9TBaNOrBKZykA6o6UJw4ZbHyyjKPZ74=;
	b=t3yVCudCZHOQQkpb967FppG3tQ1N2uGMZIJOVRMORDaX7mLUSUxcYWVoxrDXLXCE27zRYL
	L2pmAO4EIn7QxVFfF9W6/z1gKNTa866hNL+pdJZx3q0NGwIkd6Qy2ShwSxClLUwRpuIzvj
	ifWq7zrheuMn3d35gXFzn2ld3h3DvqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739535092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=z4K+C9Eqk0Vm9TBaNOrBKZykA6o6UJw4ZbHyyjKPZ74=;
	b=T2N2PqOxkZ2Bmg7JV8NM5eaV1qzUu8Z89WK4x83Lf/l3/vC6sk+6P8rUkHa6r74/G5SmUN
	SigG+jrjXllG99CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=c5zmAyGW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="U+CEmb/O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739535087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=z4K+C9Eqk0Vm9TBaNOrBKZykA6o6UJw4ZbHyyjKPZ74=;
	b=c5zmAyGWBqR6QjbYs03sZhVl2N8ZS/g9sg06u9qoBJEe5VgWXA2jQDwNgQsqHSTBiSpR0d
	J/6cWjKyY6ZC9AbWMps654m0yr8z0GWPYq0FE5Tigziw/gaLtH9noSZW6/HIJi+NFPK38L
	B6Ypbytmh1ICBtKvHzbeyPukhN/KaVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739535087;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=z4K+C9Eqk0Vm9TBaNOrBKZykA6o6UJw4ZbHyyjKPZ74=;
	b=U+CEmb/OT3W7jpkJdh9GMkBH76jlueMHwjmOJ6egQHOJYFxqo57MEJZFCdi2G1C8YqjWFw
	18RUCFCHXfhiMCCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB51413285;
	Fri, 14 Feb 2025 12:11:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V1qpKO4yr2fpcAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 14 Feb 2025 12:11:26 +0000
Message-ID: <efc30cf9-8351-4889-8245-cc4a6893ebf4@suse.cz>
Date: Fri, 14 Feb 2025 13:11:26 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 3/6] locking/local_lock: Introduce
 localtry_lock_t
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
 peterz@infradead.org, bigeasy@linutronix.de, rostedt@goodmis.org,
 houtao1@huawei.com, hannes@cmpxchg.org, shakeel.butt@linux.dev,
 mhocko@suse.com, willy@infradead.org, tglx@linutronix.de, jannh@google.com,
 tj@kernel.org, linux-mm@kvack.org, kernel-team@fb.com
References: <20250213033556.9534-1-alexei.starovoitov@gmail.com>
 <20250213033556.9534-4-alexei.starovoitov@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20250213033556.9534-4-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 038B42116D
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux-foundation.org,infradead.org,linutronix.de,goodmis.org,huawei.com,cmpxchg.org,linux.dev,suse.com,google.com,kvack.org,fb.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RBL_NIXSPAM_FAIL(0.00)[2a07:de40:b281:104:10:150:64:97:query timed out];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 2/13/25 04:35, Alexei Starovoitov wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> In !PREEMPT_RT local_lock_irqsave() disables interrupts to protect
> critical section, but it doesn't prevent NMI, so the fully reentrant
> code cannot use local_lock_irqsave() for exclusive access.
> 
> Introduce localtry_lock_t and localtry_lock_irqsave() that
> disables interrupts and sets acquired=1, so localtry_lock_irqsave()
> from NMI attempting to acquire the same lock will return false.
> 
> In PREEMPT_RT local_lock_irqsave() maps to preemptible spin_lock().
> Map localtry_lock_irqsave() to preemptible spin_trylock().
> When in hard IRQ or NMI return false right away, since
> spin_trylock() is not safe due to PI issues.
> 
> Note there is no need to use local_inc for acquired variable,
> since it's a percpu variable with strict nesting scopes.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

...

>  
> +/* localtry_lock_t variants */
> +
> +#define __localtry_lock_init(lock)				\
> +do {								\
> +	__local_lock_init(&(lock)->llock);			\
> +	WRITE_ONCE(&(lock)->acquired, 0);			\

This needs to be WRITE_ONCE((lock)->acquired, 0);

I'm adopting this implementation for my next slab sheaves RFC. But I'll want
localtry_trylock() without _irqsave too, so I've added it locally. Posting
below with the init fix and making the PREEMPT_RT comment clear. Feel free
to fold everything, it would make it easier for me. Or just the fixes, if
you don't want code you don't use yourself.

----8<----
From c4f47afa3d06367d8d54662d6c3a76d3ab6e349d Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 13 Feb 2025 19:38:31 +0100
Subject: [PATCH] locking/local_lock: add localtry_trylock()

Add a localtry_trylock() variant without _irqsave that will be used in
slab sheaves implementation. Thanks to only disabling preemption and not
irqs, it has a lower overhead. It's not necessary to disable irqs to
avoid a deadlock if the irq context uses trylock and can handle
failures.

Also make the comment of localtry_trylock_irqsave() more clear, and fix a
compilation failure in localtry_lock_init().

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/local_lock.h          | 13 +++++++++++-
 include/linux/local_lock_internal.h | 31 +++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 05c254a5d7d3..1a0bc35839e3 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -77,6 +77,16 @@
 #define localtry_lock_irqsave(lock, flags)				\
 	__localtry_lock_irqsave(lock, flags)
 
+/**
+ * localtry_trylock - Try to acquire a per CPU local lock.
+ * @lock:	The lock variable
+ *
+ * The function can be used in any context such as NMI or HARDIRQ. Due to
+ * locking constrains it will _always_ fail to acquire the lock in NMI or
+ * HARDIRQ context on PREEMPT_RT.
+ */
+#define localtry_trylock(lock)		__localtry_trylock(lock)
+
 /**
  * localtry_trylock_irqsave - Try to acquire a per CPU local lock, save and disable
  *			      interrupts if acquired
@@ -84,7 +94,8 @@
  * @flags:	Storage for interrupt flags
  *
  * The function can be used in any context such as NMI or HARDIRQ. Due to
- * locking constrains it will _always_ fail to acquire the lock on PREEMPT_RT.
+ * locking constrains it will _always_ fail to acquire the lock in NMI or
+ * HARDIRQ context on PREEMPT_RT.
  */
 #define localtry_trylock_irqsave(lock, flags)				\
 	__localtry_trylock_irqsave(lock, flags)
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index c1369b300777..67bd13d142fa 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -137,7 +137,7 @@ do {								\
 #define __localtry_lock_init(lock)				\
 do {								\
 	__local_lock_init(&(lock)->llock);			\
-	WRITE_ONCE(&(lock)->acquired, 0);			\
+	WRITE_ONCE((lock)->acquired, 0);			\
 } while (0)
 
 #define __localtry_lock(lock)					\
@@ -167,6 +167,24 @@ do {								\
 		WRITE_ONCE(lt->acquired, 1);			\
 	} while (0)
 
+#define __localtry_trylock(lock)				\
+	({							\
+		localtry_lock_t *lt;				\
+		bool _ret;					\
+								\
+		preempt_disable();				\
+		lt = this_cpu_ptr(lock);			\
+		if (!READ_ONCE(lt->acquired)) {			\
+			WRITE_ONCE(lt->acquired, 1);		\
+			local_trylock_acquire(&lt->llock);	\
+			_ret = true;				\
+		} else {					\
+			_ret = false;				\
+			preempt_enable();			\
+		}						\
+		_ret;						\
+	})
+
 #define __localtry_trylock_irqsave(lock, flags)			\
 	({							\
 		localtry_lock_t *lt;				\
@@ -275,12 +293,10 @@ do {								\
 #define __localtry_unlock_irq(lock)			__local_unlock(lock)
 #define __localtry_unlock_irqrestore(lock, flags)	__local_unlock_irqrestore(lock, flags)
 
-#define __localtry_trylock_irqsave(lock, flags)			\
+#define __localtry_trylock(lock)				\
 	({							\
 		int __locked;					\
 								\
-		typecheck(unsigned long, flags);		\
-		flags = 0;					\
 		if (in_nmi() | in_hardirq()) {			\
 			__locked = 0;				\
 		} else {					\
@@ -292,4 +308,11 @@ do {								\
 		__locked;					\
 	})
 
+#define __localtry_trylock_irqsave(lock, flags)			\
+	({							\
+		typecheck(unsigned long, flags);		\
+		flags = 0;					\
+		__localtry_trylock(lock);			\
+	})
+
 #endif /* CONFIG_PREEMPT_RT */
-- 
2.48.1





