Return-Path: <bpf+bounces-43843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE449BA778
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 19:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40C52816F8
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 18:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2116618991E;
	Sun,  3 Nov 2024 18:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4H9/N2R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B07184101
	for <bpf@vger.kernel.org>; Sun,  3 Nov 2024 18:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730659313; cv=none; b=BC4GYDL69pv26Hzg5pEj78wVcgLGlijzE0e2qFTRuRXv+MQdaavbUfIuW+UuFiqtdEleKdEJWiLDp+Rub7vc9QQaAdWBagWEInk+f3Xl8nXmAbY8MfU+K1pScYAjscb6nUGn4sS13eml0aPi86W89Vu5mshqcfgaqFmZr6iHw4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730659313; c=relaxed/simple;
	bh=cJD5lQv/C40yH3qyhnwd2y4VyKoC0fCbuuS58/mB8Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUu+1kjwyykvhpNcciYcFccWInYU7bITuq+Qk6dlHRJIEwt68JzYKAQAkBXAuoX7aRzMaFqIvGpr+rGJ55sIRNn27xed3HJQQwj+QF6DP/AnIV27Vn1dwek2FY1RMAREVfZNtdY+U40H6BziEdtGUs4qlSKzTfvalBlSa2SaKsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4H9/N2R; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso43754395e9.0
        for <bpf@vger.kernel.org>; Sun, 03 Nov 2024 10:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730659310; x=1731264110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrM6Yzo+q0bhwYl/f4hp3laGtst3AW6yLkyJIjUIpso=;
        b=a4H9/N2RPgUjsFGYVvgoJ5NZOk7iW965zLEuB0JEhEHAB36Yn04ApicAn3ymo9lmVp
         26AlW9QEF+HxqAdR1b4tyM0u6OJ6wDC3x8GUMEImSOlogYbHUZkaI/KhSB/2BBkQ7m8k
         C5Gdmh7j3GZquU3DJ1yisPHLl15vtaUxa2aVN6wGZh2WRiEJRNLk1TDTYzz/D94IZE2b
         2x/njy2xFvqOthsvfafzk9PaZ3IoDoOQPtVO8CLjLztiGENHY2VUR1+n3TW57tbYSoXQ
         iu8V+tAVWoOukl+ZHXpmf5lKU3U4fJ4lokO9QGCCbqMJefr9vK5TsVx/40B7Zv8Pi5Ac
         1J3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730659310; x=1731264110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrM6Yzo+q0bhwYl/f4hp3laGtst3AW6yLkyJIjUIpso=;
        b=qrWJDHbOQnfySI1KRdZeQQFwPXnY+08c+2CfQR2lkKGdKRuziqqTgelPXQtp1FhWJH
         HH9zVCUNV2ydrlp0a1hUyT4keti0mEjyJzcXySz0e1Jihi9Xe1SL357znxYWgGJsMfLt
         AUq1Io6T4le6/SW03/iRpqbn+5z6XwvF2eaUi2cPADDRRjJuvXAKhArTdwhWje3cl1cv
         +c0cMvhrx55OkNtAV5C+Yxc/Vzl0f6ikW4srEEE4umRZHBfPxqEOygBPeeV180ID11cy
         lPuA6pt368sN5TNB93iYs+nECoKb68kS6g2P/hfA2Acwyx+rpN9ewBg7WuRe5iw2WWx+
         BnIw==
X-Gm-Message-State: AOJu0YzqjY5jSuowoaasWTwZyUIA9wSfnD58n6EJL0qA1tCCXNjoZ1zP
	OXZq/+sAeDO4He+UD+yBJSNjtvDccm8TnHfTPvoRi11I3Bd8ujR0nWi/LNSQq0Ia2A==
X-Google-Smtp-Source: AGHT+IHPFIWNQZeryMmu7LKFd8K5Y9U7F2w7PdY4QYX+ANzpclmzev0Xs4o9FRlZxy0xOs8LjgMS9A==
X-Received: by 2002:a7b:c5cc:0:b0:431:5c7b:e939 with SMTP id 5b1f17b1804b1-43283255a38mr113071495e9.18.1730659309768;
        Sun, 03 Nov 2024 10:41:49 -0800 (PST)
Received: from localhost (fwdproxy-cln-037.fbsv.net. [2a03:2880:31ff:25::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6984f0sm133016135e9.46.2024.11.03.10.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 10:41:49 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jiri Olsa <olsajiri@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Add tests for raw_tp null handling
Date: Sun,  3 Nov 2024 10:41:44 -0800
Message-ID: <20241103184144.3765700-4-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241103184144.3765700-1-memxor@gmail.com>
References: <20241103184144.3765700-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4117; h=from:subject; bh=cJD5lQv/C40yH3qyhnwd2y4VyKoC0fCbuuS58/mB8Ks=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnJ8PPD2LNkpe8o72xbM1WOjZc/MsPNEQvCHlP78nW sOcS4j2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZyfDzwAKCRBM4MiGSL8RyrMREA C+Bbq/vXUWPqJDxLvSXQl+YqB82H1xQzuSf1QkLX5azPGM9hvje2mSjxkO1QKWCyxCS3rrZnbE7Ihm pLSwl9IAZLAQQg4WFm+UhiW6kwCi9VFHk7N4dQyXZ/pmNGzm0aRsJc8af+hKX1qE39FJkEfsPw24t0 QqrYOk+zK78cTvdoaHQUt5FnJUI+iSZv8U/J01xuhs0d900JX6r2GeBm+Pv3z3eL/Ed/2p0F7n4LM7 l8kv8CVgu0alPBKX6c2rjdqqjyz4rCfvSmElnJifd9gpQLFRyGnzlGK3QBmXUyEN0EG78EqKqvLkI+ eNexowUDRvBXsQS7LU6rxW1c3lnNzuRodhW7cPU4s8sLYONnFpP3PHcMBdlvYkkG/bn+x8hkVEJnth LuKGO4r2MILGMcdGA5RvdHG1J/ICw329zv+0nrdcApOv55aL0ojezxqGoU1Y7E2uYbLKa5Ue9HCTdq WEykizKyXKhgmrfuusEXJcc+kcVNhX8nMg96f3t+QOfdMlNtOs3rNedUDd+VjuYhKCDt2U9KgP0gFA TKvTyzUZ42LNw6rwz18oeF6XeDhe6u/k7Uc3iknAhAfo0g+Q6+FKCU39eZe/SyFi3LLCTmuyWain/U XCCi0SPzT1fPIWUB6k4zsiLxyo+oBvPYO4nWOm7WmCCgVBE5EJNJr09P9k5Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Ensure that trusted PTR_TO_BTF_ID accesses perform PROBE_MEM handling in
raw_tp program. Without the previous fix, this selftest crashes the
kernel due to a NULL-pointer dereference. Also ensure that dead code
elimination does not kick in for checks on the pointer.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/bpf_testmod/bpf_testmod-events.h      |  8 +++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  2 ++
 .../selftests/bpf/prog_tests/raw_tp_null.c    | 25 +++++++++++++++
 .../testing/selftests/bpf/progs/raw_tp_null.c | 32 +++++++++++++++++++
 4 files changed, 67 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/raw_tp_null.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
index 6c3b4d4f173a..aeef86b3da74 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
@@ -40,6 +40,14 @@ DECLARE_TRACE(bpf_testmod_test_nullable_bare,
 	TP_ARGS(ctx__nullable)
 );
 
+struct sk_buff;
+
+DECLARE_TRACE(bpf_testmod_test_raw_tp_null,
+	TP_PROTO(struct sk_buff *skb),
+	TP_ARGS(skb)
+);
+
+
 #undef BPF_TESTMOD_DECLARE_TRACE
 #ifdef DECLARE_TRACE_WRITABLE
 #define BPF_TESTMOD_DECLARE_TRACE(call, proto, args, size) \
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 8835761d9a12..4e6a9e9c0368 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -380,6 +380,8 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 
 	(void)bpf_testmod_test_arg_ptr_to_struct(&struct_arg1_2);
 
+	(void)trace_bpf_testmod_test_raw_tp_null(NULL);
+
 	struct_arg3 = kmalloc((sizeof(struct bpf_testmod_struct_arg_3) +
 				sizeof(int)), GFP_KERNEL);
 	if (struct_arg3 != NULL) {
diff --git a/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c b/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
new file mode 100644
index 000000000000..6fa19449297e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include "raw_tp_null.skel.h"
+
+void test_raw_tp_null(void)
+{
+	struct raw_tp_null *skel;
+
+	skel = raw_tp_null__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "raw_tp_null__open_and_load"))
+		return;
+
+	skel->bss->tid = sys_gettid();
+
+	if (!ASSERT_OK(raw_tp_null__attach(skel), "raw_tp_null__attach"))
+		goto end;
+
+	ASSERT_OK(trigger_module_test_read(2), "trigger testmod read");
+	ASSERT_EQ(skel->bss->i, 3, "invocations");
+
+end:
+	raw_tp_null__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/raw_tp_null.c b/tools/testing/selftests/bpf/progs/raw_tp_null.c
new file mode 100644
index 000000000000..457f34c151e3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/raw_tp_null.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+int tid;
+int i;
+
+SEC("tp_btf/bpf_testmod_test_raw_tp_null")
+int BPF_PROG(test_raw_tp_null, struct sk_buff *skb)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+
+	if (task->pid != tid)
+		return 0;
+
+	i = i + skb->mark + 1;
+	/* The compiler may move the NULL check before this deref, which causes
+	 * the load to fail as deref of scalar. Prevent that by using a barrier.
+	 */
+	barrier();
+	/* If dead code elimination kicks in, the increment below will
+	 * be removed. For raw_tp programs, we mark input arguments as
+	 * PTR_MAYBE_NULL, so branch prediction should never kick in.
+	 */
+	if (!skb)
+		i += 2;
+	return 0;
+}
-- 
2.43.5


