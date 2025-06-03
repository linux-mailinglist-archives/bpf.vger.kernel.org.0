Return-Path: <bpf+bounces-59526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CABACCC6D
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 19:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254C61896E06
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 17:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234C31E5B94;
	Tue,  3 Jun 2025 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0zGgVA+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8241BC3F;
	Tue,  3 Jun 2025 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748972800; cv=none; b=tnGmOn+IdPNP0mcxM8VVCTUWjrXGk1r9IJq7dhho0ThGQQ9E/uBxC5WwnX3SwNb3FYYYMK2E7KOhbj6PSlFGAzalVjlwhng1HywKOV3Nnj4HL93Sj2Tm/mWg1otR6OIHlEF8Nn72aPmPOmtE0sKP5KznAtkDLGOdH3R+lvYo7dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748972800; c=relaxed/simple;
	bh=qHI5lmVU9Uhwmq5FhfYhc3yzSOkYxipHvNmhX2wCH8I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2YCXkJVWVmziSW/tdxOLkSetWai/0m4plVcAvoDRVJyBY7IUsnj2kUh1ktpDlCtyrZP3kR+gPKDWrJs818ybPHTvb5l/oaRt7uKgbDmBRTpbQ3K0Vp/81+WymOS8CjuzXSwtWOiSWcl2mD0yjVtgdG2fhHrNVQWV6ulkTWjGSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0zGgVA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050A6C4CEED;
	Tue,  3 Jun 2025 17:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748972800;
	bh=qHI5lmVU9Uhwmq5FhfYhc3yzSOkYxipHvNmhX2wCH8I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=o0zGgVA+T9oSLzVwOGQIc19Flu1KlhQGv0n3cQBNhiFbC3UpX0pWRgoD5Z9KkNwvZ
	 PcH374ZDBYzCNRtzD/GHqDk70X+Zdyr90ISdExR7wRzUPb4rWLryAG/8Rfu3ptFZhA
	 qQaG2CcqI3X5oJNv06Kzo32GxxyAeVNNXxpSU4fo6EqSRW91wQxgDNjM8FrdkYj8Ri
	 wG7X/3riKrcXHb/ke0Dy5SA/vnAUDYAe0tyzvRxZS4FHHHEN63+Dy1wpwHNVxisiBZ
	 ogbcc8rwnXP9ppK2el9S4hHoGMQnPuIv7hwED4u//SShvlz+PsRslkRv5ja9/2ZrQj
	 KVlBFpU7i8rZw==
Subject: [PATCH bpf-next V1 7/7] net: xdp: update documentation for
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
Date: Tue, 03 Jun 2025 19:46:35 +0200
Message-ID: <174897279518.1677018.5982630277641723936.stgit@firesoul>
In-Reply-To: <174897271826.1677018.9096866882347745168.stgit@firesoul>
References: <174897271826.1677018.9096866882347745168.stgit@firesoul>
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
 Documentation/networking/xdp-rx-metadata.rst |   74 ++++++++++++++++++++------
 net/core/xdp.c                               |   32 +++++++++++
 2 files changed, 90 insertions(+), 16 deletions(-)

diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
index a6e0ece18be5..2c54208e4f7e 100644
--- a/Documentation/networking/xdp-rx-metadata.rst
+++ b/Documentation/networking/xdp-rx-metadata.rst
@@ -90,22 +90,64 @@ the ``data_meta`` pointer.
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
+The ``XDP_REDIRECT`` action forwards an XDP frame to another net device or a CPU
+(via cpumap/devmap) for further processing. It is invoked using BPF helpers like
+``bpf_redirect_map()`` or ``bpf_redirect()``.  When an XDP frame is redirected,
+the recipient (e.g., an XDP program on a veth device, or the kernel stack via
+cpumap) loses direct access to the original NIC's hardware descriptor and thus
+its hardware metadata
+
+By default, this loss of access means that if an ``xdp_frame`` is redirected and
+then converted to an ``skb``, its ``skb`` fields for hardware-derived metadata
+(like ``skb->hash`` or VLAN info) are not populated from the original
+packet. This can impact features like Generic Receive Offload (GRO).  While XDP
+programs can manually save custom data (e.g., using ``bpf_xdp_adjust_meta()``),
+propagating specific *hardware* RX hints to ``skb`` creation requires using the
+kfuncs described below.
+
+To enable propagating selected hardware RX hints, store BPF kfuncs allow an
+XDP program on the initial NIC to read these hints and then explicitly
+*store* them. The kfuncs place this metadata in locations associated with
+the XDP packet buffer, making it available if an ``skb`` is later built or
+the frame is otherwise processed. For instance, RX hash and VLAN tags are
+stored within the XDP frame's addressable headroom, while RX timestamps are
+typically written to an area corresponding to ``skb_shared_info``.
+
+**Crucially, the BPF programmer must call these "store" kfuncs to save the
+desired hardware hints for propagation.** The system does not do this
+automatically. The NIC driver is responsible for ensuring sufficient headroom is
+available; kfuncs may return ``-ENOSPC`` if space is inadequate for storing
+these hints.
+
+When these kfuncs are used to store hints before redirection:
+
+* If the ``xdp_frame`` is converted to an ``skb``, the networking stack can use
+  the stored hints to populate ``skb`` fields (e.g., ``skb->hash``,
+  ``skb->vlan_tci``, timestamps), aiding netstack features like GRO.
+* When running a second XDP-program after the redirect. The veth driver supports
+  access to the previous stored metadata is accessed though the normal reader
+  kfuncs.
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
index 69077cf4c541..1c0f5f980394 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -984,6 +984,18 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
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
@@ -999,6 +1011,18 @@ __bpf_kfunc int bpf_xdp_store_rx_hash(struct xdp_md *ctx, u32 hash,
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
@@ -1014,6 +1038,14 @@ __bpf_kfunc int bpf_xdp_store_rx_vlan(struct xdp_md *ctx, __be16 vlan_proto,
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



