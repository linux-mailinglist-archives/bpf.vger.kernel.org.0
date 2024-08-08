Return-Path: <bpf+bounces-36686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A5194C08C
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 17:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2EABB251F9
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 15:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C6A18F2FC;
	Thu,  8 Aug 2024 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n5VfMekT"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC1F4A33
	for <bpf@vger.kernel.org>; Thu,  8 Aug 2024 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129593; cv=none; b=C2S8zJO5BytCiIydC1NXePrudNZCrwpzH6tDXeCquklkGupStsKIt7RyZoBK812b3PTm39hUcgYBgj+DerfN4+cBI1BdoumNS9BHq+9tu11heSHalnRKTMHiQqU2z4275slek2uA1DPl2KvrQyiNFcMwYBlrbKWcFSBYrld6+qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129593; c=relaxed/simple;
	bh=vOOItDqD474ReMNIZY0Lg0SJjpf7/R0SVxZ37Ol7ZsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIhle2IIrXQOtjRuFXCqkd2Hekv7sNezqxd1WZ92jUjLdBwvo79f/hSrgKhvVt9UMQ4WhdhgCaIrzmHFslkbeCTczilKpHrRQIrUCVfMddN5TawZ6PpP6F25YwFqABSmCmcqzPaDARjoVFONM9PhOgd2EjuUlctge4TBA4CSJ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n5VfMekT; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478AMVEL020714;
	Thu, 8 Aug 2024 15:06:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=5
	osmBmpjSriCGuWhoAnTsLd7o7eoImCogrPcUbgXdRg=; b=n5VfMekTJdHJ8CEpz
	6Gd9jvW7W11QNl+oYcPTVehEzqBxsGc7CQOGkibRg6Qoe4bUY3TplOIlEMRny39H
	oePrs0+k9mTYFGVpCQe48keVsNIXACLLfMfIyfqVoRLFr2tXGA7NayJ5UiNObkYH
	1oTMgOQvJMQIpetqu+Y4XmucoZQVqH5fXidWo77l4aY2QEiGUzKpe0LwsFFkR4p2
	Qitoh+Wqqk9Rg1ghRvkWe0l+8cCb/SzYL7G6RxqVOtbaiAPk4DI3iQqpfznKtL6h
	NGHLKFri+WbddmZzuttkyn+RjZCdpwkdDF09w7Db8n/YN1pmjysI/SqmV3dvX6En
	UIz/Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sbb2t1yw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 15:06:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 478EX8gi021868;
	Thu, 8 Aug 2024 15:06:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0hrjmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 15:06:06 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 478F61Mc017870;
	Thu, 8 Aug 2024 15:06:05 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-177-74.vpn.oracle.com [10.175.177.74])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40sb0hrjg8-2;
	Thu, 08 Aug 2024 15:06:05 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: martin.lau@linux.dev
Cc: ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        davem@davemloft.net, edumazet@google.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 1/2] bpf/bpf_get,set_sockopt: add option to set TCP-BPF sock ops flags
Date: Thu,  8 Aug 2024 16:05:57 +0100
Message-ID: <20240808150558.1035626-2-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: BOZRGCqHAWEYJgZw9lFttFrfSvNEBzkp
X-Proofpoint-ORIG-GUID: BOZRGCqHAWEYJgZw9lFttFrfSvNEBzkp

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
 net/core/filter.c              | 15 +++++++++++++++
 tools/include/uapi/linux/bpf.h |  3 ++-
 3 files changed, 19 insertions(+), 2 deletions(-)

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
index 78a6f746ea0b..67114e2fb52d 100644
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
@@ -5366,6 +5371,16 @@ static int sol_tcp_sockopt(struct sock *sk, int optname,
 		if (*optlen < 1)
 			return -EINVAL;
 		break;
+	case TCP_BPF_SOCK_OPS_CB_FLAGS:
+		if (*optlen != sizeof(int))
+			return -EINVAL;
+		if (getopt) {
+			struct tcp_sock *tp = tcp_sk(sk);
+
+			memcpy(optval, &tp->bpf_sock_ops_cb_flags, *optlen);
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


