Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7298440D205
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 05:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbhIPD2J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Sep 2021 23:28:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27122 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234163AbhIPD2I (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Sep 2021 23:28:08 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FM3tSQ010541
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 20:26:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=vSO/nsN9rMswUJuH3L/3gers40qoAhMT0qvaFTmFXeo=;
 b=VyUg/yG0vhtVL3YqAlVSZbz2nEF768p0vVBYw3nmd+v9kZhttHKKT6XhStZ0Xg2/+xFG
 xhBLljEcPd019YRzoGogrOWlF5s0Omfu0n39aoCHFCiItKWRaEPAF4HwCmlL23xIeTgV
 KMIjH/LcIgpOGICZNzaVjOuomhcpauKPjuI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b3qg124f0-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 20:26:49 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 15 Sep 2021 20:26:47 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id CEEBB3A34B02; Wed, 15 Sep 2021 20:26:42 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <andrii@kernel.org>
CC:     <bpf@vger.kernel.org>, Yucong Sun <sunyucong@gmail.com>
Subject: [PATCH v5 bpf-next 2/3] selftests/bpf: add per worker cgroup suffix
Date:   Wed, 15 Sep 2021 20:26:40 -0700
Message-ID: <20210916032641.1413293-3-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916032641.1413293-1-fallentree@fb.com>
References: <20210916032641.1413293-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: KIxHh4SX7VUHwVRtF6U2zQxHZLU54eFm
X-Proofpoint-GUID: KIxHh4SX7VUHwVRtF6U2zQxHZLU54eFm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-16_01,2021-09-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 adultscore=0 spamscore=0 mlxlogscore=572 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160020
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yucong Sun <sunyucong@gmail.com>

This patch allows each worker to use a unique cgroup base directory, thus
allowing tests that uses cgroups to run concurrently.

Signed-off-by: Yucong Sun <sunyucong@gmail.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 5 +++--
 tools/testing/selftests/bpf/cgroup_helpers.h | 1 +
 tools/testing/selftests/bpf/test_progs.c     | 5 +++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing=
/selftests/bpf/cgroup_helpers.c
index 033051717ba5..a0429f0d6db2 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -29,9 +29,10 @@
 #define WALK_FD_LIMIT			16
 #define CGROUP_MOUNT_PATH		"/mnt"
 #define CGROUP_WORK_DIR			"/cgroup-test-work-dir"
+const char *CGROUP_WORK_DIR_SUFFIX =3D "";
 #define format_cgroup_path(buf, path) \
-	snprintf(buf, sizeof(buf), "%s%s%s", CGROUP_MOUNT_PATH, \
-		 CGROUP_WORK_DIR, path)
+	snprintf(buf, sizeof(buf), "%s%s%s%s", CGROUP_MOUNT_PATH, \
+	CGROUP_WORK_DIR, CGROUP_WORK_DIR_SUFFIX, path)
=20
 /**
  * enable_all_controllers() - Enable all available cgroup v2 controllers
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing=
/selftests/bpf/cgroup_helpers.h
index 5fe3d88e4f0d..5657aba02161 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -16,4 +16,5 @@ int setup_cgroup_environment(void);
 void cleanup_cgroup_environment(void);
 unsigned long long get_cgroup_id(const char *path);
=20
+extern const char *CGROUP_WORK_DIR_SUFFIX;
 #endif
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index 36f130455b2f..77ed9204cc4a 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1157,6 +1157,11 @@ static int server_main(void)
=20
 static int worker_main(int sock)
 {
+	static char suffix[16];
+
+	sprintf(suffix, "%d", env.worker_id);
+	CGROUP_WORK_DIR_SUFFIX =3D suffix;
+
 	save_netns();
=20
 	while (true) {
--=20
2.30.2

