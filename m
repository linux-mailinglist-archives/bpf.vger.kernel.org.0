Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFC05A8DE6
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 08:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiIAGBn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 02:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbiIAGBj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 02:01:39 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8760E3438
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 23:01:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MJ9P43VQBzKPyj
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 13:59:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDHGXO5ShBjaMHaAA--.4132S7;
        Thu, 01 Sep 2022 14:01:34 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hao Sun <sunhao.th@gmail.com>, Hao Luo <haoluo@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: Move sys_pidfd_open() into task_local_storage_helpers.h
Date:   Thu,  1 Sep 2022 14:19:37 +0800
Message-Id: <20220901061938.3789460-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220901061938.3789460-1-houtao@huaweicloud.com>
References: <20220901061938.3789460-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHGXO5ShBjaMHaAA--.4132S7
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWxZw4kAF4UZFy8CrWfXwb_yoW5Ww1fp3
        ykAF15tF1xA3WSqan7GF4aqa1Sqa1kAr45Cr4rtr97ZrsrJr97Wr4xKFyrZF93G3yFvr4f
        Z34Sgr15Cw4UZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

sys_pidfd_open() is defined twice in both test_bprm_opts.c and
test_local_storage.c, so move it to a common header file. And it will be
used in map_tests as well.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/prog_tests/test_bprm_opts.c  | 10 +---------
 .../bpf/prog_tests/test_local_storage.c        | 10 +---------
 .../selftests/bpf/task_local_storage_helpers.h | 18 ++++++++++++++++++
 3 files changed, 20 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/task_local_storage_helpers.h

diff --git a/tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c b/tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c
index 2559bb775762..a0054019e677 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c
@@ -9,18 +9,10 @@
 
 #include "bprm_opts.skel.h"
 #include "network_helpers.h"
-
-#ifndef __NR_pidfd_open
-#define __NR_pidfd_open 434
-#endif
+#include "task_local_storage_helpers.h"
 
 static const char * const bash_envp[] = { "TMPDIR=shouldnotbeset", NULL };
 
-static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
-{
-	return syscall(__NR_pidfd_open, pid, flags);
-}
-
 static int update_storage(int map_fd, int secureexec)
 {
 	int task_fd, ret = 0;
diff --git a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
index 26ac26a88026..9c77cd6b1eaf 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
@@ -11,15 +11,7 @@
 
 #include "local_storage.skel.h"
 #include "network_helpers.h"
-
-#ifndef __NR_pidfd_open
-#define __NR_pidfd_open 434
-#endif
-
-static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
-{
-	return syscall(__NR_pidfd_open, pid, flags);
-}
+#include "task_local_storage_helpers.h"
 
 static unsigned int duration;
 
diff --git a/tools/testing/selftests/bpf/task_local_storage_helpers.h b/tools/testing/selftests/bpf/task_local_storage_helpers.h
new file mode 100644
index 000000000000..711d5abb7d51
--- /dev/null
+++ b/tools/testing/selftests/bpf/task_local_storage_helpers.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __TASK_LOCAL_STORAGE_HELPER_H
+#define __TASK_LOCAL_STORAGE_HELPER_H
+
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+
+#ifndef __NR_pidfd_open
+#define __NR_pidfd_open 434
+#endif
+
+static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
+{
+	return syscall(__NR_pidfd_open, pid, flags);
+}
+
+#endif
-- 
2.29.2

