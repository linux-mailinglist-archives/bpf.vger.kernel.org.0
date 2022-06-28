Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C623055E9D8
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 18:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbiF1Qe5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 12:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237827AbiF1QeD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 12:34:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACD0628E3D
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656433853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zxdtYNBM7CImlWbMSmXEaZyLIeHvqNG0C66QMBcnutY=;
        b=euOI8dP1X9hQ6KUjYz+XSlgb+KB/xbwWVa+EKJV4UyDg9brQz1LXobJpKvVex2hBlIJXiw
        LKGbc2R6ftbtptL4bYYT/MWq00+Z7e3mntCVILuJ4wHbsELHBPsmze6rFjRfW1aif8S8vi
        6Y66LLqjstgYl+przTsC6INCUj/VhQg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-442-FHoI1STQNgOpv2Sq8eM6jw-1; Tue, 28 Jun 2022 12:30:50 -0400
X-MC-Unique: FHoI1STQNgOpv2Sq8eM6jw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 46301804191;
        Tue, 28 Jun 2022 16:30:50 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0FA240C141F;
        Tue, 28 Jun 2022 16:30:49 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id C2CD130736C72;
        Tue, 28 Jun 2022 18:30:48 +0200 (CEST)
Subject: [PATCH RFC bpf-next 3/9] net: create xdp_hints_common and set
 functions
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org
Cc:     xdp-hints@xdp-project.net,
        Jesper Dangaard Brouer <brouer@redhat.com>
Date:   Tue, 28 Jun 2022 18:30:48 +0200
Message-ID: <165643384876.449467.4359670537698167416.stgit@firesoul>
In-Reply-To: <165643378969.449467.13237011812569188299.stgit@firesoul>
References: <165643378969.449467.13237011812569188299.stgit@firesoul>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

XDP-hints via BTF are about giving drivers the ability to extend the
common set of hardware offload hints in a flexible way.

This patch start out with defining the common set, based on what is
used available in the SKB. Having this as a common struct in core
vmlinux makes it easier to implement xdp_frame to SKB conversion
routines as normal C-code, see later patches.

Drivers can redefine the layout of the entire metadata area, but are
encouraged to use this common struct as the base, on which they can
extend on top for their extra hardware offload hints. When doing so,
drivers can mark the xdp_buff (and xdp_frame) with flags indicating
this it compatible with the common struct.

Patch also provides XDP-hints driver helper functions for updating the
common struct. Helpers gets inlined and are defined for maximum
performance, which does require some extra care in drivers, e.g. to
keep track of flags to reduce data dependencies, see code DOC.

Userspace and BPF-prog's MUST not consider the common struct UAPI.
The common struct (and enum flags) are only exposed via BTF, which
implies consumers must read and decode this BTF before using/consuming
data layout.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 include/net/xdp.h |  133 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 net/core/xdp.c    |    5 ++
 2 files changed, 138 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 04c852c7a77f..5b77fc8fe5ce 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -8,6 +8,137 @@
 
 #include <linux/skbuff.h> /* skb_shared_info */
 
+/**
+ * DOC: XDP hints
+ *
+ * Drivers should likely include &struct xdp_hints_common as part of the driver
+ * specific xdp_hints struct's, but at the end-of their struct given XDP
+ * metadata area grows backwards.
+ *
+ * The &enum xdp_hints_flags have reserved the first 16 bits for common flags
+ * and drivers can introduce use their own flags bits from BIT(16). For
+ * BPF-progs to find these flags (via BTF) drivers should define an enum
+ * xdp_hints_flags_driver.
+ */
+struct xdp_hints_common {
+	union {
+		__wsum		csum;
+		struct {
+			__u16	csum_start;
+			__u16	csum_offset;
+		};
+	};
+	u16 rx_queue;
+	u16 vlan_tci;
+	u32 rx_hash32;
+	u32 xdp_hints_flags;
+	u32 btf_id;
+} __attribute__((aligned(4))) __attribute__((packed));
+
+enum xdp_hints_flags {
+	HINT_FLAG_CSUM_TYPE_BIT0  = BIT(0),
+	HINT_FLAG_CSUM_TYPE_BIT1  = BIT(1),
+	HINT_FLAG_CSUM_TYPE_MASK  = 0x3,
+
+	HINT_FLAG_CSUM_LEVEL_BIT0 = BIT(2),
+	HINT_FLAG_CSUM_LEVEL_BIT1 = BIT(3),
+	HINT_FLAG_CSUM_LEVEL_MASK = 0xC,
+	HINT_FLAG_CSUM_LEVEL_SHIFT = 2,
+
+	HINT_FLAG_RX_HASH_TYPE_BIT0 = BIT(4),
+	HINT_FLAG_RX_HASH_TYPE_BIT1 = BIT(5),
+	HINT_FLAG_RX_HASH_TYPE_MASK = 0x30,
+	HINT_FLAG_RX_HASH_TYPE_SHIFT = 0x4,
+
+	HINT_FLAG_RX_QUEUE = BIT(7),
+
+	HINT_FLAG_VLAN_PRESENT            = BIT(8),
+	HINT_FLAG_VLAN_PROTO_ETH_P_8021Q  = BIT(9),
+	HINT_FLAG_VLAN_PROTO_ETH_P_8021AD = BIT(10),
+	/* Flags from BIT(16) can be used by drivers */
+};
+
+/** enum xdp_hints_csum_type - BTF exposing checksum defines
+ *
+ * This enum is primarily for BTF exposing ``CHECKSUM_*`` defines (as
+ * an enum) used by &struct skb->ip_summed.
+ *
+ * These values are stored in &enum xdp_hints_flags as bit locations
+ * ``HINT_FLAG_CSUM_TYPE_BIT*``
+
+Maps to skbuff.h skb->ipsummed values. Stored in xdp_hints_flags in
+ * HINT_FLAG_CSUM_TYPE_*
+ */
+enum xdp_hints_csum_type {
+	HINT_CHECKSUM_NONE        = CHECKSUM_NONE,
+	HINT_CHECKSUM_UNNECESSARY = CHECKSUM_UNNECESSARY,
+	HINT_CHECKSUM_COMPLETE    = CHECKSUM_COMPLETE,
+	HINT_CHECKSUM_PARTIAL     = CHECKSUM_PARTIAL,
+};
+
+/** DOC: XDP hints driver helpers
+ *
+ * Helpers for drivers updating struct xdp_hints_common.
+ *
+ * Avoid creating a data dependency on xdp_hints_flags via returning the flags
+ * that need to be set.  Drivers MUST update the xdp_hints_flags member
+ * themselves, which allows drivers to construct code with less data dependency
+ * between instructions by OR'ing the final flags together.
+ */
+
+/* Drivers please use this simple helper to ease changes across drives */
+static __always_inline void xdp_hints_set_flags(struct xdp_hints_common *hints,
+						u32 flags)
+{
+	hints->xdp_hints_flags = flags;
+}
+
+static __always_inline u32 xdp_hints_set_rx_csum(
+	struct xdp_hints_common *hints,
+	u16 type, u16 level)
+{
+	u32 flags;
+
+	flags = type & HINT_FLAG_CSUM_TYPE_MASK;
+	flags |= (level << HINT_FLAG_CSUM_LEVEL_SHIFT)
+		& HINT_FLAG_CSUM_LEVEL_MASK;
+
+	// TODO: handle CHECKSUM_PARTIAL and COMPLETE (needs updating *hints)
+	return flags;
+}
+
+/* @type	Must be &enum enum pkt_hash_types (PKT_HASH_TYPE_*) */
+static __always_inline u32 xdp_hints_set_rx_hash(
+	struct xdp_hints_common *hints,
+	u32 hash, u32 type)
+{
+	hints->rx_hash32 = hash;
+	return (type << HINT_FLAG_RX_HASH_TYPE_SHIFT) &
+		HINT_FLAG_RX_HASH_TYPE_MASK;
+}
+
+static __always_inline u32 xdp_hints_set_rxq(struct xdp_hints_common *hints,
+					     u16 q_idx)
+{
+	hints->rx_queue = q_idx;
+	return HINT_FLAG_RX_QUEUE;
+}
+
+/* @proto	Must be ETH_P_8021Q or ETH_P_8021AD in network order */
+static __always_inline u32 xdp_hints_set_vlan(struct xdp_hints_common *hints,
+					      u16 vlan_tag, const u16 proto)
+{
+	u32 flags = HINT_FLAG_VLAN_PRESENT;
+
+	hints->vlan_tci = vlan_tag;
+	if (proto == htons(ETH_P_8021Q))
+		flags |= HINT_FLAG_VLAN_PROTO_ETH_P_8021Q;
+	if (proto == htons(ETH_P_8021AD))
+		flags |= HINT_FLAG_VLAN_PROTO_ETH_P_8021AD;
+
+	return flags;
+}
+
 /**
  * DOC: XDP RX-queue information
  *
@@ -72,6 +203,8 @@ enum xdp_buff_flags {
 	XDP_FLAGS_FRAGS_PF_MEMALLOC	= BIT(1), /* xdp paged memory is under
 						   * pressure
 						   */
+	XDP_FLAGS_HAS_HINTS		= BIT(2),
+	XDP_FLAGS_HINTS_COMPAT_COMMON	= BIT(3),
 };
 
 struct xdp_buff {
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 24420209bf0e..a57bd5278b47 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -33,6 +33,11 @@ static int mem_id_next = MEM_ID_MIN;
 static bool mem_id_init; /* false */
 static struct rhashtable *mem_id_ht;
 
+/* Make xdp_hints part of core vmlinux BTF */
+struct xdp_hints_common  xdp_hints_common;
+enum xdp_hints_flags     xdp_hints_flags;
+enum xdp_hints_csum_type xdp_hints_csum_type;
+
 static u32 xdp_mem_id_hashfn(const void *data, u32 len, u32 seed)
 {
 	const u32 *k = data;


