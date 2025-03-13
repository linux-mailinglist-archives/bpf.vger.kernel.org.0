Return-Path: <bpf+bounces-53994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EE4A60076
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 20:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C863422A46
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 19:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B845A1F4627;
	Thu, 13 Mar 2025 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmQUlX8D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7D41F4284;
	Thu, 13 Mar 2025 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741892612; cv=none; b=jokMyWsuZxiwRKiqCGjU5oa872z8fq5mp1ELD6lO234waMBcMYWMEpV4vzPYEpkXt2wuZuxkDam+sXVuC0ZziH90P1IOyhA0Ag19CYyPTFERPl4t5kOtKvtTGRUDtnjtDAOWYBbwU9l8rK6NQM6i7ELcYwBDqiRIYtbontqGzes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741892612; c=relaxed/simple;
	bh=RFTb05MOTvQ1XNo5zRefdOckyFOYcGFeYSohdaoDjRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYdVrw7wYwebSdvztSizBiAkRd6lckxpNzqn1dQFbs/jEyglr1fq0KZn/oDqju6wQ9+pokaz+NoYSDQgDFKJ8F1LphXB8Hp+tVQI5QSq9iJlTckeM6Q7ZvPle3p187taaNmUfs6pLmSxYo+s+R/7detdgfRbRIjeWkUjFre7byY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmQUlX8D; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22398e09e39so29040305ad.3;
        Thu, 13 Mar 2025 12:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741892610; x=1742497410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uj2Ol0TrAZxxMAWaqZASaKyaG7rHi/lbAJ67oVFmDO8=;
        b=LmQUlX8DSVIGQH6zLQ8Pjr+VoQ1JH5yfao7W0a2KMVGh0+kWjlQtMuIM+Lp/69NqFN
         A49rWsVy8FM6hAKuJNc/1vX5b5Fg5bLD45L5oKbCHP2h0QokaboK4jlNRzOJhB4PRsmP
         xgLEDNzdRcspZn4/38aNmikWoGiIIiop/P06WsUXzoCnuwTdPm+YmmI97p6IMH8vk3H7
         rO/T0bZLXz9yv3wyY2jxlM4EHVpdy0o94jG2IKiby+RerVPI7yelpTdvtlk19Hln/1wd
         WA+BY0Fa2b0+ZcuKvGUrQBRxKtLE/VsELNHP9FgP7M4/bAioG6GWb5LMEBv1bNe5qdhb
         0Xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741892610; x=1742497410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uj2Ol0TrAZxxMAWaqZASaKyaG7rHi/lbAJ67oVFmDO8=;
        b=aAY6w4C5M+sQcZpSQK6WU6PN5ynuy3gOO9noxAYxbSAw2C/x3eIosc50T6JVQHmjsf
         waJwVUiZFjyMYdNdo8cdn8ydgr5xlZb3GGgXLSZaNJOGMV/14CyI6LKr2B8AJebwxVGq
         txKlwXldFm4hNqszKSeSdHA0N7NQWoBBrXlosBM960VYWCkwq84PYPvGdOp+/xJaQai1
         MxZp8vdYc6xFD/mAEBdQpZYWdwUP57LpuzJcSXDCb2RnMUzrJ+Je+Kg2q8HQjpwxVVFC
         0LrUMuK39wiI2jkR/dXPQ7mkjDQ7Rr+l0qF2xU65QhzD/V8BnsKLKUnonD0PWgYM4vJV
         E9LA==
X-Gm-Message-State: AOJu0YwWwrm6kTNZTmSQ6k/huFtwbVsdcCMv/sv6eu+SV7wasNujXSwr
	nDUOZY7iWn7zszVkXrWjGc3vlA4dc2P627hygbHkWQlpDL9uhEulzxMTZUIwUaui/g==
X-Gm-Gg: ASbGnctFSJ++8VOcrb49ClYSVdWFiiJznSeRoJztCwvbUGFzHOJot4YBWHu+9ALWGV2
	KartlZmr62Qh+TlAMTs7n3+twFoENMNy7FXNG9cicQO9fxwwwjOSh4OeNvbuZB826Nu8jchqqfs
	4FlSih3icHJURFre9yDUM2eE7zRywAs/UP+42PshYD6Qgi9R4GS0b2TWuKrWakUeqwH31QCdHkK
	XLu0DNnHJFeupcjfiDxr40gckiihTM/0FCHXtuazqDquiee4FUkbwrrnu8pFic95t9rmjasEaT9
	tYl7K8O8RfRpQeFmdUcFz/oa0ru4T2gz7m1JNA2RoMDd72wphqaqIB8fGdBQ9o22JevKeFh2AMp
	ZwXurmGt2ORRKgOh047s=
X-Google-Smtp-Source: AGHT+IFkRgRGR3e8eA+mzEY5bk2juvLiCAbfN8lGzjxyPO9UmOxlQb974X5DyIsq/jmmHjsDVGO8wQ==
X-Received: by 2002:a05:6a21:62c8:b0:1d9:c615:d1e6 with SMTP id adf61e73a8af0-1f5bd5b7d9cmr1355525637.0.1741892609816;
        Thu, 13 Mar 2025 12:03:29 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9e2f45sm1652505a12.29.2025.03.13.12.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 12:03:29 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 11/13] selftests/bpf: Add a basic fifo qdisc test
Date: Thu, 13 Mar 2025 12:03:05 -0700
Message-ID: <20250313190309.2545711-12-ameryhung@gmail.com>
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

This selftest includes a bare minimum fifo qdisc, which simply enqueues
sk_buffs into the back of a bpf list and dequeues from the front of the
list.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  79 ++++++++++++
 .../selftests/bpf/progs/bpf_qdisc_common.h    |  27 ++++
 .../selftests/bpf/progs/bpf_qdisc_fifo.c      | 117 ++++++++++++++++++
 4 files changed, 224 insertions(+)
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
index 000000000000..f2efc69af348
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -0,0 +1,79 @@
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
index 000000000000..62a778f94908
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
@@ -0,0 +1,27 @@
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
index 000000000000..705e7da325da
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
@@ -0,0 +1,117 @@
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


