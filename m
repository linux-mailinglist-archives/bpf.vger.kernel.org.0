Return-Path: <bpf+bounces-45724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C5B9DAADC
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 16:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1E03167A29
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 15:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C627200128;
	Wed, 27 Nov 2024 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMcWpJaR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CE0200121
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732721600; cv=none; b=Dc5gg/+UIYqT06q/1+1Qzioiwqyi3wRD9M2FYQ9U9NhiNumYjM5FJoAqmbcFVbInQld2WrlCSR8aPGvq+yqcQf3gyBUeh21gXX815Obv/zMhikxVaXa+A+PTZTe5aKHpeuK77IOOWRIn0pcXV5jCEpUimSRcjkDKJMtF+bOkRgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732721600; c=relaxed/simple;
	bh=zosYKyJ5fhewCfyRbC/booiLawjfXHsjri1X0KLb8B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtvaX1aYCht5jsDUH00TXGzbGbzwBPJhfmGxiIBmy48mUw77Psq2NN5OfULXcD/fzRIMruEBck5qKejY28hiERbc6Kq1GkIt20WZl8IrP6EBC77NWR99737MhF7iT7vjwB5ClNyxkTV8cBdWVUFJxFC065s6BSQ3zvMgVQGuabA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMcWpJaR; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4349cc45219so35143565e9.3
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 07:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732721597; x=1733326397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rn9QSyfkaBdlANBW0DYKxSE5MgZsj7LY9XZ2/qaaPro=;
        b=ZMcWpJaRwxGU6Ba+CYDwUgKXBKT6Ed8pTTW5QS1jpKAvbNB4WWjI8D85LMvg9PYgow
         bh/f+GTt3HZtyN8y1yXCU583YSdc+8EcOp3qvzyQE5DdXdd568Q+ROY9N7hbSwyKtibF
         4fZmeeWELLi9yc5BhAtm4zXjzZTOyYxzSr9V+ZFeSP0sv3mIj4vx0rivNRLzR0aD1JpL
         gwS6S5lH1dp0kX5546JFl6i4vmrKyb7+czAhi8VBWC0CTVXq9yYuTwJ9oEdbxSVeXKgi
         5vVUYLsEcRtQz2cRd2ZcktHER2DluLqugOeFjWycorVMLfvJuS/SzFe93GwraIkqJagO
         9aug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732721597; x=1733326397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rn9QSyfkaBdlANBW0DYKxSE5MgZsj7LY9XZ2/qaaPro=;
        b=hbPP9OhP6/UJAgIjsLlZTD2tHXWLN3VT/mmU2FlVgVdvPqkTjiOe44lZNzOfQP56RK
         OotDO7CBQvztZRzYH5RgtQW7RSGaR/dAc/yoRVafdNo/Y3XxWlgOKt1p85Y/DQKlkK0f
         QPr05c9yMIXWC64ic4cL2jiwafqmB2V23JmbJr4f343Q0Ga+YLto6KDW9n6eUkV7mThX
         ugqpbVPyGfjduOzF5V4/5DB7yDIalWv3Iiyb9bR5Ueqr6bT0dEEiajX8LVXkOF7+3C1H
         Q+VrstqPpX7Jft6KSzL4QAXH1MUY62Whh5E0fNMWIvRGVaa/2L2AntiXjXNXa5F0n1R/
         oj2Q==
X-Gm-Message-State: AOJu0YyMtyA56C8ka3hBq9r7Cki5W9tLKp/vUNo6zrNPWiUtZbeLGheK
	bONNHtThAJXJgpnP6wW01RmLdJGQOYbyJanv2PRe0rDYker9zXTP8lQC2uyfnys=
X-Gm-Gg: ASbGncuK0bEqxFbiM/mqHxiGuWxC+7TPIaJ8driAI0WS4D4bHUnZgosVOJ/DS0Fp5Js
	x9SsOvnJnvCSzDQx2F7kKPMW14IH+mjh3b7jTiQnru0CZNRTfO4ZzvW8MgzNIVwAbdMZ8ltJfP6
	8xywUMQ3CWFvdn29LxiRqM3kFVrPtApL6004Wx8xGv5a7XJdsFCmIY9SFNjegEl+aF4re706AR/
	a3j2Gg8vHIXgcfkWeJvon9JGNOOG5SVEVkz2AGKr+naZ9g1JBU/+IeZHXd2qCsZpRFBIihuoHw5
	Iw==
X-Google-Smtp-Source: AGHT+IE+rxDQqXyw/hYZq/4MJHxG5IM6ztis1M/01cJHgp06PgfV5G8psWgQPML+DqXtMT8fF3roQQ==
X-Received: by 2002:a05:600c:4fc9:b0:434:a746:9c82 with SMTP id 5b1f17b1804b1-434a9dbaf67mr32367965e9.5.1732721596661;
        Wed, 27 Nov 2024 07:33:16 -0800 (PST)
Received: from localhost (fwdproxy-cln-115.fbsv.net. [2a03:2880:31ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7691b0sm24276305e9.17.2024.11.27.07.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 07:33:16 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 7/7] selftests/bpf: Add IRQ save/restore tests
Date: Wed, 27 Nov 2024 07:33:06 -0800
Message-ID: <20241127153306.1484562-8-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127153306.1484562-1-memxor@gmail.com>
References: <20241127153306.1484562-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12254; h=from:subject; bh=zosYKyJ5fhewCfyRbC/booiLawjfXHsjri1X0KLb8B8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnRztdYiplM7DeWfr+7eHg6gWMOSx3Ay6oDxlbsYQ2 DBQMpy6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0c7XQAKCRBM4MiGSL8RynsyD/ 9yKSu+VjkJ/Bje9nTd98WVAkm5eoy5DETIqVFQaXM856y7Pu3j2n44IDh7gXQVQ3tYKUSsMF24dpPa CvHFLvZz7YPhcq/T1UPzBDLr7wTc9np5qrJxQA0S6FKcGaJpr4UHT/Ed0v506J8g//vu+uZ7rHYv0I n5gfbZSKB6ym2a1gNUUfsMBCj3ujbbAVZqYrx0bZkTF4HhXj5x+P9E163QyVLqtKPCEqmshrQ9YaBM YLmCKBdYFoBp/mcO92gc6zrHOgIsjGyrL31WHfGlj0knZ2Yxo27sF0DuHtClPCdfsgRnTIDl0ouRCP t6a5KvRxFY2CkdTQnfnDanI+T5R+KlIZDS+HaG7pbx3LpT5TEWIhPClHxLeuxVSQxe0ettgMSELsTD wStnzfZaDWyvvx4didDQ9cYcyCEAXVb7LCE7kU+ZCDFs0/mJGhTMYX2YeT9d697yx7iWvoSdi60tnN nGTwdvOE4gDXhnW9aI4NZEmWlyEy0FRiWjiSDoYntLGfGU3cie2LsDU43RRTl6ksdcXVz2+kTer+8w l/lYHFRSH93zLACuusNfxAZYJESvzqd3FVU+j1iSxOTIobDNZ4Xyo8FK9yFtggpvrJGaCMr4MBcI7G I1tq6W7oWuG+N3CQY7ecIj++xgMxWFetfa9qnBH0fLc3iAI7dnsRggNDwK0A==
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
 tools/testing/selftests/bpf/progs/irq.c       | 393 ++++++++++++++++++
 2 files changed, 395 insertions(+)
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
index 000000000000..453024b59ce0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/irq.c
@@ -0,0 +1,393 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+unsigned long global_flags;
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


