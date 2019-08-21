Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A49BB9880D
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2019 01:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbfHUXom (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Aug 2019 19:44:42 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:33336 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730709AbfHUXol (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Aug 2019 19:44:41 -0400
Received: by mail-yb1-f202.google.com with SMTP id n62so2910506ybg.0
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2019 16:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OP734iGIdmeaq8Cdc0GPz42aZMNpU2Up9/1+UftyNgQ=;
        b=LbxaqkLHGbJugPDYwuKR9fu89dpPy522kBl/I0ch4YsedpyoZd7Pf2NeWXhCzQsjlv
         BRvbpEpwvl1Sxc6R03eUSa6Qz+6Y6auLl2YP756cj4M+Ab7x7c9Ita+uH1gqRbOR4Kwk
         nosP/EukzF8n+Vs+UPUXaziMyHoNof41tAZe3ALvqMmSxLVJU3zXxPErVq+cP/SW9l75
         KEjEpYHqbjqUBkRD4I98HW8IkJNQWq3liO2bYIDApReezijz/MRDon5+f4gTrBpWTdmJ
         jegwaGP+hGGqTkkVAvSyHbwOagDwYPevlQCh/X6oaPbTYrFu1B/Sf76V27noGF00SCVw
         vwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OP734iGIdmeaq8Cdc0GPz42aZMNpU2Up9/1+UftyNgQ=;
        b=LphShSikYeaclApoXsZsGcNBAT3EnOdqbX5gW4HPPY2qLIA3+yJ9G/LIX3P0MaueKl
         IcPyE4flYOIH2tKXxd8s7i5KVTmmol24DrfopQKTerx/k88nyzhP/oGUlWDvFPXHIjfF
         kGIKNlhIcKSXJqixg/CuCEJbp3cbyQOgRMav30gIY0pQqhDM3rsogyQwNf5ZdncEFdQS
         zhqiXF+/G/ZhF+151Dg17mcDn7c9ceFO/lpjwxYpIXJwdkLe4BWSAEz50MmKXCnGbdCJ
         xmwX1RWfMk6ReVvUgMZG2zB8ZW0JG6pK/628ad4aKMfQk9v2R2eC3jsJw5TMydAj39M5
         KIoQ==
X-Gm-Message-State: APjAAAWFl7PBDt+qpVQrfKywDALbO+V5WbbjHyBvL06RItjgBWZbwuJk
        T1bfg5dug66Qku/VWh2rR11l2XA=
X-Google-Smtp-Source: APXvYqyyDZNKv08ZF/AULz4FqWYHrnc6NTi7ed8q5KViDJ9G4WWhPA6GX1ztweyby2VhXWiumI5gaSA=
X-Received: by 2002:a81:2915:: with SMTP id p21mr27806200ywp.152.1566431080547;
 Wed, 21 Aug 2019 16:44:40 -0700 (PDT)
Date:   Wed, 21 Aug 2019 16:44:27 -0700
In-Reply-To: <20190821234427.179886-1-sdf@google.com>
Message-Id: <20190821234427.179886-5-sdf@google.com>
Mime-Version: 1.0
References: <20190821234427.179886-1-sdf@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: test_progs: remove unused ret
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

send_signal test returns static codes from the subtests which
nobody looks at, let's rely on the CHECK macros instead.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/send_signal.c    | 42 +++++++++----------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index 40c2c5efdd3e..b607112c64e7 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -8,7 +8,7 @@ static void sigusr1_handler(int signum)
 	sigusr1_received++;
 }
 
-static int test_send_signal_common(struct perf_event_attr *attr,
+static void test_send_signal_common(struct perf_event_attr *attr,
 				    int prog_type,
 				    const char *test_name)
 {
@@ -23,13 +23,13 @@ static int test_send_signal_common(struct perf_event_attr *attr,
 
 	if (CHECK(pipe(pipe_c2p), test_name,
 		  "pipe pipe_c2p error: %s\n", strerror(errno)))
-		goto no_fork_done;
+		return;
 
 	if (CHECK(pipe(pipe_p2c), test_name,
 		  "pipe pipe_p2c error: %s\n", strerror(errno))) {
 		close(pipe_c2p[0]);
 		close(pipe_c2p[1]);
-		goto no_fork_done;
+		return;
 	}
 
 	pid = fork();
@@ -38,7 +38,7 @@ static int test_send_signal_common(struct perf_event_attr *attr,
 		close(pipe_c2p[1]);
 		close(pipe_p2c[0]);
 		close(pipe_p2c[1]);
-		goto no_fork_done;
+		return;
 	}
 
 	if (pid == 0) {
@@ -125,7 +125,7 @@ static int test_send_signal_common(struct perf_event_attr *attr,
 		goto disable_pmu;
 	}
 
-	err = CHECK(buf[0] != '2', test_name, "incorrect result\n");
+	CHECK(buf[0] != '2', test_name, "incorrect result\n");
 
 	/* notify child safe to exit */
 	write(pipe_p2c[1], buf, 1);
@@ -138,11 +138,9 @@ static int test_send_signal_common(struct perf_event_attr *attr,
 	close(pipe_c2p[0]);
 	close(pipe_p2c[1]);
 	wait(NULL);
-no_fork_done:
-	return err;
 }
 
-static int test_send_signal_tracepoint(void)
+static void test_send_signal_tracepoint(void)
 {
 	const char *id_path = "/sys/kernel/debug/tracing/events/syscalls/sys_enter_nanosleep/id";
 	struct perf_event_attr attr = {
@@ -159,21 +157,21 @@ static int test_send_signal_tracepoint(void)
 	if (CHECK(efd < 0, "tracepoint",
 		  "open syscalls/sys_enter_nanosleep/id failure: %s\n",
 		  strerror(errno)))
-		return -1;
+		return;
 
 	bytes = read(efd, buf, sizeof(buf));
 	close(efd);
 	if (CHECK(bytes <= 0 || bytes >= sizeof(buf), "tracepoint",
 		  "read syscalls/sys_enter_nanosleep/id failure: %s\n",
 		  strerror(errno)))
-		return -1;
+		return;
 
 	attr.config = strtol(buf, NULL, 0);
 
-	return test_send_signal_common(&attr, BPF_PROG_TYPE_TRACEPOINT, "tracepoint");
+	test_send_signal_common(&attr, BPF_PROG_TYPE_TRACEPOINT, "tracepoint");
 }
 
-static int test_send_signal_perf(void)
+static void test_send_signal_perf(void)
 {
 	struct perf_event_attr attr = {
 		.sample_period = 1,
@@ -181,11 +179,11 @@ static int test_send_signal_perf(void)
 		.config = PERF_COUNT_SW_CPU_CLOCK,
 	};
 
-	return test_send_signal_common(&attr, BPF_PROG_TYPE_PERF_EVENT,
-				       "perf_sw_event");
+	test_send_signal_common(&attr, BPF_PROG_TYPE_PERF_EVENT,
+				"perf_sw_event");
 }
 
-static int test_send_signal_nmi(void)
+static void test_send_signal_nmi(void)
 {
 	struct perf_event_attr attr = {
 		.sample_freq = 50,
@@ -205,25 +203,23 @@ static int test_send_signal_nmi(void)
 			printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n",
 			       __func__);
 			test__skip();
-			return 0;
+			return;
 		}
 		/* Let the test fail with a more informative message */
 	} else {
 		close(pmu_fd);
 	}
 
-	return test_send_signal_common(&attr, BPF_PROG_TYPE_PERF_EVENT,
-				       "perf_hw_event");
+	test_send_signal_common(&attr, BPF_PROG_TYPE_PERF_EVENT,
+				"perf_hw_event");
 }
 
 void test_send_signal(void)
 {
-	int ret = 0;
-
 	if (test__start_subtest("send_signal_tracepoint"))
-		ret |= test_send_signal_tracepoint();
+		test_send_signal_tracepoint();
 	if (test__start_subtest("send_signal_perf"))
-		ret |= test_send_signal_perf();
+		test_send_signal_perf();
 	if (test__start_subtest("send_signal_nmi"))
-		ret |= test_send_signal_nmi();
+		test_send_signal_nmi();
 }
-- 
2.23.0.187.g17f5b7556c-goog

