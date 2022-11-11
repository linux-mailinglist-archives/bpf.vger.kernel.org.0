Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20101625364
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 07:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbiKKGIr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 01:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiKKGIo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 01:08:44 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080D4B1FA
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 22:08:42 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N7pDN3CV2z4f3vdf
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 14:08:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDH69ji5m1jjmBXAQ--.18964S7;
        Fri, 11 Nov 2022 14:08:39 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Yonghong Song <yhs@fb.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Subject: [PATCH bpf v2 3/3] selftests/bpf: Add test for cgroup iterator on a dead cgroup
Date:   Fri, 11 Nov 2022 14:34:17 +0800
Message-Id: <20221111063417.1603111-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221111063417.1603111-1-houtao@huaweicloud.com>
References: <20221111063417.1603111-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDH69ji5m1jjmBXAQ--.18964S7
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4fGr17Gw1xGrWDKr1xZrb_yoW5trWDpF
        ykJ34Utw1rXr45ur48tayY9FWFyF48Zw1UZrWxGrW5ArnxXw12gw1IkFyFyFnxCF9Fvr1a
        vr1YyayrCF10vFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
cgroup file to make a dead cgroup before reading from cgroup iterator.
It also uses kern_sync_rcu() and usleep() to wait for the release of
start cgroup. If the start cgroup is not pinned by cgroup iterator,
reading from iterator fd will trigger use-after-free.

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/prog_tests/cgroup_iter.c    | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c b/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
index c4a2adb38da1..e02feb5fae97 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
@@ -189,6 +189,80 @@ static void test_walk_self_only(struct cgroup_iter *skel)
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
+	/* The cgroup will be dead during read() iteration, so it only has
+	 * epilogue in the output
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
+		goto close_cgrp;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_GE(iter_fd, 0, "iter_create"))
+		goto free_link;
+
+	/* Close link fd and cgroup fd */
+	bpf_link__destroy(link);
+	close(cgrp_fd);
+
+	/* Remove cgroup to mark it as dead */
+	remove_cgroup(cgrp_name);
+
+	/* Two kern_sync_rcu() and usleep() pairs are used to wait for the
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
+	return;
+free_link:
+	bpf_link__destroy(link);
+close_cgrp:
+	close(cgrp_fd);
+}
+
 void test_cgroup_iter(void)
 {
 	struct cgroup_iter *skel = NULL;
@@ -217,6 +291,8 @@ void test_cgroup_iter(void)
 		test_early_termination(skel);
 	if (test__start_subtest("cgroup_iter__self_only"))
 		test_walk_self_only(skel);
+	if (test__start_subtest("cgroup_iter__dead_self_only"))
+		test_walk_dead_self_only(skel);
 out:
 	cgroup_iter__destroy(skel);
 	cleanup_cgroups();
-- 
2.29.2

