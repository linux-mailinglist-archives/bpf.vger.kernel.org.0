Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2991401EA6
	for <lists+bpf@lfdr.de>; Mon,  6 Sep 2021 18:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343709AbhIFQrh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Sep 2021 12:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244385AbhIFQpN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Sep 2021 12:45:13 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7BEC061575
        for <bpf@vger.kernel.org>; Mon,  6 Sep 2021 09:44:07 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q26so9724987wrc.7
        for <bpf@vger.kernel.org>; Mon, 06 Sep 2021 09:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rIB3XyAtA7T8X8c0T8azumVCg5vSMcsHdXTVtyJWxT8=;
        b=lQp51m5rWPSBn83DGTZq8v+/+DxQJwpbUe8AFQg99s8K4u51qgkCOWPxfV5V/1dnW+
         R0MQ/bNjVqk9kCWzIzVivSrKG54BwLVLFsjShL4MwPtXaPZbZXUyrZjurVbXMojPs3MI
         3JYxg9g2zLcpPph5H4lNYcjE3Lp4niLEAaLmlmMGvSV4RpsI9oALgrGFvkXVX9A85bTw
         RYd5vftmWScHIjxJkz5dh1fn8om5duKh9fAtNgbuKpwnZYz3IpixjjYrUTEtxfqOAqHR
         TRSX6OVcJEZ/wwP7luHg9QXQ0awKA3RQG2F3zrIVDSvhfkVEEaIPBASmvp0dYuSlJfrR
         LtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rIB3XyAtA7T8X8c0T8azumVCg5vSMcsHdXTVtyJWxT8=;
        b=E/e5k3rPjRfQSAbL081pfRmXWA1S+8s+zuNdqyQs9GCtdKce3j55Dk84Sy2uuZmaKv
         KL3VEtLqBJSB6DLabkc0Yz43Z3tD2wkuGJalRkv3l9eglLi/hjHQeQh8Rc8+LvC45pTJ
         tzXGrF3JO48BoFD91Pw50/WawQALz74/CgaSQd9RROKrbKU7GE9alV88gbjlL/l7XhJq
         NQTxkkjXSEsaHdq+Jqf2jPuSqr07bYSP+mTpooLE0JkC+QncQYkF79Re6hHq6zojc1i+
         o+Z66wgz+qz9JOtBVOfHQW/r0dA/7NbU6OT06a+2WRegqExOP3kWrPUFbGncgQNLaTOQ
         r/bg==
X-Gm-Message-State: AOAM533snqdqvAXV6m0V+RzFK++DcYe/ZoOF2pd5Jc/Ctg1AAW4r+oXD
        dUm97d8DHnjlVGhdCTuRQR5fjg==
X-Google-Smtp-Source: ABdhPJzPLtOEcLvQYtdvPeOrW+1L7b3taVNWuLYP4bksfvruBczObd3e2lz+VdPzkeEFBJJ/KRnsKw==
X-Received: by 2002:adf:c402:: with SMTP id v2mr14373341wrf.130.1630946646491;
        Mon, 06 Sep 2021 09:44:06 -0700 (PDT)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id g3sm7955975wrh.94.2021.09.06.09.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 09:44:06 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, dxu@dxuuu.xyz,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next v2] selftests/bpf: Fix build of task_pt_regs test for arm64
Date:   Mon,  6 Sep 2021 17:36:38 +0100
Message-Id: <20210906163635.302307-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

struct pt_regs is not exported to userspace on all archs. arm64 and s390
export "user_pt_regs" instead, which causes build failure at the moment:

  progs/test_task_pt_regs.c:8:16: error: variable has incomplete type 'struct pt_regs'
  struct pt_regs current_regs = {};

Instead of using pt_regs from ptrace.h, use the larger kernel struct
from vmlinux.h directly. Since the test runner task_pt_regs.c does not
have access to the kernel struct definition, copy it into a char array.

Fixes: 576d47bb1a92 ("bpf: selftests: Add bpf_task_pt_regs() selftest")
Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v2: Work on struct pt_regs from vmlinux.h
v1: https://lore.kernel.org/bpf/20210902090925.2010528-1-jean-philippe@linaro.org/
---
 .../selftests/bpf/prog_tests/task_pt_regs.c   |  1 -
 .../selftests/bpf/progs/test_task_pt_regs.c   | 19 +++++++++++++------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c b/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
index 53f0e0fa1a53..37c20b5ffa70 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE
 #include <test_progs.h>
-#include <linux/ptrace.h>
 #include "test_task_pt_regs.skel.h"
 
 void test_task_pt_regs(void)
diff --git a/tools/testing/selftests/bpf/progs/test_task_pt_regs.c b/tools/testing/selftests/bpf/progs/test_task_pt_regs.c
index 6c059f1cfa1b..e6cb09259408 100644
--- a/tools/testing/selftests/bpf/progs/test_task_pt_regs.c
+++ b/tools/testing/selftests/bpf/progs/test_task_pt_regs.c
@@ -1,12 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <linux/ptrace.h>
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
-struct pt_regs current_regs = {};
-struct pt_regs ctx_regs = {};
+#define PT_REGS_SIZE sizeof(struct pt_regs)
+
+/*
+ * The kernel struct pt_regs isn't exported in its entirety to userspace.
+ * Pass it as an array to task_pt_regs.c
+ */
+char current_regs[PT_REGS_SIZE] = {};
+char ctx_regs[PT_REGS_SIZE] = {};
 int uprobe_res = 0;
 
 SEC("uprobe/trigger_func")
@@ -17,8 +22,10 @@ int handle_uprobe(struct pt_regs *ctx)
 
 	current = bpf_get_current_task_btf();
 	regs = (struct pt_regs *) bpf_task_pt_regs(current);
-	__builtin_memcpy(&current_regs, regs, sizeof(*regs));
-	__builtin_memcpy(&ctx_regs, ctx, sizeof(*ctx));
+	if (bpf_probe_read_kernel(current_regs, PT_REGS_SIZE, regs))
+		return 0;
+	if (bpf_probe_read_kernel(ctx_regs, PT_REGS_SIZE, ctx))
+		return 0;
 
 	/* Prove that uprobe was run */
 	uprobe_res = 1;
-- 
2.33.0

