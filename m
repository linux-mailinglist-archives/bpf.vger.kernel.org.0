Return-Path: <bpf+bounces-70600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 477B1BC6270
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 19:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 265D84E22A1
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 17:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5CA2BEFF3;
	Wed,  8 Oct 2025 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ODpbwMkW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E4E2BEFEB
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759944950; cv=none; b=tTfXd4DI4B5UC2JmUw2XIHhu1h+PYCXlE4nmHfsL1qMfRkbbg/b9yGWRgAagf2TrnQbCHF/ntn2pRR3vdHBRR0eSa2K7lMvrJrCNwCvnaBNrpoLEZuHfK6l4k4ab04QNc6vMzLZwZeeg4vcFlZrPsHZ+6SjOTVNYezxYGUrPOV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759944950; c=relaxed/simple;
	bh=lD5S7P0rWMEHMGzhd3xt3SpAFdA1Ult2VhGn+i24xf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNQnYdrAabsQ+JUVLFuRHd5IEeSne+UV0m8Llorsori4Vp+sNEXZydL34KHfIgMrWhsT3MFqiLjV2wyccCCyznzJ1CYNDYoM/OzQVsN3huEAUCe9xedeH7tK+r6INZkP44Tt2UrTJnJyjWOZsPsIBAqEARTe8nrhXHBGfP/Su+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ODpbwMkW; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598HEU6q029334;
	Wed, 8 Oct 2025 17:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=hEXFS
	lC+E05ysNBx/r2KZMiAVYmkerzfUhsLAWI7Yn8=; b=ODpbwMkWvyLCi9gce9Fp7
	GNSf7HaLtdaCF0WfUw2ec/cluDdYScCCzv1Qxp9brfCA3aJeKul4dygob4MaAkpQ
	J8QccZYvQCM5Srelavh+D9bMOKWon/KDpO9TcYibYeaLzUqM4usNat997Lg2vJOg
	yTOn3aG+cSFbfoq0P6yWndHkZKgfZBFaS38XPUuUFqBak0ya/Gw0sn0oC7WRcQbX
	q5UE9v9xP7LLEgkZM1lu/OVGOnJBEYdIokyx4c05RqWZEHLBxF+qTd8rE5IBkm0y
	xguafNBGmikpoPttK0PjQYr3HQFGQhb03pWrsTDZ+KSY9vzsMlG6aUQ2CKbxhCgm
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6b81ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 598HDxV3037196;
	Wed, 8 Oct 2025 17:35:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49nv62rpuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:26 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 598HZFUo031138;
	Wed, 8 Oct 2025 17:35:26 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-90.vpn.oracle.com [10.154.53.90])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49nv62rpmb-5;
	Wed, 08 Oct 2025 17:35:25 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 04/15] libbpf: Fix parsing of multi-split BTF
Date: Wed,  8 Oct 2025 18:35:00 +0100
Message-ID: <20251008173512.731801-5-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251008173512.731801-1-alan.maguire@oracle.com>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510080123
X-Proofpoint-GUID: fAsLpzOX_ueoCxtAovTdEa17fofbgJrf
X-Authority-Analysis: v=2.4 cv=Nb7rFmD4 c=1 sm=1 tr=0 ts=68e6a0e0 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=QiS3IIuQj6xAO4Mm2N8A:9 cc=ntf
 awl=host:13625
X-Proofpoint-ORIG-GUID: fAsLpzOX_ueoCxtAovTdEa17fofbgJrf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXypB3f2ZJLunP
 3jDKbl2PsuuCi+kFSrBilwZA4bsLqmIQsL1kzB7KyHef0wbxIsjoM8GKp4X34AT3hVToHFnIMPy
 vyuXtsFMcQ7gQBJO5ug3nJnHxApr04c7kiR1Z9AGmIA4Br1dHmgk2bnkKrTmz4anSUoRxcIdqBV
 eF2mR8hhihSiEuJI8TkURMN6QYiCFPTxGbVZyu7MR2/obEYX1aB6nd+DpT8xc/BSkR+vzjHsbTJ
 2TrlLPgnAhR4m5KYKKzmCjyMWMorI86ocF2iRhi0eZoQ0cxyjT1SfqRidTu+/u0f0d5Fuf4j8m3
 u6SlwxjYlU/tMcUDsisX2Id6Flu8sy/SMH3tmreQI/1DfZH68MfNb0xMFzapXuYhNXx1m5wl8Rz
 CLKkt7sbyykGcGRBoHpA9FI5gsA4yq1UjHv+7zaBFPYssO/1rGg=

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
index 6b06fb60d39a..62d80e8e81bf 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1122,7 +1122,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
 	if (base_btf) {
 		btf->base_btf = base_btf;
 		btf->start_id = btf__type_cnt(base_btf);
-		btf->start_str_off = base_btf->hdr->str_len;
+		btf->start_str_off = base_btf->hdr->str_len + base_btf->start_str_off;
 	}
 
 	if (is_mmap) {
-- 
2.39.3


