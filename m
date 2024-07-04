Return-Path: <bpf+bounces-33880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3E19273F4
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 12:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC50B1C2106E
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 10:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1591ABC30;
	Thu,  4 Jul 2024 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCtX56oY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD461ABC25
	for <bpf@vger.kernel.org>; Thu,  4 Jul 2024 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088668; cv=none; b=Ruhi/Z8P2md6MT8bOQUXGet78JD3+KfXlR+tIXRUDPTtfFWJQijAAu+b3PFG6ise1HKepmSE3a3bktOKHK2CuuH0eT3T2ZL/DXLIRRj8WbXJveurX1DFcVWLaEOgDmpgDSMNM+pjSWQwx2wTBm6XmpbhnOL3yeu6fb3+2/y16ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088668; c=relaxed/simple;
	bh=3VHWvWIRoYm0OHxNSWyRtzLOCPr1yVWGX3xvOTYUc4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKkTiVQD35jj4RXYv2PuLKkhcQPHSklkiKeS04I+gmVBnIjYPdOHKJrBA66zJZdm1Mnw3yaOZvGk/rsgXgduY787Ky965+NeuepAbhjiyPLWrane5FFJpexOukVtmNHVVFQdsjLDjpOchNksoTAQy7dRH7JAJvj273oCBOQANro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCtX56oY; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c9a1ea8cc3so188023a91.0
        for <bpf@vger.kernel.org>; Thu, 04 Jul 2024 03:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720088665; x=1720693465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3Bs+tT/4cSTOV0X1Cvoo1p89KZrjCaeAGPrKtOb4Fc=;
        b=HCtX56oYHP6GRExTMp2JkulrQ7tGrHjvWBJFOr3vHdvXdsz7ca3UUmPqiSDflOHrIL
         b3XYmvrbGPyu1g+jWAR9IgdDr03RcqHCtQzlfnUtwNaDloGxmFvQQEPTymlArbt7R+y2
         zuyLB0V2IEXYZ2WoPg87+MbMZ92yYUi36XmCTF77iKtk11iEOuBPIM2X87emBoJCaPjz
         ferr6/cIeW5UL8YNeWszF9HZY1BwfBrkci/AvTqPR2BHuOO4s1lgSNb/l7nuJmkXuiyf
         aDGq6enTsK10dIdDX1Si34bjbaXZpldQptEjiuoiJ0GhQjJqw6LCic3TRSt/qXFm1Aw0
         h19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720088665; x=1720693465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3Bs+tT/4cSTOV0X1Cvoo1p89KZrjCaeAGPrKtOb4Fc=;
        b=OuyOMitSsXvbMRx6hbBHn1ELXHTu1rC419SkMNPvMLQryQm4tWdUdECC4MC79i6TGV
         45czuh5Gtbtw9iPnPdjDxEThrOXF7+vzDna9ErEXQ/7l9se3NYi0Bq+QBtn/o2lf/J7y
         M37gkxt8DsLm8hCFQHWeOzAIK7N/pQI2oU9Xl6ZDCe8CvwBYxcWf6aLLsbL4nHQTNPXc
         P7CeA+i59eopc1KuAzTra7OqjVwijzz9FO6q9A78X5B76n4B65c92Ke57+gKV2eR2q6Y
         WpgU5hLVH3NwcZ1eQv1yAfSNhnWR6VviMFcSeuyIXlzQxaBJvrmbbVJrH4TtOR7bzIwU
         hfjg==
X-Gm-Message-State: AOJu0Yzcte7gahputGDh70Dy6ujeeOqdGhgQLW12a9XYOACjMi00gFfz
	n8aIOMmcItnX288pG5zNT79Vub/lZwzw5jUOo95HHTF2SoI8fLi7wQWPzA==
X-Google-Smtp-Source: AGHT+IFlL78F9EbBDZp9k1zRzHEukCzWVLGqxb4vZspE6hzfZ1IvFeM2YHoeJCDY+hJjzFvQFSA7rQ==
X-Received: by 2002:a17:90a:d314:b0:2c9:6a0e:6e66 with SMTP id 98e67ed59e1d1-2c99f2fd0e9mr1493766a91.5.1720088665057;
        Thu, 04 Jul 2024 03:24:25 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c9a4c0fe8dsm216693a91.0.2024.07.04.03.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 03:24:24 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next v2 5/9] selftests/bpf: no need to track next_match_pos in struct test_loader
Date: Thu,  4 Jul 2024 03:23:57 -0700
Message-ID: <20240704102402.1644916-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704102402.1644916-1-eddyz87@gmail.com>
References: <20240704102402.1644916-1-eddyz87@gmail.com>
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
index 0ba5a20b19ba..8e997de596db 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -438,7 +438,6 @@ typedef int (*pre_execution_cb)(struct bpf_object *obj);
 struct test_loader {
 	char *log_buf;
 	size_t log_buf_sz;
-	size_t next_match_pos;
 	pre_execution_cb pre_execution_cb;
 
 	struct bpf_object *obj;
-- 
2.45.2


