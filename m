Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C1262EA8E
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 01:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiKRAvD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 19:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiKRAvD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 19:51:03 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C8374CE1;
        Thu, 17 Nov 2022 16:51:01 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NCyrB5wfGz15Mj8;
        Fri, 18 Nov 2022 08:50:34 +0800 (CST)
Received: from huawei.com (10.67.174.53) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 18 Nov
 2022 08:50:57 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liaochang1@huawei.com>
Subject: [PATCH] samples/bpf: Fix duplicate struct define in test_lru_dist sample
Date:   Fri, 18 Nov 2022 08:47:52 +0800
Message-ID: <20221118004752.97759-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.53]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Build sample/bpf report error as follow:

  CC  ./samples/bpf/test_lru_dist
./samples/bpf/test_lru_dist.c:35:8: error: redefinition of ‘struct list_head’
   35 | struct list_head {
      |        ^~~~~~~~~
In file included from ./samples/bpf/test_lru_dist.c:6:
./tools/include/linux/types.h:84:8: note: originally defined here
   84 | struct list_head {

Remove the duplicate definition of struct list_head in test_lru_dist.c

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 samples/bpf/test_lru_dist.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/samples/bpf/test_lru_dist.c b/samples/bpf/test_lru_dist.c
index 5efb91763d65..2e7341044090 100644
--- a/samples/bpf/test_lru_dist.c
+++ b/samples/bpf/test_lru_dist.c
@@ -32,10 +32,6 @@ static int nr_cpus;
 static unsigned long long *dist_keys;
 static unsigned int dist_key_counts;
 
-struct list_head {
-	struct list_head *next, *prev;
-};
-
 static inline void INIT_LIST_HEAD(struct list_head *list)
 {
 	list->next = list;
-- 
2.17.1

