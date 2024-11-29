Return-Path: <bpf+bounces-45852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 016A09DBE35
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 01:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC1E28253C
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 00:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B0AAD27;
	Fri, 29 Nov 2024 00:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhdSkkgU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A405D168DA
	for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 00:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732839407; cv=none; b=s4TnUdqkKu46UkBZsphAYcOW/eS4Xt0UTZrJOZIzkOBdsS4OlPVbWDUFI7eoBgapKo9vsEBjZUxCOcw0AX5JyPcmlYMZe+TS6FJ8U9nAeXCDkQTsIEiOAwE+03DPvFQvAqz45UC+yzcxS/sAWA/d0lgQjcPqaOpx9bgU6wr+zRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732839407; c=relaxed/simple;
	bh=ehi26WvLtHDNqOg9c0fi4JyDWWJM2Ix5M04x2JY8xbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qDAz8Ma9To5ZkLWQxHHlJM02GsoloIrYctHt9/WrbFtYGGJJpnuPjPEmvrLVzDinAcjIpVJ/Crus7stgRg1jt9AUhupH7XOsNOLgBegwIC4HuCcNHZkOqFVgNrdsRFYGZ5D9pU+Tw5f3z/H5M/YytzSeFjHD3gbZcHojXuJFubU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhdSkkgU; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3824446d2bcso1154699f8f.2
        for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 16:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732839404; x=1733444204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWQu++WV789z3AsgN8NSsS0Hi3vDX++q+Q3xLlXGnZo=;
        b=DhdSkkgUj90gLQ94/tFIUiyDMeDzNnftTOmeXHcwts/mI0XCaULhC8j6VhoD6oQ2if
         gIfaErIuSbFN/KGIHUOU5UlnUxtqJKaLGBovW6L6cT3fDdm3jf/PLg2oAAROGUdoc+yN
         jKIH3mnByRDF9v1gSAf6KcRL83ZHBBrY5cUI25zQ7xzG81mCm5gx+7wnNbAmlehj6D92
         Sq4d1031ojLBUQ4FtXFE2bXhEtJzkcYhoTjj7CoHzqwxcUdCB7iOL6qxaeoXGFrfo2df
         Y6JLooTFQP/g5lvRnr2pFjzJGXZTOD5KB9tFuWbKo+9g0XDY3A6EDjeNjW8mXhRYLvcc
         bg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732839404; x=1733444204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWQu++WV789z3AsgN8NSsS0Hi3vDX++q+Q3xLlXGnZo=;
        b=sSwtMza4nYmAwciVsNHbBhZx53qf1ZRJJHqdJiyKKLCRNVTdjSkAHsSkvQm9y+cPVz
         NvU3+Wd7AxCpCrxtalSOZwEOx3pkyXNUphRICihYazFr8TOSTXIBEVmJZ3/CNQMLePjf
         EY+GEFAXyxVzvN8NoIE/whsgqZk+5YI2InktbzFhoi5oh4S/HGesBfW6xS5a5upzy3iH
         58sQ3rtFx7zpGZijh8AS0uBkQbX2L969ed0eq9l9B1ISHoAkP91/f7d9Q5lgNEtbP4QF
         qorzZhEB+JoQZ4VIA0xtmYcXYo4Ze4Ovsh6nb/Qqg6vb5sff2vV1wBlDreAjpKE+c/oa
         ZI/Q==
X-Gm-Message-State: AOJu0YzfvYcMxvYxpKqoB7fQFK/TWVGl6tv5v/8jwS4BE5qrRVT+rzpU
	RRuPXrWaewbAgDMZJdds0gvS7KDFKHdxvrpnheorXtLfVRYGBL8+bEyiY0G4ibE=
X-Gm-Gg: ASbGncvIqeEiLCySo64sIDOoDTsT3R/Z3aVqQwhpWF2367vYJ7tpfxVnT6BYAq7GV0u
	gYp7io01kFPcu2Vg/d0imfHlHPJoqWDkbV4Kn/9UP6UO+qs4WV+rz4RFh/1zy+kfQ3NXfZlHk7q
	hDfYB0uwWvGPuk3fHB4j50SDNtjO3s0nqNF6+NzN6Ml/tSIGnBZEoYsFMJ3QrZHOnRUK9oPz/M7
	j/PAgoxBxjz/OGHlrTf2SE6a4HsTRJL+P3S9xLe98LylRLfqdgD+lo4cLZL4iGDkMSR7vqr78wD
X-Google-Smtp-Source: AGHT+IFAeikL3k5cZAeRIdIFUozsebmo361vKYpC8pr5rQCXNvxysv54h94yQBfijc1xVa21fQzjCA==
X-Received: by 2002:a5d:64e8:0:b0:382:4849:d5c8 with SMTP id ffacd0b85a97d-385c6ebb95fmr8851045f8f.31.1732839403748;
        Thu, 28 Nov 2024 16:16:43 -0800 (PST)
Received: from localhost (fwdproxy-cln-005.fbsv.net. [2a03:2880:31ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd2db43sm2926880f8f.7.2024.11.28.16.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 16:16:43 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 7/7] selftests/bpf: Add IRQ save/restore tests
Date: Thu, 28 Nov 2024 16:16:32 -0800
Message-ID: <20241129001632.3828611-8-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241129001632.3828611-1-memxor@gmail.com>
References: <20241129001632.3828611-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13870; h=from:subject; bh=ehi26WvLtHDNqOg9c0fi4JyDWWJM2Ix5M04x2JY8xbA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnSQfcYvrbONJqwMsuBYoSS+qi19jI1kCZNnhDwUpT BCp423iJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0kH3AAKCRBM4MiGSL8RyioDEA C7QQDjbCXfhbHzTR6g15SXZHYhr3wRJ/wNiqgLvF6079Yeo5q9Od0ki5lxXLbmHi/sMaTrNrczn3HZ 8iSW0Ih+htRh9WO3jx+zbRN0Jw4uIyCXBtUYvCwG7Xqu22Lwdy02+pINAyp4hdg7bwo2hs76l1FnRS VPtlKTJLnMfMDVWQuHoMyI+RBG7AN3YP55GCtv50MnEOT1jFz+Tc5tEYaoIXliF4JLjpVA5PCbCVJ7 pU72ReDgM8XZP94v1BhnR5hEGIjZN+kJ7iAUgTcVrXqb/6AlhYYuQQTbGvFe03hOAr/Qd1s+bnPp3i utY6Z8pL8ttXDzpgpT1vRJpGP2O9QuAUlUmjNQs2a/mYMvVVeVsQB0Cs14z17YunVJ740cIqFx8TDu 3JykAj0rz00uPbglACpJLxhSzZIdztto3LqWhlq5MlBZqZqeFIUPd6FJ3y5MSEYigYEfTirsyBHO5j LWEoKiItsckjbeqAx9o4eXsZ8jVniTw7YLsZjpJUDftq2+SaIoC1eiJ5FsXeyVrg2vSzGoxXnU6adX TgN8vqRqQaK77w5OLhqmmDxcvWvUMjztIxP7Z2mQIR/+2PMWVTPHmD5zbay33mfGnHDh/EkuYnRVk2 3psitrM9f0frne302/ZnLYxCK9CHM/41BzUy+PhG+B0QXgy926FdECCR+GCQ==
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


