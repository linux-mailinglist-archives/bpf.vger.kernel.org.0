Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF0FFBBBBA
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2019 20:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfIWSlQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Sep 2019 14:41:16 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:41506 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfIWSlP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Sep 2019 14:41:15 -0400
Received: by mail-qk1-f202.google.com with SMTP id z128so18742212qke.8
        for <bpf@vger.kernel.org>; Mon, 23 Sep 2019 11:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fMgw2XDtlg2MKGwEmSN1ggH8Ih9ImcUsYN8hDE/yJck=;
        b=T2GN7KBId3t6Oi4TApBUQbisaod+N+si0W5w+cCXDYCcC2rJR6J/Aok5PGEu9Dxxm5
         G4dQbZH2o3ennEW7VhaGRSlVVu6la2iLerp1C9IfsTmQXx7x1SEt3zRvwewqcQyGSYKw
         zfhtiJpfXqld8LZmD25K1jTwrWNIQK+KC7kQL64zyKKd6t52cDekxZAFJRuH2a4D7mNG
         dyb7W7vw7ftCZFHTToH5wimscLbCBupKVwBqM3zZuUbko81mmRUvrapERcqP7FUAR/d2
         ePDY965ukomdACQyBwsadnu0+F5yirwNzcHEgvA6ESsLxuvAx1J03uwIq2hFxjpWWxIj
         RJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fMgw2XDtlg2MKGwEmSN1ggH8Ih9ImcUsYN8hDE/yJck=;
        b=o5Zyix3ctVtr0EmvyFgRKUs+USBFPVzZIXZQQwvQO+lLh0yYXYA+rp/gDMhlQn+vtP
         2+PDvXilj5Artim2INA0mcsAQkEaG70gnUXZ8TwXi5YrFPFl0D5Psa87FENtVWZhoYRO
         +n5pVx+iVJP1cNBpHp5eujjTbgkkrMYdAFtrJcsj2bSSIH7G8xQAylgm5oQ7tVDhHpKO
         XTTxjieg6SIG1N1w8warhdL3c1THCoF+MbeGSKO56kkhq3coNnm6IzEyTxb5j3DP9x6k
         YefsxXbiDbMGsy3i0GTW+E4WQFM5k5fdoawBH2qvH0tced8EuT/uxiQacFzDcknFauZB
         HNFQ==
X-Gm-Message-State: APjAAAUtm5JQjP7TvH+1wqqU2mX30mMKireffeR9Z2HNQYpY8MMuVOVx
        WVcxVxcQF55K+UQ1EQ8S7zvdZaY=
X-Google-Smtp-Source: APXvYqwLYI/g4b4jT4qlqPaRZQao9X0yC7Jz0UH85WVOhKqwEq3Uoqg6UIRtv1MxAMZazMCQfRCt8fc=
X-Received: by 2002:ac8:72d0:: with SMTP id o16mr1569385qtp.16.1569264074709;
 Mon, 23 Sep 2019 11:41:14 -0700 (PDT)
Date:   Mon, 23 Sep 2019 11:41:12 -0700
Message-Id: <20190923184112.196358-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH bpf v2] selftests/bpf: test_progs: fix client/server race in tcp_rtt
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is the same problem I found earlier in test_sockopt_inherit:
there is a race between server thread doing accept() and client
thread doing connect(). Let's explicitly synchronize them via
pthread conditional variable.

v2:
* don't exit from server_thread without signaling condvar,
  fixes possible issue where main() would wait forever (Andrii Nakryiko)

Fixes: b55873984dab ("selftests/bpf: test BPF_SOCK_OPS_RTT_CB")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/tcp_rtt.c        | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
index fdc0b3614a9e..a82da555b1b0 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
@@ -203,14 +203,24 @@ static int start_server(void)
 	return fd;
 }
 
+static pthread_mutex_t server_started_mtx = PTHREAD_MUTEX_INITIALIZER;
+static pthread_cond_t server_started = PTHREAD_COND_INITIALIZER;
+
 static void *server_thread(void *arg)
 {
 	struct sockaddr_storage addr;
 	socklen_t len = sizeof(addr);
 	int fd = *(int *)arg;
 	int client_fd;
+	int err;
+
+	err = listen(fd, 1);
+
+	pthread_mutex_lock(&server_started_mtx);
+	pthread_cond_signal(&server_started);
+	pthread_mutex_unlock(&server_started_mtx);
 
-	if (CHECK_FAIL(listen(fd, 1)) < 0) {
+	if (CHECK_FAIL(err < 0)) {
 		perror("Failed to listed on socket");
 		return NULL;
 	}
@@ -248,7 +258,14 @@ void test_tcp_rtt(void)
 	if (CHECK_FAIL(server_fd < 0))
 		goto close_cgroup_fd;
 
-	pthread_create(&tid, NULL, server_thread, (void *)&server_fd);
+	if (CHECK_FAIL(pthread_create(&tid, NULL, server_thread,
+				      (void *)&server_fd)))
+		goto close_cgroup_fd;
+
+	pthread_mutex_lock(&server_started_mtx);
+	pthread_cond_wait(&server_started, &server_started_mtx);
+	pthread_mutex_unlock(&server_started_mtx);
+
 	CHECK_FAIL(run_test(cgroup_fd, server_fd));
 	close(server_fd);
 close_cgroup_fd:
-- 
2.23.0.351.gc4317032e6-goog

