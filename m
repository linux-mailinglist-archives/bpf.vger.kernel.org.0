Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00655BCEC7
	for <lists+bpf@lfdr.de>; Mon, 19 Sep 2022 16:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiISOa2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Sep 2022 10:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiISOaX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Sep 2022 10:30:23 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE942C109
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 07:30:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MWRqb20VszlJJJ
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 22:28:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAnenPtfChj541UBA--.48026S4;
        Mon, 19 Sep 2022 22:30:07 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
Subject: [PATCH bpf-next] bpf: Check whether or not node is NULL before free it in free_bulk
Date:   Mon, 19 Sep 2022 22:48:11 +0800
Message-Id: <20220919144811.3570825-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnenPtfChj541UBA--.48026S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uF18Gr1kXw4xKrWDGrWfZrb_yoW8AF4UpF
        WrJr18Gr4kZF1Iva1jvw1xCFWDZayrKa13GayxZ34SyF1rJr9Ig34DtFyYqFya9rs5trWx
        AFsFkF4FqayUZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

llnode could be NULL if there are new allocations after the checking of
c-free_cnt > c->high_watermark in bpf_mem_refill() and before the
calling of __llist_del_first() in free_bulk (e.g. a PREEMPT_RT kernel
or allocation in NMI context). And it will incur oops as shown below:

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 PGD 0 P4D 0
 Oops: 0002 [#1] PREEMPT_RT SMP
 CPU: 39 PID: 373 Comm: irq_work/39 Tainted: G        W          6.0.0-rc6-rt9+ #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
 RIP: 0010:bpf_mem_refill+0x66/0x130
 ......
 Call Trace:
  <TASK>
  irq_work_single+0x24/0x60
  irq_work_run_list+0x24/0x30
  run_irq_workd+0x18/0x20
  smpboot_thread_fn+0x13f/0x2c0
  kthread+0x121/0x140
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30
  </TASK>

Simply fixing it by checking whether or not llnode is NULL in free_bulk().

Fixes: 1376b7c57624 ("bpf: Introduce any context BPF specific memory allocator.")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 20621f5407d8..5f83be1d2018 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -277,7 +277,8 @@ static void free_bulk(struct bpf_mem_cache *c)
 		local_dec(&c->active);
 		if (IS_ENABLED(CONFIG_PREEMPT_RT))
 			local_irq_restore(flags);
-		enque_to_free(c, llnode);
+		if (llnode)
+			enque_to_free(c, llnode);
 	} while (cnt > (c->high_watermark + c->low_watermark) / 2);
 
 	/* and drain free_llist_extra */
-- 
2.29.2

