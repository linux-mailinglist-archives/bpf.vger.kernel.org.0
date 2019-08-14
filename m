Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 086168D85F
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2019 18:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfHNQrv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Aug 2019 12:47:51 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:53660 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbfHNQru (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Aug 2019 12:47:50 -0400
Received: by mail-pl1-f202.google.com with SMTP id y22so64983460plr.20
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2019 09:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=T3//wE3HCI/3ByfInvNbN4Ma41u+RbtVje+WMKN729w=;
        b=en9obOKIccXCwCjYzLjp93zzqZU3fkVuuEkHXQ5mpGdDv4enslXVD6D63bWjddCwi+
         gjM31NVpn+KLU0BvGLyDn+p23Kuv/QlPTIS+s8J8AtTMP7lsiFQ3ZmiQWe9Zv1Mwypnz
         ej8NbW2ZPxae1ugsXxJBENJglJ0tyIraMlT5ghri5tv8etYkA0+HKTC9LZPMaCLCEFiH
         LLOexEtJoXc3M9RQr2n6mOwI8LzmX1eSyXGspZURPb3QfJGNOQfzemfqpinuanYAbubV
         pd3GYOEWxeRatu6h4yO4t/M3xaKdz01GHRl4kH8bzFTqm/8FayBBorId0Z9K9U35awMx
         wm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T3//wE3HCI/3ByfInvNbN4Ma41u+RbtVje+WMKN729w=;
        b=pvuLBH62+xAoxDLfZ1EBGiXvrOKnurZnFwo4EhJvLUWAhupj4dlGd8syH/yUkNWaQB
         NLLb209LK7eRxIIQIX9NsRrdYW5zwvxiFoIeMjAZDEPFoWA0pyTq3ktUkukqW8sF8U+T
         5SlxVQMzuLkLQa7RwyJmfsg/oY4OFWbS/M2Z2BINu8zwVnIS1SSibTrQdj/46AM7KLb4
         OdvbZX7ODHAwV+a9m76vOBG8I3MHqSXU68t3sRSxEsKEB2QSHprKHf35H4uM+cYTkCqC
         86iS3zuo6oyK8OX2Pa+7QvYpDaZGUSA/3TOKUUL/GAnYMzxTdaxOZjm6t1Bw/Hdyk5iq
         lYmw==
X-Gm-Message-State: APjAAAWS7hACPgTpBcAo++WGmwvDAmPNxgQssPD1rIHmrI5Q3BbaHViZ
        olCKjBDDVNC8HzwEbq7s+qv+eOY=
X-Google-Smtp-Source: APXvYqyKnKDNaE/IxQz4eQzJ/gmghPay55SJB71zxyR0DG0Az85ks7MQXx6ZszIu60HcDXVuDXy+8gg=
X-Received: by 2002:a63:5c7:: with SMTP id 190mr101082pgf.67.1565801269487;
 Wed, 14 Aug 2019 09:47:49 -0700 (PDT)
Date:   Wed, 14 Aug 2019 09:47:40 -0700
In-Reply-To: <20190814164742.208909-1-sdf@google.com>
Message-Id: <20190814164742.208909-3-sdf@google.com>
Mime-Version: 1.0
References: <20190814164742.208909-1-sdf@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH bpf-next 2/4] selftests/bpf: test_progs: test__skip
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Export test__skip() to indicate skipped tests and use it in
test_send_signal_nmi().

Cc: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/prog_tests/send_signal.c | 1 +
 tools/testing/selftests/bpf/test_progs.c             | 9 +++++++--
 tools/testing/selftests/bpf/test_progs.h             | 2 ++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index 1575f0a1f586..40c2c5efdd3e 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -204,6 +204,7 @@ static int test_send_signal_nmi(void)
 		if (errno == ENOENT) {
 			printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n",
 			       __func__);
+			test__skip();
 			return 0;
 		}
 		/* Let the test fail with a more informative message */
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 1a7a2a0c0a11..1993f2ce0d23 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -121,6 +121,11 @@ void test__force_log() {
 	env.test->force_log = true;
 }
 
+void test__skip(void)
+{
+	env.skip_cnt++;
+}
+
 struct ipv4_packet pkt_v4 = {
 	.eth.h_proto = __bpf_constant_htons(ETH_P_IP),
 	.iph.ihl = 5,
@@ -535,8 +540,8 @@ int main(int argc, char **argv)
 			test->test_name);
 	}
 	stdio_restore();
-	printf("Summary: %d/%d PASSED, %d FAILED\n",
-	       env.succ_cnt, env.sub_succ_cnt, env.fail_cnt);
+	printf("Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
+	       env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
 
 	free(env.test_selector.num_set);
 	free(env.subtest_selector.num_set);
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 37d427f5a1e5..9defd35cb6c0 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -64,6 +64,7 @@ struct test_env {
 	int succ_cnt; /* successful tests */
 	int sub_succ_cnt; /* successful sub-tests */
 	int fail_cnt; /* total failed tests + sub-tests */
+	int skip_cnt; /* skipped tests */
 };
 
 extern int error_cnt;
@@ -72,6 +73,7 @@ extern struct test_env env;
 
 extern void test__force_log();
 extern bool test__start_subtest(const char *name);
+extern void test__skip(void);
 
 #define MAGIC_BYTES 123
 
-- 
2.23.0.rc1.153.gdeed80330f-goog

