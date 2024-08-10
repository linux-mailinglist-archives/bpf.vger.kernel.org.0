Return-Path: <bpf+bounces-36813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C504494DA26
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 04:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08F17B22595
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 02:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934CA132107;
	Sat, 10 Aug 2024 02:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyqHDRfp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3F127452
	for <bpf@vger.kernel.org>; Sat, 10 Aug 2024 02:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723257343; cv=none; b=lsV2FSGWlZMyEAkNLT+zfvy/LelZZBGUNaW0jeNHbcqvYAV2hottb4sMMFzs5sFJvi/2VM1/9Que39drmYG5ZChzTUz+OAFQHsBRAdbYgmHcjwo9ABOgGHyLoXq8ilwJbkv4mAbcJ2fi+oI+gz513OFgautljeA4FC8chsRm03A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723257343; c=relaxed/simple;
	bh=/KDny8j1ephud4jpNwERZ6XbH0I94D75jrBxrknXM5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bxFQ3r5ZrEndy5tSYC3FqzGISVljg9dPoToe9zsEi0p3lEv5P400dayvgf9O5X6a6VjjnFZehqzfmfGCZU1tL+fzk4c2lhpm4k8oiX5nLXw6L/bi1uGy4gjjoI1h5/UM1u4HxBgVyEyBLlbagQLNQ7CLqaOora66d1X7rC0N74A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyqHDRfp; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-68d30057ae9so25578817b3.1
        for <bpf@vger.kernel.org>; Fri, 09 Aug 2024 19:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723257340; x=1723862140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lit1xuNRvRvhjiBJeft9vByh8s2xh3Zrxy4U8nOaNvQ=;
        b=JyqHDRfpVKrFIw5K+ukH1GrTcMeKORulit9HYgFQEma7JFEwdSsnwEfDbHRRIwMRiP
         KWdo/h3NtPegS7II0qjgzAmTGL1CKokzDBGaKq/D24UqXKnNmPS1sSfnS+4+Nw1qJEX6
         xJfcTrI52cxuvU2IgGD224Jk7I3u05MgIBn0/iYfdX6X1LBaEo/7pmcQoFk01/aDmkED
         qdqpC2i2vC7iMeID/MF6qYVvCJqC5nxtr9/dHYifaWAEB6bg286HWC1Uctua1qB9i2Gl
         4ENfQ02SN/WvUmcmwuLr/Ewhwdkb1zcAJLPeS0EBuXjMDfF5s3Uw+NcD5pXofZZR+Nh9
         ZAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723257340; x=1723862140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lit1xuNRvRvhjiBJeft9vByh8s2xh3Zrxy4U8nOaNvQ=;
        b=RLTTALh4i2K+Ujw++zT7CAxciJxJV/lUNunB6wJjazEvalbc5O0iOvtJCBTgDVWuBw
         py5WulsCJ25K/YXnzGhdiWT7Bt8Cb25vdCIysr9I3cPh4fgNn3IiVeMq8LoYYS5ny39I
         Nyf/zdla7EBJkKYckmo8/MZMHxQM3T4+NCGWdH3J0AZ4aSOCivLAWtnzitln9DnOI832
         0gDZpzVPOCL0eCHVjwrVQ1zKq0B3wbKCxLLxCMk8FuHF7XXCZhwc9q5PWpjUKCuImR2m
         Vy2kawaJp3s7zStWqc5XmuDuddTjOpbcMCMSEq3d6CxuVNmL/ul5EY2veiDX86jqOkQG
         FApg==
X-Gm-Message-State: AOJu0YxaJRo5bq86BJa75TdLqc/SIJyuUMTBJKjlAJ9s1nEuT59gvpIG
	RR4GuSW1SC0Vr2p9TZGUiywlrWiUblxiuoyczqfzGQiU3ytCE/sDzoVg6XD/
X-Google-Smtp-Source: AGHT+IGFZEffmFqlopGak+XWpsi59DMlgRE/jhRj4XjDFni+7DX09dtY/EPhBfkr4pfYChTaG32tcQ==
X-Received: by 2002:a05:690c:4183:b0:64b:ead:3e3f with SMTP id 00721157ae682-69ec6037402mr32315257b3.22.1723257340263;
        Fri, 09 Aug 2024 19:35:40 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:e383:f1a1:d5c5:1cf2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6a0a451b371sm1280147b3.114.2024.08.09.19.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 19:35:39 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 2/6] selftests/bpf: Add the traffic monitor option to test_progs.
Date: Fri,  9 Aug 2024 19:35:30 -0700
Message-Id: <20240810023534.2458227-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240810023534.2458227-1-thinker.li@gmail.com>
References: <20240810023534.2458227-1-thinker.li@gmail.com>
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
 tools/testing/selftests/bpf/test_progs.c | 86 +++++++++++++++++-------
 tools/testing/selftests/bpf/test_progs.h |  2 +
 2 files changed, 64 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 60fafa2f1ed7..f8ed1a16a884 100644
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
 
+static bool should_tmon(struct test_selector *sel, const char *name)
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
@@ -1736,6 +1771,8 @@ int main(int argc, char **argv)
 				test->test_num, test->test_name, test->test_name, test->test_name);
 			exit(EXIT_ERR_SETUP_INFRA);
 		}
+		if (test->should_run)
+			test->should_tmon = should_tmon(&env.tmon_selector, test->test_name);
 	}
 
 	/* ignore workers if we are just listing */
@@ -1820,6 +1857,7 @@ int main(int argc, char **argv)
 
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


