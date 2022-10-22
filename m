Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545F2608CAC
	for <lists+bpf@lfdr.de>; Sat, 22 Oct 2022 13:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiJVLai (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 Oct 2022 07:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJVLaU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 22 Oct 2022 07:30:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB0B16DC2A;
        Sat, 22 Oct 2022 04:05:14 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MvdfR1j6pzVhpV;
        Sat, 22 Oct 2022 19:00:31 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 19:05:12 +0800
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 22 Oct
 2022 19:05:11 +0800
From:   Xin Liu <liuxin350@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yanan@huawei.com>, <wuchangye@huawei.com>,
        <xiesongyang@huawei.com>, <zhudi2@huawei.com>,
        <kongweibin2@huawei.com>, <liuxin350@huawei.com>
Subject: [PATCH] libbpf: glob_sym may be a NULL pointer and cause the program crash
Date:   Sat, 22 Oct 2022 19:05:29 +0800
Message-ID: <20221022110529.51857-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I found that `glob_sym` does not check whether it is NULL when reading the
code. `glob_sym` obtains the pointer of btf information in the linker from
`find_glob_sym`, which may be return NULL pointer. However, the code then
references `glob_sym->sec_id`. This may cause program to crash.

Fixes: a46349227cd8 ("libbpf: Add linker extern resolution support for functions and global variables")
Signed-off-by: Xin Liu <liuxin350@huawei.com>
Signed-off-by: Weibin Kong <kongweibin2@huawei.com>
---
 tools/lib/bpf/linker.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 4ac02c28e152..d02d2754910f 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -2355,6 +2355,11 @@ static int linker_append_btf(struct bpf_linker *linker, struct src_obj *obj)
 			if (btf_is_non_static(t)) {
 				name = btf__str_by_offset(linker->btf, t->name_off);
 				glob_sym = find_glob_sym(linker, name);
+				if (!glob_sym) {
+					pr_warn("global '%s': section mismatch %d\n", name,
+						dst_sec->id);
+					return -EINVAL;
+				}
 				if (glob_sym->sec_id != dst_sec->id) {
 					pr_warn("global '%s': section mismatch %d vs %d\n",
 						name, glob_sym->sec_id, dst_sec->id);
-- 
2.33.0

