Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B5C68F2BC
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 17:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjBHQD6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 11:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBHQD6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 11:03:58 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101724C6EE;
        Wed,  8 Feb 2023 08:03:35 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1pPmv0-0006hA-AM; Wed, 08 Feb 2023 17:03:34 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <bpf@vger.kernel.org>
Cc:     <netfilter-devel@vger.kernel.org>, Florian Westphal <fw@strlen.de>
Subject: [RFC nf-next 3/3] bpf: minimal support for programs hooked into netfilter framework
Date:   Wed,  8 Feb 2023 17:03:07 +0100
Message-Id: <20230208160307.27534-4-fw@strlen.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208160307.27534-1-fw@strlen.de>
References: <20230208160307.27534-1-fw@strlen.de>
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

Not for merging: has problems.

This adds minimal support for BPF_PROG_TYPE_NETFILTER bpf programs
that will be invoked via the NF_HOOK() points in the ip(6) stack.

Invocation incurs an indirect call.  This is not a necessity: Its
possible to add 'DEFINE_BPF_DISPATCHER(nf_progs)' and handle the
program invocation with the same method already done for xdp progs.

This isn't done here to keep the size of this chunk down.

Verifier will reject programs that don't return either DROP or ACCEPT
verdicts.

Programs currently pretend they have prototype

  func(struct __sk_buff *skb)

with rewrite via verifier, but this will be changed to native kernel struct, i.e.:

  func(struct bpf_nf_ctx *ctx)

Instead of direct packet access, plan is to have programs use upcoming
'dynptr' api.

For 'traditional' netfilter (c-functions), skb->data is only guaranteed
to be linear for the ip/ip6 header, for everything else
skb_header_pointer is mandatory.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/linux/bpf_types.h           |   4 +
 include/net/netfilter/nf_hook_bpf.h |   8 ++
 kernel/bpf/btf.c                    |   3 +
 kernel/bpf/verifier.c               |   3 +
 net/netfilter/nf_bpf_link.c         | 128 +++++++++++++++++++++++++++-
 5 files changed, 145 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index d4ee3ccd3753..ecc7444b31d4 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -77,6 +77,10 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_LSM, lsm,
 	       void *, void *)
 #endif /* CONFIG_BPF_LSM */
 #endif
+#ifdef CONFIG_NETFILTER
+BPF_PROG_TYPE(BPF_PROG_TYPE_NETFILTER, netfilter,
+	      struct __sk_buff, struct bpf_nf_ctx)
+#endif
 BPF_PROG_TYPE(BPF_PROG_TYPE_SYSCALL, bpf_syscall,
 	      void *, void *)
 
diff --git a/include/net/netfilter/nf_hook_bpf.h b/include/net/netfilter/nf_hook_bpf.h
index 9d1b338e89d7..cf02e8394598 100644
--- a/include/net/netfilter/nf_hook_bpf.h
+++ b/include/net/netfilter/nf_hook_bpf.h
@@ -1,2 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+
+struct bpf_nf_ctx {
+	const struct nf_hook_state *state;
+	const struct sk_buff *skb;
+	const void *data;
+	const void *data_end;
+};
+
 int bpf_nf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 47b8cb96f2c2..07339c81d9f1 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -25,6 +25,9 @@
 #include <linux/bsearch.h>
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
+
+#include <net/netfilter/nf_hook_bpf.h>
+
 #include <net/sock.h>
 #include "../tools/lib/bpf/relo_core.h"
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0973660a30ec..e63ecbb69250 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12547,6 +12547,9 @@ static int check_return_code(struct bpf_verifier_env *env)
 		}
 		break;
 
+	case BPF_PROG_TYPE_NETFILTER:
+		range = tnum_range(NF_DROP, NF_ACCEPT);
+		break;
 	case BPF_PROG_TYPE_EXT:
 		/* freplace program can return anything as its return value
 		 * depends on the to-be-replaced kernel func or bpf program.
diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
index fa4fae5cc669..98a6f7dc05e2 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -1,12 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/bpf.h>
+#include <linux/filter.h>
 #include <linux/netfilter.h>
 
 #include <net/netfilter/nf_hook_bpf.h>
 
 static unsigned int nf_hook_run_bpf(void *bpf_prog, struct sk_buff *skb, const struct nf_hook_state *s)
 {
-	return NF_ACCEPT;
+	const struct bpf_prog *prog = bpf_prog;
+	struct bpf_nf_ctx ctx = {
+		.state = s,
+		.skb = skb,
+		.data = skb->data,
+		.data_end = skb->data + skb_headlen(skb),
+	};
+
+	return bpf_prog_run(prog, &ctx);
 }
 
 struct bpf_nf_link {
@@ -114,3 +123,120 @@ int bpf_nf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	kfree(link);
 	return err;
 }
+
+static int bpf_prog_test_run_nf(struct bpf_prog *prog,
+				const union bpf_attr *kattr,
+				union bpf_attr __user *uattr)
+{
+	return -EOPNOTSUPP;
+}
+
+const struct bpf_prog_ops netfilter_prog_ops = {
+	.test_run		= bpf_prog_test_run_nf,
+};
+
+static u32 nf_convert_ctx_access(enum bpf_access_type type,
+				  const struct bpf_insn *si,
+				  struct bpf_insn *insn_buf,
+				  struct bpf_prog *prog, u32 *target_size)
+{
+	struct bpf_insn *insn = insn_buf;
+
+	switch (si->off) {
+	case offsetof(struct __sk_buff, data):
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_nf_ctx, data),
+				      si->dst_reg, si->src_reg,
+				      offsetof(struct bpf_nf_ctx, data));
+		break;
+	case offsetof(struct __sk_buff, data_end):
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_nf_ctx, data_end),
+				      si->dst_reg, si->src_reg,
+				      offsetof(struct bpf_nf_ctx, data_end));
+		break;
+	}
+
+	return insn - insn_buf;
+}
+
+static bool nf_is_valid_access(int off, int size, enum bpf_access_type type,
+			       const struct bpf_prog *prog,
+			       struct bpf_insn_access_aux *info)
+{
+	if (off < 0 || off >= sizeof(struct __sk_buff))
+		return false;
+
+	if (type == BPF_WRITE)
+		return false;
+
+	switch (off) {
+	case bpf_ctx_range(struct __sk_buff, data):
+		if (size != sizeof(u32))
+			return false;
+		info->reg_type = PTR_TO_PACKET;
+		return true;
+	case bpf_ctx_range(struct __sk_buff, data_end):
+		if (size != sizeof(u32))
+			return false;
+		info->reg_type = PTR_TO_PACKET_END;
+		return true;
+	default:
+		return false;
+	}
+
+	return false;
+}
+
+static const struct bpf_func_proto *
+bpf_nf_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	return bpf_base_func_proto(func_id);
+}
+
+const struct bpf_verifier_ops netfilter_verifier_ops = {
+	.is_valid_access	= nf_is_valid_access,
+	.convert_ctx_access	= nf_convert_ctx_access,
+	.get_func_proto		= bpf_nf_func_proto,
+};
+
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "kfuncs which will be used in BPF programs");
+
+/* bpf_nf_hook_state_ctx_get - get nf_hook_state context structure
+ *
+ * Get the real nf_hook_state context structure.
+ *
+ *
+ */
+const struct nf_hook_state *bpf_nf_hook_state_ctx_get(struct __sk_buff *s)
+{
+	return (const struct nf_hook_state *)s;
+}
+
+int bpf_xt_change_status(struct nf_conn *nfct, u32 status)
+{
+	return 1;
+}
+
+__diag_pop()
+
+BTF_SET8_START(nf_hook_kfunc_set)
+BTF_ID_FLAGS(func, bpf_nf_hook_state_ctx_get, 0)
+BTF_ID_FLAGS(func, bpf_xt_change_status, KF_TRUSTED_ARGS)
+BTF_SET8_END(nf_hook_kfunc_set)
+
+static const struct btf_kfunc_id_set nf_basehook_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &nf_hook_kfunc_set,
+};
+
+int register_nf_hook_bpf(void)
+{
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER, &nf_basehook_kfunc_set);
+	if (ret)
+		return ret;
+
+	return ret;
+}
-- 
2.39.1

