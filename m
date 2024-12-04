Return-Path: <bpf+bounces-46054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 548CB9E31CA
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 04:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14950284560
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 03:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4D0139587;
	Wed,  4 Dec 2024 03:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlTWnoph"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9392CA9
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 03:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281460; cv=none; b=GelenbTBQVa3LZ3DPm5UeSYPnwAGFxJf+xBJkUOwpGxcQ+mAJUZ/rxLfmtAIYCyI9boluoyHdlcC5TzfwVVo04agt2RnP69qV1IALawh+7hIZYfMGYVc5i6wE/g77tD+XDUFFjtvg88vQPtMf2/aumhNnUkn6cZFDxk9rV8InN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281460; c=relaxed/simple;
	bh=ehi26WvLtHDNqOg9c0fi4JyDWWJM2Ix5M04x2JY8xbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mV7XRvmNIIk6hGLuM08nQYDJMtGxske7F4EA8y6msY9BambfvDEKpQmYoV8ymAzzskniVKYsGFbnwW6Jc5CyL2SulwsWrVpUtdW7SDxUB0Yk3+Mqg8UiHbfkpMyLG4Aq2k7oIiUlSNgWD37LTLsLRWsi9oVYaHAhpMLLdNL/PhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlTWnoph; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4349e1467fbso55189365e9.1
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 19:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733281455; x=1733886255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWQu++WV789z3AsgN8NSsS0Hi3vDX++q+Q3xLlXGnZo=;
        b=mlTWnoph7XT81LS0ulAQfcRmnC3XVS5dTcG7wqYnIKDFbyI0Yb27uZiVsFx754xDlr
         hYBXuCqc+FsK29uirx0LDSqpqhb9MT3s1I9miXhiXxYDPowpkebQpoXffTAnlDKrNNws
         +DAgWaFaNIl+UtwjMdtqPQpT3mg66OyclU0KpNasA9AY6oxo2n6g8dabCRkEgZmIeGhj
         NYTsIbTmzRx4LKXVJtGFcJRBaFzOeN/TuWkwIkj0Kz5GPpMh3CVDb9ih8E9drgCUXm+g
         Q6yR+u08D3Ffl8wcBRPQ2tUAGkJghpy+lmzIf9VqAN56yMLYi0dmvt7KZPT0jEwO0nZR
         D6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733281455; x=1733886255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWQu++WV789z3AsgN8NSsS0Hi3vDX++q+Q3xLlXGnZo=;
        b=QH7K9594rhK1ltB8wBs6bSfx5tXlHHj+NEf3t4RM0wyaFLzzT3Svxl40yQ2m6QChOv
         rXZ7xbkPtC8Zbp3bEmA3wKq8rKyB6WFR85pGCQyiShk1C6nKZJkI7UWkKwl7lIHU4QMO
         lOYyOXWG3Csx4He8AWTU4JR4QTLXm4Hxz7vtOKYtaLM3/h7rCFGOQVFU+3mbLkyFChgr
         nsdchhiGs75PQGtc9zU4tA1THxSoiAC5G5UuZYBtzLNebaFEXJWAAKj3JyXE/tIG6QlL
         Qrd8VMbPR7MOCiXNm4jmpTNlOLXqTrM0mT9nrLar4VqwKoBXEtawcdFkN0cjOnhHc86r
         T3Tw==
X-Gm-Message-State: AOJu0Yw1XPt6qTCkFOYxhAeSMYuGRYWPMwF3L07aRRZRXV2V2Vix7/2H
	w4coFxgbxlucE5c5YPXGvRRMNeyKC8yjyZpv5SFVCs24ba78MkVBmQTqqhdp6MQ=
X-Gm-Gg: ASbGncsMLWRKaVTiBsYCHJLCoYrqxPtl1CeIwKWbUpsUHwVIgQD1xrO9AP24g/5XJPO
	hfWAC9ucjTyr8iORDdbkGkrnBQUJTcTBj+W7ndZ29TmQQyedu5qW4PlAcXVN5k8ekhnZiB85VUa
	n9yW6asxs7cUcTvJgLNaNr311KGLQfuYbHEOSiPJnG1+oF8PTOTdEUbVg77Yy7c0G+nSt2vnLF2
	W+++hPfa308ww9bmkEMX1PA2Pk8VamV9mAVktOtObq8LwJ6PvomrMjLJspdBzpVYkm9sD/89g==
X-Google-Smtp-Source: AGHT+IH+PNCwVRG0IWCaVGRnuxpaZXi5rGLhK4EKo7flgBv0Lzzslzhgym3vLHqFvWu/Ig8CC/YXNA==
X-Received: by 2002:a05:600c:1d86:b0:434:9e17:18e4 with SMTP id 5b1f17b1804b1-434d0905301mr43782735e9.0.1733281455095;
        Tue, 03 Dec 2024 19:04:15 -0800 (PST)
Received: from localhost (fwdproxy-cln-000.fbsv.net. [2a03:2880:31ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbd5asm7555655e9.40.2024.12.03.19.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 19:04:14 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 7/7] selftests/bpf: Add IRQ save/restore tests
Date: Tue,  3 Dec 2024 19:04:00 -0800
Message-ID: <20241204030400.208005-8-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241204030400.208005-1-memxor@gmail.com>
References: <20241204030400.208005-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13870; h=from:subject; bh=ehi26WvLtHDNqOg9c0fi4JyDWWJM2Ix5M04x2JY8xbA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnT8RAYvrbONJqwMsuBYoSS+qi19jI1kCZNnhDwUpT BCp423iJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0/EQAAKCRBM4MiGSL8RygkoEA CPNqqx8Fp4bSDACiPUOrMSXYMvxvl4E8WIYz5wF9U9GZ6gQUfYPMJXrTemf9citG+TvKm06xlWrkAs CMkmlrTZH4M+MJkqgyjQzzoF3NlMb502sdsZTKuSTcb9EJTiNYv6LFTMIhor/qRMBc/bQulS0Mg4fx Fw88AOtRJ7vNBnfaa7w+O4ooRl5wSO2DAu24SiKhzYnyflZmTuTUxs0nmCYhnxxOo//TENfvDrF0ha WBwR8NH3K/IMJpTePaYJyrznI3Os71SwX9ivINgsdolclN+xJtwwmlt1XdhyAPaV7toDLGVhvIaSBy pymQzRcoJ0DTuvmjONOsH1KD98GIjjnHm+LcghlnmKMqz/X5YVzI0QI8AqriEqCfi75ki2T7SoVNjc NIG7z0wmyY+4k1AVRWSS2WfYM1UFEc0PTkpeAHKwSVDuzj6kpvfjmsYS1aGec7TJR+OFvAWq1HhjF1 4gFuMOBZPmDw+B2H6yhWI4sfioaNHXC5oDDN3uyqamoI+rViZlTbF5ZilsHcbRS010eeAKAsNu6Qp+ Em6AKaNWJgrL+rePNU0B2ApbzwPMR8KBJI5LgDImNFjIdiRYpdAi5addoJ1HO4iobTph46jp7XGH1M rZqp34a0f42oSdik5iTVHu73+UXQXaTh9qlgJs3dT0C+ZirCgOaOJenyQ6Uw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Include tests that check for rejection in erroneous cases, like
unbalanced IRQ-disabled counts, within and across subprogs, invalid IRQ
flag state or input to kfuncs, behavior upon overwriting IRQ saved state
on stack, interaction with sleepable kfuncs/helpers, global functions,
and out of order restore. Include some success scenarios as well to
demonstrate usage.

#128/1   irq/irq_save_bad_arg:OK
#128/2   irq/irq_restore_bad_arg:OK
#128/3   irq/irq_restore_missing_2:OK
#128/4   irq/irq_restore_missing_3:OK
#128/5   irq/irq_restore_missing_3_minus_2:OK
#128/6   irq/irq_restore_missing_1_subprog:OK
#128/7   irq/irq_restore_missing_2_subprog:OK
#128/8   irq/irq_restore_missing_3_subprog:OK
#128/9   irq/irq_restore_missing_3_minus_2_subprog:OK
#128/10  irq/irq_balance:OK
#128/11  irq/irq_balance_n:OK
#128/12  irq/irq_balance_subprog:OK
#128/13  irq/irq_global_subprog:OK
#128/14  irq/irq_restore_ooo:OK
#128/15  irq/irq_restore_ooo_3:OK
#128/16  irq/irq_restore_3_subprog:OK
#128/17  irq/irq_restore_4_subprog:OK
#128/18  irq/irq_restore_ooo_3_subprog:OK
#128/19  irq/irq_restore_invalid:OK
#128/20  irq/irq_save_invalid:OK
#128/21  irq/irq_restore_iter:OK
#128/22  irq/irq_save_iter:OK
#128/23  irq/irq_flag_overwrite:OK
#128/24  irq/irq_flag_overwrite_partial:OK
#128/25  irq/irq_ooo_refs_array:OK
#128/26  irq/irq_sleepable_helper:OK
#128/27  irq/irq_sleepable_kfunc:OK
#128     irq:OK
Summary: 1/27 PASSED, 0 SKIPPED, 0 FAILED

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/irq.c       | 444 ++++++++++++++++++
 2 files changed, 446 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/irq.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index d9f65adb456b..b1b4d69c407a 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -98,6 +98,7 @@
 #include "verifier_xdp_direct_packet_access.skel.h"
 #include "verifier_bits_iter.skel.h"
 #include "verifier_lsm.skel.h"
+#include "irq.skel.h"
 
 #define MAX_ENTRIES 11
 
@@ -225,6 +226,7 @@ void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
 void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_direct_packet_access); }
 void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
 void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
+void test_irq(void)			      { RUN(irq); }
 
 void test_verifier_mtu(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/irq.c b/tools/testing/selftests/bpf/progs/irq.c
new file mode 100644
index 000000000000..b0b53d980964
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/irq.c
@@ -0,0 +1,444 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+unsigned long global_flags;
+
+extern void bpf_local_irq_save(unsigned long *) __weak __ksym;
+extern void bpf_local_irq_restore(unsigned long *) __weak __ksym;
+extern int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void *unsafe_ptr__ign, u64 flags) __weak __ksym;
+
+SEC("?tc")
+__failure __msg("arg#0 doesn't point to an irq flag on stack")
+int irq_save_bad_arg(struct __sk_buff *ctx)
+{
+	bpf_local_irq_save(&global_flags);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("arg#0 doesn't point to an irq flag on stack")
+int irq_restore_bad_arg(struct __sk_buff *ctx)
+{
+	bpf_local_irq_restore(&global_flags);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_local_irq_save-ed region")
+int irq_restore_missing_2(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+	unsigned long flags2;
+
+	bpf_local_irq_save(&flags1);
+	bpf_local_irq_save(&flags2);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_local_irq_save-ed region")
+int irq_restore_missing_3(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+	unsigned long flags2;
+	unsigned long flags3;
+
+	bpf_local_irq_save(&flags1);
+	bpf_local_irq_save(&flags2);
+	bpf_local_irq_save(&flags3);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_local_irq_save-ed region")
+int irq_restore_missing_3_minus_2(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+	unsigned long flags2;
+	unsigned long flags3;
+
+	bpf_local_irq_save(&flags1);
+	bpf_local_irq_save(&flags2);
+	bpf_local_irq_save(&flags3);
+	bpf_local_irq_restore(&flags3);
+	bpf_local_irq_restore(&flags2);
+	return 0;
+}
+
+static __noinline void local_irq_save(unsigned long *flags)
+{
+	bpf_local_irq_save(flags);
+}
+
+static __noinline void local_irq_restore(unsigned long *flags)
+{
+	bpf_local_irq_restore(flags);
+}
+
+SEC("?tc")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_local_irq_save-ed region")
+int irq_restore_missing_1_subprog(struct __sk_buff *ctx)
+{
+	unsigned long flags;
+
+	local_irq_save(&flags);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_local_irq_save-ed region")
+int irq_restore_missing_2_subprog(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+	unsigned long flags2;
+
+	local_irq_save(&flags1);
+	local_irq_save(&flags2);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_local_irq_save-ed region")
+int irq_restore_missing_3_subprog(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+	unsigned long flags2;
+	unsigned long flags3;
+
+	local_irq_save(&flags1);
+	local_irq_save(&flags2);
+	local_irq_save(&flags3);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_local_irq_save-ed region")
+int irq_restore_missing_3_minus_2_subprog(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+	unsigned long flags2;
+	unsigned long flags3;
+
+	local_irq_save(&flags1);
+	local_irq_save(&flags2);
+	local_irq_save(&flags3);
+	local_irq_restore(&flags3);
+	local_irq_restore(&flags2);
+	return 0;
+}
+
+SEC("?tc")
+__success
+int irq_balance(struct __sk_buff *ctx)
+{
+	unsigned long flags;
+
+	local_irq_save(&flags);
+	local_irq_restore(&flags);
+	return 0;
+}
+
+SEC("?tc")
+__success
+int irq_balance_n(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+	unsigned long flags2;
+	unsigned long flags3;
+
+	local_irq_save(&flags1);
+	local_irq_save(&flags2);
+	local_irq_save(&flags3);
+	local_irq_restore(&flags3);
+	local_irq_restore(&flags2);
+	local_irq_restore(&flags1);
+	return 0;
+}
+
+static __noinline void local_irq_balance(void)
+{
+	unsigned long flags;
+
+	local_irq_save(&flags);
+	local_irq_restore(&flags);
+}
+
+static __noinline void local_irq_balance_n(void)
+{
+	unsigned long flags1;
+	unsigned long flags2;
+	unsigned long flags3;
+
+	local_irq_save(&flags1);
+	local_irq_save(&flags2);
+	local_irq_save(&flags3);
+	local_irq_restore(&flags3);
+	local_irq_restore(&flags2);
+	local_irq_restore(&flags1);
+}
+
+SEC("?tc")
+__success
+int irq_balance_subprog(struct __sk_buff *ctx)
+{
+	local_irq_balance();
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("sleepable helper bpf_copy_from_user#")
+int irq_sleepable_helper(void *ctx)
+{
+	unsigned long flags;
+	u32 data;
+
+	local_irq_save(&flags);
+	bpf_copy_from_user(&data, sizeof(data), NULL);
+	local_irq_restore(&flags);
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("kernel func bpf_copy_from_user_str is sleepable within IRQ-disabled region")
+int irq_sleepable_kfunc(void *ctx)
+{
+	unsigned long flags;
+	u32 data;
+
+	local_irq_save(&flags);
+	bpf_copy_from_user_str(&data, sizeof(data), NULL, 0);
+	local_irq_restore(&flags);
+	return 0;
+}
+
+int __noinline global_local_irq_balance(void)
+{
+	local_irq_balance_n();
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("global function calls are not allowed with IRQs disabled")
+int irq_global_subprog(struct __sk_buff *ctx)
+{
+	unsigned long flags;
+
+	bpf_local_irq_save(&flags);
+	global_local_irq_balance();
+	bpf_local_irq_restore(&flags);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("cannot restore irq state out of order")
+int irq_restore_ooo(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+	unsigned long flags2;
+
+	bpf_local_irq_save(&flags1);
+	bpf_local_irq_save(&flags2);
+	bpf_local_irq_restore(&flags1);
+	bpf_local_irq_restore(&flags2);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("cannot restore irq state out of order")
+int irq_restore_ooo_3(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+	unsigned long flags2;
+	unsigned long flags3;
+
+	bpf_local_irq_save(&flags1);
+	bpf_local_irq_save(&flags2);
+	bpf_local_irq_restore(&flags2);
+	bpf_local_irq_save(&flags3);
+	bpf_local_irq_restore(&flags1);
+	bpf_local_irq_restore(&flags3);
+	return 0;
+}
+
+static __noinline void local_irq_save_3(unsigned long *flags1, unsigned long *flags2,
+					unsigned long *flags3)
+{
+	local_irq_save(flags1);
+	local_irq_save(flags2);
+	local_irq_save(flags3);
+}
+
+SEC("?tc")
+__success
+int irq_restore_3_subprog(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+	unsigned long flags2;
+	unsigned long flags3;
+
+	local_irq_save_3(&flags1, &flags2, &flags3);
+	bpf_local_irq_restore(&flags3);
+	bpf_local_irq_restore(&flags2);
+	bpf_local_irq_restore(&flags1);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("cannot restore irq state out of order")
+int irq_restore_4_subprog(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+	unsigned long flags2;
+	unsigned long flags3;
+	unsigned long flags4;
+
+	local_irq_save_3(&flags1, &flags2, &flags3);
+	bpf_local_irq_restore(&flags3);
+	bpf_local_irq_save(&flags4);
+	bpf_local_irq_restore(&flags4);
+	bpf_local_irq_restore(&flags1);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("cannot restore irq state out of order")
+int irq_restore_ooo_3_subprog(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+	unsigned long flags2;
+	unsigned long flags3;
+
+	local_irq_save_3(&flags1, &flags2, &flags3);
+	bpf_local_irq_restore(&flags3);
+	bpf_local_irq_restore(&flags2);
+	bpf_local_irq_save(&flags3);
+	bpf_local_irq_restore(&flags1);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("expected an initialized")
+int irq_restore_invalid(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+	unsigned long flags = 0xfaceb00c;
+
+	bpf_local_irq_save(&flags1);
+	bpf_local_irq_restore(&flags);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("expected uninitialized")
+int irq_save_invalid(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+
+	bpf_local_irq_save(&flags1);
+	bpf_local_irq_save(&flags1);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("expected an initialized")
+int irq_restore_iter(struct __sk_buff *ctx)
+{
+	struct bpf_iter_num it;
+
+	bpf_iter_num_new(&it, 0, 42);
+	bpf_local_irq_restore((unsigned long *)&it);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("Unreleased reference id=1")
+int irq_save_iter(struct __sk_buff *ctx)
+{
+	struct bpf_iter_num it;
+
+	/* Ensure same sized slot has st->ref_obj_id set, so we reject based on
+	 * slot_type != STACK_IRQ_FLAG...
+	 */
+	_Static_assert(sizeof(it) == sizeof(unsigned long), "broken iterator size");
+
+	bpf_iter_num_new(&it, 0, 42);
+	bpf_local_irq_save((unsigned long *)&it);
+	bpf_local_irq_restore((unsigned long *)&it);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("expected an initialized")
+int irq_flag_overwrite(struct __sk_buff *ctx)
+{
+	unsigned long flags;
+
+	bpf_local_irq_save(&flags);
+	flags = 0xdeadbeef;
+	bpf_local_irq_restore(&flags);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("expected an initialized")
+int irq_flag_overwrite_partial(struct __sk_buff *ctx)
+{
+	unsigned long flags;
+
+	bpf_local_irq_save(&flags);
+	*(((char *)&flags) + 1) = 0xff;
+	bpf_local_irq_restore(&flags);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("cannot restore irq state out of order")
+int irq_ooo_refs_array(struct __sk_buff *ctx)
+{
+	unsigned long flags[4];
+	struct { int i; } *p;
+
+	/* refs=1 */
+	bpf_local_irq_save(&flags[0]);
+
+	/* refs=1,2 */
+	p = bpf_obj_new(typeof(*p));
+	if (!p) {
+		bpf_local_irq_restore(&flags[0]);
+		return 0;
+	}
+
+	/* refs=1,2,3 */
+	bpf_local_irq_save(&flags[1]);
+
+	/* refs=1,2,3,4 */
+	bpf_local_irq_save(&flags[2]);
+
+	/* Now when we remove ref=2, the verifier must not break the ordering in
+	 * the refs array between 1,3,4. With an older implementation, the
+	 * verifier would swap the last element with the removed element, but to
+	 * maintain the stack property we need to use memmove.
+	 */
+	bpf_obj_drop(p);
+
+	/* Save and restore to reset active_irq_id to 3, as the ordering is now
+	 * refs=1,4,3. When restoring the linear scan will find prev_id in order
+	 * as 3 instead of 4.
+	 */
+	bpf_local_irq_save(&flags[3]);
+	bpf_local_irq_restore(&flags[3]);
+
+	/* With the incorrect implementation, we can release flags[1], flags[2],
+	 * and flags[0], i.e. in the wrong order.
+	 */
+	bpf_local_irq_restore(&flags[1]);
+	bpf_local_irq_restore(&flags[2]);
+	bpf_local_irq_restore(&flags[0]);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.5


