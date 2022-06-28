Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88C055E9DD
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 18:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbiF1QfD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 12:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbiF1QeV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 12:34:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6BBD2B1BE
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 09:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656433877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VIykwuh2hcr2Bxi16XwA4ht2ICr0Tj3hWI6npJGZ9V8=;
        b=akktK8I1iDB6rgbMiSRTL+oxSNmJ2m2tHWYQf1bNEFnFzRHqu8QAaeYDy3lfJ7cdwTq2Li
        8SSNt6amttBETEVYT4oGozy8xbTMV9CyTDGPkcd3THmW0ABp4HX/FSXc2f9ynn42TiNLMJ
        i7VcAHEALUF/uDM2jVcDdVOSfwV6JeM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-NUPGTtvwOzS5pI5CuHYAiw-1; Tue, 28 Jun 2022 12:31:15 -0400
X-MC-Unique: NUPGTtvwOzS5pI5CuHYAiw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79B01811E7A;
        Tue, 28 Jun 2022 16:31:15 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10E292166B26;
        Tue, 28 Jun 2022 16:31:15 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 0F53430736C72;
        Tue, 28 Jun 2022 18:31:14 +0200 (CEST)
Subject: [PATCH RFC bpf-next 8/9] net: use XDP-hints in xdp_frame to SKB
 conversion
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org
Cc:     xdp-hints@xdp-project.net,
        Jesper Dangaard Brouer <brouer@redhat.com>
Date:   Tue, 28 Jun 2022 18:31:14 +0200
Message-ID: <165643387403.449467.14377454384852564573.stgit@firesoul>
In-Reply-To: <165643378969.449467.13237011812569188299.stgit@firesoul>
References: <165643378969.449467.13237011812569188299.stgit@firesoul>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch makes the net/core/xdp function __xdp_build_skb_from_frame()
consume HW offloads provided via XDP-hints when creating an SKB based
on an xdp_frame. This is an initial step towards SKB less drivers that
moves SKB handing to net/core.

Current users that already benefit from this are: Redirect into veth
and cpumap. XDP_PASS action in bpf_test_run_xdp_live and driver
ethernet/aquantia/atlantic/.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 include/net/xdp.h |   10 ++++++++
 net/core/xdp.c    |   68 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 72 insertions(+), 6 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 710d145a26f9..9917fa1a2d39 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -351,6 +351,16 @@ static __always_inline bool xdp_frame_is_frag_pfmemalloc(struct xdp_frame *frame
 	return !!(frame->flags & XDP_FLAGS_FRAGS_PF_MEMALLOC);
 }
 
+static __always_inline bool xdp_frame_has_hints_compat(struct xdp_frame *xdpf)
+{
+	u32 flags = xdpf->flags;
+
+	if (!(flags & XDP_FLAGS_HINTS_COMPAT_COMMON))
+		return false;
+
+	return !!(flags & XDP_FLAGS_HINTS_ORIGIN_MASK);
+}
+
 #define XDP_BULK_QUEUE_SIZE	16
 struct xdp_frame_bulk {
 	int count;
diff --git a/net/core/xdp.c b/net/core/xdp.c
index a57bd5278b47..c60e66982da0 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -618,11 +618,60 @@ int xdp_alloc_skb_bulk(void **skbs, int n_skb, gfp_t gfp)
 }
 EXPORT_SYMBOL_GPL(xdp_alloc_skb_bulk);
 
+static void xdp_hint_skb_record_rx_queue(struct sk_buff *skb,
+					 struct xdp_hints_common *hints)
+{
+	if (hints->xdp_hints_flags & HINT_FLAG_RX_QUEUE)
+		skb_record_rx_queue(skb, hints->rx_queue);
+}
+
+static void xdp_hint_skb_set_hash(struct sk_buff *skb,
+				  struct xdp_hints_common *hints)
+{
+	u32 hash_type = hints->xdp_hints_flags & HINT_FLAG_RX_HASH_TYPE_MASK;
+
+	if (hash_type) {
+		hash_type = hash_type >> HINT_FLAG_RX_HASH_TYPE_SHIFT;
+		skb_set_hash(skb, hints->rx_hash32, hash_type);
+	}
+}
+
+static void xdp_hint_skb_checksum(struct sk_buff *skb,
+				  struct xdp_hints_common *hints)
+{
+	u32 csum_type = hints->xdp_hints_flags & HINT_FLAG_CSUM_TYPE_MASK;
+	u32 csum_level = hints->xdp_hints_flags & HINT_FLAG_CSUM_LEVEL_MASK;
+
+	if (csum_type == CHECKSUM_UNNECESSARY)
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	if (csum_level)
+		skb->csum_level = csum_level >> HINT_FLAG_CSUM_LEVEL_SHIFT;
+
+	/* TODO: First driver implementing CHECKSUM_PARTIAL or CHECKSUM_COMPLETE
+	 *  need to implement handling here.
+	 */
+}
+
+static void xdp_hint_skb_vlan_hw_tag(struct sk_buff *skb,
+				     struct xdp_hints_common *hints)
+{
+	u32 flags = hints->xdp_hints_flags;
+	__be16 proto = htons(ETH_P_8021Q);
+
+	if (flags & HINT_FLAG_VLAN_PROTO_ETH_P_8021AD)
+		proto = htons(ETH_P_8021AD);
+
+	if (flags & HINT_FLAG_VLAN_PRESENT)
+		__vlan_hwaccel_put_tag(skb, hints->vlan_tci, proto);
+}
+
 struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					   struct sk_buff *skb,
 					   struct net_device *dev)
 {
 	struct skb_shared_info *sinfo = xdp_get_shared_info_from_frame(xdpf);
+	struct xdp_hints_common *xdp_hints = NULL;
 	unsigned int headroom, frame_size;
 	void *hard_start;
 	u8 nr_frags;
@@ -640,14 +689,17 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 	frame_size = xdpf->frame_sz;
 
 	hard_start = xdpf->data - headroom;
+	prefetch(xdpf->data); /* cache-line for eth_type_trans */
 	skb = build_skb_around(skb, hard_start, frame_size);
 	if (unlikely(!skb))
 		return NULL;
 
 	skb_reserve(skb, headroom);
 	__skb_put(skb, xdpf->len);
-	if (xdpf->metasize)
+	if (xdpf->metasize) {
 		skb_metadata_set(skb, xdpf->metasize);
+		prefetch(xdpf->data - sizeof(*xdp_hints));
+	}
 
 	if (unlikely(xdp_frame_has_frags(xdpf)))
 		xdp_update_skb_shared_info(skb, nr_frags,
@@ -658,11 +710,15 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 	/* Essential SKB info: protocol and skb->dev */
 	skb->protocol = eth_type_trans(skb, dev);
 
-	/* Optional SKB info, currently missing:
-	 * - HW checksum info		(skb->ip_summed)
-	 * - HW RX hash			(skb_set_hash)
-	 * - RX ring dev queue index	(skb_record_rx_queue)
-	 */
+	/* Populate (optional) HW offload hints in SKB via XDP-hints */
+	if (xdp_frame_has_hints_compat(xdpf)
+	    && xdpf->metasize >= sizeof(*xdp_hints)) {
+		xdp_hints = xdpf->data - sizeof(*xdp_hints);
+		xdp_hint_skb_record_rx_queue(skb, xdp_hints);
+		xdp_hint_skb_set_hash(skb, xdp_hints);
+		xdp_hint_skb_checksum(skb, xdp_hints);
+		xdp_hint_skb_vlan_hw_tag(skb, xdp_hints);
+	}
 
 	/* Until page_pool get SKB return path, release DMA here */
 	xdp_release_frame(xdpf);


