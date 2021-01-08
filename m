Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E652EF859
	for <lists+bpf@lfdr.de>; Fri,  8 Jan 2021 20:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbhAHToz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 8 Jan 2021 14:44:55 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53748 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728724AbhAHToz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 Jan 2021 14:44:55 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 108JScBY023703
        for <bpf@vger.kernel.org>; Fri, 8 Jan 2021 11:44:14 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 35xu1t0xdu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 08 Jan 2021 11:44:14 -0800
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 8 Jan 2021 11:44:12 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 973672ECD211; Fri,  8 Jan 2021 11:44:10 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] libbpf: clarify kernel type use with USER variants of CORE reading macros
Date:   Fri, 8 Jan 2021 11:44:08 -0800
Message-ID: <20210108194408.3468860-1-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-08_09:2021-01-07,2021-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=844 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101080103
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add comments clarifying that USER variants of CO-RE reading macro are still
only going to work with kernel types, defined in kernel or kernel module BTF.
This should help preventing invalid use of those macro to read user-defined
types (which doesn't work with CO-RE).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_core_read.h | 45 ++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index 9456aabcb03a..53b3e199fb25 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -197,6 +197,7 @@ enum bpf_enum_value_kind {
 #define bpf_core_read(dst, sz, src)					    \
 	bpf_probe_read_kernel(dst, sz, (const void *)__builtin_preserve_access_index(src))
 
+/* NOTE: see comments for BPF_CORE_READ_USER() about the proper types use. */
 #define bpf_core_read_user(dst, sz, src)				    \
 	bpf_probe_read_user(dst, sz, (const void *)__builtin_preserve_access_index(src))
 /*
@@ -207,6 +208,7 @@ enum bpf_enum_value_kind {
 #define bpf_core_read_str(dst, sz, src)					    \
 	bpf_probe_read_kernel_str(dst, sz, (const void *)__builtin_preserve_access_index(src))
 
+/* NOTE: see comments for BPF_CORE_READ_USER() about the proper types use. */
 #define bpf_core_read_user_str(dst, sz, src)				    \
 	bpf_probe_read_user_str(dst, sz, (const void *)__builtin_preserve_access_index(src))
 
@@ -302,7 +304,11 @@ enum bpf_enum_value_kind {
 		     dst, (src), a, ##__VA_ARGS__)			    \
 })
 
-/* Variant of BPF_CORE_READ_INTO() for reading from user-space memory */
+/*
+ * Variant of BPF_CORE_READ_INTO() for reading from user-space memory.
+ *
+ * NOTE: see comments for BPF_CORE_READ_USER() about the proper types use.
+ */
 #define BPF_CORE_READ_USER_INTO(dst, src, a, ...) ({			    \
 	___core_read(bpf_core_read_user, bpf_core_read_user,		    \
 		     dst, (src), a, ##__VA_ARGS__)			    \
@@ -314,7 +320,11 @@ enum bpf_enum_value_kind {
 		     dst, (src), a, ##__VA_ARGS__)			    \
 })
 
-/* Non-CO-RE variant of BPF_CORE_READ_USER_INTO() */
+/* Non-CO-RE variant of BPF_CORE_READ_USER_INTO().
+ *
+ * As no CO-RE relocations are emitted, source types can be arbitrary and are
+ * not restricted to kernel types only.
+ */
 #define BPF_PROBE_READ_USER_INTO(dst, src, a, ...) ({			    \
 	___core_read(bpf_probe_read_user, bpf_probe_read_user,		    \
 		     dst, (src), a, ##__VA_ARGS__)			    \
@@ -330,7 +340,11 @@ enum bpf_enum_value_kind {
 		     dst, (src), a, ##__VA_ARGS__)			    \
 })
 
-/* Variant of BPF_CORE_READ_STR_INTO() for reading from user-space memory */
+/*
+ * Variant of BPF_CORE_READ_STR_INTO() for reading from user-space memory.
+ *
+ * NOTE: see comments for BPF_CORE_READ_USER() about the proper types use.
+ */
 #define BPF_CORE_READ_USER_STR_INTO(dst, src, a, ...) ({		    \
 	___core_read(bpf_core_read_user_str, bpf_core_read_user,	    \
 		     dst, (src), a, ##__VA_ARGS__)			    \
@@ -342,7 +356,12 @@ enum bpf_enum_value_kind {
 		     dst, (src), a, ##__VA_ARGS__)			    \
 })
 
-/* Non-CO-RE variant of BPF_CORE_READ_USER_STR_INTO() */
+/*
+ * Non-CO-RE variant of BPF_CORE_READ_USER_STR_INTO().
+ *
+ * As no CO-RE relocations are emitted, source types can be arbitrary and are
+ * not restricted to kernel types only.
+ */
 #define BPF_PROBE_READ_USER_STR_INTO(dst, src, a, ...) ({		    \
 	___core_read(bpf_probe_read_user_str, bpf_probe_read_user,	    \
 		     dst, (src), a, ##__VA_ARGS__)			    \
@@ -378,7 +397,16 @@ enum bpf_enum_value_kind {
 	__r;								    \
 })
 
-/* Variant of BPF_CORE_READ() for reading from user-space memory */
+/*
+ * Variant of BPF_CORE_READ() for reading from user-space memory.
+ *
+ * NOTE: all the source types involved are still *kernel types* and need to
+ * exist in kernel (or kernel module) BTF, otherwise CO-RE relocation will
+ * fail. Custom user types are not relocatable with CO-RE.
+ * The typical situation in which BPF_CORE_READ_USER() might be used is to
+ * read kernel UAPI types from the user-space memory passed in as a syscall
+ * input argument.
+ */
 #define BPF_CORE_READ_USER(src, a, ...) ({				    \
 	___type((src), a, ##__VA_ARGS__) __r;				    \
 	BPF_CORE_READ_USER_INTO(&__r, (src), a, ##__VA_ARGS__);		    \
@@ -392,7 +420,12 @@ enum bpf_enum_value_kind {
 	__r;								    \
 })
 
-/* Non-CO-RE variant of BPF_CORE_READ_USER() */
+/*
+ * Non-CO-RE variant of BPF_CORE_READ_USER().
+ *
+ * As no CO-RE relocations are emitted, source types can be arbitrary and are
+ * not restricted to kernel types only.
+ */
 #define BPF_PROBE_READ_USER(src, a, ...) ({				    \
 	___type((src), a, ##__VA_ARGS__) __r;				    \
 	BPF_PROBE_READ_USER_INTO(&__r, (src), a, ##__VA_ARGS__);	    \
-- 
2.24.1

