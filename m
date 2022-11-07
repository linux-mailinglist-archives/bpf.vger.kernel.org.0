Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285F661EB95
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 08:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiKGHSU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 02:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiKGHR5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 02:17:57 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A7D1573B
        for <bpf@vger.kernel.org>; Sun,  6 Nov 2022 23:16:44 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N5Mwk69F5z4f43vy
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:16:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgC329jWsGhjUEl6AA--.47516S6;
        Mon, 07 Nov 2022 15:16:41 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Tejun Heo <tj@kernel.org>, houtao1@huawei.com
Subject: [PATCH bpf 2/3] selftests/bpf: Add cgroup helper remove_cgroup()
Date:   Mon,  7 Nov 2022 15:42:21 +0800
Message-Id: <20221107074222.1323017-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221107074222.1323017-1-houtao@huaweicloud.com>
References: <20221107074222.1323017-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC329jWsGhjUEl6AA--.47516S6
X-Coremail-Antispam: 1UD129KBjvJXoW7tw47XFy7tr4kJFWkArWkWFg_yoW8tFyfpa
        1kJr13Ka4rKF17Xw18t34qga1rKF4kXrWUG340qr4UZanrJryxXr4SyFyYqFy5JFZaqrZx
        Ar1S9w1kCF1Ut3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFa9-UUUUU
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

Add remove_cgroup() to remove a cgroup which doesn't have any children
or live processes. It will be used by the following patch to test cgroup
iterator on a dead cgroup.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 19 +++++++++++++++++++
 tools/testing/selftests/bpf/cgroup_helpers.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index e914cc45b766..d1fef58b41c7 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -332,6 +332,25 @@ int get_root_cgroup(void)
 	return fd;
 }
 
+/*
+ * remove_cgroup() - Remove a cgroup
+ * @relative_path: The cgroup path, relative to the workdir, to remove
+ *
+ * This function expects a cgroup to already be created, relative to the cgroup
+ * work dir. It also expects the cgroup doesn't have any children or live
+ * processes and it removes the cgroup.
+ *
+ * On failure, it will print an error to stderr.
+ */
+void remove_cgroup(const char *relative_path)
+{
+	char cgroup_path[PATH_MAX + 1];
+
+	format_cgroup_path(cgroup_path, relative_path);
+	if (rmdir(cgroup_path))
+		log_err("rmdiring cgroup %s .. %s", relative_path, cgroup_path);
+}
+
 /**
  * create_and_get_cgroup() - Create a cgroup, relative to workdir, and get the FD
  * @relative_path: The cgroup path, relative to the workdir, to join
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing/selftests/bpf/cgroup_helpers.h
index 3358734356ab..f099a166c94d 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -18,6 +18,7 @@ int write_cgroup_file_parent(const char *relative_path, const char *file,
 int cgroup_setup_and_join(const char *relative_path);
 int get_root_cgroup(void);
 int create_and_get_cgroup(const char *relative_path);
+void remove_cgroup(const char *relative_path);
 unsigned long long get_cgroup_id(const char *relative_path);
 
 int join_cgroup(const char *relative_path);
-- 
2.29.2

