Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2F75ED86B
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 11:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbiI1JGn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 05:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbiI1JGi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 05:06:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3930F116B
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 02:06:37 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4McrBR6lVlzpVT6;
        Wed, 28 Sep 2022 17:03:27 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 28 Sep
 2022 17:06:21 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <quentin@isovalent.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
        <yhs@fb.com>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
        <sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
        <bpf@vger.kernel.org>
CC:     <yuancan@huawei.com>
Subject: [PATCH 2/2] tools: bpftool: Remove unused struct event_ring_info
Date:   Wed, 28 Sep 2022 09:04:40 +0000
Message-ID: <20220928090440.79637-3-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220928090440.79637-1-yuancan@huawei.com>
References: <20220928090440.79637-1-yuancan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After commit 9b190f185d2f("tools/bpftool: switch map event_pipe to libbpf's
perf_buffer"), struct event_ring_info is not used any more and can be removed
as well.

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 tools/bpf/bpftool/map_perf_ring.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/bpf/bpftool/map_perf_ring.c b/tools/bpf/bpftool/map_perf_ring.c
index 6b0c410152de..1583281d1327 100644
--- a/tools/bpf/bpftool/map_perf_ring.c
+++ b/tools/bpf/bpftool/map_perf_ring.c
@@ -29,13 +29,6 @@
 
 static volatile bool stop;
 
-struct event_ring_info {
-	int fd;
-	int key;
-	unsigned int cpu;
-	void *mem;
-};
-
 struct perf_event_sample {
 	struct perf_event_header header;
 	__u64 time;
-- 
2.17.1

