Return-Path: <bpf+bounces-76596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76820CBD283
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 10:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EA5A303EF77
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 09:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77DE329C54;
	Mon, 15 Dec 2025 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dtobGaV0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DC921B9D2;
	Mon, 15 Dec 2025 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765790356; cv=none; b=VDCGTFUW1p/8QoY4Pr4A77JPsGImiqpmxrYM7IP/HoGnxpc9DcrJjrIxIMM9JwFQ/ekLOaveB93BpzQkM5TfUMK0TVxpmwrj2CmUvDzIFUU40t58yc0+HvbKPeIZpE0QEJksOmbUHUiW+Tg1JDzf74l/GjdMCcsmkR2kKCn47e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765790356; c=relaxed/simple;
	bh=BB9thrIzSx9qXvMJNw9d+GyMUcU9y4VelEvBjwG5yqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHbdzdi9rmqkLW0/4C5f4HWWczJFuniA7RhFJoXolORJ9KJn48Bq35Txne220lmJUxg3Ci0b+/QyO8hbyAY5bMlqwsQG/QmKoBr6lAmKmMuTzFIK1kEiszjRqcoGw73TSCoNRvFxzV8sz+Z7DlNqH8HKGzvwAfUI6+/la/HgGhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dtobGaV0; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BF7uNwL1723431;
	Mon, 15 Dec 2025 09:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=k+ttb
	r85Yn/N6G4UBwm3wz8S/II8Ybtuq9g3Ti6YkRw=; b=dtobGaV0AVn4pDRSyXenb
	4AFx9qA66GpQ34a5wj2hnMQr9re2m+CrY1Qs9tj8BGnjv2SfTPsEhUDnY0svAAwg
	v4P1n1gywyOe4QnBlKchtg6EzfkzhOTKy8UFmdYDauMiLDQhF+KmSwAXng9pTJsh
	uk6ZgMylq0jgbcPzU+XU+zA1RIBM+AEWf+QFbFXdZPx9tQ/OXPcr1NixjoqZZrsn
	enTn7xM8HdH7iNWM8WvUmVZh9E/cLEppZozGafzSFKvgJ98b42LyQzQichrDdhPD
	mwIOi+bHqvx2Cpvk56zxHheqfORc9h4vTZWEo8SPF1yZuw1CNI9q2GfO1P8nI52U
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0yruhnch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 09:18:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF8e70g025805;
	Mon, 15 Dec 2025 09:18:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk8yh1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 09:18:42 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BF9Hdwi027566;
	Mon, 15 Dec 2025 09:18:41 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-2.vpn.oracle.com [10.154.53.2])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4b0xk8yg99-10;
	Mon, 15 Dec 2025 09:18:41 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        mykyta.yatsenko5@gmail.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v8 bpf-next 09/10] bpftool: Update doc to describe bpftool btf dump .. format metadata
Date: Mon, 15 Dec 2025 09:17:29 +0000
Message-ID: <20251215091730.1188790-10-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251215091730.1188790-1-alan.maguire@oracle.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_01,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150078
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA3OCBTYWx0ZWRfX8ICuI8iUgcYj
 Z18AyMDFrLnDxaohW9Xiga+lBw0K3gUAprAMoCaWYwYqGcJ+zUyAJ5EMuG1A0fVor+LOWLzSmRt
 CmX7hri9ja//5ZikfnbGoM/Ei6/XJd6eT6jnGxq/vTnxjldHkhw0qFYBpaZBgREU8BYNfHSo4sR
 o1uVKbWyk0/tEITYrQCSbEYVzeN5taH6NwDjiCge3j0uC5vv2rggbIAQSYXNR54UuGub2BBnvHu
 dCalVXTBI21zqcH+RHwdJYNkk4l3uShA8aNMzGukNZU1onYUz/slACg7e8mFKqFHu9bykoP+dKj
 PHn8uBd9w9cc5Bfco95ZWEG9aEtlQAHBjR4yFytA5YJ/Q0GaWbzK+Hb3mkAhKxNAFAIADZ8UtTj
 lAZvpLvDz9QeuSEh+IZTZwrDG8VgfQ==
X-Authority-Analysis: v=2.4 cv=TL9Iilla c=1 sm=1 tr=0 ts=693fd273 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=oGlH3XLwWBQq_BvjqjQA:9
X-Proofpoint-GUID: ib1AjSFiYKIv7SJMgSdBz9c7QP0VvagM
X-Proofpoint-ORIG-GUID: ib1AjSFiYKIv7SJMgSdBz9c7QP0VvagM

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


