Return-Path: <bpf+bounces-74781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 186C9C65D55
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 19:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F0A035E90D
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 18:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A73D33E36B;
	Mon, 17 Nov 2025 18:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5tU/p73"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12A232E748
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 18:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405708; cv=none; b=cFMPz9+K+jifynL3qSDJzE3XgD2LA6I+81mky9e1bLVjl4zH/YsPZCOPjQobJTjhFuSnaghiPOHw2a3KiW4pI7xmNtkGo/qZ8jvbKqxINxF0QgaJ17xiFF4cW4S38tlKJe6BOHmakm/cY+TYIfyz4CGtvZ5L5AU+LATEXI6KEbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405708; c=relaxed/simple;
	bh=5RJNINwKOegC+TYpBlH+UqIoj0Tco8gREjTvbLletXM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJ8pj/BpMoSE6EFay3cfUbBHS4P3TmxCjpaif+CiBWN1ZEKQMSbMau95hCa9wLeTh5ZJu6AcoTexuj6dir+jVlpeoTKWfpXFX9afi4Z/aXon7I5E9I+HDEkJixrZm9OIiOsUuNvL4dxqUyz3554jroIMgiIoE6oH0piwvvjzBRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I5tU/p73; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763405705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tw35bMbNHdoPeMQhssL+Q3vPkPpSkCeP8NPmrUEswf4=;
	b=I5tU/p73uK/GRn/zA0td2qc+ljZU6zLjA1MlEjVQpElz5nFMpYNXcihAfBHqoCmqptB92A
	KVGDQCrTpZ3R8hw9BKfhwz0YWwVOLQ7eSu7/BiDynaSQhgcUa9rEAbRNK59mZ7cFAoawDF
	D9soGao9DQwtpIwhvPGDJugSeOFaP2I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-IrTOle35N5mH1AHUXqKtyA-1; Mon,
 17 Nov 2025 13:55:02 -0500
X-MC-Unique: IrTOle35N5mH1AHUXqKtyA-1
X-Mimecast-MFC-AGG-ID: IrTOle35N5mH1AHUXqKtyA_1763405701
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C4BE1800EF6;
	Mon, 17 Nov 2025 18:55:01 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.81.153])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 19F0F180049F;
	Mon, 17 Nov 2025 18:54:55 +0000 (UTC)
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
Subject: [rtla 04/13] rtla: Replace atoi() with a robust strtoi()
Date: Mon, 17 Nov 2025 15:41:11 -0300
Message-ID: <20251117184409.42831-5-wander@redhat.com>
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

The atoi() function does not perform error checking, which can lead to
undefined behavior when parsing invalid or out-of-range strings. This
can cause issues when parsing user-provided numerical inputs, such as
signal numbers, PIDs, or CPU lists.

To address this, introduce a new strtoi() helper function that safely
converts a string to an integer. This function validates the input and
checks for overflows, returning a boolean to indicate success or failure.

Replace all calls to atoi() with the new strtoi() function and add
proper error handling to make the parsing more robust and prevent
potential issues.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/actions.c |  6 +++--
 tools/tracing/rtla/src/utils.c   | 40 ++++++++++++++++++++++++++++----
 tools/tracing/rtla/src/utils.h   |  2 ++
 3 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index efa17290926da..e23d4f1c5a592 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -199,12 +199,14 @@ actions_parse(struct actions *self, const char *trigger, const char *tracefn)
 		/* Takes two arguments, num (signal) and pid */
 		while (token != NULL) {
 			if (strlen(token) > 4 && strncmp(token, "num=", 4) == 0) {
-				signal = atoi(token + 4);
+				if(!strtoi(token + 4, &signal))
+					return -1;
 			} else if (strlen(token) > 4 && strncmp(token, "pid=", 4) == 0) {
 				if (strncmp(token + 4, "parent", 7) == 0)
 					pid = -1;
 				else
-					pid = atoi(token + 4);
+					if (!strtoi(token + 4, &pid))
+						return -1;
 			} else {
 				/* Invalid argument */
 				return -1;
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index d6ab15dcb4907..4cb765b94feec 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -17,6 +17,7 @@
 #include <fcntl.h>
 #include <sched.h>
 #include <stdio.h>
+#include <limits.h>
 
 #include "utils.h"
 
@@ -112,16 +113,18 @@ int parse_cpu_set(char *cpu_list, cpu_set_t *set)
 	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 	for (p = cpu_list; *p; ) {
-		cpu = atoi(p);
-		if (cpu < 0 || (!cpu && *p != '0') || cpu >= nr_cpus)
+		if (!strtoi(p, &cpu))
+			goto err;
+		if (cpu < 0 || cpu >= nr_cpus)
 			goto err;
 
 		while (isdigit(*p))
 			p++;
 		if (*p == '-') {
 			p++;
-			end_cpu = atoi(p);
-			if (end_cpu < cpu || (!end_cpu && *p != '0') || end_cpu >= nr_cpus)
+			if (!strtoi(p, &end_cpu))
+				goto err;
+			if (end_cpu < cpu || end_cpu >= nr_cpus)
 				goto err;
 			while (isdigit(*p))
 				p++;
@@ -322,6 +325,7 @@ int set_comm_sched_attr(const char *comm_prefix, struct sched_attr *attr)
 	struct dirent *proc_entry;
 	DIR *procfs;
 	int retval;
+	int pid;
 
 	if (strlen(comm_prefix) >= MAX_PATH) {
 		err_msg("Command prefix is too long: %d < strlen(%s)\n",
@@ -341,8 +345,12 @@ int set_comm_sched_attr(const char *comm_prefix, struct sched_attr *attr)
 		if (!retval)
 			continue;
 
+		if (!strtoi(proc_entry->d_name, &pid)) {
+			err_msg("'%s' is not a valid pid", proc_entry->d_name);
+			goto out_err;
+		}
 		/* procfs_is_workload_pid confirmed it is a pid */
-		retval = __set_sched_attr(atoi(proc_entry->d_name), attr);
+		retval = __set_sched_attr(pid, attr);
 		if (retval) {
 			err_msg("Error setting sched attributes for pid:%s\n", proc_entry->d_name);
 			goto out_err;
@@ -959,3 +967,25 @@ int auto_house_keeping(cpu_set_t *monitored_cpus)
 
 	return 1;
 }
+
+/*
+ * strtoi - convert string to integer with error checking
+ *
+ * Returns true on success, false if conversion fails or result is out of int range.
+ */
+bool strtoi(const char *s, int *res)
+{
+	char *end_ptr;
+	long lres;
+
+	if (!*s)
+		return false;
+
+	errno = 0;
+	lres = strtol(s, &end_ptr, 0);
+	if (errno || *end_ptr || lres > INT_MAX || lres < INT_MIN)
+		return false;
+
+	*res = (int) lres;
+	return true;
+}
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index a2a6f89f342d0..160491f5de91c 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -3,6 +3,7 @@
 #include <stdint.h>
 #include <time.h>
 #include <sched.h>
+#include <stdbool.h>
 
 /*
  * '18446744073709551615\0'
@@ -80,6 +81,7 @@ static inline int set_deepest_cpu_idle_state(unsigned int cpu, unsigned int stat
 static inline int have_libcpupower_support(void) { return 0; }
 #endif /* HAVE_LIBCPUPOWER_SUPPORT */
 int auto_house_keeping(cpu_set_t *monitored_cpus);
+bool strtoi(const char *s, int *res);
 
 #define ns_to_usf(x) (((double)x/1000))
 #define ns_to_per(total, part) ((part * 100) / (double)total)
-- 
2.51.1


