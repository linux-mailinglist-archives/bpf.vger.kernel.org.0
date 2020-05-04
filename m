Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D7F1C42EE
	for <lists+bpf@lfdr.de>; Mon,  4 May 2020 19:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbgEDReh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 May 2020 13:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729549AbgEDReg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 4 May 2020 13:34:36 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9299CC061A0E
        for <bpf@vger.kernel.org>; Mon,  4 May 2020 10:34:36 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 186so304102ybq.1
        for <bpf@vger.kernel.org>; Mon, 04 May 2020 10:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2g+oJRYLOrsKuFpc0J3Xz3fus20nXPDKH8t2GbFobk8=;
        b=roHoMtDszcN/CD2Rh5Zmr2bJhoexhrTpL1LSMEHsEl8SYjCVTjFxAPUQ9W/Q2jlMHb
         fGLLpiShA5fdYM8cWN4UXLguCsmS9aS14JG954F4KF9eb51EyJAemCBEAuNRf4DWl2Ba
         qp9l7gI5tQfpuqduGGBnRZKM/5i59UQzq7IWDBIpmePWnFJ1PCyKXua4srz+ShkxuJjh
         s48JFbLIpMIZuB4AR+Zhj03/pAuqVAjd6a4Vqlje+1hm86V95SLu3KBnPWAK5Ww+7DMa
         XoJYpJ042uTT0IwOZEHYb9kI+nw3ypEvgYcmuqhNMqEbh6WBHxzJ07GZOnDHzNqkNbUF
         4s7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2g+oJRYLOrsKuFpc0J3Xz3fus20nXPDKH8t2GbFobk8=;
        b=o/4WzoqP33GY9oVwhaDm3AM5RSc0iHcTZXnwFFukQ/+hsZ4GDyDJyIKWVa589Fhech
         R5wF1GiZGTP1CvdIfNd531OZ6QwfQz2FovaoniitAtrCeMj+2QinAs8UlQGXeyYmFfwc
         lUzhDSEsAofXXLeynecFdTLW11X1rr1JDClISgGmDAdxpO3R4EZ8KSEtWJk2W38RjHAl
         /BszwEn3TBwn9d3RcCJ4ThCBTEpa5UWeJbwikB7ZQqOOazAjyB6tEgTg3u0DV7GT0WMb
         1qJWnd6hTEf738OiGYg4THP2KU1IKI4xzRTfdM9awFRJTBAZFIC3y3jZ4W7xXBj85FKg
         1NvQ==
X-Gm-Message-State: AGi0PubRvP32jqkwNi9UnvIR8RvIA0srI0n1uKMDXfwKuQoj6Qr1M59Z
        vI84XPX4tZvmirwymypTHDqEtQc=
X-Google-Smtp-Source: APiQypLl2kREBLwI6IEEjPx7r4WPenyVSShCTrUfFujoE2snG5hgA2hrmd8uSHP8+C6cNulfjtnGYYI=
X-Received: by 2002:a25:c648:: with SMTP id k69mr480372ybf.340.1588613675655;
 Mon, 04 May 2020 10:34:35 -0700 (PDT)
Date:   Mon,  4 May 2020 10:34:28 -0700
In-Reply-To: <20200504173430.6629-1-sdf@google.com>
Message-Id: <20200504173430.6629-3-sdf@google.com>
Mime-Version: 1.0
References: <20200504173430.6629-1-sdf@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH bpf-next 2/4] selftests/bpf: adopt accept_timeout from sockmap_listen
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
 .../selftests/bpf/prog_tests/sockmap_listen.c | 34 ---------------
 tools/testing/selftests/bpf/test_progs.c      | 43 +++++++++++++++----
 tools/testing/selftests/bpf/test_progs.h      |  4 ++
 3 files changed, 39 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index d7d65a700799..a91c31e64274 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -195,40 +195,6 @@
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
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index ebf1b3272848..306056bc63ae 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -428,14 +428,7 @@ static void *server_thread(void *arg)
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
@@ -509,6 +502,40 @@ int connect_to_fd(int family, int server_fd)
 	return -1;
 }
 
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
+
 /* extern declarations for test funcs */
 #define DEFINE_TEST(name) extern void test_##name(void);
 #include <prog_tests/tests.h>
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 363a3f2273a4..4a48654a4f08 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -160,6 +160,10 @@ void *spin_lock_thread(void *arg);
 int start_server_thread(int family);
 void stop_server_thread(int fd);
 int connect_to_fd(int family, int server_fd);
+int accept_timeout(int fd, struct sockaddr *addr, socklen_t *len,
+		   unsigned int timeout_sec);
+int recv_timeout(int fd, void *buf, size_t len, int flags,
+		 unsigned int timeout_sec);
 
 #ifdef __x86_64__
 #define SYS_NANOSLEEP_KPROBE_NAME "__x64_sys_nanosleep"
-- 
2.26.2.526.g744177e7f7-goog

