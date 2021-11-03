Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A058A444AA7
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 23:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhKCWLi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 3 Nov 2021 18:11:38 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54458 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229698AbhKCWLi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Nov 2021 18:11:38 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A3KAqPE013772
        for <bpf@vger.kernel.org>; Wed, 3 Nov 2021 15:09:01 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c3sm5cpfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 03 Nov 2021 15:09:01 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 3 Nov 2021 15:09:00 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A34307D65E43; Wed,  3 Nov 2021 15:08:49 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v2 bpf-next 01/12] libbpf: rename DECLARE_LIBBPF_OPTS into LIBBPF_OPTS
Date:   Wed, 3 Nov 2021 15:08:34 -0700
Message-ID: <20211103220845.2676888-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103220845.2676888-1-andrii@kernel.org>
References: <20211103220845.2676888-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: Ax3GXBhioaoaT9grG28B2jbqHD7yczxM
X-Proofpoint-ORIG-GUID: Ax3GXBhioaoaT9grG28B2jbqHD7yczxM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-03_06,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=479
 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111030115
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
index 6fffb3cdf39b..f35146c1d9a9 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -29,6 +29,7 @@
 #include <stdint.h>
 
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

