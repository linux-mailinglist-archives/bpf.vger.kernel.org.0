Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBB44606C8
	for <lists+bpf@lfdr.de>; Sun, 28 Nov 2021 15:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357840AbhK1OWX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Nov 2021 09:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352701AbhK1OUV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Nov 2021 09:20:21 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305D8C06174A
        for <bpf@vger.kernel.org>; Sun, 28 Nov 2021 06:17:05 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id f65so13198808pgc.0
        for <bpf@vger.kernel.org>; Sun, 28 Nov 2021 06:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sRSj3UwUhl0qJFcWyI3i8TMm0nkJ3eYM2Pf5+NbknNs=;
        b=Kps3Xd88iIkPpPgsQOIKf2TJ4oDgqSXZ28Dif5XfSarf4OqjzgLdJVj0s0+A4SOy9Y
         NNEuNWfj2E+I3tp1hlVUGSM6lCzB7s6s88IkGyDr64DiYEs9wg4Tl212Oa1qT70xOLKs
         KPuN5DhWPXn+c3y21m4Ju1hKk3c3heUHTQN3fAhRSWOPxd3a5VvgnmWIuAM0h/J83TSA
         EJ4Q+Hopxbt6vJQg/A7KJcRfTyKW3/n/d+SHKKUintnMhLC8/XewswKy9lIvKk5KUuXr
         ezR4UlwO2NqFqsMGjFpFGyaPEB7+k0J5J0pp2E62u6GpiYxS6CHOn4NYBIZjU4UdIO+6
         4vyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sRSj3UwUhl0qJFcWyI3i8TMm0nkJ3eYM2Pf5+NbknNs=;
        b=x8LPylGR7bnKE0SUxp0M0X3myY89h1PtWF1s7WEJEYGtgE9LeWWj8fY/JuBVB4aLKM
         cB3nxln7tlenX3NBSAKFd6BysfSTXa2bycVVE2sqfExqoA83vM6p6DGYmT6PEHklrtXZ
         keoiqY/2dMf4Lc1LN/gwtcNhZDoegDNghMUyxIJ52TsbWk9fHN1RqV+/mJMoo8pFnEtf
         593vdfERueR3l1im0/XaaJOSjxbqLOxnCSGthxQuOEbPZmf6pmeAuCHSnzsRKOc7310O
         axQ05sVaJEMUUuHEj2MI7FEngiusaFyXWhJXaDYC7K99p0k4eCbq2+SykBfuOOCjvjoe
         gJWQ==
X-Gm-Message-State: AOAM533z5mrLVQipsQQitjReyCDjI5RTVYOGWg4ogUWM8+NhxN4W2qBl
        l+jTcmKPCdXHAp+KayStZOXnZKQgPmY=
X-Google-Smtp-Source: ABdhPJyFSGv94SsoW47BFWDiXbzIdTRFEID6wuqoIFFvwajaH28U8n+c113Ubr5FdGjuRbNlwSpNVg==
X-Received: by 2002:a63:d257:: with SMTP id t23mr16324135pgi.533.1638109024547;
        Sun, 28 Nov 2021 06:17:04 -0800 (PST)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id b6sm14513583pfm.170.2021.11.28.06.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 06:17:04 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        hengqi.chen@gmail.com
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Test BPF_MAP_TYPE_PROG_ARRAY static initialization
Date:   Sun, 28 Nov 2021 22:16:33 +0800
Message-Id: <20211128141633.502339-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211128141633.502339-1-hengqi.chen@gmail.com>
References: <20211128141633.502339-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add testcase for BPF_MAP_TYPE_PROG_ARRAY static initialization.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 .../bpf/prog_tests/prog_array_init.c          | 32 +++++++++++++++
 .../bpf/progs/test_prog_array_init.c          | 39 +++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/prog_array_init.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_prog_array_init.c

diff --git a/tools/testing/selftests/bpf/prog_tests/prog_array_init.c b/tools/testing/selftests/bpf/prog_tests/prog_array_init.c
new file mode 100644
index 000000000000..fc4657619739
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/prog_array_init.c
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2021 Hengqi Chen */
+
+#include <test_progs.h>
+#include "test_prog_array_init.skel.h"
+
+void test_prog_array_init(void)
+{
+	struct test_prog_array_init *skel;
+	int err;
+
+	skel = test_prog_array_init__open();
+	if (!ASSERT_OK_PTR(skel, "could not open BPF object"))
+		return;
+
+	skel->rodata->my_pid = getpid();
+
+	err = test_prog_array_init__load(skel);
+	if (!ASSERT_OK(err, "could not load BPF object"))
+		goto cleanup;
+
+	skel->links.entry = bpf_program__attach_raw_tracepoint(skel->progs.entry, "sys_enter");
+	if (!ASSERT_OK_PTR(skel->links.entry, "could not attach BPF program"))
+		goto cleanup;
+
+	usleep(1);
+
+	ASSERT_EQ(skel->bss->value, 42, "unexpected value");
+
+cleanup:
+	test_prog_array_init__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_prog_array_init.c b/tools/testing/selftests/bpf/progs/test_prog_array_init.c
new file mode 100644
index 000000000000..2cd138356126
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_prog_array_init.c
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2021 Hengqi Chen */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+const volatile pid_t my_pid = 0;
+int value = 0;
+
+SEC("raw_tp/sys_enter")
+int tailcall_1(void *ctx)
+{
+	value = 42;
+	return 0;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 2);
+	__uint(key_size, sizeof(__u32));
+	__array(values, int (void *));
+} prog_array_init SEC(".maps") = {
+	.values = {
+		[1] = (void *)&tailcall_1,
+	},
+};
+
+SEC("raw_tp/sys_enter")
+int entry(void *ctx)
+{
+	pid_t pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (pid != my_pid)
+		return 0;
+
+	bpf_tail_call(ctx, &prog_array_init, 1);
+	return 0;
+}
--
2.30.2
