Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D3B64F6DD
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 02:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiLQB6T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 20:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiLQB5y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 20:57:54 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69A023381
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 17:57:51 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id x2so3943679plb.13
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 17:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyQ+FFmbgko7U/NYm4WQvgLlWIvQ5jaACCw9RDLQDlQ=;
        b=CHGR/znC3HqI6gfTLQ+U0hUhyIJ9Jg355DJyJnrfwHNK7pavp1DHjTba/dM12Hy0K6
         3nP3mNUZ2tWyEke7TJDs81ksyYbkrYU92jDayUECPrCIXp7PSZt2Y2+M5xXp6Fe/vdNW
         0HNd04EmXcbyOP6nlENkDB1QajRrURskwt9n2uq3hhEscpc4uevHA4zeWpDVDdpulxBA
         tVoK3avjw4aH9UFrYVtZIMBiNIJ2uU9vHbnbK2LhUkMCS2BNBiSi+IpEZp9WuxKdNtHm
         eJ1vpi9ljsJr3AG5N1esnGXTvp5ViAr0jqzSLbDlnesEMVvMjDBnUIfl5Wgnah/ALb7Y
         ENHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyQ+FFmbgko7U/NYm4WQvgLlWIvQ5jaACCw9RDLQDlQ=;
        b=pGVX7tOjixRswKvw+YCTidZtAx+h63Xvezum6/ha2BPJT8Ngl29Fn3tZmdBKmIcbdv
         W2Zzh3y7VwZBFHgO78Yw6DNDr5jkyO67VAHwS7ce7lDrjCuVP7gm6OrJ2eltB9YJZTNi
         WCwnA56u/HnNmYccpI/nuGCo5dYOGC5RlVTQ50X9c59KTDhc92CZZ6Z17OeUDqGOjx4H
         XYJeln/KcA2Km2nQ628Se0sjtueHda544YkRtyj878J3AFQq9qiiKBO+oBGIfz67oSaf
         Jcp8MWPld9NM/jiDjbh3goWqkTTuK1pnirgWsu56E16Ty5W9d9ELmdeBI/RErQgZAGry
         qBdQ==
X-Gm-Message-State: ANoB5pkTNE04lRIRDGrpxfd3KC+baE4Y5u907ng5S/CChDXZ0rICRQD+
        1kbjpskIBzOyo/8KsQhpwVrQ1Gi3haczStw8xun5UfFDu8E=
X-Google-Smtp-Source: AA0mqf5O4BKVtAtoj9oAJaN/1DBehWeMuoYeuRyI9IU8esWGp2+Kx/yugBMOSbM4UEo8QRIDaFj2ig==
X-Received: by 2002:a17:90b:1181:b0:219:c87a:6926 with SMTP id gk1-20020a17090b118100b00219c87a6926mr34874686pjb.26.1671242271063;
        Fri, 16 Dec 2022 17:57:51 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090a1f4a00b001ef8ab65052sm1924994pjy.11.2022.12.16.17.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 17:57:50 -0800 (PST)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        Aditi Ghag <aditi.ghag@isovalent.com>
Subject: [PATCH 2/2] selftests/bpf: Add tests for bpf_sock_destroy
Date:   Sat, 17 Dec 2022 01:57:18 +0000
Message-Id: <16c81434c64f1c2a5d10e06c7199cc4715e467a0.1671242108.git.aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1671242108.git.aditi.ghag@isovalent.com>
References: <cover.1671242108.git.aditi.ghag@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The test cases for TCP and UDP mirror the
intended usages of the helper.

As the helper destroys sockets asynchronously,
the tests have sleep invocation before validating
if the sockets were destroyed by sending data.

Also, while all the protocol specific helpers
set `ECONNABORTED` error code on the destroyed sockets,
only the TCP test case has the validation check. UDP
sockets have an overriding error code from the disconnect
call during abort.

Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
---
 .../selftests/bpf/prog_tests/sock_destroy.c   | 131 ++++++++++++++++++
 .../selftests/bpf/progs/sock_destroy_prog.c   |  96 +++++++++++++
 2 files changed, 227 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
new file mode 100644
index 000000000000..b920f4501809
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+#include "sock_destroy_prog.skel.h"
+#include "network_helpers.h"
+
+#define ECONNABORTED 103
+
+static int duration;
+
+static void start_iter_sockets(struct bpf_program *prog)
+{
+	struct bpf_link *link;
+	char buf[16] = {};
+	int iter_fd, len;
+
+	link = bpf_program__attach_iter(prog, NULL);
+	if (!ASSERT_OK_PTR(link, "attach_iter"))
+		return;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
+		goto free_link;
+
+	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
+		;
+	CHECK(len < 0, "read", "read failed: %s\n", strerror(errno));
+
+	close(iter_fd);
+
+free_link:
+	bpf_link__destroy(link);
+}
+
+void test_tcp(struct sock_destroy_prog *skel)
+{
+	int serv = -1, clien = -1, n = 0;
+
+	serv = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
+	if (CHECK(serv < 0, "start_server", "failed to start server\n"))
+		goto cleanup_serv;
+
+	clien = connect_to_fd(serv, 0);
+	if (CHECK(clien < 0, "connect_to_fd", "errno %d\n", errno))
+		goto cleanup_serv;
+
+	serv = accept(serv, NULL, NULL);
+	if (CHECK(serv < 0, "accept", "errno %d\n", errno))
+		goto cleanup;
+
+	n = send(clien, "t", 1, 0);
+	if (CHECK(n < 0, "client_send", "client failed to send on socket\n"))
+		goto cleanup;
+
+	start_iter_sockets(skel->progs.iter_tcp6);
+
+	// Sockets are destroyed asynchronously.
+	usleep(1000);
+	n = send(clien, "t", 1, 0);
+
+	if (CHECK(n > 0, "client_send", "succeeded on destroyed socket\n"))
+		goto cleanup;
+	CHECK(errno != ECONNABORTED, "client_send", "unexpected error code on destroyed socket\n");
+
+
+cleanup:
+	close(clien);
+cleanup_serv:
+	close(serv);
+}
+
+
+void test_udp(struct sock_destroy_prog *skel)
+{
+	int serv = -1, clien = -1, n = 0;
+
+	serv = start_server(AF_INET6, SOCK_DGRAM, NULL, 0, 0);
+	if (CHECK(serv < 0, "start_server", "failed to start server\n"))
+		goto cleanup_serv;
+
+	clien = connect_to_fd(serv, 0);
+	if (CHECK(clien < 0, "connect_to_fd", "errno %d\n", errno))
+		goto cleanup_serv;
+
+	n = send(clien, "t", 1, 0);
+	if (CHECK(n < 0, "client_send", "client failed to send on socket\n"))
+		goto cleanup;
+
+	start_iter_sockets(skel->progs.iter_udp6);
+
+	// Sockets are destroyed asynchronously.
+	usleep(1000);
+
+	n = send(clien, "t", 1, 0);
+	if (CHECK(n > 0, "client_send", "succeeded on destroyed socket\n"))
+		goto cleanup;
+	// UDP sockets have an overriding error code after they are disconnected.
+
+
+cleanup:
+	close(clien);
+cleanup_serv:
+	close(serv);
+}
+
+void test_sock_destroy(void)
+{
+	int cgroup_fd = 0;
+	struct sock_destroy_prog *skel;
+
+	skel = sock_destroy_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	cgroup_fd = test__join_cgroup("/sock_destroy");
+	if (CHECK(cgroup_fd < 0, "join_cgroup", "cgroup creation failed\n"))
+		goto close_cgroup_fd;
+
+	skel->links.sock_connect = bpf_program__attach_cgroup(
+		skel->progs.sock_connect, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.sock_connect, "prog_attach"))
+		goto close_cgroup_fd;
+
+	test_tcp(skel);
+	test_udp(skel);
+
+
+close_cgroup_fd:
+	close(cgroup_fd);
+	sock_destroy_prog__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_prog.c b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
new file mode 100644
index 000000000000..ec566033f41f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+
+#define AF_INET6 10
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} tcp_conn_sockets SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} udp_conn_sockets SEC(".maps");
+
+SEC("cgroup/connect6")
+int sock_connect(struct bpf_sock_addr *ctx)
+{
+	int key = 0;
+	__u64 sock_cookie = 0;
+	__u32 keyc = 0;
+
+	if (ctx->family != AF_INET6 || ctx->user_family != AF_INET6)
+		return 1;
+
+	sock_cookie = bpf_get_socket_cookie(ctx);
+	if (ctx->protocol == IPPROTO_TCP)
+		bpf_map_update_elem(&tcp_conn_sockets, &key, &sock_cookie, 0);
+	else if (ctx->protocol == IPPROTO_UDP)
+		bpf_map_update_elem(&udp_conn_sockets, &keyc, &sock_cookie, 0);
+	else
+		return 1;
+
+	return 1;
+}
+
+SEC("iter/tcp")
+int iter_tcp6(struct bpf_iter__tcp *ctx)
+{
+	struct sock_common *sk_common = ctx->sk_common;
+	struct seq_file *seq = ctx->meta->seq;
+	__u64 sock_cookie = 0;
+	__u64 *val;
+	int key = 0;
+
+	if (!sk_common)
+		return 0;
+
+	if (sk_common->skc_family != AF_INET6)
+		return 0;
+
+	sock_cookie  = bpf_get_socket_cookie(sk_common);
+	val = bpf_map_lookup_elem(&tcp_conn_sockets, &key);
+
+	if (!val)
+		return 0;
+
+	if (sock_cookie == *val)
+		bpf_sock_destroy(sk_common);
+
+	return 0;
+}
+
+SEC("iter/udp")
+int iter_udp6(struct bpf_iter__udp *ctx)
+{
+	struct seq_file *seq = ctx->meta->seq;
+	struct udp_sock *udp_sk = ctx->udp_sk;
+	struct sock *sk = (struct sock *) udp_sk;
+	__u64 sock_cookie = 0;
+	int key = 0;
+	__u64 *val;
+
+	if (!sk)
+		return 0;
+
+	sock_cookie  = bpf_get_socket_cookie(sk);
+	val = bpf_map_lookup_elem(&udp_conn_sockets, &key);
+
+	if (!val)
+		return 0;
+
+	if (sock_cookie == *val)
+		bpf_sock_destroy(sk);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1

