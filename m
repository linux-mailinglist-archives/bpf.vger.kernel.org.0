Return-Path: <bpf+bounces-35284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1C793970D
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39794B217DF
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 23:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F6E6EB46;
	Mon, 22 Jul 2024 23:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtBiJ7Wi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440B16A342
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721691554; cv=none; b=UQDoaHCJB6Y8hwJjdRoXF5sv6HeWuM9pp5TKV2D8CUHFjKM6EWoJ7L9CaYCEYSqG2nd5XkjKixxNtB6QfiVFtEqt6pFsQyy17sctZTNLC6TQSd4A8rG0Gz0owBbmVbKnZvFLdim6u/9yZ4J3FsetdChNPfJCuCTXg3T5D2adFuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721691554; c=relaxed/simple;
	bh=Ls5NTw26GGRfzQzeToAl7wGRmkGtN892goc869jj6MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nzp3y8+gYtlkWS+iD66Sd8r/1CeYtRpw2vhx+nzmMlSpN8W6+EZZi01kI3ZL8wNN5KYxuGwvxcFPPE/OY0wRjzNo0V/AISppkJRVCm30oT7alZCz7bcBfXbvOM6UBFcqELqWMKzd1v2rxJfUreilHp5W6gSuxPBJGtE71MWSND0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtBiJ7Wi; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d2b921cd1so1121216b3a.1
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 16:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721691552; x=1722296352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5ICedsF6VbzId1MCj49chfpgGgDYXegk6kOCiPafJU=;
        b=XtBiJ7Wi55qSfYP5vH4QniE1S3KD8+g9/6MfD0jUfDL9MEggxio+vjQ6iYdjWQKD12
         UroKfkfDDtyc7qF/75XYsdrJ64N7oBqgRpwAaw7cCLISNOFemG1QDi97KryU2/YakuIu
         1dh+cVrwu11ZeuOKCqBpcDV7slAr9eVCQct21U7wbb6fkWwb5xkk6T1RXKuvk29wZ82Z
         KdBQpRg9IVTlva0Ssy9d2XP5KpefO3vF1pWbweHS9QC75Ro6A9+3MBaYfl/H/YcTphlo
         RgL+/WT+WV2dioZQXhHS7VnvxDSahrl0RTfG7bZ9gB2oIWIi441HWH+lRbrtHuGbeP+/
         5woA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721691552; x=1722296352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5ICedsF6VbzId1MCj49chfpgGgDYXegk6kOCiPafJU=;
        b=ZT9BWzxjEqOUkNm3ClxAdfRo/PK17r4xZX268h+RH38sjIyi+Gg32KQQ4l0cLVY97J
         +2L9yK4Y2ix+j5BJ/r7xZgnOUO3y6rVsvCYsrd3czUzwgCS1s0iirF/TuugPFV6ASB73
         JUTc59pIYcx5CRhWH0hBytiAveHUg318LgoML0QVnBcKTPSK40SDhM6AbV+3HaE9/V13
         yQ25R5FbhdZ7WgrdtckBHmr4aHvzzv2ibFXAp7sOlQqet1UXhwG4AhRZWH6Z87Rqb8FY
         pvf8P6k92aOO4+PtL36bybEsm0l60BnePEzz+9HYZF9Qgg/cWtHuXzZDaeHfN9J/OFKc
         b/FQ==
X-Gm-Message-State: AOJu0YyZC2NIF6lbEdQ2MtMZbu8zUgNxIim1D63Tolb4E84ou9L5lolN
	5jFgOekuwgxyoU0N8ZzTg+ZZ33KVSfLOtR+4JnClJWlhJTj+7MWQYHT0aFvZ694=
X-Google-Smtp-Source: AGHT+IFw6I3JcV3v4AtUkoJBm4WilJd2xsIAzz7MFcUQC34hxAOWnO0qacmxTNdeUyfYCAjFnsMzOg==
X-Received: by 2002:a05:6a00:2e12:b0:70d:3241:f990 with SMTP id d2e1a72fcca58-70d3241fc52mr4008460b3a.19.1721691552052;
        Mon, 22 Jul 2024 16:39:12 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d2707fe14sm2479500b3a.163.2024.07.22.16.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 16:39:11 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 06/10] selftests/bpf: no need to track next_match_pos in struct test_loader
Date: Mon, 22 Jul 2024 16:38:40 -0700
Message-ID: <20240722233844.1406874-7-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722233844.1406874-1-eddyz87@gmail.com>
References: <20240722233844.1406874-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The call stack for validate_case() function looks as follows:
- test_loader__run_subtests()
  - process_subtest()
    - run_subtest()
      - prepare_case(), which does 'tester->next_match_pos = 0';
      - validate_case(), which increments tester->next_match_pos.

Hence, each subtest is run with next_match_pos freshly set to zero.
Meaning that there is no need to persist this variable in the
struct test_loader, use local variable instead.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/test_loader.c | 19 ++++++++-----------
 tools/testing/selftests/bpf/test_progs.h  |  1 -
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index f14e10b0de96..47508cf66e89 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -434,7 +434,6 @@ static void prepare_case(struct test_loader *tester,
 	bpf_program__set_flags(prog, prog_flags | spec->prog_flags);
 
 	tester->log_buf[0] = '\0';
-	tester->next_match_pos = 0;
 }
 
 static void emit_verifier_log(const char *log_buf, bool force)
@@ -450,25 +449,23 @@ static void validate_case(struct test_loader *tester,
 			  struct bpf_program *prog,
 			  int load_err)
 {
-	int i, j, err;
-	char *match;
 	regmatch_t reg_match[1];
+	const char *log = tester->log_buf;
+	int i, j, err;
 
 	for (i = 0; i < subspec->expect_msg_cnt; i++) {
 		struct expect_msg *msg = &subspec->expect_msgs[i];
+		const char *match = NULL;
 
 		if (msg->substr) {
-			match = strstr(tester->log_buf + tester->next_match_pos, msg->substr);
+			match = strstr(log, msg->substr);
 			if (match)
-				tester->next_match_pos = match - tester->log_buf + strlen(msg->substr);
+				log += strlen(msg->substr);
 		} else {
-			err = regexec(&msg->regex,
-				      tester->log_buf + tester->next_match_pos, 1, reg_match, 0);
+			err = regexec(&msg->regex, log, 1, reg_match, 0);
 			if (err == 0) {
-				match = tester->log_buf + tester->next_match_pos + reg_match[0].rm_so;
-				tester->next_match_pos += reg_match[0].rm_eo;
-			} else {
-				match = NULL;
+				match = log + reg_match[0].rm_so;
+				log += reg_match[0].rm_eo;
 			}
 		}
 
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 51341d50213b..b1e949fb16cf 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -447,7 +447,6 @@ typedef int (*pre_execution_cb)(struct bpf_object *obj);
 struct test_loader {
 	char *log_buf;
 	size_t log_buf_sz;
-	size_t next_match_pos;
 	pre_execution_cb pre_execution_cb;
 
 	struct bpf_object *obj;
-- 
2.45.2


