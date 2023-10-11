Return-Path: <bpf+bounces-11876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4B07C4E58
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 11:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B781C20E8D
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 09:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FE91B268;
	Wed, 11 Oct 2023 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KQlbc5Re"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3AE1A73C
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 09:18:07 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1829D
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 02:18:06 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39B7mrXQ022803;
	Wed, 11 Oct 2023 09:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=vBm4mi+hilPfYfH+WuzqqZk/Ytcz3nJuxfrcvINkGEw=;
 b=KQlbc5ReRDVFD9DUFy6Hi09IIsDNQj0SRdZTHPJxiVansfNiIIRWEQ/oJaxM0Se/A6Tx
 O+jeezZgEOElXV7I1vg6bd7urx7id4sbnZ8CwYbVozvQ4Q5Ni8Y910UhulqYLOgyxvIz
 qtCns4zh00x0Irc4NZxIhXJzWRE/6z/+fdEhWluLYP3ibsypTecIHJLJg4SUhmzQlQQD
 +9kMm7hYk+OAQ5hXiHD9s8zsZAmcuh+yWd4ueSlBkWUH5Lo/KyLd/kCS4iUXqs8WS6Z1
 ksYfZPYNzRP1XdIzIaHTPkR2rl+nYbk0fHAtWjjHnrrfqOXsUE20N50BfZhqjSJnsAY/ wQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjx43qc5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 09:17:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39B7NR5Z014994;
	Wed, 11 Oct 2023 09:17:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws8d12j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 09:17:47 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39B9Hbxm020344;
	Wed, 11 Oct 2023 09:17:47 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-183-173.vpn.oracle.com [10.175.183.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tjws8d0tb-3;
	Wed, 11 Oct 2023 09:17:47 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, andrii.nakryiko@gmail.com
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 2/4] dwarves: move ARRAY_SIZE() to dwarves.h
Date: Wed, 11 Oct 2023 10:17:30 +0100
Message-Id: <20231011091732.93254-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231011091732.93254-1-alan.maguire@oracle.com>
References: <20231011091732.93254-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_06,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=748 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310110081
X-Proofpoint-ORIG-GUID: 52hM7r9MRXqVBQT2_ApsMagg5Opd1yZm
X-Proofpoint-GUID: 52hM7r9MRXqVBQT2_ApsMagg5Opd1yZm
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

...so it can be used by pahole.c too.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
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


