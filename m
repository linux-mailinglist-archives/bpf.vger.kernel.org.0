Return-Path: <bpf+bounces-33421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B404491CBF3
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 11:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D692F1C2137F
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 09:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90AB4175A;
	Sat, 29 Jun 2024 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zfmxkhyn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03FF39AFD
	for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719654494; cv=none; b=bH7IpvnrBaMXdJFVaUdv5JbK/QJ810xUXUBzEuMHP2BXDh/N320zvEbxbRx/JXgRKvt2AqF4tAufsdsB6DCX90EQ58LkkiHk7Yw9jGRIRMy98+9iBeAReZhvbiQFGhhrvWRsTmILrJgiirM0Cin2PJugit60RMuJkD6FhydbfDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719654494; c=relaxed/simple;
	bh=yCZt+XVcSAr7lva+2GhMDW87L+I3GClfxPnsLYKLnrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IxaJNELpvEbrgGDv7cCGdexXdDFKC7l/ybWQdThaNgbIUpb/geXMKNIFuhI0IaMjyvO8KwFlcEpWvNq3oRaV+FqjDfqynWYbp2Q93jPIo1oPydYl/Zc2svldOn5ksCOIVImIaecIBBSYEZH/0ErcMEkYFI5t+SAN0bJAKs8Gnuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zfmxkhyn; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d5666a4860so792818b6e.2
        for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 02:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719654492; x=1720259292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzejdGYduNITsXseCl4pjy4KNIRrUs1ao04Ddv+xHA8=;
        b=Zfmxkhyn43zsOBZOEr+KcHY753fRDWYLDmGughNanxMnNr8deUHeXzHwN3PmsHVyGz
         ZO5omXyXdgVfyodxM+PK+RVW9a2GF3q/Fx88/gnmedVVkP47OfO8iuVrpbjzChRHihpC
         jF4F+Mny5htyMv4aDf9t1BA3wiao6Bo7RGed+tQ6lg0D0zd/toHmcVHeYJNuEslvEoIm
         G4+CTRR+VbJzCRaCatR6Nww0Mbyn4LX+yAaE6F8IHpJqnqUup6gtlUk4pn2jFd117rYR
         VqxeIPfojjcNvY3tuuDX3Wl8prlCgOz4FDF7JMELjxN6QWaTbWkfbuVjrittNxx5G9vT
         H0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719654492; x=1720259292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzejdGYduNITsXseCl4pjy4KNIRrUs1ao04Ddv+xHA8=;
        b=C6DAzUt+CFB8Se4RhbhkKxJNcI0vncBNCdXhbUx5pgFw9DPierfRJ7UxGUI7LallrE
         jNIAXs1DexEyYzM4Mz6WAmnb0dhoLPkdGCo1Cu+itohFa0eg83vAofsQfa1+95bY5Ajg
         GhMtz3hbWmYGGM286Gv0WFFquAiJmu3VmbimlVqnK23SfEOYbmjQ3IbLsXZPreCkLK3u
         A9nZKtVWFizDebjNK/LSE91X0wis8EpfXTmzhY4/mpigqsEosimPnkyGTCbgpkXm5S4H
         srtDz5BqdMWg3daXmLPYC6u1PV8jeJ3nWsB8u9pZgs+lsim0Gt4+WlGANU75uQ6VHB2v
         nkHg==
X-Gm-Message-State: AOJu0YyM6DbPPCoUyC4UaJLN6h2Mju1PM7H9IIr22GacgTS/jGf/GKKs
	DehFheYFeXoTHhwJwvBbiilsBvOIoINI4AqoIR/rAgRuTMO/SxRej6hF1Q==
X-Google-Smtp-Source: AGHT+IFNl2/wIr6iPus6I3mEapjgQi/KBQVDif3/F0wWl+ZeSHd4CoaDjdhLqBn+HtXybqDdLlNkSA==
X-Received: by 2002:a05:6808:1925:b0:3d2:1a21:782 with SMTP id 5614622812f47-3d6b5499d99mr730774b6e.56.1719654491646;
        Sat, 29 Jun 2024 02:48:11 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804989f5asm2948932b3a.195.2024.06.29.02.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 02:48:11 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next v1 6/8] selftests/bpf: extract test_loader->expect_msgs as a data structure
Date: Sat, 29 Jun 2024 02:47:31 -0700
Message-ID: <20240629094733.3863850-7-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240629094733.3863850-1-eddyz87@gmail.com>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Non-functional change: use a separate data structure to represented
expected messages in test_loader.
This would allow to use the same functionality for expected set of
disassembled instructions in the follow-up commit.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/test_loader.c | 81 ++++++++++++-----------
 1 file changed, 41 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index ac9d3e81abdb..d4bb68685ba5 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -55,11 +55,15 @@ struct expect_msg {
 	regex_t regex;
 };
 
+struct msgs {
+	struct expect_msg *patterns;
+	size_t cnt;
+};
+
 struct test_subspec {
 	char *name;
 	bool expect_failure;
-	struct expect_msg *expect_msgs;
-	size_t expect_msg_cnt;
+	struct msgs expect_msgs;
 	int retval;
 	bool execute;
 };
@@ -96,44 +100,45 @@ void test_loader_fini(struct test_loader *tester)
 	free(tester->log_buf);
 }
 
-static void free_test_spec(struct test_spec *spec)
+static void free_msgs(struct msgs *msgs)
 {
 	int i;
 
+	for (i = 0; i < msgs->cnt; i++)
+		if (msgs->patterns[i].regex_str)
+			regfree(&msgs->patterns[i].regex);
+	free(msgs->patterns);
+	msgs->patterns = NULL;
+	msgs->cnt = 0;
+}
+
+static void free_test_spec(struct test_spec *spec)
+{
 	/* Deallocate expect_msgs arrays. */
-	for (i = 0; i < spec->priv.expect_msg_cnt; i++)
-		if (spec->priv.expect_msgs[i].regex_str)
-			regfree(&spec->priv.expect_msgs[i].regex);
-	for (i = 0; i < spec->unpriv.expect_msg_cnt; i++)
-		if (spec->unpriv.expect_msgs[i].regex_str)
-			regfree(&spec->unpriv.expect_msgs[i].regex);
+	free_msgs(&spec->priv.expect_msgs);
+	free_msgs(&spec->unpriv.expect_msgs);
 
 	free(spec->priv.name);
 	free(spec->unpriv.name);
-	free(spec->priv.expect_msgs);
-	free(spec->unpriv.expect_msgs);
-
 	spec->priv.name = NULL;
 	spec->unpriv.name = NULL;
-	spec->priv.expect_msgs = NULL;
-	spec->unpriv.expect_msgs = NULL;
 }
 
-static int push_msg(const char *substr, const char *regex_str, struct test_subspec *subspec)
+static int push_msg(const char *substr, const char *regex_str, struct msgs *msgs)
 {
 	void *tmp;
 	int regcomp_res;
 	char error_msg[100];
 	struct expect_msg *msg;
 
-	tmp = realloc(subspec->expect_msgs,
-		      (1 + subspec->expect_msg_cnt) * sizeof(struct expect_msg));
+	tmp = realloc(msgs->patterns,
+		      (1 + msgs->cnt) * sizeof(struct expect_msg));
 	if (!tmp) {
 		ASSERT_FAIL("failed to realloc memory for messages\n");
 		return -ENOMEM;
 	}
-	subspec->expect_msgs = tmp;
-	msg = &subspec->expect_msgs[subspec->expect_msg_cnt];
+	msgs->patterns = tmp;
+	msg = &msgs->patterns[msgs->cnt];
 
 	if (substr) {
 		msg->substr = substr;
@@ -150,7 +155,7 @@ static int push_msg(const char *substr, const char *regex_str, struct test_subsp
 		}
 	}
 
-	subspec->expect_msg_cnt += 1;
+	msgs->cnt += 1;
 	return 0;
 }
 
@@ -272,25 +277,25 @@ static int parse_test_spec(struct test_loader *tester,
 			spec->mode_mask |= UNPRIV;
 		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX)) {
 			msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX) - 1;
-			err = push_msg(msg, NULL, &spec->priv);
+			err = push_msg(msg, NULL, &spec->priv.expect_msgs);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
 		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX_UNPRIV)) {
 			msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX_UNPRIV) - 1;
-			err = push_msg(msg, NULL, &spec->unpriv);
+			err = push_msg(msg, NULL, &spec->unpriv.expect_msgs);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
 		} else if (str_has_pfx(s, TEST_TAG_EXPECT_REGEX_PFX)) {
 			msg = s + sizeof(TEST_TAG_EXPECT_REGEX_PFX) - 1;
-			err = push_msg(NULL, msg, &spec->priv);
+			err = push_msg(NULL, msg, &spec->priv.expect_msgs);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
 		} else if (str_has_pfx(s, TEST_TAG_EXPECT_REGEX_PFX_UNPRIV)) {
 			msg = s + sizeof(TEST_TAG_EXPECT_REGEX_PFX_UNPRIV) - 1;
-			err = push_msg(NULL, msg, &spec->unpriv);
+			err = push_msg(NULL, msg, &spec->unpriv.expect_msgs);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
@@ -387,11 +392,12 @@ static int parse_test_spec(struct test_loader *tester,
 			spec->unpriv.execute = spec->priv.execute;
 		}
 
-		if (!spec->unpriv.expect_msgs) {
-			for (i = 0; i < spec->priv.expect_msg_cnt; i++) {
-				struct expect_msg *msg = &spec->priv.expect_msgs[i];
+		if (spec->unpriv.expect_msgs.cnt == 0) {
+			for (i = 0; i < spec->priv.expect_msgs.cnt; i++) {
+				struct expect_msg *msg = &spec->priv.expect_msgs.patterns[i];
 
-				err = push_msg(msg->substr, msg->regex_str, &spec->unpriv);
+				err = push_msg(msg->substr, msg->regex_str,
+					       &spec->unpriv.expect_msgs);
 				if (err)
 					goto cleanup;
 			}
@@ -443,19 +449,15 @@ static void emit_verifier_log(const char *log_buf, bool force)
 	fprintf(stdout, "VERIFIER LOG:\n=============\n%s=============\n", log_buf);
 }
 
-static void validate_case(struct test_loader *tester,
-			  struct test_subspec *subspec,
-			  struct bpf_object *obj,
-			  struct bpf_program *prog,
-			  int load_err)
+static void validate_msgs(char *log_buf, struct msgs *msgs)
 {
 	regmatch_t reg_match[1];
 	const char *match;
-	const char *log = tester->log_buf;
+	const char *log = log_buf;
 	int i, j, err;
 
-	for (i = 0; i < subspec->expect_msg_cnt; i++) {
-		struct expect_msg *msg = &subspec->expect_msgs[i];
+	for (i = 0; i < msgs->cnt; i++) {
+		struct expect_msg *msg = &msgs->patterns[i];
 
 		if (msg->substr) {
 			match = strstr(log, msg->substr);
@@ -473,9 +475,9 @@ static void validate_case(struct test_loader *tester,
 
 		if (!ASSERT_OK_PTR(match, "expect_msg")) {
 			if (env.verbosity == VERBOSE_NONE)
-				emit_verifier_log(tester->log_buf, true /*force*/);
+				emit_verifier_log(log_buf, true /*force*/);
 			for (j = 0; j <= i; j++) {
-				msg = &subspec->expect_msgs[j];
+				msg = &msgs->patterns[j];
 				fprintf(stderr, "%s %s: '%s'\n",
 					j < i ? "MATCHED " : "EXPECTED",
 					msg->substr ? "SUBSTR" : " REGEX",
@@ -694,9 +696,8 @@ void run_subtest(struct test_loader *tester,
 			goto tobj_cleanup;
 		}
 	}
-
 	emit_verifier_log(tester->log_buf, false /*force*/);
-	validate_case(tester, subspec, tobj, tprog, err);
+	validate_msgs(tester->log_buf, &subspec->expect_msgs);
 
 	if (should_do_test_run(spec, subspec)) {
 		/* For some reason test_verifier executes programs
-- 
2.45.2


