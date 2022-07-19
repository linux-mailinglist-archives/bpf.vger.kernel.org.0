Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585AF57A491
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 19:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbiGSRGY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 13:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237779AbiGSRGW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 13:06:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E495A3B941;
        Tue, 19 Jul 2022 10:06:21 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LnQDP0Wy5z682Y2;
        Wed, 20 Jul 2022 01:04:37 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 19:06:19 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <quentin@isovalent.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <terrelln@fb.com>, <nathan@kernel.org>, <ndesaulniers@google.com>
CC:     <bpf@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <llvm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 2/4] bpftool: Complete libbfd feature detection
Date:   Tue, 19 Jul 2022 19:05:53 +0200
Message-ID: <20220719170555.2576993-2-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719170555.2576993-1-roberto.sassu@huawei.com>
References: <20220719170555.2576993-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 6e8ccb4f624a7 ("tools/bpf: properly account for libbfd variations")
sets the linking flags depending on which flavor of the libbfd feature was
detected.

However, the flavors except libbfd cannot be detected, as they are not in
the feature list.

Complete the list of features to detect by adding libbfd-liberty and
libbfd-liberty-z.

Fixes: 6e8ccb4f624a7 ("tools/bpf: properly account for libbfd variations")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/bpf/bpftool/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 6b5b3a99f79d..4b09a5c3b9f1 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -93,8 +93,10 @@ INSTALL ?= install
 RM ?= rm -f
 
 FEATURE_USER = .bpftool
-FEATURE_TESTS = libbfd disassembler-four-args libcap clang-bpf-co-re
-FEATURE_DISPLAY = libbfd disassembler-four-args libcap clang-bpf-co-re
+FEATURE_TESTS = libbfd libbfd-liberty libbfd-liberty-z \
+		disassembler-four-args libcap clang-bpf-co-re
+FEATURE_DISPLAY = libbfd libbfd-liberty libbfd-liberty-z \
+		  disassembler-four-args libcap clang-bpf-co-re
 
 check_feat := 1
 NON_CHECK_FEAT_TARGETS := clean uninstall doc doc-clean doc-install doc-uninstall
-- 
2.25.1

