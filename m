Return-Path: <bpf+bounces-79084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC50D267F3
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D2E0303313A
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 17:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAE43C1FC8;
	Thu, 15 Jan 2026 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNYwtwFi"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600A5E56A
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497952; cv=none; b=IK/vePM4xI/eBpTtNUodUFNRk0LWpjNixJYdjBVmP4UhqzNaB3XoUk+Pqmk8Y60WmklA+3ZmuuAHIEmWhGB3FkaYoNowU8WepPiN8HcF2CTULV6keuSN04+WrgbYNLqXW9O/3Ew4rRaU2KhQxtrm4p69kudlpZl/v1uC6S+IOWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497952; c=relaxed/simple;
	bh=p+NEomgsJB/QdCWy6uY+hD71CazlnStfzf6iCmkP6cw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9GAMBC7JSuF4OSVQ2sEQGHHXgeKi+5iPFBYHnefII/999h5IXDVlbSsoH6E59AtPgs4qlrn426i9u+SJ959wf8mf5c/N0mFIHDL+OyOH7NBunWEGasZfMnNJ9bXZGw//j2ZEKUVL9BIhu3jRwk/r4alJYwCAuup02xm060L25Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NNYwtwFi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768497948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EFAJ+b7YV88HP2PCJWlcs+TXD7SDHzMTMKvxpmYsN4w=;
	b=NNYwtwFiNvzLNt4TQnUU2VVSP2URysuPL1qDx2PnhoHH3xtY5b9CVkmZx+UQaCmHi5Aw/O
	h+fbkuj/fJymVWPA2G9E8KfhJB4cBwpDnb0FUHdA/U4gQE2CdZxlPprBIcWTFbYTDpHne2
	VCS8jwDq8UXWBFIsUfw74pKOtnU3yLw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-uqSFpn_SPjqk6OT6ADvM4Q-1; Thu,
 15 Jan 2026 12:25:45 -0500
X-MC-Unique: uqSFpn_SPjqk6OT6ADvM4Q-1
X-Mimecast-MFC-AGG-ID: uqSFpn_SPjqk6OT6ADvM4Q_1768497943
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E7A91954B0C;
	Thu, 15 Jan 2026 17:25:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.64.87])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0DB7418004D8;
	Thu, 15 Jan 2026 17:25:38 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Daniel Wagner <dwagner@suse.de>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v3 04/18] rtla: Introduce common_threshold_handler() helper
Date: Thu, 15 Jan 2026 13:31:47 -0300
Message-ID: <20260115163650.118910-5-wander@redhat.com>
In-Reply-To: <20260115163650.118910-1-wander@redhat.com>
References: <20260115163650.118910-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Several functions duplicate the logic for handling threshold actions.
When a threshold is reached, these functions stop the trace, perform
configured actions, and restart the trace if --on-threshold continue
is set.

Create common_threshold_handler() to centralize this shared logic and
avoid code duplication. The function executes the configured threshold
actions and restarts the necessary trace instances when appropriate.

Also add should_continue_tracing() helper to encapsulate the check
for whether tracing should continue after a threshold event, improving
code readability at call sites.

In timerlat_top_bpf_main_loop(), use common_params directly instead
of casting through timerlat_params when only common fields are needed.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/common.c        | 61 ++++++++++++++++++--------
 tools/tracing/rtla/src/common.h        | 18 ++++++++
 tools/tracing/rtla/src/timerlat_hist.c | 19 ++++----
 tools/tracing/rtla/src/timerlat_top.c  | 32 +++++++-------
 4 files changed, 86 insertions(+), 44 deletions(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index ceff76a62a30b..cbc207fa58707 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -175,6 +175,38 @@ common_apply_config(struct osnoise_tool *tool, struct common_params *params)
 }
 
 
+/**
+ * common_threshold_handler - handle latency threshold overflow
+ * @tool: pointer to the osnoise_tool instance containing trace contexts
+ *
+ * Executes the configured threshold actions (e.g., saving trace, printing,
+ * sending signals). If the continue flag is set (--on-threshold continue),
+ * restarts the auxiliary trace instances to continue monitoring.
+ *
+ * Return: 0 for success, -1 for error.
+ */
+int
+common_threshold_handler(const struct osnoise_tool *tool)
+{
+	actions_perform(&tool->params->threshold_actions);
+
+	if (!should_continue_tracing(tool->params))
+		/* continue flag not set, break */
+		return 0;
+
+	/* continue action reached, re-enable tracing */
+	if (tool->record && trace_instance_start(&tool->record->trace))
+		goto err;
+	if (tool->aa && trace_instance_start(&tool->aa->trace))
+		goto err;
+
+	return 0;
+
+err:
+	err_msg("Error restarting trace\n");
+	return -1;
+}
+
 int run_tool(struct tool_ops *ops, int argc, char *argv[])
 {
 	struct common_params *params;
@@ -352,17 +384,14 @@ int top_main_loop(struct osnoise_tool *tool)
 				/* stop tracing requested, do not perform actions */
 				return 0;
 
-			actions_perform(&params->threshold_actions);
+			retval = common_threshold_handler(tool);
+			if (retval)
+				return retval;
+
 
-			if (!params->threshold_actions.continue_flag)
-				/* continue flag not set, break */
+			if (!should_continue_tracing(params))
 				return 0;
 
-			/* continue action reached, re-enable tracing */
-			if (record)
-				trace_instance_start(&record->trace);
-			if (tool->aa)
-				trace_instance_start(&tool->aa->trace);
 			trace_instance_start(trace);
 		}
 
@@ -403,18 +432,14 @@ int hist_main_loop(struct osnoise_tool *tool)
 				/* stop tracing requested, do not perform actions */
 				break;
 
-			actions_perform(&params->threshold_actions);
+			retval = common_threshold_handler(tool);
+			if (retval)
+				return retval;
 
-			if (!params->threshold_actions.continue_flag)
-				/* continue flag not set, break */
-				break;
+			if (!should_continue_tracing(params))
+				return 0;
 
-			/* continue action reached, re-enable tracing */
-			if (tool->record)
-				trace_instance_start(&tool->record->trace);
-			if (tool->aa)
-				trace_instance_start(&tool->aa->trace);
-			trace_instance_start(&tool->trace);
+			trace_instance_start(trace);
 		}
 
 		/* is there still any user-threads ? */
diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index 7602c5593ef5d..c548decd3c40f 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -143,6 +143,24 @@ struct tool_ops {
 	void (*free)(struct osnoise_tool *tool);
 };
 
+/**
+ * should_continue_tracing - check if tracing should continue after threshold
+ * @params: pointer to the common parameters structure
+ *
+ * Returns true if the continue action was configured (--on-threshold continue),
+ * indicating that tracing should be restarted after handling the threshold event.
+ *
+ * Return: 1 if tracing should continue, 0 otherwise.
+ */
+static inline int
+should_continue_tracing(const struct common_params *params)
+{
+	return params->threshold_actions.continue_flag;
+}
+
+int
+common_threshold_handler(const struct osnoise_tool *tool);
+
 int osnoise_set_cpus(struct osnoise_context *context, char *cpus);
 void osnoise_restore_cpus(struct osnoise_context *context);
 
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 6ea397421f1c9..6b8eaef8a3a09 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -17,6 +17,7 @@
 #include "timerlat.h"
 #include "timerlat_aa.h"
 #include "timerlat_bpf.h"
+#include "common.h"
 
 struct timerlat_hist_cpu {
 	int			*irq;
@@ -1048,7 +1049,6 @@ static struct osnoise_tool
 
 static int timerlat_hist_bpf_main_loop(struct osnoise_tool *tool)
 {
-	struct timerlat_params *params = to_timerlat_params(tool->params);
 	int retval;
 
 	while (!stop_tracing) {
@@ -1056,18 +1056,17 @@ static int timerlat_hist_bpf_main_loop(struct osnoise_tool *tool)
 
 		if (!stop_tracing) {
 			/* Threshold overflow, perform actions on threshold */
-			actions_perform(&params->common.threshold_actions);
+			retval = common_threshold_handler(tool);
+			if (retval)
+				return retval;
 
-			if (!params->common.threshold_actions.continue_flag)
-				/* continue flag not set, break */
+			if (!should_continue_tracing(tool->params))
 				break;
 
-			/* continue action reached, re-enable tracing */
-			if (tool->record)
-				trace_instance_start(&tool->record->trace);
-			if (tool->aa)
-				trace_instance_start(&tool->aa->trace);
-			timerlat_bpf_restart_tracing();
+			if (timerlat_bpf_restart_tracing()) {
+				err_msg("Error restarting BPF trace\n");
+				return -1;
+			}
 		}
 	}
 	timerlat_bpf_detach();
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index dd727cb48b551..c6f6757c3fb6b 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -17,6 +17,7 @@
 #include "timerlat.h"
 #include "timerlat_aa.h"
 #include "timerlat_bpf.h"
+#include "common.h"
 
 struct timerlat_top_cpu {
 	unsigned long long	irq_count;
@@ -801,10 +802,10 @@ static struct osnoise_tool
 static int
 timerlat_top_bpf_main_loop(struct osnoise_tool *tool)
 {
-	struct timerlat_params *params = to_timerlat_params(tool->params);
+	const struct common_params *params = tool->params;
 	int retval, wait_retval;
 
-	if (params->common.aa_only) {
+	if (params->aa_only) {
 		/* Auto-analysis only, just wait for stop tracing */
 		timerlat_bpf_wait(-1);
 		return 0;
@@ -812,8 +813,8 @@ timerlat_top_bpf_main_loop(struct osnoise_tool *tool)
 
 	/* Pull and display data in a loop */
 	while (!stop_tracing) {
-		wait_retval = timerlat_bpf_wait(params->common.quiet ? -1 :
-						params->common.sleep_time);
+		wait_retval = timerlat_bpf_wait(params->quiet ? -1 :
+						params->sleep_time);
 
 		retval = timerlat_top_bpf_pull_data(tool);
 		if (retval) {
@@ -821,28 +822,27 @@ timerlat_top_bpf_main_loop(struct osnoise_tool *tool)
 			return retval;
 		}
 
-		if (!params->common.quiet)
+		if (!params->quiet)
 			timerlat_print_stats(tool);
 
 		if (wait_retval != 0) {
 			/* Stopping requested by tracer */
-			actions_perform(&params->common.threshold_actions);
+			retval = common_threshold_handler(tool);
+			if (retval)
+				return retval;
 
-			if (!params->common.threshold_actions.continue_flag)
-				/* continue flag not set, break */
+			if (!should_continue_tracing(tool->params))
 				break;
 
-			/* continue action reached, re-enable tracing */
-			if (tool->record)
-				trace_instance_start(&tool->record->trace);
-			if (tool->aa)
-				trace_instance_start(&tool->aa->trace);
-			timerlat_bpf_restart_tracing();
+			if (timerlat_bpf_restart_tracing()) {
+				err_msg("Error restarting BPF trace\n");
+				return -1;
+			}
 		}
 
 		/* is there still any user-threads ? */
-		if (params->common.user_workload) {
-			if (params->common.user.stopped_running) {
+		if (params->user_workload) {
+			if (params->user.stopped_running) {
 				debug_msg("timerlat user space threads stopped!\n");
 				break;
 			}
-- 
2.52.0


