Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28EFFA8D14
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2019 21:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731596AbfIDQZP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Sep 2019 12:25:15 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:55731 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729890AbfIDQZP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Sep 2019 12:25:15 -0400
Received: by mail-pf1-f202.google.com with SMTP id 22so17017602pfn.22
        for <bpf@vger.kernel.org>; Wed, 04 Sep 2019 09:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xm+DwCqYDVAFmaexnNhGuLCoMRRBGDfERnWY7ta2Hdk=;
        b=qIFFUO7lvGutBargKk7Xcxx3BoR8Pfm05++O2UwwKxJMkCFxZVlCSXIBGvEbqXeq5k
         DHFJJuYvF8qrt2moOIjXLC8iXtL3CggpRBCqo6vFycF/lj7JexpyP6CJb15IAIG9Tyhx
         zHF6ewvmA9Z8qjKcZLNTuRPsHiy7xDWotfHw/PLjsQyn9fcMXHLWg05WBlUNKWWMhXK8
         JTjRlePTwMCV8aOB5B1G0auSz1W/IvsE0m2fNoJgZxLv8xYad/VVVfQh4sU+NClC5zd/
         aLlO45vVtky7b/A0nr6br9d0NxfUj18dv+rkIFNmFMpwc0aaCCJR5f1FOJD8ZTw7mm1I
         39yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xm+DwCqYDVAFmaexnNhGuLCoMRRBGDfERnWY7ta2Hdk=;
        b=PjbNkQucENDVc4O0d+jugwAKSiOdiRJpfqHhU3uuZD7uxIhQUfR8mLGaq55k1kQo+B
         kZ8+6bfhL5sWAs9ItP+29eQE2yetGg5+GcLu591uJkZwwfB9ipcpca7mvAudYNgG1UfE
         9gRTaKsjH4SXAScAlrdCxPeHxZ1bgWvykERnOWRiuJXalbKulB7rTz2SKxABOuM1I0RF
         n3SD9k8JdE0r6erjRzTCQPftE74S6K3ODAaACyhErHe8n+V7F22MA11SknIwmOiKD2Y9
         IJcyfG/33QtkQLZrYg1KuhYaxR9I3g1nza6i07Y26782RBnWw3+okLrcE/guWsuih/z8
         2ctA==
X-Gm-Message-State: APjAAAUqQa7K1Tc5evN9kAhn7xkhZRkNh/uj5n71/JmZLy40Lssk34/B
        dHN06jYgmBiyR/glrmwVTU4EV/Y=
X-Google-Smtp-Source: APXvYqwH6yZwWfi/HOWYONAM+EcY2tZxUzx37/yso/6Ja6Rv1ZHWLPh9e1t59+HMCPVy6bi6benZyyM=
X-Received: by 2002:a63:5648:: with SMTP id g8mr35089345pgm.81.1567614314079;
 Wed, 04 Sep 2019 09:25:14 -0700 (PDT)
Date:   Wed,  4 Sep 2019 09:25:04 -0700
In-Reply-To: <20190904162509.199561-1-sdf@google.com>
Message-Id: <20190904162509.199561-2-sdf@google.com>
Mime-Version: 1.0
References: <20190904162509.199561-1-sdf@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH bpf-next 1/6] selftests/bpf: test_progs: add test__join_cgroup helper
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

test__join_cgroup() combines the following operations that usually
go hand in hand and returns cgroup fd:

  * setup cgroup environment (make sure cgroupfs is mounted)
  * mkdir cgroup
  * join cgroup

It also marks a test as a "cgroup cleanup needed" and removes cgroup
state after the test is done.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/Makefile     |  4 +--
 tools/testing/selftests/bpf/test_progs.c | 38 ++++++++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h |  1 +
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index c7595b4ed55d..e145954d3765 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -102,7 +102,7 @@ $(OUTPUT)/test_socket_cookie: cgroup_helpers.c
 $(OUTPUT)/test_sockmap: cgroup_helpers.c
 $(OUTPUT)/test_tcpbpf_user: cgroup_helpers.c
 $(OUTPUT)/test_tcpnotify_user: cgroup_helpers.c trace_helpers.c
-$(OUTPUT)/test_progs: trace_helpers.c
+$(OUTPUT)/test_progs: cgroup_helpers.c trace_helpers.c
 $(OUTPUT)/get_cgroup_id_user: cgroup_helpers.c
 $(OUTPUT)/test_cgroup_storage: cgroup_helpers.c
 $(OUTPUT)/test_netcnt: cgroup_helpers.c
@@ -196,7 +196,7 @@ $(ALU32_BUILD_DIR)/test_progs_32: test_progs.c $(OUTPUT)/libbpf.a\
 						| $(ALU32_BUILD_DIR)
 	$(CC) $(TEST_PROGS_CFLAGS) $(CFLAGS) \
 		-o $(ALU32_BUILD_DIR)/test_progs_32 \
-		test_progs.c test_stub.c trace_helpers.c prog_tests/*.c \
+		test_progs.c test_stub.c cgroup_helpers.c trace_helpers.c prog_tests/*.c \
 		$(OUTPUT)/libbpf.a $(LDLIBS)
 
 $(ALU32_BUILD_DIR)/test_progs_32: $(PROG_TESTS_H)
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index e8616e778cb5..af75a1c7a458 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2017 Facebook
  */
 #include "test_progs.h"
+#include "cgroup_helpers.h"
 #include "bpf_rlimit.h"
 #include <argp.h>
 #include <string.h>
@@ -17,6 +18,7 @@ struct prog_test_def {
 	int error_cnt;
 	int skip_cnt;
 	bool tested;
+	bool need_cgroup_cleanup;
 
 	const char *subtest_name;
 	int subtest_num;
@@ -122,6 +124,39 @@ void test__fail(void)
 	env.test->error_cnt++;
 }
 
+int test__join_cgroup(const char *path)
+{
+	int fd;
+
+	if (!env.test->need_cgroup_cleanup) {
+		if (setup_cgroup_environment()) {
+			fprintf(stderr,
+				"#%d %s: Failed to setup cgroup environment\n",
+				env.test->test_num, env.test->test_name);
+			return -1;
+		}
+
+		env.test->need_cgroup_cleanup = true;
+	}
+
+	fd = create_and_get_cgroup(path);
+	if (fd < 0) {
+		fprintf(stderr,
+			"#%d %s: Failed to create cgroup '%s' (errno=%d)\n",
+			env.test->test_num, env.test->test_name, path, errno);
+		return fd;
+	}
+
+	if (join_cgroup(path)) {
+		fprintf(stderr,
+			"#%d %s: Failed to join cgroup '%s' (errno=%d)\n",
+			env.test->test_num, env.test->test_name, path, errno);
+		return -1;
+	}
+
+	return fd;
+}
+
 struct ipv4_packet pkt_v4 = {
 	.eth.h_proto = __bpf_constant_htons(ETH_P_IP),
 	.iph.ihl = 5,
@@ -530,6 +565,9 @@ int main(int argc, char **argv)
 		fprintf(env.stdout, "#%d %s:%s\n",
 			test->test_num, test->test_name,
 			test->error_cnt ? "FAIL" : "OK");
+
+		if (test->need_cgroup_cleanup)
+			cleanup_cgroup_environment();
 	}
 	stdio_restore();
 	printf("Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index c8edb9464ba6..e518bd5da3e2 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -71,6 +71,7 @@ extern void test__force_log();
 extern bool test__start_subtest(const char *name);
 extern void test__skip(void);
 extern void test__fail(void);
+extern int test__join_cgroup(const char *path);
 
 #define MAGIC_BYTES 123
 
-- 
2.23.0.187.g17f5b7556c-goog

