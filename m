Return-Path: <bpf+bounces-2441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE2972CF39
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 21:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857B91C20BB8
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 19:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F0F8F53;
	Mon, 12 Jun 2023 19:16:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B671A8F50
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 19:16:57 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208D6171F
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 12:16:54 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6b2d356530eso1812318a34.0
        for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 12:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686597412; x=1689189412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oc8DsBUETCvIPXIc9Auy78NswSPshB6nTU0jpX+nuxA=;
        b=Yu9odbmPAdSl2y2BDwmoo4ii6y0rxhHedePOMJxNCvcnxSrVreAeKs3yg3Yj8nbGPm
         wZaFoUOgEHDGYIiIv1tlDxDCVwXignKg9m0xcCXwLvWHOmHQ88f0oXA1CXZlj/UD43Oo
         GrK1ZjX2iSm+20m0vAITVXd+CwomqNL7vl2Nt3k8K6UBW8BrToEQeh8QDZC10wZjnBag
         nBwSBD8HdEkoGVOWyOfS7JhUG/GcubCysBKaUep7AHV3LABwfR1/DoY2y0RKXT0C8WcB
         +KbxfUHb3Yd+RU3mRBHTVJUbBSsuDlzYP4poxOf840CP0FGbKLu1izgAKAIypP6CnNX7
         FkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686597412; x=1689189412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oc8DsBUETCvIPXIc9Auy78NswSPshB6nTU0jpX+nuxA=;
        b=bY5Kerxt6Xfcxww8uAkFUfkggLzIbt8wdz6LYSSW2a2cDy4v0UN0yuINrW3FTXcRhA
         AS72PtaT9HesqJhUouvgJQ2rINC36XK6b4zm3N2UypykTF5lgAauPK/rg3VlFAew/mTL
         9b8lX7PJwBOk/w5QHAgA2Lhc7NhSuwhTwA6b/E0Y80AY2eZIzZkrEkbCum5z6PTUO2/d
         5HDQCRaURUp8jq0vh/+YB8nKZwudgDN2jVIv5xzy1/TQmzU1hehO9Smkqf1ChscRJMFX
         rvnKoQaS35EKDQEdu1KdeshkhrXyXTxkj9JeIO/A5zKlZnoQtRGEGGezbofZhFY98kCZ
         FZPQ==
X-Gm-Message-State: AC+VfDx/RvIULYmyj8Tz1SWIhlUKCZL9GWNkwtK0jhKitNar2uv2I2In
	vyV/x51L5yZ1R4vk8ANBqngwFig4tno=
X-Google-Smtp-Source: ACHHUZ7xAHnWwT/4vOTJZ6Y2ZnrYZYHVFd77xS9EFwksxWBD6A5lYQsOzelCjTwv/FGEhXT6uhnPNw==
X-Received: by 2002:a05:6830:61c:b0:6b0:c7fa:2c1c with SMTP id w28-20020a056830061c00b006b0c7fa2c1cmr6510562oti.5.1686597412127;
        Mon, 12 Jun 2023 12:16:52 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:df5d:2d08:1aa:9ce3])
        by smtp.gmail.com with ESMTPSA id y14-20020a25ad0e000000b00bc6a712c523sm1292607ybi.64.2023.06.12.12.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 12:16:51 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
X-Google-Original-From: Kui-Feng Lee <kuifeng@meta.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	daniel@iogearbox.net
Cc: Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Verify that the cgroup_skb filters receive expected packets.
Date: Mon, 12 Jun 2023 12:16:41 -0700
Message-Id: <20230612191641.441774-3-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612191641.441774-1-kuifeng@meta.com>
References: <20230612191641.441774-1-kuifeng@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This test case includes four scenarios:
1. Connect to the server from outside the cgroup and close the connection
   from outside the cgroup.
2. Connect to the server from outside the cgroup and close the connection
   from inside the cgroup.
3. Connect to the server from inside the cgroup and close the connection
   from outside the cgroup.
4. Connect to the server from inside the cgroup and close the connection
   from inside the cgroup.

The test case is to verify that cgroup_skb/{egress, ingress} filters
receive expected packets including SYN, SYN/ACK, ACK, FIN, and FIN/ACK.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c  |  12 +
 tools/testing/selftests/bpf/cgroup_helpers.h  |   1 +
 tools/testing/selftests/bpf/cgroup_tcp_skb.h  |  35 ++
 .../selftests/bpf/prog_tests/cgroup_tcp_skb.c | 363 ++++++++++++++++++
 .../selftests/bpf/progs/cgroup_tcp_skb.c      | 340 ++++++++++++++++
 5 files changed, 751 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/cgroup_tcp_skb.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_tcp_skb.c

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 9e95b37a7dff..2caee8423ee0 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -277,6 +277,18 @@ int join_cgroup(const char *relative_path)
 	return join_cgroup_from_top(cgroup_path);
 }
 
+/**
+ * join_root_cgroup() - Join the root cgroup
+ *
+ * This function joins the root cgroup.
+ *
+ * On success, it returns 0, otherwise on failure it returns 1.
+ */
+int join_root_cgroup(void)
+{
+	return join_cgroup_from_top(CGROUP_MOUNT_PATH);
+}
+
 /**
  * join_parent_cgroup() - Join a cgroup in the parent process workdir
  * @relative_path: The cgroup path, relative to parent process workdir, to join
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing/selftests/bpf/cgroup_helpers.h
index f099a166c94d..5c2cb9c8b546 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -22,6 +22,7 @@ void remove_cgroup(const char *relative_path);
 unsigned long long get_cgroup_id(const char *relative_path);
 
 int join_cgroup(const char *relative_path);
+int join_root_cgroup(void);
 int join_parent_cgroup(const char *relative_path);
 
 int setup_cgroup_environment(void);
diff --git a/tools/testing/selftests/bpf/cgroup_tcp_skb.h b/tools/testing/selftests/bpf/cgroup_tcp_skb.h
new file mode 100644
index 000000000000..1054b3633983
--- /dev/null
+++ b/tools/testing/selftests/bpf/cgroup_tcp_skb.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2023 Facebook */
+
+/* Define states of a socket to tracking messages sending to and from the
+ * socket.
+ *
+ * These states are based on rfc9293 with some modifications to support
+ * tracking of messages sent out from a socket. For example, when a SYN is
+ * received, a new socket is transiting to the SYN_RECV state defined in
+ * rfc9293. But, we put it in SYN_RECV_SENDING_SYN_ACK state and when
+ * SYN-ACK is sent out, it moves to SYN_RECV state. With this modification,
+ * we can track the message sent out from a socket.
+ */
+
+#ifndef __CGROUP_TCP_SKB_H__
+#define __CGROUP_TCP_SKB_H__
+
+enum {
+	INIT,
+	CLOSED,
+	SYN_SENT,
+	SYN_RECV_SENDING_SYN_ACK,
+	SYN_RECV,
+	ESTABLISHED,
+	FIN_WAIT1,
+	FIN_WAIT2,
+	CLOSE_WAIT_SENDING_ACK,
+	CLOSE_WAIT,
+	CLOSING,
+	LAST_ACK,
+	TIME_WAIT_SENDING_ACK,
+	TIME_WAIT,
+};
+
+#endif /* __CGROUP_TCP_SKB_H__ */
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c b/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
new file mode 100644
index 000000000000..399e8f8199e0
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Facebook */
+#include <test_progs.h>
+#include <linux/in6.h>
+#include <sys/socket.h>
+#include <sched.h>
+#include <unistd.h>
+#include "cgroup_helpers.h"
+#include "testing_helpers.h"
+#include "cgroup_tcp_skb.skel.h"
+#include "cgroup_tcp_skb.h"
+
+#define CGROUP_TCP_SKB_PATH "/test_cgroup_tcp_skb"
+static __u32 duration;
+
+static int install_filters(int cgroup_fd,
+			   struct bpf_link **egress_link,
+			   struct bpf_link **ingress_link,
+			   struct bpf_program *egress_prog,
+			   struct bpf_program *ingress_prog,
+			   struct cgroup_tcp_skb *skel)
+{
+	/* Prepare filters */
+	skel->bss->g_sock_state = 0;
+	skel->bss->g_unexpected = 0;
+	*egress_link =
+		bpf_program__attach_cgroup(egress_prog,
+					   cgroup_fd);
+	if (!ASSERT_NEQ(*egress_link, NULL, "egress_link"))
+		return -1;
+	*ingress_link =
+		bpf_program__attach_cgroup(ingress_prog,
+					   cgroup_fd);
+	if (!ASSERT_NEQ(*ingress_link, NULL, "ingress_link"))
+		return -1;
+
+	return 0;
+}
+
+static void uninstall_filters(struct bpf_link **egress_link,
+			      struct bpf_link **ingress_link)
+{
+	bpf_link__destroy(*egress_link);
+	*egress_link = NULL;
+	bpf_link__destroy(*ingress_link);
+	*ingress_link = NULL;
+}
+
+static int create_client_sock_v6(void)
+{
+	int fd;
+
+	fd = socket(AF_INET6, SOCK_STREAM, 0);
+	if (fd < 0) {
+		perror("socket");
+		return -1;
+	}
+
+	return fd;
+}
+
+static int create_server_sock_v6(void)
+{
+	struct sockaddr_in6 addr = {
+		.sin6_family = AF_INET6,
+		.sin6_port = htons(0),
+		.sin6_addr = IN6ADDR_LOOPBACK_INIT,
+	};
+	int fd, err;
+
+	fd = socket(AF_INET6, SOCK_STREAM, 0);
+	if (fd < 0) {
+		perror("socket");
+		return -1;
+	}
+
+	err = bind(fd, (struct sockaddr *)&addr, sizeof(addr));
+	if (err < 0) {
+		perror("bind");
+		return -1;
+	}
+
+	err = listen(fd, 1);
+	if (err < 0) {
+		perror("listen");
+		return -1;
+	}
+
+	return fd;
+}
+
+static int get_sock_port_v6(int fd)
+{
+	struct sockaddr_in6 addr;
+	socklen_t len;
+	int err;
+
+	len = sizeof(addr);
+	err = getsockname(fd, (struct sockaddr *)&addr, &len);
+	if (err < 0) {
+		perror("getsockname");
+		return -1;
+	}
+
+	return ntohs(addr.sin6_port);
+}
+
+static int connect_client_server_v6(int client_fd, int listen_fd)
+{
+	struct sockaddr_in6 addr = {
+		.sin6_family = AF_INET6,
+		.sin6_addr = IN6ADDR_LOOPBACK_INIT,
+	};
+	int err;
+
+	addr.sin6_port = htons(get_sock_port_v6(listen_fd));
+	if (addr.sin6_port < 0)
+		return -1;
+
+	err = connect(client_fd, (struct sockaddr *)&addr, sizeof(addr));
+	if (err < 0) {
+		perror("connect");
+		return -1;
+	}
+
+	return 0;
+}
+
+/* Connect to the server in a cgroup from the outside of the cgroup. */
+static int talk_to_cgroup(int *client_fd, int *listen_fd, int *service_fd,
+			  struct cgroup_tcp_skb *skel)
+{
+	int err, cp;
+	char buf[5];
+
+	/* Create client & server socket */
+	err = join_root_cgroup();
+	if (CHECK(err, "join_root_cgroup", "failed: %d\n", err))
+		return -1;
+	*client_fd = create_client_sock_v6();
+	if (!ASSERT_GE(*client_fd, 0, "client_fd"))
+		return -1;
+	err = join_cgroup(CGROUP_TCP_SKB_PATH);
+	if (CHECK(err, "join_cgroup", "failed: %d\n", err))
+		return -1;
+	*listen_fd = create_server_sock_v6();
+	if (!ASSERT_GE(*listen_fd, 0, "listen_fd"))
+		return -1;
+	skel->bss->g_sock_port = get_sock_port_v6(*listen_fd);
+
+	/* Connect client to server */
+	err = connect_client_server_v6(*client_fd, *listen_fd);
+	if (CHECK(err, "connect_client_server_v6", "failed: %d\n", err))
+		return -1;
+	*service_fd = accept(*listen_fd, NULL, NULL);
+	if (!ASSERT_GE(*service_fd, 0, "service_fd"))
+		return -1;
+	err = join_root_cgroup();
+	if (CHECK(err, "join_root_cgroup", "failed: %d\n", err))
+		return -1;
+	cp = write(*client_fd, "hello", 5);
+	if (!ASSERT_EQ(cp, 5, "write"))
+		return -1;
+	cp = read(*service_fd, buf, 5);
+	if (!ASSERT_EQ(cp, 5, "read"))
+		return -1;
+
+	return 0;
+}
+
+/* Connect to the server out of a cgroup from inside the cgroup. */
+static int talk_to_outside(int *client_fd, int *listen_fd, int *service_fd,
+			   struct cgroup_tcp_skb *skel)
+
+{
+	int err, cp;
+	char buf[5];
+
+	/* Create client & server socket */
+	err = join_root_cgroup();
+	if (CHECK(err, "join_root_cgroup", "failed: %d\n", err))
+		return -1;
+	*listen_fd = create_server_sock_v6();
+	if (!ASSERT_GE(*listen_fd, 0, "listen_fd"))
+		return -1;
+	err = join_cgroup(CGROUP_TCP_SKB_PATH);
+	if (CHECK(err, "join_cgroup", "failed: %d\n", err))
+		return -1;
+	*client_fd = create_client_sock_v6();
+	if (!ASSERT_GE(*client_fd, 0, "client_fd"))
+		return -1;
+	err = join_root_cgroup();
+	if (CHECK(err, "join_root_cgroup", "failed: %d\n", err))
+		return -1;
+	skel->bss->g_sock_port = get_sock_port_v6(*listen_fd);
+
+	/* Connect client to server */
+	err = connect_client_server_v6(*client_fd, *listen_fd);
+	if (CHECK(err, "connect_client_server_v6", "failed: %d\n", err))
+		return -1;
+	*service_fd = accept(*listen_fd, NULL, NULL);
+	if (!ASSERT_GE(*service_fd, 0, "service_fd"))
+		return -1;
+	cp = write(*client_fd, "hello", 5);
+	if (!ASSERT_EQ(cp, 5, "write"))
+		return -1;
+	cp = read(*service_fd, buf, 5);
+	if (!ASSERT_EQ(cp, 5, "read"))
+		return -1;
+
+	return 0;
+}
+
+static int close_connection(int *closing_fd, int *peer_fd, int *listen_fd)
+{
+	int err;
+
+	/* Half shutdown to make sure the closing socket having a chance to
+	 * receive a FIN from the client.
+	 */
+	err = shutdown(*closing_fd, SHUT_WR);
+	if (CHECK(err, "shutdown closing_fd", "failed: %d\n", err))
+		return -1;
+	usleep(100000);
+	err = close(*peer_fd);
+	if (CHECK(err, "close peer_fd", "failed: %d\n", err))
+		return -1;
+	*peer_fd = -1;
+	usleep(100000);
+	err = close(*closing_fd);
+	if (CHECK(err, "close closing_fd", "failed: %d\n", err))
+		return -1;
+	*closing_fd = -1;
+
+	close(*listen_fd);
+	*listen_fd = -1;
+
+	return 0;
+}
+
+/* This test case includes four scenarios:
+ * 1. Connect to the server from outside the cgroup and close the connection
+ *    from outside the cgroup.
+ * 2. Connect to the server from outside the cgroup and close the connection
+ *    from inside the cgroup.
+ * 3. Connect to the server from inside the cgroup and close the connection
+ *    from outside the cgroup.
+ * 4. Connect to the server from inside the cgroup and close the connection
+ *    from inside the cgroup.
+ *
+ * The test case is to verify that cgroup_skb/{egress,ingress} filters
+ * receive expected packets including SYN, SYN/ACK, ACK, FIN, and FIN/ACK.
+ */
+void test_cgroup_tcp_skb(void)
+{
+	struct bpf_link *ingress_link = NULL;
+	struct bpf_link *egress_link = NULL;
+	int client_fd = -1, listen_fd = -1;
+	struct cgroup_tcp_skb *skel;
+	int service_fd = -1;
+	int cgroup_fd = -1;
+	int err;
+
+	err = setup_cgroup_environment();
+	if (CHECK(err, "setup_cgroup_environment", "failed: %d\n", err))
+		return;
+
+	cgroup_fd = create_and_get_cgroup(CGROUP_TCP_SKB_PATH);
+	if (!ASSERT_GE(cgroup_fd, 0, "cgroup_fd"))
+		goto cleanup;
+
+	skel = cgroup_tcp_skb__open_and_load();
+	if (CHECK(!skel, "skel_open_load", "failed to open/load skeleton\n"))
+		return;
+
+	/* Scenario 1 */
+	err = install_filters(cgroup_fd, &egress_link, &ingress_link,
+			      skel->progs.server_egress,
+			      skel->progs.server_ingress,
+			      skel);
+	if (CHECK(err, "install_filters", "failed\n"))
+		goto cleanup;
+
+	err = talk_to_cgroup(&client_fd, &listen_fd, &service_fd, skel);
+	if (CHECK(err, "talk_to_cgroup", "failed\n"))
+		goto cleanup;
+
+	err = close_connection(&client_fd, &service_fd, &listen_fd);
+	if (CHECK(err, "close_connection", "failed\n"))
+		goto cleanup;
+
+	ASSERT_EQ(skel->bss->g_unexpected, 0, "g_unexpected");
+	ASSERT_EQ(skel->bss->g_sock_state, CLOSED, "g_sock_state");
+
+	uninstall_filters(&egress_link, &ingress_link);
+
+	/* Scenario 2 */
+	err = install_filters(cgroup_fd, &egress_link, &ingress_link,
+			      skel->progs.server_egress_srv,
+			      skel->progs.server_ingress_srv,
+			      skel);
+
+	err = talk_to_cgroup(&client_fd, &listen_fd, &service_fd, skel);
+	if (CHECK(err, "talk_to_cgroup", "failed\n"))
+		goto cleanup;
+
+	err = close_connection(&service_fd, &client_fd, &listen_fd);
+	if (CHECK(err, "close_connection", "failed\n"))
+		goto cleanup;
+
+	ASSERT_EQ(skel->bss->g_unexpected, 0, "g_unexpected");
+	ASSERT_EQ(skel->bss->g_sock_state, TIME_WAIT, "g_sock_state");
+
+	uninstall_filters(&egress_link, &ingress_link);
+
+	/* Scenario 3 */
+	err = install_filters(cgroup_fd, &egress_link, &ingress_link,
+			      skel->progs.client_egress_srv,
+			      skel->progs.client_ingress_srv,
+			      skel);
+
+	err = talk_to_outside(&client_fd, &listen_fd, &service_fd, skel);
+	if (CHECK(err, "talk_to_outside", "failed\n"))
+		goto cleanup;
+
+	err = close_connection(&service_fd, &client_fd, &listen_fd);
+	if (CHECK(err, "close_connection", "failed\n"))
+		goto cleanup;
+
+	ASSERT_EQ(skel->bss->g_unexpected, 0, "g_unexpected");
+	ASSERT_EQ(skel->bss->g_sock_state, CLOSED, "g_sock_state");
+
+	uninstall_filters(&egress_link, &ingress_link);
+
+	/* Scenario 4 */
+	err = install_filters(cgroup_fd, &egress_link, &ingress_link,
+			      skel->progs.client_egress,
+			      skel->progs.client_ingress,
+			      skel);
+
+	err = talk_to_outside(&client_fd, &listen_fd, &service_fd, skel);
+	if (CHECK(err, "talk_to_outside", "failed\n"))
+		goto cleanup;
+
+	err = close_connection(&client_fd, &service_fd, &listen_fd);
+	if (CHECK(err, "close_connection", "failed\n"))
+		goto cleanup;
+
+	ASSERT_EQ(skel->bss->g_unexpected, 0, "g_unexpected");
+	ASSERT_EQ(skel->bss->g_sock_state, TIME_WAIT, "g_sock_state");
+
+	uninstall_filters(&egress_link, &ingress_link);
+
+cleanup:
+	close(client_fd);
+	close(listen_fd);
+	close(service_fd);
+	close(cgroup_fd);
+	bpf_link__destroy(egress_link);
+	bpf_link__destroy(ingress_link);
+	cgroup_tcp_skb__destroy(skel);
+	cleanup_cgroup_environment();
+}
diff --git a/tools/testing/selftests/bpf/progs/cgroup_tcp_skb.c b/tools/testing/selftests/bpf/progs/cgroup_tcp_skb.c
new file mode 100644
index 000000000000..78bc6d6efbd1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_tcp_skb.c
@@ -0,0 +1,340 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Facebook */
+#include <linux/bpf.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_helpers.h>
+
+#include <linux/if_ether.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/ipv6.h>
+#include <linux/tcp.h>
+
+#include <sys/types.h>
+#include <sys/socket.h>
+
+#include "cgroup_tcp_skb.h"
+
+char _license[] SEC("license") = "GPL";
+
+__u16 g_sock_port = 0;
+__u32 g_sock_state = 0;
+int g_unexpected = 0;
+
+int needed_tcp_pkt(struct __sk_buff *skb, struct tcphdr *tcph)
+{
+	struct ipv6hdr ip6h;
+
+	if (skb->protocol != bpf_htons(ETH_P_IPV6))
+		return 0;
+	if (bpf_skb_load_bytes(skb, 0, &ip6h, sizeof(ip6h)))
+		return 0;
+
+	if (ip6h.nexthdr != IPPROTO_TCP)
+		return 0;
+
+	if (bpf_skb_load_bytes(skb, sizeof(ip6h), tcph, sizeof(*tcph)))
+		return 0;
+
+	if (tcph->source != bpf_htons(g_sock_port) &&
+	    tcph->dest != bpf_htons(g_sock_port))
+		return 0;
+
+	return 1;
+}
+
+/* Run accept() on a socket in the cgroup to receive a new connection. */
+#define EGRESS_ACCEPT							\
+	case SYN_RECV_SENDING_SYN_ACK:					\
+		if (tcph.fin || !tcph.syn || tcph.rst || !tcph.ack)	\
+			g_unexpected++;					\
+		else							\
+			g_sock_state = SYN_RECV;			\
+		break
+
+#define INGRESS_ACCEPT							\
+	case INIT:							\
+		if (!tcph.syn || tcph.fin || tcph.rst || tcph.ack)	\
+			g_unexpected++;					\
+		else							\
+			g_sock_state = SYN_RECV_SENDING_SYN_ACK;	\
+		break;							\
+	case SYN_RECV:							\
+		if (tcph.fin || tcph.syn || tcph.rst || !tcph.ack)	\
+			g_unexpected++;					\
+		else							\
+			g_sock_state = ESTABLISHED;			\
+		break
+
+/* Run connect() on a socket in the cgroup to start a new connection. */
+#define EGRESS_CONNECT							\
+	case INIT:							\
+		if (!tcph.syn || tcph.fin || tcph.rst || tcph.ack)	\
+			g_unexpected++;					\
+		else							\
+			g_sock_state = SYN_SENT;			\
+		break
+
+#define INGRESS_CONNECT							\
+	case SYN_SENT:							\
+		if (tcph.fin || !tcph.syn || tcph.rst || !tcph.ack)	\
+			g_unexpected++;					\
+		else							\
+			g_sock_state = ESTABLISHED;			\
+		break
+
+/* The connection is closed by the peer outside the cgroup. */
+#define EGRESS_CLOSE_REMOTE						\
+	case ESTABLISHED:						\
+		break;							\
+	case CLOSE_WAIT_SENDING_ACK:					\
+		if (tcph.fin || tcph.syn || tcph.rst || !tcph.ack)	\
+			g_unexpected++;					\
+		else							\
+			g_sock_state = CLOSE_WAIT;			\
+		break;							\
+	case CLOSE_WAIT:						\
+		if (!tcph.fin)						\
+			g_unexpected++;					\
+		else							\
+			g_sock_state = LAST_ACK;			\
+		break
+
+#define INGRESS_CLOSE_REMOTE						\
+	case ESTABLISHED:						\
+		if (tcph.fin)						\
+			g_sock_state = CLOSE_WAIT_SENDING_ACK;		\
+		break;							\
+	case LAST_ACK:							\
+		if (tcph.fin || tcph.syn || tcph.rst || !tcph.ack)	\
+			g_unexpected++;					\
+		else							\
+			g_sock_state = CLOSED;				\
+		break
+
+/* The connection is closed by the endpoint inside the cgroup. */
+#define EGRESS_CLOSE_LOCAL						\
+	case ESTABLISHED:						\
+		if (tcph.fin)						\
+			g_sock_state = FIN_WAIT1;			\
+		break;							\
+	case TIME_WAIT_SENDING_ACK:					\
+		if (tcph.fin || tcph.syn || tcph.rst || !tcph.ack)	\
+			g_unexpected++;					\
+		else							\
+			g_sock_state = TIME_WAIT;			\
+		break
+
+#define INGRESS_CLOSE_LOCAL						\
+	case ESTABLISHED:						\
+		break;							\
+	case FIN_WAIT1:							\
+		if (tcph.fin || tcph.syn || tcph.rst || !tcph.ack)	\
+			g_unexpected++;					\
+		else							\
+			g_sock_state = FIN_WAIT2;			\
+		break;							\
+	case FIN_WAIT2:							\
+		if (!tcph.fin || tcph.syn || tcph.rst || !tcph.ack)	\
+			g_unexpected++;					\
+		else							\
+			g_sock_state = TIME_WAIT_SENDING_ACK;		\
+		break
+
+/* Check the types of outgoing packets of a server socket to make sure they
+ * are consistent with the state of the server socket.
+ *
+ * The connection is closed by the client side.
+ */
+SEC("cgroup_skb/egress")
+int server_egress(struct __sk_buff *skb)
+{
+	struct tcphdr tcph;
+
+	if (!needed_tcp_pkt(skb, &tcph))
+		return 1;
+
+	/* Egress of the server socket. */
+	switch (g_sock_state) {
+	EGRESS_ACCEPT;
+	EGRESS_CLOSE_REMOTE;
+	default:
+		g_unexpected++;
+		break;
+	}
+	return 1;
+}
+
+/* Check the types of incoming packets of a server socket to make sure they
+ * are consistent with the state of the server socket.
+ *
+ * The connection is closed by the client side.
+ */
+SEC("cgroup_skb/ingress")
+int server_ingress(struct __sk_buff *skb)
+{
+	struct tcphdr tcph;
+
+	if (!needed_tcp_pkt(skb, &tcph))
+		return 1;
+
+	/* Ingress of the server socket. */
+	switch (g_sock_state) {
+	INGRESS_ACCEPT;
+	INGRESS_CLOSE_REMOTE;
+	default:
+		g_unexpected++;
+		break;
+	}
+	return 1;
+}
+
+
+/* Check the types of outgoing packets of a server socket to make sure they
+ * are consistent with the state of the server socket.
+ *
+ * The connection is closed by the server side.
+ */
+SEC("cgroup_skb/egress")
+int server_egress_srv(struct __sk_buff *skb)
+{
+	struct tcphdr tcph;
+
+	if (!needed_tcp_pkt(skb, &tcph))
+		return 1;
+
+	/* Egress of the server socket. */
+	switch (g_sock_state) {
+	EGRESS_ACCEPT;
+	EGRESS_CLOSE_LOCAL;
+	default:
+		g_unexpected++;
+		break;
+	}
+	return 1;
+}
+
+/* Check the types of incoming packets of a server socket to make sure they
+ * are consistent with the state of the server socket.
+ *
+ * The connection is closed by the server side.
+ */
+SEC("cgroup_skb/ingress")
+int server_ingress_srv(struct __sk_buff *skb)
+{
+	struct tcphdr tcph;
+
+	if (!needed_tcp_pkt(skb, &tcph))
+		return 1;
+
+	/* Ingress of the server socket. */
+	switch (g_sock_state) {
+	INGRESS_ACCEPT;
+	INGRESS_CLOSE_LOCAL;
+	default:
+		g_unexpected++;
+		break;
+	}
+	return 1;
+}
+
+
+/* Check the types of outgoing packets of a client socket to make sure they
+ * are consistent with the state of the client socket.
+ *
+ * The connection is closed by the server side.
+ */
+SEC("cgroup_skb/egress")
+int client_egress_srv(struct __sk_buff *skb)
+{
+	struct tcphdr tcph;
+
+	if (!needed_tcp_pkt(skb, &tcph))
+		return 1;
+
+	/* Egress of the server socket. */
+	switch (g_sock_state) {
+	EGRESS_CONNECT;
+	EGRESS_CLOSE_REMOTE;
+	default:
+		g_unexpected++;
+		break;
+	}
+	return 1;
+}
+
+/* Check the types of incoming packets of a client socket to make sure they
+ * are consistent with the state of the client socket.
+ *
+ * The connection is closed by the server side.
+ */
+SEC("cgroup_skb/ingress")
+int client_ingress_srv(struct __sk_buff *skb)
+{
+	struct tcphdr tcph;
+
+	if (!needed_tcp_pkt(skb, &tcph))
+		return 1;
+
+	/* Ingress of the server socket. */
+	switch (g_sock_state) {
+	INGRESS_CONNECT;
+	INGRESS_CLOSE_REMOTE;
+	default:
+		g_unexpected++;
+		break;
+	}
+	return 1;
+}
+
+
+/* Check the types of outgoing packets of a client socket to make sure they
+ * are consistent with the state of the client socket.
+ *
+ * The connection is closed by the client side.
+ */
+SEC("cgroup_skb/egress")
+int client_egress(struct __sk_buff *skb)
+{
+	struct tcphdr tcph;
+
+	if (!needed_tcp_pkt(skb, &tcph))
+		return 1;
+
+	/* Egress of the server socket. */
+	switch (g_sock_state) {
+	EGRESS_CONNECT;
+	EGRESS_CLOSE_LOCAL;
+	default:
+		g_unexpected++;
+		break;
+	}
+	return 1;
+}
+
+/* Check the types of incoming packets of a client socket to make sure they
+ * are consistent with the state of the client socket.
+ *
+ * The connection is closed by the client side.
+ */
+SEC("cgroup_skb/ingress")
+int client_ingress(struct __sk_buff *skb)
+{
+	struct tcphdr tcph;
+
+	if (!needed_tcp_pkt(skb, &tcph))
+		return 1;
+
+	/* Ingress of the server socket. */
+	switch (g_sock_state) {
+	INGRESS_CONNECT;
+	INGRESS_CLOSE_LOCAL;
+	default:
+		g_unexpected++;
+		break;
+	}
+	return 1;
+}
+
+
+
-- 
2.34.1


