Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E038D1C61FC
	for <lists+bpf@lfdr.de>; Tue,  5 May 2020 22:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgEEU1k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 May 2020 16:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728737AbgEEU1h (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 5 May 2020 16:27:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07617C061A0F
        for <bpf@vger.kernel.org>; Tue,  5 May 2020 13:27:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r14so3731165ybk.21
        for <bpf@vger.kernel.org>; Tue, 05 May 2020 13:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+E1I84pnBiogXJ7OhzwoGGANKqMvG8H7kQ9I6DXtIwk=;
        b=oEkrfcBRZUaJIsSVP/MhAOHEbbMeXXGlQD4F7s7i4T7hQll3J/i8g28ywsueDCFKmW
         Y4jnVr95lRIvzbcc3X6KPtadXZKNeReC4fj++f/XJmr+rcEv5oNOrBMbVLw+gpN7qUy8
         Gc0nZE/DN26nhXuFo+1BULpdm+XXoSj8p4MliyCJlIOaNN40E2E3UhzRReejqxPr3kJy
         fYjstfFV5nVtMnOBBWKuAGVzXj4sq03HbPIieLKOjZY4oA/3a0OZesd/FpwilUM6fiuT
         fXoYJ76ZoxkjKd6GJYUY6bKe6i2mVIqQNaxGPZgSAKvo/DkY99xLZ46rQpn+kXMf5w0s
         vhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+E1I84pnBiogXJ7OhzwoGGANKqMvG8H7kQ9I6DXtIwk=;
        b=jxGiNtcZlzy4ZQ+EjdaTiFFWR9jMmvGtTGqU2BktOo0TVYDTfgmpiuHh4O9yIxxEZA
         DZQQgRoWQgSq3M9uT/ASaJz/yG8yTGLjXwiBGhiG9ut/oSDgHaA0E6TxCj0t0cY5qNe0
         Y+O1kOsIkIDiQP3g0kXBd/anYN2jqDVs8TDfYXy0JqwbpOVB1Vn+KHrKPGChFEluDvSV
         XZGcYeHUn1rVP/rgc0IAoI7t4dm9m6xcTX2SwyPEgqjQMzfYysIGQnLfTWXFXo7rKQKx
         d927ITFv9aH9xRFpco0PgS0NgV21BGM/RpgGw/quAPaQVvRpmQQK5BQ2njwjou1y5rTH
         NQWg==
X-Gm-Message-State: AGi0PuYvAjFhorRv1h6EH04DD1/hqFs7csszwMP9vLPHg5ohk8PqBkLg
        GobE1kpuIzOdOQGvAw510gozzt8=
X-Google-Smtp-Source: APiQypKq0cGsECMunZRtqCbvyY7hIxTruXrjKRIpUKzJmZvgu1BYnBy/JWd/JIix94smNgdQ4OAXwJY=
X-Received: by 2002:a25:cc48:: with SMTP id l69mr7750179ybf.130.1588710456212;
 Tue, 05 May 2020 13:27:36 -0700 (PDT)
Date:   Tue,  5 May 2020 13:27:27 -0700
In-Reply-To: <20200505202730.70489-1-sdf@google.com>
Message-Id: <20200505202730.70489-3-sdf@google.com>
Mime-Version: 1.0
References: <20200505202730.70489-1-sdf@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH bpf-next v2 2/5] selftests/bpf: adopt accept_timeout from sockmap_listen
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrey Ignatov <rdna@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move accept_timeout and recv_timeout to the common place so they
can be reused by the other tests. Switch to accept_timeout() in
test_progs instead of doing while loop around accept().

This prevents the tests that use start_server_thread/stop_server_thread
from being stuck when the error occurs.

Cc: Andrey Ignatov <rdna@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 43 +++++++++++++++----
 tools/testing/selftests/bpf/network_helpers.h |  4 ++
 .../selftests/bpf/prog_tests/sockmap_listen.c | 35 +--------------
 3 files changed, 40 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index ee9386b033ed..30ef0c7edebf 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -82,14 +82,7 @@ static void *server_thread(void *arg)
 		return ERR_PTR(err);
 	}
 
-	while (true) {
-		client_fd = accept(fd, (struct sockaddr *)&addr, &len);
-		if (client_fd == -1 && errno == EAGAIN) {
-			usleep(50);
-			continue;
-		}
-		break;
-	}
+	client_fd = accept_timeout(fd, (struct sockaddr *)&addr, &len, 3);
 	if (CHECK_FAIL(client_fd < 0)) {
 		perror("Failed to accept client");
 		return ERR_PTR(err);
@@ -162,3 +155,37 @@ int connect_to_fd(int family, int server_fd)
 	close(fd);
 	return -1;
 }
+
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
+int accept_timeout(int fd, struct sockaddr *addr, socklen_t *len,
+		   unsigned int timeout_sec)
+{
+	if (poll_read(fd, timeout_sec))
+		return -1;
+
+	return accept(fd, addr, len);
+}
+
+int recv_timeout(int fd, void *buf, size_t len, int flags,
+		 unsigned int timeout_sec)
+{
+	if (poll_read(fd, timeout_sec))
+		return -1;
+
+	return recv(fd, buf, len, flags);
+}
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 1f3942160287..74e2c40667a2 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -7,5 +7,9 @@
 int start_server_thread(int family);
 void stop_server_thread(int fd);
 int connect_to_fd(int family, int server_fd);
+int accept_timeout(int fd, struct sockaddr *addr, socklen_t *len,
+		   unsigned int timeout_sec);
+int recv_timeout(int fd, void *buf, size_t len, int flags,
+		 unsigned int timeout_sec);
 
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index d7d65a700799..c2a78d8a110e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -24,6 +24,7 @@
 
 #include "bpf_util.h"
 #include "test_progs.h"
+#include "network_helpers.h"
 #include "test_sockmap_listen.skel.h"
 
 #define IO_TIMEOUT_SEC 30
@@ -195,40 +196,6 @@
 		__ret;                                                         \
 	})
 
-static int poll_read(int fd, unsigned int timeout_sec)
-{
-	struct timeval timeout = { .tv_sec = timeout_sec };
-	fd_set rfds;
-	int r;
-
-	FD_ZERO(&rfds);
-	FD_SET(fd, &rfds);
-
-	r = select(fd + 1, &rfds, NULL, NULL, &timeout);
-	if (r == 0)
-		errno = ETIME;
-
-	return r == 1 ? 0 : -1;
-}
-
-static int accept_timeout(int fd, struct sockaddr *addr, socklen_t *len,
-			  unsigned int timeout_sec)
-{
-	if (poll_read(fd, timeout_sec))
-		return -1;
-
-	return accept(fd, addr, len);
-}
-
-static int recv_timeout(int fd, void *buf, size_t len, int flags,
-			unsigned int timeout_sec)
-{
-	if (poll_read(fd, timeout_sec))
-		return -1;
-
-	return recv(fd, buf, len, flags);
-}
-
 static void init_addr_loopback4(struct sockaddr_storage *ss, socklen_t *len)
 {
 	struct sockaddr_in *addr4 = memset(ss, 0, sizeof(*ss));
-- 
2.26.2.526.g744177e7f7-goog

