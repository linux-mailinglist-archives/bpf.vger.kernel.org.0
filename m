Return-Path: <bpf+bounces-17880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 999A9813D84
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 23:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25CAB1F22403
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 22:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E696F630;
	Thu, 14 Dec 2023 22:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="GSWv5A9B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c7pwMGAs"
X-Original-To: bpf@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF126E2A4;
	Thu, 14 Dec 2023 22:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id CB8F33200B64;
	Thu, 14 Dec 2023 17:49:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 14 Dec 2023 17:49:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1702594161; x=
	1702680561; bh=ynqiDxPX3Efy/SYsYJAsJaqvlEj7twgQpz4HuNKHZPw=; b=G
	SWv5A9BtfOEGRfHe0tp9jmoZbRtjAu2SXhpN6Bf6p6Pv5zjOd3x/3/p1ZSOhug7B
	1c09ZD3eloSoYWMVEOgujqoEM8BYWlleTushJWH/wMtx/qOrLnC0FPJCT1d8h6Y1
	GqZLz3FL98MpROQJsHT2xPzEc26BA2q+GWsyMxSYghALTaj/uruqf8kjp1XhN4Ac
	HIp+cpl2+dFIAFJV1+T93j5Xl0qJw3rv1efvAIQfKVGpUsgG+Y/2GurXj+jTUKiF
	VeysALPEnLERxCMwjs2Bl2vvOC6EpGgLqY18Xywjd9lvfIUnDgbh7Qgcx/sLMOln
	zzdgM3as3neNfFD4VT4ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702594161; x=
	1702680561; bh=ynqiDxPX3Efy/SYsYJAsJaqvlEj7twgQpz4HuNKHZPw=; b=c
	7pwMGAstp5oO4deeIxME8N5VDebShGUoB+yMwnqkF0qCNhoazWhKtVovzmZeE7xW
	n3baTezaHEvBTaG0z+xwT7Zp/BConBvMjSMSQmrpVt8HuMdDQ0IAt1g2fQBNwQVz
	Gt6KyrVMPi+0PKQ1s2bqUpT/2EVllz6KCOaFacpF6V6rAtiIocbM/FugbKHJMEYL
	6NCQEoWoPqQjgmDZtrBJJqjHPRTtyE/gNqPeQ8naytRFKEwLbZP85qFnkKqYUdT8
	ZWWpp4P8KhLrIhYHrCkc7TL1ayCmuoOwPSa2sF+f9W3UeTAZ3pFrNRwJfGu1DdGm
	jj0bB43e2CWtKgVaf2teA==
X-ME-Sender: <xms:cIZ7ZdRMsgzrsL3r_pX18bGoekoXPviXrL5Vl1D60o3YRUa4KNLX9g>
    <xme:cIZ7ZWxKV4ypSG7-5brKchH9pKp1EoqZ0hC8ubj1ffkwoWirsQLSoCJvkfW0qAFJE
    3G_UmGjWPtlnTffAA>
X-ME-Received: <xmr:cIZ7ZS0Q-GhpDE6HNWzu6rY3S-YhEX-6WdMiy-o0nrU7HQagPiCeJyAkGfcXR03zyKTcz5f9MI9B64WxdNxYD7woqN3whBy2A2_zGhIdLGzAJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddttddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertder
    tddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeej
    kefgffeghfdttdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:cIZ7ZVC9hsSy5pKqXSUHcjIjedceQi6g7bJEwbCP990hhbSH_vRJzQ>
    <xmx:cIZ7ZWg_eN0EEYLhH96iNVYTyowLy-s_35npwNDFlvYR3sVgK4-sjw>
    <xmx:cIZ7ZZoL8Xmgf2zHiCnPii7s4o7tIOc7jMTP6npvu4xjFkSb36aXlg>
    <xmx:cYZ7ZRU9C92gQOFgL2hVQGOzxNeguPPDyucld6HDvScfi2vP2W3Awg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 17:49:18 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: davem@davemloft.net,
	hawk@kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	kuba@kernel.org,
	edumazet@google.com,
	john.fastabend@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	pabeni@redhat.com,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	eyal.birger@gmail.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	devel@linux-ipsec.org
Subject: [PATCH bpf-next v6 1/5] bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
Date: Thu, 14 Dec 2023 15:49:02 -0700
Message-ID: <a29699c42f5fad456b875c98dd11c6afc3ffb707.1702593901.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1702593901.git.dxu@dxuuu.xyz>
References: <cover.1702593901.git.dxu@dxuuu.xyz>
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

This commit also adds a corresponding bpf_xdp_xfrm_state_release() kfunc
to release the refcnt acquired by bpf_xdp_get_xfrm_state(). The verifier
will require that all acquired xfrm_state's are released.

Co-developed-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Acked-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/net/xfrm.h        |   9 +++
 net/xfrm/Makefile         |   1 +
 net/xfrm/xfrm_policy.c    |   2 +
 net/xfrm/xfrm_state_bpf.c | 134 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 146 insertions(+)
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
index 000000000000..9e20d4a377f7
--- /dev/null
+++ b/net/xfrm/xfrm_state_bpf.c
@@ -0,0 +1,134 @@
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
+ *		   -ENOENT - No xfrm_state found
+ * @netns_id	- Specify the network namespace for lookup
+ *		 Values:
+ *		   BPF_F_CURRENT_NETNS (-1)
+ *		     Use namespace associated with ctx
+ *		   [0, S32_MAX]
+ *		     Network Namespace ID
+ * @mark	- XFRM mark to match on
+ * @daddr	- Destination address to match on
+ * @spi		- Security parameter index to match on
+ * @proto	- IP protocol to match on (eg. IPPROTO_ESP)
+ * @family	- Protocol family to match on (AF_INET/AF_INET6)
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
+ * A `struct xfrm_state *`, if found, must be released with a corresponding
+ * bpf_xdp_xfrm_state_release.
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
+/* bpf_xdp_xfrm_state_release - Release acquired xfrm_state object
+ *
+ * This must be invoked for referenced PTR_TO_BTF_ID, and the verifier rejects
+ * the program if any references remain in the program in all of the explored
+ * states.
+ *
+ * Parameters:
+ * @x		- Pointer to referenced xfrm_state object, obtained using
+ *		  bpf_xdp_get_xfrm_state.
+ */
+__bpf_kfunc void bpf_xdp_xfrm_state_release(struct xfrm_state *x)
+{
+	xfrm_state_put(x);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_SET8_START(xfrm_state_kfunc_set)
+BTF_ID_FLAGS(func, bpf_xdp_get_xfrm_state, KF_RET_NULL | KF_ACQUIRE)
+BTF_ID_FLAGS(func, bpf_xdp_xfrm_state_release, KF_RELEASE)
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


