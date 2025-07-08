Return-Path: <bpf+bounces-62596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948C5AFBFE1
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 03:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E08425593
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 01:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280F32236EB;
	Tue,  8 Jul 2025 01:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZhGGW5O"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F62821A931;
	Tue,  8 Jul 2025 01:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937839; cv=none; b=kdIsmjNl8skVF4UUekS4RQMek/Qi6CXLsGowpb7dNUrYDdFRxLKE7KZy8b3h+eoclXSXBDeursZlyZhO6uOVQ3uPoza/x0Zj+D6K4jSRpBj7+4rJp6jHAzjtnVcJYaPTXBG5y0h2j7cXu5ouKWv6KCtkBMEpMR4aficKJtf5p6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937839; c=relaxed/simple;
	bh=61tDSqBMXQ/82GJZZ8kZgqsfXb9llhFb2V03jv03Tb4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pVWCtaCic1IFP66sfL8dK4DS1yKiESZROHoRHPDweCohAkjL1OSogEVaDB8E39uLYkoWvk9TWUOnnh60SZ7z7LCEG8Ic7ngPm5+eTBu8cMF2YUU7VVD5sBaFU12yRWVoQ1lXwRKnb2w4aMChDfV4UuLi1bb8RX0g9X7bDKQGxwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZhGGW5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E7FC4CEF6;
	Tue,  8 Jul 2025 01:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751937839;
	bh=61tDSqBMXQ/82GJZZ8kZgqsfXb9llhFb2V03jv03Tb4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=SZhGGW5OTDO7VXypqKj4gzAzA/65ZWOsgQfHurefkqSouy9rZ7baRpIDR3QP4kcfA
	 YahgsCqHJhyxRhuX7Rd1UjjwYUruz+6J8+E/olYANesJKgSptypqXUH7N76oLe0Ll4
	 0ejXwNA/Wc+IUFEmMv2P7L5lC2TRJ1gwlskoAa+36GdmX1Aa0mxRmJmfqGGhINdjs+
	 VEjtoww7k5nkN4sb6e5fi80w3wjEgcwP0qp1t6uDP4grPXvgZXuPTst7jrJDYmEwte
	 QY0J9lNhG1z0r8Ne0p4UWFdR0CLGcfsLj43FsgiQya3HK5wZva4DWCCTCIBJUzBTvt
	 JoW4m6eDU8Q6Q==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uYx3v-00000000BuS-2n6L;
	Mon, 07 Jul 2025 21:23:59 -0400
Message-ID: <20250708012359.516909531@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 07 Jul 2025 21:22:50 -0400
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
Subject: [PATCH v13 11/14] unwind: Add USED bit to only have one conditional on way back to user
 space
References: <20250708012239.268642741@kernel.org>
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
 include/linux/unwind_deferred.h | 14 +++++++-------
 kernel/unwind/deferred.c        |  5 ++++-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 587e120c0fd6..376bfd50ff75 100644
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
 		current->unwind_info.id.id = 0;
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
index 256458f3eafe..9299974b6562 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -140,6 +140,9 @@ int unwind_user_faultable(struct unwind_stacktrace *trace)
 
 	cache->nr_entries = trace->nr;
 
+	/* Clear nr_entries on way back to user space */
+	set_bit(UNWIND_USED_BIT, &info->unwind_mask);
+
 	return 0;
 }
 
@@ -314,7 +317,7 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
 	guard(mutex)(&callback_mutex);
 
 	/* See if there's a bit in the mask available */
-	if (unwind_mask == ~(UNWIND_PENDING))
+	if (unwind_mask == ~(UNWIND_PENDING|UNWIND_USED))
 		return -EBUSY;
 
 	work->bit = ffz(unwind_mask);
-- 
2.47.2



