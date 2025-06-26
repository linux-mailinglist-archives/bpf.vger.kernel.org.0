Return-Path: <bpf+bounces-61702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBC8AEA843
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 22:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D038C3B6863
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 20:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1552F0C5A;
	Thu, 26 Jun 2025 20:34:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058B72EF643;
	Thu, 26 Jun 2025 20:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750970081; cv=none; b=FmJ0DbCLmdMn51s0gXp+WjsYoz2yujGV4KkuUppg/IafIztv40poAK/9aHs4v3iKVuDuHwNiHdZglOfj8+lDO/kiv67YmDS0o00koF4rvFp/86pWD/SoZmHZe3KDGWmlFpd65Cud8OfGoerO11f7ySvfeTVMsjgkHwNSeo2E+fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750970081; c=relaxed/simple;
	bh=tw1VC7HEs+P9TRBIQv0JaddD9lWTSxt56dxy9IB+8Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQ7+y9Y8DmkBFJtkVn6RddB25TCp1lQag0RXuzhPTRkws0cwMRiRP0uWZvHxMqA9kyJ0CfjYfV+gOtH1cZgSksr3PwGPoMHR3l8lo1w+vO+hEUEViEEGH3mt7WNV+realpsupGEZhlCP6U0X1tzoOs7d2P/c3h2icQK6oLtHm1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id DB41658ADB;
	Thu, 26 Jun 2025 20:34:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id D53906000B;
	Thu, 26 Jun 2025 20:34:30 +0000 (UTC)
Date: Thu, 26 Jun 2025 16:34:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu
 Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v11 06/14] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250626163457.08bbb2e1@gandalf.local.home>
In-Reply-To: <20250626124855.116ef37d@gandalf.local.home>
References: <20250625225600.555017347@goodmis.org>
	<20250625225715.825831885@goodmis.org>
	<20250626124855.116ef37d@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: D53906000B
X-Stat-Signature: s6ut4xsf3a1dmqbwpqbxf8edk6dzpd7z
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19agEkntqvhby0yK+plA+vOgmJyqNYqQCU=
X-HE-Tag: 1750970070-498929
X-HE-Meta: U2FsdGVkX19atWKYAWVIMjvmQI2zpxKH+BWWsOxZ8JTT+EMxujWbLmr9g9DQOIL73ExGOozKXnpmIVWfsq9noQOhvRTz/q9jMIZiQELxdItvnBsFj+MOMcWs4fjISgL+Gjm3cpsc1lkKqK4aX6E6DKV5xYb/v43ve0IS2M4MjEOoIAHfCV9uj6LYa81mi3y3OJejBXfQhNRfqfoqWZ4P2Innl1JsLg4mJ/L6ZXT8+3JK3xeMi6q3hxlQ1M3jhFXRfdDs8DTfBz2dAfZu/jchqb7xEFQ5hZxf/+mUTNsbepeH0mNrXOmqYJDil4gfaRaXnV6YuwM/jRpM3ZN1RUvvQ50p+7cyqZkPbnLxYWfE73rV7UhLIvxSlrQyQV2OcN4W

On Thu, 26 Jun 2025 12:48:55 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> >  static __always_inline void unwind_reset_info(void)
> >  {
> > -	if (unlikely(current->unwind_info.cache))
> > +	/* Exit out early if this was never used */
> > +	if (likely(!current->unwind_info.timestamp))
> > +		return;  
> 
> I found that this breaks the use of perf using the unwind_user_faultable()
> directly and not relying on the deferred infrastructure (which it does when
> it traces a single task and also needs to remove the separate in_nmi()
> code). Because this still requires the nr_entries to be set to zero.
> 
> The clearing of the nr_entries has to be separate from the timestamp. To
> prevent unneeded writes after the cache is allocated, should we check the
> nr_entries is set before writing zero?
> 
> 	if (current->unwind_info.cache && current->unwind_info.cache->nr_entries)
>   		current->unwind_info.cache->nr_entries = 0;
> 
> ?

I just made this into:

 	if (current->unwind_info.cache)
   		current->unwind_info.cache->nr_entries = 0;

As later patches will add more here and I added a new patch that added a
USED bit to the info->unwind_mask that gets set whenever the stack trace is
used and this code needs to be executed. That makes it so that the
unwind_mask is the only condition that needs to be checked when it was
never used.

-- Steve

From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] unwind: Add USED bit to only have one conditional on way back
 to user space

On the way back to user space, the function unwind_reset_info() is called
unconditionally (but always inlined). It currently has two conditionals.
One that checks the unwind_mask which is set whenever a deferred trace is
called and is used to know that the mask needs to be cleared. The other
checks if the cache has been allocated, and if so, it resets the
nr_entries so that the unwinder knows it needs to do the work to get a new
user space stack trace again (it only does it once per entering the
kernel).

Use one of the bits in the unwind mask as a "USED" bit that gets set
whenever a trace is created. This will make it possible to only check the
unwind_mask in the unwind_reset_info() to know if it needs to do work or
not and eliminates a conditional that happens every time the task goes
back to user space.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/unwind_deferred.h | 14 +++++++-------
 kernel/unwind/deferred.c        |  5 ++++-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index e7bf133c5a20..4786acc0f087 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -21,6 +21,10 @@ struct unwind_work {
 #define UNWIND_PENDING_BIT	(BITS_PER_LONG - 1)
 #define UNWIND_PENDING		BIT(UNWIND_PENDING_BIT)
 
+/* Set if the unwinding was used (directly or deferred) */
+#define UNWIND_USED_BIT		(UNWIND_PENDING_BIT - 1)
+#define UNWIND_USED		BIT(UNWIND_USED_BIT)
+
 enum {
 	UNWIND_ALREADY_PENDING	= 1,
 	UNWIND_ALREADY_EXECUTED	= 2,
@@ -51,14 +55,10 @@ static __always_inline void unwind_reset_info(void)
 				return;
 		} while (!try_cmpxchg(&info->unwind_mask, &bits, 0UL));
 		local64_set(&current->unwind_info.timestamp, 0);
+
+		if (unlikely(info->cache))
+			info->cache->nr_entries = 0;
 	}
-	/*
-	 * As unwind_user_faultable() can be called directly and
-	 * depends on nr_entries being cleared on exit to user,
-	 * this needs to be a separate conditional.
-	 */
-	if (unlikely(info->cache))
-		info->cache->nr_entries = 0;
 }
 
 #else /* !CONFIG_UNWIND_USER */
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index c783d273a2dc..9ec1e74c6469 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -131,6 +131,9 @@ int unwind_user_faultable(struct unwind_stacktrace *trace)
 
 	cache->nr_entries = trace->nr;
 
+	/* Clear nr_entries on way back to user space */
+	set_bit(UNWIND_USED_BIT, &info->unwind_mask);
+
 	return 0;
 }
 
@@ -325,7 +328,7 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
 	guard(mutex)(&callback_mutex);
 
 	/* See if there's a bit in the mask available */
-	if (unwind_mask == ~(UNWIND_PENDING))
+	if (unwind_mask == ~(UNWIND_PENDING|UNWIND_USED))
 		return -EBUSY;
 
 	work->bit = ffz(unwind_mask);
-- 
2.47.2


