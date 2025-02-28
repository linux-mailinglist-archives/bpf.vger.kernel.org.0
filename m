Return-Path: <bpf+bounces-52863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9720AA49424
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 09:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A1B616ED3A
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 08:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C59F254B12;
	Fri, 28 Feb 2025 08:56:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F067C254861;
	Fri, 28 Feb 2025 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740733019; cv=none; b=UEB6UZIgqdz1E9neI/CCTRbdCEXXMmL11nPNtlTHJT1rKm7E4pK86U2QsnXprZdNvx5cA5H2rg1GX/qmWYIGU8YHac5NVCb6oHS8SXF0wnrKmF+MAf3mJhHA8dO/5k3aEVqfs8H07SRQWP8fc1A7sCZ+XvPLq5kjVL+wQveHu6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740733019; c=relaxed/simple;
	bh=rioT+zs/EUwp5ugIuBu8haUrQ9xy69x6OZ0brgp5GCc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HCieDT6OSL6xz5VZpJuAVdyv7m2l6wcyHfM/OBa9M+t4lGVZwSvgUsLLqeZiQz7KZ3SD1Eb6Wt24e6xeWTTzla7HfJFFlqXd8Gs4qYxSIbUcPlsCk/d1yNZqNiOd+5JW+P+V7eKWJBmVRFo8VRvvozp2QDXlDZ3Bj/Oe++OhcO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z428d3V8qz1R5vg;
	Fri, 28 Feb 2025 16:54:57 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C8B914010D;
	Fri, 28 Feb 2025 16:56:33 +0800 (CST)
Received: from kwepemn200003.china.huawei.com (7.202.194.126) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Feb 2025 16:56:33 +0800
Received: from localhost.localdomain (10.175.101.6) by
 kwepemn200003.china.huawei.com (7.202.194.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Feb 2025 16:56:31 +0800
From: zhangmingyi <zhangmingyi5@huawei.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <yanan@huawei.com>,
	<wuchangye@huawei.com>, <xiesongyang@huawei.com>, <liuxin350@huawei.com>,
	<liwei883@huawei.com>, <tianmuyang@huawei.com>, <zhangmingyi5@huawei.com>
Subject: [PATCH bpf-next v4 2/2] selftest for TCP_ULP in bpf_setsockopt
Date: Fri, 28 Feb 2025 16:53:40 +0800
Message-ID: <20250228085340.3219391-3-zhangmingyi5@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250228085340.3219391-1-zhangmingyi5@huawei.com>
References: <20250228085340.3219391-1-zhangmingyi5@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemn200003.china.huawei.com (7.202.194.126)

From: Mingyi Zhang <zhangmingyi5@huawei.com>

We try to use bpf_set/getsockopt to set/get TCP_ULP in sockops, and "tls"
need connect is established.
To avoid impacting other test cases, I have written a separate ebpf prog.

Signed-off-by: Mingyi Zhang <zhangmingyi5@huawei.com>
Signed-off-by: Xin Liu <liuxin350@huawei.com>
---
 .../selftests/bpf/prog_tests/setget_sockopt.c | 32 +++++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |  1 +
 .../selftests/bpf/progs/setget_sockopt.c      | 24 ++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c b/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
index e12255121c15..2953076bc2f0 100644
--- a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
@@ -199,6 +199,36 @@ static void test_nonstandard_opt(int family)
 	bpf_link__destroy(getsockopt_link);
 }
 
+static void test_tcp_ulp(int family)
+{
+	struct setget_sockopt__bss *bss = skel->bss;
+	struct bpf_link *skops_sockopt_tcp_ulp = NULL;
+	int sfd = -1, cfd = -1;
+
+	memset(bss, 0, sizeof(*bss));
+
+	skops_sockopt_tcp_ulp =
+		bpf_program__attach_cgroup(skel->progs.skops_sockopt_tcp_ulp, cg_fd);
+	if (!ASSERT_OK_PTR(skel->links.skops_sockopt_tcp_ulp, "attach_cgroup"))
+		return;
+
+	sfd = start_server(family, SOCK_STREAM,
+			   family == AF_INET6 ? addr6_str : addr4_str, 0, 0);
+	if (!ASSERT_GE(sfd, 0, "start_server"))
+		goto err_out;
+
+	cfd = connect_to_fd(sfd, 0);
+	if (!ASSERT_GE(cfd, 0, "connect_to_fd_server"))
+		goto err_out;
+	ASSERT_EQ(bss->nr_tcp_ulp, 3, "nr_tcp_ulp");
+
+err_out:
+	close(sfd);
+	if (cfd != -1)
+		close(cfd);
+	bpf_link__destroy(skops_sockopt_tcp_ulp);
+}
+
 void test_setget_sockopt(void)
 {
 	cg_fd = test__join_cgroup(CG_NAME);
@@ -238,6 +268,8 @@ void test_setget_sockopt(void)
 	test_ktls(AF_INET);
 	test_nonstandard_opt(AF_INET);
 	test_nonstandard_opt(AF_INET6);
+	test_tcp_ulp(AF_INET6);
+	test_tcp_ulp(AF_INET);
 
 done:
 	setget_sockopt__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index 59843b430f76..f3ce0d74be18 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -47,6 +47,7 @@
 #define TCP_NOTSENT_LOWAT	25
 #define TCP_SAVE_SYN		27
 #define TCP_SAVED_SYN		28
+#define TCP_ULP			31
 #define TCP_CA_NAME_MAX		16
 #define TCP_NAGLE_OFF		1
 
diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/testing/selftests/bpf/progs/setget_sockopt.c
index 6dd4318debbf..80b3179c0454 100644
--- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
@@ -20,6 +20,7 @@ int nr_connect;
 int nr_binddev;
 int nr_socket_post_create;
 int nr_fin_wait1;
+int nr_tcp_ulp;
 
 struct sockopt_test {
 	int opt;
@@ -417,4 +418,27 @@ int skops_sockopt(struct bpf_sock_ops *skops)
 	return 1;
 }
 
+SEC("sockops")
+int skops_sockopt_tcp_ulp(struct bpf_sock_ops *skops)
+{
+	static const char target_ulp[] = "tls";
+	char verify_ulp[sizeof(target_ulp)];
+
+	switch (skops->op) {
+	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
+		if (bpf_setsockopt(skops, IPPROTO_TCP, TCP_ULP, (void *)target_ulp,
+							sizeof(target_ulp)) != 0)
+			return 1;
+		nr_tcp_ulp++;
+		if (bpf_getsockopt(skops, IPPROTO_TCP, TCP_ULP, verify_ulp,
+							sizeof(verify_ulp)) != 0)
+			return 1;
+		nr_tcp_ulp++;
+		if (bpf_strncmp(verify_ulp, sizeof(target_ulp), "tls") != 0)
+			return 1;
+		nr_tcp_ulp++;
+	}
+	return 1;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


