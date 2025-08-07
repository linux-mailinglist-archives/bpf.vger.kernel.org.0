Return-Path: <bpf+bounces-65204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EB2B1DA19
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 16:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3E81AA3D0B
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 14:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300EA26462E;
	Thu,  7 Aug 2025 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rRI06iNl"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC13262FF8;
	Thu,  7 Aug 2025 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754577742; cv=none; b=SVBBr87lsfD3Ra2/qZZ2jlhk8G8WHURSlucGbSoTfDwjdvuXg+GhatK79A8NPkJ6GGYfW68goido4HKlQGsx+m/Add3BsUovvw5gQTB34uecHotO4867RtwM84fA5wGxcpgK1KQpe5JZkZKqESBp1m/vWlNFjdQp+iaQIxny4t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754577742; c=relaxed/simple;
	bh=uY2YYBLhCe4Z6/eH5GyvY31+PFSBjlYJgir23MrVrWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poP8dX7/K/ZIXhfAmH5taAKseXzgwqD+Tmw2RjYU4uOuq9khSmknpCKuf8sorzjjXhQfSJ/Y6uAAvyrBEXrS1700hj0+S1AC6EhPvY6JPo0GAnM70vDtXsQzF7PZjZx0kdoeB6GFDKpBpNMNfmow1V0qIUogFOz6A9TMD+SJ+GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rRI06iNl; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5777MsQD006993;
	Thu, 7 Aug 2025 14:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=IGoNu
	kqg2VApmAgikSGXKQzP6s57nCKJToW7CCIR2ns=; b=rRI06iNlqBTr4Tf/I2VKw
	EyOK7XQ0vIdohmLbJT2UwriWEomiNloYm8bPmixi6eLuBnf8cYaqd8KxHRrfiHij
	oPnGZUbdUliJP9dvRtLM0dZLFGT9QOX8KzQ+whYRTxuflTcISy5dy5/QEaeLswk6
	1/ax+99hXyB8Oze8xAHfA7ajW1e0uKSSdisoJNwH3FJAmoJjW9Nq2fFMkybJTdEe
	igNpCCk+TThkqqY04cWNj8dCvXofKhxCwzPGBebGbGjoC3cuC8PEWUVHpkKPtMlH
	W+8Oazrj6rkxoT3EVcrZKOyXrcu4ZxcMeqEWsMCtfY2s0rjG8akUXqlu3N+tMCYp
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpxy4dp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 14:42:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 577DuDjY005693;
	Thu, 7 Aug 2025 14:42:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwyhw0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 14:42:16 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 577EgAIv014830;
	Thu, 7 Aug 2025 14:42:16 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-8.vpn.oracle.com [10.154.53.8])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 48bpwyhvt5-7;
	Thu, 07 Aug 2025 14:42:16 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 6/6] tests: Add test of pahole using BTF as input to BTF generation
Date: Thu,  7 Aug 2025 15:42:09 +0100
Message-ID: <20250807144209.1845760-7-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250807144209.1845760-1-alan.maguire@oracle.com>
References: <20250807144209.1845760-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=928 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508070118
X-Proofpoint-GUID: lx_9dJScUNI6jpbV2UeWtGd5LhqzhRr8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDExOSBTYWx0ZWRfX3Jb+q6m8Yxfm
 gOfoGwyn2cRX3ZgbjJSbcUjuBqE/SeHrGxuPB1FSJAxlm6Xw3kuCvGb+kADScY8oBaga9cFhUWh
 zban6digFQldfo/CaA0lxJjk59bOo4bne+l90fGhLEA7Sb9m49BBx/EcoOBc2kLi+MQ1jIjIYum
 K0Wnj74JDeeWQ1RejMhVWu44K/6zZrgPK421k+q4Ap9VyZigAcSIwXI+MFBMTMrEL+EOyo0kBpr
 ERFNaf8tgpuWgwu5wsd2YkQvRW1IxeM3cIS3a/w6Syz/eNxawMkKbXR0q0xHxPgkkgvoAc4NSNt
 h7R3Q8K1Szjpcj/E3t5/hsBkoXxR6V4XxfiAh75oBN/lYOWKO9Ij46MW84TEn6bzIa6a0EP4B/p
 MOuStVFqR14oWpgWeY+Wj/ym00PzTwEkZzEjbw73yWv3mSmx7Mc3XxwaDLfaDEun3sxGCM8w
X-Authority-Analysis: v=2.4 cv=Y9/4sgeN c=1 sm=1 tr=0 ts=6894bb49 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=xz9bU-MXYe8BVxLLlEsA:9 cc=ntf
 awl=host:12069
X-Proofpoint-ORIG-GUID: lx_9dJScUNI6jpbV2UeWtGd5LhqzhRr8

Create two .o files containing BTF as a result of passing -gbtf
and ensure that we can run BTF generation (and dedup) on them
to get a valid detached BTF output.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tests/btf_2_btf.sh | 122 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100755 tests/btf_2_btf.sh

diff --git a/tests/btf_2_btf.sh b/tests/btf_2_btf.sh
new file mode 100755
index 0000000..dbc4f34
--- /dev/null
+++ b/tests/btf_2_btf.sh
@@ -0,0 +1,122 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (c) 2025, Oracle and/or its affiliates.
+#
+# Use -gbtf to compile objects with BTF and combine/dedup the
+# BTF using pahole; this tests the ability to take BTF as
+# input for BTF encoding as well as DWARF.
+#
+
+outdir=
+
+fail()
+{
+	# Do not remove test dir; might be useful for analysis
+	trap - EXIT
+	if [[ -d "$outdir" ]]; then
+		echo "Test data is in $outdir"
+	fi
+	exit 1
+}
+
+cleanup()
+{
+	rm ${outdir}/*
+	rmdir $outdir
+}
+
+outdir=$(mktemp -d /tmp/btf_2_btf.sh.XXXXXX)
+
+trap cleanup EXIT
+
+echo -n "Validation of BTF encoding from cc-generated BTF: "
+
+cat <<EOF > ${outdir}/f1.c
+#include <stdlib.h>
+
+enum foo {
+	E1,
+	E2,
+	E3
+};
+
+struct bar {
+	enum foo f1;
+	int f2;
+	char *f3;
+	void *f4;
+};
+
+int baz(struct bar *b)
+{
+	return b->f2++;
+}
+EOF
+gcc -gbtf -c ${outdir}/f1.c -o ${outdir}/f1.o
+if [[ $? -ne 0 ]]; then
+	echo "skip: -gbtf not supported or gcc not present"
+	exit 1
+fi
+
+cat <<EOF > ${outdir}/f2.c
+#include <stdlib.h>
+
+enum foo {
+        E1,
+        E2,
+        E3
+};
+
+struct bar {
+        enum foo f1;
+        int f2;
+        char *f3;
+        void *f4;
+};
+
+struct bar2 {
+	void *f1;
+	int f2[3];
+};
+
+int othervar;
+
+void *baz2(struct bar2 *b2, char *o)
+{
+	if (b2->f2[0] > 2)
+		return NULL;
+	return o;
+}
+EOF
+gcc -gbtf -c ${outdir}/f2.c -o ${outdir}/f2.o
+
+pahole -J --format_path=btf --btf_features=default --lang_exclude=rust \
+	--btf_encode_detached=${outdir}/cc.btf ${outdir}/f1.o ${outdir}/f2.o
+
+for f in ${outdir}/f1.o ${outdir}/cc.btf ; do
+	struct=$(pahole $f |grep "struct bar" 2>/dev/null)
+	if [[ -z "$struct" ]]; then
+		echo "struct bar not found in '$f'"
+		fail
+	fi
+	fns=$(pfunct --all $f |grep baz 2>/dev/null)
+	if [[ -z "$fns" ]]; then
+		echo "function baz not found in '$f'"
+		fail
+	fi
+done
+struct=$(pahole $f |grep "struct bar2" 2>/dev/null)
+if [[ -z "$struct" ]]; then
+	echo "struct bar2 not found in '$f'"
+	fail
+fi
+fn=$(pfunct --all $f |grep "baz2" 2>/dev/null)
+if [[ -z "$fn" ]]; then
+	echo "function baz2 not found in '$f'"
+	fail
+fi
+
+echo "Ok"
+
+exit 0
-- 
2.43.5


