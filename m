Return-Path: <bpf+bounces-38121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2EC95FE61
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 03:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A491F21BD7
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 01:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3131BE5D;
	Tue, 27 Aug 2024 01:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WhgfNpKr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40CE79F5
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 01:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724722757; cv=none; b=r5FTf5KC8Ayz0fYaBCG5m4nP6kWMtLrOfRdHbp8nUSCu2CxBz7Bh47LWxg1mgJpz1w0vpRjPKdLN2HUwg9SYMyPMMQpgnWZMFmzgNJxAIch/wnQBfJx7/Vqg5vflf9wsReE8w5EKRR28DI+6hjf9e/iZc0az3A4Jtx9Xm1diSDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724722757; c=relaxed/simple;
	bh=A6NvX8hfm0tvRNb6Sn4Y+0kb9RfDVEiukNO29/0v/Es=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RgmirGP09sVfOh8kPSlPjkZ5GmnMIrejIzSfoKkjVeTOX3Us38pfKrFdsvSZJ1SFIKA8foMJLqiMtfCTyxzuem2Y+gfReMKPNgKwzaUkkUzDkj6tHmnxRdlR/D7/sa6vzB1Bzim0oZTzm3fKmvHQj93dUFB77sn3ZXgegbRMBfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WhgfNpKr; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44feaa08040so29989491cf.2
        for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 18:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724722754; x=1725327554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qscxrfcLa9P+rAQpqLM/qcd9DGY6ZDmZq+T5JUcka6w=;
        b=WhgfNpKrQe6QpPhNO+aXYRHywFzujt3KSXMAsCvoh8kpL0LylhrKEWVQbodxiAcSgo
         OCfA6AnxKsl7qbq5OvdEyGlpegUjmrclRXgbBuWYYlaVG5wVTjgVFuTjh28NsW5tyBvz
         7f2ySLegmXyeFwG9aGZO7rvvFddSCCtdivoW6LEAW+QwN3QU4ZyxHhqeLg50bAi88t/A
         AxFtNYwa7WVaK/OwpF8cyelzbFpenEtv2ZSme/CSIbWCDgFiAKirFH7BFGeXNKnDvUtA
         eplZT87bWN+MpBxoXi5SFU3rq2J85kfGEz8KlBryGMkcibqpSboA+9hWUJZrBq6EJHvi
         aISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724722754; x=1725327554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qscxrfcLa9P+rAQpqLM/qcd9DGY6ZDmZq+T5JUcka6w=;
        b=SHjXRTTthk1W4nR8g87Y3R1X0K1s/c+zRPvmg41HIamtulOIPdljBe3V7Tz2IM/phX
         cihsdkrUE4gaq9JLgkJGwm6keAraO6Mn/6jTdhzn3E3VwSFGjBAXYti9nmpjKfOWALSm
         b8nEBrrYGgwcZPMX4o/zizWr4acsJOgr+v5D1HtZnNWtuJEYsxug3VmYN6juatnvw6QL
         xCoTZV9mAjvd/fTqHcjcTBZWgvlICJipEDzvo+4mtlxfWKKX0qxmfPJmbSSWhDC5mwIJ
         8gh8FWfkuqJyMKwWn3Mt91nL5GIoHyyMuB5iimEfh2gfNmeJVAYsNe7VQEJACQw/K5iY
         XhaQ==
X-Gm-Message-State: AOJu0YyBiEJC8vwTdsKVZx3bFfpjJ21Sovs4jrbc/Ri+soJeQ2wuOaA+
	rQq2V9d4apnTt83a4HNNwOZO+I5yg2t/MJ1ABInnGWvxePwbruQSm4sTNOsF1+J4GLBCTtI6jsL
	2
X-Google-Smtp-Source: AGHT+IHR4Dqc++/sZLvTFVuURPll3ANdxtS1m6irNqKxnhUN6kW8V5mlXGDzjc7+Xn/LSPU+6EqOag==
X-Received: by 2002:a05:622a:4288:b0:454:e5ae:ea24 with SMTP id d75a77b69052e-45660789a1amr13036751cf.6.1724722753771;
        Mon, 26 Aug 2024 18:39:13 -0700 (PDT)
Received: from n191-036-066.byted.org ([147.160.184.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe1c5711sm48263401cf.82.2024.08.26.18.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 18:39:13 -0700 (PDT)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	xiyou.wangcong@gmail.com,
	wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com,
	Amery Hung <amery.hung@bytedance.com>,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH bpf-next v2 2/2] bpf: selftests: reserve smaller tcp header options than the actual size
Date: Tue, 27 Aug 2024 01:37:36 +0000
Message-Id: <20240827013736.2845596-3-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240827013736.2845596-1-zijianzhang@bytedance.com>
References: <20240827013736.2845596-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

If eBPF users mistakenly reserve smaller header options than the actual
size in BPF_SOCK_OPS_HDR_OPT_LEN_CB, bpf_reserve_hdr_opt should return an
appropriate error value, and there will be no packet dropping.

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 .../bpf/prog_tests/tcp_hdr_options.c          | 51 +++++++++++++
 .../bpf/progs/test_reserve_tcp_hdr_options.c  | 71 +++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_reserve_tcp_hdr_options.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
index 56685fc03c7e..9c250b5bf00a 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
@@ -14,6 +14,7 @@
 #include "test_tcp_hdr_options.h"
 #include "test_tcp_hdr_options.skel.h"
 #include "test_misc_tcp_hdr_options.skel.h"
+#include "test_reserve_tcp_hdr_options.skel.h"
 
 #define LO_ADDR6 "::1"
 #define CG_NAME "/tcpbpf-hdr-opt-test"
@@ -25,6 +26,7 @@ static struct bpf_test_option exp_active_fin_in;
 static struct hdr_stg exp_passive_hdr_stg;
 static struct hdr_stg exp_active_hdr_stg = { .active = true, };
 
+static struct test_reserve_tcp_hdr_options *reserve_skel;
 static struct test_misc_tcp_hdr_options *misc_skel;
 static struct test_tcp_hdr_options *skel;
 static int lport_linum_map_fd;
@@ -513,6 +515,49 @@ static void misc(void)
 	bpf_link__destroy(link);
 }
 
+static void reserve_hdr_opt(void)
+{
+	struct bpf_link *link;
+	struct sk_fds sk_fds;
+	char send_msg[1500];
+	char recv_msg[sizeof(send_msg)];
+	int ret;
+
+	if (!ASSERT_OK(system("ip link set dev lo mtu 1500"), "set dev lo mtu to 1500"))
+		return;
+
+	lport_linum_map_fd = bpf_map__fd(reserve_skel->maps.lport_linum_map);
+
+	link = bpf_program__attach_cgroup(reserve_skel->progs.reserve_tcp_hdr_options, cg_fd);
+	if (!ASSERT_OK_PTR(link, "attach_cgroup(reserve_tcp_hdr_options)"))
+		return;
+
+	if (sk_fds_connect(&sk_fds, false)) {
+		bpf_link__destroy(link);
+		return;
+	}
+
+	ret = send(sk_fds.active_fd, send_msg, sizeof(send_msg),
+			   MSG_EOR);
+	if (!ASSERT_EQ(ret, sizeof(send_msg), "send(msg)"))
+		goto check_linum;
+
+	ret = read(sk_fds.passive_fd, recv_msg, sizeof(recv_msg));
+	if (!ASSERT_EQ(ret, sizeof(send_msg), "read(msg)"))
+		goto check_linum;
+
+	if (sk_fds_shutdown(&sk_fds))
+		goto check_linum;
+
+	ASSERT_FALSE(reserve_skel->bss->nr_err_reserve, "unexpected nr_err_reserve");
+	ASSERT_TRUE(reserve_skel->bss->nr_nospc, "unexpected nr_nospc");
+
+check_linum:
+	ASSERT_FALSE(check_error_linum(&sk_fds), "check_error_linum");
+	sk_fds_close(&sk_fds);
+	bpf_link__destroy(link);
+}
+
 struct test {
 	const char *desc;
 	void (*run)(void);
@@ -526,6 +571,7 @@ static struct test tests[] = {
 	DEF_TEST(fastopen_estab),
 	DEF_TEST(fin),
 	DEF_TEST(misc),
+	DEF_TEST(reserve_hdr_opt),
 };
 
 void test_tcp_hdr_options(void)
@@ -540,6 +586,10 @@ void test_tcp_hdr_options(void)
 	if (!ASSERT_OK_PTR(misc_skel, "open and load misc test skel"))
 		goto skel_destroy;
 
+	reserve_skel = test_reserve_tcp_hdr_options__open_and_load();
+	if (!ASSERT_OK_PTR(reserve_skel, "open and load reserve test skel"))
+		goto skel_destroy;
+
 	cg_fd = test__join_cgroup(CG_NAME);
 	if (!ASSERT_GE(cg_fd, 0, "join_cgroup"))
 		goto skel_destroy;
@@ -558,6 +608,7 @@ void test_tcp_hdr_options(void)
 
 	close(cg_fd);
 skel_destroy:
+	test_reserve_tcp_hdr_options__destroy(reserve_skel);
 	test_misc_tcp_hdr_options__destroy(misc_skel);
 	test_tcp_hdr_options__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_reserve_tcp_hdr_options.c b/tools/testing/selftests/bpf/progs/test_reserve_tcp_hdr_options.c
new file mode 100644
index 000000000000..a40d31c4ae1b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_reserve_tcp_hdr_options.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 ByteDance Inc. */
+
+#include <stddef.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <linux/ipv6.h>
+#include <linux/tcp.h>
+#include <linux/socket.h>
+#include <linux/bpf.h>
+#include <linux/types.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+#define BPF_PROG_TEST_TCP_HDR_OPTIONS
+#include "test_tcp_hdr_options.h"
+
+unsigned int nr_err_reserve = 0;
+unsigned int nr_nospc = 0;
+
+static bool skops_current_mss(const struct bpf_sock_ops *skops)
+{
+	return skops->args[0] == BPF_WRITE_HDR_TCP_CURRENT_MSS;
+}
+
+static int handle_hdr_opt_len(struct bpf_sock_ops *skops)
+{
+	int err;
+
+	if (skops_current_mss(skops)) {
+		err = bpf_reserve_hdr_opt(skops, 4, 0);
+		if (err) {
+			nr_err_reserve++;
+			RET_CG_ERR(err);
+		}
+	} else {
+		err = bpf_reserve_hdr_opt(skops, 8, 0);
+		if (err) {
+			if (err == -ENOSPC) {
+				nr_nospc++;
+			} else {
+				nr_err_reserve++;
+				RET_CG_ERR(err);
+			}
+		}
+	}
+
+	return CG_OK;
+}
+
+SEC("sockops")
+int reserve_tcp_hdr_options(struct bpf_sock_ops *skops)
+{
+	switch (skops->op) {
+	case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
+	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
+		bpf_sock_ops_cb_flags_set(skops,
+					  skops->bpf_sock_ops_cb_flags |
+					  BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG);
+		break;
+	case BPF_SOCK_OPS_HDR_OPT_LEN_CB:
+		return handle_hdr_opt_len(skops);
+	case BPF_SOCK_OPS_WRITE_HDR_OPT_CB:
+		break;
+	}
+
+	return CG_OK;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.20.1


