Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659AB586FA9
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 19:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiHARjb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 13:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbiHARja (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 13:39:30 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E817E140B4
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 10:39:29 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id q82-20020a632a55000000b0041bafd16728so2520793pgq.3
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 10:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=XV+9Gk8Glt4UiO1lSe6vSmqpZhOdzkUwOwlhq1X7BnQ=;
        b=ILz0JyNzO9kpMnfHbXU7p2cu7gk5gfq0fQGlD+cfCx8EThUFgYytS6lS1Tu4yekioD
         FMrE5h4UnkaWNlDoEpl0erBGCvZUINVDnSIx1vCtzc0oTFZ182sHJzscQ4E+u8z2ZDTx
         I3CvvvllgTTICjCJ/UzQG2Scqk86fP/1lB5GcJTvjog+5aJmak48XXULcDOlv+OMUMh/
         7TF9n3Ngjlkqhva3kT51JkqWYFrjI0vD826x5QTAxlAduRdhcNkynFIJ82EWrZOY2li+
         tuTPNQWrF/ePDl/Xcqi3kSuUdydBs1RhfgC1DjJDbHK0oNIKUoThEVY09AIpidAvowLd
         +q+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=XV+9Gk8Glt4UiO1lSe6vSmqpZhOdzkUwOwlhq1X7BnQ=;
        b=wn+w8JNF1M1uJgN73kQDl0jcKOBvNYfl+FHzNfsLdS5OgO/u9OtX0XpV8xtc6S7+yu
         IL/jiconJweohQ1Jf2d9nW75d4z+y+50qPkjJHcPvfF8IPqTKJTycXlpfJx4e0NSpczH
         2KRm8DR4GnKCzAKQZg0OSpC/FZEhoy0+/vrDQEZ7ZpIa+jBrXF/hzsCkBMnGwT6pekBk
         dpH/p6wcJbbhZKyld+X49bsudKL43/qpAW0+8fsgKGpNV8nKcd0zOpLcQJ5L2IR0/d/L
         bEAUmUA+aJsM8lAv84tpHlzxkbrbW/igIdxa29c1rNV9PNGF/k/Q5Wlfd6ZWCz/f61Hf
         eGqA==
X-Gm-Message-State: ACgBeo0nzpMNauJsmrYtGE1GikwJ+ARwl3d/qlVmBItbLT/nzTo6KG6r
        INP4BcQFRT/l2VPQAk6nPtxiD/K6GMg3VvqV37bzV8czJPp21ZUeS8FFNje82oYQS4B3ngzbVf1
        OpmWEzvoqumLpvXT9punl2HUbJKaIHZEEapsSEpFsdO5KcrwzOQ==
X-Google-Smtp-Source: AA6agR5qj7BQTiCl0tHCGKlBs/JfKz4IAuQPIXoGAqSx8cc/amAU8KU5LYTM69VQYdQto9mz1iH/YUM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:aa4b:b0:164:11ad:af0f with SMTP id
 c11-20020a170902aa4b00b0016411adaf0fmr17465336plr.54.1659375569302; Mon, 01
 Aug 2022 10:39:29 -0700 (PDT)
Date:   Mon,  1 Aug 2022 10:39:26 -0700
In-Reply-To: <20220801173926.2441748-1-sdf@google.com>
Message-Id: <20220801173926.2441748-2-sdf@google.com>
Mime-Version: 1.0
References: <20220801173926.2441748-1-sdf@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Excercise bpf_obj_get_info_by_fd
 for bpf2bpf
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Apparently, no existing selftest covers it. Add a new one where
we load cgroup/bind4 program and attach fentry to it.
Calling bpf_obj_get_info_by_fd on the fentry program
should return non-zero btf_id/btf_obj_id instead of crashing the kernel.

v2:
- use ret instead of err in find_prog_btf_id (Hao)
- remove verifier log (Hao)
- drop if conditional from ASSERT_OK(bpf_obj_get_info_by_fd(...)) (Hao)

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/attach_to_bpf.c  | 97 +++++++++++++++++++
 .../selftests/bpf/progs/attach_to_bpf.c       | 12 +++
 2 files changed, 109 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c
 create mode 100644 tools/testing/selftests/bpf/progs/attach_to_bpf.c

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c b/tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c
new file mode 100644
index 000000000000..eb06f522c0b3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <bpf/btf.h>
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "attach_to_bpf.skel.h"
+
+static int find_prog_btf_id(const char *name, __u32 attach_prog_fd)
+{
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info);
+	struct btf *btf;
+	int ret;
+
+	ret = bpf_obj_get_info_by_fd(attach_prog_fd, &info, &info_len);
+	if (ret)
+		return ret;
+
+	if (!info.btf_id)
+		return -EINVAL;
+
+	btf = btf__load_from_kernel_by_id(info.btf_id);
+	ret = libbpf_get_error(btf);
+	if (ret)
+		return ret;
+
+	ret = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
+	btf__free(btf);
+	return ret;
+}
+
+int load_fentry(int attach_prog_fd, int attach_btf_id)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		    .expected_attach_type = BPF_TRACE_FENTRY,
+		    .attach_prog_fd = attach_prog_fd,
+		    .attach_btf_id = attach_btf_id,
+	);
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+
+	return bpf_prog_load(BPF_PROG_TYPE_TRACING,
+			     "bind4_fentry",
+			     "GPL",
+			     insns,
+			     ARRAY_SIZE(insns),
+			     &opts);
+}
+
+void test_attach_to_bpf(void)
+{
+	struct attach_to_bpf *skel = NULL;
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info);
+	int cgroup_fd = -1;
+	int fentry_fd = -1;
+	int btf_id;
+
+	cgroup_fd = test__join_cgroup("/attach_to_bpf");
+	if (!ASSERT_GE(cgroup_fd, 0, "cgroup_fd"))
+		return;
+
+	skel = attach_to_bpf__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel"))
+		goto cleanup;
+
+	skel->links.bind4 = bpf_program__attach_cgroup(skel->progs.bind4, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel, "bpf_program__attach_cgroup"))
+		goto cleanup;
+
+	btf_id = find_prog_btf_id("bind4", bpf_program__fd(skel->progs.bind4));
+	if (!ASSERT_GE(btf_id, 0, "find_prog_btf_id"))
+		goto cleanup;
+
+	fentry_fd = load_fentry(bpf_program__fd(skel->progs.bind4), btf_id);
+	if (!ASSERT_GE(fentry_fd, 0, "load_fentry"))
+		goto cleanup;
+
+	/* Make sure bpf_obj_get_info_by_fd works correctly when attaching
+	 * to another BPF program.
+	 */
+
+	ASSERT_OK(bpf_obj_get_info_by_fd(fentry_fd, &info, &info_len),
+		  "bpf_obj_get_info_by_fd");
+
+	ASSERT_EQ(info.btf_id, 0, "info.btf_id");
+	ASSERT_GT(info.attach_btf_id, 0, "info.attach_btf_id");
+	ASSERT_GT(info.attach_btf_obj_id, 0, "info.attach_btf_obj_id");
+
+cleanup:
+	close(cgroup_fd);
+	close(fentry_fd);
+	attach_to_bpf__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/attach_to_bpf.c b/tools/testing/selftests/bpf/progs/attach_to_bpf.c
new file mode 100644
index 000000000000..3f111fe96f8f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/attach_to_bpf.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+SEC("cgroup/bind4")
+int bind4(struct bpf_sock_addr *ctx)
+{
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.37.1.455.g008518b4e5-goog

