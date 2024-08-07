Return-Path: <bpf+bounces-36596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7634F94AF20
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 19:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66EC01C20F35
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 17:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDF913DDCC;
	Wed,  7 Aug 2024 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0ty5SCA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AE213DB8D
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723053060; cv=none; b=lU7J5B23DiSuT1Bvtf259mcwb9xPDD8ocJfxI/y9SOWhlA8GEBX0nbx8zDWsH1dkXbPXsa07fh8A+cHNDm5rAHbzbmC5HEnwRLvdhuz8/4UAAntQtC0nOR8SCbIdtzrnHN7WSSRkLzrYHpGmqvkzEaNDTeNERa3XI7gTqOqZoRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723053060; c=relaxed/simple;
	bh=+PX0zS1lrv+aAW3cjo86xMr8nl6JojMmDr7Ijbf+xgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iUCzVCB03Jjq5SiKTemSLYX6zSMNz+xeoVfhT58d6Ywk68mDTMwX5BLUk7iV3EUzQSW/BRZY4P2cc1StifFyX6g3CkEx8fANaCpwJNNBygU/75aUhLnSP+aqhG2Fe3QSs1c6BHM6BX62LSoQ0h3un0lybyZjdSgnHl59CEwkfU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0ty5SCA; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-699d8dc6744so5370217b3.0
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2024 10:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723053058; x=1723657858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LX4+keBrWStPLYIu0fMoP6yLM+DZqx7XQl704HLSVZI=;
        b=f0ty5SCAUTftotpu90wsbbjwVry+C5JXQkfYN/i+CSF8KURqLCvUKQHDX4EspUVYfR
         cZlK4h+cHxZoQh0wEAIR7jCuCVq4Rwoa/UAacXge+NAW+qIRDuCppkSltjKNg/I6A3RS
         yIo9GqwHu98FAQsxQBVgq8hYN+9BV3+zfrVbUTeWEpwQWFW6jcLMuXylWeR8hu4uD+n4
         1LN12cByn36y7zluCwml7YetdAP2mElU8a3jAPg36hrUw9gEzyKzGPLbDJLVsyiaz+eH
         V9wBRLrOqtc2AVMUaluZeP7zLbByZfqcG5OkCSjIIC58ClXU75W/x1/bJM31CMBFHDTz
         cDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723053058; x=1723657858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LX4+keBrWStPLYIu0fMoP6yLM+DZqx7XQl704HLSVZI=;
        b=wz9pI6w7G5cfBYa4lhlIXViqSWwsvhRUE0iWg7f8LowVKgzCZNq/GDQjUetHczTQAU
         7gRYPEzOE4ZAG67axCLtuULq0QkUtopj7MndDyY98thGOVN1XgLq861hGGw0rByq1olQ
         FCBVYKQniZYJrbvpirZBZ6nscMUkG+3I5SwCapxShmRT0zrIC1BlC0piFVIos6ZbUiyD
         Az4oqDxY1dHg/P5klgSj2OzsIPTgJ0/TUHIXp1qMwHFT4nb31QyvNdPrtP4kpIexfZEm
         Wt6kcJuaWp/NQHEjZoq6WMNo023sMpPYb5LBGHeQ9o0klN37EEIbHLj5yKLkhYo5bquC
         8W0w==
X-Gm-Message-State: AOJu0YxLzM5sjIedoE9hNvblq2FGeFfP73ujjVKmW5umlG1a4ggTuThA
	pnMXPcfiztezJ7iNeAi53RiT/3N9hUCoPyOZ3KLjpildiKZWpeLbWs6920JA
X-Google-Smtp-Source: AGHT+IGQgeISBdXmlAWadCJXB5rEHzA7kzAwIcBCvJm5JMV5CvX9J5GN3SUL8nzjI5iSfMQHCMlitA==
X-Received: by 2002:a0d:cec5:0:b0:66b:c28b:f234 with SMTP id 00721157ae682-69912af4479mr27859927b3.21.1723053057850;
        Wed, 07 Aug 2024 10:50:57 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:fb5f:452b:3dfd:192])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68fcd1727f3sm14988727b3.90.2024.08.07.10.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 10:50:57 -0700 (PDT)
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
Subject: [RFC bpf-next v6 2/6] selftests/bpf: Add the traffic monitor option to test_progs.
Date: Wed,  7 Aug 2024 10:50:48 -0700
Message-Id: <20240807175052.674250-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807175052.674250-1-thinker.li@gmail.com>
References: <20240807175052.674250-1-thinker.li@gmail.com>
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


