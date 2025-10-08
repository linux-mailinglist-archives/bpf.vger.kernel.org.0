Return-Path: <bpf+bounces-70609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9D8BC6294
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 19:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643B33A6011
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 17:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B780C2D8393;
	Wed,  8 Oct 2025 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HFHouGr4"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B099A2BEFF3
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 17:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759944967; cv=none; b=TJXhDoXrCDL+WQPebJBixCDZwVrIRllQHf52QTSju2CAu1kpumhXXsjfHaUGmiXNa1yCRfRqWa6AuAWlSlZ0aZyf7RXgEwUuVmFv8Zvpgi2ZJ2BVWXtckpLgL/LC9uUuOYOaHKKDHfXQiAeYf05usGbKUUJZS5equOsFFWEMQi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759944967; c=relaxed/simple;
	bh=6TQxpy92xTveoFNFMfoY4Mng/L5KY8rlt0y3MqeHS8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gncJNEq6R81gIXG75xF+aiGAzxdstm3zbySbFASUxWkQby3c0INK1CI3Dj0HpKXh6X8dmbJX4AU4IwTKQGRz6izfegPOunJ95BopZTCiSyKZZWIbx9MdujqRcV/YHrLT/x1pSSjTZGg+ANAZ1QtScLcOB38oncSvPN9tft2gX7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HFHouGr4; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598HERQc029135;
	Wed, 8 Oct 2025 17:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=d8B6c
	An/nKky1vFIWJ4fK/VEn4czP9FfC2PECORWqGE=; b=HFHouGr4mpFVva1LkjWE+
	9t6Jq1fkQB7Y5pdOZbE+IazETANyXrzSoo9Fha+sTZSlEJl7Px883nU9/Nh7QKBq
	3VFfb3XNOXRsU/LWny8j2HMW+ne90NctvJbJRdCb+Tm9u2yBTPop4THcry+KxWCf
	6Eim0SfSuBC5tDmLSejtHNKtNHgai9QR6yIHRZD8CLLpVXHNOVywDc9L4rwBsQt+
	8O+nmN54TpOYf0Fil4XQyZRWa1IplQVAPnNX4x7uVVdrh41YasqEr2s6gm5DyOhD
	ry+yD3EC5jowlEWiP6nE5PXK/VxdankzeGb8gG8mmtUgVknRpt/E4rX8ytJDlf4M
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6b81bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 598HDrV4036952;
	Wed, 8 Oct 2025 17:35:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49nv62rq1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:46 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 598HZFV4031138;
	Wed, 8 Oct 2025 17:35:45 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-90.vpn.oracle.com [10.154.53.90])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49nv62rpmb-12;
	Wed, 08 Oct 2025 17:35:45 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 11/15] kbuild: Add support for extra BTF
Date: Wed,  8 Oct 2025 18:35:07 +0100
Message-ID: <20251008173512.731801-12-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251008173512.731801-1-alan.maguire@oracle.com>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510080123
X-Proofpoint-GUID: eE7J4DEEM_pFxKp4zC97aG1GLmU0KcOz
X-Authority-Analysis: v=2.4 cv=Nb7rFmD4 c=1 sm=1 tr=0 ts=68e6a0f3 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=98Ek4A6AJ6fSjteOX4QA:9 cc=ntf
 awl=host:13625
X-Proofpoint-ORIG-GUID: eE7J4DEEM_pFxKp4zC97aG1GLmU0KcOz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX+5qtx2ABIcZK
 eEo01uOjllKqiaYt9VGd7vcv5i0RyqVs8a4y6cVCyfgvRGkI+ypZ5riNcVGc1P3y+jkfwc/QlqJ
 FBazkJ0rEgUlb4/ZRFKJPTEs5IlHXtp9ZDiTs3geHijd3eaYkDf95WNesKq0lPgEJYOIISLpDMj
 0tvMd/CbV1VnGIF5HXn+u/RI46j5cjG8ZoJrZWCnfiz+deIyaw1VWTEgSppclfimjXvTwfli4Tu
 nr4WA5S1BTnUIZUx8wskkzSLEmg2QSjHFjHog0MvXZyQIxzkXT/gKMi800Xi54tm6gusRdCXDj3
 PGDOv/9I4mX6tIIsgE/g/yPsrORodC1Tc3akmcQvt5UcysS9gp/kRFin4Zp/cHepYIWHBz6gLI0
 3XTl8XDX0uO9zBDVlMUaD99kwwoaK79fcTdWi+coG0MrIsv0gBQ=

information

.BTF.extra sections wil be used to add additional BTF information
for inlines etc.  .BTF.extra sections are split BTF relative to
kernel/module BTF and are enabled via CONFIG_DEBUG_INFO_BTF_EXTRA.
It is bool for now but will become tristate in a later patch when
support for a separate module is added (vmlinux .BTF.extra is
9Mb so 'y' is not a good option for most cases since it will
bloat vmlinux size).

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 include/asm-generic/vmlinux.lds.h |  4 ++++
 lib/Kconfig.debug                 | 18 ++++++++++++++++++
 scripts/Makefile.btf              |  8 ++++++++
 scripts/link-vmlinux.sh           | 13 ++++++++++---
 4 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 8a9a2e732a65..523cf20327c1 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -675,6 +675,10 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	. = ALIGN(PAGE_SIZE);						\
 	.BTF_ids : AT(ADDR(.BTF_ids) - LOAD_OFFSET) {			\
 		*(.BTF_ids)						\
+	}								\
+	. = ALIGN(PAGE_SIZE);						\
+	.BTF.extra : AT(ADDR(.BTF.extra) - LOAD_OFFSET) {		\
+		BOUNDED_SECTION_BY(.BTF.extra, _BTF_extra)		\
 	}
 #else
 #define BTF
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3034e294d50d..0d8b713c94ea 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -409,6 +409,13 @@ config PAHOLE_HAS_LANG_EXCLUDE
 	  otherwise it would emit malformed kernel and module binaries when
 	  using DEBUG_INFO_BTF_MODULES.
 
+config PAHOLE_HAS_INLINE
+	def_bool PAHOLE_VERSION >= 130
+	help
+	   Support for the "inline" feature in BTF is available; it supports
+	   encoding information about inline sites in BTF; their location
+	   and information to help retrieve their associated parameters.
+
 config DEBUG_INFO_BTF_MODULES
 	bool "Generate BTF type information for kernel modules"
 	default y
@@ -426,6 +433,17 @@ config MODULE_ALLOW_BTF_MISMATCH
 	  this option will still load module BTF where possible but ignore
 	  it when a mismatch is found.
 
+config DEBUG_INFO_BTF_EXTRA
+	bool "Provide extra information about inline sites in BTF"
+	default n
+	depends on DEBUG_INFO_BTF && PAHOLE_HAS_INLINE
+	help
+	   Generate information about inline sites in .BTF.extra sections
+	   which consist of split BTF relative to kernel/module BTF;
+	   this BTF is made available to the user in /sys/kernel/btf.extra
+	   where the filename corresponds to the kernel (vmlinux) or the
+	   module the inline info refers to.
+
 config GDB_SCRIPTS
 	bool "Provide GDB scripts for kernel debugging"
 	help
diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index db76335dd917..5ca98446d8b5 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -2,6 +2,7 @@
 
 pahole-ver := $(CONFIG_PAHOLE_VERSION)
 pahole-flags-y :=
+btf-extra :=
 
 JOBS := $(patsubst -j%,%,$(filter -j%,$(MAKEFLAGS)))
 
@@ -25,8 +26,14 @@ pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j$(JOBS) --btf_features=enc
 
 pahole-flags-$(call test-ge, $(pahole-ver), 130) += --btf_features=attributes
 
+btf-extra =
 ifneq ($(KBUILD_EXTMOD),)
 module-pahole-flags-$(call test-ge, $(pahole-ver), 128) += --btf_features=distilled_base
+else
+ifneq ($(CONFIG_DEBUG_INFO_BTF_EXTRA),)
+pahole-flags-$(call test-ge, $(pahole-ver), 130) += --btf_features=inline.extra
+btf-extra := y
+endif
 endif
 
 endif
@@ -35,3 +42,4 @@ pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
 
 export PAHOLE_FLAGS := $(pahole-flags-y)
 export MODULE_PAHOLE_FLAGS := $(module-pahole-flags-y)
+export BTF_EXTRA := $(btf-extra)
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 433849ff7529..f88b356fe270 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -105,22 +105,29 @@ vmlinux_link()
 		${kallsymso} ${btf_vmlinux_bin_o} ${arch_vmlinux_o} ${ldlibs}
 }
 
-# generate .BTF typeinfo from DWARF debuginfo
+# generate .BTF typeinfo from DWARF debuginfo.  Optionally add .BTF.extra
+# section if BTF_EXTRA is set.
 # ${1} - vmlinux image
 gen_btf()
 {
 	local btf_data=${1}.btf.o
+	local btf_extra_flags=
 
 	info BTF "${btf_data}"
 	LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
 
-	# Create ${btf_data} which contains just .BTF section but no symbols. Add
+
+	if [ -n "${BTF_EXTRA}" ]; then
+		btf_extra_flags="--only-section=.BTF.extra --set-section-flags .BTF.extra=alloc,readonly"
+	fi
+
+	# Create ${btf_data} which contains just .BTF sections but no symbols. Add
 	# SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
 	# deletes all symbols including __start_BTF and __stop_BTF, which will
 	# be redefined in the linker script. Add 2>/dev/null to suppress GNU
 	# objcopy warnings: "empty loadable segment detected at ..."
 	${OBJCOPY} --only-section=.BTF --set-section-flags .BTF=alloc,readonly \
-		--strip-all ${1} "${btf_data}" 2>/dev/null
+		${btf_extra_flags} --strip-all ${1} "${btf_data}" 2>/dev/null
 	# Change e_type to ET_REL so that it can be used to link final vmlinux.
 	# GNU ld 2.35+ and lld do not allow an ET_EXEC input.
 	if is_enabled CONFIG_CPU_BIG_ENDIAN; then
-- 
2.39.3


