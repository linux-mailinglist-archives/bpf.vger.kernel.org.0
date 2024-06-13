Return-Path: <bpf+bounces-32060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8AA906958
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 11:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2889328607B
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 09:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A2F140384;
	Thu, 13 Jun 2024 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CtCQzLOl"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BF51411F6
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718272286; cv=none; b=EcDVYT2SZQ3EoOWJlDQ9uMnkfCjGwiHWHTskXb9Cdn0rZZXqqxQj2eM9IerjQtibxYrDzADwLw6qUDeu2uyXCG2oITM2pWe+YIIt01UObuGQ1pCoujFhA8BR/rbf50EeXNv+HOG52JIGIkTu5uKkJhjHllbmcZy5QjdzeJ44IKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718272286; c=relaxed/simple;
	bh=cFrD3/rTJBIYU6DXdA7ybhaYI3Xb9/IW1NyVLl9+vxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aqBUE+FZfILgBI3denSzJ82P3bpQVXA9qz1X++O63/M41wxJbHS10Qgo2XFbz2+nsoiA2AVEqrmeJE1Jd2IuFdlhzwu7OO/CKdAl6Vibl/Y6Wpc4p31bVWWuZAVn2OvSzoKiYqCBtGtiF8e7JOMCY+ojT+4sPXEQR8DSdHxjpj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CtCQzLOl; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D7tTdv015328;
	Thu, 13 Jun 2024 09:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=U
	OSvzC1P1a1mZP5cwi1iaOU1PxVnf1inS/uCLoxZw64=; b=CtCQzLOl5+PNSYrdu
	a4U7ZBA/pLVGPbMrdOe7Tm/U22IUY0tCGqCOyahrtZQ/TlqO37+b4YMAT9gYCQIg
	M1JG25OcKc79rGhVsybBrs4HIc1AjALzSfc8B/CT/77N5BLd4rGJPxTjl7/ep/Kk
	Hm04vjxXIr7qCJHJrQYeXnuIUC0RNBNLN6YLcC4NrqgipXvZalxwR+SEZ6KlsLVr
	bWvNfUfoRmgqRPM1njYN87JEfOCt1Vr4l5eZ7sgvC/ayivOZJyP6s2h4/AZkuOV6
	Ox0dyF/nvlGir+OCQ9yPyxhMaf2+V8e473YQ5Hro3xnElOellzifqVEUkesZxrAi
	XaYtw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7fs2fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 09:51:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45D8PQ9u014436;
	Thu, 13 Jun 2024 09:51:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yncewnmj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 09:51:02 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45D9oJq8005489;
	Thu, 13 Jun 2024 09:51:01 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-212-187.vpn.oracle.com [10.175.212.187])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3yncewnkqw-10;
	Thu, 13 Jun 2024 09:51:01 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, mykolal@fb.com, dxu@dxuuu.xyz,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v6 bpf-next 9/9] kbuild,bpf: add module-specific pahole flags for distilled base BTF
Date: Thu, 13 Jun 2024 10:50:14 +0100
Message-Id: <20240613095014.357981-10-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240613095014.357981-1-alan.maguire@oracle.com>
References: <20240613095014.357981-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_02,2024-06-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406130070
X-Proofpoint-GUID: O-i2Zu8wMSElGN1dyD1fH-I58BgD3GO2
X-Proofpoint-ORIG-GUID: O-i2Zu8wMSElGN1dyD1fH-I58BgD3GO2

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


