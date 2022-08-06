Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C39A58B439
	for <lists+bpf@lfdr.de>; Sat,  6 Aug 2022 09:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239628AbiHFHk2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Aug 2022 03:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiHFHk0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Aug 2022 03:40:26 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67757A460
        for <bpf@vger.kernel.org>; Sat,  6 Aug 2022 00:40:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4M0DQW6zmzz6R8K7
        for <bpf@vger.kernel.org>; Sat,  6 Aug 2022 15:20:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDHeVydFu5iXIYHAA--.28679S11;
        Sat, 06 Aug 2022 15:22:11 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, houtao1@huawei.com
Subject: [PATCH bpf 7/9] selftests/bpf: Add tests for reading a dangling map iter fd
Date:   Sat,  6 Aug 2022 15:40:17 +0800
Message-Id: <20220806074019.2756957-8-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220806074019.2756957-1-houtao@huaweicloud.com>
References: <20220806074019.2756957-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHeVydFu5iXIYHAA--.28679S11
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1fuFW3tw1UGr17tw43Jrb_yoW7JFy8pr
        yxJ390kr4rXws7Xr1kJa1Ykr4Yqa1jqa48G3yrG3y5CrsrXrWagr1xGFW8JFn8JrW0vFna
        y34ay3yfGrWUAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUoeOJUUUUU
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

After closing both related link fd and map fd, reading the map
iterator fd to ensure it is OK to do so.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c       | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index a33874b081b6..94c2c8df3fe4 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -28,6 +28,7 @@
 #include "bpf_iter_test_kern6.skel.h"
 #include "bpf_iter_bpf_link.skel.h"
 #include "bpf_iter_ksym.skel.h"
+#include "bpf_iter_sockmap.skel.h"
 
 static int duration;
 
@@ -67,6 +68,48 @@ static void do_dummy_read(struct bpf_program *prog)
 	bpf_link__destroy(link);
 }
 
+static void do_read_map_iter_fd(struct bpf_object_skeleton **skel, struct bpf_program *prog,
+				struct bpf_map *map)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo;
+	struct bpf_link *link;
+	char buf[16] = {};
+	int iter_fd, len;
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.map.map_fd = bpf_map__fd(map);
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+	link = bpf_program__attach_iter(prog, &opts);
+	if (!ASSERT_OK_PTR(link, "attach_map_iter"))
+		return;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_GE(iter_fd, 0, "create_map_iter")) {
+		bpf_link__destroy(link);
+		return;
+	}
+
+	/* Close link and map fd prematurely */
+	bpf_link__destroy(link);
+	bpf_object__destroy_skeleton(*skel);
+	*skel = NULL;
+
+	/* Let kworker to run first */
+	usleep(100);
+	/* Sock map is freed after two synchronize_rcu() calls, so wait */
+	kern_sync_rcu();
+	kern_sync_rcu();
+
+	/* Read after both map fd and link fd are closed */
+	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
+		;
+	ASSERT_GE(len, 0, "read_iterator");
+
+	close(iter_fd);
+}
+
 static int read_fd_into_buffer(int fd, char *buf, int size)
 {
 	int bufleft = size;
@@ -827,6 +870,20 @@ static void test_bpf_array_map(void)
 	bpf_iter_bpf_array_map__destroy(skel);
 }
 
+static void test_bpf_array_map_iter_fd(void)
+{
+	struct bpf_iter_bpf_array_map *skel;
+
+	skel = bpf_iter_bpf_array_map__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_array_map__open_and_load"))
+		return;
+
+	do_read_map_iter_fd(&skel->skeleton, skel->progs.dump_bpf_array_map,
+			    skel->maps.arraymap1);
+
+	bpf_iter_bpf_array_map__destroy(skel);
+}
+
 static void test_bpf_percpu_array_map(void)
 {
 	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
@@ -1009,6 +1066,20 @@ static void test_bpf_sk_storage_get(void)
 	bpf_iter_bpf_sk_storage_helpers__destroy(skel);
 }
 
+static void test_bpf_sk_stoarge_map_iter_fd(void)
+{
+	struct bpf_iter_bpf_sk_storage_map *skel;
+
+	skel = bpf_iter_bpf_sk_storage_map__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_sk_storage_map__open_and_load"))
+		return;
+
+	do_read_map_iter_fd(&skel->skeleton, skel->progs.dump_bpf_sk_storage_map,
+			    skel->maps.sk_stg_map);
+
+	bpf_iter_bpf_sk_storage_map__destroy(skel);
+}
+
 static void test_bpf_sk_storage_map(void)
 {
 	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
@@ -1217,6 +1288,19 @@ static void test_task_vma(void)
 	bpf_iter_task_vma__destroy(skel);
 }
 
+void test_bpf_sockmap_map_iter_fd(void)
+{
+	struct bpf_iter_sockmap *skel;
+
+	skel = bpf_iter_sockmap__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_sockmap__open_and_load"))
+		return;
+
+	do_read_map_iter_fd(&skel->skeleton, skel->progs.copy, skel->maps.sockmap);
+
+	bpf_iter_sockmap__destroy(skel);
+}
+
 void test_bpf_iter(void)
 {
 	if (test__start_subtest("btf_id_or_null"))
@@ -1267,10 +1351,14 @@ void test_bpf_iter(void)
 		test_bpf_percpu_hash_map();
 	if (test__start_subtest("bpf_array_map"))
 		test_bpf_array_map();
+	if (test__start_subtest("bpf_array_map_iter_fd"))
+		test_bpf_array_map_iter_fd();
 	if (test__start_subtest("bpf_percpu_array_map"))
 		test_bpf_percpu_array_map();
 	if (test__start_subtest("bpf_sk_storage_map"))
 		test_bpf_sk_storage_map();
+	if (test__start_subtest("bpf_sk_storage_map_iter_fd"))
+		test_bpf_sk_stoarge_map_iter_fd();
 	if (test__start_subtest("bpf_sk_storage_delete"))
 		test_bpf_sk_storage_delete();
 	if (test__start_subtest("bpf_sk_storage_get"))
@@ -1283,4 +1371,6 @@ void test_bpf_iter(void)
 		test_link_iter();
 	if (test__start_subtest("ksym"))
 		test_ksym_iter();
+	if (test__start_subtest("bpf_sockmap_map_iter_fd"))
+		test_bpf_sockmap_map_iter_fd();
 }
-- 
2.29.2

