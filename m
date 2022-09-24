Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED915E8B58
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 12:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbiIXKN2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 24 Sep 2022 06:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbiIXKN1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 24 Sep 2022 06:13:27 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E24FA3D6B;
        Sat, 24 Sep 2022 03:13:24 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MZPtP63MSzHqQZ;
        Sat, 24 Sep 2022 18:11:09 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 18:13:22 +0800
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 24 Sep
 2022 18:13:21 +0800
From:   Xin Liu <liuxin350@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yanan@huawei.com>, <wuchangye@huawei.com>,
        <xiesongyang@huawei.com>, <zhudi2@huawei.com>,
        <kongweibin2@huawei.com>, <liuxin350@huawei.com>
Subject: [PATCH 1/2] libbpf: add fPIC option for static library
Date:   Sat, 24 Sep 2022 18:12:08 +0800
Message-ID: <20220924101209.50653-2-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220924101209.50653-1-liuxin350@huawei.com>
References: <20220924101209.50653-1-liuxin350@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some programs depned on libbpf.a(eg:bpftool). If libbpf.a miss -fPIC,
this will cause a similar error at compile time:

/usr/bin/ld: .../libbpf.a(libbpf-in.o): relocation
R_AARCH64_ADR_PREL_PG_HI21 against symbol `stderr@@GLIBC_2.17' which
may bind externally can not be used when making a sharedobject;
recompile with -fPIC

Use -fPIC for static library compilation to solve this problem.

Signed-off-by: Xin Liu <liuxin350@huawei.com>
---
 tools/lib/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 4c904ef0b47e..427e971f4fcd 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -91,9 +91,10 @@ override CFLAGS += $(INCLUDES)
 override CFLAGS += -fvisibility=hidden
 override CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64
 override CFLAGS += $(CLANG_CROSS_FLAGS)
+override CFLAGS += -fPIC
 
 # flags specific for shared library
-SHLIB_FLAGS := -DSHARED -fPIC
+SHLIB_FLAGS := -DSHARED
 
 ifeq ($(VERBOSE),1)
   Q =
-- 
2.33.0

