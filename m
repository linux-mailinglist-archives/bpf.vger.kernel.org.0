Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E415E774C
	for <lists+bpf@lfdr.de>; Fri, 23 Sep 2022 11:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiIWJfp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 05:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiIWJfR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 05:35:17 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C5E8E4E6
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 02:35:12 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYn2X2rVYzlXQk;
        Fri, 23 Sep 2022 17:31:00 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 17:35:09 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <cuigaosheng1@huawei.com>
CC:     <bpf@vger.kernel.org>
Subject: [PATCH] bpf: Remove obsolete iterators_bpf__open_and_load()
Date:   Fri, 23 Sep 2022 17:35:09 +0800
Message-ID: <20220923093509.521560-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit cb80ddc67152 ("bpf: Convert bpf_preload.ko to use light
skeleton.") drops the last caller of generic_free_nodedata(),
it is useless, so remove it.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 kernel/bpf/preload/iterators/iterators.lskel.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/kernel/bpf/preload/iterators/iterators.lskel.h b/kernel/bpf/preload/iterators/iterators.lskel.h
index 70f236a82fe1..e5f9c608f7f7 100644
--- a/kernel/bpf/preload/iterators/iterators.lskel.h
+++ b/kernel/bpf/preload/iterators/iterators.lskel.h
@@ -407,19 +407,4 @@ iterators_bpf__load(struct iterators_bpf *skel)
 	return 0;
 }
 
-static inline struct iterators_bpf *
-iterators_bpf__open_and_load(void)
-{
-	struct iterators_bpf *skel;
-
-	skel = iterators_bpf__open();
-	if (!skel)
-		return NULL;
-	if (iterators_bpf__load(skel)) {
-		iterators_bpf__destroy(skel);
-		return NULL;
-	}
-	return skel;
-}
-
 #endif /* __ITERATORS_BPF_SKEL_H__ */
-- 
2.25.1

