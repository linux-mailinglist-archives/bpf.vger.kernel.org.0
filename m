Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52378AA749
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2019 17:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390425AbfIEP1U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Sep 2019 11:27:20 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:55143 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390412AbfIEP1U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Sep 2019 11:27:20 -0400
Received: by mail-pf1-f201.google.com with SMTP id s139so2069009pfc.21
        for <bpf@vger.kernel.org>; Thu, 05 Sep 2019 08:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Tbz4Llm/4l7fjtRQCiC4O/nrvoLwptRAGpztTTGChds=;
        b=sHkG+YyGFJI/kQDymP09qG3i7MYmY/EwJ6vnsdeafJYKS9NxAhQk4J8DYcmo5nzJ8e
         4xa47S5JU7Eyv2puTzCJsB3ZwNBhdWixgX5bmYEQxI6tA6/5rR/h2avyAc3tY7SOWorp
         5Xg6o2OOa5fK1JYz4t4Cv8mCygnncfHsQE5Trc8guCWzvzRUEhy6dgcr2mJfBRNMuO1Q
         fkzR24dzrxulxQd5il3lHQituWx/cDzKkpkF1MEXTKQ14CX2h/0/sh07wRC7gp2aaQLa
         e93H2/jOg6pDnpJSJqziLbfxjc4eYmL2di4Ig4PfxtLM7cqNPdpLbZzP8F0YiTDLff+g
         Ha/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Tbz4Llm/4l7fjtRQCiC4O/nrvoLwptRAGpztTTGChds=;
        b=nA4cbHJgAqF3t6IjSvMP+R9lfyfCGOHDX4kAttqRWYkOF7PIFjgDfTS4ZT7nxu5XwI
         IVz2Wjbat7GjEjbf1QkKuZMBuO4tpCFYPWCeFSPPUAcPhOMBQ3uQwo9FXSV9+eicx9/t
         uRdAijI3YDXFdmdF0BAUoNvEDKC6va+L9hWdJ+tEGbhpI/zgBn8Ld6TNH6o1okOJ252Z
         t4R40z6o2Mo1LyBmplSZFEzpkxKhxJeZXY4xBxK3wNR39qDo1EPtu7+dtFBZqT1ItBJz
         WvURResv4lK16prdL6L0X3beJqIBlQpnm+2LR2LqwuI/6q7m++FevZsVGAngCd7c3DiQ
         uEXw==
X-Gm-Message-State: APjAAAV9GPHM8CD6Kxg2YLkbS1wUQ3qjoqb3bzgYKhSeoysplUk6zO8k
        QRJg0OCzrqO4WMZg1grJmQi5Iq4=
X-Google-Smtp-Source: APXvYqxk+mkk55YPPOwW5LTHjXS3ZU24COJIFKAjnAQACbsk8Dm57Gwo3vm3R6xH1unrgmljyLFexL4=
X-Received: by 2002:a63:2006:: with SMTP id g6mr3614502pgg.287.1567697238970;
 Thu, 05 Sep 2019 08:27:18 -0700 (PDT)
Date:   Thu,  5 Sep 2019 08:27:06 -0700
In-Reply-To: <20190905152709.111193-1-sdf@google.com>
Message-Id: <20190905152709.111193-4-sdf@google.com>
Mime-Version: 1.0
References: <20190905152709.111193-1-sdf@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH bpf-next v2 3/6] selftests/bpf: test_progs: convert test_sockopt_sk
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
 .../sockopt_sk.c}                             | 60 ++++---------------
 tools/testing/selftests/bpf/test_progs.h      |  3 +-
 4 files changed, 15 insertions(+), 52 deletions(-)
 rename tools/testing/selftests/bpf/{test_sockopt_sk.c => prog_tests/sockopt_sk.c} (79%)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 0315120eac8f..bc83c1a7ea1b 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -39,7 +39,6 @@ libbpf.so.*
 test_hashmap
 test_btf_dump
 xdping
-test_sockopt_sk
 test_sockopt_multi
 test_sockopt_inherit
 test_tcp_rtt
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 08e2183974d5..ea790901297c 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -28,7 +28,7 @@ TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test
 	test_sock test_btf test_sockmap get_cgroup_id_user test_socket_cookie \
 	test_cgroup_storage test_select_reuseport test_section_names \
 	test_netcnt test_tcpnotify_user test_sock_fields test_sysctl test_hashmap \
-	test_btf_dump test_cgroup_attach xdping test_sockopt_sk \
+	test_btf_dump test_cgroup_attach xdping \
 	test_sockopt_multi test_sockopt_inherit test_tcp_rtt
 
 BPF_OBJ_FILES = $(patsubst %.c,%.o, $(notdir $(wildcard progs/*.c)))
@@ -109,7 +109,6 @@ $(OUTPUT)/test_netcnt: cgroup_helpers.c
 $(OUTPUT)/test_sock_fields: cgroup_helpers.c
 $(OUTPUT)/test_sysctl: cgroup_helpers.c
 $(OUTPUT)/test_cgroup_attach: cgroup_helpers.c
-$(OUTPUT)/test_sockopt_sk: cgroup_helpers.c
 $(OUTPUT)/test_sockopt_multi: cgroup_helpers.c
 $(OUTPUT)/test_sockopt_inherit: cgroup_helpers.c
 $(OUTPUT)/test_tcp_rtt: cgroup_helpers.c
diff --git a/tools/testing/selftests/bpf/test_sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
similarity index 79%
rename from tools/testing/selftests/bpf/test_sockopt_sk.c
rename to tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
index e4f6055d92e9..2061a6beac0f 100644
--- a/tools/testing/selftests/bpf/test_sockopt_sk.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
@@ -1,23 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#include <errno.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <netinet/tcp.h>
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
 #define SOL_CUSTOM			0xdeadbeef
 
 static int getsetsockopt(void)
@@ -176,7 +160,7 @@ static int prog_attach(struct bpf_object *obj, int cgroup_fd, const char *title)
 	return 0;
 }
 
-static int run_test(int cgroup_fd)
+static void run_test(int cgroup_fd)
 {
 	struct bpf_prog_load_attr attr = {
 		.file = "./sockopt_sk.o",
@@ -186,51 +170,31 @@ static int run_test(int cgroup_fd)
 	int err;
 
 	err = bpf_prog_load_xattr(&attr, &obj, &ignored);
-	if (err) {
-		log_err("Failed to load BPF object");
-		return -1;
-	}
+	if (CHECK_FAIL(err))
+		return;
 
 	err = prog_attach(obj, cgroup_fd, "cgroup/getsockopt");
-	if (err)
+	if (CHECK_FAIL(err))
 		goto close_bpf_object;
 
 	err = prog_attach(obj, cgroup_fd, "cgroup/setsockopt");
-	if (err)
+	if (CHECK_FAIL(err))
 		goto close_bpf_object;
 
-	err = getsetsockopt();
+	CHECK_FAIL(getsetsockopt());
 
 close_bpf_object:
 	bpf_object__close(obj);
-	return err;
 }
 
-int main(int args, char **argv)
+void test_sockopt_sk(void)
 {
 	int cgroup_fd;
-	int err = EXIT_SUCCESS;
-
-	if (setup_cgroup_environment())
-		goto cleanup_obj;
-
-	cgroup_fd = create_and_get_cgroup(CG_PATH);
-	if (cgroup_fd < 0)
-		goto cleanup_cgroup_env;
-
-	if (join_cgroup(CG_PATH))
-		goto cleanup_cgroup;
-
-	if (run_test(cgroup_fd))
-		err = EXIT_FAILURE;
 
-	printf("test_sockopt_sk: %s\n",
-	       err == EXIT_SUCCESS ? "PASSED" : "FAILED");
+	cgroup_fd = test__join_cgroup("/sockopt_sk");
+	if (CHECK_FAIL(cgroup_fd < 0))
+		return;
 
-cleanup_cgroup:
+	run_test(cgroup_fd);
 	close(cgroup_fd);
-cleanup_cgroup_env:
-	cleanup_cgroup_environment();
-cleanup_obj:
-	return err;
 }
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index e518bd5da3e2..0c48f64f732b 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -16,9 +16,10 @@ typedef __u16 __sum16;
 #include <linux/if_packet.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
-#include <linux/tcp.h>
+#include <netinet/tcp.h>
 #include <linux/filter.h>
 #include <linux/perf_event.h>
+#include <linux/socket.h>
 #include <linux/unistd.h>
 
 #include <sys/ioctl.h>
-- 
2.23.0.187.g17f5b7556c-goog

