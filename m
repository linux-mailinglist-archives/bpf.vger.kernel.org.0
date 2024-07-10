Return-Path: <bpf+bounces-34398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DA192D4A5
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 17:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D370B218B3
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 15:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9306719248D;
	Wed, 10 Jul 2024 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gsXAOE4P"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372E41940AB
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720623722; cv=none; b=jy3QeRg1fEi6+7nnmVUSKgV58TjFGud9gPK4F2knIKy8EoYtQBy5R0gYno9Y3CQgqD/7ZEeuwTNuBknTpuo24ysbTLSzI4XToY2dQHGRAE1ulii/0rsA6yceJMh9B9ZQ3XawtFd6yJL0+nq/4nubszREwByfNtucw9Q4vGMqaSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720623722; c=relaxed/simple;
	bh=QDdLIwvuGJH+3YMocx0eQ5iY7pjP+Q0NbuxpHPWfomE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZLYGPsOq67Zzy4vWtk3dJ5GX8G/oMrwKfWT+OjjQAt/CWqkM663YX/y52NOUcCKegNXWZL66cUO/kiPUAIBBogs3/VmDB1AgW092beNynBWlsvrT58u8hWxIMK8ee4k3dzao8iLYOPuR0zNXh0L2w2IiVdjbGklQmJp9VIyq5cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gsXAOE4P; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A7fwZI029796;
	Wed, 10 Jul 2024 15:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=saR9+7PEpGfVBq
	gkd2J5sGITKFU02YugwMmEtDUslkg=; b=gsXAOE4PLSR34uerJsHfLWAcChg53J
	QWy6oWc0BrK/dhQf2i0f3o73OIo/PTzdu4MCP92hVWy2aXUtKe7d3hdHEghHTq+u
	Q6T+OpT1O/yGKKxao4dQX3oHZWwAQYDI1AzQPgixskEa1AFQ/3sa8wHIHAVrRyD2
	SVm+7TGzo+hkSQ9qTuLCbYrRy8eUlargm7F+w8RFNf95Ejh774vsYHHEZfvSy/EE
	CZBrcPIVCL4Q9gKCqX4lXoDywVC6lCqxym6M7U9F6cJAGMfs6srBABJc5EO/oqPv
	D7Jnie5dK7xUGicnPApOEhJaRQmWJeJ6QeGTNWlI32D0aoojdOz0LTjw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wgpyg7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 15:00:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AEXPae036427;
	Wed, 10 Jul 2024 15:00:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tv32qfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 15:00:58 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46AEuwkU027834;
	Wed, 10 Jul 2024 15:00:57 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-175-6.vpn.oracle.com [10.175.175.6])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 407tv32q6p-1;
	Wed, 10 Jul 2024 15:00:57 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net
Cc: davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
        john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com,
        mykolal@fb.com, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, lorenzo@kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next] selftests/bpf: fix compilation failure when CONFIG_NF_FLOW_TABLE=m
Date: Wed, 10 Jul 2024 16:00:51 +0100
Message-ID: <20240710150051.192598-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_10,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100105
X-Proofpoint-ORIG-GUID: C3YWhrxLEeGBuelWOSk3Pe5pJPzqPi6O
X-Proofpoint-GUID: C3YWhrxLEeGBuelWOSk3Pe5pJPzqPi6O

In many cases, kernel netfilter functionality is built as modules.
If CONFIG_NF_FLOW_TABLE=m in particular, progs/xdp_flowtable.c
(and hence selftests) will fail to compile, so add a ___local
version of "struct flow_ports".

Fixes: c77e572d3a8c ("selftests/bpf: Add selftest for bpf_xdp_flow_lookup kfunc")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/bpf/progs/xdp_flowtable.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_flowtable.c b/tools/testing/selftests/bpf/progs/xdp_flowtable.c
index 15209650f73b..7fdc7b23ee74 100644
--- a/tools/testing/selftests/bpf/progs/xdp_flowtable.c
+++ b/tools/testing/selftests/bpf/progs/xdp_flowtable.c
@@ -58,6 +58,10 @@ static bool xdp_flowtable_offload_check_tcp_state(void *ports, void *data_end,
 	return true;
 }
 
+struct flow_ports___local {
+	__be16 source, dest;
+} __attribute__((preserve_access_index));
+
 SEC("xdp.frags")
 int xdp_flowtable_do_lookup(struct xdp_md *ctx)
 {
@@ -69,7 +73,7 @@ int xdp_flowtable_do_lookup(struct xdp_md *ctx)
 	};
 	void *data = (void *)(long)ctx->data;
 	struct ethhdr *eth = data;
-	struct flow_ports *ports;
+	struct flow_ports___local *ports;
 	__u32 *val, key = 0;
 
 	if (eth + 1 > data_end)
@@ -79,7 +83,7 @@ int xdp_flowtable_do_lookup(struct xdp_md *ctx)
 	case bpf_htons(ETH_P_IP): {
 		struct iphdr *iph = data + sizeof(*eth);
 
-		ports = (struct flow_ports *)(iph + 1);
+		ports = (struct flow_ports___local *)(iph + 1);
 		if (ports + 1 > data_end)
 			return XDP_PASS;
 
@@ -106,7 +110,7 @@ int xdp_flowtable_do_lookup(struct xdp_md *ctx)
 		struct in6_addr *dst = (struct in6_addr *)tuple.ipv6_dst;
 		struct ipv6hdr *ip6h = data + sizeof(*eth);
 
-		ports = (struct flow_ports *)(ip6h + 1);
+		ports = (struct flow_ports___local *)(ip6h + 1);
 		if (ports + 1 > data_end)
 			return XDP_PASS;
 
-- 
2.31.1


