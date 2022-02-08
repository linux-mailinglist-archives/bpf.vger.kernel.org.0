Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5A84AD0D2
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 06:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346974AbiBHFcq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 00:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiBHFRP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 00:17:15 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32D4C0401EA
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 21:17:12 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2181Ldw1025943;
        Tue, 8 Feb 2022 05:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=3EvM/rCmWiuVwBkzj6vPS6ZG0crmPQkuKBSqKxfzS3E=;
 b=BLyP61LStaXJiAx6fTMIVOn6IbeckCpv+x47H4QbTFfS0HbjLFcXdE3+tk5ACdt102Q7
 SLD4LMIbWQERv3AvuwqKHiTTldERn+CrJ3a8dVwWkMldkhbPgtq8CzGLUILt/oQpo3z/
 DoD5kGGGgUUcKA7VosbwYrPQ2b2Ayod7/o4CWNSo8WYk9lj6PO7br0u7W/O/IryFra41
 dfqikmNjAKvJ0Awf3fBoLhFSXmvp/SAfYNXRZdMWbfVRaN7qNz1IjTnMwlropJOTo885
 //7Cisnfzvfi9CATbknHfz9CvBm6CGnS3PBccz2dRkHEWxrmrF3zWg1esxM7FoF0FA69 hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e22m6fnww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:55 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2185Dc1D005149;
        Tue, 8 Feb 2022 05:16:55 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e22m6fnwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:54 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2185EDB7029315;
        Tue, 8 Feb 2022 05:16:53 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3e1ggj1g6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:52 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2185GlPW38601110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Feb 2022 05:16:47 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A24AC11C04A;
        Tue,  8 Feb 2022 05:16:47 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DC5911C04C;
        Tue,  8 Feb 2022 05:16:47 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Feb 2022 05:16:46 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v4 10/14] libbpf: Move data structure manipulation macros to bpf_common_helpers.h
Date:   Tue,  8 Feb 2022 06:16:31 +0100
Message-Id: <20220208051635.2160304-11-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208051635.2160304-1-iii@linux.ibm.com>
References: <20220208051635.2160304-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iaYnX2_5Oy0urX8XKbhvjQBev_xaWupT
X-Proofpoint-ORIG-GUID: DMz5srp1Q7EcldplnN2X3QxzJAmdr0T3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_01,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080025
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These macros are useful for both libbpf and bpf progs, so put them into
a separate header dedicated to this use case.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/Makefile                 |  2 +-
 tools/lib/bpf/bpf_common_helpers.h     | 30 ++++++++++++++++++++++++++
 tools/lib/bpf/bpf_helpers.h            | 15 +------------
 tools/testing/selftests/bpf/bpf_util.h | 10 +--------
 4 files changed, 33 insertions(+), 24 deletions(-)
 create mode 100644 tools/lib/bpf/bpf_common_helpers.h

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index b8b37fe76006..60b06c22e0a1 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -239,7 +239,7 @@ install_lib: all_cmd
 
 SRC_HDRS := bpf.h libbpf.h btf.h libbpf_common.h libbpf_legacy.h xsk.h	     \
 	    bpf_helpers.h bpf_tracing.h bpf_endian.h bpf_core_read.h	     \
-	    skel_internal.h libbpf_version.h
+	    skel_internal.h libbpf_version.h bpf_common_helpers.h
 GEN_HDRS := $(BPF_GENERATED)
 
 INSTALL_PFX := $(DESTDIR)$(prefix)/include/bpf
diff --git a/tools/lib/bpf/bpf_common_helpers.h b/tools/lib/bpf/bpf_common_helpers.h
new file mode 100644
index 000000000000..79db303b6ae2
--- /dev/null
+++ b/tools/lib/bpf/bpf_common_helpers.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+#ifndef __BPF_COMMON_HELPERS__
+#define __BPF_COMMON_HELPERS__
+
+/*
+ * Helper macros that can be used both by libbpf and bpf progs.
+ */
+
+#ifndef offsetof
+#define offsetof(TYPE, MEMBER) ((unsigned long)&((TYPE *)0)->MEMBER)
+#endif
+
+#ifndef sizeof_field
+#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
+#endif
+
+#ifndef offsetofend
+#define offsetofend(TYPE, MEMBER) \
+	(offsetof(TYPE, MEMBER) + sizeof_field(TYPE, MEMBER))
+#endif
+
+#ifndef container_of
+#define container_of(ptr, type, member)				\
+	({							\
+		void *__mptr = (void *)(ptr);			\
+		((type *)(__mptr - offsetof(type, member)));	\
+	})
+#endif
+
+#endif
diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 44df982d2a5c..1e8b609c1000 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -2,6 +2,7 @@
 #ifndef __BPF_HELPERS__
 #define __BPF_HELPERS__
 
+#include "bpf_common_helpers.h"
 /*
  * Note that bpf programs need to include either
  * vmlinux.h (auto-generated from BTF) or linux/types.h
@@ -61,20 +62,6 @@
 #define KERNEL_VERSION(a, b, c) (((a) << 16) + ((b) << 8) + ((c) > 255 ? 255 : (c)))
 #endif
 
-/*
- * Helper macros to manipulate data structures
- */
-#ifndef offsetof
-#define offsetof(TYPE, MEMBER)	((unsigned long)&((TYPE *)0)->MEMBER)
-#endif
-#ifndef container_of
-#define container_of(ptr, type, member)				\
-	({							\
-		void *__mptr = (void *)(ptr);			\
-		((type *)(__mptr - offsetof(type, member)));	\
-	})
-#endif
-
 /*
  * Helper macro to throw a compilation error if __bpf_unreachable() gets
  * built into the resulting code. This works given BPF back end does not
diff --git a/tools/testing/selftests/bpf/bpf_util.h b/tools/testing/selftests/bpf/bpf_util.h
index a3352a64c067..bc0b741b1eef 100644
--- a/tools/testing/selftests/bpf/bpf_util.h
+++ b/tools/testing/selftests/bpf/bpf_util.h
@@ -6,6 +6,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
+#include <bpf/bpf_common_helpers.h>
 #include <bpf/libbpf.h> /* libbpf_num_possible_cpus */
 
 static inline unsigned int bpf_num_possible_cpus(void)
@@ -31,13 +32,4 @@ static inline unsigned int bpf_num_possible_cpus(void)
 # define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 #endif
 
-#ifndef sizeof_field
-#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
-#endif
-
-#ifndef offsetofend
-#define offsetofend(TYPE, MEMBER) \
-	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
-#endif
-
 #endif /* __BPF_UTIL__ */
-- 
2.34.1

