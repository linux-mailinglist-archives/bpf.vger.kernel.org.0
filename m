Return-Path: <bpf+bounces-53322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86753A50218
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 15:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019E6188D946
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 14:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFAA1624D2;
	Wed,  5 Mar 2025 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="bogVGdbs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gqh8aa7V"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B85242911;
	Wed,  5 Mar 2025 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185204; cv=none; b=DzCGZRe4crhT5aZPJoa5c9Nu3aJbOSiwXqhUMRub85YJpMNlo0XVmU9wirXW77qsXYawqjqqlNHNe0J4G5ELzlUPmVEEae4KEEeZIrj8+GOpbgC1r41gbcN/90JAC5dorOM3f3FkHYjEwBRrUySD/pi7V6KusdjqYEBs4ceaDE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185204; c=relaxed/simple;
	bh=EWejSudzCkg0ro7qEMrk6AxjjLTb7NgqepbrvsLhCDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JFxMZe5A2t2YhafVt9Ur9bb1PuDMjvHEUmiJiQGRA3eZ2BifZDpcG7qpgIWvOwn84vFuSJja1YkJrdVNFkbr5UCa0P/ithZSdXNql+wHWdzY5Ug9ClvdKI1o6dU0x1UrLQlOaNobR72IPA8Oh/Oj1qlle1eDzYqC0atrLI63aB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=bogVGdbs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gqh8aa7V; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 5530513826AD;
	Wed,  5 Mar 2025 09:33:21 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 05 Mar 2025 09:33:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1741185201; x=1741271601; bh=Kuu2Ja/7iSsvMscNuv79YgPPg+bC65qw
	g3QSGHAcr2Q=; b=bogVGdbs+xD4mRgMBy+o9prlxwVXC02zYaSjcrxzMV6qw2fR
	tPf/axl7BJBtlbhlGgZdjhGPu6Q5Mn6o5+xmkbT7apgfulkA57FRKivzhiWgYR3C
	JKglBQvgY5PV9qmHtuQ4uiBPOtkQCkPrZSPantAbZGRaRuPtp0OJBVh3jD4A/QyS
	zknhfsTmrZHfp45sK6BvkvbJ/r4ldnsMBcONpBJDDQEP57D8HDtXdnG6feLug2d/
	6pJCT/pu7wOTe6wxfNIknTJx/ssADxEWaB/tkGV0zQL3LN1WR9ZkbRH/EJfECeO/
	e2ax5exFyWO0ykI/Vpv3mb56dkuNh3wtsTDrEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741185201; x=
	1741271601; bh=Kuu2Ja/7iSsvMscNuv79YgPPg+bC65qwg3QSGHAcr2Q=; b=G
	qh8aa7VOD3VYgb6QuxkS8aQymit89Ag5kNBbad6mxilixpjWQvHmU4yFlzNyPfO5
	yF0FejXeX+gliLQSU7gweqFLsc1kMBmnZWkbRXduyQYaD1NJv2yWoEpYIC0dZwJy
	8EMDqqcj8Nh+U1cHjeN5JImIzI6/XXR1FWX9QC+O5ToAxAme0EI5LQFqvfGErmQb
	L7Gf0Ukno4/xcvPXr0jQcjaQm8D/3Vvwq8XR37bmITqCDi/8Tkrj1/k5130+Ybt6
	lmPZSrADTHFlBO65n2r+ibmn5+IZPVP1ckl+U29rltk/OySezR+X98QNI9cDM2Vk
	ek9/B7F/w9nSHpFz9ihxA==
X-ME-Sender: <xms:sWDIZ13KZnmeT22TUv9YW--4T7n3xDhxFXjO32uDfs-JvmJDOxXkfA>
    <xme:sWDIZ8HTRYZgHvAjW8zC5Ygae4bghWPDoBmJXi_h_2Zc275NRqBkRLEUsPcY0Ax-m
    NVxuQ04BG9GuykOjFM>
X-ME-Received: <xmr:sWDIZ17nRnPL1wOEPLIhpjYQqUysg5PAWr7164b_EP0g6ZcO37mc2D4Tm1_5GDxTzAZcT_NAuUWOC23Pods>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhenucggtf
    frrghtthgvrhhnpeffleekuefguedtiedtjeeuudejjeegfefgieelffejjefftefgfedu
    udejheevteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrthhhuhhrsegrrhhthhhurhhf
    rggsrhgvrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehthhhoihhlrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhgs
    ihgrnhgtohhnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehhrgifkheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegrfhgrsghrvgestghlohhuughflhgrrhgvrdgtohhmpdhrtghpthhtohepjh
    grkhhusgestghlohhuughflhgrrhgvrdgtohhmpdhrtghpthhtohephigrnhestghlohhu
    ughflhgrrhgvrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepjhgsrhgrnhguvggsuhhrghestghlohhuughflhgrrhgv
    rdgtohhm
X-ME-Proxy: <xmx:sWDIZy1jmtxGXc68-YXC6WX0fv0nSBQmRtrlnG7MGjZ2ONbrFDdKBg>
    <xmx:sWDIZ4FsllKvWWj3cARnebh_KTtI5WQVszKO7B9PzkpRJ_8T0tEbCw>
    <xmx:sWDIZz-1WrWvnS69ELkfPBv2sWnbn9bwojsvCNjPYXwrTPfXHbqSlA>
    <xmx:sWDIZ1lXJ-FJiduC8XMAKaM9Ko5-jtFEvraz7q4-9vea4DhHAlnpYg>
    <xmx:sWDIZzCpciUV1fBtSQ9sco5nVubqeo7RGjLwsXfqH6rADDb-UomgQE7I>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 09:33:19 -0500 (EST)
From: arthur@arthurfabre.com
Date: Wed, 05 Mar 2025 15:31:59 +0100
Subject: [PATCH RFC bpf-next 02/20] trait: XDP support
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-afabre-traits-010-rfc2-v1-2-d0ecfb869797@cloudflare.com>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 Arthur Fabre <afabre@cloudflare.com>
X-Mailer: b4 0.14.2

From: Arthur Fabre <afabre@cloudflare.com>

Store the trait KV store in the xdp_buff headroom, right after the
xdp_frame.

This ensures it can be used at the same time as XDP metadata, runtime
checks prevent either one from overlapping.
It also avoids having to move the trait KV store on every
xdp_adjust_head() call.

Support for traits is gated on support for metadata: to propagate the
traits to the skb layer, drivers will have to explicitly signal support
like the existing skb_metadata_set() call.

This also makes bounds checks simpler: we can rely on xdp->data_meta
always being a valid hard_end for traits.

This assumes there is enough headroom to store the traits header. That
avoids having to check in the hot-path, where all we could do anyways is
BUG_ON().

Defining _XDP_FRAME_SIZE in skbuff.h seems awkward, but we'll need it
to access the traits in the skb layer. Might as well use it now, to
avoid having to move the definition of struct xdp_frame.

Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
---
 include/linux/skbuff.h |  3 +++
 include/net/xdp.h      | 20 ++++++++++++++++++++
 net/core/filter.c      |  7 +++----
 net/core/xdp.c         | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index bb2b751d274acff931281a72e8b4b0c699b4e8af..03553c2200ab1c3750b799edb94fa3b94e11a5f1 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -274,6 +274,9 @@
 			 SKB_DATA_ALIGN(sizeof(struct sk_buff)) +	\
 			 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
 
+/* From xdp.h, to avoid indirectly including skbuff.h */
+#define _XDP_FRAME_SIZE (40)
+
 struct ahash_request;
 struct net_device;
 struct scatterlist;
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 4dafc5e021f13688f0bf69a21bff58d394d1ac28..58019fa299b56dbd45c104fdfa807f73af6e4fa4 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -10,6 +10,7 @@
 #include <linux/filter.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h> /* skb_shared_info */
+#include <net/trait.h>
 
 #include <net/page_pool/types.h>
 
@@ -115,6 +116,11 @@ static __always_inline void xdp_buff_set_frag_pfmemalloc(struct xdp_buff *xdp)
 	xdp->flags |= XDP_FLAGS_FRAGS_PF_MEMALLOC;
 }
 
+static __always_inline void *xdp_buff_traits(const struct xdp_buff *xdp)
+{
+	return xdp->data_hard_start + _XDP_FRAME_SIZE;
+}
+
 static __always_inline void
 xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
 {
@@ -133,6 +139,13 @@ xdp_prepare_buff(struct xdp_buff *xdp, unsigned char *hard_start,
 	xdp->data = data;
 	xdp->data_end = data + data_len;
 	xdp->data_meta = meta_valid ? data : data + 1;
+
+	if (meta_valid) {
+		/* We assume drivers reserve enough headroom to store xdp_frame
+		 * and the traits header.
+		 */
+		traits_init(xdp_buff_traits(xdp), xdp->data_meta);
+	}
 }
 
 /* Reserve memory area at end-of data area.
@@ -267,6 +280,8 @@ struct xdp_frame {
 	u32 flags; /* supported values defined in xdp_buff_flags */
 };
 
+static_assert(sizeof(struct xdp_frame) == _XDP_FRAME_SIZE);
+
 static __always_inline bool xdp_frame_has_frags(const struct xdp_frame *frame)
 {
 	return !!(frame->flags & XDP_FLAGS_HAS_FRAGS);
@@ -517,6 +532,11 @@ static inline bool xdp_metalen_invalid(unsigned long metalen)
 	return !IS_ALIGNED(metalen, sizeof(u32)) || metalen > meta_max;
 }
 
+static __always_inline void *xdp_meta_hard_start(const struct xdp_buff *xdp)
+{
+	return xdp_buff_traits(xdp) + traits_size(xdp_buff_traits(xdp));
+}
+
 struct xdp_attachment_info {
 	struct bpf_prog *prog;
 	u32 flags;
diff --git a/net/core/filter.c b/net/core/filter.c
index dcc53ac5c5458f67a422453134665d43d466a02e..79b78e7cd57fd78c6cc8443da54ae96408c496b0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -85,6 +85,7 @@
 #include <linux/un.h>
 #include <net/xdp_sock_drv.h>
 #include <net/inet_dscp.h>
+#include <net/trait.h>
 
 #include "dev.h"
 
@@ -3935,9 +3936,8 @@ static unsigned long xdp_get_metalen(const struct xdp_buff *xdp)
 
 BPF_CALL_2(bpf_xdp_adjust_head, struct xdp_buff *, xdp, int, offset)
 {
-	void *xdp_frame_end = xdp->data_hard_start + sizeof(struct xdp_frame);
 	unsigned long metalen = xdp_get_metalen(xdp);
-	void *data_start = xdp_frame_end + metalen;
+	void *data_start = xdp_meta_hard_start(xdp) + metalen;
 	void *data = xdp->data + offset;
 
 	if (unlikely(data < data_start ||
@@ -4228,13 +4228,12 @@ static const struct bpf_func_proto bpf_xdp_adjust_tail_proto = {
 
 BPF_CALL_2(bpf_xdp_adjust_meta, struct xdp_buff *, xdp, int, offset)
 {
-	void *xdp_frame_end = xdp->data_hard_start + sizeof(struct xdp_frame);
 	void *meta = xdp->data_meta + offset;
 	unsigned long metalen = xdp->data - meta;
 
 	if (xdp_data_meta_unsupported(xdp))
 		return -ENOTSUPP;
-	if (unlikely(meta < xdp_frame_end ||
+	if (unlikely(meta < xdp_meta_hard_start(xdp) ||
 		     meta > xdp->data))
 		return -EINVAL;
 	if (unlikely(xdp_metalen_invalid(metalen)))
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 2c6ab6fb452f7b90d85125ae17fef96cfc9a8576..2e87f82aa5f835f60295d859a524e40bd47c42ee 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -1032,3 +1032,53 @@ void xdp_features_clear_redirect_target(struct net_device *dev)
 	xdp_set_features_flag(dev, val);
 }
 EXPORT_SYMBOL_GPL(xdp_features_clear_redirect_target);
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_xdp_trait_set(const struct xdp_buff *xdp, u64 key,
+				  const void *val, u64 val__sz, u64 flags)
+{
+	if (xdp_data_meta_unsupported(xdp))
+		return -EOPNOTSUPP;
+
+	return trait_set(xdp_buff_traits(xdp), xdp->data_meta, key,
+			 val, val__sz, flags);
+}
+
+__bpf_kfunc int bpf_xdp_trait_get(const struct xdp_buff *xdp, u64 key,
+				  void *val, u64 val__sz)
+{
+	if (xdp_data_meta_unsupported(xdp))
+		return -EOPNOTSUPP;
+
+	return trait_get(xdp_buff_traits(xdp), key, val, val__sz);
+}
+
+__bpf_kfunc int bpf_xdp_trait_del(const struct xdp_buff *xdp, u64 key)
+{
+	if (xdp_data_meta_unsupported(xdp))
+		return -EOPNOTSUPP;
+
+	return trait_del(xdp_buff_traits(xdp), key);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(xdp_trait)
+// TODO - should we use KF_TRUSTED_ARGS? https://www.kernel.org/doc/html/next/bpf/kfuncs.html#kf-trusted-args-flag
+BTF_ID_FLAGS(func, bpf_xdp_trait_set)
+BTF_ID_FLAGS(func, bpf_xdp_trait_get)
+BTF_ID_FLAGS(func, bpf_xdp_trait_del)
+BTF_KFUNCS_END(xdp_trait)
+
+static const struct btf_kfunc_id_set xdp_trait_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &xdp_trait,
+};
+
+static int xdp_trait_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
+					 &xdp_trait_kfunc_set);
+}
+late_initcall(xdp_trait_init);

-- 
2.43.0


