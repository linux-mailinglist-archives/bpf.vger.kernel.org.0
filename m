Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F8F631A03
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 08:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiKUHJM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 02:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKUHJJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 02:09:09 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA552873B
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 23:09:06 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NFz5T1gnfz4f3tqC
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 15:09:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgC329gLJHtjFJKWAw--.51545S5;
        Mon, 21 Nov 2022 15:09:04 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Subject: [PATCH bpf-next v3 1/3] bpf: Pin the start cgroup in cgroup_iter_seq_init()
Date:   Mon, 21 Nov 2022 15:34:38 +0800
Message-Id: <20221121073440.1828292-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221121073440.1828292-1-houtao@huaweicloud.com>
References: <20221121073440.1828292-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC329gLJHtjFJKWAw--.51545S5
X-Coremail-Antispam: 1UD129KBjvJXoW7WFW8ZrWkJF17JFW7Aw4rAFb_yoW8ZrW5pF
        s5uw1qyw4FgrsFgr18t3yj9a1FyanaqryUWrs7Jr43CwsrG34UW3y0yr1FyF15AF929ry3
        tr1Yka1rC34jyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

bpf_iter_attach_cgroup() has already acquired an extra reference for the
start cgroup, but the reference may be released if the iterator link fd
is closed after the creation of iterator fd, and it may lead to
user-after-free problem when reading the iterator fd.

An alternative fix is pinning iterator link when opening iterator,
but it will make iterator link being still visible after the close of
iterator link fd and the behavior is different with other link types, so
just fixing it by acquiring another reference for the start cgroup.

Fixes: d4ccaf58a847 ("bpf: Introduce cgroup iter")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/cgroup_iter.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
index fbc6167c3599..06989d278846 100644
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

