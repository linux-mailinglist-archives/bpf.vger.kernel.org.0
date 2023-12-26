Return-Path: <bpf+bounces-18682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A268381E929
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 20:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C37871C21017
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 19:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EEB17F8;
	Tue, 26 Dec 2023 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h57EcN91"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FD4187A
	for <bpf@vger.kernel.org>; Tue, 26 Dec 2023 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3ba14203a34so4730991b6e.1
        for <bpf@vger.kernel.org>; Tue, 26 Dec 2023 11:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703617924; x=1704222724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTuwf4nogusz8iRtA/ZW5pZEaI3MW7sGZQUdQtvLCUM=;
        b=h57EcN91Q3fxUVBDufVsU9qwd9miw5IaaHfUUe3PCeOhaaf+9iAd6k98uRkxiLXng5
         38R6NGDuiPC/2tpXG+jDVPZTCHHnpKqN5N/CZZlNXGRD8b6zXWiLog2ozleunB8RSjXw
         1Dyc6DuFl/SBo6XjI2Wz89fZMQIN+YGj6GToaKH0zyRkNbB7rN8ynvVTtuEC9vVME/zs
         iwP+TjKcVvn8VILFZ6LBgFUsob846P01anf8c3rXnJyz9XmIydFQpJZNe5cVtV2X14Pn
         6jMd2PA+lqf/ae9Zrwwuyjx0Kck5Yr0KckS2rso2Qv01pfUKjc7rzY+eNg2ZDdPW6HLQ
         Vdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703617924; x=1704222724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTuwf4nogusz8iRtA/ZW5pZEaI3MW7sGZQUdQtvLCUM=;
        b=ie1GgPhQ0K2eOL713jUQQKzxeWxiISEV/CYUPcGnyl6xvdRMtYtJJCdWD2Wuqgoebw
         60Ws5TEP2V6p9Pm/tuYq1/GtXHgPb1jV/xf9Uc3hzAvUQjMn8yiNqbwD6O1LAzOEwZ+0
         OuA4XG4J6aoYo18nFil++3gJn0aYwEsCGKWslhAkRqhvmX2MiQc2DRZ+1x5OqkPmBSIN
         Kv6SfT1PGsVKKsfXBFJHEj5DRHg/wvvNHYG47qOdLu3qhSkVQtkqCR45jDf1G6KNFk70
         +GV1zApJStHpps9S70qKfW+0ErOCJO4GUgTr4lErnX/M3GzYSaPzFlPk87g1lcg20caD
         ftWQ==
X-Gm-Message-State: AOJu0YwGMB+r0ziezaUgzbgIoTK70TxeQ4xtppndtpyFsWKX3rluMFHs
	rUN1It1yp5LRscud119Y+Jp//yZ59Wk=
X-Google-Smtp-Source: AGHT+IH/xyPwU8sLspRb3Zneqh68idHGI63cy2nMC+58U0rv/N4IY3f5MPM9ojeagcgbe/51C/zX6A==
X-Received: by 2002:a05:6808:14cd:b0:3bb:a9c8:272e with SMTP id f13-20020a05680814cd00b003bba9c8272emr4537116oiw.18.1703617924231;
        Tue, 26 Dec 2023 11:12:04 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:500::4:bc9b])
        by smtp.gmail.com with ESMTPSA id k16-20020aa792d0000000b006cbe1bb5e3asm10089753pfa.138.2023.12.26.11.12.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Dec 2023 11:12:03 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	dxu@dxuuu.xyz,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 3/6] selftests/bpf: Convert exceptions_assert.c to bpf_cmp
Date: Tue, 26 Dec 2023 11:11:45 -0800
Message-Id: <20231226191148.48536-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231226191148.48536-1-alexei.starovoitov@gmail.com>
References: <20231226191148.48536-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Convert exceptions_assert.c to bpf_cmp_unlikely() macro.

Since

bpf_assert(bpf_cmp_unlikely(var, ==, 100));
other code;

will generate assembly code:

  if r1 == 100 goto L2;
  r0 = 0
  call bpf_throw
L1:
  other code;
  ...

L2: goto L1;

LLVM generates redundant basic block with extra goto. LLVM will be fixed eventually.
Right now it's less efficient than __bpf_assert(var, ==, 100) macro that produces:
  if r1 == 100 goto L1;
  r0 = 0
  call bpf_throw
L1:
  other code;

But extra goto doesn't hurt the verification process.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/exceptions_assert.c   | 80 +++++++++----------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/exceptions_assert.c b/tools/testing/selftests/bpf/progs/exceptions_assert.c
index 0ef81040da59..5e0a1ca96d4e 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_assert.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_assert.c
@@ -11,51 +11,51 @@
 #define check_assert(type, op, name, value)				\
 	SEC("?tc")							\
 	__log_level(2) __failure					\
-	int check_assert_##op##_##name(void *ctx)			\
+	int check_assert_##name(void *ctx)				\
 	{								\
 		type num = bpf_ktime_get_ns();				\
-		bpf_assert_##op(num, value);				\
+		bpf_assert(bpf_cmp_unlikely(num, op, value));		\
 		return *(u64 *)num;					\
 	}
 
-__msg(": R0_w=0xffffffff80000000 R10=fp0")
-check_assert(s64, eq, int_min, INT_MIN);
-__msg(": R0_w=0x7fffffff R10=fp0")
-check_assert(s64, eq, int_max, INT_MAX);
-__msg(": R0_w=0 R10=fp0")
-check_assert(s64, eq, zero, 0);
-__msg(": R0_w=0x8000000000000000 R1_w=0x8000000000000000 R10=fp0")
-check_assert(s64, eq, llong_min, LLONG_MIN);
-__msg(": R0_w=0x7fffffffffffffff R1_w=0x7fffffffffffffff R10=fp0")
-check_assert(s64, eq, llong_max, LLONG_MAX);
-
-__msg(": R0_w=scalar(smax=0x7ffffffe) R10=fp0")
-check_assert(s64, lt, pos, INT_MAX);
-__msg(": R0_w=scalar(smax=-1,umin=0x8000000000000000,var_off=(0x8000000000000000; 0x7fffffffffffffff))")
-check_assert(s64, lt, zero, 0);
-__msg(": R0_w=scalar(smax=0xffffffff7fffffff,umin=0x8000000000000000,umax=0xffffffff7fffffff,var_off=(0x8000000000000000; 0x7fffffffffffffff))")
-check_assert(s64, lt, neg, INT_MIN);
-
-__msg(": R0_w=scalar(smax=0x7fffffff) R10=fp0")
-check_assert(s64, le, pos, INT_MAX);
-__msg(": R0_w=scalar(smax=0) R10=fp0")
-check_assert(s64, le, zero, 0);
-__msg(": R0_w=scalar(smax=0xffffffff80000000,umin=0x8000000000000000,umax=0xffffffff80000000,var_off=(0x8000000000000000; 0x7fffffffffffffff))")
-check_assert(s64, le, neg, INT_MIN);
-
-__msg(": R0_w=scalar(smin=umin=0x80000000,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
-check_assert(s64, gt, pos, INT_MAX);
-__msg(": R0_w=scalar(smin=umin=1,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
-check_assert(s64, gt, zero, 0);
-__msg(": R0_w=scalar(smin=0xffffffff80000001) R10=fp0")
-check_assert(s64, gt, neg, INT_MIN);
-
-__msg(": R0_w=scalar(smin=umin=0x7fffffff,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
-check_assert(s64, ge, pos, INT_MAX);
-__msg(": R0_w=scalar(smin=0,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff)) R10=fp0")
-check_assert(s64, ge, zero, 0);
-__msg(": R0_w=scalar(smin=0xffffffff80000000) R10=fp0")
-check_assert(s64, ge, neg, INT_MIN);
+__msg(": R0_w=0xffffffff80000000")
+check_assert(s64, ==, eq_int_min, INT_MIN);
+__msg(": R0_w=0x7fffffff")
+check_assert(s64, ==, eq_int_max, INT_MAX);
+__msg(": R0_w=0")
+check_assert(s64, ==, eq_zero, 0);
+__msg(": R0_w=0x8000000000000000 R1_w=0x8000000000000000")
+check_assert(s64, ==, eq_llong_min, LLONG_MIN);
+__msg(": R0_w=0x7fffffffffffffff R1_w=0x7fffffffffffffff")
+check_assert(s64, ==, eq_llong_max, LLONG_MAX);
+
+__msg(": R0_w=scalar(id=1,smax=0x7ffffffe)")
+check_assert(s64, <, lt_pos, INT_MAX);
+__msg(": R0_w=scalar(id=1,smax=-1,umin=0x8000000000000000,var_off=(0x8000000000000000; 0x7fffffffffffffff))")
+check_assert(s64, <, lt_zero, 0);
+__msg(": R0_w=scalar(id=1,smax=0xffffffff7fffffff")
+check_assert(s64, <, lt_neg, INT_MIN);
+
+__msg(": R0_w=scalar(id=1,smax=0x7fffffff)")
+check_assert(s64, <=, le_pos, INT_MAX);
+__msg(": R0_w=scalar(id=1,smax=0)")
+check_assert(s64, <=, le_zero, 0);
+__msg(": R0_w=scalar(id=1,smax=0xffffffff80000000")
+check_assert(s64, <=, le_neg, INT_MIN);
+
+__msg(": R0_w=scalar(id=1,smin=umin=0x80000000,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
+check_assert(s64, >, gt_pos, INT_MAX);
+__msg(": R0_w=scalar(id=1,smin=umin=1,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
+check_assert(s64, >, gt_zero, 0);
+__msg(": R0_w=scalar(id=1,smin=0xffffffff80000001")
+check_assert(s64, >, gt_neg, INT_MIN);
+
+__msg(": R0_w=scalar(id=1,smin=umin=0x7fffffff,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
+check_assert(s64, >=, ge_pos, INT_MAX);
+__msg(": R0_w=scalar(id=1,smin=0,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
+check_assert(s64, >=, ge_zero, 0);
+__msg(": R0_w=scalar(id=1,smin=0xffffffff80000000")
+check_assert(s64, >=, ge_neg, INT_MIN);
 
 SEC("?tc")
 __log_level(2) __failure
-- 
2.34.1


