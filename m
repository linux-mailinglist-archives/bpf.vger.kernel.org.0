Return-Path: <bpf+bounces-58492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 868EBABC512
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 19:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D62189BC16
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 17:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8AD2874EF;
	Mon, 19 May 2025 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GWy+7AVN"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F4D125DF
	for <bpf@vger.kernel.org>; Mon, 19 May 2025 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747674014; cv=none; b=L46rVLbMrMf3215Bm/u7QE4PRlHGxRtAIiO2uToj7krFegKKOkS8u7zA94Qj9DdrB367QZ7qOd9UYi5MlfLz7D+HvhwEsUapfBqKU6vvPKKajwvS+BM12gooFaVrzO1BbShTuam8U/UFEjx/VlsXS27ARyKOR/nuW3OKFVawOb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747674014; c=relaxed/simple;
	bh=onMkQqx3B7v6ihjBDGkem3rFz1QyLiCt8QUNVDqNSSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNKBXt644tk3Ue/4SRpvw2Ka5IHNljlX0GTZznFIkm0SFOUCO9RM4d/J+cTVcMyb6x0AkrAQ2k4gqoKjAL7rv8SO/xv3MbKVj1jAf3JPqJnM8Ns7+ZbRWeEWiB6XCBNYzWj8DnJuNRV8Awm9QyxkTfBv1zYJqfSqk2G9bqkNxqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GWy+7AVN; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JGMrjn013874;
	Mon, 19 May 2025 16:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=i0GMy
	UUrlFaKayoABMub7eKmkKryFgoT+pFmdexVUUk=; b=GWy+7AVNtEfoA38cgoBUt
	wpLlrgq7S7VFbcRJA4d2NfhJSudSuj+UVKFTpl/y0fS6GcyxuW0JTDLx8LwHQExU
	6gMIwzxB2oxNCaNEYteTVx0hQT347x9GXcHNmK1eLLQi+ThLNzpJPKQDtsANNc/J
	QLJkFDX3q9ZpQ8bGS77wQscJjJ2ur8ZHd0n+YBeFWa3EWxW5ga+mobw9BgNdUHsc
	zdisKyeCp/V0nudPS0W5k6Kajf18u3cczXKsTarPRrwl3S/05ov58OOra3vLWDQd
	N+x6R6RoiDpY51hb+9hJne9P1Ijd3+VpLx+lXPzxI37Oecep4NMWDHb3k9AS0srd
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ph23bjqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 16:59:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54JFE4ot002582;
	Mon, 19 May 2025 16:59:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw6q2js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 16:59:44 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54JGu0Jn010939;
	Mon, 19 May 2025 16:59:43 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-48-230.vpn.oracle.com [10.154.48.230])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 46pgw6q2f5-2;
	Mon, 19 May 2025 16:59:43 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org
Cc: ast@kernel.org, ttreyer@meta.com, daniel@iogearbox.net,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 1/2] libbpf/btf: Fix string handling to support multi-split BTF
Date: Mon, 19 May 2025 17:59:34 +0100
Message-ID: <20250519165935.261614-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250519165935.261614-1-alan.maguire@oracle.com>
References: <20250519165935.261614-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505190158
X-Authority-Analysis: v=2.4 cv=GN4IEvNK c=1 sm=1 tr=0 ts=682b6381 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=nSa9Acew1kpqUmrBwOEA:9
X-Proofpoint-ORIG-GUID: P41X7zjMvolgQapxtV_4RvktB4spqjNW
X-Proofpoint-GUID: P41X7zjMvolgQapxtV_4RvktB4spqjNW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE1OCBTYWx0ZWRfX6Fex6Vb5u3ow mTmHPpL8XdZMc0eBqEY/LMJ9iMAt0atiWypq9qM8lGldzrw7bJ5UHKASgDRmRwGioHsiFnUJHZc whpQAN0LM0/j60GVr8iQW6Jl58WqlQVSC52+/bQC/bnWlJZk/SLzvM0WE7czWgrc5c+oQ+sO4ti
 N6mHPmy/3/Z/xrlKLH0lB00o9EBupNJi2fbhoE/ibDOLZGYAWSMX8sWWP5O3Kb4629s+xk6H6rL y9fVkB8KMajeAQ2CB35y2Tz70vQNjt+GV65xAW1jc3aLZ8KmTC76oXBc1t+aLygQKmF/ZNZo+Ol YTMDrDyOpr3a5P8R4FaN2Pj4RuoeAvKB6PTvYGfpt+WXQpT0MpjYc5siIxYdl9JKWvwl6o95Hi+
 2LxqqxtU9iJxqLHt6sGFSr190XAigVlSaIXd/f0cxh/EbCGKSe9Kkzydz7zayw5fHiiV2/+8

libbpf handling of split BTF has been written largely with the
assumption that multiple splits are possible, i.e. split BTF on top of
split BTF on top of base BTF.  One area where this does not quite work
is string handling in split BTF; the start string offset should be the
base BTF string section length + the base BTF string offset.  This
worked in the past because for a single split BTF with base the start
string offset was always 0.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index f18d7e6a453c..8d0d0b645a75 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -996,7 +996,7 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 	if (base_btf) {
 		btf->base_btf = base_btf;
 		btf->start_id = btf__type_cnt(base_btf);
-		btf->start_str_off = base_btf->hdr->str_len;
+		btf->start_str_off = base_btf->hdr->str_len + base_btf->start_str_off;
 		btf->swapped_endian = base_btf->swapped_endian;
 	}
 
-- 
2.39.3


