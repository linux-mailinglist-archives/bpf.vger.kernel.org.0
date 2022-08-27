Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3095A35DB
	for <lists+bpf@lfdr.de>; Sat, 27 Aug 2022 10:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbiH0I1h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 04:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiH0I1f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 04:27:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16220A6AF4;
        Sat, 27 Aug 2022 01:27:34 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MF8qx3YMwzlVys;
        Sat, 27 Aug 2022 16:24:13 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 16:27:32 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600010.china.huawei.com
 (7.193.23.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 27 Aug
 2022 16:27:31 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <rsilvera@google.com>,
        <sunke32@huawei.com>
Subject: [PATCH] perf inject: Fix error return code in cmd_inject()
Date:   Sat, 27 Aug 2022 16:38:51 +0800
Message-ID: <20220827083851.1431424-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If couldn't parse known build ids. cmd_inject should return a negative error code.

Fixes: a59d0164e202 ("perf inject: Add a command line option to specify build ids.")
Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 tools/perf/builtin-inject.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 8ec955402488..5bea538e2380 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2338,6 +2338,7 @@ int cmd_inject(int argc, const char **argv)
 
 			if (inject.known_build_ids == NULL) {
 				pr_err("Couldn't parse known build ids.\n");
+				ret = -1;
 				goto out_delete;
 			}
 		}
-- 
2.31.1

