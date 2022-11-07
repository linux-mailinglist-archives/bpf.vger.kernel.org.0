Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F50361EB92
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 08:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiKGHSR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 02:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiKGHR5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 02:17:57 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB6315737
        for <bpf@vger.kernel.org>; Sun,  6 Nov 2022 23:16:44 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N5Mwk1q6Lz4f3lB3
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:16:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgC329jWsGhjUEl6AA--.47516S5;
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
Subject: [PATCH bpf 1/3] bpf: Pin the start cgroup in cgroup_iter_seq_init()
Date:   Mon,  7 Nov 2022 15:42:20 +0800
Message-Id: <20221107074222.1323017-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221107074222.1323017-1-houtao@huaweicloud.com>
References: <20221107074222.1323017-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC329jWsGhjUEl6AA--.47516S5
X-Coremail-Antispam: 1UD129KBjvJXoW7WFW8ZF1rXry7uw1DKF1DAwb_yoW8AF4Upr
        1kCwnFyw4Fgw4qgr18t3yj9a1Fyw4Sqr1UWrZ7Jr45AwsrW34UWw1Iyr1SyF45AF9rKrya
        yr1Yka1Fk34jvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
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

bpf_iter_attach_cgroup() has already acquired an extra reference for the
start cgroup, but the reference will be released if the iterator link fd
is closed after the creation of iterator fd, and it may lead to
User-After-Free when reading the iterator fd.

So fixing it by acquiring another reference for the start cgroup.

Fixes: d4ccaf58a847 ("bpf: Introduce cgroup iter")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/cgroup_iter.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
index 9fcf09f2ef00..c187a9e62bdb 100644
--- a/kernel/bpf/cgroup_iter.c
+++ b/kernel/bpf/cgroup_iter.c
@@ -164,16 +164,30 @@ static int cgroup_iter_seq_init(void *priv, struct bpf_iter_aux_info *aux)
 	struct cgroup_iter_priv *p = (struct cgroup_iter_priv *)priv;
 	struct cgroup *cgrp = aux->cgroup.start;
 
+	/* bpf_iter_attach_cgroup() has already acquired an extra reference
+	 * for the start cgroup, but the reference may be released after
+	 * cgroup_iter_seq_init(), so acquire another reference for the
+	 * start cgroup.
+	 */
 	p->start_css = &cgrp->self;
+	css_get(p->start_css);
 	p->terminate = false;
 	p->visited_all = false;
 	p->order = aux->cgroup.order;
 	return 0;
 }
 
+static void cgroup_iter_seq_fini(void *priv)
+{
+	struct cgroup_iter_priv *p = (struct cgroup_iter_priv *)priv;
+
+	css_put(p->start_css);
+}
+
 static const struct bpf_iter_seq_info cgroup_iter_seq_info = {
 	.seq_ops		= &cgroup_iter_seq_ops,
 	.init_seq_private	= cgroup_iter_seq_init,
+	.fini_seq_private	= cgroup_iter_seq_fini,
 	.seq_priv_size		= sizeof(struct cgroup_iter_priv),
 };
 
-- 
2.29.2

