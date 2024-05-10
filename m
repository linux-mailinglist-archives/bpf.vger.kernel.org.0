Return-Path: <bpf+bounces-29537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE518C2A9D
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0997C1C21082
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03B780027;
	Fri, 10 May 2024 19:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ha6yA7vm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7835F87D;
	Fri, 10 May 2024 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369069; cv=none; b=knlKHEsDmgRY0ZIrKbJg3lcSd9MD6tg/0uscmJfdMG5z52hnuQBIgE74ie7HvbFUgkx5NNTC4OXa0tPc3fCg1nUqQXqMZYfZGQL1BcpvxMHD8MZXCMFBIzUJSgQP2WA4itB54Z9LHl0LvSAJaIrMLFGgYABs6JnzZ8Ypn94ssio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369069; c=relaxed/simple;
	bh=pNh7tvOl6BykfommEul44M+8qE3CQz31nNxdYKQMe/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A/69uOBbd5VE+oSdcbs7sPDWECK77sNIc5Blq7pp8A5r03doUIRpnYeZTM+o7QJdB+QMK5uVvaDqjFK2cXTk6H1ta3csgdE1uG9itlzZa+Lf++ynQ2N0r1BVzbMDTj8mQiS0Xg8D1nDvzJgiWN4QCbnlvkcqpvFeAOLsqdEA01E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ha6yA7vm; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-434c695ec3dso13861011cf.0;
        Fri, 10 May 2024 12:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715369066; x=1715973866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsw2WtcdY5iX/KGsvWk9j4qZlJKKVnpOsehein5lkWc=;
        b=ha6yA7vmeqD4ekU9vWFyH69zo7UL9TQrFHk3ZdT5X5OnV/wR/B030CasmSzId+iFqi
         iEiPLTngMREgpnY4ebuboNWtZTPC62dG/MgpHQZWhhw6AqtXeXTjE6/WP90biXLEc18o
         2Aig7ty77VMzMpmqm+BRP+RI9NN7ZaL9E592s+rKMf15Fqzft7igfhgKeh27O6lQNx1i
         XyetqShZwsFZE2hpU6+uWc/cX0yL9SKhBfuYdiJBEnwjksN6EyTbyuVdaUiaASAGwqGN
         HdEWWlHPsNPwL+M313lUOul3I/jOhaaypWwVxDf9ojXFYlixL/Gi8n+8CbJ498Wen93e
         EvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715369066; x=1715973866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsw2WtcdY5iX/KGsvWk9j4qZlJKKVnpOsehein5lkWc=;
        b=Du0SJnjnoUaIKjyzUyyzrrwYiJJkoTLhKL5mou64XgTStFyWvCvcCo/dvhtsXDlsEJ
         faqQtsXU4CRo9UnPcEbO7uMRW4YeuGYLZXwpGe9qOmpqHLZmiIYJnezMZowP1HahDzM4
         9Qz2Sp0ka6SJcUofm3wEbb1ihhI/Sr1oZbIchbPvmtVWLxH2L6XkNHQtjCAUwkxsGE5i
         VvBU4c6oR0BA77JzXDg614jhSeg0JsrNPWBnkCeSidSEX4Vc6VNBdYKG2z1F2Ph1tZlv
         HFDIrj9dnWsAHbBrcA5BZCmp97xtAhDvXqJC5khdJqk7m7XYEcfk2og6VQXJylq/rCw5
         F++Q==
X-Gm-Message-State: AOJu0YxFC+myoJXy3BWBNSPw/Hgw0S9bqKWexHznHzNgbcJck/n5NzFG
	nd56jrP486W7pKtgAgfkVWBxQ6IpUVGi/ehdwdGE5UasxI6A+lfeZhhcbA==
X-Google-Smtp-Source: AGHT+IFaSBrw/scnD/dBOVbCLFa27OzZOEgMk0wA4ZAa8fe7taVQbx7RxsYO2ug0iNW3VMcJG2MsOw==
X-Received: by 2002:a05:622a:c4:b0:43a:10cd:9d3 with SMTP id d75a77b69052e-43dfdaba9c2mr42594471cf.11.1715369065800;
        Fri, 10 May 2024 12:24:25 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df5b46a26sm23863251cf.80.2024.05.10.12.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 12:24:25 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [RFC PATCH v8 18/20] selftests: Add a bpf fq qdisc to selftest
Date: Fri, 10 May 2024 19:24:10 +0000
Message-Id: <20240510192412.3297104-19-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240510192412.3297104-1-amery.hung@bytedance.com>
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test implements a more sophisticated qdisc using bpf. The bpf fair-
queueing (fq) qdisc gives each flow an equal chance to transmit data. It
also respects the timestamp of skb for rate limiting. The implementation
does not prevent hash collision of flows nor does it recycle flows.

The bpf fq also takes the chance to communicate packet drop information
with a bpf clsact EDT rate limiter using bpf maps. With the info, the
rate limiter can compenstate the delay caused by packet drops in qdisc
to maintain the throughput.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  24 +
 .../selftests/bpf/progs/bpf_qdisc_fq.c        | 660 ++++++++++++++++++
 2 files changed, 684 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
index 295d0216e70f..394bf5a4adae 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -4,6 +4,7 @@
 
 #include "network_helpers.h"
 #include "bpf_qdisc_fifo.skel.h"
+#include "bpf_qdisc_fq.skel.h"
 
 #ifndef ENOTSUPP
 #define ENOTSUPP 524
@@ -154,8 +155,31 @@ static void test_fifo(void)
 	bpf_qdisc_fifo__destroy(fifo_skel);
 }
 
+static void test_fq(void)
+{
+	struct bpf_qdisc_fq *fq_skel;
+	struct bpf_link *link;
+
+	fq_skel = bpf_qdisc_fq__open_and_load();
+	if (!ASSERT_OK_PTR(fq_skel, "bpf_qdisc_fq__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(fq_skel->maps.fq);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		bpf_qdisc_fq__destroy(fq_skel);
+		return;
+	}
+
+	do_test("bpf_fq");
+
+	bpf_link__destroy(link);
+	bpf_qdisc_fq__destroy(fq_skel);
+}
+
 void test_bpf_qdisc(void)
 {
 	if (test__start_subtest("fifo"))
 		test_fifo();
+	if (test__start_subtest("fq"))
+		test_fq();
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
new file mode 100644
index 000000000000..5118237da9e4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
@@ -0,0 +1,660 @@
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+#include "bpf_qdisc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define NSEC_PER_USEC 1000L
+#define NSEC_PER_SEC 1000000000L
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
+__u64 q_horizon = 10ULL * NSEC_PER_SEC;
+__u32 q_initial_quantum = 10 * PSCHED_MTU;
+__u32 q_quantum = 2 * PSCHED_MTU;
+__u32 q_orphan_mask = 1023;
+__u32 q_flow_plimit = 100;
+__u32 q_plimit = 10000;
+__u32 q_timer_slack = 10 * NSEC_PER_USEC;
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
+struct fq_flow_node {
+	u32 hash;
+	int credit;
+	u32 qlen;
+	u32 socket_hash;
+	u64 age;
+	u64 time_next_packet;
+	struct bpf_list_node list_node;
+	struct bpf_rb_node rb_node;
+	struct bpf_rb_root queue __contains_kptr(sk_buff, bpf_rbnode);
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
+struct stashed_skb {
+	struct sk_buff __kptr *skb;
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
+private(D) struct bpf_spin_lock fq_stashed_skb_lock;
+private(D) struct bpf_list_head fq_stashed_skb __contains_kptr(sk_buff, bpf_list);
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
+static __always_inline struct qdisc_skb_cb *qdisc_skb_cb(const struct sk_buff *skb)
+{
+	return (struct qdisc_skb_cb *)skb->cb;
+}
+
+static __always_inline int hash64(u64 val, int bits)
+{
+	return val * 0x61C8864680B583EBull >> (64 - bits);
+}
+
+static bool skb_tstamp_less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	struct sk_buff *skb_a;
+	struct sk_buff *skb_b;
+
+	skb_a = container_of(a, struct sk_buff, bpf_rbnode);
+	skb_b = container_of(b, struct sk_buff, bpf_rbnode);
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
+SEC("struct_ops/bpf_fq_enqueue")
+int BPF_PROG(bpf_fq_enqueue, struct sk_buff *skb, struct Qdisc *sch,
+	     struct bpf_sk_buff_ptr *to_free)
+{
+	struct iphdr *iph = (void *)(long)skb->data + sizeof(struct ethhdr);
+	u64 time_to_send, jiffies, delay_ns, *comp_ns, *rate;
+	struct fq_flow_node *flow = NULL, *flow_copy;
+	struct fq_stashed_flow *sflow;
+	u32 hash, daddr, sk_hash;
+	bool connected;
+
+	if (q_random_drop & (bpf_get_prandom_u32() > ~0U * 0.90))
+		goto drop;
+
+	if (fq_qlen >= q_plimit)
+		goto drop;
+
+	if (!skb->tstamp) {
+		time_to_send = ktime_cache = bpf_ktime_get_ns();
+	} else {
+		if (fq_packet_beyond_horizon(skb)) {
+			ktime_cache = bpf_ktime_get_ns();
+			if (fq_packet_beyond_horizon(skb)) {
+				if (q_horizon_drop)
+					goto drop;
+
+				skb->tstamp = ktime_cache + q_horizon;
+			}
+		}
+		time_to_send = skb->tstamp;
+	}
+
+	if (fq_classify(skb, &hash, &sflow, &connected, &sk_hash) < 0)
+		goto drop;
+
+	flow = bpf_kptr_xchg(&sflow->flow, flow);
+	if (!flow)
+		goto drop; //unexpected
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
+			goto drop;
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
+	skb->tstamp = time_to_send;
+
+	bpf_spin_lock(&flow->lock);
+	bpf_rbtree_excl_add(&flow->queue, &skb->bpf_rbnode, skb_tstamp_less);
+	bpf_spin_unlock(&flow->lock);
+
+	flow->qlen++;
+	bpf_kptr_xchg_back(&sflow->flow, flow);
+
+	fq_qlen++;
+	return NET_XMIT_SUCCESS;
+
+drop:
+	if (q_compensate_tstamp) {
+		bpf_probe_read_kernel(&daddr, sizeof(daddr), &iph->daddr);
+		rate = bpf_map_lookup_elem(&rate_map, &daddr);
+		comp_ns = bpf_map_lookup_elem(&comp_map, &daddr);
+		if (rate && comp_ns) {
+			delay_ns = (u64)qdisc_skb_cb(skb)->pkt_len * NSEC_PER_SEC / (*rate);
+			__sync_fetch_and_add(comp_ns, delay_ns);
+		}
+	}
+	bpf_qdisc_skb_drop(skb, to_free);
+	return NET_XMIT_DROP;
+}
+
+static int fq_unset_throttled_flows(u32 index, bool *unset_all)
+{
+	struct bpf_rb_node *node = NULL;
+	struct fq_flow_node *flow;
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
+static __always_inline void stash_skb(struct sk_buff *skb)
+{
+	bpf_spin_lock(&fq_stashed_skb_lock);
+	bpf_list_excl_push_back(&fq_stashed_skb, &skb->bpf_list);
+	bpf_spin_unlock(&fq_stashed_skb_lock);
+}
+
+static __always_inline struct sk_buff *get_stashed_skb()
+{
+	struct bpf_list_excl_node *node;
+	struct sk_buff *skb;
+
+	bpf_spin_lock(&fq_stashed_skb_lock);
+	node = bpf_list_excl_pop_front(&fq_stashed_skb);
+	bpf_spin_unlock(&fq_stashed_skb_lock);
+	if (!node)
+		return NULL;
+
+	skb = container_of(node, struct sk_buff, bpf_list);
+	return skb;
+}
+
+static int
+fq_dequeue_nonprio_flows(u32 index, struct dequeue_nonprio_ctx *ctx)
+{
+	u64 time_next_packet, time_to_send;
+	struct bpf_rb_excl_node *rb_node;
+	struct sk_buff *skb = NULL;
+	struct bpf_list_head *head;
+	struct bpf_list_node *node;
+	struct bpf_spin_lock *lock;
+	struct fq_flow_node *flow;
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
+	rb_node = bpf_rbtree_excl_first(&flow->queue);
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
+	skb = container_of(rb_node, struct sk_buff, bpf_rbnode);
+	time_to_send = skb->tstamp;
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
+	rb_node = bpf_rbtree_excl_remove(&flow->queue, rb_node);
+	bpf_spin_unlock(&flow->lock);
+
+	if (!rb_node) {
+		fq_flows_add_tail(head, lock, flow);
+		return 0; //unexpected
+	}
+
+	skb = container_of(rb_node, struct sk_buff, bpf_rbnode);
+
+	flow->credit -= qdisc_skb_cb(skb)->pkt_len;
+	flow->qlen--;
+	fq_qlen--;
+
+	ctx->dequeued = true;
+	stash_skb(skb);
+
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
+	struct bpf_rb_excl_node *node;
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
+	node = bpf_rbtree_excl_first(&flow->queue);
+	if (!node) {
+		bpf_spin_unlock(&flow->lock);
+		goto xchg_flow_back;
+	}
+
+	skb = container_of(node, struct sk_buff, bpf_rbnode);
+	node = bpf_rbtree_excl_remove(&flow->queue, &skb->bpf_rbnode);
+	bpf_spin_unlock(&flow->lock);
+
+	if (!node) {
+		skb = NULL;
+		goto xchg_flow_back;
+	}
+
+	skb = container_of(node, struct sk_buff, bpf_rbnode);
+	fq_qlen--;
+
+xchg_flow_back:
+	bpf_kptr_xchg_back(&sflow->flow, flow);
+
+	return skb;
+}
+
+SEC("struct_ops/bpf_fq_dequeue")
+struct sk_buff *BPF_PROG(bpf_fq_dequeue, struct Qdisc *sch)
+{
+	struct dequeue_nonprio_ctx cb_ctx = {};
+	struct sk_buff *skb = NULL;
+
+	skb = fq_dequeue_prio();
+	if (skb) {
+		bpf_skb_set_dev(skb, sch);
+		return skb;
+	}
+
+	ktime_cache = dequeue_now = bpf_ktime_get_ns();
+	fq_check_throttled();
+	bpf_loop(q_plimit, fq_dequeue_nonprio_flows, &cb_ctx, 0);
+
+	skb = get_stashed_skb();
+
+	if (skb) {
+		bpf_skb_set_dev(skb, sch);
+		return skb;
+	}
+
+	if (cb_ctx.expire)
+		bpf_qdisc_watchdog_schedule(sch, cb_ctx.expire, q_timer_slack);
+
+	return NULL;
+}
+
+static int
+fq_reset_flows(u32 index, void *ctx)
+{
+	struct bpf_list_node *node;
+	struct fq_flow_node *flow;
+
+	bpf_spin_lock(&fq_new_flows_lock);
+	node = bpf_list_pop_front(&fq_new_flows);
+	bpf_spin_unlock(&fq_new_flows_lock);
+	if (!node) {
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
+SEC("struct_ops/bpf_fq_reset")
+void BPF_PROG(bpf_fq_reset, struct Qdisc *sch)
+{
+	bool unset_all = true;
+	fq_qlen = 0;
+	bpf_loop(NUM_QUEUE + 1, fq_reset_stashed_flows, NULL, 0);
+	bpf_loop(NUM_QUEUE, fq_reset_flows, NULL, 0);
+	bpf_loop(NUM_QUEUE, fq_unset_throttled_flows, &unset_all, 0);
+	return;
+}
+
+SEC(".struct_ops")
+struct Qdisc_ops fq = {
+	.enqueue   = (void *)bpf_fq_enqueue,
+	.dequeue   = (void *)bpf_fq_dequeue,
+	.reset     = (void *)bpf_fq_reset,
+	.id        = "bpf_fq",
+};
-- 
2.20.1


