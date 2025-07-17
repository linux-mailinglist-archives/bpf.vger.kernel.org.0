Return-Path: <bpf+bounces-63509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E970B081D9
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 02:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B244B5677CB
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 00:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782CB1DE4E1;
	Thu, 17 Jul 2025 00:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCGvKdz2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BA31A5BA2;
	Thu, 17 Jul 2025 00:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752713377; cv=none; b=tCBmy6u6H5NcaEx7grIXjGnWB84cv5V0QucINfXRz29939479II/LI/SEZ6797vON9nHSjiVlptrJspn76wTsOU+pYIhAgEV24wfR+4GW4tyK0DNs28QE7rDCDdRTqDy3HUc4+dnRz6jxVXFTxz3aeMRMuGSTswyT0fGdo6CLpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752713377; c=relaxed/simple;
	bh=AMDSLb4ahKvd6dfTUDgBCwcBGnWI7GZ2S1ddJhoD1h8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=hi/5ZN3TH8XNQ/KuJghnglgjUhaIyN1KIOhZ6D3GQcQod7/v9qoT2HmIE5xJcz2WaOBjnu6VwTqt2BPRLjD5vumuiEBMJsnk4O8jZqb5ZyuZrXqrNRGFSfowNVkMPcccVh/5riQHNwbLGBPYRLHDpdoRaAhvcDSKUtyPzTEzZNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCGvKdz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906A2C4CEF7;
	Thu, 17 Jul 2025 00:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752713377;
	bh=AMDSLb4ahKvd6dfTUDgBCwcBGnWI7GZ2S1ddJhoD1h8=;
	h=Date:From:To:Cc:Subject:References:From;
	b=QCGvKdz2t/zPsMrTZrF9q34VN36KQdntDJcf/ZWnQWtf/jKL1F02JTabaG6PLB7Sx
	 +gmtiaclbCiqwzDiMZ9V3V5X/CNHYz8zdDlMvDlR2fiRqPBMBZODC+11soVKDGsIik
	 CSrvTEy7qVCyegAs7CaABGlHS5m88w7LDyv0egozu6bqYcmqZA5nj+D7EEn8a0Rs5I
	 YVN/Blg9mz16iwyUPXybeMMu/kuhrFjy8bPTSka8oJFFohp/N1F2KdqXP1otl8I/gu
	 9hAp+eN5QAw0xR0TKe1BGaeumuf83fS2pYNWXjC31gPff8348TPvvkEvcqFZnpMr4X
	 v4TvnBRZqnemQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucCov-000000067VQ-3lUt;
	Wed, 16 Jul 2025 20:49:57 -0400
Message-ID: <20250717004957.746984219@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 16 Jul 2025 20:49:18 -0400
From: Steven Rostedt <rostedt@kernel.org>
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
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>
Subject: [PATCH v14 08/12] unwind: Add USED bit to only have one conditional on way back to user
 space
References: <20250717004910.297898999@kernel.org>
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
Changes since v13: https://lore.kernel.org/20250708012359.516909531@kernel.org

- The UNWIND_USED is now an enum and not a define

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



