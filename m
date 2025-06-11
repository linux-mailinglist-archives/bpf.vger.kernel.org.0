Return-Path: <bpf+bounces-60277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB30DAD47B3
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 03:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241FE17E64C
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 01:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268B51C84B3;
	Wed, 11 Jun 2025 01:03:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B131A198A1A;
	Wed, 11 Jun 2025 01:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749603791; cv=none; b=cpXz1DMqUWv31LD6HlJT3K6iMhQaEsFFPK6/FBB6ODPrhTprR0C+k7ASQU7Fnl+s8PXzd5DuLuraY8hKX1ldXrEZNZNd3cCyQJ7imkc7KX3DU1IP0f9TgQM8+wY2RaqGK4MXHTCIJF1D4AUFukQm6LWsUPD9WlZwqUaAoJrPBM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749603791; c=relaxed/simple;
	bh=a8SrMgu7Q5frriAvZ6hSGoY+qGRM5omerc//373nOfA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Tfy+UlVZckjEBETl5YV9s/sygelgVfo0hEfDT+0NTGODRKHLMjkQheXoRhMc2PXqV+V8ruEqnSw8MQ1P/IeHCAcTkSt0olmPYYEg++H1coedHRbWGMRLaeRScErK766AlG6WDzcBhI3ODhsjdgYzmtuObIlA/s50hw/Hip0TLOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 20213161482;
	Wed, 11 Jun 2025 01:03:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 15EB72002D;
	Wed, 11 Jun 2025 01:02:57 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uP9tF-00000000vAh-0Lh4;
	Tue, 10 Jun 2025 21:04:29 -0400
Message-ID: <20250611010428.938845449@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 10 Jun 2025 20:54:28 -0400
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
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v10 07/14] unwind_user/deferred: Make unwind deferral requests NMI-safe
References: <20250611005421.144238328@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 15EB72002D
X-Stat-Signature: x64qi1ah5jdgg6cu1taank451ukmsfbi
X-Rspamd-Server: rspamout06
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Ksv4W/toZnjUpeP07wqZ5Kg5uVupVKIg=
X-HE-Tag: 1749603777-939147
X-HE-Meta: U2FsdGVkX19LgvhndpAJr1L2blB5Bjl6YfCv7q5NzsCokKSwj56wkqxx1DLCvupfcDt0Bp7IWIUoL5Z8f+9qrwwzrluTg91tVJFD/fgbpjsEtAF7cqr7BCnqd732ttl4/IzkiI1HDfX9fyI9hQj0LWfLI/LAnIjSDU7c6qB/LBGlWMD52JHqUXTwmqm2DnQU78makwOyauT0ZSnFrgQ31bauxG9DGAWt6O3XCMGdLIDe163XmHxCZ36eS/MEFOgnqygGSuqD3+i2uf3TlmJYHWUKv5sU59bWDi7lS/DSgOaVpB2rjOyS71BlbAPhvDOixe07TNGuMmvEFWTpl53tM/aYsifFqw3Tsak6YTxnDXpn7fnxBCOynO+7CvwBpIgNBcbhMtQ6zdsbZ2segf6VS232XGcuhYJQCS5TwKLF3OI=

From: Josh Poimboeuf <jpoimboe@kernel.org>

Make unwind_deferred_request() NMI-safe so tracers in NMI context can
call it and safely request a user space stacktrace when the task exits.

A "nmi_timestamp" is added to the unwind_task_info that gets updated by
NMIs to not race with setting the info->timestamp.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v9: https://lore.kernel.org/linux-trace-kernel/20250513223552.636076711@goodmis.org/

- Check for ret < 0 instead of just ret != 0 from return code of
  task_work_add(). Don't want to just assume it's less than zero as it
  needs to return a negative on error.

 include/linux/unwind_deferred_types.h |  1 +
 kernel/unwind/deferred.c              | 91 ++++++++++++++++++++++++---
 2 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index 5df264cf81ad..ae27a02234b8 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -11,6 +11,7 @@ struct unwind_task_info {
 	struct unwind_cache	*cache;
 	struct callback_head	work;
 	u64			timestamp;
+	u64			nmi_timestamp;
 	int			pending;
 };
 
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index b76c704ddc6d..88c867c32c01 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -25,8 +25,27 @@ static u64 get_timestamp(struct unwind_task_info *info)
 {
 	lockdep_assert_irqs_disabled();
 
-	if (!info->timestamp)
-		info->timestamp = local_clock();
+	/*
+	 * Note, the timestamp is generated on the first request.
+	 * If it exists here, then the timestamp is earlier than
+	 * this request and it means that this request will be
+	 * valid for the stracktrace.
+	 */
+	if (!info->timestamp) {
+		WRITE_ONCE(info->timestamp, local_clock());
+		barrier();
+		/*
+		 * If an NMI came in and set a timestamp, it means that
+		 * it happened before this timestamp was set (otherwise
+		 * the NMI would have used this one). Use the NMI timestamp
+		 * instead.
+		 */
+		if (unlikely(info->nmi_timestamp)) {
+			WRITE_ONCE(info->timestamp, info->nmi_timestamp);
+			barrier();
+			WRITE_ONCE(info->nmi_timestamp, 0);
+		}
+	}
 
 	return info->timestamp;
 }
@@ -103,6 +122,13 @@ static void unwind_deferred_task_work(struct callback_head *head)
 
 	unwind_deferred_trace(&trace);
 
+	/* Check if the timestamp was only set by NMI */
+	if (info->nmi_timestamp) {
+		WRITE_ONCE(info->timestamp, info->nmi_timestamp);
+		barrier();
+		WRITE_ONCE(info->nmi_timestamp, 0);
+	}
+
 	timestamp = info->timestamp;
 
 	guard(mutex)(&callback_mutex);
@@ -111,6 +137,48 @@ static void unwind_deferred_task_work(struct callback_head *head)
 	}
 }
 
+static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *timestamp)
+{
+	struct unwind_task_info *info = &current->unwind_info;
+	bool inited_timestamp = false;
+	int ret;
+
+	/* Always use the nmi_timestamp first */
+	*timestamp = info->nmi_timestamp ? : info->timestamp;
+
+	if (!*timestamp) {
+		/*
+		 * This is the first unwind request since the most recent entry
+		 * from user space. Initialize the task timestamp.
+		 *
+		 * Don't write to info->timestamp directly, otherwise it may race
+		 * with an interruption of get_timestamp().
+		 */
+		info->nmi_timestamp = local_clock();
+		*timestamp = info->nmi_timestamp;
+		inited_timestamp = true;
+	}
+
+	if (info->pending)
+		return 1;
+
+	ret = task_work_add(current, &info->work, TWA_NMI_CURRENT);
+	if (ret < 0) {
+		/*
+		 * If this set nmi_timestamp and is not using it,
+		 * there's no guarantee that it will be used.
+		 * Set it back to zero.
+		 */
+		if (inited_timestamp)
+			info->nmi_timestamp = 0;
+		return ret;
+	}
+
+	info->pending = 1;
+
+	return 0;
+}
+
 /**
  * unwind_deferred_request - Request a user stacktrace on task exit
  * @work: Unwind descriptor requesting the trace
@@ -139,31 +207,38 @@ static void unwind_deferred_task_work(struct callback_head *head)
 int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
 {
 	struct unwind_task_info *info = &current->unwind_info;
+	int pending;
 	int ret;
 
 	*timestamp = 0;
 
-	if (WARN_ON_ONCE(in_nmi()))
-		return -EINVAL;
-
 	if ((current->flags & (PF_KTHREAD | PF_EXITING)) ||
 	    !user_mode(task_pt_regs(current)))
 		return -EINVAL;
 
+	if (in_nmi())
+		return unwind_deferred_request_nmi(work, timestamp);
+
 	guard(irqsave)();
 
 	*timestamp = get_timestamp(info);
 
 	/* callback already pending? */
-	if (info->pending)
+	pending = READ_ONCE(info->pending);
+	if (pending)
+		return 1;
+
+	/* Claim the work unless an NMI just now swooped in to do so. */
+	if (!try_cmpxchg(&info->pending, &pending, 1))
 		return 1;
 
 	/* The work has been claimed, now schedule it. */
 	ret = task_work_add(current, &info->work, TWA_RESUME);
-	if (WARN_ON_ONCE(ret))
+	if (WARN_ON_ONCE(ret)) {
+		WRITE_ONCE(info->pending, 0);
 		return ret;
+	}
 
-	info->pending = 1;
 	return 0;
 }
 
-- 
2.47.2



