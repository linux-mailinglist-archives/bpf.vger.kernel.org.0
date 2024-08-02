Return-Path: <bpf+bounces-36294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF62D946086
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 17:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A2E1C212A1
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 15:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E23175D44;
	Fri,  2 Aug 2024 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cld9ZotH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B43D175D32
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722612601; cv=none; b=et42uuGrkhjRMspP7XweOIRSht6XYkJyc3MHefIG9dyTOpWK6Efq1/wjHGBbl4YwGkWM2pVsobUXu6xf4shDHWYZ4CmT7YZwP7MACczXYy2e1wcf4wu+Nw/B4JGo0NPlxDj0pAu53WJ7cs9FCQmNzFd/qcZ95U2dhva7utAGpB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722612601; c=relaxed/simple;
	bh=E0/HjHnLfbbQ2AzOaCdSMbJAYPliiOSLl3KCxREyzxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVBtVhWhgNX4uIWnfSUhw8sdWU2IXwm5nyTpGOWMuWleHLVsvbmdOutCoA7KvEwZW54rn8v3FWauH+Tbjuk7TSayUzVwPkRadHH7YfWik5JW2Bx7+YrPrx/IuZ1srgb9uQ1b/OIMd1FI2/dg6uxA28wODPtXPuDtWjw7NKxXiHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cld9ZotH; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472DGPT3015055;
	Fri, 2 Aug 2024 15:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=w
	HhtYEbpMQf05TnQ+drQ9PFVBhZIaQuxcekwtDpyPLg=; b=Cld9ZotHvbMFi0jVa
	4yCHiUK1VZRZbSlmhjQlpdG4Cogpm/0cLblyyyjZvS++CP/JAOGq99+9RDHL1Clm
	hWtLCP9nxF2o5yNr1EYLBqSz8LjMcztJgobmpHwYfpClyTWww/83LpM2StO3yIHe
	jsdf4WbFiZNo1enXWKtTNhlbut4w9yvgBEwN+iRpMRY/DvmMefUrm6zWP6Bn8LIl
	jveb0R4Cndd4JYeOoWWG8+Z/7DhrpmPt2qedioRySaTFu8O+NIVp2YwUNoFg+edc
	kc7Q8BvoU+aMJT9yjPaQcvMcK/gQinFaoos5vHKIaxlWZNgFtQ0PUleVodnEvfzP
	3DAyg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40rjg31ecp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Aug 2024 15:29:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 472E2s27001857;
	Fri, 2 Aug 2024 15:29:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40nvp1rhfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Aug 2024 15:29:39 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 472FTYgX035653;
	Fri, 2 Aug 2024 15:29:38 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-223-234.vpn.oracle.com [10.175.223.234])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 40nvp1rh9t-2;
	Fri, 02 Aug 2024 15:29:38 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: martin.lau@linux.dev
Cc: ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        davem@davemloft.net, edumazet@google.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 1/3] bpf/bpf_get,set_sockopt: add option to set TCP-BPF sock ops flags
Date: Fri,  2 Aug 2024 16:29:27 +0100
Message-ID: <20240802152929.2695863-2-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: 6n8WM1fxNgAvM5kMAdJ3GMlHnlJdeShM
X-Proofpoint-ORIG-GUID: 6n8WM1fxNgAvM5kMAdJ3GMlHnlJdeShM

Currently the only opportunity to set sock ops flags dictating
which callbacks fire for a socket is from within a TCP-BPF sockops
program.  This is problematic if the connection is already set up
as there is no further chance to specify callbacks for that socket.
Add TCP_BPF_SOCK_OPS_CB_FLAGS to bpf_setsockopt() and bpf_getsockopt()
to allow users to specify callbacks later, either via an iterator
over sockets or via a socket-specific program triggered by a
setsockopt() on the socket.

Previous discussion on this here [1].

[1] https://lore.kernel.org/bpf/f42f157b-6e52-dd4d-3d97-9b86c84c0b00@oracle.com/

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 include/uapi/linux/bpf.h       |  3 ++-
 net/core/filter.c              | 16 ++++++++++++++++
 tools/include/uapi/linux/bpf.h |  3 ++-
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 35bcf52dbc65..d4d7efc34e67 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2851,7 +2851,7 @@ union bpf_attr {
  * 		  **TCP_SYNCNT**, **TCP_USER_TIMEOUT**, **TCP_NOTSENT_LOWAT**,
  * 		  **TCP_NODELAY**, **TCP_MAXSEG**, **TCP_WINDOW_CLAMP**,
  * 		  **TCP_THIN_LINEAR_TIMEOUTS**, **TCP_BPF_DELACK_MAX**,
- * 		  **TCP_BPF_RTO_MIN**.
+ *		  **TCP_BPF_RTO_MIN**, **TCP_BPF_SOCK_OPS_CB_FLAGS**.
  * 		* **IPPROTO_IP**, which supports *optname* **IP_TOS**.
  * 		* **IPPROTO_IPV6**, which supports the following *optname*\ s:
  * 		  **IPV6_TCLASS**, **IPV6_AUTOFLOWLABEL**.
@@ -7080,6 +7080,7 @@ enum {
 	TCP_BPF_SYN		= 1005, /* Copy the TCP header */
 	TCP_BPF_SYN_IP		= 1006, /* Copy the IP[46] and TCP header */
 	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
+	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Set TCP sock ops flags */
 };
 
 enum {
diff --git a/net/core/filter.c b/net/core/filter.c
index 78a6f746ea0b..570ca3f12175 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5278,6 +5278,11 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk, int optname,
 			return -EINVAL;
 		inet_csk(sk)->icsk_rto_min = timeout;
 		break;
+	case TCP_BPF_SOCK_OPS_CB_FLAGS:
+		if (val & ~(BPF_SOCK_OPS_ALL_CB_FLAGS))
+			return -EINVAL;
+		tp->bpf_sock_ops_cb_flags = val;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -5366,6 +5371,17 @@ static int sol_tcp_sockopt(struct sock *sk, int optname,
 		if (*optlen < 1)
 			return -EINVAL;
 		break;
+	case TCP_BPF_SOCK_OPS_CB_FLAGS:
+		if (*optlen != sizeof(int))
+			return -EINVAL;
+		if (getopt) {
+			struct tcp_sock *tp = tcp_sk(sk);
+			int val = READ_ONCE(tp->bpf_sock_ops_cb_flags);
+
+			memcpy(optval, &val, *optlen);
+			return 0;
+		}
+		return bpf_sol_tcp_setsockopt(sk, optname, optval, *optlen);
 	default:
 		if (getopt)
 			return -EINVAL;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 35bcf52dbc65..d4d7efc34e67 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2851,7 +2851,7 @@ union bpf_attr {
  * 		  **TCP_SYNCNT**, **TCP_USER_TIMEOUT**, **TCP_NOTSENT_LOWAT**,
  * 		  **TCP_NODELAY**, **TCP_MAXSEG**, **TCP_WINDOW_CLAMP**,
  * 		  **TCP_THIN_LINEAR_TIMEOUTS**, **TCP_BPF_DELACK_MAX**,
- * 		  **TCP_BPF_RTO_MIN**.
+ *		  **TCP_BPF_RTO_MIN**, **TCP_BPF_SOCK_OPS_CB_FLAGS**.
  * 		* **IPPROTO_IP**, which supports *optname* **IP_TOS**.
  * 		* **IPPROTO_IPV6**, which supports the following *optname*\ s:
  * 		  **IPV6_TCLASS**, **IPV6_AUTOFLOWLABEL**.
@@ -7080,6 +7080,7 @@ enum {
 	TCP_BPF_SYN		= 1005, /* Copy the TCP header */
 	TCP_BPF_SYN_IP		= 1006, /* Copy the IP[46] and TCP header */
 	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
+	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Set TCP sock ops flags */
 };
 
 enum {
-- 
2.31.1


