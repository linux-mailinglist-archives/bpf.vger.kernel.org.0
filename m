Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFC95ED86D
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 11:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiI1JGn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 05:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiI1JGj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 05:06:39 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520CC1AF06
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 02:06:37 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4McrBP1FcgzpVSX;
        Wed, 28 Sep 2022 17:03:25 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 28 Sep
 2022 17:06:20 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <quentin@isovalent.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
        <yhs@fb.com>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
        <sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
        <bpf@vger.kernel.org>
CC:     <yuancan@huawei.com>
Subject: [PATCH 1/2] tools: bpftool: Remove unused struct btf_attach_point
Date:   Wed, 28 Sep 2022 09:04:39 +0000
Message-ID: <20220928090440.79637-2-yuancan@huawei.com>
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

After commit 2828d0d75b73("bpftool: Switch to libbpf's hashmap for programs/maps
in BTF listing"), struct btf_attach_point is not used any more and can be
removed as well.

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 tools/bpf/bpftool/btf.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 0744bd1150be..64411fe49a66 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -43,11 +43,6 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_ENUM64]	= "ENUM64",
 };
 
-struct btf_attach_point {
-	__u32 obj_id;
-	__u32 btf_id;
-};
-
 static const char *btf_int_enc_str(__u8 encoding)
 {
 	switch (encoding) {
-- 
2.17.1

