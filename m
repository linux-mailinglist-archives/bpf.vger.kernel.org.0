Return-Path: <bpf+bounces-53995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80887A6007A
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 20:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB99A7ADA91
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 19:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB301F4639;
	Thu, 13 Mar 2025 19:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnHHGzGQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A651F4619;
	Thu, 13 Mar 2025 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741892614; cv=none; b=GZ/asaAEA63Xf8A1DB+N23OchpNuWJRmomozb7fvTPnNCBmacQlNb3940dDkWvjNvw5G/0iTbuDtzHqpW6Qxt3h5fDkT+6b3YuQZDKqLBwkToR+ovzLdXlBfP8RmWpGMBP2nzqbBIIxQOu3L+NwnrQq6sa/yYBZA9K6/MKG3dJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741892614; c=relaxed/simple;
	bh=l/EG2Hv2+qR3NhHzVmwDAf8x8ODiqMG1OgRk1D0eEXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mv7azrZg6kcslIcr/COq8lUBqvBuHuiYTkqKZ7YzcA5f+30wa9Z1mUe8efApc7BmJvZCKdDpErGN0IRQjMhojcQdoM9bp6zv6HNLYQQnxJw7n+6OlQVIDc4vC3/hD+vgszSkMSxdYAyWn/7ulM7SSXTgnYuRSrRYkwvo3xVwhQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnHHGzGQ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-224191d92e4so28974955ad.3;
        Thu, 13 Mar 2025 12:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741892611; x=1742497411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4h19YQiBcyrtSA3sf0+MDRnNgbjNX1BgikaozoMEP4=;
        b=OnHHGzGQjw7ENOF2fFhoKRyGZr4OaWc0wBEUDW9DIjnXGE6bCwafmQ8i+t5SIlDtAM
         rrwNM7jSOkTiCN+DTdRZOOnZuhQIonm4D+996GDAz3sVxOWpztzYN675MATFMwNzPyDN
         mTIhhQy8V55do/rGopq47x9IVYM4ijgDpS+0GvN5IWpPqNMljgbPVH8Wqawkva7er5U0
         hD0Je3KVdT6bVY1WO386HgjyXgZF6MIVMWzTt/jEgy9fC+ZUOf6ewEBroACTy1ZBbpom
         kWTdvV1jUkcqLOmluRi8xKBGFed03SYFCDyh/LJJYxQ288tHSB4cr+en9Erq3dUm0tQP
         937Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741892611; x=1742497411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4h19YQiBcyrtSA3sf0+MDRnNgbjNX1BgikaozoMEP4=;
        b=tBLGI6aY8qJJDXdDKGJUtihgQuhY+x7pT8Rc6LpEs5xmiJ5CXSMrz62TV1fxhlojxU
         GD/K92gh4QpOJR1ImotGU/ZCMnyURTdbrpsYSN7RPftBEUhOJJIh0CCpiofOaLorKtDz
         HaafPwcrYxnCg4HCjgEj9OuCYvDWWG6M2CF0nB6pOB8qHFNwa7shJ/WqoYOdYfb1b8aP
         Njyvv0f4n0HZXYfdT61lqeEiu4vH3Th4BEOhtYgwuy+gRxmk3FUC2fIfLP0aAkSPiNa+
         Nvwpkb1jkQs96w5SBKXQ6poTsYtGT3FKS1A/CzEilKHN+23qX3ydl2s1+pmjhXQTU6Bl
         P1zQ==
X-Gm-Message-State: AOJu0YwT5WetYGKDnbZv6D1EQSg0p+oq5jSLnxiPbnRuHweqpsCeSOi3
	HAr/K++ZgK+1Q8FUWjiMU76zOEUOBkayG63YpWYiof8YLP8dHvhylZ6ieR7GOmODRQ==
X-Gm-Gg: ASbGncslG0H8C/r91ZFfB0OrUjiusngGXjiddofLxGNhiYe2zlgC3WNLbhMicD6ZXEr
	klF/HucgKbZ6SKtiqgDDK/AsmKqc0sqXiqT4y39qSSVykqtk/Rola3HK0Oj5pk+MTGpQB+qU9VY
	LP1LcVTDRnlD0TjiN1eHPvlPHgK6BUu52h8lTJWQJwYZStStMGoObbMOz4B4yLTdyEjISNEh8a7
	x6usSd7GUJ88luwcowSZMozLmFMV6BQzcuhq1m33ER9BNLmDAl7NdiqwyR/C3XDvpaBKwJQUAXe
	XolirYBjuBDOnUrb2uO9vf/C46rVZM4sqaLGYmbh8dmdE+/sEPcKHkC1XdFN0eZuafXg9kvZLm8
	iE6GUonyIIezyflJPpPrukvnx5KHPAg==
X-Google-Smtp-Source: AGHT+IHLfx1syiPekBmd1jECOoul1TU1rVonnrv48dnpb85B8hAwdAduAK9U3S9kOr+M2SagOGiRJg==
X-Received: by 2002:a17:902:ce89:b0:21f:4c8b:c514 with SMTP id d9443c01a7336-225dd8d720emr7622005ad.45.1741892611078;
        Thu, 13 Mar 2025 12:03:31 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9e2f45sm1652505a12.29.2025.03.13.12.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 12:03:30 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	xiyou.wangcong@gmail.com,
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 12/13] selftests/bpf: Add a bpf fq qdisc to selftest
Date: Thu, 13 Mar 2025 12:03:06 -0700
Message-ID: <20250313190309.2545711-13-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250313190309.2545711-1-ameryhung@gmail.com>
References: <20250313190309.2545711-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

This test implements a more sophisticated qdisc using bpf. The bpf fair-
queueing (fq) qdisc gives each flow an equal chance to transmit data. It
also respects the timestamp of skb for rate limiting.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  24 +
 .../selftests/bpf/progs/bpf_qdisc_fq.c        | 718 ++++++++++++++++++
 2 files changed, 742 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
index f2efc69af348..7e8e3170e6b6 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -4,6 +4,7 @@
 
 #include "network_helpers.h"
 #include "bpf_qdisc_fifo.skel.h"
+#include "bpf_qdisc_fq.skel.h"
 
 #define LO_IFINDEX 1
 
@@ -64,6 +65,27 @@ static void test_fifo(void)
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
 	struct netns_obj *netns;
@@ -74,6 +96,8 @@ void test_bpf_qdisc(void)
 
 	if (test__start_subtest("fifo"))
 		test_fifo();
+	if (test__start_subtest("fq"))
+		test_fq();
 
 	netns_free(netns);
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
new file mode 100644
index 000000000000..36ef53b10d98
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
@@ -0,0 +1,718 @@
+#include <vmlinux.h>
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+#include "bpf_qdisc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define NSEC_PER_USEC 1000L
+#define NSEC_PER_SEC 1000000000L
+
+#define NUM_QUEUE (1 << 20)
+
+struct fq_bpf_data {
+	u32 quantum;
+	u32 initial_quantum;
+	u32 flow_refill_delay;
+	u32 flow_plimit;
+	u64 horizon;
+	u32 orphan_mask;
+	u32 timer_slack;
+	u64 time_next_delayed_flow;
+	u64 unthrottle_latency_ns;
+	u8 horizon_drop;
+	u32 new_flow_cnt;
+	u32 old_flow_cnt;
+	u64 ktime_cache;
+};
+
+enum {
+	CLS_RET_PRIO	= 0,
+	CLS_RET_NONPRIO = 1,
+	CLS_RET_ERR	= 2,
+};
+
+struct skb_node {
+	u64 tstamp;
+	struct sk_buff __kptr * skb;
+	struct bpf_rb_node node;
+};
+
+struct fq_flow_node {
+	int credit;
+	u32 qlen;
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
+	bool stop_iter;
+	u64 expire;
+	u64 now;
+};
+
+struct remove_flows_ctx {
+	bool gc_only;
+	u32 reset_cnt;
+	u32 reset_max;
+};
+
+struct unset_throttled_flows_ctx {
+	bool unset_all;
+	u64 now;
+};
+
+struct fq_stashed_flow {
+	struct fq_flow_node __kptr * flow;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, __u64);
+	__type(value, struct fq_stashed_flow);
+	__uint(max_entries, NUM_QUEUE);
+} fq_nonprio_flows SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, __u64);
+	__type(value, struct fq_stashed_flow);
+	__uint(max_entries, 1);
+} fq_prio_flows SEC(".maps");
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
+private(D) struct fq_bpf_data q;
+
+/* Wrapper for bpf_kptr_xchg that expects NULL dst */
+static void bpf_kptr_xchg_back(void *map_val, void *ptr)
+{
+	void *ret;
+
+	ret = bpf_kptr_xchg(map_val, ptr);
+	if (ret)
+		bpf_obj_drop(ret);
+}
+
+static bool skbn_tstamp_less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	struct skb_node *skbn_a;
+	struct skb_node *skbn_b;
+
+	skbn_a = container_of(a, struct skb_node, node);
+	skbn_b = container_of(b, struct skb_node, node);
+
+	return skbn_a->tstamp < skbn_b->tstamp;
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
+static void
+fq_flows_add_head(struct bpf_list_head *head, struct bpf_spin_lock *lock,
+		  struct fq_flow_node *flow, u32 *flow_cnt)
+{
+	bpf_spin_lock(lock);
+	bpf_list_push_front(head, &flow->list_node);
+	bpf_spin_unlock(lock);
+	*flow_cnt += 1;
+}
+
+static void
+fq_flows_add_tail(struct bpf_list_head *head, struct bpf_spin_lock *lock,
+		  struct fq_flow_node *flow, u32 *flow_cnt)
+{
+	bpf_spin_lock(lock);
+	bpf_list_push_back(head, &flow->list_node);
+	bpf_spin_unlock(lock);
+	*flow_cnt += 1;
+}
+
+static void
+fq_flows_remove_front(struct bpf_list_head *head, struct bpf_spin_lock *lock,
+		      struct bpf_list_node **node, u32 *flow_cnt)
+{
+	bpf_spin_lock(lock);
+	*node = bpf_list_pop_front(head);
+	bpf_spin_unlock(lock);
+	*flow_cnt -= 1;
+}
+
+static bool
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
+/* flow->age is used to denote the state of the flow (not-detached, detached, throttled)
+ * as well as the timestamp when the flow is detached.
+ *
+ * 0: not-detached
+ * 1 - (~0ULL-1): detached
+ * ~0ULL: throttled
+ */
+static void fq_flow_set_detached(struct fq_flow_node *flow)
+{
+	flow->age = bpf_jiffies64();
+}
+
+static bool fq_flow_is_detached(struct fq_flow_node *flow)
+{
+	return flow->age != 0 && flow->age != ~0ULL;
+}
+
+static bool sk_listener(struct sock *sk)
+{
+	return (1 << sk->__sk_common.skc_state) & (TCPF_LISTEN | TCPF_NEW_SYN_RECV);
+}
+
+static void fq_gc(void);
+
+static int fq_new_flow(void *flow_map, struct fq_stashed_flow **sflow, u64 hash)
+{
+	struct fq_stashed_flow tmp = {};
+	struct fq_flow_node *flow;
+	int ret;
+
+	flow = bpf_obj_new(typeof(*flow));
+	if (!flow)
+		return -ENOMEM;
+
+	flow->credit = q.initial_quantum,
+	flow->qlen = 0,
+	flow->age = 1,
+	flow->time_next_packet = 0,
+
+	ret = bpf_map_update_elem(flow_map, &hash, &tmp, 0);
+	if (ret == -ENOMEM || ret == -E2BIG) {
+		fq_gc();
+		bpf_map_update_elem(&fq_nonprio_flows, &hash, &tmp, 0);
+	}
+
+	*sflow = bpf_map_lookup_elem(flow_map, &hash);
+	if (!*sflow) {
+		bpf_obj_drop(flow);
+		return -ENOMEM;
+	}
+
+	bpf_kptr_xchg_back(&(*sflow)->flow, flow);
+	return 0;
+}
+
+static int
+fq_classify(struct sk_buff *skb, struct fq_stashed_flow **sflow)
+{
+	struct sock *sk = skb->sk;
+	int ret = CLS_RET_NONPRIO;
+	u64 hash = 0;
+
+	if ((skb->priority & TC_PRIO_MAX) == TC_PRIO_CONTROL) {
+		*sflow = bpf_map_lookup_elem(&fq_prio_flows, &hash);
+		ret = CLS_RET_PRIO;
+	} else {
+		if (!sk || sk_listener(sk)) {
+			hash = bpf_skb_get_hash(skb) & q.orphan_mask;
+			/* Avoid collision with an existing flow hash, which
+			 * only uses the lower 32 bits of hash, by setting the
+			 * upper half of hash to 1.
+			 */
+			hash |= (1ULL << 32);
+		} else if (sk->__sk_common.skc_state == TCP_CLOSE) {
+			hash = bpf_skb_get_hash(skb) & q.orphan_mask;
+			hash |= (1ULL << 32);
+		} else {
+			hash = sk->__sk_common.skc_hash;
+		}
+		*sflow = bpf_map_lookup_elem(&fq_nonprio_flows, &hash);
+	}
+
+	if (!*sflow)
+		ret = fq_new_flow(&fq_nonprio_flows, sflow, hash) < 0 ?
+		      CLS_RET_ERR : CLS_RET_NONPRIO;
+
+	return ret;
+}
+
+static bool fq_packet_beyond_horizon(struct sk_buff *skb)
+{
+	return (s64)skb->tstamp > (s64)(q.ktime_cache + q.horizon);
+}
+
+SEC("struct_ops/bpf_fq_enqueue")
+int BPF_PROG(bpf_fq_enqueue, struct sk_buff *skb, struct Qdisc *sch,
+	     struct bpf_sk_buff_ptr *to_free)
+{
+	struct fq_flow_node *flow = NULL, *flow_copy;
+	struct fq_stashed_flow *sflow;
+	u64 time_to_send, jiffies;
+	struct skb_node *skbn;
+	int ret;
+
+	if (sch->q.qlen >= sch->limit)
+		goto drop;
+
+	if (!skb->tstamp) {
+		time_to_send = q.ktime_cache = bpf_ktime_get_ns();
+	} else {
+		if (fq_packet_beyond_horizon(skb)) {
+			q.ktime_cache = bpf_ktime_get_ns();
+			if (fq_packet_beyond_horizon(skb)) {
+				if (q.horizon_drop)
+					goto drop;
+
+				skb->tstamp = q.ktime_cache + q.horizon;
+			}
+		}
+		time_to_send = skb->tstamp;
+	}
+
+	ret = fq_classify(skb, &sflow);
+	if (ret == CLS_RET_ERR)
+		goto drop;
+
+	flow = bpf_kptr_xchg(&sflow->flow, flow);
+	if (!flow)
+		goto drop;
+
+	if (ret == CLS_RET_NONPRIO) {
+		if (flow->qlen >= q.flow_plimit) {
+			bpf_kptr_xchg_back(&sflow->flow, flow);
+			goto drop;
+		}
+
+		if (fq_flow_is_detached(flow)) {
+			flow_copy = bpf_refcount_acquire(flow);
+
+			jiffies = bpf_jiffies64();
+			if ((s64)(jiffies - (flow_copy->age + q.flow_refill_delay)) > 0) {
+				if (flow_copy->credit < q.quantum)
+					flow_copy->credit = q.quantum;
+			}
+			flow_copy->age = 0;
+			fq_flows_add_tail(&fq_new_flows, &fq_new_flows_lock, flow_copy,
+					  &q.new_flow_cnt);
+		}
+	}
+
+	skbn = bpf_obj_new(typeof(*skbn));
+	if (!skbn) {
+		bpf_kptr_xchg_back(&sflow->flow, flow);
+		goto drop;
+	}
+
+	skbn->tstamp = skb->tstamp = time_to_send;
+
+	sch->qstats.backlog += qdisc_pkt_len(skb);
+
+	skb = bpf_kptr_xchg(&skbn->skb, skb);
+	if (skb)
+		bpf_qdisc_skb_drop(skb, to_free);
+
+	bpf_spin_lock(&flow->lock);
+	bpf_rbtree_add(&flow->queue, &skbn->node, skbn_tstamp_less);
+	bpf_spin_unlock(&flow->lock);
+
+	flow->qlen++;
+	bpf_kptr_xchg_back(&sflow->flow, flow);
+
+	sch->q.qlen++;
+	return NET_XMIT_SUCCESS;
+
+drop:
+	bpf_qdisc_skb_drop(skb, to_free);
+	sch->qstats.drops++;
+	return NET_XMIT_DROP;
+}
+
+static int fq_unset_throttled_flows(u32 index, struct unset_throttled_flows_ctx *ctx)
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
+	if (!ctx->unset_all && flow->time_next_packet > ctx->now) {
+		q.time_next_delayed_flow = flow->time_next_packet;
+		bpf_spin_unlock(&fq_delayed_lock);
+		return 1;
+	}
+
+	node = bpf_rbtree_remove(&fq_delayed, &flow->rb_node);
+
+	bpf_spin_unlock(&fq_delayed_lock);
+
+	if (!node)
+		return 1;
+
+	flow = container_of(node, struct fq_flow_node, rb_node);
+	flow->age = 0;
+	fq_flows_add_tail(&fq_old_flows, &fq_old_flows_lock, flow, &q.old_flow_cnt);
+
+	return 0;
+}
+
+static void fq_flow_set_throttled(struct fq_flow_node *flow)
+{
+	flow->age = ~0ULL;
+
+	if (q.time_next_delayed_flow > flow->time_next_packet)
+		q.time_next_delayed_flow = flow->time_next_packet;
+
+	bpf_spin_lock(&fq_delayed_lock);
+	bpf_rbtree_add(&fq_delayed, &flow->rb_node, fn_time_next_packet_less);
+	bpf_spin_unlock(&fq_delayed_lock);
+}
+
+static void fq_check_throttled(u64 now)
+{
+	struct unset_throttled_flows_ctx ctx = {
+		.unset_all = false,
+		.now = now,
+	};
+	unsigned long sample;
+
+	if (q.time_next_delayed_flow > now)
+		return;
+
+	sample = (unsigned long)(now - q.time_next_delayed_flow);
+	q.unthrottle_latency_ns -= q.unthrottle_latency_ns >> 3;
+	q.unthrottle_latency_ns += sample >> 3;
+
+	q.time_next_delayed_flow = ~0ULL;
+	bpf_loop(NUM_QUEUE, fq_unset_throttled_flows, &ctx, 0);
+}
+
+static struct sk_buff*
+fq_dequeue_nonprio_flows(u32 index, struct dequeue_nonprio_ctx *ctx)
+{
+	u64 time_next_packet, time_to_send;
+	struct bpf_rb_node *rb_node;
+	struct sk_buff *skb = NULL;
+	struct bpf_list_head *head;
+	struct bpf_list_node *node;
+	struct bpf_spin_lock *lock;
+	struct fq_flow_node *flow;
+	struct skb_node *skbn;
+	bool is_empty;
+	u32 *cnt;
+
+	if (q.new_flow_cnt) {
+		head = &fq_new_flows;
+		lock = &fq_new_flows_lock;
+		cnt = &q.new_flow_cnt;
+	} else if (q.old_flow_cnt) {
+		head = &fq_old_flows;
+		lock = &fq_old_flows_lock;
+		cnt = &q.old_flow_cnt;
+	} else {
+		if (q.time_next_delayed_flow != ~0ULL)
+			ctx->expire = q.time_next_delayed_flow;
+		goto break_loop;
+	}
+
+	fq_flows_remove_front(head, lock, &node, cnt);
+	if (!node)
+		goto break_loop;
+
+	flow = container_of(node, struct fq_flow_node, list_node);
+	if (flow->credit <= 0) {
+		flow->credit += q.quantum;
+		fq_flows_add_tail(&fq_old_flows, &fq_old_flows_lock, flow, &q.old_flow_cnt);
+		return NULL;
+	}
+
+	bpf_spin_lock(&flow->lock);
+	rb_node = bpf_rbtree_first(&flow->queue);
+	if (!rb_node) {
+		bpf_spin_unlock(&flow->lock);
+		is_empty = fq_flows_is_empty(&fq_old_flows, &fq_old_flows_lock);
+		if (head == &fq_new_flows && !is_empty) {
+			fq_flows_add_tail(&fq_old_flows, &fq_old_flows_lock, flow, &q.old_flow_cnt);
+		} else {
+			fq_flow_set_detached(flow);
+			bpf_obj_drop(flow);
+		}
+		return NULL;
+	}
+
+	skbn = container_of(rb_node, struct skb_node, node);
+	time_to_send = skbn->tstamp;
+
+	time_next_packet = (time_to_send > flow->time_next_packet) ?
+		time_to_send : flow->time_next_packet;
+	if (ctx->now < time_next_packet) {
+		bpf_spin_unlock(&flow->lock);
+		flow->time_next_packet = time_next_packet;
+		fq_flow_set_throttled(flow);
+		return NULL;
+	}
+
+	rb_node = bpf_rbtree_remove(&flow->queue, rb_node);
+	bpf_spin_unlock(&flow->lock);
+
+	if (!rb_node)
+		goto add_flow_and_break;
+
+	skbn = container_of(rb_node, struct skb_node, node);
+	skb = bpf_kptr_xchg(&skbn->skb, skb);
+	bpf_obj_drop(skbn);
+
+	if (!skb)
+		goto add_flow_and_break;
+
+	flow->credit -= qdisc_skb_cb(skb)->pkt_len;
+	flow->qlen--;
+
+add_flow_and_break:
+	fq_flows_add_head(head, lock, flow, cnt);
+
+break_loop:
+	ctx->stop_iter = true;
+	return skb;
+}
+
+static struct sk_buff *fq_dequeue_prio(void)
+{
+	struct fq_flow_node *flow = NULL;
+	struct fq_stashed_flow *sflow;
+	struct bpf_rb_node *rb_node;
+	struct sk_buff *skb = NULL;
+	struct skb_node *skbn;
+	u64 hash = 0;
+
+	sflow = bpf_map_lookup_elem(&fq_prio_flows, &hash);
+	if (!sflow)
+		return NULL;
+
+	flow = bpf_kptr_xchg(&sflow->flow, flow);
+	if (!flow)
+		return NULL;
+
+	bpf_spin_lock(&flow->lock);
+	rb_node = bpf_rbtree_first(&flow->queue);
+	if (!rb_node) {
+		bpf_spin_unlock(&flow->lock);
+		goto out;
+	}
+
+	skbn = container_of(rb_node, struct skb_node, node);
+	rb_node = bpf_rbtree_remove(&flow->queue, &skbn->node);
+	bpf_spin_unlock(&flow->lock);
+
+	if (!rb_node)
+		goto out;
+
+	skbn = container_of(rb_node, struct skb_node, node);
+	skb = bpf_kptr_xchg(&skbn->skb, skb);
+	bpf_obj_drop(skbn);
+
+out:
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
+	int i;
+
+	if (!sch->q.qlen)
+		goto out;
+
+	skb = fq_dequeue_prio();
+	if (skb)
+		goto dequeue;
+
+	q.ktime_cache = cb_ctx.now = bpf_ktime_get_ns();
+	fq_check_throttled(q.ktime_cache);
+	bpf_for(i, 0, sch->limit) {
+		skb = fq_dequeue_nonprio_flows(i, &cb_ctx);
+		if (cb_ctx.stop_iter)
+			break;
+	};
+
+	if (skb) {
+dequeue:
+		sch->q.qlen--;
+		sch->qstats.backlog -= qdisc_pkt_len(skb);
+		bpf_qdisc_bstats_update(sch, skb);
+		return skb;
+	}
+
+	if (cb_ctx.expire)
+		bpf_qdisc_watchdog_schedule(sch, cb_ctx.expire, q.timer_slack);
+out:
+	return NULL;
+}
+
+static int fq_remove_flows_in_list(u32 index, void *ctx)
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
+extern unsigned CONFIG_HZ __kconfig;
+
+/* limit number of collected flows per round */
+#define FQ_GC_MAX 8
+#define FQ_GC_AGE (3*CONFIG_HZ)
+
+static bool fq_gc_candidate(struct fq_flow_node *flow)
+{
+	u64 jiffies = bpf_jiffies64();
+
+	return fq_flow_is_detached(flow) &&
+	       ((s64)(jiffies - (flow->age + FQ_GC_AGE)) > 0);
+}
+
+static int
+fq_remove_flows(struct bpf_map *flow_map, u64 *hash,
+		struct fq_stashed_flow *sflow, struct remove_flows_ctx *ctx)
+{
+	if (sflow->flow &&
+	    (!ctx->gc_only || fq_gc_candidate(sflow->flow))) {
+		bpf_map_delete_elem(flow_map, hash);
+		ctx->reset_cnt++;
+	}
+
+	return ctx->reset_cnt < ctx->reset_max ? 0 : 1;
+}
+
+static void fq_gc(void)
+{
+	struct remove_flows_ctx cb_ctx = {
+		.gc_only = true,
+		.reset_cnt = 0,
+		.reset_max = FQ_GC_MAX,
+	};
+
+	bpf_for_each_map_elem(&fq_nonprio_flows, fq_remove_flows, &cb_ctx, 0);
+}
+
+SEC("struct_ops/bpf_fq_reset")
+void BPF_PROG(bpf_fq_reset, struct Qdisc *sch)
+{
+	struct unset_throttled_flows_ctx utf_ctx = {
+		.unset_all = true,
+	};
+	struct remove_flows_ctx rf_ctx = {
+		.gc_only = false,
+		.reset_cnt = 0,
+		.reset_max = NUM_QUEUE,
+	};
+	struct fq_stashed_flow *sflow;
+	u64 hash = 0;
+
+	sch->q.qlen = 0;
+	sch->qstats.backlog = 0;
+
+	bpf_for_each_map_elem(&fq_nonprio_flows, fq_remove_flows, &rf_ctx, 0);
+
+	rf_ctx.reset_cnt = 0;
+	bpf_for_each_map_elem(&fq_prio_flows, fq_remove_flows, &rf_ctx, 0);
+	fq_new_flow(&fq_prio_flows, &sflow, hash);
+
+	bpf_loop(NUM_QUEUE, fq_remove_flows_in_list, NULL, 0);
+	q.new_flow_cnt = 0;
+	q.old_flow_cnt = 0;
+
+	bpf_loop(NUM_QUEUE, fq_unset_throttled_flows, &utf_ctx, 0);
+}
+
+SEC("struct_ops/bpf_fq_init")
+int BPF_PROG(bpf_fq_init, struct Qdisc *sch, struct nlattr *opt,
+	     struct netlink_ext_ack *extack)
+{
+	struct net_device *dev = sch->dev_queue->dev;
+	u32 psched_mtu = dev->mtu + dev->hard_header_len;
+	struct fq_stashed_flow *sflow;
+	u64 hash = 0;
+
+	if (fq_new_flow(&fq_prio_flows, &sflow, hash) < 0)
+		return -ENOMEM;
+
+	sch->limit = 10000;
+	q.initial_quantum = 10 * psched_mtu;
+	q.quantum = 2 * psched_mtu;
+	q.flow_refill_delay = 40;
+	q.flow_plimit = 100;
+	q.horizon = 10ULL * NSEC_PER_SEC;
+	q.horizon_drop = 1;
+	q.orphan_mask = 1024 - 1;
+	q.timer_slack = 10 * NSEC_PER_USEC;
+	q.time_next_delayed_flow = ~0ULL;
+	q.unthrottle_latency_ns = 0ULL;
+	q.new_flow_cnt = 0;
+	q.old_flow_cnt = 0;
+
+	return 0;
+}
+
+SEC(".struct_ops")
+struct Qdisc_ops fq = {
+	.enqueue   = (void *)bpf_fq_enqueue,
+	.dequeue   = (void *)bpf_fq_dequeue,
+	.reset     = (void *)bpf_fq_reset,
+	.init      = (void *)bpf_fq_init,
+	.id        = "bpf_fq",
+};
-- 
2.47.1


