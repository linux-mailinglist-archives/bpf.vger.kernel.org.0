Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32211311BCD
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 08:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhBFG6u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 01:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhBFG6t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 01:58:49 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839B4C06178A
        for <bpf@vger.kernel.org>; Fri,  5 Feb 2021 22:57:49 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id s24so4820916pjp.5
        for <bpf@vger.kernel.org>; Fri, 05 Feb 2021 22:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s90ybCQSD9+lJLY0FyNWVkP+FBOIFxm3CD9jWD7W2Sw=;
        b=rE4hhGdcKPQ0lnAGXThztDl4iv7SSm6jWJlaOLz6txyWS001s5SBlbRHkBzhrAYwDc
         BxvlwRTDT291XH4ouVfoZ7EZOI6MUgiHQJeLku1dKKeDZZ2IzMm+9YkQ0PzCW8UgFJgn
         VYb0lUmo3klCf2bpH3Dpn5ZVX4HzZi6Ht8GivarAyWZYVejBUV5eDmmseKs2IWThAuqL
         lUcLp3Q42fHXqb/9IzwaM7gOH3pFvaSlWu/XydUGqFzG0VpgpVmDhhiRRUzmhfpcFi8e
         6xDhP6wl5+0JkF/5wJZtCc2wD7xvwq4rp+8Gn6GBgynwTOIMtPfpzU/dxDtszthqeDmg
         ppRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s90ybCQSD9+lJLY0FyNWVkP+FBOIFxm3CD9jWD7W2Sw=;
        b=I3ImdN88l7mf5MHKQcFbkTfyH/xhu+7iIS4OmNZxwY6A1lkM5RFcGwmOQ+1LaE3Cfd
         NqeqKInnadgmovMUhNjrZ0/+pajDN/1E/3Ihu4IFeiJ1Lp4UOgxcekCVBf1dwzQDAeKv
         jbWesfEtIarmbvzSKfgSCtVfJbrBY8jQuL03r1Qew58N6Dmh3maXfwj9e0qBPoOboyPt
         bAP8fFCeyHPQzHfNpTz7kKMgMJfJq5gwuQNFByobkRvzKAbYPqa3idA1Cb5eQFNb9vpx
         u3sGAf43IHmKeHZ0ezqFk744mTJNDGIkc8cxkh75CqR+bMZN7XX/+ixHeIiFZyUrQB+C
         lQCQ==
X-Gm-Message-State: AOAM530yjUQd1nlAe3cPdzIyeOuPIaxZ3OE+1E/iMcIrHrsT+jWH+rdw
        WkAc3kH2/MAIdjzVTai+bS16I80wDKI=
X-Google-Smtp-Source: ABdhPJwdHfi2Vb6N/TzsOGTewCyLptGQS9YKdWz6tgO0+Cwo7D0pzfrhVIyylJdw7VRSFdk48RwTXg==
X-Received: by 2002:a17:90a:648f:: with SMTP id h15mr7549150pjj.142.1612594669108;
        Fri, 05 Feb 2021 22:57:49 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id r9sm12065093pfq.8.2021.02.05.22.57.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2021 22:57:48 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next 4/5] selftest/bpf: Add recursion test
Date:   Fri,  5 Feb 2021 22:57:40 -0800
Message-Id: <20210206065741.59188-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210206065741.59188-1-alexei.starovoitov@gmail.com>
References: <20210206065741.59188-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/recursion.c      | 33 +++++++++++++
 tools/testing/selftests/bpf/progs/recursion.c | 46 +++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/recursion.c
 create mode 100644 tools/testing/selftests/bpf/progs/recursion.c

diff --git a/tools/testing/selftests/bpf/prog_tests/recursion.c b/tools/testing/selftests/bpf/prog_tests/recursion.c
new file mode 100644
index 000000000000..16e8eab5a29d
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

