Return-Path: <bpf+bounces-33064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75464916B20
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 16:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CCE1287D93
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 14:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CB816F0CD;
	Tue, 25 Jun 2024 14:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T493i61k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37BD16EC10
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327246; cv=none; b=QKMK2MkEHNeA28Mg2WoH2onE3HeElPrWX6aIQ2m/iQqfNpPp3iMu9Kl3lmKIWsHijgklEf3ZnSHyKNgGs/I6U8TfbFuH43PfLsQyqeLC4HXN6OF1jlFgZNPz5HvLpb5a2gJUoKFs0/Gr85i6hrK3zIMy87M+m5gaoZQgrtph2xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327246; c=relaxed/simple;
	bh=BkM4i+Y7W+eaQOSMUQVUA6XGklgk2Sgyuvntv82ttMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ik9La8a+ktLITMnQD29RWnnwvWRd4YRz6WntYVr9VBsCfhLeQe6Sa48wEflLkZqMd3+uF5QkRd+hWnvqQzdBQLMV49aTCxPxdECVT46RJbTu2WsllsKgM93JfVsKCqoe8Mze1UBmPmO1dd1AzcAqTzx89RConm3PwaEq8tro/MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T493i61k; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7eee734a668so250063239f.3
        for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 07:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719327243; x=1719932043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0qUKottmCyM1Qr97p5RCYJEo7ueqGiuDKy+ZD1dWtdU=;
        b=T493i61k9v0OPvM0QbuZhhEeebo5ECw7cnySZsOIUzE4PAwoo4ydwOYc/HSeJD/Tpk
         XA8wSwBO/t6N6VRyJChj99HyMlPZUqNxYTnh2Ub0ZajenbAH6zuDWZ3QSqOn8TfqZ728
         kxj6UUzOwyakzUSv2qo3Eel0hcQmGgFvtyM7ICA0QfgMGWl4gEYVvqH+9CqyJoLvbOJb
         T3Qv2WnJWXqpZ4n9ZQvdeKQpaDc70U2ym8Mept3IB6nu8rnIR51Qc9iMH4yB9vGa2zSl
         au+v15BzYJYWsO1lwARbaNFyqiLAAnCtmkMVS/gkuURNu+MIiQh8TEt3g5PcW2xvNzuq
         DmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719327243; x=1719932043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qUKottmCyM1Qr97p5RCYJEo7ueqGiuDKy+ZD1dWtdU=;
        b=muBZ4FyEtDqPuDfzlsUlYBJdhQLVacrjqrnPlGLiFMiOeZ6I4gKihqTeoe/5mPlPXd
         Q49Rchzjkbkgl+rAkxzSOomzVgsFexg0GVjTRQlWJ3UyE7jJSIavXewbCxqserQFG815
         uNglEYK+s5hZAGtEffv4nKJCP0DH7jch+yQUzJ81ZgKZAPkW3fcBdadERGLtA8bGzFh+
         9mDERS3HwojlxBa4bdefRXFGeiP2/rIz6P6S2MTHYd8ewtzhm171+LiiyOrLDQc9yjUY
         cFPcZ3MVvLXf+CrjJ/w6h5xn4YfYntlXs2LUc/1GAOuD9NYWwb+MH2lZ32n2e/OawecV
         /Z7w==
X-Gm-Message-State: AOJu0YxY0zFqwiorEl+d6kEX1aQD82uK9tkUWg0OZIqTo0sPKMVKRyNp
	WINUCriiSm10+W0l50GaDrp4TXIHFzc4nZU69w1nV+HwEpTDJrnQxFnVVg==
X-Google-Smtp-Source: AGHT+IGq1MGyRhBpUrxZlzSPO+TWR49Zs17qpX362xKkW7Q+Mhv5A1hzpfyfaQpos9ZdZaA7gSLc3Q==
X-Received: by 2002:a05:6602:168a:b0:7eb:9864:410b with SMTP id ca18e2360f4ac-7f3a13db092mr899614039f.5.1719327243469;
        Tue, 25 Jun 2024 07:54:03 -0700 (PDT)
Received: from localhost.localdomain (bb219-74-23-111.singnet.com.sg. [219.74.23.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065124dbacsm8177665b3a.124.2024.06.25.07.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:54:02 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	hffilwlqm@gmail.com,
	oliver.sang@intel.com,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next] bpf: Fix tailcall cases in test_bpf
Date: Tue, 25 Jun 2024 22:53:51 +0800
Message-ID: <20240625145351.40072-1-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since f663a03c8e35 ("bpf, x64: Remove tail call detection"),
tail_call_reachable won't be detected in x86 JIT. And, tail_call_reachable
is provided by verifier.

Therefore, in test_bpf, the tail_call_reachable must be provided in test
cases before running.

Fix and test:

[  174.828662] test_bpf: #0 Tail call leaf jited:1 170 PASS
[  174.829574] test_bpf: #1 Tail call 2 jited:1 244 PASS
[  174.830363] test_bpf: #2 Tail call 3 jited:1 296 PASS
[  174.830924] test_bpf: #3 Tail call 4 jited:1 719 PASS
[  174.831863] test_bpf: #4 Tail call load/store leaf jited:1 197 PASS
[  174.832240] test_bpf: #5 Tail call load/store jited:1 326 PASS
[  174.832240] test_bpf: #6 Tail call error path, max count reached jited:1 2214 PASS
[  174.835713] test_bpf: #7 Tail call count preserved across function calls jited:1 609751 PASS
[  175.446098] test_bpf: #8 Tail call error path, NULL target jited:1 472 PASS
[  175.447597] test_bpf: #9 Tail call error path, index out of range jited:1 206 PASS
[  175.448833] test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202406251415.c51865bc-oliver.sang@intel.com
Fixes: f663a03c8e35 ("bpf, x64: Remove tail call detection")
Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 lib/test_bpf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index ce5716c3999a4..b7acc29bcc3be 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -15198,6 +15198,7 @@ struct tail_call_test {
 	int flags;
 	int result;
 	int stack_depth;
+	bool has_tail_call;
 };
 
 /* Flags that can be passed to tail call test cases */
@@ -15273,6 +15274,7 @@ static struct tail_call_test tail_call_tests[] = {
 			BPF_EXIT_INSN(),
 		},
 		.result = 3,
+		.has_tail_call = true,
 	},
 	{
 		"Tail call 3",
@@ -15283,6 +15285,7 @@ static struct tail_call_test tail_call_tests[] = {
 			BPF_EXIT_INSN(),
 		},
 		.result = 6,
+		.has_tail_call = true,
 	},
 	{
 		"Tail call 4",
@@ -15293,6 +15296,7 @@ static struct tail_call_test tail_call_tests[] = {
 			BPF_EXIT_INSN(),
 		},
 		.result = 10,
+		.has_tail_call = true,
 	},
 	{
 		"Tail call load/store leaf",
@@ -15323,6 +15327,7 @@ static struct tail_call_test tail_call_tests[] = {
 		},
 		.result = 0,
 		.stack_depth = 16,
+		.has_tail_call = true,
 	},
 	{
 		"Tail call error path, max count reached",
@@ -15335,6 +15340,7 @@ static struct tail_call_test tail_call_tests[] = {
 		},
 		.flags = FLAG_NEED_STATE | FLAG_RESULT_IN_STATE,
 		.result = (MAX_TAIL_CALL_CNT + 1) * MAX_TESTRUNS,
+		.has_tail_call = true,
 	},
 	{
 		"Tail call count preserved across function calls",
@@ -15357,6 +15363,7 @@ static struct tail_call_test tail_call_tests[] = {
 		.stack_depth = 8,
 		.flags = FLAG_NEED_STATE | FLAG_RESULT_IN_STATE,
 		.result = (MAX_TAIL_CALL_CNT + 1) * MAX_TESTRUNS,
+		.has_tail_call = true,
 	},
 	{
 		"Tail call error path, NULL target",
@@ -15369,6 +15376,7 @@ static struct tail_call_test tail_call_tests[] = {
 		},
 		.flags = FLAG_NEED_STATE | FLAG_RESULT_IN_STATE,
 		.result = MAX_TESTRUNS,
+		.has_tail_call = true,
 	},
 	{
 		"Tail call error path, index out of range",
@@ -15381,6 +15389,7 @@ static struct tail_call_test tail_call_tests[] = {
 		},
 		.flags = FLAG_NEED_STATE | FLAG_RESULT_IN_STATE,
 		.result = MAX_TESTRUNS,
+		.has_tail_call = true,
 	},
 };
 
@@ -15430,6 +15439,7 @@ static __init int prepare_tail_call_tests(struct bpf_array **pprogs)
 		fp->len = len;
 		fp->type = BPF_PROG_TYPE_SOCKET_FILTER;
 		fp->aux->stack_depth = test->stack_depth;
+		fp->aux->tail_call_reachable = test->has_tail_call;
 		memcpy(fp->insnsi, test->insns, len * sizeof(struct bpf_insn));
 
 		/* Relocate runtime tail call offsets and addresses */
-- 
2.44.0


