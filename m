Return-Path: <bpf+bounces-34787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A00B930B1E
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 19:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE23B1F2186F
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 17:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F69D143C50;
	Sun, 14 Jul 2024 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hs0sEP56"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E8F142623;
	Sun, 14 Jul 2024 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720979500; cv=none; b=j/0lvQL6sJjexnIvi2dLRD0MNbc5Ey3ml6q4DjtQF7oW24LW1VQ7FtUH9zPEJqflBZXLZm3xsiulE2EvU+PHcSlbuOhXpK+yjCdt8MraWo9Y5iLRVvyDjulaFK22cFNsatgyVWg+ykxEu9KAUHL+ZI2C+ze9rjxwys8+k2TOHlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720979500; c=relaxed/simple;
	bh=Sw/GdMu+nwDZvnWUfqJSHIJRgPQ1+XXVghxePtb7M0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uwNkS0QsWi+hptBeA7b9ktnICxy0qFYqhA3fLxf0bosJJL9i+7auyyUbuRjCYgwBQaG6+4HJxjMS4DvnzWZ3XSnnZy6HGjyZkvF63QbZSanX9ZOGoPQXI5FEMWcb1jHM2eNkC4jzi5cOLr8iUxq5X8DxFoiWBmRuT2zInUqLIg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hs0sEP56; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-447f7c7c5fcso22399211cf.0;
        Sun, 14 Jul 2024 10:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720979497; x=1721584297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnvbTEalve2yrZBg4EjUwmO00l2W91aCisvFJUAqbig=;
        b=Hs0sEP567cX3ZXcsfpm0t72Qn6b4j4Ou0PF6sPZH9qX6B/OVM2dIJS0rAmQfGBqd/L
         uPDSsQHR6m12lyi+5r8/XuCpwt/TdlSYsaly2wzfQfjBSTWquz7bunTK685TBcJ1hTBC
         e0ao0vMcb3NoUsCjNTHDXF8SFZJTPuHpAZwINQehsokMyiyQfmoppkhsTBnyHsiRUEQz
         a/o9HddolVrxvf2IN3maB1QYyypya9LLx9xXcm38cWOLOO5xUwp9TTTtYKYq/m/sfGGz
         VCJVnNcF3e6LduFyGI+SqLUceGHcmTbYC6e4CIKj8fclD0gnBLtT73g4fctK2XDKjxQV
         JANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720979497; x=1721584297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnvbTEalve2yrZBg4EjUwmO00l2W91aCisvFJUAqbig=;
        b=k7KAuDB8I19wbPF4CquRVAhPOv+uHlWLSkfmBNxizDag2wpH6almp09iMy+KhfdraT
         7eLeERici4uN0dmCatcyJNYmyW0Cj7KYG7cRbaDUUTEEqBXgxW3wZ8qQLrBUAMkVQuo2
         ye+24pUwidVw4M+QMO4+9RYFNd/3qRCsnll40oMEhy3iASk0UC8MLWLl/2xe+wd8Zp3Y
         px8qazjGU4ow3xg592NagReTiqGQwHJmAyGW+ikPubOYVUjIDY2AB8KLOeVFPZHD9NAB
         ZkWWxuxDXI0sL5giu9Gj62LyCo5BCk4wzYj3kLbPb1WUQi+dT0mzqyaKrATKmjUULxax
         XA9w==
X-Gm-Message-State: AOJu0Yz37uUOmSgmjzupo6cWKMJi735C0DhX5w88uXRfd2D49UNXQ/Ua
	5+TEK6nb1N9ay4Ym3f5EFwX8Qnyt8aBvN1x1vPqUwz3diKFJ32+wa/SAEg==
X-Google-Smtp-Source: AGHT+IFXl1nyVnQVfMIQKIeRsmNfr5YJDNKM/yk4tkrC3iJQqIHZ57MqD4kjZT3Uzu0Id9ktQkp8PA==
X-Received: by 2002:a05:622a:1aa3:b0:446:39f9:1491 with SMTP id d75a77b69052e-447faa6f068mr231076051cf.42.1720979497501;
        Sun, 14 Jul 2024 10:51:37 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b7e1e38sm17010481cf.25.2024.07.14.10.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 10:51:37 -0700 (PDT)
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
Subject: [RFC PATCH v9 09/11] selftests: Add a basic fifo qdisc test
Date: Sun, 14 Jul 2024 17:51:28 +0000
Message-Id: <20240714175130.4051012-10-amery.hung@bytedance.com>
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

This selftest shows a bare minimum fifo qdisc, which simply enqueues skbs
into the back of a bpf list and dequeues from the front of the list.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 .../selftests/bpf/prog_tests/bpf_qdisc.c      | 161 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_qdisc_common.h    |  16 ++
 .../selftests/bpf/progs/bpf_qdisc_fifo.c      | 102 +++++++++++
 3 files changed, 279 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c

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
index 000000000000..6ffefbd43f0c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
@@ -0,0 +1,16 @@
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
+void bpf_skb_release(struct sk_buff *p) __ksym;
+void bpf_qdisc_skb_drop(struct sk_buff *p, struct bpf_sk_buff_ptr *to_free) __ksym;
+void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, u64 expire, u64 delta_ns) __ksym;
+
+#endif
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
new file mode 100644
index 000000000000..eb6272d36c77
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
@@ -0,0 +1,102 @@
+#include <vmlinux.h>
+#include "bpf_experimental.h"
+#include "bpf_qdisc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct skb_node {
+	struct sk_buff __kptr *skb;
+	struct bpf_list_node node;
+};
+
+#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
+
+private(A) struct bpf_spin_lock q_fifo_lock;
+private(A) struct bpf_list_head q_fifo __contains(skb_node, node);
+
+unsigned int q_limit = 1000;
+unsigned int q_qlen = 0;
+
+SEC("struct_ops/bpf_fifo_enqueue")
+int BPF_PROG(bpf_fifo_enqueue, struct sk_buff *skb, struct Qdisc *sch,
+	     struct bpf_sk_buff_ptr *to_free)
+{
+	struct skb_node *skbn;
+
+	if (q_qlen == q_limit)
+		goto drop;
+
+	skbn = bpf_obj_new(typeof(*skbn));
+	if (!skbn)
+		goto drop;
+
+	q_qlen++;
+	skb = bpf_kptr_xchg(&skbn->skb, skb);
+	if (skb) //unexpected
+		bpf_qdisc_skb_drop(skb, to_free);
+
+	bpf_spin_lock(&q_fifo_lock);
+	bpf_list_push_back(&q_fifo, &skbn->node);
+	bpf_spin_unlock(&q_fifo_lock);
+
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
+	q_qlen--;
+
+	return skb;
+}
+
+SEC("struct_ops/bpf_fifo_reset")
+void BPF_PROG(bpf_fifo_reset, struct Qdisc *sch)
+{
+	struct bpf_list_node *node;
+	struct skb_node *skbn;
+	int i;
+
+	bpf_for(i, 0, q_qlen) {
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
+			bpf_skb_release(skb);
+		bpf_obj_drop(skbn);
+	}
+	q_qlen = 0;
+}
+
+SEC(".struct_ops")
+struct Qdisc_ops fifo = {
+	.enqueue   = (void *)bpf_fifo_enqueue,
+	.dequeue   = (void *)bpf_fifo_dequeue,
+	.reset     = (void *)bpf_fifo_reset,
+	.id        = "bpf_fifo",
+};
+
-- 
2.20.1


