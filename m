Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D28301E8D
	for <lists+bpf@lfdr.de>; Sun, 24 Jan 2021 20:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbhAXTvu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Jan 2021 14:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbhAXTvs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Jan 2021 14:51:48 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AFAC061786
        for <bpf@vger.kernel.org>; Sun, 24 Jan 2021 11:50:52 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id l27so141859qki.9
        for <bpf@vger.kernel.org>; Sun, 24 Jan 2021 11:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f1Y1N/1faPm4cNswBuQLRgDFTLjm2SMTRzmaI71sPzA=;
        b=qTILS55e8c0e/0auw3jBjz5NPVrvsBc5nFuROwZE01aeva957rz05FkvVyhTb4tvT/
         ohui8QFnC3oUjun8HBT3i19v75cA5RM5sPKufDORRb0smvxfYXZ9PJTfViAQ7Lhsinx6
         520ZJyao5eZkU2nd8sSEqZSPkicJugt+PleZMnlWWb+OpEsUTBTaUZxRB8kPEokoxaiB
         S6zK17KWzsG8bZGwkktJ8W6qnEwOU6rbmcQNS3juT3Yc2kor9JhSPugA5xmpACyOLaGb
         muyTlR6w6sprDTxGZMBhLZkODi4awZ+ZrjEs6oQ9GbuaWrL0WdnOdOFy9VWlg5FhSz8Q
         sbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f1Y1N/1faPm4cNswBuQLRgDFTLjm2SMTRzmaI71sPzA=;
        b=mqxHOevwvP09BYLj9l0W5zPQ6d9RhUXmrYkCDlZkwZEIcHoUviFBVuNxruJkDoIe/b
         vI7a/2/R9VC3scqmFgDnPO0YHdCHNALq5LFhZc5o7VW7Q32Kvmc2ds2h7A9gcpr6697f
         cU7YzdwTMdYQ3nNNCowjqZMwsYlzmMq39gQDdm8GLa06zDvfdlicdqnnV0qqpyYYGaLt
         8DX4Upg4WGG7Jq8jhe07WhEPUFkV33/ap1q8vwLOWOwpMUHRgc9iCNFUVILO5JKzFGuf
         +/GmF+oWV17kzwi8pvvhoGvHZG47xR5EwSKT5DKosDfX5nD6EeFHF+Xx4LADn5YXR4fE
         BybQ==
X-Gm-Message-State: AOAM531iboVRFJtZRNpVMK50a+qdWLa8/XpGXTOGet+NeYO1MONNIZsz
        cdCjeTxsI+IILa3UhA3YdySEkds6oMCzaw==
X-Google-Smtp-Source: ABdhPJyZzoUBf27fnfunUiw1a2x1qgZvrIPdcv2lTD883szB4ochlhJ0oNi9RqL1hrpJ0LoMWxUzwQ==
X-Received: by 2002:a37:67d4:: with SMTP id b203mr1393027qkc.483.1611517851661;
        Sun, 24 Jan 2021 11:50:51 -0800 (PST)
Received: from localhost (pool-96-239-57-246.nycmny.fios.verizon.net. [96.239.57.246])
        by smtp.gmail.com with ESMTPSA id c62sm10308249qkf.34.2021.01.24.11.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 11:50:51 -0800 (PST)
From:   Andrei Matei <andreimatei1@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next v2 5/5] selftest/bpf: add test for var-offset stack access
Date:   Sun, 24 Jan 2021 14:49:09 -0500
Message-Id: <20210124194909.453844-6-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210124194909.453844-1-andreimatei1@gmail.com>
References: <20210124194909.453844-1-andreimatei1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a higher-level test (C BPF program) for the new functionality -
variable access stack reads and writes.

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 .../selftests/bpf/prog_tests/stack_var_off.c  | 56 +++++++++++++++++++
 .../selftests/bpf/progs/test_stack_var_off.c  | 43 ++++++++++++++
 2 files changed, 99 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stack_var_off.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_stack_var_off.c

diff --git a/tools/testing/selftests/bpf/prog_tests/stack_var_off.c b/tools/testing/selftests/bpf/prog_tests/stack_var_off.c
new file mode 100644
index 000000000000..c4c47fb0f0af
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/stack_var_off.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "test_stack_var_off.skel.h"
+
+int dummy;
+
+noinline void uprobed_function(char *s, int len)
+{
+	/* Do something to keep the compiler from removing the function.
+	 */
+	dummy++;
+}
+
+void test_stack_var_off(void)
+{
+	int duration = 0;
+	struct bpf_link *uprobe_link;
+	struct test_stack_var_off *skel;
+	size_t uprobe_offset;
+	ssize_t base_addr;
+	char s[100];
+
+	base_addr = get_base_addr();
+	if (CHECK(base_addr < 0, "get_base_addr",
+		  "failed to find base addr: %zd", base_addr))
+		return;
+	uprobe_offset = (size_t)&uprobed_function - base_addr;
+
+	skel = test_stack_var_off__open_and_load();
+	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
+		return;
+	if (CHECK(!skel->bss, "check_bss", ".bss wasn't mmap()-ed\n"))
+		goto cleanup;
+
+	uprobe_link = bpf_program__attach_uprobe(skel->progs.uprobe,
+						 false /* retprobe */,
+						 0 /* self pid */,
+						 "/proc/self/exe",
+						 uprobe_offset);
+	if (CHECK(IS_ERR(uprobe_link), "attach_uprobe",
+		  "err %ld\n", PTR_ERR(uprobe_link)))
+		goto cleanup;
+	skel->links.uprobe = uprobe_link;
+
+	/* trigger uprobe */
+	s[0] = 1;
+	s[1] = 10;
+	uprobed_function(&s[0], 2);
+
+	if (CHECK(skel->bss->uprobe_res != 10, "check_uprobe_res",
+		  "wrong uprobe res: %d\n", skel->bss->uprobe_res))
+		goto cleanup;
+
+cleanup:
+	test_stack_var_off__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_stack_var_off.c b/tools/testing/selftests/bpf/progs/test_stack_var_off.c
new file mode 100644
index 000000000000..44f982684541
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_stack_var_off.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017 Facebook
+
+#include <linux/ptrace.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+int uprobe_res;
+
+SEC("uprobe/func")
+int BPF_KPROBE(uprobe, char *s, int len)
+{
+	/* This BPF program performs variable-offset reads and writes on a
+	 * stack-allocated buffer.
+	 */
+	char buf[16];
+	unsigned long idx;
+	char out;
+
+	/* Zero-out the buffer so we can read anywhere inside it. */
+	__builtin_memset(&buf, 0, 16);
+	/* Copy the contents of s from user-space. */
+	len &= 0xf;
+	if (bpf_probe_read_user(&buf, len, s)) {
+		bpf_printk("error reading user mem\n");
+		return 1;
+	}
+	/* Index into the buffer at an unknown offset that comes from the
+	 * buffer itself. This is a variable-offset stack read.
+	 */
+	idx = buf[0];
+	idx &= 0xf;
+	out = buf[idx];
+	/* Append something to the buffer. The position where we append it
+	 * is unknown. This is a variable-offset stack write.
+	 */
+	buf[len] = buf[idx];
+	uprobe_res = out;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.27.0

