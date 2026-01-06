Return-Path: <bpf+bounces-77941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF52CF892D
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 14:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8A23306DBC9
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 13:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB263321C1;
	Tue,  6 Jan 2026 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBCgI8Y0"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106643321C8
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767706670; cv=none; b=msOsGXgIc9CjtagweMpWEXic27LuOY6Ha6issZgEp8pbbSRjsQaLt6dsSoV3cVgg8I/aWd5oulLGMRgC3Gswd9U+H3gUGgxUSSO+qBzVsyQcooXKPetrhaxO+vOoOSEt55aJ0IxfBItfXjvym3gKoCv49azY9KhJhdNNJPsfXp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767706670; c=relaxed/simple;
	bh=ay3+o11g3F2973EBIkCobkS+UPKn9HW13yLOwFXa/gA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltrzDiQcmJwH2ql0pj2WuMuPjM+Ar6eocaZSFTiEhHtdOz3fSJokR6myNB7tJ9sWu7caZWjI6XyFPnGP20kE6IEQZNCepxwy0vjGXytNonmNCuJWMLCuRe3yZAav7lIcQu0EQRjtOGBK9+7dLw/BO9Zpdi2ryhOI0eS8wrWo1aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NBCgI8Y0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767706664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9s5apwvrI9NS4GcATbs3y34CNvepD5CAt4yXpK84c9Q=;
	b=NBCgI8Y0avwkRryXzhcwi/avtZewwQ9JA5Ouqf7Yvwxfi9nZHaCQJNzt2O5RkGMjRNJaG8
	l9T0PuQ/po1is+7FqOB0DX5zObcPhEyVMzGjtI8zFnxbnlMgoyUKd6spXBzttqJFIw/3RQ
	zRxxLvx8IMt4/78PskWUyiNgYxrwzQo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-JRqNGrupOfusSZUQdTVqRQ-1; Tue,
 06 Jan 2026 08:37:41 -0500
X-MC-Unique: JRqNGrupOfusSZUQdTVqRQ-1
X-Mimecast-MFC-AGG-ID: JRqNGrupOfusSZUQdTVqRQ_1767706660
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0727E1956053;
	Tue,  6 Jan 2026 13:37:40 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.89.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A9958180035A;
	Tue,  6 Jan 2026 13:37:35 +0000 (UTC)
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
Subject: [PATCH v2 01/18] rtla: Exit on memory allocation failures during initialization
Date: Tue,  6 Jan 2026 08:49:37 -0300
Message-ID: <20260106133655.249887-2-wander@redhat.com>
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

Most memory allocations in rtla happen during early initialization
before any resources are acquired that would require cleanup. In these
cases, propagating allocation errors just adds complexity without any
benefit. There's nothing to clean up, and the program must exit anyway.

This patch introduces fatal allocation wrappers (calloc_fatal,
reallocarray_fatal, strdup_fatal) that call fatal() on allocation
failure. These wrappers simplify the code by eliminating unnecessary
error propagation paths.

The patch converts early allocations to use these wrappers in
actions_init() and related action functions, osnoise_context_alloc()
and osnoise_init_tool(), trace_instance_init() and trace event
functions, and parameter structure allocations in main functions.

This simplifies the code while maintaining the same behavior: immediate
exit on allocation failure during initialization. Allocations that
require cleanup, such as those in histogram allocation functions with
goto cleanup paths, are left unchanged and continue to return errors.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/actions.c       | 50 ++++++++++++--------------
 tools/tracing/rtla/src/actions.h       |  8 ++---
 tools/tracing/rtla/src/osnoise.c       | 22 ++++--------
 tools/tracing/rtla/src/osnoise_hist.c  | 25 ++++---------
 tools/tracing/rtla/src/osnoise_top.c   | 25 ++++---------
 tools/tracing/rtla/src/timerlat_hist.c | 24 ++++---------
 tools/tracing/rtla/src/timerlat_top.c  | 25 ++++---------
 tools/tracing/rtla/src/trace.c         | 30 ++++------------
 tools/tracing/rtla/src/trace.h         |  4 +--
 tools/tracing/rtla/src/utils.c         | 35 ++++++++++++++++++
 tools/tracing/rtla/src/utils.h         |  3 ++
 11 files changed, 108 insertions(+), 143 deletions(-)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index 8945aee58d511..ff7811e175930 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -15,7 +15,7 @@ void
 actions_init(struct actions *self)
 {
 	self->size = action_default_size;
-	self->list = calloc(self->size, sizeof(struct action));
+	self->list = calloc_fatal(self->size, sizeof(struct action));
 	self->len = 0;
 	self->continue_flag = false;
 
@@ -50,8 +50,10 @@ static struct action *
 actions_new(struct actions *self)
 {
 	if (self->len >= self->size) {
-		self->size *= 2;
-		self->list = realloc(self->list, self->size * sizeof(struct action));
+		const size_t new_size = self->size * 2;
+
+		self->list = reallocarray_fatal(self->list, new_size, sizeof(struct action));
+		self->size = new_size;
 	}
 
 	return &self->list[self->len++];
@@ -60,25 +62,21 @@ actions_new(struct actions *self)
 /*
  * actions_add_trace_output - add an action to output trace
  */
-int
+void
 actions_add_trace_output(struct actions *self, const char *trace_output)
 {
 	struct action *action = actions_new(self);
 
 	self->present[ACTION_TRACE_OUTPUT] = true;
 	action->type = ACTION_TRACE_OUTPUT;
-	action->trace_output = calloc(strlen(trace_output) + 1, sizeof(char));
-	if (!action->trace_output)
-		return -1;
+	action->trace_output = calloc_fatal(strlen(trace_output) + 1, sizeof(char));
 	strcpy(action->trace_output, trace_output);
-
-	return 0;
 }
 
 /*
  * actions_add_trace_output - add an action to send signal to a process
  */
-int
+void
 actions_add_signal(struct actions *self, int signal, int pid)
 {
 	struct action *action = actions_new(self);
@@ -87,40 +85,32 @@ actions_add_signal(struct actions *self, int signal, int pid)
 	action->type = ACTION_SIGNAL;
 	action->signal = signal;
 	action->pid = pid;
-
-	return 0;
 }
 
 /*
  * actions_add_shell - add an action to execute a shell command
  */
-int
+void
 actions_add_shell(struct actions *self, const char *command)
 {
 	struct action *action = actions_new(self);
 
 	self->present[ACTION_SHELL] = true;
 	action->type = ACTION_SHELL;
-	action->command = calloc(strlen(command) + 1, sizeof(char));
-	if (!action->command)
-		return -1;
+	action->command = calloc_fatal(strlen(command) + 1, sizeof(char));
 	strcpy(action->command, command);
-
-	return 0;
 }
 
 /*
  * actions_add_continue - add an action to resume measurement
  */
-int
+void
 actions_add_continue(struct actions *self)
 {
 	struct action *action = actions_new(self);
 
 	self->present[ACTION_CONTINUE] = true;
 	action->type = ACTION_CONTINUE;
-
-	return 0;
 }
 
 /*
@@ -174,7 +164,8 @@ actions_parse(struct actions *self, const char *trigger, const char *tracefn)
 				/* Only one argument allowed */
 				return -1;
 		}
-		return actions_add_trace_output(self, trace_output);
+		actions_add_trace_output(self, trace_output);
+		break;
 	case ACTION_SIGNAL:
 		/* Takes two arguments, num (signal) and pid */
 		while (token != NULL) {
@@ -197,21 +188,26 @@ actions_parse(struct actions *self, const char *trigger, const char *tracefn)
 			/* Missing argument */
 			return -1;
 
-		return actions_add_signal(self, signal, pid);
+		actions_add_signal(self, signal, pid);
+		break;
 	case ACTION_SHELL:
 		if (token == NULL)
 			return -1;
-		if (strlen(token) > 8 && strncmp(token, "command=", 8) == 0)
-			return actions_add_shell(self, token + 8);
-		return -1;
+		if (strlen(token) > 8 && strncmp(token, "command=", 8))
+			return -1;
+		actions_add_shell(self, token + 8);
+		break;
 	case ACTION_CONTINUE:
 		/* Takes no argument */
 		if (token != NULL)
 			return -1;
-		return actions_add_continue(self);
+		actions_add_continue(self);
+		break;
 	default:
 		return -1;
 	}
+
+	return 0;
 }
 
 /*
diff --git a/tools/tracing/rtla/src/actions.h b/tools/tracing/rtla/src/actions.h
index a4f9b570775b5..fb366d6509b8b 100644
--- a/tools/tracing/rtla/src/actions.h
+++ b/tools/tracing/rtla/src/actions.h
@@ -44,9 +44,9 @@ struct actions {
 
 void actions_init(struct actions *self);
 void actions_destroy(struct actions *self);
-int actions_add_trace_output(struct actions *self, const char *trace_output);
-int actions_add_signal(struct actions *self, int signal, int pid);
-int actions_add_shell(struct actions *self, const char *command);
-int actions_add_continue(struct actions *self);
+void actions_add_trace_output(struct actions *self, const char *trace_output);
+void actions_add_signal(struct actions *self, int signal, int pid);
+void actions_add_shell(struct actions *self, const char *command);
+void actions_add_continue(struct actions *self);
 int actions_parse(struct actions *self, const char *trigger, const char *tracefn);
 int actions_perform(struct actions *self);
diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 312c511fa0044..c5b41ec26b0a4 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -938,9 +938,7 @@ struct osnoise_context *osnoise_context_alloc(void)
 {
 	struct osnoise_context *context;
 
-	context = calloc(1, sizeof(*context));
-	if (!context)
-		return NULL;
+	context = calloc_fatal(1, sizeof(*context));
 
 	context->orig_stop_us		= OSNOISE_OPTION_INIT_VAL;
 	context->stop_us		= OSNOISE_OPTION_INIT_VAL;
@@ -1017,24 +1015,16 @@ void osnoise_destroy_tool(struct osnoise_tool *top)
 struct osnoise_tool *osnoise_init_tool(char *tool_name)
 {
 	struct osnoise_tool *top;
-	int retval;
-
-	top = calloc(1, sizeof(*top));
-	if (!top)
-		return NULL;
 
+	top = calloc_fatal(1, sizeof(*top));
 	top->context = osnoise_context_alloc();
-	if (!top->context)
-		goto out_err;
 
-	retval = trace_instance_init(&top->trace, tool_name);
-	if (retval)
-		goto out_err;
+	if (trace_instance_init(&top->trace, tool_name)) {
+		osnoise_destroy_tool(top);
+		return NULL;
+	}
 
 	return top;
-out_err:
-	osnoise_destroy_tool(top);
-	return NULL;
 }
 
 /*
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index ff8c231e47c47..af7d8621dd9d7 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -474,9 +474,7 @@ static struct common_params
 	int c;
 	char *trace_output = NULL;
 
-	params = calloc(1, sizeof(*params));
-	if (!params)
-		exit(1);
+	params = calloc_fatal(1, sizeof(*params));
 
 	actions_init(&params->common.threshold_actions);
 	actions_init(&params->common.end_actions);
@@ -564,9 +562,6 @@ static struct common_params
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
-			if (!tevent)
-				fatal("Error alloc trace event");
-
 			if (params->common.events)
 				tevent->next = params->common.events;
 
@@ -631,22 +626,16 @@ static struct common_params
 			params->common.hist.with_zeros = 1;
 			break;
 		case '4': /* trigger */
-			if (params->common.events) {
-				retval = trace_event_add_trigger(params->common.events, optarg);
-				if (retval)
-					fatal("Error adding trigger %s", optarg);
-			} else {
+			if (params->common.events)
+				trace_event_add_trigger(params->common.events, optarg);
+			else
 				fatal("--trigger requires a previous -e");
-			}
 			break;
 		case '5': /* filter */
-			if (params->common.events) {
-				retval = trace_event_add_filter(params->common.events, optarg);
-				if (retval)
-					fatal("Error adding filter %s", optarg);
-			} else {
+			if (params->common.events)
+				trace_event_add_filter(params->common.events, optarg);
+			else
 				fatal("--filter requires a previous -e");
-			}
 			break;
 		case '6':
 			params->common.warmup = get_llong_from_str(optarg);
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 04c699bdd7363..31b7e92d76fe4 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -327,9 +327,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 	int c;
 	char *trace_output = NULL;
 
-	params = calloc(1, sizeof(*params));
-	if (!params)
-		exit(1);
+	params = calloc_fatal(1, sizeof(*params));
 
 	actions_init(&params->common.threshold_actions);
 	actions_init(&params->common.end_actions);
@@ -410,9 +408,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
-			if (!tevent)
-				fatal("Error alloc trace event");
-
 			if (params->common.events)
 				tevent->next = params->common.events;
 			params->common.events = tevent;
@@ -462,22 +457,16 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 			params->threshold = get_llong_from_str(optarg);
 			break;
 		case '0': /* trigger */
-			if (params->common.events) {
-				retval = trace_event_add_trigger(params->common.events, optarg);
-				if (retval)
-					fatal("Error adding trigger %s", optarg);
-			} else {
+			if (params->common.events)
+				trace_event_add_trigger(params->common.events, optarg);
+			else
 				fatal("--trigger requires a previous -e");
-			}
 			break;
 		case '1': /* filter */
-			if (params->common.events) {
-				retval = trace_event_add_filter(params->common.events, optarg);
-				if (retval)
-					fatal("Error adding filter %s", optarg);
-			} else {
+			if (params->common.events)
+				trace_event_add_filter(params->common.events, optarg);
+			else
 				fatal("--filter requires a previous -e");
-			}
 			break;
 		case '2':
 			params->common.warmup = get_llong_from_str(optarg);
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 1fb471a787b79..226167c88c8d6 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -772,9 +772,7 @@ static struct common_params
 	int c;
 	char *trace_output = NULL;
 
-	params = calloc(1, sizeof(*params));
-	if (!params)
-		exit(1);
+	params = calloc_fatal(1, sizeof(*params));
 
 	actions_init(&params->common.threshold_actions);
 	actions_init(&params->common.end_actions);
@@ -883,8 +881,6 @@ static struct common_params
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
-			if (!tevent)
-				fatal("Error alloc trace event");
 
 			if (params->common.events)
 				tevent->next = params->common.events;
@@ -963,22 +959,16 @@ static struct common_params
 			params->common.hist.with_zeros = 1;
 			break;
 		case '6': /* trigger */
-			if (params->common.events) {
-				retval = trace_event_add_trigger(params->common.events, optarg);
-				if (retval)
-					fatal("Error adding trigger %s", optarg);
-			} else {
+			if (params->common.events)
+				trace_event_add_trigger(params->common.events, optarg);
+			else
 				fatal("--trigger requires a previous -e");
-			}
 			break;
 		case '7': /* filter */
-			if (params->common.events) {
-				retval = trace_event_add_filter(params->common.events, optarg);
-				if (retval)
-					fatal("Error adding filter %s", optarg);
-			} else {
+			if (params->common.events)
+				trace_event_add_filter(params->common.events, optarg);
+			else
 				fatal("--filter requires a previous -e");
-			}
 			break;
 		case '8':
 			params->dma_latency = get_llong_from_str(optarg);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 29c2c1f717ed7..31e1514a2528d 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -544,9 +544,7 @@ static struct common_params
 	int c;
 	char *trace_output = NULL;
 
-	params = calloc(1, sizeof(*params));
-	if (!params)
-		exit(1);
+	params = calloc_fatal(1, sizeof(*params));
 
 	actions_init(&params->common.threshold_actions);
 	actions_init(&params->common.end_actions);
@@ -655,9 +653,6 @@ static struct common_params
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
-			if (!tevent)
-				fatal("Error alloc trace event");
-
 			if (params->common.events)
 				tevent->next = params->common.events;
 			params->common.events = tevent;
@@ -713,22 +708,16 @@ static struct common_params
 			params->common.user_data = true;
 			break;
 		case '0': /* trigger */
-			if (params->common.events) {
-				retval = trace_event_add_trigger(params->common.events, optarg);
-				if (retval)
-					fatal("Error adding trigger %s", optarg);
-			} else {
+			if (params->common.events)
+				trace_event_add_trigger(params->common.events, optarg);
+			else
 				fatal("--trigger requires a previous -e");
-			}
 			break;
 		case '1': /* filter */
-			if (params->common.events) {
-				retval = trace_event_add_filter(params->common.events, optarg);
-				if (retval)
-					fatal("Error adding filter %s", optarg);
-			} else {
+			if (params->common.events)
+				trace_event_add_filter(params->common.events, optarg);
+			else
 				fatal("--filter requires a previous -e");
-			}
 			break;
 		case '2': /* dma-latency */
 			params->dma_latency = get_llong_from_str(optarg);
diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 69cbc48d53d3a..b22bb844b71f3 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -192,9 +192,7 @@ void trace_instance_destroy(struct trace_instance *trace)
  */
 int trace_instance_init(struct trace_instance *trace, char *tool_name)
 {
-	trace->seq = calloc(1, sizeof(*trace->seq));
-	if (!trace->seq)
-		goto out_err;
+	trace->seq = calloc_fatal(1, sizeof(*trace->seq));
 
 	trace_seq_init(trace->seq);
 
@@ -275,15 +273,9 @@ struct trace_events *trace_event_alloc(const char *event_string)
 {
 	struct trace_events *tevent;
 
-	tevent = calloc(1, sizeof(*tevent));
-	if (!tevent)
-		return NULL;
+	tevent = calloc_fatal(1, sizeof(*tevent));
 
-	tevent->system = strdup(event_string);
-	if (!tevent->system) {
-		free(tevent);
-		return NULL;
-	}
+	tevent->system = strdup_fatal(event_string);
 
 	tevent->event = strstr(tevent->system, ":");
 	if (tevent->event) {
@@ -297,31 +289,23 @@ struct trace_events *trace_event_alloc(const char *event_string)
 /*
  * trace_event_add_filter - record an event filter
  */
-int trace_event_add_filter(struct trace_events *event, char *filter)
+void trace_event_add_filter(struct trace_events *event, char *filter)
 {
 	if (event->filter)
 		free(event->filter);
 
-	event->filter = strdup(filter);
-	if (!event->filter)
-		return 1;
-
-	return 0;
+	event->filter = strdup_fatal(filter);
 }
 
 /*
  * trace_event_add_trigger - record an event trigger action
  */
-int trace_event_add_trigger(struct trace_events *event, char *trigger)
+void trace_event_add_trigger(struct trace_events *event, char *trigger)
 {
 	if (event->trigger)
 		free(event->trigger);
 
-	event->trigger = strdup(trigger);
-	if (!event->trigger)
-		return 1;
-
-	return 0;
+	event->trigger = strdup_fatal(trigger);
 }
 
 /*
diff --git a/tools/tracing/rtla/src/trace.h b/tools/tracing/rtla/src/trace.h
index 1e5aee4b828dd..95b911a2228b2 100644
--- a/tools/tracing/rtla/src/trace.h
+++ b/tools/tracing/rtla/src/trace.h
@@ -45,6 +45,6 @@ void trace_events_destroy(struct trace_instance *instance,
 int trace_events_enable(struct trace_instance *instance,
 			  struct trace_events *events);
 
-int trace_event_add_filter(struct trace_events *event, char *filter);
-int trace_event_add_trigger(struct trace_events *event, char *trigger);
+void trace_event_add_filter(struct trace_events *event, char *filter);
+void trace_event_add_trigger(struct trace_events *event, char *trigger);
 int trace_set_buffer_size(struct trace_instance *trace, int size);
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 9cf5a0098e9aa..acf95afa25b5a 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -1000,3 +1000,38 @@ char *parse_optional_arg(int argc, char **argv)
 		return NULL;
 	}
 }
+
+static inline void fatal_alloc(void)
+{
+	fatal("Error allocating memory\n");
+}
+
+void *calloc_fatal(size_t n, size_t size)
+{
+	void *p = calloc(n, size);
+
+	if (!p)
+		fatal_alloc();
+
+	return p;
+}
+
+void *reallocarray_fatal(void *p, size_t n, size_t size)
+{
+	p = reallocarray(p, n, size);
+
+	if (!p)
+		fatal_alloc();
+
+	return p;
+}
+
+char *strdup_fatal(const char *s)
+{
+	char *p = strdup(s);
+
+	if (!p)
+		fatal_alloc();
+
+	return p;
+}
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index 091df4ba45877..0ed2c7275f2c5 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -68,6 +68,9 @@ int set_comm_sched_attr(const char *comm_prefix, struct sched_attr *attr);
 int set_comm_cgroup(const char *comm_prefix, const char *cgroup);
 int set_pid_cgroup(pid_t pid, const char *cgroup);
 int set_cpu_dma_latency(int32_t latency);
+void *calloc_fatal(size_t n, size_t size);
+void *reallocarray_fatal(void *p, size_t n, size_t size);
+char *strdup_fatal(const char *s);
 #ifdef HAVE_LIBCPUPOWER_SUPPORT
 int save_cpu_idle_disable_state(unsigned int cpu);
 int restore_cpu_idle_disable_state(unsigned int cpu);
-- 
2.52.0


