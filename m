Return-Path: <bpf+bounces-1270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7212711EBE
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 06:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6295D281001
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 04:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B892116;
	Fri, 26 May 2023 04:18:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4CF1C26
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 04:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD55EC433EF;
	Fri, 26 May 2023 04:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685074692;
	bh=iB6U30XiVWAQS2p/KZ8B8h9IpEUiIb2rQrKOiT2f/z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o2wAT523ZgtvcL1RB07VAZfXZMzhmHMnf6rQJEm6GQ+dZqCqqqtP6ehqsnzLT7i7t
	 fh46HthVaDMIfAP0+Zchp2m8u6kpa+PV/89OZB4qOL16Pkkvr/fh78FHRqpDLBGZj9
	 H2S+6QlEQ5uYTRp79+baLf2jdyCI98s8t0v6aYVuTs0WHqqD6X8RPbYt7a/usPxRFk
	 iRhWOVbo7fgBCV3L2l0hl7FLeDBsjG8gbfn9dEFZRCTuvh9FkYK6LqVouyWSK0p8uc
	 08zMhG2dBbsIrVnahIBddDziIjKQTDeU3RQvEwoH8xVI75CIUKKw1UucwXuBRItYVO
	 zjEzT9gUek8TA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Florent Revest <revest@chromium.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v13 02/12] tracing/probes: Avoid setting TPARG_FL_FENTRY and TPARG_FL_RETURN
Date: Fri, 26 May 2023 12:18:07 +0800
Message-ID:  <168507468731.913472.11354553441385410734.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To:  <168507466597.913472.10572827237387849017.stgit@mhiramat.roam.corp.google.com>
References:  <168507466597.913472.10572827237387849017.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

When parsing a kprobe event, the return probe always sets both
TPARG_FL_RETURN and TPARG_FL_FENTRY, but this is not useful because
some fetchargs are only for return probe and some others only for
function entry. Make it obviously mutual exclusive.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |    2 +-
 kernel/trace/trace_probe.h  |    5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 59cda19a9033..867ffb7ee31d 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -825,7 +825,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		if (is_return)
 			flags |= TPARG_FL_RETURN;
 		ret = kprobe_on_func_entry(NULL, symbol, offset);
-		if (ret == 0)
+		if (ret == 0 && !is_return)
 			flags |= TPARG_FL_FENTRY;
 		/* Defer the ENOENT case until register kprobe */
 		if (ret == -EINVAL && is_return) {
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index ef8ed3b65d05..752a08fcf0be 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -357,6 +357,11 @@ int trace_probe_print_args(struct trace_seq *s, struct probe_arg *args, int nr_a
 #define trace_probe_for_each_link_rcu(pos, tp)	\
 	list_for_each_entry_rcu(pos, &(tp)->event->files, list)
 
+/*
+ * The flags used for parsing trace_probe arguments.
+ * TPARG_FL_RETURN, TPARG_FL_FENTRY and TPARG_FL_TPOINT are mutually exclusive.
+ * TPARG_FL_KERNEL and TPARG_FL_USER are also mutually exclusive.
+ */
 #define TPARG_FL_RETURN BIT(0)
 #define TPARG_FL_KERNEL BIT(1)
 #define TPARG_FL_FENTRY BIT(2)


