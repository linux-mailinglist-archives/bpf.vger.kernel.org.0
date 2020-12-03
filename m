Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6522CE0CA
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 22:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbgLCVeZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 16:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729674AbgLCVeZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 16:34:25 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FCCC061A53
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 13:33:44 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id u12so3385027wrt.0
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 13:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dDqswSxrOovHq7XveMqAtYURq0EbDhW65Qvlm2rJxY8=;
        b=MFEW4lCBtUz9MgxmJ5eNWwfkSOUwG7W8pL1ZfjZ2rrjkLHQzyeprkezxHiSt23tLlD
         F/9X33oqRjdtUJf+gfVSaY7DH7b3HCq3nztBXIu+5+IEBmnXLOlK+jSqNz+p/jbcTNkZ
         o/gem+RJlvoN6BVzML8Zu7p3mgZ6K6n1awHMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dDqswSxrOovHq7XveMqAtYURq0EbDhW65Qvlm2rJxY8=;
        b=JQA6YizevsgmTwTBOiKIfvClk14axioFdmofEjzRcSADkpsVOP7tbkUBtq59MrCNmS
         yFX9RKMrDf5zqaLvkZsvnXzihn9HCSJiYJg/fgU1IaTr2BjNRSDrWNhVHLiucNH1Op37
         aoS2co1RTzTneKV4VVjjPeQPoMQXOgt/trd3OJJPYhNlMnMzJsZwq2klG3OAiQxGRvgh
         wIihhtDn5fEfw8bkD63HmRw1n+ayChaIesNPfeLGLUwCCHIzVSRozw6EK3wvZ3SAZikP
         RRUSxRS1zW8tzixPVt+NUtC3BrwOw6ZYf8XVjJhTq5fgKdLaGIhnk/9W4x7IeAh6tgYq
         eIow==
X-Gm-Message-State: AOAM533Gd0alTs7blOrCh/2fk7RXkd8QjCuFJseBPshJVnJyMstjTyL0
        YIfOagomfX3CWTGnaXdP8N6K2HNpmk0lyg==
X-Google-Smtp-Source: ABdhPJwYiGIrdh1/Si+3STFxqmF1qTV3V2gV58nuFLV5iZCSFXG17oWUGhF3VJ2OThegp1XsXVFFwQ==
X-Received: by 2002:a5d:514f:: with SMTP id u15mr1242830wrt.385.1607031223345;
        Thu, 03 Dec 2020 13:33:43 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id h83sm754013wmf.9.2020.12.03.13.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 13:33:42 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
X-Google-Original-From: Florent Revest <revest@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: Integrate the socket_cookie test to test_progs
Date:   Thu,  3 Dec 2020 22:33:29 +0100
Message-Id: <20201203213330.1657666-2-revest@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201203213330.1657666-1-revest@google.com>
References: <20201203213330.1657666-1-revest@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, the selftest for the BPF socket_cookie helpers is built and
run independently from test_progs. It's easy to forget and hard to
maintain.

This patch moves the socket cookies test into prog_tests/ and vastly
simplifies its logic by:
- rewriting the loading code with BPF skeletons
- rewriting the server/client code with network helpers
- rewriting the cgroup code with test__join_cgroup
- rewriting the error handling code with CHECKs

Signed-off-by: Florent Revest <revest@google.com>
---
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../selftests/bpf/prog_tests/socket_cookie.c  |  82 +++++++
 .../selftests/bpf/progs/socket_cookie_prog.c  |   2 -
 .../selftests/bpf/test_socket_cookie.c        | 208 ------------------
 4 files changed, 83 insertions(+), 212 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/socket_cookie.c
 delete mode 100644 tools/testing/selftests/bpf/test_socket_cookie.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 894192c319fb..8c7ff88f0eb3 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -33,7 +33,7 @@ LDLIBS += -lcap -lelf -lz -lrt -lpthread
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
 	test_verifier_log test_dev_cgroup \
-	test_sock test_sockmap get_cgroup_id_user test_socket_cookie \
+	test_sock test_sockmap get_cgroup_id_user \
 	test_cgroup_storage \
 	test_netcnt test_tcpnotify_user test_sysctl \
 	test_progs-no_alu32 \
@@ -161,7 +161,6 @@ $(OUTPUT)/test_dev_cgroup: cgroup_helpers.c
 $(OUTPUT)/test_skb_cgroup_id_user: cgroup_helpers.c
 $(OUTPUT)/test_sock: cgroup_helpers.c
 $(OUTPUT)/test_sock_addr: cgroup_helpers.c
-$(OUTPUT)/test_socket_cookie: cgroup_helpers.c
 $(OUTPUT)/test_sockmap: cgroup_helpers.c
 $(OUTPUT)/test_tcpnotify_user: cgroup_helpers.c trace_helpers.c
 $(OUTPUT)/get_cgroup_id_user: cgroup_helpers.c
diff --git a/tools/testing/selftests/bpf/prog_tests/socket_cookie.c b/tools/testing/selftests/bpf/prog_tests/socket_cookie.c
new file mode 100644
index 000000000000..53d0c44e7907
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/socket_cookie.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2020 Google LLC.
+// Copyright (c) 2018 Facebook
+
+#include <test_progs.h>
+#include "socket_cookie_prog.skel.h"
+#include "network_helpers.h"
+
+static int duration;
+
+struct socket_cookie {
+	__u64 cookie_key;
+	__u32 cookie_value;
+};
+
+void test_socket_cookie(void)
+{
+	socklen_t addr_len = sizeof(struct sockaddr_in6);
+	struct bpf_link *set_link, *update_link;
+	int server_fd, client_fd, cgroup_fd;
+	struct socket_cookie_prog *skel;
+	__u32 cookie_expected_value;
+	struct sockaddr_in6 addr;
+	struct socket_cookie val;
+	int err = 0;
+
+	skel = socket_cookie_prog__open_and_load();
+	if (CHECK(!skel, "socket_cookie_prog__open_and_load",
+		  "skeleton open_and_load failed\n"))
+		return;
+
+	cgroup_fd = test__join_cgroup("/socket_cookie");
+	if (CHECK(cgroup_fd < 0, "join_cgroup", "cgroup creation failed\n"))
+		goto destroy_skel;
+
+	set_link = bpf_program__attach_cgroup(skel->progs.set_cookie,
+					      cgroup_fd);
+	if (CHECK(IS_ERR(set_link), "set-link-cg-attach", "err %ld\n",
+		  PTR_ERR(set_link)))
+		goto close_cgroup_fd;
+
+	update_link = bpf_program__attach_cgroup(skel->progs.update_cookie,
+						 cgroup_fd);
+	if (CHECK(IS_ERR(update_link), "update-link-cg-attach", "err %ld\n",
+		  PTR_ERR(update_link)))
+		goto free_set_link;
+
+	server_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
+	if (CHECK(server_fd < 0, "start_server", "errno %d\n", errno))
+		goto free_update_link;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (CHECK(client_fd < 0, "connect_to_fd", "errno %d\n", errno))
+		goto close_server_fd;
+
+	err = bpf_map_lookup_elem(bpf_map__fd(skel->maps.socket_cookies),
+				  &client_fd, &val);
+	if (CHECK(err, "map_lookup", "err %d errno %d\n", err, errno))
+		goto close_client_fd;
+
+	err = getsockname(client_fd, (struct sockaddr *)&addr, &addr_len);
+	if (CHECK(err, "getsockname", "Can't get client local addr\n"))
+		goto close_client_fd;
+
+	cookie_expected_value = (ntohs(addr.sin6_port) << 8) | 0xFF;
+	CHECK(val.cookie_value != cookie_expected_value, "",
+	      "Unexpected value in map: %x != %x\n", val.cookie_value,
+	      cookie_expected_value);
+
+close_client_fd:
+	close(client_fd);
+close_server_fd:
+	close(server_fd);
+free_update_link:
+	bpf_link__destroy(update_link);
+free_set_link:
+	bpf_link__destroy(set_link);
+close_cgroup_fd:
+	close(cgroup_fd);
+destroy_skel:
+	socket_cookie_prog__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/socket_cookie_prog.c b/tools/testing/selftests/bpf/progs/socket_cookie_prog.c
index 0cb5656a22b0..81e84be6f86d 100644
--- a/tools/testing/selftests/bpf/progs/socket_cookie_prog.c
+++ b/tools/testing/selftests/bpf/progs/socket_cookie_prog.c
@@ -65,6 +65,4 @@ int update_cookie(struct bpf_sock_ops *ctx)
 	return 1;
 }
 
-int _version SEC("version") = 1;
-
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_socket_cookie.c b/tools/testing/selftests/bpf/test_socket_cookie.c
deleted file mode 100644
index ca7ca87e91aa..000000000000
--- a/tools/testing/selftests/bpf/test_socket_cookie.c
+++ /dev/null
@@ -1,208 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2018 Facebook
-
-#include <string.h>
-#include <unistd.h>
-
-#include <arpa/inet.h>
-#include <netinet/in.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-
-#include "bpf_rlimit.h"
-#include "cgroup_helpers.h"
-
-#define CG_PATH			"/foo"
-#define SOCKET_COOKIE_PROG	"./socket_cookie_prog.o"
-
-struct socket_cookie {
-	__u64 cookie_key;
-	__u32 cookie_value;
-};
-
-static int start_server(void)
-{
-	struct sockaddr_in6 addr;
-	int fd;
-
-	fd = socket(AF_INET6, SOCK_STREAM, 0);
-	if (fd == -1) {
-		log_err("Failed to create server socket");
-		goto out;
-	}
-
-	memset(&addr, 0, sizeof(addr));
-	addr.sin6_family = AF_INET6;
-	addr.sin6_addr = in6addr_loopback;
-	addr.sin6_port = 0;
-
-	if (bind(fd, (const struct sockaddr *)&addr, sizeof(addr)) == -1) {
-		log_err("Failed to bind server socket");
-		goto close_out;
-	}
-
-	if (listen(fd, 128) == -1) {
-		log_err("Failed to listen on server socket");
-		goto close_out;
-	}
-
-	goto out;
-
-close_out:
-	close(fd);
-	fd = -1;
-out:
-	return fd;
-}
-
-static int connect_to_server(int server_fd)
-{
-	struct sockaddr_storage addr;
-	socklen_t len = sizeof(addr);
-	int fd;
-
-	fd = socket(AF_INET6, SOCK_STREAM, 0);
-	if (fd == -1) {
-		log_err("Failed to create client socket");
-		goto out;
-	}
-
-	if (getsockname(server_fd, (struct sockaddr *)&addr, &len)) {
-		log_err("Failed to get server addr");
-		goto close_out;
-	}
-
-	if (connect(fd, (const struct sockaddr *)&addr, len) == -1) {
-		log_err("Fail to connect to server");
-		goto close_out;
-	}
-
-	goto out;
-
-close_out:
-	close(fd);
-	fd = -1;
-out:
-	return fd;
-}
-
-static int validate_map(struct bpf_map *map, int client_fd)
-{
-	__u32 cookie_expected_value;
-	struct sockaddr_in6 addr;
-	socklen_t len = sizeof(addr);
-	struct socket_cookie val;
-	int err = 0;
-	int map_fd;
-
-	if (!map) {
-		log_err("Map not found in BPF object");
-		goto err;
-	}
-
-	map_fd = bpf_map__fd(map);
-
-	err = bpf_map_lookup_elem(map_fd, &client_fd, &val);
-
-	err = getsockname(client_fd, (struct sockaddr *)&addr, &len);
-	if (err) {
-		log_err("Can't get client local addr");
-		goto out;
-	}
-
-	cookie_expected_value = (ntohs(addr.sin6_port) << 8) | 0xFF;
-	if (val.cookie_value != cookie_expected_value) {
-		log_err("Unexpected value in map: %x != %x", val.cookie_value,
-			cookie_expected_value);
-		goto err;
-	}
-
-	goto out;
-err:
-	err = -1;
-out:
-	return err;
-}
-
-static int run_test(int cgfd)
-{
-	enum bpf_attach_type attach_type;
-	struct bpf_prog_load_attr attr;
-	struct bpf_program *prog;
-	struct bpf_object *pobj;
-	const char *prog_name;
-	int server_fd = -1;
-	int client_fd = -1;
-	int prog_fd = -1;
-	int err = 0;
-
-	memset(&attr, 0, sizeof(attr));
-	attr.file = SOCKET_COOKIE_PROG;
-	attr.prog_type = BPF_PROG_TYPE_UNSPEC;
-	attr.prog_flags = BPF_F_TEST_RND_HI32;
-
-	err = bpf_prog_load_xattr(&attr, &pobj, &prog_fd);
-	if (err) {
-		log_err("Failed to load %s", attr.file);
-		goto out;
-	}
-
-	bpf_object__for_each_program(prog, pobj) {
-		prog_name = bpf_program__section_name(prog);
-
-		if (libbpf_attach_type_by_name(prog_name, &attach_type))
-			goto err;
-
-		err = bpf_prog_attach(bpf_program__fd(prog), cgfd, attach_type,
-				      BPF_F_ALLOW_OVERRIDE);
-		if (err) {
-			log_err("Failed to attach prog %s", prog_name);
-			goto out;
-		}
-	}
-
-	server_fd = start_server();
-	if (server_fd == -1)
-		goto err;
-
-	client_fd = connect_to_server(server_fd);
-	if (client_fd == -1)
-		goto err;
-
-	if (validate_map(bpf_map__next(NULL, pobj), client_fd))
-		goto err;
-
-	goto out;
-err:
-	err = -1;
-out:
-	close(client_fd);
-	close(server_fd);
-	bpf_object__close(pobj);
-	printf("%s\n", err ? "FAILED" : "PASSED");
-	return err;
-}
-
-int main(int argc, char **argv)
-{
-	int cgfd = -1;
-	int err = 0;
-
-	cgfd = cgroup_setup_and_join(CG_PATH);
-	if (cgfd < 0)
-		goto err;
-
-	if (run_test(cgfd))
-		goto err;
-
-	goto out;
-err:
-	err = -1;
-out:
-	close(cgfd);
-	cleanup_cgroup_environment();
-	return err;
-}
-- 
2.29.2.576.ga3fc446d84-goog

