Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B294EAA744
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2019 17:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390408AbfIEP1P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Sep 2019 11:27:15 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:56098 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731588AbfIEP1P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Sep 2019 11:27:15 -0400
Received: by mail-vk1-f201.google.com with SMTP id q190so1067397vkf.22
        for <bpf@vger.kernel.org>; Thu, 05 Sep 2019 08:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xm+DwCqYDVAFmaexnNhGuLCoMRRBGDfERnWY7ta2Hdk=;
        b=Oi+zYOA7np20AWHEV7W6CBSlZhDDh49nfoQtkE9wtbXtkp837VRUzh3g2FoHf6dwpW
         i3paWJpapHte9YuLIPuraeJj4annAFgvba1OBwXrpGT0NNK26kQwPMkeZmVSfqgitw9f
         4HcoOrTb4rc77wRkQeegEauqlTJCuo4Q/+EUdgQqWU9543rGPg41YnMxKdAswzvn+U/J
         yLZBHasiGSVRKJBg09U3I3+cOjB6cx6Y7j845e+qTcWBa7khchITvnOx9Coe64aNcWbI
         PTIvchHOojIM/EKqJFiALdYX8MAE1MJbCvN5vQuTlL7eyolO9O8xC+0s4l7/C1NJHPlC
         IROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xm+DwCqYDVAFmaexnNhGuLCoMRRBGDfERnWY7ta2Hdk=;
        b=GXqdtc2j3ZgG2Hq2CZnK05t/uYBH1Z+QuTyWwZYzco5VFDuOCJ+qirjD/771FR+Bby
         1pwDJxR2P/5jyV4h4/yDCB7a65EHfOKBpxUD820u5M8rYywpu9UtiYWB75mx2hXgKmsD
         +pXpb20eAD/c//VDVQU07PN5FrEM9rjuJDwyEY4OdCWZB8BzezyrJszmNXTux0vLWeXb
         EdjVbq+EGN4QWObTyLWwTtv1IhDMUtiAOARTIRZrhMccfmtFIj7Pvi5J4Fm1PIV6Icvm
         URoVmz5lAivXHFUA888VcDqL6OsFo6V5GbpJZbhAknhtCcFnKxt6i+3vIFuy3FHuEKOv
         WY8Q==
X-Gm-Message-State: APjAAAXkB2mNHZzu+bC59GNaTa/YOl3HCBTCuNoqq0T5S1vku7Y0cY4X
        AlbkYWUcl81m++MMqnWvw1iOfAE=
X-Google-Smtp-Source: APXvYqxAC0fXvQlk4s2nrhMYwyk9+AD5ntCoT63A8DQ7mpaoeDu5yiJbZT9hCeCYSuOs8+sm9Nzl3Hk=
X-Received: by 2002:ab0:49c6:: with SMTP id f6mr1812653uad.3.1567697233912;
 Thu, 05 Sep 2019 08:27:13 -0700 (PDT)
Date:   Thu,  5 Sep 2019 08:27:04 -0700
In-Reply-To: <20190905152709.111193-1-sdf@google.com>
Message-Id: <20190905152709.111193-2-sdf@google.com>
Mime-Version: 1.0
References: <20190905152709.111193-1-sdf@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH bpf-next v2 1/6] selftests/bpf: test_progs: add
 test__join_cgroup helper
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

