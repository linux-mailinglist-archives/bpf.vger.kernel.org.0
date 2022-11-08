Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCF16214CC
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 15:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbiKHOFO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 09:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbiKHOFL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 09:05:11 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACFC69DC1;
        Tue,  8 Nov 2022 06:05:07 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N68xT54KNz4f3xRM;
        Tue,  8 Nov 2022 22:05:01 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP4 (Coremail) with SMTP id gCh0CgDX+9gPYmpjfcbAAA--.7279S2;
        Tue, 08 Nov 2022 22:05:04 +0800 (CST)
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
Subject: [PATCH bpf-next v2] bpf: Initialize same number of free nodes for each pcpu_freelist
Date:   Tue,  8 Nov 2022 09:22:07 -0500
Message-Id: <20221108142207.4079521-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDX+9gPYmpjfcbAAA--.7279S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyxArWrAw15ZF1xWw48WFg_yoW8CF4rpF
        4fAw1jqw1vgryrWws5G3W8W343t3yDGw17Gan8Kr15Zry3KFyqqw1vyF4aqFW7WF4Ivr4F
        kFsI9FZFyayUWFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
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
free nodes for some CPUs, and then possibly one CPU with fewer nodes,
followed by remaining cpus with 0 nodes. For example, when nr_elems == 256
and num_possible_cpus() == 32, if CPU 0 is the current cpu, CPU 0~27
each gets 9 free nodes, CPU 28 gets 4 free nodes, CPU 29~31 get 0 free
nodes, while in fact each CPU should get 8 nodes equally.

This patch initializes nr_elems / num_possible_cpus() free nodes for each
CPU firstly, then allocates the remaining free nodes by one for each CPU
until no free nodes left.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
v2: Update commit message and add Yonghong's ack
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

