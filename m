Return-Path: <bpf+bounces-76430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C38CB3F83
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 21:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DAA6301276C
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 20:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE0D32C937;
	Wed, 10 Dec 2025 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VLiTNOav"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5063C32C320;
	Wed, 10 Dec 2025 20:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765398820; cv=none; b=H5P579CMrYZ4krseQgc2fJKbIowCCKqgq3q1foZdlzYvvytk1dmanOqlcmTn20RANf++RSG/wSlcKDeG0r6/V8UCyX1D+05nABRKer+q6rM+xrMyfMrNl1aa36z7vvDr0gu4kKmBQnRA2OonPf0HSEHl/NSFDbuWo0y6gt0xUlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765398820; c=relaxed/simple;
	bh=iMg5VTL7Pc/z/Wvu8M10TO5UttsN6jY0LHcB4pGMFug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vCrfpsS21Wvx/5wOY+5eMHKKfCWoNUzEuwnxP2oVDRM6+XCTQGaHtU15oXVHiZcEU2Ldpi8jjMhWeMaRaT1fCChl0Ghdita672usMWf/1a4MEh0lTnniXCAUkR2cLDIVdDDLMxfuXsJoejOb324m73q9Ke7Yry+ERsFsVUoQx6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VLiTNOav; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BAIYB1P3758073;
	Wed, 10 Dec 2025 20:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Ij5FH
	aEfBkWUVzukxQO30QYnQS7mVCVYkbHFHe62FgY=; b=VLiTNOavLVqghB/e9IzTa
	WDZtOpjyA8exxDDYXywf0ggTBTDgACydpXRgPV9XJ4tgNyo9Fj79HonYXpssE+a1
	UL8Zz7rCIlVnVtSvnCmjNzDyR9lNDuuubJwWT6LNyEkZpCKz/6+K63olTSDORjfF
	+4TQlmLfPRqqxLV25/puNfJLTjeW/5hwL/K/Q7qLaNEQIYdDgWWQjeiih2ScC87I
	Yy31QsUznU52CYIO587FYmGiDNwHwzvpDXD7R+rxVdBa/wVUrIk4+sQFrzBc/009
	6ik9Aqh0eHgQZ5bNr2QuUyzl653kYr38sJEo958v+eUYs/KDEshPfYTC1bU7Rxod
	A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aybqv0h7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 20:33:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAK8TWF039920;
	Wed, 10 Dec 2025 20:33:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxmrq6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 20:33:11 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BAKWkSl001635;
	Wed, 10 Dec 2025 20:33:10 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-60-41.vpn.oracle.com [10.154.60.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4avaxmrprn-10;
	Wed, 10 Dec 2025 20:33:10 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v6 bpf-next 09/10] bpftool: Update doc to describe bpftool btf dump .. format metadata
Date: Wed, 10 Dec 2025 20:32:42 +0000
Message-ID: <20251210203243.814529-10-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251210203243.814529-1-alan.maguire@oracle.com>
References: <20251210203243.814529-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512100168
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDE2OCBTYWx0ZWRfX5xyfCfDY8AJq
 fFlVdaTQ6WhpexeXwrV72IzsFg2/A459zciTJcc3aFO0c8xDxYsgmaS4OdTBqCjjp2yLeHPmLzP
 FVwFo7TPFIzlZkY9NsP1VsduVNWIZPcgAWLvIMNH70rq85488XS/fWBv7DfZzrbWbqhfAH7GpZ1
 Qnv5clxj76rflZSNBKlxUM8tNGs0ZGBc5XJG9RnWYdpFIb0lO65BWB5FKvBGbFavSa7fWOPkgP+
 9wihnBiETeLMPzMIXP4qkmdDf0xYqd10OAbbVlgMvRcCcLpvXGRL3tBkeDwG4ntGJF8RNSk17/q
 ruR1TojkzJ3fGW7IN39OFwocUNayJ4msdG35ViuY25hOGF/mt2MTGT3kkzMmqudALMAlFx57gH3
 XpHK4HosXIgfemud+N9BHMAtHhNVGGPAEDDasCZd5xpoPlHNduU=
X-Proofpoint-ORIG-GUID: NFV3V17swZ79b9Q7eTvg-hpDQdyP2y08
X-Authority-Analysis: v=2.4 cv=OLAqHCaB c=1 sm=1 tr=0 ts=6939d907 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=oGlH3XLwWBQq_BvjqjQA:9 cc=ntf awl=host:12099
X-Proofpoint-GUID: NFV3V17swZ79b9Q7eTvg-hpDQdyP2y08

...and provide an example of output.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../bpf/bpftool/Documentation/bpftool-btf.rst | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
index d47dddc2b4ee..1c11b5647ab7 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
@@ -28,7 +28,7 @@ BTF COMMANDS
 | **bpftool** **btf help**
 |
 | *BTF_SRC* := { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{**key** | **value** | **kv** | **all**}] | **file** *FILE* }
-| *FORMAT* := { **raw** | **c** [**unsorted**] }
+| *FORMAT* := { **raw** | **c** [**unsorted**] | **meta** }
 | *MAP* := { **id** *MAP_ID* | **pinned** *FILE* }
 | *PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* | **name** *PROG_NAME* }
 
@@ -65,7 +65,8 @@ bpftool btf dump *BTF_SRC* [format *FORMAT*] [root_id *ROOT_ID*]
     **format** option can be used to override default (raw) output format. Raw
     (**raw**) or C-syntax (**c**) output formats are supported. With C-style
     formatting, the output is sorted by default. Use the **unsorted** option
-    to avoid sorting the output.
+    to avoid sorting the output.  BTF metadata can be displayed with the
+    **meta** option.
 
     **root_id** option can be used to filter a dump to a single type and all
     its dependent types. It cannot be used with any other types of filtering
@@ -267,3 +268,26 @@ All the standard ways to specify map or program are supported:
   [104859] FUNC 'smbalert_work' type_id=9695 linkage=static
   [104860] FUNC 'smbus_alert' type_id=71367 linkage=static
   [104861] FUNC 'smbus_do_alert' type_id=84827 linkage=static
+
+Display BTF metadata from file vmlinux
+
+**# bpftool btf dump file vmlinux format meta**
+
+::
+
+  size 5161076
+  magic 0xeb9f
+  version 1
+  flags 0x1
+  hdr_len 40
+  type_len 3036368
+  type_off 0
+  str_len 2124588
+  str_off 3036368
+  kind_layout_len 80
+  kind_layout_off 5160956
+  kind 0    UNKNOWN    info_sz 0    elem_sz 0
+  kind 1    INT        info_sz 0    elem_sz 0
+  kind 2    PTR        info_sz 0    elem_sz 0
+  kind 3    ARRAY      info_sz 0    elem_sz 0
+  kind 4    STRUCT     info_sz 0    elem_sz 0
-- 
2.43.5


