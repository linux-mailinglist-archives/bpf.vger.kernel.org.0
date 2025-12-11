Return-Path: <bpf+bounces-76481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D4DCB68BE
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 17:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7806D3001C14
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 16:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4B1313E14;
	Thu, 11 Dec 2025 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iQbSwBXC"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5572FF64C;
	Thu, 11 Dec 2025 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765471660; cv=none; b=nBo0NBehIeh0yblti6Tn5XjPdTjWW2bVM6QTqmzf+Ha/zbuctV5b++gDIfkFZu0HKRNNK6tkHYX0s727Zv3iv4kLKYU5sY36VVu1IdAb/09vVjsXEOHO0ybU4eyNoz1lSMp55opwiKrwmMvtrQeR+koH/ADSg1YuR7NPv1KwWoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765471660; c=relaxed/simple;
	bh=BB9thrIzSx9qXvMJNw9d+GyMUcU9y4VelEvBjwG5yqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dhw9n9wrCs/iYN4EM8LBEAs8I8UcUgR1i7H0GA1W73r2WPOsIgLNpLpSCSryIR2PlmjMQJrSzfnCNCtspz5x4aWxcvnMGyTkotrniLbxlHTT+QoIIRChAUnE9sCZl1Ila05Kp7auhUbsK+rMkrjIr2IT3LlYXbnvBwoD4hwzupU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iQbSwBXC; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBG5IgZ1722286;
	Thu, 11 Dec 2025 16:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=k+ttb
	r85Yn/N6G4UBwm3wz8S/II8Ybtuq9g3Ti6YkRw=; b=iQbSwBXCdxoQuMM4pdKxt
	VOBy4UZgFcIbqvH1K7MaQnFic8a2VuOiezSJwXYxIBSJComOc+6J2PiDp1p+hh0k
	wL6QPjm71ookOmdNXqmPnIYpRlPg/x6vxL+SFXLRQE6SWUrxLPVysWEvodoHtSbM
	e3miYPwab4gRP4ZkJ8CFWjmFY8zPpnJbCbjnjbvjpL9NgpS72YSNIsZs8wPFCtTy
	1N7x5/my86ks1x9HK9CcQpUpr1DLihvFPYHtnY/brGBLNE3RSfAxNMjgjpQQ5f1U
	VZ/BBIGQYOcMt6Az4pTsrFUqPlT1hS3+xtF1Qux0X6B7wyxosAH5go3h1l96ZJJz
	Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ayd1m9ssb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Dec 2025 16:47:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBFmhcr040231;
	Thu, 11 Dec 2025 16:47:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxnsx55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Dec 2025 16:47:14 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BBGknmP030704;
	Thu, 11 Dec 2025 16:47:14 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-126.vpn.oracle.com [10.154.50.126])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4avaxnswqy-10;
	Thu, 11 Dec 2025 16:47:14 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v7 bpf-next 09/10] bpftool: Update doc to describe bpftool btf dump .. format metadata
Date: Thu, 11 Dec 2025 16:46:45 +0000
Message-ID: <20251211164646.1219122-10-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251211164646.1219122-1-alan.maguire@oracle.com>
References: <20251211164646.1219122-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_02,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512110133
X-Proofpoint-GUID: ySfSNN96ktSJr8w9-enD0_cSmqWVWeYt
X-Authority-Analysis: v=2.4 cv=HvZ72kTS c=1 sm=1 tr=0 ts=693af593 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=oGlH3XLwWBQq_BvjqjQA:9 cc=ntf awl=host:12110
X-Proofpoint-ORIG-GUID: ySfSNN96ktSJr8w9-enD0_cSmqWVWeYt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDEzNCBTYWx0ZWRfX9QlSw5m4s2ye
 Wyf/arTgqrjTCntkgQZPTtXsu9JH+q2ts/8yYHw7IX9z1LESbCCqe1JaBWS1y7ICTq82cNyYzp+
 fZW7vABbQ4osY99sJ+o1k+K3xo5wnF+ByMKdkQYii+W28h5uCG/RPTXTnHiP+yzQCfziOTeGnSA
 DpxL1Y3ztgYXK+Bp0Iz51WXw/ApSOKQ2da1uC4Kqu0oMWrdu4iWFDKuODHoewRxTNM6iICJAuXw
 K6d1/Tgan1YLhD8AHwKEwn5EubUcXLPXop7bzr8F8VH1iLZMBNdFksaetj2PQ7w2aBaY8WkIR+D
 wQa1jRnlw8StjlMaFmt95AIVYOb3WiErKZXEEbDiubcMp2+Htm0za8yE6rjKRpO2LTLNOtN/xvC
 cfy7lDxlYJcpMToRxjdickzXdPF3Obqi0WbLxl8FZtjk+VoCtek=

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
2.39.3


