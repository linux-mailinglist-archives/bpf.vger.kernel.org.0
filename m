Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18F517FF5B
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2019 19:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391630AbfHBRRQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Aug 2019 13:17:16 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:50922 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404015AbfHBRRQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Aug 2019 13:17:16 -0400
Received: by mail-pl1-f201.google.com with SMTP id d6so41954246pls.17
        for <bpf@vger.kernel.org>; Fri, 02 Aug 2019 10:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=O05bfBgCmRCYik5O2nL0bMxz4KwV9NNW1nSOu/Ju4u8=;
        b=VUwYDMroTNP+EHUxBbP89FLtpD1y9X1Wv47rFZHwmyCzdqSPuTzbQaQ/Y0Xwj5vcKb
         5f7rCm1zjd1L7UWHYQhLu4pFahBfll87Rz7l/RLi8RxRWK0cifC/Y4CxYuWexIT87FF9
         iSzaz3GxvZvITCWTaJqEg4s5A+/S57+zghhKhsX1gjZ53CDe+pFv1azCunbuiq5vm8ki
         ih8RXhejnDptmtnwdW68V4RxF60ZoRe4Dlp1GnHpvw0I4gM6rItpKh2M/Ax9R1yeyvOL
         sQDa2irqIFqkPHeLKGmB2bt0YcMuyr6489uUHptvn/Z4Imrm1ob13feymZWBM9tM2rAO
         d86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=O05bfBgCmRCYik5O2nL0bMxz4KwV9NNW1nSOu/Ju4u8=;
        b=lairlbn5cazfaXFHb4Mp3gayP3++R3MeDcn1+VqI2/H9hnwtb+SY9DtbfquAS57B0v
         laxrsQ7RoS6/g48ZNZdqxZcuoBsfCpwHqqbikzjZ2C3Cx+68/AR5l3Yxl5Av38WveBey
         R+qwaA7SI8/u8Ai7vs7YNhQ4Z8edCmLXVVmJh+ivEAXd3tA27VBd/oLmbgfEMd+YYlqc
         LYb/0WHzTjbw1OT3RPkdPLuUEa75j7teH7bghKUczS0YFvtTZGkwPnqxmJia1mtM5p+l
         D9IdQcTLyJdAJXiwhGDQ6WngwazHpy1aEc3ctZ1oDrSkgn0JzjS+WZcrT/BUV8g1guG/
         g5PQ==
X-Gm-Message-State: APjAAAVHVVZ/J0soXmA4EQ/jvisa5X6otytcmtn40rM6NTNKirlyLmn4
        RZt4nVX1Wabsw7rfhiRoDpo8Hf8=
X-Google-Smtp-Source: APXvYqxOsLjrHB32hLX1/JF4eKl/Ozavx1O6VnWAf00sl+5R5HoknsXTRK2rhSl0d7nk5gVa3df2MYo=
X-Received: by 2002:a63:4404:: with SMTP id r4mr123241068pga.245.1564766234786;
 Fri, 02 Aug 2019 10:17:14 -0700 (PDT)
Date:   Fri,  2 Aug 2019 10:17:08 -0700
In-Reply-To: <20190802171710.11456-1-sdf@google.com>
Message-Id: <20190802171710.11456-2-sdf@google.com>
Mime-Version: 1.0
References: <20190802171710.11456-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH bpf-next 1/3] selftests/bpf: test_progs: switch to open_memstream
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

Use open_memstream to override stdout during test execution.
The copy of the original stdout is held in env.stdout and used
to print subtest info and dump failed log.

test_{v,}printf are now simple wrappers around stdout and will be
removed in the next patch.

Cc: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/test_progs.c | 100 ++++++++++-------------
 tools/testing/selftests/bpf/test_progs.h |   2 +-
 2 files changed, 46 insertions(+), 56 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index db00196c8315..00d1565d01a3 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -40,14 +40,22 @@ static bool should_run(struct test_selector *sel, int num, const char *name)
 
 static void dump_test_log(const struct prog_test_def *test, bool failed)
 {
-	if (env.verbose || test->force_log || failed) {
-		if (env.log_cnt) {
-			fprintf(stdout, "%s", env.log_buf);
-			if (env.log_buf[env.log_cnt - 1] != '\n')
-				fprintf(stdout, "\n");
+	if (stdout == env.stdout)
+		return;
+
+	fflush(stdout); /* exports env.log_buf & env.log_cap */
+
+	if (env.log_cap && (env.verbose || test->force_log || failed)) {
+		int len = strlen(env.log_buf);
+
+		if (len) {
+			fprintf(env.stdout, "%s", env.log_buf);
+			if (env.log_buf[len - 1] != '\n')
+				fprintf(env.stdout, "\n");
+
+			fseeko(stdout, 0, SEEK_SET); /* rewind */
 		}
 	}
-	env.log_cnt = 0;
 }
 
 void test__end_subtest()
@@ -62,7 +70,7 @@ void test__end_subtest()
 
 	dump_test_log(test, sub_error_cnt);
 
-	printf("#%d/%d %s:%s\n",
+	fprintf(env.stdout, "#%d/%d %s:%s\n",
 	       test->test_num, test->subtest_num,
 	       test->subtest_name, sub_error_cnt ? "FAIL" : "OK");
 }
@@ -100,53 +108,7 @@ void test__force_log() {
 
 void test__vprintf(const char *fmt, va_list args)
 {
-	size_t rem_sz;
-	int ret = 0;
-
-	if (env.verbose || (env.test && env.test->force_log)) {
-		vfprintf(stderr, fmt, args);
-		return;
-	}
-
-try_again:
-	rem_sz = env.log_cap - env.log_cnt;
-	if (rem_sz) {
-		va_list ap;
-
-		va_copy(ap, args);
-		/* we reserved extra byte for \0 at the end */
-		ret = vsnprintf(env.log_buf + env.log_cnt, rem_sz + 1, fmt, ap);
-		va_end(ap);
-
-		if (ret < 0) {
-			env.log_buf[env.log_cnt] = '\0';
-			fprintf(stderr, "failed to log w/ fmt '%s'\n", fmt);
-			return;
-		}
-	}
-
-	if (!rem_sz || ret > rem_sz) {
-		size_t new_sz = env.log_cap * 3 / 2;
-		char *new_buf;
-
-		if (new_sz < 4096)
-			new_sz = 4096;
-		if (new_sz < ret + env.log_cnt)
-			new_sz = ret + env.log_cnt;
-
-		/* +1 for guaranteed space for terminating \0 */
-		new_buf = realloc(env.log_buf, new_sz + 1);
-		if (!new_buf) {
-			fprintf(stderr, "failed to realloc log buffer: %d\n",
-				errno);
-			return;
-		}
-		env.log_buf = new_buf;
-		env.log_cap = new_sz;
-		goto try_again;
-	}
-
-	env.log_cnt += ret;
+	vprintf(fmt, args);
 }
 
 void test__printf(const char *fmt, ...)
@@ -477,6 +439,32 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 	return 0;
 }
 
+static void stdout_hijack(void)
+{
+	if (env.verbose || (env.test && env.test->force_log)) {
+		/* nothing to do, output to stdout by default */
+		return;
+	}
+
+	/* stdout -> buffer */
+	fflush(stdout);
+	stdout = open_memstream(&env.log_buf, &env.log_cap);
+}
+
+static void stdout_restore(void)
+{
+	if (stdout == env.stdout)
+		return;
+
+	fclose(stdout);
+	free(env.log_buf);
+
+	env.log_buf = NULL;
+	env.log_cap = 0;
+
+	stdout = env.stdout;
+}
+
 int main(int argc, char **argv)
 {
 	static const struct argp argp = {
@@ -495,6 +483,7 @@ int main(int argc, char **argv)
 	srand(time(NULL));
 
 	env.jit_enabled = is_jit_enabled();
+	env.stdout = stdout;
 
 	for (i = 0; i < prog_test_cnt; i++) {
 		struct prog_test_def *test = &prog_test_defs[i];
@@ -508,6 +497,7 @@ int main(int argc, char **argv)
 				test->test_num, test->test_name))
 			continue;
 
+		stdout_hijack();
 		test->run_test();
 		/* ensure last sub-test is finalized properly */
 		if (test->subtest_name)
@@ -522,6 +512,7 @@ int main(int argc, char **argv)
 			env.succ_cnt++;
 
 		dump_test_log(test, test->error_cnt);
+		stdout_restore();
 
 		printf("#%d %s:%s\n", test->test_num, test->test_name,
 		       test->error_cnt ? "FAIL" : "OK");
@@ -529,7 +520,6 @@ int main(int argc, char **argv)
 	printf("Summary: %d/%d PASSED, %d FAILED\n",
 	       env.succ_cnt, env.sub_succ_cnt, env.fail_cnt);
 
-	free(env.log_buf);
 	free(env.test_selector.num_set);
 	free(env.subtest_selector.num_set);
 
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index afd14962456f..9fd89078494f 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -56,8 +56,8 @@ struct test_env {
 	bool jit_enabled;
 
 	struct prog_test_def *test;
+	FILE *stdout;
 	char *log_buf;
-	size_t log_cnt;
 	size_t log_cap;
 
 	int succ_cnt; /* successful tests */
-- 
2.22.0.770.g0f2c4a37fd-goog

