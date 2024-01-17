Return-Path: <bpf+bounces-19757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C506830EEB
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 22:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D47BEB22C7A
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 21:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B8F28E21;
	Wed, 17 Jan 2024 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YM6c7n/N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A8628DDF;
	Wed, 17 Jan 2024 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705528595; cv=none; b=O2W3Uxe+BnHFPING9cu5ZaAd1nmBlxOUX/2C3mca+l4rMmp4ptDEOAAQO5rabTtExhfsTOgIKcbyWSh7Pg9jhO+OYXOUqnMbU1WpQLrMwzQpDbzgmSJgzMA01FLVIfEBon3wgNLZ7pcoKV88LrypQ70XVSHdJ+ZcVwohJ0dawDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705528595; c=relaxed/simple;
	bh=wQY48SIKA2UxhFI2tKp7oxzy5oRHlrmQrWcv+tN4YUs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=DJ+CGAdxtt3sfRcKWTZqHj2F1EzGqjSqueOikbc4y2jwk4WIoOKO0ySxoRCuwzpCir4JsXWdGmE6Isekp4D8SI0xb3YxOvjWpvoDl2Afmf+43KUrecckKXe8yNhfEi+u8HhMJ47vV2GSTutwtSs3On/VqcTKVM79ngrbqj/VekI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YM6c7n/N; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42987bc95ffso77343321cf.1;
        Wed, 17 Jan 2024 13:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705528592; x=1706133392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoqdlFLSzLJnoY4US3wycGoYv6Oytnxns+gjaHrwdsw=;
        b=YM6c7n/NbKKUR0qPlrcHNHsWqgKSZPiVYX81b7OTy96L8UuFhWQBOR+epLi3ozWLzC
         jp2KUR9IOjD3vRQaf6EAd3CXdzag8w2qzNFx1NwlVdgdjjJSCBXn5W3aYpQnDF+64qq6
         ZpdBo9SbtlnTu8few0tJjQbQEyYqC150p0+4lLATTiGwAXPZdTupEeoBbQoruFkrX6I9
         SWaJDLFgO00aI2k3vShMniY7a0wsRW4nUgqiQ//Vd6Jaxvyc1Lx3sqhaGZ3aOLq/V5IJ
         aCUSoF5C4okaOLLPMga0Zh1VJJHwHMlOx87BzMPj/PuN5X/GI32+f2ZkJtFoswqPD3C4
         BSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705528592; x=1706133392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VoqdlFLSzLJnoY4US3wycGoYv6Oytnxns+gjaHrwdsw=;
        b=Vi/0P/tLxdSEgYRDDcY/utAV76W2cDPTT1+uTANFOG/bHo9V/anfNwSvWXXjP8Qz70
         33whE9SdJAjwJX2DzmDhu+EctLA+V+J9VDDZoIIn80dg7Virk30rCodUHyYGuXU/69A3
         OBOoMNXZW696FaJaPFLeMi+ke8WG8XU5oirdyvgpyLQZUJS4hvizl2cf3nBpqq1ppaK/
         tPm/wpMDEQusiWCnfv1lW7tKZfctbzSFuC2UzlBPtHWD9V/9HOL2B8JOwZpAR6rinwsS
         JmEJJID5XEa5zdXMgTDDkEoQa2tdFXl37tU4/o3IQIO1doLA1pd3AuSbOIvWri4HGLKv
         Va3Q==
X-Gm-Message-State: AOJu0Yxztun2OMl28U3/SvySA4rbAC4t1OELWxnCs2Yl7cJs++easj8g
	RFW2Jb1hw2RS/wfv73gl8R3Xrz39Abo=
X-Google-Smtp-Source: AGHT+IFw2KK9VwGZag3izSgz1uIrClcYwhg4G1dY4teWBFC/W+78/Rgf5RO0gvIEQNIO4e8+gatpzg==
X-Received: by 2002:a05:622a:44:b0:429:fa91:f0 with SMTP id y4-20020a05622a004400b00429fa9100f0mr5248369qtw.23.1705528591973;
        Wed, 17 Jan 2024 13:56:31 -0800 (PST)
Received: from n36-183-057.byted.org ([147.160.184.91])
        by smtp.gmail.com with ESMTPSA id hj11-20020a05622a620b00b00428346b88bfsm6105263qtb.65.2024.01.17.13.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 13:56:31 -0800 (PST)
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
Subject: [RFC PATCH v7 7/8] samples/bpf: Add an example of bpf fq qdisc
Date: Wed, 17 Jan 2024 21:56:23 +0000
Message-Id: <52a0e08033292a88865aab37b0b3bd294b93e13c.1705432850.git.amery.hung@bytedance.com>
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

tc_sch_fq.bpf.c
A simple bpf fair queueing (fq) qdisc that gives each flow a euqal chance
to transmit data. The qdisc respects the timestamp in a skb set by an
clsact rate limiter. It can also inform the rate limiter about packet drop
when enabled to adjust timestamps. The implementation does not prevent hash
collision of flows nor does it recycle flows.

tc_sch_fq.c
A user space program to load and attach the eBPF-based fq qdisc, which
by default add the bpf fq to the loopback device, but can also add to other
dev and class with '-d' and '-p' options.

To test the bpf fq qdisc with the EDT rate limiter:
$ tc qdisc add dev lo clsact
$ tc filter add dev lo egress bpf obj tc_clsact_edt.bpf.o sec classifier
$ ./tc_sch_fq -s

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 samples/bpf/Makefile            |   8 +-
 samples/bpf/bpf_experimental.h  | 134 +++++++
 samples/bpf/tc_clsact_edt.bpf.c | 103 +++++
 samples/bpf/tc_sch_fq.bpf.c     | 666 ++++++++++++++++++++++++++++++++
 samples/bpf/tc_sch_fq.c         | 321 +++++++++++++++
 5 files changed, 1231 insertions(+), 1 deletion(-)
 create mode 100644 samples/bpf/bpf_experimental.h
 create mode 100644 samples/bpf/tc_clsact_edt.bpf.c
 create mode 100644 samples/bpf/tc_sch_fq.bpf.c
 create mode 100644 samples/bpf/tc_sch_fq.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 933f6c3fe6b0..ea516a00352d 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -46,6 +46,7 @@ tprogs-y += xdp_fwd
 tprogs-y += task_fd_query
 tprogs-y += ibumad
 tprogs-y += hbm
+tprogs-y += tc_sch_fq
 
 # Libbpf dependencies
 LIBBPF_SRC = $(TOOLS_PATH)/lib/bpf
@@ -98,6 +99,7 @@ ibumad-objs := ibumad_user.o
 hbm-objs := hbm.o $(CGROUP_HELPERS)
 
 xdp_router_ipv4-objs := xdp_router_ipv4_user.o $(XDP_SAMPLE)
+tc_sch_fq-objs := tc_sch_fq.o
 
 # Tell kbuild to always build the programs
 always-y := $(tprogs-y)
@@ -149,6 +151,7 @@ always-y += task_fd_query_kern.o
 always-y += ibumad_kern.o
 always-y += hbm_out_kern.o
 always-y += hbm_edt_kern.o
+always-y += tc_sch_fq.bpf.o
 
 TPROGS_CFLAGS = $(TPROGS_USER_CFLAGS)
 TPROGS_LDFLAGS = $(TPROGS_USER_LDFLAGS)
@@ -195,6 +198,7 @@ TPROGLDLIBS_tracex4		+= -lrt
 TPROGLDLIBS_trace_output	+= -lrt
 TPROGLDLIBS_map_perf_test	+= -lrt
 TPROGLDLIBS_test_overhead	+= -lrt
+TPROGLDLIBS_tc_sch_fq		+= -lmnl
 
 # Allows pointing LLC/CLANG to a LLVM backend with bpf support, redefine on cmdline:
 # make M=samples/bpf LLC=~/git/llvm-project/llvm/build/bin/llc CLANG=~/git/llvm-project/llvm/build/bin/clang
@@ -306,6 +310,7 @@ $(obj)/$(TRACE_HELPERS) $(obj)/$(CGROUP_HELPERS) $(obj)/$(XDP_SAMPLE): | libbpf_
 .PHONY: libbpf_hdrs
 
 $(obj)/xdp_router_ipv4_user.o: $(obj)/xdp_router_ipv4.skel.h
+$(obj)/tc_sch_fq.o: $(obj)/tc_sch_fq.skel.h
 
 $(obj)/tracex5.bpf.o: $(obj)/syscall_nrs.h
 $(obj)/hbm_out_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
@@ -370,10 +375,11 @@ $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h $(src)/x
 		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
 		-c $(filter %.bpf.c,$^) -o $@
 
-LINKED_SKELS := xdp_router_ipv4.skel.h
+LINKED_SKELS := xdp_router_ipv4.skel.h tc_sch_fq.skel.h
 clean-files += $(LINKED_SKELS)
 
 xdp_router_ipv4.skel.h-deps := xdp_router_ipv4.bpf.o xdp_sample.bpf.o
+tc_sch_fq.skel.h-deps := tc_sch_fq.bpf.o
 
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.bpf.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
 
diff --git a/samples/bpf/bpf_experimental.h b/samples/bpf/bpf_experimental.h
new file mode 100644
index 000000000000..fc39063e0322
--- /dev/null
+++ b/samples/bpf/bpf_experimental.h
@@ -0,0 +1,134 @@
+#ifndef __BPF_EXPERIMENTAL__
+#define __BPF_EXPERIMENTAL__
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+
+#define __contains(name, node) __attribute__((btf_decl_tag("contains:" #name ":" #node)))
+
+/* Description
+ *	Allocates an object of the type represented by 'local_type_id' in
+ *	program BTF. User may use the bpf_core_type_id_local macro to pass the
+ *	type ID of a struct in program BTF.
+ *
+ *	The 'local_type_id' parameter must be a known constant.
+ *	The 'meta' parameter is rewritten by the verifier, no need for BPF
+ *	program to set it.
+ * Returns
+ *	A pointer to an object of the type corresponding to the passed in
+ *	'local_type_id', or NULL on failure.
+ */
+extern void *bpf_obj_new_impl(__u64 local_type_id, void *meta) __ksym;
+
+/* Convenience macro to wrap over bpf_obj_new_impl */
+#define bpf_obj_new(type) ((type *)bpf_obj_new_impl(bpf_core_type_id_local(type), NULL))
+
+/* Description
+ *	Free an allocated object. All fields of the object that require
+ *	destruction will be destructed before the storage is freed.
+ *
+ *	The 'meta' parameter is rewritten by the verifier, no need for BPF
+ *	program to set it.
+ * Returns
+ *	Void.
+ */
+extern void bpf_obj_drop_impl(void *kptr, void *meta) __ksym;
+
+/* Convenience macro to wrap over bpf_obj_drop_impl */
+#define bpf_obj_drop(kptr) bpf_obj_drop_impl(kptr, NULL)
+
+/* Description
+ *	Increment the refcount on a refcounted local kptr, turning the
+ *	non-owning reference input into an owning reference in the process.
+ *
+ *	The 'meta' parameter is rewritten by the verifier, no need for BPF
+ *	program to set it.
+ * Returns
+ *	An owning reference to the object pointed to by 'kptr'
+ */
+extern void *bpf_refcount_acquire_impl(void *kptr, void *meta) __ksym;
+
+/* Convenience macro to wrap over bpf_refcount_acquire_impl */
+#define bpf_refcount_acquire(kptr) bpf_refcount_acquire_impl(kptr, NULL)
+
+/* Description
+ *	Add a new entry to the beginning of the BPF linked list.
+ *
+ *	The 'meta' and 'off' parameters are rewritten by the verifier, no need
+ *	for BPF programs to set them
+ * Returns
+ *	0 if the node was successfully added
+ *	-EINVAL if the node wasn't added because it's already in a list
+ */
+extern int bpf_list_push_front_impl(struct bpf_list_head *head,
+				    struct bpf_list_node *node,
+				    void *meta, __u64 off) __ksym;
+
+/* Convenience macro to wrap over bpf_list_push_front_impl */
+#define bpf_list_push_front(head, node) bpf_list_push_front_impl(head, node, NULL, 0)
+
+/* Description
+ *	Add a new entry to the end of the BPF linked list.
+ *
+ *	The 'meta' and 'off' parameters are rewritten by the verifier, no need
+ *	for BPF programs to set them
+ * Returns
+ *	0 if the node was successfully added
+ *	-EINVAL if the node wasn't added because it's already in a list
+ */
+extern int bpf_list_push_back_impl(struct bpf_list_head *head,
+				   struct bpf_list_node *node,
+				   void *meta, __u64 off) __ksym;
+
+/* Convenience macro to wrap over bpf_list_push_back_impl */
+#define bpf_list_push_back(head, node) bpf_list_push_back_impl(head, node, NULL, 0)
+
+/* Description
+ *	Remove the entry at the beginning of the BPF linked list.
+ * Returns
+ *	Pointer to bpf_list_node of deleted entry, or NULL if list is empty.
+ */
+extern struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head) __ksym;
+
+/* Description
+ *	Remove the entry at the end of the BPF linked list.
+ * Returns
+ *	Pointer to bpf_list_node of deleted entry, or NULL if list is empty.
+ */
+extern struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head) __ksym;
+
+/* Description
+ *	Remove 'node' from rbtree with root 'root'
+ * Returns
+ * 	Pointer to the removed node, or NULL if 'root' didn't contain 'node'
+ */
+extern struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
+					     struct bpf_rb_node *node) __ksym;
+
+/* Description
+ *	Add 'node' to rbtree with root 'root' using comparator 'less'
+ *
+ *	The 'meta' and 'off' parameters are rewritten by the verifier, no need
+ *	for BPF programs to set them
+ * Returns
+ *	0 if the node was successfully added
+ *	-EINVAL if the node wasn't added because it's already in a tree
+ */
+extern int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *node,
+			       bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b),
+			       void *meta, __u64 off) __ksym;
+
+/* Convenience macro to wrap over bpf_rbtree_add_impl */
+#define bpf_rbtree_add(head, node, less) bpf_rbtree_add_impl(head, node, less, NULL, 0)
+
+/* Description
+ *	Return the first (leftmost) node in input tree
+ * Returns
+ *	Pointer to the node, which is _not_ removed from the tree. If the tree
+ *	contains no nodes, returns NULL.
+ */
+extern struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root) __ksym;
+
+#endif
diff --git a/samples/bpf/tc_clsact_edt.bpf.c b/samples/bpf/tc_clsact_edt.bpf.c
new file mode 100644
index 000000000000..f0b2ea84028d
--- /dev/null
+++ b/samples/bpf/tc_clsact_edt.bpf.c
@@ -0,0 +1,103 @@
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+#define ETH_P_IP	0x0800
+#define TC_ACT_OK	0
+#define NS_PER_SEC	1000000000ULL
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, __u32);
+	__type(value, __u64);
+	__uint(pinning, LIBBPF_PIN_BY_NAME);
+	__uint(max_entries, 16);
+} rate_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 16);
+	__type(key, u32);
+	__type(value, u64);
+	__uint(pinning, LIBBPF_PIN_BY_NAME);
+} tstamp_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 16);
+	__type(key, u32);
+	__type(value, u64);
+	__uint(pinning, LIBBPF_PIN_BY_NAME);
+} comp_map SEC(".maps");
+
+u64 last_ktime = 0;
+
+SEC("classifier")
+int prog(struct __sk_buff *skb)
+{
+	void *data_end = (void *)(unsigned long long)skb->data_end;
+	u64 *rate, *tstamp, delay_ns, tstamp_comp, tstamp_new, *comp, comp_ns, now, init_rate = 12500000;    /* 100 Mbits/sec */
+	void *data = (void *)(unsigned long long)skb->data;
+	struct iphdr *ip = data + sizeof(struct ethhdr);
+	struct ethhdr *eth = data;
+	u64 len = skb->len;
+	long ret;
+	u64 zero = 0;
+
+	now = bpf_ktime_get_ns();
+
+	if (data + sizeof(struct ethhdr) > data_end)
+		return TC_ACT_OK;
+	if (skb->protocol != bpf_htons(ETH_P_IP))
+		return TC_ACT_OK;
+	if (data + sizeof(struct ethhdr) + sizeof(struct iphdr) > data_end)
+		return TC_ACT_OK;
+
+	rate = bpf_map_lookup_elem(&rate_map, &ip->daddr);
+	if (!rate) {
+		bpf_map_update_elem(&rate_map, &ip->daddr, &init_rate, BPF_ANY);
+		bpf_map_update_elem(&tstamp_map, &ip->daddr, &now, BPF_ANY);
+		bpf_map_update_elem(&comp_map, &ip->daddr, &zero, BPF_ANY);
+		return TC_ACT_OK;
+	}
+
+	delay_ns = skb->len * NS_PER_SEC / (*rate);
+
+	tstamp = bpf_map_lookup_elem(&tstamp_map, &ip->daddr);
+	if (!tstamp)	/* unlikely */
+		return TC_ACT_OK;
+
+	comp = bpf_map_lookup_elem(&comp_map, &ip->daddr);
+	if (!comp)	/* unlikely */
+		return TC_ACT_OK;
+
+	// Reset comp and tstamp when idle
+	if (now - last_ktime > 1000000000) {
+		__sync_lock_test_and_set(comp, 0);
+		__sync_lock_test_and_set(tstamp, now);
+	}
+	last_ktime = now;
+
+	comp_ns = __sync_lock_test_and_set(comp, 0);
+	tstamp_comp = *tstamp - comp_ns;
+	if (tstamp_comp < now) {
+		tstamp_new = tstamp_comp + delay_ns;
+		if (tstamp_new < now) {
+			__sync_fetch_and_add(comp, now - tstamp_new);
+			__sync_lock_test_and_set(tstamp, now);
+		} else {
+			__sync_fetch_and_sub(tstamp, comp_ns);
+			__sync_fetch_and_add(tstamp, delay_ns);
+		}
+		skb->tstamp = now;
+		return TC_ACT_OK;
+	}
+
+	__sync_fetch_and_sub(tstamp, comp_ns);
+	skb->tstamp = *tstamp;
+	__sync_fetch_and_add(tstamp, delay_ns);
+
+	return TC_ACT_OK;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/samples/bpf/tc_sch_fq.bpf.c b/samples/bpf/tc_sch_fq.bpf.c
new file mode 100644
index 000000000000..b2287ea3e2b2
--- /dev/null
+++ b/samples/bpf/tc_sch_fq.bpf.c
@@ -0,0 +1,666 @@
+#include "vmlinux.h"
+#include "bpf_experimental.h"
+#include <bpf/bpf_helpers.h>
+
+#define TC_PRIO_CONTROL  7
+#define TC_PRIO_MAX  15
+
+#define NS_PER_SEC 1000000000
+#define PSCHED_MTU (64 * 1024 + 14)
+
+#define NUM_QUEUE_LOG 10
+#define NUM_QUEUE (1 << NUM_QUEUE_LOG)
+#define PRIO_QUEUE (NUM_QUEUE + 1)
+#define COMP_DROP_PKT_DELAY 1
+#define THROTTLED 0xffffffffffffffff
+
+/* fq configuration */
+__u64 q_flow_refill_delay = 40 * 10000; //40us
+__u64 q_horizon = NS_PER_SEC * 10ULL;
+__u32 q_initial_quantum = 10 * PSCHED_MTU;
+__u32 q_quantum = 2 * PSCHED_MTU;
+__u32 q_orphan_mask = 1023;
+__u32 q_flow_plimit = 100;
+__u32 q_plimit = 10000;
+bool q_horizon_drop = true;
+
+bool q_compensate_tstamp;
+bool q_random_drop;
+
+unsigned long time_next_delayed_flow = ~0ULL;
+unsigned long unthrottle_latency_ns = 0ULL;
+unsigned long ktime_cache = 0;
+unsigned long dequeue_now;
+unsigned int fq_qlen = 0;
+
+struct fq_cb {
+	u32 plen;
+};
+
+struct skb_node {
+	u64 tstamp;
+	struct sk_buff __kptr *skb;
+	struct bpf_rb_node node;
+};
+
+struct fq_flow_node {
+	u32 hash;
+	int credit;
+	u32 qlen;
+	u32 socket_hash;
+	u64 age;
+	u64 time_next_packet;
+	struct bpf_list_node list_node;
+	struct bpf_rb_node rb_node;
+	struct bpf_rb_root queue __contains(skb_node, node);
+	struct bpf_spin_lock lock;
+	struct bpf_refcount refcount;
+};
+
+struct dequeue_nonprio_ctx {
+	bool dequeued;
+	u64 expire;
+};
+
+struct fq_stashed_flow {
+	struct fq_flow_node __kptr *flow;
+};
+
+/* [NUM_QUEUE] for TC_PRIO_CONTROL
+ * [0, NUM_QUEUE - 1] for other flows
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, __u32);
+	__type(value, struct fq_stashed_flow);
+	__uint(max_entries, NUM_QUEUE + 1);
+} fq_stashed_flows SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, __u32);
+	__type(value, __u64);
+	__uint(pinning, LIBBPF_PIN_BY_NAME);
+	__uint(max_entries, 16);
+} rate_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, __u32);
+	__type(value, __u64);
+	__uint(pinning, LIBBPF_PIN_BY_NAME);
+	__uint(max_entries, 16);
+} comp_map SEC(".maps");
+
+#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
+
+private(A) struct bpf_spin_lock fq_delayed_lock;
+private(A) struct bpf_rb_root fq_delayed __contains(fq_flow_node, rb_node);
+
+private(B) struct bpf_spin_lock fq_new_flows_lock;
+private(B) struct bpf_list_head fq_new_flows __contains(fq_flow_node, list_node);
+
+private(C) struct bpf_spin_lock fq_old_flows_lock;
+private(C) struct bpf_list_head fq_old_flows __contains(fq_flow_node, list_node);
+
+struct sk_buff *bpf_skb_acquire(struct sk_buff *p) __ksym;
+void bpf_skb_release(struct sk_buff *p) __ksym;
+u32 bpf_skb_get_hash(struct sk_buff *p) __ksym;
+void bpf_qdisc_set_skb_dequeue(struct sk_buff *p) __ksym;
+
+static __always_inline bool bpf_kptr_xchg_back(void *map_val, void *ptr)
+{
+	void *ret;
+
+	ret = bpf_kptr_xchg(map_val, ptr);
+	if (ret) { //unexpected
+		bpf_obj_drop(ret);
+		return false;
+	}
+	return true;
+}
+
+static __always_inline int hash64(u64 val, int bits)
+{
+	return val * 0x61C8864680B583EBull >> (64 - bits);
+}
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
+
+static bool fn_time_next_packet_less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	struct fq_flow_node *flow_a;
+	struct fq_flow_node *flow_b;
+
+	flow_a = container_of(a, struct fq_flow_node, rb_node);
+	flow_b = container_of(b, struct fq_flow_node, rb_node);
+
+	return flow_a->time_next_packet < flow_b->time_next_packet;
+}
+
+static __always_inline void
+fq_flows_add_head(struct bpf_list_head *head, struct bpf_spin_lock *lock,
+		  struct fq_flow_node *flow)
+{
+	bpf_spin_lock(lock);
+	bpf_list_push_front(head, &flow->list_node);
+	bpf_spin_unlock(lock);
+}
+
+static __always_inline void
+fq_flows_add_tail(struct bpf_list_head *head, struct bpf_spin_lock *lock,
+		  struct fq_flow_node *flow)
+{
+	bpf_spin_lock(lock);
+	bpf_list_push_back(head, &flow->list_node);
+	bpf_spin_unlock(lock);
+}
+
+static __always_inline bool
+fq_flows_is_empty(struct bpf_list_head *head, struct bpf_spin_lock *lock)
+{
+	struct bpf_list_node *node;
+
+	bpf_spin_lock(lock);
+	node = bpf_list_pop_front(head);
+	if (node) {
+		bpf_list_push_front(head, node);
+		bpf_spin_unlock(lock);
+		return false;
+	}
+	bpf_spin_unlock(lock);
+
+	return true;
+}
+
+static __always_inline void fq_flow_set_detached(struct fq_flow_node *flow)
+{
+	flow->age = bpf_jiffies64();
+	bpf_obj_drop(flow);
+}
+
+static __always_inline bool fq_flow_is_detached(struct fq_flow_node *flow)
+{
+	return flow->age != 0 && flow->age != THROTTLED;
+}
+
+static __always_inline bool fq_flow_is_throttled(struct fq_flow_node *flow)
+{
+	return flow->age != THROTTLED;
+}
+
+static __always_inline bool sk_listener(struct sock *sk)
+{
+	return (1 << sk->__sk_common.skc_state) & (TCPF_LISTEN | TCPF_NEW_SYN_RECV);
+}
+
+static __always_inline int
+fq_classify(struct sk_buff *skb, u32 *hash, struct fq_stashed_flow **sflow,
+	    bool *connected, u32 *sk_hash)
+{
+	struct fq_flow_node *flow;
+	struct sock *sk = skb->sk;
+
+	*connected = false;
+
+	if ((skb->priority & TC_PRIO_MAX) == TC_PRIO_CONTROL) {
+		*hash = PRIO_QUEUE;
+	} else {
+		if (!sk || sk_listener(sk)) {
+			*sk_hash = bpf_skb_get_hash(skb) & q_orphan_mask;
+			*sk_hash = (*sk_hash << 1 | 1);
+		} else if (sk->__sk_common.skc_state == TCP_CLOSE) {
+			*sk_hash = bpf_skb_get_hash(skb) & q_orphan_mask;
+			*sk_hash = (*sk_hash << 1 | 1);
+		} else {
+			*sk_hash = sk->__sk_common.skc_hash;
+			*connected = true;
+		}
+		*hash = hash64(*sk_hash, NUM_QUEUE_LOG);
+	}
+
+	*sflow = bpf_map_lookup_elem(&fq_stashed_flows, hash);
+	if (!*sflow)
+		return -1; //unexpected
+
+	if ((*sflow)->flow)
+		return 0;
+
+	flow = bpf_obj_new(typeof(*flow));
+	if (!flow)
+		return -1;
+
+	flow->hash = *hash;
+	flow->credit = q_initial_quantum;
+	flow->qlen = 0;
+	flow->age = 1UL;
+	flow->time_next_packet = 0;
+
+	bpf_kptr_xchg_back(&(*sflow)->flow, flow);
+
+	return 0;
+}
+
+static __always_inline bool fq_packet_beyond_horizon(struct sk_buff *skb)
+{
+	return (s64)skb->tstamp > (s64)(ktime_cache + q_horizon);
+}
+
+SEC("qdisc/enqueue")
+int enqueue_prog(struct bpf_qdisc_ctx *ctx)
+{
+	struct iphdr *iph = (void *)(long)ctx->skb->data + sizeof(struct ethhdr);
+	u64 time_to_send, jiffies, delay_ns, *comp_ns, *rate;
+	struct fq_flow_node *flow = NULL, *flow_copy;
+	struct sk_buff *skb = ctx->skb;
+	u32 hash, plen, daddr, sk_hash;
+	struct fq_stashed_flow *sflow;
+	struct bpf_rb_node *node;
+	struct skb_node *skbn;
+	void *flow_queue;
+	bool connected;
+
+	if (q_random_drop & (bpf_get_prandom_u32() > ~0U * 0.90))
+		goto drop;
+
+	if (fq_qlen >= q_plimit)
+		goto drop;
+
+	skb = bpf_skb_acquire(ctx->skb);
+	if (!skb->tstamp) {
+		time_to_send = ktime_cache = bpf_ktime_get_ns();
+	} else {
+		if (fq_packet_beyond_horizon(skb)) {
+			ktime_cache = bpf_ktime_get_ns();
+			if (fq_packet_beyond_horizon(skb)) {
+				if (q_horizon_drop)
+					goto rel_skb_and_drop;
+
+				skb->tstamp = ktime_cache + q_horizon;
+			}
+		}
+		time_to_send = skb->tstamp;
+	}
+
+	if (fq_classify(skb, &hash, &sflow, &connected, &sk_hash) < 0)
+		goto rel_skb_and_drop;
+
+	flow = bpf_kptr_xchg(&sflow->flow, flow);
+	if (!flow)
+		goto rel_skb_and_drop; //unexpected
+
+	if (hash != PRIO_QUEUE) {
+		if (connected && flow->socket_hash != sk_hash) {
+			flow->credit = q_initial_quantum;
+			flow->socket_hash = sk_hash;
+			if (fq_flow_is_throttled(flow)) {
+				/* mark the flow as undetached. The reference to the
+				 * throttled flow in fq_delayed will be removed later.
+				 */
+				flow_copy = bpf_refcount_acquire(flow);
+				flow_copy->age = 0;
+				fq_flows_add_tail(&fq_old_flows, &fq_old_flows_lock, flow_copy);
+			}
+			flow->time_next_packet = 0ULL;
+		}
+
+		if (flow->qlen >= q_flow_plimit) {
+			bpf_kptr_xchg_back(&sflow->flow, flow);
+			goto rel_skb_and_drop;
+		}
+
+		if (fq_flow_is_detached(flow)) {
+			if (connected)
+				flow->socket_hash = sk_hash;
+
+			flow_copy = bpf_refcount_acquire(flow);
+
+			jiffies = bpf_jiffies64();
+			if ((s64)(jiffies - (flow_copy->age + q_flow_refill_delay)) > 0) {
+				if (flow_copy->credit < q_quantum)
+					flow_copy->credit = q_quantum;
+			}
+			flow_copy->age = 0;
+			fq_flows_add_tail(&fq_new_flows, &fq_new_flows_lock, flow_copy);
+		}
+	}
+
+	skbn = bpf_obj_new(typeof(*skbn));
+	if (!skbn) {
+		bpf_kptr_xchg_back(&sflow->flow, flow);
+		goto rel_skb_and_drop;
+	}
+
+	skbn->tstamp = time_to_send;
+	skb = bpf_kptr_xchg(&skbn->skb, skb);
+	if (skb)
+		bpf_skb_release(skb);
+
+	bpf_spin_lock(&flow->lock);
+	bpf_rbtree_add(&flow->queue, &skbn->node, skbn_tstamp_less);
+	bpf_spin_unlock(&flow->lock);
+
+	flow->qlen++;
+	bpf_kptr_xchg_back(&sflow->flow, flow);
+
+	fq_qlen++;
+	return SCH_BPF_QUEUED;
+
+rel_skb_and_drop:
+	bpf_skb_release(skb);
+drop:
+	if (q_compensate_tstamp) {
+		bpf_probe_read_kernel(&plen, sizeof(plen), (void *)(ctx->skb->cb));
+		bpf_probe_read_kernel(&daddr, sizeof(daddr), &iph->daddr);
+		rate = bpf_map_lookup_elem(&rate_map, &daddr);
+		comp_ns = bpf_map_lookup_elem(&comp_map, &daddr);
+		if (rate && comp_ns) {
+			delay_ns = (u64)plen * NS_PER_SEC / (*rate);
+			__sync_fetch_and_add(comp_ns, delay_ns);
+		}
+	}
+	return SCH_BPF_DROP;
+}
+
+static int fq_unset_throttled_flows(u32 index, bool *unset_all)
+{
+	struct bpf_rb_node *node = NULL;
+	struct fq_flow_node *flow;
+	u32 hash;
+
+	bpf_spin_lock(&fq_delayed_lock);
+
+	node = bpf_rbtree_first(&fq_delayed);
+	if (!node) {
+		bpf_spin_unlock(&fq_delayed_lock);
+		return 1;
+	}
+
+	flow = container_of(node, struct fq_flow_node, rb_node);
+	if (!*unset_all && flow->time_next_packet > dequeue_now) {
+		time_next_delayed_flow = flow->time_next_packet;
+		bpf_spin_unlock(&fq_delayed_lock);
+		return 1;
+	}
+
+	node = bpf_rbtree_remove(&fq_delayed, &flow->rb_node);
+
+	bpf_spin_unlock(&fq_delayed_lock);
+
+	if (!node)
+		return 1; //unexpected
+
+	flow = container_of(node, struct fq_flow_node, rb_node);
+
+	/* the flow was recycled during enqueue() */
+	if (flow->age != THROTTLED) {
+		bpf_obj_drop(flow);
+		return 0;
+	}
+
+	flow->age = 0;
+	fq_flows_add_tail(&fq_old_flows, &fq_old_flows_lock, flow);
+
+	return 0;
+}
+
+static __always_inline void fq_flow_set_throttled(struct fq_flow_node *flow)
+{
+	flow->age = THROTTLED;
+
+	if (time_next_delayed_flow > flow->time_next_packet)
+		time_next_delayed_flow = flow->time_next_packet;
+
+	bpf_spin_lock(&fq_delayed_lock);
+	bpf_rbtree_add(&fq_delayed, &flow->rb_node, fn_time_next_packet_less);
+	bpf_spin_unlock(&fq_delayed_lock);
+}
+
+static __always_inline void fq_check_throttled(void)
+{
+	bool unset_all = false;
+	unsigned long sample;
+
+	if (time_next_delayed_flow > dequeue_now)
+		return;
+
+	sample = (unsigned long)(dequeue_now - time_next_delayed_flow);
+	unthrottle_latency_ns -= unthrottle_latency_ns >> 3;
+	unthrottle_latency_ns += sample >> 3;
+
+	time_next_delayed_flow = ~0ULL;
+	bpf_loop(NUM_QUEUE, fq_unset_throttled_flows, &unset_all, 0);
+}
+
+static int
+fq_dequeue_nonprio_flows(u32 index, struct dequeue_nonprio_ctx *ctx)
+{
+	u64 time_next_packet, time_to_send;
+	struct skb_node *skbn, *skbn_tbd;
+	struct bpf_rb_node *rb_node;
+	struct sk_buff *skb = NULL;
+	struct bpf_list_head *head;
+	struct bpf_list_node *node;
+	struct bpf_spin_lock *lock;
+	struct fq_flow_node *flow;
+	u32 plen, key = 0;
+	struct fq_cb cb;
+	bool is_empty;
+
+	head = &fq_new_flows;
+	lock = &fq_new_flows_lock;
+	bpf_spin_lock(&fq_new_flows_lock);
+	node = bpf_list_pop_front(&fq_new_flows);
+	bpf_spin_unlock(&fq_new_flows_lock);
+	if (!node) {
+		head = &fq_old_flows;
+		lock = &fq_old_flows_lock;
+		bpf_spin_lock(&fq_old_flows_lock);
+		node = bpf_list_pop_front(&fq_old_flows);
+		bpf_spin_unlock(&fq_old_flows_lock);
+		if (!node) {
+			if (time_next_delayed_flow != ~0ULL)
+				ctx->expire = time_next_delayed_flow;
+			return 1;
+		}
+	}
+
+	flow = container_of(node, struct fq_flow_node, list_node);
+	if (flow->credit <= 0) {
+		flow->credit += q_quantum;
+		fq_flows_add_tail(&fq_old_flows, &fq_old_flows_lock, flow);
+		return 0;
+	}
+
+	bpf_spin_lock(&flow->lock);
+	rb_node = bpf_rbtree_first(&flow->queue);
+	if (!rb_node) {
+		bpf_spin_unlock(&flow->lock);
+		is_empty = fq_flows_is_empty(&fq_old_flows, &fq_old_flows_lock);
+		if (head == &fq_new_flows && !is_empty)
+			fq_flows_add_tail(&fq_old_flows, &fq_old_flows_lock, flow);
+		else
+			fq_flow_set_detached(flow);
+
+		return 0;
+	}
+
+	skbn = container_of(rb_node, struct skb_node, node);
+	time_to_send = skbn->tstamp;
+
+	time_next_packet = (time_to_send > flow->time_next_packet) ?
+		time_to_send : flow->time_next_packet;
+	if (dequeue_now < time_next_packet) {
+		bpf_spin_unlock(&flow->lock);
+		flow->time_next_packet = time_next_packet;
+		fq_flow_set_throttled(flow);
+		return 0;
+	}
+
+	rb_node = bpf_rbtree_remove(&flow->queue, &skbn->node);
+	bpf_spin_unlock(&flow->lock);
+
+	if (!rb_node) {
+		fq_flows_add_tail(head, lock, flow);
+		return 0; //unexpected
+	}
+
+	skbn = container_of(rb_node, struct skb_node, node);
+	skb = bpf_kptr_xchg(&skbn->skb, skb);
+	if (!skb)
+		goto out;
+
+	bpf_probe_read_kernel(&cb, sizeof(cb), skb->cb);
+	plen = cb.plen;
+
+	flow->credit -= plen;
+	flow->qlen--;
+	fq_qlen--;
+
+	ctx->dequeued = true;
+	bpf_qdisc_set_skb_dequeue(skb);
+out:
+	bpf_obj_drop(skbn);
+	fq_flows_add_head(head, lock, flow);
+
+	return 1;
+}
+
+static __always_inline struct sk_buff *fq_dequeue_prio(void)
+{
+	struct fq_flow_node *flow = NULL;
+	struct fq_stashed_flow *sflow;
+	struct sk_buff *skb = NULL;
+	struct bpf_rb_node *node;
+	struct skb_node *skbn;
+	u32 hash = NUM_QUEUE;
+
+	sflow = bpf_map_lookup_elem(&fq_stashed_flows, &hash);
+	if (!sflow)
+		return NULL; //unexpected
+
+	flow = bpf_kptr_xchg(&sflow->flow, flow);
+	if (!flow)
+		return NULL;
+
+	bpf_spin_lock(&flow->lock);
+	node = bpf_rbtree_first(&flow->queue);
+	if (!node) {
+		bpf_spin_unlock(&flow->lock);
+		goto xchg_flow_back;
+	}
+
+	skbn = container_of(node, struct skb_node, node);
+	node = bpf_rbtree_remove(&flow->queue, &skbn->node);
+	bpf_spin_unlock(&flow->lock);
+
+	if (!node)
+		goto xchg_flow_back;
+
+	skbn = container_of(node, struct skb_node, node);
+	skb = bpf_kptr_xchg(&skbn->skb, skb);
+	bpf_obj_drop(skbn);
+	fq_qlen--;
+
+xchg_flow_back:
+	bpf_kptr_xchg_back(&sflow->flow, flow);
+
+	return skb;
+}
+
+SEC("qdisc/dequeue")
+int dequeue_prog(struct bpf_qdisc_ctx *ctx)
+{
+	struct dequeue_nonprio_ctx cb_ctx = {};
+	struct skb_node *skbn = NULL;
+	struct bpf_rb_node *rb_node;
+	struct sk_buff *skb = NULL;
+
+	skb = fq_dequeue_prio();
+	if (skb) {
+		bpf_qdisc_set_skb_dequeue(skb);
+		return SCH_BPF_DEQUEUED;
+	}
+
+	ktime_cache = dequeue_now = bpf_ktime_get_ns();
+	fq_check_throttled();
+	bpf_loop(q_plimit, fq_dequeue_nonprio_flows, &cb_ctx, 0);
+
+	if (cb_ctx.dequeued)
+		return SCH_BPF_DEQUEUED;
+
+	if (cb_ctx.expire) {
+		ctx->expire = cb_ctx.expire;
+		return SCH_BPF_THROTTLE;
+	}
+
+	return SCH_BPF_DROP;
+}
+
+static int
+fq_reset_flows(u32 index, void *ctx)
+{
+	struct bpf_list_head *head;
+	struct bpf_list_node *node;
+	struct bpf_spin_lock *lock;
+	struct fq_flow_node *flow;
+
+	head = &fq_new_flows;
+	lock = &fq_new_flows_lock;
+	bpf_spin_lock(&fq_new_flows_lock);
+	node = bpf_list_pop_front(&fq_new_flows);
+	bpf_spin_unlock(&fq_new_flows_lock);
+	if (!node) {
+		head = &fq_old_flows;
+		lock = &fq_old_flows_lock;
+		bpf_spin_lock(&fq_old_flows_lock);
+		node = bpf_list_pop_front(&fq_old_flows);
+		bpf_spin_unlock(&fq_old_flows_lock);
+		if (!node)
+			return 1;
+	}
+
+	flow = container_of(node, struct fq_flow_node, list_node);
+	bpf_obj_drop(flow);
+
+	return 0;
+}
+
+static int
+fq_reset_stashed_flows(u32 index, void *ctx)
+{
+	struct fq_flow_node *flow = NULL;
+	struct fq_stashed_flow *sflow;
+
+	sflow = bpf_map_lookup_elem(&fq_stashed_flows, &index);
+	if (!sflow)
+		return 0;
+
+	flow = bpf_kptr_xchg(&sflow->flow, flow);
+	if (flow)
+		bpf_obj_drop(flow);
+
+	return 0;
+}
+
+SEC("qdisc/reset")
+void reset_prog(struct bpf_qdisc_ctx *ctx)
+{
+	bool unset_all = true;
+	fq_qlen = 0;
+	bpf_loop(NUM_QUEUE + 1, fq_reset_stashed_flows, NULL, 0);
+	bpf_loop(NUM_QUEUE, fq_reset_flows, NULL, 0);
+	bpf_loop(NUM_QUEUE, fq_unset_throttled_flows, &unset_all, 0);
+	return;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/samples/bpf/tc_sch_fq.c b/samples/bpf/tc_sch_fq.c
new file mode 100644
index 000000000000..0e55d377ea33
--- /dev/null
+++ b/samples/bpf/tc_sch_fq.c
@@ -0,0 +1,321 @@
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <signal.h>
+#include <time.h>
+#include <sys/stat.h>
+
+#include <libmnl/libmnl.h>
+#include <linux/pkt_sched.h>
+#include <linux/rtnetlink.h>
+#include <net/if.h>
+
+#include "tc_sch_fq.skel.h"
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
+	printf("Attach an fq eBPF qdisc and optionally an EDT rate limiter.\n");
+	printf("Usage: %s [...]\n", cmd);
+	printf("	-d <device>	Device\n");
+	printf("	-h <handle>	Qdisc handle\n");
+	printf("	-p <parent>	Parent Qdisc handle\n");
+	printf("	-s		Share packet drop info with the clsact EDT rate limiter\n");
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
+	req.t.tcm_parent = TC_H_ROOT;
+	req.t.tcm_handle = handle;
+
+	if (mnl_socket_sendto(nl, &req.n, req.n.nlmsg_len) < 0)
+		exit(1);
+
+	exit(0);
+}
+
+static int qdisc_add_tc_sch_fq(struct tc_sch_fq *skel)
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
+	bool verbose = false, share = false;
+	struct tc_sch_fq *skel = NULL;
+	struct stat stat_buf = {};
+	char d[IFNAMSIZ] = "lo";
+	int opt, ret = 1;
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
+	skel = tc_sch_fq__open_opts(&opts);
+	if (!skel) {
+		perror("Failed to open tc_sch_fq");
+		goto out;
+	}
+
+	if (share) {
+		if (stat("/sys/fs/bpf/tc", &stat_buf) == -1)
+			mkdir("/sys/fs/bpf/tc", 0700);
+
+		mkdir("/sys/fs/bpf/tc/globals", 0700);
+
+		bpf_map__set_pin_path(skel->maps.rate_map, "/sys/fs/bpf/tc/globals/rate_map");
+		bpf_map__set_pin_path(skel->maps.comp_map, "/sys/fs/bpf/tc/globals/comp_map");
+
+		skel->bss->q_compensate_tstamp = true;
+		skel->bss->q_random_drop = true;
+	}
+
+	ret = tc_sch_fq__load(skel);
+	if (ret) {
+		perror("Failed to load tc_sch_fq");
+		ret = 1;
+		goto out_destroy;
+	}
+
+	ret = qdisc_add_tc_sch_fq(skel);
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
+	tc_sch_fq__destroy(skel);
+out:
+	mnl_socket_close(nl);
+	return ret;
+}
-- 
2.20.1


