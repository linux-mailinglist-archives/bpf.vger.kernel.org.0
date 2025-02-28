Return-Path: <bpf+bounces-52857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E85AA491E6
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 08:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6868E189270C
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 07:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1B71C8617;
	Fri, 28 Feb 2025 07:09:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00AB748F;
	Fri, 28 Feb 2025 07:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740726571; cv=none; b=POU+xNZQHmTMwkbQcJbBD5tWwtbtwD/jgtt1c4Q5Ria+RTZBjKaR8qEX2RBAgLNoTG4lPIjFUSKmgJAlut+hda7bBeZhoeun4Kz+ZxVIo+UehlXQsZUMRPagkiXRBj29Hd0PsnR+WeWvhshJomwyZcxQI2xw1wbc5ldq9qnVJJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740726571; c=relaxed/simple;
	bh=pqrBh1KCeGY79d7eofYJtVnNnDXjFlJWJKrE+XQn3kg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LazpSW6+Qiijm6mHUBzXgPw0Dt+F+6KTMbKTC0Ws2v9UsKgwFUUBZhoXuKvDmhSnCcxgYl2MHo33hEQD+NxDEYvsI2w0k7UWbEKBfRPqra5KowqHsUy2Bbub4u/HZ5kZ/Scey3gHYze3H587tFYB9VeSaImtcKFi9AFGpId8uaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Z3zn64zrYzVmWD;
	Fri, 28 Feb 2025 15:07:54 +0800 (CST)
Received: from dggemv711-chm.china.huawei.com (unknown [10.1.198.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 5910E180113;
	Fri, 28 Feb 2025 15:09:26 +0800 (CST)
Received: from kwepemn200003.china.huawei.com (7.202.194.126) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Feb 2025 15:09:26 +0800
Received: from localhost.localdomain (10.175.101.6) by
 kwepemn200003.china.huawei.com (7.202.194.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Feb 2025 15:09:24 +0800
From: zhangmingyi <zhangmingyi5@huawei.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <yanan@huawei.com>,
	<wuchangye@huawei.com>, <xiesongyang@huawei.com>, <liuxin350@huawei.com>,
	<liwei883@huawei.com>, <tianmuyang@huawei.com>, <zhangmingyi5@huawei.com>
Subject: [PATCH bpf-next v3 2/2] selftest for TCP_ULP in bpf_setsockopt
Date: Fri, 28 Feb 2025 15:06:28 +0800
Message-ID: <20250228070628.3219087-3-zhangmingyi5@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250228070628.3219087-1-zhangmingyi5@huawei.com>
References: <20250228070628.3219087-1-zhangmingyi5@huawei.com>
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
index e12255121c15..1b6fd380e994 100644
--- a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
@@ -199,6 +199,36 @@ static void test_nonstandard_opt(int family)
 	bpf_link__destroy(getsockopt_link);
 }
 
+static void test_tcp_ulp(int family)
+{
+	struct setget_sockopt_tcp_ulp__bss *bss = skel->bss;
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
+	test_tcp_ulp(AF_INET6)
+	test_tcp_ulp(AF_INET)
 
 done:
 	setget_sockopt__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index 59843b430f76..67b761290956 100644
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


