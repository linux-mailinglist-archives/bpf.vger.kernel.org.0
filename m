Return-Path: <bpf+bounces-12993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 487917D2F46
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 11:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795CB1C20A1B
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 09:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C83014001;
	Mon, 23 Oct 2023 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qfl/ibIh"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D63614297
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 09:58:27 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575A61717
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 02:58:26 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N6j9IM029437;
	Mon, 23 Oct 2023 09:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=b/K50mY8+chMNeje8FvYiijwCMrdZp7QY183COsfuOg=;
 b=Qfl/ibIhsuGOJPr/JnZqm0xCtFC/nCej9DGjQCpUPuxcGv8/yAE+12Hhe6YgkcpiCtLQ
 hqDInyGC9PIcqROpw78mUGVIuTeEzuLZ4yCggPQqZ/06hG7FAj1JvqhKTo0uJ3T15s7y
 L1EXvXuZ0W2v5JJZhC95iVrcygUZ1ekQmZa5HGM4IDP2RgptHy/JDMdyIlj1fXrjQL3G
 RRUk5Zh0KkzGPcdTTt3ptNI2vNb8Ytl0hv3ALOnlk1gwMpN0q9Z9gRn15iQksAmToohY
 bXK7HiVoCaHFkWIUJ0C01HwnjPN5t9IGEYmh7v8HhV5dYKD+ZrfPWKySW20Ef3W6KNyZ Aw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5jbasft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Oct 2023 09:57:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39N7DFHB001556;
	Mon, 23 Oct 2023 09:57:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53a8129-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Oct 2023 09:57:43 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39N9t2cP039213;
	Mon, 23 Oct 2023 09:57:42 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-206-92.vpn.oracle.com [10.175.206.92])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3tv53a80w0-3;
	Mon, 23 Oct 2023 09:57:42 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, andrii.nakryiko@gmail.com
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v4 dwarves 2/5] dwarves: move ARRAY_SIZE() to dwarves.h
Date: Mon, 23 Oct 2023 10:57:23 +0100
Message-Id: <20231023095726.1179529-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231023095726.1179529-1-alan.maguire@oracle.com>
References: <20231023095726.1179529-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_07,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=758
 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230085
X-Proofpoint-GUID: rh2pUkB7vcpfgAvnlFfrzTGLj6V0KGKC
X-Proofpoint-ORIG-GUID: rh2pUkB7vcpfgAvnlFfrzTGLj6V0KGKC

...so it can be used by pahole.c too.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 dwarves.c | 16 ----------------
 dwarves.h | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/dwarves.c b/dwarves.c
index 218367b..9f97eda 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -2094,22 +2094,6 @@ int cus__load_file(struct cus *cus, struct conf_load *conf,
 	_min1 < _min2 ? _min1 : _min2; })
 #endif
 
-/* Force a compilation error if condition is true, but also produce a
-   result (of value 0 and type size_t), so the expression can be used
-   e.g. in a structure initializer (or where-ever else comma expressions
-   aren't permitted). */
-#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
-
-/* Are two types/vars the same type (ignoring qualifiers)? */
-#ifndef __same_type
-# define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
-#endif
-
-/* &a[0] degrades to a pointer: a different type from an array */
-#define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
-
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
-
 #ifndef DW_LANG_C89
 #define DW_LANG_C89		0x0001
 #endif
diff --git a/dwarves.h b/dwarves.h
index db68161..857b37c 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -19,6 +19,22 @@
 #include "list.h"
 #include "rbtree.h"
 
+/* Force a compilation error if condition is true, but also produce a
+   result (of value 0 and type size_t), so the expression can be used
+   e.g. in a structure initializer (or where-ever else comma expressions
+   aren't permitted). */
+#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
+
+/* Are two types/vars the same type (ignoring qualifiers)? */
+#ifndef __same_type
+# define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
+#endif
+
+/* &a[0] degrades to a pointer: a different type from an array */
+#define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
+
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
+
 struct cu;
 
 enum load_steal_kind {
-- 
2.31.1


