Return-Path: <bpf+bounces-43908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3439BBBAD
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 18:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A810C282745
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 17:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AE21C760D;
	Mon,  4 Nov 2024 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzyuD6WH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050081C5793
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740808; cv=none; b=OfVBjGUUpZo1flgrWWuLFeBh1X9RLz5F4viLw7ljZVvtZyS1yi5KndIM4kkyB4iiFGNecyIk7to+uJ8UkdCtghrV9uFF/5VmI3zmHgbZl1lsdFBSgrJ2f25sWv72EYZcorVblUFs6QlUg+CQ3OZLq6TpTdQQkWfY/U7ehRIULLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740808; c=relaxed/simple;
	bh=KeLKDQttyADe4OxPGHrIqEv+R4Uau44CaiEy19OO1j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fawMG/8rHCIcb4+uvKfSCOIz1WvdldT/1dzhlnN7kjlGNb7Ytl2KygH/pibdpfP/LX/4pu5vQ+h255vvjj1HCNcc/4MaCq0i6ISnBZ8WdwiULQ4yPfODHsEoLsa7xhkjW11ziD1NsHeBXrGSdriVKM+Poy269kkpG6wcztKnzYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzyuD6WH; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so39243415e9.1
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 09:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730740805; x=1731345605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dolg5d6auqYGOV3uto7yeOBaCZO2J2L1Nv77LSazgLE=;
        b=DzyuD6WHXhMx4eHyR015mtUvtYpqiNunPWbF+b3LzHmC9MO/P+BqtRtj3XEaP32M44
         3WvSMxJAH4eEmZsScs7cDLcxEbFVW5X2Frw4G80YmpJDZmLs0OJXSrpmBEdryd0kWKxb
         epA+TY58lCK3NLwjv9QCpYzL3d+sib0bjTTMmSiza4Zgcz/zjMda6b2awFhGYSZe5s5z
         2eh81ldBzB+AXS4hhA1g81mGzG+SioGomUTdbBnxgwVwN5pS9Ll+RH9CjLY+FElhefiC
         8b/bfT0CyjP8JxBGK7d9ieAeS7oPYgg+lIoCdlftbBxaKbbUNrnnK9fi7MwHfYGaMqdF
         1dCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730740805; x=1731345605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dolg5d6auqYGOV3uto7yeOBaCZO2J2L1Nv77LSazgLE=;
        b=bC6v1OImIUqwT/5AkrIB///s5INtvWv46xDTb78lDIqYO0nmDBHfpfyISkeVF3Fb6m
         fBPpsLoQtCAylDFQRuiGMQjRma2Wch8t7b1ZBkuEj/rqUE/xrQZ2VhBU8dJAtgYiQ4jH
         XFHWfFhzG/61V3E5uQ7D2lpCi9sAHvOnKTfC8Oyg0fQwqe0w+TotfGCZ1BnKjSenEZ1r
         dkNmSG1KqSwAyxwNMxbgBQf9xe/8/d9oxV50zy7MgcqHhC6dHg8i90Wq+94dTvPdbYrK
         PC5zqBnMlBGZ5awEIezB1HrmDKLAZ1LJqlcHXwxBPnTDP+2HuNA9VFTMFzyOAMhkTNO8
         wCmg==
X-Gm-Message-State: AOJu0YyYeMKojiuipbgxS2o6YFixvRdq1kOjOE2vdlFoVS9pvpw25bty
	oYt2KF02y6qYYu872AlczjQgUeyjm86Kj9Tv2IxM+08J+fMSI+3GR0iC+bNGC2+wKA==
X-Google-Smtp-Source: AGHT+IF7pNKRGFksAXZSUbrXMpFQQU4BujI/elb1vRfW5ICKLvjmSqPMaF2XrwlRc+iUAs1opwT1Fg==
X-Received: by 2002:a05:600c:4ecb:b0:42e:75a6:bb60 with SMTP id 5b1f17b1804b1-4319acb8fcbmr284759435e9.19.1730740804949;
        Mon, 04 Nov 2024 09:20:04 -0800 (PST)
Received: from localhost (fwdproxy-cln-000.fbsv.net. [2a03:2880:31ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e8524sm189005835e9.5.2024.11.04.09.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 09:20:04 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Add tests for raw_tp null handling
Date: Mon,  4 Nov 2024 09:19:59 -0800
Message-ID: <20241104171959.2938862-4-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241104171959.2938862-1-memxor@gmail.com>
References: <20241104171959.2938862-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4160; h=from:subject; bh=KeLKDQttyADe4OxPGHrIqEv+R4Uau44CaiEy19OO1j8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnKQEyHNdJg5Vk8zS31IUoKAk70vskEy88dg3IaLtL K9vdmtCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZykBMgAKCRBM4MiGSL8RyoIBD/ 9jrhV8/WOOK2ksT9mOG7IJE3Ca+SVVvoMcMrNZUlJhcX3cezNrJvopM+aEadzziws2cIywEJJ4ePCK DeKemZbjEoXN7XXIVCBeIjZodYndEkzProznelLeVyfDO1xaJ1/+Du8CyC4NDlPQwFPVYzNiVEr/y3 +nvLwbJXAL0ITdq4e5UaKRwmn725suBV7SAwRD0k38ZUA07/3ZC05GoIBOcK6U4UVnKTC2BfN6x7lh CqvEBUv62W7VlaOtnhnpdNFImgJJJxmZku72OFSE88KjQBqYYV1xE7yhQ4j5YvR0D6gLmVMNaivIcd YxYcDLfAHJ4J63hyuNwImd2/nDcUMMT+MxtjK5+gz+0b76emLP+ov1NtN8tr/N0gBsqcwJdTr1G6vR 2wKOTS3/nnF+WGcObE7V/Q49B4Ls6HKOdUvZ7osjO0F5ocWO61uwhzL6Rcz80GIfA6gIeYGqmyNTkh vcNk/kOj8h5rU/Tu8YGoebaCRZc9rq/FXFEQsfAvl91n+V/gRi+iZtun4SKupnycdLzrzbDBiiycyB qI2Nd7Abxv1e0KwMf+56quBsPSoV2sNgUONtSg0R8wqZx0HyKExfik+AwmFy2+8xgwmzQ+HOAH72Zz kXunXnlfrUvDSQ7BlHjahxrXSLHgkt7bcfSL6nlJa3H7gA9dDAPuK7seV1+g==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Ensure that trusted PTR_TO_BTF_ID accesses perform PROBE_MEM handling in
raw_tp program. Without the previous fix, this selftest crashes the
kernel due to a NULL-pointer dereference. Also ensure that dead code
elimination does not kick in for checks on the pointer.

Reviewed-by: Jiri Olsa <jolsa@kernel.org>
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


