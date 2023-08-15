Return-Path: <bpf+bounces-7825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D1877CF14
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 17:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23ED281597
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 15:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A25215482;
	Tue, 15 Aug 2023 15:27:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FB8134AD;
	Tue, 15 Aug 2023 15:27:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9473B10E;
	Tue, 15 Aug 2023 08:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692113236; x=1723649236;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ntcK//hDwpIaSQAS3okkAAFw2AoMGueinRApB3qebB0=;
  b=AY7AmGmWbfe4N5bxbYgypMbRvWgZ0jY4yj2XC/b9aRDDyuHgMnPaUgsK
   9XzXuzxmwdyaGiN8OBKlvxkJg7ErCZqnpzFzspZAmm5mjajNoKmsN9vOa
   rKIDHBUSb9qF3Ifv79AXb+gCEp5D0gNI+maYY+3ZMWn7H8197A7XMJt35
   46T3+2Ehu+DBddiQL+WaLKnjwCkZgqBJqOlLaXxR/6oRfZkeIi3VPksOj
   v3DRbSpn4H0aWWX56N5OpUg4VvUHusTWgnBJ/MZvKD1hi9/l+NgFa338O
   OwKZHjjF7XulUB8wzPhm4ARP1uGGO21ELZW7/lCGKbr9LzIe+w9fSYvtA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357273938"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="357273938"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 08:21:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="803848427"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="803848427"
Received: from unknown (HELO paamrpdk12-S2600BPB.aw.intel.com) ([10.228.151.145])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 08:21:07 -0700
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
Subject: [PATCH bpf-next v2] xsk: fix xsk_build_skb() error: 'skb' dereferencing possible ERR_PTR()
Date: Tue, 15 Aug 2023 20:33:25 +0530
Message-Id: <20230815150325.2010460-1-tirthendu.sarkar@intel.com>
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

xsk_build_skb_zerocopy() may return an error other than -EAGAIN and this
is received as skb and used later in xsk_set_destructor_arg() and
xsk_drop_skb() which must operate on a valid skb.

Set -EOVERFLOW as error when MAX_SKB_FRAGS are exceeded and packet needs
to be dropped and use this to distinguish against all other error cases
where allocation needs to be retried.

Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202307210434.OjgqFcbB-lkp@intel.com/
Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")

Changelog:
	v1 -> v2:
	- Removed err as a parameter to xsk_build_skb_zerocopy()
	[Stanislav Fomichev]
	- use explicit error to distinguish packet drop vs retry
---
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


