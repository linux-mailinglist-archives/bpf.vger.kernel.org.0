Return-Path: <bpf+bounces-3511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1399D73EF04
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 01:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E97A1C209E4
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 23:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B4B16436;
	Mon, 26 Jun 2023 23:02:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05CC1641A;
	Mon, 26 Jun 2023 23:02:30 +0000 (UTC)
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8C110DB;
	Mon, 26 Jun 2023 16:02:29 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.nyi.internal (Postfix) with ESMTP id 63445582914;
	Mon, 26 Jun 2023 19:02:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 26 Jun 2023 19:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm1; t=1687820548; x=
	1687827748; bh=6b8JNzZ9nHf7gmJe2DR3IE4e9XIkJuXbimCGs/vSd/M=; b=h
	UlRbSOvbGdVTP9mq/hwOXnTs4E0qglcpDth6gzoSTd+vcXWRZxKrvVPjAIBuhIQ7
	HqfmDdZTNy3VHPVcJJN/3cNp/cjy1aoBCRIz8emdGW2WNnPPe58ehW3l9B1sWink
	44TuFHn6YAgM7gHCRYa8nUzBT6x0oCXnI9M9p7sqoOCRcUqnRWQqKMmjGUPIduXs
	NSAaWmVdhsZjsldHm8a1JhUXIUBwH3SDdIQ8ONFyULEasv1ii0+5lQFLnWwPyUMY
	fbOsqy/qYyIaW9V0696iTndrHYvVpfNAniQcjKLbUtCyISZ3cLNni0PBL1wa1gyE
	eCywaJhT6CHvic7M3x8Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1687820548; x=
	1687827748; bh=6b8JNzZ9nHf7gmJe2DR3IE4e9XIkJuXbimCGs/vSd/M=; b=G
	Wge2ZbpLNg+JUeRkVe2Cp14zoqrHUQ0lGt+tgbhb0ul+PjPEc4ih6F01Vi0DnKM2
	e0Q6ghnJCBl3upU1OHC6XVu0EpxJDG5aHSAP9snAALj0vxjmxRgaip+rtzp62aZq
	5plzTsTiBnMUzsIFakmFB/iNmMSARpMRnds/UV+JyPPvx8ysSXp3/OuQrcbMIWIl
	kf3gqaQnM9tKlFAyzvGf0uixTg17KzkqW23NTcJj64guV7E1gorVJ0T+5umye7Vl
	BXp0RAne132qqvLgBSIw6cY8gYHq39h+KDd+43/jLTQRuKZRjy5uLPZ3wiI6q7UQ
	ioLtS32RyLb1/tGicxgDQ==
X-ME-Sender: <xms:BBmaZFK0O5mEl4Ht6kCHqmL0WAUN0QOot3Fokgp7PATry8hjxccYGQ>
    <xme:BBmaZBKP-4HSB3jVGFP26C928YVGuOXB60vEBMRYpLqbAkhPrlniaJTDxAMqC0hh9
    PE8t-yo8H9fhislEA>
X-ME-Received: <xmr:BBmaZNtuntJs_MbSzf7iMvYsUYGojcoIS4exqNqVMqWtFUkckpDjOuc74s-t4QHQVYNWGa6nyf1O9KukGJTPw8IRJ9g-8VcR2eCcMDXtJHM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeehgedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepjeegveeljeehvdevud
    duffffleelveejueegjedvhedvhedvheethfejgedtieeinecuffhomhgrihhnpehnvght
    fhhilhhtvghrrdhpfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:BBmaZGZh1WV13W_ABIo76a7XYSR0KfVxXzJFev72NtRQ38wZL4uYsg>
    <xmx:BBmaZMbgp4scvuhrwNtVOBN6qfLdYblF7kT1AeDEtU-ljt6Gt1oylg>
    <xmx:BBmaZKA027UvcdHag-yM9vFZd_KJZLwNCcousDkSKH-_RLjn-oQ3EA>
    <xmx:BBmaZJJfCxHaq5U8VaK5wHde4FXM0tgLPeoFIl23PNTvm5o4RxoIjA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jun 2023 19:02:25 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: daniel@iogearbox.net,
	edumazet@google.com,
	kuba@kernel.org,
	fw@strlen.de,
	pabeni@redhat.com,
	pablo@netfilter.org,
	andrii@kernel.org,
	davem@davemloft.net,
	ast@kernel.org,
	kadlec@netfilter.org
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
Subject: [PATCH bpf-next 4/7] netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFRAG in netfilter link
Date: Mon, 26 Jun 2023 17:02:11 -0600
Message-Id: <242c66138bf4ec8aa26b29d736fb48242b4164ce.1687819413.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1687819413.git.dxu@dxuuu.xyz>
References: <cover.1687819413.git.dxu@dxuuu.xyz>
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

This commit adds support for enabling IP defrag using pre-existing
netfilter defrag support. Basically all the flag does is bump a refcnt
while the link the active. Checks are also added to ensure the prog
requesting defrag support is run _after_ netfilter defrag hooks.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/uapi/linux/bpf.h       |   5 ++
 net/netfilter/nf_bpf_link.c    | 108 +++++++++++++++++++++++++++++----
 tools/include/uapi/linux/bpf.h |   5 ++
 3 files changed, 107 insertions(+), 11 deletions(-)

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
index c36da56d756f..a8015dbce12a 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/bpf.h>
 #include <linux/filter.h>
+#include <linux/kmod.h>
 #include <linux/netfilter.h>
 
 #include <net/netfilter/nf_bpf_link.h>
@@ -23,8 +24,77 @@ struct bpf_nf_link {
 	struct nf_hook_ops hook_ops;
 	struct net *net;
 	u32 dead;
+	bool defrag;
 };
 
+static int bpf_nf_enable_defrag(struct bpf_nf_link *link)
+{
+	int err;
+
+	switch (link->hook_ops.pf) {
+#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4)
+	case NFPROTO_IPV4:
+		const struct nf_defrag_v4_hook *v4_hook;
+
+		err = request_module("nf_defrag_ipv4");
+		if (err)
+			return err;
+
+		rcu_read_lock();
+		v4_hook = rcu_dereference(nf_defrag_v4_hook);
+		err = v4_hook->enable(link->net);
+		rcu_read_unlock();
+
+		return err;
+#endif
+#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
+	case NFPROTO_IPV6:
+		const struct nf_defrag_v6_hook *v6_hook;
+
+		err = request_module("nf_defrag_ipv6_hooks");
+		if (err)
+			return err;
+
+		rcu_read_lock();
+		v6_hook = rcu_dereference(nf_defrag_v6_hook);
+		err = v6_hook->enable(link->net);
+		rcu_read_unlock();
+
+		return err;
+#endif
+	default:
+		return -EAFNOSUPPORT;
+	}
+}
+
+static void bpf_nf_disable_defrag(struct bpf_nf_link *link)
+{
+	switch (link->hook_ops.pf) {
+#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4)
+	case NFPROTO_IPV4:
+		const struct nf_defrag_v4_hook *v4_hook;
+
+		rcu_read_lock();
+		v4_hook = rcu_dereference(nf_defrag_v4_hook);
+		v4_hook->disable(link->net);
+		rcu_read_unlock();
+
+		break;
+#endif
+#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
+	case NFPROTO_IPV6:
+		const struct nf_defrag_v6_hook *v6_hook;
+
+		rcu_read_lock();
+		v6_hook = rcu_dereference(nf_defrag_v6_hook);
+		v6_hook->disable(link->net);
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
@@ -37,6 +107,9 @@ static void bpf_nf_link_release(struct bpf_link *link)
 	 */
 	if (!cmpxchg(&nf_link->dead, 0, 1))
 		nf_unregister_net_hook(nf_link->net, &nf_link->hook_ops);
+
+	if (nf_link->defrag)
+		bpf_nf_disable_defrag(nf_link);
 }
 
 static void bpf_nf_link_dealloc(struct bpf_link *link)
@@ -92,6 +165,8 @@ static const struct bpf_link_ops bpf_nf_link_lops = {
 
 static int bpf_nf_check_pf_and_hooks(const union bpf_attr *attr)
 {
+	int prio;
+
 	switch (attr->link_create.netfilter.pf) {
 	case NFPROTO_IPV4:
 	case NFPROTO_IPV6:
@@ -102,19 +177,18 @@ static int bpf_nf_check_pf_and_hooks(const union bpf_attr *attr)
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
+		 (prio > NF_IP_PRI_FIRST && prio <= NF_IP_PRI_CONNTRACK_DEFRAG))
+		return -ERANGE;  /* cannot use defrag if prog runs before nf_defrag */
 
 	return 0;
 }
@@ -156,6 +230,18 @@ int bpf_nf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
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
2.40.1


