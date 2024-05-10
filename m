Return-Path: <bpf+bounces-29536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B058C2A9B
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E89E2823D8
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0B17C082;
	Fri, 10 May 2024 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRes9vu1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C42355E75;
	Fri, 10 May 2024 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369067; cv=none; b=kQMxst43X8n4WAB4XIzzinCQh4cEffTuTEUColfM1K2da/uA+4aEy+DZuJ8VFqqBACojIdA593Q2VcpbC5p5m9XYXlHM1+t8Xnd0CblGnx9Pq9VCBZGDOSmGbr/eVPTj2rSN+/4XVDVu2P5jX/xxESGTVTYD129S1hqzD+liwIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369067; c=relaxed/simple;
	bh=X8JTZEt4CLyh8rSwnEp3audO/QsnByZlLOSQi/tN6RI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZebQShSY2sj3YTMNyrgh0QNef4Zt6NWucIuskO0rniQ9JQCzmoyGxzLc3iQ3vNtekhP8WUrFoP9eQL2MCIjrpd8lrwO5Zyf2sj/epmE6UOrFFU4uACU1fvYGbt3veV9w6RgugyKdpR9ZXM7dxKIJ4NntOoLpV2edcbSvBFM+GHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRes9vu1; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6a05f376effso17989216d6.0;
        Fri, 10 May 2024 12:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715369065; x=1715973865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCyraiy4VfnPbvydKak/xLiI2YOc9+4gv5Onslt4dC0=;
        b=iRes9vu1xVYDIIWrftLomj9v4QwMOh7c93/sGRSzbktEJJCa7eJhgddQdKhoH+vMeH
         ZWU3tx83jCwMm0AkmlgsH4ol9k4OVbqZwEMcVaZPh6l6Fz1MC6M/124I3MAew0KOjsgq
         L5xAnVWDemG/GvqbLIdbASUy3E/RNRSK8ex9+L3oxNjz4c0lDpOMwOH/kGMtGui/h9hr
         W0ArlBMdnKDaERI6BQzjLPuNyrczZDtBtz+fh5SGDkH2Dx7SuClZMMtcl6MI8h+rsMkY
         TJUaFz8hU6Q02j4N8wqCsZg7MbVJtmdpN1GuY/QgwdgaNLVC06IrRxlqPu3olarZ1xtT
         UI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715369065; x=1715973865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCyraiy4VfnPbvydKak/xLiI2YOc9+4gv5Onslt4dC0=;
        b=jg0GDqdOQep2f4kHfIUc1se9MnfAfXCXjdr3WCNKFfu73uLL0ual8w3kfHVkYBOvpE
         Jhnd6uqz0yMME8iV11+TfZwCy2Lif+NRgWBQTD6PdZP1Sl7bQKYE1QJ8QRtumfFYVnNX
         VWBaPOpj41QtCZ3gFA6/g8KYE/J+tGL/YKdQONj0xuJxcYmGf047lY7fua9/Fh4VRZd6
         ceutFEYPZMz1JTwTNi241mIYt9joZjaeC+Y1Rh1Jhc2xxqS+Xv6Q5r5L/h6o76KXNb0v
         DkbxfZwzElJVjWvmrQNmIs1xhmfTlIHTK1BwV22x9G2SbLCVCm8ah4qxKLrnM1ZwAvZH
         +cEQ==
X-Gm-Message-State: AOJu0YwbYeI49C5ci68n6jBV6y9+2hlFLAIUkzfupARCOuNTUUyfTEMf
	+8VxqYLTYkhjAWBW5KMgoL9vzUqkcx8sqP9CdlDgruBLSIm73k5YiKbzoA==
X-Google-Smtp-Source: AGHT+IHQcbKaoqUQe5Yu+hPiJ9h/Y1docuZVx6UMnXeuKEVSigP+I6iEa5AAujveEujJwSpTBZIoOA==
X-Received: by 2002:a05:6214:3a09:b0:6a0:84f8:6b85 with SMTP id 6a1803df08f44-6a16823d998mr41479096d6.53.1715369065003;
        Fri, 10 May 2024 12:24:25 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df5b46a26sm23863251cf.80.2024.05.10.12.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 12:24:24 -0700 (PDT)
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
Subject: [RFC PATCH v8 17/20] selftests: Add a basic fifo qdisc test
Date: Fri, 10 May 2024 19:24:09 +0000
Message-Id: <20240510192412.3297104-18-amery.hung@bytedance.com>
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

This selftest shows a bare minimum fifo qdisc, which simply enqueues skbs
into the back of a bpf list and dequeues from the front of the list.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 .../selftests/bpf/prog_tests/bpf_qdisc.c      | 161 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_qdisc_common.h    |  23 +++
 .../selftests/bpf/progs/bpf_qdisc_fifo.c      |  83 +++++++++
 3 files changed, 267 insertions(+)
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
index 000000000000..96ab357de28e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
@@ -0,0 +1,23 @@
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
+void bpf_skb_set_dev(struct sk_buff *skb, struct Qdisc *sch) __ksym;
+u32 bpf_skb_get_hash(struct sk_buff *p) __ksym;
+void bpf_skb_release(struct sk_buff *p) __ksym;
+void bpf_qdisc_skb_drop(struct sk_buff *p, struct bpf_sk_buff_ptr *to_free) __ksym;
+void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, u64 expire, u64 delta_ns) __ksym;
+bool bpf_qdisc_find_class(struct Qdisc *sch, u32 classid) __ksym;
+int bpf_qdisc_create_child(struct Qdisc *sch, u32 min,
+			   struct netlink_ext_ack *extack) __ksym;
+int bpf_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch, u32 classid,
+		      struct bpf_sk_buff_ptr *to_free_list) __ksym;
+struct sk_buff *bpf_qdisc_dequeue(struct Qdisc *sch, u32 classid) __ksym;
+
+#endif
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
new file mode 100644
index 000000000000..433fd9c3639c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
@@ -0,0 +1,83 @@
+#include <vmlinux.h>
+#include "bpf_experimental.h"
+#include "bpf_qdisc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
+
+private(B) struct bpf_spin_lock q_fifo_lock;
+private(B) struct bpf_list_head q_fifo __contains_kptr(sk_buff, bpf_list);
+
+unsigned int q_limit = 1000;
+unsigned int q_qlen = 0;
+
+SEC("struct_ops/bpf_fifo_enqueue")
+int BPF_PROG(bpf_fifo_enqueue, struct sk_buff *skb, struct Qdisc *sch,
+	     struct bpf_sk_buff_ptr *to_free)
+{
+	q_qlen++;
+	if (q_qlen > q_limit) {
+		bpf_qdisc_skb_drop(skb, to_free);
+		return NET_XMIT_DROP;
+	}
+
+	bpf_spin_lock(&q_fifo_lock);
+	bpf_list_excl_push_back(&q_fifo, &skb->bpf_list);
+	bpf_spin_unlock(&q_fifo_lock);
+
+	return NET_XMIT_SUCCESS;
+}
+
+SEC("struct_ops/bpf_fifo_dequeue")
+struct sk_buff *BPF_PROG(bpf_fifo_dequeue, struct Qdisc *sch)
+{
+	struct sk_buff *skb;
+	struct bpf_list_excl_node *node;
+
+	bpf_spin_lock(&q_fifo_lock);
+	node = bpf_list_excl_pop_front(&q_fifo);
+	bpf_spin_unlock(&q_fifo_lock);
+	if (!node)
+		return NULL;
+
+	skb = container_of(node, struct sk_buff, bpf_list);
+	bpf_skb_set_dev(skb, sch);
+	q_qlen--;
+
+	return skb;
+}
+
+static int reset_fifo(u32 index, void *ctx)
+{
+	struct bpf_list_excl_node *node;
+	struct sk_buff *skb;
+
+	bpf_spin_lock(&q_fifo_lock);
+	node = bpf_list_excl_pop_front(&q_fifo);
+	bpf_spin_unlock(&q_fifo_lock);
+
+	if (!node) {
+		return 1;
+	}
+
+	skb = container_of(node, struct sk_buff, bpf_list);
+	bpf_skb_release(skb);
+	return 0;
+}
+
+SEC("struct_ops/bpf_fifo_reset")
+void BPF_PROG(bpf_fifo_reset, struct Qdisc *sch)
+{
+	bpf_loop(q_qlen, reset_fifo, NULL, 0);
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


