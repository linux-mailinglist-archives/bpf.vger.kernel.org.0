Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042AE5B698D
	for <lists+bpf@lfdr.de>; Tue, 13 Sep 2022 10:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiIMI3o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Sep 2022 04:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiIMI3m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Sep 2022 04:29:42 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D75992631;
        Tue, 13 Sep 2022 01:29:39 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MRc5b0jQyzHnvj;
        Tue, 13 Sep 2022 16:27:15 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 16:29:15 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>,
        <john.fastabend@gmail.com>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
        <jolsa@kernel.org>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [bpf-next v2] bpf: use kvmemdup_bpfptr helper
Date:   Tue, 13 Sep 2022 16:40:33 +0800
Message-ID: <1663058433-14089-1-git-send-email-wangyufen@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use kvmemdup_bpfptr helper instead of open-coding to
simplify the code.

Signed-off-by: Wang Yufen <wangyufen@huawei.com>
---
 kernel/bpf/syscall.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4fb08c4..f862406 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1416,19 +1416,14 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 	}
 
 	value_size = bpf_map_value_size(map);
-
-	err = -ENOMEM;
-	value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
-	if (!value)
+	value = kvmemdup_bpfptr(uvalue, value_size);
+	if (IS_ERR(value)) {
+		err = PTR_ERR(value);
 		goto free_key;
-
-	err = -EFAULT;
-	if (copy_from_bpfptr(value, uvalue, value_size) != 0)
-		goto free_value;
+	}
 
 	err = bpf_map_update_value(map, f, key, value, attr->flags);
 
-free_value:
 	kvfree(value);
 free_key:
 	kvfree(key);
-- 
1.8.3.1

