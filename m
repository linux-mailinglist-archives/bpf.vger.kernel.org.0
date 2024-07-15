Return-Path: <bpf+bounces-34859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9472931D70
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 01:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2191C215DD
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 23:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8887620DF4;
	Mon, 15 Jul 2024 23:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYTjmnJ0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8818C13FD66
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721084557; cv=none; b=Hbjg7dEWtsckIGIXtZzzP5C8xeWjoM2jxGiN6B29VRq5OscDWKTFPus94U22DOVuLsTxRgUVnY6gV0sqlSIGv7WpGTGTuwBGENqv1Q1XLxooHP1zQ7/QxP+Ry4GVnTSqpe2UzstY2JDRZ9JzvFaWgqXbuAm1UV2wsKwCrQhQejU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721084557; c=relaxed/simple;
	bh=zHssEFSew6/7/I5d3v96ywaAl8Z3NeUArp5+VNQy/C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOHrsT6B91v2xyjOG/beqcvvEYvaFC7pctgSxrVK9KzyzT0YMl7u7hH18mB9ebggjB8M1cXYTtWVzJNXTZ4VyS/dgg4OFVFNeRbWLBNKKBIdxAxyW1rvCFvy/LjnSB6ltZWPgeT3vXxXqFHvflRKoNjAMZ/1eGNdw7qKemClakA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYTjmnJ0; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70afe18837cso3020979b3a.3
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 16:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721084554; x=1721689354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Skpti20qxoE6XuXbBaxdLW/TvxJxIRzVhmXOURRx+sc=;
        b=QYTjmnJ0NoH4F0Xzs2rlKEeTkH28uKXQO3jLQi8pECQ4zotwPE57mdEhEu99PltH34
         s0LHteGtf3Q6G9J6SyuYnpBCsnCzhzNzb6wO7yhytV3XUMK/k62AketqNNaD9OekAs7K
         S2Nj3E8PCSKHQAAJfEF4lxOli5ii+KIuTJsmIf7raecWrXZxUlcQZ5Lr33N9qSOcGMae
         gQ3SM2Wj8B1Z5+2r+F2BESbf/vTZ9OngdHPBDDhMZoHIW9ANtymeCHhzy+EA+3FQg4vz
         Nb7e1pZsDRYbWGv7H18YSLpPA0n0jY4QGNv4d4ZCUdgdchAMWS2+Tc9IsZuMqczm8sHe
         NNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721084554; x=1721689354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Skpti20qxoE6XuXbBaxdLW/TvxJxIRzVhmXOURRx+sc=;
        b=tgaNJHyQe94Sk7SD44zmF5lNx2PNzHVvl4DPhnOKlWKUUqWFe3WlyJCV2sHmrjQ57W
         gpwNesn+oJDf/5S/ZQY2dKorvrng4OxAGouly7F4DNQVtbdGxRjVsm7HpBiZUVmoVpoL
         weBTACN5d4Srm6wvSfz3vzYR/7M6GQjJDllmO0AXvVVkBj9Yp6RLdX2VHgV2FbJtuSI+
         uZ+ZNmehPMfJQRnHubnlnWIQVYFAEh7Rj9/RL21pEItPL+EDCxAHV2lV/GcVoTfdjC8g
         xRyJD2ysYwVUliSpmrSkaG5ffgTnSaBVn/rdue/uZdhRfrVoJzce7Gx6jDWaOyAb7oLc
         fM4g==
X-Gm-Message-State: AOJu0YxdHOnW+isnrMMX1ZIiOTPIF908q8bhEoVCIylVKq1ZW1u6uJrY
	RuYkw6uAo9Jg9hn1RJiWKS3Gr5eW9Bi04UzuheGDvelD98GuaH+wANItgw==
X-Google-Smtp-Source: AGHT+IGDJly7JQmW4Sume9xsYbBZyPdgaRNEsb2bNnzYj/cwNFv78GL6tiOs70TN31XMIWz8NGGDvQ==
X-Received: by 2002:a05:6a21:e8a:b0:1c0:f648:8574 with SMTP id adf61e73a8af0-1c3f123d9e7mr428547637.29.1721084554363;
        Mon, 15 Jul 2024 16:02:34 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ecc9d36sm4915344b3a.205.2024.07.15.16.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 16:02:33 -0700 (PDT)
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
Subject: [bpf-next v3 07/12] selftests/bpf: extract test_loader->expect_msgs as a data structure
Date: Mon, 15 Jul 2024 16:01:56 -0700
Message-ID: <20240715230201.3901423-8-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240715230201.3901423-1-eddyz87@gmail.com>
References: <20240715230201.3901423-1-eddyz87@gmail.com>
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

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/test_loader.c | 81 ++++++++++++-----------
 1 file changed, 41 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 47508cf66e89..3f84903558dd 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -55,11 +55,15 @@ struct expect_msg {
 	regex_t regex;
 };
 
+struct expected_msgs {
+	struct expect_msg *patterns;
+	size_t cnt;
+};
+
 struct test_subspec {
 	char *name;
 	bool expect_failure;
-	struct expect_msg *expect_msgs;
-	size_t expect_msg_cnt;
+	struct expected_msgs expect_msgs;
 	int retval;
 	bool execute;
 };
@@ -96,44 +100,45 @@ void test_loader_fini(struct test_loader *tester)
 	free(tester->log_buf);
 }
 
-static void free_test_spec(struct test_spec *spec)
+static void free_msgs(struct expected_msgs *msgs)
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
+static int push_msg(const char *substr, const char *regex_str, struct expected_msgs *msgs)
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
@@ -443,18 +449,14 @@ static void emit_verifier_log(const char *log_buf, bool force)
 	fprintf(stdout, "VERIFIER LOG:\n=============\n%s=============\n", log_buf);
 }
 
-static void validate_case(struct test_loader *tester,
-			  struct test_subspec *subspec,
-			  struct bpf_object *obj,
-			  struct bpf_program *prog,
-			  int load_err)
+static void validate_msgs(char *log_buf, struct expected_msgs *msgs)
 {
 	regmatch_t reg_match[1];
-	const char *log = tester->log_buf;
+	const char *log = log_buf;
 	int i, j, err;
 
-	for (i = 0; i < subspec->expect_msg_cnt; i++) {
-		struct expect_msg *msg = &subspec->expect_msgs[i];
+	for (i = 0; i < msgs->cnt; i++) {
+		struct expect_msg *msg = &msgs->patterns[i];
 		const char *match = NULL;
 
 		if (msg->substr) {
@@ -471,9 +473,9 @@ static void validate_case(struct test_loader *tester,
 
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
@@ -692,9 +694,8 @@ void run_subtest(struct test_loader *tester,
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


