Return-Path: <bpf+bounces-9392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB76796F81
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 06:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB21281511
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 04:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC7A10E4;
	Thu,  7 Sep 2023 04:08:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A776EA9;
	Thu,  7 Sep 2023 04:08:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFD1199F;
	Wed,  6 Sep 2023 21:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694059731; x=1725595731;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F6i5KMiSgIz0qrgnQCr9KUhuID6UI84mNdjhAUZUdbY=;
  b=n3sOihnErTYfZQin6WuZElPhxT6d7v/06fDsaZ8v6brumpoMYAE3GBr6
   fB/ha51Sfi2eJQ74LRtOiY/Jv0shDc22mZj4utQHlYUuQVwA4LQAy8J+m
   rerrHdh5Sjp/+Vdn7n95+b+SDGgegdPBs+w1UfNBl0AdE+1KRwmXHJkpN
   1q5TwRga4EU2xvfS/NdC3KRE0s1iU4sqtz8IgjrwB5NJjVpiyYtwlU8vy
   cWFT2acOFrX8WARagdJyywjX3MIjchUCGsRQeD2N2mxnHqcynHjkxrxk7
   CwKUDHUZixYWdDhxiD6e6leHmkNsX9rfoTZf405suXDpQaEZV9al5U5/u
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="362281790"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="362281790"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 21:08:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="885020114"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="885020114"
Received: from unknown (HELO paamrpdk12-S2600BPB.aw.intel.com) ([10.228.151.145])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 21:08:36 -0700
From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net
Subject: [PATCH bpf-next] xsk: add multi-buffer support for sockets sharing umem
Date: Thu,  7 Sep 2023 09:20:32 +0530
Message-Id: <20230907035032.2627879-1-tirthendu.sarkar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Userspace applications indicate their multi-buffer capability to xsk
using XSK_USE_SG socket bind flag. For sockets using shared umem the
bind flag may contain XSK_USE_SG only for the first socket. For any
subsequent socket the only option supported is XDP_SHARED_UMEM.

Add option XDP_UMEM_SG_FLAG in umem config flags to store the
multi-buffer handling capability when indicated by XSK_USE_SG option in
bing flag by the first socket. Use this to derive multi-buffer capability
for subsequent sockets in xsk core.

Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
Fixes: 81470b5c3c66 ("xsk: introduce XSK_USE_SG bind flag for xsk socket")
---
 include/net/xdp_sock.h  | 2 ++
 net/xdp/xsk.c           | 2 +-
 net/xdp/xsk_buff_pool.c | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 1617af380162..69b472604b86 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -14,6 +14,8 @@
 #include <linux/mm.h>
 #include <net/sock.h>
 
+#define XDP_UMEM_SG_FLAG (1 << 1)
+
 struct net_device;
 struct xsk_queue;
 struct xdp_buff;
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 55f8b9b0e06d..7482d0aca504 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1228,7 +1228,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 
 	xs->dev = dev;
 	xs->zc = xs->umem->zc;
-	xs->sg = !!(flags & XDP_USE_SG);
+	xs->sg = !!(xs->umem->flags & XDP_UMEM_SG_FLAG);
 	xs->queue_id = qid;
 	xp_add_xsk(xs->pool, xs);
 
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index b3f7b310811e..49cb9f9a09be 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -170,6 +170,9 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	if (err)
 		return err;
 
+	if (flags & XDP_USE_SG)
+		pool->umem->flags |= XDP_UMEM_SG_FLAG;
+
 	if (flags & XDP_USE_NEED_WAKEUP)
 		pool->uses_need_wakeup = true;
 	/* Tx needs to be explicitly woken up the first time.  Also
-- 
2.34.1


