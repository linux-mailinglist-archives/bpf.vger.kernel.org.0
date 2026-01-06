Return-Path: <bpf+bounces-77945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BF4CF89D9
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 14:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B8E2307268D
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 13:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3B133C521;
	Tue,  6 Jan 2026 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Liije0JN"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7277833C52E
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767706866; cv=none; b=QYkXJ4/IEMzgyGgl8qhacvGMHzECvNvnxpCG/Zk4gFBGgbH2YQ4RT29e5eUGXeR8zRWju6ItyRTR1ShKLzDE+S871sczq319Cz4bgLwqj6pyXFdOFs3kfSGhEqZXW96Ctly6bP539x37wudHLLHlGuow1KoByL2Hvnz4wpB7Q1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767706866; c=relaxed/simple;
	bh=ijhR3i1gavKundTTF+SyXMl11p58jCX5UvqYieE4d9g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4VqDM5dfLE6FbaWT8/GUPF+UdRwsJnzEmVTBcpXfHKAvutG2lmNxaHYW7cK4ml9qh9PxRS0PrOcvKc3u2kmBAESPBtd/8tblBrH4uYeWAuHLPYt6apGFgH7NKhkGsW//IEmDac4GP5NSJyjtmlORN08oOa/7rJzywBEV8FTrQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Liije0JN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767706863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WL7clRY6ZrnFyBLMlVvLXH34kZISJ+Yx3LR2pif4tUA=;
	b=Liije0JNSDBkbyciEinZ0eDS9rod8ekwDyg9Iz98C7kRm5xRPk9HTUsYD6yXgZYu3QFRs+
	N3hELedazT23yJX/tAOKrHTJlZDoP+8Jhs84oZUZNOsXRRZrLs3ld5Q5Z58kcpvt1a+4Vv
	gYSzYrLQS+O6GIcRusPPmDaOetDDdX8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-bOnU7qCXNTu2bRFet3SiNw-1; Tue,
 06 Jan 2026 08:41:01 -0500
X-MC-Unique: bOnU7qCXNTu2bRFet3SiNw-1
X-Mimecast-MFC-AGG-ID: bOnU7qCXNTu2bRFet3SiNw_1767706859
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2B991800358;
	Tue,  6 Jan 2026 13:40:59 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.89.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E05D1800367;
	Tue,  6 Jan 2026 13:40:55 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v2 05/18] rtla: Simplify argument parsing
Date: Tue,  6 Jan 2026 08:49:41 -0300
Message-ID: <20260106133655.249887-6-wander@redhat.com>
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
 tools/tracing/rtla/src/actions.c | 57 +++++++++++++++++++++++---------
 tools/tracing/rtla/src/utils.h   | 14 ++++++--
 2 files changed, 54 insertions(+), 17 deletions(-)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index e933c2c68b208..b50bf9f9adf28 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -113,6 +113,29 @@ actions_add_continue(struct actions *self)
 	action->type = ACTION_CONTINUE;
 }
 
+static inline const char *__extract_arg(const char *token, const char *opt, size_t opt_len)
+{
+	const size_t tok_len = strlen(token);
+
+	if (tok_len <= opt_len)
+		return NULL;
+
+	if (strncmp(token, opt, opt_len))
+		return NULL;
+
+	return token + opt_len;
+}
+
+/*
+ * extract_arg - extract argument value from option token
+ * @token: option token (e.g., "file=trace.txt")
+ * @opt: option name to match (e.g., "file")
+ *
+ * Returns pointer to argument value after "=" if token matches "opt=",
+ * otherwise returns NULL.
+ */
+#define extract_arg(token, opt) __extract_arg(token, opt "=", STRING_LENGTH(opt "="))
+
 /*
  * actions_parse - add an action based on text specification
  */
@@ -122,6 +145,7 @@ actions_parse(struct actions *self, const char *trigger, const char *tracefn)
 	enum action_type type = ACTION_NONE;
 	const char *token;
 	char trigger_c[strlen(trigger) + 1];
+	const char *arg_value;
 
 	/* For ACTION_SIGNAL */
 	int signal = 0, pid = 0;
@@ -152,12 +176,10 @@ actions_parse(struct actions *self, const char *trigger, const char *tracefn)
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
@@ -169,17 +191,21 @@ actions_parse(struct actions *self, const char *trigger, const char *tracefn)
 	case ACTION_SIGNAL:
 		/* Takes two arguments, num (signal) and pid */
 		while (token != NULL) {
-			if (strlen(token) > 4 && strncmp(token, "num=", 4) == 0) {
-				if (strtoi(token + 4, &signal))
-					return -1;
-			} else if (strlen(token) > 4 && strncmp(token, "pid=", 4) == 0) {
-				if (strncmp(token + 4, "parent", 7) == 0)
-					pid = -1;
-				else if (strtoi(token + 4, &pid))
+			arg_value = extract_arg(token, "num");
+			if (arg_value) {
+				if (strtoi(arg_value, &signal))
 					return -1;
 			} else {
-				/* Invalid argument */
-				return -1;
+				arg_value = extract_arg(token, "pid");
+				if (arg_value) {
+					if (strncmp_static(arg_value, "parent") == 0)
+						pid = -1;
+					else if (strtoi(arg_value, &pid))
+						return -1;
+				} else {
+					/* Invalid argument */
+					return -1;
+				}
 			}
 
 			token = strtok(NULL, ",");
@@ -194,9 +220,10 @@ actions_parse(struct actions *self, const char *trigger, const char *tracefn)
 	case ACTION_SHELL:
 		if (token == NULL)
 			return -1;
-		if (strlen(token) > 8 && strncmp(token, "command=", 8))
+		arg_value = extract_arg(token, "command");
+		if (!arg_value)
 			return -1;
-		actions_add_shell(self, token + 8);
+		actions_add_shell(self, arg_value);
 		break;
 	case ACTION_CONTINUE:
 		/* Takes no argument */
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index efbf798650306..7fa3ac5e0bfb6 100644
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
+	const typeof(((type *)0)->member) * __mptr = (ptr);		\
 	(type *)((char *)__mptr - offsetof(type, member)) ; })
 
 extern int config_debug;
-- 
2.52.0


