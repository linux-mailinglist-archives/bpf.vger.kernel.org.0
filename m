Return-Path: <bpf+bounces-4444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A34D574B55D
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 18:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1ADF1C2100C
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 16:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5DF1119E;
	Fri,  7 Jul 2023 16:51:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496171118E;
	Fri,  7 Jul 2023 16:51:07 +0000 (UTC)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9120B210C;
	Fri,  7 Jul 2023 09:51:05 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id DC9EB320015C;
	Fri,  7 Jul 2023 12:51:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 07 Jul 2023 12:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm1; t=1688748663; x=
	1688835063; bh=50Mq7yDH4SaalwjOr9VWbgSV3HaqQVn5wwG7OgrzEBE=; b=O
	fqFSHotl5MPw+omR7FqaSYyuuht7W7DDKg+v2/eHGO1wiruemdRLo1MTeEaSxivu
	s0RqOqhl4TFy4MgwyB4y9pfFdIHne6J062sLfU9D9ZnbB8TpHa13+MCwHJTNR3Pd
	ziLU2yztrAr5IEK8z4JTnpozUddATvo+j/auSNyRTkzoeM2lPRp6Peun6mMavK6y
	197s9men4fwMgPuiWCLujuhJ4L7PDLsyZKK5ZxqoyvkRAQuHUwLLfkwONCmcu6qJ
	k7m9G86SQbFaB8Y95lt7N2uu88MhVOKWEBERHBWC3bVK5dEOFAylvWalPVSpmXBd
	blu7/MSzz303GiEMx0ioA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688748663; x=
	1688835063; bh=50Mq7yDH4SaalwjOr9VWbgSV3HaqQVn5wwG7OgrzEBE=; b=D
	Np3goPrOcaNvkVar8Cni9qJJJxRiaNmv68DIU97gBo83H1Shc3FaPPL9oTLGfT7w
	dScyySdJRWCiMJJ9bge8rxrHAamfreAqNRiLBCFxBCPWuFw4cmpOFSN6xw4JHGmw
	XOBKoAzWz9QJ3NSbvWsbw6lxVKgEcUYX9Uk0WCzPapCEj4ZXro8wKYdYDCKyibh5
	5d0zn8nCfiNT2q1GIo6msaVFV8uxw9iROpCVRmGKNZ/QoveToLk4v4svwTSiSfu0
	rtES0SaHXVtkEKv+EPPQUmX/pXX+GZBKLQosL6RIIJwu1uTt/DwdjX1Y0Km+h21b
	+dXMHUSiB7lnsy9SNntdg==
X-ME-Sender: <xms:d0KoZIbcf7VMeTd2CDLCkkaU6jPxCYJGVu_qAVQmjARkOtrHYRyOBA>
    <xme:d0KoZDZlD--WTCl-pKmqvP0vxUIoOS67QTxBo30sEofGd93VDYiHa3pOUIluWksyT
    9NgrVsmIf7bJJgsjA>
X-ME-Received: <xmr:d0KoZC_0pLdD57MCh5ExBGkW8wu6arg5Fcnahjo0n1e5sW-Kr3TSwh08EQSHNd0JkwzxCwC1I0hAN73S6x6l808-fbHJ5Mcv-NtTy9i9nyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvddugddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:d0KoZCqe1Ybln4f3wJ4BvVDyxgxV_OrKQfgbE0WrspwgqIMG_2FL9Q>
    <xmx:d0KoZDrYCczugKjErchDBjf8PttVu2vh_wsoPoRET51LyGpqk5-9KA>
    <xmx:d0KoZATJ09rnpyiok0PiDn5882OlnZd4XYnoWElGl1D-u1Urtp4sew>
    <xmx:d0KoZBhDeJo_fN0BrKphHTOroXT-zf2KYxXER2m9RjLPMhXgHw1RfQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jul 2023 12:51:02 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: pablo@netfilter.org,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	kadlec@netfilter.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	fw@strlen.de,
	daniel@iogearbox.net
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 1/6] netfilter: defrag: Add glue hooks for enabling/disabling defrag
Date: Fri,  7 Jul 2023 10:50:16 -0600
Message-ID: <8a20b0a3fff75bce1bed207631fe4f56abc3e99d.1688748455.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688748455.git.dxu@dxuuu.xyz>
References: <cover.1688748455.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We want to be able to enable/disable IP packet defrag from core
bpf/netfilter code. In other words, execute code from core that could
possibly be built as a module.

To help avoid symbol resolution errors, use glue hooks that the modules
will register callbacks with during module init.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/netfilter.h                 | 12 ++++++++++++
 net/ipv4/netfilter/nf_defrag_ipv4.c       | 16 +++++++++++++++-
 net/ipv6/netfilter/nf_defrag_ipv6_hooks.c | 10 ++++++++++
 net/netfilter/core.c                      |  6 ++++++
 4 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index d4fed4c508ca..77a637b681f2 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -481,6 +481,18 @@ struct nfnl_ct_hook {
 };
 extern const struct nfnl_ct_hook __rcu *nfnl_ct_hook;
 
+struct nf_defrag_v4_hook {
+	int (*enable)(struct net *net);
+	void (*disable)(struct net *net);
+};
+extern const struct nf_defrag_v4_hook __rcu *nf_defrag_v4_hook;
+
+struct nf_defrag_v6_hook {
+	int (*enable)(struct net *net);
+	void (*disable)(struct net *net);
+};
+extern const struct nf_defrag_v6_hook __rcu *nf_defrag_v6_hook;
+
 /*
  * nf_skb_duplicated - TEE target has sent a packet
  *
diff --git a/net/ipv4/netfilter/nf_defrag_ipv4.c b/net/ipv4/netfilter/nf_defrag_ipv4.c
index e61ea428ea18..1f3e0e893b7a 100644
--- a/net/ipv4/netfilter/nf_defrag_ipv4.c
+++ b/net/ipv4/netfilter/nf_defrag_ipv4.c
@@ -7,6 +7,7 @@
 #include <linux/ip.h>
 #include <linux/netfilter.h>
 #include <linux/module.h>
+#include <linux/rcupdate.h>
 #include <linux/skbuff.h>
 #include <net/netns/generic.h>
 #include <net/route.h>
@@ -113,17 +114,30 @@ static void __net_exit defrag4_net_exit(struct net *net)
 	}
 }
 
+static const struct nf_defrag_v4_hook defrag_hook = {
+	.enable = nf_defrag_ipv4_enable,
+	.disable = nf_defrag_ipv4_disable,
+};
+
 static struct pernet_operations defrag4_net_ops = {
 	.exit = defrag4_net_exit,
 };
 
 static int __init nf_defrag_init(void)
 {
-	return register_pernet_subsys(&defrag4_net_ops);
+	int err;
+
+	err = register_pernet_subsys(&defrag4_net_ops);
+	if (err)
+		return err;
+
+	rcu_assign_pointer(nf_defrag_v4_hook, &defrag_hook);
+	return err;
 }
 
 static void __exit nf_defrag_fini(void)
 {
+	rcu_assign_pointer(nf_defrag_v4_hook, NULL);
 	unregister_pernet_subsys(&defrag4_net_ops);
 }
 
diff --git a/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c b/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c
index cb4eb1d2c620..f7c7ee31c472 100644
--- a/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c
+++ b/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/icmp.h>
+#include <linux/rcupdate.h>
 #include <linux/sysctl.h>
 #include <net/ipv6_frag.h>
 
@@ -96,6 +97,11 @@ static void __net_exit defrag6_net_exit(struct net *net)
 	}
 }
 
+static const struct nf_defrag_v6_hook defrag_hook = {
+	.enable = nf_defrag_ipv6_enable,
+	.disable = nf_defrag_ipv6_disable,
+};
+
 static struct pernet_operations defrag6_net_ops = {
 	.exit = defrag6_net_exit,
 };
@@ -114,6 +120,9 @@ static int __init nf_defrag_init(void)
 		pr_err("nf_defrag_ipv6: can't register pernet ops\n");
 		goto cleanup_frag6;
 	}
+
+	rcu_assign_pointer(nf_defrag_v6_hook, &defrag_hook);
+
 	return ret;
 
 cleanup_frag6:
@@ -124,6 +133,7 @@ static int __init nf_defrag_init(void)
 
 static void __exit nf_defrag_fini(void)
 {
+	rcu_assign_pointer(nf_defrag_v6_hook, NULL);
 	unregister_pernet_subsys(&defrag6_net_ops);
 	nf_ct_frag6_cleanup();
 }
diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index 5f76ae86a656..34845155bb85 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -680,6 +680,12 @@ EXPORT_SYMBOL_GPL(nfnl_ct_hook);
 const struct nf_ct_hook __rcu *nf_ct_hook __read_mostly;
 EXPORT_SYMBOL_GPL(nf_ct_hook);
 
+const struct nf_defrag_v4_hook __rcu *nf_defrag_v4_hook __read_mostly;
+EXPORT_SYMBOL_GPL(nf_defrag_v4_hook);
+
+const struct nf_defrag_v6_hook __rcu *nf_defrag_v6_hook __read_mostly;
+EXPORT_SYMBOL_GPL(nf_defrag_v6_hook);
+
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 u8 nf_ctnetlink_has_listener;
 EXPORT_SYMBOL_GPL(nf_ctnetlink_has_listener);
-- 
2.41.0


