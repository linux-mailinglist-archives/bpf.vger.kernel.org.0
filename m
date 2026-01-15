Return-Path: <bpf+bounces-79068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04699D25C5C
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 17:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6854A3003199
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 16:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2813BC4EE;
	Thu, 15 Jan 2026 16:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gLtND0uP"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A438C3BB9FE
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 16:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768494939; cv=none; b=W1LK7+3BB13cNDZWu8f0jUzoJPhzN6oW2mmcp+QvrIDApUTMg0AJnxRKJ/xF/LAXNScCFqVyk1IuLQzda94uDSNwh+Qm9xIH3qHrVGoa+fOl5n5nrukswVhpVTU44h4V9ppjekBccZOat2AacjGoIHMogF2VjiLAj0uhV/yG1Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768494939; c=relaxed/simple;
	bh=VuiM20ERhP6WnZdQe8Xxn6PzJLR3svN2yiTp6Sz7xFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=niB7wZW0jdKUubBYNF+Oy5igtJEvGre8ZFuJFHrQwAA1b5ZLwBPGPpBRNUnAL/NYRXoWMzUmJqk5l97g5co/wWc0mRl+IpBhpqBCvoh1F825fQEhhDiSvOqlqQEcydmGTtCV94271/tEAcKyqsDBLP1O+q9NoJRnyh/hgtGLS3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gLtND0uP; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FEtBk5802772;
	Thu, 15 Jan 2026 16:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=3uWMvpb0vrNnEBuCeZrI3BGMpfMJk
	EO/lUJz6vUZWVQ=; b=gLtND0uP6a1gv/Gu1JjiO40uDb3wMmDVceKlEfBTXsPj7
	k5U3X2dJgb2FzMVbIRXeydXwjiIBOMW4HnpvuQSpTq1x+NQG1H9AJ2ICFDEG0XvS
	XT1hJDcTIYumsrAFFneSvbZbCaVnweh0A1yK3Gr1SMnotesSAth57tqGe1HZTzRL
	NT/G35D732Iyn9L8qNttknEpYLuVj/aQpvTWTO/AVtBj9D89x2nwXxjbO95li+3e
	RkDm2zQHR3VlaLaYYCt/Lvv9RmyYp4AI+TqMINEpxkhpc3lDAxw1EittDEqq0vHc
	lpdSlB+wssqpV9f8vgLnQ8M+f7efUNuZAyvN/gmOg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkre4077k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 16:35:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60FG5kto004244;
	Thu, 15 Jan 2026 16:35:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7nacf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 16:35:00 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60FGZ03R033048;
	Thu, 15 Jan 2026 16:35:00 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-30.vpn.oracle.com [10.154.52.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4bkd7nacdg-1;
	Thu, 15 Jan 2026 16:35:00 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, alexis.lothore@bootlin.com,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf] selftests/bpf: Support when CONFIG_VXLAN=m
Date: Thu, 15 Jan 2026 16:34:57 +0000
Message-ID: <20260115163457.146267-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_05,2026-01-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601150126
X-Proofpoint-ORIG-GUID: SlZKVP0Dnig-xVAt8SV-jaqwhbclivUO
X-Authority-Analysis: v=2.4 cv=YKOSCBGx c=1 sm=1 tr=0 ts=69691736 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=9TsxrzUAS9hMPq_yXcUA:9 cc=ntf awl=host:12110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDEyNiBTYWx0ZWRfX8BpZhXvAXGZd
 iC2OZ0Qcal2CnutQAJPqqVaymxGJQm0hXo0KslxpD5udcxBcuYbo3jflJgOCls4asXLFzKBOT2b
 FHqft+ZvGWQhnHOwZnMQW1+dHpLrNKAuZTe8adD19dECCXOeU3mwoRzGBUae/6Ki0F4tSEK+VbH
 gvuTGgYcjtjAq1Jv8A6JReIRiO57IefwCt/dCuzP2i2d1bc+WlvybiNfRfGn80Dj6AEyKX7a7zK
 Ywu4JnawWljEzqtTuT4F8GB3kP6Iqs1094LaLRH7Ll0jmydFGfXu2E4pq660hi1u1y+rI4jFYE8
 Do9OUcezI+BKgXzRVg2VAbA372rw2UmyVneoLmmYyq9Ssm96I9soBHSAPvWvK0o3SFGJ78mXCdO
 7wFX7QKFvGoVtpvCJglVC0B5IhpOOjzfnjTWyuj5PvGCNIZppWRxfaEzSIn72Z4uvaN2lDTioGO
 mjYH052IAqWpuMKoB+HjdPEY9OBjob5fCbsyPUCc=
X-Proofpoint-GUID: SlZKVP0Dnig-xVAt8SV-jaqwhbclivUO

If CONFIG_VXLAN is 'm', struct vxlanhdr will not be in vmlinux.h.
Add a ___local variant to support cases where vxlan is a module.

Fixes: 8517b1abe5ea ("selftests/bpf: Integrate test_tc_tunnel.sh tests into test_progs")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/progs/test_tc_tunnel.c      | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
index 7330c61b5730..7376df405a6b 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
@@ -23,7 +23,12 @@ static const int cfg_udp_src = 20000;
 	(((__u64)len & BPF_ADJ_ROOM_ENCAP_L2_MASK)	\
 	 << BPF_ADJ_ROOM_ENCAP_L2_SHIFT)
 
-#define	L2_PAD_SZ	(sizeof(struct vxlanhdr) + ETH_HLEN)
+struct vxlanhdr___local {
+	__be32 vx_flags;
+	__be32 vx_vni;
+};
+
+#define	L2_PAD_SZ	(sizeof(struct vxlanhdr___local) + ETH_HLEN)
 
 #define	UDP_PORT		5555
 #define	MPLS_OVER_UDP_PORT	6635
@@ -154,7 +159,7 @@ static __always_inline int __encap_ipv4(struct __sk_buff *skb, __u8 encap_proto,
 		l2_len = ETH_HLEN;
 		if (ext_proto & EXTPROTO_VXLAN) {
 			udp_dst = VXLAN_UDP_PORT;
-			l2_len += sizeof(struct vxlanhdr);
+			l2_len += sizeof(struct vxlanhdr___local);
 		} else
 			udp_dst = ETH_OVER_UDP_PORT;
 		break;
@@ -195,12 +200,12 @@ static __always_inline int __encap_ipv4(struct __sk_buff *skb, __u8 encap_proto,
 		flags |= BPF_F_ADJ_ROOM_ENCAP_L2_ETH;
 
 		if (ext_proto & EXTPROTO_VXLAN) {
-			struct vxlanhdr *vxlan_hdr = (struct vxlanhdr *)l2_hdr;
+			struct vxlanhdr___local *vxlan_hdr = (struct vxlanhdr___local *)l2_hdr;
 
 			vxlan_hdr->vx_flags = VXLAN_FLAGS;
 			vxlan_hdr->vx_vni = VXLAN_VNI;
 
-			l2_hdr += sizeof(struct vxlanhdr);
+			l2_hdr += sizeof(struct vxlanhdr___local);
 		}
 
 		if (bpf_skb_load_bytes(skb, 0, l2_hdr, ETH_HLEN))
@@ -285,7 +290,7 @@ static __always_inline int __encap_ipv6(struct __sk_buff *skb, __u8 encap_proto,
 		l2_len = ETH_HLEN;
 		if (ext_proto & EXTPROTO_VXLAN) {
 			udp_dst = VXLAN_UDP_PORT;
-			l2_len += sizeof(struct vxlanhdr);
+			l2_len += sizeof(struct vxlanhdr___local);
 		} else
 			udp_dst = ETH_OVER_UDP_PORT;
 		break;
@@ -325,12 +330,12 @@ static __always_inline int __encap_ipv6(struct __sk_buff *skb, __u8 encap_proto,
 		flags |= BPF_F_ADJ_ROOM_ENCAP_L2_ETH;
 
 		if (ext_proto & EXTPROTO_VXLAN) {
-			struct vxlanhdr *vxlan_hdr = (struct vxlanhdr *)l2_hdr;
+			struct vxlanhdr___local *vxlan_hdr = (struct vxlanhdr___local *)l2_hdr;
 
 			vxlan_hdr->vx_flags = VXLAN_FLAGS;
 			vxlan_hdr->vx_vni = VXLAN_VNI;
 
-			l2_hdr += sizeof(struct vxlanhdr);
+			l2_hdr += sizeof(struct vxlanhdr___local);
 		}
 
 		if (bpf_skb_load_bytes(skb, 0, l2_hdr, ETH_HLEN))
@@ -639,7 +644,7 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
 			olen += ETH_HLEN;
 			break;
 		case VXLAN_UDP_PORT:
-			olen += ETH_HLEN + sizeof(struct vxlanhdr);
+			olen += ETH_HLEN + sizeof(struct vxlanhdr___local);
 			break;
 		}
 		break;
-- 
2.39.3


