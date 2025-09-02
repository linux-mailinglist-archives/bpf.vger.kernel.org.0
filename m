Return-Path: <bpf+bounces-67185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B2BB40719
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 16:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B3D206F94
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 14:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D917F30E835;
	Tue,  2 Sep 2025 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVFW6xgK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAA12F361D;
	Tue,  2 Sep 2025 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823748; cv=none; b=EId35X7pmhOciRIzZhLrhLZoK7A9ThflzgqYhZ68senx5UmD2yaSQhb06IImGSbKanQVBpR9ECco/AZa41vJhPKJWxl4A6wlbuOM9RaX4ramtnoICrTV2vnWGO0KZPa4Qf4SzoInDwaRpHEMt4U3QsZ43zFoHNddTKyUNvsq08w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823748; c=relaxed/simple;
	bh=FR+1AdMvmpUyMMVlgESextRgMfPsqzjwtFh0yzY02k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KkVicEMW5Er5fPgWKb0C8roLRsfOPoyfum2qLJGP7vHe4J8cYSoRXg27B45zPXYBAi+DzdqtZ1Eql/utJ8kljeq0XbBEVCPE9CTGsbePogVQFkMW1THITC9pvPx3/D1abcGtwXEo/Uap+t3BP7DXiGQH5Zgyuki65nbOEn+yoYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVFW6xgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607BFC4CEED;
	Tue,  2 Sep 2025 14:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756823747;
	bh=FR+1AdMvmpUyMMVlgESextRgMfPsqzjwtFh0yzY02k4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lVFW6xgK2tjpZ7ID8C0wJj5vuo2tQlWFlV9+aIT+UO2qjO3nLOji6L02le5T1gH2b
	 KNL0S2lueH//gEkeu13OuAw+NYxGFFSBlPkAnogXV/JcGIraRYFBWWZIyb2oEPysQI
	 maeiVk2J+pjlinGrPxwboN2mEqAkucmSQm5u1BOylER5nQS1dTB0rNNLSDQvvmKZ5m
	 CLmoWoaeIiewkD/cxTDGcPIGxomePvjUdB4XYyvc4urXcVUzWRSrt0Kiifqqr9BlNt
	 idtlq3NKZFRxYdhLxRs9WTWtx4Met/yWtJIvcriRnw1DBPzdcXdqRCg8XFTYjE5tz5
	 bTrlq8xFOrnzA==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH perf/core 03/11] perf: Add support to attach standard unique uprobe
Date: Tue,  2 Sep 2025 16:34:56 +0200
Message-ID: <20250902143504.1224726-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902143504.1224726-1-jolsa@kernel.org>
References: <20250902143504.1224726-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to attach unique probe through perf uprobe pmu.

Adding new 'unique' format attribute that allows to pass the
request to create unique uprobe the uprobe consumer.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/trace_events.h    | 2 +-
 kernel/events/core.c            | 8 ++++++--
 kernel/trace/trace_event_perf.c | 4 ++--
 kernel/trace/trace_probe.h      | 2 +-
 kernel/trace/trace_uprobe.c     | 9 +++++----
 5 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 04307a19cde3..1d35727fda27 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -877,7 +877,7 @@ extern int bpf_get_kprobe_info(const struct perf_event *event,
 #endif
 #ifdef CONFIG_UPROBE_EVENTS
 extern int  perf_uprobe_init(struct perf_event *event,
-			     unsigned long ref_ctr_offset, bool is_retprobe);
+			     unsigned long ref_ctr_offset, bool is_retprobe, bool is_unique);
 extern void perf_uprobe_destroy(struct perf_event *event);
 extern int bpf_get_uprobe_info(const struct perf_event *event,
 			       u32 *fd_type, const char **filename,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 28de3baff792..10a9341c638f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11046,11 +11046,13 @@ EXPORT_SYMBOL_GPL(perf_tp_event);
  */
 enum perf_probe_config {
 	PERF_PROBE_CONFIG_IS_RETPROBE = 1U << 0,  /* [k,u]retprobe */
+	PERF_PROBE_CONFIG_IS_UNIQUE   = 1U << 1,  /* unique uprobe */
 	PERF_UPROBE_REF_CTR_OFFSET_BITS = 32,
 	PERF_UPROBE_REF_CTR_OFFSET_SHIFT = 64 - PERF_UPROBE_REF_CTR_OFFSET_BITS,
 };
 
 PMU_FORMAT_ATTR(retprobe, "config:0");
+PMU_FORMAT_ATTR(unique, "config:1");
 #endif
 
 #ifdef CONFIG_KPROBE_EVENTS
@@ -11114,6 +11116,7 @@ PMU_FORMAT_ATTR(ref_ctr_offset, "config:32-63");
 
 static struct attribute *uprobe_attrs[] = {
 	&format_attr_retprobe.attr,
+	&format_attr_unique.attr,
 	&format_attr_ref_ctr_offset.attr,
 	NULL,
 };
@@ -11144,7 +11147,7 @@ static int perf_uprobe_event_init(struct perf_event *event)
 {
 	int err;
 	unsigned long ref_ctr_offset;
-	bool is_retprobe;
+	bool is_retprobe, is_unique;
 
 	if (event->attr.type != perf_uprobe.type)
 		return -ENOENT;
@@ -11159,8 +11162,9 @@ static int perf_uprobe_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 
 	is_retprobe = event->attr.config & PERF_PROBE_CONFIG_IS_RETPROBE;
+	is_unique = event->attr.config & PERF_PROBE_CONFIG_IS_UNIQUE;
 	ref_ctr_offset = event->attr.config >> PERF_UPROBE_REF_CTR_OFFSET_SHIFT;
-	err = perf_uprobe_init(event, ref_ctr_offset, is_retprobe);
+	err = perf_uprobe_init(event, ref_ctr_offset, is_retprobe, is_unique);
 	if (err)
 		return err;
 
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index a6bb7577e8c5..b4383ab21d88 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -296,7 +296,7 @@ void perf_kprobe_destroy(struct perf_event *p_event)
 
 #ifdef CONFIG_UPROBE_EVENTS
 int perf_uprobe_init(struct perf_event *p_event,
-		     unsigned long ref_ctr_offset, bool is_retprobe)
+		     unsigned long ref_ctr_offset, bool is_retprobe, bool is_unique)
 {
 	int ret;
 	char *path = NULL;
@@ -317,7 +317,7 @@ int perf_uprobe_init(struct perf_event *p_event,
 	}
 
 	tp_event = create_local_trace_uprobe(path, p_event->attr.probe_offset,
-					     ref_ctr_offset, is_retprobe);
+					     ref_ctr_offset, is_retprobe, is_unique);
 	if (IS_ERR(tp_event)) {
 		ret = PTR_ERR(tp_event);
 		goto out;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 842383fbc03b..92870b98b296 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -469,7 +469,7 @@ extern void destroy_local_trace_kprobe(struct trace_event_call *event_call);
 
 extern struct trace_event_call *
 create_local_trace_uprobe(char *name, unsigned long offs,
-			  unsigned long ref_ctr_offset, bool is_return);
+			  unsigned long ref_ctr_offset, bool is_return, bool is_unique);
 extern void destroy_local_trace_uprobe(struct trace_event_call *event_call);
 #endif
 extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 8b0bcc0d8f41..4ecb6083f949 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -333,7 +333,7 @@ trace_uprobe_primary_from_call(struct trace_event_call *call)
  * Allocate new trace_uprobe and initialize it (including uprobes).
  */
 static struct trace_uprobe *
-alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
+alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret, bool is_unique)
 {
 	struct trace_uprobe *tu;
 	int ret;
@@ -356,6 +356,7 @@ alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
 	tu->consumer.handler = uprobe_dispatcher;
 	if (is_ret)
 		tu->consumer.ret_handler = uretprobe_dispatcher;
+	tu->consumer.is_unique = is_unique;
 	init_trace_uprobe_filter(tu->tp.event->filter);
 	return tu;
 
@@ -688,7 +689,7 @@ static int __trace_uprobe_create(int argc, const char **argv)
 	argc -= 2;
 	argv += 2;
 
-	tu = alloc_trace_uprobe(group, event, argc, is_return);
+	tu = alloc_trace_uprobe(group, event, argc, is_return, false /* unique */);
 	if (IS_ERR(tu)) {
 		ret = PTR_ERR(tu);
 		/* This must return -ENOMEM otherwise there is a bug */
@@ -1636,7 +1637,7 @@ static int unregister_uprobe_event(struct trace_uprobe *tu)
 #ifdef CONFIG_PERF_EVENTS
 struct trace_event_call *
 create_local_trace_uprobe(char *name, unsigned long offs,
-			  unsigned long ref_ctr_offset, bool is_return)
+			  unsigned long ref_ctr_offset, bool is_return, bool is_unique)
 {
 	enum probe_print_type ptype;
 	struct trace_uprobe *tu;
@@ -1658,7 +1659,7 @@ create_local_trace_uprobe(char *name, unsigned long offs,
 	 * duplicated name "DUMMY_EVENT" here.
 	 */
 	tu = alloc_trace_uprobe(UPROBE_EVENT_SYSTEM, "DUMMY_EVENT", 0,
-				is_return);
+				is_return, is_unique);
 
 	if (IS_ERR(tu)) {
 		pr_info("Failed to allocate trace_uprobe.(%d)\n",
-- 
2.51.0


