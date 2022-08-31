Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318B45A73CE
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 04:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiHaCQl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 22:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiHaCQk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 22:16:40 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CB780F4E;
        Tue, 30 Aug 2022 19:16:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VNolbJn_1661912181;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VNolbJn_1661912181)
          by smtp.aliyun-inc.com;
          Wed, 31 Aug 2022 10:16:35 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     yhs@fb.com
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] bpf: Remove useless else if
Date:   Wed, 31 Aug 2022 10:16:18 +0800
Message-Id: <20220831021618.86770-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The assignment of the else and else if branches is the same, so the else
if here is redundant, so we remove it and add a comment to make the code
here readable.

./kernel/bpf/cgroup_iter.c:81:6-8: WARNING: possible condition with no effect (if == else).

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2016
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/bpf/cgroup_iter.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
index c69bce2f4403..0d200a993489 100644
--- a/kernel/bpf/cgroup_iter.c
+++ b/kernel/bpf/cgroup_iter.c
@@ -78,9 +78,7 @@ static void *cgroup_iter_seq_start(struct seq_file *seq, loff_t *pos)
 		return css_next_descendant_pre(NULL, p->start_css);
 	else if (p->order == BPF_CGROUP_ITER_DESCENDANTS_POST)
 		return css_next_descendant_post(NULL, p->start_css);
-	else if (p->order == BPF_CGROUP_ITER_ANCESTORS_UP)
-		return p->start_css;
-	else /* BPF_CGROUP_ITER_SELF_ONLY */
+	else /* BPF_CGROUP_ITER_SELF_ONLY and BPF_CGROUP_ITER_ANCESTORS_UP */
 		return p->start_css;
 }
 
-- 
2.20.1.7.g153144c

