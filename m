Return-Path: <bpf+bounces-19758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B52830EEC
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 22:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2041F23B88
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 21:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABF728E32;
	Wed, 17 Jan 2024 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBLBYzYO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6306628E1C;
	Wed, 17 Jan 2024 21:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705528596; cv=none; b=t7hBSH5HIYTm5xaDJQKJqDglLQqLvzjDkIFbD6Zdmvtau9So2uXJwNmqd86EykinYOriyEdet3kfb4k0k4POUCQyIrmsSOq+Sl3W2z+JqNrZmIQR7mEciZjm15iR+f2Yxs7nPKCKkJJNjSneL0oKXfa9TISU2kVwJjYH+JcA/s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705528596; c=relaxed/simple;
	bh=WynIwsoUg3bULqZw+eKtS+i7WdzyzHnbyJSzQfcmyCI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=A/zMZmZ4xFP7psG/TTlpa2nsUKT1Ojh9gHjPK3WYeS2YX8j6uLwLVY+1uRqi2gjPZF01xg+rVNgrCOPNmJGl+h9iFSnpsFhfDA6nBVS2K1qwyfa0/1SUPtzHAzJaF3SlLnVciqA3O+oPTp2qv8aAbTFIA77UBTOC78s9IWJxf8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBLBYzYO; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-429be9fe952so1058171cf.0;
        Wed, 17 Jan 2024 13:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705528593; x=1706133393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0JrVED4ngcpYxa01oTPJs1iJIIx5CIBDAO0VemoDxs=;
        b=FBLBYzYOeKovlNib+CyymKvZ/cz1r3RAePcdnuRZPSeDDFQJ4ryqw9klx/tXRmVFJg
         TehRHh/QLiTdFVOhEvrVs034y8SoG9wQ57qNTAJDkVUVEVeBt09AHn451UTur3ZOjx21
         zJtV3jK+kcmmfBfQQdAuRxR4KaSecCxvyWko8kyAScRWHiXKZz/shiFKKv/8LCPlxPDN
         eli1mWtX/i3+bj+ZmvekoHZHwu4YSgttPOQE8BwG72r2FXnnwzdzoa5LwPj1/5w/MVPE
         W3+tv5aInpAmXukwwn3SHHBRBGbQCVodc8MQPM/IJx4kDMCVN1voZ7F/GVoqzrQrarbN
         CWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705528593; x=1706133393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0JrVED4ngcpYxa01oTPJs1iJIIx5CIBDAO0VemoDxs=;
        b=NOvfyCe5r9xFScABTGvI9qlTmuPh35Mpp7GSBpgSCg8qCq9lc4t8WMGe/4vYLP+6vy
         2i0fSa3LRYgQbshHmX5M1YacUf61rPFWQYtvV5J5EMo/g/uByzHEEpyk+uYDJJCYpNkq
         3AUDMBnj7z+nBzEkGWYcpF3OiUTPzytjK/ldedla5ziG7Y1R48EtqiCIxJd/DWcY0ivA
         9PO7Qg731/++znYPtvlzhPN/rM5xGuOdSgdxcNT1tJVgO/CVQA4O4UH1vGEax/SdTPJQ
         p/OOWulFRibicMhgmroVPKbYFvXKLPbsJEMKpxEuZFGee5laUkYwh6byWRJOaQYBY1/X
         bybw==
X-Gm-Message-State: AOJu0YwEfUJCR4adycS+UTP5CwoT6IjDJTLVE0vhfxUn6aFs1dfGSsCl
	ttpS3pmU6zFydZVJXBgzAnLAVhOWPYo=
X-Google-Smtp-Source: AGHT+IEqRbVy9eDvTGMWQyjVQvk1zmsoPqvwn2kENUA0cSnUD0XU6NaPDmUc1dQUs3+caSvUpuk4SA==
X-Received: by 2002:ac8:580c:0:b0:42a:152d:32b4 with SMTP id g12-20020ac8580c000000b0042a152d32b4mr1043162qtg.57.1705528592967;
        Wed, 17 Jan 2024 13:56:32 -0800 (PST)
Received: from n36-183-057.byted.org ([147.160.184.91])
        by smtp.gmail.com with ESMTPSA id hj11-20020a05622a620b00b00428346b88bfsm6105263qtb.65.2024.01.17.13.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 13:56:32 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com
Subject: [RFC PATCH v7 8/8] samples/bpf: Add an example of bpf netem qdisc
Date: Wed, 17 Jan 2024 21:56:24 +0000
Message-Id: <5d01cc9a45d3f537a5bf5eb197567d5bcd6b936e.1705432850.git.amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1705432850.git.amery.hung@bytedance.com>
References: <cover.1705432850.git.amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tc_sch_netem.bpf.c
A simple bpf network emulator (netem) qdisc that simulates packet drops,
loss, and delay. The qdisc shares the state machine of Gilbert-Elliott
model via a eBPF map when it is added to multiple tx queues.

tc_sch_netem.c
A user space program to load and attach the eBPF-based netem qdisc, which
by default add the bpf fq to the loopback device, but can also add to other
dev and class with '-d' and '-p' options.

To test mq + netem with shared state machine:
$ tc qdisc add dev ens5 root handle 1: mq
$ ./tc_sch_netem -d ens5 -p 1:1 -h 801 -s
$ ./tc_sch_netem -d ens5 -p 1:2 -h 802 -s
$ ./tc_sch_netem -d ens5 -p 1:3 -h 803 -s
$ ./tc_sch_netem -d ens5 -p 1:4 -h 804 -s

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 samples/bpf/Makefile           |   8 +-
 samples/bpf/tc_sch_netem.bpf.c | 256 ++++++++++++++++++++++++
 samples/bpf/tc_sch_netem.c     | 347 +++++++++++++++++++++++++++++++++
 3 files changed, 610 insertions(+), 1 deletion(-)
 create mode 100644 samples/bpf/tc_sch_netem.bpf.c
 create mode 100644 samples/bpf/tc_sch_netem.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index ea516a00352d..880f15ae4bed 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -47,6 +47,7 @@ tprogs-y += task_fd_query
 tprogs-y += ibumad
 tprogs-y += hbm
 tprogs-y += tc_sch_fq
+tprogs-y += tc_sch_netem
 
 # Libbpf dependencies
 LIBBPF_SRC = $(TOOLS_PATH)/lib/bpf
@@ -100,6 +101,7 @@ hbm-objs := hbm.o $(CGROUP_HELPERS)
 
 xdp_router_ipv4-objs := xdp_router_ipv4_user.o $(XDP_SAMPLE)
 tc_sch_fq-objs := tc_sch_fq.o
+tc_sch_netem-objs := tc_sch_netem.o
 
 # Tell kbuild to always build the programs
 always-y := $(tprogs-y)
@@ -152,6 +154,7 @@ always-y += ibumad_kern.o
 always-y += hbm_out_kern.o
 always-y += hbm_edt_kern.o
 always-y += tc_sch_fq.bpf.o
+always-y += tc_sch_netem.bpf.o
 
 TPROGS_CFLAGS = $(TPROGS_USER_CFLAGS)
 TPROGS_LDFLAGS = $(TPROGS_USER_LDFLAGS)
@@ -199,6 +202,7 @@ TPROGLDLIBS_trace_output	+= -lrt
 TPROGLDLIBS_map_perf_test	+= -lrt
 TPROGLDLIBS_test_overhead	+= -lrt
 TPROGLDLIBS_tc_sch_fq		+= -lmnl
+TPROGLDLIBS_tc_sch_netem	+= -lmnl
 
 # Allows pointing LLC/CLANG to a LLVM backend with bpf support, redefine on cmdline:
 # make M=samples/bpf LLC=~/git/llvm-project/llvm/build/bin/llc CLANG=~/git/llvm-project/llvm/build/bin/clang
@@ -311,6 +315,7 @@ $(obj)/$(TRACE_HELPERS) $(obj)/$(CGROUP_HELPERS) $(obj)/$(XDP_SAMPLE): | libbpf_
 
 $(obj)/xdp_router_ipv4_user.o: $(obj)/xdp_router_ipv4.skel.h
 $(obj)/tc_sch_fq.o: $(obj)/tc_sch_fq.skel.h
+$(obj)/tc_sch_netem.o: $(obj)/tc_sch_netem.skel.h
 
 $(obj)/tracex5.bpf.o: $(obj)/syscall_nrs.h
 $(obj)/hbm_out_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
@@ -375,11 +380,12 @@ $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h $(src)/x
 		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
 		-c $(filter %.bpf.c,$^) -o $@
 
-LINKED_SKELS := xdp_router_ipv4.skel.h tc_sch_fq.skel.h
+LINKED_SKELS := xdp_router_ipv4.skel.h tc_sch_fq.skel.h tc_sch_netem.skel.h
 clean-files += $(LINKED_SKELS)
 
 xdp_router_ipv4.skel.h-deps := xdp_router_ipv4.bpf.o xdp_sample.bpf.o
 tc_sch_fq.skel.h-deps := tc_sch_fq.bpf.o
+tc_sch_netem.skel.h-deps := tc_sch_netem.bpf.o
 
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.bpf.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
 
diff --git a/samples/bpf/tc_sch_netem.bpf.c b/samples/bpf/tc_sch_netem.bpf.c
new file mode 100644
index 000000000000..b4db382f2c58
--- /dev/null
+++ b/samples/bpf/tc_sch_netem.bpf.c
@@ -0,0 +1,256 @@
+#include "vmlinux.h"
+#include "bpf_experimental.h"
+#include <bpf/bpf_helpers.h>
+
+#define NETEM_DIST_SCALE	8192
+
+#define NS_PER_SEC		1000000000
+
+int q_loss_model = CLG_GILB_ELL;
+unsigned int q_limit = 1000;
+signed long q_latency = 0;
+signed long q_jitter = 0;
+unsigned int q_loss = 1;
+unsigned int q_qlen = 0;
+
+struct crndstate q_loss_cor = {.last = 0, .rho = 0,};
+struct crndstate q_delay_cor = {.last = 0, .rho = 0,};
+
+struct skb_node {
+	u64 tstamp;
+	struct sk_buff __kptr *skb;
+	struct bpf_rb_node node;
+};
+
+struct clg_state {
+	u64 state;
+	u32 a1;
+	u32 a2;
+	u32 a3;
+	u32 a4;
+	u32 a5;
+};
+
+static bool skbn_tstamp_less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	struct skb_node *skb_a;
+	struct skb_node *skb_b;
+
+	skb_a = container_of(a, struct skb_node, node);
+	skb_b = container_of(b, struct skb_node, node);
+
+	return skb_a->tstamp < skb_b->tstamp;
+}
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, __u32);
+	__type(value, struct clg_state);
+	__uint(max_entries, 1);
+} g_clg_state SEC(".maps");
+
+#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
+
+private(A) struct bpf_spin_lock t_root_lock;
+private(A) struct bpf_rb_root t_root __contains(skb_node, node);
+
+struct sk_buff *bpf_skb_acquire(struct sk_buff *p) __ksym;
+void bpf_skb_release(struct sk_buff *p) __ksym;
+u32 bpf_skb_get_hash(struct sk_buff *p) __ksym;
+void bpf_qdisc_set_skb_dequeue(struct sk_buff *p) __ksym;
+
+static __always_inline u32 get_crandom(struct crndstate *state)
+{
+	u64 value, rho;
+	unsigned long answer;
+
+	if (!state || state->rho == 0)	/* no correlation */
+		return bpf_get_prandom_u32();
+
+	value = bpf_get_prandom_u32();
+	rho = (u64)state->rho + 1;
+	answer = (value * ((1ull<<32) - rho) + state->last * rho) >> 32;
+	state->last = answer;
+	return answer;
+}
+
+static __always_inline s64 tabledist(s64 mu, s32 sigma, struct crndstate *state)
+{
+	s64 x;
+	long t;
+	u32 rnd;
+
+	if (sigma == 0)
+		return mu;
+
+	rnd = get_crandom(state);
+
+	/* default uniform distribution */
+	return ((rnd % (2 * (u32)sigma)) + mu) - sigma;
+}
+
+static __always_inline bool loss_gilb_ell(void)
+{
+	struct clg_state *clg;
+	u32 r1, r2, key = 0;
+	bool ret = false;
+
+ 	clg = bpf_map_lookup_elem(&g_clg_state, &key);
+	if (!clg)
+		return false;
+
+	r1 = bpf_get_prandom_u32();
+	r2 = bpf_get_prandom_u32();
+
+	switch (clg->state) {
+	case GOOD_STATE:
+		if (r1 < clg->a1)
+			__sync_val_compare_and_swap(&clg->state,
+						    GOOD_STATE, BAD_STATE);
+		if (r2 < clg->a4)
+			ret = true;
+		break;
+	case BAD_STATE:
+		if (r1 < clg->a2)
+			__sync_val_compare_and_swap(&clg->state,
+						    BAD_STATE, GOOD_STATE);
+		if (r2 > clg->a3)
+			ret = true;
+	}
+
+	return ret;
+}
+
+static __always_inline bool loss_event(void)
+{
+	switch (q_loss_model) {
+	case CLG_RANDOM:
+		return q_loss && q_loss >= get_crandom(&q_loss_cor);
+	case CLG_GILB_ELL:
+		return loss_gilb_ell();
+	}
+
+	return false;
+}
+
+static __always_inline void tfifo_enqueue(struct skb_node *skbn)
+{
+	bpf_spin_lock(&t_root_lock);
+	bpf_rbtree_add(&t_root, &skbn->node, skbn_tstamp_less);
+	bpf_spin_unlock(&t_root_lock);
+}
+
+SEC("qdisc/enqueue")
+int enqueue_prog(struct bpf_qdisc_ctx *ctx)
+{
+	struct sk_buff *old, *skb = ctx->skb;
+	struct skb_node *skbn;
+	int count = 1;
+	s64 delay = 0;
+	u64 now;
+
+	if (loss_event())
+		--count;
+
+	if (count == 0)
+		return SCH_BPF_BYPASS;
+
+	q_qlen++;
+	if (q_qlen > q_limit)
+		return SCH_BPF_DROP;
+
+	skb = bpf_skb_acquire(ctx->skb);
+	skbn = bpf_obj_new(typeof(*skbn));
+	if (!skbn) {
+		bpf_skb_release(skb);
+		return SCH_BPF_DROP;
+	}
+
+	delay = tabledist(q_latency, q_jitter, &q_delay_cor);
+
+	now = bpf_ktime_get_ns();
+
+	skbn->tstamp = now + delay;
+	old = bpf_kptr_xchg(&skbn->skb, skb);
+	if (old)
+		bpf_skb_release(old);
+
+	tfifo_enqueue(skbn);
+	return SCH_BPF_QUEUED;
+}
+
+
+SEC("qdisc/dequeue")
+int dequeue_prog(struct bpf_qdisc_ctx *ctx)
+{
+	struct bpf_rb_node *node = NULL;
+	struct sk_buff *skb = NULL;
+	struct skb_node *skbn;
+	u64 now;
+
+	now = bpf_ktime_get_ns();
+
+	bpf_spin_lock(&t_root_lock);
+	node = bpf_rbtree_first(&t_root);
+	if (!node) {
+		bpf_spin_unlock(&t_root_lock);
+		return SCH_BPF_DROP;
+	}
+
+	skbn = container_of(node, struct skb_node, node);
+	if (skbn->tstamp <= now) {
+		node = bpf_rbtree_remove(&t_root, &skbn->node);
+		bpf_spin_unlock(&t_root_lock);
+
+		if (!node)
+			return SCH_BPF_DROP;
+
+		skbn = container_of(node, struct skb_node, node);
+		skb = bpf_kptr_xchg(&skbn->skb, skb);
+		if (!skb) {
+			bpf_obj_drop(skbn);
+			return SCH_BPF_DROP;
+		}
+
+		bpf_qdisc_set_skb_dequeue(skb);
+		bpf_obj_drop(skbn);
+
+		q_qlen--;
+		return SCH_BPF_DEQUEUED;
+	}
+
+	ctx->expire = skbn->tstamp;
+	bpf_spin_unlock(&t_root_lock);
+	return SCH_BPF_THROTTLE;
+}
+
+static int reset_queue(u32 index, void *ctx)
+{
+	struct bpf_rb_node *node = NULL;
+	struct skb_node *skbn;
+
+	bpf_spin_lock(&t_root_lock);
+	node = bpf_rbtree_first(&t_root);
+	if (!node) {
+		bpf_spin_unlock(&t_root_lock);
+		return 1;
+	}
+
+	skbn = container_of(node, struct skb_node, node);
+	node = bpf_rbtree_remove(&t_root, &skbn->node);
+	bpf_spin_unlock(&t_root_lock);
+
+	if (!node)
+		return 1;
+
+	skbn = container_of(node, struct skb_node, node);
+	bpf_obj_drop(skbn);
+	return 0;
+}
+
+SEC("qdisc/reset")
+void reset_prog(struct bpf_qdisc_ctx *ctx)
+{
+	bpf_loop(q_limit, reset_queue, NULL, 0);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/samples/bpf/tc_sch_netem.c b/samples/bpf/tc_sch_netem.c
new file mode 100644
index 000000000000..918d626909d3
--- /dev/null
+++ b/samples/bpf/tc_sch_netem.c
@@ -0,0 +1,347 @@
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <signal.h>
+#include <time.h>
+#include <limits.h>
+#include <sys/stat.h>
+
+#include <libmnl/libmnl.h>
+#include <linux/bpf.h>
+#include <linux/pkt_sched.h>
+#include <linux/rtnetlink.h>
+#include <net/if.h>
+
+struct crndstate {
+	__u32 last;
+	__u32 rho;
+};
+
+struct clg_state {
+	__u64 state;
+	__u32 a1;
+	__u32 a2;
+	__u32 a3;
+	__u32 a4;
+	__u32 a5;
+};
+
+#include "tc_sch_netem.skel.h"
+
+static int libbpf_print_fn(enum libbpf_print_level level, const char *format,
+			   va_list args)
+{
+	return vprintf(format, args);
+}
+
+#define TCA_BUF_MAX (64 * 1024)
+#define FILTER_NAMESZ 16
+
+bool cleanup;
+unsigned int ifindex;
+unsigned int handle = 0x8000000;
+unsigned int parent = TC_H_ROOT;
+struct mnl_socket *nl;
+
+static void usage(const char *cmd)
+{
+	printf("Attach a netem eBPF qdisc and optionally an EDT rate limiter.\n");
+	printf("Usage: %s [...]\n", cmd);
+	printf("	-d <device>	Device\n");
+	printf("	-h <handle>	Qdisc handle\n");
+	printf("	-p <parent>	Parent Qdisc handle\n");
+	printf("	-s		Share a global Gilbert-Elliot state mahine\n");
+	printf("	-c		Delete the qdisc before quit\n");
+	printf("	-v		Verbose\n");
+}
+
+static int get_tc_classid(__u32 *h, const char *str)
+{
+	unsigned long maj, min;
+	char *p;
+
+	maj = TC_H_ROOT;
+	if (strcmp(str, "root") == 0)
+		goto ok;
+	maj = TC_H_UNSPEC;
+	if (strcmp(str, "none") == 0)
+		goto ok;
+	maj = strtoul(str, &p, 16);
+	if (p == str) {
+		maj = 0;
+		if (*p != ':')
+			return -1;
+	}
+	if (*p == ':') {
+		if (maj >= (1<<16))
+			return -1;
+		maj <<= 16;
+		str = p+1;
+		min = strtoul(str, &p, 16);
+		if (*p != 0)
+			return -1;
+		if (min >= (1<<16))
+			return -1;
+		maj |= min;
+	} else if (*p != 0)
+		return -1;
+
+ok:
+	*h = maj;
+	return 0;
+}
+
+static int get_qdisc_handle(__u32 *h, const char *str)
+{
+	__u32 maj;
+	char *p;
+
+	maj = TC_H_UNSPEC;
+	if (strcmp(str, "none") == 0)
+		goto ok;
+	maj = strtoul(str, &p, 16);
+	if (p == str || maj >= (1 << 16))
+		return -1;
+	maj <<= 16;
+	if (*p != ':' && *p != 0)
+		return -1;
+ok:
+	*h = maj;
+	return 0;
+}
+
+static void sigdown(int signo)
+{
+	struct {
+		struct nlmsghdr n;
+		struct tcmsg t;
+		char buf[TCA_BUF_MAX];
+	} req = {
+		.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct tcmsg)),
+		.n.nlmsg_flags = NLM_F_REQUEST,
+		.n.nlmsg_type = RTM_DELQDISC,
+		.t.tcm_family = AF_UNSPEC,
+	};
+
+	if (!cleanup)
+		exit(0);
+
+	req.n.nlmsg_seq = time(NULL);
+	req.t.tcm_ifindex = ifindex;
+	req.t.tcm_parent = parent;
+	req.t.tcm_handle = handle;
+
+	if (mnl_socket_sendto(nl, &req.n, req.n.nlmsg_len) < 0)
+		exit(1);
+
+	exit(0);
+}
+
+static int qdisc_add_tc_sch_netem(struct tc_sch_netem *skel)
+{
+	char qdisc_type[FILTER_NAMESZ] = "bpf";
+	char buf[MNL_SOCKET_BUFFER_SIZE];
+	struct rtattr *option_attr;
+	const char *qdisc_name;
+	char prog_name[256];
+	int ret;
+	unsigned int seq, portid;
+	struct {
+		struct nlmsghdr n;
+		struct tcmsg t;
+		char buf[TCA_BUF_MAX];
+	} req = {
+		.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct tcmsg)),
+		.n.nlmsg_flags = NLM_F_REQUEST | NLM_F_EXCL | NLM_F_CREATE,
+		.n.nlmsg_type = RTM_NEWQDISC,
+		.t.tcm_family = AF_UNSPEC,
+	};
+
+	seq = time(NULL);
+	portid = mnl_socket_get_portid(nl);
+
+	qdisc_name = bpf_object__name(skel->obj);
+
+	req.t.tcm_ifindex = ifindex;
+	req.t.tcm_parent = parent;
+	req.t.tcm_handle = handle;
+	mnl_attr_put_str(&req.n, TCA_KIND, qdisc_type);
+
+	// eBPF Qdisc specific attributes
+	option_attr = (struct rtattr *)mnl_nlmsg_get_payload_tail(&req.n);
+	mnl_attr_put(&req.n, TCA_OPTIONS, 0, NULL);
+	mnl_attr_put_u32(&req.n, TCA_SCH_BPF_ENQUEUE_PROG_FD,
+			 bpf_program__fd(skel->progs.enqueue_prog));
+	snprintf(prog_name, sizeof(prog_name), "%s_enqueue", qdisc_name);
+	mnl_attr_put(&req.n, TCA_SCH_BPF_ENQUEUE_PROG_NAME, strlen(prog_name) + 1, prog_name);
+
+	mnl_attr_put_u32(&req.n, TCA_SCH_BPF_DEQUEUE_PROG_FD,
+			 bpf_program__fd(skel->progs.dequeue_prog));
+	snprintf(prog_name, sizeof(prog_name), "%s_dequeue", qdisc_name);
+	mnl_attr_put(&req.n, TCA_SCH_BPF_DEQUEUE_PROG_NAME, strlen(prog_name) + 1, prog_name);
+
+	mnl_attr_put_u32(&req.n, TCA_SCH_BPF_RESET_PROG_FD,
+			 bpf_program__fd(skel->progs.reset_prog));
+	snprintf(prog_name, sizeof(prog_name), "%s_reset", qdisc_name);
+	mnl_attr_put(&req.n, TCA_SCH_BPF_RESET_PROG_NAME, strlen(prog_name) + 1, prog_name);
+
+	option_attr->rta_len = (void *)mnl_nlmsg_get_payload_tail(&req.n) -
+			       (void *)option_attr;
+
+	if (mnl_socket_sendto(nl, &req.n, req.n.nlmsg_len) < 0) {
+		perror("mnl_socket_sendto");
+		return -1;
+	}
+
+	for (;;) {
+		ret = mnl_socket_recvfrom(nl, buf, sizeof(buf));
+		if (ret == -1) {
+			if (errno == ENOBUFS || errno == EINTR)
+				continue;
+
+			if (errno == EAGAIN) {
+				errno = 0;
+				ret = 0;
+				break;
+			}
+
+			perror("mnl_socket_recvfrom");
+			return -1;
+		}
+
+		ret = mnl_cb_run(buf, ret, seq, portid, NULL, NULL);
+		if (ret < 0) {
+			perror("mnl_cb_run");
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, opts, .kernel_log_level = 2);
+	bool verbose = false, share = false, state_init = false;
+	struct tc_sch_netem *skel = NULL;
+	struct clg_state state = {};
+	struct stat stat_buf = {};
+	int opt, ret = 1, key = 0;
+	char d[IFNAMSIZ] = "lo";
+	struct sigaction sa = {
+		.sa_handler = sigdown,
+	};
+
+	while ((opt = getopt(argc, argv, "d:h:p:csv")) != -1) {
+		switch (opt) {
+		/* General args */
+		case 'd':
+			strncpy(d, optarg, sizeof(d)-1);
+			break;
+		case 'h':
+			ret = get_qdisc_handle(&handle, optarg);
+			if (ret) {
+				printf("Invalid qdisc handle\n");
+				return 1;
+			}
+			break;
+		case 'p':
+			ret = get_tc_classid(&parent, optarg);
+			if (ret) {
+				printf("Invalid parent qdisc handle\n");
+				return 1;
+			}
+			break;
+		case 'c':
+			cleanup = true;
+			break;
+		case 's':
+			share = true;
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			usage(argv[0]);
+			return 1;
+		}
+	}
+
+	nl = mnl_socket_open(NETLINK_ROUTE);
+	if (!nl) {
+		perror("mnl_socket_open");
+		return 1;
+	}
+
+	ret = mnl_socket_bind(nl, 0, MNL_SOCKET_AUTOPID);
+	if (ret < 0) {
+		perror("mnl_socket_bind");
+		ret = 1;
+		goto out;
+	}
+
+	ifindex = if_nametoindex(d);
+	if (errno == ENODEV) {
+		fprintf(stderr, "No such device: %s\n", d);
+		goto out;
+	}
+
+	if (sigaction(SIGINT, &sa, NULL) || sigaction(SIGTERM, &sa, NULL))
+		goto out;
+
+	if (verbose)
+		libbpf_set_print(libbpf_print_fn);
+
+	skel = tc_sch_netem__open_opts(&opts);
+	if (!skel) {
+		perror("Failed to open tc_sch_netem");
+		goto out;
+	}
+
+	if (share) {
+		if (stat("/sys/fs/bpf/tc", &stat_buf) == -1)
+			mkdir("/sys/fs/bpf/tc", 0700);
+
+		mkdir("/sys/fs/bpf/tc/globals", 0700);
+
+		bpf_map__set_pin_path(skel->maps.g_clg_state, "/sys/fs/bpf/tc/globals/g_clg_state");
+	}
+
+	ret = tc_sch_netem__load(skel);
+	if (ret) {
+		perror("Failed to load tc_sch_netem");
+		ret = 1;
+		goto out_destroy;
+	}
+
+	if (!state_init) {
+		state.state = 1;
+		state.a1 = (double)UINT_MAX * 0.05;
+		state.a2 = (double)UINT_MAX * 0.95;
+		state.a3 = (double)UINT_MAX * 0.30;
+		state.a4 = (double)UINT_MAX * 0.001;
+
+		bpf_map__update_elem(skel->maps.g_clg_state, &key, sizeof(key), &state,
+				     sizeof(state), 0);
+
+		state_init = true;
+	}
+
+	ret = qdisc_add_tc_sch_netem(skel);
+	if (ret < 0) {
+		perror("Failed to create qdisc");
+		ret = 1;
+		goto out_destroy;
+	}
+
+	for (;;)
+		pause();
+
+out_destroy:
+	tc_sch_netem__destroy(skel);
+out:
+	mnl_socket_close(nl);
+	return ret;
+}
-- 
2.20.1


