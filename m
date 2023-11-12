Return-Path: <bpf+bounces-14933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FF47E8FCC
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 13:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A156B280C91
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 12:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C592679EB;
	Sun, 12 Nov 2023 12:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tlQrPTpc"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7658832
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 12:49:55 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CF72D5B
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 04:49:54 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACChvTp023723;
	Sun, 12 Nov 2023 12:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=gKHJWU0T2PN4V4H8YnwkWPyMqTCCKQoI5Xp1gDDfh2o=;
 b=tlQrPTpcrAc37wSTsct5Fzp7wERYCv0bENtn7ZXATCK6ohkEFaJJ9vjs4R8tGzJ39poi
 wSskW2DL3b9q3HEZT6dM6G4keSPZ9AFI2oRWx161ZMLxb22rY7ZJfpcY6W276Lmrx7Iy
 xCjuapesES/YQKjtrZzr4nyWeN/VwTftNzwFU9Bf08+Ui/3Vm9PUIMitovSGBF/5wVmr
 HKUTaJaTbt1EVdsTnBHs04I/rT0eunIX0Na1iAYYqEY85BedDAdgbfYZMWlKQiBYngoX
 Kp1A7JHgYvY5IA+aK4LFkS9iOIgHF5jJlO1WdpCAFG3VYvjuMvm+G4b8vE5U7lAtKKJ5 oA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2mdhey7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:49:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCEP1x008885;
	Sun, 12 Nov 2023 12:49:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxhngfsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:49:37 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ACCmceU029718;
	Sun, 12 Nov 2023 12:49:36 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-173-14.vpn.oracle.com [10.175.173.14])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uaxhngfep-15;
	Sun, 12 Nov 2023 12:49:36 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org
Cc: quentin@isovalent.com, eddyz87@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        masahiroy@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 14/17] kbuild, bpf: allow opt-out from using split BTF for modules
Date: Sun, 12 Nov 2023 12:48:31 +0000
Message-Id: <20231112124834.388735-15-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: zrSjkRWugFzXNqQ2w0nVcINF8Zn7Kw4v
X-Proofpoint-ORIG-GUID: zrSjkRWugFzXNqQ2w0nVcINF8Zn7Kw4v

By having a BTF_BASE variable defaulting to using vmlinux
as base BTF, we allow module builders to build standalone
BTF such that it is generated independently and not
de-duplicated with core vmlinux BTF.  This allows such
modules to be more resilient to changes in vmlinux BTF
if they occur, as would happen if a change resulted in
a different vmlinux BTF id mapping.

Opt-out of split BTF is done via

 make BTF_BASE= M=path/2/module

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 scripts/Makefile.btf      | 3 +++
 scripts/Makefile.modfinal | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index f8ce33d7f9bb..352271a10fb5 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -19,3 +19,6 @@ pahole-flags-$(call test-ge, $(pahole-ver), 125)	+= --skip_encoding_btf_inconsis
 pahole-flags-$(call test-ge, $(pahole-ver), 126)	= -j --lang_exclude=rust --btf_features=encode_force,var,float,decl_tag,type_tag,enum64,optimized_func,consistent_func,crc,kind_layout
 
 export PAHOLE_FLAGS := $(pahole-flags-y)
+
+# Allow opt-out of split BTF by overriding BTF_BASE
+export BTF_BASE	:= --btf_base vmlinux
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 8568d256d6fb..3400d1a72127 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -39,8 +39,8 @@ quiet_cmd_btf_ko = BTF [M] $@
 	if [ ! -f vmlinux ]; then					\
 		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
 	else								\
-		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_base vmlinux $@; \
-		$(RESOLVE_BTFIDS) -b vmlinux $@; 			\
+		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(BTF_BASE) $@; \
+		$(RESOLVE_BTFIDS) $(BTF_BASE) $@; 			\
 	fi;
 
 # Same as newer-prereqs, but allows to exclude specified extra dependencies
-- 
2.31.1


