Return-Path: <bpf+bounces-46585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D93869EC1E1
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 03:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866F716622A
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 02:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEDC1FBCB1;
	Wed, 11 Dec 2024 02:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgI2jFXG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0F6F4FA
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 02:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733882525; cv=none; b=aWIAGCHHSdsgHVScrj/VuQM1SWKr9/eSJt+AGj25LTw+ovDSCQNP7srycSuaTLh3zpGCEaXkzj882USafXMucJGC6CtyUehMkaG9iEOggREsf7od/tGgPiU8+cczT45EQP6aK9UgsV6yDiLYeyZcpd/XdB0okTkWydntbPmVfPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733882525; c=relaxed/simple;
	bh=NLH/seX4Uu655knSV9b6cxL2RBQiVdUH64rmV8wUEEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnW59wuD8xrChUPEU4FTyGbMOwloxb0W9UtXkYRDNxg2faKctgwi+IflRKwPYBR40/PaPqb9nVjU2645onFEGhdA40xYmDf4IMllv6zoUxemPwz0Zdr8U1RbslJVDWhg0uD0gANLLCEnymVZ1ATtWxcvMrLclZQNNGY4ytpk6QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgI2jFXG; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-434fef8203fso14794965e9.1
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 18:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733882522; x=1734487322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2EwSvCCaH/O3vpGExBjN+nGvLED19Y3oy1nPo+Iafo=;
        b=AgI2jFXGEvmi/w3x1NRCJf79I5uTBH46WMVMv8g7NivMwS7hi7qqeTW0pa4R1iMr4S
         h3W6ew3g9sxkDeU3GIe2wGIiwXLsseE83TCUbrgd/uUmqClgrUCapLAsdimEMmmsCoYe
         9S+wzk6QoQ/1I7ETfrYrLsVFOM4D1XktI4SgUkRd3aqoTvJFhX893Z6k7uTlqkO2AChv
         JmvxAoJeGYv/LTQzqn4GPLs8Bxc3gd/A9fycPfPeqiVSG6YezM22lb5s77j/SThIiiQi
         ZqlwfUsDyCL+Xuk0g2II8RTMLkOjsmOGqinziHeO+GJYdrxzLyrhqOdgPCAQ1SpCQbeX
         BlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733882522; x=1734487322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2EwSvCCaH/O3vpGExBjN+nGvLED19Y3oy1nPo+Iafo=;
        b=dmQq1yrIOwxMeq14aAVBjbaeZIQRxsQBhArSSGfasLJRj+a+x6u7VAfXrmMI9ZTo6C
         rPe3A9cewVvmdRv9WQIROfvkHc7Y7TBBZBL7Kej4nl4h9ZT7+wzT16Vrw5K+A52Kk6ls
         JQnyISP4v8DCDxGpZk139+k2Puh4p3XTlKVSsHW82XUozIA542aUjwj1rNJIFlZPxZ5Q
         DrElNeE/MmqoZCSyKoF0KuZlniwryIt2dHfCNgBKhDr6nQoZX3iqAfBur2oYpXGUY81i
         geSMVwnYZ57Ny3gNSaoEYTEik0UnQZyNH+MN8BI2lNC9iqcEFTa8rYihxtpQjQcZLVEs
         WkYw==
X-Gm-Message-State: AOJu0YzLWBydKpw3B5ONYj+1Hf8CZsELUd0e/dVFmCDEM2zZKA/WsEaR
	ed2euVRX2OnQ+Y0rDxoJiLX9mX3QDCvPh+FwsA9sSZVYb3P2Hlwi4APxo8fmNYQ=
X-Gm-Gg: ASbGncuWkUkl3iKZ50Fu24DHjl+sfcLZikBHj8Zj+L4/X9/gsLKunp6C9GLj7CjspPA
	irA18Qm/0TzXdc9/kKUx2G0bSjscpRbs/7YZoy0VvcueJ3SGQuhT7DOp4+E/ecs6U2EjMmvYDK5
	Q7RMHAwjDna8IEGyO4hYcgIFd+6W7ALwn1o1jCJsFywqAsUBaUKnjrxYTUFMwgk1JCDpolCMEvN
	5G/w4AVKlX2g2lBCqSpVgiji/Rp9+9ZPpRhEkPUAkbCHjsBxN4a1IjgK5ZW4Ncnef2UNoan1241
	SViEwQ==
X-Google-Smtp-Source: AGHT+IGBn9iLOCPuVaM47LkwtOoZq3McPe85FScv40LO1Ru2oye+aY9p1KXjcfqpKBx9tGIghkQeSQ==
X-Received: by 2002:a05:600c:4f11:b0:430:563a:b20a with SMTP id 5b1f17b1804b1-4361c3aa6demr5745605e9.11.1733882521785;
        Tue, 10 Dec 2024 18:02:01 -0800 (PST)
Received: from localhost (fwdproxy-cln-023.fbsv.net. [2a03:2880:31ff:17::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434e83f3958sm143853705e9.25.2024.12.10.18.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 18:02:00 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Manu Bretelle <chantra@meta.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	kernel-team@fb.com
Subject: [PATCH bpf v1 2/4] selftests/bpf: Revert "selftests/bpf: Add tests for raw_tp null handling"
Date: Tue, 10 Dec 2024 18:01:54 -0800
Message-ID: <20241211020156.18966-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241211020156.18966-1-memxor@gmail.com>
References: <20241211020156.18966-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4115; h=from:subject; bh=NLH/seX4Uu655knSV9b6cxL2RBQiVdUH64rmV8wUEEo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnWPJW0tpK4fkMor83OChmugBWFIqYWbdpX439wXy+ mkBUEr2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ1jyVgAKCRBM4MiGSL8RykmyD/ 9+jntpVfHIvW/g1tTzoVuNiNx2dkkcfNluo/W8WeUXSsmzFGO5uIhG+sBC9Jzv/CUBOwXbfq6rHIes TxJ5otjZ7QR7oTjASOgYzhdxecPS70AJ/ZtPloeWSrz6g7lEXZQCwftAQ887SQJAT5MdaGjrcEIPhO WP1uGtMkelZ6Q/aJx+2UYoSe/RUPC7mf6ewHfnxCejwhPkkvpWBJsKsiCOrcfW0wDcaAwvstepNXYi IpI8cm7cCUnXIX/nYisL0n7Jd2cCAehkxvUZQZdpPb/FyDoushITfTqH/VW0VcVhj4fcL9wY3cRRrI l2LLI9uUKAfpn1k2bFpUrslut5o3taI9mFEkXHWLKv0X+VMZN6nBSzB4qiXYQaIv/Pf1WvGyAgPoAz L2uiItGJYIInB+3yUIlx0byFtv37ak4vkzocUJcz2Bj2bUe8Wg9Wv03JFZ8bzbbCI/QaMipFrLzd0a hzIQKtU3rksanUWjxPjMVDiQMnZEXGfMeDZbLLk5iQ1Q7j3xhKna9yX+80Y1kHJs/AYWZa9tah3InO tK/We8NjQrvSBctf7C2WvYwoTr5WhPscwLfWv2JeM+tVUNA4vzSjmug+lQKX+REAcQbMS14dacuCww 0ePgYKoHzJxJQtD8XbdogCjuiyx4qWq3Nuw9385dXZWzbXR5bNYxcYk4zhnA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This patch reverts
commit d798ce3f4cab ("selftests/bpf: Add tests for raw_tp null handling")
since it's parent
commit cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")
is also being reverted.

Fixes: d798ce3f4cab ("selftests/bpf: Add tests for raw_tp null handling")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/bpf_testmod/bpf_testmod-events.h      |  8 -----
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  2 --
 .../selftests/bpf/prog_tests/raw_tp_null.c    | 25 ---------------
 .../testing/selftests/bpf/progs/raw_tp_null.c | 32 -------------------
 4 files changed, 67 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
 delete mode 100644 tools/testing/selftests/bpf/progs/raw_tp_null.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
index aeef86b3da74..6c3b4d4f173a 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
@@ -40,14 +40,6 @@ DECLARE_TRACE(bpf_testmod_test_nullable_bare,
 	TP_ARGS(ctx__nullable)
 );
 
-struct sk_buff;
-
-DECLARE_TRACE(bpf_testmod_test_raw_tp_null,
-	TP_PROTO(struct sk_buff *skb),
-	TP_ARGS(skb)
-);
-
-
 #undef BPF_TESTMOD_DECLARE_TRACE
 #ifdef DECLARE_TRACE_WRITABLE
 #define BPF_TESTMOD_DECLARE_TRACE(call, proto, args, size) \
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index cc9dde507aba..c64dd001a4ed 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -413,8 +413,6 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 
 	(void)bpf_testmod_test_arg_ptr_to_struct(&struct_arg1_2);
 
-	(void)trace_bpf_testmod_test_raw_tp_null(NULL);
-
 	bpf_testmod_test_struct_ops3();
 
 	struct_arg3 = kmalloc((sizeof(struct bpf_testmod_struct_arg_3) +
diff --git a/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c b/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
deleted file mode 100644
index 6fa19449297e..000000000000
--- a/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
+++ /dev/null
@@ -1,25 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
-
-#include <test_progs.h>
-#include "raw_tp_null.skel.h"
-
-void test_raw_tp_null(void)
-{
-	struct raw_tp_null *skel;
-
-	skel = raw_tp_null__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "raw_tp_null__open_and_load"))
-		return;
-
-	skel->bss->tid = sys_gettid();
-
-	if (!ASSERT_OK(raw_tp_null__attach(skel), "raw_tp_null__attach"))
-		goto end;
-
-	ASSERT_OK(trigger_module_test_read(2), "trigger testmod read");
-	ASSERT_EQ(skel->bss->i, 3, "invocations");
-
-end:
-	raw_tp_null__destroy(skel);
-}
diff --git a/tools/testing/selftests/bpf/progs/raw_tp_null.c b/tools/testing/selftests/bpf/progs/raw_tp_null.c
deleted file mode 100644
index 457f34c151e3..000000000000
--- a/tools/testing/selftests/bpf/progs/raw_tp_null.c
+++ /dev/null
@@ -1,32 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
-
-#include <vmlinux.h>
-#include <bpf/bpf_tracing.h>
-
-char _license[] SEC("license") = "GPL";
-
-int tid;
-int i;
-
-SEC("tp_btf/bpf_testmod_test_raw_tp_null")
-int BPF_PROG(test_raw_tp_null, struct sk_buff *skb)
-{
-	struct task_struct *task = bpf_get_current_task_btf();
-
-	if (task->pid != tid)
-		return 0;
-
-	i = i + skb->mark + 1;
-	/* The compiler may move the NULL check before this deref, which causes
-	 * the load to fail as deref of scalar. Prevent that by using a barrier.
-	 */
-	barrier();
-	/* If dead code elimination kicks in, the increment below will
-	 * be removed. For raw_tp programs, we mark input arguments as
-	 * PTR_MAYBE_NULL, so branch prediction should never kick in.
-	 */
-	if (!skb)
-		i += 2;
-	return 0;
-}
-- 
2.43.5


