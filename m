Return-Path: <bpf+bounces-74456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E2AC5BAA7
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 08:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED02F4F24D6
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 07:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1843A2E8B85;
	Fri, 14 Nov 2025 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnSPqpm4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AB81E1C02;
	Fri, 14 Nov 2025 07:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763103621; cv=none; b=I6mS7Pq+nCjdHYOGKj7/kptWACr7IbVH/4skw7zkhhVYcTgzHHfs3O7+4XIAzblfBK7KX99H2BDW8UE/7wXJb353iwnlerVLMXiVxOC9PwTgKhps/Hiz7mV+v+eSqw5eXG9Kxunec88FdbXYVAzPBPg+i19lCXFt9YM+oDYM7i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763103621; c=relaxed/simple;
	bh=ojTHLSjZBXCP+lYeZxCWYORNJqxatfl7RNTwhIJgLEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lvo7XKQf2sGgxcxOPFOZcnUGjH479pg831FCqFdwfJga5rGVKTNu2rxJeGz+mEhyBEMfZtcM0nHjR+Jba/gO2PWfl53pX+dOdqyaJhVRJpjrQs3173gnWSNzh8x5aRNTJmXkZLl9izGKH0F3mpWekF/tMRj/8h9LASvvXMCdB34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnSPqpm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DBBC2BCAF;
	Fri, 14 Nov 2025 07:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763103621;
	bh=ojTHLSjZBXCP+lYeZxCWYORNJqxatfl7RNTwhIJgLEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RnSPqpm4BG3OYy1ehexNiclK+1uprAddFXpTnJF/0SKsAH6mUEsXpLGwKZCYtCxan
	 ND7bjt0cKwq/flFyRfTa0uzwy5md2BDfL5STGkGyR1D5aE2FdxnO01tb5LO7sNEXKg
	 tEw+ZH5z8ALgaiu5QKTRkGdQis5EPqvjiY10RSzQRIMnrAP9lGbt7mGGpOIVmK4c7b
	 Lf03F72cGmb8vwJGpwM7LPsaFWHHxNuCYSpog9jFtQn86RyW79/WOcMd8/8AVtnLpt
	 fLapYdf7D5irjqEmKTLmbfrmE9cTlznLImhnDfBOMl1ukAxPlmXz864r/EeXR575OG
	 RRXuHt3IQKC6A==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 1/5] tools headers UAPI: Sync linux/perf_event.h for deferred callchains
Date: Thu, 13 Nov 2025 23:00:14 -0800
Message-ID: <20251114070018.160330-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114070018.160330-1-namhyung@kernel.org>
References: <20251114070018.160330-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It needs to sync with the kernel to support user space changes for the
deferred callchains.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/linux/perf_event.h | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 78a362b8002776e5..d292f96bc06f86bc 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -463,7 +463,9 @@ struct perf_event_attr {
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
-				__reserved_1   : 26;
+				defer_callchain:  1, /* request PERF_RECORD_CALLCHAIN_DEFERRED records */
+				defer_output   :  1, /* output PERF_RECORD_CALLCHAIN_DEFERRED records */
+				__reserved_1   : 24;
 
 	union {
 		__u32		wakeup_events;	  /* wake up every n events */
@@ -1239,6 +1241,22 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_AUX_OUTPUT_HW_ID		= 21,
 
+	/*
+	 * This user callchain capture was deferred until shortly before
+	 * returning to user space.  Previous samples would have kernel
+	 * callchains only and they need to be stitched with this to make full
+	 * callchains.
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				cookie;
+	 *	u64				nr;
+	 *	u64				ips[nr];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_CALLCHAIN_DEFERRED		= 22,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
@@ -1269,6 +1287,7 @@ enum perf_callchain_context {
 	PERF_CONTEXT_HV				= (__u64)-32,
 	PERF_CONTEXT_KERNEL			= (__u64)-128,
 	PERF_CONTEXT_USER			= (__u64)-512,
+	PERF_CONTEXT_USER_DEFERRED		= (__u64)-640,
 
 	PERF_CONTEXT_GUEST			= (__u64)-2048,
 	PERF_CONTEXT_GUEST_KERNEL		= (__u64)-2176,
-- 
2.52.0.rc1.455.g30608eb744-goog


