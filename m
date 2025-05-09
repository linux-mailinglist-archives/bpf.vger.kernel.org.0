Return-Path: <bpf+bounces-57881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8DEAB1AF3
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 18:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05263A249D9
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 16:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5359C23D29F;
	Fri,  9 May 2025 16:51:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EA023BD0B;
	Fri,  9 May 2025 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746809499; cv=none; b=PbkeRLP9fwQe1H/Uq9XTkAmgJTNlea10t/MHkB2vyLqaioUqxBTltclcv0Lu0B49AZt/ruLVtsoNrwrzeyZ+bNF8CrW3cQpPgjTsgQPy8ASYv+7Sp9qven5ULtTaO+L1NiuPhdGM7fWi3MSnNlbtvjaexlb8zLNkyMPvgh5nmh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746809499; c=relaxed/simple;
	bh=o+zpPJwuZrytbEsaS1hNJK0I6210t782rt6sY9BeE+M=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=FRj5OFMHSpklQhPTFTd2CTssF2KV6UYSpyNOsEyIlmo86XgGRTS0suhlTMCha+i50eWYr/QhyibxUvCWWWh6G4aPA4skAm6+yy0E+Uut6xV1oLZrzLkufFhaAbTWPTugxqg9Rnai+CR7d3LVfvXmQ+JNpUD3A2pIQc0urFpjFOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F031C4CEE9;
	Fri,  9 May 2025 16:51:39 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uDQx1-00000002gIE-1ptS;
	Fri, 09 May 2025 12:51:55 -0400
Message-ID: <20250509165155.292241900@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 09 May 2025 12:45:34 -0400
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
 Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v8 10/18] unwind_user/deferred: Make unwind deferral requests NMI-safe
References: <20250509164524.448387100@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

Make unwind_deferred_request() NMI-safe so tracers in NMI context can
call it and safely request a user space stacktrace when the task exits.

A "nmi_timestamp" is added to the unwind_task_info that gets updated by
NMIs to not race with setting the info->timestamp.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v7: https://lore.kernel.org/20250502165009.069806229@goodmis.org

- Updated to use timestamp instead of cookie

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
index b76c704ddc6d..238cd97079ec 100644
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
+	if (ret) {
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



