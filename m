Return-Path: <bpf+bounces-8366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EED785B68
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 17:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6EB81C20C9C
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 15:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8946C2E5;
	Wed, 23 Aug 2023 15:05:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBDF9448;
	Wed, 23 Aug 2023 15:05:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7216D19A;
	Wed, 23 Aug 2023 08:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692803132; x=1724339132;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Pbb3bAtA+Hcdg5cgC9oggNX6MZo2s1S88j5Kf9mmsNE=;
  b=jbOXSU45GpsbO0xuVphqlkaiDvK0f2/P6WxpXu4RcLgRb8tRgEZuGkcb
   iHwERrqxqEJuDWqbcbVB7ExH7Z0dNZKd6fN+Ps5nkehvKgxYpHmeJzj3Z
   A5d8K9fTNjSlU4+yriypjFfYlpMITLRQkvZx81mk+j4cAf4Gp5H2Z1agD
   r3b82MfDB5tMhZUfzRC4lZOzA3400aVlTMvDgeTtgfeJqzzzkiKLGljsm
   Fyuej/dnMJaoESTOd1MIqYMy0/w8T4UfnXeEBTNHbBQLfVfw2uRLAXSip
   uN5bx7fPQ8XE7+IbDUg/W+a2E2ZQk4aCYjMMh59h6GktLPHIUAdT6lfb3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="438117963"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="438117963"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 08:05:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="713606209"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="713606209"
Received: from unknown (HELO paamrpdk12-S2600BPB.aw.intel.com) ([10.228.151.145])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 08:05:11 -0700
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
	dan.carpenter@linaro.org,
	sdf@google.com
Subject: [PATCH bpf-next v3] xsk: fix xsk_build_skb() error: 'skb' dereferencing possible ERR_PTR()
Date: Wed, 23 Aug 2023 20:17:13 +0530
Message-Id: <20230823144713.2231808-1-tirthendu.sarkar@intel.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, xsk_build_skb() is a function that builds skb in two possible
ways and then is ended with common error handling.

We can distinguish four possible error paths and handling in xsk_build_skb():
 1. sock_alloc_send_skb fails: Retry (skb is NULL).
 2. skb_store_bits fails : Free skb and retry.
 3. MAX_SKB_FRAGS exceeded: Free skb, cleanup and drop packet.
 4. alloc_page fails for frag: Retry page allocation w/o freeing skb

1] and 3] can happen in xsk_build_skb_zerocopy(), which is one of the two
code paths responsible for building skb. Common error path in
xsk_build_skb() assumes that in case errno != -EAGAIN, skb is a valid
pointer, which is wrong as kernel test robot reports that in
xsk_build_skb_zerocopy() other errno values are returned for skb being
NULL.

To fix this, set -EOVERFLOW as error when MAX_SKB_FRAGS are exceeded and
packet needs to be dropped in both xsk_build_skb() and
xsk_build_skb_zerocopy() and use this to distinguish against all other
error cases. Also, add explicit kfree_skb() for 3] so that handling of 1],
2], and 3] becomes identical where allocation needs to be retried.

Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202307210434.OjgqFcbB-lkp@intel.com/
Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
---
Changelog:
	v2 -> v3:
	- Added further details in commit message as asked by Maciej
	v1 -> v2:
	- Removed err as a parameter to xsk_build_skb_zerocopy()
	[Stanislav Fomichev]
	- use explicit error to distinguish packet drop vs retry

 net/xdp/xsk.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index fcfc8472f73d..55f8b9b0e06d 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -602,7 +602,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 
 	for (copied = 0, i = skb_shinfo(skb)->nr_frags; copied < len; i++) {
 		if (unlikely(i >= MAX_SKB_FRAGS))
-			return ERR_PTR(-EFAULT);
+			return ERR_PTR(-EOVERFLOW);
 
 		page = pool->umem->pgs[addr >> PAGE_SHIFT];
 		get_page(page);
@@ -655,15 +655,17 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			skb_put(skb, len);
 
 			err = skb_store_bits(skb, 0, buffer, len);
-			if (unlikely(err))
+			if (unlikely(err)) {
+				kfree_skb(skb);
 				goto free_err;
+			}
 		} else {
 			int nr_frags = skb_shinfo(skb)->nr_frags;
 			struct page *page;
 			u8 *vaddr;
 
 			if (unlikely(nr_frags == (MAX_SKB_FRAGS - 1) && xp_mb_desc(desc))) {
-				err = -EFAULT;
+				err = -EOVERFLOW;
 				goto free_err;
 			}
 
@@ -690,12 +692,14 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	return skb;
 
 free_err:
-	if (err == -EAGAIN) {
-		xsk_cq_cancel_locked(xs, 1);
-	} else {
-		xsk_set_destructor_arg(skb);
-		xsk_drop_skb(skb);
+	if (err == -EOVERFLOW) {
+		/* Drop the packet */
+		xsk_set_destructor_arg(xs->skb);
+		xsk_drop_skb(xs->skb);
 		xskq_cons_release(xs->tx);
+	} else {
+		/* Let application retry */
+		xsk_cq_cancel_locked(xs, 1);
 	}
 
 	return ERR_PTR(err);
@@ -738,7 +742,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		skb = xsk_build_skb(xs, &desc);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
-			if (err == -EAGAIN)
+			if (err != -EOVERFLOW)
 				goto out;
 			err = 0;
 			continue;
-- 
2.34.1


