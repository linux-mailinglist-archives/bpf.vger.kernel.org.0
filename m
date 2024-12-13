Return-Path: <bpf+bounces-46957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF359F1A13
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 00:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2BE16B299
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801611F4E5B;
	Fri, 13 Dec 2024 23:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="amS6IQYG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC3F1F2C5C
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 23:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132619; cv=none; b=fhZ9ZxdN3ISOZQsIqBLRZJJv6TN0JL+CT+thRMCgYnEBNSpZNlIsJiLn+wX5MgoJv6CiLfGlT0GKgMVphrdzQN37n3QHRl3NSg996e9LWxFAXjl9YP/Jap1qpehnnu6Que5/Nc10DnegiFO3Nx72ScUeKwfDytgx12+3/lBjuK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132619; c=relaxed/simple;
	bh=zkOCx9fEVcuuqsnmNZ34ovCXQmFDFRNUTii418FycEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lSGkuteH/LnJH7Aj7SBy9/icoVv8IzHFryv63ri3tngeclBuNmP7KrojL70RQRLBuiY4i4KIlDJ99SBVqF6kGKD9fWKUT9nuuU7jWFKpevHVszXSk17s/U3YZO7C/S3bEjtyRKaUBx3ImZezID14dnR0AwnDjBm8lAceU90Wpvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=amS6IQYG; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b68e73188cso268417285a.0
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 15:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734132616; x=1734737416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkJpbIrUvCjlO7FumYI/XkKLoDSIiksX//uFYPHYx0Q=;
        b=amS6IQYGClvxA8RFe1iFPY7ljyk5W/wX6w7EeAV8KKnlI9Z3BLqsnQTQvB0BqAzLee
         H5eaU8fevPtVQI8xHGl/jqD3mh7my0bt9C6KSZivpBMGBtP721605l7PzKsim83Y47VR
         KTu4RbNHMCRAKyxn4+QR2GI17eO76m6614YMhN5RaOtVECt3IfT93+4ULUgigW/yWSzy
         TI6rQrrmqtzzD5pRMGAxV10KMv3k+YqfLjxkRTKRvBJXjqSQJAtU3hCd1VDhDNKlRlt/
         zu4h+SJSXGcUp4ZG95Vu4k5Z3i+jZBnPxMSXzCYN8aSnMA38s4FFrdi3yIoku1krkvMo
         LZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734132616; x=1734737416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkJpbIrUvCjlO7FumYI/XkKLoDSIiksX//uFYPHYx0Q=;
        b=tywfl8bT/4kcQWWi/myhhfP9/4fzggLgAOnbHksjNwKSM7+rpkO9pP1o8VRPqyW21B
         Qad4RanwtyvldsEKDJHISxadXqlTHH80ribDXBtH6GvM4tHqqJBypvy8GtT3hh32VC2u
         JJtAs2a6Jo4ixmsSW39A36EPjBrOVqdTA46hfm3OSxC3U8usWYIL4FuGKLZOeihLtS69
         X0BpCm2FKazxyLYonff+Hr5MvdJKfMFehg8FYL6qjTFnjGj3zp/ZA2chQwS2g34CgjsR
         f6MkzPi8/sH8vP3GfjGkPt/jzR1CpRUbc59vCbgvhZFXJ1IHGxcQTTfGcoNhLm2RgDNe
         VBWw==
X-Gm-Message-State: AOJu0Yxp6ZJ0g3TBve1p/BPr+A0VX92Q9f4NVBIbbLCzbGQbIv8wXo0N
	amUtdlO8MWLbnJ3qEGCU97PoQc3qEBwmj1fdxCXTYkf5D/MH3q8IRNWVtcTgml8=
X-Gm-Gg: ASbGncvdfWx0AYwPc8qu/3zBcBlwdimeA6UUlveq64vzGDVqvAUp5onBeog6VxVHZEU
	75Hb4QtefnDXqiNaX0FkYhUBbsoLBFxjpmvjLjFIvswzSrJI05TYEb4BBTFKtI2a2zGPUHtxzJo
	qdh9ICYuKF4CKV+KSvQINNmtx78eIKXKVvuYlv/hWlp+MPzBrnZ7xsxRr0SKR35xPmWOWAkZ4HZ
	pXrU+2KEufdk1956RiQ92e2cNvmn17/uKIQG1/eclt20tWI/TY8rcHZNgG5DqboQMWfkxu+r4/I
X-Google-Smtp-Source: AGHT+IF6hkt0GS8haa9WAqQFP726yw1CCl2JAzNKOkLXC1pdkOhPxJQJf4vvq8nhh5fsfj18QCulcw==
X-Received: by 2002:a05:620a:27d1:b0:7b6:d0bd:c7e6 with SMTP id af79cd13be357-7b6fbf15179mr660740385a.32.1734132616104;
        Fri, 13 Dec 2024 15:30:16 -0800 (PST)
Received: from n36-183-057.byted.org ([130.44.215.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047d4a20sm25805085a.39.2024.12.13.15.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 15:30:15 -0800 (PST)
From: Amery Hung <amery.hung@bytedance.com>
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
	ameryhung@gmail.com
Subject: [PATCH bpf-next v1 12/13] selftests: Add a basic fifo qdisc test
Date: Fri, 13 Dec 2024 23:29:57 +0000
Message-Id: <20241213232958.2388301-13-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241213232958.2388301-1-amery.hung@bytedance.com>
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
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
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/bpf_qdisc.c      | 161 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_qdisc_common.h    |  27 +++
 .../selftests/bpf/progs/bpf_qdisc_fifo.c      | 117 +++++++++++++
 4 files changed, 306 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 4ca84c8d9116..cf35e7e473d4 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -70,6 +70,7 @@ CONFIG_NET_IPGRE=y
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
2.20.1


