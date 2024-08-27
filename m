Return-Path: <bpf+bounces-38116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 156EC95FDF1
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 02:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD01EB20C5B
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 00:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F534431;
	Tue, 27 Aug 2024 00:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WVXLE2+2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95B133E8
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 00:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724717793; cv=none; b=EtzTRPQ8tSFXvaAin4/ghcvhVGHff+dt7bqP/7WQZdY7k/0NBT+W+booQhQg4iMbnxxbihdDRANNBqcCXbAPfMRw0owi92A2u1go/aqWqnT7msVnAwik+Rc46ZDBJSRDt83IuuT4M1fDxs7L5JEMugIlGY8eztlXPfovnqN1C1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724717793; c=relaxed/simple;
	bh=RxdtVQym2vCbSh2nlk82aJAXg9u7EZsZm+vr5Jo9ilw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k3HFk5ZHalYRd4aNsTx8Iv9VGMmCzsfq1llEFFuu4/nWltvKhQStzY5hnorN93nIiz9sKZY9DPrBj7BJ6/ceRSh7t73LOEcwRq40sjoDjJSymUQnTJLsxI2VVFVk4Rcf3/u4tFL12tn3NfDYEWf6/hTMhHUlYpsgVIMlQ1fEKdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WVXLE2+2; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e1205de17aaso5143828276.2
        for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 17:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724717789; x=1725322589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyzDIeO0OSMdXGqEylULwMz5dVtw2flzpxSJxYZ7Qq4=;
        b=WVXLE2+2Q6h/KCbahRdUwY3iCGQTIvXQi2Rj3ydytToybIzK7q/bqIj+gsclTo0FK9
         cj0IjBz75E5T1m0yCaVoGCgEYDJ4QPp74sYndPwoPaqjszQf4HBBWMuXdUKRz76WxEUt
         pIVygWAQwRoP0Av3wffPMPzcDxMnCi7KEWpNkEqkq8bQ2num+ji9Eiis3HLbp6fG1Kmp
         huEjuGIkirq0uydQJgaDKcxY0yR51y31YItO0b/j1M90mdfzID3mF61B59X8/Pfl+rhn
         jxL4n/5bKRAc2JryTpZko05RfVFLcWneOpTPFP/JviTu5vXfxlMOVU9HhZ0eB8cqLpu5
         AGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724717789; x=1725322589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyzDIeO0OSMdXGqEylULwMz5dVtw2flzpxSJxYZ7Qq4=;
        b=S7IGy3FKVtKwqZEJjsL8lsWTzoDN0qgFCvC7/IvuawLSYDiOkljzV0ElgjY0wawn3x
         IF51RpDNhY4pJ5/Blh60SIKU+O1Vc8NNNUSkKKfFxbOPZI5xMR2gebF7eHWWb6e2/Due
         yyBoEyy9tHThQrqMAqsj62MmYG3c4eTwvtBu1/xYwbPgw37Wbr0xSmDiBUJLa8qmB3eI
         8cXtTadyeRHt9qyEhLTr6ZfkNRIe5WqQFT5+7RKoa/q/fL3anbg/wYHemnBxh67+TwDC
         sEXxecjzsqHK1Ov4c7GzOqCJ4R8IhDphDdyhFoL/cXHGH4v5EGtRxZeesYiZNGvIBCvd
         LS1A==
X-Gm-Message-State: AOJu0YwzN52rJi6A2ynXi3x+sROysd7q5WgGdZfN+RMDqu4vjlM2Qmn4
	onOaksJwF+0ExzCb8OftA8a5A23MEIC8kWcx1uC87Vpk/pgDm107f5YJN8clkbuEo0800hn/D5W
	U
X-Google-Smtp-Source: AGHT+IEL8YHhMYqZkllj/y8QVubYFEFdE3QxRKNCOhCH9XwJoeplSU3bEyGEppCuN50zLSZfGFqjXw==
X-Received: by 2002:a05:6902:c03:b0:e0b:e50a:e7d6 with SMTP id 3f1490d57ef6-e17a869c4c3mr11751314276.57.1724717789492;
        Mon, 26 Aug 2024 17:16:29 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162dcda66sm51387136d6.122.2024.08.26.17.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 17:16:29 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 2/2] bpf: selftests: reserve smaller tcp header options than the actual size
Date: Tue, 27 Aug 2024 00:14:07 +0000
Message-Id: <20240827001407.2476854-3-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240827001407.2476854-1-zijianzhang@bytedance.com>
References: <20240827001407.2476854-1-zijianzhang@bytedance.com>
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
 .../bpf/prog_tests/tcp_hdr_options.c          | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

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
-- 
2.20.1


