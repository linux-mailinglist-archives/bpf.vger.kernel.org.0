Return-Path: <bpf+bounces-4637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B595974DEF9
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 22:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6667028135F
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 20:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D5F168AF;
	Mon, 10 Jul 2023 20:12:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE87C168A9;
	Mon, 10 Jul 2023 20:12:32 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3985135;
	Mon, 10 Jul 2023 13:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=P51N69MzEDDOv/BbnL7GRKSfZhJYZ3OrstRUY1XpE3Y=; b=J7K1Hbtq7rjLbsOBWdvWbqJpYm
	rW5KiRgi+9zMvd793z4jKxHdftAJs0xigG0VtNqys7777yIyI5x6SNDvJZz8iK0mHoS2DOfMnfErA
	3LnNXlWE3/BnAFrfjYgQq7ormqHohlIK78S7O6psd3Djis+rkeRyOQ0PvEg1bElzAlGPfU7o+g70g
	fYpqQy+l6ejpfLI+/C/8yNdefMKoKUoClzr0jWIflO5QYS16iLzf957XvhUELEhHzr3rS9jHP9Psh
	erfc1yw2h63s3j1T0RAiYzA/O+Z4XkuNcJPxzVDgh1UIQuEAwHxqvzmT4lD8qjfPcH926CiGKx1nY
	AO73j4RA==;
Received: from 12.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.12] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qIxFB-000E3p-Td; Mon, 10 Jul 2023 22:12:26 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: andrii@kernel.org,
	martin.lau@linux.dev,
	razor@blackwall.org,
	sdf@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	dxu@dxuuu.xyz,
	joe@cilium.io,
	toke@kernel.org,
	davem@davemloft.net,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v4 2/8] bpf: Add fd-based tcx multi-prog infra with link support
Date: Mon, 10 Jul 2023 22:12:12 +0200
Message-Id: <20230710201218.19460-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230710201218.19460-1-daniel@iogearbox.net>
References: <20230710201218.19460-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26965/Mon Jul 10 09:29:40 2023)
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This work refactors and adds a lightweight extension ("tcx") to the tc BPF
ingress and egress data path side for allowing BPF program management based
on fds via bpf() syscall through the newly added generic multi-prog API.
The main goal behind this work which we also presented at LPC [0] last year
and a recent update at LSF/MM/BPF this year [3] is to support long-awaited
BPF link functionality for tc BPF programs, which allows for a model of safe
ownership and program detachment.

Given the rise in tc BPF users in cloud native environments, this becomes
necessary to avoid hard to debug incidents either through stale leftover
programs or 3rd party applications accidentally stepping on each others toes.
As a recap, a BPF link represents the attachment of a BPF program to a BPF
hook point. The BPF link holds a single reference to keep BPF program alive.
Moreover, hook points do not reference a BPF link, only the application's
fd or pinning does. A BPF link holds meta-data specific to attachment and
implements operations for link creation, (atomic) BPF program update,
detachment and introspection. The motivation for BPF links for tc BPF programs
is multi-fold, for example:

  - From Meta: "It's especially important for applications that are deployed
    fleet-wide and that don't "control" hosts they are deployed to. If such
    application crashes and no one notices and does anything about that, BPF
    program will keep running draining resources or even just, say, dropping
    packets. We at FB had outages due to such permanent BPF attachment
    semantics. With fd-based BPF link we are getting a framework, which allows
    safe, auto-detachable behavior by default, unless application explicitly
    opts in by pinning the BPF link." [1]

  - From Cilium-side the tc BPF programs we attach to host-facing veth devices
    and phys devices build the core datapath for Kubernetes Pods, and they
    implement forwarding, load-balancing, policy, EDT-management, etc, within
    BPF. Currently there is no concept of 'safe' ownership, e.g. we've recently
    experienced hard-to-debug issues in a user's staging environment where
    another Kubernetes application using tc BPF attached to the same prio/handle
    of cls_bpf, accidentally wiping all Cilium-based BPF programs from underneath
    it. The goal is to establish a clear/safe ownership model via links which
    cannot accidentally be overridden. [0,2]

BPF links for tc can co-exist with non-link attachments, and the semantics are
in line also with XDP links: BPF links cannot replace other BPF links, BPF
links cannot replace non-BPF links, non-BPF links cannot replace BPF links and
lastly only non-BPF links can replace non-BPF links. In case of Cilium, this
would solve mentioned issue of safe ownership model as 3rd party applications
would not be able to accidentally wipe Cilium programs, even if they are not
BPF link aware.

Earlier attempts [4] have tried to integrate BPF links into core tc machinery
to solve cls_bpf, which has been intrusive to the generic tc kernel API with
extensions only specific to cls_bpf and suboptimal/complex since cls_bpf could
be wiped from the qdisc also. Locking a tc BPF program in place this way, is
getting into layering hacks given the two object models are vastly different.

We instead implemented the tcx (tc 'express') layer which is an fd-based tc BPF
attach API, so that the BPF link implementation blends in naturally similar to
other link types which are fd-based and without the need for changing core tc
internal APIs. BPF programs for tc can then be successively migrated from classic
cls_bpf to the new tc BPF link without needing to change the program's source
code, just the BPF loader mechanics for attaching is sufficient.

For the current tc framework, there is no change in behavior with this change
and neither does this change touch on tc core kernel APIs. The gist of this
patch is that the ingress and egress hook have a lightweight, qdisc-less
extension for BPF to attach its tc BPF programs, in other words, a minimal
entry point for tc BPF. The name tcx has been suggested from discussion of
earlier revisions of this work as a good fit, and to more easily differ between
the classic cls_bpf attachment and the fd-based one.

For the ingress and egress tcx points, the device holds a cache-friendly array
with program pointers which is separated from control plane (slow-path) data.
Earlier versions of this work used priority to determine ordering and expression
of dependencies similar as with classic tc, but it was challenged that for
something more future-proof a better user experience is required. Hence this
resulted in the design and development of the generic attach/detach/query API
for multi-progs. See prior patch with its discussion on the API design. tcx is
the first user and later we plan to integrate also others, for example, one
candidate is multi-prog support for XDP which would benefit and have the same
'look and feel' from API perspective.

The goal with tcx is to have maximum compatibility to existing tc BPF programs,
so they don't need to be rewritten specifically. Compatibility to call into
classic tcf_classify() is also provided in order to allow successive migration
or both to cleanly co-exist where needed given its all one logical tc layer and
the tcx plus classic tc cls/act build one logical overall processing pipeline.

tcx supports the simplified return codes TCX_NEXT which is non-terminating (go
to next program) and terminating ones with TCX_PASS, TCX_DROP, TCX_REDIRECT.
The fd-based API is behind a static key, so that when unused the code is also
not entered. The struct tcx_entry's program array is currently static, but
could be made dynamic if necessary at a point in future. The a/b pair swap
design has been chosen so that for detachment there are no allocations which
otherwise could fail.

The work has been tested with tc-testing selftest suite which all passes, as
well as the tc BPF tests from the BPF CI, and also with Cilium's L4LB.

Kudos also to Nikolay Aleksandrov and Martin Lau for in-depth early reviews
of this work.

  [0] https://lpc.events/event/16/contributions/1353/
  [1] https://lore.kernel.org/bpf/CAEf4BzbokCJN33Nw_kg82sO=xppXnKWEncGTWCTB9vGCmLB6pw@mail.gmail.com
  [2] https://colocatedeventseu2023.sched.com/event/1Jo6O/tales-from-an-ebpf-programs-murder-mystery-hemanth-malla-guillaume-fournier-datadog
  [3] http://vger.kernel.org/bpfconf2023_material/tcx_meta_netdev_borkmann.pdf
  [4] https://lore.kernel.org/bpf/20210604063116.234316-1-memxor@gmail.com

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 MAINTAINERS                    |   4 +-
 include/linux/bpf_mprog.h      |   9 +
 include/linux/netdevice.h      |  15 +-
 include/linux/skbuff.h         |   4 +-
 include/net/sch_generic.h      |   2 +-
 include/net/tcx.h              | 199 +++++++++++++++++++
 include/uapi/linux/bpf.h       |  34 +++-
 kernel/bpf/Kconfig             |   1 +
 kernel/bpf/Makefile            |   1 +
 kernel/bpf/syscall.c           |  83 ++++++--
 kernel/bpf/tcx.c               | 351 +++++++++++++++++++++++++++++++++
 net/Kconfig                    |   5 +
 net/core/dev.c                 | 267 +++++++++++++++----------
 net/core/filter.c              |   4 +-
 net/sched/Kconfig              |   4 +-
 net/sched/sch_ingress.c        |  61 +++++-
 tools/include/uapi/linux/bpf.h |  34 +++-
 17 files changed, 934 insertions(+), 144 deletions(-)
 create mode 100644 include/net/tcx.h
 create mode 100644 kernel/bpf/tcx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e5ba799d1c5..0a1327cf4e34 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3830,13 +3830,15 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	kernel/bpf/bpf_struct*
 
-BPF [NETWORKING] (tc BPF, sock_addr)
+BPF [NETWORKING] (tcx & tc BPF, sock_addr)
 M:	Martin KaFai Lau <martin.lau@linux.dev>
 M:	Daniel Borkmann <daniel@iogearbox.net>
 R:	John Fastabend <john.fastabend@gmail.com>
 L:	bpf@vger.kernel.org
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	include/net/tcx.h
+F:	kernel/bpf/tcx.c
 F:	net/core/filter.c
 F:	net/sched/act_bpf.c
 F:	net/sched/cls_bpf.c
diff --git a/include/linux/bpf_mprog.h b/include/linux/bpf_mprog.h
index 63f0f35bd3e2..ffe39bac011f 100644
--- a/include/linux/bpf_mprog.h
+++ b/include/linux/bpf_mprog.h
@@ -340,4 +340,13 @@ int bpf_mprog_detach(struct bpf_mprog_entry *entry, struct bpf_prog *prog,
 int bpf_mprog_query(const union bpf_attr *attr, union bpf_attr __user *uattr,
 		    struct bpf_mprog_entry *entry);
 
+static inline bool bpf_mprog_supported(enum bpf_prog_type type)
+{
+	switch (type) {
+	case BPF_PROG_TYPE_SCHED_CLS:
+		return true;
+	default:
+		return false;
+	}
+}
 #endif /* __BPF_MPROG_H */
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b828c7a75be2..024314c68bc8 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1930,8 +1930,7 @@ enum netdev_ml_priv_type {
  *
  *	@rx_handler:		handler for received packets
  *	@rx_handler_data: 	XXX: need comments on this one
- *	@miniq_ingress:		ingress/clsact qdisc specific data for
- *				ingress processing
+ *	@tcx_ingress:		BPF & clsact qdisc specific data for ingress processing
  *	@ingress_queue:		XXX: need comments on this one
  *	@nf_hooks_ingress:	netfilter hooks executed for ingress packets
  *	@broadcast:		hw bcast address
@@ -1952,8 +1951,7 @@ enum netdev_ml_priv_type {
  *	@xps_maps:		all CPUs/RXQs maps for XPS device
  *
  *	@xps_maps:	XXX: need comments on this one
- *	@miniq_egress:		clsact qdisc specific data for
- *				egress processing
+ *	@tcx_egress:		BPF & clsact qdisc specific data for egress processing
  *	@nf_hooks_egress:	netfilter hooks executed for egress packets
  *	@qdisc_hash:		qdisc hash table
  *	@watchdog_timeo:	Represents the timeout that is used by
@@ -2252,9 +2250,8 @@ struct net_device {
 	unsigned int		gro_ipv4_max_size;
 	rx_handler_func_t __rcu	*rx_handler;
 	void __rcu		*rx_handler_data;
-
-#ifdef CONFIG_NET_CLS_ACT
-	struct mini_Qdisc __rcu	*miniq_ingress;
+#ifdef CONFIG_NET_XGRESS
+	struct bpf_mprog_entry __rcu *tcx_ingress;
 #endif
 	struct netdev_queue __rcu *ingress_queue;
 #ifdef CONFIG_NETFILTER_INGRESS
@@ -2282,8 +2279,8 @@ struct net_device {
 #ifdef CONFIG_XPS
 	struct xps_dev_maps __rcu *xps_maps[XPS_MAPS_MAX];
 #endif
-#ifdef CONFIG_NET_CLS_ACT
-	struct mini_Qdisc __rcu	*miniq_egress;
+#ifdef CONFIG_NET_XGRESS
+	struct bpf_mprog_entry __rcu *tcx_egress;
 #endif
 #ifdef CONFIG_NETFILTER_EGRESS
 	struct nf_hook_entries __rcu *nf_hooks_egress;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 91ed66952580..ed83f1c5fc1f 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -944,7 +944,7 @@ struct sk_buff {
 	__u8			__mono_tc_offset[0];
 	/* public: */
 	__u8			mono_delivery_time:1;	/* See SKB_MONO_DELIVERY_TIME_MASK */
-#ifdef CONFIG_NET_CLS_ACT
+#ifdef CONFIG_NET_XGRESS
 	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
 	__u8			tc_skip_classify:1;
 #endif
@@ -993,7 +993,7 @@ struct sk_buff {
 	__u8			csum_not_inet:1;
 #endif
 
-#ifdef CONFIG_NET_SCHED
+#if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
 	__u16			tc_index;	/* traffic control index */
 #endif
 
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index e92f73bb3198..15be2d96b06d 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -703,7 +703,7 @@ int skb_do_redirect(struct sk_buff *);
 
 static inline bool skb_at_tc_ingress(const struct sk_buff *skb)
 {
-#ifdef CONFIG_NET_CLS_ACT
+#ifdef CONFIG_NET_XGRESS
 	return skb->tc_at_ingress;
 #else
 	return false;
diff --git a/include/net/tcx.h b/include/net/tcx.h
new file mode 100644
index 000000000000..6c84817f6a6c
--- /dev/null
+++ b/include/net/tcx.h
@@ -0,0 +1,199 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2023 Isovalent */
+#ifndef __NET_TCX_H
+#define __NET_TCX_H
+
+#include <linux/bpf.h>
+#include <linux/bpf_mprog.h>
+
+#include <net/sch_generic.h>
+
+struct mini_Qdisc;
+
+struct tcx_entry {
+	struct mini_Qdisc __rcu *miniq;
+	struct bpf_mprog_bundle bundle;
+	bool miniq_active;
+	struct rcu_head rcu;
+};
+
+struct tcx_link {
+	struct bpf_link link;
+	struct net_device *dev;
+	u32 location;
+};
+
+static inline void tcx_set_ingress(struct sk_buff *skb, bool ingress)
+{
+#ifdef CONFIG_NET_XGRESS
+	skb->tc_at_ingress = ingress;
+#endif
+}
+
+#ifdef CONFIG_NET_XGRESS
+static inline struct tcx_entry *tcx_entry(struct bpf_mprog_entry *entry)
+{
+	struct bpf_mprog_bundle *bundle = entry->parent;
+
+	return container_of(bundle, struct tcx_entry, bundle);
+}
+
+static inline struct tcx_link *tcx_link(struct bpf_link *link)
+{
+	return container_of(link, struct tcx_link, link);
+}
+
+static inline const struct tcx_link *tcx_link_const(const struct bpf_link *link)
+{
+	return tcx_link((struct bpf_link *)link);
+}
+
+void tcx_inc(void);
+void tcx_dec(void);
+
+static inline void
+tcx_entry_update(struct net_device *dev, struct bpf_mprog_entry *entry,
+		 bool ingress)
+{
+	ASSERT_RTNL();
+	if (ingress)
+		rcu_assign_pointer(dev->tcx_ingress, entry);
+	else
+		rcu_assign_pointer(dev->tcx_egress, entry);
+}
+
+static inline bool tcx_entry_needs_release(struct bpf_mprog_entry *entry,
+					   int code)
+{
+	ASSERT_RTNL();
+	return code == BPF_MPROG_FREE && !tcx_entry(entry)->miniq_active;
+}
+
+static inline struct bpf_mprog_entry *
+tcx_entry_fetch(struct net_device *dev, bool ingress)
+{
+	ASSERT_RTNL();
+	if (ingress)
+		return rcu_dereference_rtnl(dev->tcx_ingress);
+	else
+		return rcu_dereference_rtnl(dev->tcx_egress);
+}
+
+static inline struct bpf_mprog_entry *tcx_entry_create(void)
+{
+	struct tcx_entry *tcx = kzalloc(sizeof(*tcx), GFP_KERNEL);
+
+	if (tcx) {
+		bpf_mprog_bundle_init(&tcx->bundle);
+		return &tcx->bundle.a;
+	}
+	return NULL;
+}
+
+static inline void tcx_entry_free(struct bpf_mprog_entry *entry)
+{
+	kfree_rcu(tcx_entry(entry), rcu);
+}
+
+static inline struct bpf_mprog_entry *
+tcx_entry_fetch_or_create(struct net_device *dev, bool ingress, bool *created)
+{
+	struct bpf_mprog_entry *entry = tcx_entry_fetch(dev, ingress);
+
+	*created = false;
+	if (!entry) {
+		entry = tcx_entry_create();
+		if (!entry)
+			return NULL;
+		*created = true;
+	}
+	return entry;
+}
+
+static inline void tcx_skeys_inc(bool ingress)
+{
+	tcx_inc();
+	if (ingress)
+		net_inc_ingress_queue();
+	else
+		net_inc_egress_queue();
+}
+
+static inline void tcx_skeys_dec(bool ingress)
+{
+	if (ingress)
+		net_dec_ingress_queue();
+	else
+		net_dec_egress_queue();
+	tcx_dec();
+}
+
+static inline void tcx_miniq_active(struct bpf_mprog_entry *entry,
+				    const bool active)
+{
+	ASSERT_RTNL();
+	tcx_entry(entry)->miniq_active = active;
+}
+
+static inline enum tcx_action_base tcx_action_code(struct sk_buff *skb,
+						   int code)
+{
+	switch (code) {
+	case TCX_PASS:
+		skb->tc_index = qdisc_skb_cb(skb)->tc_classid;
+		fallthrough;
+	case TCX_DROP:
+	case TCX_REDIRECT:
+		return code;
+	case TCX_NEXT:
+	default:
+		return TCX_NEXT;
+	}
+}
+#endif /* CONFIG_NET_XGRESS */
+
+#if defined(CONFIG_NET_XGRESS) && defined(CONFIG_BPF_SYSCALL)
+int tcx_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog);
+int tcx_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
+int tcx_prog_detach(const union bpf_attr *attr, struct bpf_prog *prog);
+void tcx_uninstall(struct net_device *dev, bool ingress);
+
+int tcx_prog_query(const union bpf_attr *attr,
+		   union bpf_attr __user *uattr);
+
+static inline void dev_tcx_uninstall(struct net_device *dev)
+{
+	ASSERT_RTNL();
+	tcx_uninstall(dev, true);
+	tcx_uninstall(dev, false);
+}
+#else
+static inline int tcx_prog_attach(const union bpf_attr *attr,
+				  struct bpf_prog *prog)
+{
+	return -EINVAL;
+}
+
+static inline int tcx_link_attach(const union bpf_attr *attr,
+				  struct bpf_prog *prog)
+{
+	return -EINVAL;
+}
+
+static inline int tcx_prog_detach(const union bpf_attr *attr,
+				  struct bpf_prog *prog)
+{
+	return -EINVAL;
+}
+
+static inline int tcx_prog_query(const union bpf_attr *attr,
+				 union bpf_attr __user *uattr)
+{
+	return -EINVAL;
+}
+
+static inline void dev_tcx_uninstall(struct net_device *dev)
+{
+}
+#endif /* CONFIG_NET_XGRESS && CONFIG_BPF_SYSCALL */
+#endif /* __NET_TCX_H */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 74879c538f2b..98c4a3a6e137 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1036,6 +1036,8 @@ enum bpf_attach_type {
 	BPF_LSM_CGROUP,
 	BPF_STRUCT_OPS,
 	BPF_NETFILTER,
+	BPF_TCX_INGRESS,
+	BPF_TCX_EGRESS,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -1053,7 +1055,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_KPROBE_MULTI = 8,
 	BPF_LINK_TYPE_STRUCT_OPS = 9,
 	BPF_LINK_TYPE_NETFILTER = 10,
-
+	BPF_LINK_TYPE_TCX = 11,
 	MAX_BPF_LINK_TYPE,
 };
 
@@ -1559,13 +1561,13 @@ union bpf_attr {
 			__u32		map_fd;		/* struct_ops to attach */
 		};
 		union {
-			__u32		target_fd;	/* object to attach to */
-			__u32		target_ifindex; /* target ifindex */
+			__u32	target_fd;	/* target object to attach to or ... */
+			__u32	target_ifindex; /* target ifindex */
 		};
 		__u32		attach_type;	/* attach type */
 		__u32		flags;		/* extra flags */
 		union {
-			__u32		target_btf_id;	/* btf_id of target to attach to */
+			__u32	target_btf_id;	/* btf_id of target to attach to */
 			struct {
 				__aligned_u64	iter_info;	/* extra bpf_iter_link_info */
 				__u32		iter_info_len;	/* iter_info length */
@@ -1599,6 +1601,13 @@ union bpf_attr {
 				__s32		priority;
 				__u32		flags;
 			} netfilter;
+			struct {
+				union {
+					__u32	relative_fd;
+					__u32	relative_id;
+				};
+				__u64		expected_revision;
+			} tcx;
 		};
 	} link_create;
 
@@ -6207,6 +6216,19 @@ struct bpf_sock_tuple {
 	};
 };
 
+/* (Simplified) user return codes for tcx prog type.
+ * A valid tcx program must return one of these defined values. All other
+ * return codes are reserved for future use. Must remain compatible with
+ * their TC_ACT_* counter-parts. For compatibility in behavior, unknown
+ * return codes are mapped to TCX_NEXT.
+ */
+enum tcx_action_base {
+	TCX_NEXT	= -1,
+	TCX_PASS	= 0,
+	TCX_DROP	= 2,
+	TCX_REDIRECT	= 7,
+};
+
 struct bpf_xdp_sock {
 	__u32 queue_id;
 };
@@ -6459,6 +6481,10 @@ struct bpf_link_info {
 			__s32 priority;
 			__u32 flags;
 		} netfilter;
+		struct {
+			__u32 ifindex;
+			__u32 attach_type;
+		} tcx;
 	};
 } __attribute__((aligned(8)));
 
diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index 2dfe1079f772..6a906ff93006 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -31,6 +31,7 @@ config BPF_SYSCALL
 	select TASKS_TRACE_RCU
 	select BINARY_PRINTF
 	select NET_SOCK_MSG if NET
+	select NET_XGRESS if NET
 	select PAGE_POOL if NET
 	default n
 	help
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 1bea2eb912cd..f526b7573e97 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_BPF_SYSCALL) += devmap.o
 obj-$(CONFIG_BPF_SYSCALL) += cpumap.o
 obj-$(CONFIG_BPF_SYSCALL) += offload.o
 obj-$(CONFIG_BPF_SYSCALL) += net_namespace.o
+obj-$(CONFIG_BPF_SYSCALL) += tcx.o
 endif
 ifeq ($(CONFIG_PERF_EVENTS),y)
 obj-$(CONFIG_BPF_SYSCALL) += stackmap.o
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a2aef900519c..8c884cd50413 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -37,6 +37,8 @@
 #include <linux/trace_events.h>
 #include <net/netfilter/nf_bpf_link.h>
 
+#include <net/tcx.h>
+
 #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
 			  (map)->map_type == BPF_MAP_TYPE_CGROUP_ARRAY || \
 			  (map)->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS)
@@ -3588,31 +3590,45 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 		return BPF_PROG_TYPE_XDP;
 	case BPF_LSM_CGROUP:
 		return BPF_PROG_TYPE_LSM;
+	case BPF_TCX_INGRESS:
+	case BPF_TCX_EGRESS:
+		return BPF_PROG_TYPE_SCHED_CLS;
 	default:
 		return BPF_PROG_TYPE_UNSPEC;
 	}
 }
 
-#define BPF_PROG_ATTACH_LAST_FIELD replace_bpf_fd
+#define BPF_PROG_ATTACH_LAST_FIELD expected_revision
+
+#define BPF_F_ATTACH_MASK_BASE	\
+	(BPF_F_ALLOW_OVERRIDE |	\
+	 BPF_F_ALLOW_MULTI |	\
+	 BPF_F_REPLACE)
 
-#define BPF_F_ATTACH_MASK \
-	(BPF_F_ALLOW_OVERRIDE | BPF_F_ALLOW_MULTI | BPF_F_REPLACE)
+#define BPF_F_ATTACH_MASK_MPROG	\
+	(BPF_F_REPLACE |	\
+	 BPF_F_BEFORE |		\
+	 BPF_F_AFTER |		\
+	 BPF_F_ID |		\
+	 BPF_F_LINK)
 
 static int bpf_prog_attach(const union bpf_attr *attr)
 {
 	enum bpf_prog_type ptype;
 	struct bpf_prog *prog;
+	u32 mask;
 	int ret;
 
 	if (CHECK_ATTR(BPF_PROG_ATTACH))
 		return -EINVAL;
 
-	if (attr->attach_flags & ~BPF_F_ATTACH_MASK)
-		return -EINVAL;
-
 	ptype = attach_type_to_prog_type(attr->attach_type);
 	if (ptype == BPF_PROG_TYPE_UNSPEC)
 		return -EINVAL;
+	mask = bpf_mprog_supported(ptype) ?
+	       BPF_F_ATTACH_MASK_MPROG : BPF_F_ATTACH_MASK_BASE;
+	if (attr->attach_flags & ~mask)
+		return -EINVAL;
 
 	prog = bpf_prog_get_type(attr->attach_bpf_fd, ptype);
 	if (IS_ERR(prog))
@@ -3648,6 +3664,9 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 		else
 			ret = cgroup_bpf_prog_attach(attr, ptype, prog);
 		break;
+	case BPF_PROG_TYPE_SCHED_CLS:
+		ret = tcx_prog_attach(attr, prog);
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -3657,25 +3676,42 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 	return ret;
 }
 
-#define BPF_PROG_DETACH_LAST_FIELD attach_type
+#define BPF_PROG_DETACH_LAST_FIELD expected_revision
 
 static int bpf_prog_detach(const union bpf_attr *attr)
 {
+	struct bpf_prog *prog = NULL;
 	enum bpf_prog_type ptype;
+	int ret;
 
 	if (CHECK_ATTR(BPF_PROG_DETACH))
 		return -EINVAL;
 
 	ptype = attach_type_to_prog_type(attr->attach_type);
+	if (bpf_mprog_supported(ptype)) {
+		if (ptype == BPF_PROG_TYPE_UNSPEC)
+			return -EINVAL;
+		if (attr->attach_flags & ~BPF_F_ATTACH_MASK_MPROG)
+			return -EINVAL;
+		prog = bpf_prog_get_type(attr->attach_bpf_fd, ptype);
+		if (IS_ERR(prog)) {
+			if ((int)attr->attach_bpf_fd > 0)
+				return PTR_ERR(prog);
+			prog = NULL;
+		}
+	}
 
 	switch (ptype) {
 	case BPF_PROG_TYPE_SK_MSG:
 	case BPF_PROG_TYPE_SK_SKB:
-		return sock_map_prog_detach(attr, ptype);
+		ret = sock_map_prog_detach(attr, ptype);
+		break;
 	case BPF_PROG_TYPE_LIRC_MODE2:
-		return lirc_prog_detach(attr);
+		ret = lirc_prog_detach(attr);
+		break;
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
-		return netns_bpf_prog_detach(attr, ptype);
+		ret = netns_bpf_prog_detach(attr, ptype);
+		break;
 	case BPF_PROG_TYPE_CGROUP_DEVICE:
 	case BPF_PROG_TYPE_CGROUP_SKB:
 	case BPF_PROG_TYPE_CGROUP_SOCK:
@@ -3684,13 +3720,21 @@ static int bpf_prog_detach(const union bpf_attr *attr)
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
 	case BPF_PROG_TYPE_SOCK_OPS:
 	case BPF_PROG_TYPE_LSM:
-		return cgroup_bpf_prog_detach(attr, ptype);
+		ret = cgroup_bpf_prog_detach(attr, ptype);
+		break;
+	case BPF_PROG_TYPE_SCHED_CLS:
+		ret = tcx_prog_detach(attr, prog);
+		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+
+	if (prog)
+		bpf_prog_put(prog);
+	return ret;
 }
 
-#define BPF_PROG_QUERY_LAST_FIELD query.prog_attach_flags
+#define BPF_PROG_QUERY_LAST_FIELD query.link_attach_flags
 
 static int bpf_prog_query(const union bpf_attr *attr,
 			  union bpf_attr __user *uattr)
@@ -3738,6 +3782,9 @@ static int bpf_prog_query(const union bpf_attr *attr,
 	case BPF_SK_MSG_VERDICT:
 	case BPF_SK_SKB_VERDICT:
 		return sock_map_bpf_prog_query(attr, uattr);
+	case BPF_TCX_INGRESS:
+	case BPF_TCX_EGRESS:
+		return tcx_prog_query(attr, uattr);
 	default:
 		return -EINVAL;
 	}
@@ -4700,6 +4747,13 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 			goto out;
 		}
 		break;
+	case BPF_PROG_TYPE_SCHED_CLS:
+		if (attr->link_create.attach_type != BPF_TCX_INGRESS &&
+		    attr->link_create.attach_type != BPF_TCX_EGRESS) {
+			ret = -EINVAL;
+			goto out;
+		}
+		break;
 	default:
 		ptype = attach_type_to_prog_type(attr->link_create.attach_type);
 		if (ptype == BPF_PROG_TYPE_UNSPEC || ptype != prog->type) {
@@ -4751,6 +4805,9 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 	case BPF_PROG_TYPE_XDP:
 		ret = bpf_xdp_link_attach(attr, prog);
 		break;
+	case BPF_PROG_TYPE_SCHED_CLS:
+		ret = tcx_link_attach(attr, prog);
+		break;
 	case BPF_PROG_TYPE_NETFILTER:
 		ret = bpf_nf_link_attach(attr, prog);
 		break;
diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
new file mode 100644
index 000000000000..f5211bb6714c
--- /dev/null
+++ b/kernel/bpf/tcx.c
@@ -0,0 +1,351 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Isovalent */
+
+#include <linux/bpf.h>
+#include <linux/bpf_mprog.h>
+#include <linux/netdevice.h>
+
+#include <net/tcx.h>
+
+int tcx_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
+{
+	bool created, ingress = attr->attach_type == BPF_TCX_INGRESS;
+	struct net *net = current->nsproxy->net_ns;
+	struct bpf_prog *replace_prog = NULL;
+	struct bpf_mprog_entry *entry;
+	struct net_device *dev;
+	int ret;
+
+	rtnl_lock();
+	dev = __dev_get_by_index(net, attr->target_ifindex);
+	if (!dev) {
+		ret = -ENODEV;
+		goto out;
+	}
+	if (attr->attach_flags & BPF_F_REPLACE) {
+		replace_prog = bpf_prog_get_type(attr->replace_bpf_fd,
+						 prog->type);
+		if (IS_ERR(replace_prog)) {
+			ret = PTR_ERR(replace_prog);
+			replace_prog = NULL;
+			goto out;
+		}
+	}
+	entry = tcx_entry_fetch_or_create(dev, ingress, &created);
+	if (!entry) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	ret = bpf_mprog_attach(entry, prog, NULL, replace_prog,
+			       attr->attach_flags, attr->relative_fd,
+			       attr->expected_revision);
+	if (ret >= 0) {
+		if (bpf_mprog_swap_entries(ret))
+			tcx_entry_update(dev, bpf_mprog_peer(entry), ingress);
+		bpf_mprog_commit(entry);
+		tcx_skeys_inc(ingress);
+		ret = 0;
+	} else if (created) {
+		tcx_entry_free(entry);
+	}
+out:
+	if (replace_prog)
+		bpf_prog_put(replace_prog);
+	rtnl_unlock();
+	return ret;
+}
+
+int tcx_prog_detach(const union bpf_attr *attr, struct bpf_prog *prog)
+{
+	bool tcx_release, ingress = attr->attach_type == BPF_TCX_INGRESS;
+	struct net *net = current->nsproxy->net_ns;
+	struct bpf_mprog_entry *entry, *peer;
+	struct net_device *dev;
+	int ret;
+
+	rtnl_lock();
+	dev = __dev_get_by_index(net, attr->target_ifindex);
+	if (!dev) {
+		ret = -ENODEV;
+		goto out;
+	}
+	entry = tcx_entry_fetch(dev, ingress);
+	if (!entry) {
+		ret = -ENOENT;
+		goto out;
+	}
+	ret = bpf_mprog_detach(entry, prog, NULL, attr->attach_flags,
+			       attr->relative_fd, attr->expected_revision);
+	if (ret >= 0) {
+		tcx_release = tcx_entry_needs_release(entry, ret);
+		peer = tcx_release ? NULL : bpf_mprog_peer(entry);
+		if (bpf_mprog_swap_entries(ret))
+			tcx_entry_update(dev, peer, ingress);
+		bpf_mprog_commit(entry);
+		tcx_skeys_dec(ingress);
+		if (tcx_release)
+			tcx_entry_free(entry);
+		ret = 0;
+	}
+out:
+	rtnl_unlock();
+	return ret;
+}
+
+void tcx_uninstall(struct net_device *dev, bool ingress)
+{
+	struct bpf_tuple tuple = {};
+	struct bpf_mprog_entry *entry;
+	struct bpf_mprog_fp *fp;
+	struct bpf_mprog_cp *cp;
+
+	entry = tcx_entry_fetch(dev, ingress);
+	if (!entry)
+		return;
+	tcx_entry_update(dev, NULL, ingress);
+	bpf_mprog_commit(entry);
+	bpf_mprog_foreach_tuple(entry, fp, cp, tuple) {
+		if (tuple.link)
+			tcx_link(tuple.link)->dev = NULL;
+		else
+			bpf_prog_put(tuple.prog);
+		tcx_skeys_dec(ingress);
+	}
+	WARN_ON_ONCE(tcx_entry(entry)->miniq_active);
+	tcx_entry_free(entry);
+}
+
+int tcx_prog_query(const union bpf_attr *attr, union bpf_attr __user *uattr)
+{
+	bool ingress = attr->query.attach_type == BPF_TCX_INGRESS;
+	struct net *net = current->nsproxy->net_ns;
+	struct bpf_mprog_entry *entry;
+	struct net_device *dev;
+	int ret;
+
+	rtnl_lock();
+	dev = __dev_get_by_index(net, attr->query.target_ifindex);
+	if (!dev) {
+		ret = -ENODEV;
+		goto out;
+	}
+	entry = tcx_entry_fetch(dev, ingress);
+	if (!entry) {
+		ret = -ENOENT;
+		goto out;
+	}
+	ret = bpf_mprog_query(attr, uattr, entry);
+out:
+	rtnl_unlock();
+	return ret;
+}
+
+static int tcx_link_prog_attach(struct bpf_link *link, u32 flags, u32 object,
+				u64 revision)
+{
+	struct tcx_link *tcx = tcx_link(link);
+	bool created, ingress = tcx->location == BPF_TCX_INGRESS;
+	struct net_device *dev = tcx->dev;
+	struct bpf_mprog_entry *entry;
+	int ret;
+
+	ASSERT_RTNL();
+	entry = tcx_entry_fetch_or_create(dev, ingress, &created);
+	if (!entry)
+		return -ENOMEM;
+	ret = bpf_mprog_attach(entry, link->prog, link, NULL, flags, object,
+			       revision);
+	if (ret >= 0) {
+		if (bpf_mprog_swap_entries(ret))
+			tcx_entry_update(dev, bpf_mprog_peer(entry), ingress);
+		bpf_mprog_commit(entry);
+		tcx_skeys_inc(ingress);
+		ret = 0;
+	} else if (created) {
+		tcx_entry_free(entry);
+	}
+	return ret;
+}
+
+static void tcx_link_release(struct bpf_link *link)
+{
+	struct tcx_link *tcx = tcx_link(link);
+	bool tcx_release, ingress = tcx->location == BPF_TCX_INGRESS;
+	struct bpf_mprog_entry *entry, *peer;
+	struct net_device *dev;
+	int ret = 0;
+
+	rtnl_lock();
+	dev = tcx->dev;
+	if (!dev)
+		goto out;
+	entry = tcx_entry_fetch(dev, ingress);
+	if (!entry) {
+		ret = -ENOENT;
+		goto out;
+	}
+	ret = bpf_mprog_detach(entry, link->prog, link, 0, 0, 0);
+	if (ret >= 0) {
+		tcx_release = tcx_entry_needs_release(entry, ret);
+		peer = tcx_release ? NULL : bpf_mprog_peer(entry);
+		if (bpf_mprog_swap_entries(ret))
+			tcx_entry_update(dev, peer, ingress);
+		bpf_mprog_commit(entry);
+		tcx_skeys_dec(ingress);
+		if (tcx_release)
+			tcx_entry_free(entry);
+		tcx->dev = NULL;
+		ret = 0;
+	}
+out:
+	WARN_ON_ONCE(ret);
+	rtnl_unlock();
+}
+
+static int tcx_link_update(struct bpf_link *link, struct bpf_prog *nprog,
+			   struct bpf_prog *oprog)
+{
+	struct tcx_link *tcx = tcx_link(link);
+	bool ingress = tcx->location == BPF_TCX_INGRESS;
+	struct bpf_mprog_entry *entry;
+	struct net_device *dev;
+	int ret = 0;
+
+	rtnl_lock();
+	dev = tcx->dev;
+	if (!dev) {
+		ret = -ENOLINK;
+		goto out;
+	}
+	if (oprog && link->prog != oprog) {
+		ret = -EPERM;
+		goto out;
+	}
+	oprog = link->prog;
+	if (oprog == nprog) {
+		bpf_prog_put(nprog);
+		goto out;
+	}
+	entry = tcx_entry_fetch(dev, ingress);
+	if (!entry) {
+		ret = -ENOENT;
+		goto out;
+	}
+	ret = bpf_mprog_attach(entry, nprog, link, oprog,
+			       BPF_F_REPLACE | BPF_F_ID,
+			       link->prog->aux->id, 0);
+	if (ret >= 0) {
+		if (bpf_mprog_swap_entries(ret))
+			tcx_entry_update(dev, bpf_mprog_peer(entry), ingress);
+		bpf_mprog_commit(entry);
+		tcx_skeys_inc(ingress);
+		oprog = xchg(&link->prog, nprog);
+		bpf_prog_put(oprog);
+		ret = 0;
+	}
+out:
+	rtnl_unlock();
+	return ret;
+}
+
+static void tcx_link_dealloc(struct bpf_link *link)
+{
+	kfree(tcx_link(link));
+}
+
+static void tcx_link_fdinfo(const struct bpf_link *link, struct seq_file *seq)
+{
+	const struct tcx_link *tcx = tcx_link_const(link);
+	u32 ifindex = 0;
+
+	rtnl_lock();
+	if (tcx->dev)
+		ifindex = tcx->dev->ifindex;
+	rtnl_unlock();
+
+	seq_printf(seq, "ifindex:\t%u\n", ifindex);
+	seq_printf(seq, "attach_type:\t%u (%s)\n",
+		   tcx->location,
+		   tcx->location == BPF_TCX_INGRESS ? "ingress" : "egress");
+}
+
+static int tcx_link_fill_info(const struct bpf_link *link,
+			      struct bpf_link_info *info)
+{
+	const struct tcx_link *tcx = tcx_link_const(link);
+	u32 ifindex = 0;
+
+	rtnl_lock();
+	if (tcx->dev)
+		ifindex = tcx->dev->ifindex;
+	rtnl_unlock();
+
+	info->tcx.ifindex = ifindex;
+	info->tcx.attach_type = tcx->location;
+	return 0;
+}
+
+static int tcx_link_detach(struct bpf_link *link)
+{
+	tcx_link_release(link);
+	return 0;
+}
+
+static const struct bpf_link_ops tcx_link_lops = {
+	.release	= tcx_link_release,
+	.detach		= tcx_link_detach,
+	.dealloc	= tcx_link_dealloc,
+	.update_prog	= tcx_link_update,
+	.show_fdinfo	= tcx_link_fdinfo,
+	.fill_link_info	= tcx_link_fill_info,
+};
+
+static int tcx_link_init(struct tcx_link *tcx,
+			 struct bpf_link_primer *link_primer,
+			 const union bpf_attr *attr,
+			 struct net_device *dev,
+			 struct bpf_prog *prog)
+{
+	bpf_link_init(&tcx->link, BPF_LINK_TYPE_TCX, &tcx_link_lops, prog);
+	tcx->location = attr->link_create.attach_type;
+	tcx->dev = dev;
+	return bpf_link_prime(&tcx->link, link_primer);
+}
+
+int tcx_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
+{
+	struct net *net = current->nsproxy->net_ns;
+	struct bpf_link_primer link_primer;
+	struct net_device *dev;
+	struct tcx_link *tcx;
+	int ret;
+
+	rtnl_lock();
+	dev = __dev_get_by_index(net, attr->link_create.target_ifindex);
+	if (!dev) {
+		ret = -ENODEV;
+		goto out;
+	}
+	tcx = kzalloc(sizeof(*tcx), GFP_USER);
+	if (!tcx) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	ret = tcx_link_init(tcx, &link_primer, attr, dev, prog);
+	if (ret) {
+		kfree(tcx);
+		goto out;
+	}
+	ret = tcx_link_prog_attach(&tcx->link, attr->link_create.flags,
+				   attr->link_create.tcx.relative_fd,
+				   attr->link_create.tcx.expected_revision);
+	if (ret) {
+		tcx->dev = NULL;
+		bpf_link_cleanup(&link_primer);
+		goto out;
+	}
+	ret = bpf_link_settle(&link_primer);
+out:
+	rtnl_unlock();
+	return ret;
+}
diff --git a/net/Kconfig b/net/Kconfig
index 2fb25b534df5..d532ec33f1fe 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -52,6 +52,11 @@ config NET_INGRESS
 config NET_EGRESS
 	bool
 
+config NET_XGRESS
+	select NET_INGRESS
+	select NET_EGRESS
+	bool
+
 config NET_REDIRECT
 	bool
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 69a3e544676c..db60921ba1f8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -107,6 +107,7 @@
 #include <net/pkt_cls.h>
 #include <net/checksum.h>
 #include <net/xfrm.h>
+#include <net/tcx.h>
 #include <linux/highmem.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -154,7 +155,6 @@
 #include "dev.h"
 #include "net-sysfs.h"
 
-
 static DEFINE_SPINLOCK(ptype_lock);
 struct list_head ptype_base[PTYPE_HASH_SIZE] __read_mostly;
 struct list_head ptype_all __read_mostly;	/* Taps */
@@ -3882,69 +3882,200 @@ int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *skb)
 EXPORT_SYMBOL(dev_loopback_xmit);
 
 #ifdef CONFIG_NET_EGRESS
-static struct sk_buff *
-sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
+static struct netdev_queue *
+netdev_tx_queue_mapping(struct net_device *dev, struct sk_buff *skb)
+{
+	int qm = skb_get_queue_mapping(skb);
+
+	return netdev_get_tx_queue(dev, netdev_cap_txqueue(dev, qm));
+}
+
+static bool netdev_xmit_txqueue_skipped(void)
 {
+	return __this_cpu_read(softnet_data.xmit.skip_txqueue);
+}
+
+void netdev_xmit_skip_txqueue(bool skip)
+{
+	__this_cpu_write(softnet_data.xmit.skip_txqueue, skip);
+}
+EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
+#endif /* CONFIG_NET_EGRESS */
+
+#ifdef CONFIG_NET_XGRESS
+static int tc_run(struct tcx_entry *entry, struct sk_buff *skb)
+{
+	int ret = TC_ACT_UNSPEC;
 #ifdef CONFIG_NET_CLS_ACT
-	struct mini_Qdisc *miniq = rcu_dereference_bh(dev->miniq_egress);
-	struct tcf_result cl_res;
+	struct mini_Qdisc *miniq = rcu_dereference_bh(entry->miniq);
+	struct tcf_result res;
 
 	if (!miniq)
-		return skb;
+		return ret;
 
-	/* qdisc_skb_cb(skb)->pkt_len was already set by the caller. */
 	tc_skb_cb(skb)->mru = 0;
 	tc_skb_cb(skb)->post_ct = false;
-	mini_qdisc_bstats_cpu_update(miniq, skb);
 
-	switch (tcf_classify(skb, miniq->block, miniq->filter_list, &cl_res, false)) {
+	mini_qdisc_bstats_cpu_update(miniq, skb);
+	ret = tcf_classify(skb, miniq->block, miniq->filter_list, &res, false);
+	/* Only tcf related quirks below. */
+	switch (ret) {
+	case TC_ACT_SHOT:
+		mini_qdisc_qstats_cpu_drop(miniq);
+		break;
 	case TC_ACT_OK:
 	case TC_ACT_RECLASSIFY:
-		skb->tc_index = TC_H_MIN(cl_res.classid);
+		skb->tc_index = TC_H_MIN(res.classid);
 		break;
+	}
+#endif /* CONFIG_NET_CLS_ACT */
+	return ret;
+}
+
+static DEFINE_STATIC_KEY_FALSE(tcx_needed_key);
+
+void tcx_inc(void)
+{
+	static_branch_inc(&tcx_needed_key);
+}
+EXPORT_SYMBOL_GPL(tcx_inc);
+
+void tcx_dec(void)
+{
+	static_branch_dec(&tcx_needed_key);
+}
+EXPORT_SYMBOL_GPL(tcx_dec);
+
+static __always_inline enum tcx_action_base
+tcx_run(const struct bpf_mprog_entry *entry, struct sk_buff *skb,
+	const bool needs_mac)
+{
+	const struct bpf_mprog_fp *fp;
+	const struct bpf_prog *prog;
+	int ret = TCX_NEXT;
+
+	if (needs_mac)
+		__skb_push(skb, skb->mac_len);
+	bpf_mprog_foreach_prog(entry, fp, prog) {
+		bpf_compute_data_pointers(skb);
+		ret = bpf_prog_run(prog, skb);
+		if (ret != TCX_NEXT)
+			break;
+	}
+	if (needs_mac)
+		__skb_pull(skb, skb->mac_len);
+	return tcx_action_code(skb, ret);
+}
+
+static __always_inline struct sk_buff *
+sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
+		   struct net_device *orig_dev, bool *another)
+{
+	struct bpf_mprog_entry *entry = rcu_dereference_bh(skb->dev->tcx_ingress);
+	int sch_ret;
+
+	if (!entry)
+		return skb;
+	if (*pt_prev) {
+		*ret = deliver_skb(skb, *pt_prev, orig_dev);
+		*pt_prev = NULL;
+	}
+
+	qdisc_skb_cb(skb)->pkt_len = skb->len;
+	tcx_set_ingress(skb, true);
+
+	if (static_branch_unlikely(&tcx_needed_key)) {
+		sch_ret = tcx_run(entry, skb, true);
+		if (sch_ret != TC_ACT_UNSPEC)
+			goto ingress_verdict;
+	}
+	sch_ret = tc_run(tcx_entry(entry), skb);
+ingress_verdict:
+	switch (sch_ret) {
+	case TC_ACT_REDIRECT:
+		/* skb_mac_header check was done by BPF, so we can safely
+		 * push the L2 header back before redirecting to another
+		 * netdev.
+		 */
+		__skb_push(skb, skb->mac_len);
+		if (skb_do_redirect(skb) == -EAGAIN) {
+			__skb_pull(skb, skb->mac_len);
+			*another = true;
+			break;
+		}
+		*ret = NET_RX_SUCCESS;
+		return NULL;
 	case TC_ACT_SHOT:
-		mini_qdisc_qstats_cpu_drop(miniq);
-		*ret = NET_XMIT_DROP;
-		kfree_skb_reason(skb, SKB_DROP_REASON_TC_EGRESS);
+		kfree_skb_reason(skb, SKB_DROP_REASON_TC_INGRESS);
+		*ret = NET_RX_DROP;
 		return NULL;
+	/* used by tc_run */
 	case TC_ACT_STOLEN:
 	case TC_ACT_QUEUED:
 	case TC_ACT_TRAP:
-		*ret = NET_XMIT_SUCCESS;
 		consume_skb(skb);
+		fallthrough;
+	case TC_ACT_CONSUMED:
+		*ret = NET_RX_SUCCESS;
 		return NULL;
+	}
+
+	return skb;
+}
+
+static __always_inline struct sk_buff *
+sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
+{
+	struct bpf_mprog_entry *entry = rcu_dereference_bh(dev->tcx_egress);
+	int sch_ret;
+
+	if (!entry)
+		return skb;
+
+	/* qdisc_skb_cb(skb)->pkt_len & tcx_set_ingress() was
+	 * already set by the caller.
+	 */
+	if (static_branch_unlikely(&tcx_needed_key)) {
+		sch_ret = tcx_run(entry, skb, false);
+		if (sch_ret != TC_ACT_UNSPEC)
+			goto egress_verdict;
+	}
+	sch_ret = tc_run(tcx_entry(entry), skb);
+egress_verdict:
+	switch (sch_ret) {
 	case TC_ACT_REDIRECT:
 		/* No need to push/pop skb's mac_header here on egress! */
 		skb_do_redirect(skb);
 		*ret = NET_XMIT_SUCCESS;
 		return NULL;
-	default:
-		break;
+	case TC_ACT_SHOT:
+		kfree_skb_reason(skb, SKB_DROP_REASON_TC_EGRESS);
+		*ret = NET_XMIT_DROP;
+		return NULL;
+	/* used by tc_run */
+	case TC_ACT_STOLEN:
+	case TC_ACT_QUEUED:
+	case TC_ACT_TRAP:
+		*ret = NET_XMIT_SUCCESS;
+		return NULL;
 	}
-#endif /* CONFIG_NET_CLS_ACT */
 
 	return skb;
 }
-
-static struct netdev_queue *
-netdev_tx_queue_mapping(struct net_device *dev, struct sk_buff *skb)
-{
-	int qm = skb_get_queue_mapping(skb);
-
-	return netdev_get_tx_queue(dev, netdev_cap_txqueue(dev, qm));
-}
-
-static bool netdev_xmit_txqueue_skipped(void)
+#else
+static __always_inline struct sk_buff *
+sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
+		   struct net_device *orig_dev, bool *another)
 {
-	return __this_cpu_read(softnet_data.xmit.skip_txqueue);
+	return skb;
 }
 
-void netdev_xmit_skip_txqueue(bool skip)
+static __always_inline struct sk_buff *
+sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 {
-	__this_cpu_write(softnet_data.xmit.skip_txqueue, skip);
+	return skb;
 }
-EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
-#endif /* CONFIG_NET_EGRESS */
+#endif /* CONFIG_NET_XGRESS */
 
 #ifdef CONFIG_XPS
 static int __get_xps_queue_idx(struct net_device *dev, struct sk_buff *skb,
@@ -4128,9 +4259,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 	skb_update_prio(skb);
 
 	qdisc_pkt_len_init(skb);
-#ifdef CONFIG_NET_CLS_ACT
-	skb->tc_at_ingress = 0;
-#endif
+	tcx_set_ingress(skb, false);
 #ifdef CONFIG_NET_EGRESS
 	if (static_branch_unlikely(&egress_needed_key)) {
 		if (nf_hook_egress_active()) {
@@ -5064,72 +5193,6 @@ int (*br_fdb_test_addr_hook)(struct net_device *dev,
 EXPORT_SYMBOL_GPL(br_fdb_test_addr_hook);
 #endif
 
-static inline struct sk_buff *
-sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
-		   struct net_device *orig_dev, bool *another)
-{
-#ifdef CONFIG_NET_CLS_ACT
-	struct mini_Qdisc *miniq = rcu_dereference_bh(skb->dev->miniq_ingress);
-	struct tcf_result cl_res;
-
-	/* If there's at least one ingress present somewhere (so
-	 * we get here via enabled static key), remaining devices
-	 * that are not configured with an ingress qdisc will bail
-	 * out here.
-	 */
-	if (!miniq)
-		return skb;
-
-	if (*pt_prev) {
-		*ret = deliver_skb(skb, *pt_prev, orig_dev);
-		*pt_prev = NULL;
-	}
-
-	qdisc_skb_cb(skb)->pkt_len = skb->len;
-	tc_skb_cb(skb)->mru = 0;
-	tc_skb_cb(skb)->post_ct = false;
-	skb->tc_at_ingress = 1;
-	mini_qdisc_bstats_cpu_update(miniq, skb);
-
-	switch (tcf_classify(skb, miniq->block, miniq->filter_list, &cl_res, false)) {
-	case TC_ACT_OK:
-	case TC_ACT_RECLASSIFY:
-		skb->tc_index = TC_H_MIN(cl_res.classid);
-		break;
-	case TC_ACT_SHOT:
-		mini_qdisc_qstats_cpu_drop(miniq);
-		kfree_skb_reason(skb, SKB_DROP_REASON_TC_INGRESS);
-		*ret = NET_RX_DROP;
-		return NULL;
-	case TC_ACT_STOLEN:
-	case TC_ACT_QUEUED:
-	case TC_ACT_TRAP:
-		consume_skb(skb);
-		*ret = NET_RX_SUCCESS;
-		return NULL;
-	case TC_ACT_REDIRECT:
-		/* skb_mac_header check was done by cls/act_bpf, so
-		 * we can safely push the L2 header back before
-		 * redirecting to another netdev
-		 */
-		__skb_push(skb, skb->mac_len);
-		if (skb_do_redirect(skb) == -EAGAIN) {
-			__skb_pull(skb, skb->mac_len);
-			*another = true;
-			break;
-		}
-		*ret = NET_RX_SUCCESS;
-		return NULL;
-	case TC_ACT_CONSUMED:
-		*ret = NET_RX_SUCCESS;
-		return NULL;
-	default:
-		break;
-	}
-#endif /* CONFIG_NET_CLS_ACT */
-	return skb;
-}
-
 /**
  *	netdev_is_rx_handler_busy - check if receive handler is registered
  *	@dev: device to check
@@ -10838,7 +10901,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
 
 		/* Shutdown queueing discipline. */
 		dev_shutdown(dev);
-
+		dev_tcx_uninstall(dev);
 		dev_xdp_uninstall(dev);
 		bpf_dev_bound_netdev_unregister(dev);
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 06ba0e56e369..e39a8a20dd10 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9312,7 +9312,7 @@ static struct bpf_insn *bpf_convert_tstamp_read(const struct bpf_prog *prog,
 	__u8 value_reg = si->dst_reg;
 	__u8 skb_reg = si->src_reg;
 
-#ifdef CONFIG_NET_CLS_ACT
+#ifdef CONFIG_NET_XGRESS
 	/* If the tstamp_type is read,
 	 * the bpf prog is aware the tstamp could have delivery time.
 	 * Thus, read skb->tstamp as is if tstamp_type_access is true.
@@ -9346,7 +9346,7 @@ static struct bpf_insn *bpf_convert_tstamp_write(const struct bpf_prog *prog,
 	__u8 value_reg = si->src_reg;
 	__u8 skb_reg = si->dst_reg;
 
-#ifdef CONFIG_NET_CLS_ACT
+#ifdef CONFIG_NET_XGRESS
 	/* If the tstamp_type is read,
 	 * the bpf prog is aware the tstamp could have delivery time.
 	 * Thus, write skb->tstamp as is if tstamp_type_access is true.
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index 4b95cb1ac435..470c70deffe2 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -347,8 +347,7 @@ config NET_SCH_FQ_PIE
 config NET_SCH_INGRESS
 	tristate "Ingress/classifier-action Qdisc"
 	depends on NET_CLS_ACT
-	select NET_INGRESS
-	select NET_EGRESS
+	select NET_XGRESS
 	help
 	  Say Y here if you want to use classifiers for incoming and/or outgoing
 	  packets. This qdisc doesn't do anything else besides running classifiers,
@@ -679,6 +678,7 @@ config NET_EMATCH_IPT
 config NET_CLS_ACT
 	bool "Actions"
 	select NET_CLS
+	select NET_XGRESS
 	help
 	  Say Y here if you want to use traffic control actions. Actions
 	  get attached to classifiers and are invoked after a successful
diff --git a/net/sched/sch_ingress.c b/net/sched/sch_ingress.c
index e43a45499372..ea1baa0e0d76 100644
--- a/net/sched/sch_ingress.c
+++ b/net/sched/sch_ingress.c
@@ -13,6 +13,7 @@
 #include <net/netlink.h>
 #include <net/pkt_sched.h>
 #include <net/pkt_cls.h>
+#include <net/tcx.h>
 
 struct ingress_sched_data {
 	struct tcf_block *block;
@@ -78,6 +79,8 @@ static int ingress_init(struct Qdisc *sch, struct nlattr *opt,
 {
 	struct ingress_sched_data *q = qdisc_priv(sch);
 	struct net_device *dev = qdisc_dev(sch);
+	struct bpf_mprog_entry *entry;
+	bool created;
 	int err;
 
 	if (sch->parent != TC_H_INGRESS)
@@ -85,7 +88,13 @@ static int ingress_init(struct Qdisc *sch, struct nlattr *opt,
 
 	net_inc_ingress_queue();
 
-	mini_qdisc_pair_init(&q->miniqp, sch, &dev->miniq_ingress);
+	entry = tcx_entry_fetch_or_create(dev, true, &created);
+	if (!entry)
+		return -ENOMEM;
+	tcx_miniq_active(entry, true);
+	mini_qdisc_pair_init(&q->miniqp, sch, &tcx_entry(entry)->miniq);
+	if (created)
+		tcx_entry_update(dev, entry, true);
 
 	q->block_info.binder_type = FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS;
 	q->block_info.chain_head_change = clsact_chain_head_change;
@@ -103,11 +112,22 @@ static int ingress_init(struct Qdisc *sch, struct nlattr *opt,
 static void ingress_destroy(struct Qdisc *sch)
 {
 	struct ingress_sched_data *q = qdisc_priv(sch);
+	struct net_device *dev = qdisc_dev(sch);
+	struct bpf_mprog_entry *entry = rtnl_dereference(dev->tcx_ingress);
 
 	if (sch->parent != TC_H_INGRESS)
 		return;
 
 	tcf_block_put_ext(q->block, sch, &q->block_info);
+
+	if (entry) {
+		tcx_miniq_active(entry, false);
+		if (!bpf_mprog_total(entry)) {
+			tcx_entry_update(dev, NULL, false);
+			tcx_entry_free(entry);
+		}
+	}
+
 	net_dec_ingress_queue();
 }
 
@@ -223,6 +243,8 @@ static int clsact_init(struct Qdisc *sch, struct nlattr *opt,
 {
 	struct clsact_sched_data *q = qdisc_priv(sch);
 	struct net_device *dev = qdisc_dev(sch);
+	struct bpf_mprog_entry *entry;
+	bool created;
 	int err;
 
 	if (sch->parent != TC_H_CLSACT)
@@ -231,7 +253,13 @@ static int clsact_init(struct Qdisc *sch, struct nlattr *opt,
 	net_inc_ingress_queue();
 	net_inc_egress_queue();
 
-	mini_qdisc_pair_init(&q->miniqp_ingress, sch, &dev->miniq_ingress);
+	entry = tcx_entry_fetch_or_create(dev, true, &created);
+	if (!entry)
+		return -ENOMEM;
+	tcx_miniq_active(entry, true);
+	mini_qdisc_pair_init(&q->miniqp_ingress, sch, &tcx_entry(entry)->miniq);
+	if (created)
+		tcx_entry_update(dev, entry, true);
 
 	q->ingress_block_info.binder_type = FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS;
 	q->ingress_block_info.chain_head_change = clsact_chain_head_change;
@@ -244,7 +272,13 @@ static int clsact_init(struct Qdisc *sch, struct nlattr *opt,
 
 	mini_qdisc_pair_block_init(&q->miniqp_ingress, q->ingress_block);
 
-	mini_qdisc_pair_init(&q->miniqp_egress, sch, &dev->miniq_egress);
+	entry = tcx_entry_fetch_or_create(dev, false, &created);
+	if (!entry)
+		return -ENOMEM;
+	tcx_miniq_active(entry, true);
+	mini_qdisc_pair_init(&q->miniqp_egress, sch, &tcx_entry(entry)->miniq);
+	if (created)
+		tcx_entry_update(dev, entry, false);
 
 	q->egress_block_info.binder_type = FLOW_BLOCK_BINDER_TYPE_CLSACT_EGRESS;
 	q->egress_block_info.chain_head_change = clsact_chain_head_change;
@@ -256,12 +290,31 @@ static int clsact_init(struct Qdisc *sch, struct nlattr *opt,
 static void clsact_destroy(struct Qdisc *sch)
 {
 	struct clsact_sched_data *q = qdisc_priv(sch);
+	struct net_device *dev = qdisc_dev(sch);
+	struct bpf_mprog_entry *ingress_entry = rtnl_dereference(dev->tcx_ingress);
+	struct bpf_mprog_entry *egress_entry = rtnl_dereference(dev->tcx_egress);
 
 	if (sch->parent != TC_H_CLSACT)
 		return;
 
-	tcf_block_put_ext(q->egress_block, sch, &q->egress_block_info);
 	tcf_block_put_ext(q->ingress_block, sch, &q->ingress_block_info);
+	tcf_block_put_ext(q->egress_block, sch, &q->egress_block_info);
+
+	if (ingress_entry) {
+		tcx_miniq_active(ingress_entry, false);
+		if (!bpf_mprog_total(ingress_entry)) {
+			tcx_entry_update(dev, NULL, true);
+			tcx_entry_free(ingress_entry);
+		}
+	}
+
+	if (egress_entry) {
+		tcx_miniq_active(egress_entry, false);
+		if (!bpf_mprog_total(egress_entry)) {
+			tcx_entry_update(dev, NULL, false);
+			tcx_entry_free(egress_entry);
+		}
+	}
 
 	net_dec_ingress_queue();
 	net_dec_egress_queue();
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 74879c538f2b..98c4a3a6e137 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1036,6 +1036,8 @@ enum bpf_attach_type {
 	BPF_LSM_CGROUP,
 	BPF_STRUCT_OPS,
 	BPF_NETFILTER,
+	BPF_TCX_INGRESS,
+	BPF_TCX_EGRESS,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -1053,7 +1055,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_KPROBE_MULTI = 8,
 	BPF_LINK_TYPE_STRUCT_OPS = 9,
 	BPF_LINK_TYPE_NETFILTER = 10,
-
+	BPF_LINK_TYPE_TCX = 11,
 	MAX_BPF_LINK_TYPE,
 };
 
@@ -1559,13 +1561,13 @@ union bpf_attr {
 			__u32		map_fd;		/* struct_ops to attach */
 		};
 		union {
-			__u32		target_fd;	/* object to attach to */
-			__u32		target_ifindex; /* target ifindex */
+			__u32	target_fd;	/* target object to attach to or ... */
+			__u32	target_ifindex; /* target ifindex */
 		};
 		__u32		attach_type;	/* attach type */
 		__u32		flags;		/* extra flags */
 		union {
-			__u32		target_btf_id;	/* btf_id of target to attach to */
+			__u32	target_btf_id;	/* btf_id of target to attach to */
 			struct {
 				__aligned_u64	iter_info;	/* extra bpf_iter_link_info */
 				__u32		iter_info_len;	/* iter_info length */
@@ -1599,6 +1601,13 @@ union bpf_attr {
 				__s32		priority;
 				__u32		flags;
 			} netfilter;
+			struct {
+				union {
+					__u32	relative_fd;
+					__u32	relative_id;
+				};
+				__u64		expected_revision;
+			} tcx;
 		};
 	} link_create;
 
@@ -6207,6 +6216,19 @@ struct bpf_sock_tuple {
 	};
 };
 
+/* (Simplified) user return codes for tcx prog type.
+ * A valid tcx program must return one of these defined values. All other
+ * return codes are reserved for future use. Must remain compatible with
+ * their TC_ACT_* counter-parts. For compatibility in behavior, unknown
+ * return codes are mapped to TCX_NEXT.
+ */
+enum tcx_action_base {
+	TCX_NEXT	= -1,
+	TCX_PASS	= 0,
+	TCX_DROP	= 2,
+	TCX_REDIRECT	= 7,
+};
+
 struct bpf_xdp_sock {
 	__u32 queue_id;
 };
@@ -6459,6 +6481,10 @@ struct bpf_link_info {
 			__s32 priority;
 			__u32 flags;
 		} netfilter;
+		struct {
+			__u32 ifindex;
+			__u32 attach_type;
+		} tcx;
 	};
 } __attribute__((aligned(8)));
 
-- 
2.34.1


