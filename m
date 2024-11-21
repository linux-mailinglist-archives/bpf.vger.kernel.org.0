Return-Path: <bpf+bounces-45319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210A99D4529
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 01:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65F99B22B1C
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 00:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8677B4120B;
	Thu, 21 Nov 2024 00:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihy5vZCe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123AC1F5E6
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 00:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732150425; cv=none; b=pr53r5OTP3T8nfQYYCErUq/a9ERoWXVAhIS+qUjRDvZ2c/jWOAJHIsAeTmD3p7qIznST3Q79obDVCbQrsXDv7sNr0myfksMURiHy12h6h03MBKYCluoWosHtFsi3UQ0ViVnQR5JU+6EAGbQzx3GKmnVlipSrj5cVxCLzxdjR1tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732150425; c=relaxed/simple;
	bh=S0c8/0bmQeJ1HCT5yCpbzuDjLmHtYJDKJtDb5NbkrqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYJyKLFJGXYSPhhYJCyb4jppyTTLaxnPmKe+hclNFl9Rri4nm4Qn8J05MKZLHYQjSFzEKG3JkeBNWWOyAn5AGO5jwczzPCOiAEAXG/CEKJ8TNBmMQEY364pCmCASwcafm9iUEq8egELs4DR0K3Skl/qS3dxbIduWCr/843rN2+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihy5vZCe; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-432d9b8558aso8633215e9.0
        for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 16:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732150420; x=1732755220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckNAmfMcW6wGdRCmI/h6TZ072pLpHECQCkP4SxalKEo=;
        b=ihy5vZCeMFKQ5EgQ4QdCtI4IRniWXeESxDfoZiK8u4DbZE1rlwBKp8R3liWwrt4WA/
         u9SFA/fZk/3+XfmLG7fOZaaAz0aBO/pU3W3LBFD7gUXluZUs4yDAiW+t+EcXUtseFbID
         CMW8jnPHiTldWKlskXn6pfbBTduhG5zg4Ojclpfz6J87Bzfne9+RaF5nzZyVnlhD8BMK
         B092RsXMJf5U3d8hznyN9iCclBgU1RgLyyz60LZ6qtf4kx1Ec9QVMo9iEX+p6BBxP9NV
         u171DB0+6Lck4vPXiLomaraZ2hUhul3hemonaei0MidVzu3yHM8XR7dJciO8H/CFB1ei
         AcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732150420; x=1732755220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckNAmfMcW6wGdRCmI/h6TZ072pLpHECQCkP4SxalKEo=;
        b=ShyGtRHbuV1P/FsCKC5AkN2xYLgJrAscIhOA8odvJ74jr2r2JP3kayLHDnxjLPIo3t
         BTwIXoWkKHpeOP/uF2wd7auvI7sh4epM9tC10x9WGMDZud0a3S/4yJkoSsmG4A46Kh6N
         b+92LbzaZyDaBMVdZw1qR3OnSLcoPlKWM9ynA2yyjOsMng7qDwK5GbFqIHUIK0BQyQ4V
         wtS2y4/LInYlYGOgiSVRnZBXcBfYcenCNd+CFJJ9ZRY97Bb7A1QW4yKO2f4TiOBCnP6l
         UoJCmHocQC5nIvMzWwwCOmvJd8AEZLr/tanLGV2uN7bvCKA95inVCLXzyC8Wg0S8FPwJ
         R++A==
X-Gm-Message-State: AOJu0YzZDd0fPLafT0QWG2CSDwwQxikh34e14BCnNAysMiDMKAM/bPPI
	Gc7PvejK3Ev9XM+DAlQXe95kQA2DDZ21Nwrcy0pNyXd71Zhc35MQM34LVltRK4o=
X-Google-Smtp-Source: AGHT+IFUhboSl8/YdFY3DTsVypf2n4adF22GnPDyUs2ASOe0grWxJspshvhskflj3SoGrw8RhvdzMg==
X-Received: by 2002:a5d:6c6a:0:b0:382:442c:2c69 with SMTP id ffacd0b85a97d-38259cc0b32mr1059444f8f.2.1732150420481;
        Wed, 20 Nov 2024 16:53:40 -0800 (PST)
Received: from localhost (fwdproxy-cln-035.fbsv.net. [2a03:2880:31ff:23::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382549107a4sm3377340f8f.50.2024.11.20.16.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 16:53:39 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v1 7/7] selftests/bpf: Add IRQ save/restore tests
Date: Wed, 20 Nov 2024 16:53:29 -0800
Message-ID: <20241121005329.408873-8-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241121005329.408873-1-memxor@gmail.com>
References: <20241121005329.408873-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11715; h=from:subject; bh=S0c8/0bmQeJ1HCT5yCpbzuDjLmHtYJDKJtDb5NbkrqA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnPoQ34DF6UbxIEClklVBl8C2FceiO6z+E1Mys48qR d/Mt1LOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZz6ENwAKCRBM4MiGSL8RykX/D/ 9uGweg+dlkGNv4zghMqDrFyDe83tEq1LKcrQyjExuv3tu6+0wcQL9QnSZB8GCUSDTtUFDqMUv/xNr8 qIKAcnlA2wRsXo/t7UDu2k5d9Kjd0I6fjcSZPcjDHW8sSKn96X6E1NvIh06LHiyAx3qukOL68kRS+d 2pGEvS5O24xQyfQt6wpOIg3jZMhzdxCpvdDKyLUkJRpc+J6/s7hwbzuNoMNHKN3uDTZT3qPAS1iRUy qkiL1W8OEaP8hwmcXEDrdEvJSk6pcq4u5YFf9VXx+0q+63tVqrHvhcRh4x5EkS1LLkPmSb96s2Xduf DoL4sr6KtkO9jolS3L/wB9r20CquQO2ve4MRMYa3veJ7UDjvJqbZUdEvQb6h26DJhA4O+8+b8UGABt 5+GtOK7gDv/3uLmtZxsDgUSvck3D86+Z1PJdbrywDqPfqOgVxVvvfyrwyqby7zG/7/6G2dfuzAgx7T TfVc3oCG1km4J2ghydI2baFO6ASuR5mVvZrH6z6rtRRGlm0ADvZ/lt7uya2KmHF6HM00LasGq1o+il oZGNavCLiCP1pkAK3UlaiJpg+o6hgtJt+KbjHqGgQsGHgNCVx1c2gOoSVrOpddCKkrGXgzqxPd5U09 M1xNFRXDw5h0G7uA0LZtndL+WH2Z4m6K3xTxrj0OKwqp8bc1X7h45D8sLtFQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Include tests that check for rejection in erroneous cases, like
unbalanced IRQ-disabled counts, within and across subprogs, invalid IRQ
flag state or input to kfuncs, behavior upon overwriting IRQ saved state
on stack, interaction with sleepable kfuncs/helpers, global functions,
and out of order restore. Include some success scenarios as well to
demonstrate usage.

#123/1   irq/irq_restore_missing_1:OK
#123/2   irq/irq_restore_missing_2:OK
#123/3   irq/irq_restore_missing_3:OK
#123/4   irq/irq_restore_missing_3_minus_2:OK
#123/5   irq/irq_restore_missing_1_subprog:OK
#123/6   irq/irq_restore_missing_2_subprog:OK
#123/7   irq/irq_restore_missing_3_subprog:OK
#123/8   irq/irq_restore_missing_3_minus_2_subprog:OK
#123/9   irq/irq_balance:OK
#123/10  irq/irq_balance_n:OK
#123/11  irq/irq_balance_subprog:OK
#123/12  irq/irq_balance_n_subprog:OK
#123/13  irq/irq_global_subprog:OK
#123/14  irq/irq_restore_ooo:OK
#123/15  irq/irq_restore_ooo_3:OK
#123/16  irq/irq_restore_3_subprog:OK
#123/17  irq/irq_restore_4_subprog:OK
#123/18  irq/irq_restore_ooo_3_subprog:OK
#123/19  irq/irq_restore_invalid:OK
#123/20  irq/irq_save_invalid:OK
#123/21  irq/irq_restore_iter:OK
#123/22  irq/irq_save_iter:OK
#123/23  irq/irq_flag_overwrite:OK
#123/24  irq/irq_flag_overwrite_partial:OK
#123/25  irq/irq_sleepable_helper:OK
#123/26  irq/irq_sleepable_kfunc:OK
#123     irq:OK
Summary: 1/26 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/irq.c |   9 +
 tools/testing/selftests/bpf/progs/irq.c      | 393 +++++++++++++++++++
 2 files changed, 402 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/irq.c
 create mode 100644 tools/testing/selftests/bpf/progs/irq.c

diff --git a/tools/testing/selftests/bpf/prog_tests/irq.c b/tools/testing/selftests/bpf/prog_tests/irq.c
new file mode 100644
index 000000000000..496f4826ac37
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/irq.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <irq.skel.h>
+
+void test_irq(void)
+{
+	RUN_TESTS(irq);
+}
diff --git a/tools/testing/selftests/bpf/progs/irq.c b/tools/testing/selftests/bpf/progs/irq.c
new file mode 100644
index 000000000000..5301b66fc752
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/irq.c
@@ -0,0 +1,393 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("?tc")
+__failure __msg("BPF_EXIT instruction cannot be used inside bpf_local_irq_save-ed region")
+int irq_restore_missing_1(struct __sk_buff *ctx)
+{
+	unsigned long flags;
+
+	bpf_local_irq_save(&flags);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("BPF_EXIT instruction cannot be used inside bpf_local_irq_save-ed region")
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
+__failure __msg("BPF_EXIT instruction cannot be used inside bpf_local_irq_save-ed region")
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
+__failure __msg("BPF_EXIT instruction cannot be used inside bpf_local_irq_save-ed region")
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
+__failure __msg("BPF_EXIT instruction cannot be used inside bpf_local_irq_save-ed region")
+int irq_restore_missing_1_subprog(struct __sk_buff *ctx)
+{
+	unsigned long flags;
+
+	local_irq_save(&flags);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("BPF_EXIT instruction cannot be used inside bpf_local_irq_save-ed region")
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
+__failure __msg("BPF_EXIT instruction cannot be used inside bpf_local_irq_save-ed region")
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
+__failure __msg("BPF_EXIT instruction cannot be used inside bpf_local_irq_save-ed region")
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
+SEC("?tc")
+__success
+int irq_balance_n_subprog(struct __sk_buff *ctx)
+{
+	local_irq_balance_n();
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


