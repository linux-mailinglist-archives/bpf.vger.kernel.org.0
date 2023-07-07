Return-Path: <bpf+bounces-4445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E348C74B560
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 18:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F939280C7B
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 16:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8778D168C4;
	Fri,  7 Jul 2023 16:51:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3141095B;
	Fri,  7 Jul 2023 16:51:13 +0000 (UTC)
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61C72119;
	Fri,  7 Jul 2023 09:51:11 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailnew.west.internal (Postfix) with ESMTP id DC54C2B00067;
	Fri,  7 Jul 2023 12:51:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 07 Jul 2023 12:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm1; t=1688748667; x=
	1688755867; bh=VezMYB4YicTitKIY+TkEFPi41YfCsLE9uPWHuApXvaI=; b=o
	IXiUHeK5rYHaRz2mqUJCyH3N7bpSNlHaNTW53lDL6vwB2H0bcYaN07Y7226GYkZG
	CPCGMBOEIFzA2mhPXV9tikdNF21/Q+u8G3ohcfvmJFU1xNpQ3I2KUtoFNhO4kEbc
	CrH685S3GxYnwQX1QpIS4htQOQnu/gVH6m9GAKlcyh88dGTACsE493tGFcn0hrzf
	Vbmby9DLnkapCZvsXVwTGR2yxi71CJFxybCulaohdFWraWiZV9og5iEFZtDT/I/2
	T3IgTjhyw1LZdCnASBYLzNXEoLrVOeA/8EAYsEoE33EE9pVqOk5QwMtU/+/khDUJ
	L0RullPKDWNZd5QiD3G0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688748667; x=
	1688755867; bh=VezMYB4YicTitKIY+TkEFPi41YfCsLE9uPWHuApXvaI=; b=H
	MuEc9RHecFlhMQYG0dl1lRWw+hZmdNIhXk+e5syBdN8CqQmpONt87rWZ47kt4D4A
	1VeIfRu/v9ZlGNNleTshTn20cGXe8Cbf2gWdb8keFco3jHmepG3OUTpScCxdWv4T
	1HU2VTLV6/ixqGj6n4x4gv/3xD3RkB3Ie5nCC5Ar+AgxIlRW94e84Nu0VUh3LWP4
	c79QtK/S8k2tQ+44e9+OtErD4B3Mb2oAj1bUgmt8nLMh2mCwWbVTXxLWYUWLFfIw
	xjeHmA3PGCHTOKc9lC6fgheF4Hr3We9jSjJJn7sPMluUrPoSLjW+k7Mfdt6cnfCY
	tyQsACjwt5ZrAwg93dzmw==
X-ME-Sender: <xms:e0KoZLSIHVbD2_Wz3gN1XnrY2P5yKe8ufiFB_4zm4bgvkTCn-iAufw>
    <xme:e0KoZMwIS5nA59AbCYTgBAnSQmqRISHvMkI1o8bG-VxfrPbqcuUHLu44WkmhhyMkQ
    oPrt8MMvjj5bqbL_g>
X-ME-Received: <xmr:e0KoZA1fSqr0JFQxsq_RWHAg-mXV5lsoBuV_iXYKrEj-N8AGLvWjSy4gXG-jKp3JwoeWVvzPbL_cM5kEiWfXL0TZYQIxSOrGzZCukCeoXIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvddugddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepjeegveeljeehvdevud
    duffffleelveejueegjedvhedvhedvheethfejgedtieeinecuffhomhgrihhnpehnvght
    fhhilhhtvghrrdhpfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:e0KoZLCS730AUGs0HL1gKHIdacfKccuUyq2fksw3H9fjOd1fNhs-IA>
    <xmx:e0KoZEhZT_NrzXvbz7xd_Pfr_-CWXGAf6NC2y4XsDIa_SHEvVxh0VA>
    <xmx:e0KoZPpPRiKo7q8Cg8O_2TtscVCWqirZ7xF377NA2jVQvd3WIWMnMA>
    <xmx:e0KoZPQMKdagBjFDLZJupdVHF3LQPDxSmdyTwg48d7BzhNUD5Uulp3LIT1o>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jul 2023 12:51:05 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	kuba@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	kadlec@netfilter.org,
	andrii@kernel.org,
	pabeni@redhat.com,
	pablo@netfilter.org,
	fw@strlen.de
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
Subject: [PATCH bpf-next v3 2/6] netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFRAG in netfilter link
Date: Fri,  7 Jul 2023 10:50:17 -0600
Message-ID: <3b1c20ea7eb2f77065c683e21a2a5d457a57011d.1688748455.git.dxu@dxuuu.xyz>
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This commit adds support for enabling IP defrag using pre-existing
netfilter defrag support. Basically all the flag does is bump a refcnt
while the link the active. Checks are also added to ensure the prog
requesting defrag support is run _after_ netfilter defrag hooks.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/uapi/linux/bpf.h       |   5 ++
 net/netfilter/nf_bpf_link.c    | 129 ++++++++++++++++++++++++++++++---
 tools/include/uapi/linux/bpf.h |   5 ++
 3 files changed, 128 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 60a9d59beeab..04ac77481583 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1170,6 +1170,11 @@ enum bpf_link_type {
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
index c36da56d756f..5b72aa246577 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/bpf.h>
 #include <linux/filter.h>
+#include <linux/kmod.h>
 #include <linux/netfilter.h>
 
 #include <net/netfilter/nf_bpf_link.h>
@@ -23,8 +24,98 @@ struct bpf_nf_link {
 	struct nf_hook_ops hook_ops;
 	struct net *net;
 	u32 dead;
+	bool defrag;
 };
 
+static int bpf_nf_enable_defrag(struct bpf_nf_link *link)
+{
+	const struct nf_defrag_v4_hook __maybe_unused *v4_hook;
+	const struct nf_defrag_v6_hook __maybe_unused *v6_hook;
+	int err;
+
+	switch (link->hook_ops.pf) {
+#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4)
+	case NFPROTO_IPV4:
+		rcu_read_lock();
+		v4_hook = rcu_dereference(nf_defrag_v4_hook);
+		if (!v4_hook) {
+			rcu_read_unlock();
+			err = request_module("nf_defrag_ipv4");
+			if (err)
+				return err < 0 ? err : -EINVAL;
+
+			rcu_read_lock();
+			v4_hook = rcu_dereference(nf_defrag_v4_hook);
+			if (!v4_hook) {
+				WARN_ONCE(1, "nf_defrag_ipv4 bad registration");
+				err = -ENOENT;
+				goto out_v4;
+			}
+		}
+
+		err = v4_hook->enable(link->net);
+out_v4:
+		rcu_read_unlock();
+		return err;
+#endif
+#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
+	case NFPROTO_IPV6:
+		rcu_read_lock();
+		v6_hook = rcu_dereference(nf_defrag_v6_hook);
+		if (!v6_hook) {
+			rcu_read_unlock();
+			err = request_module("nf_defrag_ipv6");
+			if (err)
+				return err < 0 ? err : -EINVAL;
+
+			rcu_read_lock();
+			v6_hook = rcu_dereference(nf_defrag_v6_hook);
+			if (!v6_hook) {
+				WARN_ONCE(1, "nf_defrag_ipv6_hooks bad registration");
+				err = -ENOENT;
+				goto out_v6;
+			}
+		}
+
+		err = v6_hook->enable(link->net);
+out_v6:
+		rcu_read_unlock();
+		return err;
+#endif
+	default:
+		return -EAFNOSUPPORT;
+	}
+}
+
+static void bpf_nf_disable_defrag(struct bpf_nf_link *link)
+{
+	const struct nf_defrag_v4_hook __maybe_unused *v4_hook;
+	const struct nf_defrag_v6_hook __maybe_unused *v6_hook;
+
+	switch (link->hook_ops.pf) {
+#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4)
+	case NFPROTO_IPV4:
+		rcu_read_lock();
+		v4_hook = rcu_dereference(nf_defrag_v4_hook);
+		if (v4_hook)
+			v4_hook->disable(link->net);
+		rcu_read_unlock();
+
+		break;
+#endif
+#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
+	case NFPROTO_IPV6:
+		rcu_read_lock();
+		v6_hook = rcu_dereference(nf_defrag_v6_hook);
+		if (v6_hook)
+			v6_hook->disable(link->net);
+		rcu_read_unlock();
+
+		break;
+	}
+#endif
+}
+
 static void bpf_nf_link_release(struct bpf_link *link)
 {
 	struct bpf_nf_link *nf_link = container_of(link, struct bpf_nf_link, link);
@@ -37,6 +128,9 @@ static void bpf_nf_link_release(struct bpf_link *link)
 	 */
 	if (!cmpxchg(&nf_link->dead, 0, 1))
 		nf_unregister_net_hook(nf_link->net, &nf_link->hook_ops);
+
+	if (nf_link->defrag)
+		bpf_nf_disable_defrag(nf_link);
 }
 
 static void bpf_nf_link_dealloc(struct bpf_link *link)
@@ -92,6 +186,8 @@ static const struct bpf_link_ops bpf_nf_link_lops = {
 
 static int bpf_nf_check_pf_and_hooks(const union bpf_attr *attr)
 {
+	int prio;
+
 	switch (attr->link_create.netfilter.pf) {
 	case NFPROTO_IPV4:
 	case NFPROTO_IPV6:
@@ -102,19 +198,18 @@ static int bpf_nf_check_pf_and_hooks(const union bpf_attr *attr)
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
@@ -156,6 +251,18 @@ int bpf_nf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 		return err;
 	}
 
+	if (attr->link_create.netfilter.flags & BPF_F_NETFILTER_IP_DEFRAG) {
+		err = bpf_nf_enable_defrag(link);
+		if (err) {
+			bpf_link_cleanup(&link_primer);
+			return err;
+		}
+		/* only mark defrag enabled if enabling succeeds so cleanup path
+		 * doesn't disable without a corresponding enable
+		 */
+		link->defrag = true;
+	}
+
 	err = nf_register_net_hook(net, &link->hook_ops);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 60a9d59beeab..04ac77481583 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1170,6 +1170,11 @@ enum bpf_link_type {
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


