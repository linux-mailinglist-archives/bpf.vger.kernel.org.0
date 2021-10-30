Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF00C440787
	for <lists+bpf@lfdr.de>; Sat, 30 Oct 2021 06:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhJ3FC0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 30 Oct 2021 01:02:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39750 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231409AbhJ3FCY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 30 Oct 2021 01:02:24 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19U3dM86021751
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 21:59:55 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c0mdnmsj6-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 21:59:55 -0700
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 29 Oct 2021 21:59:53 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 898067830519; Fri, 29 Oct 2021 21:59:49 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH bpf-next 03/14] libbpf: rename DECLARE_LIBBPF_OPTS into LIBBPF_OPTS
Date:   Fri, 29 Oct 2021 21:59:30 -0700
Message-ID: <20211030045941.3514948-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211030045941.3514948-1-andrii@kernel.org>
References: <20211030045941.3514948-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: P7W95Rg3pXriqptd8h3T66TrthbUflof
X-Proofpoint-ORIG-GUID: P7W95Rg3pXriqptd8h3T66TrthbUflof
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-30_01,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 mlxlogscore=399 lowpriorityscore=0 spamscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110300025
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It's confusing that libbpf-provided helper macro doesn't start with
LIBBPF. Also "declare" vs "define" is confusing terminology, I can never
remember and always have to look up previous examples.

Bypass both issues by renaming DECLARE_LIBBPF_OPTS into a short and
clean LIBBPF_OPTS. To avoid breaking existing code, provide:

  #define DECLARE_LIBBPF_OPTS LIBBPF_OPTS

in libbpf_legacy.h. We can decide later if we ever want to remove it or
we'll keep it forever because it doesn't add any maintainability burden.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.h           | 1 +
 tools/lib/bpf/libbpf_common.h | 2 +-
 tools/lib/bpf/libbpf_legacy.h | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 6ef9e1e464c0..aac6bb4d8c82 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -33,6 +33,7 @@
 #include <sys/types.h>
 
 #include "libbpf_common.h"
+#include "libbpf_legacy.h"
 
 #ifdef __cplusplus
 extern "C" {
diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.h
index aaa1efbf6f51..0967112b933a 100644
--- a/tools/lib/bpf/libbpf_common.h
+++ b/tools/lib/bpf/libbpf_common.h
@@ -54,7 +54,7 @@
  * including any extra padding, it with memset() and then assigns initial
  * values provided by users in struct initializer-syntax as varargs.
  */
-#define DECLARE_LIBBPF_OPTS(TYPE, NAME, ...)				    \
+#define LIBBPF_OPTS(TYPE, NAME, ...)					    \
 	struct TYPE NAME = ({ 						    \
 		memset(&NAME, 0, sizeof(struct TYPE));			    \
 		(struct TYPE) {						    \
diff --git a/tools/lib/bpf/libbpf_legacy.h b/tools/lib/bpf/libbpf_legacy.h
index 5ba5c9beccfa..bb03c568af7b 100644
--- a/tools/lib/bpf/libbpf_legacy.h
+++ b/tools/lib/bpf/libbpf_legacy.h
@@ -69,6 +69,7 @@ enum libbpf_strict_mode {
 
 LIBBPF_API int libbpf_set_strict_mode(enum libbpf_strict_mode mode);
 
+#define DECLARE_LIBBPF_OPTS LIBBPF_OPTS
 
 #ifdef __cplusplus
 } /* extern "C" */
-- 
2.30.2

