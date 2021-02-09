Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BE9315835
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 22:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbhBIU6q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 15:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbhBIUvp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 15:51:45 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB81FC061788
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 11:49:04 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 189so3550147pfy.6
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 11:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n17y02GKzFtVkS+sQassrbdWRE9LRSsncjj+HgJBEPU=;
        b=QEw+Jr/gHIUZ2mBIkVjj+ym4TJwiiN4OeYdS5RcAl2CF8fiV8BNFrhy5ZHnWWf93ow
         ogDxsKKd84fjsVDg5JpsLawCl9ZEMLesN4wO5Te6Xr6sooClGh1W48zfIN1IIX9W3Wgx
         ffFaZFGmjzy+PmfYsgfZDTxS2ihc8aetPrTYbB+r5C8zr3b6NklLk0tlnSmCDUE8qCsR
         SxgkMpXsM7U/t8j2Id7GFz2pio+v+aEluyMdSGRePxdF4XsNeZRMbBqyyZsLzUMvYuWL
         Z97XIZqsTwWklQtGGlithR6KrjaA9urcMLvZpJn5cFBhGIzYsl55mjSetXd4bISJT1uz
         HiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n17y02GKzFtVkS+sQassrbdWRE9LRSsncjj+HgJBEPU=;
        b=LOKBCfH+xsAl7A+JmaGzyU3uY3X3EuIR0NJ1ovsYJLzn9/2bsfdduGy4nm/B/lQgKn
         W13YxsBVmuKKAKIEQhceZIPOslJ2Ip53+Nx+w4zVAOO5RfGrrCcD2r9CllFeBBqs2fTS
         28DIJT/6mIoB/+bU7Ryb+J5d/2EiN6nJZgRNpQh1J880bc2uC0L9WpQXAZFycec2dhqB
         OceXDUapR1eDp/gsa6LHeklwL2/CW2LZYJlzEYN1s+fCe0x4PSD76JAWPu7K0MP+2Exl
         lf1ggZ3gRTpIRs1oZLfD3S1NUuYrrn93fFZHRv1ZThtxp/XTtacNMjhgzSxt0eLTAS23
         OOQQ==
X-Gm-Message-State: AOAM533D832doEfX/V0TwB9eRq+fL2Jr2kyFWNx2d1qdYyNRFjnW3sFU
        UI/3ftOZPDJKMViWBsvVv2E=
X-Google-Smtp-Source: ABdhPJy6wjnRpA+JIIjRM+a4XALWYF7YRaQ6cVdUf5/xY2o4Xeub3wyygBF5P1fSl4AdFwmrDdcyUg==
X-Received: by 2002:aa7:9018:0:b029:1d9:55d7:1ffc with SMTP id m24-20020aa790180000b02901d955d71ffcmr18973594pfo.71.1612900144232;
        Tue, 09 Feb 2021 11:49:04 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id j22sm139123pff.57.2021.02.09.11.49.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 11:49:03 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 4/8] selftest/bpf: Add a recursion test
Date:   Tue,  9 Feb 2021 11:48:52 -0800
Message-Id: <20210209194856.24269-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210209194856.24269-1-alexei.starovoitov@gmail.com>
References: <20210209194856.24269-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Add recursive non-sleepable fentry program as a test.
All attach points where sleepable progs can execute are non recursive so far.
The recursion protection mechanism for sleepable cannot be activated yet.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/recursion.c      | 33 +++++++++++++
 tools/testing/selftests/bpf/progs/recursion.c | 46 +++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/recursion.c
 create mode 100644 tools/testing/selftests/bpf/progs/recursion.c

diff --git a/tools/testing/selftests/bpf/prog_tests/recursion.c b/tools/testing/selftests/bpf/prog_tests/recursion.c
new file mode 100644
index 000000000000..863757461e3f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/recursion.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include <test_progs.h>
+#include "recursion.skel.h"
+
+void test_recursion(void)
+{
+	struct recursion *skel;
+	int key = 0;
+	int err;
+
+	skel = recursion__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	err = recursion__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto out;
+
+	ASSERT_EQ(skel->bss->pass1, 0, "pass1 == 0");
+	bpf_map_lookup_elem(bpf_map__fd(skel->maps.hash1), &key, 0);
+	ASSERT_EQ(skel->bss->pass1, 1, "pass1 == 1");
+	bpf_map_lookup_elem(bpf_map__fd(skel->maps.hash1), &key, 0);
+	ASSERT_EQ(skel->bss->pass1, 2, "pass1 == 2");
+
+	ASSERT_EQ(skel->bss->pass2, 0, "pass2 == 0");
+	bpf_map_lookup_elem(bpf_map__fd(skel->maps.hash2), &key, 0);
+	ASSERT_EQ(skel->bss->pass2, 1, "pass2 == 1");
+	bpf_map_lookup_elem(bpf_map__fd(skel->maps.hash2), &key, 0);
+	ASSERT_EQ(skel->bss->pass2, 2, "pass2 == 2");
+out:
+	recursion__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/recursion.c b/tools/testing/selftests/bpf/progs/recursion.c
new file mode 100644
index 000000000000..49f679375b9d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/recursion.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, long);
+} hash1 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, long);
+} hash2 SEC(".maps");
+
+int pass1 = 0;
+int pass2 = 0;
+
+SEC("fentry/__htab_map_lookup_elem")
+int BPF_PROG(on_lookup, struct bpf_map *map)
+{
+	int key = 0;
+
+	if (map == (void *)&hash1) {
+		pass1++;
+		return 0;
+	}
+	if (map == (void *)&hash2) {
+		pass2++;
+		/* htab_map_gen_lookup() will inline below call
+		 * into direct call to __htab_map_lookup_elem()
+		 */
+		bpf_map_lookup_elem(&hash2, &key);
+		return 0;
+	}
+
+	return 0;
+}
-- 
2.24.1

