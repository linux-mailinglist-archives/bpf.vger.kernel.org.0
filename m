Return-Path: <bpf+bounces-10373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1E67A5F3F
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 12:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617631C20DFF
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 10:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E4C30F9B;
	Tue, 19 Sep 2023 10:14:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877522E65B
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 10:14:26 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EFA19C
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 03:14:00 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JA8cuS022158;
	Tue, 19 Sep 2023 10:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Qyhy4D1LcrZGhzjETD9N3DXigigt8kwipGIG1hZZaP4=;
 b=eCkfVJXfBKE2HhnbxxmqmSb1Z/fe1fmk232fuHCgTIMlUjD6fvySP5TGmYvlnGwbtVEj
 PPyG6kiV+i5Tq6IyRCws+KUerEhEwYDS0JsxKvRHik0yP/UIkD3c0rvVCPXP9tTocflY
 IYKjd5fIKkqptjANtUN3UgfAaK+JyLvSaniIDIJYyjf2aWmnS26uwmckndMtEYWjVmM6
 ptW8Rb3I7eukgjNVdX4JaP4o5KJdnIh793iS6bxZdLPyhDEfHL88C1wxUZNPT2teikeJ
 CZo12bbnGN7e0UyQBN4XtTr0lHOdoYQ0D2VpiNWWzZcGHlqO597P/x3greyY3D7wIdEE iA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t783928y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Sep 2023 10:13:46 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38J9Vw1d018164;
	Tue, 19 Sep 2023 10:13:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5ppskp8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Sep 2023 10:13:46 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38JADhqB4915828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Sep 2023 10:13:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 694BE20067;
	Tue, 19 Sep 2023 10:13:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D544A2004F;
	Tue, 19 Sep 2023 10:13:42 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.67.55])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Sep 2023 10:13:42 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 02/10] selftests/bpf: Unmount the cgroup2 work directory
Date: Tue, 19 Sep 2023 12:09:04 +0200
Message-ID: <20230919101336.2223655-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230919101336.2223655-1-iii@linux.ibm.com>
References: <20230919101336.2223655-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GW4NWwhengcYKBwRujI4yMrTyUoRC3uL
X-Proofpoint-GUID: GW4NWwhengcYKBwRujI4yMrTyUoRC3uL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_04,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 spamscore=0 clxscore=1015 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

test_progs -t bind_perm,bpf_obj_pinning/mounted-str-rel fails when
the selftests directory is mounted under /mnt, which is a reasonable
thing to do when sharing the selftests residing on the host with a
virtual machine, e.g., using 9p.

The reason is that cgroup2 is mounted at /mnt and not unmounted,
causing subsequent tests that need to access the selftests directory
to fail.

Fix by unmounting it. The kernel maintains a mount stack, so this
reveals what was mounted there before. Introduce cgroup_workdir_mounted
in order to maintain idempotency. Make it thread-local in order to
support test_progs -j.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 33 +++++++++++++++-----
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 2caee8423ee0..24ba56d42f2d 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -49,6 +49,10 @@
 	snprintf(buf, sizeof(buf), "%s%s", NETCLS_MOUNT_PATH,	\
 		 CGROUP_WORK_DIR)
 
+static __thread bool cgroup_workdir_mounted;
+
+static void __cleanup_cgroup_environment(void);
+
 static int __enable_controllers(const char *cgroup_path, const char *controllers)
 {
 	char path[PATH_MAX + 1];
@@ -209,9 +213,10 @@ int setup_cgroup_environment(void)
 		log_err("mount cgroup2");
 		return 1;
 	}
+	cgroup_workdir_mounted = true;
 
 	/* Cleanup existing failed runs, now that the environment is setup */
-	cleanup_cgroup_environment();
+	__cleanup_cgroup_environment();
 
 	if (mkdir(cgroup_workdir, 0777) && errno != EEXIST) {
 		log_err("mkdir cgroup work dir");
@@ -305,11 +310,26 @@ int join_parent_cgroup(const char *relative_path)
 	return join_cgroup_from_top(cgroup_path);
 }
 
+/**
+ * __cleanup_cgroup_environment() - Delete temporary cgroups
+ *
+ * This is a helper for cleanup_cgroup_environment() that is responsible for
+ * deletion of all temporary cgroups that have been created during the test.
+ */
+static void __cleanup_cgroup_environment(void)
+{
+	char cgroup_workdir[PATH_MAX + 1];
+
+	format_cgroup_path(cgroup_workdir, "");
+	join_cgroup_from_top(CGROUP_MOUNT_PATH);
+	nftw(cgroup_workdir, nftwfunc, WALK_FD_LIMIT, FTW_DEPTH | FTW_MOUNT);
+}
+
 /**
  * cleanup_cgroup_environment() - Cleanup Cgroup Testing Environment
  *
  * This is an idempotent function to delete all temporary cgroups that
- * have been created during the test, including the cgroup testing work
+ * have been created during the test and unmount the cgroup testing work
  * directory.
  *
  * At call time, it moves the calling process to the root cgroup, and then
@@ -320,11 +340,10 @@ int join_parent_cgroup(const char *relative_path)
  */
 void cleanup_cgroup_environment(void)
 {
-	char cgroup_workdir[PATH_MAX + 1];
-
-	format_cgroup_path(cgroup_workdir, "");
-	join_cgroup_from_top(CGROUP_MOUNT_PATH);
-	nftw(cgroup_workdir, nftwfunc, WALK_FD_LIMIT, FTW_DEPTH | FTW_MOUNT);
+	__cleanup_cgroup_environment();
+	if (cgroup_workdir_mounted && umount(CGROUP_MOUNT_PATH))
+		log_err("umount cgroup2");
+	cgroup_workdir_mounted = false;
 }
 
 /**
-- 
2.41.0


