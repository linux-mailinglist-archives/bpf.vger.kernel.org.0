Return-Path: <bpf+bounces-45858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7269DBE65
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 02:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13782164B90
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 01:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AC560DCF;
	Fri, 29 Nov 2024 01:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwHhdnV1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B894B40BE5;
	Fri, 29 Nov 2024 01:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732843361; cv=none; b=KrUtbNQfaOI9rLzUi6LyOVeSRyime4NAdt6jYWPPj8H4pZ4zTSCRRvI0jH0ClDBATmT5XR4qaMPicPhLjog3AC2OETaigEhw+ChA7yeF3CLdTpDwUSkSwv1HChoGrgYBh4mfy5ghIgM9l+CG4JojNoMv8ONneNx1sem/+aDbGhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732843361; c=relaxed/simple;
	bh=J2jrEWju1jVKn0vlRKQ9FBdIPh81YXEU56bdDxRNoNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e+Fz/hIV1zdE/SYSlWI5VZvOp41Xk7dhC1I5T93E2lXQRkuPSVTd715+t+tDgRWiAlNeB6bhqht9B97nRqi9t3n428cVhHCDYhdM7XKXA86pwtlUhUmJ4Xnc20ZMZ+YRHln25agHcaAyHl5RTZybyS5fiD9WVJVRvRRAY/P0oew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwHhdnV1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2153a73edd5so2643175ad.2;
        Thu, 28 Nov 2024 17:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732843359; x=1733448159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBHjmnFgNYCxWG5JxN+rt+rQGcx0todJSez7JTwI7wM=;
        b=YwHhdnV183bg+EEWCfX6S7LGX3MQFCcB8PmRzz4T8zFlkUjGop1fXyn39H0FNmfsBE
         K+Phg7rBB2O5OAC7liqmp9gy+UcysKAb2a3xbi0JwKHL41utg3vMNqS63x1sUC75YwFK
         NYdOAJnES2fC5RTEMnIRyv21b+IA6Vq4IccJ+pg9ZwgJVZFtHGKvUpLhCJMd+I+R2i3j
         BKz2I6TfRiJuKRQHolflTrFylDGZn3NDzmhdGUjPLWdTvBl3NDOmGJ7nXehwuVv9Ji8t
         jE19v7jPgfacuK5a9XIYgWQ+XgZEpCbBeWL9M/TCbEP0sGsoAtHGAqI5e95szOgNXvwg
         kACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732843359; x=1733448159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBHjmnFgNYCxWG5JxN+rt+rQGcx0todJSez7JTwI7wM=;
        b=RzXGqjU9+AAnQI4NkO05RRFzuSqQL7jVJy6wZCaFJJG4+LnYRr/5vUd2y0T7R6rnnz
         Q9c9ubf2cQk9qsLUhSzvZ0PgpvDIdfvuQkvgpBBN1rKR0X0HmJ2JSP/0ESM25J7DZg8X
         qSyTZ0nw3t2ar7RpHeZYiP6KSUcnB4TF811Xlv/wrby2bN08Xd/n4g72+3lmt12DQP6J
         /I0aWOIRrVUklfLPS3QfBiEBS5cGgte9pZ+yeGJmos6KK5tLrUa+Gj1R70hzAZ1Z1/9k
         NnnqH20AYzEeU21nJ1vTrUF0ij5vNvjKJNgR0sFJ9v8+OoFdUyOeXaoGid9BrbKzwugB
         fwUA==
X-Gm-Message-State: AOJu0YyjR1wiG/ceC+uliE82rQDB/oD/wHpmPU3N8J4QQ9+IaLXdT1c6
	rWcZNQ1LuCBv0+jLE11KMExmm7xgILzitrL4sYFoLPC6nIiPrX8IRjpY3g==
X-Gm-Gg: ASbGncsUEnl/hMaXCXslP+Q3etKbgH2Hpa/o8J8INMJK5iwDYvOnv2tUP277MYs7hxA
	2CoxEp9IL6nI1xzfOUNhQCT/azexwmyBhin+u85EVv+wj6SZlwtB+QWP4yleXF3u6MD8AM/h532
	G5fjI36H3IjMHfNvjfj9/BRizWQ+JLKgpplNJzktnocpEay7gZvS2bHyzDhxMynn9rXna1o44gW
	zdnKtOCnEfAIS+TAct0bFRgEh+29NowMn8QTnLS6kIZZGEe+F9DFHKUiJ6d1AYFh0Gur61w7a1G
	8wI=
X-Google-Smtp-Source: AGHT+IHwh700/BckVWRm/rz1ESuNAcWfcqgdTpUXx25M+SH7jPkgDqD/3jgnKuaDATNhGTjxJeYZ8g==
X-Received: by 2002:a17:902:ec8f:b0:20c:62e1:6361 with SMTP id d9443c01a7336-215018579admr125549245ad.25.1732843358658;
        Thu, 28 Nov 2024 17:22:38 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:7990:ba58:c520:e7e8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521905120sm20010215ad.80.2024.11.28.17.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 17:22:38 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [Patch bpf v2 4/4] selftests/bpf: Test bpf_skb_change_tail() in TC ingress
Date: Thu, 28 Nov 2024 17:22:21 -0800
Message-Id: <20241129012221.739069-5-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241129012221.739069-1-xiyou.wangcong@gmail.com>
References: <20241129012221.739069-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

Similarly to the previous test, we also need a test case to cover
positive offsets as well, TC is an excellent hook for this.

Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Zijian Zhang <zijianzhang@bytedance.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 .../selftests/bpf/prog_tests/tc_change_tail.c |  78 ++++++++++++
 .../selftests/bpf/progs/test_tc_change_tail.c | 114 ++++++++++++++++++
 2 files changed, 192 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_change_tail.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tc_change_tail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_change_tail.c b/tools/testing/selftests/bpf/prog_tests/tc_change_tail.c
new file mode 100644
index 000000000000..110f54a71a35
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tc_change_tail.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <error.h>
+#include <test_progs.h>
+#include <linux/pkt_cls.h>
+
+#include "test_tc_change_tail.skel.h"
+#include "socket_helpers.h"
+
+#define LO_IFINDEX 1
+
+void test_tc_change_tail(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook, .ifindex = LO_IFINDEX,
+			.attach_point = BPF_TC_INGRESS);
+	DECLARE_LIBBPF_OPTS(bpf_tc_opts, opts);
+	struct test_tc_change_tail *skel = NULL;
+	bool hook_created = false;
+	int ret, fd;
+	int c1, p1;
+	char buf[2];
+
+	skel = test_tc_change_tail__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_tc_change_tail__open_and_load"))
+		return;
+	ret = bpf_tc_hook_create(&hook);
+	if (ret == 0)
+		hook_created = true;
+	ret = ret == -EEXIST ? 0 : ret;
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
+		goto destroy;
+	fd = bpf_program__fd(skel->progs.change_tail);
+	opts.prog_fd = fd;
+	opts.handle = 1;
+	opts.priority = 1;
+	opts.flags = BPF_TC_F_REPLACE;
+	ret = bpf_tc_attach(&hook, &opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach"))
+		goto hook_destroy;
+
+	ret = create_pair(AF_INET, SOCK_STREAM, &c1, &p1);
+	if (!ASSERT_OK(ret, "create_pair"))
+		goto detach;
+
+	ret = xsend(p1, "Tr", 2, 0);
+	ASSERT_EQ(ret, 2, "xsend(p1)");
+	ret = recv(c1, buf, 2, 0);
+	ASSERT_EQ(ret, 2, "recv(c1)");
+	ASSERT_EQ(skel->data->change_tail_ret, 0, "change_tail_ret");
+
+	ret = xsend(p1, "G", 1, 0);
+	ASSERT_EQ(ret, 1, "xsend(p1)");
+	ret = recv(c1, buf, 1, 0);
+	ASSERT_EQ(ret, 1, "recv(c1)");
+	ASSERT_EQ(skel->data->change_tail_ret, 0, "change_tail_ret");
+
+	ret = xsend(p1, "E", 1, 0);
+	ASSERT_EQ(ret, 1, "xsend(p1)");
+	ret = recv(c1, buf, 1, 0);
+	ASSERT_EQ(ret, 1, "recv(c1)");
+	ASSERT_EQ(skel->data->change_tail_ret, -EINVAL, "change_tail_ret");
+
+	ret = xsend(p1, "Z", 1, 0);
+	ASSERT_EQ(ret, 1, "xsend(p1)");
+	ret = recv(c1, buf, 1, 0);
+	ASSERT_EQ(ret, 1, "recv(c1)");
+	ASSERT_EQ(skel->data->change_tail_ret, -EINVAL, "change_tail_ret");
+
+	close(c1);
+	close(p1);
+detach:
+	bpf_tc_detach(&hook, &opts);
+hook_destroy:
+	if (hook_created)
+		bpf_tc_hook_destroy(&hook);
+destroy:
+	test_tc_change_tail__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_tc_change_tail.c b/tools/testing/selftests/bpf/progs/test_tc_change_tail.c
new file mode 100644
index 000000000000..735c7325a2ab
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_tc_change_tail.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <linux/if_ether.h>
+#include <linux/in.h>
+#include <linux/ip.h>
+#include <linux/tcp.h>
+#include <linux/pkt_cls.h>
+
+long change_tail_ret = 1;
+
+static __always_inline struct iphdr *parse_ip_header(struct __sk_buff *skb, int *ip_proto)
+{
+	void *data_end = (void *)(long)skb->data_end;
+	void *data = (void *)(long)skb->data;
+	struct ethhdr *eth = data;
+	struct iphdr *iph;
+
+	/* Verify Ethernet header */
+	if ((void *)(data + sizeof(*eth)) > data_end)
+		return NULL;
+
+	/* Skip Ethernet header to get to IP header */
+	iph = (void *)(data + sizeof(struct ethhdr));
+
+	/* Verify IP header */
+	if ((void *)(data + sizeof(struct ethhdr) + sizeof(*iph)) > data_end)
+		return NULL;
+
+	/* Basic IP header validation */
+	if (iph->version != 4)  /* Only support IPv4 */
+		return NULL;
+
+	if (iph->ihl < 5)  /* Minimum IP header length */
+		return NULL;
+
+	*ip_proto = iph->protocol;
+	return iph;
+}
+
+static __always_inline struct tcphdr *parse_tcp_header(struct __sk_buff *skb, struct iphdr *iph)
+{
+	void *data_end = (void *)(long)skb->data_end;
+	void *hdr = (void *)iph;
+	struct tcphdr *tcp;
+
+	/* Calculate TCP header position */
+	tcp = hdr + (iph->ihl * 4);
+	hdr = (void *)tcp;
+
+	/* Verify TCP header bounds */
+	if ((void *)(hdr + sizeof(*tcp)) > data_end)
+		return NULL;
+
+	/* Basic TCP validation */
+	if (tcp->doff < 5) /* Minimum TCP header length */
+		return NULL;
+
+	/* Success */
+	return tcp;
+}
+
+SEC("tc")
+int change_tail(struct __sk_buff *skb)
+{
+	int len = skb->len;
+	struct tcphdr *tcp;
+	struct iphdr *iph;
+	void *data_end;
+	char *payload;
+	int ip_proto;
+
+	bpf_skb_pull_data(skb, len);
+
+	data_end = (void *)(long)skb->data_end;
+	iph = parse_ip_header(skb, &ip_proto);
+	if (!iph)
+		return TC_ACT_OK;
+
+	if (ip_proto != IPPROTO_TCP) /* Only support TCP packets */
+		return TC_ACT_OK;
+
+	tcp = parse_tcp_header(skb, iph);
+	if (!tcp)
+		return TC_ACT_OK;
+
+	payload = (char *)tcp + (tcp->doff * 4);
+	if (payload + 1 > (char *)data_end)
+		return TC_ACT_OK;
+
+	if (payload[0] == 'T') {
+		change_tail_ret = bpf_skb_change_tail(skb, len - 1, 0);
+		/* Change it back to make TCP happy */
+		if (change_tail_ret == 0)
+			bpf_skb_change_tail(skb, len, 0);
+		return TC_ACT_OK;
+	} else if (payload[0] == 'G') {
+		change_tail_ret = bpf_skb_change_tail(skb, len + 1, 0);
+		/* Change it back to make TCP happy */
+		if (change_tail_ret == 0)
+			bpf_skb_change_tail(skb, len, 0);
+		return TC_ACT_OK;
+	} else if (payload[0] == 'E') {
+		change_tail_ret = bpf_skb_change_tail(skb, 65535, 0); /* Should fail */
+		return TC_ACT_OK;
+	} else if (payload[0] == 'Z') {
+		change_tail_ret = bpf_skb_change_tail(skb, 0, 0); /* Should fail */
+		return TC_ACT_OK;
+	}
+	return TC_ACT_SHOT;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


