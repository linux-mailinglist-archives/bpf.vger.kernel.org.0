Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2FE305BFE
	for <lists+bpf@lfdr.de>; Wed, 27 Jan 2021 13:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313998AbhAZWxh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 17:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391448AbhAZSil (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jan 2021 13:38:41 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79481C061353
        for <bpf@vger.kernel.org>; Tue, 26 Jan 2021 10:36:10 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id s24so1949534wmj.0
        for <bpf@vger.kernel.org>; Tue, 26 Jan 2021 10:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X1ze2fflOX7/46xWR3hpmUad/Wa7AjqE192c4QQYIsg=;
        b=HCQ6Pm8aQyCoFwpWooD6CS8rL97K08fYfS5st00ud11TorFBpacKbCT3q8XJJR2XOP
         5oRG80VSnxs5QVmnreunNbODoawaqgNWNvd/w5MQodlNc8BBUhOb/HEYWztoDcUZfWXt
         ZSAdhTjG9+nZAn1QoE8bD7qxDgukLfWWHny/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X1ze2fflOX7/46xWR3hpmUad/Wa7AjqE192c4QQYIsg=;
        b=IsnmUhkbvMh/tz59o68CtTv4GbVvm9MAoGrG+42t90UQjqELkMP7QRUmv9KCpLOJaj
         920ZzdCcwZA9bFz1XGPWncdzEs1VVT9XyfEaQ7oJDIoS/kDUbjNbJlKT5+Qd4JN0VHXa
         l6sue+2t+5kbq6sFXI78VgxZfQ6yfJYylQvKh78OGogyMphmeM6dWA8sa9CZDkIhta0Y
         dXj1tvahfNUiA7BvQGC+lvydl68lTaaTwFdpf7v9ZZWFlqU/OoBOrdVKhbJpepFc2mXf
         cAEOyhyiHleGhAGsruUvXUuAROv2EPqyea4KGPpG1wBd9HKovdytMV0OoXFGcuPvbz4q
         4p3A==
X-Gm-Message-State: AOAM531Xu8H9hd58CVxijrY7a4eLV9B7L9ZofJByLofOfdvKtc11khte
        DP7UwMGBgJ61DVOklKPfvQtQPdgciNK8EQ==
X-Google-Smtp-Source: ABdhPJyO9QH1QrHZENuGKooGO8pFjbMrNLy9c4+h12/o3tVIzaITPXBou7ghiOfldwcJ+CY+wfgSLQ==
X-Received: by 2002:a7b:c08f:: with SMTP id r15mr965684wmh.22.1611686168843;
        Tue, 26 Jan 2021 10:36:08 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:deb:d0ec:3143:2380])
        by smtp.gmail.com with ESMTPSA id d13sm28339354wrx.93.2021.01.26.10.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:36:08 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next v6 3/5] selftests/bpf: Integrate the socket_cookie test to test_progs
Date:   Tue, 26 Jan 2021 19:35:57 +0100
Message-Id: <20210126183559.1302406-3-revest@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210126183559.1302406-1-revest@chromium.org>
References: <20210126183559.1302406-1-revest@chromium.org>
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

Signed-off-by: Florent Revest <revest@chromium.org>
Acked-by: KP Singh <kpsingh@kernel.org>
---
 tools/testing/selftests/bpf/.gitignore        |   1 -
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../selftests/bpf/prog_tests/socket_cookie.c  |  71 ++++++
 .../selftests/bpf/progs/socket_cookie_prog.c  |   2 -
 .../selftests/bpf/test_socket_cookie.c        | 208 ------------------
 5 files changed, 72 insertions(+), 213 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/socket_cookie.c
 delete mode 100644 tools/testing/selftests/bpf/test_socket_cookie.c

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 9abca0616ec0..c0c48fdb9ac1 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -17,7 +17,6 @@ test_sockmap
 test_lirc_mode2_user
 get_cgroup_id_user
 test_skb_cgroup_id_user
-test_socket_cookie
 test_cgroup_storage
 test_flow_dissector
 flow_dissector_load
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 63d6288e419c..af00fe3b7fb9 100644
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
 	test_progs-no_alu32
@@ -187,7 +187,6 @@ $(OUTPUT)/test_dev_cgroup: cgroup_helpers.c
 $(OUTPUT)/test_skb_cgroup_id_user: cgroup_helpers.c
 $(OUTPUT)/test_sock: cgroup_helpers.c
 $(OUTPUT)/test_sock_addr: cgroup_helpers.c
-$(OUTPUT)/test_socket_cookie: cgroup_helpers.c
 $(OUTPUT)/test_sockmap: cgroup_helpers.c
 $(OUTPUT)/test_tcpnotify_user: cgroup_helpers.c trace_helpers.c
 $(OUTPUT)/get_cgroup_id_user: cgroup_helpers.c
diff --git a/tools/testing/selftests/bpf/prog_tests/socket_cookie.c b/tools/testing/selftests/bpf/prog_tests/socket_cookie.c
new file mode 100644
index 000000000000..e12a31d3752c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/socket_cookie.c
@@ -0,0 +1,71 @@
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
+	int server_fd = 0, client_fd = 0, cgroup_fd = 0, err = 0;
+	socklen_t addr_len = sizeof(struct sockaddr_in6);
+	struct socket_cookie_prog *skel;
+	__u32 cookie_expected_value;
+	struct sockaddr_in6 addr;
+	struct socket_cookie val;
+
+	skel = socket_cookie_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	cgroup_fd = test__join_cgroup("/socket_cookie");
+	if (CHECK(cgroup_fd < 0, "join_cgroup", "cgroup creation failed\n"))
+		goto out;
+
+	skel->links.set_cookie = bpf_program__attach_cgroup(
+		skel->progs.set_cookie, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.set_cookie, "prog_attach"))
+		goto close_cgroup_fd;
+
+	skel->links.update_cookie = bpf_program__attach_cgroup(
+		skel->progs.update_cookie, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.update_cookie, "prog_attach"))
+		goto close_cgroup_fd;
+
+	server_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
+	if (CHECK(server_fd < 0, "start_server", "errno %d\n", errno))
+		goto close_cgroup_fd;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (CHECK(client_fd < 0, "connect_to_fd", "errno %d\n", errno))
+		goto close_server_fd;
+
+	err = bpf_map_lookup_elem(bpf_map__fd(skel->maps.socket_cookies),
+				  &client_fd, &val);
+	if (!ASSERT_OK(err, "map_lookup(socket_cookies)"))
+		goto close_client_fd;
+
+	err = getsockname(client_fd, (struct sockaddr *)&addr, &addr_len);
+	if (!ASSERT_OK(err, "getsockname"))
+		goto close_client_fd;
+
+	cookie_expected_value = (ntohs(addr.sin6_port) << 8) | 0xFF;
+	ASSERT_EQ(val.cookie_value, cookie_expected_value, "cookie_value");
+
+close_client_fd:
+	close(client_fd);
+close_server_fd:
+	close(server_fd);
+close_cgroup_fd:
+	close(cgroup_fd);
+out:
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
2.30.0.280.ga3ce27912f-goog

