Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120E662B398
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 07:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiKPG6T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 01:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiKPG6S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 01:58:18 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57389BE07
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 22:58:17 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NBv5H5nv6z4f3v79
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 14:58:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDH69gBinRjrfhyAg--.6637S6;
        Wed, 16 Nov 2022 14:58:14 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        David Vernet <void@manifault.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Subject: [PATCH bpf v2 2/4] libbpf: Handle size overflow for ringbuf mmap
Date:   Wed, 16 Nov 2022 15:23:49 +0800
Message-Id: <20221116072351.1168938-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221116072351.1168938-1-houtao@huaweicloud.com>
References: <20221116072351.1168938-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDH69gBinRjrfhyAg--.6637S6
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWxuFWrXw15GFW5Jw1xuFg_yoW8AF4Upa
        1S934UGFs3Zr18Aw1Du3yvv390kFZ2qr47GrZ7Jw1rZr1UXFsFqrn8KFW5Ary7JrWkKrWI
        9rWqgFyvkr1jqrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
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
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1sa9DUUUUU==
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

The maximum size of ringbuf is 2GB on x86-64 host, so 2 * max_entries
will overflow u32 when mapping producer page and data pages. Only
casting max_entries to size_t is not enough, because for 32-bits
application on 64-bits kernel the size of read-only mmap region
also could overflow size_t.

So fixing it by casting the size of read-only mmap region into a __u64
and checking whether or not there will be overflow during mmap.

Fixes: bf99c936f947 ("libbpf: Add BPF ring buffer support")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/lib/bpf/ringbuf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index d285171d4b69..5b1dc8794b06 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -77,6 +77,7 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 	__u32 len = sizeof(info);
 	struct epoll_event *e;
 	struct ring *r;
+	__u64 mmap_sz;
 	void *tmp;
 	int err;
 
@@ -129,8 +130,14 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 	 * data size to allow simple reading of samples that wrap around the
 	 * end of a ring buffer. See kernel implementation for details.
 	 * */
-	tmp = mmap(NULL, rb->page_size + 2 * info.max_entries, PROT_READ,
-		   MAP_SHARED, map_fd, rb->page_size);
+	mmap_sz = rb->page_size + 2 * (__u64)info.max_entries;
+	if (mmap_sz != (__u64)(size_t)mmap_sz) {
+		pr_warn("ringbuf: ring buffer size (%u) is too big\n",
+			info.max_entries);
+		return libbpf_err(-E2BIG);
+	}
+	tmp = mmap(NULL, (size_t)mmap_sz, PROT_READ, MAP_SHARED, map_fd,
+		   rb->page_size);
 	if (tmp == MAP_FAILED) {
 		err = -errno;
 		ringbuf_unmap_ring(rb, r);
-- 
2.29.2

