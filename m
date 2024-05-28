Return-Path: <bpf+bounces-30721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F31D48D1B35
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 14:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4D9285F8E
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 12:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BDC16DEA9;
	Tue, 28 May 2024 12:25:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7681616D4C7
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899126; cv=none; b=pdfjfFjoKW1aDd1qLnrz/kzLN/V9+2sxTwVP23WInTFmtJXd6PSWmnhrR+ORwWK60RaIgxLM94Cm/3I8uuBoF5YBxLMHkJxfCODe6Yo4YhkB1dsBpAB4ITyN8b2Od+f1O3nExjiw93fxTo3Q9VgUtwOau0bcOMbZsw646Xm+FI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899126; c=relaxed/simple;
	bh=fo6f025uGeEF4kfzXAUKOx4eW818nb7jv8zyUPpoYU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ekJ98bbwhjZFoRll21nvbMsIqi4oC0JLrlwm1/eZPYRwKkUsGbLa9EwblM9pd3ckaXpsZ5gokTzzthWRiFA3cESMQrmYI/3yc2YZI4bsS0XlMJEEREKr/QsHH75+jo3xXJRHR1lcSZvTWo+Ry9cjk3ud6/0M2qxDefuUwo0ngog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44SBopZT001882;
	Tue, 28 May 2024 12:25:03 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:date:from:in-reply-to:message-i?=
 =?UTF-8?Q?d:mime-version:references:subject:to;_s=3Dcorp-2023-11-20;_bh?=
 =?UTF-8?Q?=3D8ROdIoCUKw5gL8Lat8A/ZyCUsufSG6CK8pvyct9a6z4=3D;_b=3DF/6Eqal4?=
 =?UTF-8?Q?WzpvmtmyFVGHF27YlnWt6UUGra6Kb2UX7uCQAPjupjQ0kdP30BadpLShftCM_qZ?=
 =?UTF-8?Q?AiA8NGJYlq8IBoGBjFP686WLWD1V6YeGSInOcf3pHjye8YcCEU0RMmtobPOaBe6?=
 =?UTF-8?Q?NZ+_CMrKeAzkEtWuYX06MoEcg1sSHp1TAP1mX+JabYA7pz1LMLPzdFOYvwssbsG?=
 =?UTF-8?Q?f+G2vbEPi_CCmCisD5minZywFdr2AKlsNxFlRyWbTUsiRKqUxjM2F/BnrD+i+YM?=
 =?UTF-8?Q?M9Wxr5mqSQGlqUx_cEeNjFQRNl9hg+IEv22YD+EXQyPqRDAW4asP4oU2fuBrAiU?=
 =?UTF-8?Q?bEQvRfY+BoKPQeaGHSQCY_bg=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g446y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 12:25:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44SBsioP037413;
	Tue, 28 May 2024 12:25:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc535a0eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 12:25:01 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44SCNlJd022297;
	Tue, 28 May 2024 12:25:01 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-164-70.vpn.oracle.com [10.175.164.70])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3yc5359yey-10;
	Tue, 28 May 2024 12:25:00 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 bpf-next 9/9] kbuild,bpf: add module-specific pahole flags for distilled base BTF
Date: Tue, 28 May 2024 13:24:08 +0100
Message-Id: <20240528122408.3154936-10-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240528122408.3154936-1-alan.maguire@oracle.com>
References: <20240528122408.3154936-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_08,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280093
X-Proofpoint-GUID: 2MNiSfRLdNMW66OiKZ3fyyn9F9w3MUgC
X-Proofpoint-ORIG-GUID: 2MNiSfRLdNMW66OiKZ3fyyn9F9w3MUgC

Support creation of module BTF along with distilled base BTF;
the latter is stored in a .BTF.base ELF section and supplements
split BTF references to base BTF with information about base types,
allowing for later relocation of split BTF with a (possibly
changed) base.  resolve_btfids detects the presence of a .BTF.base
section and will use it instead of the base BTF it is passed in
BTF id resolution.

Modules will be built with a distilled .BTF.base section for external
module build, i.e.

make -C. -M=path2/module

...while in-tree module build as part of a normal kernel build will
not generate distilled base BTF; this is because in-tree modules
change with the kernel and do not require BTF relocation for the
running vmlinux.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 scripts/Makefile.btf      | 5 +++++
 scripts/Makefile.modfinal | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index bca8a8f26ea4..191b4903e864 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -21,8 +21,13 @@ else
 # Switch to using --btf_features for v1.26 and later.
 pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func
 
+ifneq ($(KBUILD_EXTMOD),)
+module-pahole-flags-$(call test-ge, $(pahole-ver), 126) += --btf_features=distilled_base
+endif
+
 endif
 
 pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
 
 export PAHOLE_FLAGS := $(pahole-flags-y)
+export MODULE_PAHOLE_FLAGS := $(module-pahole-flags-y)
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 79fcf2731686..6d2b8da98ee5 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -39,7 +39,7 @@ quiet_cmd_btf_ko = BTF [M] $@
 	if [ ! -f vmlinux ]; then					\
 		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
 	else								\
-		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_base vmlinux $@; \
+		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_PAHOLE_FLAGS) --btf_base vmlinux $@; \
 		$(RESOLVE_BTFIDS) -b vmlinux $@; 			\
 	fi;
 
-- 
2.31.1


