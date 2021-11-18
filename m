Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8665245521B
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 02:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242201AbhKRBX2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 17 Nov 2021 20:23:28 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54408 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242223AbhKRBX1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Nov 2021 20:23:27 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1AHLe06M029289
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 17:20:27 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3cd1gnnexm-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 17:20:27 -0800
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 17 Nov 2021 17:20:27 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A28E099730A3; Wed, 17 Nov 2021 17:20:19 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] libbpf: add runtime APIs to query libbpf version
Date:   Wed, 17 Nov 2021 17:20:18 -0800
Message-ID: <20211118012018.2124797-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 4to8MO-mghRHjxvNYANI8Qd_Q-wR2WLW
X-Proofpoint-ORIG-GUID: 4to8MO-mghRHjxvNYANI8Qd_Q-wR2WLW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_09,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Libbpf provided LIBBPF_MAJOR_VERSION and LIBBPF_MINOR_VERSION macros to
check libbpf version at compilation time. This doesn't cover all the
needs, though, because version of libbpf that application is compiled
against doesn't necessarily match the version of libbpf at runtime,
especially if libbpf is used as a shared library.

Add libbpf_major_version() and libbpf_minor_version() returning major
and minor versions, respectively, as integers. Also add a convenience
libbpf_version_string() for various tooling using libbpf to print out
libbpf version in a human-readable form. Currently it will return
"v0.6", but in the future it can contains some extra information, so the
format itself is not part of a stable API and shouldn't be relied upon.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c   | 19 +++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  4 ++++
 tools/lib/bpf/libbpf.map |  3 +++
 3 files changed, 26 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index de7e09a6b5ec..78de238f975a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -168,6 +168,25 @@ int libbpf_set_strict_mode(enum libbpf_strict_mode mode)
 	return 0;
 }
 
+__u32 libbpf_major_version(void)
+{
+	return LIBBPF_MAJOR_VERSION;
+}
+
+__u32 libbpf_minor_version(void)
+{
+	return LIBBPF_MINOR_VERSION;
+}
+
+const char *libbpf_version_string(void)
+{
+#define __S(X) #X
+#define _S(X) __S(X)
+	return  "v" _S(LIBBPF_MAJOR_VERSION) "." _S(LIBBPF_MINOR_VERSION);
+#undef _S
+#undef __S
+}
+
 enum kern_feature_id {
 	/* v4.14: kernel support for program & map names. */
 	FEAT_PROG_NAME,
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 4ec69f224342..003fdc5cf3a8 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -24,6 +24,10 @@
 extern "C" {
 #endif
 
+LIBBPF_API __u32 libbpf_major_version(void);
+LIBBPF_API __u32 libbpf_minor_version(void);
+LIBBPF_API const char *libbpf_version_string(void);
+
 enum libbpf_errno {
 	__LIBBPF_ERRNO__START = 4000,
 
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 6a59514a48cf..7f8f515588d1 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -414,4 +414,7 @@ LIBBPF_0.6.0 {
 		perf_buffer__new_deprecated;
 		perf_buffer__new_raw;
 		perf_buffer__new_raw_deprecated;
+		libbpf_major_version;
+		libbpf_minor_version;
+		libbpf_version_string;
 } LIBBPF_0.5.0;
-- 
2.30.2

