Return-Path: <bpf+bounces-27635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E3F8AFF47
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 05:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE31281AEB
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 03:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57C1139573;
	Wed, 24 Apr 2024 03:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4Jotl7w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA42585C59
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 03:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713928403; cv=none; b=V7Gm5Iitz5D2WIWOsGPrvDQDugOiH6Pn1wkz4f7kRweodcH5G6FcaEObXEfsGqkLSX2xR3zaTE4951cgkz7Qpd7jbdty3yFsoJY1CTGyXlCVuZSXWWEoVAmKtUrgYItZU/e+RDmiB7/nItKWvqLeYm2Gbtwy2iAvnOWrDmrJxAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713928403; c=relaxed/simple;
	bh=V/mVwOVq31CC3WejgrqNDRrOcshPMVlEjDE6YlJuDXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehSYPqdE9tUcSBiV962JBayab14fvL4lgMRXX3/Lsfde2GCEQqVEhdS0xx1k0u+N+WEVSBu0b7uHMNa7YpDHHzgQ0ksQIpZgGzBruDD/WwU1gsscQmMzEvS5C1YpLr+Sl0pR79O8r9/C03kWAGIAM0FxDZeRkbLn3a98/1IQmxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4Jotl7w; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a58872905b5so106010166b.2
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 20:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713928399; x=1714533199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boZt1+d49RBqMdIV0R60tZV7Mz7+9bHS1QBy9JQ7iZo=;
        b=i4Jotl7wiinBvW268yYSZNbVbwgvzUPQe/JJuu4mrDPvPHOU7Wu8ml1a2k6opIWJ/G
         m+PSckCCdAnV8mrVn2tkbWsv4gS/VP6Ds9BEw14hS+ATZS+mQar2MF2dJsAcKj9puk4f
         tQBEpcFxrxRPCbwLVzGwSg9H90JtYnfOntSvUOXvFtT4vc0vozyNQVtHSyEHRCKM78Sb
         dNMbScQEQv+APE3GJV57vb2QNh0EHwXTWSbDydh8q7pcrJh7JZ4nJvDU6t3gRsWi1ufh
         J6vGmZrl7TWLJnH32OjuFv10LvxvBK/+r9P1MMqDHTwxGjIULHM3+ZcH3ohrmYcHuvZ/
         LYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713928399; x=1714533199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boZt1+d49RBqMdIV0R60tZV7Mz7+9bHS1QBy9JQ7iZo=;
        b=GLi5R78GTnAfDmsrrsGr+vUwnHVtsElUOw4JC7sULohXDXMzHk4InwZnOfS9sM9/v7
         Elz2HEE5EAawi+U7A7bpEuy7R8XHkv+oN6qTZT9JUjaGhIHURrshAH6tgnVU8W2dK2fi
         /V2ql1agndxYIOSI+b7P3j2nz6vcn6atS2zg+IhE+jGq0GXE8hpgeUmfdkpLfzUlB9xM
         JoMshVsDA4oj8Kxo2O1lKXAnp6ArUIxn6ugi2J1oeGvlSEUT9gUUUIXrqtLnL0P0+848
         KFZa0sIK12fgNS2Ey315orPWAlzASUM5OBT4U0J+yd/ftk6z4iaXc8Kv2A9O1A2p3ZcU
         ye2Q==
X-Gm-Message-State: AOJu0YytNXkGD4U9tom1LgtPNFu0b5dbFJ7Xt9ptSljfuCGiqNA1z4tK
	7pOwXOyviU7T0y8t463j9aSu5plIJfqnKM3yT8b9qjCgb8dEgpF1m/DGg43u
X-Google-Smtp-Source: AGHT+IEjvq9bvouGY/nVhBQwNKrzEualHMXm+BCvoUuVttvBMXDNf5rfod7jYL8tRmQyLF63a8DCQA==
X-Received: by 2002:a17:906:3645:b0:a58:7ce0:8e13 with SMTP id r5-20020a170906364500b00a587ce08e13mr633944ejb.34.1713928399221;
        Tue, 23 Apr 2024 20:13:19 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id i21-20020a170906091500b00a5216df5d25sm7738097ejd.3.2024.04.23.20.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 20:13:18 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Barret Rhoden <brho@google.com>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add tests for preempt kfuncs
Date: Wed, 24 Apr 2024 03:13:15 +0000
Message-ID: <20240424031315.2757363-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240424031315.2757363-1-memxor@gmail.com>
References: <20240424031315.2757363-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4871; i=memxor@gmail.com; h=from:subject; bh=V/mVwOVq31CC3WejgrqNDRrOcshPMVlEjDE6YlJuDXE=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBmKHiQsYTybRY2KJQT/Jt1DmJLCR8aaMOsHjtdm 2IvGuVttvqJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZih4kAAKCRBM4MiGSL8R ynToEACk5koOqu9O3cN4epkJukdVi25SLlcueJbZj+8cQqNYXaB2ex49/HauVYd38eKbatBy7g0 DRMfQwmL8pPKav9E5WZxFnNW/xyU4/BMaKANQCeUkpCH/5DFigMPhJek8aGWT/tePcUgh1KqOVu K+nCCH5zwrXmz2pT4TRynmeVc43GVMJLrO5Rct/sEwqvoZmDC66aJ71bWsY96DnJOLsupCncSNh I02Hmmrq/nVY2pA1dUK6Q7NrM5PryCl5xpmIKGU1ERjIMKMHS1HEJOVnm/nhlOg5DBAi2adlHYZ B2zFuoOM76MB5T13A7qA5FzLNv9h4WTgM+OGKZ3e8Frs6/vmrXw2orj3jgtPD8xyT0cqunga1AH pxli4tYjvzouy+r5xQc8HPz/vukJ4hhO88MH0a47X/3Hw0GItAxwg4g/9tOYycwMiIvi+5EOC2y eGTCiQePfZxCb8/i7Iv5S1s4PHmSfiiPKnVJV3Ya1a3eR0YnLIGlmZta5fAokpDPCmsYAhX8TSF z9K/rk5hZ4SVHoX9/wUisyTT5W6/4urFPXg02uGjfUW9GAIwFynmbNQaw40/R4Nz7y5oJQq8Zue a4fiZuLmSxleCjsvQRaxqOOd57spFVujwnyfqTzrN9B30SK6aY9cenRFYgMhd6REXw+EBBqAjTr IXO1f2CEw7mJmSw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add tests for nested cases, nested count preservation upon different
subprog calls that disable/enable preemption, and test sleepable helper
call in non-preemptible regions.

182/1   preempt_lock/preempt_lock_missing_1:OK
182/2   preempt_lock/preempt_lock_missing_2:OK
182/3   preempt_lock/preempt_lock_missing_3:OK
182/4   preempt_lock/preempt_lock_missing_3_minus_2:OK
182/5   preempt_lock/preempt_lock_missing_1_subprog:OK
182/6   preempt_lock/preempt_lock_missing_2_subprog:OK
182/7   preempt_lock/preempt_lock_missing_2_minus_1_subprog:OK
182/8   preempt_lock/preempt_balance:OK
182/9   preempt_lock/preempt_balance_subprog_test:OK
182/10  preempt_lock/preempt_global_subprog_test:OK
182/11  preempt_lock/preempt_sleepable_helper:OK
182     preempt_lock:OK
Summary: 1/11 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/preempt_lock.c   |   9 ++
 .../selftests/bpf/progs/preempt_lock.c        | 135 ++++++++++++++++++
 2 files changed, 144 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/preempt_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/preempt_lock.c

diff --git a/tools/testing/selftests/bpf/prog_tests/preempt_lock.c b/tools/testing/selftests/bpf/prog_tests/preempt_lock.c
new file mode 100644
index 000000000000..02917c672441
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/preempt_lock.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include <preempt_lock.skel.h>
+
+void test_preempt_lock(void)
+{
+	RUN_TESTS(preempt_lock);
+}
diff --git a/tools/testing/selftests/bpf/progs/preempt_lock.c b/tools/testing/selftests/bpf/progs/preempt_lock.c
new file mode 100644
index 000000000000..6c637ee01ec4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/preempt_lock.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+void bpf_preempt_disable(void) __ksym;
+void bpf_preempt_enable(void) __ksym;
+
+SEC("?tc")
+__failure __msg("1 bpf_preempt_enable is missing")
+int preempt_lock_missing_1(struct __sk_buff *ctx)
+{
+	bpf_preempt_disable();
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("2 bpf_preempt_enable(s) are missing")
+int preempt_lock_missing_2(struct __sk_buff *ctx)
+{
+	bpf_preempt_disable();
+	bpf_preempt_disable();
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("3 bpf_preempt_enable(s) are missing")
+int preempt_lock_missing_3(struct __sk_buff *ctx)
+{
+	bpf_preempt_disable();
+	bpf_preempt_disable();
+	bpf_preempt_disable();
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("1 bpf_preempt_enable is missing")
+int preempt_lock_missing_3_minus_2(struct __sk_buff *ctx)
+{
+	bpf_preempt_disable();
+	bpf_preempt_disable();
+	bpf_preempt_disable();
+	bpf_preempt_enable();
+	bpf_preempt_enable();
+	return 0;
+}
+
+static __noinline void preempt_disable(void)
+{
+	bpf_preempt_disable();
+}
+
+static __noinline void preempt_enable(void)
+{
+	bpf_preempt_enable();
+}
+
+SEC("?tc")
+__failure __msg("1 bpf_preempt_enable is missing")
+int preempt_lock_missing_1_subprog(struct __sk_buff *ctx)
+{
+	preempt_disable();
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("2 bpf_preempt_enable(s) are missing")
+int preempt_lock_missing_2_subprog(struct __sk_buff *ctx)
+{
+	preempt_disable();
+	preempt_disable();
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("1 bpf_preempt_enable is missing")
+int preempt_lock_missing_2_minus_1_subprog(struct __sk_buff *ctx)
+{
+	preempt_disable();
+	preempt_disable();
+	preempt_enable();
+	return 0;
+}
+
+static __noinline void preempt_balance_subprog(void)
+{
+	preempt_disable();
+	preempt_enable();
+}
+
+SEC("?tc")
+__success int preempt_balance(struct __sk_buff *ctx)
+{
+	bpf_preempt_disable();
+	bpf_preempt_enable();
+	return 0;
+}
+
+SEC("?tc")
+__success int preempt_balance_subprog_test(struct __sk_buff *ctx)
+{
+	preempt_balance_subprog();
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("sleepable helper bpf_copy_from_user#")
+int preempt_sleepable_helper(void *ctx)
+{
+	u32 data;
+
+	bpf_preempt_disable();
+	bpf_copy_from_user(&data, sizeof(data), NULL);
+	bpf_preempt_enable();
+	return 0;
+}
+
+int __noinline preempt_global_subprog(void)
+{
+	preempt_balance_subprog();
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("global function calls are not allowed with preemption disabled")
+int preempt_global_subprog_test(struct __sk_buff *ctx)
+{
+	preempt_disable();
+	preempt_global_subprog();
+	preempt_enable();
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


