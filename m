Return-Path: <bpf+bounces-4355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8195774A7A6
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 01:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39DA1C20ED3
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 23:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FBD171BA;
	Thu,  6 Jul 2023 23:26:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC27B171A7;
	Thu,  6 Jul 2023 23:26:23 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5981BC3;
	Thu,  6 Jul 2023 16:26:22 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 2901B5C00E1;
	Thu,  6 Jul 2023 19:26:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 06 Jul 2023 19:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm1; t=1688685982; x=
	1688772382; bh=q+GZB03bv8FWk8Fi1TVDaCiqNoaHfJjJsc6EY7aLdqg=; b=d
	ajqFc2+WLI+82TWCjXDI3fUTiyA1e5YSIVr/195+w77LRdYDkSQg2IP8uvcqANBQ
	Bf99hzP2pDhGj0+NtdqC3xgMiFoTPSLDPSpe1+ZIfWuhVsXP5TNoVmCBsIkdaIBo
	y/aCpmPlftxp+Vg68nYAvAExJg6mEmuWKZg2H4tzDYHAlCU9HZjZl5K3YM+/UOz3
	0EQzI2mT9rvzwqKpf5pjRYD7bv+t04AEoWizCZ/8WqN12/GGYUx0q3Ey81UHJ6ga
	UMiMcqEIRd9Nt4rSSzuqEtwmpP1EgBAuAo1d/cNr0tEGu5AD9519/8dodbPrpr8P
	deH5gpN3JF3fRLH5g3SmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688685982; x=
	1688772382; bh=q+GZB03bv8FWk8Fi1TVDaCiqNoaHfJjJsc6EY7aLdqg=; b=Z
	PRPVuy1Nnpk7552fuze8F7nRqZCIouBMxVE8pOBjAGtUcDDnb0bUJxw2DbPvx1OK
	JXwSPAOT00maCUBb+5gH3UKwQhsMrm4B9h7LpHJUsO38IrBN9bHBjKXaImqqciG+
	LV0W8q8K4cgs+ewOKK+akonksj3bT6G+rwrrJmEbP3lbiOBoMbPgHDecdxvvgm9A
	n2sEapu2fAqC2TDbM8IjbjvDZkehGb10fOHFDt0C23sp0jPOaz6sINsYb/KUYAUk
	jiMCa698yq2I+FPl5DfjKC5VALPC6EyNrai5N7xzOx0jOfBEnSW0U4jCZsgR4Gtu
	x0ywPn1escick0aqFHetg==
X-ME-Sender: <xms:nk2nZN40hwToJz5HaFo6S6jH_TEP60IYM2pAGqaTRn3mO3t08A8XIQ>
    <xme:nk2nZK4Sr-87zhQI6mFhJTRf6-10adRqypUvLMjhlKWwIExaQOczrFE0sEE3AtQn2
    iqjSh5ALWAp-zNImQ>
X-ME-Received: <xmr:nk2nZEegG2ydWbrbWohcxqZV7VJmYriud2zqUPshBIKLxeoPwkKdeIQ6GhwqElbXi3ciNXz6naOB2v1SQTJgySV7sC4vb9Yn6f-VCQtF7FY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvddtgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduieekvd
    euteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhiiigv
    pedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:nk2nZGJ0GnKfsSbw0vfIuLoAfXkxeaQG7pMO2g_q7dr7eRTWs-qDpQ>
    <xmx:nk2nZBJeb9yH1A6CB9LniQgSHlICd0kOzY16C5_lepn7GW0ZSpOW7w>
    <xmx:nk2nZPzVbb_aLMVOaw-LMsKir2hJAbFoIv5WQJS_ujwFNJO5HSh6mw>
    <xmx:nk2nZLAud1mD3mYZ3_kLodyMnQbGW32IRiSnaMXJH_2j_J3mbpo9_Q>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jul 2023 19:26:20 -0400 (EDT)
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
Subject: [PATCH bpf-next v2 3/6] netfilter: bpf: Prevent defrag module unload while link active
Date: Thu,  6 Jul 2023 17:25:50 -0600
Message-ID: <81ede90e3f1468763ea5b0b6ec2971b7b1b870c1.1688685338.git.dxu@dxuuu.xyz>
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

While in practice we could handle the module being unloaded while a
netfilter link (that requested defrag) was active, it's a better user
experience to prevent the defrag module from going away. It would
violate user expectations if fragmented packets started showing up if
some other part of the system tried to unload defrag module.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/netfilter.h                 |  3 +++
 net/ipv4/netfilter/nf_defrag_ipv4.c       |  1 +
 net/ipv6/netfilter/nf_defrag_ipv6_hooks.c |  1 +
 net/netfilter/nf_bpf_link.c               | 21 +++++++++++++++++++--
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index 77a637b681f2..a160dc1e23bf 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -11,6 +11,7 @@
 #include <linux/wait.h>
 #include <linux/list.h>
 #include <linux/static_key.h>
+#include <linux/module.h>
 #include <linux/netfilter_defs.h>
 #include <linux/netdevice.h>
 #include <linux/sockptr.h>
@@ -482,12 +483,14 @@ struct nfnl_ct_hook {
 extern const struct nfnl_ct_hook __rcu *nfnl_ct_hook;
 
 struct nf_defrag_v4_hook {
+	struct module *owner;
 	int (*enable)(struct net *net);
 	void (*disable)(struct net *net);
 };
 extern const struct nf_defrag_v4_hook __rcu *nf_defrag_v4_hook;
 
 struct nf_defrag_v6_hook {
+	struct module *owner;
 	int (*enable)(struct net *net);
 	void (*disable)(struct net *net);
 };
diff --git a/net/ipv4/netfilter/nf_defrag_ipv4.c b/net/ipv4/netfilter/nf_defrag_ipv4.c
index 1f3e0e893b7a..fb133bf3131d 100644
--- a/net/ipv4/netfilter/nf_defrag_ipv4.c
+++ b/net/ipv4/netfilter/nf_defrag_ipv4.c
@@ -115,6 +115,7 @@ static void __net_exit defrag4_net_exit(struct net *net)
 }
 
 static const struct nf_defrag_v4_hook defrag_hook = {
+	.owner = THIS_MODULE,
 	.enable = nf_defrag_ipv4_enable,
 	.disable = nf_defrag_ipv4_disable,
 };
diff --git a/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c b/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c
index f7c7ee31c472..29d31721c9c0 100644
--- a/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c
+++ b/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c
@@ -98,6 +98,7 @@ static void __net_exit defrag6_net_exit(struct net *net)
 }
 
 static const struct nf_defrag_v6_hook defrag_hook = {
+	.owner = THIS_MODULE,
 	.enable = nf_defrag_ipv6_enable,
 	.disable = nf_defrag_ipv6_disable,
 };
diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
index 765612cb2370..8ce34696939e 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -2,6 +2,7 @@
 #include <linux/bpf.h>
 #include <linux/filter.h>
 #include <linux/kmod.h>
+#include <linux/module.h>
 #include <linux/netfilter.h>
 
 #include <net/netfilter/nf_bpf_link.h>
@@ -53,6 +54,12 @@ static int bpf_nf_enable_defrag(struct bpf_nf_link *link)
 			}
 		}
 
+		/* Prevent defrag module from going away while in use */
+		if (!try_module_get(v4_hook->owner)) {
+			err = -ENOENT;
+			goto out_v4;
+		}
+
 		err = v4_hook->enable(link->net);
 out_v4:
 		rcu_read_unlock();
@@ -79,6 +86,12 @@ static int bpf_nf_enable_defrag(struct bpf_nf_link *link)
 			}
 		}
 
+		/* Prevent defrag module from going away while in use */
+		if (!try_module_get(v6_hook->owner)) {
+			err = -ENOENT;
+			goto out_v6;
+		}
+
 		err = v6_hook->enable(link->net);
 out_v6:
 		rcu_read_unlock();
@@ -98,8 +111,10 @@ static void bpf_nf_disable_defrag(struct bpf_nf_link *link)
 
 		rcu_read_lock();
 		v4_hook = rcu_dereference(nf_defrag_v4_hook);
-		if (v4_hook)
+		if (v4_hook) {
 			v4_hook->disable(link->net);
+			module_put(v4_hook->owner);
+		}
 		rcu_read_unlock();
 
 		break;
@@ -110,8 +125,10 @@ static void bpf_nf_disable_defrag(struct bpf_nf_link *link)
 
 		rcu_read_lock();
 		v6_hook = rcu_dereference(nf_defrag_v6_hook);
-		if (v6_hook)
+		if (v6_hook) {
 			v6_hook->disable(link->net);
+			module_put(v6_hook->owner);
+		}
 		rcu_read_unlock();
 
 		break;
-- 
2.41.0


