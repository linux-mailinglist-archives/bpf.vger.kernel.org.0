Return-Path: <bpf+bounces-36297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F85946089
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 17:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96281C21660
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 15:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7DF1537AA;
	Fri,  2 Aug 2024 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G+WOJkCT"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD921537AB
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722612612; cv=none; b=NXwG5gJf5iI3igtz82UIWV37aiVawPOLP4S2otfaO3zlA6ccv/IL8VI/kHPEYoF6fQvu4+hpIcgZPahKZcc9dYgxvSVFtbV2GKgM1zl5sntDHMJw1tw3FYhyDC8fg8ZMIB+7O/9qReRhGa41ab4zv1yQXNL8uIfKQ+BQRAo5iaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722612612; c=relaxed/simple;
	bh=wlLt2jaE1jgImr2UwVnqlCKapZVN3QLFdCP/5Ck8Kdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrsU4rFKR8v+AMbkOZC5Gdh5+AKv+OqMQ0yiCm1e8S3QPNlxIcSHzTUyvp+oa8hSgjUeYIVpSDdUZq4LdswKCesko8p5ktckAfblTWHNHsPzv9V6miIbx9D6zqz9CXyaAJI4dmdgIF/AuFCvszwEZ3kn9EKMil8jXv9mvuIX2As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G+WOJkCT; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472DHX5N031533;
	Fri, 2 Aug 2024 15:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=o
	zHTT2FU49PoAIeyA/cyJJZJJDuBiE4PYW5JGMtwWjo=; b=G+WOJkCTVnirdQHw8
	8IO+ZV5mBLh3x/6Qmex75GyWf0OZwUjtZvUfZ/mm2HFg/gTq6Z+zYBIHoC1cXK1l
	GpjPEIYz5/P4H5dTx/v/XEnD5N85LrGEXmt4TOYhmefI5NAX6s2dCs8QUMGF4dXc
	BqmfxQ+swPK4dwKXij9GDs+OHmh9y5TvYalCF3UIBUEqkxHeQcQVQA1iBfWJi7nz
	1JY1iVMJPLNrE0HiSaLTVY63LfevN6exoedDJ/fHzpq1V4f7dl3g+2ly6FriHAOh
	42yrbS7D9dcw20EOwgquEe89zva2GR9qtfbSDYdNOqq2ny8i0GmGUU6OmyLTPAcP
	WIHkA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40rjg5hf87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Aug 2024 15:29:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 472Dx5wt001845;
	Fri, 2 Aug 2024 15:29:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40nvp1rhmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Aug 2024 15:29:47 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 472FTYgb035653;
	Fri, 2 Aug 2024 15:29:47 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-223-234.vpn.oracle.com [10.175.223.234])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 40nvp1rh9t-4;
	Fri, 02 Aug 2024 15:29:46 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: martin.lau@linux.dev
Cc: ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        davem@davemloft.net, edumazet@google.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: modify bpf_iter_setsockopt to test TCP_BPF_SOCK_OPS_CB_FLAGS
Date: Fri,  2 Aug 2024 16:29:29 +0100
Message-ID: <20240802152929.2695863-4-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: yi-nAajMF94WsyQo5eRbDs7ebuUCPfla
X-Proofpoint-GUID: yi-nAajMF94WsyQo5eRbDs7ebuUCPfla

Add support to test bpf_setsockopt(.., TCP_BPF_SOCK_OPS_CB_FLAGS, ...)
in BPF iterator context; use per-socket storage to store the new
value and retrieve it in a cgroup/getsockopt program we attach to
allow us to query TCP_BPF_SOCK_OPS_CB_FLAGS via getsockopt.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../bpf/prog_tests/bpf_iter_setsockopt.c      | 83 +++++++++++++------
 .../selftests/bpf/progs/bpf_iter_setsockopt.c | 76 ++++++++++++++---
 2 files changed, 123 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c
index 16bed9dd8e6a..42effafe8efe 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c
@@ -4,10 +4,13 @@
 #include <sched.h>
 #include <test_progs.h>
 #include "network_helpers.h"
+#include "cgroup_helpers.h"
 #include "bpf_dctcp.skel.h"
 #include "bpf_cubic.skel.h"
 #include "bpf_iter_setsockopt.skel.h"
 
+#define TEST_CGROUP "/test-iter-setsockopt"
+
 static int create_netns(void)
 {
 	if (!ASSERT_OK(unshare(CLONE_NEWNET), "create netns"))
@@ -32,17 +35,26 @@ static unsigned int set_bpf_cubic(int *fds, unsigned int nr_fds)
 	return nr_fds;
 }
 
-static unsigned int check_bpf_dctcp(int *fds, unsigned int nr_fds)
+static unsigned int check_bpf_val(int *fds, unsigned int nr_fds, bool cong)
 {
 	char tcp_cc[16];
-	socklen_t optlen = sizeof(tcp_cc);
+	socklen_t cc_optlen = sizeof(tcp_cc);
+	int flags;
+	socklen_t flags_optlen = sizeof(flags);
 	unsigned int i;
 
 	for (i = 0; i < nr_fds; i++) {
-		if (getsockopt(fds[i], SOL_TCP, TCP_CONGESTION,
-			       tcp_cc, &optlen) ||
-		    strcmp(tcp_cc, "bpf_dctcp"))
-			return i;
+		if (cong) {
+			if (getsockopt(fds[i], SOL_TCP, TCP_CONGESTION,
+				       tcp_cc, &cc_optlen) ||
+			    strcmp(tcp_cc, "bpf_dctcp"))
+				return i;
+		} else {
+			if (getsockopt(fds[i], SOL_TCP, TCP_BPF_SOCK_OPS_CB_FLAGS,
+				       &flags, &flags_optlen) ||
+			    flags != BPF_SOCK_OPS_ALL_CB_FLAGS)
+				return i;
+		}
 	}
 
 	return nr_fds;
@@ -102,7 +114,7 @@ static unsigned short get_local_port(int fd)
 }
 
 static void do_bpf_iter_setsockopt(struct bpf_iter_setsockopt *iter_skel,
-				   bool random_retry)
+				   bool random_retry, bool cong)
 {
 	int *reuse_listen_fds = NULL, *accepted_fds = NULL, *est_fds = NULL;
 	unsigned int nr_reuse_listens = 256, nr_est = 256;
@@ -140,9 +152,16 @@ static void do_bpf_iter_setsockopt(struct bpf_iter_setsockopt *iter_skel,
 			"get_local_port(reuse_listen_fds[0])"))
 		goto done;
 
-	/* Run bpf tcp iter to switch from bpf_cubic to bpf_dctcp */
+	/* Run bpf tcp iter to change tcp value:
+	 *
+	 * - If cong is true, switch from bpf_cubic to bpf_dctcp;
+	 * - If cong is false, use bpf_setsockopt() to set TCP sockops flags.
+	 */
+
 	iter_skel->bss->random_retry = random_retry;
-	iter_fd = bpf_iter_create(bpf_link__fd(iter_skel->links.change_tcp_cc));
+	iter_skel->bss->cong = cong;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(iter_skel->links.change_tcp_val));
 	if (!ASSERT_GE(iter_fd, 0, "create iter_fd"))
 		goto done;
 
@@ -152,22 +171,21 @@ static void do_bpf_iter_setsockopt(struct bpf_iter_setsockopt *iter_skel,
 	if (!ASSERT_OK(err, "read iter error"))
 		goto done;
 
-	/* Check reuseport listen fds for dctcp */
-	ASSERT_EQ(check_bpf_dctcp(reuse_listen_fds, nr_reuse_listens),
+	/* Check reuseport listen fds */
+	ASSERT_EQ(check_bpf_val(reuse_listen_fds, nr_reuse_listens, cong),
 		  nr_reuse_listens,
-		  "check reuse_listen_fds dctcp");
-
-	/* Check non reuseport listen fd for dctcp */
-	ASSERT_EQ(check_bpf_dctcp(&listen_fd, 1), 1,
-		  "check listen_fd dctcp");
+		  "check reuse_listen_fds");
+	/* Check non reuseport listen fd */
+	ASSERT_EQ(check_bpf_val(&listen_fd, 1, cong), 1,
+		  "check listen_fd");
 
-	/* Check established fds for dctcp */
-	ASSERT_EQ(check_bpf_dctcp(est_fds, nr_est), nr_est,
-		  "check est_fds dctcp");
+	/* Check established fds */
+	ASSERT_EQ(check_bpf_val(est_fds, nr_est, cong), nr_est,
+		  "check est_fds");
 
-	/* Check accepted fds for dctcp */
-	ASSERT_EQ(check_bpf_dctcp(accepted_fds, nr_est), nr_est,
-		  "check accepted_fds dctcp");
+	/* Check accepted fds */
+	ASSERT_EQ(check_bpf_val(accepted_fds, nr_est, cong), nr_est,
+		  "check accepted_fds");
 
 done:
 	if (iter_fd != -1)
@@ -186,6 +204,8 @@ void serial_test_bpf_iter_setsockopt(void)
 	struct bpf_dctcp *dctcp_skel = NULL;
 	struct bpf_link *cubic_link = NULL;
 	struct bpf_link *dctcp_link = NULL;
+	struct bpf_link *getsockopt_link = NULL;
+	int cgroup_fd;
 
 	if (create_netns())
 		return;
@@ -194,8 +214,9 @@ void serial_test_bpf_iter_setsockopt(void)
 	iter_skel = bpf_iter_setsockopt__open_and_load();
 	if (!ASSERT_OK_PTR(iter_skel, "iter_skel"))
 		return;
-	iter_skel->links.change_tcp_cc = bpf_program__attach_iter(iter_skel->progs.change_tcp_cc, NULL);
-	if (!ASSERT_OK_PTR(iter_skel->links.change_tcp_cc, "attach iter"))
+	iter_skel->links.change_tcp_val = bpf_program__attach_iter(iter_skel->progs.change_tcp_val,
+								   NULL);
+	if (!ASSERT_OK_PTR(iter_skel->links.change_tcp_val, "attach iter"))
 		goto done;
 
 	/* Load bpf_cubic */
@@ -214,13 +235,23 @@ void serial_test_bpf_iter_setsockopt(void)
 	if (!ASSERT_OK_PTR(dctcp_link, "dctcp_link"))
 		goto done;
 
-	do_bpf_iter_setsockopt(iter_skel, true);
-	do_bpf_iter_setsockopt(iter_skel, false);
+	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
+	if (!ASSERT_OK_FD(cgroup_fd, "cgroup switch"))
+		goto done;
+	getsockopt_link = bpf_program__attach_cgroup(iter_skel->progs._getsockopt, cgroup_fd);
+	if (!ASSERT_OK_PTR(getsockopt_link, "getsockopt prog"))
+		goto done;
 
+	do_bpf_iter_setsockopt(iter_skel, true, true);
+	do_bpf_iter_setsockopt(iter_skel, false, true);
+	do_bpf_iter_setsockopt(iter_skel, true, false);
+	do_bpf_iter_setsockopt(iter_skel, false, false);
 done:
 	bpf_link__destroy(cubic_link);
 	bpf_link__destroy(dctcp_link);
+	bpf_link__destroy(getsockopt_link);
 	bpf_cubic__destroy(cubic_skel);
 	bpf_dctcp__destroy(dctcp_skel);
 	bpf_iter_setsockopt__destroy(iter_skel);
+	cleanup_cgroup_environment();
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_setsockopt.c b/tools/testing/selftests/bpf/progs/bpf_iter_setsockopt.c
index ec7f91850dec..60752a7ebdf8 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_setsockopt.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_setsockopt.c
@@ -5,6 +5,13 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
+struct {
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, int);
+} sk_map SEC(".maps");
+
 #define bpf_tcp_sk(skc)	({				\
 	struct sock_common *_skc = skc;			\
 	sk = NULL;					\
@@ -21,6 +28,7 @@ unsigned short listen_hport = 0;
 char cubic_cc[TCP_CA_NAME_MAX] = "bpf_cubic";
 char dctcp_cc[TCP_CA_NAME_MAX] = "bpf_dctcp";
 bool random_retry = false;
+bool cong = false;
 
 static bool tcp_cc_eq(const char *a, const char *b)
 {
@@ -36,10 +44,32 @@ static bool tcp_cc_eq(const char *a, const char *b)
 	return true;
 }
 
+/* This program is used to intercept getsockopt() calls, providing
+ * the value of bpf_sock_ops_cb_flags for the socket; this value
+ * has been saved in per-socket storage earlier via the iterator
+ * program.
+ */
+SEC("cgroup/getsockopt")
+int _getsockopt(struct bpf_sockopt *ctx)
+{
+	struct bpf_sock *sk = ctx->sk;
+	int *optval = ctx->optval;
+	int *sk_storage = 0;
+
+	if (!sk || ctx->level != SOL_TCP || ctx->optname != TCP_BPF_SOCK_OPS_CB_FLAGS)
+		return 1;
+	sk_storage = bpf_sk_storage_get(&sk_map, sk, 0, 0);
+	if (sk_storage) {
+		if (ctx->optval + sizeof(int) <= ctx->optval_end)
+			*optval = *sk_storage;
+		ctx->retval = 0;
+	}
+	return 1;
+}
+
 SEC("iter/tcp")
-int change_tcp_cc(struct bpf_iter__tcp *ctx)
+int change_tcp_val(struct bpf_iter__tcp *ctx)
 {
-	char cur_cc[TCP_CA_NAME_MAX];
 	struct tcp_sock *tp;
 	struct sock *sk;
 
@@ -54,17 +84,43 @@ int change_tcp_cc(struct bpf_iter__tcp *ctx)
 	     bpf_ntohs(sk->sk_dport) != listen_hport))
 		return 0;
 
-	if (bpf_getsockopt(tp, SOL_TCP, TCP_CONGESTION,
-			   cur_cc, sizeof(cur_cc)))
-		return 0;
+	if (cong) {
+		char cur_cc[TCP_CA_NAME_MAX];
 
-	if (!tcp_cc_eq(cur_cc, cubic_cc))
-		return 0;
+		if (bpf_getsockopt(tp, SOL_TCP, TCP_CONGESTION,
+				   cur_cc, sizeof(cur_cc)))
+			return 0;
 
-	if (random_retry && bpf_get_prandom_u32() % 4 == 1)
-		return 1;
+		if (!tcp_cc_eq(cur_cc, cubic_cc))
+			return 0;
+
+		if (random_retry && bpf_get_prandom_u32() % 4 == 1)
+			return 1;
+
+		bpf_setsockopt(tp, SOL_TCP, TCP_CONGESTION, dctcp_cc, sizeof(dctcp_cc));
+	} else {
+		int val, newval = BPF_SOCK_OPS_ALL_CB_FLAGS;
+		int *sk_storage;
 
-	bpf_setsockopt(tp, SOL_TCP, TCP_CONGESTION, dctcp_cc, sizeof(dctcp_cc));
+		if (bpf_getsockopt(tp, SOL_TCP, TCP_BPF_SOCK_OPS_CB_FLAGS,
+				   &val, sizeof(val)))
+			return 0;
+
+		if (val == newval)
+			return 0;
+
+		if (random_retry && bpf_get_prandom_u32() % 4 == 1)
+			return 1;
+
+		if (bpf_setsockopt(tp, SOL_TCP, TCP_BPF_SOCK_OPS_CB_FLAGS,
+				   &newval, sizeof(newval)))
+			return 0;
+		/* store flags value for retrieval in cgroup/getsockopt prog */
+		sk_storage = bpf_sk_storage_get(&sk_map, sk, 0,
+						BPF_SK_STORAGE_GET_F_CREATE);
+		if (sk_storage)
+			*sk_storage = newval;
+	}
 	return 0;
 }
 
-- 
2.31.1


