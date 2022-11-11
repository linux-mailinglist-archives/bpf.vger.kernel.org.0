Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9043625363
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 07:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbiKKGIr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 01:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbiKKGIo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 01:08:44 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0667A275E6
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 22:08:41 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N7pDM2778z4f3tpS
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 14:08:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDH69ji5m1jjmBXAQ--.18964S5;
        Fri, 11 Nov 2022 14:08:38 +0800 (CST)
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
Subject: [PATCH bpf v2 1/3] bpf: Pin iterator link when opening iterator
Date:   Fri, 11 Nov 2022 14:34:15 +0800
Message-Id: <20221111063417.1603111-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221111063417.1603111-1-houtao@huaweicloud.com>
References: <20221111063417.1603111-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDH69ji5m1jjmBXAQ--.18964S5
X-Coremail-Antispam: 1UD129KBjvJXoWxAFy5Cr4UtrW3JryxXFWfAFb_yoWrJryrpF
        95u3yqyr48XrZrWF1DJanrurnIy3WUG34UuFs7J34fKwnI9wnFgFW5tF4ayF1YyFWDCrna
        qr109a4rXFWUZrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

For many bpf iterator (e.g., cgroup iterator), iterator link acquires
the reference of iteration target in .attach_target(), but iterator link
may be closed before or in the middle of iteration, so iterator will
need to acquire the reference of iteration target as well to prevent
potential use-after-free. To avoid doing the acquisition in
.init_seq_private() for each iterator type, just pin iterator link in
iterator.

Fixes: d4ccaf58a847 ("bpf: Introduce cgroup iter")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/bpf_iter.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 5dc307bdeaeb..67d899011cb2 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -20,7 +20,7 @@ struct bpf_iter_link {
 };
 
 struct bpf_iter_priv_data {
-	struct bpf_iter_target_info *tinfo;
+	struct bpf_iter_link *link;
 	const struct bpf_iter_seq_info *seq_info;
 	struct bpf_prog *prog;
 	u64 session_id;
@@ -79,7 +79,7 @@ static bool bpf_iter_support_resched(struct seq_file *seq)
 
 	iter_priv = container_of(seq->private, struct bpf_iter_priv_data,
 				 target_private);
-	return bpf_iter_target_support_resched(iter_priv->tinfo);
+	return bpf_iter_target_support_resched(iter_priv->link->tinfo);
 }
 
 /* maximum visited objects before bailing out */
@@ -276,6 +276,7 @@ static int iter_release(struct inode *inode, struct file *file)
 		iter_priv->seq_info->fini_seq_private(seq->private);
 
 	bpf_prog_put(iter_priv->prog);
+	bpf_link_put(&iter_priv->link->link);
 	seq->private = iter_priv;
 
 	return seq_release_private(inode, file);
@@ -576,11 +577,19 @@ int bpf_iter_link_attach(const union bpf_attr *attr, bpfptr_t uattr,
 }
 
 static void init_seq_meta(struct bpf_iter_priv_data *priv_data,
-			  struct bpf_iter_target_info *tinfo,
+			  struct bpf_iter_link *link,
 			  const struct bpf_iter_seq_info *seq_info,
 			  struct bpf_prog *prog)
 {
-	priv_data->tinfo = tinfo;
+	/* For many bpf iterator, iterator link acquires the reference of
+	 * iteration target in .attach_target(), but iterator link may be
+	 * closed before or in the middle of iteration, so iterator will
+	 * need to acquire the reference of iteration target as well. To
+	 * avoid doing the acquisition in .init_seq_private() for each
+	 * iterator type, just pin iterator link in iterator.
+	 */
+	bpf_link_inc(&link->link);
+	priv_data->link = link;
 	priv_data->seq_info = seq_info;
 	priv_data->prog = prog;
 	priv_data->session_id = atomic64_inc_return(&session_id);
@@ -592,7 +601,6 @@ static int prepare_seq_file(struct file *file, struct bpf_iter_link *link,
 			    const struct bpf_iter_seq_info *seq_info)
 {
 	struct bpf_iter_priv_data *priv_data;
-	struct bpf_iter_target_info *tinfo;
 	struct bpf_prog *prog;
 	u32 total_priv_dsize;
 	struct seq_file *seq;
@@ -603,7 +611,6 @@ static int prepare_seq_file(struct file *file, struct bpf_iter_link *link,
 	bpf_prog_inc(prog);
 	mutex_unlock(&link_mutex);
 
-	tinfo = link->tinfo;
 	total_priv_dsize = offsetof(struct bpf_iter_priv_data, target_private) +
 			   seq_info->seq_priv_size;
 	priv_data = __seq_open_private(file, seq_info->seq_ops,
@@ -619,7 +626,7 @@ static int prepare_seq_file(struct file *file, struct bpf_iter_link *link,
 			goto release_seq_file;
 	}
 
-	init_seq_meta(priv_data, tinfo, seq_info, prog);
+	init_seq_meta(priv_data, link, seq_info, prog);
 	seq = file->private_data;
 	seq->private = priv_data->target_private;
 
-- 
2.29.2

