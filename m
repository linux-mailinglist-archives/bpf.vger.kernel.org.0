Return-Path: <bpf+bounces-16458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D0A80144C
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 21:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F17E81C20EDE
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 20:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9E357880;
	Fri,  1 Dec 2023 20:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="ZxHE7jnh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l4Snbsb1"
X-Original-To: bpf@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9C110DE;
	Fri,  1 Dec 2023 12:23:54 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 512955C01E3;
	Fri,  1 Dec 2023 15:23:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 01 Dec 2023 15:23:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1701462234; x=
	1701548634; bh=xTRa+2HDeb46JzorfzVt/qXV/++HAxjSIWVmSYgsSnU=; b=Z
	xHE7jnh2/BEdBP3kS+n/nszuIAuUgVFpIRmReUYUUOIca709q3TJskWwzbnijDoK
	ehl7FSwMlc6oZU6QqIL6aRMdEV9rskDYxaOWS9IDdd/H6bgbDBygUxFV+ZAmfsR4
	tyDhRm2sMwzQrdk9kGDuK1W/JtfCiiidALn/DqZcLJDHh58WZ8tG9TNR520TDPZT
	81OYB3Y/I1EsdzGNWwvIe2EK1pMAHtJkvfmxVwklQCRp0wLYAuVJksC11OQlfSbb
	12qA+vMGKuNE1yF7ucIsPKdmH9eh6ZOpGPQntYgkFzjtyzIdxPzeJfWBHRkx/8WO
	fhoMf0L+Ji4jMO0AY4hbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701462234; x=
	1701548634; bh=xTRa+2HDeb46JzorfzVt/qXV/++HAxjSIWVmSYgsSnU=; b=l
	4Snbsb1CARmoxLPg6hpjCSVR08ogs70ShRWw5qDYC8O/rnQFcDIwLyKprWwGC5DY
	v9KTHAFIxbE57YYROhjPNz04dui9PG85SjwXD90t/jL7sNJ3dga4iWFM2pHHx4q1
	13XT1hGzzGQ0w6Q+VdJ4RJ7EiILSNPgitX1AD7bz/y95Aj72splvvpibkamYRXT1
	i9HD6EL9N5jdlcUaE3sf4L+mrkr8UlbiJLNcW6qhjp6eZmU9W1ZonVBaBW9h0ytV
	RIXxaODwM9GXU404UceTpveIjgALlddSnMn0//DVF+H6Z1x2gZMV9QWDNDh+Z2TE
	wJXLn9ZUdK7Vk+N7sEsdg==
X-ME-Sender: <xms:2UBqZR-60XM617xiT9lc6R4wFydLyTAfOHm_kGDRb9PVgiBSVWHgLw>
    <xme:2UBqZVs1Dnwtq4UvlxxllzvG52NxnmrZZ3uBD_eVxR_-2ZF-b6bxb_jP4-gMzX1zK
    JHED-em4vTH8vfsxA>
X-ME-Received: <xmr:2UBqZfDRQKfTpJlEJCZ2k-ybOqoC-wHQKfJmPpxXmXMN6JqCRIAUSvXVs9TbkE5io0Efp6DPMvl9CsctqEG2yswl5bh3-SvXUFWipGHnfrwbCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredt
    redttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpefgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleej
    jeekgfffgefhtddtteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:2UBqZVdvWmG1sFu7hjIxeShd6qnHZ0WP8GkByo7oQ-SVbLEdrGqoDQ>
    <xmx:2UBqZWNWAQa9pmRCCT9MYe8LZzr_dPzh8KPGSXho7rFYC6T3gYnh-w>
    <xmx:2UBqZXlWWcAUXs1L7kb-ORax5aMl6OF4HciF680FyFOwvTvFwiKRzg>
    <xmx:2kBqZbfXfTHijN8I5aGlljWm1aqOh_RjgFuGGCznJKn3cSZDTgECsg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 15:23:52 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: davem@davemloft.net,
	daniel@iogearbox.net,
	kuba@kernel.org,
	edumazet@google.com,
	ast@kernel.org,
	john.fastabend@gmail.com,
	steffen.klassert@secunet.com,
	hawk@kernel.org,
	pabeni@redhat.com,
	"Herbert Xu steffen . klassert @ secunet . com" <herbert@gondor.apana.org.au>,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	devel@linux-ipsec.org
Subject: [PATCH ipsec-next v3 1/9] bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
Date: Fri,  1 Dec 2023 13:23:12 -0700
Message-ID: <490d156ba0dd547329eba79bc536623fb0a2006d.1701462010.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1701462010.git.dxu@dxuuu.xyz>
References: <cover.1701462010.git.dxu@dxuuu.xyz>
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
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/net/xfrm.h        |   9 +++
 net/xfrm/Makefile         |   1 +
 net/xfrm/xfrm_policy.c    |   2 +
 net/xfrm/xfrm_state_bpf.c | 112 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 124 insertions(+)
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
index 000000000000..1681825db506
--- /dev/null
+++ b/net/xfrm/xfrm_state_bpf.c
@@ -0,0 +1,112 @@
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


