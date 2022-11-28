Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B13663A985
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 14:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiK1Naq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 08:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiK1NaQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 08:30:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8934F1E72A
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 05:30:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A4CAB80DB6
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 13:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CA3C433C1;
        Mon, 28 Nov 2022 13:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669642212;
        bh=msSWn6hJlMuId26cxpEHU4ld/HBG5dDN7Gt8gr70eEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gifhp7fZKnThTadMvPzIELIg0CBf0JBYPj96tcgqm4XkOKWxdBhwh9cUCXq3c1HXN
         3BYj//BXVXbUDR4m9/RZ1E49GwaVJwbSiMGkRD4TfXJikvVNMotaoZQWVxuEkxcGK1
         tJRZImJLfZj9BI/vPw00jBUCndL2Aok4/Fc+nMrogIihOSNBFWxrM83yU6UDqMTazJ
         r+rNQLd3CaZxMGoY5h0mK06Wjv8QFvOgDAK9a+rBUYuBf1eucRA/+pGzDYd2XGt4wO
         vwNiUWBslHKi1sqfQsBhF61sJxNxihXHldBf/tPaUOKz+S3r1Gq872jsGnnWOj12AZ
         lGZTd8FTHrJ+A==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCHv4 bpf-next 4/4] selftests/bpf: Add bpf_vma_build_id_parse task vma iterator test
Date:   Mon, 28 Nov 2022 14:29:15 +0100
Message-Id: <20221128132915.141211-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221128132915.141211-1-jolsa@kernel.org>
References: <20221128132915.141211-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding tests for using new bpf_vma_build_id_parse kfunc in task_vma
iterator program.

On bpf program side the iterator filters test proccess and proper
vma by provided function pointer and reads its build id with the
new kfunc.

On user side the test uses readelf to get test_progs build id and
compares it with the one read from iterator.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/bpf_iter.c       | 44 +++++++++++++++++++
 .../selftests/bpf/progs/bpf_iter_build_id.c   | 41 +++++++++++++++++
 2 files changed, 85 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_build_id.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 6f8ed61fc4b4..b2cad9f70b32 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -33,6 +33,9 @@
 #include "bpf_iter_bpf_link.skel.h"
 #include "bpf_iter_ksym.skel.h"
 #include "bpf_iter_sockmap.skel.h"
+#include "bpf_iter_build_id.skel.h"
+
+#define BUILDID_STR_SIZE (BPF_BUILD_ID_SIZE*2 + 1)
 
 static int duration;
 
@@ -1560,6 +1563,45 @@ static void test_task_vma_offset(void)
 	test_task_vma_offset_common(NULL, false);
 }
 
+static void test_task_vma_build_id(void)
+{
+	struct bpf_iter_build_id *skel;
+	char buf[BUILDID_STR_SIZE] = {};
+	int iter_fd, len;
+	char *build_id;
+
+	skel = bpf_iter_build_id__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_vma_offset__open_and_load"))
+		return;
+
+	skel->bss->pid = getpid();
+	skel->bss->address = (uintptr_t)trigger_func;
+
+	skel->links.vma_build_id = bpf_program__attach_iter(skel->progs.vma_build_id, NULL);
+	if (!ASSERT_OK_PTR(skel->links.vma_build_id, "attach_iter"))
+		goto exit;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(skel->links.vma_build_id));
+	if (!ASSERT_GT(iter_fd, 0, "create_iter"))
+		goto exit;
+
+	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
+		;
+	buf[BUILDID_STR_SIZE] = 0;
+
+	/* Read build_id via readelf to compare with iterator buf. */
+	if (!ASSERT_OK(read_self_buildid(&build_id), "read_buildid"))
+		goto exit;
+
+	ASSERT_STREQ(buf, build_id, "build_id_match");
+	ASSERT_GT(skel->data->size, 0, "size");
+
+	free(build_id);
+	close(iter_fd);
+exit:
+	bpf_iter_build_id__destroy(skel);
+}
+
 void test_bpf_iter(void)
 {
 	ASSERT_OK(pthread_mutex_init(&do_nothing_mutex, NULL), "pthread_mutex_init");
@@ -1640,4 +1682,6 @@ void test_bpf_iter(void)
 		test_bpf_sockmap_map_iter_fd();
 	if (test__start_subtest("vma_offset"))
 		test_task_vma_offset();
+	if (test__start_subtest("vma_build_id"))
+		test_task_vma_build_id();
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_build_id.c b/tools/testing/selftests/bpf/progs/bpf_iter_build_id.c
new file mode 100644
index 000000000000..86694ce6a194
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_build_id.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "bpf_iter.h"
+#include <bpf/bpf_helpers.h>
+
+#define BPF_BUILD_ID_SIZE 20
+
+extern int bpf_vma_build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
+				  size_t build_id__sz) __ksym;
+
+char _license[] SEC("license") = "GPL";
+
+uintptr_t address = 0;
+__u32 pid = 0;
+int size = -1;
+
+static unsigned char build_id[BPF_BUILD_ID_SIZE];
+
+SEC("iter/task_vma")
+int vma_build_id(struct bpf_iter__task_vma *ctx)
+{
+	struct vm_area_struct *vma = ctx->vma;
+	struct seq_file *seq = ctx->meta->seq;
+	struct task_struct *task = ctx->task;
+	int i;
+
+	if (task == NULL || vma == NULL)
+		return 0;
+
+	if (task->tgid != pid)
+		return 0;
+
+	if (address < vma->vm_start || vma->vm_end < address)
+		return 0;
+
+	size = bpf_vma_build_id_parse(vma, build_id, sizeof(build_id));
+
+	for (i = 0; i < BPF_BUILD_ID_SIZE; i++)
+		BPF_SEQ_PRINTF(seq, "%02x", build_id[i]);
+	return 0;
+}
-- 
2.38.1

