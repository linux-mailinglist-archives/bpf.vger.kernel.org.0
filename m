Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074F656C50F
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 02:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiGIAFV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 20:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiGIAFO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 20:05:14 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78C6655A9
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 17:04:56 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id pt7-20020a17090b3d0700b001efb2800e55so158818pjb.3
        for <bpf@vger.kernel.org>; Fri, 08 Jul 2022 17:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nN9iRiPprDMd9CY+1g47ilbqup9IRJOrksYIMCPwycQ=;
        b=REkZZYiBiOu3B7c6deB/uB76Hs0UxOhzOLDMinoOqr0Neiim+zmlmjd2DvbziMD53S
         pz6rJH1t4NLkUMmt6ymWvQKlhdsgId49CHzP3ln40e2Lv9pSlTy44ISzpy2dsIMmy2K2
         T6Lhqhmz5cXcbzI1QpwXlzaDAcWhGxMoayYJkccTwN7Bfl1h3emEHTbRGmVOidkqoL+T
         A3vrvNuLyW6o2RuQmm0V8pW87UQA9WO/JqQ+K6lpxisZX3O3N+SU2ikFzSbBiaHiPHHy
         KN04AxkrhTaWRC1Xd4V3yOAY92wV6RXf1Mz4CWKI1+MtmrjEyTgsqz8MfRhljD1wOqGS
         +NKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nN9iRiPprDMd9CY+1g47ilbqup9IRJOrksYIMCPwycQ=;
        b=oD+GI941xo4Dj4Nh5o857hzYlkBRE6zh0iDjE5cXnrOMQXM1k5DyDOQ69A5g0/ml2s
         UeCauSeiiwp5+0p7vCxXauOD2QvN/BZNTjmDlvie/FtTOAlfItbFmae1NXNma4JZq3QC
         kt7GXA5JX4HXkKVZrUT+Nl85FuEUzwqTOw/156ljBYdi1ns2wYgpT7lzSXP/7yMzbfzu
         QMTNhwkIJX9rSG5jviodz2gQa044+xTZsr034iYUQAF2yiKpZqB4Qyt3c9b0bwV53InA
         xJrq6qF5tF/Vq7JyCHQi6h6mECz/b0po29G5m5jL5rrPb8gHLahmzEMZ2FoFN2bEk2sW
         /zYA==
X-Gm-Message-State: AJIora8bxVidLzvW/dS/OwFjrBlHWPyWlpczq1e7lCf1uS5bZgbEkNyM
        ax9Rxw+D5V7RyMeV4tT8I1MX2VTSJz/xb4/U
X-Google-Smtp-Source: AGRyM1uDfFRx5j+cM6tbCWOhRwTsjJ5Vy7uYoTktlYi3FILmZXjFZdV5ntJEOBWxattA/lSzaZtUJ/PAaCsY1b3n
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:aa7:9ae3:0:b0:528:d881:9ff with SMTP id
 y3-20020aa79ae3000000b00528d88109ffmr6595168pfp.66.1657325095847; Fri, 08 Jul
 2022 17:04:55 -0700 (PDT)
Date:   Sat,  9 Jul 2022 00:04:36 +0000
In-Reply-To: <20220709000439.243271-1-yosryahmed@google.com>
Message-Id: <20220709000439.243271-6-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220709000439.243271-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH bpf-next v3 5/8] selftests/bpf: Test cgroup_iter.
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hao Luo <haoluo@google.com>

Add a selftest for cgroup_iter. The selftest creates a mini cgroup tree
of the following structure:

    ROOT (working cgroup)
     |
   PARENT
  /      \
CHILD1  CHILD2

and tests the following scenarios:

 - invalid cgroup fd.
 - pre-order walk over descendants from PARENT.
 - post-order walk over descendants from PARENT.
 - walk of ancestors from PARENT.
 - early termination.

Signed-off-by: Hao Luo <haoluo@google.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/cgroup_iter.c    | 190 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_iter.h  |   7 +
 .../testing/selftests/bpf/progs/cgroup_iter.c |  39 ++++
 3 files changed, 236 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_iter.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c b/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
new file mode 100644
index 0000000000000..4c8f11f784915
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Google */
+
+#include <test_progs.h>
+#include <bpf/libbpf.h>
+#include <bpf/btf.h>
+#include "cgroup_iter.skel.h"
+#include "cgroup_helpers.h"
+
+#define ROOT		0
+#define PARENT		1
+#define CHILD1		2
+#define CHILD2		3
+#define NUM_CGROUPS	4
+
+#define PROLOGUE	"prologue\n"
+#define EPILOGUE	"epilogue\n"
+
+#define format_expected_output1(cg_id1) \
+	snprintf(expected_output, sizeof(expected_output), \
+		 PROLOGUE "%8llu\n" EPILOGUE, (cg_id1))
+
+#define format_expected_output2(cg_id1, cg_id2) \
+	snprintf(expected_output, sizeof(expected_output), \
+		 PROLOGUE "%8llu\n%8llu\n" EPILOGUE, \
+		 (cg_id1), (cg_id2))
+
+#define format_expected_output3(cg_id1, cg_id2, cg_id3) \
+	snprintf(expected_output, sizeof(expected_output), \
+		 PROLOGUE "%8llu\n%8llu\n%8llu\n" EPILOGUE, \
+		 (cg_id1), (cg_id2), (cg_id3))
+
+const char *cg_path[] = {
+	"/", "/parent", "/parent/child1", "/parent/child2"
+};
+
+static int cg_fd[] = {-1, -1, -1, -1};
+static unsigned long long cg_id[] = {0, 0, 0, 0};
+static char expected_output[64];
+
+int setup_cgroups(void)
+{
+	int fd, i = 0;
+
+	for (i = 0; i < NUM_CGROUPS; i++) {
+		fd = create_and_get_cgroup(cg_path[i]);
+		if (fd < 0)
+			return fd;
+
+		cg_fd[i] = fd;
+		cg_id[i] = get_cgroup_id(cg_path[i]);
+	}
+	return 0;
+}
+
+void cleanup_cgroups(void)
+{
+	int i;
+
+	for (i = 0; i < NUM_CGROUPS; i++)
+		close(cg_fd[i]);
+}
+
+static void read_from_cgroup_iter(struct bpf_program *prog, int cgroup_fd,
+				  int order, const char *testname)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo;
+	struct bpf_link *link;
+	int len, iter_fd;
+	static char buf[64];
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.cgroup.cgroup_fd = cgroup_fd;
+	linfo.cgroup.traversal_order = order;
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+
+	link = bpf_program__attach_iter(prog, &opts);
+	if (!ASSERT_OK_PTR(link, "attach_iter"))
+		return;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (iter_fd < 0)
+		goto free_link;
+
+	memset(buf, 0, sizeof(buf));
+	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
+		;
+
+	ASSERT_STREQ(buf, expected_output, testname);
+
+	close(iter_fd);
+free_link:
+	bpf_link__destroy(link);
+}
+
+/* Invalid cgroup. */
+static void test_invalid_cgroup(struct cgroup_iter *skel)
+{
+
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo;
+	struct bpf_link *link;
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.cgroup.cgroup_fd = (__u32)-1;
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+
+	link = bpf_program__attach_iter(skel->progs.cgroup_id_printer, &opts);
+	if (!ASSERT_ERR_PTR(link, "attach_iter"))
+		bpf_link__destroy(link);
+}
+
+/* Preorder walk prints parent and child in order. */
+static void test_walk_preorder(struct cgroup_iter *skel)
+{
+	format_expected_output3(cg_id[PARENT], cg_id[CHILD1], cg_id[CHILD2]);
+
+	read_from_cgroup_iter(skel->progs.cgroup_id_printer, cg_fd[PARENT],
+			      BPF_ITER_CGROUP_PRE, "preorder");
+}
+
+/* Postorder walk prints child and parent in order. */
+static void test_walk_postorder(struct cgroup_iter *skel)
+{
+	format_expected_output3(cg_id[CHILD1], cg_id[CHILD2], cg_id[PARENT]);
+
+	read_from_cgroup_iter(skel->progs.cgroup_id_printer, cg_fd[PARENT],
+			      BPF_ITER_CGROUP_POST, "postorder");
+}
+
+/* Walking parents prints parent and then root. */
+static void test_walk_parent_up(struct cgroup_iter *skel)
+{
+	/* terminate the walk when ROOT is met. */
+	skel->bss->terminal_cgroup = cg_id[ROOT];
+
+	format_expected_output2(cg_id[PARENT], cg_id[ROOT]);
+
+	read_from_cgroup_iter(skel->progs.cgroup_id_printer, cg_fd[PARENT],
+			      BPF_ITER_CGROUP_PARENT_UP, "parent_up");
+
+	skel->bss->terminal_cgroup = 0;
+}
+
+/* Early termination prints parent only. */
+static void test_early_termination(struct cgroup_iter *skel)
+{
+	/* terminate the walk after the first element is processed. */
+	skel->bss->terminate_early = 1;
+
+	format_expected_output1(cg_id[PARENT]);
+
+	read_from_cgroup_iter(skel->progs.cgroup_id_printer, cg_fd[PARENT],
+			      BPF_ITER_CGROUP_PRE, "early_termination");
+
+	skel->bss->terminate_early = 0;
+}
+
+void test_cgroup_iter(void)
+{
+	struct cgroup_iter *skel = NULL;
+
+	if (setup_cgroup_environment() < 0)
+		return;
+
+	if (setup_cgroups() < 0)
+		goto out;
+
+	skel = cgroup_iter__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "cgroup_iter__open_and_load"))
+		goto out;
+
+	if (test__start_subtest("cgroup_iter__invalid_cgroup"))
+		test_invalid_cgroup(skel);
+	if (test__start_subtest("cgroup_iter__preorder"))
+		test_walk_preorder(skel);
+	if (test__start_subtest("cgroup_iter__postorder"))
+		test_walk_postorder(skel);
+	if (test__start_subtest("cgroup_iter__parent_up_walk"))
+		test_walk_parent_up(skel);
+	if (test__start_subtest("cgroup_iter__early_termination"))
+		test_early_termination(skel);
+out:
+	cgroup_iter__destroy(skel);
+	cleanup_cgroups();
+	cleanup_cgroup_environment();
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter.h b/tools/testing/selftests/bpf/progs/bpf_iter.h
index 97ec8bc76ae62..bfcb0e0e3b1aa 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter.h
+++ b/tools/testing/selftests/bpf/progs/bpf_iter.h
@@ -17,6 +17,7 @@
 #define bpf_iter__bpf_sk_storage_map bpf_iter__bpf_sk_storage_map___not_used
 #define bpf_iter__sockmap bpf_iter__sockmap___not_used
 #define bpf_iter__bpf_link bpf_iter__bpf_link___not_used
+#define bpf_iter__cgroup bpf_iter__cgroup___not_used
 #define btf_ptr btf_ptr___not_used
 #define BTF_F_COMPACT BTF_F_COMPACT___not_used
 #define BTF_F_NONAME BTF_F_NONAME___not_used
@@ -39,6 +40,7 @@
 #undef bpf_iter__bpf_sk_storage_map
 #undef bpf_iter__sockmap
 #undef bpf_iter__bpf_link
+#undef bpf_iter__cgroup
 #undef btf_ptr
 #undef BTF_F_COMPACT
 #undef BTF_F_NONAME
@@ -139,6 +141,11 @@ struct bpf_iter__bpf_link {
 	struct bpf_link *link;
 };
 
+struct bpf_iter__cgroup {
+	struct bpf_iter_meta *meta;
+	struct cgroup *cgroup;
+} __attribute__((preserve_access_index));
+
 struct btf_ptr {
 	void *ptr;
 	__u32 type_id;
diff --git a/tools/testing/selftests/bpf/progs/cgroup_iter.c b/tools/testing/selftests/bpf/progs/cgroup_iter.c
new file mode 100644
index 0000000000000..2a34d146d6df0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_iter.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Google */
+
+#include "bpf_iter.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+volatile int terminate_early = 0;
+volatile u64 terminal_cgroup = 0;
+
+static inline u64 cgroup_id(struct cgroup *cgrp)
+{
+	return cgrp->kn->id;
+}
+
+SEC("iter/cgroup")
+int cgroup_id_printer(struct bpf_iter__cgroup *ctx)
+{
+	struct seq_file *seq = ctx->meta->seq;
+	struct cgroup *cgrp = ctx->cgroup;
+
+	/* epilogue */
+	if (cgrp == NULL) {
+		BPF_SEQ_PRINTF(seq, "epilogue\n");
+		return 0;
+	}
+
+	/* prologue */
+	if (ctx->meta->seq_num == 0)
+		BPF_SEQ_PRINTF(seq, "prologue\n");
+
+	BPF_SEQ_PRINTF(seq, "%8llu\n", cgroup_id(cgrp));
+
+	if (terminal_cgroup == cgroup_id(cgrp))
+		return 1;
+
+	return terminate_early ? 1 : 0;
+}
-- 
2.37.0.rc0.161.g10f37bed90-goog

