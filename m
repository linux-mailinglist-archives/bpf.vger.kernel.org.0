Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D89D61EB94
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 08:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiKGHSS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 02:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiKGHR5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 02:17:57 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B66614034
        for <bpf@vger.kernel.org>; Sun,  6 Nov 2022 23:16:45 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N5Mwl3cjsz4f43wP
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:16:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgC329jWsGhjUEl6AA--.47516S7;
        Mon, 07 Nov 2022 15:16:42 +0800 (CST)
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
Subject: [PATCH bpf 3/3] selftests/bpf: Add test for cgroup iterator on a dead cgroup
Date:   Mon,  7 Nov 2022 15:42:22 +0800
Message-Id: <20221107074222.1323017-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221107074222.1323017-1-houtao@huaweicloud.com>
References: <20221107074222.1323017-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC329jWsGhjUEl6AA--.47516S7
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1DAw1rCF1fKF1UWryrtFb_yoW5try8pF
        ykJ345tw1rXr45Wr48Ga4j9FWFyF48Zw1UXrWxJrW5ArnxXw12gw1IkFySyFnxCF9xZr1a
        vr1YyayrCF10vF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
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

The test closes both iterator link fd and cgroup fd, and removes the
cgroup file to make a dead cgroup before reading cgroup iterator fd. It
also uses kern_sync_rcu() and usleep() to wait for the release of
start cgroup. If the start cgroup is not pinned by cgroup iterator,
reading iterator fd will trigger use-after-free.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/prog_tests/cgroup_iter.c    | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c b/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
index c4a2adb38da1..d64ed1cf1554 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
@@ -189,6 +189,82 @@ static void test_walk_self_only(struct cgroup_iter *skel)
 			      BPF_CGROUP_ITER_SELF_ONLY, "self_only");
 }
 
+static void test_walk_dead_self_only(struct cgroup_iter *skel)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	char expected_output[128], buf[128];
+	const char *cgrp_name = "/dead";
+	union bpf_iter_link_info linfo;
+	int len, cgrp_fd, iter_fd;
+	struct bpf_link *link;
+	size_t left;
+	char *p;
+
+	cgrp_fd = create_and_get_cgroup(cgrp_name);
+	if (!ASSERT_GE(cgrp_fd, 0, "create cgrp"))
+		return;
+
+	/* The cgroup is already dead during iteration, so it only has epilogue
+	 * in the output.
+	 */
+	snprintf(expected_output, sizeof(expected_output), EPILOGUE);
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.cgroup.cgroup_fd = cgrp_fd;
+	linfo.cgroup.order = BPF_CGROUP_ITER_SELF_ONLY;
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+
+	link = bpf_program__attach_iter(skel->progs.cgroup_id_printer, &opts);
+	if (!ASSERT_OK_PTR(link, "attach_iter"))
+		goto close_cg;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_GE(iter_fd, 0, "iter_create"))
+		goto free_link;
+
+	/* Close link fd and cgroup fd */
+	bpf_link__destroy(link);
+	link = NULL;
+	close(cgrp_fd);
+	cgrp_fd = -1;
+
+	/* Remove cgroup to mark it as dead */
+	remove_cgroup(cgrp_name);
+
+	/* Two kern_sync_rcu() and usleep() pair are used to wait for the
+	 * releases of cgroup css, and the last kern_sync_rcu() and usleep()
+	 * pair is used to wait for the free of cgroup itself.
+	 */
+	kern_sync_rcu();
+	usleep(8000);
+	kern_sync_rcu();
+	usleep(8000);
+	kern_sync_rcu();
+	usleep(1000);
+
+	memset(buf, 0, sizeof(buf));
+	left = ARRAY_SIZE(buf);
+	p = buf;
+	while ((len = read(iter_fd, p, left)) > 0) {
+		p += len;
+		left -= len;
+	}
+
+	ASSERT_STREQ(buf, expected_output, "dead cgroup output");
+
+	/* read() after iter finishes should be ok. */
+	if (len == 0)
+		ASSERT_OK(read(iter_fd, buf, sizeof(buf)), "second_read");
+
+	close(iter_fd);
+free_link:
+	bpf_link__destroy(link);
+close_cg:
+	if (cgrp_fd >= 0)
+		close(cgrp_fd);
+}
+
 void test_cgroup_iter(void)
 {
 	struct cgroup_iter *skel = NULL;
@@ -217,6 +293,8 @@ void test_cgroup_iter(void)
 		test_early_termination(skel);
 	if (test__start_subtest("cgroup_iter__self_only"))
 		test_walk_self_only(skel);
+	if (test__start_subtest("cgroup_iter_dead_self_only"))
+		test_walk_dead_self_only(skel);
 out:
 	cgroup_iter__destroy(skel);
 	cleanup_cgroups();
-- 
2.29.2

