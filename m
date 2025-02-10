Return-Path: <bpf+bounces-51023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13771A2F5A3
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7103A7D52
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D13B257AD7;
	Mon, 10 Feb 2025 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfygcYOv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392872566C4;
	Mon, 10 Feb 2025 17:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209448; cv=none; b=aw0Q9QADdn2TIGFslsfos8FanJUcwCCYkj/w2GAkHlS5BdmNDvcSJD+xBpWeT66m2OB3eRK3kDIoweZ53wet3KizUnPQHF6KragMgKxPxIu6vSlu4C9/nKDLs6A5nUzXrNzbrNjQ2sqsZhRODmD21w+ZIaC3mWfrc94IQHT+DCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209448; c=relaxed/simple;
	bh=RFTb05MOTvQ1XNo5zRefdOckyFOYcGFeYSohdaoDjRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+M+R1a7DJsQL8zZJYNtFRGiaKJ0dD5ajh7MFXGQ2aexEhF/k0b8/VIC8MoWLPG8toULHfVArwcjpSMv+ievuwnQJHpokH4c0yq8VoaJJvzpo8CUXsrZBMfZ0VS4peJjnSUrPbSeYuk0T5m4zvW/FUBIYjM7GV+zFP6cUt0XKog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfygcYOv; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fa48404207so4257359a91.1;
        Mon, 10 Feb 2025 09:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739209446; x=1739814246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uj2Ol0TrAZxxMAWaqZASaKyaG7rHi/lbAJ67oVFmDO8=;
        b=UfygcYOvslAgwfMZg2UCWFEZIYpHDEJQAHmOnFWDRcQnoDwqXo0IFqN1sgi8e3WePw
         +n7BFWvJJ9oWuQdEP0MDCn0uBYY4ZrTFmWV1TEDB463EdyJUJBOqqHISrzjThFwq0pc6
         A9xjh0pSwlt7ghGdVmimrNY2YU050J7eXWWtnI2E8Nv9IeUtps9GGB3o7T3JSoBRZOtR
         dnJ9lhEjs6Oz5cQzzoM0BjPHXV1iM+u4QlTn+EE9C4Q/f3QFVXzfeTnLk2w8+Lm0FlLq
         2/8aFrqfmJHDzQAeML/lz7cGXeqKMivUru0fM8BBMNw8DL1TrSkioYYgxOOlsUAQh4/X
         x+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209446; x=1739814246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uj2Ol0TrAZxxMAWaqZASaKyaG7rHi/lbAJ67oVFmDO8=;
        b=VXeFcXUyHLAdq/qAkThGEqbIWhRr96myO8AeUDNMcsSgIzTrGY63TG3qZHe81rZmFB
         5nhHirAt5x+xaAbVFTL3zTyVcTOncI2yknbjgMywQ64VMGKkAKoQMT+r6LVoA4AWbP7R
         ovq5GEcb/3PE5loYHOmJOCMoKCg6kXh6pa2Ftel83n5UlV1Aw0IVjyFW6+Sq3uyTIw4H
         /PIW7EquwHsp/kBreYppgLzTcmPsS/0dH1Sdlbg/gAgGWIUqv/rHvYkSFwvMxYZXpwCm
         iU5awUGgabL31KvzyDGorb1AuskSrBZaz9QVjtA2u6dGZwSEuDfCHl/T6FaqrJ68QzOc
         eSyQ==
X-Gm-Message-State: AOJu0YzspMaWx+utqvSXAnDpRVIig081iNawJq7n5N7GD85jUPUn+n3T
	UFYni/Uslx54OfaE1peW0A5nrhDOUd8aHCqZ+fCh7GgvDHuOrUSpW8pbphhh
X-Gm-Gg: ASbGncuDrP+itq773SRAXD3HpqqM3+h0lwySlawxkedxixSA5SGA0tPnUrzyjDNWlOb
	XQfzv4pCcz9qdE/osst5twri0CHSiyELA+0jnD27XI+LPtyQur6qcz3YSdqNdPx4tCrxAfMahX4
	PNM0dBZpMdjJdsTKxXh83zdIQ+g+wxbrCSxNSGLlVZOHZwjwIpBwg6DTI9LVmsouYljxTonOWlx
	syDwSOtz9c665tLAKnw5PNeRI0ygUnoRH0N2/JHQpzsoMethn8eJEwjqIwGodSqajVx1fxCZevF
	xuEnP3TsIfIFTxqMOlhgfObTsBXdGYdfiq5FpBdZwBk5F4Ds5t3h7Ha8jiFM2I7cRg==
X-Google-Smtp-Source: AGHT+IGdt1055JAv7BZ3s4mqMoumroYQSVN/OWuBk+S0sdxJXtOcgCSk4dINsvkr26ohQ0ya7gtvBw==
X-Received: by 2002:a17:90b:2888:b0:2f5:88bb:12f with SMTP id 98e67ed59e1d1-2fa24177731mr20014870a91.21.1739209446298;
        Mon, 10 Feb 2025 09:44:06 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa3fb55dcasm5554961a91.4.2025.02.10.09.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:44:05 -0800 (PST)
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
	cong.wang@bytedance.com,
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
Subject: [PATCH bpf-next v4 17/19] selftests/bpf: Add a basic fifo qdisc test
Date: Mon, 10 Feb 2025 09:43:31 -0800
Message-ID: <20250210174336.2024258-18-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210174336.2024258-1-ameryhung@gmail.com>
References: <20250210174336.2024258-1-ameryhung@gmail.com>
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


