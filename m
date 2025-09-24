Return-Path: <bpf+bounces-69537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3DBB99B1E
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 13:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8194C1899611
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 11:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E702FF673;
	Wed, 24 Sep 2025 11:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kpe8gqlS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554352FDC43
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 11:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715066; cv=none; b=kC03pdYaP84ZaE+o34PvBWvjNl24GmFJamCg51jC4/KC/nlfloEJ6fdrzptlGJvmv2lnXhREwPag8Fi8KRAgC8vwTzKQPb5XF9ITNcHq/fiW2Vn2FNGy3z4rhIzokU4fD2JC9bqJNKHIMLMtIxESM5qTF/mmG+uM+ZBdEhDFmOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715066; c=relaxed/simple;
	bh=NV/1Io78cR8ISlWReEPLV5BhxNNFQQi9eOMFvQvLcaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J52ntj1lUyul2sS6iRAk6i1bWnUSzRTMicgXOlhni9VDD4no10U0TBVBk2XMHIYAJwxQbqEX7jmI0MFjxIUcCp0Qcrjx+q/lNrA7+KIqv0RmU2gtnmF/kOi321wUsyTeRaB8oZBfeorLxBc5aBsaGtHotCMd31ZGwzETi5OGFkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kpe8gqlS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso3325319f8f.3
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 04:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758715063; x=1759319863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGAbO+Daijvx6QO5klPVFv7MX5wNSN1KP/uZIZW2Svg=;
        b=Kpe8gqlSx67nhWuP6gpjnicYWVMSvM2WA7FNIFIxE4DB45nXvCDjcuLbfoOMXdvNTt
         I3lHLTYqXQ2lLb8zFEKJE87RV+0AUeDru8MWsUzyJqwC+yEH+rwoLabFua5LsSUlrL6+
         NzXk4GWaJEWGwc3zvvLOqK+pDJ1t+Uw2pEyICS+Z0UwQ1ru5nGFoU9WhuXk9IUJzKkw1
         D6RYH/t0UgbGY+jd062BKye9FGBf7UGn9csm670ge0rCu5XNFQmfZsqGj1i1LhBYaGw9
         U32K7XP70cW5ChRA8/ajEizid9fnpNsK0WSpBFAOsd3+4BIjbzb82/f2Uc/aKti6agvC
         IFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758715063; x=1759319863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGAbO+Daijvx6QO5klPVFv7MX5wNSN1KP/uZIZW2Svg=;
        b=iFaexuRo1tlUTbCcC9Diab8mpkn68/KM1L1LfUYcemvEt4z2P3jVf+OKLDt+RNMePd
         fJsulA9Oks9gMeOYTjVwoRdO6omiXdaysWjQE2SyAcu6H4RcMX8xUDyMjEL73yYOGTbI
         jE+VeLkXtvZRcB+A9gfJURoMAn3dnEi1iD5mhMbF6lHHP+y4hNBywOw6k8acriP2WSTK
         vetCeD82gZ69ZdWsozLNujQ3vjCSU3SkVhy+nBZY0yVlOprbtnjrorhrjxeoN4/lYue2
         JpAtvjO7vfe1Wve2pc0uShBowLNBo/dq3l9w4wkGPCTmRiOOWzhdt/ndjo5dgKmlpyh1
         GrnA==
X-Gm-Message-State: AOJu0YyL8SGhS9gr4GymPdRbE3muQoQyIGQquOxdtGkAa9DJ5FihR3pP
	EiDXBJm7FpuZJ8djXmUksZBS/crR4GmHn4Qgr3jDI0dNB7dH1KvfjzCIGwlI/gws
X-Gm-Gg: ASbGncvLnnWRMOSM4Yl/aqp56iDyMJldPl1OdcGpnKqNsk4gcT1Th60HXVA1d3L1go5
	Doj30F1SPh0Zr7DW2TZNdIgvytrkla96uKKymYOhMFD5WhJ2rj2aDxThQkV0AWGx2XgejNRmpob
	bhf6w7PMgZN8QWDus6OKKEsJcGNNQnoe/QBQY6f65Wx/8CMbpN9PFcgvecwtlKeBmoY4aDv1OjD
	yhAafE5kIWQ4ilqUzutprjXPi6UKHy2bk4n3ND+aT/fXYeBsgtA7jlUdUrbooNxc0a9Agjnadz0
	C7I3Im8UAWKpZRLQXCZXLm6XywovQDHeO0K/36xj/kWrd3SkKA9/MwwchEerqqZkLgYcxbZA9xN
	mq7WkchF4AjcFEIF+7STJ9Q==
X-Google-Smtp-Source: AGHT+IG+q5qOsDVuQ2+zSrUdlvp23unVbL74MWzpgDzxZQnRfTGcZ9CB4CfURY6MmrlNodJGzZV/YA==
X-Received: by 2002:a5d:584b:0:b0:3ec:b384:322b with SMTP id ffacd0b85a97d-405ca95bebfmr5708409f8f.46.1758715062562;
        Wed, 24 Sep 2025 04:57:42 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407aebsm28958916f8f.14.2025.09.24.04.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:57:42 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: task_work selftest cleanup fixes
Date: Wed, 24 Sep 2025 12:57:00 +0100
Message-ID: <20250924115700.42457-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924115700.42457-1-mykyta.yatsenko5@gmail.com>
References: <20250924115700.42457-1-mykyta.yatsenko5@gmail.com>
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
index 666585270fbf..65c4efd05e9e 100644
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
+		goto cleanup;
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


