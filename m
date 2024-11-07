Return-Path: <bpf+bounces-44276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 460319C0D43
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 18:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C2D284C69
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 17:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1102170AD;
	Thu,  7 Nov 2024 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQEcH6/l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A02A216A32
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001876; cv=none; b=I96YesT1/EWKo6tp+9VY/YK+zK68Vrv5thPI/Srr6hOMIG+CsfZS7MrmG4MPTTNxw89WkTlzXiljeqZrRHnfqDH0mOt/CYKTv38XJsLkby4CW6NusAO4bTdrvB4oK/PSDn0pxZXFRqcQlajOu1lp70K7uQVFoMVRJMEASz2EupU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001876; c=relaxed/simple;
	bh=T8QX5b2CBgdACcPlQMEOyncHYhOUy2dUPRC73WryojY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tD+f5/l2l7cjHYufg/nqTghFXN1uzJkWgvVFHd5UldWDiG+BA13O2y94Cw/oG2yfEnizCJ0CFuT/Lnc8KbfcQfe0zoWn4KQUrE661VqrabelX30uJB2dp/02oHAuM6pnkJ0aILbFFJjjvGC/+EEZHzuRHj3q5Gs72oRSUM1Oklc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQEcH6/l; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ea8de14848so941369a12.2
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 09:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731001874; x=1731606674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugDuautYCQncfLo+o9NNjswjmgF8uCkD4Ve2GCTJRIA=;
        b=PQEcH6/l+FN3zUwDI2s3f7XCzpFlY3lFTn+jNkwHrsWvwSEuZkDGiLDVkDnwYk8vN1
         jSRZSf096fF/fQvnGD9GNdQ5y6iu+u66OnAuAmLwHFZCcmmEKOHl0xmUYLYgPW9WhI2e
         u6fdRM2jHYl4pTx5sqOw1jRKWxMRqRwHxP/5RZsi3h2lOlackX4z4i50Kcsl7OWW/7x7
         6oQ7ATJw3eYmXkDBVScTucLYpmtwT0q3D9QZXHvTYRltMeh+BaAxtazoeRVTJ8qWkTBL
         /J7yNI2wqSTXqyh2/ApYihLHfkxHo2fDBz/P3i2NwlrmIFZ+bJNWi1ugV9J331WeZurA
         Ai0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731001874; x=1731606674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugDuautYCQncfLo+o9NNjswjmgF8uCkD4Ve2GCTJRIA=;
        b=U1yxWlT9wk0fYXC/SKmIsfN6duHwjkQsZDvX4r75qBEFczIrss+MNQoAcCn+TZtSsb
         26+1nEMACqGjXRsLuHpUczJfkEfECs92FPU7iatbg/0bbkb73drCcCYXvJ9Vm6j6fou8
         eQhXMFgzA2zrqLLJfm+un0/wfGhbWYAtzKU6tTAnImRb+piYQMv/m058ddTsRNyU+t1F
         ySkiNlnjq1orbzF/J/PDd7CJmzspzBXEIwV8dNB0NdeYRWqUYcWUCMIAxo3+gGrjUWZF
         MOOL6wYqHiSe1aPEvWKg3emayFgjgblYa5ADo08xy69cBkGroZ0zXwMS0TZRfrrnB3nP
         o05w==
X-Gm-Message-State: AOJu0Yz69Ym5zmRvyWMX/vj6iuVh0I+zK870HVn6sZFZwLiCW8y1SQA2
	uBrb4iFZMV6VmjROoIJXINZQOm3lVJo4JWW3mbC7LygoOP6wEO2cMXDVJOpH
X-Google-Smtp-Source: AGHT+IGABM8JjjY2cpnDgDCuDj5D7UKok8cf67X8kyECbZygUSf7GXrDmNgtbu04APtwOiFrbor2oA==
X-Received: by 2002:a17:90b:4a91:b0:2e2:a3aa:6509 with SMTP id 98e67ed59e1d1-2e9b1697bf5mr62741a91.14.1731001874228;
        Thu, 07 Nov 2024 09:51:14 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f52b32sm1730686a91.5.2024.11.07.09.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 09:51:13 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 02/11] selftests/bpf: tests for opt_hard_wire_dead_code_branches()
Date: Thu,  7 Nov 2024 09:50:31 -0800
Message-ID: <20241107175040.1659341-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107175040.1659341-1-eddyz87@gmail.com>
References: <20241107175040.1659341-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As opt_hard_wire_dead_code_branches() was changed to react to
accumulated branch prediction flags for conditional jumps,
add tests for various possible predictions.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_dead_code.c  | 63 +++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_dead_code.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 75f7a2ce334b..efd42c07f58a 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -26,6 +26,7 @@
 #include "verifier_ctx.skel.h"
 #include "verifier_ctx_sk_msg.skel.h"
 #include "verifier_d_path.skel.h"
+#include "verifier_dead_code.skel.h"
 #include "verifier_direct_packet_access.skel.h"
 #include "verifier_direct_stack_access_wraparound.skel.h"
 #include "verifier_div0.skel.h"
@@ -154,6 +155,7 @@ void test_verifier_const_or(void)             { RUN(verifier_const_or); }
 void test_verifier_ctx(void)                  { RUN(verifier_ctx); }
 void test_verifier_ctx_sk_msg(void)           { RUN(verifier_ctx_sk_msg); }
 void test_verifier_d_path(void)               { RUN(verifier_d_path); }
+void test_verifier_dead_code(void)            { RUN(verifier_dead_code); }
 void test_verifier_direct_packet_access(void) { RUN(verifier_direct_packet_access); }
 void test_verifier_direct_stack_access_wraparound(void) { RUN(verifier_direct_stack_access_wraparound); }
 void test_verifier_div0(void)                 { RUN(verifier_div0); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_dead_code.c b/tools/testing/selftests/bpf/progs/verifier_dead_code.c
new file mode 100644
index 000000000000..b2eed6be0d42
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_dead_code.c
@@ -0,0 +1,63 @@
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("socket")
+__xlated("0: r1 = 1")
+__xlated("1: r0 = 42")
+__xlated("2: r0 = 24")
+__xlated("3: exit")
+__success
+__retval(24)
+__naked void cond_always_false(void)
+{
+	asm volatile (
+		"r1 = 1;"
+		"r0 = 42;"
+		"if r1 != 1 goto +1;"
+		"r0 = 24;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+SEC("socket")
+__xlated("0: r1 = 2")
+__xlated("1: r0 = 42")
+__xlated("2: exit")
+__success
+__retval(42)
+__naked void cond_always_true(void)
+{
+	asm volatile (
+		"r1 = 2;"
+		"r0 = 42;"
+		"if r1 != 1 goto +1;"
+		"r0 = 24;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+SEC("socket")
+__xlated("0: call")
+__xlated("1: r1 = r0")
+__xlated("2: r0 = 42")
+__xlated("3: if r1 != 0x1 goto pc+1")
+__xlated("4: r0 = 24")
+__xlated("5: exit")
+__success
+__naked void cond_unknown(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"r1 = r0;"
+		"r0 = 42;"
+		"if r1 != 1 goto +1;"
+		"r0 = 24;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
-- 
2.47.0


