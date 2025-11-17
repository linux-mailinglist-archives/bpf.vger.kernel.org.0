Return-Path: <bpf+bounces-74778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BE1C65D15
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 19:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id DEC1429470
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 18:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E24A33A019;
	Mon, 17 Nov 2025 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZSkkEoO"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28263339B4E
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 18:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405659; cv=none; b=hDYnGYnPNxYofJE4wZ68jNlmfaAmDNFyNhRbKKf8W1WaksZa2NbwxSqxDiGf9N1GDBMx60EsiKaXsx6VK4t9FL712IqlKfKuDUoocTw/KNbsLuQ3CXCTedbFlLb152/BaoXppmp6M+ca0/XW7aAlZGTmPZwAh0PEVdMqdusz/L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405659; c=relaxed/simple;
	bh=YWrSV4nY4LocEp7mCnwqF5xXNyBYnRwLmTPE4sU0cPE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KxbVswITi2yTNmWoBm38DhEiCFCOpK2xXOsqwfCne4taCnUcz1vc3IRsoAuRIHmf3TQIFP1TxvioeT+2zfBWBcdl90qoLM9+kAjq4J+a/ffYK8yBmMOAQuLwfVW9LDhGnN0iD+PZ7yf+qrM3bYwpfLpvZRIoB93knYLcQLaeiCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UZSkkEoO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763405656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bFNQ6BM0IW516zJK11WM40Y2bQSeuES9ESqJWTtS0po=;
	b=UZSkkEoO9byBWPVE0iLNcXV92Wi2hHLm+4YtcFbFf3IpHFoFt/4xTD33GDPfJda0K82IPH
	F4NpvXDuAJfVbbIza3t2UhaD6tYVF416sqDSbVrlRBuIZ20yBkJ2JBBPXe9eiFz8XYCOK2
	0UTj2po7/gTXmhbXiAaoXU2505bU5fU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-4Ygaa0CeP7-nYKrFBbDUbQ-1; Mon,
 17 Nov 2025 13:54:12 -0500
X-MC-Unique: 4Ygaa0CeP7-nYKrFBbDUbQ-1
X-Mimecast-MFC-AGG-ID: 4Ygaa0CeP7-nYKrFBbDUbQ_1763405651
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8356C1801308;
	Mon, 17 Nov 2025 18:54:11 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.81.153])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C3536180049F;
	Mon, 17 Nov 2025 18:54:05 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Wander Lairson Costa <wander@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [rtla 01/13] rtla: Check for memory allocation failures
Date: Mon, 17 Nov 2025 15:41:08 -0300
Message-ID: <20251117184409.42831-2-wander@redhat.com>
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

The actions_init() and actions_new() functions did not check the
return value of calloc() and realloc() respectively. In a low
memory situation, this could lead to a NULL pointer dereference.

Add checks for the return value of memory allocation functions
and return an error in case of failure. Update the callers to
handle the error properly.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/actions.c       | 26 +++++++++++++++++++++++---
 tools/tracing/rtla/src/actions.h       |  2 +-
 tools/tracing/rtla/src/timerlat_hist.c |  7 +++++--
 tools/tracing/rtla/src/timerlat_top.c  |  7 +++++--
 4 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index 8945aee58d511..01648a1425c10 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -11,11 +11,13 @@
 /*
  * actions_init - initialize struct actions
  */
-void
+int
 actions_init(struct actions *self)
 {
 	self->size = action_default_size;
 	self->list = calloc(self->size, sizeof(struct action));
+	if (!self->list)
+		return -1;
 	self->len = 0;
 	self->continue_flag = false;
 
@@ -23,6 +25,7 @@ actions_init(struct actions *self)
 
 	/* This has to be set by the user */
 	self->trace_output_inst = NULL;
+	return 0;
 }
 
 /*
@@ -50,8 +53,13 @@ static struct action *
 actions_new(struct actions *self)
 {
 	if (self->len >= self->size) {
-		self->size *= 2;
-		self->list = realloc(self->list, self->size * sizeof(struct action));
+		const size_t new_size = self->size * 2;
+		void *p = reallocarray(self->list, new_size, sizeof(struct action));
+
+		if (!p)
+			return NULL;
+		self->list = p;
+		self->size = new_size;
 	}
 
 	return &self->list[self->len++];
@@ -65,6 +73,9 @@ actions_add_trace_output(struct actions *self, const char *trace_output)
 {
 	struct action *action = actions_new(self);
 
+	if (!action)
+		return -1;
+
 	self->present[ACTION_TRACE_OUTPUT] = true;
 	action->type = ACTION_TRACE_OUTPUT;
 	action->trace_output = calloc(strlen(trace_output) + 1, sizeof(char));
@@ -83,6 +94,9 @@ actions_add_signal(struct actions *self, int signal, int pid)
 {
 	struct action *action = actions_new(self);
 
+	if (!action)
+		return -1;
+
 	self->present[ACTION_SIGNAL] = true;
 	action->type = ACTION_SIGNAL;
 	action->signal = signal;
@@ -99,6 +113,9 @@ actions_add_shell(struct actions *self, const char *command)
 {
 	struct action *action = actions_new(self);
 
+	if (!action)
+		return -1;
+
 	self->present[ACTION_SHELL] = true;
 	action->type = ACTION_SHELL;
 	action->command = calloc(strlen(command) + 1, sizeof(char));
@@ -117,6 +134,9 @@ actions_add_continue(struct actions *self)
 {
 	struct action *action = actions_new(self);
 
+	if (!action)
+		return -1;
+
 	self->present[ACTION_CONTINUE] = true;
 	action->type = ACTION_CONTINUE;
 
diff --git a/tools/tracing/rtla/src/actions.h b/tools/tracing/rtla/src/actions.h
index a4f9b570775b5..439bcc58ac93a 100644
--- a/tools/tracing/rtla/src/actions.h
+++ b/tools/tracing/rtla/src/actions.h
@@ -42,7 +42,7 @@ struct actions {
 	struct tracefs_instance *trace_output_inst;
 };
 
-void actions_init(struct actions *self);
+int actions_init(struct actions *self);
 void actions_destroy(struct actions *self);
 int actions_add_trace_output(struct actions *self, const char *trace_output);
 int actions_add_signal(struct actions *self, int signal, int pid);
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 606c1688057b2..09a3da3f58630 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -798,8 +798,11 @@ static struct common_params
 	if (!params)
 		exit(1);
 
-	actions_init(&params->common.threshold_actions);
-	actions_init(&params->common.end_actions);
+	if (actions_init(&params->common.threshold_actions) ||
+	    actions_init(&params->common.end_actions)) {
+		err_msg("Error initializing actions");
+		exit(EXIT_FAILURE);
+	}
 
 	/* disabled by default */
 	params->dma_latency = -1;
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index fc479a0dcb597..7679820e72db5 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -556,8 +556,11 @@ static struct common_params
 	if (!params)
 		exit(1);
 
-	actions_init(&params->common.threshold_actions);
-	actions_init(&params->common.end_actions);
+	if (actions_init(&params->common.threshold_actions) ||
+	    actions_init(&params->common.end_actions)) {
+		err_msg("Error initializing actions");
+		exit(EXIT_FAILURE);
+	}
 
 	/* disabled by default */
 	params->dma_latency = -1;
-- 
2.51.1


