Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3055657A490
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 19:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237587AbiGSRGW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 13:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235892AbiGSRGV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 13:06:21 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4724D817;
        Tue, 19 Jul 2022 10:06:20 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LnQBR2z29z689Mf;
        Wed, 20 Jul 2022 01:02:55 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 19:06:17 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <quentin@isovalent.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <terrelln@fb.com>, <nathan@kernel.org>, <ndesaulniers@google.com>
CC:     <bpf@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <llvm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 1/4] tools, build: Retry detection of bfd-related features
Date:   Tue, 19 Jul 2022 19:05:52 +0200
Message-ID: <20220719170555.2576993-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
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

While separate features have been defined to determine which linking flags
are required to use libbfd depending on the distribution (libbfd,
libbfd-liberty and libbfd-liberty-z), the same has not been done for other
features requiring linking to libbfd.

For example, disassembler-four-args requires linking to libbfd too, but it
should use the right linking flags. If not all the required ones are
specified, e.g. -liberty, detection will always fail even if the feature is
available.

Instead of creating new features, similarly to libbfd, simply retry
detection with the different set of flags until detection succeeds (or
fails, if the libraries are missing). In this way, feature detection is
transparent for the users of this building mechanism (e.g. perf), and those
users don't have for example to set an appropriate value for the
FEATURE_CHECK_LDFLAGS-disassembler-four-args variable.

The number of retries and features for which the retry mechanism is
implemented is low enough to make the increase in the complexity of
Makefile negligible.

Tested with perf and bpftool on Ubuntu 20.04.4 LTS, Fedora 36 and openSUSE
Tumbleweed.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/build/feature/Makefile | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 7c2a17e23c30..063dab19148c 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -89,6 +89,8 @@ all: $(FILES)
 
 __BUILD = $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.c,$(@F)) $(LDFLAGS)
   BUILD = $(__BUILD) > $(@:.bin=.make.output) 2>&1
+  BUILD_BFD = $(BUILD) -DPACKAGE='"perf"' -lbfd -ldl
+  BUILD_ALL = $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd -lcap
 
 __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
   BUILDXX = $(__BUILDXX) > $(@:.bin=.make.output) 2>&1
@@ -96,7 +98,7 @@ __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(
 ###############################
 
 $(OUTPUT)test-all.bin:
-	$(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd -lcap
+	$(BUILD_ALL) || $(BUILD_ALL) -lopcodes -liberty
 
 $(OUTPUT)test-hello.bin:
 	$(BUILD)
@@ -240,13 +242,14 @@ $(OUTPUT)test-libpython.bin:
 	$(BUILD) $(FLAGS_PYTHON_EMBED)
 
 $(OUTPUT)test-libbfd.bin:
-	$(BUILD) -DPACKAGE='"perf"' -lbfd -ldl
+	$(BUILD_BFD)
 
 $(OUTPUT)test-libbfd-buildid.bin:
-	$(BUILD) -DPACKAGE='"perf"' -lbfd -ldl
+	$(BUILD_BFD) || $(BUILD_BFD) -liberty || $(BUILD_BFD) -liberty -lz
 
 $(OUTPUT)test-disassembler-four-args.bin:
-	$(BUILD) -DPACKAGE='"perf"' -lbfd -lopcodes
+	$(BUILD_BFD) -lopcodes || $(BUILD_BFD) -lopcodes -liberty || \
+	$(BUILD_BFD) -lopcodes -liberty -lz
 
 $(OUTPUT)test-reallocarray.bin:
 	$(BUILD)
-- 
2.25.1

