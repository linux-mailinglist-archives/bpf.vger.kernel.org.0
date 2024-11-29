Return-Path: <bpf+bounces-45856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0309DBE61
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 02:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52A76B21BD0
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 01:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB294381BA;
	Fri, 29 Nov 2024 01:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZJ5lzvG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFB817C91;
	Fri, 29 Nov 2024 01:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732843358; cv=none; b=ZhTMUkOmGjQvHwXcW3EZqp1s+xsh+db7d8sqXVOPqpc+Fk2//oCSGkxfFc9YVejJEXHth7CuVH92IdVpFK+XkI+1w41HTdYMpLpZE8w+P5K5/4s24YJCsJ5oXmybpEHzUxfFstRfbGds4st+YZ2hX6vG9Nv6Td0oaqpCNoRipwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732843358; c=relaxed/simple;
	bh=F7JT4xBisKFMYTJpBnqsx7QxIwVAr4egbfjHF471I5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KmLkjGfjKcFz27ymxa2mQDP9/3lYzXPZEXrUe/BxXsWuiXpywqS353vPTc0WdBYzYxXAV5UqEZ+K53KQaToIndiCx3ZXVtuPXM6DRKdMwYE3JoCc4ca0crShgLUsWNE7uVqLpqbJf1pHgEyOtvUx7k/kwPjgfQPB/pit2u7XgcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZJ5lzvG; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so1113395a12.0;
        Thu, 28 Nov 2024 17:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732843356; x=1733448156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5uKx0qV8o+/qU6rwv2ps7xvE7yEZcSPlta89mEJuKA=;
        b=QZJ5lzvGkBvInpe+bYC1BeKkuga4LPXdrl7gXS3998bt9siISjgjr6ZqhccJhqyTQT
         31N+3CNXt3i/tif5o56kPQEi4NKflLSxVFH75d2n6GgxsEIh9LfHiCiJQ9QHeKI/Ybvi
         IraErhqDCwWESjZLsdWm8IfYf05ble0G+QRKOj/932QGDGFMrzRijZMH2fvH8rx7x0A8
         ctx1v7Vjx4YgyHK4xTYEqSFZ2zc06h/NqYiJxKSy5UAaszBZ9J7xLukgCnvREbbubuCq
         Wpba8Gm5mKjcH1FcpJlhyLBYgmjrAWnluBd+OmPX865eSt0/IsxpbkRWFv8+0j7Fje+/
         p9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732843356; x=1733448156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5uKx0qV8o+/qU6rwv2ps7xvE7yEZcSPlta89mEJuKA=;
        b=qEyvxucBm0lS7fCNocvR0hxQSTPWja7GrCBtS1iLvdLZMkdM5e1b/n49DYeMmsmJTy
         Li9RUs4TMYAw2Or34TjOzmaK1mlhIYZTfhFM1RwoxBmOvGNBDhj6gr839aIndLLYlWWe
         yrdnL5h2CE4O65JVxGf9zd+GaSy0exwbZsT6ToTS23G7XXyodmGjA39mfrW8gtD4WDDg
         ZZCcIwB3u6qFoMPNZCa9Kuw/BH5pByAru4kxKeFbxOa098IgK3O+Vdru+OC7fHQlkjUp
         LrIUySrvWB/uj8KQSFZkSWPMHcAh5moLm0ZgKojRI390+nVTyv2I8k5FTwEPk9QJkeol
         X30A==
X-Gm-Message-State: AOJu0YwAIJaNYnXDy6C/oPtGBwdY+G8rRQnzvELIJOvwkX8PITr4rdOP
	lFxjnn55so5qkv4qWnAIwXNExpxoyh0B3SHr5WybNmNuhEMxmaXGCDFgrA==
X-Gm-Gg: ASbGncv2GhSWZ8EyzQ1sNoFzWqcMsCnLbKVI/WNNiimGR2qM+rpEtq89TullK3/2LC0
	SmcbalJaVaFXLsWbHy5FhKiEwy0wSO+hU0GLLohR/w8CuXUpYMXYI82e1dFY2ezP6RmE2P+4Lhx
	xrpiXc4Pmr74MbMTxnC/YYg3pYEQ22BVFKA2beyvKwzdT/w+WGlJagNBJGCdDD/y8E0XC+CgOHT
	uGcIqUuyku+TPK8o9FJFRpoD7aNj6VlyhllUCS3G5IdqaUeyip2dgo7+ZEgctQJ0QHZm8xeC8VM
	al0=
X-Google-Smtp-Source: AGHT+IG3NWrMz3s6bmLPqlk1wtDEhdqlSNbvoWCzs4WGQmNFQViX8s3As28xjGRItpZqITlLzeHJiA==
X-Received: by 2002:a17:90b:380c:b0:2ea:b867:ddbb with SMTP id 98e67ed59e1d1-2ee08e9fdf5mr11125812a91.13.1732843355848;
        Thu, 28 Nov 2024 17:22:35 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:7990:ba58:c520:e7e8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521905120sm20010215ad.80.2024.11.28.17.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 17:22:35 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [Patch bpf v2 2/4] selftests/bpf: Add a BPF selftest for bpf_skb_change_tail()
Date: Thu, 28 Nov 2024 17:22:19 -0800
Message-Id: <20241129012221.739069-3-xiyou.wangcong@gmail.com>
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

As requested by Daniel, we need to add a selftest to cover
bpf_skb_change_tail() cases in skb_verdict. Here we test trimming,
growing and error cases, and validate its expected return values and the
expected sizes of the payload.

Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Zijian Zhang <zijianzhang@bytedance.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 51 +++++++++++++++++++
 .../bpf/progs/test_sockmap_change_tail.c      | 40 +++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index fdff0652d7ef..574db6471fb5 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -12,6 +12,7 @@
 #include "test_sockmap_progs_query.skel.h"
 #include "test_sockmap_pass_prog.skel.h"
 #include "test_sockmap_drop_prog.skel.h"
+#include "test_sockmap_change_tail.skel.h"
 #include "bpf_iter_sockmap.skel.h"
 
 #include "sockmap_helpers.h"
@@ -643,6 +644,54 @@ static void test_sockmap_skb_verdict_fionread(bool pass_prog)
 		test_sockmap_drop_prog__destroy(drop);
 }
 
+static void test_sockmap_skb_verdict_change_tail(void)
+{
+	struct test_sockmap_change_tail *skel;
+	int err, map, verdict;
+	int c1, p1, sent, recvd;
+	int zero = 0;
+	char buf[2];
+
+	skel = test_sockmap_change_tail__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	verdict = bpf_program__fd(skel->progs.prog_skb_verdict);
+	map = bpf_map__fd(skel->maps.sock_map_rx);
+
+	err = bpf_prog_attach(verdict, map, BPF_SK_SKB_STREAM_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto out;
+	err = create_pair(AF_INET, SOCK_STREAM, &c1, &p1);
+	if (!ASSERT_OK(err, "create_pair()"))
+		goto out;
+	err = bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(c1)"))
+		goto out_close;
+	sent = xsend(p1, "Tr", 2, 0);
+	ASSERT_EQ(sent, 2, "xsend(p1)");
+	recvd = recv(c1, buf, 2, 0);
+	ASSERT_EQ(recvd, 1, "recv(c1)");
+	ASSERT_EQ(skel->data->change_tail_ret, 0, "change_tail_ret");
+
+	sent = xsend(p1, "G", 1, 0);
+	ASSERT_EQ(sent, 1, "xsend(p1)");
+	recvd = recv(c1, buf, 2, 0);
+	ASSERT_EQ(recvd, 2, "recv(c1)");
+	ASSERT_EQ(skel->data->change_tail_ret, 0, "change_tail_ret");
+
+	sent = xsend(p1, "E", 1, 0);
+	ASSERT_EQ(sent, 1, "xsend(p1)");
+	recvd = recv(c1, buf, 1, 0);
+	ASSERT_EQ(recvd, 1, "recv(c1)");
+	ASSERT_EQ(skel->data->change_tail_ret, -EINVAL, "change_tail_ret");
+
+out_close:
+	close(c1);
+	close(p1);
+out:
+	test_sockmap_change_tail__destroy(skel);
+}
+
 static void test_sockmap_skb_verdict_peek_helper(int map)
 {
 	int err, c1, p1, zero = 0, sent, recvd, avail;
@@ -1056,6 +1105,8 @@ void test_sockmap_basic(void)
 		test_sockmap_skb_verdict_fionread(true);
 	if (test__start_subtest("sockmap skb_verdict fionread on drop"))
 		test_sockmap_skb_verdict_fionread(false);
+	if (test__start_subtest("sockmap skb_verdict change tail"))
+		test_sockmap_skb_verdict_change_tail();
 	if (test__start_subtest("sockmap skb_verdict msg_f_peek"))
 		test_sockmap_skb_verdict_peek();
 	if (test__start_subtest("sockmap skb_verdict msg_f_peek with link"))
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c b/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
new file mode 100644
index 000000000000..2796dd8545eb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 ByteDance */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} sock_map_rx SEC(".maps");
+
+long change_tail_ret = 1;
+
+SEC("sk_skb")
+int prog_skb_verdict(struct __sk_buff *skb)
+{
+	char *data, *data_end;
+
+	bpf_skb_pull_data(skb, 1);
+	data = (char *)(unsigned long)skb->data;
+	data_end = (char *)(unsigned long)skb->data_end;
+
+	if (data + 1 > data_end)
+		return SK_PASS;
+
+	if (data[0] == 'T') { /* Trim the packet */
+		change_tail_ret = bpf_skb_change_tail(skb, skb->len - 1, 0);
+		return SK_PASS;
+	} else if (data[0] == 'G') { /* Grow the packet */
+		change_tail_ret = bpf_skb_change_tail(skb, skb->len + 1, 0);
+		return SK_PASS;
+	} else if (data[0] == 'E') { /* Error */
+		change_tail_ret = bpf_skb_change_tail(skb, 65535, 0);
+		return SK_PASS;
+	}
+	return SK_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


