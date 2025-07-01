Return-Path: <bpf+bounces-61921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A56AEEB7B
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 02:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72093E17D3
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 00:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6380E236431;
	Tue,  1 Jul 2025 00:54:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856EE1DE8A8;
	Tue,  1 Jul 2025 00:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331270; cv=none; b=bIgE1akY9MwX5ag0/dxTgdNOcYTuBSPqkPp48l+dxoYIEOWgtL8flmY0YO9sjj68UJoc8uVHmvHi7j46y7ExiZcZodcw8clyKjAxXXmOhCoyopvy1SMLAOWW+YYhBMMy22lPweFlTm8kH68l0zN+hGvg2A0RhulH7LEq78Zsi0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331270; c=relaxed/simple;
	bh=GxsWDBD9I8xgA6mocM89fqPpLAPvsy58hRYfl9t6/Q8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=bmfCKsk6w1HlNilfSADtzrMCJGcub7GxNP5SZm/37WKoHoGl1O3nykH5ZWTFBjMO2vz2tctp3KSeDscT6LXgxw9/rmjvdT/ngj68oLQGQCZR6lXp8X6McD57EyPGSvOTLX9U3T64D4eUyX+qKUE3A3YseDOYMk9jscE8vCMq44Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 2CFD4B75F3;
	Tue,  1 Jul 2025 00:54:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id B31392F;
	Tue,  1 Jul 2025 00:54:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uWPGu-00000007Nje-2LQ8;
	Mon, 30 Jun 2025 20:54:52 -0400
Message-ID: <20250701005452.410928589@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 30 Jun 2025 20:53:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>
Subject: [PATCH v12 11/14] unwind: Add USED bit to only have one conditional on way back to user
 space
References: <20250701005321.942306427@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: k7xnun1bnkyjn736ianodppzekqz1gon
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: B31392F
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19eKUGLvBLqRE45Kp4Db8tasvp/PYHjQVs=
X-HE-Tag: 1751331255-3749
X-HE-Meta: U2FsdGVkX1/mbvrZl5+8EhNgL1PIjqDaW1yKBD81gcn6LuB/4orj1A2jMOX7GY0kPjqxUuk4MgWGBVW2rofCqRReFDzs9O9oD9bmy+06vpO3X1+O3VtrfhwOhYMMDbvdiVQma0Vf9u8Qw8u67KkdpD8Yl2bLvTyueCi+kOF3DqUfULyYHKV9zhQmyUvBv2pe4AmsJ9zApONJqsCziQBavNRtt2BeMjUSRR+LxQM25j/qOWhk+FHyXz4O7JcDFUvCagn02TNGIB5vmlEIm0pltXF/ErzY2llY22VSDXNpkI3/66yfoQ36dwL7XCyL+5Ibsk8QKkO4rsaMpAkDhIo2C670KpaecoTEnpc4tg2HAyD5ltdd3qxiY1Z5a549gaHDf0W5cRpIrYmvEYNVscahc+Ig7QA+RA1puTE5huVq/4oCrP7+tDfFDw==

From: Steven Rostedt <rostedt@goodmis.org>

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
index d25a72fb21ef..a1c62097f142 100644
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
@@ -49,14 +53,10 @@ static __always_inline void unwind_reset_info(void)
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
index e7e4442926d3..5ab9b9045ae5 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -131,6 +131,9 @@ int unwind_user_faultable(struct unwind_stacktrace *trace)
 
 	cache->nr_entries = trace->nr;
 
+	/* Clear nr_entries on way back to user space */
+	set_bit(UNWIND_USED_BIT, &info->unwind_mask);
+
 	return 0;
 }
 
@@ -308,7 +311,7 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
 	guard(mutex)(&callback_mutex);
 
 	/* See if there's a bit in the mask available */
-	if (unwind_mask == ~(UNWIND_PENDING))
+	if (unwind_mask == ~(UNWIND_PENDING|UNWIND_USED))
 		return -EBUSY;
 
 	work->bit = ffz(unwind_mask);
-- 
2.47.2



