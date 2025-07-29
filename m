Return-Path: <bpf+bounces-64653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA34BB152AC
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 20:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B89C97A7A24
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 18:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4691024EAB1;
	Tue, 29 Jul 2025 18:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rB2bwMk5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9942223F40E;
	Tue, 29 Jul 2025 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813431; cv=none; b=NV9cUT7QNtstmFgPV5IWMj/Gzb1Q8X36WeZXjOpy28F1UGA3CxBIpF/1lCPNL6Z8kjxC9oE6ZSByFfzoq9gDJdKZfolVF3RvMndZFYAgMhKoitFIejuJCYGFWLCTdxwAJjTffBV65kVPxSgBhvM0SMgvCDqVHo6n71NqNvjOiQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813431; c=relaxed/simple;
	bh=NZ3Qj0P/JmSkdjneYYfwWdzG1XP1ccqyAKp67DKOm9o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EDK1ZvdvxJzKIgxlCrIljlaLCKy5BWS9maNes3Asxvz5KGzK5e56LgprPQ70RWDym/VMRjCv2vn06dRr+r87GDuKhNURdPpg5JpVXpjdseNySxiYRcfuCSp8fnG5Ati0A9v7kqdvLZswbtC+tWH2NUheRkTUJUwzeCUndjwuzwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rB2bwMk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DBAC4CEFD;
	Tue, 29 Jul 2025 18:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753813431;
	bh=NZ3Qj0P/JmSkdjneYYfwWdzG1XP1ccqyAKp67DKOm9o=;
	h=Date:From:To:Cc:Subject:References:From;
	b=rB2bwMk503JQpZLqFwjTM8fH8PZx4bhDE8zvlioQ5bIR8YfYxoYbM1pMUPMz7FjNZ
	 jAlGY6Us/QxzLfE0g5anh83tNUvotsPuHyZqp5FhJ7SPi/pNOk5QvpkMwJPG5zb8cj
	 FX4k8a7NHPwFU9RWhLnTKomHrQoNhvakZ6SEAmEWm9uhrWImtpfE4AMiDkcHJzBN8R
	 6sauifCRQegDcEo+A6yFVaGzFiNOlHQ55QHwT5QxegJK2/bAYY87vjfUULyQBRj661
	 OVTPf1+X+MRy25snOoLsWHkWDvN7EkAaym+vylpaLETFrPPCKJWoamBA9YcYUVkIyL
	 JasLWpQzOP1dg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ugoze-0000000551x-1HBh;
	Tue, 29 Jul 2025 14:24:06 -0400
Message-ID: <20250729182406.155422551@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 29 Jul 2025 14:23:12 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
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
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>
Subject: [PATCH v16 08/10] unwind: Add USED bit to only have one conditional on way back to user
 space
References: <20250729182304.965835871@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

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
 include/linux/unwind_deferred.h | 18 +++++++++---------
 kernel/unwind/deferred.c        |  5 ++++-
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index b9ec4c8515c7..2efbda01e959 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -20,10 +20,14 @@ struct unwind_work {
 
 enum {
 	UNWIND_PENDING_BIT = 0,
+	UNWIND_USED_BIT,
 };
 
 enum {
 	UNWIND_PENDING		= BIT(UNWIND_PENDING_BIT),
+
+	/* Set if the unwinding was used (directly or deferred) */
+	UNWIND_USED		= BIT(UNWIND_USED_BIT)
 };
 
 void unwind_task_init(struct task_struct *task);
@@ -49,15 +53,11 @@ static __always_inline void unwind_reset_info(void)
 				return;
 		} while (!try_cmpxchg(&info->unwind_mask, &bits, 0UL));
 		current->unwind_info.id.id = 0;
-	}
-	/*
-	 * As unwind_user_faultable() can be called directly and
-	 * depends on nr_entries being cleared on exit to user,
-	 * this needs to be a separate conditional.
-	 */
-	if (unlikely(info->cache)) {
-		info->cache->nr_entries = 0;
-		info->cache->unwind_completed = 0;
+
+		if (unlikely(info->cache)) {
+			info->cache->nr_entries = 0;
+			info->cache->unwind_completed = 0;
+		}
 	}
 }
 
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index a3d26014a2e6..2311b725d691 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -45,7 +45,7 @@ static inline bool try_assign_cnt(struct unwind_task_info *info, u32 cnt)
 static DEFINE_MUTEX(callback_mutex);
 static LIST_HEAD(callbacks);
 
-#define RESERVED_BITS	(UNWIND_PENDING)
+#define RESERVED_BITS	(UNWIND_PENDING | UNWIND_USED)
 
 /* Zero'd bits are available for assigning callback users */
 static unsigned long unwind_mask = RESERVED_BITS;
@@ -140,6 +140,9 @@ int unwind_user_faultable(struct unwind_stacktrace *trace)
 
 	cache->nr_entries = trace->nr;
 
+	/* Clear nr_entries on way back to user space */
+	set_bit(UNWIND_USED_BIT, &info->unwind_mask);
+
 	return 0;
 }
 
-- 
2.47.2



