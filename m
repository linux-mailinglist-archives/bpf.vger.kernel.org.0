Return-Path: <bpf+bounces-29459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BD88C2244
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 12:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DD5283736
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 10:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A7E150998;
	Fri, 10 May 2024 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AdTono6X"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1122114F139
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715337420; cv=none; b=clVtQz0ynZO2qwVNB/9DMS5kJ13I8LrCRa2Cb0PvOWeNzlkUi8bRAl0yl8VB0EmcYZbkF354a0f0FQESHNfWWkLO4WQo54QZrd43gpBBxwhwsvdYYgNbn8YPZidwNA9FKGf966stg22eJODRwSQiIXF1NO6J243QMlK3toGv6mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715337420; c=relaxed/simple;
	bh=yVC6tmcPxKskNY1hTzSU52cyP+qgu3OTkqLXyU4/+KU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nz+n89lVGrnWgv+P8yV42MwnptSIvEJmzreMtfSYG8uKsn0XD6Jmk1ihMn9ilC+ndmcwG00xMOPDGyfdSpUN9ux9BNTiS1DrAlXbd+Dk1mBoS9clPjzMuMpXdxKdrS8T/pnVULmBwtSTdQVsjCeMEI40TBtTbJL0Ec99ftplF8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AdTono6X; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44AAT4df003368;
	Fri, 10 May 2024 10:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=ccdujVrnaoL1Mchau8WyPceo/j5fIB7Xc7uyGgVrubI=;
 b=AdTono6XApF087nLxptT006tyuBjVVAGxtedGdAOwrEQVeZt4GWNsYtTxtkWxWgKcF5K
 P/Ry7Q7tpg0dRJnt0YewgKxfAE2eZg2h4IMUfUUxjgj13LPSsastG5ZfzQ4n4Ujxqupg
 dGx59DMFDUWTkUTY5tVp302wIy+sT+FZ18vsXMwA580q3EJYMKdBBdLToqeQqEVbfETs
 hTTLTTcLGwr1M7hXs4iKDzuA6v0fFu/G1iI5XorzgLGFMSt9PbEj2vKoN0o5FEdak7wq
 RIcfcrJv7HhzuPQUFbJdijCrGqyAs7Z0BO1yxDZHl+Ay1QE1EKE8Iwusw3L3RkKGih17 Yw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y1hps817v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 10:36:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44AAUiNU019716;
	Fri, 10 May 2024 10:31:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfpcn22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 10:31:36 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44AAV0hd011786;
	Fri, 10 May 2024 10:31:35 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-161-199.vpn.oracle.com [10.175.161.199])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xysfpcm4p-7;
	Fri, 10 May 2024 10:31:35 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 06/11] kbuild, bpf: add module-specific pahole/resolve_btfids flags for distilled base BTF
Date: Fri, 10 May 2024 11:30:47 +0100
Message-Id: <20240510103052.850012-7-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240510103052.850012-1-alan.maguire@oracle.com>
References: <20240510103052.850012-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_07,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405100074
X-Proofpoint-GUID: deo8LT0kD4jzXB_TduwqLgvyzhIYZFry
X-Proofpoint-ORIG-GUID: deo8LT0kD4jzXB_TduwqLgvyzhIYZFry

Support creation of module BTF along with distilled base BTF;
the latter is stored in a .BTF.base ELF section and supplements
split BTF references to base BTF with information about base types,
allowing for later relocation of split BTF with a (possibly
changed) base.  resolve_btfids uses the "-B" option to specify
that the BTF.ids section should be populated with split BTF
relative to the added .BTF.base section rather than relative
to the vmlinux base.

Modules will be built with a distilled .BTF.base section for external
module build, i.e.

make -C. -M=path2/module

...while in-tree module build as part of a normal kernel build will
not generate distilled base BTF; this is because in-tree modules
change with the kernel and do not require BTF relocation for the
running vmlinux.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 scripts/Makefile.btf      | 7 +++++++
 scripts/Makefile.modfinal | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index 2d6e5ed9081e..48a11bbae38f 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -23,8 +23,15 @@ else
 # Switch to using --btf_features for v1.26 and later.
 pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func
 
+ifneq ($(KBUILD_EXTMOD),)
+module-pahole-flags-$(call test-ge, $(pahole-ver), 126) += --btf_features=distilled_base
+module-resolve-btfids-flags-$(call test-ge, $(pahole-ver), 126) = -B
+endif
+
 endif
 
 pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
 
 export PAHOLE_FLAGS := $(pahole-flags-y)
+export MODULE_PAHOLE_FLAGS := $(module-pahole-flags-y)
+export MODULE_RESOLVE_BTFIDS_FLAGS := $(module-resolve-btfids-flags-y)
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 79fcf2731686..86189ddf39e8 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -39,8 +39,8 @@ quiet_cmd_btf_ko = BTF [M] $@
 	if [ ! -f vmlinux ]; then					\
 		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
 	else								\
-		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_base vmlinux $@; \
-		$(RESOLVE_BTFIDS) -b vmlinux $@; 			\
+		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_PAHOLE_FLAGS) --btf_base vmlinux $@; \
+		$(RESOLVE_BTFIDS) $(MODULE_RESOLVE_BTFIDS_FLAGS) -b vmlinux $@; 			\
 	fi;
 
 # Same as newer-prereqs, but allows to exclude specified extra dependencies
-- 
2.31.1


