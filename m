Return-Path: <bpf+bounces-5652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747C275D5B6
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 22:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966F51C21748
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 20:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46BE24168;
	Fri, 21 Jul 2023 20:24:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4B524162;
	Fri, 21 Jul 2023 20:24:35 +0000 (UTC)
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128293AA4;
	Fri, 21 Jul 2023 13:24:05 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailnew.west.internal (Postfix) with ESMTP id 0B4E52B00099;
	Fri, 21 Jul 2023 16:23:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 21 Jul 2023 16:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1689970989; x=
	1689978189; bh=EDxNOEbgLa8gl3gQjxhLoql3OoSwDYrcv1iI2rkEv7M=; b=R
	fjH50xHMAbUDPOitQFnWW5wwBq+p26rzbpmbRTQLR7te6zNMEhe8/ZgwHq27tRIx
	86cxMdLxYSeq/pTpwfMToIC87tuEhpoEu3Y7yB56pJBbSTcNFtQY7eqaHo9O6Tct
	eo4Fxyxsz/DG+UM8aLiI2d2T07xc0c0qamUDYFkJOjRreEfsC9Xj0T3S8QxsEwyh
	xcPOu3tVi7bDAnSiW2FbNN5WkngIMclfNsKpICXYXe+nGiypKRXt4dbYKbf5esgw
	N/HNd7SgT6+1zeoNCMpa31E9b5fWvE+27lxdyxHConI5l1JswITUXq09+/1OcHQY
	KUqB9ZkIUo7eCuy17fIVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1689970989; x=
	1689978189; bh=EDxNOEbgLa8gl3gQjxhLoql3OoSwDYrcv1iI2rkEv7M=; b=E
	wQACD6msiaD0YiqTcFqfZdknIE2HimtT1Ynj1nG8d9Ss3wQ/Vd4J3L7xiO1nSWnU
	bPWWRUwE7bwLtkLR6Xp/5Ykz92T48wAnKghjQSS7Z4j8nb0KMxjdEncIGirn+NGX
	uKMkRUbMQ1BcFeyiHl3ZLwMkCXONFxZ3MdMIM/TG8f1/GOuUcq1Rx/5H1QBoXpoQ
	I5zvPMlYFN8nw9dnLLfaVdN5S3pt32zEa5NZNijrP/UxfEJNB5xuvbkrt5WAQR/m
	ijRsadTgyjWhYaogvUPp9IrxcxDmv3/ZOs99J+nwKwR9Yjo64wwcw/JqYsdLkqTF
	cSt2Y3kuCBHzduvDwChsw==
X-ME-Sender: <xms:Lem6ZCJs8qkjCTwSS1gZNAJLqnznpD9karQ_k6g8dQ81MpunqCHA0A>
    <xme:Lem6ZKKyrJzEIOOf2JDxdAbslYOcQrFDSq2B_lAnpiTfAK07avA6RXWWtGrsqKwbg
    ObSY2RpRDuD6leYrA>
X-ME-Received: <xmr:Lem6ZCvzvf4Xyn0SYxvj34Ogth0XSFxGoCjjJhFn8yGZTdd83UpZYdW3D_T4Od8P2yeSbo147WWkDSGlcnYX05jqZhXpNrVIcdVYuizGE4U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgddugeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepjeegveeljeehvdevud
    duffffleelveejueegjedvhedvhedvheethfejgedtieeinecuffhomhgrihhnpehnvght
    fhhilhhtvghrrdhpfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:Lem6ZHaX4NndGVhbL89Jz1fcv2CorS6OG259qydUtSsX0FMDebNgiQ>
    <xmx:Lem6ZJZFwL1RgnS3oFladK6LN1wyBxl3b89ACTMKbipqmA3QvwzUdA>
    <xmx:Lem6ZDABkUS7IVV-FBzYOdlmuxcmxkZJVEWdRpHcHHAKN6A7mrVK0A>
    <xmx:Lem6ZJqbuan-d_NDBQHnyMHqPBXfyQO2EKgSM0TpJwGxufV-0gU3_OI_DVM>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jul 2023 16:23:07 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: daniel@iogearbox.net,
	kadlec@netfilter.org,
	edumazet@google.com,
	ast@kernel.org,
	fw@strlen.de,
	kuba@kernel.org,
	pabeni@redhat.com,
	pablo@netfilter.org,
	andrii@kernel.org,
	davem@davemloft.net,
	alexei.starovoitov@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	dsahern@kernel.org
Subject: [PATCH bpf-next v6 2/5] netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFRAG in netfilter link
Date: Fri, 21 Jul 2023 14:22:46 -0600
Message-ID: <5cff26f97e55161b7d56b09ddcf5f8888a5add1d.1689970773.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689970773.git.dxu@dxuuu.xyz>
References: <cover.1689970773.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This commit adds support for enabling IP defrag using pre-existing
netfilter defrag support. Basically all the flag does is bump a refcnt
while the link the active. Checks are also added to ensure the prog
requesting defrag support is run _after_ netfilter defrag hooks.

We also take care to avoid any issues w.r.t. module unloading -- while
defrag is active on a link, the module is prevented from unloading.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/uapi/linux/bpf.h       |   5 ++
 net/netfilter/nf_bpf_link.c    | 123 +++++++++++++++++++++++++++++----
 tools/include/uapi/linux/bpf.h |   5 ++
 3 files changed, 118 insertions(+), 15 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 739c15906a65..12a5480314a2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1187,6 +1187,11 @@ enum bpf_perf_event_type {
  */
 #define BPF_F_KPROBE_MULTI_RETURN	(1U << 0)
 
+/* link_create.netfilter.flags used in LINK_CREATE command for
+ * BPF_PROG_TYPE_NETFILTER to enable IP packet defragmentation.
+ */
+#define BPF_F_NETFILTER_IP_DEFRAG (1U << 0)
+
 /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
  * the following extensions:
  *
diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
index c36da56d756f..8fe594bbc7e2 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/bpf.h>
 #include <linux/filter.h>
+#include <linux/kmod.h>
+#include <linux/module.h>
 #include <linux/netfilter.h>
 
 #include <net/netfilter/nf_bpf_link.h>
@@ -23,8 +25,88 @@ struct bpf_nf_link {
 	struct nf_hook_ops hook_ops;
 	struct net *net;
 	u32 dead;
+	const struct nf_defrag_hook *defrag_hook;
 };
 
+static const struct nf_defrag_hook *
+get_proto_defrag_hook(struct bpf_nf_link *link,
+		      const struct nf_defrag_hook __rcu *global_hook,
+		      const char *mod)
+{
+	const struct nf_defrag_hook *hook;
+	int err;
+
+	/* RCU protects us from races against module unloading */
+	rcu_read_lock();
+	hook = rcu_dereference(global_hook);
+	if (!hook) {
+		rcu_read_unlock();
+		err = request_module(mod);
+		if (err)
+			return ERR_PTR(err < 0 ? err : -EINVAL);
+
+		rcu_read_lock();
+		hook = rcu_dereference(global_hook);
+	}
+
+	if (hook && try_module_get(hook->owner)) {
+		/* Once we have a refcnt on the module, we no longer need RCU */
+		hook = rcu_pointer_handoff(hook);
+	} else {
+		WARN_ONCE(!hook, "%s has bad registration", mod);
+		hook = ERR_PTR(-ENOENT);
+	}
+	rcu_read_unlock();
+
+	if (!IS_ERR(hook)) {
+		err = hook->enable(link->net);
+		if (err) {
+			module_put(hook->owner);
+			hook = ERR_PTR(err);
+		}
+	}
+
+	return hook;
+}
+
+static int bpf_nf_enable_defrag(struct bpf_nf_link *link)
+{
+	const struct nf_defrag_hook __maybe_unused *hook;
+
+	switch (link->hook_ops.pf) {
+#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4)
+	case NFPROTO_IPV4:
+		hook = get_proto_defrag_hook(link, nf_defrag_v4_hook, "nf_defrag_ipv4");
+		if (IS_ERR(hook))
+			return PTR_ERR(hook);
+
+		link->defrag_hook = hook;
+		return 0;
+#endif
+#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
+	case NFPROTO_IPV6:
+		hook = get_proto_defrag_hook(link, nf_defrag_v6_hook, "nf_defrag_ipv6");
+		if (IS_ERR(hook))
+			return PTR_ERR(hook);
+
+		link->defrag_hook = hook;
+		return 0;
+#endif
+	default:
+		return -EAFNOSUPPORT;
+	}
+}
+
+static void bpf_nf_disable_defrag(struct bpf_nf_link *link)
+{
+	const struct nf_defrag_hook *hook = link->defrag_hook;
+
+	if (!hook)
+		return;
+	hook->disable(link->net);
+	module_put(hook->owner);
+}
+
 static void bpf_nf_link_release(struct bpf_link *link)
 {
 	struct bpf_nf_link *nf_link = container_of(link, struct bpf_nf_link, link);
@@ -32,11 +114,11 @@ static void bpf_nf_link_release(struct bpf_link *link)
 	if (nf_link->dead)
 		return;
 
-	/* prevent hook-not-found warning splat from netfilter core when
-	 * .detach was already called
-	 */
-	if (!cmpxchg(&nf_link->dead, 0, 1))
+	/* do not double release in case .detach was already called */
+	if (!cmpxchg(&nf_link->dead, 0, 1)) {
 		nf_unregister_net_hook(nf_link->net, &nf_link->hook_ops);
+		bpf_nf_disable_defrag(nf_link);
+	}
 }
 
 static void bpf_nf_link_dealloc(struct bpf_link *link)
@@ -92,6 +174,8 @@ static const struct bpf_link_ops bpf_nf_link_lops = {
 
 static int bpf_nf_check_pf_and_hooks(const union bpf_attr *attr)
 {
+	int prio;
+
 	switch (attr->link_create.netfilter.pf) {
 	case NFPROTO_IPV4:
 	case NFPROTO_IPV6:
@@ -102,19 +186,18 @@ static int bpf_nf_check_pf_and_hooks(const union bpf_attr *attr)
 		return -EAFNOSUPPORT;
 	}
 
-	if (attr->link_create.netfilter.flags)
+	if (attr->link_create.netfilter.flags & ~BPF_F_NETFILTER_IP_DEFRAG)
 		return -EOPNOTSUPP;
 
-	/* make sure conntrack confirm is always last.
-	 *
-	 * In the future, if userspace can e.g. request defrag, then
-	 * "defrag_requested && prio before NF_IP_PRI_CONNTRACK_DEFRAG"
-	 * should fail.
-	 */
-	switch (attr->link_create.netfilter.priority) {
-	case NF_IP_PRI_FIRST: return -ERANGE; /* sabotage_in and other warts */
-	case NF_IP_PRI_LAST: return -ERANGE; /* e.g. conntrack confirm */
-	}
+	/* make sure conntrack confirm is always last */
+	prio = attr->link_create.netfilter.priority;
+	if (prio == NF_IP_PRI_FIRST)
+		return -ERANGE;  /* sabotage_in and other warts */
+	else if (prio == NF_IP_PRI_LAST)
+		return -ERANGE;  /* e.g. conntrack confirm */
+	else if ((attr->link_create.netfilter.flags & BPF_F_NETFILTER_IP_DEFRAG) &&
+		 prio <= NF_IP_PRI_CONNTRACK_DEFRAG)
+		return -ERANGE;  /* cannot use defrag if prog runs before nf_defrag */
 
 	return 0;
 }
@@ -149,6 +232,7 @@ int bpf_nf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 
 	link->net = net;
 	link->dead = false;
+	link->defrag_hook = NULL;
 
 	err = bpf_link_prime(&link->link, &link_primer);
 	if (err) {
@@ -156,8 +240,17 @@ int bpf_nf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 		return err;
 	}
 
+	if (attr->link_create.netfilter.flags & BPF_F_NETFILTER_IP_DEFRAG) {
+		err = bpf_nf_enable_defrag(link);
+		if (err) {
+			bpf_link_cleanup(&link_primer);
+			return err;
+		}
+	}
+
 	err = nf_register_net_hook(net, &link->hook_ops);
 	if (err) {
+		bpf_nf_disable_defrag(link);
 		bpf_link_cleanup(&link_primer);
 		return err;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 739c15906a65..12a5480314a2 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1187,6 +1187,11 @@ enum bpf_perf_event_type {
  */
 #define BPF_F_KPROBE_MULTI_RETURN	(1U << 0)
 
+/* link_create.netfilter.flags used in LINK_CREATE command for
+ * BPF_PROG_TYPE_NETFILTER to enable IP packet defragmentation.
+ */
+#define BPF_F_NETFILTER_IP_DEFRAG (1U << 0)
+
 /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
  * the following extensions:
  *
-- 
2.41.0


