Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5796D61ECFD
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 09:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiKGIfV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 03:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiKGIfU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 03:35:20 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FD0140D0;
        Mon,  7 Nov 2022 00:35:18 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N5PgN3cppz4f4G0R;
        Mon,  7 Nov 2022 16:35:12 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP2 (Coremail) with SMTP id Syh0CgBHXrlCw2hjV_t7AA--.38382S2;
        Mon, 07 Nov 2022 16:35:15 +0800 (CST)
From:   Xu Kuohai <xukuohai@huaweicloud.com>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf-next] bpf: Initialize same number of free nodes for each pcpu_freelist
Date:   Mon,  7 Nov 2022 03:50:30 -0500
Message-Id: <20221107085030.3901608-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBHXrlCw2hjV_t7AA--.38382S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyxArWrJr4fXw4UXFyrJFb_yoW8AFWxpF
        4fAw1jqw1vgrn5Wws5G3WrW343t3ykGw13Ga98Kr1Yvry3GFyqvr1vyF4aqFWagF4Ivr4F
        kFsI9FZFyayUXFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Xu Kuohai <xukuohai@huawei.com>

pcpu_freelist_populate() initializes nr_elems / num_possible_cpus() + 1
free nodes for each CPU except the last initialized CPU, always making
the last CPU get fewer free nodes. For example, when nr_elems == 256
and num_possible_cpus() == 32, if CPU 0 is the current cpu, CPU 0~27
each gets 9 free nodes, CPU 28 gets 4 free nodes, CPU 29~31 get 0 free
nodes, while in fact each CPU should get 8 nodes equally.

This patch initializes nr_elems / num_possible_cpus() free nodes for each
CPU firstly, and then allocates the remaining free nodes by one for each
CPU until no free nodes left.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 kernel/bpf/percpu_freelist.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/percpu_freelist.c b/kernel/bpf/percpu_freelist.c
index b6e7f5c5b9ab..89e84f7381cc 100644
--- a/kernel/bpf/percpu_freelist.c
+++ b/kernel/bpf/percpu_freelist.c
@@ -100,12 +100,15 @@ void pcpu_freelist_populate(struct pcpu_freelist *s, void *buf, u32 elem_size,
 			    u32 nr_elems)
 {
 	struct pcpu_freelist_head *head;
-	int i, cpu, pcpu_entries;
+	int i, cpu, pcpu_entries, remain_entries;
+
+	pcpu_entries = nr_elems / num_possible_cpus();
+	remain_entries = nr_elems % num_possible_cpus();
 
-	pcpu_entries = nr_elems / num_possible_cpus() + 1;
 	i = 0;
 
 	for_each_possible_cpu(cpu) {
+		int j = i + pcpu_entries + (remain_entries-- > 0 ? 1 : 0);
 again:
 		head = per_cpu_ptr(s->freelist, cpu);
 		/* No locking required as this is not visible yet. */
@@ -114,7 +117,7 @@ void pcpu_freelist_populate(struct pcpu_freelist *s, void *buf, u32 elem_size,
 		buf += elem_size;
 		if (i == nr_elems)
 			break;
-		if (i % pcpu_entries)
+		if (i < j)
 			goto again;
 	}
 }
-- 
2.30.2

