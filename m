Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A38B1DA89F
	for <lists+bpf@lfdr.de>; Wed, 20 May 2020 05:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgETDcd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 May 2020 23:32:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59806 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726432AbgETDcc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 May 2020 23:32:32 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 251B519E1456738066EC;
        Wed, 20 May 2020 11:32:30 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 20 May 2020
 11:32:23 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <mark.rutland@arm.com>,
        <bobo.shaobowang@huawei.com>, <guohanjun@huawei.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <wangnan0@huawei.com>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
Subject: [PATCH] perf bpf-loader: Add missing '*' for key_scan_pos
Date:   Wed, 20 May 2020 11:32:16 +0800
Message-ID: <20200520033216.48310-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
To:     unlisted-recipients:; (no To-header on input)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

key_scan_pos is a pointer for getting scan position in
bpf__obj_config_map() for each BPF map configuration term,
but it's misused when error not happened.

Fixes: 066dacbf2a32 ("perf bpf: Add API to set values to map entries in a bpf object")
Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 tools/perf/util/bpf-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 10c187b8b8ea..460056bc072c 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1225,7 +1225,7 @@ bpf__obj_config_map(struct bpf_object *obj,
 out:
 	free(map_name);
 	if (!err)
-		key_scan_pos += strlen(map_opt);
+		*key_scan_pos += strlen(map_opt);
 	return err;
 }
 
-- 
2.17.1

