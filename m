Return-Path: <bpf+bounces-78295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBCBD087DC
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 11:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E75FE304EAB9
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 10:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B785337BAD;
	Fri,  9 Jan 2026 10:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OOI1f7/s"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DB73376BA
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767953646; cv=none; b=tQsNxKdpHYwk9efXO56BK045Iy3E95MoU+LLTFmeMdeTH8cGGL/ICTvRT/xrxh4CvPPoKE5X2Yb+YvqR57v0kr+iU52NztxRK1u0zr0soKNUZUjzmmEgDUg4z5GYPrtOGpyJWHUciCsVF+FytSOuLIpV5QtNRtUi+YNuxj+ggLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767953646; c=relaxed/simple;
	bh=8EtyrDwY/09ML2UHgTpDAMhjubOGMR4PWEweE35yTq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YglQqSLH+jRd4bmlYdO9kyeWPs3jazwW/8umfEnVMLnJL5DtAk0fIJk0+qNGI1ccbpmlqNwfHf8TvTLp8cwnLjC4cjqHKKvjWHV7dD+TR4tcYOElzf2YIDrliOAe6dWrVmtcUB/UaF8vgx56NY6EXtakDJ9YBuAyFA1H6v6gQhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OOI1f7/s; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6099DXK93225775;
	Fri, 9 Jan 2026 10:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=NmXhyE3jmmMggszJAtH56LcKf/UFH
	pcY4I3h+kuHaI8=; b=OOI1f7/smYOLQxbZqd2H2XtWZ10O0QFUedPiDYDVpT7fN
	ak+vVr68nBxyGn9tQJwXYerfwR7J7Q1GAhLldDz4gUF8RA70newsvLa3ODKaHHGi
	tI0bOYrh2M8WByeGx+C98DP3mRY4CvJ1X6DlBx7x9LbYXy/hLpGF+33e28JtfelH
	3k2dYYD9aDDWxO0Q4FettXxTrHuzp5s2lhDiy6zMMx4NASvxbU7546MhKmiFqNgX
	RyqQGb2RpyNFihY9PrBit4zqiw6fQeR5shr28yNG3OpiMlKkUkKb3LmY5rQnZXbS
	9RmF8m4IJ9lEkg8GE9BG7huGnPh1xX+japEILHKWg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bjxuv821p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Jan 2026 10:13:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60980TkF026322;
	Fri, 9 Jan 2026 10:13:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjpfhwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Jan 2026 10:13:40 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 609ADd3K002889;
	Fri, 9 Jan 2026 10:13:39 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-55-245.vpn.oracle.com [10.154.55.245])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4besjpfhsj-1;
	Fri, 09 Jan 2026 10:13:39 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org
Cc: ast@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, nilay@linux.ibm.com,
        bvanassche@acm.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf] libbpf: BTF dedup should ignore modifiers in type equivalence checks
Date: Fri,  9 Jan 2026 10:13:25 +0000
Message-ID: <20260109101325.47721-1-alan.maguire@oracle.com>
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
 definitions=2026-01-09_03,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601090074
X-Proofpoint-ORIG-GUID: DEZMPqPRjSXRICKYUlH8F4OOKI76djb1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA3MyBTYWx0ZWRfX1Z3Ahh5io/9O
 j1JUcboWf6+UVAE566MKlr8/MFw+wfB0glawOfnWl+cpHUPhaDdGFv3Wr315x3YTjNQR4M1nm3p
 JWxv3YX+RJhE7gzwkM0tsOVpdyUBa3kEYMQ8ImrsglOWGXPpre0zGcElDU2BmRNP4wEr56f9e5j
 ty0iD6OeiZm9J0rKv2y1GMeua3SMYXpDy3dOynrqyXe30L72ojQsOojRgGE36NecKF6uwbwVlMG
 UWcJrikS2H2wRrBZo9zWrile6sRR42IytpJGIwSip0GjtwdOrL5QKOLekUyXb1SsVIXBUVq5/Fc
 kcb1NyOVQkZKRQjAoRaG+FacteWW1YRjNjP6hqgFeEzHT54NdPOse/J8xXX/cHlZMXx84zB1rUg
 6GSuK66aC0AA5E12GFDUENzywyMujMvjbdYyJoue4Bk8WsPdNlyp7BQYbPUY5A5h9Y2+m3xdiz0
 HFzWuGry6L80XbOpQEcdOqhFJsWdpVDbSau798As=
X-Authority-Analysis: v=2.4 cv=ara/yCZV c=1 sm=1 tr=0 ts=6960d4d4 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=yPCof4ZbAAAA:8 a=Okz6QPqX2RRS1ZvgQmQA:9 cc=ntf awl=host:12110
X-Proofpoint-GUID: DEZMPqPRjSXRICKYUlH8F4OOKI76djb1

We see identical type problems in [1] as a result of an occasionally
applied volatile modifier to kernel data structures. Such things can
result from different header include patterns, explicit Makefile
rules etc.  As a result consider types with modifiers const, volatile
and restrict as equivalent for dedup equivalence testing purposes.

Type tag is excluded from modifier equivalence as it would be possible
we would end up with the type without the type tag annotations in the
final BTF, which could potentially lead to information loss.

[1] https://lore.kernel.org/bpf/42a1b4b0-83d0-4dda-b1df-15a1b7c7638d@linux.ibm.com/

Reported-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index b136572e889a..89fbeed948a8 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -4677,12 +4677,10 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 	cand_kind = btf_kind(cand_type);
 	canon_kind = btf_kind(canon_type);
 
-	if (cand_type->name_off != canon_type->name_off)
-		return 0;
-
 	/* FWD <--> STRUCT/UNION equivalence check, if enabled */
-	if ((cand_kind == BTF_KIND_FWD || canon_kind == BTF_KIND_FWD)
-	    && cand_kind != canon_kind) {
+	if ((cand_kind == BTF_KIND_FWD || canon_kind == BTF_KIND_FWD) &&
+	    cand_type->name_off == canon_type->name_off &&
+	    cand_kind != canon_kind) {
 		__u16 real_kind;
 		__u16 fwd_kind;
 
@@ -4699,7 +4697,24 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 		return fwd_kind == real_kind;
 	}
 
-	if (cand_kind != canon_kind)
+	/*
+	 * Types are considered equivalent if modifiers (const, volatile,
+	 * restrict) are present for one but not the other.
+	 */
+	if (cand_kind != canon_kind) {
+		__u32 next_cand_id = cand_id;
+		__u32 next_canon_id = canon_id;
+
+		if (btf_is_mod(cand_type) && !btf_is_type_tag(cand_type))
+			next_cand_id = cand_type->type;
+		if (btf_is_mod(canon_type) && !btf_is_type_tag(canon_type))
+			next_canon_id = canon_type->type;
+		if (cand_id == next_cand_id && canon_id == next_canon_id)
+			return 0;
+		return btf_dedup_is_equiv(d, next_cand_id, next_canon_id);
+	}
+
+	if (cand_type->name_off != canon_type->name_off)
 		return 0;
 
 	switch (cand_kind) {
-- 
2.39.3


