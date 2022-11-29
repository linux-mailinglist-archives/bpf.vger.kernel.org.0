Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EBA63BADD
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 08:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiK2Hmt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 02:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiK2Hmt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 02:42:49 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052491FF87;
        Mon, 28 Nov 2022 23:42:41 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NLvMy1HqCznV3Q;
        Tue, 29 Nov 2022 15:38:38 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 15:42:39 +0800
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 29 Nov
 2022 15:42:38 +0800
From:   Xin Liu <liuxin350@huawei.com>
To:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yanan@huawei.com>, <wuchangye@huawei.com>,
        <xiesongyang@huawei.com>, <kongweibin2@huawei.com>,
        <liuxin350@huawei.com>, <zhangmingyi5@huawei.com>
Subject: [PATCH] Improved usability of the Makefile in libbpf
Date:   Tue, 29 Nov 2022 15:42:35 +0800
Message-ID: <20221129074235.116969-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Current libbpf Makefile does not contain the help command, which
is inconvenient to use. A help command is provided to list the
commands supported by libbpf make and the functions of the commands.

Signed-off-by: Xin Liu <liuxin350@huawei.com>
---
 tools/lib/bpf/Makefile | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 4c904ef0b47e..c86e05df4711 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -286,3 +286,37 @@ tags:
 
 # Delete partially updated (corrupted) files on error
 .DELETE_ON_ERROR:
+
+help:
+	@echo 'Default targets:'
+	@echo '  all               - Run all_cmd'
+	@echo '  all_cmd           - Build library and pkgconfig, check abi and version info'
+	@echo ''
+	@echo 'Cleaning targets:'
+	@echo '  clean             - Remove all generated files'
+	@echo ''
+	@echo 'Build targets:'
+	@echo '  libbpf.so         - Build the dynamic library'
+	@echo '  libbpf.a          - Build the static library'
+	@echo '  libbpf.pc         - Build the pkgconfig file'
+	@echo ''
+	@echo 'Install targets:'
+	@echo '  install           - Install all headers, library and pkgconfig file to'
+	@echo '                      DESTDIR(default: /) with prefix(default: /usr/local)'
+	@echo '  install_lib       - Install only library'
+	@echo '  install_headers   - Install only headers'
+	@echo '  install_pkgconfig - Install only pkgconfig file'
+	@echo ''
+	@echo 'Other generic targets:'
+	@echo '  cscope            - Generate cscope index'
+	@echo '  tags              - Generate tags file for editors'
+	@echo '  check             - Check abi and version info'
+	@echo '  check_abi         - Check versioned symbols'
+	@echo '  check_version     - Check whether the libbpf version defined in libbpf_version.h'
+	@echo '                      is the same as that defined in libbpf.map'
+	@echo ''
+	@echo '  make V=0|1             [targets] 0 => quiet build (default), 1 => verbose build'
+	@echo '  make DESTDIR=/root     [install targets] use DESTDIR for installing'
+	@echo '                                           into a different root directory'
+	@echo '  make prefix=/path      [install targets] use prefix for installing'
+	@echo '                                           into a user defined prefix path'
-- 
2.33.0

