Return-Path: <bpf+bounces-36610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2161C94AFCB
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 20:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18AC1F23CAA
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 18:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B00113E41F;
	Wed,  7 Aug 2024 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKxFevEn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57CB13E02E
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055518; cv=none; b=MvQrc1Z14E/ZMm+BcNGyRgTKLcMBOku1xklWuE2pbJIEpW6oRXU+F6gexbITvvN5IMCH+32Fpz7yDiPbVTzWNeOFSLUbaq7E2rNzGLnbb4CirfXxaSJwXA6agbZMklhrvE5MF2DTkFsQrLWEmZ4jQ+ZDBlg5LJSadBWsIdfNT8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055518; c=relaxed/simple;
	bh=+PX0zS1lrv+aAW3cjo86xMr8nl6JojMmDr7Ijbf+xgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M5RqR2JkduNF/IEK6sd8CCuZ7LpVV3ugvOjjsz+uWWCSYeNBRqlo4oLROFmZxHCorXnqgFygZWZIa1AahArfdjHVkfwN5wkZcG8Fxmk2qQXAqj2RMRRwqVYPRc3pv+wpZ0ZP5p7ymZz3ZEguVeI4dh3tB/IYFkKb/bz/Bb/Ubjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKxFevEn; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-70942ebcc29so85443a34.0
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2024 11:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723055516; x=1723660316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LX4+keBrWStPLYIu0fMoP6yLM+DZqx7XQl704HLSVZI=;
        b=IKxFevEn5Dct6IqkZTtukWWnAwSYIqncFG7ppaQgEdKQ5Kq8R173yINmhmKsjnt5Jn
         CaHRFpoeenJxVx0id0uwCZf6ZNRnMunNTujVFOHVdqg34+Cq6CmrzHxzLRAvzZCDpGve
         1TsXy7GDFAJ6hBurb6MeQ5crkH4Jnx7tGJjBCywX7NlW2C0ksJGH81bMiqGFzpRg0IC6
         HeBMsN0OK5vyg7Pw7guS5BzNv/WP/sqlRBhDX2VI2sNH980luKfXl/ovs68L9fd5LX7I
         XJYHMea2S51wrkC6mqos2rso8GEV2EBnKT/KCEzouZ+Dw0y4Fd2dw6OjA8RGB/gf9lpf
         t/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723055516; x=1723660316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LX4+keBrWStPLYIu0fMoP6yLM+DZqx7XQl704HLSVZI=;
        b=B9t+cdeGmLTBWEoFHMYKujRdTP7iLg1PgSKrIK89TABVeqOM6aKCpHwHIc5QGCM1dE
         Oo/1eWlziEK5OhRwlLQ+/ZN/BzAF/7pSY/Vy2j8Bz1juadI8XFWi6FfHA+Q514/CWEF3
         dXFDAg4TUvXkLB2SjBSRw1pAFw5cohorGEUhSy+ia+cah9ETd1zUccATz7tDpORK1DKc
         3zAZiw3g7mbBYzFRvr4vxdVvmpxE3DCe+pBqS/nwzfUiqklfB2HvIcw6mAhXU2i0U4IX
         xnUrFxB+uBz7+d7ximfp4CvcUqpBCHEZFSYe/AaIISeNteac6gwnCuLHSTEG84Ks9t+R
         XoKQ==
X-Gm-Message-State: AOJu0Yz32wwaJfKLQCgw6JIrldD1TrioUhzP8AQT+BOKU3yesAb/e0z/
	3HLpsZH1zpSqq3dvnO/Rjp8n7aA0Xc3OktWI7moZ1/1DtiJBrQya11uL+Jdj
X-Google-Smtp-Source: AGHT+IFc1XnID+Yp+CWEjlCxIpd2pMhn0rg7/2DNIm1Or7RJqDAdBk87fw2K8f0Bd7pZrWmX/jZexQ==
X-Received: by 2002:a05:6358:71c9:b0:1aa:b9ec:50ca with SMTP id e5c5f4694b2df-1af3bb8f601mr2390362555d.25.1723055515638;
        Wed, 07 Aug 2024 11:31:55 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:fb5f:452b:3dfd:192])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a0f4188a9sm20106447b3.2.2024.08.07.11.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:31:55 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	sdf@fomichev.me,
	geliang@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v6 2/6] selftests/bpf: Add the traffic monitor option to test_progs.
Date: Wed,  7 Aug 2024 11:31:45 -0700
Message-Id: <20240807183149.764711-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807183149.764711-1-thinker.li@gmail.com>
References: <20240807183149.764711-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add option '-m' to test_progs to accept names and patterns of test cases.
This option will be used later to enable traffic monitor that capture
network packets generated by test cases.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/testing/selftests/bpf/test_progs.c | 87 +++++++++++++++++-------
 tools/testing/selftests/bpf/test_progs.h |  2 +
 2 files changed, 65 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 60fafa2f1ed7..fed22e9fd223 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -155,6 +155,7 @@ struct prog_test_def {
 	void (*run_serial_test)(void);
 	bool should_run;
 	bool need_cgroup_cleanup;
+	bool should_tmon;
 };
 
 /* Override C runtime library's usleep() implementation to ensure nanosleep()
@@ -192,46 +193,59 @@ static bool should_run(struct test_selector *sel, int num, const char *name)
 	return num < sel->num_set_len && sel->num_set[num];
 }
 
-static bool should_run_subtest(struct test_selector *sel,
-			       struct test_selector *subtest_sel,
-			       int subtest_num,
-			       const char *test_name,
-			       const char *subtest_name)
+static bool match_subtest(struct test_filter_set *filter,
+			  const char *test_name,
+			  const char *subtest_name)
 {
 	int i, j;
 
-	for (i = 0; i < sel->blacklist.cnt; i++) {
-		if (glob_match(test_name, sel->blacklist.tests[i].name)) {
-			if (!sel->blacklist.tests[i].subtest_cnt)
-				return false;
-
-			for (j = 0; j < sel->blacklist.tests[i].subtest_cnt; j++) {
-				if (glob_match(subtest_name,
-					       sel->blacklist.tests[i].subtests[j]))
-					return false;
-			}
-		}
-	}
-
-	for (i = 0; i < sel->whitelist.cnt; i++) {
-		if (glob_match(test_name, sel->whitelist.tests[i].name)) {
-			if (!sel->whitelist.tests[i].subtest_cnt)
+	for (i = 0; i < filter->cnt; i++) {
+		if (glob_match(test_name, filter->tests[i].name)) {
+			if (!filter->tests[i].subtest_cnt)
 				return true;
 
-			for (j = 0; j < sel->whitelist.tests[i].subtest_cnt; j++) {
+			for (j = 0; j < filter->tests[i].subtest_cnt; j++) {
 				if (glob_match(subtest_name,
-					       sel->whitelist.tests[i].subtests[j]))
+					       filter->tests[i].subtests[j]))
 					return true;
 			}
 		}
 	}
 
+	return false;
+}
+
+static bool should_run_subtest(struct test_selector *sel,
+			       struct test_selector *subtest_sel,
+			       int subtest_num,
+			       const char *test_name,
+			       const char *subtest_name)
+{
+	if (match_subtest(&sel->blacklist, test_name, subtest_name))
+		return false;
+
+	if (match_subtest(&sel->whitelist, test_name, subtest_name))
+		return true;
+
 	if (!sel->whitelist.cnt && !subtest_sel->num_set)
 		return true;
 
 	return subtest_num < subtest_sel->num_set_len && subtest_sel->num_set[subtest_num];
 }
 
+static bool should_tmon(struct test_selector *sel, int num, const char *name)
+{
+	int i;
+
+	for (i = 0; i < sel->whitelist.cnt; i++) {
+		if (glob_match(name, sel->whitelist.tests[i].name) &&
+		    !sel->whitelist.tests[i].subtest_cnt)
+			return true;
+	}
+
+	return false;
+}
+
 static char *test_result(bool failed, bool skipped)
 {
 	return failed ? "FAIL" : (skipped ? "SKIP" : "OK");
@@ -488,6 +502,10 @@ bool test__start_subtest(const char *subtest_name)
 		return false;
 	}
 
+	subtest_state->should_tmon = match_subtest(&env.tmon_selector.whitelist,
+						   test->test_name,
+						   subtest_name);
+
 	env.subtest_state = subtest_state;
 	stdio_hijack_init(&subtest_state->log_buf, &subtest_state->log_cnt);
 
@@ -667,7 +685,8 @@ enum ARG_KEYS {
 	ARG_TEST_NAME_GLOB_DENYLIST = 'd',
 	ARG_NUM_WORKERS = 'j',
 	ARG_DEBUG = -1,
-	ARG_JSON_SUMMARY = 'J'
+	ARG_JSON_SUMMARY = 'J',
+	ARG_TRAFFIC_MONITOR = 'm',
 };
 
 static const struct argp_option opts[] = {
@@ -694,6 +713,10 @@ static const struct argp_option opts[] = {
 	{ "debug", ARG_DEBUG, NULL, 0,
 	  "print extra debug information for test_progs." },
 	{ "json-summary", ARG_JSON_SUMMARY, "FILE", 0, "Write report in json format to this file."},
+#ifdef TRAFFIC_MONITOR
+	{ "traffic-monitor", ARG_TRAFFIC_MONITOR, "NAMES", 0,
+	  "Monitor network traffic of tests with name matching the pattern (supports '*' wildcard)." },
+#endif
 	{},
 };
 
@@ -905,6 +928,18 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 		break;
 	case ARGP_KEY_END:
 		break;
+#ifdef TRAFFIC_MONITOR
+	case ARG_TRAFFIC_MONITOR:
+		if (arg[0] == '@')
+			err = parse_test_list_file(arg + 1,
+						   &env->tmon_selector.whitelist,
+						   true);
+		else
+			err = parse_test_list(arg,
+					      &env->tmon_selector.whitelist,
+					      true);
+		break;
+#endif
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -1736,6 +1771,9 @@ int main(int argc, char **argv)
 				test->test_num, test->test_name, test->test_name, test->test_name);
 			exit(EXIT_ERR_SETUP_INFRA);
 		}
+		if (test->should_run)
+			test->should_tmon = should_tmon(&env.tmon_selector,
+							test->test_num, test->test_name);
 	}
 
 	/* ignore workers if we are just listing */
@@ -1820,6 +1858,7 @@ int main(int argc, char **argv)
 
 	free_test_selector(&env.test_selector);
 	free_test_selector(&env.subtest_selector);
+	free_test_selector(&env.tmon_selector);
 	free_test_states();
 
 	if (env.succ_cnt + env.fail_cnt + env.skip_cnt == 0)
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index cb9d6d46826b..966011eb7ec8 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -74,6 +74,7 @@ struct subtest_state {
 	int error_cnt;
 	bool skipped;
 	bool filtered;
+	bool should_tmon;
 
 	FILE *stdout_saved;
 };
@@ -98,6 +99,7 @@ struct test_state {
 struct test_env {
 	struct test_selector test_selector;
 	struct test_selector subtest_selector;
+	struct test_selector tmon_selector;
 	bool verifier_stats;
 	bool debug;
 	enum verbosity verbosity;
-- 
2.34.1


