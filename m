Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CD15B68C4
	for <lists+bpf@lfdr.de>; Tue, 13 Sep 2022 09:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiIMHhz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Sep 2022 03:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiIMHhz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Sep 2022 03:37:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8D557E2E;
        Tue, 13 Sep 2022 00:37:53 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MRZxW3BRMznVFj;
        Tue, 13 Sep 2022 15:35:11 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 15:37:51 +0800
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 13 Sep
 2022 15:37:50 +0800
From:   Xin Liu <liuxin350@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yanan@huawei.com>, <wuchangye@huawei.com>,
        <xiesongyang@huawei.com>, <zhudi2@huawei.com>,
        <kongweibin2@huawei.com>, <liuxin350@huawei.com>
Subject: [PATCH v3] libbpf: Clean up legacy bpf maps declaration in bpf_helpers
Date:   Tue, 13 Sep 2022 15:36:43 +0800
Message-ID: <20220913073643.19960-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Legacy bpf maps declaration were no longer supported in Libbpf 1.0.
So it was time to remove the definition of bpf_map_def in bpf_helpers.h.
Supported in Libbpf 1.0 ([0])

  [0]:https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Xin Liu <liuxin350@huawei.com>
---
v2 -> v3: Modify the number of lines and links in commit information
v2: https://lore.kernel.org/bpf/94275aa1e5af4efea53f322f91b27380@huawei.com/
v1: https://lore.kernel.org/bpf/6d349d1047f44001b926f80ad5416245@huawei.com/

 tools/lib/bpf/bpf_helpers.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 7349b16b8e2f..d37c4fe2849d 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -160,18 +160,6 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
 }
 #endif
 
-/*
- * Helper structure used by eBPF C program
- * to describe BPF map attributes to libbpf loader
- */
-struct bpf_map_def {
-	unsigned int type;
-	unsigned int key_size;
-	unsigned int value_size;
-	unsigned int max_entries;
-	unsigned int map_flags;
-} __attribute__((deprecated("use BTF-defined maps in .maps section")));
-
 enum libbpf_pin_type {
 	LIBBPF_PIN_NONE,
 	/* PIN_BY_NAME: pin maps by name (in /sys/fs/bpf by default) */
-- 
2.33.0

