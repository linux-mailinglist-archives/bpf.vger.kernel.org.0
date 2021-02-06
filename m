Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2450311EFD
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 18:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBFREe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 12:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhBFREd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 12:04:33 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA1AC06178A
        for <bpf@vger.kernel.org>; Sat,  6 Feb 2021 09:03:52 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id e12so5176707pls.4
        for <bpf@vger.kernel.org>; Sat, 06 Feb 2021 09:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NNvlFpZ2P+nsN0N8rvXToy2l98iABgwCDQW0vsBD0NI=;
        b=TgvhfEoSretMhN2ajBMifUXoBnrTALAoLxzE5CcCB1fzs/NwEqZXNac1EqLuzgzcKu
         F8VgLNCJ4eKxOhl3W0j7DumYP/Fa97tZjZAp86v52WmL30vdDuctVAMttxUHZwAHuZQr
         ihXlkyGFthdQU8/ehO463erXIDrMbFwsilVxNnwPvDLGl2zG4WAoNb6Eoht/Z8lvNjsQ
         dT6BRKjAOOKGLDzTlti1nA1We86eYfLKeQy1G+Xvb5t8lPofGTVFmx9KuexMK49ghRzk
         WkLeAvsfEtXFyJ7nWx+L7P/RLMHbIW5zY+/WnL279jKLVhtjpXO7TKJ1mE8tHeuyreKf
         LdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NNvlFpZ2P+nsN0N8rvXToy2l98iABgwCDQW0vsBD0NI=;
        b=k/qXZcEez86syIMYkzgutle3RRaPHyYX2HnLRTxvylj0DB6YDRzI6hKIhC/YjrAcID
         f3T4/h52TrcIzwhZPNd9xHjBCOWD0BEAXgtuJidEP4JfwzWRKwnDPpYbuxj3O0QrdxOt
         +FvQYgaCu4Q1cj34MR6KwJ35tLk971B9x2SyFE7T8DvBuZCBvZ7UKRkepQ92nshP5aUn
         dAjt+f4cfcKEiEoS2J+PYdtjySuiH0+B0wR8ldYBigTwHA4/ZCTHUCoJScLPuYD6Qe1p
         4kRq9xtLm32PPzboetfzl2b2kjZwVvV50MVRJI0ibzdFK8qr2i7M6JDpzNQHB02WAC+k
         jdzA==
X-Gm-Message-State: AOAM531PLObhXd/oSmpgpjmmmchmE0ysaZFm0QhxOMx+ypbVWQ7ml3HG
        Jx1A1x6VLIYZpV5lCCjlMaI=
X-Google-Smtp-Source: ABdhPJyFkjM0yCjHD2HH6r/jY9pffe+4hYrtSOPEig44ZgxlnxXATUAAUvV2nCQkW+lEuJy2NxS6gw==
X-Received: by 2002:a17:90b:1008:: with SMTP id gm8mr9540487pjb.174.1612631032410;
        Sat, 06 Feb 2021 09:03:52 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id j14sm11149964pjl.35.2021.02.06.09.03.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Feb 2021 09:03:51 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 bpf-next 4/7] selftest/bpf: Add a recursion test
Date:   Sat,  6 Feb 2021 09:03:41 -0800
Message-Id: <20210206170344.78399-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210206170344.78399-1-alexei.starovoitov@gmail.com>
References: <20210206170344.78399-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Add recursive non-sleepable fentry program as a test.
All attach points where sleepable progs can execute are non recursive so far.
The recursion protection mechanism for sleepable cannot be activated yet.

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

