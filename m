Return-Path: <bpf+bounces-49845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9864FA1D312
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 10:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018883A2655
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 09:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D441FDA6D;
	Mon, 27 Jan 2025 09:09:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73D21FCFE6;
	Mon, 27 Jan 2025 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737968995; cv=none; b=lmkuJufEoWCjskt4bDUJinfs/Z06OfWvjBjhXTpymO2plxgIBTHm5gTGSKOWQSOHQQp6akKUKolEAVf2gpynhu5MjP1jh9+HHy7JEmJENQOXnDj9feT+OU6F2QkFLjtY9fuaaVIvpDWuVyDIc2LyiSRGthFAxDg4DjjJ/z5TFFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737968995; c=relaxed/simple;
	bh=ZubBlVElppc3zps+tVo58hGyz9tBp1Gtae18sdb6aQQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqO+RdsrIZg7hrBQGXDIFIy6xcmpUL60PzyGxyVA2HcW/Xll46yxm0TW460KAsqxcyJiri2ukOswBImEr79SmYTGymW3+ZgCzWdMfy9n4pmxA4nM0XP2tMpYvSuAEoFPOQ6/zv9eDSe9+3JlHRdObEivC5HZWeuBa5Ym+hxCPGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YhMwW3DTlz1l0C9;
	Mon, 27 Jan 2025 17:06:19 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id BBA9A1A0188;
	Mon, 27 Jan 2025 17:09:44 +0800 (CST)
Received: from kwepemn200003.china.huawei.com (7.202.194.126) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Jan 2025 17:09:44 +0800
Received: from localhost.localdomain (10.175.101.6) by
 kwepemn200003.china.huawei.com (7.202.194.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Jan 2025 17:09:42 +0800
From: zhangmingyi <zhangmingyi5@huawei.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <yanan@huawei.com>,
	<wuchangye@huawei.com>, <xiesongyang@huawei.com>, <liuxin350@huawei.com>,
	<liwei883@huawei.com>, <tianmuyang@huawei.com>, <zhangmingyi5@huawei.com>
Subject: [PATCH 2/2] add selftest for TCP_ULP in bpf_setsockopt
Date: Mon, 27 Jan 2025 17:07:24 +0800
Message-ID: <20250127090724.3168791-3-zhangmingyi5@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250127090724.3168791-1-zhangmingyi5@huawei.com>
References: <20250127090724.3168791-1-zhangmingyi5@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemn200003.china.huawei.com (7.202.194.126)

This case invokes bpf_setsockopt and bpf_getsockopt to set ulp. 
The existing smc_ulp_ops of the kernel is used as a test case to test
whether the setting and get operations can be performed normally.

Signed-off-by: zhangmingyi <zhangmingyi5@huawei.com>
---
 .../selftests/bpf/progs/setget_sockopt.c      | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/testing/selftests/bpf/progs/setget_sockopt.c
index 6dd4318debbf..dcdf26ef41c4 100644
--- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
@@ -327,6 +327,18 @@ static int test_tcp_maxseg(void *ctx, struct sock *sk)
 	return 0;
 }
 
+static int test_tcp_ulp(void *ctx, struct sock *sk)
+{
+	__u8 saved_syn[20];
+
+	if (sk->sk_state == TCP_SYN_SENT)
+		return bpf_setsockopt(ctx, IPPROTO_TCP, TCP_ULP,
+						"smc", sizeof("smc"));
+
+	return bpf_getsockopt(ctx, IPPROTO_TCP, TCP_ULP,
+			    saved_syn, sizeof(saved_syn));
+}
+
 static int test_tcp_saved_syn(void *ctx, struct sock *sk)
 {
 	__u8 saved_syn[20];
@@ -395,16 +407,19 @@ int skops_sockopt(struct bpf_sock_ops *skops)
 		break;
 	case BPF_SOCK_OPS_TCP_CONNECT_CB:
 		nr_connect += !(bpf_test_sockopt(skops, sk) ||
-				test_tcp_maxseg(skops, sk));
+				test_tcp_maxseg(skops, sk) ||
+				test_tcp_ulp(skops, sk));
 		break;
 	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
 		nr_active += !(bpf_test_sockopt(skops, sk) ||
-			       test_tcp_maxseg(skops, sk));
+			       test_tcp_maxseg(skops, sk) ||
+				   test_tcp_ulp(skops, sk));
 		break;
 	case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
 		nr_passive += !(bpf_test_sockopt(skops, sk) ||
 				test_tcp_maxseg(skops, sk) ||
-				test_tcp_saved_syn(skops, sk));
+				test_tcp_saved_syn(skops, sk) ||
+				test_tcp_ulp(skops, sk));
 		flags = skops->bpf_sock_ops_cb_flags | BPF_SOCK_OPS_STATE_CB_FLAG;
 		bpf_setsockopt(skops, SOL_TCP, TCP_BPF_SOCK_OPS_CB_FLAGS, &flags, sizeof(flags));
 		break;
-- 
2.43.0


