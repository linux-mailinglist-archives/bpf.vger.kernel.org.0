Return-Path: <bpf+bounces-4880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798EA7514B4
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 01:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA71A1C21064
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 23:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3C8FC07;
	Wed, 12 Jul 2023 23:44:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B11FBFB;
	Wed, 12 Jul 2023 23:44:36 +0000 (UTC)
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E56CEA;
	Wed, 12 Jul 2023 16:44:33 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailnew.west.internal (Postfix) with ESMTP id 9DDF12B00194;
	Wed, 12 Jul 2023 19:44:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 12 Jul 2023 19:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm1; t=1689205470; x=
	1689212670; bh=SpOK0IbwC8H/LwAMTCpFl9t2wFGThdkYmAvUp2+Lk0I=; b=W
	7Q69FXQmq1w7CoX6Hu5BEXqJTq00ZTFZ/VbpVXvX3P4/c1hpFK8HurR6y6uG6YQ8
	EItABoKXqMKswZOSIY0e41BgTyMChNZxWstVGPX6Iggqh4F4JnV9doMwQljP2+wr
	0cG48RNZVnJ/7SpmCXSgR5dgx/vte8tckpl/PjGQ9upfw5E120GDpmTdw5mIFhbD
	RUdDINeV9R/35W9VQEiy+VdJSs7Hdn4Y+X6HM2HclGlgRrmq5JdcWOaZyEkwwzXF
	ySdipY4pn2ncsLp/oQo1x1yu2gobckTVOn239g9LfYSspGgjA3dNws3/+Ctf+5/U
	BSIC7NyU+muU7oBx/v8Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1689205470; x=
	1689212670; bh=SpOK0IbwC8H/LwAMTCpFl9t2wFGThdkYmAvUp2+Lk0I=; b=E
	ugiooFspI2bcq3zOT26W2R+qv8Cx8hHvgdDVmILk/xhSDbolSqmNK3puFzE5WUgP
	Qx7oXugQsr6Rnqw0PcYdOUDDhBtaZdGWelzHdUbKxqMKf+wLY+hQ7xDtWfqQPcU6
	QQiqpoFnuvjLo/rizYOTALrUBALp4pjoG150j4Yz+qILVNMqFQ2DglKU6+ej4mTq
	fEWuh1wCtcnj8tRy+pG0SLkcQdTJ0/uV1On9GFBMGn8Lt+JARbzcqZPDyGYylKUb
	gVUpRcuE0wNaD/Ugdt9Oaa+NPJ4KrQ4rmllO0FVew0Es0cH+mY1ioCS9/ftuns4L
	rV0z2XBKA4Kl6JymCmdrQ==
X-ME-Sender: <xms:3TqvZPSpoyhSIFGddim2f0UUL9ChKdz3T74aUohty8J3iQn6Ov1ogQ>
    <xme:3TqvZAyxRuWdTxIeIt-_PCKsUWqUJNFtTf9dcr0PQYN3cQ1mIPwGI9SMEQZiHyHeI
    PWvk4D280FtYlpISA>
X-ME-Received: <xmr:3TqvZE2Cmrim2kopkYACxiWboyrAYzrgpctNw1avwbn0d7YA0iIjZNxqRKRfAA8yRD43rkVdG7dDJhZG3WLAd6CjQQmvt5avPcT9-Bq9V8M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeefgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeejgeevleejhedvveduud
    ffffelleevjeeugeejvdehvdehvdehtefhjeegtdeiieenucffohhmrghinhepnhgvthhf
    ihhlthgvrhdrphhfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:3TqvZPAUupSCCHFpMgTbToEc2Y8HBthbN1HRRmbHsHw11PGz4U_U-A>
    <xmx:3TqvZIhOjivEqYfRCEi1P1vuxJ7-pToA8ImNq7xoLuxovDM2VB6PUw>
    <xmx:3TqvZDo8bDwR8pl2uLgnCyHLb-h0AizlCZ-T16HiT0rVh23M6N9VWg>
    <xmx:3jqvZAQXVXMOoOgtgro8_2BCM60WjdwrmzpM6438mHVu62XAoU1ZL9rT8zo>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jul 2023 19:44:28 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: andrii@kernel.org,
	ast@kernel.org,
	fw@strlen.de,
	davem@davemloft.net,
	pablo@netfilter.org,
	pabeni@redhat.com,
	daniel@iogearbox.net,
	edumazet@google.com,
	kuba@kernel.org,
	kadlec@netfilter.org,
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
Subject: [PATCH bpf-next v4 2/6] netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFRAG in netfilter link
Date: Wed, 12 Jul 2023 17:43:57 -0600
Message-ID: <d3b0ff95c58356192ea3b50824f8cdbf02c354e3.1689203090.git.dxu@dxuuu.xyz>
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This commit adds support for enabling IP defrag using pre-existing
netfilter defrag support. Basically all the flag does is bump a refcnt
while the link the active. Checks are also added to ensure the prog
requesting defrag support is run _after_ netfilter defrag hooks.

Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/uapi/linux/bpf.h       |   5 ++
 net/netfilter/nf_bpf_link.c    | 129 ++++++++++++++++++++++++++++++---
 tools/include/uapi/linux/bpf.h |   5 ++
 3 files changed, 128 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 600d0caebbd8..c820076c38db 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1180,6 +1180,11 @@ enum bpf_perf_event_type {
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
index 600d0caebbd8..c820076c38db 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1180,6 +1180,11 @@ enum bpf_perf_event_type {
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


