Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1C24247F3
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 22:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhJFUdf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 16:33:35 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60972 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229677AbhJFUde (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 16:33:34 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196JvYtG024535
        for <bpf@vger.kernel.org>; Wed, 6 Oct 2021 13:31:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=SsmvSVCwRksvvYFYj73aSiCt87OGqFl2ccOdDkYGmKI=;
 b=Hc+MgMimlcfQCNwPSpLgywBtaoVXzzTV9Bbf6S+d12GGvIxvFGAyXY7O9AUl4AsxH5+m
 qnkM7HPqiYVzsqJz7WJ4ydwoADYNxAbt1C1yo4IDvQtk0YykBwEokC0HusE6/52sqAtD
 lzGW/C+jAf+8oGFAUKvNtDIxKXcF/8gfvkY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bhfhj9vf7-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 13:31:41 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 6 Oct 2021 13:31:39 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 9940A15D85AFD; Wed,  6 Oct 2021 13:31:37 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>
Subject: [PATCH] selftests/bpf: skip get_branch_snapshot in vm
Date:   Wed, 6 Oct 2021 13:31:35 -0700
Message-ID: <20211006203135.2566248-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: nu9p-rteNLSKsIwUh_AVw2tuVGA6YxnQ
X-Proofpoint-GUID: nu9p-rteNLSKsIwUh_AVw2tuVGA6YxnQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=944 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

VMs running on latest kernel support LBR. However, bpf_get_branch_snapsho=
t
couldn't stop the LBR before too many entries are flushed. Skip the test
for VMs before we find a proper fix for VMs.

Read the "flags" line from /proc/cpuinfo, if it contains "hypervisor",
skip test get_branch_snapshot.

Fixes: 025bd7c753aa (selftests/bpf: Add test for bpf_get_branch_snapshot)
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 .../bpf/prog_tests/get_branch_snapshot.c      | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c=
 b/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
index 67e86f8d86775..bf9d47a859449 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
@@ -6,6 +6,30 @@
 static int *pfd_array;
 static int cpu_cnt;
=20
+static bool is_hypervisor(void)
+{
+	char *line =3D NULL;
+	bool ret =3D false;
+	size_t len;
+	FILE *fp;
+
+	fp =3D fopen("/proc/cpuinfo", "r");
+	if (!fp)
+		return false;
+
+	while (getline(&line, &len, fp) !=3D -1) {
+		if (strstr(line, "flags") =3D=3D line) {
+			if (strstr(line, "hypervisor") !=3D NULL)
+				ret =3D true;
+			break;
+		}
+	}
+
+	free(line);
+	fclose(fp);
+	return ret;
+}
+
 static int create_perf_events(void)
 {
 	struct perf_event_attr attr =3D {0};
@@ -54,6 +78,14 @@ void test_get_branch_snapshot(void)
 	struct get_branch_snapshot *skel =3D NULL;
 	int err;
=20
+	if (is_hypervisor()) {
+		/* As of today, LBR in hypervisor cannot be stopped before
+		 * too many entries are flushed. Skip the test for now in
+		 * hypervisor until we optimize the LBR in hypervisor.
+		 */
+		test__skip();
+		return;
+	}
 	if (create_perf_events()) {
 		test__skip();  /* system doesn't support LBR */
 		goto cleanup;
--=20
2.30.2

