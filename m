Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D0D1B56B1
	for <lists+bpf@lfdr.de>; Thu, 23 Apr 2020 09:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgDWHwF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Apr 2020 03:52:05 -0400
Received: from condef-03.nifty.com ([202.248.20.68]:27019 "EHLO
        condef-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgDWHwE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Apr 2020 03:52:04 -0400
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-03.nifty.com with ESMTP id 03N7eXqn016162
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2020 16:40:34 +0900
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 03N7dV9Y000368;
        Thu, 23 Apr 2020 16:39:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 03N7dV9Y000368
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587627585;
        bh=hZ8+fwVp7+ov3O6upNJo7VpVTfDPY/IvaiBo3lVHLJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hqz14zUC1I7SppGewxhPGdV5Rk7+84OzsClwJY3RdIQQyRnlMJt30rTut/FN2RlCw
         hQtc3eJg9rYrgq2sPR49eaXYxvpFcFghjJZHdmhwDJ0ZzFw5x4yR+IPBHm0nUFkmSr
         Uaez3b6d1KOI1OK/5qIvoAgIeFaxWe6KXc1WRQS6DcpiTEKxVkiUlGOKbAbgxEJR8o
         XQVebwL2iIfKzw8eaIbxNVuuq3osVUo6DxBBVE9Qlf0uoIyZCYFs6tOrHUlpiS5azZ
         4qMG6K7kuyI8PH+wuerB9lkXzMJVvHDneNys7zjK6BIrX1ph0uO+ADx1lLCN7esx+R
         3lEivQ7AxCc5A==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     bpf@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/16] samples: mei: build sample program for target architecture
Date:   Thu, 23 Apr 2020 16:39:26 +0900
Message-Id: <20200423073929.127521-14-masahiroy@kernel.org>
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

I also guarded the CONFIG option by 'depends on CC_CAN_LINK' because
$(CC) may not necessarily provide libc.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 samples/Kconfig      | 1 +
 samples/mei/Makefile | 9 +++------
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index b8113555aa6c..b9dafee5d3af 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -193,6 +193,7 @@ config SAMPLE_VFS
 config SAMPLE_INTEL_MEI
 	bool "Build example program working with intel mei driver"
 	depends on INTEL_MEI
+	depends on CC_CAN_LINK && HEADERS_INSTALL
 	help
 	  Build a sample program to work with mei device.
 
diff --git a/samples/mei/Makefile b/samples/mei/Makefile
index f5b9d02be2cd..ced5532cbbee 100644
--- a/samples/mei/Makefile
+++ b/samples/mei/Makefile
@@ -1,10 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2012-2019, Intel Corporation. All rights reserved.
 
-hostprogs := mei-amt-version
+userprogs := mei-amt-version
+always-y := $(userprogs)
 
-HOSTCFLAGS_mei-amt-version.o += -I$(objtree)/usr/include
-
-always-y := $(hostprogs)
-
-all: mei-amt-version
+user-ccflags += -I usr/include
-- 
2.25.1

