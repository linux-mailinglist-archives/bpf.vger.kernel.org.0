Return-Path: <bpf+bounces-62128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A198AF5BFC
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9344177B79
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 14:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D6930E823;
	Wed,  2 Jul 2025 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8jJjDLo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEC22620D5;
	Wed,  2 Jul 2025 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468345; cv=none; b=dymLfEAr+NlNefNEFyAEp5z4WQcWsDEsEH/h4Sv+u6n6qnnBE0JkudI+2HoodbyoGtfQDuZ7NmND1BZpv5H1sKDMnqNrfX8C88YKc3mIWvAvpNRMnKTfpN03bbSK6VjRWtEPnyrWhNjJvzLrH/T+/2G1b2GacRGiQfcIeSSS5NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468345; c=relaxed/simple;
	bh=iU8cjkbiD1V8rEfkQhLFyDJqS2/+nK4xq+1ZWRs13lg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BzQRZkbyogLzEa+lRQRogcpV3dahxiD0ZxbE8IuL4/mN7w2OvivjSv8fnMv6dy+SWW8wG4D743d4yf4LGoTAkBEqYx05Xd/4tmz2KUUuXQXwPUZMOC/Jt8+6TOBHcMdMBldrKRXZi/tv4RA9lgMbGmudv/+x5QpJIr+j340lKhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8jJjDLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75647C4CEE7;
	Wed,  2 Jul 2025 14:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751468345;
	bh=iU8cjkbiD1V8rEfkQhLFyDJqS2/+nK4xq+1ZWRs13lg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=b8jJjDLoT8GowzlULHqZPtmlNy/bMuYhpYPSkQ3qWHwNuHQeh7EQra4MLuilbGgII
	 ugc9yWT3xatpkrw7XfJIqKdBDBGFJivH1BAal1clX+++Rh8hkK2VA5fcjBYiM1qKWl
	 81jO+iYM18B/aLrzBD7qPh9bGVl2a1HC/EE+n4y4+1+rSfP+z5MaStlWEDyQLIv0lF
	 RjbVRPfFZ5lwxODyuFFVY01aTeNjLHm0KoQU3NUcOoXUeA9JYqxAuLHqvcN8a7zVEL
	 v6OoThwpJoia7M93zzomr32GCDEgXLaWpwhLNAfZPd8DIMXlFTgZN+xNfousCymmdO
	 fcr/aps7yJPSQ==
Subject: [PATCH bpf-next V2 7/7] net: xdp: update documentation for
 xdp-rx-metadata.rst
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, lorenzo@kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <borkmann@iogearbox.net>,
 Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 sdf@fomichev.me, kernel-team@cloudflare.com, arthur@arthurfabre.com,
 jakub@cloudflare.com
Date: Wed, 02 Jul 2025 16:58:59 +0200
Message-ID: <175146833962.1421237.12791103620310340595.stgit@firesoul>
In-Reply-To: <175146824674.1421237.18351246421763677468.stgit@firesoul>
References: <175146824674.1421237.18351246421763677468.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Update the documentation[1] based on the changes in this patchset.

[1] https://docs.kernel.org/networking/xdp-rx-metadata.html

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 Documentation/networking/xdp-rx-metadata.rst |   77 +++++++++++++++++++++-----
 net/core/xdp.c                               |   32 +++++++++++
 2 files changed, 93 insertions(+), 16 deletions(-)

diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
index a6e0ece18be5..e2b89c066a82 100644
--- a/Documentation/networking/xdp-rx-metadata.rst
+++ b/Documentation/networking/xdp-rx-metadata.rst
@@ -90,22 +90,67 @@ the ``data_meta`` pointer.
 In the future, we'd like to support a case where an XDP program
 can override some of the metadata used for building ``skbs``.
 
-bpf_redirect_map
-================
-
-``bpf_redirect_map`` can redirect the frame to a different device.
-Some devices (like virtual ethernet links) support running a second XDP
-program after the redirect. However, the final consumer doesn't have
-access to the original hardware descriptor and can't access any of
-the original metadata. The same applies to XDP programs installed
-into devmaps and cpumaps.
-
-This means that for redirected packets only custom metadata is
-currently supported, which has to be prepared by the initial XDP program
-before redirect. If the frame is eventually passed to the kernel, the
-``skb`` created from such a frame won't have any hardware metadata populated
-in its ``skb``. If such a packet is later redirected into an ``XSK``,
-that will also only have access to the custom metadata.
+XDP_REDIRECT
+============
+
+The ``XDP_REDIRECT`` action forwards an XDP frame (``xdp_frame``) to another net
+device or a CPU (via cpumap/devmap) for further processing. It is invoked using
+BPF helpers like ``bpf_redirect_map()`` or ``bpf_redirect()``.  When an XDP
+frame is redirected, the recipient (e.g., an XDP program on a veth device, or
+the kernel stack via cpumap) naturally loses direct access to the original NIC's
+hardware descriptor and thus its hardware metadata hints.
+
+By default, if an ``xdp_frame`` is redirected and then converted to an ``skb``,
+its fields for hardware-derived metadata like ``skb->hash`` are not
+populated. When this occurs, the network stack recalculates the hash in
+software. This is particularly problematic for encapsulated tunnel traffic
+(e.g., IPsec, GRE), as the software hash is based on the outer headers. For a
+single tunnel, this can cause all flows to receive the same hash, leading to
+poor load balancing when redirected to a veth device or processed by cpumap.
+
+To solve this, a BPF program can calculate a more appropriate hint from the
+packet data (e.g., from the inner headers of a tunnel) and store it for later
+use. While it is also possible for the BPF program to propagate existing
+hardware hints, this is not useful for the tunnel use case; it is unnecessary to
+read the existing hardware metadata hint, as it is based on the outer headers
+and must be recalculated to correctly reflect the inner flow.
+
+For example, a BPF program can perform partial decryption on an IPsec packet,
+calculate a hash from the inner headers, and use ``bpf_xdp_store_rx_hash()`` to
+save it. This ensures that when the packet is redirected to a veth device, it is
+placed on the correct RX queue, achieving proper load balancing.
+
+When these kfuncs are used to store hints before redirection:
+
+* If the ``xdp_frame`` is converted to an ``skb``, the networking stack will use
+  the stored hints to populate the corresponding ``skb`` fields (e.g.,
+  ``skb->hash``, ``skb->vlan_tci``, timestamps).
+
+* When running a second XDP-program after the redirect. The veth driver supports
+  access to the previous stored metadata is accessed though the normal reader
+  kfuncs.
+
+The BPF programmer must explicitly call these "store" kfuncs to save the desired
+hints. The NIC driver is responsible for ensuring sufficient headroom is
+available; kfuncs may return ``-ENOSPC`` if space is inadequate.
+
+Kfuncs are available for storing RX hash (``bpf_xdp_store_rx_hash()``),
+VLAN information (``bpf_xdp_store_rx_vlan()``), and hardware timestamps
+(``bpf_xdp_store_rx_ts()``). Consult the kfunc API documentation for usage
+details, expected data, return codes, and relevant XDP flags that may
+indicate success or metadata availability.
+
+Kfuncs for **store** operations:
+
+.. kernel-doc:: net/core/xdp.c
+   :identifiers: bpf_xdp_store_rx_timestamp
+
+.. kernel-doc:: net/core/xdp.c
+   :identifiers: bpf_xdp_store_rx_hash
+
+.. kernel-doc:: net/core/xdp.c
+   :identifiers: bpf_xdp_store_rx_vlan_tag
+
 
 bpf_tail_call
 =============
diff --git a/net/core/xdp.c b/net/core/xdp.c
index f1b2a3b4ba95..e8faf9f6fc7e 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -990,6 +990,18 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
 	return -EOPNOTSUPP;
 }
 
+/**
+ * bpf_xdp_store_rx_hash - Store XDP frame RX hash.
+ * @ctx: XDP context pointer.
+ * @hash: 32-bit hash value.
+ * @rss_type: RSS hash type.
+ *
+ * The RSS hash type (@rss_type) is as descibed in bpf_xdp_metadata_rx_hash.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-NOSPC``   : means device driver doesn't provide enough headroom for storing
+ */
 __bpf_kfunc int bpf_xdp_store_rx_hash(struct xdp_md *ctx, u32 hash,
 				      enum xdp_rss_hash_type rss_type)
 {
@@ -1005,6 +1017,18 @@ __bpf_kfunc int bpf_xdp_store_rx_hash(struct xdp_md *ctx, u32 hash,
 	return 0;
 }
 
+/**
+ * bpf_xdp_store_rx_vlan_tag - Store XDP packet outermost VLAN tag
+ * @ctx: XDP context pointer.
+ * @vlan_proto: VLAN protocol stored in **network byte order (BE)**
+ * @vlan_tci: VLAN TCI (VID + DEI + PCP) stored in **host byte order**
+ *
+ * See bpf_xdp_metadata_rx_vlan_tag() for byte order reasoning.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-NOSPC``   : means device driver doesn't provide enough headroom for storing
+ */
 __bpf_kfunc int bpf_xdp_store_rx_vlan(struct xdp_md *ctx, __be16 vlan_proto,
 				      u16 vlan_tci)
 {
@@ -1020,6 +1044,14 @@ __bpf_kfunc int bpf_xdp_store_rx_vlan(struct xdp_md *ctx, __be16 vlan_proto,
 	return 0;
 }
 
+/**
+ * bpf_xdp_metadata_rx_timestamp - Store XDP frame RX timestamp.
+ * @ctx: XDP context pointer.
+ * @timestamp: Timestamp value.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ */
 __bpf_kfunc int bpf_xdp_store_rx_ts(struct xdp_md *ctx, u64 ts)
 {
 	struct xdp_buff *xdp = (struct xdp_buff *)ctx;



