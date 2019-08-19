Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9500594DB4
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2019 21:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfHSTR6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Aug 2019 15:17:58 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:44642 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbfHSTR6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Aug 2019 15:17:58 -0400
Received: by mail-pl1-f201.google.com with SMTP id t2so2552669plq.11
        for <bpf@vger.kernel.org>; Mon, 19 Aug 2019 12:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hShxd4ltIa245wnoOhY0uQYOHxvsehg7IXlkK87plz8=;
        b=X9PBetkvzfE1wFof53s5fSnbSU8lwg5bU5h0t7Oe9bYSn90UUjX/dkl5vjju+m0TOH
         FOuQiWOfI6Q5kUF0r2FtZzo3VsqAHANsJr/eYJQqDvlP/JU9RMUF4m6h07WWSOwLaK3Z
         5mlwHdR573qXjCB/5ch2W83sT2+l6s90n6TRbjee4vCCHYa2bzftwzLorcaAiRumzypM
         eZqWXOC0r8riYiXsyVdn017BXI/BSeJgtG2xwmowl8VBMyhBpJsbYT2FuPLo67kqB90w
         LOvgX50puJHYa9ry2aWUV/glRXR0ZjS/j6yrqCMH/q7/3gOAULfYSMnSfY2Fe+9F/9AM
         A14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hShxd4ltIa245wnoOhY0uQYOHxvsehg7IXlkK87plz8=;
        b=gT9kW5BAaYzsanyEPHq/I6UHdfnBUmg/l2uZO/KMhWyHeya/D2gYzggO53Kms8VVMp
         f6c+rQJz5mw0UnohlUY0/Gn9wEsI5twVMhJTyJ4D0FVBXQw2tZz+U07Czh72ei8zXmSK
         iDfLCYhAdkXoH+dnMUWXlEYvwv/+Uq3eX+7RgPj3JWZRKXj8v07FcZmERw/AdxMWb8rj
         XjzH5OwxzZ5eXUWBFW/tuUCB9LlpNi0V8fRRpxOKs2AZgQcNbmOX9YL611u1mM0MGFoJ
         tLNJELmIn1DQD+jnO/BRUIKNTVcL2cOJo+sBNDhYV44ErGNJkSEnpyGssguGhedVxMu9
         IXcA==
X-Gm-Message-State: APjAAAWdqZs3P1iyKIv68myv39NXKuvo3YXLNOvgdKd2qxdMBz12L7Dg
        rtCLTTQm0d89h+FhF8UZioxItfI=
X-Google-Smtp-Source: APXvYqwIVMAYsrIMwVDIMKxOKiG44Ve4sqIt7ji4vvkWuKRIUxXKgnaFTc7onkauvXpLqjavghJ9pSc=
X-Received: by 2002:a65:534c:: with SMTP id w12mr21438458pgr.51.1566242277325;
 Mon, 19 Aug 2019 12:17:57 -0700 (PDT)
Date:   Mon, 19 Aug 2019 12:17:49 -0700
In-Reply-To: <20190819191752.241637-1-sdf@google.com>
Message-Id: <20190819191752.241637-2-sdf@google.com>
Mime-Version: 1.0
References: <20190819191752.241637-1-sdf@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH bpf-next v2 1/4] selftests/bpf: test_progs: test__skip
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
2.23.0.rc1.153.gdeed80330f-goog

