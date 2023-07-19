Return-Path: <bpf+bounces-5287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BBF7596A9
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 15:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43AF2819BE
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 13:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0636156E7;
	Wed, 19 Jul 2023 13:25:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD74156D4;
	Wed, 19 Jul 2023 13:25:09 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE97FD;
	Wed, 19 Jul 2023 06:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689773108; x=1721309108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DgbSD0gf5fczboVokH0FJzFy1mZ6vLNCfC26qTCfZ+o=;
  b=L/iOeSGmkuV6gy+eauvCHaJ25QxUiQ4r4ZINpiQjiLYP4EdLzAdt8ex+
   d+ZVGNtlLTKzSGg4fkeqFBYdjEb8WaQYkDEunQ5OrLbzCviQ1HTdfAI31
   hq3bhLO5yzwEDKSRBBgMZaAvUZZ1DWtL919OSf4zdNUWaGnYSdJVGq1Zv
   YmuEFuw1RoXmzbMETKogco6WX9EH3O0MMpJQQawIoRq6ev+lotYhsSqyg
   am/bTlk1iWJ37FOyxKMB+xl41Q7T9RWswK1zrJK8CAjvTNFlodrde7mBr
   9yr2lgCHkRVYNgOj7JbS95iW2GdhrIC62pAlbZUTNdKDMMwHnILGG1Rwg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="363920504"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="363920504"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 06:24:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="717977999"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="717977999"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2023 06:24:39 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	toke@kernel.org,
	kuba@kernel.org,
	horms@kernel.org,
	tirthendu.sarkar@intel.com
Subject: [PATCH v7 bpf-next 02/24] xsk: introduce XSK_USE_SG bind flag for xsk socket
Date: Wed, 19 Jul 2023 15:23:59 +0200
Message-Id: <20230719132421.584801-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230719132421.584801-1-maciej.fijalkowski@intel.com>
References: <20230719132421.584801-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>

As of now xsk core drops any xdp_buff with data size greater than the
xsk frame_size as set by the af_xdp application. With multi-buffer
support introduced in the next patch xsk core can now split those
buffers into multiple descriptors provided the af_xdp application can
handle them. Such capability of the application needs to be independent
of the xdp_prog's frag support capability since there are cases where
even a single xdp_buffer may need to be split into multiple descriptors
owing to a smaller xsk frame size.

For e.g., with NIC rx_buffer size set to 4kB, a 3kB packet will
constitute of a single buffer and so will be sent as such to AF_XDP layer
irrespective of 'xdp.frags' capability of the XDP program. Now if the xsk
frame size is set to 2kB by the AF_XDP application, then the packet will
need to be split into 2 descriptors if AF_XDP application can handle
multi-buffer, else it needs to be dropped.

Applications can now advertise their frag handling capability to xsk core
so that xsk core can decide if it should drop or split xdp_buffs that
exceed xsk frame size. This is done using a new 'XSK_USE_SG' bind flag
for the xdp socket.

Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
---
 include/net/xdp_sock.h      | 1 +
 include/uapi/linux/if_xdp.h | 6 ++++++
 net/xdp/xsk.c               | 5 +++--
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index e96a1151ec75..36b0411a0d1b 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -52,6 +52,7 @@ struct xdp_sock {
 	struct xsk_buff_pool *pool;
 	u16 queue_id;
 	bool zc;
+	bool sg;
 	enum {
 		XSK_READY = 0,
 		XSK_BOUND,
diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index 434f313dc26c..8d48863472b9 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -25,6 +25,12 @@
  * application.
  */
 #define XDP_USE_NEED_WAKEUP (1 << 3)
+/* By setting this option, userspace application indicates that it can
+ * handle multiple descriptors per packet thus enabling AF_XDP to split
+ * multi-buffer XDP frames into multiple Rx descriptors. Without this set
+ * such frames will be dropped.
+ */
+#define XDP_USE_SG	(1 << 4)
 
 /* Flags for xsk_umem_config flags */
 #define XDP_UMEM_UNALIGNED_CHUNK_FLAG (1 << 0)
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 914a80cd55d3..7b709e4e7ec4 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -897,7 +897,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 
 	flags = sxdp->sxdp_flags;
 	if (flags & ~(XDP_SHARED_UMEM | XDP_COPY | XDP_ZEROCOPY |
-		      XDP_USE_NEED_WAKEUP))
+		      XDP_USE_NEED_WAKEUP | XDP_USE_SG))
 		return -EINVAL;
 
 	bound_dev_if = READ_ONCE(sk->sk_bound_dev_if);
@@ -929,7 +929,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 		struct socket *sock;
 
 		if ((flags & XDP_COPY) || (flags & XDP_ZEROCOPY) ||
-		    (flags & XDP_USE_NEED_WAKEUP)) {
+		    (flags & XDP_USE_NEED_WAKEUP) || (flags & XDP_USE_SG)) {
 			/* Cannot specify flags for shared sockets. */
 			err = -EINVAL;
 			goto out_unlock;
@@ -1028,6 +1028,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 
 	xs->dev = dev;
 	xs->zc = xs->umem->zc;
+	xs->sg = !!(flags & XDP_USE_SG);
 	xs->queue_id = qid;
 	xp_add_xsk(xs->pool, xs);
 
-- 
2.34.1


