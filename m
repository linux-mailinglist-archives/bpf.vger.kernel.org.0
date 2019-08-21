Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB59C98807
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2019 01:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfHUXoe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Aug 2019 19:44:34 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:34562 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbfHUXod (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Aug 2019 19:44:33 -0400
Received: by mail-qt1-f202.google.com with SMTP id i1so4576145qtm.1
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2019 16:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Z9Fx2qHgrVFO0Xvkt9vhVDPtNI8t4fyGLLQEYR+6XgE=;
        b=CgRycxCysMA5xOQkR9Qjh7Uv4iCaF9jBPRNmLwkYC7j4ptr63XwXHva5mqgCnYL3uJ
         qzFpQHifN434JgjZSMjOoiE0+riw47IiMzrSXtEeb3cz9+rsYljsizPbl5XjDoUsVfi6
         yUb3e2PzHdTh7c3C+MVXXnK3XJcenYKvStjBPRPkeFXojah2ylkzWlnn0q1nFmx7tNOK
         /kW7AQ8TrRRIrglhiatKrnJch8zz9xEuPE7nYb7DeJq4wMMN1RSgghdbeQbxDdK0j5GB
         3atAdCimg3lDGEybrLV0PQ6VMyCQnFZC2NOfQ4Ukb98gOLxgLMTSZKqBmTIQ1Imrv7ya
         ETDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z9Fx2qHgrVFO0Xvkt9vhVDPtNI8t4fyGLLQEYR+6XgE=;
        b=VxaFe44wN1kPpyt0KaJARi3apPM7olHq7iv9tcqq2ZURm6dyueIemoWZWEEqLXHfgg
         h5AHUBJVWqOQEk/Su+EHpBFyokI0sUxaKzDRcVt9sw7I8meEuKxETs3etJxynwGHg8Kd
         VFUQWT7k5x/1ZVMPt4gzJpeiQqWUTv11sZ3FNy3lmgdpLFQTBQ/aY/QIU/hdkS/C37ja
         H3waLwv9/Ur2Y/aTntlIF6hhqoJLQIJpQKLKgU1neU583VccKYMGnLn9wat4DBw7dP7m
         PbSv/Go/lvc+PIKK53RVYXpJU8bfwMVytffsjJaSWj5RFgNkDoXa2Ak/J8WszwiRp6vu
         tenw==
X-Gm-Message-State: APjAAAUzqOGPnE3i/DITquWnnTGxZPxPE3F6oFvyLogGB5I14/nUsvkF
        L1CeURnItAHvQdOSRi8PCmaEnxU=
X-Google-Smtp-Source: APXvYqwkTm5KbK5ETfbO/YnKluADk3DY62ebRiiSjqtmnf7m1ISta/V5K/ZNQ97XyX/qjBg8M+oYaro=
X-Received: by 2002:a37:8c07:: with SMTP id o7mr19117735qkd.491.1566431072838;
 Wed, 21 Aug 2019 16:44:32 -0700 (PDT)
Date:   Wed, 21 Aug 2019 16:44:24 -0700
In-Reply-To: <20190821234427.179886-1-sdf@google.com>
Message-Id: <20190821234427.179886-2-sdf@google.com>
Mime-Version: 1.0
References: <20190821234427.179886-1-sdf@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH bpf-next v3 1/4] selftests/bpf: test_progs: test__skip
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
 .../selftests/bpf/prog_tests/send_signal.c    |  1 +
 tools/testing/selftests/bpf/test_progs.c      | 20 +++++++++++++++++--
 tools/testing/selftests/bpf/test_progs.h      |  2 ++
 3 files changed, 21 insertions(+), 2 deletions(-)

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
index 12895d03d58b..e545dfb55872 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -17,6 +17,7 @@ struct prog_test_def {
 	bool force_log;
 	int pass_cnt;
 	int error_cnt;
+	int skip_cnt;
 	bool tested;
 
 	const char *subtest_name;
@@ -56,6 +57,14 @@ static void dump_test_log(const struct prog_test_def *test, bool failed)
 	fseeko(stdout, 0, SEEK_SET); /* rewind */
 }
 
+static void skip_account(void)
+{
+	if (env.test->skip_cnt) {
+		env.skip_cnt++;
+		env.test->skip_cnt = 0;
+	}
+}
+
 void test__end_subtest()
 {
 	struct prog_test_def *test = env.test;
@@ -65,6 +74,7 @@ void test__end_subtest()
 		env.fail_cnt++;
 	else
 		env.sub_succ_cnt++;
+	skip_account();
 
 	dump_test_log(test, sub_error_cnt);
 
@@ -105,6 +115,11 @@ void test__force_log() {
 	env.test->force_log = true;
 }
 
+void test__skip(void)
+{
+	env.test->skip_cnt++;
+}
+
 struct ipv4_packet pkt_v4 = {
 	.eth.h_proto = __bpf_constant_htons(ETH_P_IP),
 	.iph.ihl = 5,
@@ -510,6 +525,7 @@ int main(int argc, char **argv)
 			env.fail_cnt++;
 		else
 			env.succ_cnt++;
+		skip_account();
 
 		dump_test_log(test, test->error_cnt);
 
@@ -518,8 +534,8 @@ int main(int argc, char **argv)
 			test->error_cnt ? "FAIL" : "OK");
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
2.23.0.187.g17f5b7556c-goog

