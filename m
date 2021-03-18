Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B3C33FC5F
	for <lists+bpf@lfdr.de>; Thu, 18 Mar 2021 01:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhCRApg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Mar 2021 20:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhCRApZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Mar 2021 20:45:25 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C1AC06174A
        for <bpf@vger.kernel.org>; Wed, 17 Mar 2021 17:45:25 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so6049411pjb.0
        for <bpf@vger.kernel.org>; Wed, 17 Mar 2021 17:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xNKAxLiv56VMx5hUUy/0ykFGK1+FbITlQeQlud3BAfg=;
        b=mhGwUCd2G64Dy/QPfAXjLMPEkfJtFeLgGkaRl0E23PPL1lDr3xa75+kF1kdWWZvIvm
         4sqW5CBNIC4EqkGdoDxH/x/lyXO0pBBbKe7SYKpcKtp+prMkMt9oxFxmkaupzDPMl6+x
         Jc6NWHKig995rKNJn4XE4PXI85RsfTVnlRYPxX4URz1tMmTQ68xPC3EwmxXdtPGQZPlF
         1RZFxIzSHrGdaOcBsVVd8epUt9r9k3kO5KhGGOhm97B6w6++YcBoWbSq9RfjeSRKdQBk
         OqjJC117oTl3D7rsU1nKENeEehXclf+CA9zom5+AyEfYDXSa9mcBoYMFC6pPp+GYKt35
         DYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xNKAxLiv56VMx5hUUy/0ykFGK1+FbITlQeQlud3BAfg=;
        b=Plg6ruH4MXOTazoxeEizgBHQRvEOxHSEFABqgKVKa7eGn/6jYWlSovfOrqb9X/0Sqt
         3E1DvJqmpaXZzreUGqnENnkIuZdA/vCSS97+uaRSoU2y5wRlQioSrFJ9WSJpedvMYyHA
         3P8KMsGTT5HTbjligzS9/WiJFUJBhjSkqCo/a0d8CE+5jVpqTiEE2f58LH5i4dwwg4+d
         jCej4Rhem+CAcP6ZwUW2xlkjXncSGtr40rYtUH5LkaWiLia/W2Qn6vWKLuTDw1Pqmnww
         YjRerWF0jXiXB1Mt1dMzE/qWp8ZWg8fulbk54hMQzqsP+RoirI8yR4L6JTkrN46zWp1f
         Fvew==
X-Gm-Message-State: AOAM5316j/3Vengo+KZ8qTwx6Eop3itl/BxmGHc3dV41Hh0GC1t/h+gt
        6u76x+jFFD2g1O3hELhqPH4=
X-Google-Smtp-Source: ABdhPJxIniWhyZkVm7NIHWSa/0sMxpROdUVF1mkDMmEplDMFggrV5YZViJ5mvtqkb4MwKabBNtZbVA==
X-Received: by 2002:a17:902:c14c:b029:e5:cd82:a0b with SMTP id 12-20020a170902c14cb02900e5cd820a0bmr6979844plj.34.1616028324760;
        Wed, 17 Mar 2021 17:45:24 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id u24sm237539pfm.214.2021.03.17.17.45.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Mar 2021 17:45:24 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, paulmck@kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf] selftest/bpf: Add a test to check trampoline freeing logic.
Date:   Wed, 17 Mar 2021 17:45:23 -0700
Message-Id: <20210318004523.55908-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Add a selfttest for commit e21aa341785c ("bpf: Fix fexit trampoline.")
to make sure that attaching fexit prog to a sleeping kernel function
will trigger appropriate trampoline and program destruction.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/fexit_sleep.c    | 82 +++++++++++++++++++
 .../testing/selftests/bpf/progs/fexit_sleep.c | 31 +++++++
 2 files changed, 113 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fexit_sleep.c
 create mode 100644 tools/testing/selftests/bpf/progs/fexit_sleep.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_sleep.c b/tools/testing/selftests/bpf/prog_tests/fexit_sleep.c
new file mode 100644
index 000000000000..6c4d42a2386f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_sleep.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#define _GNU_SOURCE
+#include <sched.h>
+#include <test_progs.h>
+#include <time.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include "fexit_sleep.skel.h"
+
+static int do_sleep(void *skel)
+{
+	struct fexit_sleep *fexit_skel = skel;
+	struct timespec ts1 = { .tv_nsec = 1 };
+	struct timespec ts2 = { .tv_sec = 10 };
+
+	fexit_skel->bss->pid = getpid();
+	(void)syscall(__NR_nanosleep, &ts1, NULL);
+	(void)syscall(__NR_nanosleep, &ts2, NULL);
+	return 0;
+}
+
+#define STACK_SIZE (1024 * 1024)
+static char child_stack[STACK_SIZE];
+
+void test_fexit_sleep(void)
+{
+	struct fexit_sleep *fexit_skel = NULL;
+	int wstatus, duration = 0;
+	pid_t cpid;
+	int err, fexit_cnt;
+
+	fexit_skel = fexit_sleep__open_and_load();
+	if (CHECK(!fexit_skel, "fexit_skel_load", "fexit skeleton failed\n"))
+		goto cleanup;
+
+	err = fexit_sleep__attach(fexit_skel);
+	if (CHECK(err, "fexit_attach", "fexit attach failed: %d\n", err))
+		goto cleanup;
+
+	cpid = clone(do_sleep, child_stack + STACK_SIZE, CLONE_FILES | SIGCHLD, fexit_skel);
+	if (CHECK(cpid == -1, "clone", strerror(errno)))
+		goto cleanup;
+
+	/* wait until first sys_nanosleep ends and second sys_nanosleep starts */
+	while (READ_ONCE(fexit_skel->bss->fentry_cnt) != 2);
+	fexit_cnt = READ_ONCE(fexit_skel->bss->fexit_cnt);
+	if (CHECK(fexit_cnt != 1, "fexit_cnt", "%d", fexit_cnt))
+		goto cleanup;
+
+	/* close progs and detach them. That will trigger two nop5->jmp5 rewrites
+	 * in the trampolines to skip nanosleep_fexit prog.
+	 * The nanosleep_fentry prog will get detached first.
+	 * The nanosleep_fexit prog will get detached second.
+	 * Detaching will trigger freeing of both progs JITed images.
+	 * There will be two dying bpf_tramp_image-s, but only the initial
+	 * bpf_tramp_image (with both _fentry and _fexit progs will be stuck
+	 * waiting for percpu_ref_kill to confirm). The other one
+	 * will be freed quickly.
+	 */
+	close(bpf_program__fd(fexit_skel->progs.nanosleep_fentry));
+	close(bpf_program__fd(fexit_skel->progs.nanosleep_fexit));
+	fexit_sleep__detach(fexit_skel);
+
+	/* kill the thread to unwind sys_nanosleep stack through the trampoline */
+	kill(cpid, 9);
+
+	if (CHECK(waitpid(cpid, &wstatus, 0) == -1, "waitpid", strerror(errno)))
+		goto cleanup;
+	if (CHECK(WEXITSTATUS(wstatus) != 0, "exitstatus", "failed"))
+		goto cleanup;
+
+	/* The bypassed nanosleep_fexit prog shouldn't have executed.
+	 * Unlike progs the maps were not freed and directly accessible.
+	 */
+	fexit_cnt = READ_ONCE(fexit_skel->bss->fexit_cnt);
+	if (CHECK(fexit_cnt != 1, "fexit_cnt", "%d", fexit_cnt))
+		goto cleanup;
+
+cleanup:
+	fexit_sleep__destroy(fexit_skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/fexit_sleep.c b/tools/testing/selftests/bpf/progs/fexit_sleep.c
new file mode 100644
index 000000000000..03a672d76353
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fexit_sleep.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char LICENSE[] SEC("license") = "GPL";
+
+int pid = 0;
+int fentry_cnt = 0;
+int fexit_cnt = 0;
+
+SEC("fentry/__x64_sys_nanosleep")
+int BPF_PROG(nanosleep_fentry, const struct pt_regs *regs)
+{
+	if ((int)bpf_get_current_pid_tgid() != pid)
+		return 0;
+
+	fentry_cnt++;
+	return 0;
+}
+
+SEC("fexit/__x64_sys_nanosleep")
+int BPF_PROG(nanosleep_fexit, const struct pt_regs *regs, int ret)
+{
+	if ((int)bpf_get_current_pid_tgid() != pid)
+		return 0;
+
+	fexit_cnt++;
+	return 0;
+}
-- 
2.30.2

