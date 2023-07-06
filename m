Return-Path: <bpf+bounces-4362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905CB74A7CE
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 01:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C151C20EC8
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 23:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C822168D6;
	Thu,  6 Jul 2023 23:35:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB68FD2E9;
	Thu,  6 Jul 2023 23:35:53 +0000 (UTC)
X-Greylist: delayed 569 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Jul 2023 16:35:51 PDT
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4251BC3;
	Thu,  6 Jul 2023 16:35:51 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailnew.nyi.internal (Postfix) with ESMTP id D3AC45802E5;
	Thu,  6 Jul 2023 19:26:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 06 Jul 2023 19:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm1; t=1688685980; x=
	1688693180; bh=E1jtUQpyvb6NHwarldVNq8v8v/YlodFgEoqeEX93HuI=; b=R
	MjG+66Xg6VCZAJK4n3j9i0XltlhbyrQhNBnTT42GY8+bOQPBZY7zBBdtSlhvbQIU
	LEb6ilrGbdhiVQdBnhJ3E4l0s+mXvpkZRHCxQ6eIiuQh7kQwOW8XlfMWb2ikGuLl
	u7W1bkOJ1gqf3/NoG7akwhcRosOqCt4YavBgvfx/bmt5Iz5yGuxfVFeDedfO7pVF
	6IHbsRYxJ5uJVZ0oSuLMBs1XM1LsY+gSkiCaG35STSE5+ngSwTvZWU9dO417noTC
	SeJhttYewAmZJ5ddgxYinc/45sHzQErULcQ5BUnBAQMhGrguAc7uNososSe9f92V
	lVvhSBMdsdVDbhEiSWS7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688685980; x=
	1688693180; bh=E1jtUQpyvb6NHwarldVNq8v8v/YlodFgEoqeEX93HuI=; b=Z
	6Gvcy1mLAKlBLstKK1Bh3f2kRf+cHwpVUuQo84cGjsM/igpjJpwpET5gxkOQiWBZ
	S03I/MMssyABDccrumd3OPF95Yf4yOsvfpqhQ3AET6cK7B2o7t7bW5ZnrZGM94eq
	ftjKEdy7GRHlohE6OM37WjcadVQiuWdC0QHSgfMnjS2bOMrJwuAZ6aDIIxVNtUad
	28jZdvX+TICUbBJ1/0MrlA6u2UCCC1YBXqrtPEK/iHa54sVFN4Qzz2gfQx7rOfJd
	Gm9gFdDR51d4Sr+gJNGUcufrOLyoOq2sy6RWXIk6MNwwMh64JkxMhluhPjcg9voX
	F6XhH5cNh8zsnKEGJlZ0g==
X-ME-Sender: <xms:nE2nZDTycXF81lmzCmkocr34v9hM1yAql3C_CYZcbi5ZIio1u3XC4w>
    <xme:nE2nZEz0BFXTn9bGl3fp_LDV6ZwgsNgmuBiusyJIGPEX42bjrUelGxeDOeEZ6AsXn
    _Dta2dQi4c9CjqA7Q>
X-ME-Received: <xmr:nE2nZI2kCLyfLBbDxOce207rVB5AhM89Ro87wENe8ITDJU9-98UPfS9WmT_6FQhvgwOxm0mB9O8jcVXyW74aMdx_HrJYJOrBKwrrJb4mcJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvddtgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeejgeevleejhedvveduud
    ffffelleevjeeugeejvdehvdehvdehtefhjeegtdeiieenucffohhmrghinhepnhgvthhf
    ihhlthgvrhdrphhfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:nE2nZDAqZBBMy8MuuIj9RdYIAg7nZ6lPjW7c-fjT4b4M0TJt71mZtA>
    <xmx:nE2nZMjaELnkCODi7hI41ZhyCk6S01DGT0RvqGzt1dtD-_ic8ivIiw>
    <xmx:nE2nZHpzA5IQZm7FB2UQsrL2Mn6YRGRsgEckrQPwJMF2ZZSfNUxffQ>
    <xmx:nE2nZHQ2cN9DfW79PEYAYrgia77hlgqzbpXoUGrvUG6N-ntS3POqTg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jul 2023 19:26:18 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: pabeni@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	fw@strlen.de,
	davem@davemloft.net,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	pablo@netfilter.org,
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
Subject: [PATCH bpf-next v2 2/6] netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFRAG in netfilter link
Date: Thu,  6 Jul 2023 17:25:49 -0600
Message-ID: <c749ad3cf54196768dd00a48af3f8aa6b7c29b9a.1688685338.git.dxu@dxuuu.xyz>
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

This commit adds support for enabling IP defrag using pre-existing
netfilter defrag support. Basically all the flag does is bump a refcnt
while the link the active. Checks are also added to ensure the prog
requesting defrag support is run _after_ netfilter defrag hooks.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/uapi/linux/bpf.h       |   5 ++
 net/netfilter/nf_bpf_link.c    | 132 ++++++++++++++++++++++++++++++---
 tools/include/uapi/linux/bpf.h |   5 ++
 3 files changed, 131 insertions(+), 11 deletions(-)

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
index c36da56d756f..765612cb2370 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/bpf.h>
 #include <linux/filter.h>
+#include <linux/kmod.h>
 #include <linux/netfilter.h>
 
 #include <net/netfilter/nf_bpf_link.h>
@@ -23,8 +24,101 @@ struct bpf_nf_link {
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
+		const struct nf_defrag_v6_hook *v6_hook;
+
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
+	switch (link->hook_ops.pf) {
+#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4)
+	case NFPROTO_IPV4:
+		const struct nf_defrag_v4_hook *v4_hook;
+
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
+		const struct nf_defrag_v6_hook *v6_hook;
+
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
@@ -37,6 +131,9 @@ static void bpf_nf_link_release(struct bpf_link *link)
 	 */
 	if (!cmpxchg(&nf_link->dead, 0, 1))
 		nf_unregister_net_hook(nf_link->net, &nf_link->hook_ops);
+
+	if (nf_link->defrag)
+		bpf_nf_disable_defrag(nf_link);
 }
 
 static void bpf_nf_link_dealloc(struct bpf_link *link)
@@ -92,6 +189,8 @@ static const struct bpf_link_ops bpf_nf_link_lops = {
 
 static int bpf_nf_check_pf_and_hooks(const union bpf_attr *attr)
 {
+	int prio;
+
 	switch (attr->link_create.netfilter.pf) {
 	case NFPROTO_IPV4:
 	case NFPROTO_IPV6:
@@ -102,19 +201,18 @@ static int bpf_nf_check_pf_and_hooks(const union bpf_attr *attr)
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
@@ -156,6 +254,18 @@ int bpf_nf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
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


