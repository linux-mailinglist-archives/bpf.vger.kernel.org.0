Return-Path: <bpf+bounces-34789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86659930B21
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 19:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D881C20976
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 17:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E634F1442EF;
	Sun, 14 Jul 2024 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVRG4QmE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E0913D533;
	Sun, 14 Jul 2024 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720979501; cv=none; b=hwBY4lmjmj72HItIt/SUgEDFT3qDW+dbrFxGxWaIDcBgA1txU/o6n2zpDQXmgxfV0xmcnkFlEs9MDvQaXP5TcZ4qzxSIForOkWEsgKT8aiebORklU9rGZb5w8oHj3u9PhLSkIjW75bUWcEPps0WaF0/afvg3+1zTxnQ7Ih9+DzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720979501; c=relaxed/simple;
	bh=bQ+34maP/UD2Q5MReBTSvH93tQya4LO9WvhCA14krd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CEgl3MhTKB8uhGncIulM97tI3e7y+tVlIxS0PVWcrVa1UFeSTuyqLQAonKzA1G8HN9uuyzf6EJIQAhIeLlY90fju78L15nu++f2k6ojsGGj7HxHA9o6O5SbEHo37WzG/yjhb6TeX7qEJkpzMFjTZQm4+4dL/bJRN1OF2xWMMbTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVRG4QmE; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44931d9eda6so29162001cf.1;
        Sun, 14 Jul 2024 10:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720979499; x=1721584299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXabjXEAojtFoTktfk1aij/0ux5sndtJGYU+XjZZZnc=;
        b=RVRG4QmEuUGZG69jN61zvOy/Ea0XDuyofmjhAqCcWstTiz9QtoARer5qKHjOX8Is1z
         x2Yma/23k9Uloxc7saC1zF4tocdosOYTSuYZm+VnbbDQGOWgMQCkRIcNSvjQIkT4wKmu
         on6Y+bl76ZhzFs6rllZBie8jeq8jATD6Xq2F6OE4h29s5cPhOQ02nkNBxN6NDNrZbzQ+
         Ou/JqMGKFXnp4MDh6XJunYlMeP/s8u1bXRv4aCB/N5UkrTNrAnod1y1TAxD7RCY5XeD2
         pziuBDNPxoGTLDeCyhhNs00IKO7bVnRNQaTBGWYk7K4X/uK6sulrebEf0KMqQ2cUDSZt
         +XGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720979499; x=1721584299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXabjXEAojtFoTktfk1aij/0ux5sndtJGYU+XjZZZnc=;
        b=hS2JhyDaJdXIeO2EE/GSNH6cqVnUcixXrHLw6kK6YN5Aw8T0u/HrIhSIEynBYWz0t5
         YyaK9jeZhqkfIqDxb1teN7QxqIS/Wa9zfyrlWeE3DtKdaieEZLm+eEyz9mjl3SDYCVwx
         28OCglMiqwQ1rtQhk3R7e7iHM57HxibbRqF1f9lDZmYs29jVzNV0/B+EFpUb+UxXr73v
         SAz2zpndU637gZsntkgov/DAfLKsLtZ+tBcL/u6FlJzfNXT91UvzEFQkCpYAUGg9afVm
         C9+LyiuO0QFaARtrKqgUTVujRIhQ0fG2mbaidnTqp9Mr89ziKgxNy9Qn9lgIOEdOcC9S
         y1Yw==
X-Gm-Message-State: AOJu0Yw8pK6BnTBNU2Meskuax4yFV+BpH9iIlJv5aWZtpM8jhnkuoeyY
	MaCJIr8tEvYPNrtYRTQeZbRR/ARrmleFb76gsqQ385XB+FNDm4BwiXp5JQ==
X-Google-Smtp-Source: AGHT+IHzmeWTyAkZUwjWI2Y+jQgfma7EKavsxYmhe3zA2vpFYca4tVzLqNIksn0KMWtixExepJQUHw==
X-Received: by 2002:a05:622a:120b:b0:447:f942:50c1 with SMTP id d75a77b69052e-44e5d54b50cmr135622381cf.29.1720979498632;
        Sun, 14 Jul 2024 10:51:38 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b7e1e38sm17010481cf.25.2024.07.14.10.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 10:51:38 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [RFC PATCH v9 11/11] selftests: Add a bpf netem qdisc to selftest
Date: Sun, 14 Jul 2024 17:51:30 +0000
Message-Id: <20240714175130.4051012-12-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240714175130.4051012-1-amery.hung@bytedance.com>
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
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
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  30 ++
 .../selftests/bpf/progs/bpf_qdisc_netem.c     | 258 ++++++++++++++++++
 2 files changed, 288 insertions(+)
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
index 000000000000..39be88a5f16a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_netem.c
@@ -0,0 +1,258 @@
+#include <vmlinux.h>
+#include "bpf_experimental.h"
+#include "bpf_qdisc_common.h"
+
+char _license[] SEC("license") = "GPL";
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
+static bool skb_tstamp_less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
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
+static u32 get_crandom(struct crndstate *state)
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
+static s64 tabledist(s64 mu, s32 sigma, struct crndstate *state)
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
+static bool loss_gilb_ell(void)
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
+static bool loss_event(void)
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
+	struct skb_node *skbn;
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
+	skbn = bpf_obj_new(typeof(*skbn));
+	if (!skbn) {
+		bpf_qdisc_skb_drop(skb, to_free);
+		return NET_XMIT_DROP;
+	}
+
+	skb = bpf_kptr_xchg(&skbn->skb, skb);
+	if (skb)
+		bpf_qdisc_skb_drop(skb, to_free);
+
+	delay = tabledist(q_latency, q_jitter, &q_delay_cor);
+	now = bpf_ktime_get_ns();
+	skbn->tstamp = now + delay;
+
+	bpf_spin_lock(&t_root_lock);
+	bpf_rbtree_add(&t_root, &skbn->node, skb_tstamp_less);
+	bpf_spin_unlock(&t_root_lock);
+
+	return NET_XMIT_SUCCESS;
+}
+
+SEC("struct_ops/bpf_netem_dequeue")
+struct sk_buff *BPF_PROG(bpf_netem_dequeue, struct Qdisc *sch)
+{
+	struct sk_buff *skb = NULL;
+	struct bpf_rb_node *node;
+	struct skb_node *skbn;
+	u64 now, tstamp;
+
+	now = bpf_ktime_get_ns();
+
+	bpf_spin_lock(&t_root_lock);
+	node = bpf_rbtree_first(&t_root);
+	if (!node) {
+		bpf_spin_unlock(&t_root_lock);
+		return NULL;
+	}
+
+	skbn = container_of(node, struct skb_node, node);
+	tstamp = skbn->tstamp;
+	if (tstamp <= now) {
+		node = bpf_rbtree_remove(&t_root, node);
+		bpf_spin_unlock(&t_root_lock);
+
+		if (!node)
+			return NULL;
+
+		skbn = container_of(node, struct skb_node, node);
+		skb = bpf_kptr_xchg(&skbn->skb, skb);
+		bpf_obj_drop(skbn);
+
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
+SEC("struct_ops/bpf_netem_reset")
+void BPF_PROG(bpf_netem_reset, struct Qdisc *sch)
+{
+	struct bpf_rb_node *node;
+	struct skb_node *skbn;
+	int i;
+
+	bpf_for(i, 0, q_limit) {
+		struct sk_buff *skb = NULL;
+
+		bpf_spin_lock(&t_root_lock);
+		node = bpf_rbtree_first(&t_root);
+		if (!node) {
+			bpf_spin_unlock(&t_root_lock);
+			break;
+		}
+
+		skbn = container_of(node, struct skb_node, node);
+		node = bpf_rbtree_remove(&t_root, node);
+		bpf_spin_unlock(&t_root_lock);
+
+		if (!node)
+			continue;
+
+		skbn = container_of(node, struct skb_node, node);
+		skb = bpf_kptr_xchg(&skbn->skb, skb);
+		if (skb)
+			bpf_skb_release(skb);
+		bpf_obj_drop(skbn);
+	}
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


