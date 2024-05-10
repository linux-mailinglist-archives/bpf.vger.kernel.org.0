Return-Path: <bpf+bounces-29539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172338C2AA1
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB681C21804
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB66884A32;
	Fri, 10 May 2024 19:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnisPoIT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86849745D6;
	Fri, 10 May 2024 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369070; cv=none; b=HcK0KPZ8z46Ix7meNOstm4LT7HCAhH1Eo6t6yxXpFHyW2MQr/fH313a4+1qXGTw1kOOVXycuLjr9NGCyukm0oCODLD3y4sBfeW4xL3PxQfYF2gOXiGLDoHa0H+kHFyrptb8n3SHVpQ2Yqe1IFgBy6kkD+BFpBQ9P2Iov39nqE4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369070; c=relaxed/simple;
	bh=McH3JQz3ARd65YOEk+fjyk5G0KlyuzzdR67QHonGxHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LoWtiuJCCO64qbVOlRlkogRxYEuR5jCn2ROYL0Yl2FvFtw9arsnRc4ytNS19YJk9NvgO/iAVUOD2p41Pu4K7l+p/WLOiJs35FtdqOTQtMdER1ina/M7PSeK8J2YGFq5fhlBdBdg9WzHwRuK5W3mToMghsBcjJN9bJRrS23mwSsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnisPoIT; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6a0ffaa079dso29924086d6.1;
        Fri, 10 May 2024 12:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715369066; x=1715973866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcFgc0dd4kFkfH1AU13CU7hfuaB5/OLt6xXwuSXRk+A=;
        b=lnisPoITDmtZ03N6I8b5VJB4ifojIiJulecyerhBLeQbUT7rBhJjq8bElHKVSlnybT
         iHIfsr6tcO2NQrXXuog7dGPWxf4B+J2VKmU5+R9y3B27mdf2uj9qfHkWnOQ8SJVSwyRi
         VWsQrK23r0Y6edhK7ttIYxapQVZGLMavZPsh6qSYcUeKhTnxE0YDRTofNlvt5OxlVaI0
         ndqWFRKhB1I7wgx2sLt8/ThuQcnTmDDKEwiSYH/6lM3m00mlurAXp1BkLqTKZtQ3fBnu
         VPO/ja8jQSDcjQmE5BzEiAKZ2BdjWu/bPYFWdKlBYR/IESfyhT0EOKc1yGx/G1P75Ys+
         N8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715369066; x=1715973866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcFgc0dd4kFkfH1AU13CU7hfuaB5/OLt6xXwuSXRk+A=;
        b=LbfviINWth0h2UIfXigAG8lgXYNEmnNJRYmB5kcA3qQ/lB/Uq92azBrU4aJk3QF0En
         7e/D4DIEPkR6fjIYBIpmpp82Px+MTJQplRA41iOOq27EI3TyrJkWdW/5VN64+kcz7M3i
         VZeq0hp49Loaiga4D4hXbBUEvYXRXlWdaCRvKa10MfgeSvRRd6pRsuDfurBncxzlt+rh
         khgLE2WcOO5FabiuUjJo6S0suPDrVirVD0HvJqMchaK8SGnp4S3zEFd0GvdwK06M/T+C
         AWuaaWLKXV28miFX9elXSX1RpK73d6UVzcgpj/meYPBDEMCFq6vCqqz6YUxHTV+MUAeS
         xUjA==
X-Gm-Message-State: AOJu0Yzt4Ub2aEwv3C98QgiqTF0IRrisMQAyzJXnWbNAuPnDTYHVjSHZ
	WzSYNp97NAa2g3YSrDpfHjAnh7u/TiAOAuOJ7zrBGCZnZo9Q8XJA097k9w==
X-Google-Smtp-Source: AGHT+IF2V0gfhmoBGlHwEaxVpr8nk38rG81YpQ1QxO5eYANQguLdkdt9bISew15DIlcqnR7N6WXmAA==
X-Received: by 2002:a0c:f301:0:b0:6a0:f637:667 with SMTP id 6a1803df08f44-6a15cbc48a1mr116205646d6.12.1715369066495;
        Fri, 10 May 2024 12:24:26 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df5b46a26sm23863251cf.80.2024.05.10.12.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 12:24:26 -0700 (PDT)
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
Subject: [RFC PATCH v8 19/20] selftests: Add a bpf netem qdisc to selftest
Date: Fri, 10 May 2024 19:24:11 +0000
Message-Id: <20240510192412.3297104-20-amery.hung@bytedance.com>
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

This test implements a simple network emulator qdisc that simulates
packet drop, loss and delay. The qdisc uses Gilbert-Elliott model to
simulate packet drops. When used with mq qdisc, the bpf netem qdiscs
on different tx queues maintain a global state machine using a bpf map.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  30 +++
 .../selftests/bpf/progs/bpf_qdisc_netem.c     | 236 ++++++++++++++++++
 2 files changed, 266 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_netem.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
index 394bf5a4adae..ec9c0d166e89 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -6,6 +6,13 @@
 #include "bpf_qdisc_fifo.skel.h"
 #include "bpf_qdisc_fq.skel.h"
 
+struct crndstate {
+	u32 last;
+	u32 rho;
+};
+
+#include "bpf_qdisc_netem.skel.h"
+
 #ifndef ENOTSUPP
 #define ENOTSUPP 524
 #endif
@@ -176,10 +183,33 @@ static void test_fq(void)
 	bpf_qdisc_fq__destroy(fq_skel);
 }
 
+static void test_netem(void)
+{
+	struct bpf_qdisc_netem *netem_skel;
+	struct bpf_link *link;
+
+	netem_skel = bpf_qdisc_netem__open_and_load();
+	if (!ASSERT_OK_PTR(netem_skel, "bpf_qdisc_netem__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(netem_skel->maps.netem);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		bpf_qdisc_netem__destroy(netem_skel);
+		return;
+	}
+
+	do_test("bpf_netem");
+
+	bpf_link__destroy(link);
+	bpf_qdisc_netem__destroy(netem_skel);
+}
+
 void test_bpf_qdisc(void)
 {
 	if (test__start_subtest("fifo"))
 		test_fifo();
 	if (test__start_subtest("fq"))
 		test_fq();
+	if (test__start_subtest("netem"))
+		test_netem();
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_netem.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_netem.c
new file mode 100644
index 000000000000..c1df73cdbd3e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_netem.c
@@ -0,0 +1,236 @@
+#include <vmlinux.h>
+#include "bpf_experimental.h"
+#include "bpf_qdisc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
+
+private(A) struct bpf_spin_lock t_root_lock;
+private(A) struct bpf_rb_root t_root __contains_kptr(sk_buff, bpf_rbnode);
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
+struct clg_state {
+	u64 state;
+	u32 a1;
+	u32 a2;
+	u32 a3;
+	u32 a4;
+	u32 a5;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, __u32);
+	__type(value, struct clg_state);
+	__uint(max_entries, 1);
+} g_clg_state SEC(".maps");
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
+	clg = bpf_map_lookup_elem(&g_clg_state, &key);
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
+SEC("struct_ops/bpf_netem_enqueue")
+int BPF_PROG(bpf_netem_enqueue, struct sk_buff *skb, struct Qdisc *sch,
+	     struct bpf_sk_buff_ptr *to_free)
+{
+	int count = 1;
+	s64 delay = 0;
+	u64 now;
+
+	if (loss_event())
+		--count;
+
+	if (count == 0) {
+		bpf_qdisc_skb_drop(skb, to_free);
+		return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
+	}
+
+	q_qlen++;
+	if (q_qlen > q_limit) {
+		bpf_qdisc_skb_drop(skb, to_free);
+		return NET_XMIT_DROP;
+	}
+
+	delay = tabledist(q_latency, q_jitter, &q_delay_cor);
+	now = bpf_ktime_get_ns();
+	skb->tstamp = now + delay;
+
+	bpf_spin_lock(&t_root_lock);
+	bpf_rbtree_excl_add(&t_root, &skb->bpf_rbnode, skb_tstamp_less);
+	bpf_spin_unlock(&t_root_lock);
+
+	return NET_XMIT_SUCCESS;
+}
+
+SEC("struct_ops/bpf_netem_dequeue")
+struct sk_buff *BPF_PROG(bpf_netem_dequeue, struct Qdisc *sch)
+{
+	struct bpf_rb_excl_node *node;
+	struct sk_buff *skb;
+	u64 now, tstamp;
+
+	now = bpf_ktime_get_ns();
+
+	bpf_spin_lock(&t_root_lock);
+	node = bpf_rbtree_excl_first(&t_root);
+	if (!node) {
+		bpf_spin_unlock(&t_root_lock);
+		return NULL;
+	}
+
+	skb = container_of(node, struct sk_buff, bpf_rbnode);
+	tstamp = skb->tstamp;
+	if (tstamp <= now) {
+		node = bpf_rbtree_excl_remove(&t_root, node);
+		bpf_spin_unlock(&t_root_lock);
+
+		if (!node)
+			return NULL;
+
+		skb = container_of(node, struct sk_buff, bpf_rbnode);
+		bpf_skb_set_dev(skb, sch);
+		q_qlen--;
+		return skb;
+	}
+
+	bpf_spin_unlock(&t_root_lock);
+	bpf_qdisc_watchdog_schedule(sch, tstamp, 0);
+	return NULL;
+}
+
+SEC("struct_ops/bpf_netem_init")
+int BPF_PROG(bpf_netem_init, struct Qdisc *sch, struct nlattr *opt,
+	     struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static int reset_queue(u32 index, void *ctx)
+{
+	struct bpf_rb_excl_node *node;
+	struct sk_buff *skb;
+
+	bpf_spin_lock(&t_root_lock);
+	node = bpf_rbtree_excl_first(&t_root);
+	if (!node) {
+		bpf_spin_unlock(&t_root_lock);
+		return 1;
+	}
+
+	skb = container_of(node, struct sk_buff, bpf_rbnode);
+	node = bpf_rbtree_excl_remove(&t_root, node);
+	bpf_spin_unlock(&t_root_lock);
+
+	if (!node)
+		return 1;
+
+	skb = container_of(node, struct sk_buff, bpf_rbnode);
+	bpf_skb_release(skb);
+	return 0;
+}
+
+SEC("struct_ops/bpf_netem_reset")
+void BPF_PROG(bpf_netem_reset, struct Qdisc *sch)
+{
+	bpf_loop(q_limit, reset_queue, NULL, 0);
+	q_qlen = 0;
+}
+
+SEC(".struct_ops")
+struct Qdisc_ops netem = {
+	.enqueue   = (void *)bpf_netem_enqueue,
+	.dequeue   = (void *)bpf_netem_dequeue,
+	.init      = (void *)bpf_netem_init,
+	.reset     = (void *)bpf_netem_reset,
+	.id        = "bpf_netem",
+};
+
-- 
2.20.1


