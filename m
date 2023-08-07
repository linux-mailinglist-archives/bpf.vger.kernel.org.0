Return-Path: <bpf+bounces-7194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 614CC772F9B
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 21:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 166602815A5
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 19:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C1D1643E;
	Mon,  7 Aug 2023 19:39:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0481640B
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 19:39:29 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF0119B9
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 12:38:58 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-583d63ca1e9so56670917b3.1
        for <bpf@vger.kernel.org>; Mon, 07 Aug 2023 12:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691437123; x=1692041923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3gKfosq/mKZMp2DGktrUPHNHkHFpwamRSk1MNeIWG34=;
        b=nWn4C/IYGTog75QzHoS+72rLYiUwrDm+fDSxguKwSDSmWqMUuvGuPEVWJiPXDhY9zk
         RyWUDw9lxPMoXIxPdD2gGeJzn15/AGcLK+Mr9jNtz26H6qAAdIJCYjB/VLB30RIOZk2r
         mjBYnjlZ8DuEiA5K72l5dzvtsNkB4CH4XRhpkraymgBJ5Yevs6iAropLS47ztfm0+Yfj
         Lm7QckrCvH4cl/pZ/TahJwvqiGlQzlOyvtPNwNFSD+5znjGJ5gD/w3X2Gu9jFQxZCBvb
         Y+mdYOmN4/FRpoIpu7dG36HlJrWGrJ4gd1ZE9y97QXKilOgrA+9OZ9Ys2iXWg1ZKkmNF
         +juQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691437123; x=1692041923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3gKfosq/mKZMp2DGktrUPHNHkHFpwamRSk1MNeIWG34=;
        b=UTnAs3N5yxiQcQzkcg36oHQi0QuV4SzVYN6624Le6BCDtV43cVnA8AW0HsTLHH90ev
         81EWT9P8EwE/XARxdkGkPoifDzjt07zifRnBRSXgXMxTzhCZaWsv8gWpRq0b53TbLw+i
         NbP+LA0/ZoMVePE4BV9VrjpiAF9Sy8jchYCpejimjtM+AoJGVzT//7WYFevKFTY0Optj
         NrF4sqjBG+j5r0HrHEf1+LLPJhi9L7C3XrnFOuKbcZFE8X7zCCLy91uqUlkoDP1jxGvq
         jpbtDV59taWd1I9XgnbhTfxPzlosJ1w+MK/A+T0pFluNJrvprPH5WFsBThXxGLxO7N9N
         Qtzw==
X-Gm-Message-State: AOJu0YytfaPfOD3Jq08SWmdkMScVlDUlOrj/q2pPcH+Ygmc5sxrAUFIl
	Y2GWFT5ICkezN4Xon4WF5t9KemCpIxY=
X-Google-Smtp-Source: AGHT+IFRWDpV53oApf+C80XsBdV3mz8xKTuE+sBh0ST31B5VVD4knZQrHjX4aJDPcukwiPZuNXvNrw==
X-Received: by 2002:a81:5b43:0:b0:573:7f55:a40e with SMTP id p64-20020a815b43000000b005737f55a40emr11194621ywb.49.1691437123480;
        Mon, 07 Aug 2023 12:38:43 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:24f0:2f4c:34ea:71b5])
        by smtp.gmail.com with ESMTPSA id w125-20020a817b83000000b00583cd6f8e1dsm2904083ywc.15.2023.08.07.12.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 12:38:43 -0700 (PDT)
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
Subject: [PATCH bpf-next] selftests/bpf: remove duplicated functions
Date: Mon,  7 Aug 2023 12:38:40 -0700
Message-Id: <20230807193840.567962-1-thinker.li@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

The file cgroup_tcp_skb.c contains redundant implementations of the similar
functions (create_server_sock_v6() and connect_client_server_v6()) found in
network_helpers.c. Let's eliminate these duplicated functions.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/prog_tests/cgroup_tcp_skb.c | 65 ++-----------------
 1 file changed, 7 insertions(+), 58 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c b/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
index d686ef19f705..3085d539608d 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
@@ -9,6 +9,7 @@
 #include "testing_helpers.h"
 #include "cgroup_tcp_skb.skel.h"
 #include "cgroup_tcp_skb.h"
+#include "network_helpers.h"
 
 #define CGROUP_TCP_SKB_PATH "/test_cgroup_tcp_skb"
 
@@ -58,36 +59,6 @@ static int create_client_sock_v6(void)
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
 static int get_sock_port_v6(int fd)
 {
 	struct sockaddr_in6 addr;
@@ -104,28 +75,6 @@ static int get_sock_port_v6(int fd)
 	return ntohs(addr.sin6_port);
 }
 
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
@@ -143,14 +92,14 @@ static int talk_to_cgroup(int *client_fd, int *listen_fd, int *service_fd,
 	err = join_cgroup(CGROUP_TCP_SKB_PATH);
 	if (!ASSERT_OK(err, "join_cgroup"))
 		return -1;
-	*listen_fd = create_server_sock_v6();
+	*listen_fd = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 2000);
 	if (!ASSERT_GE(*listen_fd, 0, "listen_fd"))
 		return -1;
 	skel->bss->g_sock_port = get_sock_port_v6(*listen_fd);
 
 	/* Connect client to server */
-	err = connect_client_server_v6(*client_fd, *listen_fd);
-	if (!ASSERT_OK(err, "connect_client_server_v6"))
+	err = connect_fd_to_fd(*client_fd, *listen_fd, 500);
+	if (!ASSERT_OK(err, "connect_fd_to_fd"))
 		return -1;
 	*service_fd = accept(*listen_fd, NULL, NULL);
 	if (!ASSERT_GE(*service_fd, 0, "service_fd"))
@@ -180,7 +129,7 @@ static int talk_to_outside(int *client_fd, int *listen_fd, int *service_fd,
 	err = join_root_cgroup();
 	if (!ASSERT_OK(err, "join_root_cgroup"))
 		return -1;
-	*listen_fd = create_server_sock_v6();
+	*listen_fd = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 2000);
 	if (!ASSERT_GE(*listen_fd, 0, "listen_fd"))
 		return -1;
 	err = join_cgroup(CGROUP_TCP_SKB_PATH);
@@ -195,8 +144,8 @@ static int talk_to_outside(int *client_fd, int *listen_fd, int *service_fd,
 	skel->bss->g_sock_port = get_sock_port_v6(*listen_fd);
 
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


