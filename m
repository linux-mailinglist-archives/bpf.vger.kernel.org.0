Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDA0681408
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 16:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbjA3PE4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 10:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbjA3PEq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 10:04:46 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A9D1814C;
        Mon, 30 Jan 2023 07:04:45 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1pMVi6-0003mG-S9; Mon, 30 Jan 2023 16:04:42 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <bpf@vger.kernel.org>
Cc:     <netfilter-devel@vger.kernel.org>, Florian Westphal <fw@strlen.de>
Subject: [RFC] bpf: add bpf_link support for BPF_NETFILTER programs
Date:   Mon, 30 Jan 2023 16:04:32 +0100
Message-Id: <20230130150432.24924-1-fw@strlen.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Doesn't apply, doesn't work -- there is no BPF_NETFILTER program type.

Sketches the uapi.  Example usage:

	union bpf_attr attr = { };

	attr.link_create.prog_fd = progfd;
	attr.link_create.attach_type = BPF_NETFILTER;
	attr.link_create.netfilter.pf = PF_INET;
	attr.link_create.netfilter.hooknum = NF_INET_LOCAL_IN;
	attr.link_create.netfilter.priority = -128;

	err = bpf(BPF_LINK_CREATE, &attr, sizeof(attr));

... this would attach progfd to ipv4:input hook.

Is BPF_LINK the right place?  Hook gets removed automatically if the calling program
exits, afaict this is intended.

Should a program running in init_netns be allowed to attach hooks in other netns too?

I could do what BPF_LINK_TYPE_NETNS is doing and fetch net via
get_net_ns_by_fd(attr->link_create.target_fd);

For the actual BPF_NETFILTER program type I plan to follow what the bpf
flow dissector is doing, i.e. pretend prototype is

func(struct __sk_buff *skb)

but pass a custom program specific context struct on kernel side.
Verifier will rewrite accesses as needed.

Things like nf_hook_state->in (net_device) could then be exposed via
kfuncs.

nf_hook_run_bpf() (c-function that creates the program context and
calls the real bpf prog) would be "updated" to use the bpf dispatcher to
avoid the indirect call overhead.

Does that seem ok to you?  I'd ignore the bpf dispatcher for now and
would work on the needed verifier changes first.

Thanks.
---
 include/linux/netfilter.h           |   1 +
 include/net/netfilter/nf_hook_bpf.h |   3 +
 include/uapi/linux/bpf.h            |  13 ++++
 kernel/bpf/syscall.c                |   7 ++
 net/netfilter/nf_hook_bpf.c         | 114 ++++++++++++++++++++++++++++
 5 files changed, 138 insertions(+)

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index 6820649a0d46..fbab6e2b463e 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -87,6 +87,7 @@ typedef unsigned int nf_hookfn(void *priv,
 enum nf_hook_ops_type {
 	NF_HOOK_OP_UNDEFINED,
 	NF_HOOK_OP_NF_TABLES,
+	NF_HOOK_OP_BPF,
 };
 
 struct nf_hook_ops {
diff --git a/include/net/netfilter/nf_hook_bpf.h b/include/net/netfilter/nf_hook_bpf.h
index d0e865a1843a..7014fd986ad9 100644
--- a/include/net/netfilter/nf_hook_bpf.h
+++ b/include/net/netfilter/nf_hook_bpf.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 struct bpf_dispatcher;
 struct bpf_prog;
+struct nf_hook_ops;
 
 #if IS_ENABLED(CONFIG_NF_HOOK_BPF)
 struct bpf_prog *nf_hook_bpf_create(const struct nf_hook_entries *n,
@@ -21,3 +22,5 @@ nf_hook_bpf_create(const struct nf_hook_entries *n, struct nf_hook_ops * const *
 
 static inline struct bpf_prog *nf_hook_bpf_get_fallback(void) { return NULL; }
 #endif
+
+int bpf_nf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index bc1a3d232ae4..387944db0228 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -986,6 +986,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_LSM,
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
+	BPF_PROG_TYPE_NETFILTER,
 };
 
 enum bpf_attach_type {
@@ -1033,6 +1034,7 @@ enum bpf_attach_type {
 	BPF_PERF_EVENT,
 	BPF_TRACE_KPROBE_MULTI,
 	BPF_LSM_CGROUP,
+	BPF_NETFILTER,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -1049,6 +1051,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_PERF_EVENT = 7,
 	BPF_LINK_TYPE_KPROBE_MULTI = 8,
 	BPF_LINK_TYPE_STRUCT_OPS = 9,
+	BPF_LINK_TYPE_NETFILTER = 10,
 
 	MAX_BPF_LINK_TYPE,
 };
@@ -1538,6 +1541,11 @@ union bpf_attr {
 				 */
 				__u64		cookie;
 			} tracing;
+			struct {
+				__u32		pf;
+				__u32		hooknum;
+				__s32		prio;
+			} netfilter;
 		};
 	} link_create;
 
@@ -6342,6 +6350,11 @@ struct bpf_link_info {
 		struct {
 			__u32 ifindex;
 		} xdp;
+		struct {
+			__u32 pf;
+			__u32 hooknum;
+			__s32 priority;
+		} netfilter;
 	};
 } __attribute__((aligned(8)));
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a3f969f1aed5..fdfbabdd9222 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -35,6 +35,7 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/memcontrol.h>
 #include <linux/trace_events.h>
+#include <net/netfilter/nf_hook_bpf.h>
 
 #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
 			  (map)->map_type == BPF_MAP_TYPE_CGROUP_ARRAY || \
@@ -2433,6 +2434,7 @@ static bool is_net_admin_prog_type(enum bpf_prog_type prog_type)
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
 	case BPF_PROG_TYPE_SOCK_OPS:
 	case BPF_PROG_TYPE_EXT: /* extends any prog */
+	case BPF_PROG_TYPE_NETFILTER:
 		return true;
 	case BPF_PROG_TYPE_CGROUP_SKB:
 		/* always unpriv */
@@ -3452,6 +3454,8 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 		return BPF_PROG_TYPE_XDP;
 	case BPF_LSM_CGROUP:
 		return BPF_PROG_TYPE_LSM;
+	case BPF_NETFILTER:
+		return BPF_PROG_TYPE_NETFILTER;
 	default:
 		return BPF_PROG_TYPE_UNSPEC;
 	}
@@ -4605,6 +4609,9 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 	case BPF_PROG_TYPE_XDP:
 		ret = bpf_xdp_link_attach(attr, prog);
 		break;
+	case BPF_PROG_TYPE_NETFILTER:
+		ret = bpf_nf_link_attach(attr, prog);
+		break;
 #endif
 	case BPF_PROG_TYPE_PERF_EVENT:
 	case BPF_PROG_TYPE_TRACEPOINT:
diff --git a/net/netfilter/nf_hook_bpf.c b/net/netfilter/nf_hook_bpf.c
index 55bede6e78cd..922f4c85a7ce 100644
--- a/net/netfilter/nf_hook_bpf.c
+++ b/net/netfilter/nf_hook_bpf.c
@@ -648,3 +648,117 @@ void nf_hook_bpf_change_prog_and_release(struct bpf_dispatcher *d, struct bpf_pr
 	if (from && from != fallback_nf_hook_slow)
 		bpf_prog_put(from);
 }
+
+static unsigned int nf_hook_run_bpf(void *bpf_prog, struct sk_buff *skb, const struct nf_hook_state *s)
+{
+	/* BPF_DISPATCHER_FUNC(nf_hook_base)(state, prog->insnsi, prog->bpf_func); */
+
+	pr_info_ratelimited("%s called at hook %d for pf %d\n", __func__, s->hook, s->pf);
+	return NF_ACCEPT;
+}
+
+struct bpf_nf_link {
+	struct bpf_link link;
+	struct nf_hook_ops hook_ops;
+	struct net *net;
+};
+
+static void bpf_nf_link_release(struct bpf_link *link)
+{
+	struct bpf_nf_link *nf_link = container_of(link, struct bpf_nf_link, link);
+
+	nf_unregister_net_hook(nf_link->net, &nf_link->hook_ops);
+}
+
+static void bpf_nf_link_dealloc(struct bpf_link *link)
+{
+	struct bpf_nf_link *nf_link = container_of(link, struct bpf_nf_link, link);
+
+	kfree(nf_link);
+}
+
+static int bpf_nf_link_detach(struct bpf_link *link)
+{
+	bpf_nf_link_release(link);
+	return 0;
+}
+
+static void bpf_nf_link_show_info(const struct bpf_link *link,
+				  struct seq_file *seq)
+{
+	struct bpf_nf_link *nf_link = container_of(link, struct bpf_nf_link, link);
+
+	seq_printf(seq, "pf:\t%u\thooknum:\t%u\tprio:\t%d\n",
+		  nf_link->hook_ops.pf, nf_link->hook_ops.hooknum,
+		  nf_link->hook_ops.priority);
+}
+
+static int bpf_nf_link_fill_link_info(const struct bpf_link *link,
+				      struct bpf_link_info *info)
+{
+	struct bpf_nf_link *nf_link = container_of(link, struct bpf_nf_link, link);
+
+	info->netfilter.pf = nf_link->hook_ops.pf;
+	info->netfilter.hooknum = nf_link->hook_ops.hooknum;
+	info->netfilter.priority = nf_link->hook_ops.priority;
+
+	return 0;
+}
+
+static int bpf_nf_link_update(struct bpf_link *link, struct bpf_prog *new_prog,
+			      struct bpf_prog *old_prog)
+{
+	return -EOPNOTSUPP;
+}
+
+static const struct bpf_link_ops bpf_nf_link_lops = {
+	.release = bpf_nf_link_release,
+	.dealloc = bpf_nf_link_dealloc,
+	.detach = bpf_nf_link_detach,
+	.show_fdinfo = bpf_nf_link_show_info,
+	.fill_link_info = bpf_nf_link_fill_link_info,
+	.update_prog = bpf_nf_link_update,
+};
+
+int bpf_nf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
+{
+	struct net *net = current->nsproxy->net_ns;
+	struct bpf_link_primer link_primer;
+	struct bpf_nf_link *link;
+	int err;
+
+	if (attr->link_create.flags)
+		return -EINVAL;
+
+	link = kzalloc(sizeof(*link), GFP_USER);
+	if (!link)
+		return -ENOMEM;
+
+	bpf_link_init(&link->link, BPF_LINK_TYPE_NETFILTER, &bpf_nf_link_lops, prog);
+
+	link->hook_ops.hook = nf_hook_run_bpf;
+	link->hook_ops.hook_ops_type = NF_HOOK_OP_BPF;
+	link->hook_ops.priv = prog;
+
+	link->hook_ops.pf = attr->link_create.netfilter.pf;
+	link->hook_ops.priority = attr->link_create.netfilter.prio;
+	link->hook_ops.hooknum = attr->link_create.netfilter.hooknum;
+
+	link->net = net;
+
+	err = bpf_link_prime(&link->link, &link_primer);
+	if (err)
+		goto out_free;
+
+	err = nf_register_net_hook(net, &link->hook_ops);
+	if (err) {
+		bpf_link_cleanup(&link_primer);
+		goto out_free;
+	}
+
+	return bpf_link_settle(&link_primer);
+
+out_free:
+	kfree(link);
+	return err;
+}
-- 
2.39.1

