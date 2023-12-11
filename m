Return-Path: <bpf+bounces-17439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7AC80DB66
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 21:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F651F21C45
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 20:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1319453E15;
	Mon, 11 Dec 2023 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="TjaV5R8q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VYBObC5E"
X-Original-To: bpf@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF64DC;
	Mon, 11 Dec 2023 12:20:32 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 144795C03DC;
	Mon, 11 Dec 2023 15:20:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 11 Dec 2023 15:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1702326032; x=
	1702412432; bh=piiXiJNdW1NBfwhRBiQgK8RAR9SzPBbGqZhxXCsSKHU=; b=T
	jaV5R8qSAqrZBVsGona2RH/W51gxrBZcYHlUujZg/0akI304Wuccc/UeI3BXOI1W
	hjI2lR5Sb1wRjlfJdVIu8U+SApfLNSQIx8AwyCg7tLLTWxa8kplrwf+Gh9zA8zSN
	MCHQHBGfHJjmqypVFr75flxAzxl+93+DtI9cEsD0zNVZ9Kr9BezDyv4gqZXdGiW9
	oEkzE/OAXG6eDRlRDIbnd+0ERw3fbmdbYCRsE3lwDfsAesRPzjW+8kWEtZIVmWUT
	rQMP1ycrJtwJKFAX4F4D3RzQOzlTQBjgqiPKCrJ8RjZuya3zMEJPs3x2IBCFnsLf
	uDsM8pACjLUkhd9pjvn3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702326032; x=
	1702412432; bh=piiXiJNdW1NBfwhRBiQgK8RAR9SzPBbGqZhxXCsSKHU=; b=V
	YBObC5EmbGJVuILPRtYrqAvQ0XobNk2PvhbGarad4IBpGGdoZUIhXy4YkOSYuvwI
	Aqjn8ddRTd0gtBYwLL4M++RbeTtRrHhLIOqz9AfVnBtqehkk/6bW4O7eY+5rWsmV
	Uw+GHZdvg8ZJbpzIJwPh976ZgwptuLxPzf5blvoGxfft1+8+3p0MpmYoUe8vepKQ
	kUYy5COcKM9KdH9aOGrJiT9h7uCM6Lro8LX2rpsKJ8m0De9T5rq/YeqxV3N/N/S3
	Zn4N7/g2JZJX/IbCSilohA8BPjKskYulp6rqiCjx1gx0g90SgN1qycfGRjd71hG9
	dRMwsiGOYeqBRReKTvvCw==
X-ME-Sender: <xms:Dm93ZQwUDmgOV1xEsJ56pcW1TIgQqtu1tWyrajN19yUpmFZFZHxabA>
    <xme:Dm93ZURtBx8K71Pkor2lWGZN-rU5W21br6zl-Iy-fL_OH4Abzge6-Eetr-jhNHPYm
    MVuxI9IY0kAKMfEGA>
X-ME-Received: <xmr:Dm93ZSX2ZIxB3ysG3w-US4rn6RDQ5FENruFKrc0D_bZksiPZm8Gu6_EoK4-yLHqQ1bi8iWsdzaauotT4RqJyVYENRq49s-33_ETMiriyres>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredt
    redttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpefgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleej
    jeekgfffgefhtddtteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:Dm93Zeh3IcFU6IxUo-C2Y64nPJf3nLLLDrC1xHpY81bl_xRE3SPH3w>
    <xmx:Dm93ZSBCHkNwc7CyOtlwGyTir2n2pXdb4WjgfLKfPIEE80MkhT8Kgg>
    <xmx:Dm93ZfKDsfmujYtzsP3v_2JU7w3d6o8NU1zt1DMOP2JW6TdHjNAldg>
    <xmx:EG93Za1IQkC6LNVHZ9M9LC7SCVOv54J-LfmNbqOuJm6Kn29RI_8Y6A>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 15:20:29 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	Herbert Xu <herbert@gondor.apana.org.au>,
	ast@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	steffen.klassert@secunet.com,
	pabeni@redhat.com,
	hawk@kernel.org,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	eyal.birger@gmail.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	devel@linux-ipsec.org
Subject: [PATCH bpf-next v5 1/9] bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
Date: Mon, 11 Dec 2023 13:20:05 -0700
Message-ID: <e8029421b1a0d045fadb214ba919cc25efab4952.1702325874.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1702325874.git.dxu@dxuuu.xyz>
References: <cover.1702325874.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds an unstable kfunc helper to access internal xfrm_state
associated with an SA. This is intended to be used for the upcoming
IPsec pcpu work to assign special pcpu SAs to a particular CPU. In other
words: for custom software RSS.

That being said, the function that this kfunc wraps is fairly generic
and used for a lot of xfrm tasks. I'm sure people will find uses
elsewhere over time.

Co-developed-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Acked-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/net/xfrm.h        |   9 +++
 net/xfrm/Makefile         |   1 +
 net/xfrm/xfrm_policy.c    |   2 +
 net/xfrm/xfrm_state_bpf.c | 114 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 126 insertions(+)
 create mode 100644 net/xfrm/xfrm_state_bpf.c

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index c9bb0f892f55..1d107241b901 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -2190,4 +2190,13 @@ static inline int register_xfrm_interface_bpf(void)
 
 #endif
 
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF)
+int register_xfrm_state_bpf(void);
+#else
+static inline int register_xfrm_state_bpf(void)
+{
+	return 0;
+}
+#endif
+
 #endif	/* _NET_XFRM_H */
diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
index cd47f88921f5..547cec77ba03 100644
--- a/net/xfrm/Makefile
+++ b/net/xfrm/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_XFRM_USER_COMPAT) += xfrm_compat.o
 obj-$(CONFIG_XFRM_IPCOMP) += xfrm_ipcomp.o
 obj-$(CONFIG_XFRM_INTERFACE) += xfrm_interface.o
 obj-$(CONFIG_XFRM_ESPINTCP) += espintcp.o
+obj-$(CONFIG_DEBUG_INFO_BTF) += xfrm_state_bpf.o
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index c13dc3ef7910..1b7e75159727 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4218,6 +4218,8 @@ void __init xfrm_init(void)
 #ifdef CONFIG_XFRM_ESPINTCP
 	espintcp_init();
 #endif
+
+	register_xfrm_state_bpf();
 }
 
 #ifdef CONFIG_AUDITSYSCALL
diff --git a/net/xfrm/xfrm_state_bpf.c b/net/xfrm/xfrm_state_bpf.c
new file mode 100644
index 000000000000..21630974c27d
--- /dev/null
+++ b/net/xfrm/xfrm_state_bpf.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Unstable XFRM state BPF helpers.
+ *
+ * Note that it is allowed to break compatibility for these functions since the
+ * interface they are exposed through to BPF programs is explicitly unstable.
+ */
+
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <net/xdp.h>
+#include <net/xfrm.h>
+
+/* bpf_xfrm_state_opts - Options for XFRM state lookup helpers
+ *
+ * Members:
+ * @error      - Out parameter, set for any errors encountered
+ *		 Values:
+ *		   -EINVAL - netns_id is less than -1
+ *		   -EINVAL - opts__sz isn't BPF_XFRM_STATE_OPTS_SZ
+ *		   -ENONET - No network namespace found for netns_id
+ * @netns_id	- Specify the network namespace for lookup
+ *		 Values:
+ *		   BPF_F_CURRENT_NETNS (-1)
+ *		     Use namespace associated with ctx
+ *		   [0, S32_MAX]
+ *		     Network Namespace ID
+ * @mark	- XFRM mark to match on
+ * @daddr	- Destination address to match on
+ * @spi		- Security parameter index to match on
+ * @proto	- L3 protocol to match on
+ * @family	- L3 protocol family to match on
+ */
+struct bpf_xfrm_state_opts {
+	s32 error;
+	s32 netns_id;
+	u32 mark;
+	xfrm_address_t daddr;
+	__be32 spi;
+	u8 proto;
+	u16 family;
+};
+
+enum {
+	BPF_XFRM_STATE_OPTS_SZ = sizeof(struct bpf_xfrm_state_opts),
+};
+
+__bpf_kfunc_start_defs();
+
+/* bpf_xdp_get_xfrm_state - Get XFRM state
+ *
+ * Parameters:
+ * @ctx	- Pointer to ctx (xdp_md) in XDP program
+ *		    Cannot be NULL
+ * @opts	- Options for lookup (documented above)
+ *		    Cannot be NULL
+ * @opts__sz	- Length of the bpf_xfrm_state_opts structure
+ *		    Must be BPF_XFRM_STATE_OPTS_SZ
+ */
+__bpf_kfunc struct xfrm_state *
+bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *opts, u32 opts__sz)
+{
+	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
+	struct net *net = dev_net(xdp->rxq->dev);
+	struct xfrm_state *x;
+
+	if (!opts || opts__sz < sizeof(opts->error))
+		return NULL;
+
+	if (opts__sz != BPF_XFRM_STATE_OPTS_SZ) {
+		opts->error = -EINVAL;
+		return NULL;
+	}
+
+	if (unlikely(opts->netns_id < BPF_F_CURRENT_NETNS)) {
+		opts->error = -EINVAL;
+		return NULL;
+	}
+
+	if (opts->netns_id >= 0) {
+		net = get_net_ns_by_id(net, opts->netns_id);
+		if (unlikely(!net)) {
+			opts->error = -ENONET;
+			return NULL;
+		}
+	}
+
+	x = xfrm_state_lookup(net, opts->mark, &opts->daddr, opts->spi,
+			      opts->proto, opts->family);
+
+	if (opts->netns_id >= 0)
+		put_net(net);
+	if (!x)
+		opts->error = -ENOENT;
+
+	return x;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_SET8_START(xfrm_state_kfunc_set)
+BTF_ID_FLAGS(func, bpf_xdp_get_xfrm_state, KF_RET_NULL | KF_ACQUIRE)
+BTF_SET8_END(xfrm_state_kfunc_set)
+
+static const struct btf_kfunc_id_set xfrm_state_xdp_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &xfrm_state_kfunc_set,
+};
+
+int __init register_xfrm_state_bpf(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
+					 &xfrm_state_xdp_kfunc_set);
+}
-- 
2.42.1


