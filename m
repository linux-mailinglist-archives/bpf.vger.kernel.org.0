Return-Path: <bpf+bounces-54412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BADA69B9F
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 22:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D9C981B6D
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 21:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DB422155C;
	Wed, 19 Mar 2025 21:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdR7SGM/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E196C220686;
	Wed, 19 Mar 2025 21:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421262; cv=none; b=iqkfIjVdIMi3ixtg0WcBJBZ4+7pLL7UBLSFEO+E6Mu4TQWXcl7tZ3tuJXxbBCIeYEzwl3hAPwW2Hk11EA6euCXBeUrxL3ZaM+X0Dt0vNGc2+OVVBOSNX2HXrTKzFG0pX2M3hm6udhWC5X5EP/+zhxzhWhjTH/xd6WwkG+xuRMyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421262; c=relaxed/simple;
	bh=7oCmsNZ8473D2gAN3hzXmHGHBnHahfxBN0/mybaCK0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=epXGobFjA4uleQ927sgaeG8vk+8vbspely7KCVMHAqLuySsEYqMOTagF8IeSF4WRbPFeQnHZH/CRYUdYaj3P8Dj6s7fMplJ2GE10aJKOGvevdk4L/yMrQP/4gbOPO/2VNY1JKuy/I6SnPMZN1raO0XDq6FC3B76vRTZljunuZsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdR7SGM/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22438c356c8so770725ad.1;
        Wed, 19 Mar 2025 14:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742421260; x=1743026060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KChyYDIA43QzHoDj7a8SpWlMHUhtVWuxUFkLRAF6kHM=;
        b=HdR7SGM/aYOczB42cUglIJxblMKchViwJbmbyO/tE2e7QCVOpbJ4clVY7p9WkDxAjt
         Xg8uLwXeHKRkkLV+vcgxBByaySl+89ZorXlBhkTXDDJCiGGNi27YNyEbGwIlBbewRwNJ
         lJTK47aiqdX9YpDwIySs5G61LfZp5/QYUBe407kN+6MzPbICnFeKLRxGwog/ygC0U7Vo
         PjcB86m2TYoLqbUWlKTUHBsA7iDLCOXlYnjVxQl2a2C32v7hwQiAYIRndgUuw7A2RiH4
         glqJLYArvm77Jrj9gNT8yTHz9kxwc1Vyg8FRnJybAN6WFQimq3ghcw+Hg5i+DTPor3VW
         IdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421260; x=1743026060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KChyYDIA43QzHoDj7a8SpWlMHUhtVWuxUFkLRAF6kHM=;
        b=P7NP/XDXlwqYgk6PK72Dl9C8vffovu4G7ACe7UY5iOVpqiFAvh34sqo+iIGweSzbtz
         Kxq4B+70oz8bcWWt4IVbFRcLv2NUG8tVxM8RqccouKslre099cERwKLyfLc6zTz9GN/+
         pArO9NbGHfQK0H3ygdgICeVD6X3x4dETM0WlpW4UPcxgzwRwl4SvQNSUdCreyWbRjL7l
         nQV67TkZAuSllOfunSfPMHwlgfJfxjni09/01StnIBG72WMrnnM+E+0QKi9YMVM7VXtZ
         QA1iGvaWvg87yVJdqMSQmG+Kh5N3mK18UQ6uF1MVrz5X53yddESLwWBo4dJo43/BOlRv
         YiwQ==
X-Gm-Message-State: AOJu0YxFdXTwYFSsrHQ6onc/emyNoXXMpBzkLxhwQeGkVYGol0t61wzP
	AluzLVJnxz8Js9evj/c0LhjEcNAYFY5Xf2sO5PQ8nrmQCwzf7JiMnTw5XJwYCjs=
X-Gm-Gg: ASbGnctBLjlY3u/0Qi3WvPKZVQd99C4DJx9mTuKi+8T+OPCEK25CGHGxWABenvaDJki
	sim7jLvDBHdCS8G5+/Wnp81aYYest9T4Gcm7lbPvNfWymM8Zbn850rKNGASOEhVLpFnPtTusWw3
	SdCFi0cUXNDrP2XG1/YUPdycGSiu5mBzJfiuEB5icpSeuYGDnUn+BZFyZ7pmgJ85bhijts9Hwns
	7GKVMIn/KOCdxWWYpfH/5K1A/FGt+8vRSXAeDG40bBTRiq3vtEjP52cnBdhY3l32LZRoomHCJkJ
	WylkuUOuXri2D1WGFksttjtyqAOLf+0CtKMyiiKqw5YZRFeuabUTff+NcZ2Bm8KNjEmByUbjSzx
	choyg3ZtntSFvBmXxrUE=
X-Google-Smtp-Source: AGHT+IER4Wb+7sjIVeTNHgIin1FmwnOgqp5vlAgr+64pnKxRson9Vf15ODLw0A5H/Inu7ZpJd3u3VQ==
X-Received: by 2002:a05:6a20:2d23:b0:1f5:5b2a:f641 with SMTP id adf61e73a8af0-1fd116ff312mr1438602637.28.1742421259961;
        Wed, 19 Mar 2025 14:54:19 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116b0e8asm12175596b3a.158.2025.03.19.14.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:54:19 -0700 (PDT)
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
	juntong.deng@outlook.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 09/11] selftests/bpf: Add a basic fifo qdisc test
Date: Wed, 19 Mar 2025 14:53:56 -0700
Message-ID: <20250319215358.2287371-10-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250319215358.2287371-1-ameryhung@gmail.com>
References: <20250319215358.2287371-1-ameryhung@gmail.com>
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
 .../selftests/bpf/progs/bpf_qdisc_common.h    |  29 +++++
 .../selftests/bpf/progs/bpf_qdisc_fifo.c      | 119 ++++++++++++++++++
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
index 000000000000..24a83cdec7cd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
@@ -0,0 +1,29 @@
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
index 000000000000..a42024ce6c30
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
@@ -0,0 +1,119 @@
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
+#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
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


