Return-Path: <bpf+bounces-69541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0562DB9A3F5
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 16:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A04818973C2
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 14:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4643074B0;
	Wed, 24 Sep 2025 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BK4ebVvg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C99F3064AA
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724201; cv=none; b=pVVYcH5sU4O+Qw6zAHLZv6eIe/Rhgnh+GMz77iGlHiRI7l3LrEztIvvTxpMBpMK/2YLVGaBXgbFr80n0AwNy8frXqJbHw7mSKZsVaNUYBWBbitCf3opSGas/oBRgSK5k1zdLZO3kc8vlFft8qNdVQO5eQ0HEMehFYAEpF8/A8iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724201; c=relaxed/simple;
	bh=asMwAVvAFJGhz5+YWgVUxWKRQyUyvH8FlGc9nXCtqE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSwyLeeNvLxqA+tV4eXZqyw9gGgaTxGrV5O+5xXO/Cpf/K4Cn0HFWnZYmHoV3KjlDiwHVXfc3gC9fLIFuviEGvK0F6HopsPdVdno/TGoDDsKbngHo+JMcjR7D2rOIYaPi/5LLzUM9usKXXuzlfSd0YdSL8XW91eTd8uHjx/Iu5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BK4ebVvg; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so2630222f8f.1
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 07:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758724198; x=1759328998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgmVro1LxoGVW4/3lqaxLZJiLJJTX/RzQh+o4CCJZB4=;
        b=BK4ebVvg+5kogrBMsAOLZiofgz8tYxiDdtkoBs/pG07Uz4MCUf4X+pyDoA8GnQHsfb
         HqDdmWuHlf8BWx1BDE9kZrKgUQMJgqTfJnKeSeOCI++0auKjLWiPSfu8PNfGUkL42MQa
         ZdqbbQpmWcwMkWXt7cePDSp7AffHxXqZUJuCYw7drdK4CJOATEbvy0OWb0uTLFEPmqdd
         xvetp6ZDJbK21sVPhFPjvT46FbVkt5eb/K/9kSD9Vbr3yQIc3t74Hd7EgmH0G2sVjdds
         RB9/WMpHV1qBO2u4fOdK07dvyHF8nIxVJ/KbwYiO8UCN1kIOhEKpGydCj1ikug+f4oBi
         tgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758724198; x=1759328998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgmVro1LxoGVW4/3lqaxLZJiLJJTX/RzQh+o4CCJZB4=;
        b=RGWcgbltOBULKeFjcpi7GdQJrn1+hBSF7qYuWCLMBkLCFBk2lgYpGnYCsz9OyG5JtQ
         AiijNWQdFqnCbe9P4o7Vo/zd69OX7vLjL1imslZCtPv3qPE1PXQkBWSNl1tbYS2fwB/U
         WEZppmlIp2WaepdFRBWDwCl71qooHvJMUr7REsPQ4EpKKneUYq+zfQapYb2fCBQtX3Fe
         uHpFg1Qfnj/5KdYpv6zJSEFfIqqQqtQyRBLXE3gzDdyxAOqZCBlFs9RobleohYG/BLXj
         HrSwtO/Jj8AMGjcSzgCQXRx2MoqMs7fD/CwPPkl1Nc7rVzx55xsU9hDPv9+ayfbYNqaB
         /T8A==
X-Gm-Message-State: AOJu0YyHoWcTwnmyOzAbPgdhcSB0dKG/unA+eaDpeKv/D1yiHtWz/AFq
	yJd6woxpBvnrs3Psg6C3JffbdX+zXTHW1R4UUts3mVe7iRaJjL3tT1wQuuTeqQ+u
X-Gm-Gg: ASbGncvceEkIYhphaCfwCtg7RDj51/+XkgMS0TSKAiDCs2Fye11srHEW7xMENk7aOn7
	UfDfbTJc2/nZ6MQ2EkpMWIrMDsIC/XibD/G1lcIXpiZ55XfxquChQsqtNx8kVS7RT16lFQgqUWU
	yMkyQhsttf1aKR1O151Lzd7umLR97sXQWGUd3BPDggjP6zRvGIg8xTnlkhhR9ARvU1fG6zM3VGq
	Zdp+8tVbiA8NM2Y/8Mkc4bmrJe0yAj1Wo09SUUkx3A3+em7f+GbNZyCvTKvsIHLRAg5i8QEBwiD
	/UZewUiU9z3Rb2CeGVydJE3feBgq045KIo2LkO/+RkYk4OK1kAjh9ieYif7tLu57iymLu/jFSyO
	zK1/waxV0ZvGibrlaLdJDyQ==
X-Google-Smtp-Source: AGHT+IHOsuPCAVXo5SisA78CogLlbyPrfajOezPlhihz+B5EruC3NT5MQcmzDW7PZ77lEIbW9rZ1jQ==
X-Received: by 2002:a5d:5888:0:b0:3ec:248f:f86a with SMTP id ffacd0b85a97d-40e4bf00efbmr136922f8f.48.1758724197756;
        Wed, 24 Sep 2025 07:29:57 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40e0641fa13sm413157f8f.61.2025.09.24.07.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:29:57 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: task_work selftest cleanup fixes
Date: Wed, 24 Sep 2025 15:29:54 +0100
Message-ID: <20250924142954.129519-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924142954.129519-1-mykyta.yatsenko5@gmail.com>
References: <20250924142954.129519-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

task_work selftest does not properly handle cleanup during failures:
 * destroy bpf_link
 * perf event fd is passed to bpf_link, no need to close it if link was
 created successfully
 * goto cleanup if fork() failed, close pipe.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../selftests/bpf/prog_tests/test_task_work.c | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_work.c b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
index 666585270fbf..08d24c16e359 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_task_work.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
@@ -55,8 +55,8 @@ static void task_work_run(const char *prog_name, const char *map_name)
 	struct task_work *skel;
 	struct bpf_program *prog;
 	struct bpf_map *map;
-	struct bpf_link *link;
-	int err, pe_fd = 0, pid, status, pipefd[2];
+	struct bpf_link *link = NULL;
+	int err, pe_fd = -1, pid, status, pipefd[2];
 	char user_string[] = "hello world";
 
 	if (!ASSERT_NEQ(pipe(pipefd), -1, "pipe"))
@@ -77,7 +77,11 @@ static void task_work_run(const char *prog_name, const char *map_name)
 		(void)num;
 		exit(0);
 	}
-	ASSERT_GT(pid, 0, "fork() failed");
+	if (!ASSERT_GT(pid, 0, "fork() failed")) {
+		close(pipefd[0]);
+		close(pipefd[1]);
+		return;
+	}
 
 	skel = task_work__open();
 	if (!ASSERT_OK_PTR(skel, "task_work__open"))
@@ -109,9 +113,12 @@ static void task_work_run(const char *prog_name, const char *map_name)
 	}
 
 	link = bpf_program__attach_perf_event(prog, pe_fd);
-	if (!ASSERT_OK_PTR(link, "attach_perf_event"))
+	if (!ASSERT_OK_PTR(link, "attach_perf_event")) {
+		link = NULL;
 		goto cleanup;
-
+	}
+	/* perf event fd ownership is passed to bpf_link */
+	pe_fd = -1;
 	close(pipefd[0]);
 	write(pipefd[1], user_string, 1);
 	close(pipefd[1]);
@@ -126,8 +133,10 @@ static void task_work_run(const char *prog_name, const char *map_name)
 cleanup:
 	if (pe_fd >= 0)
 		close(pe_fd);
+	if (link)
+		bpf_link__destroy(link);
 	task_work__destroy(skel);
-	if (pid) {
+	if (pid > 0) {
 		close(pipefd[0]);
 		write(pipefd[1], user_string, 1);
 		close(pipefd[1]);
-- 
2.51.0


