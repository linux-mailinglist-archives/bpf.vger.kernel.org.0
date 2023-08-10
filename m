Return-Path: <bpf+bounces-7468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B065777ED5
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 19:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC211C2171C
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 17:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C5120FAF;
	Thu, 10 Aug 2023 17:10:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A771E1C0;
	Thu, 10 Aug 2023 17:10:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B12F26A9;
	Thu, 10 Aug 2023 10:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691687429; x=1723223429;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=775MfnnaTiwKWwX0WE4xNNZXvmgkHTxCHtDIgf2UKQI=;
  b=bVluSIXJ5xbiUShYnCJKSZ2njx3JHKsVxwbCinOa0U8g1s/lnGJkvEHv
   qipChLxs4Ae+6lZu2bsMQaX5pZjq7e1bvoH+GUcwajxDnb/wqeBJ/ZHa8
   Cgjxfkou8cD8LXUTSxe6fLDOhjS+ZToLJdtmhReMgtBbDfDWGzGbqj1Ki
   MT/SaYr3FUpsd/c4HY2JmHqWsrlZoEWg7VS8XTCy0LxTlG/q3+ts+b+9P
   guLMykOKmEOpUqFT9bZQQM/vvS1AkcSvNE0sDMeJwDUSKoYkejErVuKSy
   XmZFooo2aGtdDhYGkysap7jZfWZOh/wJeL8kLqRQQUOsx+l5o5Ksu7i9V
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="361605272"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="361605272"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 10:10:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="1062992888"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="1062992888"
Received: from unknown (HELO paamrpdk12-S2600BPB.aw.intel.com) ([10.228.151.145])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 10:10:10 -0700
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
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	dan.carpenter@linaro.org
Subject: [PATCH bpf-next] xsk: fix xsk_build_skb() error: 'skb' dereferencing possible ERR_PTR()
Date: Thu, 10 Aug 2023 22:22:23 +0530
Message-Id: <20230810165223.1870882-1-tirthendu.sarkar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

xsk_build_skb_zerocopy() may return an error other than -EAGAIN and this
is received as skb and used later in xsk_set_destructor_arg() and
xsk_drop_skb() which must operate on a valid skb.

Add new parameter to xsk_build_skb_zerocopy() to explicitly return error
and invoke xsk_set_destructor_arg() and xsk_drop_skb() only for a valid
skb.

Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202307210434.OjgqFcbB-lkp@intel.com/
Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
---
 net/xdp/xsk.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 47796a5a79b3..ff467ade2da6 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -572,22 +572,23 @@ static void xsk_drop_skb(struct sk_buff *skb)
 }
 
 static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
-					      struct xdp_desc *desc)
+					      struct xdp_desc *desc,
+					      int *err)
 {
 	struct xsk_buff_pool *pool = xs->pool;
 	u32 hr, len, ts, offset, copy, copied;
 	struct sk_buff *skb = xs->skb;
 	struct page *page;
 	void *buffer;
-	int err, i;
 	u64 addr;
+	int i;
 
 	if (!skb) {
 		hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(xs->dev->needed_headroom));
 
-		skb = sock_alloc_send_skb(&xs->sk, hr, 1, &err);
+		skb = sock_alloc_send_skb(&xs->sk, hr, 1, err);
 		if (unlikely(!skb))
-			return ERR_PTR(err);
+			goto ret_err;
 
 		skb_reserve(skb, hr);
 	}
@@ -601,8 +602,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	addr = buffer - pool->addrs;
 
 	for (copied = 0, i = skb_shinfo(skb)->nr_frags; copied < len; i++) {
-		if (unlikely(i >= MAX_SKB_FRAGS))
-			return ERR_PTR(-EFAULT);
+		if (unlikely(i >= MAX_SKB_FRAGS)) {
+			*err = -EFAULT;
+			goto ret_err;
+		}
 
 		page = pool->umem->pgs[addr >> PAGE_SHIFT];
 		get_page(page);
@@ -620,7 +623,8 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	skb->truesize += ts;
 
 	refcount_add(ts, &xs->sk.sk_wmem_alloc);
-
+	*err = 0;
+ret_err:
 	return skb;
 }
 
@@ -632,11 +636,9 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	int err;
 
 	if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
-		skb = xsk_build_skb_zerocopy(xs, desc);
-		if (IS_ERR(skb)) {
-			err = PTR_ERR(skb);
+		skb = xsk_build_skb_zerocopy(xs, desc, &err);
+		if (err)
 			goto free_err;
-		}
 	} else {
 		u32 hr, tr, len;
 		void *buffer;
@@ -692,7 +694,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 free_err:
 	if (err == -EAGAIN) {
 		xsk_cq_cancel_locked(xs, 1);
-	} else {
+	} else if (skb) {
 		xsk_set_destructor_arg(skb);
 		xsk_drop_skb(skb);
 		xskq_cons_release(xs->tx);
-- 
2.34.1


