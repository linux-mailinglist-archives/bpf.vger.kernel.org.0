Return-Path: <bpf+bounces-77944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 757E5CF8975
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 14:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D4AE30376BF
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 13:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A283358A8;
	Tue,  6 Jan 2026 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EwcDltG4"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6066233509C
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767706829; cv=none; b=W5gj9YAwTHCCRe/M5dnnF0bbyQJi+niK9VUmfQPAKYqh4EO6ICTbsR6pZeS0dXsBYo7KFuQNvvhm1aY7YHd47IoGHkoYe9jtkKqXIykdEf7VLeWlEFCxYhihSwGjMWr/S+uACQMEdd7RRPAiIRauy9CiePjSXp6XjRFnHg0s68U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767706829; c=relaxed/simple;
	bh=C9pPSqrNCCRKwBOuAOsgJ4xElCRCsaFzDGm/+khZD3Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEyNmw79zHB1ZMVXoXVNcDQtRiGBrhEGJVYwXbGzqYnUkvMVofX8aQtNQCkBmkoCOVm+OeiwymbQdYfYkpyV4AfZKFQNKjAHyqH2b5YeKxJIFGRnmscJdWR6rmJ5tGTSUmi3Cl6f3x+tHeErUsfhL7C6a82oetyZKlJ0rKjcvkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EwcDltG4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767706826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nmP8xBHdWYkSAZWCXGpMjJAhpv6Mw36u53Y1D1y92fw=;
	b=EwcDltG4rKfg22A/u7wAB00MXEoctQ8C8HWcEYjyg3xZnqcOquTH4hrEw6Qnt63DXcVEPV
	pBphdHNfdRwZWnnv6GtOAPNGmTe9JPIkqxB4vwG2hGh+3AOLJ057Zh2KlsD+X0VyZNSAUd
	7fRPnGERafw8VcKJ7srKpDV5PYWR/m8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-aG-OJuyVMCKFReBgsuGUQQ-1; Tue,
 06 Jan 2026 08:40:22 -0500
X-MC-Unique: aG-OJuyVMCKFReBgsuGUQQ-1
X-Mimecast-MFC-AGG-ID: aG-OJuyVMCKFReBgsuGUQQ_1767706821
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B29231956095;
	Tue,  6 Jan 2026 13:40:21 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.89.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CCA2F180066B;
	Tue,  6 Jan 2026 13:40:15 +0000 (UTC)
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
Subject: [PATCH v2 04/18] rtla: Replace atoi() with a robust strtoi()
Date: Tue,  6 Jan 2026 08:49:40 -0300
Message-ID: <20260106133655.249887-5-wander@redhat.com>
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

The atoi() function does not perform error checking, which can lead to
undefined behavior when parsing invalid or out-of-range strings. This
can cause issues when parsing user-provided numerical inputs, such as
signal numbers, PIDs, or CPU lists.

To address this, introduce a new strtoi() helper function that safely
converts a string to an integer. This function validates the input and
checks for overflows, returning a negative value on  failure.

Replace all calls to atoi() with the new strtoi() function and add
proper error handling to make the parsing more robust and prevent
potential issues.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/actions.c |  7 +++---
 tools/tracing/rtla/src/utils.c   | 40 ++++++++++++++++++++++++++++----
 tools/tracing/rtla/src/utils.h   |  2 ++
 3 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index a4d0dc47e6aa1..e933c2c68b208 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -170,12 +170,13 @@ actions_parse(struct actions *self, const char *trigger, const char *tracefn)
 		/* Takes two arguments, num (signal) and pid */
 		while (token != NULL) {
 			if (strlen(token) > 4 && strncmp(token, "num=", 4) == 0) {
-				signal = atoi(token + 4);
+				if (strtoi(token + 4, &signal))
+					return -1;
 			} else if (strlen(token) > 4 && strncmp(token, "pid=", 4) == 0) {
 				if (strncmp(token + 4, "parent", 7) == 0)
 					pid = -1;
-				else
-					pid = atoi(token + 4);
+				else if (strtoi(token + 4, &pid))
+					return -1;
 			} else {
 				/* Invalid argument */
 				return -1;
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index acf95afa25b5a..f3e129d17a82b 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -17,6 +17,7 @@
 #include <fcntl.h>
 #include <sched.h>
 #include <stdio.h>
+#include <limits.h>
 
 #include "utils.h"
 
@@ -127,16 +128,18 @@ int parse_cpu_set(char *cpu_list, cpu_set_t *set)
 	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 	for (p = cpu_list; *p; ) {
-		cpu = atoi(p);
-		if (cpu < 0 || (!cpu && *p != '0') || cpu >= nr_cpus)
+		if (strtoi(p, &cpu))
+			goto err;
+		if (cpu < 0 || cpu >= nr_cpus)
 			goto err;
 
 		while (isdigit(*p))
 			p++;
 		if (*p == '-') {
 			p++;
-			end_cpu = atoi(p);
-			if (end_cpu < cpu || (!end_cpu && *p != '0') || end_cpu >= nr_cpus)
+			if (strtoi(p, &end_cpu))
+				goto err;
+			if (end_cpu < cpu || end_cpu >= nr_cpus)
 				goto err;
 			while (isdigit(*p))
 				p++;
@@ -337,6 +340,7 @@ int set_comm_sched_attr(const char *comm_prefix, struct sched_attr *attr)
 	struct dirent *proc_entry;
 	DIR *procfs;
 	int retval;
+	int pid;
 
 	if (strlen(comm_prefix) >= MAX_PATH) {
 		err_msg("Command prefix is too long: %d < strlen(%s)\n",
@@ -356,8 +360,12 @@ int set_comm_sched_attr(const char *comm_prefix, struct sched_attr *attr)
 		if (!retval)
 			continue;
 
+		if (strtoi(proc_entry->d_name, &pid)) {
+			err_msg("'%s' is not a valid pid", proc_entry->d_name);
+			goto out_err;
+		}
 		/* procfs_is_workload_pid confirmed it is a pid */
-		retval = __set_sched_attr(atoi(proc_entry->d_name), attr);
+		retval = __set_sched_attr(pid, attr);
 		if (retval) {
 			err_msg("Error setting sched attributes for pid:%s\n", proc_entry->d_name);
 			goto out_err;
@@ -1035,3 +1043,25 @@ char *strdup_fatal(const char *s)
 
 	return p;
 }
+
+/*
+ * strtoi - convert string to integer with error checking
+ *
+ * Returns 0 on success, -1 if conversion fails or result is out of int range.
+ */
+int strtoi(const char *s, int *res)
+{
+	char *end_ptr;
+	long lres;
+
+	if (!*s)
+		return -1;
+
+	errno = 0;
+	lres = strtol(s, &end_ptr, 0);
+	if (errno || *end_ptr || lres > INT_MAX || lres < INT_MIN)
+		return -1;
+
+	*res = (int) lres;
+	return 0;
+}
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index 0ed2c7275f2c5..efbf798650306 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -3,6 +3,7 @@
 #include <stdint.h>
 #include <time.h>
 #include <sched.h>
+#include <stdbool.h>
 
 /*
  * '18446744073709551615\0'
@@ -85,6 +86,7 @@ static inline int set_deepest_cpu_idle_state(unsigned int cpu, unsigned int stat
 static inline int have_libcpupower_support(void) { return 0; }
 #endif /* HAVE_LIBCPUPOWER_SUPPORT */
 int auto_house_keeping(cpu_set_t *monitored_cpus);
+__attribute__((__warn_unused_result__)) int strtoi(const char *s, int *res);
 
 #define ns_to_usf(x) (((double)x/1000))
 #define ns_to_per(total, part) ((part * 100) / (double)total)
-- 
2.52.0


