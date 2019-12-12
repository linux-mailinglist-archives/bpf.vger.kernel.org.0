Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 397D111CA8F
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2019 11:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfLLKXN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Dec 2019 05:23:13 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41350 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbfLLKXN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Dec 2019 05:23:13 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so1647740ljc.8
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2019 02:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mZCa8HeRWszw3UxMsfD2fmhwb6gt/SB9ovIuPnMioaU=;
        b=l8Vc0Li+dRGhs5prs3ci2pnZ8iCOxS704GfRZj2+qbzTmgSN8N9QRCRWvGbcv8UGG3
         ih2ccMZCohmhQNU9XdEDPVDVyumhToHkM5bMSLtcXbWu5yQPO4f3TRalJKGAXY5QbOd3
         7wHM+lwMDLK3fVAMkQxxooCUqgO46ravi1Eow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mZCa8HeRWszw3UxMsfD2fmhwb6gt/SB9ovIuPnMioaU=;
        b=UVqE/bXyIRi1c7e+1NmfAhKFaGbm1M/tipJHZbpIcwO+bWbJb2Adf1a3Pp7ArVwAq+
         SPaYT7c7OivqymuRVPSknW0+oSC7jS7AtAJ8CsxuZfk2uscDSj+W3smyBBkKRK/XP54e
         1wi8QJNVaohrvnrLSqXT6HncslguWCWPmFIXSOhSUMQusxMLIRfT4Jt7NxO2zWqqaRXl
         f7NH1aSVW7HFNlkm5oKt9iu8RhMfZEyEwa1Nlwdxz3CxG/zA+FDZWcD5kx9qwWF/yPRM
         S5QuZ0i+4OXnhpdYUyHO8iDcrNXz8ef2d8+QczmMV+Rt/+8LNNWLyUGJ85qeZCX2bpKx
         NxVg==
X-Gm-Message-State: APjAAAW1PadMBqIeL7MgYBqZApgjAi8HZKR5dBt1YT/D2Yx+X2kaUY5a
        2YRGqyWyd1OYxAnHLHC5TDWxPeXv4bzubw==
X-Google-Smtp-Source: APXvYqywe2nK5WDUJsA0y/u7YmIGx+Dz1F3q2UeVsHddE2Zy2x7YNFV/5GKt7wec0uAmmKxEJAhKCA==
X-Received: by 2002:a2e:6e03:: with SMTP id j3mr5502173ljc.27.1576146191155;
        Thu, 12 Dec 2019 02:23:11 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id g6sm2787770lja.10.2019.12.12.02.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 02:23:10 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     Martin Lau <kafai@fb.com>, kernel-team@cloudflare.com
Subject: [PATCH bpf-next 08/10] selftests/bpf: Pull up printing the test name into test runner
Date:   Thu, 12 Dec 2019 11:22:57 +0100
Message-Id: <20191212102259.418536-9-jakub@cloudflare.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212102259.418536-1-jakub@cloudflare.com>
References: <20191212102259.418536-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Again, prepare for switching reuseport tests to test_progs framework.
test_progs framework will print the subtest name for us if we set it.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../selftests/bpf/test_select_reuseport.c     | 27 +++++++++----------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_select_reuseport.c b/tools/testing/selftests/bpf/test_select_reuseport.c
index cc35816b7b34..0d5687feb689 100644
--- a/tools/testing/selftests/bpf/test_select_reuseport.c
+++ b/tools/testing/selftests/bpf/test_select_reuseport.c
@@ -441,7 +441,6 @@ static void test_err_inner_map(int type, sa_family_t family)
 		.pass_on_failure = 0,
 	};
 
-	printf("%s: ", __func__);
 	expected_results[DROP_ERR_INNER_MAP]++;
 	do_test(type, family, &cmd, DROP_ERR_INNER_MAP);
 	printf("OK\n");
@@ -449,7 +448,6 @@ static void test_err_inner_map(int type, sa_family_t family)
 
 static void test_err_skb_data(int type, sa_family_t family)
 {
-	printf("%s: ", __func__);
 	expected_results[DROP_ERR_SKB_DATA]++;
 	do_test(type, family, NULL, DROP_ERR_SKB_DATA);
 	printf("OK\n");
@@ -462,7 +460,6 @@ static void test_err_sk_select_port(int type, sa_family_t family)
 		.pass_on_failure = 0,
 	};
 
-	printf("%s: ", __func__);
 	expected_results[DROP_ERR_SK_SELECT_REUSEPORT]++;
 	do_test(type, family, &cmd, DROP_ERR_SK_SELECT_REUSEPORT);
 	printf("OK\n");
@@ -473,7 +470,6 @@ static void test_pass(int type, sa_family_t family)
 	struct cmd cmd;
 	int i;
 
-	printf("%s: ", __func__);
 	cmd.pass_on_failure = 0;
 	for (i = 0; i < REUSEPORT_ARRAY_SIZE; i++) {
 		expected_results[PASS]++;
@@ -494,7 +490,6 @@ static void test_syncookie(int type, sa_family_t family)
 	if (type != SOCK_STREAM)
 		return;
 
-	printf("%s: ", __func__);
 	/*
 	 * +1 for TCP-SYN and
 	 * +1 for the TCP-ACK (ack the syncookie)
@@ -530,7 +525,6 @@ static void test_pass_on_err(int type, sa_family_t family)
 		.pass_on_failure = 1,
 	};
 
-	printf("%s: ", __func__);
 	expected_results[PASS_ERR_SK_SELECT_REUSEPORT] += 1;
 	do_test(type, family, &cmd, PASS_ERR_SK_SELECT_REUSEPORT);
 	printf("OK\n");
@@ -545,7 +539,6 @@ static void test_detach_bpf(int type, sa_family_t family)
 	struct cmd cmd = {};
 	int optvalue = 0;
 
-	printf("%s: ", __func__);
 	err = setsockopt(sk_fds[0], SOL_SOCKET, SO_DETACH_REUSEPORT_BPF,
 			 &optvalue, sizeof(optvalue));
 	CHECK(err == -1, "setsockopt(SO_DETACH_REUSEPORT_BPF)",
@@ -584,7 +577,7 @@ static void test_detach_bpf(int type, sa_family_t family)
 	printf("OK\n");
 	close(cli_fd);
 #else
-	printf("%s: SKIP\n", __func__);
+	printf("SKIP\n");
 #endif
 }
 
@@ -734,19 +727,22 @@ static const char *sotype_str(int sotype)
 	}
 }
 
+#define TEST_INIT(fn, ...) { fn, #fn, __VA_ARGS__ }
+
 static void test_config(int type, sa_family_t family, bool inany)
 {
 	const struct test {
 		void (*fn)(int sotype, sa_family_t family);
+		const char *name;
 		bool no_inner_map;
 	} tests[] = {
-		{ test_err_inner_map, true /* no_inner_map */ },
-		{ test_err_skb_data },
-		{ test_err_sk_select_port },
-		{ test_pass },
-		{ test_syncookie },
-		{ test_pass_on_err },
-		{ test_detach_bpf },
+		TEST_INIT(test_err_inner_map, true /* no_inner_map */),
+		TEST_INIT(test_err_skb_data),
+		TEST_INIT(test_err_sk_select_port),
+		TEST_INIT(test_pass),
+		TEST_INIT(test_syncookie),
+		TEST_INIT(test_pass_on_err),
+		TEST_INIT(test_detach_bpf),
 	};
 	const struct test *t;
 
@@ -756,6 +752,7 @@ static void test_config(int type, sa_family_t family, bool inany)
 
 	for (t = tests; t < tests + ARRAY_SIZE(tests); t++) {
 		setup_per_test(type, family, inany, t->no_inner_map);
+		printf("%s: ", t->name);
 		t->fn(type, family);
 		cleanup_per_test(t->no_inner_map);
 	}
-- 
2.23.0

