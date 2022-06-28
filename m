Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5606155EB42
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 19:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbiF1Rnl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 13:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbiF1Rnh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 13:43:37 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CB65F8A
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 10:43:35 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id b24-20020a17090ae39800b001ecd48d4b29so8406465pjz.4
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 10:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=L/d02DW7fpHrMYqWchZB/XKkkRiXXYuZDK6RvaDG4+s=;
        b=i9VGCD+GbaS7beovwTSth2ob9fT68JvWMaBwQzz+hyjBcwEG81VJXdhGjYWKoBwAYc
         obm0CRcsD5BBH2vl/DfeRPinLLs73biUQPT3wd3kRTO9pZngak6w9KepYyNzpidQGvwn
         Kc56/M+Ts3J7yhkXSCQHJQBkLXEL1uUQiM9ojVc7djFv17hBDE4M2/D/M1AQFiNc1IWK
         gPGakJRh0HIsEFhCnO06R1tEM/ms5To4BXEueKDYGiuDcTtxWdrRw9FbysD2WlazymSk
         Xh3fGxmVtjP831xQBP7adyniZzBts4po3bJ91u8nA3N1as0tfqu9+I60umOwwcizAtYz
         yO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L/d02DW7fpHrMYqWchZB/XKkkRiXXYuZDK6RvaDG4+s=;
        b=twZ20tLF9FFgswJkNJdJAX3Pq+tuKD9SJwE7n+DG9fDOwHkY2X8A0mnQtGLeKUrR5T
         5aUwftEEE2BCqKiIsBrMFfy1nKQxMSbjIk9YiZiAUYEJgdJwb5xGazdxBTSIdN8ApbcM
         RXQI19EG1N7agaY6fa/J20bd97sCdUhow4NCi8bl5CXMv4j+a85HewDloDi0ew1N8cbK
         c2+csL/E5NDC5+R9XCCA9EHiSw2mOk5eV6hOh1kJsWUimy4dtXFPfeO5AlYIWja0loIl
         TX/2UR2FRcQTNO679xzXSdsrS2/O6HeLEvFFquC32g5fNt/kR8lMRViCzk9PGmhzpVdy
         o3uw==
X-Gm-Message-State: AJIora8GsujbJJvYmAikloVURJBsyXTpQizHNbtjV1Dwdu8b97phW8/e
        yBoG9UWrtMIboN5qS+9CUpQtp9gAtps/WImRjjl/kyjvk6Yv85ZYLWKW3Jbf+9TYRXBHd6mwkXs
        ZiW5+ngYqamA1OuupEtqik5f9pZjv0C0csrVPUMJuHmnZbYziWQ==
X-Google-Smtp-Source: AGRyM1sNemXMKyoZwyYZO/d6gomXdwq0OcH7mJw3EPoqNlNepAlTPvgRrUfSpXvZIwCvJxPxUBnl0qI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:f8d6:b0:1ee:e6b1:d52 with SMTP id
 l22-20020a17090af8d600b001eee6b10d52mr850325pjd.158.1656438214687; Tue, 28
 Jun 2022 10:43:34 -0700 (PDT)
Date:   Tue, 28 Jun 2022 10:43:14 -0700
In-Reply-To: <20220628174314.1216643-1-sdf@google.com>
Message-Id: <20220628174314.1216643-12-sdf@google.com>
Mime-Version: 1.0
References: <20220628174314.1216643-1-sdf@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH bpf-next v11 11/11] selftests/bpf: lsm_cgroup functional test
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Functional test that exercises the following:

1. apply default sk_priority policy
2. permit TX-only AF_PACKET socket
3. cgroup attach/detach/replace
4. reusing trampoline shim

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/lsm_cgroup.c     | 293 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../testing/selftests/bpf/progs/lsm_cgroup.c  | 180 +++++++++++
 3 files changed, 474 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_cgroup.c

diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
new file mode 100644
index 000000000000..d40810a742fa
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
@@ -0,0 +1,293 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+#include "lsm_cgroup.skel.h"
+#include "cgroup_helpers.h"
+#include "network_helpers.h"
+
+static struct btf *btf;
+
+static __u32 query_prog_cnt(int cgroup_fd, const char *attach_func)
+{
+	LIBBPF_OPTS(bpf_prog_query_opts, p);
+	int cnt = 0;
+	int i;
+
+	ASSERT_OK(bpf_prog_query_opts(cgroup_fd, BPF_LSM_CGROUP, &p), "prog_query");
+
+	if (!attach_func)
+		return p.prog_cnt;
+
+	/* When attach_func is provided, count the number of progs that
+	 * attach to the given symbol.
+	 */
+
+	if (!btf)
+		btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK(libbpf_get_error(btf), "btf_vmlinux"))
+		return -1;
+
+	p.prog_ids = malloc(sizeof(u32) * p.prog_cnt);
+	p.prog_attach_flags = malloc(sizeof(u32) * p.prog_cnt);
+	ASSERT_OK(bpf_prog_query_opts(cgroup_fd, BPF_LSM_CGROUP, &p), "prog_query");
+
+	for (i = 0; i < p.prog_cnt; i++) {
+		struct bpf_prog_info info = {};
+		__u32 info_len = sizeof(info);
+		int fd;
+
+		fd = bpf_prog_get_fd_by_id(p.prog_ids[i]);
+		ASSERT_GE(fd, 0, "prog_get_fd_by_id");
+		ASSERT_OK(bpf_obj_get_info_by_fd(fd, &info, &info_len), "prog_info_by_fd");
+		close(fd);
+
+		if (info.attach_btf_id ==
+		    btf__find_by_name_kind(btf, attach_func, BTF_KIND_FUNC))
+			cnt++;
+	}
+
+	free(p.prog_ids);
+	free(p.prog_attach_flags);
+
+	return cnt;
+}
+
+static void test_lsm_cgroup_functional(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_prog_attach_opts, attach_opts);
+	DECLARE_LIBBPF_OPTS(bpf_link_update_opts, update_opts);
+	int cgroup_fd = -1, cgroup_fd2 = -1, cgroup_fd3 = -1;
+	int listen_fd, client_fd, accepted_fd;
+	struct lsm_cgroup *skel = NULL;
+	int post_create_prog_fd2 = -1;
+	int post_create_prog_fd = -1;
+	int bind_link_fd2 = -1;
+	int bind_prog_fd2 = -1;
+	int alloc_prog_fd = -1;
+	int bind_prog_fd = -1;
+	int bind_link_fd = -1;
+	int clone_prog_fd = -1;
+	int err, fd, prio;
+	socklen_t socklen;
+
+	cgroup_fd3 = test__join_cgroup("/sock_policy_empty");
+	if (!ASSERT_GE(cgroup_fd3, 0, "create empty cgroup"))
+		goto close_cgroup;
+
+	cgroup_fd2 = test__join_cgroup("/sock_policy_reuse");
+	if (!ASSERT_GE(cgroup_fd2, 0, "create cgroup for reuse"))
+		goto close_cgroup;
+
+	cgroup_fd = test__join_cgroup("/sock_policy");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		goto close_cgroup;
+
+	skel = lsm_cgroup__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto close_cgroup;
+
+	post_create_prog_fd = bpf_program__fd(skel->progs.socket_post_create);
+	post_create_prog_fd2 = bpf_program__fd(skel->progs.socket_post_create2);
+	bind_prog_fd = bpf_program__fd(skel->progs.socket_bind);
+	bind_prog_fd2 = bpf_program__fd(skel->progs.socket_bind2);
+	alloc_prog_fd = bpf_program__fd(skel->progs.socket_alloc);
+	clone_prog_fd = bpf_program__fd(skel->progs.socket_clone);
+
+	ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_sk_alloc_security"), 0, "prog count");
+	ASSERT_EQ(query_prog_cnt(cgroup_fd, NULL), 0, "total prog count");
+	err = bpf_prog_attach(alloc_prog_fd, cgroup_fd, BPF_LSM_CGROUP, 0);
+	if (!ASSERT_OK(err, "attach alloc_prog_fd"))
+		goto detach_cgroup;
+	ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_sk_alloc_security"), 1, "prog count");
+	ASSERT_EQ(query_prog_cnt(cgroup_fd, NULL), 1, "total prog count");
+
+	ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_inet_csk_clone"), 0, "prog count");
+	err = bpf_prog_attach(clone_prog_fd, cgroup_fd, BPF_LSM_CGROUP, 0);
+	if (!ASSERT_OK(err, "attach clone_prog_fd"))
+		goto detach_cgroup;
+	ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_inet_csk_clone"), 1, "prog count");
+	ASSERT_EQ(query_prog_cnt(cgroup_fd, NULL), 2, "total prog count");
+
+	/* Make sure replacing works. */
+
+	ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_socket_post_create"), 0, "prog count");
+	err = bpf_prog_attach(post_create_prog_fd, cgroup_fd,
+			      BPF_LSM_CGROUP, 0);
+	if (!ASSERT_OK(err, "attach post_create_prog_fd"))
+		goto detach_cgroup;
+	ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_socket_post_create"), 1, "prog count");
+	ASSERT_EQ(query_prog_cnt(cgroup_fd, NULL), 3, "total prog count");
+
+	attach_opts.replace_prog_fd = post_create_prog_fd;
+	err = bpf_prog_attach_opts(post_create_prog_fd2, cgroup_fd,
+				   BPF_LSM_CGROUP, &attach_opts);
+	if (!ASSERT_OK(err, "prog replace post_create_prog_fd"))
+		goto detach_cgroup;
+	ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_socket_post_create"), 1, "prog count");
+	ASSERT_EQ(query_prog_cnt(cgroup_fd, NULL), 3, "total prog count");
+
+	/* Try the same attach/replace via link API. */
+
+	ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_socket_bind"), 0, "prog count");
+	bind_link_fd = bpf_link_create(bind_prog_fd, cgroup_fd,
+				       BPF_LSM_CGROUP, NULL);
+	if (!ASSERT_GE(bind_link_fd, 0, "link create bind_prog_fd"))
+		goto detach_cgroup;
+	ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_socket_bind"), 1, "prog count");
+	ASSERT_EQ(query_prog_cnt(cgroup_fd, NULL), 4, "total prog count");
+
+	update_opts.old_prog_fd = bind_prog_fd;
+	update_opts.flags = BPF_F_REPLACE;
+
+	err = bpf_link_update(bind_link_fd, bind_prog_fd2, &update_opts);
+	if (!ASSERT_OK(err, "link update bind_prog_fd"))
+		goto detach_cgroup;
+	ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_socket_bind"), 1, "prog count");
+	ASSERT_EQ(query_prog_cnt(cgroup_fd, NULL), 4, "total prog count");
+
+	/* Attach another instance of bind program to another cgroup.
+	 * This should trigger the reuse of the trampoline shim (two
+	 * programs attaching to the same btf_id).
+	 */
+
+	ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_socket_bind"), 1, "prog count");
+	ASSERT_EQ(query_prog_cnt(cgroup_fd2, "bpf_lsm_socket_bind"), 0, "prog count");
+	bind_link_fd2 = bpf_link_create(bind_prog_fd2, cgroup_fd2,
+					BPF_LSM_CGROUP, NULL);
+	if (!ASSERT_GE(bind_link_fd2, 0, "link create bind_prog_fd2"))
+		goto detach_cgroup;
+	ASSERT_EQ(query_prog_cnt(cgroup_fd2, "bpf_lsm_socket_bind"), 1, "prog count");
+	ASSERT_EQ(query_prog_cnt(cgroup_fd, NULL), 4, "total prog count");
+	ASSERT_EQ(query_prog_cnt(cgroup_fd2, NULL), 1, "total prog count");
+
+	/* AF_UNIX is prohibited. */
+
+	fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_LT(fd, 0, "socket(AF_UNIX)");
+	close(fd);
+
+	/* AF_INET6 gets default policy (sk_priority). */
+
+	fd = socket(AF_INET6, SOCK_STREAM, 0);
+	if (!ASSERT_GE(fd, 0, "socket(SOCK_STREAM)"))
+		goto detach_cgroup;
+
+	prio = 0;
+	socklen = sizeof(prio);
+	ASSERT_GE(getsockopt(fd, SOL_SOCKET, SO_PRIORITY, &prio, &socklen), 0,
+		  "getsockopt");
+	ASSERT_EQ(prio, 123, "sk_priority");
+
+	close(fd);
+
+	/* TX-only AF_PACKET is allowed. */
+
+	ASSERT_LT(socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL)), 0,
+		  "socket(AF_PACKET, ..., ETH_P_ALL)");
+
+	fd = socket(AF_PACKET, SOCK_RAW, 0);
+	ASSERT_GE(fd, 0, "socket(AF_PACKET, ..., 0)");
+
+	/* TX-only AF_PACKET can not be rebound. */
+
+	struct sockaddr_ll sa = {
+		.sll_family = AF_PACKET,
+		.sll_protocol = htons(ETH_P_ALL),
+	};
+	ASSERT_LT(bind(fd, (struct sockaddr *)&sa, sizeof(sa)), 0,
+		  "bind(ETH_P_ALL)");
+
+	close(fd);
+
+	/* Trigger passive open. */
+
+	listen_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
+	ASSERT_GE(listen_fd, 0, "start_server");
+	client_fd = connect_to_fd(listen_fd, 0);
+	ASSERT_GE(client_fd, 0, "connect_to_fd");
+	accepted_fd = accept(listen_fd, NULL, NULL);
+	ASSERT_GE(accepted_fd, 0, "accept");
+
+	prio = 0;
+	socklen = sizeof(prio);
+	ASSERT_GE(getsockopt(accepted_fd, SOL_SOCKET, SO_PRIORITY, &prio, &socklen), 0,
+		  "getsockopt");
+	ASSERT_EQ(prio, 234, "sk_priority");
+
+	/* These are replaced and never called. */
+	ASSERT_EQ(skel->bss->called_socket_post_create, 0, "called_create");
+	ASSERT_EQ(skel->bss->called_socket_bind, 0, "called_bind");
+
+	/* AF_INET6+SOCK_STREAM
+	 * AF_PACKET+SOCK_RAW
+	 * listen_fd
+	 * client_fd
+	 * accepted_fd
+	 */
+	ASSERT_EQ(skel->bss->called_socket_post_create2, 5, "called_create2");
+
+	/* start_server
+	 * bind(ETH_P_ALL)
+	 */
+	ASSERT_EQ(skel->bss->called_socket_bind2, 2, "called_bind2");
+	/* Single accept(). */
+	ASSERT_EQ(skel->bss->called_socket_clone, 1, "called_clone");
+
+	/* AF_UNIX+SOCK_STREAM (failed)
+	 * AF_INET6+SOCK_STREAM
+	 * AF_PACKET+SOCK_RAW (failed)
+	 * AF_PACKET+SOCK_RAW
+	 * listen_fd
+	 * client_fd
+	 * accepted_fd
+	 */
+	ASSERT_EQ(skel->bss->called_socket_alloc, 7, "called_alloc");
+
+	close(listen_fd);
+	close(client_fd);
+	close(accepted_fd);
+
+	/* Make sure other cgroup doesn't trigger the programs. */
+
+	if (!ASSERT_OK(join_cgroup("/sock_policy_empty"), "join root cgroup"))
+		goto detach_cgroup;
+
+	fd = socket(AF_INET6, SOCK_STREAM, 0);
+	if (!ASSERT_GE(fd, 0, "socket(SOCK_STREAM)"))
+		goto detach_cgroup;
+
+	prio = 0;
+	socklen = sizeof(prio);
+	ASSERT_GE(getsockopt(fd, SOL_SOCKET, SO_PRIORITY, &prio, &socklen), 0,
+		  "getsockopt");
+	ASSERT_EQ(prio, 0, "sk_priority");
+
+	close(fd);
+
+detach_cgroup:
+	ASSERT_GE(bpf_prog_detach2(post_create_prog_fd2, cgroup_fd,
+				   BPF_LSM_CGROUP), 0, "detach_create");
+	close(bind_link_fd);
+	/* Don't close bind_link_fd2, exercise cgroup release cleanup. */
+	ASSERT_GE(bpf_prog_detach2(alloc_prog_fd, cgroup_fd,
+				   BPF_LSM_CGROUP), 0, "detach_alloc");
+	ASSERT_GE(bpf_prog_detach2(clone_prog_fd, cgroup_fd,
+				   BPF_LSM_CGROUP), 0, "detach_clone");
+
+close_cgroup:
+	close(cgroup_fd);
+	close(cgroup_fd2);
+	close(cgroup_fd3);
+	lsm_cgroup__destroy(skel);
+}
+
+void test_lsm_cgroup(void)
+{
+	if (test__start_subtest("functional"))
+		test_lsm_cgroup_functional();
+	btf__free(btf);
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index 1c1289ba5fc5..98dd2c4815f0 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -8,6 +8,7 @@
 #define SOL_SOCKET		1
 #define SO_SNDBUF		7
 #define __SO_ACCEPTCON		(1 << 16)
+#define SO_PRIORITY		12
 
 #define SOL_TCP			6
 #define TCP_CONGESTION		13
diff --git a/tools/testing/selftests/bpf/progs/lsm_cgroup.c b/tools/testing/selftests/bpf/progs/lsm_cgroup.c
new file mode 100644
index 000000000000..89f3b1e961a8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lsm_cgroup.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+#ifndef AF_PACKET
+#define AF_PACKET 17
+#endif
+
+#ifndef AF_UNIX
+#define AF_UNIX 1
+#endif
+
+#ifndef EPERM
+#define EPERM 1
+#endif
+
+struct {
+	__uint(type, BPF_MAP_TYPE_CGROUP_STORAGE);
+	__type(key, __u64);
+	__type(value, __u64);
+} cgroup_storage SEC(".maps");
+
+int called_socket_post_create;
+int called_socket_post_create2;
+int called_socket_bind;
+int called_socket_bind2;
+int called_socket_alloc;
+int called_socket_clone;
+
+static __always_inline int test_local_storage(void)
+{
+	__u64 *val;
+
+	val = bpf_get_local_storage(&cgroup_storage, 0);
+	if (!val)
+		return 0;
+	*val += 1;
+
+	return 1;
+}
+
+static __always_inline int real_create(struct socket *sock, int family,
+				       int protocol)
+{
+	struct sock *sk;
+	int prio = 123;
+
+	/* Reject non-tx-only AF_PACKET. */
+	if (family == AF_PACKET && protocol != 0)
+		return 0; /* EPERM */
+
+	sk = sock->sk;
+	if (!sk)
+		return 1;
+
+	/* The rest of the sockets get default policy. */
+	if (bpf_setsockopt(sk, SOL_SOCKET, SO_PRIORITY, &prio, sizeof(prio)))
+		return 0; /* EPERM */
+
+	/* Make sure bpf_getsockopt is allowed and works. */
+	prio = 0;
+	if (bpf_getsockopt(sk, SOL_SOCKET, SO_PRIORITY, &prio, sizeof(prio)))
+		return 0; /* EPERM */
+	if (prio != 123)
+		return 0; /* EPERM */
+
+	/* Can access cgroup local storage. */
+	if (!test_local_storage())
+		return 0; /* EPERM */
+
+	return 1;
+}
+
+/* __cgroup_bpf_run_lsm_socket */
+SEC("lsm_cgroup/socket_post_create")
+int BPF_PROG(socket_post_create, struct socket *sock, int family,
+	     int type, int protocol, int kern)
+{
+	called_socket_post_create++;
+	return real_create(sock, family, protocol);
+}
+
+/* __cgroup_bpf_run_lsm_socket */
+SEC("lsm_cgroup/socket_post_create")
+int BPF_PROG(socket_post_create2, struct socket *sock, int family,
+	     int type, int protocol, int kern)
+{
+	called_socket_post_create2++;
+	return real_create(sock, family, protocol);
+}
+
+static __always_inline int real_bind(struct socket *sock,
+				     struct sockaddr *address,
+				     int addrlen)
+{
+	struct sockaddr_ll sa = {};
+
+	if (sock->sk->__sk_common.skc_family != AF_PACKET)
+		return 1;
+
+	if (sock->sk->sk_kern_sock)
+		return 1;
+
+	bpf_probe_read_kernel(&sa, sizeof(sa), address);
+	if (sa.sll_protocol)
+		return 0; /* EPERM */
+
+	/* Can access cgroup local storage. */
+	if (!test_local_storage())
+		return 0; /* EPERM */
+
+	return 1;
+}
+
+/* __cgroup_bpf_run_lsm_socket */
+SEC("lsm_cgroup/socket_bind")
+int BPF_PROG(socket_bind, struct socket *sock, struct sockaddr *address,
+	     int addrlen)
+{
+	called_socket_bind++;
+	return real_bind(sock, address, addrlen);
+}
+
+/* __cgroup_bpf_run_lsm_socket */
+SEC("lsm_cgroup/socket_bind")
+int BPF_PROG(socket_bind2, struct socket *sock, struct sockaddr *address,
+	     int addrlen)
+{
+	called_socket_bind2++;
+	return real_bind(sock, address, addrlen);
+}
+
+/* __cgroup_bpf_run_lsm_current (via bpf_lsm_current_hooks) */
+SEC("lsm_cgroup/sk_alloc_security")
+int BPF_PROG(socket_alloc, struct sock *sk, int family, gfp_t priority)
+{
+	called_socket_alloc++;
+	if (family == AF_UNIX)
+		return 0; /* EPERM */
+
+	/* Can access cgroup local storage. */
+	if (!test_local_storage())
+		return 0; /* EPERM */
+
+	return 1;
+}
+
+/* __cgroup_bpf_run_lsm_sock */
+SEC("lsm_cgroup/inet_csk_clone")
+int BPF_PROG(socket_clone, struct sock *newsk, const struct request_sock *req)
+{
+	int prio = 234;
+
+	called_socket_clone++;
+
+	if (!newsk)
+		return 1;
+
+	/* Accepted request sockets get a different priority. */
+	if (bpf_setsockopt(newsk, SOL_SOCKET, SO_PRIORITY, &prio, sizeof(prio)))
+		return 0; /* EPERM */
+
+	/* Make sure bpf_getsockopt is allowed and works. */
+	prio = 0;
+	if (bpf_getsockopt(newsk, SOL_SOCKET, SO_PRIORITY, &prio, sizeof(prio)))
+		return 0; /* EPERM */
+	if (prio != 234)
+		return 0; /* EPERM */
+
+	/* Can access cgroup local storage. */
+	if (!test_local_storage())
+		return 0; /* EPERM */
+
+	return 1;
+}
-- 
2.37.0.rc0.161.g10f37bed90-goog

