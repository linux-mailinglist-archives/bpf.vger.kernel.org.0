Return-Path: <bpf+bounces-46920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F179F18FB
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352B0188F095
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194431EE005;
	Fri, 13 Dec 2024 22:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SomIOZlu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12AA185949
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 22:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128383; cv=none; b=hLCSp0jxvmXO+o91bEemjtAR60ehgqExLNg8+OwvcVcOEkoGmpbbF59T8Re6i8veQJ+p9f+DRdqJiaTfp6XpJMJWFqfLRrB/Ha5BmYBqnbuhyNKT4h5gR78j2BKWuKTUNqizVHsgLdbaIvFPSddNFS+uLLZRZN8d5DqvxrBQdhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128383; c=relaxed/simple;
	bh=vsRKSkz/fZOFZmIfl7f9CCgSIMhv+zZmOd+PgYxJzDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCoEslXHKnmxYmZNrjQsjHYcnjdoNKXVD3uQCRzeop70JKiLtRR/GxlisKx4JmR8i9P6dntwqhCKy9AE/Uj/s5gyZqfSoTfADem0wCC5smxXqDhc64g91wuy8MUy6tnrFB5nFy0bm9June5wyhFBym4Ig4DL9UiavyL8Ja39I8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SomIOZlu; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-3862d161947so1019278f8f.3
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 14:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734128379; x=1734733179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/xdfUQsKZfCf1D4VPdEjPDkdQjmt7uCtafMZN5T7vY=;
        b=SomIOZluaYr+nMUz7+Nd7SPyIHuZ1iojQfp2t8Hl/jm4uNCQeAE7NssRHXwK47hzpz
         yUZeEP4r3k40yV9KbbcqvCS3JII/FYZrIMChgakEsEEzHHjuPUu1hfbAZfTNzVuN7/Os
         vxx0WK9S0oqN2w6IioCKGcChh4hgAB4glsZjDGJodcSdICZAFl39twzKYn7IOMzgEY54
         27NgdnEpDgP9YYXnOMznAeFgOTeWbgdY+Cr04dBS4+JLLCT1FY7hICVq7nmOQaNbr/DO
         U4R9s2HVkcgfoOOSrJ/HhTS17ClRtnjRXOjOOTgHBjevx33QvNFfv8z4jaHdi9hI85SR
         9B1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128379; x=1734733179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/xdfUQsKZfCf1D4VPdEjPDkdQjmt7uCtafMZN5T7vY=;
        b=D1M3qtaExxnYjvV+VGwbZPCv5iU2Qtcqss5TGdVbuRXq3ET8lGijGnihVnzOiI9Zjv
         yxDMzS0uYo1+jJ8cMOcTMhqgBnZ347o42SBK2dEFzyVjc/mGWjOpi5xxj+qMEb2CLUl9
         6Ql7G7sV0OwJKHMLQoxtrHTEkz4EM/R0YOFf2PzvnPPIJISp3AIn+N6Fpdp6X4okHf/4
         /dE0W2hsJCCIAp7AYrvbU/wlZ4S6DsJsq4ZFOV8mLdpxIqT9NFBKaVXkaHE0CsEUnjvO
         y72z8jhqZi4nOsj6PObmmVvnCRilXTwn7R59Tn6aZ/nQA/Yku/XaPGpNloG1O+keMaQY
         0rsA==
X-Gm-Message-State: AOJu0YwsFxgNG1YUv7qIMUVoS1V6bxjdeBWYHdeT3fEv4zDF088opZa4
	I6kWgOPpGJOOMrV2arImW4NfpLBEuJBjbW9nBwqRX5tnVPEsaNN2eC0bszv1wCLVnA==
X-Gm-Gg: ASbGncu+OSB2upO3wOwHOdC90YSWBH4xpl/iKREz3WMOrzvnHF90uzRh138i+XvsGYE
	VCOljSmYFcdC7N1eji9jrLEN1vcTNnKARD2UdNGngiX+p5ehmwGRlO+JWKYCoYbYSBZU+jHpVoq
	VA954gn7DvOpyLf/er5EtlY3t15YV6p5XZfYBE54VaIjrMl9tMpLuIKPAG3xtcz7hL/qBWUwyPa
	QrgPz+Tye88t95o0KbG96dfU0EYzAPxVS2nPw0DuanXG4llvM6yH9zve/EcMQH5WTnL6MMIxNq3
	VXmo+09r
X-Google-Smtp-Source: AGHT+IForGseAj7xBAzNzdqeCK55zAg1Hew9Q+kNtkV4XfRKCPkZiSXBw+b81MfRa8Yo9KWSuae5LQ==
X-Received: by 2002:a05:6000:4709:b0:386:3803:bbd8 with SMTP id ffacd0b85a97d-3888e0c4d35mr3368674f8f.59.1734128379404;
        Fri, 13 Dec 2024 14:19:39 -0800 (PST)
Received: from localhost (fwdproxy-cln-039.fbsv.net. [2a03:2880:31ff:27::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801626asm690656f8f.29.2024.12.13.14.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:19:38 -0800 (PST)
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
Subject: [PATCH bpf v3 3/3] selftests/bpf: Add tests for raw_tp NULL args
Date: Fri, 13 Dec 2024 14:19:29 -0800
Message-ID: <20241213221929.3495062-4-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241213221929.3495062-1-memxor@gmail.com>
References: <20241213221929.3495062-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2301; h=from:subject; bh=vsRKSkz/fZOFZmIfl7f9CCgSIMhv+zZmOd+PgYxJzDg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnXK5lZKmTsj99EWTjLG1rmpgQTQk6XSjfFdqe8PQb tfxJShKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ1yuZQAKCRBM4MiGSL8RyoSFD/ 471ubGxUCUfNQbGbCwQjFdBgcF7duepdT+DGeQNi836aWhdCBV/3dwJE8XkiMZPKH606pn72YZICMx Dy5ggd19bY1dQMJMIIrS2LDvBKoSnzpZKP0ambuGtlHi4EuWGhIKChkPYJ47Ma7dHiVxCnV/Zcfasa jzYyzAdfAkXL8DWKL3VEaX8hGq7b5J7LAAvVEHOY0F0j6UGWMxvsds2A+FUyvXY6W8JJvjaz8xhsU3 gW/2hFYhjUsEAvy5MK3rxD+W17z04rNFa1rHLexnq4vxkyLl+acOq4vthymoVrEZ7p045qJMjIQN0k EusdVAXvDzCl1LyOSL8SCR9LKOKr1FdycyFuX2FD3wJrd+UAAzGGKmmzqQwpsYYDvCbvH5pfNn6YW1 B4+pGh3LhvanEiFh3gyWQE+9seXeuVSFl/P0NH/q9Q3ul7GGUjt3nAn8K+LwpFkRIRZ+nL0+3xwBlL Q3r6olRDbAjaEYp5BN0ncJ4+J5PcdSdSox8b0UIoXhtjLky7D3BUSgXwof8T6uyxLIm7M0EOX2NPnd fbctk+cXh1jtjv8kPdFMU/j+iAyDN34RF867wY8NtTwfqOZ9l7XO+CBiYcWwhcVjq9T4xRjAFJzSYK h9XPX/mbWrp8vi+xS+oeuoX1ODryhfJ0z16X+9PJ+GrfqQwixBtn2bZvARqg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add tests to ensure that arguments are correctly marked based on their
specified positions, and whether they get marked correctly as maybe
null. For modules, all tracepoint parameters should be marked
PTR_MAYBE_NULL by default.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/raw_tp_null.c    |  3 +++
 .../selftests/bpf/progs/raw_tp_null_fail.c    | 24 +++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/raw_tp_null_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c b/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
index 6fa19449297e..43676a9922dc 100644
--- a/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
+++ b/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
@@ -3,11 +3,14 @@
 
 #include <test_progs.h>
 #include "raw_tp_null.skel.h"
+#include "raw_tp_null_fail.skel.h"
 
 void test_raw_tp_null(void)
 {
 	struct raw_tp_null *skel;
 
+	RUN_TESTS(raw_tp_null_fail);
+
 	skel = raw_tp_null__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "raw_tp_null__open_and_load"))
 		return;
diff --git a/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c b/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c
new file mode 100644
index 000000000000..38d669957bf1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+/* Ensure module parameter has PTR_MAYBE_NULL */
+SEC("tp_btf/bpf_testmod_test_raw_tp_null")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_bpf_testmod_test_raw_tp_null_arg_1(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+/* Check NULL marking */
+SEC("tp_btf/sched_pi_setprio")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_sched_pi_setprio_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
-- 
2.43.5


