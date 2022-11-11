Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03AF62561D
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 10:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiKKJEE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 04:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiKKJDp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 04:03:45 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976CC10B68
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 01:01:05 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N7t3J0Sh6z4f3wZC
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 17:01:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgC329hLD25jbi9eAQ--.31717S7;
        Fri, 11 Nov 2022 17:01:03 +0800 (CST)
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
Subject: [PATCH bpf 3/4] libbpf: Handle size overflow for user ringbuf mmap
Date:   Fri, 11 Nov 2022 17:26:41 +0800
Message-Id: <20221111092642.2333724-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221111092642.2333724-1-houtao@huaweicloud.com>
References: <20221111092642.2333724-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC329hLD25jbi9eAQ--.31717S7
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWkGr4fKr1UXr13Cr1fCrg_yoW8Ar47pa
        13Kr1xJF4fXr18Zw1UuayIvry5ZFZ2qr4xGFZ7Gw1Fvw15XFsIqF109FWYkF4UXrWkGF1I
        krZ09Fy8Gw1jqw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
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

Similar with the overflow problem on ringbuf mmap, in user_ringbuf_map()
2 * max_entries may overflow u32 when mapping writeable region.

Fixing it by casting the size of writable mmap region into a __u64 and
checking whether or not there will be overflow during mmap.

Fixes: b66ccae01f1d ("bpf: Add libbpf logic for user-space ring buffer")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/lib/bpf/ringbuf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index c4bdc88af672..b34e61c538d7 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -355,6 +355,7 @@ static int user_ringbuf_map(struct user_ring_buffer *rb, int map_fd)
 {
 	struct bpf_map_info info;
 	__u32 len = sizeof(info);
+	__u64 wr_size;
 	void *tmp;
 	struct epoll_event *rb_epoll;
 	int err;
@@ -391,8 +392,14 @@ static int user_ringbuf_map(struct user_ring_buffer *rb, int map_fd)
 	 * simple reading and writing of samples that wrap around the end of
 	 * the buffer.  See the kernel implementation for details.
 	 */
-	tmp = mmap(NULL, rb->page_size + 2 * info.max_entries,
-		   PROT_READ | PROT_WRITE, MAP_SHARED, map_fd, rb->page_size);
+	wr_size = rb->page_size + 2 * (__u64)info.max_entries;
+	if (wr_size != (__u64)(size_t)wr_size) {
+		pr_warn("user ringbuf: ring buf size (%u) is too big\n",
+			info.max_entries);
+		return -E2BIG;
+	}
+	tmp = mmap(NULL, (size_t)wr_size, PROT_READ | PROT_WRITE, MAP_SHARED,
+		   map_fd, rb->page_size);
 	if (tmp == MAP_FAILED) {
 		err = -errno;
 		pr_warn("user ringbuf: failed to mmap data pages for map fd=%d: %d\n",
-- 
2.29.2

