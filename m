Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201FD625620
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 10:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbiKKJEF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 04:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbiKKJDp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 04:03:45 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCE682C4B
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 01:01:04 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N7t3G6Wz3z4f3w24
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 17:00:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgC329hLD25jbi9eAQ--.31717S5;
        Fri, 11 Nov 2022 17:01:01 +0800 (CST)
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
Subject: [PATCH bpf 1/4] libbpf: Adjust ring buffer size when probing ring buffer map
Date:   Fri, 11 Nov 2022 17:26:39 +0800
Message-Id: <20221111092642.2333724-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221111092642.2333724-1-houtao@huaweicloud.com>
References: <20221111092642.2333724-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC329hLD25jbi9eAQ--.31717S5
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4fZw17AFWUCrWftr45Awb_yoW8urWxpr
        sYkryrCr1S9w48CFyDWr1FgFWYkrsrWr48G34xXw1YvF4UXFsrKr1IkFWayry3X3yDGw15
        urZ09ry8A3y8XrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2mL9UUUUU
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

Adjusting the size of ring buffer when probing ring buffer map, else
the probe may fail on host with 64KB page size (e.g., an ARM64 host).

After the fix, the output of "bpftool feature" on above host will be
correct.

Before :
    eBPF map_type ringbuf is NOT available
    eBPF map_type user_ringbuf is NOT available

After :
    eBPF map_type ringbuf is available
    eBPF map_type user_ringbuf is available

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/lib/bpf/libbpf.c          | 2 +-
 tools/lib/bpf/libbpf_internal.h | 2 ++
 tools/lib/bpf/libbpf_probes.c   | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 184ce1684dcd..907f735568ae 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2353,7 +2353,7 @@ int parse_btf_map_def(const char *map_name, struct btf *btf,
 	return 0;
 }
 
-static size_t adjust_ringbuf_sz(size_t sz)
+size_t adjust_ringbuf_sz(size_t sz)
 {
 	__u32 page_sz = sysconf(_SC_PAGE_SIZE);
 	__u32 mul;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 377642ff51fc..99dc4d6a19be 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -576,4 +576,6 @@ static inline bool is_pow_of_2(size_t x)
 #define PROG_LOAD_ATTEMPTS 5
 int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int attempts);
 
+size_t adjust_ringbuf_sz(size_t sz);
+
 #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index f3a8e8e74eb8..29a1db2645fd 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -234,7 +234,7 @@ static int probe_map_create(enum bpf_map_type map_type)
 	case BPF_MAP_TYPE_USER_RINGBUF:
 		key_size = 0;
 		value_size = 0;
-		max_entries = 4096;
+		max_entries = adjust_ringbuf_sz(4096);
 		break;
 	case BPF_MAP_TYPE_STRUCT_OPS:
 		/* we'll get -ENOTSUPP for invalid BTF type ID for struct_ops */
-- 
2.29.2

