Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF09315DD6
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 04:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbhBJDh7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 22:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhBJDh6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 22:37:58 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBF1C061788
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 19:36:44 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id my11so2275446pjb.1
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 19:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n17y02GKzFtVkS+sQassrbdWRE9LRSsncjj+HgJBEPU=;
        b=YfxJQRrwYnL7bGFDZtaVp5NAkuzdt4xqeP3VHTQmhfFruKgIv/18DncP5+R9UxDm1N
         bAQvN4G+moWYQUKl9ElNzGca+VOLnS84y5k81KeCbIN4UC2v4S894Z8ouTNDKqyYxd/E
         dViHYpW2GpsiqwmG0uZtllBZH4ZGhnmg2JxUeDj7FzQcW+CkfPCERI49NhCsMbpa8iMR
         fOXZKr3xCQs8o56w3MHqNa1VonufOCYHugB+d4FePVZarLQ8i/DSLtYlyA7szxK1iMc7
         vl4ZHpz0RTND6wvf7UIjdRldXIaPYyFOZwBTiXccorM0UXaIULA1RvBBMaa57XN963vM
         zj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n17y02GKzFtVkS+sQassrbdWRE9LRSsncjj+HgJBEPU=;
        b=DBY0AQ9yogNar3uJOVXYYqZt/gGV3q446Pkv0wX0+dbpIcKRE/MnvkqGYrfm9kH8YQ
         VJOlhPABCLih0Y+klOhrcKsLayeH8D/0v5u3LLq8LngYUzjIM16y/AFUv7j6jBfQ/Erd
         wrV8AsEQLMCCdQxxDIcec5tvO9sHEZYefEWZqj4pBFO7B3kk2vpDDRqJczQLNyz60xMe
         CFYFINLbjKmZthAbTL08PeDhMuzKzk1TajEonXUXZAs9/DFsss6d6CLKxfWSCCvTjFus
         cJ3YSGEPnQ5QZxDuzvwUaS2NsUTC8O42pxNz1yw6YLsuKmI2N7m6NwIv+bXRftiCd8Zk
         VNyg==
X-Gm-Message-State: AOAM5329+cvKFxJYqcKvuZoJ/qDsJzslqisj/KcJMNsQ/0SL0uY0vfVu
        tTwZeK6ZiwTPS5ZWwfcMBpY=
X-Google-Smtp-Source: ABdhPJwmOwqZsbA158CWWZ+pnt+n+UIEXTi4tPMBrn7Cb7/RiNboSuFKyVEozeCVBRtPVDAC909cgw==
X-Received: by 2002:a17:902:8b89:b029:e0:6c0:dea8 with SMTP id ay9-20020a1709028b89b02900e006c0dea8mr1014316plb.28.1612928204296;
        Tue, 09 Feb 2021 19:36:44 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id f7sm391099pjh.45.2021.02.09.19.36.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 19:36:43 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 5/9] selftest/bpf: Add a recursion test
Date:   Tue,  9 Feb 2021 19:36:30 -0800
Message-Id: <20210210033634.62081-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210210033634.62081-1-alexei.starovoitov@gmail.com>
References: <20210210033634.62081-1-alexei.starovoitov@gmail.com>
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

