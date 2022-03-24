Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62654E6B49
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 00:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356100AbiCXXoM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Mar 2022 19:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356450AbiCXXnF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Mar 2022 19:43:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0AA27CFB
        for <bpf@vger.kernel.org>; Thu, 24 Mar 2022 16:41:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i5-20020a258b05000000b006347131d40bso4710045ybl.17
        for <bpf@vger.kernel.org>; Thu, 24 Mar 2022 16:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Fvc6J6M6wcnrLQYRH6BhKAfsqygwLe3UGholaX7FMA0=;
        b=qwc6aIu5Ovc+0GN2azCLlUlH2jfPiydIUMXBP/9wtLJp8BKskc9/DY2+dCmr0NLdx5
         CzW10s1Kb6fzMKDh7Sw3PF1JYO84FG1kyfULFPQI5D/xYr+frrv9ObUJ67LBoFWDI6hj
         OOaMseMGnEg5OVT6ajCRQ4pY3FwwP5OblzYsfwrussZTcHfXPzKZ+KLs613k8ud5i3EG
         o1OK7th6NWrLoDhkua8yon0Y9Ew/cesv62AkwEHWcxBHjIeQ87zgwRjEHpOScmRzwHkt
         pDaC+xoAmSjXzeS8gBkEHSz7yuLJ9VN5/7ufq6373j64IHyxT0KWeSAaZROGMnAIY5K/
         JMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Fvc6J6M6wcnrLQYRH6BhKAfsqygwLe3UGholaX7FMA0=;
        b=WClSeLDCyxFcjhgGhuYY+2auNNfTEuXaXPjNaR5scUgZU0XHc9h5xXsr8JCvayiRhQ
         06Qj9uYH/Y8imVvoLTFlvz/MVymfKse125LC2oZh/bgr2XLOX8jRol1OxQv5oxm+D7QB
         BaQxDkc0Lavcgz8o3GhCaeaiKaRnv9JHZlYb9pjorotsHylD02plcB72QIagccV/qru0
         J/y1Vkt+AufFGqckDJsI5yUY8pt9gq2zVv83oYpJcYD/5Xl09+VghwHwTUFB/mFz4/8a
         jWCiZ8ALLKOfxhX6wlKugcUsSqtLzSpNceZsBPKk74TuSBlIN9xyslDgjB84MCNSDPAJ
         42ZQ==
X-Gm-Message-State: AOAM531TyO8vFj2QK6KyeDhv8NjR2qAFzZZRFdm+s3vuRFhcg1WuQAUA
        wtQD/MIjKyIpswPnhNgtbmtKQPDSi0Q=
X-Google-Smtp-Source: ABdhPJzbLWng5ePUh2h4yTHDw5MikqqEhBkzdNWfUsNQmPt0KjRTRPPBspbB/2lcY6syjTsOHEFYmJog1Ew=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:f3eb:bf7b:2da4:12c9])
 (user=haoluo job=sendgmr) by 2002:a81:5545:0:b0:2e5:a302:4739 with SMTP id
 j66-20020a815545000000b002e5a3024739mr7412732ywb.348.1648165292087; Thu, 24
 Mar 2022 16:41:32 -0700 (PDT)
Date:   Thu, 24 Mar 2022 16:41:23 -0700
In-Reply-To: <20220324234123.1608337-1-haoluo@google.com>
Message-Id: <20220324234123.1608337-3-haoluo@google.com>
Mime-Version: 1.0
References: <20220324234123.1608337-1-haoluo@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH RFC bpf-next 2/2] selftests/bpf: Test mmapable task local storage.
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     yhs@fb.com, KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Tests mmapable task local storage.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 .../bpf/prog_tests/task_local_storage.c       | 38 +++++++++++++++++++
 .../bpf/progs/task_local_storage_mmapable.c   | 38 +++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/task_local_storage_mmapable.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index 035c263aab1b..24e6edd32a78 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -6,8 +6,10 @@
 #include <sys/syscall.h>   /* For SYS_xxx definitions */
 #include <sys/types.h>
 #include <test_progs.h>
+#include <sys/mman.h>
 #include "task_local_storage.skel.h"
 #include "task_local_storage_exit_creds.skel.h"
+#include "task_local_storage_mmapable.skel.h"
 #include "task_ls_recursion.skel.h"
 
 static void test_sys_enter_exit(void)
@@ -81,6 +83,40 @@ static void test_recursion(void)
 	task_ls_recursion__destroy(skel);
 }
 
+#define MAGIC_VALUE 0xabcd1234
+
+static void test_mmapable(void)
+{
+	struct task_local_storage_mmapable *skel;
+	const long page_size = sysconf(_SC_PAGE_SIZE);
+	int fd, err;
+	void *ptr;
+
+	skel = task_local_storage_mmapable__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	fd = bpf_map__fd(skel->maps.mmapable_map);
+	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (!ASSERT_NEQ(ptr, MAP_FAILED, "mmap"))
+		goto out;
+
+	skel->bss->target_pid = syscall(SYS_gettid);
+
+	err = task_local_storage_mmapable__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto unmap;
+
+	syscall(SYS_gettid);
+
+	ASSERT_EQ(*(u64 *)ptr, MAGIC_VALUE, "value");
+
+unmap:
+	munmap(ptr, page_size);
+out:
+	task_local_storage_mmapable__destroy(skel);
+}
+
 void test_task_local_storage(void)
 {
 	if (test__start_subtest("sys_enter_exit"))
@@ -89,4 +125,6 @@ void test_task_local_storage(void)
 		test_exit_creds();
 	if (test__start_subtest("recursion"))
 		test_recursion();
+	if (test__start_subtest("mmapable"))
+		test_mmapable();
 }
diff --git a/tools/testing/selftests/bpf/progs/task_local_storage_mmapable.c b/tools/testing/selftests/bpf/progs/task_local_storage_mmapable.c
new file mode 100644
index 000000000000..8cd82bb7336a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_local_storage_mmapable.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Google */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC | BPF_F_MMAPABLE);
+	__type(key, int);
+	__type(value, long);
+} mmapable_map SEC(".maps");
+
+#define MAGIC_VALUE 0xabcd1234
+
+pid_t target_pid = 0;
+
+SEC("tp_btf/sys_enter")
+int BPF_PROG(on_enter, struct pt_regs *regs, long id)
+{
+	struct task_struct *task;
+	long *ptr;
+
+	task = bpf_get_current_task_btf();
+	if (task->pid != target_pid)
+		return 0;
+
+	ptr = bpf_task_storage_get(&mmapable_map, task, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!ptr)
+		return 0;
+
+	*ptr = MAGIC_VALUE;
+	return 0;
+}
-- 
2.35.1.1021.g381101b075-goog

