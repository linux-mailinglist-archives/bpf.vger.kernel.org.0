Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B754583ED
	for <lists+bpf@lfdr.de>; Sun, 21 Nov 2021 14:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbhKUN6V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Nov 2021 08:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbhKUN6V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Nov 2021 08:58:21 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA08C061574
        for <bpf@vger.kernel.org>; Sun, 21 Nov 2021 05:55:16 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id x5so13721039pfr.0
        for <bpf@vger.kernel.org>; Sun, 21 Nov 2021 05:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ye208/exj71RqbZgkfB/6Oxo23lrX2clUxqCXmyAbG4=;
        b=nvLqQ6TTBN9z+J63m7fEp6vL+LnbaYZChu7PUbfUwADRrRDBz+fo1pzDOXUcR/dxDp
         nit5B1y/Z+Erp8UycQglufqLNxTdZqyyVWHcvYPi5misf+YVVx6gdvXwJJbMGBu867v2
         T+0j/z/9QAO9QSa19eQDIORF7xCa/hyrCc9wGCH5bApX+a3JeDztP0WDHFmFzPmvSMPm
         ZoGwGCUKxvdnMUK7E+QWPLOPkBZevLtFmA6KDi2BiH+s2byS9xEpp0UnFTmXzeyOnBQL
         JPQdBAQDSZ94L0DEKM82ikjNOLHRQMcMGa6Yxo8kRqa8obIAMaylxkc9riGzW4ZxVccV
         Kwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ye208/exj71RqbZgkfB/6Oxo23lrX2clUxqCXmyAbG4=;
        b=cYwo5ENO8jnllmWGWhghDKTRu+SBMXK9tYwB3fGvScASxqHAFloeh1p437OdeWiplv
         /IV0s92B84uonnvTh5jmiESnN4sS2dM6nLohm/QaDTL3U29A3gf3UYf6LfTQI3kg5VYo
         lk839a2kgNYt9HJ9yEY2EoQ6DVaRAICUWJko3DFartJAgv+xRVA7LKEBqHaKapWWwNSU
         yxq57F/bZzgz+sjq0haHC5ge/UKOsUg6iS9fif/h0F0x754fi5sA3dJS5ixw3Vil7a5z
         HVytyNLIHlVx56jguE/zZYdSEszVOX7fK2U9Wjxk5dGOO31N2Gpp/pOuL925lmtspLl0
         avag==
X-Gm-Message-State: AOAM532DqQ8KT0Ac0IzUB7x7F6AfrIPbudU2dsWgvoVAUDrR1I8Fgt+x
        lTLnirpzGrtV9X8JdtFwxa8Xe+qNlro=
X-Google-Smtp-Source: ABdhPJzm9ISjuRI5fXchY0tzhM2ugYPyqbdDrF3u9DdfccGU3/xu2mcLXRQlXxSbdh9N7VgzhL5K1g==
X-Received: by 2002:a05:6a00:248c:b0:49f:abac:a266 with SMTP id c12-20020a056a00248c00b0049fabaca266mr78596150pfv.42.1637502916271;
        Sun, 21 Nov 2021 05:55:16 -0800 (PST)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id u38sm6061073pfg.0.2021.11.21.05.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 05:55:15 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        hengqi.chen@gmail.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test BPF_MAP_TYPE_PROG_ARRAY static initialization
Date:   Sun, 21 Nov 2021 21:54:40 +0800
Message-Id: <20211121135440.3205482-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211121135440.3205482-1-hengqi.chen@gmail.com>
References: <20211121135440.3205482-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add testcase for BPF_MAP_TYPE_PROG_ARRAY static initialization.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 .../bpf/prog_tests/prog_array_init.c          | 27 +++++++++++++++++
 .../bpf/progs/test_prog_array_init.c          | 30 +++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/prog_array_init.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_prog_array_init.c

diff --git a/tools/testing/selftests/bpf/prog_tests/prog_array_init.c b/tools/testing/selftests/bpf/prog_tests/prog_array_init.c
new file mode 100644
index 000000000000..2fbf6946a0b6
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/prog_array_init.c
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2021 Hengqi Chen */
+
+#include <test_progs.h>
+#include <sys/un.h>
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
+	err = test_prog_array_init__load(skel);
+	if (!ASSERT_OK(err, "could not load BPF object"))
+		goto cleanup;
+
+	err = test_prog_array_init__attach(skel);
+	if (!ASSERT_OK(err, "could not attach BPF object"))
+		goto cleanup;
+
+cleanup:
+	test_prog_array_init__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_prog_array_init.c b/tools/testing/selftests/bpf/progs/test_prog_array_init.c
new file mode 100644
index 000000000000..e97204dd5443
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_prog_array_init.c
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2021 Hengqi Chen */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+SEC("socket")
+int tailcall_1(void *ctx)
+{
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
+SEC("socket")
+int BPF_PROG(entry)
+{
+	bpf_tail_call(ctx, &prog_array_init, 1);
+	return 0;
+}
--
2.30.2
