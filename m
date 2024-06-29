Return-Path: <bpf+bounces-33420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 492F191CBF2
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 11:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D971F22486
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 09:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66C04086A;
	Sat, 29 Jun 2024 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eebtCxGk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF50D3F8C7
	for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719654493; cv=none; b=pD+lHziA31bQsHVEL3lBtdGaEW94vQxM4XYzfwHQAYWFirTqpF5eH0kZEXJ+FUA35SPaT4vEAUm9BP5sM2Z6ERyjuVQaknm0TWeiVv7NNtkVRIaeTdhatPQuVjWn3WE73UrHE/6TFcS1GnG9NY+w/XWRQ6VSbjSXHNweO1HIXuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719654493; c=relaxed/simple;
	bh=Q2Hf+dtKFKxCHAoFjupuQq6hLoNi/M+gDEEPRFrP3U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dulR5/eo1JbgRlzxmQcXEahdUYdml3ZTNof/WR/ldkZQbxfFI6Xel/8JPU5ahBOky/Ikj/8TvDefojROhE2w2nPKCx7HiMZNy15baIVvQYGzGSG8X2pTHgGgqX8Zj14xf3SojhAFNko7hnt9X8o3XCYiIllNNpLzrLvzFttKm94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eebtCxGk; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-25982aa59efso683663fac.3
        for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 02:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719654491; x=1720259291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzJ32pOW9CYn6Orr21OKsQ8Oe31NgrzxMqAqSZGNdng=;
        b=eebtCxGkd6aLNN+yuX7zVjD+50QcOep6cq43SqlTYadDmCaoizZ9VFV2LmE2VktZJN
         4zvRKwS6oGmtYwbykszLrv7Rli6sw0tlB66wV9NSFGxhIQS3ncU09k4b6s81Z2JGMW/v
         0YmibnUe0FoBtLzOFvUtMoq2q64C1UOQJyZvV4PK1qIdkeP5cD91AGYGcYqXU/NhAfCw
         vLDOP6/ZK4Khav/uueqPB5dhpNsMsVraks3oliN+GlZuzHaZy9K+9mUgRECLUByXjsju
         soU3aM4li5nJyuZeeJik+0/m3z7VGaXWNVmBvhQMNR6rQ2PEz7X7VOkKXvSOeTB/ZyCr
         CMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719654491; x=1720259291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzJ32pOW9CYn6Orr21OKsQ8Oe31NgrzxMqAqSZGNdng=;
        b=l32J5qETrHXBfaGfZaZ99sBG6+z3wIz+QY5kYWVgTqOiSVM7p8qVcU+R9Pr4DT+AK4
         XBQnj6tFKzcgQkN8eGxdce7/uoMcxzxcPBncjCbWYcntDHR/nRuRICyIzkgkeP7bzYzl
         NfDZhYYKBK4PoZ9Bk5370Tnu4kcQmlVtCgFn30jcgmqGfssYEPpBF8/jW2Md6lStPJmU
         /6FqP3P6oNbuHWQfQtVAYVwXbhxzaLDn7ZlOGcaiLm3Ra7wDyj2UHs2IijcaHlkvc5H7
         giTr4Ax7xyslN35H5gjcV8XPSq7YcTxN6WFKCBZJkkO9HC/UYOsg5UHicnOgHCvYEr0d
         2Shw==
X-Gm-Message-State: AOJu0YzHlTaQeLHmz2WmksGGrQz+C2kQS3PX5OENSO2FwzyetKBJvepP
	ITrSLD9B3pXO1cOdmR4eknMoYveZj3vyxwkGwdJKGm9Mve4kiqP0kvyIkg==
X-Google-Smtp-Source: AGHT+IEUCCgJ1lulHD7x2QV4JXvmWvg35n2hUbqHnkw4A1x/acftH8pPSJo6LALXDP9nvxHK/BnQZw==
X-Received: by 2002:a05:6870:b685:b0:23d:225a:9443 with SMTP id 586e51a60fabf-25db3592066mr476237fac.41.1719654490698;
        Sat, 29 Jun 2024 02:48:10 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804989f5asm2948932b3a.195.2024.06.29.02.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 02:48:10 -0700 (PDT)
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
Subject: [RFC bpf-next v1 5/8] selftests/bpf: no need to track next_match_pos in struct test_loader
Date: Sat, 29 Jun 2024 02:47:30 -0700
Message-ID: <20240629094733.3863850-6-eddyz87@gmail.com>
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

The call stack for validate_case() function looks as follows:
- test_loader__run_subtests()
  - process_subtest()
    - run_subtest()
      - prepare_case(), which does 'tester->next_match_pos = 0';
      - validate_case(), which increments tester->next_match_pos.

Hence, each subtest is run with next_match_pos freshly set to zero.
Meaning that there is no need to persist this variable in the
struct test_loader, use local variable instead.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/test_loader.c | 17 ++++++++---------
 tools/testing/selftests/bpf/test_progs.h  |  1 -
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index f14e10b0de96..ac9d3e81abdb 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -434,7 +434,6 @@ static void prepare_case(struct test_loader *tester,
 	bpf_program__set_flags(prog, prog_flags | spec->prog_flags);
 
 	tester->log_buf[0] = '\0';
-	tester->next_match_pos = 0;
 }
 
 static void emit_verifier_log(const char *log_buf, bool force)
@@ -450,23 +449,23 @@ static void validate_case(struct test_loader *tester,
 			  struct bpf_program *prog,
 			  int load_err)
 {
-	int i, j, err;
-	char *match;
 	regmatch_t reg_match[1];
+	const char *match;
+	const char *log = tester->log_buf;
+	int i, j, err;
 
 	for (i = 0; i < subspec->expect_msg_cnt; i++) {
 		struct expect_msg *msg = &subspec->expect_msgs[i];
 
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
+				match = log + reg_match[0].rm_so;
+				log += reg_match[0].rm_eo;
 			} else {
 				match = NULL;
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


