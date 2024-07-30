Return-Path: <bpf+bounces-35959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C05F940223
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 02:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB7CCB22106
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 00:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18672563;
	Tue, 30 Jul 2024 00:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wm/toVbt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE6C17FD
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 00:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722299276; cv=none; b=nAEWzcwPgWLQB+IGh54fKxbCEkFs/q/M1igZX3Zi0hJsI7EGqRQMmU46RgPas9piWxQI8Fuq+uJuE4s6ilZvsMeHFEyoc5o98EKU+bqET03+iEJ2HmitB840Zum5VR2VHT+uuaqNb54cR+HABsTGLbEMlICvKHzR6j2qxlzpoLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722299276; c=relaxed/simple;
	bh=aIwisVROqNyedZRTYpyTdgD6CHZZd1TarD/jKw0ewN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lo7XjhyMG0w+5K9o50ozEgx330ZjdSHx4KdbkVam/A642KI/JfBbNPXaAiB03slaA+rbdwCNaCLBcp8xQIkEpRw+y+ZhfgQs8ULHbSLSDSNl1l9unLkl+vhiLSzDCRHm4HnSPRgc2gMyPXodrkUi0vN09mwVgKagnBM496GP1dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wm/toVbt; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-65f7bd30546so19907107b3.1
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 17:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722299273; x=1722904073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5PU37Q7qlelttIJ1jpNo/VGx4tvNLnO3b8rfN8jT38=;
        b=Wm/toVbthikj4QP93uo9Wv5zIpgb3XJ0Yc1ldkE2dAcqKfwtIXcEzSUkqcGUrtD0Qq
         1wgW+XiZ7+WVc57iFVaeDC6+I78M59TiGER1MHi9aGWpDHACaMSfyphD467frcuINfnD
         dcOM+t4yibfVfCOvt1h52xp1kAuO6hOEUu1cPbY8CLJeu67PNCrsBcftdp+9Nh7Np/ur
         WcLEed2jZ86rBq/vxgWQyYKZdckGKKsmMqdbJTH6gdCFp1t+1ea7+wTMjDG+UM4B958z
         nXv48FJXeWJWSJc102kyCECDpy93iJHncZRsw7rw+YoulPu/LIwVjRMZJM+uojDj8dms
         iwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722299273; x=1722904073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5PU37Q7qlelttIJ1jpNo/VGx4tvNLnO3b8rfN8jT38=;
        b=uMkVcFeR+fHHQtufe+hCYNv7ACDjLvWGrRQ3Pv7fpoCqJ6zd3JdAGKz8frAoR/xbyX
         n+AQQdNAduAT5mMBURxPJlBFp0gQi1VaPONuRTzsMQ/+NtDEVeJyfPsce49aXcsdk7O9
         AZUPIw0rhS6i1kfy37K0kofQb9sfTpyBEMLwxs6Gy10WWZ2oPR6f93656TrONf4hkLNX
         eZl0QQeKmIAUwQX3XeRC4fJ3GyWTMclY5Bo3n89TD7wInYIMcUv9qr1yGP2+Q44bEBLq
         phHL1gJ9qTl4Z32Qcc22jxnDD2kqiuW0R4LYhU3SiBLN3h62KLHTeuDmCePB7GNwPhWm
         uddQ==
X-Gm-Message-State: AOJu0YwJQ6tByeo686csFY4EvoZ086wEpaAYirG9eCPMCgK5TTHQh4La
	M9JhL5qAesTPLQCA18oAozMkf5UiKjCY/6NqGfrBDWmxNbngeupwk+JK0BQA
X-Google-Smtp-Source: AGHT+IFGscvEhPI6iaLUyU5/ce28TH/rqFdVvAaqpYS5F/Fvo2JsHvyG6ECVj6/7r9LODi84pH/YCA==
X-Received: by 2002:a81:c24d:0:b0:666:f7f:a05b with SMTP id 00721157ae682-68264e68b91mr4501747b3.0.1722299273587;
        Mon, 29 Jul 2024 17:27:53 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:5695:a85f:7b5f:e238])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756c44c698sm23052177b3.135.2024.07.29.17.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 17:27:53 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 2/6] selftests/bpf: Add the traffic monitor option to test_progs.
Date: Mon, 29 Jul 2024 17:27:41 -0700
Message-Id: <20240730002745.1484204-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730002745.1484204-1-thinker.li@gmail.com>
References: <20240730002745.1484204-1-thinker.li@gmail.com>
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
 tools/testing/selftests/bpf/test_progs.c | 85 +++++++++++++++++-------
 tools/testing/selftests/bpf/test_progs.h |  2 +
 2 files changed, 63 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 62303eca11f4..2fb375ecc095 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -156,6 +156,7 @@ struct prog_test_def {
 	void (*run_serial_test)(void);
 	bool should_run;
 	bool need_cgroup_cleanup;
+	bool should_tmon;
 };
 
 /* Override C runtime library's usleep() implementation to ensure nanosleep()
@@ -193,46 +194,59 @@ static bool should_run(struct test_selector *sel, int num, const char *name)
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
@@ -906,6 +920,10 @@ bool test__start_subtest(const char *subtest_name)
 		return false;
 	}
 
+	subtest_state->should_tmon = match_subtest(&env.tmon_selector.whitelist,
+						   test->test_name,
+						   subtest_name);
+
 	env.subtest_state = subtest_state;
 	stdio_hijack_init(&subtest_state->log_buf, &subtest_state->log_cnt);
 
@@ -1085,7 +1103,8 @@ enum ARG_KEYS {
 	ARG_TEST_NAME_GLOB_DENYLIST = 'd',
 	ARG_NUM_WORKERS = 'j',
 	ARG_DEBUG = -1,
-	ARG_JSON_SUMMARY = 'J'
+	ARG_JSON_SUMMARY = 'J',
+	ARG_TRAFFIC_MONITOR = 'm',
 };
 
 static const struct argp_option opts[] = {
@@ -1112,6 +1131,8 @@ static const struct argp_option opts[] = {
 	{ "debug", ARG_DEBUG, NULL, 0,
 	  "print extra debug information for test_progs." },
 	{ "json-summary", ARG_JSON_SUMMARY, "FILE", 0, "Write report in json format to this file."},
+	{ "traffic-monitor", ARG_TRAFFIC_MONITOR, "NAMES", 0,
+	  "Monitor network traffic of tests with name matching the pattern (supports '*' wildcard)." },
 	{},
 };
 
@@ -1323,6 +1344,18 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 		break;
 	case ARGP_KEY_END:
 		break;
+	case ARG_TRAFFIC_MONITOR: {
+		if (arg[0] == '@')
+			err = parse_test_list_file(arg + 1,
+						   &env->tmon_selector.whitelist,
+						   true);
+		else
+			err = parse_test_list(arg,
+					      &env->tmon_selector.whitelist,
+					      true);
+
+		break;
+	}
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -2154,6 +2187,9 @@ int main(int argc, char **argv)
 				test->test_num, test->test_name, test->test_name, test->test_name);
 			exit(EXIT_ERR_SETUP_INFRA);
 		}
+		if (test->should_run)
+			test->should_tmon = should_tmon(&env.tmon_selector,
+							test->test_num, test->test_name);
 	}
 
 	/* ignore workers if we are just listing */
@@ -2238,6 +2274,7 @@ int main(int argc, char **argv)
 
 	free_test_selector(&env.test_selector);
 	free_test_selector(&env.subtest_selector);
+	free_test_selector(&env.tmon_selector);
 	free_test_states();
 
 	if (env.succ_cnt + env.fail_cnt + env.skip_cnt == 0)
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 5a9191f69707..6c88e15564d6 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -74,6 +74,7 @@ struct subtest_state {
 	int error_cnt;
 	bool skipped;
 	bool filtered;
+	bool should_tmon;
 
 	FILE *stdout;
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


