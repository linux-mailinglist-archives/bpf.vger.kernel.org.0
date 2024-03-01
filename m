Return-Path: <bpf+bounces-23110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E398886DA46
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 04:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0125C1C22127
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 03:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AF350A8F;
	Fri,  1 Mar 2024 03:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTIKBLKw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3904EB3A
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 03:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709264282; cv=none; b=FvLmfhE4BxWljovCZB0COULnh91uMFoiz/iYV3mSySPbj/OIDR0Ew0mGUUpvL0VthUqNI4pBcDSD0dEbdEn/cLM8qpe2GgEim0h+5Fc6uQkvTt2VoNpzaApo8obHvzfmhtjyUeL7MpUj328Fffmemqr6GCKdHVGYh0gBSTL937Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709264282; c=relaxed/simple;
	bh=uNm8UAAjM07l5dnbUcorqFCBSlXCO1KNXoNbp2ZjVjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E3axAiNPNk5zuLigl5t/BnjxIKBGbupPEYmOk8JUdEjFkonWNG8/aHr7h6tMeHRGa1N5javP5KqAbevkin7LKwPYF7v88NCLZops7yevEJrqB8GmKFtRkJDOyk6lbhOjWZz70MvJV2S+XHKPUMUH6031MWqQTAlg7UC60TSDopQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTIKBLKw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dcd6a3da83so12260855ad.3
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 19:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709264279; x=1709869079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJKoITsZ2qMw+f2ZVmr0IejkTeqQU9mDVNK0qHIBo7g=;
        b=BTIKBLKwIPDSw0haSOMe9MI6v5iSzguCg+Fmxr+Bi4O6BT92k2W7DYWnbrQxxO7jlW
         pE8kQ3PNFvrwGBGyhsUPn17Dqv1tC8fGmEmCXhQwhETMAbOWC44chVvezNu1ls9Qx6WE
         PtCKYqtD6M9K1ju3qPZlxf8BPV6egCbjLyMKy84a2U+64PKIH40FcyuolDF8GOAVG/SH
         W8zixMet7vGe97wTmwEnUrMaaR/Fh9y0yQ2x/Z66p1/g/MyrCqtkT/TqXO8CuDBPcwxx
         qUjS2BM6+7oqAnd8kFTwNKWjTgmoo4Wl8s/r2Opt6llBlBqAAatyN9Mz7Gyc2uxZTUhc
         Y6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709264279; x=1709869079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJKoITsZ2qMw+f2ZVmr0IejkTeqQU9mDVNK0qHIBo7g=;
        b=INiyjytQ7Uir6IwFo6xguOocNQomsJCbDKc9tdONvoHGqfBUmOqie3BHuxu78VO7WW
         WX+zZo1DwO82Jzpu+6gJxptXt4MQ4d8TQkHJ1Ve8MVmSyKf4VespbDgT5ueu4B4FJbYH
         TejBGGVBuJaU/QUEs+n2H3dIxb0x87XFtuF0yAannjwSunl0jBTdS0BcNfq+q/DmnaK4
         KNwe3KwJyNClMO4kWxB+MeHXnOAU6vvJrwB7lk33zHh3XtcaA9ngKFEsxY+d1jfDbG6t
         DPVt93Ww6B0pX/T8FCVf7Jp02YAHbklM8lFKWRLmKB4tMmKv9BhdVZ2+SAHxxcmYE4xq
         5Lfg==
X-Gm-Message-State: AOJu0Yx/YexmzOHhOt3sPQR6BrjpaikWpmll3wEQBW+ea3kOtnZwSVYr
	WwpyT+/Q0+Gv5Sg0kmaAIXWquSVidJUbOwR9VSH4OfPNF1zYcJCl/f8mXuu2
X-Google-Smtp-Source: AGHT+IGU48rZ0de+QbY3STODj6Sgd0rZFVhal7z7CMldITeKfSJJ95CoUWB/0B+VhXNUu1b9qfY5wA==
X-Received: by 2002:a17:902:e944:b0:1dc:226d:d85f with SMTP id b4-20020a170902e94400b001dc226dd85fmr674519pll.69.1709264279315;
        Thu, 29 Feb 2024 19:37:59 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:8f17])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b001dc3c3be4a4sm2267286plg.304.2024.02.29.19.37.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Feb 2024 19:37:58 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 4/4] selftests/bpf: Test may_goto
Date: Thu, 29 Feb 2024 19:37:34 -0800
Message-Id: <20240301033734.95939-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240301033734.95939-1-alexei.starovoitov@gmail.com>
References: <20240301033734.95939-1-alexei.starovoitov@gmail.com>
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
 tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
 .../bpf/progs/verifier_iterating_callbacks.c  | 72 ++++++++++++++++++-
 2 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index 1a63996c0304..c6c31b960810 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -3,3 +3,4 @@
 exceptions				 # JIT does not support calling kfunc bpf_throw				       (exceptions)
 get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
 stacktrace_build_id                      # compare_map_keys stackid_hmap vs. stackmap err -2 errno 2                   (?)
+verifier_iter/cond_break
diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index 5905e036e0ea..8476dc47623f 100644
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
@@ -239,4 +237,72 @@ int bpf_loop_iter_limit_nested(void *unused)
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
+	unsigned int i;
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
+__success __retval(0x800000) /* BPF_MAX_LOOPS */
+int cond_break4(const void *ctx)
+{
+	int cnt = 0;
+
+	for (;;) {
+		cond_break;
+		cnt++;
+	}
+	return cnt;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.34.1


