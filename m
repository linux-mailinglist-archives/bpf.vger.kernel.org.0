Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDEB55E9DB
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 18:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiF1QfA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 12:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237991AbiF1QeF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 12:34:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE9922A725
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 09:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656433861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tqdy4FigqsoKxYEf1vCkrfEQxDja3iU/ZlxhrwADmhA=;
        b=ZqX6twkFC2YYi6ToxWH07WF4EbyAUs+XxsGkv04oE4zZY2WUfW4+nj8WnqYWL9HahWsNsS
        WIoXx17C1lUElxsoXTOQqLu0dUZsjxoJGro/CFvnOFwqyYtXtOoNU9wYiIQfdcxgmYhLjE
        Y+j0MTUIFYT61PBcbPpr4y4DuQ96A1c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-3_yFbrUmMLapBKQ7ps_lxg-1; Tue, 28 Jun 2022 12:31:00 -0400
X-MC-Unique: 3_yFbrUmMLapBKQ7ps_lxg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DA6B3C0F377;
        Tue, 28 Jun 2022 16:31:00 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE2031678F;
        Tue, 28 Jun 2022 16:30:59 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id DE18630736C72;
        Tue, 28 Jun 2022 18:30:58 +0200 (CEST)
Subject: [PATCH RFC bpf-next 5/9] xdp: controlling XDP-hints from BPF-prog via
 helper
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org
Cc:     xdp-hints@xdp-project.net,
        Jesper Dangaard Brouer <brouer@redhat.com>
Date:   Tue, 28 Jun 2022 18:30:58 +0200
Message-ID: <165643385885.449467.3259561784742405947.stgit@firesoul>
In-Reply-To: <165643378969.449467.13237011812569188299.stgit@firesoul>
References: <165643378969.449467.13237011812569188299.stgit@firesoul>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

XDP BPF-prog's need a way to interact with the XDP-hints. This patch
introduces a BPF-helper function, that allow XDP BPF-prog's to interact
with the XDP-hints.

BPF-prog can query if any XDP-hints have been setup and if this is
compatible with the xdp_hints_common struct. If XDP-hints are available
the BPF "origin" is returned (see enum xdp_hints_btf_origin) as BTF can
come from different sources or origins e.g. vmlinux, module or local.

Remember that XDP-hints are setup by the driver prior to calling the
XDP BPF-prog, which is useful for adjusting the HW provided XDP-hints
in-case of HW issues or missing HW features, for use-case like xdp2skb
or AF_XDP.

The BPP-prog might also prefer to use metadata area for other things,
either disabling XDP-hints or updating with another XDP-hints layout
that might still be compatible with common struct. Thus, helper have
"update" and "delete" mode flags.

RFC/TODO: Improve patch: Can verifier validate provided BTF on "update"
and detect if compatible with common struct???

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 include/net/xdp.h        |   42 ++++++++++++++++++++++++++++++++++++++----
 include/uapi/linux/bpf.h |   43 +++++++++++++++++++++++++++++++++++++++++++
 net/core/filter.c        |   45 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+), 4 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 5b77fc8fe5ce..710d145a26f9 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -199,14 +199,22 @@ struct xdp_txq_info {
 };
 
 enum xdp_buff_flags {
-	XDP_FLAGS_HAS_FRAGS		= BIT(0), /* non-linear xdp buff */
-	XDP_FLAGS_FRAGS_PF_MEMALLOC	= BIT(1), /* xdp paged memory is under
+	XDP_FLAGS_HINTS_ORIGIN_BIT0	= BIT(0),/* enum xdp_hints_btf_origin */
+	XDP_FLAGS_HINTS_ORIGIN_BIT1	= BIT(1),
+#define	XDP_FLAGS_HINTS_COMPAT_COMMON_	  BIT(3) /* HINTS_BTF_COMPAT_COMMON */
+	XDP_FLAGS_HINTS_COMPAT_COMMON	= XDP_FLAGS_HINTS_COMPAT_COMMON_,
+
+	XDP_FLAGS_HAS_FRAGS		= BIT(4), /* non-linear xdp buff */
+	XDP_FLAGS_FRAGS_PF_MEMALLOC	= BIT(5), /* xdp paged memory is under
 						   * pressure
 						   */
-	XDP_FLAGS_HAS_HINTS		= BIT(2),
-	XDP_FLAGS_HINTS_COMPAT_COMMON	= BIT(3),
 };
 
+#define XDP_FLAGS_HINTS_ORIGIN_MASK	(XDP_FLAGS_HINTS_ORIGIN_BIT0 |	\
+					 XDP_FLAGS_HINTS_ORIGIN_BIT1)
+#define XDP_FLAGS_HINTS_RETURN_MASK	(XDP_FLAGS_HINTS_ORIGIN_MASK |	\
+					 XDP_FLAGS_HINTS_COMPAT_COMMON)
+
 struct xdp_buff {
 	void *data;
 	void *data_end;
@@ -243,6 +251,32 @@ static __always_inline void xdp_buff_set_frag_pfmemalloc(struct xdp_buff *xdp)
 	xdp->flags |= XDP_FLAGS_FRAGS_PF_MEMALLOC;
 }
 
+static __always_inline bool xdp_buff_has_hints(struct xdp_buff *xdp)
+{
+	return !!(xdp->flags & XDP_FLAGS_HINTS_ORIGIN_MASK);
+}
+
+static __always_inline bool xdp_buff_has_hints_compat(struct xdp_buff *xdp)
+{
+	u32 flags = xdp->flags;
+
+	if (!(flags & XDP_FLAGS_HINTS_COMPAT_COMMON))
+		return false;
+
+	return !!(flags & XDP_FLAGS_HINTS_ORIGIN_MASK);
+}
+
+static __always_inline void xdp_buff_set_hints(struct xdp_buff *xdp,
+					       u32 btf_origin,
+					       bool is_compat_common)
+{
+	u32 common = is_compat_common ? XDP_FLAGS_HINTS_COMPAT_COMMON : 0;
+
+	/* enum xdp_hints_btf_origin */
+	btf_origin &= XDP_FLAGS_HINTS_ORIGIN_MASK;
+	xdp->flags |= btf_origin | common;
+}
+
 static __always_inline void
 xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
 {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e81362891596..1c3780c02239 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5325,6 +5325,31 @@ union bpf_attr {
  *		**-EACCES** if the SYN cookie is not valid.
  *
  *		**-EPROTONOSUPPORT** if CONFIG_IPV6 is not builtin.
+ *
+ * long xdp_hints_btf(struct xdp_buff *xdp_md, u32 btf_origin, u64 flags)
+ *     Description
+ *             Update and get info on XDP hints BTF type and origin.
+ *
+ *             Drivers can provide XDP-hints information via the metadata area,
+ *             which defines the layout of this area via BTF. The BTF ID is
+ *             available as the last member. The BTF ID can originate from
+ *             different sources, e.g. vmlinux, module or local BTF-object.
+ *
+ *             In-case a BPF-prog want to redefine the layout of this area it
+ *             should update the BTF ID (last-member) and MUST call this helper
+ *             to specify the origin for the BTF ID.
+ *
+ *             If updating the BTF ID then caller can request that the layout
+ *             is compatible with kernels xdp_hints_common. This is then
+ *             validated (TODO HOW?!?) before kernel side trust this can be
+ *             used for e.g. populating SKB fields.
+ *
+ *             The **flags** are used to control the mode of the helper.
+ *
+ *     Return
+ *             Returns indications on whether XDP-hints were populated by
+ *             driver via an 'origin' value and whether this layout is
+ *             compatible with kernels xdp_hints_common.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5535,6 +5560,7 @@ union bpf_attr {
 	FN(tcp_raw_gen_syncookie_ipv6),	\
 	FN(tcp_raw_check_syncookie_ipv4),	\
 	FN(tcp_raw_check_syncookie_ipv6),	\
+	FN(xdp_hints_btf),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
@@ -5946,6 +5972,23 @@ struct xdp_md {
 	__u32 egress_ifindex;  /* txq->dev->ifindex */
 };
 
+/* Mode flags for BPF_FUNC_xdp_hints_btf helper. */
+enum xdp_hints_btf_mode_flags {
+	HINTS_BTF_QUERY_ONLY    = (1U << 0),
+	HINTS_BTF_UPDATE        = (1U << 1),
+	HINTS_BTF_DISABLE       = (1U << 2),
+	HINTS_BTF_COMPAT_COMMON = (1U << 3),
+};
+
+/* BTF can come from different sources e.g. vmlinux, module or local */
+enum xdp_hints_btf_origin {
+	BTF_ORIGIN_NONE    = 0,
+	BTF_ORIGIN_VMLINUX = 1,
+	BTF_ORIGIN_MODULE  = 2,
+	BTF_ORIGIN_LOCAL   = 3,
+	BTF_ORIGIN_MASK    = 0x3,
+};
+
 /* DEVMAP map-value layout
  *
  * The struct data-layout of map-value is a configuration interface.
diff --git a/net/core/filter.c b/net/core/filter.c
index 151aa4756bd6..614054f89fdc 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6129,6 +6129,49 @@ static const struct bpf_func_proto bpf_xdp_check_mtu_proto = {
 	.arg5_type      = ARG_ANYTHING,
 };
 
+/* btf_origin type &enum xdp_hints_btf_origin
+ * flags      type &enum xdp_hints_btf_mode_flags
+ */
+BPF_CALL_3(bpf_xdp_hints_btf, struct xdp_buff *, xdp, u32, btf_origin, u64, flags)
+{
+	s64 ret = BTF_ORIGIN_NONE;
+	bool is_compat_common;
+
+	if (flags & HINTS_BTF_QUERY_ONLY) {
+		BUILD_BUG_ON(HINTS_BTF_COMPAT_COMMON != XDP_FLAGS_HINTS_COMPAT_COMMON_);
+		ret = xdp->flags & XDP_FLAGS_HINTS_RETURN_MASK;
+		goto out;
+	}
+	if (flags & HINTS_BTF_DISABLE) {
+		xdp_buff_set_hints(xdp, BTF_ORIGIN_NONE, false);
+		goto out;
+	}
+	if (flags & HINTS_BTF_UPDATE) {
+		is_compat_common = !!(flags & HINTS_BTF_COMPAT_COMMON);
+	/* TODO: Can kernel validate if hints are BTF compat with common? */
+	/* TODO: Could BPF prog provide BTF as ARG_PTR_TO_BTF_ID to prove compat_common ? */
+	/* TODO: Validate if metadata size is >= sizeof(xdp_hints_common) */
+		btf_origin &= BTF_ORIGIN_MASK;
+	/* TODO: Validate if module BTF_ID is large than vmlinux base */
+		xdp_buff_set_hints(xdp, btf_origin, is_compat_common);
+		BUILD_BUG_ON(BTF_ORIGIN_MASK != XDP_FLAGS_HINTS_ORIGIN_MASK);
+		ret = xdp->flags & XDP_FLAGS_HINTS_RETURN_MASK;
+		goto out;
+	}
+
+ out:
+	return ret;
+}
+
+static const struct bpf_func_proto bpf_xdp_hints_btf_proto = {
+	.func		= bpf_xdp_hints_btf,
+	.gpl_only	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_ANYTHING,
+};
+
 #if IS_ENABLED(CONFIG_IPV6_SEG6_BPF)
 static int bpf_push_seg6_encap(struct sk_buff *skb, u32 type, void *hdr, u32 len)
 {
@@ -7959,6 +8002,8 @@ xdp_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_xdp_fib_lookup_proto;
 	case BPF_FUNC_check_mtu:
 		return &bpf_xdp_check_mtu_proto;
+	case BPF_FUNC_xdp_hints_btf:
+		return &bpf_xdp_hints_btf_proto;
 #ifdef CONFIG_INET
 	case BPF_FUNC_sk_lookup_udp:
 		return &bpf_xdp_sk_lookup_udp_proto;


