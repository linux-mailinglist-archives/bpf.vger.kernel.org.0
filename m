Return-Path: <bpf+bounces-45768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D19A09DAEFF
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 22:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53551B218AF
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 21:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5A92036FC;
	Wed, 27 Nov 2024 21:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ha+ow2Gc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D4B203712
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 21:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732743351; cv=none; b=iZWYCD44oIzyk+nCR/AgFZSRhP6nGwkoswe8ZrhvAdLvQKvBs4Fe/a+7RfyGb6z57vTCKud9ENuTaf+LpNWqbcZye/07XEjQ5yb1ZYwdLAQ+s9fZGoyFnKV5iRFWZDzy1J0Hh94874xDuuM1470kAvcNlUfCovN1NzSDWRDmvwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732743351; c=relaxed/simple;
	bh=oKNzaaFVrJSwLEjaY/JdfG+ePoPPd5PC28IvTt9EK5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzYR4qWY2ZXBUbinc7Gk3o97+wQfoRNG//DBFoJv0joSHGufL4+aLmO/J6NzrB56cE1w7yA1pGuRWwu0bcAZ2u1buKGDRLQr/essXnZJdimlhn8nYajRRJcLwa6hpJccO5jmkY01bLYWTOgKlxEgajicIDV9+Q+GuZ7tN3FEyWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ha+ow2Gc; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-434a7ee3d60so7797945e9.1
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 13:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732743347; x=1733348147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8aGK/nurJ0pFhZLLXoFWXyWjNsdaRzGcZ9s/k3JCAY=;
        b=ha+ow2GchuMDW9nLoy+pb7b/7K9U+8Ye5FVy+7kOqo5v+YDzMBTic+DS7elHzvr41l
         tUmAkS8zEtlJauhBipmDWlyrC9FLtHzyqY5Y5qAn3Ous2QfEdyoi4Haswbi0dUzrRaFE
         5MUboaoHkjLAZGCRUkjmRkyhyHmtw4RkI7KM5VM3AiXQreo/QQAGQxDylk7RJ2EBLBpE
         1ForATcVrYnuxtOizhQTczAtKUezQXRYWd7slvdP6DpBwKXFNhL+njHk2Ua892zIMKJI
         0PC6b8ROJakis+0iaIzjJ2yf7n/1LoXdYGysTYwK2GTjUfkDQyVZAPthgWJbDVQDC274
         lX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732743347; x=1733348147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8aGK/nurJ0pFhZLLXoFWXyWjNsdaRzGcZ9s/k3JCAY=;
        b=R9ZvNOakYH6ewb/2NunrRkzPERZ2UNMD19juvSHsAlo0KuyyCdU6601GQSSd+SHczs
         /OkPEJhY0865+D4xVOnVLVV8zn3ZIFqGB0fpwryOwLFDNjXgiHyPOr6XXZrlKZRstjsd
         jmqg4qSrFcg4/CApvlCP1LLLkUKeBIHY8xG1iFoUw9HtVF3eQe2FBBTWMDN7oX4W1idK
         h852UgOZk/vgsBlNrBSMxyFurMKvTQc2NPzeL4xirideSZG3sTpuJoF6RI46LgNXgqnU
         AZBabvF1kpMA6zXMyTaF5tZvnw1pQ85otHsSzDaMFMAueU5rHOh0niYyJ89lxVQ9kJIj
         uQtw==
X-Gm-Message-State: AOJu0YwA9YfePxF5ht04G93JfdYARg+tbMYRTEqVcyYwQq7Ws2vC1G66
	55RECN1OZWYalz70Yulq0+vUyLYNiDoLHz0+1v6xMo71HMA6hAGUE8XG6eV5EoU=
X-Gm-Gg: ASbGncsAUKc+tZp/hP1qahwgcSokd+MnmrE8wf52O3AOnZF4GGLyg9uZgW8sPxP6moN
	A+T2WHueBFPujOLr89aWeLLj/oHYQuI/4HiR+qdv+08fOLrZc7fXFJDtV6Ajt5JbnKv8eR1iUyw
	qt24a4TY+IMyMAAnRtjiiiKOYSEV4LiOxkYnQwraAbt8qrsE0O0n96jfFk3fEtohfRYI34V701n
	muTDxaJkdjNDDZ7eTvM899ShMeES4gQpNVA8mHqR2YRdePubLaHL8UOIKs0ALPFbtvzCu8JW+Tt
X-Google-Smtp-Source: AGHT+IGYSSa8TdhRWDzYNMr9DlbgdYiqEXaha6uVtQIj+dLiJmk06UZJNlw4ner98TWxufj7/FpijA==
X-Received: by 2002:a05:6000:1569:b0:382:4641:9854 with SMTP id ffacd0b85a97d-385cbd73618mr849403f8f.8.1732743347279;
        Wed, 27 Nov 2024 13:35:47 -0800 (PST)
Received: from localhost (fwdproxy-cln-015.fbsv.net. [2a03:2880:31ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbe91a6sm17604325f8f.86.2024.11.27.13.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 13:35:46 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 7/7] selftests/bpf: Add IRQ save/restore tests
Date: Wed, 27 Nov 2024 13:35:35 -0800
Message-ID: <20241127213535.3657472-8-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127213535.3657472-1-memxor@gmail.com>
References: <20241127213535.3657472-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12505; h=from:subject; bh=oKNzaaFVrJSwLEjaY/JdfG+ePoPPd5PC28IvTt9EK5A=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR46u+Fa3OBgf44+T2tWcV8lK44O9pee3XLaltCWF GTepBNSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0eOrgAKCRBM4MiGSL8RynM0D/ 9ZnPjbU6kRbO55GoDSms6sIHqb++4FvspNtUfElpG3uTT/vDtohp+yJRUKiNBQnd5oc2PN0oz47p0L KD4nQ3aZLKe7E68BlCIbp5Q9pRyPwGMRLiXAlzV+tk3ExcZCu+Kpp9a25o8pSdBtd48tq3vl6KfgO4 FCWpsy0BK08ae8QnfN+4VkzILX5kW1+Ic9ndGC+KgFcR+HZGJWbBjiZ97jBQNKIVE5tm8TfUbWQcbU ehBZnjTXv/+v8Vx74NkCksPTfgoi3MFYrJpuwu1PFuDBKSs/F9kz3C2fSFluLqyZHtWfmJzFl2QaFv 0NEciCqIraHIHqzbCYXyyH8fbkg1BFka1k1Yt4uGmDgCoXw8gTNAYjBt100AVefT2yfQhcnxbr9N60 DoxC+Tt/pDsQlrNBtEPPFKKDrOrHbBZoG6JDur0DPN0nStldytd7Tm5D6jrtiPk3IvTMxmd/F2ooSi prkjMO2qgbbQ9asDcH0DYMRzt9o3yceyYIir1dJL/NxbszXkgNcIiJtdJHzUEGWms4K5sg31XPL/Yj T/voymPNrNDdH1fdH8pozUGSEptBfDPvUamrBaCZdZCtIoSy+43ou84gQ1ILQ1X2zDSSx3BD0GEZRe NJG4Vlma+7itcB+XAfqKp14f4WhgT5xsR1InPK7d+EgTMJdp+cDGZO9nXLkg==
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
#128/25  irq/irq_sleepable_helper:OK
#128/26  irq/irq_sleepable_kfunc:OK
#128     irq:OK
Summary: 1/26 PASSED, 0 SKIPPED, 0 FAILED

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/irq.c       | 397 ++++++++++++++++++
 2 files changed, 399 insertions(+)
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
index 000000000000..b5056ac17384
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/irq.c
@@ -0,0 +1,397 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
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
+char _license[] SEC("license") = "GPL";
-- 
2.43.5


