Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE2964D5F7
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 05:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiLOErx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 23:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiLOErv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 23:47:51 -0500
Received: from mailgw1.comp.nus.edu.sg (84-20.comp.nus.edu.sg [137.132.84.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16500532E3
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 20:47:47 -0800 (PST)
Received: from localhost (avs2.comp.nus.edu.sg [192.168.49.6])
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTP id 495BD11A0FF;
        Thu, 15 Dec 2022 12:47:47 +0800 (+08)
X-Virus-Scanned: amavisd-new at comp.nus.edu.sg
Received: from mailgw1.comp.nus.edu.sg ([192.168.49.5])
        by localhost (avs.comp.nus.edu.sg [192.168.49.6]) (amavisd-new, port 10024)
        with ESMTP id 3QxjVA-PDUwK; Thu, 15 Dec 2022 12:47:41 +0800 (+08)
Received: from mailauth1.comp.nus.edu.sg (mailauth1.comp.nus.edu.sg [192.168.49.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTPS;
        Thu, 15 Dec 2022 12:47:41 +0800 (+08)
Received: from soccf-srl-002.comp.nus.edu.sg (soccf-srl-002.d2.comp.nus.edu.sg [172.26.191.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: e0446373)
        by mailauth1.comp.nus.edu.sg (Postfix) with ESMTPSA id A57D0601AF6A5;
        Thu, 15 Dec 2022 12:47:41 +0800 (+08)
From:   Shen Jiamin <shen_jiamin@comp.nus.edu.sg>
To:     Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
Cc:     Shen Jiamin <shen_jiamin@comp.nus.edu.sg>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2] tools/resolve_btfids: Use pkg-config to locate libelf
Date:   Thu, 15 Dec 2022 12:47:03 +0800
Message-Id: <20221215044703.400139-1-shen_jiamin@comp.nus.edu.sg>
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
 tools/bpf/resolve_btfids/Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index 19a3112e271a..f7375a119f54 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -56,13 +56,17 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
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

-LIBS = -lelf -lz
+LIBS = $(LIBELF_LIBS) -lz

 export srctree OUTPUT CFLAGS Q
 include $(srctree)/tools/build/Makefile.include
--
2.34.1
