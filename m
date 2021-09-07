Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7DA24030DF
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 00:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243678AbhIGWYo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 7 Sep 2021 18:24:44 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27246 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241562AbhIGWYn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Sep 2021 18:24:43 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 187M9sFs017545
        for <bpf@vger.kernel.org>; Tue, 7 Sep 2021 15:23:36 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3axcq4t076-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Sep 2021 15:23:36 -0700
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 7 Sep 2021 15:23:18 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 773B23D405AC; Tue,  7 Sep 2021 15:23:15 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <patrick.mccarty@intel.com>, <msuchanek@suse.de>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] libbpf: Fix build with latest gcc/binutils with LTO
Date:   Tue, 7 Sep 2021 15:10:23 -0700
Message-ID: <20210907221023.2660953-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: SG9NU3P3Kcxe3GoOq8EEOvY6p7DeG7eu
X-Proofpoint-ORIG-GUID: SG9NU3P3Kcxe3GoOq8EEOvY6p7DeG7eu
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-07_08:2021-09-07,2021-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109070140
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After updating to binutils 2.35, the build began to fail with an
assembler error. A bug was opened on the Red Hat Bugzilla a few days
later for the same issue.

Work around the problem by using the new `symver` attribute (introduced
in GCC 10) as needed instead of assembler directives.

This addresses Red Hat ([0]) and OpenSUSE ([1]) bug reports, as well as libbpf
issue ([2]).

  [0]: https://bugzilla.redhat.com/show_bug.cgi?id=1863059
  [1]: https://bugzilla.opensuse.org/show_bug.cgi?id=1188749
  [2]: Closes: https://github.com/libbpf/libbpf/issues/338

Co-developed-by: Patrick McCarty <patrick.mccarty@intel.com>
Signed-off-by: Patrick McCarty <patrick.mccarty@intel.com>
Co-developed-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf_internal.h | 25 +++++++++++++++++++------
 tools/lib/bpf/xsk.c             |  4 ++--
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 533b0211f40a..4f6ff5c23695 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -90,17 +90,30 @@
 /* Symbol versioning is different between static and shared library.
  * Properly versioned symbols are needed for shared library, but
  * only the symbol of the new version is needed for static library.
+ * Starting with GNU C 10, use symver attribute instead of .symver assembler
+ * directive, which works better with GCC LTO builds.
  */
-#ifdef SHARED
-# define COMPAT_VERSION(internal_name, api_name, version) \
+#if defined(SHARED) && defined(__GNUC__) && __GNUC__ >= 10
+
+#define DEFAULT_VERSION(internal_name, api_name, version) \
+	__attribute__((symver(#api_name "@@" #version)))
+#define COMPAT_VERSION(internal_name, api_name, version) \
+	__attribute__((symver(#api_name "@" #version)))
+
+#elif defined(SHARED)
+
+#define COMPAT_VERSION(internal_name, api_name, version) \
 	asm(".symver " #internal_name "," #api_name "@" #version);
-# define DEFAULT_VERSION(internal_name, api_name, version) \
+#define DEFAULT_VERSION(internal_name, api_name, version) \
 	asm(".symver " #internal_name "," #api_name "@@" #version);
-#else
-# define COMPAT_VERSION(internal_name, api_name, version)
-# define DEFAULT_VERSION(internal_name, api_name, version) \
+
+#else /* !SHARED */
+
+#define COMPAT_VERSION(internal_name, api_name, version)
+#define DEFAULT_VERSION(internal_name, api_name, version) \
 	extern typeof(internal_name) api_name \
 	__attribute__((alias(#internal_name)));
+
 #endif
 
 extern void libbpf_print(enum libbpf_print_level level,
diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index e9b619aa0cdf..a2111696ba91 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -281,6 +281,7 @@ static int xsk_create_umem_rings(struct xsk_umem *umem, int fd,
 	return err;
 }
 
+DEFAULT_VERSION(xsk_umem__create_v0_0_4, xsk_umem__create, LIBBPF_0.0.4)
 int xsk_umem__create_v0_0_4(struct xsk_umem **umem_ptr, void *umem_area,
 			    __u64 size, struct xsk_ring_prod *fill,
 			    struct xsk_ring_cons *comp,
@@ -345,6 +346,7 @@ struct xsk_umem_config_v1 {
 	__u32 frame_headroom;
 };
 
+COMPAT_VERSION(xsk_umem__create_v0_0_2, xsk_umem__create, LIBBPF_0.0.2)
 int xsk_umem__create_v0_0_2(struct xsk_umem **umem_ptr, void *umem_area,
 			    __u64 size, struct xsk_ring_prod *fill,
 			    struct xsk_ring_cons *comp,
@@ -358,8 +360,6 @@ int xsk_umem__create_v0_0_2(struct xsk_umem **umem_ptr, void *umem_area,
 	return xsk_umem__create_v0_0_4(umem_ptr, umem_area, size, fill, comp,
 					&config);
 }
-COMPAT_VERSION(xsk_umem__create_v0_0_2, xsk_umem__create, LIBBPF_0.0.2)
-DEFAULT_VERSION(xsk_umem__create_v0_0_4, xsk_umem__create, LIBBPF_0.0.4)
 
 static enum xsk_prog get_xsk_prog(void)
 {
-- 
2.30.2

