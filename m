Return-Path: <bpf+bounces-34858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD00B931D71
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 01:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 388D3B221AB
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 23:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A53014036F;
	Mon, 15 Jul 2024 23:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlJdF6Ww"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B23144306
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 23:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721084555; cv=none; b=YKTdrWGPkhNXKsst4PSqehcBm0TP4I4nFkGW9rZSs46OSzRkyKpP+k7AqpVd3PXJLUIGhCmoa2SH1Jo+5xg4/vdwLoX50mKEXDYUM+Q4aKg1xMa74L3ZqDZfTYbq+vFcTgmPnPVxm6Dv5qqTCpnb0G49/x5eRRa4JuouzWmkAGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721084555; c=relaxed/simple;
	bh=Ls5NTw26GGRfzQzeToAl7wGRmkGtN892goc869jj6MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XO0MAPC8AcQjGg+X/pt9PV+kucdoVDzL1pDLzk1AO3RTAyD0xzpnuue1p9kq+Y7CE18HN4lgWNjQ/3xEnKvKceGHyF3+M7Ls6YzEuPsGNbcL8mbWvwVZnhO8rF0UHEaT+GdO8LrYEn3HGXvh8kx6+V3i5Cc5dPa/xPZCQMARS6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlJdF6Ww; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70af22a9c19so3646585b3a.2
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 16:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721084553; x=1721689353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5ICedsF6VbzId1MCj49chfpgGgDYXegk6kOCiPafJU=;
        b=hlJdF6Ww0J1mYgGyMYSYdT/c3bQ48aEtTXc+Sujn7dLL1kMUl5VpGctrZ97JQYw1Dj
         88YdMfyU0gSZg+4qrpo9ub9y9rtCFaOevz/AsNDXs3x3gh1CSaTLMVMbhpCzt/+ewDup
         6VHVx8rvOXp3LCrbwgQAgBcycwRYbPu+Ybt4xZDIaayF4rAoXLPRi9RGKiiHqcNBSjSr
         62XYah14PyZKQ+INMCfe9PsCY4ZwQq6Z+nDi0z/EhMIjoUPUn+M+w8QatxLPw2AqeYUi
         lZ+xg0t6XDZyt9/VFdScgspY4iNXm/9vPeS8mx1S+pnftzWlUgIT8IOOpGG1RIMiey/W
         1LwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721084553; x=1721689353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5ICedsF6VbzId1MCj49chfpgGgDYXegk6kOCiPafJU=;
        b=ko+ovtiiyvCEtQeun5+qvgEfuQ9/bFP/cGkxfgcqpbJulhF4EMP/DFyidoYJQpIKZr
         oLj0ZOjI4xkxi5+9+Lv/DqCX8+5BJBoqc3Yok3Kr85Llz/wFXJ3J3cpAIXvuM8hnwRr3
         BvBzdV94cfND9FVpt+HKMR0mmMtxlfuaO96IpopsI65w84OSMD6AT+Y2SFJAwybsrQRT
         +Wd3/xItBUGR+ERGWF2QFC5/2HbhvqAhkJm8CwlVLHQqGfg9VEbXD6C+h7jgFAyUQjZX
         mllnW6iHZk05whJ8xXC9ILYeDOF2rgXLYTXc9a5skbgQmb2CK1x1OISWUc9BMHFof+hd
         6rSA==
X-Gm-Message-State: AOJu0YyFyZngQ5wjodAigZ2AaMipXWNp5zOLEhxWuYDy8HWDcieDE8r6
	gzd/xuQxhp+xaaYsoOMUdK5VjXbf5GZwv9kN7ZfP7toVrLM+QZZU0eFe/w==
X-Google-Smtp-Source: AGHT+IHAd4gM0kyr6sja+HOI766JiOb4G/G2IyRlk4tCFxI0turuHrER9CaBMEdEwFrNfhsBirtY6Q==
X-Received: by 2002:a05:6a00:2304:b0:706:251d:d98 with SMTP id d2e1a72fcca58-70c1fb673fbmr608586b3a.4.1721084553383;
        Mon, 15 Jul 2024 16:02:33 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ecc9d36sm4915344b3a.205.2024.07.15.16.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 16:02:32 -0700 (PDT)
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
Subject: [bpf-next v3 06/12] selftests/bpf: no need to track next_match_pos in struct test_loader
Date: Mon, 15 Jul 2024 16:01:55 -0700
Message-ID: <20240715230201.3901423-7-eddyz87@gmail.com>
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


