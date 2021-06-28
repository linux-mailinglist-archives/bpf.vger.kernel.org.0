Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5433B57AF
	for <lists+bpf@lfdr.de>; Mon, 28 Jun 2021 05:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhF1DHw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 27 Jun 2021 23:07:52 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8473 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhF1DHw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 27 Jun 2021 23:07:52 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GCsph3sJ7zZfy4;
        Mon, 28 Jun 2021 11:02:20 +0800 (CST)
Received: from localhost.localdomain (10.175.103.91) by
 dggeme754-chm.china.huawei.com (10.3.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 28 Jun 2021 11:05:24 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huawei.libin@huawei.com>
Subject: [PATCH] tools: bpf: Fix error in 'make -C tools/ bpf_install'
Date:   Mon, 28 Jun 2021 11:04:09 +0800
Message-ID: <20210628030409.3459095-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

make[2]: *** No rule to make target 'install'.  Stop.
make[1]: *** [Makefile:122: runqslower_install] Error 2
make: *** [Makefile:116: bpf_install] Error 2

There is no rule for target 'install' in tools/bpf/runqslower/Makefile,
and there is no need to install it, so just remove 'runqslower_install'.

Fixes: 9c01546d26d2 ("tools/bpf: Add runqslower tool to tools/bpf")
Signed-off-by: Wei Li <liwei391@huawei.com>
---
 tools/bpf/Makefile | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
index 39bb322707b4..b11cfc86a3d0 100644
--- a/tools/bpf/Makefile
+++ b/tools/bpf/Makefile
@@ -97,7 +97,7 @@ clean: bpftool_clean runqslower_clean resolve_btfids_clean
 	$(Q)$(RM) -- $(OUTPUT)FEATURE-DUMP.bpf
 	$(Q)$(RM) -r -- $(OUTPUT)feature
 
-install: $(PROGS) bpftool_install runqslower_install
+install: $(PROGS) bpftool_install
 	$(call QUIET_INSTALL, bpf_jit_disasm)
 	$(Q)$(INSTALL) -m 0755 -d $(DESTDIR)$(prefix)/bin
 	$(Q)$(INSTALL) $(OUTPUT)bpf_jit_disasm $(DESTDIR)$(prefix)/bin/bpf_jit_disasm
@@ -118,9 +118,6 @@ bpftool_clean:
 runqslower:
 	$(call descend,runqslower)
 
-runqslower_install:
-	$(call descend,runqslower,install)
-
 runqslower_clean:
 	$(call descend,runqslower,clean)
 
@@ -131,5 +128,5 @@ resolve_btfids_clean:
 	$(call descend,resolve_btfids,clean)
 
 .PHONY: all install clean bpftool bpftool_install bpftool_clean \
-	runqslower runqslower_install runqslower_clean \
+	runqslower runqslower_clean \
 	resolve_btfids resolve_btfids_clean
-- 
2.25.1

