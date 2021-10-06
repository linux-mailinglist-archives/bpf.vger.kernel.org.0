Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CF942464C
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 20:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhJFS6T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 14:58:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:65416 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229992AbhJFS6T (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 14:58:19 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196Fpodi024101
        for <bpf@vger.kernel.org>; Wed, 6 Oct 2021 11:56:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=xVwudgJm10RSrZOZYvAAtPEvN7b3bSI6UyazlCFUPmk=;
 b=Qdds1W1qwTzl8WT3dJma9qIRgA/A3orvlfezis31N7NDN4z6LUYkZw80hNbnGvW2DqmH
 OKfKANpbr9vM7HbtK313z1iZHppAfB8lbgiY4CLjUClTrWt8Kr2dLNtYMilwz/oIl8i9
 vfK/WMFs/VCAu4+3TJ34rc6AEJo7ZTzLaS0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bhetf9kvr-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 11:56:26 -0700
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 6 Oct 2021 11:56:23 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 2300B4BDB5B3; Wed,  6 Oct 2021 11:56:20 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <sunyucong@gmail.com>
Subject: [PATCH bpf-next v6 04/14] selftests/bpf: add per worker cgroup suffix
Date:   Wed, 6 Oct 2021 11:56:09 -0700
Message-ID: <20211006185619.364369-5-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006185619.364369-1-fallentree@fb.com>
References: <20211006185619.364369-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 4h2pW874jrfKc4CsaeSS30bVtk9eY807
X-Proofpoint-ORIG-GUID: 4h2pW874jrfKc4CsaeSS30bVtk9eY807
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 adultscore=0 spamscore=0
 mlxlogscore=488 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yucong Sun <sunyucong@gmail.com>

This patch make each worker use a unique cgroup base directory, thus
allowing tests that uses cgroups to run concurrently.

Signed-off-by: Yucong Sun <sunyucong@gmail.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 6 +++---
 tools/testing/selftests/bpf/cgroup_helpers.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing=
/selftests/bpf/cgroup_helpers.c
index f3daa44a8266..8fcd44841bb2 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -11,6 +11,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <ftw.h>
+#include <unistd.h>
=20
 #include "cgroup_helpers.h"
=20
@@ -33,10 +34,9 @@
 #define CGROUP_MOUNT_DFLT		"/sys/fs/cgroup"
 #define NETCLS_MOUNT_PATH		CGROUP_MOUNT_DFLT "/net_cls"
 #define CGROUP_WORK_DIR			"/cgroup-test-work-dir"
-
 #define format_cgroup_path(buf, path) \
-	snprintf(buf, sizeof(buf), "%s%s%s", CGROUP_MOUNT_PATH, \
-		 CGROUP_WORK_DIR, path)
+	snprintf(buf, sizeof(buf), "%s%s%d%s", CGROUP_MOUNT_PATH, \
+	CGROUP_WORK_DIR, getpid(), path)
=20
 #define format_classid_path(buf)				\
 	snprintf(buf, sizeof(buf), "%s%s", NETCLS_MOUNT_PATH,	\
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing=
/selftests/bpf/cgroup_helpers.h
index 629da3854b3e..fcc9cb91b211 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -26,4 +26,4 @@ int join_classid(void);
 int setup_classid_environment(void);
 void cleanup_classid_environment(void);
=20
-#endif /* __CGROUP_HELPERS_H */
+#endif /* __CGROUP_HELPERS_H */
\ No newline at end of file
--=20
2.30.2

