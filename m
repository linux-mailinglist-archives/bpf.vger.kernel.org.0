Return-Path: <bpf+bounces-55595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AABA8339D
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 23:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D2A464233
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 21:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A08215F48;
	Wed,  9 Apr 2025 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8J7dctI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EE821B9F3;
	Wed,  9 Apr 2025 21:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744235180; cv=none; b=jhMV0VG2smJqmbiGOUMoA0/i67syA0WGX/MkQkol46pVp02ms5Su/mZVUFhw9wv3AGekndo4lI5xnS4ozqrLyFr158TItnsXszJge/ACkTLN4toQXMRXJq8kj72+kcNnZelrTHVbe4YAHsNJy0jdI5UXr2ON5SuiuaHN9OVgtHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744235180; c=relaxed/simple;
	bh=trXEOrLTzMbbQs+Xsxlw+yJn7nNiN7tMHsz/LkEXZ0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jL/NsR1pwV9yLM7rxYqCCpQA8qMGtWGVN7c2BPhp3G5maCDsBrnksdPLEaZNvEOosDP76PZY2muk7SO+rwavF4sgpG7l+ehblozf2DSB+YdRos+tma0JaMns/a4hAyoB6FahzZs4fjpQ+6kJHKLmQq3iUnwSqn3XKGwWB3h8C4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8J7dctI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22548a28d0cso1739845ad.3;
        Wed, 09 Apr 2025 14:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744235178; x=1744839978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdJuFlmIhtIdd2CmK8/gNgSHGth8wVmVzbC8BafYzDI=;
        b=B8J7dctIGBb8IGw8UPp8Ap3yS7BALQG09hOmHYv/IkaZjMoml9kO5i5aDPe/8zmZPx
         3/DjI24mMhSfT5gkBhtLvT2v2qeN2sdq5LicpHMG5fgzvroeuZPkB3i1M5tCuHjgTHxA
         PeKdK55rjIoJnH42yiR1dUY7myHdhNNCBGb6Jtc7KVIBAAaLRKkegFdR2kKcTOdrxdZ+
         VhoF5kJ/to8kJdEqQXd7zcZTVNry2j2eNkD4KhLxn2IpsTjJbdvcOXO3tojt/3k754Cx
         PTv6EXQ5G6aczcjYZ+RV97NhK+WUvS89z0xwrg2fjymHWhXSCfjj+rG2NBwHkUwOgdEV
         Az/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744235178; x=1744839978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdJuFlmIhtIdd2CmK8/gNgSHGth8wVmVzbC8BafYzDI=;
        b=QcCoYMn2cZxfgy1TuUDgbRa7jqmZ/cCrqI2oddWFA2pgFot/8m/i1q9/sXmd4TofEF
         fHXstbRy+0edwJR0pM82V1SSiflIwBZSbI+Fs5Gxo+ih98X+htxliqvKwFXgWg/f/1uB
         LCkMeocZqBF1tQMTw3yQcUSdDE+Zb1CfekmjqkbKon9sAGKUxyv51BAPnSVIQ6FHdU5J
         3vwntNezdAfIjdnABTsW6a3SPDhBPc0Nf5o+oH1jiSTViSImFl1U6MEOpP9CgY9Hssnj
         z8/k+GZDE+fTfMCmf0TbSnLUS6sEE+Gsr21APgOiZ4QeJ60hzskDdAoyYrpRShtfh0Z2
         5vew==
X-Gm-Message-State: AOJu0YyNjcHFHczQ1UaAD4+3U3M6YM8DUQobN87KIrCi3Sg1lH4I375p
	uHH/ze1dcYH20wI14PsrliLEukszDPyHtjXhH5XNytYJeNnllefhRdAvhtl7
X-Gm-Gg: ASbGncvu9JbRwdrrwBkZsEjcOhRFmJssLXhd1YUkmYEpjcwQWRlKCuAppsk7uvczowK
	ImiySm5fIpkIjNQ1aT+ltftORKk7u4Zubxa+PUjk/2peOedbGquYTy0WrJCh1qklAhCCcWaKerN
	YezYzH2rc4apDFKV2J5oFXPdqMasLl7bxyGo/pyEvS1Dd/a7Ztcsqykk0Tn5+aoQA8AcUffX4/l
	looWnrC1gaGVX9c8xFTHVpz36xQcr+mHvZnnAsBOAn0EqWxCM7Qjsmeh14uS78IS3uIKQiJXwE3
	EwEKsc0S7UmFPUapcMB4r5jee1/SpwI=
X-Google-Smtp-Source: AGHT+IHOuW1I0GDRaVMG4wM4GFB2NlCAwQ2HfR4TN7wt5U3YhIljZfPwjTpwX22RnMaubScegBv3gg==
X-Received: by 2002:a17:902:dac9:b0:21f:6bda:e492 with SMTP id d9443c01a7336-22b42ca827emr7613045ad.35.1744235178233;
        Wed, 09 Apr 2025 14:46:18 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:c::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e694efsm1863731b3a.164.2025.04.09.14.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 14:46:17 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	edumazet@google.com,
	kuba@kernel.org,
	xiyou.wangcong@gmail.com,
	jhs@mojatatu.com,
	martin.lau@kernel.org,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	toke@redhat.com,
	sinquersw@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 08/10] selftests/bpf: Add a basic fifo qdisc test
Date: Wed,  9 Apr 2025 14:46:04 -0700
Message-ID: <20250409214606.2000194-9-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250409214606.2000194-1-ameryhung@gmail.com>
References: <20250409214606.2000194-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

This selftest includes a bare minimum fifo qdisc, which simply enqueues
sk_buffs into the back of a bpf list and dequeues from the front of the
list.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  81 ++++++++++++
 .../selftests/bpf/progs/bpf_qdisc_common.h    |  31 +++++
 .../selftests/bpf/progs/bpf_qdisc_fifo.c      | 117 ++++++++++++++++++
 4 files changed, 230 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index c378d5d07e02..6b0cab55bd2d 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -71,6 +71,7 @@ CONFIG_NET_IPGRE=y
 CONFIG_NET_IPGRE_DEMUX=y
 CONFIG_NET_IPIP=y
 CONFIG_NET_MPLS_GSO=y
+CONFIG_NET_SCH_BPF=y
 CONFIG_NET_SCH_FQ=y
 CONFIG_NET_SCH_INGRESS=y
 CONFIG_NET_SCHED=y
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
new file mode 100644
index 000000000000..1ec321eb089f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/pkt_sched.h>
+#include <linux/rtnetlink.h>
+#include <test_progs.h>
+
+#include "network_helpers.h"
+#include "bpf_qdisc_fifo.skel.h"
+
+#define LO_IFINDEX 1
+
+static const unsigned int total_bytes = 10 * 1024 * 1024;
+
+static void do_test(char *qdisc)
+{
+	DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook, .ifindex = LO_IFINDEX,
+			    .attach_point = BPF_TC_QDISC,
+			    .parent = TC_H_ROOT,
+			    .handle = 0x8000000,
+			    .qdisc = qdisc);
+	int srv_fd = -1, cli_fd = -1;
+	int err;
+
+	err = bpf_tc_hook_create(&hook);
+	if (!ASSERT_OK(err, "attach qdisc"))
+		return;
+
+	srv_fd = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
+	if (!ASSERT_OK_FD(srv_fd, "start server"))
+		goto done;
+
+	cli_fd = connect_to_fd(srv_fd, 0);
+	if (!ASSERT_OK_FD(cli_fd, "connect to client"))
+		goto done;
+
+	err = send_recv_data(srv_fd, cli_fd, total_bytes);
+	ASSERT_OK(err, "send_recv_data");
+
+done:
+	if (srv_fd != -1)
+		close(srv_fd);
+	if (cli_fd != -1)
+		close(cli_fd);
+
+	bpf_tc_hook_destroy(&hook);
+}
+
+static void test_fifo(void)
+{
+	struct bpf_qdisc_fifo *fifo_skel;
+	struct bpf_link *link;
+
+	fifo_skel = bpf_qdisc_fifo__open_and_load();
+	if (!ASSERT_OK_PTR(fifo_skel, "bpf_qdisc_fifo__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(fifo_skel->maps.fifo);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		bpf_qdisc_fifo__destroy(fifo_skel);
+		return;
+	}
+
+	do_test("bpf_fifo");
+
+	bpf_link__destroy(link);
+	bpf_qdisc_fifo__destroy(fifo_skel);
+}
+
+void test_bpf_qdisc(void)
+{
+	struct netns_obj *netns;
+
+	netns = netns_new("bpf_qdisc_ns", true);
+	if (!ASSERT_OK_PTR(netns, "netns_new"))
+		return;
+
+	if (test__start_subtest("fifo"))
+		test_fifo();
+
+	netns_free(netns);
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
new file mode 100644
index 000000000000..65a2c561c0bb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _BPF_QDISC_COMMON_H
+#define _BPF_QDISC_COMMON_H
+
+#define NET_XMIT_SUCCESS        0x00
+#define NET_XMIT_DROP           0x01    /* skb dropped                  */
+#define NET_XMIT_CN             0x02    /* congestion notification      */
+
+#define TC_PRIO_CONTROL  7
+#define TC_PRIO_MAX      15
+
+#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
+
+u32 bpf_skb_get_hash(struct sk_buff *p) __ksym;
+void bpf_kfree_skb(struct sk_buff *p) __ksym;
+void bpf_qdisc_skb_drop(struct sk_buff *p, struct bpf_sk_buff_ptr *to_free) __ksym;
+void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, u64 expire, u64 delta_ns) __ksym;
+void bpf_qdisc_bstats_update(struct Qdisc *sch, const struct sk_buff *skb) __ksym;
+
+static struct qdisc_skb_cb *qdisc_skb_cb(const struct sk_buff *skb)
+{
+	return (struct qdisc_skb_cb *)skb->cb;
+}
+
+static inline unsigned int qdisc_pkt_len(const struct sk_buff *skb)
+{
+	return qdisc_skb_cb(skb)->pkt_len;
+}
+
+#endif
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
new file mode 100644
index 000000000000..0c7cfb82dae1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include "bpf_experimental.h"
+#include "bpf_qdisc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct skb_node {
+	struct sk_buff __kptr * skb;
+	struct bpf_list_node node;
+};
+
+private(A) struct bpf_spin_lock q_fifo_lock;
+private(A) struct bpf_list_head q_fifo __contains(skb_node, node);
+
+SEC("struct_ops/bpf_fifo_enqueue")
+int BPF_PROG(bpf_fifo_enqueue, struct sk_buff *skb, struct Qdisc *sch,
+	     struct bpf_sk_buff_ptr *to_free)
+{
+	struct skb_node *skbn;
+	u32 pkt_len;
+
+	if (sch->q.qlen == sch->limit)
+		goto drop;
+
+	skbn = bpf_obj_new(typeof(*skbn));
+	if (!skbn)
+		goto drop;
+
+	pkt_len = qdisc_pkt_len(skb);
+
+	sch->q.qlen++;
+	skb = bpf_kptr_xchg(&skbn->skb, skb);
+	if (skb)
+		bpf_qdisc_skb_drop(skb, to_free);
+
+	bpf_spin_lock(&q_fifo_lock);
+	bpf_list_push_back(&q_fifo, &skbn->node);
+	bpf_spin_unlock(&q_fifo_lock);
+
+	sch->qstats.backlog += pkt_len;
+	return NET_XMIT_SUCCESS;
+drop:
+	bpf_qdisc_skb_drop(skb, to_free);
+	return NET_XMIT_DROP;
+}
+
+SEC("struct_ops/bpf_fifo_dequeue")
+struct sk_buff *BPF_PROG(bpf_fifo_dequeue, struct Qdisc *sch)
+{
+	struct bpf_list_node *node;
+	struct sk_buff *skb = NULL;
+	struct skb_node *skbn;
+
+	bpf_spin_lock(&q_fifo_lock);
+	node = bpf_list_pop_front(&q_fifo);
+	bpf_spin_unlock(&q_fifo_lock);
+	if (!node)
+		return NULL;
+
+	skbn = container_of(node, struct skb_node, node);
+	skb = bpf_kptr_xchg(&skbn->skb, skb);
+	bpf_obj_drop(skbn);
+	if (!skb)
+		return NULL;
+
+	sch->qstats.backlog -= qdisc_pkt_len(skb);
+	bpf_qdisc_bstats_update(sch, skb);
+	sch->q.qlen--;
+
+	return skb;
+}
+
+SEC("struct_ops/bpf_fifo_init")
+int BPF_PROG(bpf_fifo_init, struct Qdisc *sch, struct nlattr *opt,
+	     struct netlink_ext_ack *extack)
+{
+	sch->limit = 1000;
+	return 0;
+}
+
+SEC("struct_ops/bpf_fifo_reset")
+void BPF_PROG(bpf_fifo_reset, struct Qdisc *sch)
+{
+	struct bpf_list_node *node;
+	struct skb_node *skbn;
+	int i;
+
+	bpf_for(i, 0, sch->q.qlen) {
+		struct sk_buff *skb = NULL;
+
+		bpf_spin_lock(&q_fifo_lock);
+		node = bpf_list_pop_front(&q_fifo);
+		bpf_spin_unlock(&q_fifo_lock);
+
+		if (!node)
+			break;
+
+		skbn = container_of(node, struct skb_node, node);
+		skb = bpf_kptr_xchg(&skbn->skb, skb);
+		if (skb)
+			bpf_kfree_skb(skb);
+		bpf_obj_drop(skbn);
+	}
+	sch->q.qlen = 0;
+}
+
+SEC(".struct_ops")
+struct Qdisc_ops fifo = {
+	.enqueue   = (void *)bpf_fifo_enqueue,
+	.dequeue   = (void *)bpf_fifo_dequeue,
+	.init      = (void *)bpf_fifo_init,
+	.reset     = (void *)bpf_fifo_reset,
+	.id        = "bpf_fifo",
+};
+
-- 
2.47.1


