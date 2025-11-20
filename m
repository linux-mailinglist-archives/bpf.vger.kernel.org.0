Return-Path: <bpf+bounces-75127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1A5C71C99
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 03:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8721B3516D5
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 02:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907311534EC;
	Thu, 20 Nov 2025 02:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clLoad+U"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06E029CB57;
	Thu, 20 Nov 2025 02:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763604651; cv=none; b=IhUL+A46hUeRW9ynx6ehmMNQmowsjbS2fpOyg5/f527voH4wR5cixp0OqErW9WEcSKcOeWtIyUX6sz3f3ys1MO8wG93r+BTPrvXX+1LCYPDCRmhDYnqodSJTlvlvdkExoOltnhQpGHRQhIas4yymmGiQ/CJcU1UHhAqmL1K7ajk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763604651; c=relaxed/simple;
	bh=kmY+wqdPNEqjRCGwsEFVcX7BYsUFzFg4Uc4vo26TUxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNzvplCoLyksnYJjO9cxcgRrbXPgnDUmsgLPivIlDS9CmrnMEd8CNlyppTrA2wIjbFOdo8VDJzI4sLNAIxN8kIWlF7uRUXFIuXUXajarcUoVqgxGdsEeS1pAftpMlg1dFHHa98PNEc2D6um7pO58OJJXciQhK+PEQ4vy1VZTjak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clLoad+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32255C4CEF5;
	Thu, 20 Nov 2025 02:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763604651;
	bh=kmY+wqdPNEqjRCGwsEFVcX7BYsUFzFg4Uc4vo26TUxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=clLoad+UYjP68KTjnQzxLxOIQLloeKJYpUHhnYQUaDjZboq4LmGZMiCxRrIjsIHGi
	 cSQFt3CuEcdmSx2Vz/JMVe4FhtU0fs6v6LsehH7kEgffAwbolRjSSTiswnZjJg5+Fx
	 s53nP3Iwh4Rgp4MnKotJVbDpCe37ZssYpGak/31Zzwd/Ofj5iESQfj458ahivu0F8W
	 HVH8dQxbE6nXb7zOUxe2v8vYsxvyNlnGReSYN+V7D9WsTz5KbOzy9S4NFFnaVGFC9A
	 C0TLH54ercfrkSRz7V65gjQN0L/pEU2eB18wEmXrbgSHpzRdSa0gl/HOWHpRr3ExQG
	 CYKQcgivtWBkw==
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
Subject: [PATCH v5 1/6] tools headers UAPI: Sync linux/perf_event.h for deferred callchains
Date: Wed, 19 Nov 2025 18:10:41 -0800
Message-ID: <20251120021046.94490-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251120021046.94490-1-namhyung@kernel.org>
References: <20251120021046.94490-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It needs to sync with the kernel to support user space changes for the
deferred callchains.

Reviewed-by: Ian Rogers <irogers@google.com>
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


