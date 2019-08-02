Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 762548021B
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2019 23:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731265AbfHBVLP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Aug 2019 17:11:15 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:41058 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfHBVLP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Aug 2019 17:11:15 -0400
Received: by mail-yb1-f202.google.com with SMTP id q196so58009146ybg.8
        for <bpf@vger.kernel.org>; Fri, 02 Aug 2019 14:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/ayBitId/HEhPorEq5NqiLjp7PwMslc/VCgo9cbAoMw=;
        b=LkbFmoY87NwZKW+e+UCdnqWWUOUlNcXZAojTYR4Y57z3gg37liXbw7JsjrjuBWKfPI
         PebUDChxUX17nJ/gaQnbfQ5cx2O+3tUOWd8YdRatXZxBtzZXqN4C4gv5IXFTek1bkAL5
         7oSwMURfpjvDLGCjregmEGXzyUiqSW3R43LZ7pHs6uD9m3f8IJ/ns/YYXPw2QNjf0GGE
         Zfw/7SjRfjGo9urf3bQHq1BwLjYxfNrFQpLRfAsA4CelIoltvPLH8vjPXf4U6jw53BuA
         x4jDN94ZmrjNE6IrQhIfSLCP99SVghcCSEZovD2xuN1njaOwhPCwENk9Tbiq14jG8PQB
         7TRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/ayBitId/HEhPorEq5NqiLjp7PwMslc/VCgo9cbAoMw=;
        b=QrKTyyfw4eR+ZpVNXMJT0GEqXDVsdfyBX3HTaIKTtfXebks/v4+DCt/YZQVtpojaNX
         pHFjwHR4W96x0jcYA3PKMPhhWyIDx+QenwMRdkEr/HIPYeObYQ0WSBVb4OekA9WTOwkb
         iF1Z6kBncpOwYq7GYplIjqpAn9FRU5ZvESKLUXIUwhrSvTM1ZZvC7NyiHOl3MQfKgv6z
         AZ0Y9Wu/VWd7hoNgMoBWMpOBX1+QxIwdLFOSyXsJNRGXV11w+rEbjtsGxuvis0wNRed4
         +f0yHyrIlE2Mf/gWWvcCxuMuf5YuT/kE7gSoUX+L9cUbKtyeLoSeXzIdVu9HgSKZaX4e
         bVxw==
X-Gm-Message-State: APjAAAUtf+RwdOTrzC63XGyK+joWE8PEk8vzSbenzPkwTIukrriVylc8
        w+1ZdAf21quVw48IhoJoggMpDT8=
X-Google-Smtp-Source: APXvYqw5umqrGycMz0AjZR2Mnwm0Hijzp9PG63AlR34gfdx0JE1utiZpflrsRkDCeShy/ZfNSHDixaM=
X-Received: by 2002:a5b:9cb:: with SMTP id y11mr71217409ybq.387.1564780273887;
 Fri, 02 Aug 2019 14:11:13 -0700 (PDT)
Date:   Fri,  2 Aug 2019 14:11:06 -0700
In-Reply-To: <20190802211108.90739-1-sdf@google.com>
Message-Id: <20190802211108.90739-2-sdf@google.com>
Mime-Version: 1.0
References: <20190802211108.90739-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH bpf-next v2 1/3] selftests/bpf: test_progs: switch to open_memstream
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

v2:
* add ifdef __GLIBC__ around open_memstream (maybe pointless since
  we already depend on glibc for argp_parse)
* hijack stderr as well (Andrii Nakryiko)
* don't hijack for every test, do it once (Andrii Nakryiko)
* log_cap -> log_size (Andrii Nakryiko)
* do fseeko in a proper place (Andrii Nakryiko)
* check open_memstream returned value (Andrii Nakryiko)

Cc: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/test_progs.c | 124 ++++++++++++-----------
 tools/testing/selftests/bpf/test_progs.h |   4 +-
 2 files changed, 68 insertions(+), 60 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index db00196c8315..eb8743302a00 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -40,14 +40,23 @@ static bool should_run(struct test_selector *sel, int num, const char *name)
 
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
+	fflush(stdout); /* exports env.log_buf & env.log_size */
+
+	if (env.log_size && (env.verbose || test->force_log || failed)) {
+		int len = strlen(env.log_buf);
+
+		if (len) {
+			fprintf(env.stdout, "%s", env.log_buf);
+			if (env.log_buf[len - 1] != '\n')
+				fprintf(env.stdout, "\n");
+
 		}
 	}
-	env.log_cnt = 0;
+
+	fseeko(stdout, 0, SEEK_SET); /* rewind */
 }
 
 void test__end_subtest()
@@ -62,7 +71,7 @@ void test__end_subtest()
 
 	dump_test_log(test, sub_error_cnt);
 
-	printf("#%d/%d %s:%s\n",
+	fprintf(env.stdout, "#%d/%d %s:%s\n",
 	       test->test_num, test->subtest_num,
 	       test->subtest_name, sub_error_cnt ? "FAIL" : "OK");
 }
@@ -79,7 +88,8 @@ bool test__start_subtest(const char *name)
 	test->subtest_num++;
 
 	if (!name || !name[0]) {
-		fprintf(stderr, "Subtest #%d didn't provide sub-test name!\n",
+		fprintf(env.stderr,
+			"Subtest #%d didn't provide sub-test name!\n",
 			test->subtest_num);
 		return false;
 	}
@@ -100,53 +110,7 @@ void test__force_log() {
 
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
@@ -477,6 +441,48 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 	return 0;
 }
 
+static void stdio_hijack(void)
+{
+#ifdef __GLIBC__
+	if (env.verbose || (env.test && env.test->force_log)) {
+		/* nothing to do, output to stdout by default */
+		return;
+	}
+
+	/* stdout and stderr -> buffer */
+	fflush(stdout);
+
+	env.stdout = stdout;
+	env.stderr = stderr;
+
+	stdout = open_memstream(&env.log_buf, &env.log_size);
+	if (!stdout) {
+		stdout = env.stdout;
+		perror("open_memstream");
+		return;
+	}
+
+	stderr = stdout;
+#endif
+}
+
+static void stdio_restore(void)
+{
+#ifdef __GLIBC__
+	if (stdout == env.stdout)
+		return;
+
+	fclose(stdout);
+	free(env.log_buf);
+
+	env.log_buf = NULL;
+	env.log_size = 0;
+
+	stdout = env.stdout;
+	stderr = env.stderr;
+#endif
+}
+
 int main(int argc, char **argv)
 {
 	static const struct argp argp = {
@@ -496,6 +502,7 @@ int main(int argc, char **argv)
 
 	env.jit_enabled = is_jit_enabled();
 
+	stdio_hijack();
 	for (i = 0; i < prog_test_cnt; i++) {
 		struct prog_test_def *test = &prog_test_defs[i];
 		int old_pass_cnt = pass_cnt;
@@ -523,13 +530,14 @@ int main(int argc, char **argv)
 
 		dump_test_log(test, test->error_cnt);
 
-		printf("#%d %s:%s\n", test->test_num, test->test_name,
-		       test->error_cnt ? "FAIL" : "OK");
+		fprintf(env.stdout, "#%d %s:%s\n",
+			test->test_num, test->test_name,
+			test->error_cnt ? "FAIL" : "OK");
 	}
+	stdio_restore();
 	printf("Summary: %d/%d PASSED, %d FAILED\n",
 	       env.succ_cnt, env.sub_succ_cnt, env.fail_cnt);
 
-	free(env.log_buf);
 	free(env.test_selector.num_set);
 	free(env.subtest_selector.num_set);
 
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index afd14962456f..54f30d7731c6 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -56,9 +56,9 @@ struct test_env {
 	bool jit_enabled;
 
 	struct prog_test_def *test;
+	FILE *stdout, *stderr;
 	char *log_buf;
-	size_t log_cnt;
-	size_t log_cap;
+	size_t log_size;
 
 	int succ_cnt; /* successful tests */
 	int sub_succ_cnt; /* successful sub-tests */
-- 
2.22.0.770.g0f2c4a37fd-goog

