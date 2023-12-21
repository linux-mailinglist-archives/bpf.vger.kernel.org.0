Return-Path: <bpf+bounces-18531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A3881B88B
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 14:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F7B28E104
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 13:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF966D6CE;
	Thu, 21 Dec 2023 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/Mln8U9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237D86D6C0;
	Thu, 21 Dec 2023 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703165231; x=1734701231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gy+3JGGJvg5YbIavzYqCZcWzf4+wmHieQCNFt2txYqE=;
  b=g/Mln8U9mKpUVxmppVxs3Nv4zN1BAmcjRGCd6vjM81DHEEBHRAZ8AO0q
   MudW7mMqyzzpoXju6jd21sls06BiVjDlzomxYJPdBcvRYMO24B6yP5XAM
   g/odl1fn0QZD+ultOKFhL+QtrBcfch83KqXMjqZp+FRVmcgsyStVNOGch
   Xx67QsnkgTjmlQOJjr8XLu2Ukqz1Wt+U3aYw4TohWX+y6CSFAEK7Bo2Wf
   P0/X9aqF6OISBGCX12Se5G7eZvicTS4oNDqJkfOJgbup7SB+JF44b0ZT2
   bClfbaRRkkZgfMyNUCNqjHdks6ZHGhCbSe+liaY27IfOJNaV7lCXAsO+6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="3205560"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="3205560"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 05:27:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="24955794"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa001.jf.intel.com with ESMTP; 21 Dec 2023 05:27:08 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com,
	echaudro@redhat.com,
	lorenzo@kernel.org,
	tirthendu.sarkar@intel.com
Subject: [PATCH v3 bpf 2/4] xsk: fix usage of multi-buffer BPF helpers for ZC XDP
Date: Thu, 21 Dec 2023 14:26:54 +0100
Message-Id: <20231221132656.384606-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231221132656.384606-1-maciej.fijalkowski@intel.com>
References: <20231221132656.384606-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently when packet is shrunk via bpf_xdp_adjust_tail(), null ptr
dereference happens:

[1136314.192256] BUG: kernel NULL pointer dereference, address:
0000000000000034
[1136314.203943] #PF: supervisor read access in kernel mode
[1136314.213768] #PF: error_code(0x0000) - not-present page
[1136314.223550] PGD 0 P4D 0
[1136314.230684] Oops: 0000 [#1] PREEMPT SMP NOPTI
[1136314.239621] CPU: 8 PID: 54203 Comm: xdpsock Not tainted 6.6.0+ #257
[1136314.250469] Hardware name: Intel Corporation S2600WFT/S2600WFT,
BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
[1136314.265615] RIP: 0010:__xdp_return+0x6c/0x210
[1136314.274653] Code: ad 00 48 8b 47 08 49 89 f8 a8 01 0f 85 9b 01 00 00 0f 1f 44 00 00 f0 41 ff 48 34 75 32 4c 89 c7 e9 79 cd 80 ff 83 fe 03 75 17 <f6> 41 34 01 0f 85 02 01 00 00 48 89 cf e9 22 cc 1e 00 e9 3d d2 86
[1136314.302907] RSP: 0018:ffffc900089f8db0 EFLAGS: 00010246
[1136314.312967] RAX: ffffc9003168aed0 RBX: ffff8881c3300000 RCX:
0000000000000000
[1136314.324953] RDX: 0000000000000000 RSI: 0000000000000003 RDI:
ffffc9003168c000
[1136314.336929] RBP: 0000000000000ae0 R08: 0000000000000002 R09:
0000000000010000
[1136314.348844] R10: ffffc9000e495000 R11: 0000000000000040 R12:
0000000000000001
[1136314.360706] R13: 0000000000000524 R14: ffffc9003168aec0 R15:
0000000000000001
[1136314.373298] FS:  00007f8df8bbcb80(0000) GS:ffff8897e0e00000(0000)
knlGS:0000000000000000
[1136314.386105] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[1136314.396532] CR2: 0000000000000034 CR3: 00000001aa912002 CR4:
00000000007706f0
[1136314.408377] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[1136314.420173] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[1136314.431890] PKRU: 55555554
[1136314.439143] Call Trace:
[1136314.446058]  <IRQ>
[1136314.452465]  ? __die+0x20/0x70
[1136314.459881]  ? page_fault_oops+0x15b/0x440
[1136314.468305]  ? exc_page_fault+0x6a/0x150
[1136314.476491]  ? asm_exc_page_fault+0x22/0x30
[1136314.484927]  ? __xdp_return+0x6c/0x210
[1136314.492863]  bpf_xdp_adjust_tail+0x155/0x1d0
[1136314.501269]  bpf_prog_ccc47ae29d3b6570_xdp_sock_prog+0x15/0x60
[1136314.511263]  ice_clean_rx_irq_zc+0x206/0xc60 [ice]
[1136314.520222]  ? ice_xmit_zc+0x6e/0x150 [ice]
[1136314.528506]  ice_napi_poll+0x467/0x670 [ice]
[1136314.536858]  ? ttwu_do_activate.constprop.0+0x8f/0x1a0
[1136314.546010]  __napi_poll+0x29/0x1b0
[1136314.553462]  net_rx_action+0x133/0x270
[1136314.561619]  __do_softirq+0xbe/0x28e
[1136314.569303]  do_softirq+0x3f/0x60

This comes from __xdp_return() call with xdp_buff argument passed as
NULL which is supposed to be consumed by xsk_buff_free() call.

To address this properly, in ZC case, a node that represents the frag
being removed has to be pulled out of xskb_list. Introduce
appriopriate xsk helpers to do such node operation and use them
accordingly within bpf_xdp_adjust_tail().

Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com> # For the xsk header part
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/net/xdp_sock_drv.h | 26 +++++++++++++++++++++
 net/core/filter.c          | 48 +++++++++++++++++++++++++++++++-------
 2 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index b62bb8525a5f..3d35ac0f838b 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -159,6 +159,23 @@ static inline struct xdp_buff *xsk_buff_get_frag(struct xdp_buff *first)
 	return ret;
 }
 
+static inline void xsk_buff_del_tail(struct xdp_buff *tail)
+{
+	struct xdp_buff_xsk *xskb = container_of(tail, struct xdp_buff_xsk, xdp);
+
+	list_del(&xskb->xskb_list_node);
+}
+
+static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
+{
+	struct xdp_buff_xsk *xskb = container_of(first, struct xdp_buff_xsk, xdp);
+	struct xdp_buff_xsk *frag;
+
+	frag = list_last_entry(&xskb->pool->xskb_list, struct xdp_buff_xsk,
+			       xskb_list_node);
+	return &frag->xdp;
+}
+
 static inline void xsk_buff_set_size(struct xdp_buff *xdp, u32 size)
 {
 	xdp->data = xdp->data_hard_start + XDP_PACKET_HEADROOM;
@@ -350,6 +367,15 @@ static inline struct xdp_buff *xsk_buff_get_frag(struct xdp_buff *first)
 	return NULL;
 }
 
+static inline void xsk_buff_del_tail(struct xdp_buff *tail)
+{
+}
+
+static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
+{
+	return NULL;
+}
+
 static inline void xsk_buff_set_size(struct xdp_buff *xdp, u32 size)
 {
 }
diff --git a/net/core/filter.c b/net/core/filter.c
index 24061f29c9dd..1e20196687fd 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -83,6 +83,7 @@
 #include <net/netfilter/nf_conntrack_bpf.h>
 #include <net/netkit.h>
 #include <linux/un.h>
+#include <net/xdp_sock_drv.h>
 
 #include "dev.h"
 
@@ -4096,6 +4097,42 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)
 	return 0;
 }
 
+static void __shrink_data(struct xdp_buff *xdp, struct xdp_mem_info *mem_info,
+			  skb_frag_t *frag, int shrink)
+{
+	if (mem_info->type == MEM_TYPE_XSK_BUFF_POOL) {
+		struct xdp_buff *tail = xsk_buff_get_tail(xdp);
+
+		if (tail)
+			tail->data_end -= shrink;
+	}
+	skb_frag_size_sub(frag, shrink);
+}
+
+static bool shrink_data(struct xdp_buff *xdp, skb_frag_t *frag, int shrink)
+{
+	struct xdp_mem_info *mem_info = &xdp->rxq->mem;
+
+	if (skb_frag_size(frag) == shrink) {
+		struct page *page = skb_frag_page(frag);
+		struct xdp_buff *zc_frag = NULL;
+
+		if (mem_info->type == MEM_TYPE_XSK_BUFF_POOL) {
+			zc_frag = xsk_buff_get_tail(xdp);
+
+			if (zc_frag) {
+				xdp_buff_clear_frags_flag(zc_frag);
+				xsk_buff_del_tail(zc_frag);
+			}
+		}
+
+		__xdp_return(page_address(page), mem_info, false, zc_frag);
+		return true;
+	}
+	__shrink_data(xdp, mem_info, frag, shrink);
+	return false;
+}
+
 static int bpf_xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
 {
 	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
@@ -4110,17 +4147,10 @@ static int bpf_xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
 
 		len_free += shrink;
 		offset -= shrink;
-
-		if (skb_frag_size(frag) == shrink) {
-			struct page *page = skb_frag_page(frag);
-
-			__xdp_return(page_address(page), &xdp->rxq->mem,
-				     false, NULL);
+		if (shrink_data(xdp, frag, shrink))
 			n_frags_free++;
-		} else {
-			skb_frag_size_sub(frag, shrink);
+		else
 			break;
-		}
 	}
 	sinfo->nr_frags -= n_frags_free;
 	sinfo->xdp_frags_size -= len_free;
-- 
2.34.1


