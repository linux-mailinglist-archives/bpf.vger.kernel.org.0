Return-Path: <bpf+bounces-36511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B8F949B02
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 00:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C29E828218F
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 22:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB342171E68;
	Tue,  6 Aug 2024 22:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htRzzO8e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4BB170A02
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 22:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982375; cv=none; b=ZWZEyMxgo62+1mDyYDvVL+zd1MK1iliX7E/BnNFrKXHE2ZG8mvlBt8X4zwU5G5sCCFQmmelIkzoIYTJxPJQ/PRgaMW6hxbmcZX2Q9d1dyfgqLCHLCWOIt+Sai9exEDcxrroYD1Ex3NhLNbDaRD0i37nomWRoQoUgGghZIPis10c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982375; c=relaxed/simple;
	bh=a5bM5D19pkC1WtS2oGrGcWce0KV//4c38rD/GyDqHO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ckXAn/YD33xUpACOFENauJANXl48CcseVsH3ta9nzayvIrbEVRozdWzrscB4OBuvqBEiyS/MoNFrRK8gQyPKRvijoqalgLNjTzR9gxCQ5fDLilGU+NxtjtlrBus+aSCx+vU4N72O+W9TIm6lLnepkhPUZ+nJ4WlHl0CFf/J4T2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htRzzO8e; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-67b709024bfso12736087b3.3
        for <bpf@vger.kernel.org>; Tue, 06 Aug 2024 15:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722982373; x=1723587173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvP8+JKfLQZnZsDFEkQJdTL0McoYwtKkB423Sdz4t20=;
        b=htRzzO8e/IwJ5duwfgBvmxVrTzW6UQlNdqoAFwCuOEPLikFvJemUVNWd/vTZ7/PVRF
         EGOmkgwtAiSNucIMeIDPTAM5vBtd7We9ioU0ovqbkE8YKXz72gnxiM/JJK6kVD2ShvcK
         1UNlASwo1jiC20o+dLuRJmLidQF+aqcOeSbPo12njrHn5V65eWYJQ3FhstPfqWbOAtUE
         2T6XAJwr11KuIzHsYW2Ar37/08xXJb2UE7vnbiy5Dp9jaDwaL986yEvWDVt9NVQLILFL
         IBdp6q5qESkvLH6trgbtrfljKl3YPTFp6+wmfLexBnNRxaGbXtC9kf9bb9wq2aA3frt5
         XcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722982373; x=1723587173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvP8+JKfLQZnZsDFEkQJdTL0McoYwtKkB423Sdz4t20=;
        b=AQ5CO4Lg5PZiUHcO4hlMIDutEjB9QgwBd/MrtcxltkX5Lvvr8kv/PpPxDzAeS4rv44
         LGptu2cSNOucRXjF7yH3Gj5R1pObJr8rvFqJD8Sgen1972rs8FLX6fzhIiJxzQUpCEvS
         PNX6fNf5vJTWIKstkpYyoMl5OhG5+T4Gh968137q5Bn55E/Nn+HMV2Rs4VEwFyF+xl7U
         RfBUG5M5jBcNSNmTKa4wp//Pm/FExjvZwBPXLEbb+G6n7YlZFH1L8tkHqNsXTfq/7Zlh
         4qftiVZb6XCfd4USXPaAnrVjgWZPrWDIszssD8RENOwAubb45IgonpRL9H7Zh4tv01QI
         kDAA==
X-Gm-Message-State: AOJu0YxA5mfhHU5wNoCQOVWggKMZamUYx2QSxyNOfk5eRFZwjjZcUc8F
	cdROhXbBM1CAFKdPKzRtCTl3tl5EP2kz7e4t3uzsDZZI5ICW27s5Wx6/wQhA
X-Google-Smtp-Source: AGHT+IGRuUjiUG1TQ/H5jCMw5wOhhpe0Rwl9k8UXJ3weFXvbE50YwI7sVyQJ+LHLmmVkm4RzuGZwaw==
X-Received: by 2002:a0d:d3c3:0:b0:61b:df5:7876 with SMTP id 00721157ae682-6895f41dff0mr160215747b3.6.1722982372736;
        Tue, 06 Aug 2024 15:12:52 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:cfe6:adb2:c0bb:6a13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a12d138b6sm16990017b3.88.2024.08.06.15.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 15:12:52 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 2/6] selftests/bpf: Add the traffic monitor option to test_progs.
Date: Tue,  6 Aug 2024 15:12:39 -0700
Message-Id: <20240806221243.1806879-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806221243.1806879-1-thinker.li@gmail.com>
References: <20240806221243.1806879-1-thinker.li@gmail.com>
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
index 60fafa2f1ed7..cfd2330a5230 100644
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
@@ -694,6 +713,8 @@ static const struct argp_option opts[] = {
 	{ "debug", ARG_DEBUG, NULL, 0,
 	  "print extra debug information for test_progs." },
 	{ "json-summary", ARG_JSON_SUMMARY, "FILE", 0, "Write report in json format to this file."},
+	{ "traffic-monitor", ARG_TRAFFIC_MONITOR, "NAMES", 0,
+	  "Monitor network traffic of tests with name matching the pattern (supports '*' wildcard)." },
 	{},
 };
 
@@ -905,6 +926,20 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 		break;
 	case ARGP_KEY_END:
 		break;
+	case ARG_TRAFFIC_MONITOR:
+#ifndef TRAFFIC_MONITOR
+		fprintf(stderr, "Traffic monitor is disabled.\n");
+#else
+		if (arg[0] == '@')
+			err = parse_test_list_file(arg + 1,
+						   &env->tmon_selector.whitelist,
+						   true);
+		else
+			err = parse_test_list(arg,
+					      &env->tmon_selector.whitelist,
+					      true);
+#endif
+		break;
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


