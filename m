Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738BF1B563E
	for <lists+bpf@lfdr.de>; Thu, 23 Apr 2020 09:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgDWHmw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Apr 2020 03:42:52 -0400
Received: from condef-06.nifty.com ([202.248.20.71]:41939 "EHLO
        condef-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgDWHmv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Apr 2020 03:42:51 -0400
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-06.nifty.com with ESMTP id 03N7eVoa021027
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2020 16:40:31 +0900
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 03N7dV9V000368;
        Thu, 23 Apr 2020 16:39:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 03N7dV9V000368
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587627583;
        bh=+ykdUqghvT+SxkLRSA1PptHJ5c/3PxPl83bqUUzuoq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zzsEkYnnSUhsgkWWdxup+egmkkGXuChgkFvnbo28nh6movAmh0a19vX9RLudHudGN
         RXhNPGbL9tmDct4ww3g70B1dbJd+NhnHTbazIsk83A0Bqjg5Ah8kiEdWqig4OiQuL5
         pF+BipcYVCnn7fBNxEppBQB6f4xE6BRYip/cmVaR3TUOIra7CUklxCOpl/iS6cFN5A
         /lpRBxwwnICmYOnVgha/8fki2DRIT2Cj9OffQvw6WavRfwo+LE7+sWHIwzyUNyN9Ih
         t065FmDSqhVrxbFKPUf0hG/jSd1QcLgn7e3SR5aFP6ji5GvXH/48gzhfzdT7NbU/66
         NdhihN6OBRUQg==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     bpf@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/16] samples: connector: build sample program for target architecture
Date:   Thu, 23 Apr 2020 16:39:23 +0900
Message-Id: <20200423073929.127521-11-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200423073929.127521-1-masahiroy@kernel.org>
References: <20200423073929.127521-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This userspace program includes UAPI headers exported to usr/include/.
'make headers' always works for the target architecture (i.e. the same
architecture as the kernel), so the sample program must be built for
the target as well. Kbuild now supports the 'userprogs' syntax to
describe it cleanly.

$(CC) can always compile cn_text.o since it is the kenrel-space code,
but building ucon requires libc.

I guarded it by:

  always-$(CONFIG_CC_CAN_LINK) := $(userprogs)

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 samples/connector/Makefile | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/samples/connector/Makefile b/samples/connector/Makefile
index b785cbde5ffa..7b5117e96fd0 100644
--- a/samples/connector/Makefile
+++ b/samples/connector/Makefile
@@ -1,13 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_SAMPLE_CONNECTOR) += cn_test.o
 
-# List of programs to build
-hostprogs := ucon
-always-y := $(hostprogs)
+userprogs := ucon
+always-$(CONFIG_CC_CAN_LINK) := $(userprogs)
 
-HOSTCFLAGS_ucon.o += -I$(objtree)/usr/include
-
-all: modules
-
-modules clean:
-	$(MAKE) -C ../.. M=$(CURDIR) $@
+user-ccflags += -I usr/include
-- 
2.25.1

