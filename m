Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379055B3581
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 12:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiIIKsy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 06:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIIKsf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 06:48:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F2613D7B3;
        Fri,  9 Sep 2022 03:47:05 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MPCHM1hfgzZcDc;
        Fri,  9 Sep 2022 18:42:23 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 18:46:54 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>,
        <john.fastabend@gmail.com>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
        <jolsa@kernel.org>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [bpf-next] bpf: use kvmemdup_bpfptr helper
Date:   Fri, 9 Sep 2022 18:58:17 +0800
Message-ID: <1662721097-23793-1-git-send-email-wangyufen@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
 kernel/bpf/syscall.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4e9d4622aef7..13ce28081982 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1413,20 +1413,14 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
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
-	kvfree(value);
 free_key:
 	kvfree(key);
 err_put:
-- 
2.25.1

