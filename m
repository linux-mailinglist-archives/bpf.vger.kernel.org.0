Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4288A64CD0A
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 16:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238478AbiLNP2f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 10:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238370AbiLNP2e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 10:28:34 -0500
X-Greylist: delayed 419 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 14 Dec 2022 07:28:31 PST
Received: from mailgw0.comp.nus.edu.sg (84-20.comp.nus.edu.sg [137.132.84.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFBFA33A
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 07:28:31 -0800 (PST)
Received: from localhost (avs1.comp.nus.edu.sg [192.168.20.54])
        by mailgw0.comp.nus.edu.sg (Postfix) with ESMTP id 7133A400D74D7;
        Wed, 14 Dec 2022 23:21:30 +0800 (+08)
X-Virus-Scanned: amavisd-new at comp.nus.edu.sg
Received: from mailgw0.comp.nus.edu.sg ([192.168.20.35])
        by localhost (avs1.comp.nus.edu.sg [192.168.20.54]) (amavisd-new, port 10024)
        with ESMTP id YTcNfM64Ndjq; Wed, 14 Dec 2022 23:21:24 +0800 (+08)
Received: from mailauth0.comp.nus.edu.sg (mailauth0.comp.nus.edu.sg [192.168.49.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailgw0.comp.nus.edu.sg (Postfix) with ESMTPS;
        Wed, 14 Dec 2022 23:21:24 +0800 (+08)
Received: from soccf-srl-002.comp.nus.edu.sg (soccf-srl-002.d2.comp.nus.edu.sg [172.26.191.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: e0446373)
        by mailauth0.comp.nus.edu.sg (Postfix) with ESMTPSA id 242F820018080;
        Wed, 14 Dec 2022 23:21:20 +0800 (+08)
From:   Shen Jiamin <shen_jiamin@comp.nus.edu.sg>
To:     bpf@vger.kernel.org
Cc:     Shen Jiamin <shen_jiamin@comp.nus.edu.sg>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] tools/resolve_btfids: Use pkg-config to locate libelf
Date:   Wed, 14 Dec 2022 23:20:37 +0800
Message-Id: <20221214152037.395772-1-shen_jiamin@comp.nus.edu.sg>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When libelf was not installed in the standard location, it cannot be
located by the current building config.

Use pkg-config to help locate libelf in such cases.

Signed-off-by: Shen Jiamin <shen_jiamin@comp.nus.edu.sg>
---
 tools/bpf/resolve_btfids/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index 19a3112e271a..5dcc31e01149 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -56,11 +56,17 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
 		    DESTDIR=$(LIBBPF_DESTDIR) prefix= EXTRA_CFLAGS="$(CFLAGS)" \
 		    $(abspath $@) install_headers

+LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
+LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
+
 CFLAGS += -g \
           -I$(srctree)/tools/include \
           -I$(srctree)/tools/include/uapi \
           -I$(LIBBPF_INCLUDE) \
-          -I$(SUBCMD_SRC)
+          -I$(SUBCMD_SRC) \
+          $(LIBELF_FLAGS)
+
+LDFLAGS +=  $(LIBELF_LIBS)

 LIBS = -lelf -lz

--
2.34.1
