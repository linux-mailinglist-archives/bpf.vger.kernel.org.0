Return-Path: <bpf+bounces-4354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A274374A79C
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 01:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57CB028157B
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 23:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459CD168CB;
	Thu,  6 Jul 2023 23:26:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD22063BA;
	Thu,  6 Jul 2023 23:26:21 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F811BC3;
	Thu,  6 Jul 2023 16:26:20 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 732195C00C8;
	Thu,  6 Jul 2023 19:26:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 06 Jul 2023 19:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm1; t=1688685978; x=
	1688772378; bh=50Mq7yDH4SaalwjOr9VWbgSV3HaqQVn5wwG7OgrzEBE=; b=i
	MmC7YyfNAqXjJdbhv9QlzlkYkxFoTRyeKZBYp77nwt/S6s3qqC9kHyn78vNhSDVd
	c41e1H2KeMcvcYxUi6JneGQRBjk5H4y2DxH9SdxQqBjA3gv9RzxbeNHlOUhXr/0m
	37CYrGVXvVQCJhbLotc0TBfclhde8hLFdjJQ1QD/8xQvb22X4T+nQZVt+OQrbmzS
	Exwy0E57rSuZdd6aYn7y3euafKy6aylOCB0ZQtdvQjcK1ftZBzegpYRXvndmdUdm
	0ELoYwCVhGq9Cytz4N2eaAZpdYkhLfYMnXXh0bJtnZnmcbFT5bi8sv/WQgWrch9/
	LFHt4st8pUW55RFmIh8Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688685978; x=
	1688772378; bh=50Mq7yDH4SaalwjOr9VWbgSV3HaqQVn5wwG7OgrzEBE=; b=I
	yEO8iEM+w1uIEu2/YEr9VFqi4sYs4mbDj4ZZfHaiEmEkjdoDvq2euyIEActD2KVS
	Wfu2MbTzYFzygYgPX1rZJ8+Mfo4fZYOB/sYbppMq/mVqVT5RMhmqyTQ6sqhHwcQi
	XrNCWQEGRlNg8+FGpz9P2q3gZ0iDZ1box8M7/tMwB10svu2S4M1Ai6gA7TLXDpjq
	SX9HDGX/HWtAx2Mcd8Oq1zw1OCQ/AAQ7+VwXVizPqHedai+LFgO3cJPvSumdmPB9
	/KNgepLZkRSLVp+wDz0qH7XH+KnWM6LeCWBXMhfQtsZaO4JVuhTw0phzJtSUhprj
	5iq7kMnu2hJ8HLPgVwFsg==
X-ME-Sender: <xms:mk2nZBlvrxiAgzGkb1el8Kn6JiabfolmnR6ad32G7CHeR0G3C3A1Hg>
    <xme:mk2nZM3fhIFb9UCp5s5rEHAFmkWJFJMCexA_Rse5Lc-Zw4oAvTvG5CIX300NJuHjy
    PsGzbwVssNHTpD5ug>
X-ME-Received: <xmr:mk2nZHrQAZXXn_0CF0BmGkBBuUGBx7mWwDSKmIA23NO5XZhYOnVphecl2A_1CmsPfRbJsBjCF8yBDyYsUKqK6jV6qNS4CM3ZAvNsWW-cj8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvddtgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduieekvd
    euteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:mk2nZBnMblThseeS-lqN_-4EPfrPNaVp0YEagg5pl_7sdvOgc4TTAg>
    <xmx:mk2nZP0g248Y_SKj-3A1i1f4qwl69a9x756IP696R9G7fox9yQ63hQ>
    <xmx:mk2nZAv2EnDxxhDyizYyC1ocPYO9wdvk5XHE1s5GXSBX67z_SlC0BA>
    <xmx:mk2nZNMtjGOc5aFOlEztQeWbKuh-UZ9O9J68xwsFDCqBeKB4H1a1HA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jul 2023 19:26:17 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: pabeni@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	fw@strlen.de,
	davem@davemloft.net,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	dsahern@kernel.org,
	daniel@iogearbox.net
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 1/6] netfilter: defrag: Add glue hooks for enabling/disabling defrag
Date: Thu,  6 Jul 2023 17:25:48 -0600
Message-ID: <20411df83bf659ac202af13923d5a6d82bfd4087.1688685338.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688685338.git.dxu@dxuuu.xyz>
References: <cover.1688685338.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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


