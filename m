Return-Path: <bpf+bounces-53338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B93A5024A
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 15:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A331899B64
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 14:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF9C2528EC;
	Wed,  5 Mar 2025 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="AlTOl8v4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VJr5D2xb"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDD72517B6;
	Wed,  5 Mar 2025 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185231; cv=none; b=ingz+4bw1Vqfa3Z8TZtMTUq3gBe1jCx8lWIoC0CD0EzSVaIXgUIZ1EpV9ayCDzNAKQhmtTpQ8itCUzt4la1v3oodHhO6m7mXIG37dKumv+t+/IgHRXMVGP7gI4UtlUkOq8Uo5s97316of0qfW9wZnlZNtGPMCHkSWbU9WQRYYv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185231; c=relaxed/simple;
	bh=HicSASNYdZDA0RtzA5b9cOjfR7//E6FUJk6ywDhapTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ei/TDAdTx5YWziJm6CMgl/mSzaXRToT3a4t/QbqZVg9oyoV7EwaBU70VTuqVJY3IDe0TaXDzLW+AMMv/v9UHg4yPGQFYuoCUyfGbWPUxTypsBxoyctTTN36xGYnkSOTqSf/XRoUvfP6kmYVXwDPRm7Zewr0l832eSC3M62TZ/+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=AlTOl8v4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VJr5D2xb; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id DDD2C1382714;
	Wed,  5 Mar 2025 09:33:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 05 Mar 2025 09:33:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1741185228; x=1741271628; bh=1yiODElVD2neYVmTMEcUZKN6LweCz1z0
	YkWtPJecTq8=; b=AlTOl8v4ziM2qlT6JwwOu/+iCiu56Pt3q4/sES1Q53otv8RK
	bdxa2kSPz0kZYTxY7jsNkUufBI9oC+ZoNV0bElIUH7FDrlP31M1T2NINkRov2Q7S
	uk2O4aeBdjvceFM18hjVaFyczLgDG+7e6KLBE8kVVs3zOZH2kbwVvf/P9XYh7hSH
	3ZDxIULJQ8qkUGFSPAQIfLcZmeLoP92T9zN761xxgd8wM3U7khbzwB8gMGS6OOQO
	uGFWs+5oznxxAs8tQow/myoMkA+obgrWlblGB56qSnG9RWVvOfc8XblNiAtFjg3U
	R+GPRfZcGDxVlsKdiQ58WJTLWkhMQRJSLY+xHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741185228; x=
	1741271628; bh=1yiODElVD2neYVmTMEcUZKN6LweCz1z0YkWtPJecTq8=; b=V
	Jr5D2xbBDkJuFCkEXnIIRf5wZkH+At/ATKXpY8cdWAPR1elcpgkbmCSesSwt966w
	XEIbiTJMn47iBo+qupAKUH6XehftOG8UkbZjEJN2gTt71r3mkIfbalA0g4RKF5kz
	t1MddtDqKAlHDT3eC+87ckPQgv87vzEHj9Cn7iP1Sm83rXoHVhV0EYBYkJuKWsax
	zszA1wGtxPuVwzmKF9gsYkPt9aetyW/pIJ1hkWoa0KmOiSZAKqR3KlK9D8bNn5bf
	AjTm1ZGAWGJZv5Lomj5U2GLfHXB6+lQ9idcTh6YQc+vZ2iqUYqj+XWOPgItvqYHq
	BG9LkGfL8kkNclVKf/5gg==
X-ME-Sender: <xms:zGDIZ-WU9Sd5bm38e3-xnEjXVCPaaznQzYmfSmZUDApwrwxVknBpZA>
    <xme:zGDIZ6k_aMgbov5OXtBKdGOeKJwtiglNDQjR8cQe3pIB419B-a26bdH67bexG6vf4
    zqRWxGULtaVnH66dSE>
X-ME-Received: <xmr:zGDIZyZJwTJL46IibglClo4J88rhsasxtVa0LUc6XXWDh0O71dsIhs-NPvlaX8i-TuaYDk9lB9PAlZkQR8U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhenucggtf
    frrghtthgvrhhnpeffueehtddtkeetgfelteejledvjeekgeduleffjeetfeekveeggffh
    fefhvdegffenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhdpnhgspghrtghpthhtohep
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhhohhilhgrnhgusehrvgguhh
    grthdrtghomhdprhgtphhtthhopehlsghirghntghonhesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohephhgrfihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsphhfsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghfrggsrhgvsegtlhhouhgufhhl
    rghrvgdrtghomhdprhgtphhtthhopehjrghkuhgssegtlhhouhgufhhlrghrvgdrtghomh
    dprhgtphhtthhopeihrghnsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopehn
    vghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsghrrghnug
    gvsghurhhgsegtlhhouhgufhhlrghrvgdrtghomh
X-ME-Proxy: <xmx:zGDIZ1W17-tcHYbBlpF0xcpED2ogJdCMoSHOJ_oZrgR2pHzNnGBtZA>
    <xmx:zGDIZ4lXmu4u7ygG5liE-P_fKrMq4VlhjBXyou4xIk7ZV4Pp15ySHQ>
    <xmx:zGDIZ6f3jkMyo5i7Facjr01jc0rR0oU33T5SKyXSCiADk_HustjyLQ>
    <xmx:zGDIZ6EN8cgvLQ42HTx7hWK8YQeSCYmo97Df2P-Mza8pzd87vmqpcw>
    <xmx:zGDIZ1jV4O6n79NvMhgJAWzsP4KmHzlBj0Qg983YggAyP6sHhZTdkQ0I>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 09:33:47 -0500 (EST)
From: arthur@arthurfabre.com
Date: Wed, 05 Mar 2025 15:32:15 +0100
Subject: [PATCH RFC bpf-next 18/20] trait: registration API
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-afabre-traits-010-rfc2-v1-18-d0ecfb869797@cloudflare.com>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 Arthur Fabre <afabre@cloudflare.com>
X-Mailer: b4 0.14.2

From: Arthur Fabre <afabre@cloudflare.com>

The "raw" key values (0-63) of traits could be exposed to userspace, and
used directly in BPF programs.

Similarly to allocating TCP or UDP ports to services, services that use
traits could make the IDs they use configurable in their config file,
and the system administrator could decided which services use which IDs.

However, unlike TCP or UDP ports, if two services hardcode and use the
same trait ID, we wouldn't be able to detect this and fail fast with
EADDRINUSE. The services would instead overwrite each other's traits.

This is intended more to kick off a discussion rather than be a fully
fleshed out patch.

One solution is to have the kernel provide an API for services to
register traits they want to use. If the trait is already registered, we
can return an appropriate error.

This could take many forms (in order of increasing complexity):
- A syscall to "reserve" a specific trait ID / key for use.
- A syscall to dynamically request a free trait ID / key. The keys could
  be passed to BPF programs as constants.
  (what this patch implements).
- Hide numerical trait IDs / keys from userspace entirely, and have them
  use strings. The verifier could allocate IDs for each unique string,
  and rewrite programs to use them (or the loader).

In all cases, it isn't obvious how to deal with the lifetime of
registered traits. Services need to be able to unregister traits so they
can restart cleanly. But that's complicated:
- Do we need to track which BPF programs use which traits, to prevent
  traits in use from being unregistered?
  How will this work if we extend netfilter and routing to support
  traits?
- If a service unregisters a key, what happens to in flight packets that
  have a trait with that ID set?
  If the same ID is re-used, it could be mis-interpreted.

On the other hand, it would also lets us specify and store per trait / key
flags.
This could let us handle cases like GRO by specifying policies for how
to "merge" traits of GRO'd packets, eg:
- TRAIT_KEEP_FIRST: keep the value of the first packet.
- TRAIT_KEEP_LAST: keep the value of the last packet.
- TRAIT_SUM: sum the values of all packets.
This would avoid disabling GRO as soon as packets have different traits,
which unfortunately happens today with XDP metadata.

Many other aspects of traits can be decided later on: how to guarantee
enough headroom without XDP, how to deal with GRO, skb clones, IP
fragmentation... because we can implement the most restrictive option
for now.
That's not the case for a registration API: we can't add one once we
allow users to use raw trait IDs.

Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
---
 include/linux/bpf-netns.h   | 12 ++++++++++
 include/net/net_namespace.h |  6 +++++
 include/net/netns/trait.h   | 22 ++++++++++++++++++
 include/uapi/linux/bpf.h    | 26 ++++++++++++++++++++++
 kernel/bpf/net_namespace.c  | 54 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c        | 26 ++++++++++++++++++++++
 kernel/bpf/verifier.c       | 39 +++++++++++++++++++++++++++++++-
 7 files changed, 184 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf-netns.h b/include/linux/bpf-netns.h
index 413cfa5e4b0710806f5ed56824c7488b2586e19b..775f9de5e3e2931103ca66b3f168637437872480 100644
--- a/include/linux/bpf-netns.h
+++ b/include/linux/bpf-netns.h
@@ -33,6 +33,8 @@ int netns_bpf_prog_attach(const union bpf_attr *attr,
 int netns_bpf_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype);
 int netns_bpf_link_create(const union bpf_attr *attr,
 			  struct bpf_prog *prog);
+int netns_bpf_trait_register(const union bpf_attr *attr);
+int netns_bpf_trait_unregister(const union bpf_attr *attr);
 #else
 static inline int netns_bpf_prog_query(const union bpf_attr *attr,
 				       union bpf_attr __user *uattr)
@@ -57,6 +59,16 @@ static inline int netns_bpf_link_create(const union bpf_attr *attr,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int netns_bpf_trait_register(const union bpf_attr *attr)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int netns_bpf_trait_unregister(const union bpf_attr *attr)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 #endif /* _BPF_NETNS_H */
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index f467a66abc6b16b690a99037a3dea2e355910661..6f35593c91627c2793f7ced3e6c69c6fb4409665 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -37,6 +37,7 @@
 #include <net/netns/smc.h>
 #include <net/netns/bpf.h>
 #include <net/netns/mctp.h>
+#include <net/netns/trait.h>
 #include <net/net_trackers.h>
 #include <linux/ns_common.h>
 #include <linux/idr.h>
@@ -193,6 +194,11 @@ struct net {
 	/* Move to a better place when the config guard is removed. */
 	struct mutex		rtnl_mutex;
 #endif
+	/* Traits probably shouldn't be per namespace - otherwise we'd have to explicitly clear
+	 * them. And packet tracing should work across namespaces.
+	 * I just didn't know where to put this.
+	 */
+	struct netns_traits traits;
 } __randomize_layout;
 
 #include <linux/seq_file_net.h>
diff --git a/include/net/netns/trait.h b/include/net/netns/trait.h
new file mode 100644
index 0000000000000000000000000000000000000000..5b1d2ad4572c447dea80c285feb4da69d15693d6
--- /dev/null
+++ b/include/net/netns/trait.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Traits registered to a network namespace.
+ */
+
+#ifndef __NETNS_TRAIT_H__
+#define __NETNS_TRAIT_H__
+
+#include <linux/types.h>
+#include <linux/bpf.h>
+
+struct registered_trait {
+	bool used;
+	char name[BPF_OBJ_NAME_LEN];
+	u32 flags;
+};
+
+struct netns_traits {
+	struct registered_trait traits[64];
+};
+
+#endif /* __NETNS_TRAIT_H__ */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index bb37897c039398dd3568cd007586d9b088ddeb32..748ab5a1cbe0d29d890b874aacfc4ee66b082058 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -906,6 +906,21 @@ union bpf_iter_link_info {
  *		A new file descriptor (a nonnegative integer), or -1 if an
  *		error occurred (in which case, *errno* is set appropriately).
  *
+ * BPF_REGISTER_TRAIT
+ *	Description
+ *		Register a trait. Docs to make bpf_doc.py not error out.
+ *	Return
+ *		Registered trait key.
+ *
+ * BPF_UNREGISTER_TRAIT
+ *	Description
+ *		Unregister a trait. Needed so services registering traits
+ *		can restart.
+ *		But what happens if a trait is currently being used?
+ *		And to in flight packets?
+ *	Return
+ *		-1 if an error occurred.
+ *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
  *
@@ -961,6 +976,8 @@ enum bpf_cmd {
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
 	BPF_TOKEN_CREATE,
+	BPF_REGISTER_TRAIT,
+	BPF_UNREGISTER_TRAIT,
 	__MAX_BPF_CMD,
 };
 
@@ -1841,6 +1858,15 @@ union bpf_attr {
 		__u32		bpffs_fd;
 	} token_create;
 
+	struct { /* struct used by BPF_REGISTER_TRAIT command */
+		char		name[BPF_OBJ_NAME_LEN];
+		__u32		flags;
+	} register_trait;
+
+	struct { /* struct used by BPF_UNREGISTER_TRAIT command */
+		__u64		trait;
+	} unregister_trait;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
index 868cc2c43899713b5dbd0ac92f06d297be4b4270..0828310b45f12d1feb8c26aad2cf9cbb0fb5cdf9 100644
--- a/kernel/bpf/net_namespace.c
+++ b/kernel/bpf/net_namespace.c
@@ -526,6 +526,60 @@ int netns_bpf_link_create(const union bpf_attr *attr, struct bpf_prog *prog)
 	return err;
 }
 
+int netns_bpf_trait_register(const union bpf_attr *attr)
+{
+	struct net *net;
+	int i;
+	int ret;
+
+	net = current->nsproxy->net_ns;
+	mutex_lock(&netns_bpf_mutex);
+
+	for (i = 0; i < 64; i++) {
+		if (net->traits.traits[i].used)
+			continue;
+
+		net->traits.traits[i].used = true;
+		net->traits.traits[i].flags = attr->register_trait.flags;
+		memcpy(net->traits.traits[i].name, attr->register_trait.name,
+				sizeof(attr->register_trait.name));
+
+		ret = i;
+		goto out_unlock;
+	}
+	ret = -ENOSPC;
+
+out_unlock:
+	mutex_unlock(&netns_bpf_mutex);
+
+	return ret;
+}
+
+int netns_bpf_trait_unregister(const union bpf_attr *attr)
+{
+	struct net *net;
+	int ret;
+
+	if (attr->unregister_trait.trait > 63)
+		return -EINVAL;
+
+	net = current->nsproxy->net_ns;
+	mutex_lock(&netns_bpf_mutex);
+
+	if (!net->traits.traits[attr->unregister_trait.trait].used) {
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+
+	net->traits.traits[attr->unregister_trait.trait].used = false;
+	ret = 0;
+
+out_unlock:
+	mutex_unlock(&netns_bpf_mutex);
+
+	return ret;
+}
+
 static int __net_init netns_bpf_pernet_init(struct net *net)
 {
 	int type;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 57a438706215936b75c957f95f5324371aa8f436..4ae401dbb5e332343f729dee0fa7bdbe6d216f16 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5769,6 +5769,26 @@ static int token_create(union bpf_attr *attr)
 	return bpf_token_create(attr);
 }
 
+#define BPF_REGISTER_TRAIT_LAST_FIELD register_trait.flags
+
+static int register_trait(union bpf_attr *attr)
+{
+	if (CHECK_ATTR(BPF_REGISTER_TRAIT))
+		return -EINVAL;
+
+	return netns_bpf_trait_register(attr);
+}
+
+#define BPF_UNREGISTER_TRAIT_LAST_FIELD unregister_trait.trait
+
+static int unregister_trait(union bpf_attr *attr)
+{
+	if (CHECK_ATTR(BPF_UNREGISTER_TRAIT))
+		return -EINVAL;
+
+	return netns_bpf_trait_unregister(attr);
+}
+
 static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 {
 	union bpf_attr attr;
@@ -5905,6 +5925,12 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 	case BPF_TOKEN_CREATE:
 		err = token_create(&attr);
 		break;
+	case BPF_REGISTER_TRAIT:
+		err = register_trait(&attr);
+		break;
+	case BPF_UNREGISTER_TRAIT:
+		err = unregister_trait(&attr);
+		break;
 	default:
 		err = -EINVAL;
 		break;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4edb2db0f889c5b236416ce0016d74fda2e09a18..da41a54731fb1eccafb295ea1a0bc1d27d92c726 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -30,6 +30,7 @@
 #include <net/xdp.h>
 #include <linux/trace_events.h>
 #include <linux/kallsyms.h>
+#include <linux/bpf-netns.h>
 
 #include "disasm.h"
 
@@ -12007,6 +12008,8 @@ enum special_kfunc_type {
 	KF_bpf_iter_num_destroy,
 	KF_bpf_set_dentry_xattr,
 	KF_bpf_remove_dentry_xattr,
+	KF_bpf_xdp_trait_set,
+	KF_bpf_skb_trait_set,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -12040,6 +12043,8 @@ BTF_ID(func, bpf_iter_css_task_new)
 BTF_ID(func, bpf_set_dentry_xattr)
 BTF_ID(func, bpf_remove_dentry_xattr)
 #endif
+BTF_ID(func, bpf_xdp_trait_set)
+BTF_ID(func, bpf_skb_trait_set)
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12096,6 +12101,8 @@ BTF_ID(func, bpf_remove_dentry_xattr)
 BTF_ID_UNUSED
 BTF_ID_UNUSED
 #endif
+BTF_ID(func, bpf_xdp_trait_set)
+BTF_ID(func, bpf_skb_trait_set)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -13288,7 +13295,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 {
 	bool sleepable, rcu_lock, rcu_unlock, preempt_disable, preempt_enable;
 	u32 i, nargs, ptr_type_id, release_ref_obj_id;
-	struct bpf_reg_state *regs = cur_regs(env);
+	struct bpf_reg_state *regs = cur_regs(env), *reg;
 	const char *func_name, *ptr_type_name;
 	const struct btf_type *t, *ptr_type;
 	struct bpf_kfunc_call_arg_meta meta;
@@ -13297,6 +13304,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	const struct btf_param *args;
 	const struct btf_type *ret_t;
 	struct btf *desc_btf;
+	struct net *net;
+	bool trait_used;
 
 	/* skip for now, but return error when we find this in fixup_kfunc_call */
 	if (!insn->imm)
@@ -13463,6 +13472,34 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	if (meta.func_id == special_kfunc_list[KF_bpf_xdp_trait_set] ||
+	    meta.func_id == special_kfunc_list[KF_bpf_skb_trait_set]) {
+		reg = &cur_regs(env)[BPF_REG_2];
+		if (reg->type != SCALAR_VALUE || !tnum_is_const(reg->var_off)) {
+			verbose(env, "trait_set() key is not a known constant\n");
+			return -EINVAL;
+		}
+
+		if (reg->var_off.value > 63) {
+			verbose(env, "trait_set() key %llu invalid\n", reg->var_off.value);
+			return -EINVAL;
+		}
+
+		net = current->nsproxy->net_ns;
+		mutex_lock(&netns_bpf_mutex);
+		trait_used = net->traits.traits[reg->var_off.value].used;
+		mutex_unlock(&netns_bpf_mutex);
+
+		/* Checking in the verifier is good for runtime performance, but what happens if
+		 * a trait is unregistered?
+		 * Should we track which traits are used by BPF programs and prevent it?
+		 */
+		if (!trait_used) {
+			verbose(env, "trait_set() key %llu is not registered\n", reg->var_off.value);
+			return -EINVAL;
+		}
+	}
+
 	for (i = 0; i < CALLER_SAVED_REGS; i++)
 		mark_reg_not_init(env, regs, caller_saved[i]);
 

-- 
2.43.0


