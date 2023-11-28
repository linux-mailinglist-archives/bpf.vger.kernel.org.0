Return-Path: <bpf+bounces-16067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84AD7FC0B6
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 18:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38081282C48
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 17:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941093D0B4;
	Tue, 28 Nov 2023 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="Cg9d71I2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wrvkl5xd"
X-Original-To: bpf@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E0A1BE;
	Tue, 28 Nov 2023 09:54:52 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 128555C018F;
	Tue, 28 Nov 2023 12:54:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 28 Nov 2023 12:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1701194092; x=
	1701280492; bh=xTRa+2HDeb46JzorfzVt/qXV/++HAxjSIWVmSYgsSnU=; b=C
	g9d71I2EiMhyFaB7G/c+W2ub7fXhRbjxh95I7vBEW2QS9Dw+pLj+AcwO7OijpfMU
	1Htk0AG8diqMVk7CpWN1sWCNZQPcMXSKchp1hkvF6T/u+oBIa7nLkLUHuiWalOiG
	qy+UCZ0344uJ2BQxKcB5k5kgLJMsyttc1DunfTUJ1xjMVY97A86dqDm0ILP4rv64
	G/tVlMdLIVYJGbRGwwjBvW7AkbfTZONn5YuKN7hg/mM6gDRmqpx7nWCWIodwbxys
	BSyUFmzplE5ZLRYs2IkWak5NEIif8aYQep6e1mMnm8d15lMWD0Dkw6Le/aZoHU9j
	TFi5vlzZobLvWt2PxXuLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701194092; x=
	1701280492; bh=xTRa+2HDeb46JzorfzVt/qXV/++HAxjSIWVmSYgsSnU=; b=W
	rvkl5xdtP5PzKZ2mqbc6YRDUXm0U3EpXajrKJ+T+pimZWby+vMV9q9UdK+vySA/0
	n5mqFBbGNNsap5SV3sodVc0adZnfKlupRF4V8vTqN69mt8EjBim/95+iOmh7Icb5
	LDvLhfcSxFLeXxyDmbywWTg8ZoUWBnu8zXM3teJsdLfridjyrsyrUhse4KnpN8R0
	oIms79Ptb3ZBlLnpgjCZ7Gl5WIcOhgHRLi0Rftwd3vAuzYSBmPtH2whzuR1tkA9s
	Xv63uaAgIXcYG63bsJGhKl5h/15iwpmH6t0d0ioBAYn8Egwk8FsCC9zaTJXnr1cK
	XQCRCLeMwvjt2rEgDgDUw==
X-ME-Sender: <xms:ailmZYG5XBBnOIrhWOdED06iF4E9y6vsj8GkS_shvmhYlHZse9ckQQ>
    <xme:ailmZRX-Bm9Lat7UqO3ht4FeK9sJl3exlwTybeZglBxS5j3W1SC0Yskay6Cka7aM8
    WuOrrVhcwUqExr5WQ>
X-ME-Received: <xmr:ailmZSJl_fbglVqwjUGgEhfYtOr-Mb3LlLp9QWnaZCjc3SJjQjofeCMAKPuGxovigv_O28Uwuy6BsmEHDW5e3uXgNAvGTk6yixOMINuxvw_pBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeifedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredt
    redttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpefgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleej
    jeekgfffgefhtddtteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:ailmZaEH_M77YXWJUsyiY04yhGpyCbPRTGgKGRk_6kr1yJ7IRTaVOA>
    <xmx:ailmZeWp2XI8wnoRT-yrBRs1-qeccU4-bzn6Sb9qNlB6vt0bKNazlQ>
    <xmx:ailmZdOwUyvs021EgWDpnwwo89MepiO--a9iNEP2xPBEOrb5W-r-iw>
    <xmx:bClmZamfa7OTwVafwOwKfePrPE_IwQsVOXeSfqzKgFA84HthWOQCdQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Nov 2023 12:54:49 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: kuba@kernel.org,
	steffen.klassert@secunet.com,
	john.fastabend@gmail.com,
	Herbert Xu <herbert@gondor.apana.org.au>,
	davem@davemloft.net,
	hawk@kernel.org,
	daniel@iogearbox.net,
	pabeni@redhat.com,
	edumazet@google.com,
	ast@kernel.org,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	devel@linux-ipsec.org
Subject: [PATCH ipsec-next v2 1/6] bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
Date: Tue, 28 Nov 2023 10:54:21 -0700
Message-ID: <490d156ba0dd547329eba79bc536623fb0a2006d.1701193577.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1701193577.git.dxu@dxuuu.xyz>
References: <cover.1701193577.git.dxu@dxuuu.xyz>
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


