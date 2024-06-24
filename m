Return-Path: <bpf+bounces-32899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ECA914DE5
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 15:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB55FB23D83
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 13:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BED313D628;
	Mon, 24 Jun 2024 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fdfIRyVU"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C3513D60D
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234351; cv=none; b=jFVaGB+7mCZEGV63tsn6tMeFs9oR98r4ULKgK5XGFXGWyg0AVFuQQ1tD2anM64yTQV6esXJYbYteeyAcCEptAbAJcdUNToJcNUNq91c9WJmL4wBZ9Aoyo5nv4GiiEW09sACLdZLo1GMfUb1k8nGlyofopIf5FPZcTv9x+IX9Bvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234351; c=relaxed/simple;
	bh=xuc2Ia3IS/WoFjAUEj7w7wUfqYnZlS/SxWB1LOgZqYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lg3vKshSGHqpOr6W6alFB53Hdwir2BGXjShqYn0YNyyxmoPpxgve2/1IsrXwCEYHxbzCpdsjTSqZ1Xijr3mquXr/ZCUV53XPStjncAUs6jb4WR+OajH9li6f7jDy6w4vBO0PDkw1ceftRWsXG9s6QucK3pg66nLaGiUwMkQgj1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fdfIRyVU; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O7g1rg029713;
	Mon, 24 Jun 2024 13:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=GTG63pN2JDiSFw
	5jcpgEXZyFIFKPXTHS24lp5fhOSz8=; b=fdfIRyVUbzgqJumsZRCU0fY8Wkg8Ks
	T4y1xVS6q1/yOO/zqzpkKXeuE/TpgbtiwnXBcYrGo2FbLQjHLb80J3p/AFFlzOgC
	aG6dkRljlKNq6TeVAbH4C2BPcVJ+wYlYcneKoJXY8yZ0HMGrehcYA4Iq3uwVt7Zi
	dUx2+lLegMfI5PXSIxcvgAWxW1fgl+NtkBbG6C90Z2vu3NT3PNKzkHMFXXM7lhkA
	myGdmfcVUOfEoFQrDDD+4g/P61xFBIN8/GNW81F8Rhsha2arBaKFexyv/m4H8ztX
	CCYoaqb73FavNymVslkr+S+3DdJrUIV/i1blEauU2mOmtjJNnCTzpqBA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnd2ahvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 13:05:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45OBIwhI023395;
	Mon, 24 Jun 2024 13:05:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2cdu0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 13:05:10 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45OD5AZ9035548;
	Mon, 24 Jun 2024 13:05:10 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-162-165.vpn.oracle.com [10.175.162.165])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ywn2cdtv4-1;
	Mon, 24 Jun 2024 13:05:09 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, eddyz87@gmail.com
Cc: acme@redhat.com, ast@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, mykolal@fb.com, thinker.li@gmail.com,
        bentiss@kernel.org, tanggeliang@kylinos.cn, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next] libbpf: fix clang compilation error in
Date: Mon, 24 Jun 2024 14:05:05 +0100
Message-ID: <20240624130505.694567-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_09,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406240105
X-Proofpoint-ORIG-GUID: kaiapNm0tANycEtJ7F5WBxlC1xmJilQw
X-Proofpoint-GUID: kaiapNm0tANycEtJ7F5WBxlC1xmJilQw

When building with clang for ARCH=i386, the following errors are
observed:

  CC      kernel/bpf/btf_relocate.o
./tools/lib/bpf/btf_relocate.c:206:23: error: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingle-bit-bitfield-constant-conversion]
  206 |                 info[id].needs_size = true;
      |                                     ^ ~
./tools/lib/bpf/btf_relocate.c:256:25: error: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingle-bit-bitfield-constant-conversion]
  256 |                         base_info.needs_size = true;
      |                                              ^ ~
2 errors generated.

The problem is we use 1-bit and 31-bit bitfields in a signed int;
changing to unsigned int resolves the error.  Change associated
assignments from 'true' to 1 also for clarity.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf_relocate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
index 2281dbbafa11..1fa11aa4e827 100644
--- a/tools/lib/bpf/btf_relocate.c
+++ b/tools/lib/bpf/btf_relocate.c
@@ -58,8 +58,8 @@ struct btf_relocate {
 struct btf_name_info {
 	const char *name;
 	/* set when search requires a size match */
-	int needs_size:1,
-	    size:31;
+	unsigned int needs_size:1,
+		     size:31;
 	__u32 id;
 };
 
@@ -203,7 +203,7 @@ static int btf_relocate_map_distilled_base(struct btf_relocate *r)
 		info[id].name = btf__name_by_offset(r->dist_base_btf, dist_t->name_off);
 		info[id].id = id;
 		info[id].size = dist_t->size;
-		info[id].needs_size = true;
+		info[id].needs_size = 1;
 	}
 	qsort(info, r->nr_dist_base_types, sizeof(*info), cmp_btf_name_size);
 
@@ -253,7 +253,7 @@ static int btf_relocate_map_distilled_base(struct btf_relocate *r)
 		case BTF_KIND_ENUM:
 		case BTF_KIND_ENUM64:
 			/* These types should match both name and size */
-			base_info.needs_size = true;
+			base_info.needs_size = 1;
 			base_info.size = base_t->size;
 			break;
 		case BTF_KIND_FWD:
-- 
2.31.1


