Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA4A6EAF20
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 18:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjDUQb0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 12:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjDUQbZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 12:31:25 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C081293DE
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:31:22 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-94f4b911570so256911266b.0
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682094681; x=1684686681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IDMfFvqa0HfGea3cDrMluz4M37S8ZiFE/sCKg2zqVQ=;
        b=OdST6DKi51HFRb/oBMLVBFuU1BhsJvwJcLoGLqy5qQwIMrnxEQfkq/bQ3TJW0nanv4
         BJVuObZsXmNebAHHr/cZnSCEWcgEkBXOQD0iL+9/yXC/cIFrTQJR7BF6UdokvEP7Snst
         TgT2g4+i8Y/7/wpTkcOJeqphMORmCsCKnOLjfctDNSZPjSdQRIpsKE99LaVwppxSQ7DF
         JGCZidn4ZHnFAe8WEniJjDh9SvmAqWKNQOKQrsOJ5xQEbFaPRDhAs1023jHvXAFsCDxs
         9z1wR9FLWBjmwrXo5NGcdlv0Z/y9dq+ii1dyPGB7dZBgXjRTSzTjLugE+esbPIuM2PVJ
         5CRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682094681; x=1684686681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IDMfFvqa0HfGea3cDrMluz4M37S8ZiFE/sCKg2zqVQ=;
        b=QvjSxia8W18busCmK+iiB4MF3W9ZmfwlcSGuK+Oh5C+HHcts651BgNOVCBwyxw2AWl
         IGdCiPvH7BAvOiKjF+QqfozoUc9ZyTHtNU5o4b4OlmPNkPmJrYd5ocXcxYKAJ2QLpchi
         cuUrqdeyhCMC8zx+qaqHKt51itI0LeaH/ciZaMV90B37gp3KUtCA3ID6Vvd3WS1x8tHi
         Bmu+yWEMWc750l2Wot4GTSIr0uK57AWIUhOnQSpFWAqiOy0QIoIrp+Ho+l6VeGZw4ItX
         9WL1hNqJiHITsKQNwVWDnJKs3rIgf/JaqGJgqITBBD5t8VOV7uZS7zCWe7hKL5Hc47mL
         wzXw==
X-Gm-Message-State: AAQBX9frK9l/AYNK3K2Tu1rpG/EMRtuenjBtNbDkmPu1geRN5ZSO/uUA
        GumLU0nuiWmzoLZr5H+5KCdVoNKaosBUaA==
X-Google-Smtp-Source: AKy350Zc8a4YbJnEcRx2ildgOiklBq7xps6UC4WEewrt57V657y7uPAFxl1LlEHpo7V+aCFAs+RrpA==
X-Received: by 2002:a17:907:2982:b0:8b8:c06e:52d8 with SMTP id eu2-20020a170907298200b008b8c06e52d8mr2759331ejc.36.1682094680772;
        Fri, 21 Apr 2023 09:31:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id k9-20020a170906970900b009534211cc97sm2248578ejx.159.2023.04.21.09.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 09:31:20 -0700 (PDT)
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>, martin.lau@linux.dev,
        kernel-team@meta.com
Subject: [PATCH bpf-next v3 02/10] selftests/bpf: Track sockaddr length in sock addr tests
Date:   Fri, 21 Apr 2023 18:27:10 +0200
Message-Id: <20230421162718.440230-3-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
References: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In preparation for adding unix socket support to the bpf cgroup
socket address hooks, start tracking the sockaddr length in the
sockaddr tests which will be required when adding tests for unix
sockets.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 tools/testing/selftests/bpf/test_sock_addr.c | 130 ++++++++++++-------
 1 file changed, 85 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index 2c89674fc62c..6a618c8f477c 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -604,7 +604,7 @@ static struct sock_addr_test tests[] = {
 };
 
 static int mk_sockaddr(int domain, const char *ip, unsigned short port,
-		       struct sockaddr *addr, socklen_t addr_len)
+		       struct sockaddr *addr, socklen_t *addr_len)
 {
 	struct sockaddr_in6 *addr6;
 	struct sockaddr_in *addr4;
@@ -614,10 +614,10 @@ static int mk_sockaddr(int domain, const char *ip, unsigned short port,
 		return -1;
 	}
 
-	memset(addr, 0, addr_len);
+	memset(addr, 0, *addr_len);
 
 	if (domain == AF_INET) {
-		if (addr_len < sizeof(struct sockaddr_in))
+		if (*addr_len < sizeof(struct sockaddr_in))
 			return -1;
 		addr4 = (struct sockaddr_in *)addr;
 		addr4->sin_family = domain;
@@ -626,8 +626,9 @@ static int mk_sockaddr(int domain, const char *ip, unsigned short port,
 			log_err("Invalid IPv4: %s", ip);
 			return -1;
 		}
+		*addr_len = sizeof(struct sockaddr_in);
 	} else if (domain == AF_INET6) {
-		if (addr_len < sizeof(struct sockaddr_in6))
+		if (*addr_len < sizeof(struct sockaddr_in6))
 			return -1;
 		addr6 = (struct sockaddr_in6 *)addr;
 		addr6->sin6_family = domain;
@@ -636,6 +637,7 @@ static int mk_sockaddr(int domain, const char *ip, unsigned short port,
 			log_err("Invalid IPv6: %s", ip);
 			return -1;
 		}
+		*addr_len = sizeof(struct sockaddr_in6);
 	}
 
 	return 0;
@@ -749,6 +751,7 @@ static int sendmsg4_rw_asm_prog_load(const struct sock_addr_test *test)
 {
 	struct sockaddr_in dst4_rw_addr;
 	struct in_addr src4_rw_ip;
+	socklen_t dst4_rw_addr_len = sizeof(dst4_rw_addr);
 
 	if (inet_pton(AF_INET, SRC4_REWRITE_IP, (void *)&src4_rw_ip) != 1) {
 		log_err("Invalid IPv4: %s", SRC4_REWRITE_IP);
@@ -757,7 +760,7 @@ static int sendmsg4_rw_asm_prog_load(const struct sock_addr_test *test)
 
 	if (mk_sockaddr(AF_INET, SERV4_REWRITE_IP, SERV4_REWRITE_PORT,
 			(struct sockaddr *)&dst4_rw_addr,
-			sizeof(dst4_rw_addr)) == -1)
+			&dst4_rw_addr_len) == -1)
 		return -1;
 
 	struct bpf_insn insns[] = {
@@ -812,6 +815,7 @@ static int sendmsg6_rw_dst_asm_prog_load(const struct sock_addr_test *test,
 {
 	struct sockaddr_in6 dst6_rw_addr;
 	struct in6_addr src6_rw_ip;
+	socklen_t dst6_rw_addr_len = sizeof(dst6_rw_addr);
 
 	if (inet_pton(AF_INET6, SRC6_REWRITE_IP, (void *)&src6_rw_ip) != 1) {
 		log_err("Invalid IPv6: %s", SRC6_REWRITE_IP);
@@ -820,7 +824,7 @@ static int sendmsg6_rw_dst_asm_prog_load(const struct sock_addr_test *test,
 
 	if (mk_sockaddr(AF_INET6, rw_dst_ip, SERV6_REWRITE_PORT,
 			(struct sockaddr *)&dst6_rw_addr,
-			sizeof(dst6_rw_addr)) == -1)
+			&dst6_rw_addr_len) == -1)
 		return -1;
 
 	struct bpf_insn insns[] = {
@@ -885,8 +889,9 @@ static int sendmsg6_rw_c_prog_load(const struct sock_addr_test *test)
 	return load_path(test, SENDMSG6_PROG_PATH);
 }
 
-static int cmp_addr(const struct sockaddr_storage *addr1,
-		    const struct sockaddr_storage *addr2, int cmp_port)
+static int cmp_addr(const struct sockaddr_storage *addr1, socklen_t addr1_len,
+		    const struct sockaddr_storage *addr2, socklen_t addr2_len,
+		    int cmp_port)
 {
 	const struct sockaddr_in *four1, *four2;
 	const struct sockaddr_in6 *six1, *six2;
@@ -894,6 +899,9 @@ static int cmp_addr(const struct sockaddr_storage *addr1,
 	if (addr1->ss_family != addr2->ss_family)
 		return -1;
 
+	if (addr1_len != addr2_len)
+		return -1;
+
 	if (addr1->ss_family == AF_INET) {
 		four1 = (const struct sockaddr_in *)addr1;
 		four2 = (const struct sockaddr_in *)addr2;
@@ -911,7 +919,8 @@ static int cmp_addr(const struct sockaddr_storage *addr1,
 }
 
 static int cmp_sock_addr(info_fn fn, int sock1,
-			 const struct sockaddr_storage *addr2, int cmp_port)
+			 const struct sockaddr_storage *addr2,
+			 socklen_t addr2_len, int cmp_port)
 {
 	struct sockaddr_storage addr1;
 	socklen_t len1 = sizeof(addr1);
@@ -920,22 +929,28 @@ static int cmp_sock_addr(info_fn fn, int sock1,
 	if (fn(sock1, (struct sockaddr *)&addr1, (socklen_t *)&len1) != 0)
 		return -1;
 
-	return cmp_addr(&addr1, addr2, cmp_port);
+	return cmp_addr(&addr1, len1, addr2, addr2_len, cmp_port);
 }
 
-static int cmp_local_ip(int sock1, const struct sockaddr_storage *addr2)
+static int cmp_local_ip(int sock1, const struct sockaddr_storage *addr2,
+			socklen_t addr2_len)
 {
-	return cmp_sock_addr(getsockname, sock1, addr2, /*cmp_port*/ 0);
+	return cmp_sock_addr(getsockname, sock1, addr2, addr2_len,
+			     /*cmp_port*/ 0);
 }
 
-static int cmp_local_addr(int sock1, const struct sockaddr_storage *addr2)
+static int cmp_local_addr(int sock1, const struct sockaddr_storage *addr2,
+			  socklen_t addr2_len)
 {
-	return cmp_sock_addr(getsockname, sock1, addr2, /*cmp_port*/ 1);
+	return cmp_sock_addr(getsockname, sock1, addr2, addr2_len,
+			     /*cmp_port*/ 1);
 }
 
-static int cmp_peer_addr(int sock1, const struct sockaddr_storage *addr2)
+static int cmp_peer_addr(int sock1, const struct sockaddr_storage *addr2,
+			 socklen_t addr2_len)
 {
-	return cmp_sock_addr(getpeername, sock1, addr2, /*cmp_port*/ 1);
+	return cmp_sock_addr(getpeername, sock1, addr2, addr2_len,
+			     /*cmp_port*/ 1);
 }
 
 static int start_server(int type, const struct sockaddr_storage *addr,
@@ -1109,7 +1124,8 @@ static int fastconnect_to_server(const struct sockaddr_storage *addr,
 				 MSG_FASTOPEN, &sendmsg_err);
 }
 
-static int recvmsg_from_client(int sockfd, struct sockaddr_storage *src_addr)
+static int recvmsg_from_client(int sockfd, struct sockaddr_storage *src_addr,
+			       socklen_t *src_addr_len)
 {
 	struct timeval tv;
 	struct msghdr hdr;
@@ -1133,31 +1149,39 @@ static int recvmsg_from_client(int sockfd, struct sockaddr_storage *src_addr)
 
 	memset(&hdr, 0, sizeof(hdr));
 	hdr.msg_name = src_addr;
-	hdr.msg_namelen = sizeof(struct sockaddr_storage);
+	hdr.msg_namelen = *src_addr_len;
 	hdr.msg_iov = &iov;
 	hdr.msg_iovlen = 1;
 
-	return recvmsg(sockfd, &hdr, 0);
+	if (recvmsg(sockfd, &hdr, 0) < 0)
+		return -1;
+
+	*src_addr_len = hdr.msg_namelen;
+	return 0;
 }
 
 static int init_addrs(const struct sock_addr_test *test,
 		      struct sockaddr_storage *requested_addr,
+		      socklen_t *requested_addr_len,
 		      struct sockaddr_storage *expected_addr,
-		      struct sockaddr_storage *expected_src_addr)
+		      socklen_t *expected_addr_len,
+		      struct sockaddr_storage *expected_src_addr,
+		      socklen_t *expected_src_addr_len)
 {
-	socklen_t addr_len = sizeof(struct sockaddr_storage);
-
 	if (mk_sockaddr(test->domain, test->expected_ip, test->expected_port,
-			(struct sockaddr *)expected_addr, addr_len) == -1)
+			(struct sockaddr *)expected_addr,
+			expected_addr_len) == -1)
 		goto err;
 
 	if (mk_sockaddr(test->domain, test->requested_ip, test->requested_port,
-			(struct sockaddr *)requested_addr, addr_len) == -1)
+			(struct sockaddr *)requested_addr,
+			requested_addr_len) == -1)
 		goto err;
 
 	if (test->expected_src_ip &&
 	    mk_sockaddr(test->domain, test->expected_src_ip, 0,
-			(struct sockaddr *)expected_src_addr, addr_len) == -1)
+			(struct sockaddr *)expected_src_addr,
+			expected_src_addr_len) == -1)
 		goto err;
 
 	return 0;
@@ -1167,25 +1191,28 @@ static int init_addrs(const struct sock_addr_test *test,
 
 static int run_bind_test_case(const struct sock_addr_test *test)
 {
-	socklen_t addr_len = sizeof(struct sockaddr_storage);
 	struct sockaddr_storage requested_addr;
 	struct sockaddr_storage expected_addr;
+	socklen_t requested_addr_len = sizeof(struct sockaddr_storage);
+	socklen_t expected_addr_len = sizeof(struct sockaddr_storage);
 	int clientfd = -1;
 	int servfd = -1;
 	int err = 0;
 
-	if (init_addrs(test, &requested_addr, &expected_addr, NULL))
+	if (init_addrs(test, &requested_addr, &requested_addr_len,
+		       &expected_addr, &expected_addr_len, NULL, NULL))
 		goto err;
 
-	servfd = start_server(test->type, &requested_addr, addr_len);
+	servfd = start_server(test->type, &requested_addr, requested_addr_len);
 	if (servfd == -1)
 		goto err;
 
-	if (cmp_local_addr(servfd, &expected_addr))
+	if (cmp_local_addr(servfd, &expected_addr, expected_addr_len))
 		goto err;
 
 	/* Try to connect to server just in case */
-	clientfd = connect_to_server(test->type, &expected_addr, addr_len);
+	clientfd = connect_to_server(test->type, &expected_addr,
+				     expected_addr_len);
 	if (clientfd == -1)
 		goto err;
 
@@ -1204,28 +1231,33 @@ static int run_connect_test_case(const struct sock_addr_test *test)
 	struct sockaddr_storage expected_src_addr;
 	struct sockaddr_storage requested_addr;
 	struct sockaddr_storage expected_addr;
+	socklen_t expected_src_addr_len = sizeof(struct sockaddr_storage);
+	socklen_t requested_addr_len = sizeof(struct sockaddr_storage);
+	socklen_t expected_addr_len = sizeof(struct sockaddr_storage);
 	int clientfd = -1;
 	int servfd = -1;
 	int err = 0;
 
-	if (init_addrs(test, &requested_addr, &expected_addr,
-		       &expected_src_addr))
+	if (init_addrs(test, &requested_addr, &requested_addr_len,
+		       &expected_addr, &expected_addr_len, &expected_src_addr,
+		       &expected_src_addr_len))
 		goto err;
 
 	/* Prepare server to connect to */
-	servfd = start_server(test->type, &expected_addr, addr_len);
+	servfd = start_server(test->type, &expected_addr, expected_addr_len);
 	if (servfd == -1)
 		goto err;
 
-	clientfd = connect_to_server(test->type, &requested_addr, addr_len);
+	clientfd = connect_to_server(test->type, &requested_addr,
+				     requested_addr_len);
 	if (clientfd == -1)
 		goto err;
 
 	/* Make sure src and dst addrs were overridden properly */
-	if (cmp_peer_addr(clientfd, &expected_addr))
+	if (cmp_peer_addr(clientfd, &expected_addr, expected_addr_len))
 		goto err;
 
-	if (cmp_local_ip(clientfd, &expected_src_addr))
+	if (cmp_local_ip(clientfd, &expected_src_addr, expected_src_addr_len))
 		goto err;
 
 	if (test->type == SOCK_STREAM) {
@@ -1235,10 +1267,11 @@ static int run_connect_test_case(const struct sock_addr_test *test)
 			goto err;
 
 		/* Make sure src and dst addrs were overridden properly */
-		if (cmp_peer_addr(clientfd, &expected_addr))
+		if (cmp_peer_addr(clientfd, &expected_addr, expected_addr_len))
 			goto err;
 
-		if (cmp_local_ip(clientfd, &expected_src_addr))
+		if (cmp_local_ip(clientfd, &expected_src_addr,
+				 expected_src_addr_len))
 			goto err;
 	}
 
@@ -1253,11 +1286,14 @@ static int run_connect_test_case(const struct sock_addr_test *test)
 
 static int run_xmsg_test_case(const struct sock_addr_test *test, int max_cmsg)
 {
-	socklen_t addr_len = sizeof(struct sockaddr_storage);
 	struct sockaddr_storage expected_addr;
 	struct sockaddr_storage server_addr;
 	struct sockaddr_storage sendmsg_addr;
 	struct sockaddr_storage recvmsg_addr;
+	socklen_t expected_addr_len = sizeof(struct sockaddr_storage);
+	socklen_t server_addr_len = sizeof(struct sockaddr_storage);
+	socklen_t sendmsg_addr_len = sizeof(struct sockaddr_storage);
+	socklen_t recvmsg_addr_len = sizeof(struct sockaddr_storage);
 	int clientfd = -1;
 	int servfd = -1;
 	int set_cmsg;
@@ -1266,11 +1302,12 @@ static int run_xmsg_test_case(const struct sock_addr_test *test, int max_cmsg)
 	if (test->type != SOCK_DGRAM)
 		goto err;
 
-	if (init_addrs(test, &sendmsg_addr, &server_addr, &expected_addr))
+	if (init_addrs(test, &sendmsg_addr, &sendmsg_addr_len, &server_addr,
+		       &server_addr_len, &expected_addr, &expected_addr_len))
 		goto err;
 
 	/* Prepare server to sendmsg to */
-	servfd = start_server(test->type, &server_addr, addr_len);
+	servfd = start_server(test->type, &server_addr, server_addr_len);
 	if (servfd == -1)
 		goto err;
 
@@ -1279,8 +1316,8 @@ static int run_xmsg_test_case(const struct sock_addr_test *test, int max_cmsg)
 			close(clientfd);
 
 		clientfd = sendmsg_to_server(test->type, &sendmsg_addr,
-					     addr_len, set_cmsg, /*flags*/0,
-					     &err);
+					     sendmsg_addr_len, set_cmsg,
+					     /*flags*/ 0, &err);
 		if (err)
 			goto out;
 		else if (clientfd == -1)
@@ -1298,10 +1335,13 @@ static int run_xmsg_test_case(const struct sock_addr_test *test, int max_cmsg)
 		 * specific packet may differ from the one used by default and
 		 * returned by getsockname(2).
 		 */
-		if (recvmsg_from_client(servfd, &recvmsg_addr) == -1)
+		if (recvmsg_from_client(servfd, &recvmsg_addr,
+					&recvmsg_addr_len) == -1)
 			goto err;
 
-		if (cmp_addr(&recvmsg_addr, &expected_addr, /*cmp_port*/0))
+		if (cmp_addr(&recvmsg_addr, recvmsg_addr_len, &expected_addr,
+			     expected_addr_len,
+			     /*cmp_port*/ 0))
 			goto err;
 	}
 
-- 
2.40.0

