Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498765079C0
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 21:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357515AbiDSTEu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 15:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357525AbiDSTEF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 15:04:05 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073DA3F8A8
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 12:01:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2ebf1d99068so155358987b3.9
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 12:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7FEbUMCmq3os2Yda/eEiHufzKdbzHqu7v9kf+ItQjhA=;
        b=OVFj2O/jmF37yyWx1bCZqitlC9OSfN8rt9YbFUCGV8uko2CMB45Xgqmvw2WI9k7jo2
         j51v8ehbBomHOrXhi+4iSB6zngbwNhlKA2gQvOpIVAuXUxeVFqmzt3k2pku4juwFLci9
         ghEKQ3wyNCWL6C2zmfov7p3XEMWcMap8emFRAaQ+7ikG8d1DvqTKUE9VVUWPSO/CCkeL
         N92KKhcuAYKVMaDDI4DMHyAZd6Y8KzsEngX5Y2853vo6KpxASD+x+kauxccgqdcHF82b
         dU/KqLlq4PxGddwapAo9DJfHOSYu+wksODJY9A5SKRcwHTWsMNtN2AA88DTv8DdiC8Bs
         1Ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7FEbUMCmq3os2Yda/eEiHufzKdbzHqu7v9kf+ItQjhA=;
        b=UiPuCEqtzey1zuHGy24nZEgNyIPnqRtmzFdQ8lloIdaPeUBWXD3LP93bg/8gwuamgV
         2Hom2JTn9JkRD1/rmQG9gVwQ2FsiF81/It6XrPdlvq/q3SGRE/6KF9fZHazw0B/Jt4o+
         +8C+u19S4+xDqIOhQLABok4kjXTUsnlZO4/DRUWx57QbLzNCwCGYoQC7SOPdzZ39togG
         26Gu3ISUADfh+EDsnl4Yvea+8keKk1Hs4DCw6rhsxlY5QsjZ7hUkZ4KT/8GlesITBnvi
         PV2wr7WcyqS/p9dLUYD24VZhDiMchRLbogvDYP8SjxpgB7kOE8suelm1anHY5euhBRMO
         7wnw==
X-Gm-Message-State: AOAM5306CskNrRyBHvrlwX6eXFj9gwyphD0WkThCTkGqezshp9qAGZLA
        onVR2XIpC4b7c9TclIVaY/K7hQo=
X-Google-Smtp-Source: ABdhPJzySR8R/wgZlQEwxQexYL8k++2PDSdxvQVuzK8L3wIV+ySYwKbC6M5oTl57KrYVaR1zZGVzwrE=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:37f:6746:8e66:a291])
 (user=sdf job=sendgmr) by 2002:a25:41cf:0:b0:641:1857:ac7c with SMTP id
 o198-20020a2541cf000000b006411857ac7cmr16662119yba.281.1650394874254; Tue, 19
 Apr 2022 12:01:14 -0700 (PDT)
Date:   Tue, 19 Apr 2022 12:00:52 -0700
In-Reply-To: <20220419190053.3395240-1-sdf@google.com>
Message-Id: <20220419190053.3395240-8-sdf@google.com>
Mime-Version: 1.0
References: <20220419190053.3395240-1-sdf@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH bpf-next v5 7/8] selftests/bpf: lsm_cgroup functional test
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>
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
 .../selftests/bpf/prog_tests/lsm_cgroup.c     | 213 ++++++++++++++++++
 .../testing/selftests/bpf/progs/lsm_cgroup.c  | 126 +++++++++++
 2 files changed, 339 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_cgroup.c

diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
new file mode 100644
index 000000000000..fbd6ed29f7d4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <test_progs.h>
+
+#include "lsm_cgroup.skel.h"
+#include "cgroup_helpers.h"
+#include "network_helpers.h"
+
+void test_lsm_cgroup(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_prog_attach_opts, attach_opts);
+	DECLARE_LIBBPF_OPTS(bpf_link_update_opts, update_opts);
+	int cgroup_fd, cgroup_fd2, err, fd, prio;
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
+	socklen_t socklen;
+
+	cgroup_fd = test__join_cgroup("/sock_policy");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		goto close_skel;
+
+	cgroup_fd2 = create_and_get_cgroup("/sock_policy2");
+	if (!ASSERT_GE(cgroup_fd2, 0, "create second cgroup"))
+		goto close_skel;
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
+	err = bpf_prog_attach(alloc_prog_fd, cgroup_fd, BPF_LSM_CGROUP, 0);
+	if (!ASSERT_OK(err, "attach alloc_prog_fd"))
+		goto detach_cgroup;
+
+	err = bpf_prog_attach(clone_prog_fd, cgroup_fd, BPF_LSM_CGROUP, 0);
+	if (!ASSERT_OK(err, "attach clone_prog_fd"))
+		goto detach_cgroup;
+
+	/* Make sure replacing works.
+	 */
+
+	err = bpf_prog_attach(post_create_prog_fd, cgroup_fd,
+			      BPF_LSM_CGROUP, 0);
+	if (!ASSERT_OK(err, "attach post_create_prog_fd"))
+		goto close_cgroup;
+
+	attach_opts.replace_prog_fd = post_create_prog_fd;
+	err = bpf_prog_attach_opts(post_create_prog_fd2, cgroup_fd,
+				   BPF_LSM_CGROUP, &attach_opts);
+	if (!ASSERT_OK(err, "prog replace post_create_prog_fd"))
+		goto detach_cgroup;
+
+	/* Try the same attach/replace via link API.
+	 */
+
+	bind_link_fd = bpf_link_create(bind_prog_fd, cgroup_fd,
+				       BPF_LSM_CGROUP, NULL);
+	if (!ASSERT_GE(bind_link_fd, 0, "link create bind_prog_fd"))
+		goto detach_cgroup;
+
+	update_opts.old_prog_fd = bind_prog_fd;
+	update_opts.flags = BPF_F_REPLACE;
+
+	err = bpf_link_update(bind_link_fd, bind_prog_fd2, &update_opts);
+	if (!ASSERT_OK(err, "link update bind_prog_fd"))
+		goto detach_cgroup;
+
+	/* Attach another instance of bind program to another cgroup.
+	 * This should trigger the reuse of the trampoline shim (two
+	 * programs attaching to the same btf_id).
+	 */
+
+	bind_link_fd2 = bpf_link_create(bind_prog_fd2, cgroup_fd2,
+					BPF_LSM_CGROUP, NULL);
+	if (!ASSERT_GE(bind_link_fd2, 0, "link create bind_prog_fd2"))
+		goto detach_cgroup;
+
+	/* AF_UNIX is prohibited.
+	 */
+
+	fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_LT(fd, 0, "socket(AF_UNIX)");
+
+	/* AF_INET6 gets default policy (sk_priority).
+	 */
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
+	/* TX-only AF_PACKET is allowed.
+	 */
+
+	ASSERT_LT(socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL)), 0,
+		  "socket(AF_PACKET, ..., ETH_P_ALL)");
+
+	fd = socket(AF_PACKET, SOCK_RAW, 0);
+	ASSERT_GE(fd, 0, "socket(AF_PACKET, ..., 0)");
+
+	/* TX-only AF_PACKET can not be rebound.
+	 */
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
+	/* Trigger passive open.
+	 */
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
+	/* Make sure other cgroup doesn't trigger the programs.
+	 */
+
+	if (!ASSERT_OK(join_cgroup(""), "join root cgroup"))
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
+close_skel:
+	lsm_cgroup__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/lsm_cgroup.c b/tools/testing/selftests/bpf/progs/lsm_cgroup.c
new file mode 100644
index 000000000000..70f4ffd90d49
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lsm_cgroup.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
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
+int called_socket_post_create;
+int called_socket_post_create2;
+int called_socket_bind;
+int called_socket_bind2;
+int called_socket_alloc;
+int called_socket_clone;
+
+static __always_inline int real_create(struct socket *sock, int family,
+				       int protocol)
+{
+	struct sock *sk;
+
+	/* Reject non-tx-only AF_PACKET.
+	 */
+	if (family == AF_PACKET && protocol != 0)
+		return 0; /* EPERM */
+
+	sk = sock->sk;
+	if (!sk)
+		return 1;
+
+	/* The rest of the sockets get default policy.
+	 */
+	sk->sk_priority = 123;
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
+	return 1;
+}
+
+/* __cgroup_bpf_run_lsm_sock */
+SEC("lsm_cgroup/inet_csk_clone")
+int BPF_PROG(socket_clone, struct sock *newsk, const struct request_sock *req)
+{
+	called_socket_clone++;
+
+	if (!newsk)
+		return 1;
+
+	/* Accepted request sockets get a different priority.
+	 */
+	newsk->sk_priority = 234;
+	return 1;
+}
-- 
2.36.0.rc0.470.gd361397f0d-goog

