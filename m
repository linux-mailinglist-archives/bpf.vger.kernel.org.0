Return-Path: <bpf+bounces-72565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F70C15A7B
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 17:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DC2404FFD
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 15:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D693451A9;
	Tue, 28 Oct 2025 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MPFw6GU7"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934BC3446B5
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667067; cv=none; b=rmmXLgY37RYJDAR2pzU/gx6VHl6rNFnXPrtwt1AP3/3yj3RSvhE/CKXaylA97lUZGnPv0S+yTOOXvoO5V8Oob1yVkGZriOWxNZY1lnneGj7aJL0X1Lhc2JhTsUrLgVsKtoEgnyN7vNy+vg/Jxd5pefQUFlbq7soRTNvwrZyAGjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667067; c=relaxed/simple;
	bh=aCDjGvX3Wf+l8cPhrpK2Olg0SxRnro3L7eXVTgyOmfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaZelDFnknZHo0u2H7pVEI5gMsJ1rkeJCIz1+8cCAHzXA7RrulNNOOOVZkZPUs//Fj9LAr2Q3Y9zGkfSSD/+qP49GQJiQLjvO0JIYW1J2fb36katbe5UJVfqAZ/lgljH6Wp/2z8eNXzm/9slS+gB/da693+wJ+OUMVuWz3pYhk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MPFw6GU7; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SBDnpl010051;
	Tue, 28 Oct 2025 15:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Tzb8m
	nRoJ/Hy4tntlkpSkW4VSeXd5ajZr7Qd5CejXsU=; b=MPFw6GU7yjPD6PspLi2Uv
	nJeOXWZkEBuSrQu3CxZNWu8mUy7/AUbGAQHZQRZIyJ+dg2x9mK/wVxn7Z7r6qaX1
	UhVXqdZi4HTZdSDk2BpjBfjHy916nMoZk9klCqe0Z3iWifpaElL8WQCHGvsMg0Dk
	vYtqboUSaCxZ7OcU2pGe/m3k9iIlMIb/W42WEJZllQrzK/ys2nZqJRgQgGm9EsTq
	UYWDmoro9loCBKai7RVg1bOEsfA4KOQUXzXIrTgxxDmnzo+kiHt+Q5x2jjdpee/f
	+KsEpZ/47Ri1Q3V5HITK08eI535uVKE7a88CvknINogZyndu9+4Mt4h2PQX+3RUp
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a0q3s6g9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 15:57:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59SEq89g016897;
	Tue, 28 Oct 2025 15:57:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n08cgux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 15:57:18 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59SFvDAc009896;
	Tue, 28 Oct 2025 15:57:17 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-56-75.vpn.oracle.com [10.154.56.75])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a0n08cgqf-2;
	Tue, 28 Oct 2025 15:57:17 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org
Cc: eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, ihor.solodrai@linux.dev, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 1/2] libbpf: Fix parsing of multi-split BTF
Date: Tue, 28 Oct 2025 15:57:08 +0000
Message-ID: <20251028155709.1265445-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251028155709.1265445-1-alan.maguire@oracle.com>
References: <20251028155709.1265445-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510280134
X-Proofpoint-ORIG-GUID: VK2aZFVTVj53TC_wgIZoSfQGD-MIiI9Q
X-Proofpoint-GUID: VK2aZFVTVj53TC_wgIZoSfQGD-MIiI9Q
X-Authority-Analysis: v=2.4 cv=Q57fIo2a c=1 sm=1 tr=0 ts=6900e7de cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=XlrTAmi2F6-cTnHVTwAA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAzMSBTYWx0ZWRfXwXos+wPYc+qF
 E1YEPf40qTI9WGIyuVZ1AxM5K0Q/i9Gr4RpJ9tkpYXAdZOfjKy1uQJWaEjxyW+0ip9mvpFZcrHH
 qCHg89FT6hl2rgcpdgyoYsTtKRvYLbxcqpS/AwlsMIzvwlwcBiKG+x7rm5ekdJrsZ0FrU5HpAke
 hFErc+9YaJqXkRNc+RRQL1x8825DU8Xnvm+pYq7ZHeGSpQJI4u79mpv1/3tJIjtBmnS/S+HU/C7
 /fwPcv0UKwKa1QClUR2yRR4lG3Q9aU3v1J9UwKBGGeGmXRKSrOXCsdv1AcbQwfms91il470e29A
 HRd57o1DZqmZlRdapww3EROm/5fUEHqJMXO7wtzAnMkhgr4jy7Zh9cpz+mRJLXV9sDSyBkqPE78
 iqFHpHtnyHS5BFg2TwF81MqB4dlGPA==

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


