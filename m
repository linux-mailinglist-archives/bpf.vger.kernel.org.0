Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF31184C14
	for <lists+bpf@lfdr.de>; Fri, 13 Mar 2020 17:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgCMQK5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Mar 2020 12:10:57 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40349 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgCMQK4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Mar 2020 12:10:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id j17so8310356lfe.7
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2020 09:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Ek0JoNOJW6XbGMO4niOnEC+bE2MbKDPjgOryNyycgM=;
        b=TfV93QAdzZMOIXr5FNO8ZZM62+qasmyu71q6QniUpK0HxtNEd8f+2B8Q8z33+uO+Yv
         BoEQlUqfGbeyEFDLDcgCPhTGZzN/etHwJb/YIktBtgG06TsdW+WScP+gK43zSlzeOc21
         ljtA+fRYSbEC14tjnIKB/wzFrWus5rN2TUSxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Ek0JoNOJW6XbGMO4niOnEC+bE2MbKDPjgOryNyycgM=;
        b=KXhbTnYbNN06EpMvQXoPG3FJRnzM4J1D9zw9nNkVFLqwuCtmBQC4E0UIZK7MB1bYSV
         OBJyXTpeUGEhhER7G1+xff1lJ50+50paDYNR4xveLNxEOPY1IGTBhtpM+xCmOUOIpDru
         n8I8sIS0eDYcm9tedAqG2qfg8XUfJnd+zGdlcCAPFys+nyMEvKCZqMkwtbjIH4sTp/PG
         BVXNuFlXAFjBZcC7tRWL2JByzrwdr/EYEGYOID3/O+26kx+sc4++Zr93j1b9QTfBkb7C
         3MKvgle2jgaEAalgRbJXF9xCLtUlOd0uciQ9xpzqXOtM+UK3vKntL2m9X1GFMNd/7pIH
         oLMQ==
X-Gm-Message-State: ANhLgQ00DFTyz8FwpK/bukrrCPc02FW4agyCjTfdko8IRPo2WzEndWB3
        +OCNu7TUqBWr45tMVYewCz9MsSYFCSXZ0w==
X-Google-Smtp-Source: ADFU+vs1snoc4lwc1ubZ6FswWpOhuZFkh+uu8UtwTcuF/TWb5dEVUK2/lbCzH2FRvnPDAuS0OTZaTQ==
X-Received: by 2002:ac2:5598:: with SMTP id v24mr8718590lfg.139.1584115851577;
        Fri, 13 Mar 2020 09:10:51 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id s16sm20744073ljc.89.2020.03.13.09.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 09:10:50 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next v2] selftests/bpf: Fix spurious failures in accept due to EAGAIN
Date:   Fri, 13 Mar 2020 17:10:49 +0100
Message-Id: <20200313161049.677700-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko reports that sockmap_listen test suite is frequently
failing due to accept() calls erroring out with EAGAIN:

  ./test_progs:connect_accept_thread:733: accept: Resource temporarily unavailable
  connect_accept_thread:FAIL:733

This is because we are using a non-blocking listening TCP socket to
accept() connections without polling on the socket.

While at first switching to blocking mode seems like the right thing to do,
this could lead to test process blocking indefinitely in face of a network
issue, like loopback interface being down, as Andrii pointed out.

Hence, stick to non-blocking mode for TCP listening sockets but with
polling for incoming connection for a limited time before giving up.

Apply this approach to all socket I/O calls in the test suite that we
expect to block indefinitely, that is accept() for TCP and recv() for UDP.

Fixes: 44d28be2b8d4 ("selftests/bpf: Tests for sockmap/sockhash holding listening sockets")
Reported-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---

Notes:
    v2: Switch back to non-blocking mode, but with polling and timeout.
        Extend the fix to all I/O calls that we expect to block. (Andrii)

 .../selftests/bpf/prog_tests/sockmap_listen.c | 77 ++++++++++++++-----
 1 file changed, 58 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 52aa468bdccd..d7d65a700799 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -16,6 +16,7 @@
 #include <pthread.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/select.h>
 #include <unistd.h>
 
 #include <bpf/bpf.h>
@@ -25,6 +26,7 @@
 #include "test_progs.h"
 #include "test_sockmap_listen.skel.h"
 
+#define IO_TIMEOUT_SEC 30
 #define MAX_STRERR_LEN 256
 #define MAX_TEST_NAME 80
 
@@ -44,9 +46,10 @@
 
 /* Wrappers that fail the test on error and report it. */
 
-#define xaccept(fd, addr, len)                                                 \
+#define xaccept_nonblock(fd, addr, len)                                        \
 	({                                                                     \
-		int __ret = accept((fd), (addr), (len));                       \
+		int __ret =                                                    \
+			accept_timeout((fd), (addr), (len), IO_TIMEOUT_SEC);   \
 		if (__ret == -1)                                               \
 			FAIL_ERRNO("accept");                                  \
 		__ret;                                                         \
@@ -116,9 +119,10 @@
 		__ret;                                                         \
 	})
 
-#define xrecv(fd, buf, len, flags)                                             \
+#define xrecv_nonblock(fd, buf, len, flags)                                    \
 	({                                                                     \
-		ssize_t __ret = recv((fd), (buf), (len), (flags));             \
+		ssize_t __ret = recv_timeout((fd), (buf), (len), (flags),      \
+					     IO_TIMEOUT_SEC);                  \
 		if (__ret == -1)                                               \
 			FAIL_ERRNO("recv");                                    \
 		__ret;                                                         \
@@ -191,6 +195,40 @@
 		__ret;                                                         \
 	})
 
+static int poll_read(int fd, unsigned int timeout_sec)
+{
+	struct timeval timeout = { .tv_sec = timeout_sec };
+	fd_set rfds;
+	int r;
+
+	FD_ZERO(&rfds);
+	FD_SET(fd, &rfds);
+
+	r = select(fd + 1, &rfds, NULL, NULL, &timeout);
+	if (r == 0)
+		errno = ETIME;
+
+	return r == 1 ? 0 : -1;
+}
+
+static int accept_timeout(int fd, struct sockaddr *addr, socklen_t *len,
+			  unsigned int timeout_sec)
+{
+	if (poll_read(fd, timeout_sec))
+		return -1;
+
+	return accept(fd, addr, len);
+}
+
+static int recv_timeout(int fd, void *buf, size_t len, int flags,
+			unsigned int timeout_sec)
+{
+	if (poll_read(fd, timeout_sec))
+		return -1;
+
+	return recv(fd, buf, len, flags);
+}
+
 static void init_addr_loopback4(struct sockaddr_storage *ss, socklen_t *len)
 {
 	struct sockaddr_in *addr4 = memset(ss, 0, sizeof(*ss));
@@ -265,7 +303,7 @@ static int socket_loopback_reuseport(int family, int sotype, int progfd)
 	if (err)
 		goto close;
 
-	if (sotype == SOCK_DGRAM)
+	if (sotype & SOCK_DGRAM)
 		return s;
 
 	err = xlisten(s, SOMAXCONN);
@@ -589,7 +627,7 @@ static void test_accept_after_delete(int family, int sotype, int mapfd)
 	socklen_t len;
 	u64 value;
 
-	s = socket_loopback(family, sotype);
+	s = socket_loopback(family, sotype | SOCK_NONBLOCK);
 	if (s == -1)
 		return;
 
@@ -617,7 +655,7 @@ static void test_accept_after_delete(int family, int sotype, int mapfd)
 	if (err)
 		goto close_cli;
 
-	p = xaccept(s, NULL, NULL);
+	p = xaccept_nonblock(s, NULL, NULL);
 	if (p == -1)
 		goto close_cli;
 
@@ -643,7 +681,7 @@ static void test_accept_before_delete(int family, int sotype, int mapfd)
 	socklen_t len;
 	u64 value;
 
-	s = socket_loopback(family, sotype);
+	s = socket_loopback(family, sotype | SOCK_NONBLOCK);
 	if (s == -1)
 		return;
 
@@ -666,7 +704,7 @@ static void test_accept_before_delete(int family, int sotype, int mapfd)
 	if (err)
 		goto close_cli;
 
-	p = xaccept(s, NULL, NULL);
+	p = xaccept_nonblock(s, NULL, NULL);
 	if (p == -1)
 		goto close_cli;
 
@@ -730,7 +768,7 @@ static void *connect_accept_thread(void *arg)
 			break;
 		}
 
-		p = xaccept(s, NULL, NULL);
+		p = xaccept_nonblock(s, NULL, NULL);
 		if (p < 0) {
 			xclose(c);
 			break;
@@ -912,7 +950,7 @@ static void redir_to_connected(int family, int sotype, int sock_mapfd,
 	if (err)
 		goto close_cli0;
 
-	p0 = xaccept(s, NULL, NULL);
+	p0 = xaccept_nonblock(s, NULL, NULL);
 	if (p0 < 0)
 		goto close_cli0;
 
@@ -923,7 +961,7 @@ static void redir_to_connected(int family, int sotype, int sock_mapfd,
 	if (err)
 		goto close_cli1;
 
-	p1 = xaccept(s, NULL, NULL);
+	p1 = xaccept_nonblock(s, NULL, NULL);
 	if (p1 < 0)
 		goto close_cli1;
 
@@ -1044,7 +1082,7 @@ static void redir_to_listening(int family, int sotype, int sock_mapfd,
 	if (err)
 		goto close_cli;
 
-	p = xaccept(s, NULL, NULL);
+	p = xaccept_nonblock(s, NULL, NULL);
 	if (p < 0)
 		goto close_cli;
 
@@ -1139,7 +1177,8 @@ static void test_reuseport_select_listening(int family, int sotype,
 
 	zero_verdict_count(verd_map);
 
-	s = socket_loopback_reuseport(family, sotype, reuseport_prog);
+	s = socket_loopback_reuseport(family, sotype | SOCK_NONBLOCK,
+				      reuseport_prog);
 	if (s < 0)
 		return;
 
@@ -1164,7 +1203,7 @@ static void test_reuseport_select_listening(int family, int sotype,
 	if (sotype == SOCK_STREAM) {
 		int p;
 
-		p = xaccept(s, NULL, NULL);
+		p = xaccept_nonblock(s, NULL, NULL);
 		if (p < 0)
 			goto close_cli;
 		xclose(p);
@@ -1176,7 +1215,7 @@ static void test_reuseport_select_listening(int family, int sotype,
 		if (n == -1)
 			goto close_cli;
 
-		n = xrecv(s, &b, sizeof(b), 0);
+		n = xrecv_nonblock(s, &b, sizeof(b), 0);
 		if (n == -1)
 			goto close_cli;
 	}
@@ -1232,7 +1271,7 @@ static void test_reuseport_select_connected(int family, int sotype,
 		goto close_cli0;
 
 	if (sotype == SOCK_STREAM) {
-		p0 = xaccept(s, NULL, NULL);
+		p0 = xaccept_nonblock(s, NULL, NULL);
 		if (p0 < 0)
 			goto close_cli0;
 	} else {
@@ -1276,7 +1315,7 @@ static void test_reuseport_select_connected(int family, int sotype,
 		if (n == -1)
 			goto close_cli1;
 
-		n = recv(c1, &b, sizeof(b), 0);
+		n = recv_timeout(c1, &b, sizeof(b), 0, IO_TIMEOUT_SEC);
 		err = n == -1;
 	}
 	if (!err || errno != ECONNREFUSED)
@@ -1350,7 +1389,7 @@ static void test_reuseport_mixed_groups(int family, int sotype, int sock_map,
 		if (n == -1)
 			goto close_cli;
 
-		n = recv(c, &b, sizeof(b), 0);
+		n = recv_timeout(c, &b, sizeof(b), 0, IO_TIMEOUT_SEC);
 		err = n == -1;
 	}
 	if (!err || errno != ECONNREFUSED) {
-- 
2.24.1

