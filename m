Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066195FAD07
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 08:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJKGrC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 02:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiJKGrB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 02:47:01 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2056F1C43F
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 23:47:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MmmVl07V7zl5kr
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 14:45:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAnJ8lhEUVjGGlfAA--.22272S4;
        Tue, 11 Oct 2022 14:46:58 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Subject: [PATCH bpf-next] selftests/bpf: Use sys_pidfd_open() helper when possible
Date:   Tue, 11 Oct 2022 15:12:49 +0800
Message-Id: <20221011071249.3471760-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnJ8lhEUVjGGlfAA--.22272S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zry5KrWkJr4xCry7KrWUCFg_yoW5JF1kpa
        ykAF4qkFyfJa9xJ3ZrCF42g3Waqw1kX345Crn0qr98Zr43Xr93Wr4xKFyrZF1rG3yFvr1f
        Z3ySkr1fCrWUZFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIx
        AIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUo0eHDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

SYS_pidfd_open may be undefined for old glibc, so using sys_pidfd_open()
helper defined in task_local_storage_helpers.h instead to fix potential
build failure.

And according to commit 7615d9e1780e ("arch: wire-up pidfd_open()"), the
syscall number of pidfd_open is always 434 except for alpha architure,
so update the definition of __NR_pidfd_open accordingly.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c      | 10 +++-------
 .../testing/selftests/bpf/task_local_storage_helpers.h |  4 ++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index ecde236047fe..c39d40f4b268 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -3,6 +3,7 @@
 #include <test_progs.h>
 #include <unistd.h>
 #include <sys/syscall.h>
+#include <task_local_storage_helpers.h>
 #include "bpf_iter_ipv6_route.skel.h"
 #include "bpf_iter_netlink.skel.h"
 #include "bpf_iter_bpf_map.skel.h"
@@ -175,11 +176,6 @@ static void test_bpf_map(void)
 	bpf_iter_bpf_map__destroy(skel);
 }
 
-static int pidfd_open(pid_t pid, unsigned int flags)
-{
-	return syscall(SYS_pidfd_open, pid, flags);
-}
-
 static void check_bpf_link_info(const struct bpf_program *prog)
 {
 	LIBBPF_OPTS(bpf_iter_attach_opts, opts);
@@ -295,8 +291,8 @@ static void test_task_pidfd(void)
 	union bpf_iter_link_info linfo;
 	int pidfd;
 
-	pidfd = pidfd_open(getpid(), 0);
-	if (!ASSERT_GT(pidfd, 0, "pidfd_open"))
+	pidfd = sys_pidfd_open(getpid(), 0);
+	if (!ASSERT_GT(pidfd, 0, "sys_pidfd_open"))
 		return;
 
 	memset(&linfo, 0, sizeof(linfo));
diff --git a/tools/testing/selftests/bpf/task_local_storage_helpers.h b/tools/testing/selftests/bpf/task_local_storage_helpers.h
index 711d5abb7d51..281f86132766 100644
--- a/tools/testing/selftests/bpf/task_local_storage_helpers.h
+++ b/tools/testing/selftests/bpf/task_local_storage_helpers.h
@@ -7,8 +7,12 @@
 #include <sys/types.h>
 
 #ifndef __NR_pidfd_open
+#ifdef __alpha__
+#define __NR_pidfd_open 544
+#else
 #define __NR_pidfd_open 434
 #endif
+#endif
 
 static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
 {
-- 
2.29.2

