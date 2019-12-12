Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51F9711DA03
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2019 00:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbfLLXbV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Dec 2019 18:31:21 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32978 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726427AbfLLXbV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Dec 2019 18:31:21 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCNUfot024272
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2019 15:31:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=exfKRwHGEpDTARVMgsME3iP36reIzun2TE76MQAKTOc=;
 b=Fy6eWIZGbBJpDAdXSun0pIJYDWkdtnGO50fk23WzfYZEDNhe4H3RiQdF/AjgglHAKbEF
 QW11cjjkCm1REP20oENUexzZJR5GrZbqiJWj9yOW2buCw7gGIKQOJO9RqVjGr8o5TaF6
 BJK3jotP8hGmzA5g3Xh+9lGSNfv2C5d1q7U= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wu2gf7uqd-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2019 15:31:19 -0800
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 12 Dec 2019 15:31:17 -0800
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id F09AC3712A1F; Thu, 12 Dec 2019 15:31:16 -0800 (PST)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <andriin@fb.com>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 4/6] libbpf: Make DECLARE_LIBBPF_OPTS available in bpf.h
Date:   Thu, 12 Dec 2019 15:30:51 -0800
Message-ID: <db7f94fd1735a28b6729a7f908c1a219af046dec.1576193131.git.rdna@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1576193131.git.rdna@fb.com>
References: <cover.1576193131.git.rdna@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_08:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=13 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 mlxlogscore=889 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912120181
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DECLARE_LIBBPF_OPTS is the way to use option structures in a backward
compatible and extensible way. It's available only in libbpf.h.  Though
public interfaces in bpf.h have the same requirement  to accept options
in a way that can be simply extended w/o introducing new xattr-functions
every time.

libbpf.c depends on bpf.h, hence to share the macros a couple of options
exist:
* either a common header should be introduced;
* or the macro can be moved to bpf.h and used by libbpf.h from there;

The former seems to be an overkill, so do the latter:
* move DECLARE_LIBBPF_OPTS from libbpf.h to bpf.h;
* move `#include "bpf.h"` from libbpf.c to libbpf.h not to break users
  of the macro who already include only libbpf.h.

That makes the macro available to use in bpf.{h,c} and should not break
those who already use it.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 tools/lib/bpf/bpf.h    | 22 ++++++++++++++++++++++
 tools/lib/bpf/libbpf.c |  1 -
 tools/lib/bpf/libbpf.h | 24 ++----------------------
 3 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 3c791fa8e68e..5cfe6e0a1aef 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -36,6 +36,28 @@ extern "C" {
 #define LIBBPF_API __attribute__((visibility("default")))
 #endif
 
+/* Helper macro to declare and initialize libbpf options struct
+ *
+ * This dance with uninitialized declaration, followed by memset to zero,
+ * followed by assignment using compound literal syntax is done to preserve
+ * ability to use a nice struct field initialization syntax and **hopefully**
+ * have all the padding bytes initialized to zero. It's not guaranteed though,
+ * when copying literal, that compiler won't copy garbage in literal's padding
+ * bytes, but that's the best way I've found and it seems to work in practice.
+ *
+ * Macro declares opts struct of given type and name, zero-initializes,
+ * including any extra padding, it with memset() and then assigns initial
+ * values provided by users in struct initializer-syntax as varargs.
+ */
+#define DECLARE_LIBBPF_OPTS(TYPE, NAME, ...)				    \
+	struct TYPE NAME = ({						    \
+		memset(&NAME, 0, sizeof(struct TYPE));			    \
+		(struct TYPE) {						    \
+			.sz = sizeof(struct TYPE),			    \
+			__VA_ARGS__					    \
+		};							    \
+	})
+
 struct bpf_create_map_attr {
 	const char *name;
 	enum bpf_map_type map_type;
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 920d4e06a5f9..9d788c1b9874 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -46,7 +46,6 @@
 #include <gelf.h>
 
 #include "libbpf.h"
-#include "bpf.h"
 #include "btf.h"
 #include "str_error.h"
 #include "libbpf_internal.h"
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 0dbf4bfba0c4..03189880d99e 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -17,6 +17,8 @@
 #include <sys/types.h>  // for size_t
 #include <linux/bpf.h>
 
+#include "bpf.h"
+
 #ifdef __cplusplus
 extern "C" {
 #endif
@@ -67,28 +69,6 @@ struct bpf_object_open_attr {
 	enum bpf_prog_type prog_type;
 };
 
-/* Helper macro to declare and initialize libbpf options struct
- *
- * This dance with uninitialized declaration, followed by memset to zero,
- * followed by assignment using compound literal syntax is done to preserve
- * ability to use a nice struct field initialization syntax and **hopefully**
- * have all the padding bytes initialized to zero. It's not guaranteed though,
- * when copying literal, that compiler won't copy garbage in literal's padding
- * bytes, but that's the best way I've found and it seems to work in practice.
- *
- * Macro declares opts struct of given type and name, zero-initializes,
- * including any extra padding, it with memset() and then assigns initial
- * values provided by users in struct initializer-syntax as varargs.
- */
-#define DECLARE_LIBBPF_OPTS(TYPE, NAME, ...)				    \
-	struct TYPE NAME = ({ 						    \
-		memset(&NAME, 0, sizeof(struct TYPE));			    \
-		(struct TYPE) {						    \
-			.sz = sizeof(struct TYPE),			    \
-			__VA_ARGS__					    \
-		};							    \
-	})
-
 struct bpf_object_open_opts {
 	/* size of this struct, for forward/backward compatiblity */
 	size_t sz;
-- 
2.17.1

