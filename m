Return-Path: <bpf+bounces-56394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6660A96C77
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 15:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60C117C61E
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 13:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4572B283CB0;
	Tue, 22 Apr 2025 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="OGAuPxTj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dC5C2uEW"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1D427F4E7;
	Tue, 22 Apr 2025 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328240; cv=none; b=NzW+AfvaQYqltGhJMPL1nqaJv6WMlEpoHm+ttigFojnB8uMN8IPj/cIq+E4ShVKpNAiovWNyCVZv9ahJ/fuKri6rsI31tiwRMWvssjQ20AK8fg9UrsMeNAtR+vpCYblJbtSE3EM8VZbu2BLEG1e6ZmWx7t4sS6mSikTTmFbnKOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328240; c=relaxed/simple;
	bh=TsI2PE4UcMlw6oRAGoLo2a4+gY/wPCzVGK84BS18aKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OOfQl9UKkpgcjVqrI7tkZfqu6Rkw1tc/3VStQTlgPKHuKc0eReNdk25j7PXMewo/iiUcpfGhqYvK0s3MDt8C0wi/xCV4/+dUVq0+LKLOBiqvn9q2iQvxAi7fqQWTfR2IMFUfvQmYjmhmOSYnM8FcqHqA8f2RZGt7fzeA4cSkpiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=OGAuPxTj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dC5C2uEW; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6D05B2540212;
	Tue, 22 Apr 2025 09:23:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 22 Apr 2025 09:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1745328237; x=1745414637; bh=OJq7IC0KK0Q9BHmWjjD2m8pjvJVexFc4
	paJLgC2yzZA=; b=OGAuPxTjFhSVpYqL9ELtwxI07Cqjb5jalsFfef1xzzdiNmzP
	u54FF+fQbr15EzfCI1EN4xFuEKvELcGfZh9zhkBbgA4YdgwC70BuM6imD5C/J5qz
	wObYk8SBrFWVzBfdk1o7z7IpphW3fJCG+a5ovNYySI8VzgcOxDIJin2mwScXVffa
	3zh5h13f+9KWitiBgQxrxbgzuDhvqoRTAR1YoSbTE6BXZw/qMjPDGzSpB2SzgHit
	vFbkd9b3lSvLMnPodcf8Qa8wmgKFGU86fRSuIjQFcsMwl+8KHftgCk//AKrerPhS
	3siYMconYySEfh83G0pF0MCeK8zPpKN8yJE5lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745328237; x=
	1745414637; bh=OJq7IC0KK0Q9BHmWjjD2m8pjvJVexFc4paJLgC2yzZA=; b=d
	C5C2uEWJa6o8gRw/i8iIoQq1E3v/cwPAd2kXwLByMDXoRDrGfJurx8kX86yVQSd8
	1+UFJTyY+Al+TxjWiaTJrPES6AXoBkBkXm2KcNoCGS63SNPDkHF11os4t0yLZGy0
	5bLoerOUSPWagFYEEbrI65BVecnSv+0I3KGkDaGC/MPPMXipwsAcIkRFOQ17Ytfk
	dSnrJY1dGr74LoGjieHWvi7xTI8ZovJEMQ7Mf8bhBs7Di7mP1/6OwlK3+Q9k5sut
	9w/aVt3hKlYbZNcWXN6K+kAWOECbxyECMyIoClXD57SQlpWTgupJ46gOPUJGOy5i
	4NFCDdI7h16cNriALBtLw==
X-ME-Sender: <xms:bZgHaCM_rrnptYCahgnjOsQZ-X5Fvutu5e_uDl3Tb6e7wxkHce_Thg>
    <xme:bZgHaA9wJHLAJmtJOXHuZXxFFRXFgS9kGpkZZQOOefYjQF-9IfX5pQ2uoGyu5JF0b
    kLeEOih0DiGnmPsqU0>
X-ME-Received: <xmr:bZgHaJSIZZ2TuW34WnIpbT3Wmda0HtE9KPbjm1oOPu8E9d6gpaDVz1SBckvZlM-7Z7irWPK2vDAM3rAFSqM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehrthhhuhhrucfhrggs
    rhgvuceorghrthhhuhhrsegrrhhthhhurhhfrggsrhgvrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejkeehffejvdefhedtleetgfeivdetgfefffetkeelieefvdefhfeuveevhffh
    ueenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhdpnhgspghrtghpthhtohepuddvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohephigrnhestghlohhuughflhgrrhgvrdgtohhmpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrfihksehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepthhhohhilhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhope
    hjsghrrghnuggvsghurhhgsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopegs
    phhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:bZgHaCuLQ8KCLU0Owj8klJFjzRB2Nu8Cz4sNmXmg1ibuwuLZpQbYBA>
    <xmx:bZgHaKensjc2JMiKm7EDxZ8rbSExj5qOMij0I-miWCLiBTf1jDUPFw>
    <xmx:bZgHaG0IjBo0lFgONCndcdLU4Lwu2bDJAgRpR8LTr-l_nxIlIvv8-A>
    <xmx:bZgHaO8VS9pTIDeGjd2LvTAF7HLx2-3UVjDWgGzJOVHd2jHuUQ8e-g>
    <xmx:bZgHaOwj0qzbjOpLfRXudXxfqIFGrYIVX-rMO19_kFuF2SAeBxWn7ksL>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 09:23:55 -0400 (EDT)
From: Arthur Fabre <arthur@arthurfabre.com>
Date: Tue, 22 Apr 2025 15:23:32 +0200
Subject: [PATCH RFC bpf-next v2 03/17] trait: XDP support
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-afabre-traits-010-rfc2-v2-3-92bcc6b146c9@arthurfabre.com>
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
In-Reply-To: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 ast@kernel.org, kuba@kernel.org, edumazet@google.com, 
 Arthur Fabre <arthur@arthurfabre.com>
X-Mailer: b4 0.14.2

Store the trait KV store in the xdp_buff headroom, right after the
xdp_frame.

Storing it at the front of the headroom makes it easy to add encap
headers / adjust_head(): we don't need to copy the traits out of the way
first.

But, in case we want to change this in the future, disallow traits from
being used at the same time as metadata.

Support for traits is gated on support for metadata: to propagate the
traits to the skb layer, drivers will have to explicitly signal support
like the existing skb_metadata_set() call.

This assumes there is enough headroom to store the traits header. That
avoids having to check in the hot-path, where all we could do anyways is
BUG_ON().

Signed-off-by: Arthur Fabre <arthur@arthurfabre.com>
---
 include/net/xdp.h | 25 ++++++++++++++++++++-
 net/core/filter.c |  7 ++++--
 net/core/xdp.c    | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+), 3 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 16c36813cbf8631ea170d2698f1d3408286129a2..0da1e87afdebfd4323d1944de65a6d63438209bf 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -10,6 +10,7 @@
 #include <linux/filter.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h> /* skb_shared_info */
+#include <net/trait.h>
 
 #include <net/page_pool/types.h>
 
@@ -79,6 +80,7 @@ enum xdp_buff_flags {
 	XDP_FLAGS_META_SUPPORTED	= BIT(2), /* metadata in headroom supported
 						   * by driver
 						   */
+	XDP_FLAGS_TRAITS_SUPPORTED	= BIT(3), /* traits in headroom supported */
 };
 
 struct xdp_buff {
@@ -118,6 +120,13 @@ static __always_inline void xdp_buff_set_frag_pfmemalloc(struct xdp_buff *xdp)
 	xdp->flags |= XDP_FLAGS_FRAGS_PF_MEMALLOC;
 }
 
+#define _XDP_FRAME_SIZE (40)
+
+static __always_inline void *xdp_buff_traits(const struct xdp_buff *xdp)
+{
+	return xdp->data_hard_start + _XDP_FRAME_SIZE;
+}
+
 static __always_inline void
 xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
 {
@@ -137,8 +146,15 @@ xdp_prepare_buff(struct xdp_buff *xdp, unsigned char *hard_start,
 	xdp->data_end = data + data_len;
 	xdp->data_meta = data;
 
-	if (meta_valid)
+	if (meta_valid) {
 		xdp->flags |= XDP_FLAGS_META_SUPPORTED;
+
+		xdp->flags |= XDP_FLAGS_TRAITS_SUPPORTED;
+		/* We assume drivers reserve enough headroom to store xdp_frame
+		 * and the traits header.
+		 */
+		traits_init(xdp_buff_traits(xdp), xdp->data_meta);
+	}
 }
 
 /* Reserve memory area at end-of data area.
@@ -273,6 +289,8 @@ struct xdp_frame {
 	u32 flags; /* supported values defined in xdp_buff_flags */
 };
 
+static_assert(sizeof(struct xdp_frame) == _XDP_FRAME_SIZE);
+
 static __always_inline bool xdp_frame_has_frags(const struct xdp_frame *frame)
 {
 	return !!(frame->flags & XDP_FLAGS_HAS_FRAGS);
@@ -522,6 +540,11 @@ static inline bool xdp_metalen_invalid(unsigned long metalen)
 	return !IS_ALIGNED(metalen, sizeof(u32)) || metalen > meta_max;
 }
 
+static __always_inline void *xdp_data_hard_start(const struct xdp_buff *xdp)
+{
+	return xdp_buff_traits(xdp) + traits_size(xdp_buff_traits(xdp));
+}
+
 struct xdp_attachment_info {
 	struct bpf_prog *prog;
 	u32 flags;
diff --git a/net/core/filter.c b/net/core/filter.c
index f9b3358e274fa4b85e39509b04192c282ba2009c..909962b5d89b8f45c8963f9074e02c7cc5f1c393 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -85,6 +85,7 @@
 #include <linux/un.h>
 #include <net/xdp_sock_drv.h>
 #include <net/inet_dscp.h>
+#include <net/trait.h>
 
 #include "dev.h"
 
@@ -3942,9 +3943,8 @@ static unsigned long xdp_get_metalen(const struct xdp_buff *xdp)
 
 BPF_CALL_2(bpf_xdp_adjust_head, struct xdp_buff *, xdp, int, offset)
 {
-	void *xdp_frame_end = xdp->data_hard_start + sizeof(struct xdp_frame);
 	unsigned long metalen = xdp_get_metalen(xdp);
-	void *data_start = xdp_frame_end + metalen;
+	void *data_start = xdp_data_hard_start(xdp) + metalen;
 	void *data = xdp->data + offset;
 
 	if (unlikely(data < data_start ||
@@ -4247,6 +4247,9 @@ BPF_CALL_2(bpf_xdp_adjust_meta, struct xdp_buff *, xdp, int, offset)
 	if (unlikely(xdp_metalen_invalid(metalen)))
 		return -EACCES;
 
+	/* Traits and meta can't be used together */
+	xdp->flags &= ~XDP_FLAGS_TRAITS_SUPPORTED;
+
 	xdp->data_meta = meta;
 
 	return 0;
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 4ee9ff9dbd0e810425e00c1e8bcc0d7088ddaad4..9b7124d52f377cf800664b3433c047f27956933e 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -1021,3 +1021,69 @@ void xdp_features_clear_redirect_target(struct net_device *dev)
 	xdp_set_features_flag(dev, val);
 }
 EXPORT_SYMBOL_GPL(xdp_features_clear_redirect_target);
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_xdp_trait_set(struct xdp_buff *xdp, u64 key,
+				  const void *val, u64 val__sz, u64 flags)
+{
+	if (!(xdp->flags & XDP_FLAGS_TRAITS_SUPPORTED))
+		return -EOPNOTSUPP;
+	/* Traits and meta can't be used together */
+	xdp->flags &= ~XDP_FLAGS_META_SUPPORTED;
+
+	return trait_set(xdp_buff_traits(xdp), xdp->data, key,
+			 val, val__sz, flags);
+}
+
+__bpf_kfunc int bpf_xdp_trait_is_set(struct xdp_buff *xdp, u64 key)
+{
+	if (!(xdp->flags & XDP_FLAGS_TRAITS_SUPPORTED))
+		return -EOPNOTSUPP;
+	/* Traits and meta can't be used together */
+	xdp->flags &= ~XDP_FLAGS_META_SUPPORTED;
+
+	return trait_is_set(xdp_buff_traits(xdp), key);
+}
+
+__bpf_kfunc int bpf_xdp_trait_get(struct xdp_buff *xdp, u64 key,
+				  void *val, u64 val__sz)
+{
+	if (!(xdp->flags & XDP_FLAGS_TRAITS_SUPPORTED))
+		return -EOPNOTSUPP;
+	/* Traits and meta can't be used together */
+	xdp->flags &= ~XDP_FLAGS_META_SUPPORTED;
+
+	return trait_get(xdp_buff_traits(xdp), key, val, val__sz);
+}
+
+__bpf_kfunc int bpf_xdp_trait_del(struct xdp_buff *xdp, u64 key)
+{
+	if (!(xdp->flags & XDP_FLAGS_TRAITS_SUPPORTED))
+		return -EOPNOTSUPP;
+	/* Traits and meta can't be used together */
+	xdp->flags &= ~XDP_FLAGS_META_SUPPORTED;
+
+	return trait_del(xdp_buff_traits(xdp), key);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(xdp_trait)
+BTF_ID_FLAGS(func, bpf_xdp_trait_set)
+BTF_ID_FLAGS(func, bpf_xdp_trait_is_set)
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


