Return-Path: <bpf+bounces-4995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A445A753996
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 13:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F34628133D
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 11:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE6C134C0;
	Fri, 14 Jul 2023 11:37:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF72A12B98;
	Fri, 14 Jul 2023 11:37:09 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA8630E8;
	Fri, 14 Jul 2023 04:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689334628; x=1720870628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fYm5fa0u4eP8engLfHD6ER78K+hByF4+pg++EtDx3KU=;
  b=j1KMST4u0RAR+GIGx9e4CIYseH+GkfTLirEgGUjSwtVMpNft4YqG6hEX
   AkXD3yQuaPOv+4wfaEM9EG+9m2hFP0lhNd5MDINIEGoy+iLvKQRqjI18l
   MNw2MZNCXCre/p8FS8rs+f1knU+OXEFMzHTeJhKHftKeSaRw8JBu5Yz6R
   GPGpqXSx3gpgv/voGHCC5W7XU0z7yq79TQzMfPtxg7M51XevOPW0mst+S
   z6gasAbp98j+V3UoaafiWEINBhhdbW5pT8+j0qGaJUg6pELuAMrGWnmo3
   GWcHrU2ZQ2Z39K/A2yjDp6VHaNaXh2SeBLvKO4C2bnBR+6/vvMdYM4Ud3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345048117"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="345048117"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 04:36:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="846425139"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="846425139"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga004.jf.intel.com with ESMTP; 14 Jul 2023 04:36:52 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	tirthendu.sarkar@intel.com,
	toke@kernel.org,
	kuba@kernel.org,
	horms@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v6 bpf-next 03/24] xsk: prepare both copy and zero-copy modes to co-exist
Date: Fri, 14 Jul 2023 13:36:19 +0200
Message-Id: <20230714113640.556893-4-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230714113640.556893-1-maciej.fijalkowski@intel.com>
References: <20230714113640.556893-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
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
index c8460927e5f3..c7f79920e8cc 100644
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


