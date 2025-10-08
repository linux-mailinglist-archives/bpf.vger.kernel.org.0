Return-Path: <bpf+bounces-70612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0F2BC628E
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 19:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BBA54E3E43
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 17:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DA02EB878;
	Wed,  8 Oct 2025 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JL635UTg"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368012C0264
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759944978; cv=none; b=dTgnxxHAFN28IAFL39XZbyi4V9Wlc4G6SLOksV3bZge4E9bOqDoFo+VPeo3f2XmRTZ08tWvMGmrz9/oNrlAB/pI3ubT2vHTUkwMD+E5TuO0c7K9f1hWYTA2k9SVHkHwerOiMgmKg4Fb0hj+K1rW8MHN6JuujU4CWgfVQiC1GEeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759944978; c=relaxed/simple;
	bh=er62Rtv5V/716kSmOE1MgVouNnlb1cqvoXwhrHJjDus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPlr5i11Lis40W2gC+2kL6ojCaPTUVGn0SB92kUmiNKJH7wFztfRzxTAEo4fdTveRAHWb9YjTHv+bAbTUslG+gYkjc4G/3xjxUFoMQYDoZMIUSqBnakvwML/zc5J41tFndThSql0IqqqTuTmaOciprIDZg63TpyaKmK4v2eATRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JL635UTg; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598HER83032572;
	Wed, 8 Oct 2025 17:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=E7kZ/
	MoHReGo9Z3TWJBHn2ObJjWse4R3G3iwAA2rq18=; b=JL635UTgBQ1tbU/rjEBjk
	EikGDzlvd6sRr7hk3fmSV2gFs0CnSX3xAD3ygP1yAExiRYwjDLzHELu1qsEyScUE
	qn1dtoofBHkrKS0VJXHPgc7bLvQKpm2gKm/tCfWW0u2jhvpvS2YDzXLHO/mFJ4Ou
	L8sYhBBmC6tv8T0+NEnQLFdhy3NapH7OAfpSr4sISer0LEs/tQ+LLS2eWrTMqxP+
	LvRWdptcQjp29kkI8nrYtrC4KMZmz8ixr+JPwdXXmhEYokH58H+WfFuhuWfcJ8/N
	Kw1vRr84k+BrZmh+y82yLaJ1x4jfxBLwQoN9leUZXHfrB34NNNSyfEOVzk3+Rix8
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6br1cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 598HDtlg037063;
	Wed, 8 Oct 2025 17:35:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49nv62rq5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:56 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 598HZFVC031138;
	Wed, 8 Oct 2025 17:35:56 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-90.vpn.oracle.com [10.154.53.90])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49nv62rpmb-16;
	Wed, 08 Oct 2025 17:35:56 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 15/15] selftests/bpf: Add test tracing inline site using SEC("kloc")
Date: Wed,  8 Oct 2025 18:35:11 +0100
Message-ID: <20251008173512.731801-16-alan.maguire@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=BLO+bVQG c=1 sm=1 tr=0 ts=68e6a0fe b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=bx4hg8W_W4Gx3aSBSrUA:9 cc=ntf
 awl=host:13625
X-Proofpoint-ORIG-GUID: IKuUYh4UEdJIOteyyPkUGxCyo-J816IH
X-Proofpoint-GUID: IKuUYh4UEdJIOteyyPkUGxCyo-J816IH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXwyNvr04yBPS3
 deY37oPcm2zMkyGHw0dZ5YWTq+ALLJo9RartWkexxr6cw7LJNJZNnPKlwqh1oKEmc/jwpe8qAdT
 oephoXlXwG13pDdkUf6XHBf3zOFXMBvLTxZ4i+uAxg41g91rKv8YGpJVJg1LMca3gYGM0rlkMQi
 dt1Zz8y1RtEpMgrZFxFjZJ76Z7AHsqHtO8HYd7FPxnGrQ+w1yE/cgBycCmoVqfACYDxynFH63xB
 CBoeyasqH3YtXqP0FBhy+KnmgAVNquzXvSI/HI6c30+8RKsKw5bHQQ4pJnr0bhskV0NtEi+bHh+
 bHBfjN5eL4z6tGfYS5aYbSv7Oq1B2VKxwiBu2bmrHznM+hUqz0joY8EXYokrU51Q5y+HTUy3TAI
 t1Jj3xscvBY0AjBUGgIKEr3t3SQC5hzq9x+/I/A0alMCl07pG3k=

Add a test tracing a vmlinux inline function called from
__sys_bpf() and ensure one of its arguments - if available -
is as expected.

A simple test as a starting point but it does demonstrate the
viability of the approach.

Ideally we would add a bunch of inlines to bpf_testmod, but
need to have BTF distillation/relocation working for .BTF.extra
sections; that is not yet implemented.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/bpf/prog_tests/kloc.c | 51 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/kloc.c      | 36 +++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kloc.c
 create mode 100644 tools/testing/selftests/bpf/progs/kloc.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kloc.c b/tools/testing/selftests/bpf/prog_tests/kloc.c
new file mode 100644
index 000000000000..a88a43f25909
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kloc.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025, Oracle and/or its affiliates. */
+
+#include <test_progs.h>
+#include <sys/stat.h>
+
+#include "kloc.skel.h"
+
+void test_kloc(void)
+{
+	int err = 0, duration = 0;
+	struct kloc *skel;
+	struct stat sb;
+
+	/* If CONFIG_DEBUG_INFO_BTF_EXTRA=m , ensure vmlinux BTF extra is
+	 * loaded.
+	 */
+	system("modprobe btf_extra");
+
+	/* Kernel may not have been compiled with extra BTF info or pahole
+	 * may not have support.
+	 */
+	if (stat("/sys/kernel/btf_extra/vmlinux", &sb) != 0)
+		test__skip();
+
+	skel = kloc__open_and_load();
+	if (CHECK(!skel, "skel_load", "skeleton failed: %d\n", err))
+		goto cleanup;
+
+	skel->bss->test_pid = getpid();
+
+	err = kloc__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto cleanup;
+	/* trigger bpf syscall to trigger kloc */
+	(void) bpf_obj_get("/sys/fs/bpf/noexist");
+
+	ASSERT_GT(skel->bss->kloc_triggered, 0, "verify kloc was triggered");
+
+	/* this is a conditional since it is possible the size parameter
+	 * is not available at the inline site.
+	 *
+	 * Expected size here is that from bpf_obj_get_opts(); see
+	 * tools/lib/bpf/bpf.c.
+	 */
+	if (skel->bss->kloc_size > 0)
+		ASSERT_EQ(skel->bss->kloc_size, offsetofend(union bpf_attr, path_fd), "verify kloc size set");
+
+cleanup:
+	kloc__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/kloc.c b/tools/testing/selftests/bpf/progs/kloc.c
new file mode 100644
index 000000000000..8007e53f3210
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kloc.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025, Oracle and/or its affiliates. */
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/loc.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+int kloc_triggered;
+size_t kloc_size;
+int test_pid;
+
+/* This function is inlined to __sys_bpf() and we trigger a call to
+ * it via bpf_obj_get_opts().
+ */
+SEC("kloc/vmlinux:copy_from_bpfptr_offset")
+int BPF_KLOC(trace_copy_from_bpfptr_offset, void *dst, void *uattr, size_t offset, size_t size)
+{
+	int pid = bpf_get_current_pid_tgid() >> 32;
+	long s;
+
+	if (test_pid != pid)
+		return 0;
+
+	kloc_triggered++;
+
+	/* is arg available? */
+	if (bpf_loc_arg(ctx, 3, &s) == 0)
+		kloc_size = size;
+
+	return 0;
+}
-- 
2.39.3


