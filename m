Return-Path: <bpf+bounces-37229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 485DC952661
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 01:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C02C1C21A36
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 23:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941FC14F13E;
	Wed, 14 Aug 2024 23:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OORHX8CY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46BF14900E
	for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 23:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723679905; cv=none; b=Ru51yf2Zc6O/jLtZmh3ugr5DTKGEW1DgLxLfNbzKT8S8bkF4A3G/7pTCj3t8Z6TsHslLG3OMkA9yYaYlqptGy9zbCYffL4ggTTyR+WKEorJWTqqL7NBBl4z5zqDZ+a4b7I2innsYXJ9sZLyfzVDgUTaVnUzooDnnu80W/c31Nhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723679905; c=relaxed/simple;
	bh=jQVq3+JODnwQq+1vCUCouWsaExJWOQU+qoJGU59S+HE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dk69mJd9xtaqXgaNW/ict4KX/YUna5XDEbIGHQ2T9rjNSflOa/JdOir6qUwV+wypOMjOZ7puF1mWYEjhEJgqBCBbNVbRlnNxXMqmW+0V/XEQXY7cs3D76F28I9jfg+fCcQwV2suzQvqk/814fX3lldjzVMASvSA3dOwGEA/uNEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OORHX8CY; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7105043330aso355069b3a.0
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 16:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723679903; x=1724284703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JOjB6qYi8GFcmeLMpnH15K96KfMPCaC+ZzbKMjqCJMo=;
        b=OORHX8CYFFULMMjkvcX/i0zfJMFDg6h5LMgIWp/vAfA/2adwhzSFru92cOUdiqhW/2
         EmYCMrnE3zV2aa6sQ60byXHZfLSUs4H/olt7JvPH+ShsxYYreuUg884IKM3EyEhmm20T
         RsSSLSTEONgBSWb3aMkFBVmsy7S5VHZD64ZI/gjVstuUGP+Y/oacJCX/mD8X7P+I0QNw
         wqRs88KQ8jIPefoTSPzqeKclcNKXc8Vxu26fJ/WHkiepxUj0q0E4FrVaLtbrJmHIWzIa
         kKzSnpbYSDXUmBMSAFnLZnITdj8DLJPu6sX9/QpC3zO9+xRG0Gmrlkr8fV3xs8wAgVtI
         A7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723679903; x=1724284703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOjB6qYi8GFcmeLMpnH15K96KfMPCaC+ZzbKMjqCJMo=;
        b=WxZhHmkmg1GXEpLC1l5SvAozYZddGNEfSJ2mSS0Rn++WQ+ZOz2PvI0k33xjSfim3DO
         0dLBQWAIDJ6RsLaCPWFfPMLPJqEStko2+ndxL1XT+l3jVvoxirVj9xVreU06kQ96WAcH
         1R3ZkGFNzmDZ+60NAGdQnEcQV2pxpY0KT/1LVCKWh6qVOtebwLXpXsOl0GSJc+lmjktq
         RdmwI9My3dm7R2pt7fYH3bM5z0FNsZ//L9INXeKZSTe7cWJxGfyrEVN41Z2lLoJHNVt1
         SMKEuDhWUUYs3lvQ5Ba343u4uVCGF62VYEV1NXbgBbzhOdGV2Kmv+y+BJH0owyIq5Ik3
         DOkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbwo+8manBGEKQLqx8wzLvhDhVaYG7jstEh3gfT9f+9nCNHPtgMzcbnD58KSBbDGqQMCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhT/PLALzwiHQ4euyeyRAp76ruqJyTajrtIc4fmCW236x9t44E
	5IJhazI34nCUEWnlDfNQMv4ncx4vn7EZMp5WMvzjPx71Ga8ruRFX
X-Google-Smtp-Source: AGHT+IEiJtSZHUID81oZSYuyf6kSTlATV8sJw6m6HQ6JzYoGmglZl5UyN6ZA/CMCV+6oeusTWVKp0Q==
X-Received: by 2002:a05:6a20:c91b:b0:1c6:ba9c:5d7b with SMTP id adf61e73a8af0-1c8eaeaf7b7mr5820527637.23.1723679902904;
        Wed, 14 Aug 2024 16:58:22 -0700 (PDT)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef5229sm127264b3a.107.2024.08.14.16.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 16:58:22 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: andrii@kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf/selftests: coverage for calling kfuncs within tracepoint
Date: Wed, 14 Aug 2024 16:57:59 -0700
Message-ID: <20240814235800.15253-2-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814235800.15253-1-inwardvessel@gmail.com>
References: <20240814235800.15253-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test exposes the issue of being unable to call kfuncs within a
normal tracepoint program. The program will be rejected by the verifier
as not allowed.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 .../selftests/bpf/prog_tests/kfunc_in_tp.c    | 34 ++++++++++++++++++
 .../selftests/bpf/progs/test_kfunc_in_tp.c    | 35 +++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kfunc_in_tp.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_kfunc_in_tp.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_in_tp.c b/tools/testing/selftests/bpf/prog_tests/kfunc_in_tp.c
new file mode 100644
index 000000000000..bef1d192fc00
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_in_tp.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <errno.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include "test_kfunc_in_tp.skel.h"
+#include "test_progs.h"
+
+static void run_tp(void)
+{
+	(void)syscall(__NR_getpid);
+}
+
+void test_kfunc_in_tp(void)
+{
+	struct test_kfunc_in_tp *skel;
+	int err;
+
+	skel = test_kfunc_in_tp__open();
+	ASSERT_OK_PTR(skel, "test_kfunc_in_tp__open");
+
+	err = test_kfunc_in_tp__load(skel);
+	ASSERT_OK(err, "test_kfunc_in_tp__load");
+
+	err = test_kfunc_in_tp__attach(skel);
+	ASSERT_OK(err, "test_kfunc_in_tp__attach");
+
+	run_tp();
+	ASSERT_OK(skel->data->result, "complete");
+
+	test_kfunc_in_tp__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_in_tp.c b/tools/testing/selftests/bpf/progs/test_kfunc_in_tp.c
new file mode 100644
index 000000000000..5a3f1ff930af
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_kfunc_in_tp.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+extern struct bpf_cpumask *bpf_cpumask_create(void) __ksym;
+extern void bpf_cpumask_set_cpu(u32 cpu, struct bpf_cpumask *cpumask) __ksym;
+extern bool bpf_cpumask_test_cpu(u32 cpu, const struct cpumask *cpumask) __ksym;
+extern void bpf_cpumask_release(struct bpf_cpumask *cpumask) __ksym;
+
+int result = -1;
+
+/* call arbitrary kfuncs within a tracepoint program */
+SEC("tp/syscalls/sys_enter_getpid")
+int handle_tp(struct trace_event_raw_ipi_send_cpumask *ctx)
+{
+	struct bpf_cpumask *cpumask;
+	const u32 cpu = bpf_get_smp_processor_id();
+
+	cpumask = bpf_cpumask_create();
+	if (!cpumask)
+		return 0;
+
+	bpf_cpumask_set_cpu(cpu, cpumask);
+	if (bpf_cpumask_test_cpu(cpu, (struct cpumask *)cpumask))
+		bpf_printk("match\n");
+
+	bpf_cpumask_release(cpumask);
+	result = 0;
+
+	return 0;
+}
-- 
2.46.0


