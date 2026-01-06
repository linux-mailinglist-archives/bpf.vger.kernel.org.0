Return-Path: <bpf+bounces-77947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A8BCF8AC9
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 15:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D3B8302956E
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 14:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6C833F38A;
	Tue,  6 Jan 2026 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JdAg6CDb"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CAA33F364
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 13:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767706940; cv=none; b=U0VSkCQN66d59g+z6+iMqvtNh6V12OLywOwVeytjyqTXwahL9MrLPBGv59OaswEvSSisAx4aBmld9jxRDCr2sJuj4Pk4+wwKvk8MC6htpY80H44RSF35qMFO8TBcqYVnX7GB2nr5Vl8DwUqXP31AHB6FfGj+llZcPGX4XTO2sZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767706940; c=relaxed/simple;
	bh=0WUPyK+qfDEixMaCU5x9MQ2nD7F+MVzr1/647jwgHt4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5WG+JTqNNHYJyJXRKqmW1Oj91aWsyivZ3vzX8FtjGtsfv7zKS8lZGYiE0WPeIXfcGASC7nlF/WXRhunGGrqSqdh439BYu5d0q0hurGQJlXCCe8XrrSEShIQIA+7PU17MaVF7fbgljxt5ugvf+t9A78uIE12kh235/G7Z7i4xwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JdAg6CDb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767706937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ICpCfMygw2MMFHUKfb4+us+NT7ItdUncTrnLD4HZzk=;
	b=JdAg6CDbP7SAzRLuHAUICnrnFBouhDkRCt0AgwFD+1GGOTNZNqKGy8sRUutBeFMf0ryJlJ
	rGdEPTWxyz4ipLzKPKtPwMcZkh7dam35IuwYIfRHaUFVuUNmY/MH3y2Q/D3xNhOMz2kTPV
	BaY+E1ApsP+VSlU6IzILg6qGOcJ170o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-dUzFzlorOKOf_rrI_PYaNQ-1; Tue,
 06 Jan 2026 08:42:14 -0500
X-MC-Unique: dUzFzlorOKOf_rrI_PYaNQ-1
X-Mimecast-MFC-AGG-ID: dUzFzlorOKOf_rrI_PYaNQ_1767706933
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 659AD18011EE;
	Tue,  6 Jan 2026 13:42:13 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.89.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E2604180035A;
	Tue,  6 Jan 2026 13:42:09 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v2 07/18] rtla: Introduce common_restart() helper
Date: Tue,  6 Jan 2026 08:49:43 -0300
Message-ID: <20260106133655.249887-8-wander@redhat.com>
In-Reply-To: <20260106133655.249887-1-wander@redhat.com>
References: <20260106133655.249887-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

A few functions duplicate the logic for handling threshold actions.
When a threshold is reached, these functions stop the trace, perform
actions, and restart the trace if configured to continue.

Create a new helper function, common_restart(), to centralize this
shared logic and avoid code duplication. This function now handles the
threshold actions and restarts the necessary trace instances.

Refactor the affected functions main loops to call the new helper.
This makes the code cleaner and more maintainable.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/common.c        | 65 +++++++++++++++++++-------
 tools/tracing/rtla/src/common.h        |  9 ++++
 tools/tracing/rtla/src/timerlat_hist.c | 20 ++++----
 tools/tracing/rtla/src/timerlat_top.c  | 20 ++++----
 4 files changed, 78 insertions(+), 36 deletions(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index b197037fc58b3..d608ffe12e7b0 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -95,6 +95,37 @@ common_apply_config(struct osnoise_tool *tool, struct common_params *params)
 }
 
 
+/**
+ * common_restart - handle threshold actions and optionally restart tracing
+ * @tool: pointer to the osnoise_tool instance containing trace contexts
+ * @params: timerlat parameters with threshold action configuration
+ *
+ * Return:
+ *   RESTART_OK - Actions executed successfully and tracing restarted
+ *   RESTART_STOP - Actions executed but 'continue' flag not set, stop tracing
+ *   RESTART_ERROR - Failed to restart tracing after executing actions
+ */
+enum restart_result
+common_restart(const struct osnoise_tool *tool, struct common_params *params)
+{
+	actions_perform(&params->threshold_actions);
+
+	if (!params->threshold_actions.continue_flag)
+		/* continue flag not set, break */
+		return RESTART_STOP;
+
+	/* continue action reached, re-enable tracing */
+	if (tool->record && trace_instance_start(&tool->record->trace))
+		goto err;
+	if (tool->aa && trace_instance_start(&tool->aa->trace))
+		goto err;
+	return RESTART_OK;
+
+err:
+	err_msg("Error restarting trace\n");
+	return RESTART_ERROR;
+}
+
 int run_tool(struct tool_ops *ops, int argc, char *argv[])
 {
 	struct common_params *params;
@@ -272,17 +303,16 @@ int top_main_loop(struct osnoise_tool *tool)
 				/* stop tracing requested, do not perform actions */
 				return 0;
 
-			actions_perform(&params->threshold_actions);
+			enum restart_result result;
+
+			result = common_restart(tool, params);
 
-			if (!params->threshold_actions.continue_flag)
-				/* continue flag not set, break */
+			if (result == RESTART_STOP)
 				return 0;
 
-			/* continue action reached, re-enable tracing */
-			if (record)
-				trace_instance_start(&record->trace);
-			if (tool->aa)
-				trace_instance_start(&tool->aa->trace);
+			if (result == RESTART_ERROR)
+				return -1;
+
 			trace_instance_start(trace);
 		}
 
@@ -323,18 +353,17 @@ int hist_main_loop(struct osnoise_tool *tool)
 				/* stop tracing requested, do not perform actions */
 				break;
 
-			actions_perform(&params->threshold_actions);
+			enum restart_result result;
 
-			if (!params->threshold_actions.continue_flag)
-				/* continue flag not set, break */
-				break;
+			result = common_restart(tool, params);
+
+			if (result == RESTART_STOP)
+				return 0;
 
-			/* continue action reached, re-enable tracing */
-			if (tool->record)
-				trace_instance_start(&tool->record->trace);
-			if (tool->aa)
-				trace_instance_start(&tool->aa->trace);
-			trace_instance_start(&tool->trace);
+			if (result == RESTART_ERROR)
+				return -1;
+
+			trace_instance_start(trace);
 		}
 
 		/* is there still any user-threads ? */
diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index 9ec2b7632c376..f2c9e21c03651 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -143,6 +143,15 @@ struct tool_ops {
 	void (*free)(struct osnoise_tool *tool);
 };
 
+enum restart_result {
+	RESTART_OK,
+	RESTART_STOP,
+	RESTART_ERROR = -1,
+};
+
+enum restart_result
+common_restart(const struct osnoise_tool *tool, struct common_params *params);
+
 int osnoise_set_cpus(struct osnoise_context *context, char *cpus);
 void osnoise_restore_cpus(struct osnoise_context *context);
 
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 226167c88c8d6..27fc98270da59 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -17,6 +17,7 @@
 #include "timerlat.h"
 #include "timerlat_aa.h"
 #include "timerlat_bpf.h"
+#include "common.h"
 
 struct timerlat_hist_cpu {
 	int			*irq;
@@ -1100,18 +1101,19 @@ static int timerlat_hist_bpf_main_loop(struct osnoise_tool *tool)
 
 		if (!stop_tracing) {
 			/* Threshold overflow, perform actions on threshold */
-			actions_perform(&params->common.threshold_actions);
+			enum restart_result result;
 
-			if (!params->common.threshold_actions.continue_flag)
-				/* continue flag not set, break */
+			result = common_restart(tool, &params->common);
+			if (result == RESTART_STOP)
 				break;
 
-			/* continue action reached, re-enable tracing */
-			if (tool->record)
-				trace_instance_start(&tool->record->trace);
-			if (tool->aa)
-				trace_instance_start(&tool->aa->trace);
-			timerlat_bpf_restart_tracing();
+			if (result == RESTART_ERROR)
+				return -1;
+
+			if (timerlat_bpf_restart_tracing()) {
+				err_msg("Error restarting BPF trace\n");
+				return -1;
+			}
 		}
 	}
 	timerlat_bpf_detach();
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 31e1514a2528d..f7e85dc918ef3 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -18,6 +18,7 @@
 #include "timerlat.h"
 #include "timerlat_aa.h"
 #include "timerlat_bpf.h"
+#include "common.h"
 
 struct timerlat_top_cpu {
 	unsigned long long	irq_count;
@@ -869,18 +870,19 @@ timerlat_top_bpf_main_loop(struct osnoise_tool *tool)
 
 		if (wait_retval != 0) {
 			/* Stopping requested by tracer */
-			actions_perform(&params->common.threshold_actions);
+			enum restart_result result;
 
-			if (!params->common.threshold_actions.continue_flag)
-				/* continue flag not set, break */
+			result = common_restart(tool, &params->common);
+			if (result == RESTART_STOP)
 				break;
 
-			/* continue action reached, re-enable tracing */
-			if (tool->record)
-				trace_instance_start(&tool->record->trace);
-			if (tool->aa)
-				trace_instance_start(&tool->aa->trace);
-			timerlat_bpf_restart_tracing();
+			if (result == RESTART_ERROR)
+				return -1;
+
+			if (timerlat_bpf_restart_tracing()) {
+				err_msg("Error restarting BPF trace\n");
+				return -1;
+			}
 		}
 
 		/* is there still any user-threads ? */
-- 
2.52.0


