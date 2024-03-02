Return-Path: <bpf+bounces-23238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CDF86EE0E
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 03:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77701F22DA5
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 02:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1794A7462;
	Sat,  2 Mar 2024 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AY6LA2xv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37168747F
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709344830; cv=none; b=DNkNd2E95Wt01yu0flF9Q0t81aYyd+L14XQSgaR16wRznvdFelbsiFqUZy35M37xWguZc7RaeoJh2YHbPpiMhOAIQ1kW6E/ElZ9zADZhN3QZW/TZDTawIyE/tPZBQvf+ADny3+mOvUCZWm4A8YHuIjBYu7CoEksANIQdSa629OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709344830; c=relaxed/simple;
	bh=3wDQOmKZsOjVn1y1MGbr3TQ2Q860PAYSuJAMvSBZOY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vi+FZEUgdmqO04MSnmpP7Cqa1/2Y1tUSM7slluwgYgyUy90Ut4j5+SwtJCMcT4BpD99GZTEYa/ui53rpdXrQW7Pj8mSluwrLBNySteGVMjQ+MXLHE5ZTHnII7wgzK4GKInS/YkpChRlEwCI3D77QlNaheto55mp9FjxupQ84zwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AY6LA2xv; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1db6e0996ceso22757975ad.2
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 18:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709344828; x=1709949628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjnjQW9WPZyMITbBPyAJxM4HpfdS/LiKPWFWetwj7v8=;
        b=AY6LA2xvbD45glqqr7GarkH3T1CXlPoejChZUmYo1FTFosqrDeP4OxP8HftS4GNN3H
         bgYfVRVIvRRLLGhggkNbYCwmiJJT7p4LJ9+f/7JPo2tkD8UptoSDmHSSozcAC5wQAacd
         AkVDcqPW/NJN90c5CnaxUjK6YFtDSqPXLvxH/Kcj+M5TRrWUQFZMgSrwZvWQbJFD5EDt
         EwZ/+5D8r/kkeO/VzGdt8C6XIN7MumO0S5Fwm4ztz1aClBstNhBSzUvRt7+LkV/KdC7z
         G+hBkwVt/okrXtljeHUi6S7qLgfi2YX41E9OJ9pvW1AQpJuZETZfWt3an+0JxHmA9gB5
         pnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709344828; x=1709949628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjnjQW9WPZyMITbBPyAJxM4HpfdS/LiKPWFWetwj7v8=;
        b=wvw2Bj87YMTIDf11DvIvstzya391a9aGS2MicaqlhjJb9jbK5XLZ5MrdHPwkwuJDCU
         9WlUDXBJZcZS8+/SlwK9y/YiDePn4WER6mJHrKdR2B8AlGmvj0yd1wlkURAc6B2NT9p5
         d1UIUTDKRIQoRzX+GCljpzgXNwKWQmjH6DKnXdE9HYWCVSxdMfbDuzyM44wzfz6vUmQz
         B1dP/A7mO+vTBfyft2148x6H1CWp3SkeZ11M6rdtzcGufQTuY5+T5aPq3nL/gndbjwEw
         Zrj6piQAsB40J//xQvFOvwWWUScIKCUXeSizHQhAH5f8Aqa9cr0otfoxYZhHcjaEyIPY
         Lu1Q==
X-Gm-Message-State: AOJu0Yyp9tNzd+BadpbJ13H4B2S96Ihot3fTMmagZ6YeC63DqLQ8xCmh
	LSEmCyDyjIGYzvfK6/LTxj0eITeMKiUv7RC6qxlp79S/Ug1kUG0CSKpVlYmY
X-Google-Smtp-Source: AGHT+IG3UN5WW61nyOOB5zYdFPn42Uk7VdoHJG1H3YMueXQdy5P8EgjfdroqS6L736kND+atXMA3Rw==
X-Received: by 2002:a17:903:18e:b0:1db:3618:fed5 with SMTP id z14-20020a170903018e00b001db3618fed5mr3682070plg.53.1709344827841;
        Fri, 01 Mar 2024 18:00:27 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:8f17])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902e89100b001dcfc68e7desm70433plg.75.2024.03.01.18.00.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 01 Mar 2024 18:00:27 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v4 bpf-next 4/4] selftests/bpf: Test may_goto
Date: Fri,  1 Mar 2024 18:00:10 -0800
Message-Id: <20240302020010.95393-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240302020010.95393-1-alexei.starovoitov@gmail.com>
References: <20240302020010.95393-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add tests for may_goto instruction via cond_break macro.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../bpf/progs/verifier_iterating_callbacks.c  | 103 +++++++++++++++++-
 2 files changed, 101 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index 1a63996c0304..9f579fc3fd55 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -3,3 +3,4 @@
 exceptions				 # JIT does not support calling kfunc bpf_throw				       (exceptions)
 get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
 stacktrace_build_id                      # compare_map_keys stackid_hmap vs. stackmap err -2 errno 2                   (?)
+verifier_iterating_callbacks/cond_break
diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index 5905e036e0ea..04cdbce4652f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#include <linux/bpf.h>
-#include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
+#include "bpf_experimental.h"
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
@@ -239,4 +237,103 @@ int bpf_loop_iter_limit_nested(void *unused)
 	return 1000 * a + b + c;
 }
 
+#define ARR_SZ 1000000
+int zero;
+char arr[ARR_SZ];
+
+SEC("socket")
+__success __retval(0xd495cdc0)
+int cond_break1(const void *ctx)
+{
+	unsigned long i;
+	unsigned int sum = 0;
+
+	for (i = zero; i < ARR_SZ; cond_break, i++)
+		sum += i;
+	for (i = zero; i < ARR_SZ; i++) {
+		barrier_var(i);
+		sum += i + arr[i];
+		cond_break;
+	}
+
+	return sum;
+}
+
+SEC("socket")
+__success __retval(999000000)
+int cond_break2(const void *ctx)
+{
+	int i, j;
+	int sum = 0;
+
+	for (i = zero; i < 1000; cond_break, i++)
+		for (j = zero; j < 1000; j++) {
+			sum += i + j;
+			cond_break;
+		}
+
+	return sum;
+}
+
+static __noinline int loop(void)
+{
+	int i, sum = 0;
+
+	for (i = zero; i <= 1000000; i++, cond_break)
+		sum += i;
+
+	return sum;
+}
+
+SEC("socket")
+__success __retval(0x6a5a2920)
+int cond_break3(const void *ctx)
+{
+	return loop();
+}
+
+SEC("socket")
+__success __retval(1)
+int cond_break4(const void *ctx)
+{
+	int cnt = zero;
+
+	for (;;) {
+		/* should eventually break out of the loop */
+		cond_break;
+		cnt++;
+	}
+	/* if we looped a bit, it's a success */
+	return cnt > 1 ? 1 : 0;
+}
+
+static __noinline int static_subprog(void)
+{
+	int cnt = zero;
+
+	for (;;) {
+		cond_break;
+		cnt++;
+	}
+
+	return cnt;
+}
+
+SEC("socket")
+__success __retval(1)
+int cond_break5(const void *ctx)
+{
+	int cnt1 = zero, cnt2;
+
+	for (;;) {
+		cond_break;
+		cnt1++;
+	}
+
+	cnt2 = static_subprog();
+
+	/* main and subprog have to loop a bit */
+	return cnt1 > 1 && cnt2 > 1 ? 1 : 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.34.1


