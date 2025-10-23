Return-Path: <bpf+bounces-71931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33BAC01CCB
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 16:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662EE3A3FDF
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 14:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3329432AADD;
	Thu, 23 Oct 2025 14:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FfWceYWd"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EF32FC877
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761229735; cv=none; b=lcffM0TxkVn7b6iPBiXUbGtrooi03aD/5qGWyUBUHs09OorMhBK8bePq2Z5vVww8kmWaTi310EkWyCirU9Bh4iP9bIRrW7QkqHXSNvaAIP47p5GBkJHfe4io6bzY3FQk0RyicPO+k77Rw9DjcYRRCdGXj/k1ZFop8ypdqIMiejc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761229735; c=relaxed/simple;
	bh=WP3Ux75pe+WCU4tYoC5mW9biKP3m6syLlUoPSNx54pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SPRyT9ej1tP1bWwktYVksB7UJeg/kd3Kcc+rn0mb1iwvW2rlZTIO91Cm0ftdWdBMZzS3tKFeBx3PxKeea8mXw1uO8qFj49kjwVlrjFmSe7QkBVsVBDEAIT5ok+vuz9FBTaKzaglqhmmVDRHQc/A7oTmqBu8Y/8tw0O9xhYquasY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FfWceYWd; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NAtis9016311;
	Thu, 23 Oct 2025 14:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=AWw8Hbt3SBCABcPW3CxZruk6S6CqO
	YUvDzmSD9EtedQ=; b=FfWceYWdp33n7Xk5xIixlkTfOBO1K/a6uMeOrb1RpPmNJ
	gWXw1etRr2x7Qp2aTaUIay8NZDWA5Yidpg2Y29HQEBXAqxrIwyJ+YSy+pnyxNL88
	dv8gN1KgCXcijzglMvgfZ/UGxaA0Uhzu9dm3WGGcYUC46vAIRf5JkMeC0fPAY8w3
	FX4t6c1ZVq1zIQSXRNU3J+858YsmRMX4a1AJrBmPZeCA0/r2ka1cIZlmYRHvNAFI
	nQdT96qjpHDXJy8EqdaIR5V9q1DP86wqFdQGJf69JNAUl78K0CM6+2bJEceEsxtw
	cEos4fJpR2UD6a+wqGEqmP9K00udRqFvFd1f2zaig==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2vw1vaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 14:28:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59NEEl3K025308;
	Thu, 23 Oct 2025 14:28:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49xwk94ttc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 14:28:29 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59NESS9n023920;
	Thu, 23 Oct 2025 14:28:28 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-57-124.vpn.oracle.com [10.154.57.124])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49xwk94tqh-1;
	Thu, 23 Oct 2025 14:28:28 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next] libbpf: Fix parsing of multi-split BTF
Date: Thu, 23 Oct 2025 15:28:12 +0100
Message-ID: <20251023142812.258870-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510230132
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX5g5/SdFZdKM+
 shR0p28xUlp+IWTk3eWXvUCknr+l/q90KXI/uarMqsI+jbQ3HjXNiX9lzEnEluAQPw/DFxJ2CKN
 E79CvHNPODDQFXbkY6wPxyCJhYbvn280AVX4RnukjMUmBH4kis2xgyyjvFhEHotb7EHfXHJS3gj
 TMelNDDCtmnlhcsz+Mbe2SujfyhvDXZV6okM9LNY/kUkdlKv3MjUuYP2COu0LQGm0HCdHIiZ5r1
 YJyvRmtfvOV1ANWgw+dK6ZtpxWpCYudjMeMvTK8HoivLZDnJ0zzIll53RAhxIoSt8hNf0x7ARu6
 sY6lpcvbm1h37y8dNwAe/lAbALfp7QUOtad1VtFI7Gk8tWb8OqFgI/bT2GbAAzzmygoLBz4aqZ0
 LrGsIFwk0Jhgq6gWv6Z8XepeD4mbAlVoECYNBEpjV8uKhtWA7Os=
X-Proofpoint-ORIG-GUID: iScO3amnNEQGGw4oLKNQ1nobYyeAlefd
X-Proofpoint-GUID: iScO3amnNEQGGw4oLKNQ1nobYyeAlefd
X-Authority-Analysis: v=2.4 cv=FuwIPmrq c=1 sm=1 tr=0 ts=68fa3b8d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=QiS3IIuQj6xAO4Mm2N8A:9 cc=ntf awl=host:12092

When creating multi-split BTF we correctly set the start string offset
to be the size of the base string section plus the base BTF start
string offset; the latter is needed for multi-split BTF since the
offset is non-zero there.

Unfortunately the BTF parsing case needed that logic and it was
missed.

Fixes: 4e29128a9ace ("libbpf/btf: Fix string handling to support
multi-split BTF")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 18907f0fcf9f..4154781e8bfa 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1061,7 +1061,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
 	if (base_btf) {
 		btf->base_btf = base_btf;
 		btf->start_id = btf__type_cnt(base_btf);
-		btf->start_str_off = base_btf->hdr->str_len;
+		btf->start_str_off = base_btf->hdr->str_len + base_btf->start_str_off;
 	}
 
 	if (is_mmap) {
-- 
2.43.5


