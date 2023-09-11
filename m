Return-Path: <bpf+bounces-9663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E926D79A9F3
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 17:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239831C20990
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 15:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4649611CBA;
	Mon, 11 Sep 2023 15:46:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106FA11C82;
	Mon, 11 Sep 2023 15:46:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7589121;
	Mon, 11 Sep 2023 08:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694447209; x=1725983209;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YjRdALQo6iO1ekUDe9KTiN6+J4DKc5QGUKKvZdLZ6Fg=;
  b=VAr+T+so/Ib372/Lo/cbODLMrlrsOOZIWmD/6i3NY7rxEfSsSEd2NXPR
   CbikkgO3cVOXypVi9uwt69jsrYnlsjVzzI+F3JAclB02bl+yalcrMD2MW
   xjiwnA9bRaAtmsmH2BHFmw5XVoNotob0GWN7X7XjdISgcbHKshbMPuFhL
   LKVg5lqWg3scpX5YwLCqdMGf9zvgVbi/pSIWk9W7+Cdqa5w0Wo2uymize
   By+Oz7BYtSsmievYibH7OyqVDGbYwkf4iY8MUM3w0598q+3/o5JZA0U5W
   RY0CILn3UbB4Kg+1iOu3Too5cBTRbe1VJjq5nPt7xUy6if+c+BtZ/9d9a
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="358412451"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="358412451"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 08:45:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="990123595"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="990123595"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 11 Sep 2023 08:45:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 39E8213F; Mon, 11 Sep 2023 18:45:35 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>
Subject: [PATCH net-next v1 1/2] net: core: Use the bitmap API to allocate bitmaps
Date: Mon, 11 Sep 2023 18:45:33 +0300
Message-Id: <20230911154534.4174265-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use bitmap_zalloc() and bitmap_free() instead of hand-writing them.
It is less verbose and it improves the type checking and semantic.

While at it, add missing header inclusion (should be bitops.h,
but with the above change it becomes bitmap.h).

Suggested-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 net/core/dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index ccff2b6ef958..85df22f05c38 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -69,7 +69,7 @@
  */
 
 #include <linux/uaccess.h>
-#include <linux/bitops.h>
+#include <linux/bitmap.h>
 #include <linux/capability.h>
 #include <linux/cpu.h>
 #include <linux/types.h>
@@ -1080,7 +1080,7 @@ static int __dev_alloc_name(struct net *net, const char *name, char *buf)
 			return -EINVAL;
 
 		/* Use one page as a bit array of possible slots */
-		inuse = (unsigned long *) get_zeroed_page(GFP_ATOMIC);
+		inuse = bitmap_zalloc(max_netdevices, GFP_ATOMIC);
 		if (!inuse)
 			return -ENOMEM;
 
@@ -1109,7 +1109,7 @@ static int __dev_alloc_name(struct net *net, const char *name, char *buf)
 		}
 
 		i = find_first_zero_bit(inuse, max_netdevices);
-		free_page((unsigned long) inuse);
+		bitmap_free(inuse);
 	}
 
 	snprintf(buf, IFNAMSIZ, name, i);
-- 
2.40.0.1.gaa8946217a0b


