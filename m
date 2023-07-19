Return-Path: <bpf+bounces-5288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D29577596AC
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 15:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F94E1C20FD0
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 13:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE8316407;
	Wed, 19 Jul 2023 13:25:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC17156D4;
	Wed, 19 Jul 2023 13:25:11 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF9A10A;
	Wed, 19 Jul 2023 06:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689773110; x=1721309110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A2rRmvT99Ctn0N1x3U+i8X3661ilBKF2oE0tUghdl2g=;
  b=CJEyYhIoemc26Tpr27c8WAUiQubmZNS4xmSdqmEt3tcrf9FLVTzNuffM
   7WNe7CzWbyJ2t3g2F0elbLIGa6LtI+jP2u2L/GJj3Zm/Z5ypXS+tNnoRr
   DT45v1zVhkugeb81R8OIWonxyfokPyO6qU+/0m38QYrfjhnJjeFk0v0NY
   7S6bKKiXxGuzHT9Grm4D1Xoy/EMBVwfqCP5cNRfBajhmjn/aftrSqLP7j
   FXf1AWbpjKJNO82GjNUsA99ov99OMSSyaqIPsGTGtUwXBG8fNibXZQIyY
   5vFngnTB7TAPoEkoiuKEmVaqpfa4K4S3GyKeF5dPtzlAcvB5TiSC6o2KQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="363920514"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="363920514"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 06:24:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="717978009"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="717978009"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2023 06:24:42 -0700
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
	tirthendu.sarkar@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v7 bpf-next 03/24] xsk: prepare both copy and zero-copy modes to co-exist
Date: Wed, 19 Jul 2023 15:24:00 +0200
Message-Id: <20230719132421.584801-4-maciej.fijalkowski@intel.com>
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

Currently, __xsk_rcv_zc() is a function that is responsible for
producing AF_XDP Rx descriptors. It is used by both copy and zero-copy
mode. Both of these modes are going to differ when multi-buffer support
is going to be added. ZC will work on a chain of xdp_buff_xsk structs
whereas copy-mode is going to utilize skb_shared_info contents. This
means that ZC-specific changes would affect the copy mode.

Let's modify __xsk_rcv_zc() to work directly on xdp_buff_xsk so the
callsites have to retrieve this from xdp_buff. Also, introduce
xsk_rcv_zc() which will carry all the needed later changes for
supporting multi-buffer on ZC side that do not apply to copy mode.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xsk.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7b709e4e7ec4..029a092582da 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -135,9 +135,9 @@ int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *pool,
 	return 0;
 }
 
-static int __xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len, u32 flags)
+static int __xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff_xsk *xskb, u32 len,
+			u32 flags)
 {
-	struct xdp_buff_xsk *xskb = container_of(xdp, struct xdp_buff_xsk, xdp);
 	u64 addr;
 	int err;
 
@@ -152,6 +152,13 @@ static int __xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len, u32
 	return 0;
 }
 
+static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
+{
+	struct xdp_buff_xsk *xskb = container_of(xdp, struct xdp_buff_xsk, xdp);
+
+	return __xsk_rcv_zc(xs, xskb, len, 0);
+}
+
 static void xsk_copy_xdp(struct xdp_buff *to, struct xdp_buff *from, u32 len)
 {
 	void *from_buf, *to_buf;
@@ -172,6 +179,7 @@ static void xsk_copy_xdp(struct xdp_buff *to, struct xdp_buff *from, u32 len)
 
 static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 {
+	struct xdp_buff_xsk *xskb;
 	struct xdp_buff *xsk_xdp;
 	int err;
 	u32 len;
@@ -189,7 +197,8 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 	}
 
 	xsk_copy_xdp(xsk_xdp, xdp, len);
-	err = __xsk_rcv_zc(xs, xsk_xdp, len, 0);
+	xskb = container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
+	err = __xsk_rcv_zc(xs, xskb, len, 0);
 	if (err) {
 		xsk_buff_free(xsk_xdp);
 		return err;
@@ -259,7 +268,7 @@ static int xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 
 	if (xdp->rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL) {
 		len = xdp->data_end - xdp->data;
-		return __xsk_rcv_zc(xs, xdp, len, 0);
+		return xsk_rcv_zc(xs, xdp, len);
 	}
 
 	err = __xsk_rcv(xs, xdp);
-- 
2.34.1


