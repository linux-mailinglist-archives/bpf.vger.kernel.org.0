Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E92DA8D17
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2019 21:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731615AbfIDQZS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Sep 2019 12:25:18 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:54316 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731595AbfIDQZR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Sep 2019 12:25:17 -0400
Received: by mail-vs1-f73.google.com with SMTP id t25so288030vsq.21
        for <bpf@vger.kernel.org>; Wed, 04 Sep 2019 09:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cy7OIRRKM9Ad0BetjvL+BYcBydjw1ujStZM5vmqq9GE=;
        b=kGbzntrJUaHQJ9rNaUwMOHrgequc9e9r+/T1OP8oPo+hzs8IkQQoaU6PT5OUta324z
         qJr6TWWEfHOWlS0vEM+yfXcSS7NBtfDPjOtjQe+lu5sk2zjzT6VsMY+PRYIAMlhNEmXy
         xrl0Q/O66a5RJo4pU8VkMm5ESShxM2lim4rp/wEAbFxCTnPMfLUkusE/Niv3jADJgNBO
         hmMzSCLZhTGaJATcIS/tblXnIrlTtq3/c7N4W81YuFryiICtUjlyoNPRzfrKLC8k1Ywf
         NxIJjXBq+Eb/nkphFeyRp0K/6rRhuR2OtKPw3RSf/kp9BoaFGupFEdjYHBqvi913NqD1
         JlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cy7OIRRKM9Ad0BetjvL+BYcBydjw1ujStZM5vmqq9GE=;
        b=GpPV+WNDyX8PzfRk8njXZqU+UQPjU9jmAIlgPXkWUvmj9kvmeNgOyoDavUZSPNZJss
         QBtK67VVGDmLjWDWFymJ0jde8Iij8Xyrdg4C9Kgm0VGsaoI5N3dt3j1gJdzNza5MV1Uz
         vkFaUQ0FG14tyq4TnFuGXxSCTaPEDEqfBwUxZtX8T/nn3sRjQR+mn0ZsAyk9VUHCu4Us
         +Hfa2T56pH0PzjpG7+VKl9Dq45so2oX5upiT5ceP5xZE+HlgqBOP9qozKxR7uOS3ejJM
         w+5+SUEvy6R1WhKxlqwvIZ7r/iIoCxxJmhUXEjQubaftESI4R2spLJeREDCLNOFpPHll
         t6wg==
X-Gm-Message-State: APjAAAXgInRQYZhz2tf3phymfmgglZwN68lJJQdKLByrpN6w8/vxm7PJ
        XohXoYCommkaqzM/T+hYgCQoC/U=
X-Google-Smtp-Source: APXvYqxddGIt4YEWHZnlPboPZa6bcFgJlnaBhk7AmbCvMqIYXpWNTbl4iG7PD38uOsYAeIYV+s2Hn3I=
X-Received: by 2002:a67:328f:: with SMTP id y137mr8696374vsy.199.1567614316653;
 Wed, 04 Sep 2019 09:25:16 -0700 (PDT)
Date:   Wed,  4 Sep 2019 09:25:05 -0700
In-Reply-To: <20190904162509.199561-1-sdf@google.com>
Message-Id: <20190904162509.199561-3-sdf@google.com>
Mime-Version: 1.0
References: <20190904162509.199561-1-sdf@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH bpf-next 2/6] selftests/bpf: test_progs: convert test_sockopt
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move the files, adjust includes, remove entry from Makefile & .gitignore

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/.gitignore        |  1 -
 tools/testing/selftests/bpf/Makefile          |  3 +-
 .../{test_sockopt.c => prog_tests/sockopt.c}  | 50 +++----------------
 3 files changed, 8 insertions(+), 46 deletions(-)
 rename tools/testing/selftests/bpf/{test_sockopt.c => prog_tests/sockopt.c} (96%)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 60c9338cd9b4..0315120eac8f 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -39,7 +39,6 @@ libbpf.so.*
 test_hashmap
 test_btf_dump
 xdping
-test_sockopt
 test_sockopt_sk
 test_sockopt_multi
 test_sockopt_inherit
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e145954d3765..08e2183974d5 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -28,7 +28,7 @@ TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test
 	test_sock test_btf test_sockmap get_cgroup_id_user test_socket_cookie \
 	test_cgroup_storage test_select_reuseport test_section_names \
 	test_netcnt test_tcpnotify_user test_sock_fields test_sysctl test_hashmap \
-	test_btf_dump test_cgroup_attach xdping test_sockopt test_sockopt_sk \
+	test_btf_dump test_cgroup_attach xdping test_sockopt_sk \
 	test_sockopt_multi test_sockopt_inherit test_tcp_rtt
 
 BPF_OBJ_FILES = $(patsubst %.c,%.o, $(notdir $(wildcard progs/*.c)))
@@ -109,7 +109,6 @@ $(OUTPUT)/test_netcnt: cgroup_helpers.c
 $(OUTPUT)/test_sock_fields: cgroup_helpers.c
 $(OUTPUT)/test_sysctl: cgroup_helpers.c
 $(OUTPUT)/test_cgroup_attach: cgroup_helpers.c
-$(OUTPUT)/test_sockopt: cgroup_helpers.c
 $(OUTPUT)/test_sockopt_sk: cgroup_helpers.c
 $(OUTPUT)/test_sockopt_multi: cgroup_helpers.c
 $(OUTPUT)/test_sockopt_inherit: cgroup_helpers.c
diff --git a/tools/testing/selftests/bpf/test_sockopt.c b/tools/testing/selftests/bpf/prog_tests/sockopt.c
similarity index 96%
rename from tools/testing/selftests/bpf/test_sockopt.c
rename to tools/testing/selftests/bpf/prog_tests/sockopt.c
index 23bd0819382d..3e8517a8395a 100644
--- a/tools/testing/selftests/bpf/test_sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
@@ -1,22 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#include <errno.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-
-#include <linux/filter.h>
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-
-#include "bpf_rlimit.h"
-#include "bpf_util.h"
+#include <test_progs.h>
 #include "cgroup_helpers.h"
 
-#define CG_PATH				"/sockopt"
-
 static char bpf_log_buf[4096];
 static bool verbose;
 
@@ -983,39 +968,18 @@ static int run_test(int cgroup_fd, struct sockopt_test *test)
 	return ret;
 }
 
-int main(int args, char **argv)
+void test_sockopt(void)
 {
-	int err = EXIT_FAILURE, error_cnt = 0;
 	int cgroup_fd, i;
 
-	if (setup_cgroup_environment())
-		goto cleanup_obj;
-
-	cgroup_fd = create_and_get_cgroup(CG_PATH);
-	if (cgroup_fd < 0)
-		goto cleanup_cgroup_env;
-
-	if (join_cgroup(CG_PATH))
-		goto cleanup_cgroup;
+	cgroup_fd = test__join_cgroup("/sockopt");
+	if (CHECK_FAIL(cgroup_fd < 0))
+		return;
 
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
-		int err = run_test(cgroup_fd, &tests[i]);
-
-		if (err)
-			error_cnt++;
-
-		printf("#%d %s: %s\n", i, err ? "FAIL" : "PASS",
-		       tests[i].descr);
+		test__start_subtest(tests[i].descr);
+		CHECK_FAIL(run_test(cgroup_fd, &tests[i]));
 	}
 
-	printf("Summary: %ld PASSED, %d FAILED\n",
-	       ARRAY_SIZE(tests) - error_cnt, error_cnt);
-	err = error_cnt ? EXIT_FAILURE : EXIT_SUCCESS;
-
-cleanup_cgroup:
 	close(cgroup_fd);
-cleanup_cgroup_env:
-	cleanup_cgroup_environment();
-cleanup_obj:
-	return err;
 }
-- 
2.23.0.187.g17f5b7556c-goog

