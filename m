Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9993120AD
	for <lists+bpf@lfdr.de>; Sun,  7 Feb 2021 02:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhBGBL4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 20:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhBGBL4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 20:11:56 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABEBC06178A
        for <bpf@vger.kernel.org>; Sat,  6 Feb 2021 17:11:15 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id s77so11008828qke.4
        for <bpf@vger.kernel.org>; Sat, 06 Feb 2021 17:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4B1lByB23Mjsr/oXNA7OyT1Bcx5NI3UuCUOCI/MwObk=;
        b=LdXKxvH95MDHVs+Cn78ACKE9sI/xithSrRyqUmEu5nib6ldRt9Ba5vGozZlwsUiqkv
         dGbdHxwGbMetzjt9cazv0bwQmSpd27itgHJnq273lVbiaCPlulqRwLx8IrCsGMtzCJ0F
         JXsESgfLi9AMGPanw2Iu9hspbGGhy98Sos2Sfq6bGhROlre5fkcPkoaEIwIyVpawc+qp
         O0YHOZOAlDH1XetSVDnn3XakhiXnVSdztulHiVeCpCUqR5zizO9IxQ0Ztx7u2iPn45qY
         OwNQgWOb8n98bSG942Z513+5bFJTKzwFt+E4pFoRkqmTkasiHXPjOSuC5p9yqk3NaPcl
         tO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4B1lByB23Mjsr/oXNA7OyT1Bcx5NI3UuCUOCI/MwObk=;
        b=ZjvQinpQnv6LnjgI28Lklre2uMg7yeGuJWs/dPQUjDq3BwEnGDYHCqm35H8gXcZj1e
         J3Wyf1hJus0w0UXmyxRBDRbKVktIKPoFb0OMpWADuDkqt7Fxz/4PLdA6GdO/Hpx/eJqd
         8o8LsWtp6jf7rdQ25q6lRug41/IbxPDNrJAi0zsY3IgsPdyA2XvpcN/Q/ylYjA1KDsPh
         khAyMrxhvSZK6EMHHD5L2uN/0+76NeY+VU5vvGISujX5VlUZ3NU+glbOfDPmxzbsD/Rb
         ZjHkZ8e80mPzKKRvb/rZxtCMMsbjpX3Gy8KoxnC502w/3OnuXaHgsLWo6A/cWBAjl+Gq
         K7Og==
X-Gm-Message-State: AOAM530u4oy+7VGZUb9N2IfGVIV7LL6Q/hplLu79FPXRMDVv80tXLQYQ
        7OXcC+HgIoSXNJfaumYJZYS51w6kOQKtXw==
X-Google-Smtp-Source: ABdhPJyR95xaoDfFKZmd8k+vMn/OZNJFZ6OtVFVD9fZEiaLGhJxYXQcCpGXaBP8XpSbF/sEuldcvag==
X-Received: by 2002:a37:2741:: with SMTP id n62mr11183768qkn.43.1612660274748;
        Sat, 06 Feb 2021 17:11:14 -0800 (PST)
Received: from localhost (pool-100-33-73-206.nycmny.fios.verizon.net. [100.33.73.206])
        by smtp.gmail.com with ESMTPSA id c17sm1713137qtn.71.2021.02.06.17.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Feb 2021 17:11:14 -0800 (PST)
From:   Andrei Matei <andreimatei1@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Cc:     Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next v3 4/4] selftest/bpf: add test for var-offset stack access
Date:   Sat,  6 Feb 2021 20:10:27 -0500
Message-Id: <20210207011027.676572-5-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210207011027.676572-1-andreimatei1@gmail.com>
References: <20210207011027.676572-1-andreimatei1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a higher-level test (C BPF program) for the new functionality -
variable access stack reads and writes.

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 .../selftests/bpf/prog_tests/stack_var_off.c  | 36 ++++++++++++
 .../selftests/bpf/progs/test_stack_var_off.c  | 56 +++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stack_var_off.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_stack_var_off.c

diff --git a/tools/testing/selftests/bpf/prog_tests/stack_var_off.c b/tools/testing/selftests/bpf/prog_tests/stack_var_off.c
new file mode 100644
index 000000000000..52e00486b1aa
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/stack_var_off.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "test_stack_var_off.skel.h"
+
+/* Test read and writes to the stack performed with offsets that are not
+ * statically known.
+ */
+void test_stack_var_off(void)
+{
+	int duration = 0;
+	struct test_stack_var_off *skel;
+
+	skel = test_stack_var_off__open_and_load();
+	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
+		return;
+	if (CHECK(!skel->bss, "check_bss", ".bss wasn't mmap()-ed\n"))
+		goto cleanup;
+
+	test_stack_var_off__attach(skel);
+
+	/* Give pid to bpf prog so it doesn't trigger for anyone else. */
+	skel->bss->test_pid = getpid();
+	/* Initialize the probe's input. */
+	skel->bss->input[0] = 2;
+	skel->bss->input[1] = 42;  /* This will be returned in probe_res. */
+
+	/* Trigger probe. */
+	usleep(1);
+
+	if (CHECK(skel->bss->probe_res != 42, "check_probe_res",
+		  "wrong probe res: %d\n", skel->bss->probe_res))
+		goto cleanup;
+
+cleanup:
+	test_stack_var_off__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_stack_var_off.c b/tools/testing/selftests/bpf/progs/test_stack_var_off.c
new file mode 100644
index 000000000000..bd9c8d86cd91
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_stack_var_off.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017 Facebook
+
+#include <linux/ptrace.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+int probe_res;
+
+char input[4] = {};
+int test_pid;
+
+SEC("tracepoint/syscalls/sys_enter_nanosleep")
+int probe(void *ctx)
+{
+	/* This BPF program performs variable-offset reads and writes on a
+	 * stack-allocated buffer.
+	 */
+	char stack_buf[16];
+	unsigned long len;
+	unsigned long last;
+
+	if (test_pid == 0)
+		return 0;
+	if ((bpf_get_current_pid_tgid() >> 32) != test_pid)
+		return 0;
+
+	/* Copy the input to the stack. */
+	__builtin_memcpy(stack_buf, input, 4);
+
+	/* The first byte in the buffer indicates the length. */
+	len = stack_buf[0] & 0xf;
+	last = (len - 1) & 0xf;
+
+	/* Append something to the buffer. The offset where we write is not
+	 * statically known; this is a variable-offset stack write.
+	 */
+	stack_buf[len] = 42;
+
+	/* Index into the buffer at an unknown offset. This is a
+	 * variable-offset stack read.
+	 *
+	 * Note that if it wasn't for the preceding variable-offset write, this
+	 * read would be rejected because the stack slot cannot be verified as
+	 * being initialized. With the preceding variable-offset write, the
+	 * stack slot still cannot be verified, but the write inhibits the
+	 * respective check on the reasoning that, if there was a
+	 * variable-offset to a higher-or-equal spot, we're probably reading
+	 * what we just wrote.
+	 */
+	probe_res = stack_buf[last];
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.27.0

