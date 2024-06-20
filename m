Return-Path: <bpf+bounces-32572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E47910022
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 11:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FAF92818CB
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 09:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8E219DF93;
	Thu, 20 Jun 2024 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V5HFhmAt"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8D119B3D6
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 09:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718875113; cv=none; b=eiKIifwzNJcXEW1c/pX6KZw11UFqok8dT3eNOsuahumk+28c3WvkmwVe76L6BCNtA1RlA1h6GH/EY/+7NHcf+32E2hVH7Rq0ZWiiouK8g0XOvbCg6RoW7wqhX7Iq5oUS8J3ePhFMi8zPvNEeE9BWO3hTR9DTXLsacfO8731uyzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718875113; c=relaxed/simple;
	bh=ybDTfN5N3zj/steF5klcIOaef6miZPXdQaO/7eXY1IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsQgO1XlrVzYeaZa/r46bTUT94n0hNlWa3HalnIPvURnZBdL9++aBpH9SY7fC28ihCNbmvPYg7OkZhXfTAEc4j+WhkPe2mJD7lu+KtOAcqIUT3pdFuLuoA5aRN2hhJ/XGkSqOCXUgtmlfNwYdL/nXhEMHnwAMfYC3dPzMqfl8nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V5HFhmAt; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K5FP5s005940;
	Thu, 20 Jun 2024 09:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=+
	KtaInblVt/M6r1fsmNyNP3GLRrx8AQ0YqMDrwtTs+M=; b=V5HFhmAtxnzO5Q5W5
	53PDvCz8ESywrkZrVvg9i70MlCYGUMbgrA6d5ihdvFsbb1yt+TbfeaD0rCWbOTvb
	b9yj8s+wzSAot0JWcLYla32LeNG5ciIqNqgORv4Uhbxvqf3rJ4xN3qYiOGn31RJQ
	iPUvi7dhCeTAcR9ltpMLH/GaX9BLhO8dJjUKJUMguLASLvfLlzU9KuD+WD71Zn1D
	vCpcdLEVeptpgnlW2K0v5EALDmUqnOEwLB/OXjYFMesLcGOj/7W2vkelH3hwGqa9
	nAhFd9WdmLTJ/ExdIvz4vo00b4AQbt4LPIbxiHtbTIv7llpIaCd026Ek6Q4q5n/l
	lt36g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuj9jarhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 09:18:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45K7MeJX031869;
	Thu, 20 Jun 2024 09:18:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1da76ht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 09:18:07 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45K9HdGN028275;
	Thu, 20 Jun 2024 09:18:06 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-186-70.vpn.oracle.com [10.175.186.70])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ys1da764t-6;
	Thu, 20 Jun 2024 09:18:06 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, eddyz87@gmail.com
Cc: acme@redhat.com, ast@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, mykolal@fb.com, thinker.li@gmail.com,
        bentiss@kernel.org, tanggeliang@kylinos.cn, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 5/6] kbuild,bpf: add module-specific pahole flags for distilled base BTF
Date: Thu, 20 Jun 2024 10:17:32 +0100
Message-ID: <20240620091733.1967885-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620091733.1967885-1-alan.maguire@oracle.com>
References: <20240620091733.1967885-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_06,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406200065
X-Proofpoint-GUID: zq-64aRq3BNUkDKpyt25pziDu3zVTGA5
X-Proofpoint-ORIG-GUID: zq-64aRq3BNUkDKpyt25pziDu3zVTGA5

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
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
---
 scripts/Makefile.btf      | 5 +++++
 scripts/Makefile.modfinal | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index 2597e3d4d6e0..b75f09f3f424 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -21,8 +21,13 @@ else
 # Switch to using --btf_features for v1.26 and later.
 pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
 
+ifneq ($(KBUILD_EXTMOD),)
+module-pahole-flags-$(call test-ge, $(pahole-ver), 126) += --btf_features=distilled_base
+endif
+
 endif
 
 pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
 
 export PAHOLE_FLAGS := $(pahole-flags-y)
+export MODULE_PAHOLE_FLAGS := $(module-pahole-flags-y)
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 3bec9043e4f3..1fa98b5e952b 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -41,7 +41,7 @@ quiet_cmd_btf_ko = BTF [M] $@
 	if [ ! -f vmlinux ]; then					\
 		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
 	else								\
-		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_base vmlinux $@; \
+		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_PAHOLE_FLAGS) --btf_base vmlinux $@; \
 		$(RESOLVE_BTFIDS) -b vmlinux $@; 			\
 	fi;
 
-- 
2.31.1


