Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D641B6EF17B
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 11:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240081AbjDZJ5X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 05:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239627AbjDZJ5W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 05:57:22 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56DF195;
        Wed, 26 Apr 2023 02:57:20 -0700 (PDT)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Q5vQX1jnnzLlld;
        Wed, 26 Apr 2023 17:56:20 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 17:57:18 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>,
        <john.fastabend@gmail.com>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
        <jolsa@kernel.org>, <chenzhongjin@huawei.com>
Subject: [PATCH] bpf: Unregister fentry when bpf_trampoline_unlink_prog fails to update image
Date:   Wed, 26 Apr 2023 17:55:48 +0800
Message-ID: <20230426095548.176045-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In bpf_link_free, bpf trampoline will update the image and remove the
unlinked prog.

bpf_trampoline_unlink_prog is committed as 'never fail', however it depends
on the result of image update. It is possible to fail if memory allocation
fail in bpf_trampoline_update.

The error result of bpf_trampoline_update can't be passed to bpf_link_free
because link release callback returns void. Then it will free the prog
whether image updating is successful or not.
If the old image tries to call a freed prog, it makes kernel panic.

    BUG: unable to handle page fault for address: ffffffffc04a8d20
    #PF: supervisor instruction fetch in kernel mode
    #PF: error_code(0x0010) - not-present page
    RIP: 0010:0xffffffffc04a8d20
    Code: Unable to access opcode bytes at RIP 0xffffffffc04a8cf6.
    ...
    Call Trace:
    ? bpf_trampoline_78223_0
    bpf_traced_function
    ...

Fix this when bpf_trampoline_update failed in bpf_trampoline_unlink_prog,
unregister fentry to disable the trampoline. Then other progs on the
trampoline can be unlinked safely and finally the trampoline will be
released.

Fixes: 88fd9e5352fe ("bpf: Refactor trampoline update code")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 kernel/bpf/trampoline.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index d0ed7d6f5eec..6daa93b30e81 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -604,7 +604,10 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_
 	}
 	hlist_del_init(&link->tramp_hlist);
 	tr->progs_cnt[kind]--;
-	return bpf_trampoline_update(tr, true /* lock_direct_mutex */);
+	err =  bpf_trampoline_update(tr, true /* lock_direct_mutex */);
+	if (err && tr->cur_image)
+		unregister_fentry(tr, tr->cur_image->image);
+	return err;
 }
 
 /* bpf_trampoline_unlink_prog() should never fail. */
-- 
2.17.1

