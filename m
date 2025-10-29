Return-Path: <bpf+bounces-72709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2C4C19814
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 10:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6716A4F5F13
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 09:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB092E427B;
	Wed, 29 Oct 2025 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="orr91ltW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22DA20C48A
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731237; cv=none; b=XC6DVC+8rOy/Pu3Vg7XrKTVfQR1t8OItBRhyE9R2yya9EBHXaPhpFuBF0VHtn+ASLP8MpR9yc2SGNS4aF0cTD7pEy/pkd2VLBxRML+AJecqw6mEx9+m3ik+oei6uP0p1k4KAXxIu/sbN7/4wbTtQInMlfSr4Q6m/gTm+VcIQ6yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731237; c=relaxed/simple;
	bh=xKelu7/w0PqcnXx3h/HFLv5mx2SbpRyrSfFLz225kdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MnOrFp72wqVPL/5lnCcXS0AQs/uBB/mj3rniHt8uhbDz/PcRvHMF2ayYxnxszASjqqgX454bW9IzpGCkzXS5nUYm4EPg4w6ZNQTAEG3P4yflxzYAa769eIjJjK7q0sKNILMhVpL5UwF4gmtIEPP2CFE+Ad/KAHLLNf1UW/hrQcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=orr91ltW; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59T7gV2t030041;
	Wed, 29 Oct 2025 09:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=ZAi8V
	m1tyE2QSHBam3pI/5o7/Wo1P+qiFCrAS7zAe+U=; b=orr91ltWba6obbIf1FPoz
	TmNWBNmffglqEKI1E0aCmSfmroIR2wGDUDXEAefTX5Dfq/EcLpu7UYLVzSWM7Xd8
	VkJXyZspxKe2moA1MjJOvyP9H9/o+NnQ55nvbQhU+/bihkVq8ChYN6vDrJ1cvI86
	ECuj8ordn7sDqRETFQ8orr7XSkDj2HcFixDKMfILyE5IWE6GDVQT7KNon81gydca
	1DG0pIb7hCBmKsdGvr5XnbpMFBavu7KjpeDkRNg+m3JXp3BYvCoFnFwUWXA+Svm4
	BvA5i4MSf21wp5ZkiMyMXxUm1a4qYuc0lLXZqmiCH+SnuWCODIc/81I6P1ZtW3DU
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a3bgkrhfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 09:46:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59T95eRo007644;
	Wed, 29 Oct 2025 09:46:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33wk0ceg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 09:46:43 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59T9kbKa030346;
	Wed, 29 Oct 2025 09:46:42 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-55-155.vpn.oracle.com [10.154.55.155])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a33wk0cah-2;
	Wed, 29 Oct 2025 09:46:42 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: qmo@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, terrelln@fb.com,
        dsterba@suse.com, acme@redhat.com, irogers@google.com, leo.yan@arm.com,
        namhyung@kernel.org, tglozar@redhat.com, blakejones@google.com,
        yuzhuo@google.com, charlie@rivosinc.com, ebiggers@kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 1/2] tools-build: Add feature test for openssl3
Date: Wed, 29 Oct 2025 09:46:30 +0000
Message-ID: <20251029094631.1387011-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251029094631.1387011-1-alan.maguire@oracle.com>
References: <20251029094631.1387011-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510290072
X-Authority-Analysis: v=2.4 cv=Y4b1cxeN c=1 sm=1 tr=0 ts=6901e284 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ntg_Zx-WAAAA:8 a=yPCof4ZbAAAA:8
 a=J178hsxuldUgMzOB7hEA:9 a=RUfouJl5KNV7104ufCm4:22 a=nl4s5V0KI7Kw-pW0DWrs:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-GUID: 5PDP1qskHd08U8VY8W6f10y7X0VZ5fyM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAyOCBTYWx0ZWRfX4lAdfXJF4d0t
 k3cSzFcZVH4SZyUw4PwLlKdjTAuwbIsnIezk09/5MiXkd/ScFlSMssJ8+D5CpBsoVnqjJ26zH/A
 MxXfky7NivT4rezMp3w/MDMJcXDzzhqu612JD7gsN+Iz9x4HrCKZZaW3yZn+BCfobnDbyRIudAM
 0K/ydUMEQgYBP/4ZDO+TUXuZ81NQB2Rqy8juKYdSwecfnN8isc1lR/9eBzQqpX8vdJ/w4R2Zxjm
 yxCkknzCdtNG63+S4DtBcDov0Bf/7a0rahGeMVISWz1Qr6n8vqFh48QDSfnNMYgNkxQEkMybXPO
 fUuvTg3nNb9N4lgrLol16Hbt/HQWEO8LccgsJ/7jba0L7C9cr+U6sKHFuzxFrUMMcv4YUkbcKy1
 XIb4DnvAYtt2nakHn4z5rCxjNEJRjA==
X-Proofpoint-ORIG-GUID: 5PDP1qskHd08U8VY8W6f10y7X0VZ5fyM

Add test that verifies if libcrypto has >= openssl3 support; use openssl3
function ERR_get_error_all() [1]

[1] https://docs.openssl.org/3.0/man3/ERR_get_error/

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/build/feature/Makefile         |  6 +++++-
 tools/build/feature/test-libcrypto.c | 12 ++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)
 create mode 100644 tools/build/feature/test-libcrypto.c

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 49b0add392b1..380087f9170d 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -22,6 +22,7 @@ FILES=                                          \
          test-cplus-demangle.bin                \
          test-cxa-demangle.bin                  \
          test-libcap.bin			\
+         test-libcrypto.bin			\
          test-libelf.bin                        \
          test-libelf-getphdrnum.bin             \
          test-libelf-gelf_getnote.bin           \
@@ -107,7 +108,7 @@ all: $(FILES)
 __BUILD = $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.c,$(@F)) $(LDFLAGS)
   BUILD = $(__BUILD) > $(@:.bin=.make.output) 2>&1
   BUILD_BFD = $(BUILD) -DPACKAGE='"perf"' -lbfd -ldl
-  BUILD_ALL = $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd
+  BUILD_ALL = $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lcrypto -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd
 
 __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
   BUILDXX = $(__BUILDXX) > $(@:.bin=.make.output) 2>&1
@@ -138,6 +139,9 @@ $(OUTPUT)test-bionic.bin:
 $(OUTPUT)test-libcap.bin:
 	$(BUILD) -lcap
 
+$(OUTPUT)test-libcrypto.bin:
+	$(BUILD) -lcrypto
+
 $(OUTPUT)test-libelf.bin:
 	$(BUILD) -lelf
 
diff --git a/tools/build/feature/test-libcrypto.c b/tools/build/feature/test-libcrypto.c
new file mode 100644
index 000000000000..b94116e0c44c
--- /dev/null
+++ b/tools/build/feature/test-libcrypto.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <openssl/err.h>
+
+/*
+ * ERR_get_error_all() was introduced in openssl3
+ *
+ * https://docs.openssl.org/3.0/man3/ERR_get_error/
+ */
+int main(void)
+{
+	return ERR_get_error_all(NULL, NULL, NULL, NULL, NULL);
+}
-- 
2.39.3


