Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBADC64906E
	for <lists+bpf@lfdr.de>; Sat, 10 Dec 2022 20:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiLJTgj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Dec 2022 14:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiLJTgh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Dec 2022 14:36:37 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AEE167CD
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 11:36:36 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h10so8304782wrx.3
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 11:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziCJ3oPB670i/Ex4/hyT8q5ZYvIG8lgP9O//9AOFINo=;
        b=DJtw+tWPvRKEJtzzrmIpnf8FpYTkPWCKevAswNQ0X2zAJtSzP/9L/f2OarBTd3dx4J
         TDULy/cDZLZysasGq+aJxKk0AkuYHyONiHv1b7ogOG0Rs2sjZeH+TB5BFqRN0m69VJI2
         G4jnY7vwza4mllS0FL5yk+JOfhM31vzDwMhwDIqsnceH5plNpvfDMUsNrxXo6r461dun
         YtduZEu43qXTGcmmvmcVRx3icf3fWlJriSfckqNLFarGf9HCuzLNC+KogjHSIOqPZqiJ
         Z4CsOoa9EBqEk/x5sFXn/Y11KZtEMVUOwmySKNCD4XJKHibKtSrbJSmhUj4eU2rwSNdZ
         EpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ziCJ3oPB670i/Ex4/hyT8q5ZYvIG8lgP9O//9AOFINo=;
        b=OjvNh2GiN7yjGpYDxLIrGJy4jldQm+dUd3/nHr5mVj0iib0ZdxbNAEpj98KCkdMOES
         sLxBU3hutoOuEO2E1k9oZVJlZrHKlLd5SIkI5/CvKrC4luKqCN6sKYM4ldK4NvHPwVJJ
         1Tuf3l2z29PU59t8dTWQmeENxhQTyQNWbJvT6eqzPtWQZfguclpXtSmYgIp1v+N7KPBW
         c/zUjUvcO6m8DeERIMYpYtO31xWOSovwhfH3bBSwZo7H8Xj4o0mj/LR8fEuycNIOMVw0
         pIkfHEeXgIRKMdELqgdXa+s1TepOBX1wjXX9bH4c0mJIlWisMJZNF1Tl4JHPfas/4ybp
         CQwA==
X-Gm-Message-State: ANoB5pko5Fjz6Q8tlZEoIwyzL3AIOY1CnntnygjjpdkPNbRmzP9VQ9WV
        xDG9XHch2AxEjaEHLiYDe3yX4icjqsy7tw==
X-Google-Smtp-Source: AA0mqf7wZLzE5LP0P4aG7mS/ZmzBNlpBtt6YLyx7nrCjyUFAjk6yt+svAta3VMzzzMDVDj+cQPNvWQ==
X-Received: by 2002:adf:de06:0:b0:242:1277:925b with SMTP id b6-20020adfde06000000b002421277925bmr6772286wrm.59.1670700994370;
        Sat, 10 Dec 2022 11:36:34 -0800 (PST)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::5:366e])
        by smtp.googlemail.com with ESMTPSA id az18-20020adfe192000000b002423a5d7cb1sm4584676wrb.113.2022.12.10.11.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 11:36:33 -0800 (PST)
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>, martin.lau@linux.dev,
        kernel-team@meta.com
Subject: [PATCH bpf-next v2 4/9] selftests/bpf: Track sockaddr length in sock addr tests
Date:   Sat, 10 Dec 2022 20:35:54 +0100
Message-Id: <20221210193559.371515-5-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221210193559.371515-1-daan.j.demeyer@gmail.com>
References: <20221210193559.371515-1-daan.j.demeyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In preparation for adding unix socket support to the bpf cgroup
socket address hooks, start tracking the sockaddr length in the
sockaddr tests which will be required when adding tests for unix
sockets.
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
2.38.1

