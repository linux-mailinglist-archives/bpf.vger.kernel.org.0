Return-Path: <bpf+bounces-9662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBC979A9F0
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 17:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD7A28134A
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 15:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1A911CB3;
	Mon, 11 Sep 2023 15:46:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52D1F51E;
	Mon, 11 Sep 2023 15:46:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371C9FB;
	Mon, 11 Sep 2023 08:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694447168; x=1725983168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EGZf1+DVn+gyziuqfigDtm3H2lqewI5JtUnRehH1Sco=;
  b=AkFbVm+J18qg7N9laCG+ojqAJcic/iItPCXhCoq+5Qi0+sGGUrx9Uc/G
   iytz3AzMU+yjO/Qla/AFmv7sfilboc8AiCM5hZ28/S8pKOnjhIcwIrUzt
   QeGwCwbUF4BWe9h9AhoCyKDTcC9IPGxyFIg32T/cXR9urm6ITQL+zOMsG
   qY91Rq1TjAGF6fy9qar+w9Lo94pzswV12P4JJkPoj1MfAtp5/QkPPydBT
   C58JlHN2xGIPT/Pg+YN3KFxDxYQsdNB+Zyupva6NBxs5ANL1z2nppwojI
   OnKfqK5rSLtxWqQCALqoVQP7Q5ncwNER0wE/bAEMJXSXPCxISdv1pq517
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="444539598"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="444539598"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 08:45:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="917061944"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="917061944"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 11 Sep 2023 08:45:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DB1B145B; Mon, 11 Sep 2023 18:45:35 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v1 2/2] net: core: Sort headers alphabetically
Date: Mon, 11 Sep 2023 18:45:34 +0300
Message-Id: <20230911154534.4174265-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230911154534.4174265-1-andriy.shevchenko@linux.intel.com>
References: <20230911154534.4174265-1-andriy.shevchenko@linux.intel.com>
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

It's rather a gigantic list of heards that is very hard to follow.
Sorting helps to see what's already included and what's not.
It improves a maintainability in a long term.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 net/core/dev.c | 135 +++++++++++++++++++++++++------------------------
 1 file changed, 69 insertions(+), 66 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 85df22f05c38..d795a6c5a591 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -68,91 +68,94 @@
  *				        - netif_rx() feedback
  */
 
-#include <linux/uaccess.h>
+#include <linux/audit.h>
 #include <linux/bitmap.h>
+#include <linux/bpf.h>
+#include <linux/bpf_trace.h>
 #include <linux/capability.h>
 #include <linux/cpu.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/hash.h>
-#include <linux/slab.h>
-#include <linux/sched.h>
-#include <linux/sched/mm.h>
-#include <linux/mutex.h>
-#include <linux/rwsem.h>
-#include <linux/string.h>
-#include <linux/mm.h>
-#include <linux/socket.h>
-#include <linux/sockios.h>
+#include <linux/cpu_rmap.h>
+#include <linux/crash_dump.h>
+#include <linux/ctype.h>
+#include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/err.h>
 #include <linux/errno.h>
-#include <linux/interrupt.h>
-#include <linux/if_ether.h>
-#include <linux/netdevice.h>
+#include <linux/errqueue.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
-#include <linux/skbuff.h>
+#include <linux/hash.h>
+#include <linux/hashtable.h>
+#include <linux/highmem.h>
+#include <linux/hrtimer.h>
+#include <linux/if_arp.h>
+#include <linux/if_ether.h>
+#include <linux/if_macvlan.h>
+#include <linux/if_vlan.h>
+#include <linux/indirect_call_wrapper.h>
+#include <linux/inetdevice.h>
+#include <linux/in.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/jhash.h>
+#include <linux/kernel.h>
 #include <linux/kthread.h>
-#include <linux/bpf.h>
-#include <linux/bpf_trace.h>
-#include <net/net_namespace.h>
-#include <net/sock.h>
-#include <net/busy_poll.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/netdevice.h>
+#include <linux/netfilter_netdev.h>
+#include <linux/net_namespace.h>
+#include <linux/netpoll.h>
+#include <linux/once_lite.h>
+#include <linux/pm_runtime.h>
+#include <linux/prandom.h>
+#include <linux/random.h>
+#include <linux/rcupdate.h>
 #include <linux/rtnetlink.h>
+#include <linux/rwsem.h>
+#include <linux/sched.h>
+#include <linux/sched/mm.h>
+#include <linux/sctp.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <linux/socket.h>
+#include <linux/sockios.h>
 #include <linux/stat.h>
+#include <linux/static_key.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <linux/vmalloc.h>
+
+#include <asm/current.h>
+
+#include <net/busy_poll.h>
+#include <net/checksum.h>
+#include <net/devlink.h>
 #include <net/dsa.h>
 #include <net/dst.h>
 #include <net/dst_metadata.h>
 #include <net/gro.h>
-#include <net/pkt_sched.h>
-#include <net/pkt_cls.h>
-#include <net/checksum.h>
-#include <net/xfrm.h>
-#include <net/tcx.h>
-#include <linux/highmem.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/netpoll.h>
-#include <linux/rcupdate.h>
-#include <linux/delay.h>
-#include <net/iw_handler.h>
-#include <asm/current.h>
-#include <linux/audit.h>
-#include <linux/dmaengine.h>
-#include <linux/err.h>
-#include <linux/ctype.h>
-#include <linux/if_arp.h>
-#include <linux/if_vlan.h>
-#include <linux/ip.h>
 #include <net/ip.h>
+#include <net/iw_handler.h>
 #include <net/mpls.h>
-#include <linux/ipv6.h>
-#include <linux/in.h>
-#include <linux/jhash.h>
-#include <linux/random.h>
+#include <net/netdev_rx_queue.h>
+#include <net/net_namespace.h>
+#include <net/pkt_cls.h>
+#include <net/pkt_sched.h>
+#include <net/sock.h>
+#include <net/tcx.h>
+#include <net/udp_tunnel.h>
+#include <net/xfrm.h>
+
 #include <trace/events/napi.h>
 #include <trace/events/net.h>
-#include <trace/events/skb.h>
 #include <trace/events/qdisc.h>
+#include <trace/events/skb.h>
 #include <trace/events/xdp.h>
-#include <linux/inetdevice.h>
-#include <linux/cpu_rmap.h>
-#include <linux/static_key.h>
-#include <linux/hashtable.h>
-#include <linux/vmalloc.h>
-#include <linux/if_macvlan.h>
-#include <linux/errqueue.h>
-#include <linux/hrtimer.h>
-#include <linux/netfilter_netdev.h>
-#include <linux/crash_dump.h>
-#include <linux/sctp.h>
-#include <net/udp_tunnel.h>
-#include <linux/net_namespace.h>
-#include <linux/indirect_call_wrapper.h>
-#include <net/devlink.h>
-#include <linux/pm_runtime.h>
-#include <linux/prandom.h>
-#include <linux/once_lite.h>
-#include <net/netdev_rx_queue.h>
 
 #include "dev.h"
 #include "net-sysfs.h"
-- 
2.40.0.1.gaa8946217a0b


