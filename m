Return-Path: <bpf+bounces-12568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B51017CDBA5
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 14:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703EC281DDA
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 12:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DEF34CCC;
	Wed, 18 Oct 2023 12:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qQdorI1Q"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DEE347C7
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 12:30:03 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70503A3
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 05:30:02 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IBJWip017456;
	Wed, 18 Oct 2023 12:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=bytAvguS1Z0gWAu7TmhxZ7lZvlSwRDTczlmteUBI5HI=;
 b=qQdorI1QWTCo6+hSiWyzokvMuKl6rpvwzvLtp/Xl0yxwBtfHrm0y8HIqqY4zGGAfZ5Mt
 CgCzmmmkwDkb2nVw6nWntuw+awX8zG5ExwZo2BJs8RHFtfeeRDw26UwN9dxOnPxjQY4q
 P4OZs3A7KiN4T1Dretd2IQJmi8OBky3+m1V5sm6jxv7cJlJVq4Btrr0prVj54TmBR39s
 flWCazaxUgX64f5I2ytyZ4s8deleRjUem4bBFYxpdc1VHawHSA/bR/0hA9Wkds+365UP
 JSJb5AebDMq1PXcTvjRfqKmrMCu0pxVS83y75BS3WdJQ7SDTOe44jkjcVJ5V++l2klB5 8g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqjy1fbxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Oct 2023 12:29:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39IB6vJs040556;
	Wed, 18 Oct 2023 12:29:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trfynp8ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Oct 2023 12:29:40 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39ICTUEW034930;
	Wed, 18 Oct 2023 12:29:40 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-178-90.vpn.oracle.com [10.175.178.90])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3trfynp8bs-3;
	Wed, 18 Oct 2023 12:29:39 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, andrii.nakryiko@gmail.com
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v3 dwarves 2/5] dwarves: move ARRAY_SIZE() to dwarves.h
Date: Wed, 18 Oct 2023 13:29:23 +0100
Message-Id: <20231018122926.735416-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231018122926.735416-1-alan.maguire@oracle.com>
References: <20231018122926.735416-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_11,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=808 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180103
X-Proofpoint-GUID: oOGDRR0z_3fvIJ47huc-NSHsfMN_83HP
X-Proofpoint-ORIG-GUID: oOGDRR0z_3fvIJ47huc-NSHsfMN_83HP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

...so it can be used by pahole.c too.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
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


