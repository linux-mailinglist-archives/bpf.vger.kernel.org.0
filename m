Return-Path: <bpf+bounces-18162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C477581659F
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 05:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E944B1C22104
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 04:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C426FA5;
	Mon, 18 Dec 2023 04:18:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out199-1.us.a.mail.aliyun.com (out199-1.us.a.mail.aliyun.com [47.90.199.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894A46ABD;
	Mon, 18 Dec 2023 04:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vye8nWS_1702873107;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0Vye8nWS_1702873107)
          by smtp.aliyun-inc.com;
          Mon, 18 Dec 2023 12:18:27 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	coreteam@netfilter.org,
	netfilter-devel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org
Subject: [RFC nf-next v2 1/2] netfilter: bpf: support prog update
Date: Mon, 18 Dec 2023 12:18:20 +0800
Message-Id: <1702873101-77522-2-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702873101-77522-1-git-send-email-alibuda@linux.alibaba.com>
References: <1702873101-77522-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

To support the prog update, we need to ensure that the prog seen
within the hook is always valid. Considering that hooks are always
protected by rcu_read_lock(), which provide us the ability to
access the prog under rcu.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/netfilter/nf_bpf_link.c | 63 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
index e502ec0..8eed7cf 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -8,17 +8,8 @@
 #include <net/netfilter/nf_bpf_link.h>
 #include <uapi/linux/netfilter_ipv4.h>
 
-static unsigned int nf_hook_run_bpf(void *bpf_prog, struct sk_buff *skb,
-				    const struct nf_hook_state *s)
-{
-	const struct bpf_prog *prog = bpf_prog;
-	struct bpf_nf_ctx ctx = {
-		.state = s,
-		.skb = skb,
-	};
-
-	return bpf_prog_run(prog, &ctx);
-}
+/* protect link update in parallel */
+static DEFINE_MUTEX(bpf_nf_mutex);
 
 struct bpf_nf_link {
 	struct bpf_link link;
@@ -26,8 +17,20 @@ struct bpf_nf_link {
 	struct net *net;
 	u32 dead;
 	const struct nf_defrag_hook *defrag_hook;
+	struct rcu_head head;
 };
 
+static unsigned int nf_hook_run_bpf(void *bpf_link, struct sk_buff *skb,
+				    const struct nf_hook_state *s)
+{
+	const struct bpf_nf_link *nf_link = bpf_link;
+	struct bpf_nf_ctx ctx = {
+		.state = s,
+		.skb = skb,
+	};
+	return bpf_prog_run(rcu_dereference(nf_link->link.prog), &ctx);
+}
+
 #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4) || IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
 static const struct nf_defrag_hook *
 get_proto_defrag_hook(struct bpf_nf_link *link,
@@ -126,8 +129,7 @@ static void bpf_nf_link_release(struct bpf_link *link)
 static void bpf_nf_link_dealloc(struct bpf_link *link)
 {
 	struct bpf_nf_link *nf_link = container_of(link, struct bpf_nf_link, link);
-
-	kfree(nf_link);
+	kfree_rcu(nf_link, head);
 }
 
 static int bpf_nf_link_detach(struct bpf_link *link)
@@ -162,7 +164,34 @@ static int bpf_nf_link_fill_link_info(const struct bpf_link *link,
 static int bpf_nf_link_update(struct bpf_link *link, struct bpf_prog *new_prog,
 			      struct bpf_prog *old_prog)
 {
-	return -EOPNOTSUPP;
+	struct bpf_nf_link *nf_link = container_of(link, struct bpf_nf_link, link);
+	int err = 0;
+
+	mutex_lock(&bpf_nf_mutex);
+
+	if (nf_link->dead) {
+		err = -EPERM;
+		goto out;
+	}
+
+	/* target old_prog mismatch */
+	if (old_prog && link->prog != old_prog) {
+		err = -EPERM;
+		goto out;
+	}
+
+	old_prog = link->prog;
+	if (old_prog == new_prog) {
+		/* don't need update */
+		bpf_prog_put(new_prog);
+		goto out;
+	}
+
+	old_prog = xchg(&link->prog, new_prog);
+	bpf_prog_put(old_prog);
+out:
+	mutex_unlock(&bpf_nf_mutex);
+	return err;
 }
 
 static const struct bpf_link_ops bpf_nf_link_lops = {
@@ -226,7 +255,11 @@ int bpf_nf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 
 	link->hook_ops.hook = nf_hook_run_bpf;
 	link->hook_ops.hook_ops_type = NF_HOOK_OP_BPF;
-	link->hook_ops.priv = prog;
+
+	/* bpf_nf_link_release & bpf_nf_link_dealloc() can ensures that link remains
+	 * valid at all times within nf_hook_run_bpf().
+	 */
+	link->hook_ops.priv = link;
 
 	link->hook_ops.pf = attr->link_create.netfilter.pf;
 	link->hook_ops.priority = attr->link_create.netfilter.priority;
-- 
1.8.3.1


