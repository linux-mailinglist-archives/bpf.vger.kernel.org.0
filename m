Return-Path: <bpf+bounces-14930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DD17E8FC9
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 13:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9DB1C20951
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 12:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF32D847C;
	Sun, 12 Nov 2023 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0stlijWA"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A15648
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 12:49:44 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3682C2D5B
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 04:49:43 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCiHEr012817;
	Sun, 12 Nov 2023 12:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=duGHp55YrRgxpthIBFv+XMYAuTI83o5ozohkSNbz4Gg=;
 b=0stlijWA5giqH6ssWMaKgFXfoVBDuhHz87xNxucF1Wf7zqLdU4mSenh7+bvA301Ceg2b
 kzmc0bKeRvBgo89qVMD5/e2X8qu/UIV5/4I/ObO1onLHnLf0TymV8s/xFrA4RwrSDbOt
 cJE2wNzpjOkQhVcf0kq3OOVKFQEvJG9XvA8Rjc3ak+iS6tMmlglowYLUrXTTd02VrsC/
 peN3mfqiSJuzzfHFBTPO2F5bHUFhT/NN6xBb0Yo2JR7kHdCsn6WOHOdJTJ4j0zT4066J
 bUCIh7MhRzYlR44aWVXUHmg/hwWsPzshORSJsg9bSXUeOfqW32Y++P6oSPD2pMNkg7uq KQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2r01eqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:49:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCFBjk009314;
	Sun, 12 Nov 2023 12:49:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxhngfqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:49:25 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ACCmceO029718;
	Sun, 12 Nov 2023 12:49:24 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-173-14.vpn.oracle.com [10.175.173.14])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uaxhngfep-12;
	Sun, 12 Nov 2023 12:49:24 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org
Cc: quentin@isovalent.com, eddyz87@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        masahiroy@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 11/17] bpftool: update doc to describe bpftool btf dump .. format meta
Date: Sun, 12 Nov 2023 12:48:28 +0000
Message-Id: <20231112124834.388735-12-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231112124834.388735-1-alan.maguire@oracle.com>
References: <20231112124834.388735-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-12_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311120113
X-Proofpoint-ORIG-GUID: 7V5_hlsSOkNwhv9sdOH3AgTLBGs8h7k1
X-Proofpoint-GUID: 7V5_hlsSOkNwhv9sdOH3AgTLBGs8h7k1

...and provide an example of output.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../bpf/bpftool/Documentation/bpftool-btf.rst | 30 +++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
index 342716f74ec4..ea8bb0a2041c 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
@@ -28,7 +28,7 @@ BTF COMMANDS
 |	**bpftool** **btf help**
 |
 |	*BTF_SRC* := { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{**key** | **value** | **kv** | **all**}] | **file** *FILE* }
-|	*FORMAT* := { **raw** | **c** }
+|	*FORMAT* := { **raw** | **c** | **meta** }
 |	*MAP* := { **id** *MAP_ID* | **pinned** *FILE* }
 |	*PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* }
 
@@ -67,8 +67,8 @@ DESCRIPTION
 		  typically produced by clang or pahole.
 
 		  **format** option can be used to override default (raw)
-		  output format. Raw (**raw**) or C-syntax (**c**) output
-		  formats are supported.
+		  output format. Raw (**raw**), C-syntax (**c**) and
+                  BTF metadata (**meta**) formats are supported.
 
 	**bpftool btf help**
 		  Print short help message.
@@ -266,3 +266,27 @@ All the standard ways to specify map or program are supported:
   [104859] FUNC 'smbalert_work' type_id=9695 linkage=static
   [104860] FUNC 'smbus_alert' type_id=71367 linkage=static
   [104861] FUNC 'smbus_do_alert' type_id=84827 linkage=static
+
+
+**# bpftool btf dump file vmlinux format meta**
+
+::
+
+ size 5161076
+ magic 0xeb9f
+ version 1
+ flags 0x1
+ hdr_len 40
+ type_len 3036368
+ type_off 0
+ str_len 2124588
+ str_off 3036368
+ kind_layout_len 80
+ kind_layout_off 5160956
+ crc 0x64af901b
+ base_crc 0x0
+ kind 0    UNKNOWN    flags 0x0    info_sz 0    elem_sz 0
+ kind 1    INT        flags 0x0    info_sz 0    elem_sz 0
+ kind 2    PTR        flags 0x0    info_sz 0    elem_sz 0
+ kind 3    ARRAY      flags 0x0    info_sz 0    elem_sz 0
+ kind 4    STRUCT     flags 0x35   info_sz 0    elem_sz 0
-- 
2.31.1


