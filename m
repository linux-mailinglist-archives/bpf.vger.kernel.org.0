Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB184A8D1C
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2019 21:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbfIDQZZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Sep 2019 12:25:25 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:56930 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731540AbfIDQZZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Sep 2019 12:25:25 -0400
Received: by mail-qt1-f202.google.com with SMTP id m6so15864413qtk.23
        for <bpf@vger.kernel.org>; Wed, 04 Sep 2019 09:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1M7koa/+IrNoKIYdGoxU0RnSi5kAFxlJXP3OMpiRbEk=;
        b=O+TR9hby5HJP+GI7QH1BG+seka8fzBtkJ9nxOpNMVczlELuemjbf1rNBut/URTFlNy
         tfnae1Qtn0SPfzpGc5zIiwY9TDEWsCQyMct5xKXFmdvOBGfs1tw4TmQuhXGYsWR46jlN
         zMBhJdcwN3MW1UCFCpwXoXfQrYUg2gFrkHW15Go546iKEVJDeULKhNQ5caIzsFGmlrup
         GtMtXitnYYUlkRmdu9wZnp/jhOTO9dnpQ44F6/YIYO1wcNiCJ+gNDpK5UzHDYWsN4aaW
         rKRAUh7VrQS99HTsQygQ71zmstAYkk0aKg+AiTjUAEfWTFabCMiFCBbbUf+qoD+68nYO
         y5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1M7koa/+IrNoKIYdGoxU0RnSi5kAFxlJXP3OMpiRbEk=;
        b=GsxwrxMwPJPwngsbDo0w/e8MBh1fg3vpNXmvLzy0IoigpZyMLlSpcBgAptbVIpzCJQ
         9tjsfdQ13D0HR3yp08DWizPVz7wVu3pQezuhH9j18tp98pX1PFu/Oe32vBhFynfyf7Y+
         XUTsB83VoZopcXjdIDWVuAaKEhs2Uwjj8qVsWMvg47w8qM5LcvE4s5ECfpGSPGQBovMg
         +q1FsG53Ng5o3UNyr3cPgivHKVXu6tDiIGq05iVsaWR77HNO3I1OvDFY1j+K781fI5qN
         dzs6Rmu1j922A9eCpGR1XK2WUBb9MofrIRrDjCi5Qfa2pj4WixktbQE0QY+NeTCj3V0s
         ahMQ==
X-Gm-Message-State: APjAAAVGqFJHQ62VzMaSFYmDChQ043Ju5Gu5Q0skoGunqc2XqRjrrM3d
        ptv/R8yOXoRU8jmhhKfm72Q9I7g=
X-Google-Smtp-Source: APXvYqyjkGCc7llEddgSuTe3hYtFHz5jEd3EuWHysIjH9JYqQwNoDmldk92u9Nl0D/5MMWHvxk4Ez1Q=
X-Received: by 2002:ac8:65d6:: with SMTP id t22mr17100128qto.259.1567614324109;
 Wed, 04 Sep 2019 09:25:24 -0700 (PDT)
Date:   Wed,  4 Sep 2019 09:25:08 -0700
In-Reply-To: <20190904162509.199561-1-sdf@google.com>
Message-Id: <20190904162509.199561-6-sdf@google.com>
Mime-Version: 1.0
References: <20190904162509.199561-1-sdf@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH bpf-next 5/6] selftests/bpf: test_progs: convert test_sockopt_inherit
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

I also added pthread_cond_wait for the server thread startup. We don't
want to connect to the server that's not yet up (for some reason
this existing race is now more prominent with test_progs).

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/.gitignore        |   1 -
 tools/testing/selftests/bpf/Makefile          |   4 +-
 .../sockopt_inherit.c}                        | 102 ++++++++----------
 3 files changed, 43 insertions(+), 64 deletions(-)
 rename tools/testing/selftests/bpf/{test_sockopt_inherit.c => prog_tests/sockopt_inherit.c} (72%)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 4143add5a11e..5b06bb45b500 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -39,5 +39,4 @@ libbpf.so.*
 test_hashmap
 test_btf_dump
 xdping
-test_sockopt_inherit
 test_tcp_rtt
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 271f8ce89c97..fe786df1174b 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -28,8 +28,7 @@ TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test
 	test_sock test_btf test_sockmap get_cgroup_id_user test_socket_cookie \
 	test_cgroup_storage test_select_reuseport test_section_names \
 	test_netcnt test_tcpnotify_user test_sock_fields test_sysctl test_hashmap \
-	test_btf_dump test_cgroup_attach xdping \
-	test_sockopt_inherit test_tcp_rtt
+	test_btf_dump test_cgroup_attach xdping test_tcp_rtt
 
 BPF_OBJ_FILES = $(patsubst %.c,%.o, $(notdir $(wildcard progs/*.c)))
 TEST_GEN_FILES = $(BPF_OBJ_FILES)
@@ -109,7 +108,6 @@ $(OUTPUT)/test_netcnt: cgroup_helpers.c
 $(OUTPUT)/test_sock_fields: cgroup_helpers.c
 $(OUTPUT)/test_sysctl: cgroup_helpers.c
 $(OUTPUT)/test_cgroup_attach: cgroup_helpers.c
-$(OUTPUT)/test_sockopt_inherit: cgroup_helpers.c
 $(OUTPUT)/test_tcp_rtt: cgroup_helpers.c
 
 .PHONY: force
diff --git a/tools/testing/selftests/bpf/test_sockopt_inherit.c b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
similarity index 72%
rename from tools/testing/selftests/bpf/test_sockopt_inherit.c
rename to tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
index 1bf699815b9b..6cbeea7b4bf1 100644
--- a/tools/testing/selftests/bpf/test_sockopt_inherit.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
@@ -1,22 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <error.h>
-#include <errno.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <pthread.h>
-
-#include <linux/filter.h>
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-
-#include "bpf_rlimit.h"
-#include "bpf_util.h"
+#include <test_progs.h>
 #include "cgroup_helpers.h"
 
-#define CG_PATH				"/sockopt_inherit"
 #define SOL_CUSTOM			0xdeadbeef
 #define CUSTOM_INHERIT1			0
 #define CUSTOM_INHERIT2			1
@@ -74,6 +59,9 @@ static int verify_sockopt(int fd, int optname, const char *msg, char expected)
 	return 0;
 }
 
+static pthread_mutex_t server_started_mtx = PTHREAD_MUTEX_INITIALIZER;
+static pthread_cond_t server_started = PTHREAD_COND_INITIALIZER;
+
 static void *server_thread(void *arg)
 {
 	struct sockaddr_storage addr;
@@ -82,16 +70,26 @@ static void *server_thread(void *arg)
 	int client_fd;
 	int err = 0;
 
-	if (listen(fd, 1) < 0)
-		error(1, errno, "Failed to listed on socket");
+	err = listen(fd, 1);
+
+	pthread_mutex_lock(&server_started_mtx);
+	pthread_cond_signal(&server_started);
+	pthread_mutex_unlock(&server_started_mtx);
+
+	if (CHECK_FAIL(err < 0)) {
+		perror("Failed to listed on socket");
+		return NULL;
+	}
 
 	err += verify_sockopt(fd, CUSTOM_INHERIT1, "listen", 1);
 	err += verify_sockopt(fd, CUSTOM_INHERIT2, "listen", 1);
 	err += verify_sockopt(fd, CUSTOM_LISTENER, "listen", 1);
 
 	client_fd = accept(fd, (struct sockaddr *)&addr, &len);
-	if (client_fd < 0)
-		error(1, errno, "Failed to accept client");
+	if (CHECK_FAIL(client_fd < 0)) {
+		perror("Failed to accept client");
+		return NULL;
+	}
 
 	err += verify_sockopt(client_fd, CUSTOM_INHERIT1, "accept", 1);
 	err += verify_sockopt(client_fd, CUSTOM_INHERIT2, "accept", 1);
@@ -167,7 +165,7 @@ static int prog_attach(struct bpf_object *obj, int cgroup_fd, const char *title)
 	return 0;
 }
 
-static int run_test(int cgroup_fd)
+static void run_test(int cgroup_fd)
 {
 	struct bpf_prog_load_attr attr = {
 		.file = "./sockopt_inherit.o",
@@ -180,40 +178,41 @@ static int run_test(int cgroup_fd)
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
 
 	server_fd = start_server();
-	if (server_fd < 0) {
-		err = -1;
+	if (CHECK_FAIL(server_fd < 0))
+		goto close_bpf_object;
+
+	if (CHECK_FAIL(pthread_create(&tid, NULL, server_thread,
+				      (void *)&server_fd)))
 		goto close_bpf_object;
-	}
 
-	pthread_create(&tid, NULL, server_thread, (void *)&server_fd);
+	pthread_mutex_lock(&server_started_mtx);
+	pthread_cond_wait(&server_started, &server_started_mtx);
+	pthread_mutex_unlock(&server_started_mtx);
 
 	client_fd = connect_to_server(server_fd);
-	if (client_fd < 0) {
-		err = -1;
+	if (CHECK_FAIL(client_fd < 0))
 		goto close_server_fd;
-	}
 
-	err += verify_sockopt(client_fd, CUSTOM_INHERIT1, "connect", 0);
-	err += verify_sockopt(client_fd, CUSTOM_INHERIT2, "connect", 0);
-	err += verify_sockopt(client_fd, CUSTOM_LISTENER, "connect", 0);
+	CHECK_FAIL(verify_sockopt(client_fd, CUSTOM_INHERIT1, "connect", 0));
+	CHECK_FAIL(verify_sockopt(client_fd, CUSTOM_INHERIT2, "connect", 0));
+	CHECK_FAIL(verify_sockopt(client_fd, CUSTOM_LISTENER, "connect", 0));
 
 	pthread_join(tid, &server_err);
 
-	err += (int)(long)server_err;
+	err = (int)(long)server_err;
+	CHECK_FAIL(err);
 
 	close(client_fd);
 
@@ -221,33 +220,16 @@ static int run_test(int cgroup_fd)
 	close(server_fd);
 close_bpf_object:
 	bpf_object__close(obj);
-	return err;
 }
 
-int main(int args, char **argv)
+void test_sockopt_inherit(void)
 {
 	int cgroup_fd;
-	int err = EXIT_SUCCESS;
-
-	if (setup_cgroup_environment())
-		return err;
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
 
-	printf("test_sockopt_inherit: %s\n",
-	       err == EXIT_SUCCESS ? "PASSED" : "FAILED");
+	cgroup_fd = test__join_cgroup("/sockopt_inherit");
+	if (CHECK_FAIL(cgroup_fd < 0))
+		return;
 
-cleanup_cgroup:
+	run_test(cgroup_fd);
 	close(cgroup_fd);
-cleanup_cgroup_env:
-	cleanup_cgroup_environment();
-	return err;
 }
-- 
2.23.0.187.g17f5b7556c-goog

