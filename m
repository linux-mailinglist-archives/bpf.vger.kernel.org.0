Return-Path: <bpf+bounces-74782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6870BC65D5C
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 20:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 17D53361E90
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 18:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B420C33F8DF;
	Mon, 17 Nov 2025 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5XW+Cuq"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93308325731
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405728; cv=none; b=SYECg03/COt/KkjYQSQVPA8nGKKIEZF6W4zmS8BJilrM9di+hZAWeDyGGuvQmTgjMnAv+zridaMPJBfrIBb2W3Zyp6+GhzOLz5t+69KsWkKA0M2qUTNoX2EyLDBr2iAp/GJmK/TyDhwhWd3sKiP9D9LxUcxgcvha21P131WpmLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405728; c=relaxed/simple;
	bh=tImqdC5OOuw6pbQKrHUSqD+e0Avl+HgeBq15ztTcD7A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWl8oR5pWDawVLZh+KstmX9RHVQDFnZ2tohLFDT0FIfM1L44gRXZt9ZfJ70T8hpyd5rE0QgaKUaysFy/6OGBnmgQsYTMmLe88wuWqX20wFCy9Ta11z0FVX7PHWlzLB6ucJQ42tWGRtq8kL/387c211nCCHCL+LcLbc6MIYSef14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5XW+Cuq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763405725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SPweW+DKunR1tbyeKWNvzzIK414Ai0gzFwnlL2yiZc=;
	b=V5XW+CuqwCI7Nv5CY5MMBS1aDiCIzeuA7MzyWJbuxxSr1G3Fst0QHYOw9XEyQ4Rv20zwUi
	/N2rkMrrfCX0pABWcELtxVwR6jO06Tg+UpRgHQaQZUf/gC40GdXdiLhW0u7EnA2pPAO3DP
	V3a3m9xbpaKckxO5Ha5QV2+B+TRNzD4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-4zoGgmFzMQS1WKUexE-_XQ-1; Mon,
 17 Nov 2025 13:55:20 -0500
X-MC-Unique: 4zoGgmFzMQS1WKUexE-_XQ-1
X-Mimecast-MFC-AGG-ID: 4zoGgmFzMQS1WKUexE-_XQ_1763405717
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D51E18002D1;
	Mon, 17 Nov 2025 18:55:17 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.81.153])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AFCB3180049F;
	Mon, 17 Nov 2025 18:55:12 +0000 (UTC)
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
Subject: [rtla 05/13] rtla: Simplify argument parsing
Date: Mon, 17 Nov 2025 15:41:12 -0300
Message-ID: <20251117184409.42831-6-wander@redhat.com>
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

The actions_parse() function uses open-coded logic to extract arguments
from a string. This includes manual length checks and strncmp() calls,
which can be verbose and error-prone.

To simplify and improve the robustness of argument parsing, introduce a
new extract_arg() helper macro. This macro extracts the value from a
"key=value" pair, making the code more concise and readable.

Also, introduce STRING_LENGTH() and strncmp_static() macros to
perform compile-time calculations of string lengths and safer string
comparisons.

Refactor actions_parse() to use these new helpers, resulting in
cleaner and more maintainable code.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/actions.c | 37 ++++++++++++++++++++++----------
 tools/tracing/rtla/src/utils.h   | 14 ++++++++++--
 2 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index e23d4f1c5a592..2a01ece78454c 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -143,15 +143,30 @@ actions_add_continue(struct actions *self)
 	return 0;
 }
 
+/*
+ * extract_arg - extract argument value from option token
+ * @token: option token (e.g., "file=trace.txt")
+ * @opt: option name to match (e.g., "file")
+ *
+ * Returns pointer to argument value after "=" if token matches "opt=",
+ * otherwise returns NULL.
+ */
+#define extract_arg(token, opt) (				\
+	strlen(token) > STRING_LENGTH(opt "=") &&		\
+	!strncmp_static(token, opt "=")				\
+		? (token) + STRING_LENGTH(opt "=") : NULL )
+
 /*
  * actions_parse - add an action based on text specification
  */
 int
 actions_parse(struct actions *self, const char *trigger, const char *tracefn)
 {
+
 	enum action_type type = ACTION_NONE;
 	const char *token;
 	char trigger_c[strlen(trigger) + 1];
+	const char *arg_value;
 
 	/* For ACTION_SIGNAL */
 	int signal = 0, pid = 0;
@@ -182,12 +197,10 @@ actions_parse(struct actions *self, const char *trigger, const char *tracefn)
 		if (token == NULL)
 			trace_output = tracefn;
 		else {
-			if (strlen(token) > 5 && strncmp(token, "file=", 5) == 0) {
-				trace_output = token + 5;
-			} else {
+			trace_output = extract_arg(token, "file");
+			if (!trace_output)
 				/* Invalid argument */
 				return -1;
-			}
 
 			token = strtok(NULL, ",");
 			if (token != NULL)
@@ -198,14 +211,15 @@ actions_parse(struct actions *self, const char *trigger, const char *tracefn)
 	case ACTION_SIGNAL:
 		/* Takes two arguments, num (signal) and pid */
 		while (token != NULL) {
-			if (strlen(token) > 4 && strncmp(token, "num=", 4) == 0) {
-				if(!strtoi(token + 4, &signal))
+			arg_value = extract_arg(token, "num");
+			if (arg_value) {
+				if (!strtoi(arg_value, &signal))
 					return -1;
-			} else if (strlen(token) > 4 && strncmp(token, "pid=", 4) == 0) {
-				if (strncmp(token + 4, "parent", 7) == 0)
+			} else if ((arg_value = extract_arg(token, "pid"))) {
+				if (strncmp_static(arg_value, "parent") == 0)
 					pid = -1;
 				else
-					if (!strtoi(token + 4, &pid))
+					if (!strtoi(arg_value, &pid))
 						return -1;
 			} else {
 				/* Invalid argument */
@@ -223,8 +237,9 @@ actions_parse(struct actions *self, const char *trigger, const char *tracefn)
 	case ACTION_SHELL:
 		if (token == NULL)
 			return -1;
-		if (strlen(token) > 8 && strncmp(token, "command=", 8) == 0)
-			return actions_add_shell(self, token + 8);
+		arg_value = extract_arg(token, "command");
+		if (arg_value)
+			return actions_add_shell(self, arg_value);
 		return -1;
 	case ACTION_CONTINUE:
 		/* Takes no argument */
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index 160491f5de91c..f7ff548f7fba7 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -13,8 +13,18 @@
 #define MAX_NICE		20
 #define MIN_NICE		-19
 
-#define container_of(ptr, type, member)({			\
-	const typeof(((type *)0)->member) *__mptr = (ptr);	\
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
+#endif
+
+/* Calculate string length at compile time (excluding null terminator) */
+#define STRING_LENGTH(s) (ARRAY_SIZE(s) - sizeof(*(s)))
+
+/* Compare string with static string, length determined at compile time */
+#define strncmp_static(s1, s2) strncmp(s1, s2, STRING_LENGTH(s2))
+
+#define container_of(ptr, type, member)({				\
+	const typeof(((type *)0)->member) *__mptr = (ptr);		\
 	(type *)((char *)__mptr - offsetof(type, member)) ; })
 
 extern int config_debug;
-- 
2.51.1


