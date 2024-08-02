Return-Path: <bpf+bounces-36296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E73CE946088
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 17:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED6C282CB1
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 15:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7541C175D48;
	Fri,  2 Aug 2024 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P87Y+LHl"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4834213635A
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722612608; cv=none; b=oqSJYmUvK5apER2HvaGJICq2L9SGCgTV5FB9hpLKFPsm5uE2s/0HBet/jY7XAZP+ZiUN6jn9fPxA3l6uPs1S5nWxiWiGoed3AXPTTJP5Q/3nSmyjfW2520tau4VA1wls0/pIIFd4AF1EIFUy4c5UK/rqsm0vP5bcor1Jyd5NMj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722612608; c=relaxed/simple;
	bh=F7GKnvena9bL8dC04BQsbziD4U7s7shL7yNKspy0aE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzGNZ+1Lj3Fv4eH4QV5iMnUjKFZ4tbTq0ontG9g8i1LjDn9QmbOkE6V5nfcIw9lJHyNXv6elbjPv95SI5M+CDmFaqt6R1KMqcS25S4z8EOdyEiyxTBuBWeNmKK3M9MH8sv54nzxKwjkNjEC/MUZFP8g3APx/v8ieZj/Kw2zrXuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P87Y+LHl; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472DGRmL009840;
	Fri, 2 Aug 2024 15:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=J
	Malo93BzW7e6u62fqej41GqJvh9Dvc9+j2jOQ/za8Q=; b=P87Y+LHl7CuQM4T/5
	7n2Wv1FF9oGCS4mF008m7A5AYthp6wNMoIU4AhYZUBZI4WnPWSYmD+ielr/qorWn
	FyzliuNoim2oCmK57fhr+3Yi2j4/e0kx8Nu1s/bnc6X0CUMCDeF9WZWGfI579Exa
	4YWRBsat54h+2yhYr+vKfTpMvhcQEStR9lSQgLRZdbPSc6by3vBZP/NA6u5Vt9uy
	Pki6pUc6yvdVoDFmBtQRkLcU1fxBWp5Hk7TBBYA/kN3sGPEMq/GqwNOl6I6d+8qn
	vS+bvfq88+AYjw0xQiEBrKq0b8LXHR/D/W+SyXE8VFJOzDTqV4hgOGEMk2vkSV27
	LorAQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40rjdwhdyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Aug 2024 15:29:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 472Doiw4002409;
	Fri, 2 Aug 2024 15:29:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40nvp1rhjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Aug 2024 15:29:43 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 472FTYgZ035653;
	Fri, 2 Aug 2024 15:29:42 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-223-234.vpn.oracle.com [10.175.223.234])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 40nvp1rh9t-3;
	Fri, 02 Aug 2024 15:29:42 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: martin.lau@linux.dev
Cc: ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        davem@davemloft.net, edumazet@google.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 2/3] selftests/bpf: add tests for TCP_BPF_SOCK_OPS_CB_FLAGS
Date: Fri,  2 Aug 2024 16:29:28 +0100
Message-ID: <20240802152929.2695863-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240802152929.2695863-1-alan.maguire@oracle.com>
References: <20240802152929.2695863-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_11,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408020107
X-Proofpoint-ORIG-GUID: K4OX8PModn2J7LgPSjPzsH-hGeJSx8g-
X-Proofpoint-GUID: K4OX8PModn2J7LgPSjPzsH-hGeJSx8g-

Add tests to set/get TCP sockopt TCP_BPF_SOCK_OPS_CB_FLAGS via
bpf_setsockopt() and also add a cgroup/setsockopt program that
catches setsockopt() for this option and uses bpf_setsockopt()
to set it.  The latter allows us to support modifying sockops
cb flags on a per-socket basis via setsockopt() without adding
support into core setsockopt() itself.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/setget_sockopt.c | 11 ++++++
 .../selftests/bpf/progs/setget_sockopt.c      | 37 +++++++++++++++++--
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c b/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
index 7d4a9b3d3722..b9c54217a489 100644
--- a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
@@ -42,6 +42,7 @@ static int create_netns(void)
 static void test_tcp(int family)
 {
 	struct setget_sockopt__bss *bss = skel->bss;
+	int cb_flags = BPF_SOCK_OPS_STATE_CB_FLAG | BPF_SOCK_OPS_RTO_CB_FLAG;
 	int sfd, cfd;
 
 	memset(bss, 0, sizeof(*bss));
@@ -56,6 +57,9 @@ static void test_tcp(int family)
 		close(sfd);
 		return;
 	}
+	ASSERT_EQ(setsockopt(sfd, SOL_TCP, TCP_BPF_SOCK_OPS_CB_FLAGS,
+			     &cb_flags, sizeof(cb_flags)),
+		  0, "setsockopt cb_flags");
 	close(sfd);
 	close(cfd);
 
@@ -65,6 +69,8 @@ static void test_tcp(int family)
 	ASSERT_EQ(bss->nr_passive, 1, "nr_passive");
 	ASSERT_EQ(bss->nr_socket_post_create, 2, "nr_socket_post_create");
 	ASSERT_EQ(bss->nr_binddev, 2, "nr_bind");
+	ASSERT_GE(bss->nr_state, 1, "nr_state");
+	ASSERT_EQ(bss->nr_setsockopt, 1, "nr_setsockopt");
 }
 
 static void test_udp(int family)
@@ -185,6 +191,11 @@ void test_setget_sockopt(void)
 	if (!ASSERT_OK_PTR(skel->links.socket_post_create, "attach_cgroup"))
 		goto done;
 
+	skel->links.tcp_setsockopt =
+		bpf_program__attach_cgroup(skel->progs.tcp_setsockopt, cg_fd);
+	if (!ASSERT_OK_PTR(skel->links.tcp_setsockopt, "attach_setsockopt"))
+		goto done;
+
 	test_tcp(AF_INET6);
 	test_tcp(AF_INET);
 	test_udp(AF_INET6);
diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/testing/selftests/bpf/progs/setget_sockopt.c
index 60518aed1ffc..920af9e21e84 100644
--- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
@@ -20,6 +20,8 @@ int nr_connect;
 int nr_binddev;
 int nr_socket_post_create;
 int nr_fin_wait1;
+int nr_state;
+int nr_setsockopt;
 
 struct sockopt_test {
 	int opt;
@@ -59,6 +61,8 @@ static const struct sockopt_test sol_tcp_tests[] = {
 	{ .opt = TCP_THIN_LINEAR_TIMEOUTS, .flip = 1, },
 	{ .opt = TCP_USER_TIMEOUT, .new = 123400, .expected = 123400, },
 	{ .opt = TCP_NOTSENT_LOWAT, .new = 1314, .expected = 1314, },
+	{ .opt = TCP_BPF_SOCK_OPS_CB_FLAGS, .new = BPF_SOCK_OPS_ALL_CB_FLAGS,
+	  .expected = BPF_SOCK_OPS_ALL_CB_FLAGS, .restore = BPF_SOCK_OPS_STATE_CB_FLAG, },
 	{ .opt = 0, },
 };
 
@@ -124,6 +128,7 @@ static int bpf_test_sockopt_int(void *ctx, struct sock *sk,
 
 	if (bpf_setsockopt(ctx, level, opt, &new, sizeof(new)))
 		return 1;
+
 	if (bpf_getsockopt(ctx, level, opt, &tmp, sizeof(tmp)) ||
 	    tmp != expected)
 		return 1;
@@ -384,11 +389,14 @@ int skops_sockopt(struct bpf_sock_ops *skops)
 		nr_passive += !(bpf_test_sockopt(skops, sk) ||
 				test_tcp_maxseg(skops, sk) ||
 				test_tcp_saved_syn(skops, sk));
-		bpf_sock_ops_cb_flags_set(skops,
-					  skops->bpf_sock_ops_cb_flags |
-					  BPF_SOCK_OPS_STATE_CB_FLAG);
+
+		/* no need to set sockops cb flags here as sockopt
+		 * tests and user-space originated setsockopt() will
+		 * set flags to include BPF_SOCK_OPS_STATE_CB.
+		 */
 		break;
 	case BPF_SOCK_OPS_STATE_CB:
+		nr_state++;
 		if (skops->args[1] == BPF_TCP_CLOSE_WAIT)
 			nr_fin_wait1 += !bpf_test_sockopt(skops, sk);
 		break;
@@ -397,4 +405,27 @@ int skops_sockopt(struct bpf_sock_ops *skops)
 	return 1;
 }
 
+SEC("cgroup/setsockopt")
+int tcp_setsockopt(struct bpf_sockopt *ctx)
+{
+	struct bpf_sock *sk = ctx->sk;
+	__u8 *optval_end = ctx->optval_end;
+	__u8 *optval = ctx->optval;
+	int val = 0;
+
+	if (!sk || ctx->level != SOL_TCP || ctx->optname != TCP_BPF_SOCK_OPS_CB_FLAGS)
+		return 1;
+	if (optval + sizeof(int) > optval_end)
+		return 0;
+	if (ctx->optlen != sizeof(int))
+		return 0;
+	val = *(int *)optval;
+	if (bpf_setsockopt(sk, ctx->level, ctx->optname, &val, sizeof(val)))
+		return 0;
+	nr_setsockopt++;
+	/* BPF has handled this no need to call "real" setsockopt() */
+	ctx->optlen = -1;
+	return 1;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.31.1


