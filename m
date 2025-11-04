Return-Path: <bpf+bounces-73499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FF1C32E9F
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 21:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD1064E749F
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 20:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340BB2E92D2;
	Tue,  4 Nov 2025 20:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NM6YPrlR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5072DFF3F
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 20:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762288451; cv=none; b=IKJFG7otNH9xs64nOr7fFAURHsrNGETIYBwd/5gGeuoy9DvrdApCPVLkVp6VzQPeXrIwQYCNOKEZefAxPZW4mIOGBCXcHYcb3yYh77nIlBMfC7fd4e8QS3jfg/Y/Cw6Pvyi+gApmZo+FubfidFG9WCb67nKYICW5bfwRCoru64Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762288451; c=relaxed/simple;
	bh=zNE2LkYBE1AfnhkzSQtQjrR2ixibO4hF2kKDWh9mL3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8PxmfqW+ahnDvFb3ZD4nS1j15QdRkftree2Ts8Bznof43F/OtHXRMQoG3j1FVlFZ1b1FWpKtKKoWEoIbHMTiXPHN8VWDgE7UyI94P9bTOR/fuSGew88cCsklhLO9+Cjp/OVk3oPs68QoNuYzHvGVulYv8ByQSV2iAGUS6LYTnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NM6YPrlR; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4KNhot006166;
	Tue, 4 Nov 2025 20:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=x+n/+
	Ats/aYSejTHy5UAOY+8Mhm7JLyoFaunsScIIh4=; b=NM6YPrlRpDSVfA+AF3O0S
	Qh66VBERCoblEGbTc4q3rg/e36lN1A3UAuQEmdZY1BgdgRIv+ON41NBVLb6+yP22
	dPBHzSoNBDegibIAS2KfbX5XXp1kiTY/Hz/HFowHDkKj89DYHzatqipu/O9r+fU3
	N17bePHRdEFBDYnhb4ZHz4HqV9+sHMNPoxWEGqhtEZ+MHJ5BXj/W2A+S2mEDVNue
	0WFn00SV2ibUdzCL0VQu29T7cmz5757a+90Sx7RsGLWoLS+70TyygBf1pFLX6Y3v
	vFzOPWXMOb96agnP+zqW1LaaIDXnl/1UJiEH2+2JSFguxQx+Gg47qJLUB50AzwJg
	g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a7rbp01e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 20:33:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4KPIo1019392;
	Tue, 4 Nov 2025 20:33:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nkw96g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 20:33:35 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A4KXWve039670;
	Tue, 4 Nov 2025 20:33:34 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-59-143.vpn.oracle.com [10.154.59.143])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4a58nkw8un-2;
	Tue, 04 Nov 2025 20:33:34 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org
Cc: eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, ihor.solodrai@linux.dev,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 1/2] libbpf: Fix parsing of multi-split BTF
Date: Tue,  4 Nov 2025 20:33:08 +0000
Message-ID: <20251104203309.318429-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251104203309.318429-1-alan.maguire@oracle.com>
References: <20251104203309.318429-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511040173
X-Authority-Analysis: v=2.4 cv=UJjQ3Sfy c=1 sm=1 tr=0 ts=690a6320 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=XlrTAmi2F6-cTnHVTwAA:9 cc=ntf awl=host:12124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE3MCBTYWx0ZWRfX5Xyf5W5k0ts1
 wEy86lcdNWJMcg0MJBZm97ReRQSL5QRzGzOVgC252hv/LTpMYPvJbv/RL4iqqQID5X8l0oceF73
 +uXKAF6y64LnFOV9+YYtT1hviyuGdw44mkKUn0RP9wKzwnO9MncpAqv0iUiYf90r6ELi+xHl/so
 oG8hoEgDNnlXuBh9cQt2Y2/la8NgoBIYQRX0ziGEFhelC3SBT1pJ9qe2eBAxZmzVYUOZD16bcbh
 N9BZINxuer2ZyK6mFMvd4cUoNoBOEGmdlq674IULC9vRpVFJ4cjrpRs0MuFuvn8HDjZNwJ8+Pz+
 X6R90VTRG48c/PjmJS2ZrEf9qu8TYr+a/X0nfVV/rs3wYRec9VHh04YGqewXeimu/QzY5ytqLhC
 aPKvbbUogh9931iQWdtXpMiBbf9H5fCEr/ZAZWigcHH3uX+OtZw=
X-Proofpoint-ORIG-GUID: BZJQUX3z0A0DW7pAtZ3njBF9mfCTa5Sz
X-Proofpoint-GUID: BZJQUX3z0A0DW7pAtZ3njBF9mfCTa5Sz

When creating multi-split BTF we correctly set the start string offset
to be the size of the base string section plus the base BTF start
string offset; the latter is needed for multi-split BTF since the
offset is non-zero there.

Unfortunately the BTF parsing case needed that logic and it was
missed.

Fixes: 4e29128a9ace ("libbpf/btf: Fix string handling to support multi-split BTF")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 18907f0fcf9f..9f141395c074 100644
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
@@ -5818,7 +5818,7 @@ void btf_set_base_btf(struct btf *btf, const struct btf *base_btf)
 {
 	btf->base_btf = (struct btf *)base_btf;
 	btf->start_id = btf__type_cnt(base_btf);
-	btf->start_str_off = base_btf->hdr->str_len;
+	btf->start_str_off = base_btf->hdr->str_len + base_btf->start_str_off;
 }
 
 int btf__relocate(struct btf *btf, const struct btf *base_btf)
-- 
2.39.3


