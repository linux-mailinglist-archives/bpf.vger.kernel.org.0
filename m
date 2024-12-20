Return-Path: <bpf+bounces-47481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB459F9ADB
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 20:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAED616C6E6
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 19:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB6522915E;
	Fri, 20 Dec 2024 19:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXDdTG96"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0505F229128;
	Fri, 20 Dec 2024 19:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734724603; cv=none; b=MqOB60tcvHdrmFSE+mPsDRtY9GQiMIToOrY1uGL0/Iu8/vBVdDR0dB8V+B8vd42mzZH064xhPiCR9P+uQYPBUGGMeTnrZ+00lJQzzJRmmDty9d1ZJSH3vPPMDE4vlOKrFFDJJgObLt/q7kRdfNuo+N6nHYvu/CIZJM2acIjLAYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734724603; c=relaxed/simple;
	bh=LmGFr7ciPFl0uEsztDZ+TIQBnHOI8t5Sz+e8A+p2IlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9YvyECy1CWNSyppYvZ+v/EWCpjYfDeBwQTD4MkGG+Ok1tdgtVJRQvX/gLtgDJcJtQldo3+I3mxY5UFNNYRjP5H33yFQbPZgqoRWs85g+/Q4IKYzc6xqbxz0bBgKz2TDIA6oi62sIZ40p2W7HG45yYAy8+oQbvZujGVDb6i42jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXDdTG96; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-728ea1573c0so2076646b3a.0;
        Fri, 20 Dec 2024 11:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734724601; x=1735329401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KkoFeBG+yST4/Hwb8uolOPrVi+5DHCAbOjl4ev3y9k=;
        b=nXDdTG96WFCLNI8UyZHOhVa2kr4e7vP8j+7VVmG022h+OeMKso+vX7Emel/jO3XYET
         wbwjyBQvuuaL5EO2EpL+8J19py71jkDwsqeRj6WHIs0Y5C5RhiReWs30sQmIdXfrRBQM
         6F/Pk7kgAkmzdEGGLpHf73HMJlyr8fEs3VvbKTTd8PQMOPNh6OuCUvK1SUgvhCtXzOoM
         Ws2wiN8x1GCm6moIfe5XJr6J1Wfd5Hznk/oJNWfbOGt7WVYUyl0w91tgZJikZbhvMVEw
         vmJmO89v7gs2pIF5WzT6nAzMPlzeWnrCOAtAL7/HV8yJi0olZeN06lW6u3VhcDikiVdW
         oT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734724601; x=1735329401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KkoFeBG+yST4/Hwb8uolOPrVi+5DHCAbOjl4ev3y9k=;
        b=Q0ydf/6JTYbouoSR0qsI3KVQNKO5rmRsJOT26gVqJgVR0lO4My2S19M7YDiFF1DOdx
         YPhq1NxaCYGaS7Jea0yeedt8M28Sw9MS9OGnbx8oUXMSw+er5yLnPxkcmqgJdTcjTXeB
         o6GF3LTdhg5KCkI13EeCz6Q+pherrwPZZ/kR2vok8H09bwJD7X3HhtK+OkQjEEQjvS+x
         Bfxeo/k8vuxwFX9hhTnS4W0HHqC4k24DJtax7B+e/ejEoC7YqofVW6JTPnhsmhXNSaiR
         h0PiJ3hQ7FYoh2ZYMm05+OygwayaOlYjaz3cPXXDYZX3TjjPFGKCg9X+ASy996qJ/7CJ
         SkcA==
X-Gm-Message-State: AOJu0YzG9Z1Cdm6v2w7Gzulnc/3vEbW6x63TTxxW9k2fVv3h4KGVohDX
	aOSmldqqZV0l/zXp2dJQt4xnB4TlLJser1iDGbCT3DSBLaeDNi5e9wmu9A==
X-Gm-Gg: ASbGncszKT1K6c85KJNjZdReMqSvW3SR7RuGUI90bTihxBgidlTrLA8EkSNzNjPZ+hx
	4mqM3rugsQFttL6eP49lfYBAywBfbkN8njvBYo/Ui5WjnEu7p3jqwkn+JA1S7NzU5AjR8amKiaS
	O2CcrcL+Us2YqOMyVXFp5aRHr0DBIfkNy7sMh5fR59p/sqtTNcFXj8pQ42PLMiwGl1qr00nt2nI
	zjroEThe+G9wPn411AUD6HRrOu2yx3JpAzP6RbYJi/0AqxyL0HadWy+6dJURZqg3/nuhbmYeLhY
	7FBTqB0aE9zJ5IXjSyj8Igi2jhI6ebIJ
X-Google-Smtp-Source: AGHT+IHr5Mkl6vSRfDdzDsaMXXcQjHIroHKJr3ty4gHJfKOki7D40zdOH4Xw6fPbSTd+iq1MCnob6g==
X-Received: by 2002:a05:6a21:9103:b0:1e0:d766:8da1 with SMTP id adf61e73a8af0-1e5e083e4f5mr7389502637.39.1734724601151;
        Fri, 20 Dec 2024 11:56:41 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b17273dasm3240342a12.19.2024.12.20.11.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 11:56:40 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	amery.hung@bytedance.com
Subject: [PATCH bpf-next v2 13/14] selftests: Add a basic fifo qdisc test
Date: Fri, 20 Dec 2024 11:55:39 -0800
Message-ID: <20241220195619.2022866-14-amery.hung@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220195619.2022866-1-amery.hung@gmail.com>
References: <20241220195619.2022866-1-amery.hung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

This selftest shows a bare minimum fifo qdisc, which simply enqueues skbs
into the back of a bpf list and dequeues from the front of the list.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/bpf_qdisc.c      | 161 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_qdisc_common.h    |  27 +++
 .../selftests/bpf/progs/bpf_qdisc_fifo.c      | 117 +++++++++++++
 4 files changed, 306 insertions(+)
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
index 000000000000..295d0216e70f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -0,0 +1,161 @@
+#include <linux/pkt_sched.h>
+#include <linux/rtnetlink.h>
+#include <test_progs.h>
+
+#include "network_helpers.h"
+#include "bpf_qdisc_fifo.skel.h"
+
+#ifndef ENOTSUPP
+#define ENOTSUPP 524
+#endif
+
+#define LO_IFINDEX 1
+
+static const unsigned int total_bytes = 10 * 1024 * 1024;
+static int stop;
+
+static void *server(void *arg)
+{
+	int lfd = (int)(long)arg, err = 0, fd;
+	ssize_t nr_sent = 0, bytes = 0;
+	char batch[1500];
+
+	fd = accept(lfd, NULL, NULL);
+	while (fd == -1) {
+		if (errno == EINTR)
+			continue;
+		err = -errno;
+		goto done;
+	}
+
+	if (settimeo(fd, 0)) {
+		err = -errno;
+		goto done;
+	}
+
+	while (bytes < total_bytes && !READ_ONCE(stop)) {
+		nr_sent = send(fd, &batch,
+			       MIN(total_bytes - bytes, sizeof(batch)), 0);
+		if (nr_sent == -1 && errno == EINTR)
+			continue;
+		if (nr_sent == -1) {
+			err = -errno;
+			break;
+		}
+		bytes += nr_sent;
+	}
+
+	ASSERT_EQ(bytes, total_bytes, "send");
+
+done:
+	if (fd >= 0)
+		close(fd);
+	if (err) {
+		WRITE_ONCE(stop, 1);
+		return ERR_PTR(err);
+	}
+	return NULL;
+}
+
+static void do_test(char *qdisc)
+{
+	DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook, .ifindex = LO_IFINDEX,
+			    .attach_point = BPF_TC_QDISC,
+			    .parent = TC_H_ROOT,
+			    .handle = 0x8000000,
+			    .qdisc = qdisc);
+	struct sockaddr_in6 sa6 = {};
+	ssize_t nr_recv = 0, bytes = 0;
+	int lfd = -1, fd = -1;
+	pthread_t srv_thread;
+	socklen_t addrlen = sizeof(sa6);
+	void *thread_ret;
+	char batch[1500];
+	int err;
+
+	WRITE_ONCE(stop, 0);
+
+	err = bpf_tc_hook_create(&hook);
+	if (!ASSERT_OK(err, "attach qdisc"))
+		return;
+
+	lfd = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
+	if (!ASSERT_NEQ(lfd, -1, "socket")) {
+		bpf_tc_hook_destroy(&hook);
+		return;
+	}
+
+	fd = socket(AF_INET6, SOCK_STREAM, 0);
+	if (!ASSERT_NEQ(fd, -1, "socket")) {
+		bpf_tc_hook_destroy(&hook);
+		close(lfd);
+		return;
+	}
+
+	if (settimeo(lfd, 0) || settimeo(fd, 0))
+		goto done;
+
+	err = getsockname(lfd, (struct sockaddr *)&sa6, &addrlen);
+	if (!ASSERT_NEQ(err, -1, "getsockname"))
+		goto done;
+
+	/* connect to server */
+	err = connect(fd, (struct sockaddr *)&sa6, addrlen);
+	if (!ASSERT_NEQ(err, -1, "connect"))
+		goto done;
+
+	err = pthread_create(&srv_thread, NULL, server, (void *)(long)lfd);
+	if (!ASSERT_OK(err, "pthread_create"))
+		goto done;
+
+	/* recv total_bytes */
+	while (bytes < total_bytes && !READ_ONCE(stop)) {
+		nr_recv = recv(fd, &batch,
+			       MIN(total_bytes - bytes, sizeof(batch)), 0);
+		if (nr_recv == -1 && errno == EINTR)
+			continue;
+		if (nr_recv == -1)
+			break;
+		bytes += nr_recv;
+	}
+
+	ASSERT_EQ(bytes, total_bytes, "recv");
+
+	WRITE_ONCE(stop, 1);
+	pthread_join(srv_thread, &thread_ret);
+	ASSERT_OK(IS_ERR(thread_ret), "thread_ret");
+
+done:
+	close(lfd);
+	close(fd);
+
+	bpf_tc_hook_destroy(&hook);
+	return;
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
+	if (test__start_subtest("fifo"))
+		test_fifo();
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
2.47.0


