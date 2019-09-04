Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3727A8D1A
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2019 21:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731665AbfIDQZW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Sep 2019 12:25:22 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:54751 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731609AbfIDQZW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Sep 2019 12:25:22 -0400
Received: by mail-pf1-f202.google.com with SMTP id s139so9995854pfc.21
        for <bpf@vger.kernel.org>; Wed, 04 Sep 2019 09:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PKBNn7QHICb88J96DR4dcB71cwak21YXIgp4bI9raYQ=;
        b=kp1ziuYLM00emul/vYxvoONHGZq9eJwyLEBYeGpWkcVBSWphwLoM1t3imA/pesfzR0
         Xm+HU+Ap8xYz9SjdVOEXho3PMJT5IYwf0mk984TYznZuNph9+USEqUDUNnZDBmh7PryM
         IDL6Dr5GUGy4L0UvLJo4xYLsfpAY+LTtK9J4FXQMBJWiTcfUzFBwqYH/owvr9DK67JT5
         ULvAxSdjqq7MmlNSnuBf+b49/aceEpCL6/y2mrxc7WDAi0zx8Qk558oLp/zco6NVAhhT
         X1OOj9dgA39TeS776iMrFH6zGDQ77VWTSFeNSyn95jQRwW8mfMQMHTByiMymwDHudhfJ
         RB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PKBNn7QHICb88J96DR4dcB71cwak21YXIgp4bI9raYQ=;
        b=Mnk+J3FF3dBLnERdcDjRBP2uC1mCZ2SqMmnJsEaBK9zhrmtnedeRjZrlzVdzk8YQcA
         o8UGmf5fvgCk5/+/JL4b/6Tvvf/sYPuZ0xJIrxMuFbz6iHealUdi4Z50tjOzhRgSCyf/
         8OwGF5W8khKzwRzX26vJ5dzvqsGmrkQn7J5LBXQDpfdZrpwdtQTYxzd9WIakpiNTVUpZ
         miPq8SodqNOkhzdfl31fbd+czcYx3ka/dtNk2RLyCrrrNH7L/MIHHZldvY2C+6I43+zU
         v8DuAhtQkWRQ0Rtm2b/jQcFP1B6u2i6vqIYAwEsXCzTBnVA3m5ZojOHn4owLN9UOw26D
         ojPw==
X-Gm-Message-State: APjAAAUUcU54mVBWHZo6L8fZvsw2GP68SDRkvcWFomhJjGeCUxKh/l4U
        tezkNzdJ4cE1hCWFP/9XvKB7yD8=
X-Google-Smtp-Source: APXvYqyT1LUBgP9MRRfz5tL5ApXkfhCTmJlsAU5YD18nV6Hcyr14CEch6kn8E7WUZycQ5xWn5HfGyU8=
X-Received: by 2002:a65:49cc:: with SMTP id t12mr33548600pgs.83.1567614321459;
 Wed, 04 Sep 2019 09:25:21 -0700 (PDT)
Date:   Wed,  4 Sep 2019 09:25:07 -0700
In-Reply-To: <20190904162509.199561-1-sdf@google.com>
Message-Id: <20190904162509.199561-5-sdf@google.com>
Mime-Version: 1.0
References: <20190904162509.199561-1-sdf@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH bpf-next 4/6] selftests/bpf: test_progs: convert test_sockopt_multi
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
 .../sockopt_multi.c}                          | 62 +++----------------
 3 files changed, 11 insertions(+), 55 deletions(-)
 rename tools/testing/selftests/bpf/{test_sockopt_multi.c => prog_tests/sockopt_multi.c} (83%)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index bc83c1a7ea1b..4143add5a11e 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -39,6 +39,5 @@ libbpf.so.*
 test_hashmap
 test_btf_dump
 xdping
-test_sockopt_multi
 test_sockopt_inherit
 test_tcp_rtt
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index ea790901297c..271f8ce89c97 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -29,7 +29,7 @@ TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test
 	test_cgroup_storage test_select_reuseport test_section_names \
 	test_netcnt test_tcpnotify_user test_sock_fields test_sysctl test_hashmap \
 	test_btf_dump test_cgroup_attach xdping \
-	test_sockopt_multi test_sockopt_inherit test_tcp_rtt
+	test_sockopt_inherit test_tcp_rtt
 
 BPF_OBJ_FILES = $(patsubst %.c,%.o, $(notdir $(wildcard progs/*.c)))
 TEST_GEN_FILES = $(BPF_OBJ_FILES)
@@ -109,7 +109,6 @@ $(OUTPUT)/test_netcnt: cgroup_helpers.c
 $(OUTPUT)/test_sock_fields: cgroup_helpers.c
 $(OUTPUT)/test_sysctl: cgroup_helpers.c
 $(OUTPUT)/test_cgroup_attach: cgroup_helpers.c
-$(OUTPUT)/test_sockopt_multi: cgroup_helpers.c
 $(OUTPUT)/test_sockopt_inherit: cgroup_helpers.c
 $(OUTPUT)/test_tcp_rtt: cgroup_helpers.c
 
diff --git a/tools/testing/selftests/bpf/test_sockopt_multi.c b/tools/testing/selftests/bpf/prog_tests/sockopt_multi.c
similarity index 83%
rename from tools/testing/selftests/bpf/test_sockopt_multi.c
rename to tools/testing/selftests/bpf/prog_tests/sockopt_multi.c
index 4be3441db867..29188d6f5c8d 100644
--- a/tools/testing/selftests/bpf/test_sockopt_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_multi.c
@@ -1,19 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#include <error.h>
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
 
 static int prog_attach(struct bpf_object *obj, int cgroup_fd, const char *title)
@@ -308,7 +294,7 @@ static int run_setsockopt_test(struct bpf_object *obj, int cg_parent,
 	return err;
 }
 
-int main(int argc, char **argv)
+void test_sockopt_multi(void)
 {
 	struct bpf_prog_load_attr attr = {
 		.file = "./sockopt_multi.o",
@@ -319,56 +305,28 @@ int main(int argc, char **argv)
 	int err = -1;
 	int ignored;
 
-	if (setup_cgroup_environment()) {
-		log_err("Failed to setup cgroup environment\n");
-		goto out;
-	}
-
-	cg_parent = create_and_get_cgroup("/parent");
-	if (cg_parent < 0) {
-		log_err("Failed to create cgroup /parent\n");
-		goto out;
-	}
-
-	cg_child = create_and_get_cgroup("/parent/child");
-	if (cg_child < 0) {
-		log_err("Failed to create cgroup /parent/child\n");
+	cg_parent = test__join_cgroup("/parent");
+	if (CHECK_FAIL(cg_parent < 0))
 		goto out;
-	}
 
-	if (join_cgroup("/parent/child")) {
-		log_err("Failed to join cgroup /parent/child\n");
+	cg_child = test__join_cgroup("/parent/child");
+	if (CHECK_FAIL(cg_child < 0))
 		goto out;
-	}
 
 	err = bpf_prog_load_xattr(&attr, &obj, &ignored);
-	if (err) {
-		log_err("Failed to load BPF object");
+	if (CHECK_FAIL(err))
 		goto out;
-	}
 
 	sock_fd = socket(AF_INET, SOCK_STREAM, 0);
-	if (sock_fd < 0) {
-		log_err("Failed to create socket");
+	if (CHECK_FAIL(sock_fd < 0))
 		goto out;
-	}
 
-	if (run_getsockopt_test(obj, cg_parent, cg_child, sock_fd))
-		err = -1;
-	printf("test_sockopt_multi: getsockopt %s\n",
-	       err ? "FAILED" : "PASSED");
-
-	if (run_setsockopt_test(obj, cg_parent, cg_child, sock_fd))
-		err = -1;
-	printf("test_sockopt_multi: setsockopt %s\n",
-	       err ? "FAILED" : "PASSED");
+	CHECK_FAIL(run_getsockopt_test(obj, cg_parent, cg_child, sock_fd));
+	CHECK_FAIL(run_setsockopt_test(obj, cg_parent, cg_child, sock_fd));
 
 out:
 	close(sock_fd);
 	bpf_object__close(obj);
 	close(cg_child);
 	close(cg_parent);
-
-	printf("test_sockopt_multi: %s\n", err ? "FAILED" : "PASSED");
-	return err ? EXIT_FAILURE : EXIT_SUCCESS;
 }
-- 
2.23.0.187.g17f5b7556c-goog

