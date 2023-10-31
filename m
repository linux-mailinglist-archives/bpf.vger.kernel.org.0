Return-Path: <bpf+bounces-13684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE09F7DC66A
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 07:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEBF01C20C06
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA996107A4;
	Tue, 31 Oct 2023 06:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVT9yzmz"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE5F107A1
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 06:18:53 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E451A4
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:07:25 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1e9bb3a0bfeso3521251fac.3
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698732444; x=1699337244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUv+lLz98TsYmkmvnDaCDlL7ttL7iI1bx/gxb+W2XWQ=;
        b=DVT9yzmzJXZ+ATmaZYyeifXGxaHa6OX13bfoasQbyyOexNke2o+MZhIYmeXUWiEbcD
         4UW8lKTOvy9OZq8yZfc5+De3UpCm7hTUQZfMLzE3Dg5FU6usRQznkyDvKGqOIoLc310Y
         f0jyAZLJ7cOi+ZI09E5FJcXUyDtPSp0RTHiqJ3cXD/9CzWDDIM0RaVnSA1P5kSLgALLf
         Cs5rGL4yTMRLgqrYfi5m4tAaDh2HbaNlbcNUXAlEf5ItDrDiL2GTyW6xalDu6nfNF8Kc
         8IkukRZZP5xT9YlFLOIBgODsFfOPiKRBttx48+R0f0SRBc32kd/Ev/XpECh2+Nf8CQnU
         DF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698732444; x=1699337244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUv+lLz98TsYmkmvnDaCDlL7ttL7iI1bx/gxb+W2XWQ=;
        b=QEGI5iFwyHMXETDw3HEYqwv/ZlVEqePxPo1w6J3+m1KU9JhnOVDoZDY/V+d0oAfYlq
         3F8ZTr+Z07TtxSaRddwTDUXze/TzcZqugs5pNHSBKjrwWx0Ude0ucfsZd/+8CZyyotmB
         g0UVovQyJHViRC5tNBHq52wH2Nkxq9NWMEDvl7Hftfgn8f+GgObDHLP4d9hXig3/ag3z
         7A2nyj2IUkW3QzNK1uvDO1o61YOfGgPDE3vb9hjUT84UGrSpwQ7ro0Toi3EZiMlHf248
         AM8S5d0n+RKw9k0KkhPcddIupIOkKzhOy3QcVLCYR0rGkXwXoXX8WKN+v0rRcfoR4h5e
         FDZw==
X-Gm-Message-State: AOJu0YyfJo1kqz9JqyZx9Opj77T+sotvRULB46bz6+ysGzWorwGwNiNH
	QsndahxhGEHqPVa0nbKjWgwizLKHajgLlQ==
X-Google-Smtp-Source: AGHT+IGPe/7smLbT0AEowfaAnjO5L40awyT4WdaQx98d+FyeWkSQ2d4GeQCUZvE4ZFkGvig/Oh/xIg==
X-Received: by 2002:a17:902:ecce:b0:1cc:59a1:79c6 with SMTP id a14-20020a170902ecce00b001cc59a179c6mr3579643plh.18.1698732045904;
        Mon, 30 Oct 2023 23:00:45 -0700 (PDT)
Received: from ubuntu.. ([203.205.141.13])
        by smtp.googlemail.com with ESMTPSA id x5-20020a170902b40500b001cc50f67fbasm460683plr.281.2023.10.30.23.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 23:00:45 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	keescook@chromium.org,
	luto@amacapital.net,
	wad@chromium.org,
	hengqi.chen@gmail.com
Subject: [PATCH bpf-next 5/6] selftests/bpf: Add seccomp verifier tests
Date: Tue, 31 Oct 2023 01:24:06 +0000
Message-Id: <20231031012407.51371-6-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031012407.51371-1-hengqi.chen@gmail.com>
References: <20231031012407.51371-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This tests seccomp context access and helper call
restriction.

  # ./test_progs -t verifier_seccomp
  #375/1   verifier_seccomp/seccomp no helper call:OK
  #375/2   verifier_seccomp/seccomp invalid ctx access, write:OK
  #375/3   verifier_seccomp/seccomp invalid ctx access, out of range:OK
  #375/4   verifier_seccomp/seccomp invalid ctx access, size too short:OK
  #375/5   verifier_seccomp/seccomp invalid ctx access, size too short:OK
  #375/6   verifier_seccomp/seccomp invalid ctx access, size too short:OK
  #375/7   verifier_seccomp/seccomp invalid ctx access, size too short:OK
  #375/8   verifier_seccomp/seccomp invalid ctx access, size too large:OK
  #375/9   verifier_seccomp/seccomp ctx access, valid:OK
  #375     verifier_seccomp:OK
  Summary: 1/9 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_seccomp.c    | 154 ++++++++++++++++++
 2 files changed, 156 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_seccomp.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index e3e68c97b40c..dfb40a11939e 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -57,6 +57,7 @@
 #include "verifier_scalar_ids.skel.h"
 #include "verifier_sdiv.skel.h"
 #include "verifier_search_pruning.skel.h"
+#include "verifier_seccomp.skel.h"
 #include "verifier_sock.skel.h"
 #include "verifier_spill_fill.skel.h"
 #include "verifier_spin_lock.skel.h"
@@ -164,6 +165,7 @@ void test_verifier_runtime_jit(void)          { RUN(verifier_runtime_jit); }
 void test_verifier_scalar_ids(void)           { RUN(verifier_scalar_ids); }
 void test_verifier_sdiv(void)                 { RUN(verifier_sdiv); }
 void test_verifier_search_pruning(void)       { RUN(verifier_search_pruning); }
+void test_verifier_seccomp(void)              { RUN(verifier_seccomp); }
 void test_verifier_sock(void)                 { RUN(verifier_sock); }
 void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill); }
 void test_verifier_spin_lock(void)            { RUN(verifier_spin_lock); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_seccomp.c b/tools/testing/selftests/bpf/progs/verifier_seccomp.c
new file mode 100644
index 000000000000..d3984a0cdae0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_seccomp.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Hengqi Chen */
+
+#include "vmlinux.h"
+#include "bpf_misc.h"
+
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+SEC("seccomp")
+__description("seccomp no helper call")
+__failure __msg("unknown func bpf_get_prandom_u32")
+__naked void seccomp_no_helper_call(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 = 0;						\
+	exit;"						\
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("seccomp")
+__description("seccomp invalid ctx access, write")
+__failure __msg("invalid bpf_context access")
+__naked void seccomp_ctx_write(void)
+{
+	asm volatile ("					\
+	r2 = r1;					\
+	*(u64*)(r2 + 8) = r1;				\
+	r0 = 0;						\
+	exit;"						\
+	:
+	:
+	: __clobber_all);
+}
+
+SEC("seccomp")
+__description("seccomp invalid ctx access, out of range")
+__failure __msg("invalid bpf_context access")
+__naked void seccomp_ctx_read_out_of_range(void)
+{
+	asm volatile ("					\
+	r2 = *(u64*)(r1 + %[__bpf_seccomp_ctx_size]);	\
+	r0 = 0;						\
+	exit;"						\
+	:
+	: __imm_const(__bpf_seccomp_ctx_size, sizeof(struct seccomp_data))
+	: __clobber_all);
+}
+
+SEC("seccomp")
+__description("seccomp invalid ctx access, size too short")
+__failure __msg("invalid bpf_context access")
+__naked void seccomp_ctx_read_too_short1(void)
+{
+	asm volatile ("					\
+	r2 = *(u8*)(r1 + %[__bpf_seccomp_ctx_nr]);	\
+	r0 = 0;						\
+	exit;"						\
+	:
+	: __imm_const(__bpf_seccomp_ctx_nr, offsetof(struct seccomp_data, nr))
+	: __clobber_all);
+}
+
+SEC("seccomp")
+__description("seccomp invalid ctx access, size too short")
+__failure __msg("invalid bpf_context access")
+__naked void seccomp_ctx_read_too_short2(void)
+{
+	asm volatile ("					\
+	r2 = *(u16*)(r1 + %[__bpf_seccomp_ctx_arch]);	\
+	r0 = 0;						\
+	exit;"						\
+	:
+	: __imm_const(__bpf_seccomp_ctx_arch, offsetof(struct seccomp_data, arch))
+	: __clobber_all);
+}
+
+SEC("seccomp")
+__description("seccomp invalid ctx access, size too short")
+__failure __msg("invalid bpf_context access")
+__naked void seccomp_ctx_read_too_short3(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__bpf_seccomp_ctx_ip]);	\
+	r0 = 0;						\
+	exit;"						\
+	:
+	: __imm_const(__bpf_seccomp_ctx_ip, offsetof(struct seccomp_data, instruction_pointer))
+	: __clobber_all);
+}
+
+SEC("seccomp")
+__description("seccomp invalid ctx access, size too short")
+__failure __msg("invalid bpf_context access")
+__naked void seccomp_ctx_read_too_short4(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__bpf_seccomp_ctx_arg1]);	\
+	r0 = 0;						\
+	exit;"						\
+	:
+	: __imm_const(__bpf_seccomp_ctx_arg1, offsetof(struct seccomp_data, args[1]))
+	: __clobber_all);
+}
+
+SEC("seccomp")
+__description("seccomp invalid ctx access, size too large")
+__failure __msg("invalid bpf_context access")
+__naked void seccomp_ctx_read_too_large(void)
+{
+	asm volatile ("					\
+	r2 = *(u64*)(r1 + %[__bpf_seccomp_ctx_nr]);	\
+	r0 = 0;						\
+	exit;"						\
+	:
+	: __imm_const(__bpf_seccomp_ctx_nr, offsetof(struct seccomp_data, nr))
+	: __clobber_all);
+}
+
+SEC("seccomp")
+__description("seccomp ctx access, valid")
+__success __retval(0x5ecc0779)
+__naked void seccomp_ctx_read_ok(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__bpf_seccomp_ctx_nr]);	\
+	r2 = *(u32*)(r1 + %[__bpf_seccomp_ctx_arch]);	\
+	r2 = *(u64*)(r1 + %[__bpf_seccomp_ctx_ip]);	\
+	r2 = *(u64*)(r1 + %[__bpf_seccomp_ctx_arg0]);	\
+	r2 = *(u64*)(r1 + %[__bpf_seccomp_ctx_arg1]);	\
+	r2 = *(u64*)(r1 + %[__bpf_seccomp_ctx_arg2]);	\
+	r2 = *(u64*)(r1 + %[__bpf_seccomp_ctx_arg3]);	\
+	r2 = *(u64*)(r1 + %[__bpf_seccomp_ctx_arg4]);	\
+	r2 = *(u64*)(r1 + %[__bpf_seccomp_ctx_arg5]);	\
+	r0 = 0x5ecc0779;				\
+	exit;"						\
+	:
+	: __imm_const(__bpf_seccomp_ctx_nr, offsetof(struct seccomp_data, nr)),
+	  __imm_const(__bpf_seccomp_ctx_arch, offsetof(struct seccomp_data, arch)),
+	  __imm_const(__bpf_seccomp_ctx_ip, offsetof(struct seccomp_data, instruction_pointer)),
+	  __imm_const(__bpf_seccomp_ctx_arg0, offsetof(struct seccomp_data, args[0])),
+	  __imm_const(__bpf_seccomp_ctx_arg1, offsetof(struct seccomp_data, args[1])),
+	  __imm_const(__bpf_seccomp_ctx_arg2, offsetof(struct seccomp_data, args[2])),
+	  __imm_const(__bpf_seccomp_ctx_arg3, offsetof(struct seccomp_data, args[3])),
+	  __imm_const(__bpf_seccomp_ctx_arg4, offsetof(struct seccomp_data, args[4])),
+	  __imm_const(__bpf_seccomp_ctx_arg5, offsetof(struct seccomp_data, args[5]))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


