Return-Path: <bpf+bounces-74784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 611E6C65D68
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 20:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EC9B736240A
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 18:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60505331A6C;
	Mon, 17 Nov 2025 18:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIhPXMGA"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4638533032B
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 18:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405756; cv=none; b=icwxt0MdU8vKZyrOAnfEYXnSTGpv941qyjxbWc9w7JpgIDcfZHpZLToq5xQcbgvGXD6QebCEyFuPolQCo/UAEQhi31/mH7M0I3RC7LUbhyNL39j2BKIFMW4Gn9EMt2NH0IggHzLi+wH0SCndJIDL/kLIo7CH30inijJ3oM6dP+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405756; c=relaxed/simple;
	bh=0DUJjjpWGFu3cxwZ4U+Q5JEjqJrK7b/UDtBTQaqQouw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QT33cSNv/aiPRbkxkvbWYNb+hGE3tGIlTV+S+Dr+Mm2+tUVs+xYcQwJQ0+fEdkirHWhSnUx9ZOpRQRqfApuUf69Eu8YI1uEVCdHeQNsUZTfNMC7FeiGfbgXJmahjIjq3sOJ6C+3LPdRt8IAlNg3rczyXk/st0ym7JtwncNShPdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JIhPXMGA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763405754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fWTz1t3u2xCVa15Vvd3x9H1q+7O4K8arNn0cRNPfP4M=;
	b=JIhPXMGAZzkpMOgzazl+fl5Uh99xbuN1xN+1kkdDDBWwAWGDX1y2fq4Tw+huUhVe1qGffk
	HEPsKQRV5Sh7pgewLsx38xxDosoE63E9oxCqygwS9diVVag7BnAwNIYAHLzr3wKY7tuTkt
	Gk0F1U2NkFhsNglQbNz+40kS5nk8FXA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-kTKo6WKPM9-VZrKAIcFSUg-1; Mon,
 17 Nov 2025 13:55:50 -0500
X-MC-Unique: kTKo6WKPM9-VZrKAIcFSUg-1
X-Mimecast-MFC-AGG-ID: kTKo6WKPM9-VZrKAIcFSUg_1763405749
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9161A180047F;
	Mon, 17 Nov 2025 18:55:49 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.81.153])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2AA531800367;
	Mon, 17 Nov 2025 18:55:44 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Wander Lairson Costa <wander@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	John Kacur <jkacur@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [rtla 07/13] rtla: Introduce timerlat_restart() helper
Date: Mon, 17 Nov 2025 15:41:14 -0300
Message-ID: <20251117184409.42831-8-wander@redhat.com>
In-Reply-To: <20251117184409.42831-1-wander@redhat.com>
References: <20251117184409.42831-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The timerlat_hist and timerlat_top commands duplicate the logic for
handling threshold actions. When a threshold is reached, both commands
stop the trace, perform actions, and restart the trace if configured to
continue.

Create a new helper function, timerlat_restart(), to centralize this
shared logic and avoid code duplication. This function now handles the
threshold actions and restarts the necessary trace instances.

Refactor timerlat_hist_main() and the timerlat_top main loops to call
the new helper. This makes the code cleaner and more maintainable.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/timerlat.c      | 31 ++++++++++++++++++++++++++
 tools/tracing/rtla/src/timerlat.h      |  9 ++++++++
 tools/tracing/rtla/src/timerlat_hist.c | 19 ++++++++--------
 tools/tracing/rtla/src/timerlat_top.c  | 19 ++++++++--------
 4 files changed, 60 insertions(+), 18 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 56e0b8af041d7..50c7eb00fd6b7 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -22,6 +22,37 @@
 
 static int dma_latency_fd = -1;
 
+/**
+ * timerlat_restart - handle threshold actions and optionally restart tracing
+ * @tool: pointer to the osnoise_tool instance containing trace contexts
+ * @params: timerlat parameters with threshold action configuration
+ *
+ * Return:
+ *   RESTART_OK - Actions executed successfully and tracing restarted
+ *   RESTART_STOP - Actions executed but 'continue' flag not set, stop tracing
+ *   RESTART_ERROR - Failed to restart tracing after executing actions
+ */
+enum restart_result
+timerlat_restart(const struct osnoise_tool *tool, struct timerlat_params *params)
+{
+	actions_perform(&params->common.threshold_actions);
+
+	if (!params->common.threshold_actions.continue_flag)
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
 /*
  * timerlat_apply_config - apply common configs to the initialized tool
  */
diff --git a/tools/tracing/rtla/src/timerlat.h b/tools/tracing/rtla/src/timerlat.h
index fd6065f48bb7f..47a34bb443fa0 100644
--- a/tools/tracing/rtla/src/timerlat.h
+++ b/tools/tracing/rtla/src/timerlat.h
@@ -31,6 +31,15 @@ struct timerlat_params {
 
 #define to_timerlat_params(ptr) container_of(ptr, struct timerlat_params, common)
 
+enum restart_result {
+	RESTART_OK,
+	RESTART_STOP,
+	RESTART_ERROR = -1,
+};
+
+enum restart_result
+timerlat_restart(const struct osnoise_tool *tool, struct timerlat_params *params);
+
 int timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params);
 int timerlat_main(int argc, char *argv[]);
 int timerlat_enable(struct osnoise_tool *tool);
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 09a3da3f58630..f14fc56c5b4a5 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1165,18 +1165,19 @@ static int timerlat_hist_bpf_main_loop(struct osnoise_tool *tool)
 
 		if (!stop_tracing) {
 			/* Threshold overflow, perform actions on threshold */
-			actions_perform(&params->common.threshold_actions);
+			enum restart_result result;
 
-			if (!params->common.threshold_actions.continue_flag)
-				/* continue flag not set, break */
+			result = timerlat_restart(tool, params);
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
index 7679820e72db5..d831a9e1818f4 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -921,18 +921,19 @@ timerlat_top_bpf_main_loop(struct osnoise_tool *tool)
 
 		if (wait_retval == 1) {
 			/* Stopping requested by tracer */
-			actions_perform(&params->common.threshold_actions);
+			enum restart_result result;
 
-			if (!params->common.threshold_actions.continue_flag)
-				/* continue flag not set, break */
+			result = timerlat_restart(tool, params);
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
2.51.1


