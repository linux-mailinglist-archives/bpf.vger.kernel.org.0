Return-Path: <bpf+bounces-4879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD7D7514B2
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 01:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A70A2819EF
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 23:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2855EF9E0;
	Wed, 12 Jul 2023 23:44:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED23EF9DB;
	Wed, 12 Jul 2023 23:44:29 +0000 (UTC)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D4B1986;
	Wed, 12 Jul 2023 16:44:28 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id BC80C320093E;
	Wed, 12 Jul 2023 19:44:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 12 Jul 2023 19:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm1; t=1689205466; x=
	1689291866; bh=3RvQh4jFY2Kh9igZgTiTvyyFsNGKqOCVzW8Fk9+mwA0=; b=i
	NRH/v4y/adbQNUeASl7X2Ut3BZscCaKqyOVJAtoOj/9F0n7Z0atyr3SMw/Opou1a
	abL6MC5YAN9VN6TyK0dSZlAl3x04JHeK+SmLunnAjRyRC38afdReP3Xz2vrVBTGD
	N8PPQ6ctYi7t44NdhcWpp5mEDX9ehG7SL5XtsOTIM/NZ5zEg1bT4OM0AdCX1eUhD
	2xqZRoFDpaGa5YqmuC3van8KJ60mVFR5Atlz1+8FiP4X31qT29Xl91FWHZYbACM7
	glj5Ya7/F5Mc6+oO25dZQEQGKSfary9t7MBDbB5vfQbKUf7jmEVfmXyCO+7SbG2m
	ISJa7RNHFvvv80JvfF/cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1689205466; x=
	1689291866; bh=3RvQh4jFY2Kh9igZgTiTvyyFsNGKqOCVzW8Fk9+mwA0=; b=K
	Ny49kEWLKYYMGp8p7OJ2WvZzKlBWuFGwIRWby523Z31wieUT+hfBDlZhP+1agQ9f
	03cTjmYwRej/BVPh4P/mXOytbGnvI39QNhk/wwil4NSqH4Y+LSLcnctSYf9f1FJX
	3g5culy+GNDIxKdd7QFxAdQexeM0L31h3uDtiKwymYSqtf96/hqyiu9U8NawSGX8
	cPzqx9Q9aTkGy4BZTrLB8QNYeR70VcuBesDfqZMeuLC58Sjk/kMJxiONbAL8T2s2
	W5KNhqFkI+A4APT19k6CXGLCo4WI0RZ6Hg7/8DYiVyyu6BlJDquMdOi9EWgcxMj2
	C/NdNuBRJMvk8aKWXR77A==
X-ME-Sender: <xms:2TqvZDqSlo-ym-Tqfkkx_0sHfTyLN1Y-key0chpcorxEo3TcmMjZ9g>
    <xme:2TqvZNp66stRy8fUTeHeanGWU_eHO9H7bJodRYjRWpXfJ4LGVhBp0-DYeCJ7s8c14
    423nep4oc9ivd2j4A>
X-ME-Received: <xmr:2TqvZAODjsHrvelhzXFL6N08FYhbvtmbXir_3IN5XAwnyZYHecJKJ50RdvFyuo4t2UVmjmjw8t0xZcwOsF2tvEIl9JRKt72hakycYQ-w2Kk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeefgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduieekvd
    euteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:2TqvZG7mCRlGe33kUt0PMMWkIG6ghwm8lagfOSz92ukf5a1EnZ-gBg>
    <xmx:2TqvZC616ZswRdPnHZiVaRidYRGEZFbM0xKsytIYAEuFNaWi11az2w>
    <xmx:2TqvZOgUmMb0HFzISM3huu7Q4h3PxibWrK0fV4ti76GWsLoQiGOKlw>
    <xmx:2jqvZFLOWlgLdjSjITvsDy7UDFbhXVlzeBQ_k_GIdev7n-YG85Cczw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jul 2023 19:44:24 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: fw@strlen.de,
	davem@davemloft.net,
	pabeni@redhat.com,
	pablo@netfilter.org,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	kadlec@netfilter.org,
	alexei.starovoitov@gmail.com,
	daniel@iogearbox.net
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v4 1/6] netfilter: defrag: Add glue hooks for enabling/disabling defrag
Date: Wed, 12 Jul 2023 17:43:56 -0600
Message-ID: <e948d8c93103b6c020cba1d697dc5cd63f9af5e5.1689203090.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689203090.git.dxu@dxuuu.xyz>
References: <cover.1689203090.git.dxu@dxuuu.xyz>
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
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We want to be able to enable/disable IP packet defrag from core
bpf/netfilter code. In other words, execute code from core that could
possibly be built as a module.

To help avoid symbol resolution errors, use glue hooks that the modules
will register callbacks with during module init.

Reviewed-by: Florian Westphal <fw@strlen.de>
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


