Return-Path: <bpf+bounces-5289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A197596B6
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 15:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033B41C20FD0
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 13:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136D5168A8;
	Wed, 19 Jul 2023 13:25:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB16516405;
	Wed, 19 Jul 2023 13:25:13 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CD410A;
	Wed, 19 Jul 2023 06:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689773112; x=1721309112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RB6qkwXrd5by5ir0TWQK8DtpCRw6TC7ewfGZazQYkdY=;
  b=MS+r0bwDfatf7JiYC2SqNUC8znWQTGCWU1XjfpPv/Irx6o0fcSGt6Psp
   /yACRutBVDTJb0y65g4b6C3N3qKYHwGdX5RTyT4TLhXsMWp0Ti9kT6XJ2
   0MaYOjGp6tHERurNVu+b1qkaV7s3lTTtbjcuGwTM4RjvKecEtfvDhxRC1
   et+X9DZd95zUlR1eZbHkg94cU5DvHEs0ubfgzsV8Td5cstYX8SyphDGG1
   L0p6Cd+ZUTsqSvh6HNShXdlLwucHHe/XWrMv6eDxhY9yw901wR6tKN1jE
   19SinZz7K+wxaQyrCerhPMPUDoCzGEGLCgdgMWaXhbaHGLFgnu6YQzzuG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="363920527"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="363920527"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 06:24:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="717978023"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="717978023"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2023 06:24:45 -0700
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
Subject: [PATCH v7 bpf-next 04/24] xsk: move xdp_buff's data length check to xsk_rcv_check
Date: Wed, 19 Jul 2023 15:24:01 +0200
Message-Id: <20230719132421.584801-5-maciej.fijalkowski@intel.com>
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

If the data in xdp_buff exceeds the xsk frame length, the packet needs
to be dropped. This check is currently being done in __xsk_rcv(). Move
the described logic to xsk_rcv_check() so that such a xdp_buff will
only be dropped if the application does not support multi-buffer
(absence of XDP_USE_SG bind flag). This is applicable for all cases:
copy mode, zero copy mode as well as skb mode.

Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
---
 net/xdp/xsk.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 029a092582da..a968ac506f4a 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -177,18 +177,11 @@ static void xsk_copy_xdp(struct xdp_buff *to, struct xdp_buff *from, u32 len)
 	memcpy(to_buf, from_buf, len + metalen);
 }
 
-static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
+static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 {
 	struct xdp_buff_xsk *xskb;
 	struct xdp_buff *xsk_xdp;
 	int err;
-	u32 len;
-
-	len = xdp->data_end - xdp->data;
-	if (len > xsk_pool_get_rx_frame_size(xs->pool)) {
-		xs->rx_dropped++;
-		return -ENOSPC;
-	}
 
 	xsk_xdp = xsk_buff_alloc(xs->pool);
 	if (!xsk_xdp) {
@@ -224,7 +217,7 @@ static bool xsk_is_bound(struct xdp_sock *xs)
 	return false;
 }
 
-static int xsk_rcv_check(struct xdp_sock *xs, struct xdp_buff *xdp)
+static int xsk_rcv_check(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 {
 	if (!xsk_is_bound(xs))
 		return -ENXIO;
@@ -232,6 +225,11 @@ static int xsk_rcv_check(struct xdp_sock *xs, struct xdp_buff *xdp)
 	if (xs->dev != xdp->rxq->dev || xs->queue_id != xdp->rxq->queue_index)
 		return -EINVAL;
 
+	if (len > xsk_pool_get_rx_frame_size(xs->pool)) {
+		xs->rx_dropped++;
+		return -ENOSPC;
+	}
+
 	sk_mark_napi_id_once_xdp(&xs->sk, xdp);
 	return 0;
 }
@@ -245,12 +243,13 @@ static void xsk_flush(struct xdp_sock *xs)
 
 int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 {
+	u32 len = xdp_get_buff_len(xdp);
 	int err;
 
 	spin_lock_bh(&xs->rx_lock);
-	err = xsk_rcv_check(xs, xdp);
+	err = xsk_rcv_check(xs, xdp, len);
 	if (!err) {
-		err = __xsk_rcv(xs, xdp);
+		err = __xsk_rcv(xs, xdp, len);
 		xsk_flush(xs);
 	}
 	spin_unlock_bh(&xs->rx_lock);
@@ -259,10 +258,10 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 
 static int xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 {
+	u32 len = xdp_get_buff_len(xdp);
 	int err;
-	u32 len;
 
-	err = xsk_rcv_check(xs, xdp);
+	err = xsk_rcv_check(xs, xdp, len);
 	if (err)
 		return err;
 
@@ -271,7 +270,7 @@ static int xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 		return xsk_rcv_zc(xs, xdp, len);
 	}
 
-	err = __xsk_rcv(xs, xdp);
+	err = __xsk_rcv(xs, xdp, len);
 	if (!err)
 		xdp_return_buff(xdp);
 	return err;
-- 
2.34.1


