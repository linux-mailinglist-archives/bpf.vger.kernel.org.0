Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC504561A6
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 18:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbhKRRoA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 18 Nov 2021 12:44:00 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6702 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231264AbhKRRn7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 12:43:59 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIDNsXh027708
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 09:40:59 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cdqp4j11f-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 09:40:59 -0800
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 18 Nov 2021 09:40:58 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 17C4E9AF1A73; Thu, 18 Nov 2021 09:40:56 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH v2 bpf-next] libbpf: add runtime APIs to query libbpf version
Date:   Thu, 18 Nov 2021 09:40:54 -0800
Message-ID: <20211118174054.2699477-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
X-FB-Source: Intern
X-Proofpoint-GUID: SWAVixb47qDvuKx2F54gOLGE9-oEBli2
X-Proofpoint-ORIG-GUID: SWAVixb47qDvuKx2F54gOLGE9-oEBli2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_12,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180093
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

Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
v1->v2:
  - libbpf.map wasn't alphabetically sorted, fixed that.

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
index 6a59514a48cf..bea6791272e5 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -410,6 +410,9 @@ LIBBPF_0.6.0 {
 		btf__type_cnt;
 		btf_dump__new;
 		btf_dump__new_deprecated;
+		libbpf_major_version;
+		libbpf_minor_version;
+		libbpf_version_string;
 		perf_buffer__new;
 		perf_buffer__new_deprecated;
 		perf_buffer__new_raw;
-- 
2.30.2

