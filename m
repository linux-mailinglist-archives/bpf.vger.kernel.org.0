Return-Path: <bpf+bounces-52108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C12A3E750
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 23:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8CD17A9F99
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 22:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0CA1EEA23;
	Thu, 20 Feb 2025 22:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="La2Y5EqS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11F11EB9ED
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 22:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740089745; cv=none; b=TxOTk95FlkrZhDeb+i9/75JJEr1dcd3i0WXLwhR7w//RmgJcLyTLYlBKPIxshkf4txhzlDL7K0yAvx+ZMYQNaBOydBZ/hdr1PDj6sVNV1StEOiXdaELy1LOzkWbLaBxuZa+eJSRQYf0G381jO5VB2ATk7I2AuwNc9BzkxFdHWnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740089745; c=relaxed/simple;
	bh=D3amauyLaaZw/EoRfPBN+QHv39Kf9g2r4RygCwuhtmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjt36TQqk/DyDQTyQdJyhOtbINIjVLWRvEy0xcudtkI3hQlzsXeETQyA7BcgwbheKAHlnL+ATvbKzLx7lZZEKFPDLNuI/tFR0p+kDDr13SxPuLnmthZeHhpUI6XRJXEhkAoggNYAraJJEX+Sfzs55VfxrePMLL8FxNUNf5hxt0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=La2Y5EqS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-221206dbd7eso28968985ad.2
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 14:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740089743; x=1740694543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13YlboN/hEjGLL5hNA6CwAwrc5jCiPOW2r8f54Ki1Ys=;
        b=La2Y5EqSA6tMNLznXdq664HzGkzutzJ+2Ost2Oij4Xjkr3vpk3SpHe6w6fbqmMK3xy
         qR6rbo5XrJ+96RYbd8F7wiisWqZAcczUQPkJIbOnV38aYAhqW5k5Ktw9S9ulVZKQ302Y
         PKUMKxhCh0VjvDOxOvWswWf7SSyXYalBOo5CRk5Osc3h0cz/pJcMHMmH60SSpaTRJ8oB
         eYx2tebV9YCr0mLcVHNtdwHLzfMapNyTLxzJitdMtlkCoGpzF8LMFZaY3Vm0a0JG6F+a
         z61HKuPOgS+9eemg5cWlzZmBOMoIOVL6tsQ0gwPiSpJGQ5BQ3sA7bM4uVSBJeQkxNi7W
         ICjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740089743; x=1740694543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13YlboN/hEjGLL5hNA6CwAwrc5jCiPOW2r8f54Ki1Ys=;
        b=VZeaFRSI9T/3BDvyxbjDgRlLOIDK2Z2q+1KU9XO++zBn6kOx9AiFmkIhyVzzzMAE+S
         46QUXzeDbNP0O2vgWWzwTJcAiUw9EgSm7gpbtqwdOm6PHqOKiHNslO9zV9jn1UPub7TT
         UxsUpH09SxMf3ewFVuHXaNxDh52rXdG0DjIVwh/ZxZj+IjelvP0Ypwi+FcGdKEL/iu1Y
         ujob7iRu4U3eN6jY6EMTyaCCywOktULTrTarbVFib9GljJRvoROWpptt+TqoEDRHMsQQ
         VIoXNRxYvGXoMcIJmHpoiCD4beiPZUlIKRIl7fV13gSa8onkpjfJdNH7lBTv8JqfxKDt
         HqJA==
X-Gm-Message-State: AOJu0YxHKpuR6uMYRAZzvtEp3oCY8lr+TR+7e9lb+kZf4P7yfQiJCnT4
	ZoHZfhFkDwm9xPoMMlxZ34/vt2arYWqLePSGYN9vkAbkErBweWCiADVH+Q==
X-Gm-Gg: ASbGncs5MuWaZn3PwGIRdG9dlGNcp6SqOx8qKbE17HV+Z+P7lSHshS9w9D1aPqY6tRX
	GLwW7xuu9VoWZyCGGWPAc35Tce8Qs4SGRQxVCthPxYmtaBXWWoNwPwcZV6KJaFa+jAZL0Y/pStz
	x6cags981fzWNKihSfttLrck1NbqA/PRGZp11+Nx6uiC5Vb7A5fw1B5RyVGgVP8iizOZnwLMJPX
	Y2ppu8Hi7kRdWCm9o3IxfaY2/2eeNcL1IzWXRx4zmd3AbGII+j2rtA8EFYDMtvIHsB//OOSI7V6
	6q40a+UXilpYU0qukPP3W40XmoCDvuWXb4c8jxWll0norc00f6RbRfTLqIAsTRn9TQ==
X-Google-Smtp-Source: AGHT+IF3/ZugQldXCiLTdC/2OoybSVxy3yIJW7iqSO1fYUR+wY4vaSp3QPk0LXTesBAghsQLFXbQHA==
X-Received: by 2002:a05:6a20:2589:b0:1ee:cab3:4278 with SMTP id adf61e73a8af0-1eef3d8d2edmr1541935637.32.1740089742701;
        Thu, 20 Feb 2025 14:15:42 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732425467adsm14852251b3a.15.2025.02.20.14.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 14:15:42 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Test struct_ops program with __ref arg calling bpf_tail_call
Date: Thu, 20 Feb 2025 14:15:32 -0800
Message-ID: <20250220221532.1079331-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250220221532.1079331-1-ameryhung@gmail.com>
References: <20250220221532.1079331-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test if the verifier rejects struct_ops program with __ref argument
calling bpf_tail_call().

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../prog_tests/test_struct_ops_refcounted.c   |  2 ++
 .../struct_ops_refcounted_fail__tail_call.c   | 36 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  1 +
 3 files changed, 39 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__tail_call.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c
index e290a2f6db95..da60c715fc59 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c
@@ -3,10 +3,12 @@
 #include "struct_ops_refcounted.skel.h"
 #include "struct_ops_refcounted_fail__ref_leak.skel.h"
 #include "struct_ops_refcounted_fail__global_subprog.skel.h"
+#include "struct_ops_refcounted_fail__tail_call.skel.h"
 
 void test_struct_ops_refcounted(void)
 {
 	RUN_TESTS(struct_ops_refcounted);
 	RUN_TESTS(struct_ops_refcounted_fail__ref_leak);
 	RUN_TESTS(struct_ops_refcounted_fail__global_subprog);
+	RUN_TESTS(struct_ops_refcounted_fail__tail_call);
 }
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__tail_call.c b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__tail_call.c
new file mode 100644
index 000000000000..3b125025a1f2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__tail_call.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/bpf_testmod.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} prog_array SEC(".maps");
+
+/* Test that the verifier rejects a program with referenced kptr arguments
+ * that tail call
+ */
+SEC("struct_ops/test_refcounted")
+__failure __msg("program with __ref argument cannot tail call")
+int refcounted_fail__tail_call(unsigned long long *ctx)
+{
+	struct task_struct *task = (struct task_struct *)ctx[1];
+
+	bpf_task_release(task);
+	bpf_tail_call(ctx, &prog_array, 0);
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_ref_acquire = {
+	.test_refcounted = (void *)refcounted_fail__tail_call,
+};
+
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 89dc502de9d4..578bfc40dd05 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1130,6 +1130,7 @@ static const struct btf_kfunc_id_set bpf_testmod_kfunc_set = {
 };
 
 static const struct bpf_verifier_ops bpf_testmod_verifier_ops = {
+	.get_func_proto	 = bpf_base_func_proto,
 	.is_valid_access = bpf_testmod_ops_is_valid_access,
 };
 
-- 
2.47.1


