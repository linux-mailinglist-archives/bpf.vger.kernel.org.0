Return-Path: <bpf+bounces-32419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D511C90D931
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 18:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390E428493F
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 16:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBA44E1C8;
	Tue, 18 Jun 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fw/CZXDg"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD912557F
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727950; cv=none; b=fZYDZPfvL320W232xAWK2Ak6086s+gUgBMo5pJZPJHB0Uq7/0DoKTP6eg94eQ+HWIh6Cu4GNcsQ1OWMQHA8ebwH6ENsW71pJO27sw2r334ILo7uC8ZtChW7Mw9volZ48qcmqtAaC/Z9JUToOO+mWXcYKzXwATx3vwpbOEkyZvnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727950; c=relaxed/simple;
	bh=5Uez+yZ/E6YVlST960EewzqFVJLxkRb6gzyqLRepw8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvM5QQPkI8qKRM5tnuMMoPMVy0BYeqGZio0U0IOZ6AFphmSkKc4Nl9g4enCDPfDRwztFOxK2fiHZpJOtL7ElVXQgLXjHFJHpY9rWWFl3rI4zoD+9LYKtTrGW/yGodOcqMHHOSXR4VV5bc1FpWb94Q24h8ad4sZXL8R2/ZjWoiRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fw/CZXDg; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IGMeE9020768;
	Tue, 18 Jun 2024 16:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=O
	ipMuMzn4Ku6P1GSxUYI9YdDwUqUMqF3SLxprDhtnYg=; b=fw/CZXDg0DbiMG6Iy
	0qEIb936pveDjDo5tlhW2pRddKZCAXBN3c0McFfV+Ynj/T59hP379HRQl+23sM+e
	n85Ye2bgpHUYlRcVn3sFE98Azd5ITlxaOcXjtdOLb/pZruJtyXrI0QjPWx+Agkn6
	lmtmbL0hzXKjF8+M87GH+Gp69Ipam/cT/DkxpGUem300kep3HVIvjQUWfiON6mBi
	UC2FrjtCX1D8ajltcPOdDHsAvyeCvNFHYuqWXcyZ5bmLr5101cPebytqsx1wWDDH
	FQ7BP3OcTH+UbiT/JQXvF30NFohquC8+bm5wl86Yc7Mp/a/HMZ0ccm5u3T5ASVUH
	DF4Iw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys1r1waww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 16:25:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IGAb1Z035300;
	Tue, 18 Jun 2024 16:25:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d8c0tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 16:25:20 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45IGOt42028167;
	Tue, 18 Jun 2024 16:25:19 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-223-50.vpn.oracle.com [10.175.223.50])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ys1d8c08e-5;
	Tue, 18 Jun 2024 16:25:19 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, eddyz87@gmail.com
Cc: acme@redhat.com, ast@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, mykolal@fb.com, thinker.li@gmail.com,
        bentiss@kernel.org, tanggeliang@kylinos.cn, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 4/5] kbuild,bpf: add module-specific pahole flags for distilled base BTF
Date: Tue, 18 Jun 2024 17:24:48 +0100
Message-ID: <20240618162449.809994-5-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618162449.809994-1-alan.maguire@oracle.com>
References: <20240618162449.809994-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180123
X-Proofpoint-ORIG-GUID: EheN4AMOjYQU4SGN6Blt0hgmatPseMQl
X-Proofpoint-GUID: EheN4AMOjYQU4SGN6Blt0hgmatPseMQl

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


