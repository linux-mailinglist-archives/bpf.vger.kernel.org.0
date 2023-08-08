Return-Path: <bpf+bounces-7246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A061D773E5D
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 18:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05761C20E85
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 16:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4A714A88;
	Tue,  8 Aug 2023 16:29:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98CC13AF9
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 16:29:48 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A486132CA
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 09:29:36 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-585ff234cd1so63347837b3.3
        for <bpf@vger.kernel.org>; Tue, 08 Aug 2023 09:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691512150; x=1692116950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zOkDp4+qp4bVUstm5eUqxLh9Hrp9/tswtsyOZpInDnY=;
        b=qApj0ncbEkWhMO4bJIOJEBR9GdIm82uIiXmPNn4AVthuI+DPad1G9GGE3IDzO/+hxV
         0ExP2ABvqQzGp7PJU9r0rbSIKWaSaGUxYom6nb5yWOEOcApGPJ3hRDXNypwWu0szKWqR
         AEM60QCy2rrnY/tdsEditW9UOjI34lSBdq1MNySNnoHRlqerNSVNMQHTLi42sarmMevy
         Fmj4ZGgCLYqU/sfOH1sriggBYM/Hdr8NBLsu6lxOI9ejZkwsVOM+b7zGDZjJNr48P+U6
         8Ccx13cVmArpGdVt9JfB3o2+zL/I3fLyGfNLowFZKQDDAmHTpMmMj3tadTsotbx+56ku
         CuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512150; x=1692116950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOkDp4+qp4bVUstm5eUqxLh9Hrp9/tswtsyOZpInDnY=;
        b=d8w+OnaQrv4IRovKeNSjDaYwr6j0B2+hr3BZkf9wYoAaZRoXCKxWAE/fgM+Ff3JJ5V
         G66/535LHBmaYuw/sm+RP603m7AfGS54fqK4RCAWl2lxu2jitmMyAyrbKl57m97TUFDD
         rGqHTp2dRsvikoT7bypZACSRqoRKhwl2BCnWomuhKaaS65PnC5KbCqb9x8iInoRSGinJ
         eGqT8VIZF8yzZw/d+rYiTeeT5WZpVXMlSkwDdqvBX1JHr9WZQvgKAvRk4Z5ufrJKlR+I
         eLeAVnfU4fqUKPktTnOAl4tPBvaGyS34hFgYWsCXxrii6JqKbEm6FCAooTHRpH3OokOA
         fj1Q==
X-Gm-Message-State: AOJu0Yw0x53/k19ozqr3xqH4Nv9Dqb/u9MUHKoOu6wPth0U5fgjdIkaA
	fmbKwugwW+wgKIejbLNcvcmslrptB+k=
X-Google-Smtp-Source: AGHT+IGJ6S6rfEthjAqNpY8FTgYmXk66PAtMPAAmm/QV9V3o65UZiDSK7Zvvn+ysBG2OZdiKqDxrgg==
X-Received: by 2002:a0d:de04:0:b0:585:edc6:c73e with SMTP id h4-20020a0dde04000000b00585edc6c73emr261571ywe.28.1691512149781;
        Tue, 08 Aug 2023 09:29:09 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:791:e1e6:ba74:485a])
        by smtp.gmail.com with ESMTPSA id z133-20020a81658b000000b005772e9388cdsm3416687ywb.62.2023.08.08.09.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 09:29:09 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v2] selftests/bpf: remove duplicated functions
Date: Tue,  8 Aug 2023 09:28:58 -0700
Message-Id: <20230808162858.326871-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

The file cgroup_tcp_skb.c contains redundant implementations of the similar
functions (create_server_sock_v6(), connect_client_server_v6() and
get_sock_port_v6()) found in network_helpers.c. Let's eliminate these
duplicated functions.

Changes from v1:

 - Remove get_sock_port_v6() as well.

v1: https://lore.kernel.org/all/20230807193840.567962-1-thinker.li@gmail.com/

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/prog_tests/cgroup_tcp_skb.c | 93 ++++---------------
 1 file changed, 17 insertions(+), 76 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c b/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
index d686ef19f705..3353c42bc2be 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
@@ -9,6 +9,7 @@
 #include "testing_helpers.h"
 #include "cgroup_tcp_skb.skel.h"
 #include "cgroup_tcp_skb.h"
+#include "network_helpers.h"
 
 #define CGROUP_TCP_SKB_PATH "/test_cgroup_tcp_skb"
 
@@ -58,80 +59,13 @@ static int create_client_sock_v6(void)
 	return fd;
 }
 
-static int create_server_sock_v6(void)
-{
-	struct sockaddr_in6 addr = {
-		.sin6_family = AF_INET6,
-		.sin6_port = htons(0),
-		.sin6_addr = IN6ADDR_LOOPBACK_INIT,
-	};
-	int fd, err;
-
-	fd = socket(AF_INET6, SOCK_STREAM, 0);
-	if (fd < 0) {
-		perror("socket");
-		return -1;
-	}
-
-	err = bind(fd, (struct sockaddr *)&addr, sizeof(addr));
-	if (err < 0) {
-		perror("bind");
-		return -1;
-	}
-
-	err = listen(fd, 1);
-	if (err < 0) {
-		perror("listen");
-		return -1;
-	}
-
-	return fd;
-}
-
-static int get_sock_port_v6(int fd)
-{
-	struct sockaddr_in6 addr;
-	socklen_t len;
-	int err;
-
-	len = sizeof(addr);
-	err = getsockname(fd, (struct sockaddr *)&addr, &len);
-	if (err < 0) {
-		perror("getsockname");
-		return -1;
-	}
-
-	return ntohs(addr.sin6_port);
-}
-
-static int connect_client_server_v6(int client_fd, int listen_fd)
-{
-	struct sockaddr_in6 addr = {
-		.sin6_family = AF_INET6,
-		.sin6_addr = IN6ADDR_LOOPBACK_INIT,
-	};
-	int err, port;
-
-	port = get_sock_port_v6(listen_fd);
-	if (port < 0)
-		return -1;
-	addr.sin6_port = htons(port);
-
-	err = connect(client_fd, (struct sockaddr *)&addr, sizeof(addr));
-	if (err < 0) {
-		perror("connect");
-		return -1;
-	}
-
-	return 0;
-}
-
 /* Connect to the server in a cgroup from the outside of the cgroup. */
 static int talk_to_cgroup(int *client_fd, int *listen_fd, int *service_fd,
 			  struct cgroup_tcp_skb *skel)
 {
 	int err, cp;
 	char buf[5];
+	int port;
 
 	/* Create client & server socket */
 	err = join_root_cgroup();
@@ -143,14 +77,17 @@ static int talk_to_cgroup(int *client_fd, int *listen_fd, int *service_fd,
 	err = join_cgroup(CGROUP_TCP_SKB_PATH);
 	if (!ASSERT_OK(err, "join_cgroup"))
 		return -1;
-	*listen_fd = create_server_sock_v6();
+	*listen_fd = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 2000);
 	if (!ASSERT_GE(*listen_fd, 0, "listen_fd"))
 		return -1;
-	skel->bss->g_sock_port = get_sock_port_v6(*listen_fd);
+	port = get_socket_local_port(*listen_fd);
+	if (!ASSERT_GE(port, 0, "get_socket_local_port"))
+		return -1;
+	skel->bss->g_sock_port = ntohs(port);
 
 	/* Connect client to server */
-	err = connect_client_server_v6(*client_fd, *listen_fd);
-	if (!ASSERT_OK(err, "connect_client_server_v6"))
+	err = connect_fd_to_fd(*client_fd, *listen_fd, 500);
+	if (!ASSERT_OK(err, "connect_fd_to_fd"))
 		return -1;
 	*service_fd = accept(*listen_fd, NULL, NULL);
 	if (!ASSERT_GE(*service_fd, 0, "service_fd"))
@@ -175,12 +112,13 @@ static int talk_to_outside(int *client_fd, int *listen_fd, int *service_fd,
 {
 	int err, cp;
 	char buf[5];
+	int port;
 
 	/* Create client & server socket */
 	err = join_root_cgroup();
 	if (!ASSERT_OK(err, "join_root_cgroup"))
 		return -1;
-	*listen_fd = create_server_sock_v6();
+	*listen_fd = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 2000);
 	if (!ASSERT_GE(*listen_fd, 0, "listen_fd"))
 		return -1;
 	err = join_cgroup(CGROUP_TCP_SKB_PATH);
@@ -192,11 +130,14 @@ static int talk_to_outside(int *client_fd, int *listen_fd, int *service_fd,
 	err = join_root_cgroup();
 	if (!ASSERT_OK(err, "join_root_cgroup"))
 		return -1;
-	skel->bss->g_sock_port = get_sock_port_v6(*listen_fd);
+	port = get_socket_local_port(*listen_fd);
+	if (!ASSERT_GE(port, 0, "get_socket_local_port"))
+		return -1;
+	skel->bss->g_sock_port = ntohs(port);
 
 	/* Connect client to server */
-	err = connect_client_server_v6(*client_fd, *listen_fd);
-	if (!ASSERT_OK(err, "connect_client_server_v6"))
+	err = connect_fd_to_fd(*client_fd, *listen_fd, 500);
+	if (!ASSERT_OK(err, "connect_fd_to_fd"))
 		return -1;
 	*service_fd = accept(*listen_fd, NULL, NULL);
 	if (!ASSERT_GE(*service_fd, 0, "service_fd"))
-- 
2.34.1


