Return-Path: <bpf+bounces-26442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4015789F98A
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 16:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31D21F27258
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 14:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534AA160783;
	Wed, 10 Apr 2024 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prR8nXMo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D268915ADB0
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712758202; cv=none; b=F6zBrANd0TbIkCpy3X0vV5eOdFg9FQ9lFSavZqeazUORGgGAJdbrlXwamrJ5UNClK/ze2a1oVVv7HIDDjP3hOUEKVS+m2h6vA0a36fyRaM3isRoYsirrXO0mcxvPgj5JgIa1ptsVyWjqdxWeGkz3y2tqk+tGCy1UUSxGSPgOPZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712758202; c=relaxed/simple;
	bh=1LvYoijyqUoEtjBfvs4wPXhJ/A2MPc278OaIUTAm5ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lX3QbS1YASPHWmGSxHHa4N2A9akcrLA1ipW6DdEQOSIShDbw6tL1z6LlrHqbH/yQRC8PrerbliNupOQi8wF1zxuQruHP6bBH/4TGINY44p2ZxHXg9XkgNvejA+r7ODXtT+QVRGdVAIA/AXcPe2e7QPzqnq6PSaUaeSnSmaE9CmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prR8nXMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3040C433C7;
	Wed, 10 Apr 2024 14:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712758202;
	bh=1LvYoijyqUoEtjBfvs4wPXhJ/A2MPc278OaIUTAm5ZM=;
	h=From:To:Cc:Subject:Date:From;
	b=prR8nXMob/k0p8wSkUU6LsVg0C4iERh6XwKWqQYcbXqmcxMMiVi+G7k/PHAztO6hd
	 IfadtoSKDJoqtm5alkSyX4muhdX4xWznUDfhKeNiIr/9H++0IFnLOWNGwVq1UmcAsT
	 CHS3xT0lRZZbnXOYAYFKuW0WC8JfdOTrXnHVorPipnLyAzbz+KjfvbHWu1eNhhsaYW
	 ys7WnUzGOIJEh2sv1XkNVBsvLQUEjYM3EW95pJCXmFzaR8wBqb8KhL20KERy/usdyT
	 rsUk3dGXOGAq12aA71f+EVJt6doy7EV48zIEn7kHELgbLtur0vuQZ/h49gtOXBueSd
	 +TSjuzrCs0q0A==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCHv2 bpf-next] selftests/bpf: Add read_trace_pipe_iter function
Date: Wed, 10 Apr 2024 16:09:52 +0200
Message-ID: <20240410140952.292261-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have two printk tests reading trace_pipe in non blocking way,
with the very same code. Moving that in new read_trace_pipe_iter
function.

Current read_trace_pipe is used from sampless/bpf and needs to
do blocking read and printf of the trace_pipe data, using new
read_trace_pipe_iter to implement that.

Both printk tests do early checks for the number of found messages
and can bail earlier, but I did not find any speed difference w/o
that condition, so I did not complicate the change more for that.

Some of the samples/bpf programs use read_trace_pipe function,
so I kept that interface untouched. I did not see any issues with
affected samples/bpf programs other than there's slight change in
read_trace_pipe output. The current code uses puts that adds new
line after the printed string, so we would occasionally see extra
new line. With this patch we read output per lines, so there's no
need to use puts and we can use just printf instead without extra
new line.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 v2 changes:
   - call read_trace_pipe_iter callback only in case there's new data
     read from getline

 .../selftests/bpf/prog_tests/trace_printk.c   | 36 +++--------
 .../selftests/bpf/prog_tests/trace_vprintk.c  | 36 +++--------
 tools/testing/selftests/bpf/trace_helpers.c   | 63 ++++++++++++-------
 tools/testing/selftests/bpf/trace_helpers.h   |  2 +
 4 files changed, 60 insertions(+), 77 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/trace_printk.c b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
index 7b9124d506a5..e56e88596d64 100644
--- a/tools/testing/selftests/bpf/prog_tests/trace_printk.c
+++ b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
@@ -5,18 +5,19 @@
 
 #include "trace_printk.lskel.h"
 
-#define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
-#define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
 #define SEARCHMSG	"testing,testing"
 
+static void trace_pipe_cb(const char *str, void *data)
+{
+	if (strstr(str, SEARCHMSG) != NULL)
+		(*(int *)data)++;
+}
+
 void serial_test_trace_printk(void)
 {
 	struct trace_printk_lskel__bss *bss;
-	int err = 0, iter = 0, found = 0;
 	struct trace_printk_lskel *skel;
-	char *buf = NULL;
-	FILE *fp = NULL;
-	size_t buflen;
+	int err = 0, found = 0;
 
 	skel = trace_printk_lskel__open();
 	if (!ASSERT_OK_PTR(skel, "trace_printk__open"))
@@ -35,16 +36,6 @@ void serial_test_trace_printk(void)
 	if (!ASSERT_OK(err, "trace_printk__attach"))
 		goto cleanup;
 
-	if (access(TRACEFS_PIPE, F_OK) == 0)
-		fp = fopen(TRACEFS_PIPE, "r");
-	else
-		fp = fopen(DEBUGFS_PIPE, "r");
-	if (!ASSERT_OK_PTR(fp, "fopen(TRACE_PIPE)"))
-		goto cleanup;
-
-	/* We do not want to wait forever if this test fails... */
-	fcntl(fileno(fp), F_SETFL, O_NONBLOCK);
-
 	/* wait for tracepoint to trigger */
 	usleep(1);
 	trace_printk_lskel__detach(skel);
@@ -56,21 +47,12 @@ void serial_test_trace_printk(void)
 		goto cleanup;
 
 	/* verify our search string is in the trace buffer */
-	while (getline(&buf, &buflen, fp) >= 0 || errno == EAGAIN) {
-		if (strstr(buf, SEARCHMSG) != NULL)
-			found++;
-		if (found == bss->trace_printk_ran)
-			break;
-		if (++iter > 1000)
-			break;
-	}
+	ASSERT_OK(read_trace_pipe_iter(trace_pipe_cb, &found, 1000),
+		 "read_trace_pipe_iter");
 
 	if (!ASSERT_EQ(found, bss->trace_printk_ran, "found"))
 		goto cleanup;
 
 cleanup:
 	trace_printk_lskel__destroy(skel);
-	free(buf);
-	if (fp)
-		fclose(fp);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/trace_vprintk.c b/tools/testing/selftests/bpf/prog_tests/trace_vprintk.c
index 44ea2fd88f4c..2af6a6f2096a 100644
--- a/tools/testing/selftests/bpf/prog_tests/trace_vprintk.c
+++ b/tools/testing/selftests/bpf/prog_tests/trace_vprintk.c
@@ -5,18 +5,19 @@
 
 #include "trace_vprintk.lskel.h"
 
-#define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
-#define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
 #define SEARCHMSG	"1,2,3,4,5,6,7,8,9,10"
 
+static void trace_pipe_cb(const char *str, void *data)
+{
+	if (strstr(str, SEARCHMSG) != NULL)
+		(*(int *)data)++;
+}
+
 void serial_test_trace_vprintk(void)
 {
 	struct trace_vprintk_lskel__bss *bss;
-	int err = 0, iter = 0, found = 0;
 	struct trace_vprintk_lskel *skel;
-	char *buf = NULL;
-	FILE *fp = NULL;
-	size_t buflen;
+	int err = 0, found = 0;
 
 	skel = trace_vprintk_lskel__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "trace_vprintk__open_and_load"))
@@ -28,16 +29,6 @@ void serial_test_trace_vprintk(void)
 	if (!ASSERT_OK(err, "trace_vprintk__attach"))
 		goto cleanup;
 
-	if (access(TRACEFS_PIPE, F_OK) == 0)
-		fp = fopen(TRACEFS_PIPE, "r");
-	else
-		fp = fopen(DEBUGFS_PIPE, "r");
-	if (!ASSERT_OK_PTR(fp, "fopen(TRACE_PIPE)"))
-		goto cleanup;
-
-	/* We do not want to wait forever if this test fails... */
-	fcntl(fileno(fp), F_SETFL, O_NONBLOCK);
-
 	/* wait for tracepoint to trigger */
 	usleep(1);
 	trace_vprintk_lskel__detach(skel);
@@ -49,14 +40,8 @@ void serial_test_trace_vprintk(void)
 		goto cleanup;
 
 	/* verify our search string is in the trace buffer */
-	while (getline(&buf, &buflen, fp) >= 0 || errno == EAGAIN) {
-		if (strstr(buf, SEARCHMSG) != NULL)
-			found++;
-		if (found == bss->trace_vprintk_ran)
-			break;
-		if (++iter > 1000)
-			break;
-	}
+	ASSERT_OK(read_trace_pipe_iter(trace_pipe_cb, &found, 1000),
+		 "read_trace_pipe_iter");
 
 	if (!ASSERT_EQ(found, bss->trace_vprintk_ran, "found"))
 		goto cleanup;
@@ -66,7 +51,4 @@ void serial_test_trace_vprintk(void)
 
 cleanup:
 	trace_vprintk_lskel__destroy(skel);
-	free(buf);
-	if (fp)
-		fclose(fp);
 }
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 7f45b4cb41fe..70e29f316fe7 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -233,29 +233,6 @@ int kallsyms_find(const char *sym, unsigned long long *addr)
 	return err;
 }
 
-void read_trace_pipe(void)
-{
-	int trace_fd;
-
-	if (access(TRACEFS_PIPE, F_OK) == 0)
-		trace_fd = open(TRACEFS_PIPE, O_RDONLY, 0);
-	else
-		trace_fd = open(DEBUGFS_PIPE, O_RDONLY, 0);
-	if (trace_fd < 0)
-		return;
-
-	while (1) {
-		static char buf[4096];
-		ssize_t sz;
-
-		sz = read(trace_fd, buf, sizeof(buf) - 1);
-		if (sz > 0) {
-			buf[sz] = 0;
-			puts(buf);
-		}
-	}
-}
-
 ssize_t get_uprobe_offset(const void *addr)
 {
 	size_t start, end, base;
@@ -413,3 +390,43 @@ int read_build_id(const char *path, char *build_id, size_t size)
 	close(fd);
 	return err;
 }
+
+int read_trace_pipe_iter(void (*cb)(const char *str, void *data), void *data, int iter)
+{
+	size_t buflen, n;
+	char *buf = NULL;
+	FILE *fp = NULL;
+
+	if (access(TRACEFS_PIPE, F_OK) == 0)
+		fp = fopen(TRACEFS_PIPE, "r");
+	else
+		fp = fopen(DEBUGFS_PIPE, "r");
+	if (!fp)
+		return -1;
+
+	 /* We do not want to wait forever when iter is specified. */
+	if (iter)
+		fcntl(fileno(fp), F_SETFL, O_NONBLOCK);
+
+	while ((n = getline(&buf, &buflen, fp) >= 0) || errno == EAGAIN) {
+		if (n > 0)
+			cb(buf, data);
+		if (iter && !(--iter))
+			break;
+	}
+
+	free(buf);
+	if (fp)
+		fclose(fp);
+	return 0;
+}
+
+static void trace_pipe_cb(const char *str, void *data)
+{
+	printf("%s", str);
+}
+
+void read_trace_pipe(void)
+{
+	read_trace_pipe_iter(trace_pipe_cb, NULL, 0);
+}
diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
index d1ed71789049..2ce873c9f9aa 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -33,6 +33,8 @@ struct ksym *search_kallsyms_custom_local(struct ksyms *ksyms, const void *p1,
 int kallsyms_find(const char *sym, unsigned long long *addr);
 
 void read_trace_pipe(void);
+int read_trace_pipe_iter(void (*cb)(const char *str, void *data),
+			 void *data, int iter);
 
 ssize_t get_uprobe_offset(const void *addr);
 ssize_t get_rel_offset(uintptr_t addr);
-- 
2.44.0


