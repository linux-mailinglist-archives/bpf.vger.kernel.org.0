Return-Path: <bpf+bounces-36687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5D294C08D
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 17:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 498DA283F93
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 15:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6D618EFE8;
	Thu,  8 Aug 2024 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="onYopdAi"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E43C18EFD3
	for <bpf@vger.kernel.org>; Thu,  8 Aug 2024 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129599; cv=none; b=QswjHn8FT1R/d7/fdZgKrvBgY8EWcg9nSywtoKc9KOS69HbpdD8tAz+EF38ynpgWp5Kcia1t4tvzbaWuiBSEh3QRSXkC4Cqi0tGsrgnmDazObn3AZBPnamk5S34tpyQ0Ft9NZJFSkIs+aQ4GnJhSPBCGYvsIuRreVmiTXmiMaVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129599; c=relaxed/simple;
	bh=CJGFt1DX+ezzoOr3S3iA0iSMInJi5IhtMUAvxyLT6F8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6OJ/tHfx+ItrKW7m78A7njCd4YMQc1OWIhPd8J/KYo8kw8XfQZhyt5Rpx6rinXFD26x9BgZXsr06f3tSHUOw61vlZMCzxcMlS6vhbgWolF5fRT7+iFg9vX/uCXUGXzayBfjbKG4Ss+R7F00QpaGmtSh9+xIP8+VLjc4GhsRxHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=onYopdAi; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478AMY40024550;
	Thu, 8 Aug 2024 15:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=O
	LkmQv4BOKQaoSUzAx91c9AN94AajDZeA6ETum+x7wM=; b=onYopdAi4F5ZfTpMR
	sYgowuoog86MsKyaoI3WyFka+gwB/QTIq3zKeEs2wBK9/kZALqzdfvOvNrFHiu9F
	5dhNdtl0J0eH8lU4xyd4wEM1m8peg2+TsO88h9sFf+JuNJkwLeLFA+x5iujEiseA
	hG2zeXhCLC2yWXeIGGQuJVZHGszKjwi5A5RzNyuCA0lHgC4U3IaUrBuIA6vsSq5D
	4x3mvqwchZhWLfy4wVxX6p3ut1P9jtD5FO6+XiS0skNGrfJ3fMXVS/A1dDmcBEz6
	wUnCL6G/Dw5JNQgQI8ocqK95ZNIfXKuh3toBGKI0V5wyq0dHR4ur7q2zjcsBQ0XV
	zpZKA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40saye9xa2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 15:06:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 478ESLOg021747;
	Thu, 8 Aug 2024 15:06:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0hrjqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 15:06:10 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 478F61Me017870;
	Thu, 8 Aug 2024 15:06:09 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-177-74.vpn.oracle.com [10.175.177.74])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40sb0hrjg8-3;
	Thu, 08 Aug 2024 15:06:09 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: martin.lau@linux.dev
Cc: ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        davem@davemloft.net, edumazet@google.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: add sockopt tests for TCP_BPF_SOCK_OPS_CB_FLAGS
Date: Thu,  8 Aug 2024 16:05:58 +0100
Message-ID: <20240808150558.1035626-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240808150558.1035626-1-alan.maguire@oracle.com>
References: <20240808150558.1035626-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_15,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408080107
X-Proofpoint-ORIG-GUID: 3t2SKb7_WPLTVOEWCd_IZGGfhaydjuRR
X-Proofpoint-GUID: 3t2SKb7_WPLTVOEWCd_IZGGfhaydjuRR

Add tests to set TCP sockopt TCP_BPF_SOCK_OPS_CB_FLAGS via
bpf_setsockopt() and use a cgroup/getsockopt program to retrieve
the value to verify it was set.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/setget_sockopt.c | 47 +++++++++++++++++++
 .../selftests/bpf/progs/setget_sockopt.c      | 24 ++++++++--
 2 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c b/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
index 7d4a9b3d3722..89a0b899441c 100644
--- a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
@@ -154,6 +154,51 @@ static void test_ktls(int family)
 	close(sfd);
 }
 
+static void test_nonstandard_opt(int family)
+{
+	struct setget_sockopt__bss *bss = skel->bss;
+	struct bpf_link *getsockopt_link = NULL;
+	int sfd = -1, fd = -1, cfd = -1, flags;
+	socklen_t flagslen = sizeof(flags);
+
+	memset(bss, 0, sizeof(*bss));
+
+	sfd = start_server(family, SOCK_STREAM,
+			   family == AF_INET6 ? addr6_str : addr4_str, 0, 0);
+	if (!ASSERT_GE(sfd, 0, "start_server"))
+		return;
+
+	fd = connect_to_fd(sfd, 0);
+	if (!ASSERT_GE(fd, 0, "connect_to_fd_server")) {
+		close(sfd);
+		return;
+	}
+
+	/* cgroup/getsockopt prog will intercept getsockopt() below and
+	 * retrieve the tcp socket bpf_sock_ops_cb_flags value for the
+	 * accept()ed socket; this was set earlier in the passive established
+	 * callback for the accept()ed socket via bpf_setsockopt().
+	 */
+	getsockopt_link = bpf_program__attach_cgroup(skel->progs._getsockopt, cg_fd);
+	if (!ASSERT_OK_PTR(getsockopt_link, "getsockopt prog"))
+		goto err_out;
+
+	cfd = accept(sfd, NULL, 0);
+	if (!ASSERT_GE(cfd, 0, "accept"))
+		goto err_out;
+
+	if (!ASSERT_OK(getsockopt(cfd, SOL_TCP, TCP_BPF_SOCK_OPS_CB_FLAGS, &flags, &flagslen),
+		       "getsockopt_flags"))
+		goto err_out;
+	ASSERT_EQ(flags & BPF_SOCK_OPS_STATE_CB_FLAG, BPF_SOCK_OPS_STATE_CB_FLAG,
+		  "cb_flags_set");
+err_out:
+	close(sfd);
+	close(fd);
+	close(cfd);
+	bpf_link__destroy(getsockopt_link);
+}
+
 void test_setget_sockopt(void)
 {
 	cg_fd = test__join_cgroup(CG_NAME);
@@ -191,6 +236,8 @@ void test_setget_sockopt(void)
 	test_udp(AF_INET);
 	test_ktls(AF_INET6);
 	test_ktls(AF_INET);
+	test_nonstandard_opt(AF_INET);
+	test_nonstandard_opt(AF_INET6);
 
 done:
 	setget_sockopt__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/testing/selftests/bpf/progs/setget_sockopt.c
index 60518aed1ffc..0b59be6502cc 100644
--- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
@@ -353,11 +353,30 @@ int BPF_PROG(socket_post_create, struct socket *sock, int family,
 	return 1;
 }
 
+SEC("cgroup/getsockopt")
+int _getsockopt(struct bpf_sockopt *ctx)
+{
+	struct bpf_sock *sk = ctx->sk;
+	int *optval = ctx->optval;
+	struct tcp_sock *tp;
+
+	if (!sk || ctx->level != SOL_TCP || ctx->optname != TCP_BPF_SOCK_OPS_CB_FLAGS)
+		return 1;
+
+	tp = bpf_core_cast(sk, struct tcp_sock);
+	if (ctx->optval + sizeof(int) <= ctx->optval_end) {
+		*optval = tp->bpf_sock_ops_cb_flags;
+		ctx->retval = 0;
+	}
+	return 1;
+}
+
 SEC("sockops")
 int skops_sockopt(struct bpf_sock_ops *skops)
 {
 	struct bpf_sock *bpf_sk = skops->sk;
 	struct sock *sk;
+	int flags;
 
 	if (!bpf_sk)
 		return 1;
@@ -384,9 +403,8 @@ int skops_sockopt(struct bpf_sock_ops *skops)
 		nr_passive += !(bpf_test_sockopt(skops, sk) ||
 				test_tcp_maxseg(skops, sk) ||
 				test_tcp_saved_syn(skops, sk));
-		bpf_sock_ops_cb_flags_set(skops,
-					  skops->bpf_sock_ops_cb_flags |
-					  BPF_SOCK_OPS_STATE_CB_FLAG);
+		flags = skops->bpf_sock_ops_cb_flags | BPF_SOCK_OPS_STATE_CB_FLAG;
+		bpf_setsockopt(skops, SOL_TCP, TCP_BPF_SOCK_OPS_CB_FLAGS, &flags, sizeof(flags));
 		break;
 	case BPF_SOCK_OPS_STATE_CB:
 		if (skops->args[1] == BPF_TCP_CLOSE_WAIT)
-- 
2.31.1


