Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220871C7D66
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 00:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbgEFWcQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 18:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729870AbgEFWcQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 May 2020 18:32:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6F7C061A0F
        for <bpf@vger.kernel.org>; Wed,  6 May 2020 15:32:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h185so4459254ybg.6
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 15:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Cd6H1IN+k3QCESY2yMOzFUe9ra6aSXjPN2bt1pDPE6w=;
        b=RIySjJ7CIa0DHDP8faBaEH+cY0ImNpgKfR5YwcuR8+uljzI/bSqjwF6WN6CrkVa22N
         MVLlHGJEyH9qvWzU5oFwJAKX9But+FZ51xjDkJZ+BcFGBf9QeIBuQ7/aRoHk7R29Q7Nd
         6YulgbRZwZhhijhtgcmVO1f82wKeUhmMSZDTNn0FoFYufFeUIvp+bBf7JMm+z2u6TYcu
         knq1gcfbFxJk5LZmgmmqEf+6cUggkOPD4RKf3tM2fbPgymYhcFTNaPm5FOwZWl0T+y6W
         r2XdMyIBw+0V67/L4Qk3V2TElIjf6cmg0b/hhPd/Kxx2/Xe3i7I/R7aR2kkqvBdSORZr
         dKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Cd6H1IN+k3QCESY2yMOzFUe9ra6aSXjPN2bt1pDPE6w=;
        b=W+roEOsRaxZlajkYyOEp1T+3652SmPYNpWAv8rdMfGcCNbWfMpFi8lhjb3lJ8Osaam
         bLRhi3rDrsLZwXtZO5e89+Ceebtj6b8GdQvKnN0vfAMba5a4q5oe0I96wKG3F/vLNaL/
         rfLaI1UTcQMn5mWcEiiW4YnO7QraWWOyVb64z5Jt2tKHN2EE+SJHvVYHctXsjDLcAjWk
         +UCzFqLk68JpXtbEa1Zmm/9BG+psLgCh+9x5bh0aAyRcWMORDLPIEK62yHQth8ll5l6m
         hTaC15jXdbuNbkU7U3b5gr8cmhYtdRuFf1255LKF8YFPcmAvDq972ao6qJXgekuprQ/v
         J0YQ==
X-Gm-Message-State: AGi0PubK21TMeQdq6Uljne+/wbDPSTJet3NNKASrQMwa5XuKsbkhakgL
        8jkdbBeaKverHba6WjqqM5plees=
X-Google-Smtp-Source: APiQypKXEVjzOkX+56Mogduj37krdUrA4GNapWJBvSS7ePXrK+Kk2adEeM5S6iX9/dNmlHhusPEnNH8=
X-Received: by 2002:a25:80cd:: with SMTP id c13mr17513679ybm.335.1588804335286;
 Wed, 06 May 2020 15:32:15 -0700 (PDT)
Date:   Wed,  6 May 2020 15:32:07 -0700
In-Reply-To: <20200506223210.93595-1-sdf@google.com>
Message-Id: <20200506223210.93595-3-sdf@google.com>
Mime-Version: 1.0
References: <20200506223210.93595-1-sdf@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH bpf-next v3 2/5] selftests/bpf: adopt accept_timeout from sockmap_listen
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrey Ignatov <rdna@fb.com>, Martin KaFai Lau <kafai@fb.com>
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
Cc: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 43 +++++++++++++++----
 tools/testing/selftests/bpf/network_helpers.h |  4 ++
 .../selftests/bpf/prog_tests/sockmap_listen.c | 35 +--------------
 3 files changed, 40 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 6ad16dfebfb2..3c1b5a78331f 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -82,14 +82,7 @@ static void *server_thread(void *arg)
 	pthread_cond_signal(&server_started);
 	pthread_mutex_unlock(&server_started_mtx);
 
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
 		return ERR_PTR(-1);
@@ -162,3 +155,37 @@ int connect_to_fd(int family, int type, int server_fd)
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
index 4ed31706b7f4..9279c23ab52e 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -8,5 +8,9 @@ int start_server(int family, int type);
 int start_server_thread(int family, int type);
 void stop_server_thread(int fd);
 int connect_to_fd(int family, int type, int server_fd);
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

