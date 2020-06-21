Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CC92028F7
	for <lists+bpf@lfdr.de>; Sun, 21 Jun 2020 07:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbgFUFz0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Jun 2020 01:55:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18060 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729318AbgFUFzZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 21 Jun 2020 01:55:25 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05L5qJbF014730
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 22:55:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=v+dz7xhSejOqZYYwUNCwwDJeqy0RdXIDw+UhnWkRI2I=;
 b=MzA5WMpFDveJ10WJ9ImRy1DiG7uDVld8+5V0SVCJzQ5z0Ak55F7VFAEX8iqHS5SyAoDD
 VBGpXR/btmxOERRvLW+0OakB3DR661oAYP9GbdP4tjLdZKMnir4MBDcCLsqh5JrygEB7
 xE1X5prW5aU5WZpAk5EZvpF953IboWb9gP8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31shrtaaa9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 22:55:25 -0700
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 20 Jun 2020 22:55:23 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 4E9F637052EE; Sat, 20 Jun 2020 22:55:18 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v2 15/15] bpf/selftests: add tcp/udp iterator programs to selftests
Date:   Sat, 20 Jun 2020 22:55:18 -0700
Message-ID: <20200621055518.2630977-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200621055459.2629116-1-yhs@fb.com>
References: <20200621055459.2629116-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-20_16:2020-06-19,2020-06-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=13 bulkscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 mlxlogscore=999 cotscore=-2147483648
 clxscore=1015 mlxscore=0 phishscore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006210047
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Added tcp{4,6} and udp{4,6} bpf programs into test_progs
selftest so that they at least can load successfully.
  $ ./test_progs -n 3
  ...
  #3/7 tcp4:OK
  #3/8 tcp6:OK
  #3/9 udp4:OK
  #3/10 udp6:OK
  ...
  #3 bpf_iter:OK
  Summary: 1/16 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c       | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_iter.c
index 87c29dde1cf9..1e2e0fced6e8 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -6,6 +6,10 @@
 #include "bpf_iter_bpf_map.skel.h"
 #include "bpf_iter_task.skel.h"
 #include "bpf_iter_task_file.skel.h"
+#include "bpf_iter_tcp4.skel.h"
+#include "bpf_iter_tcp6.skel.h"
+#include "bpf_iter_udp4.skel.h"
+#include "bpf_iter_udp6.skel.h"
 #include "bpf_iter_test_kern1.skel.h"
 #include "bpf_iter_test_kern2.skel.h"
 #include "bpf_iter_test_kern3.skel.h"
@@ -120,6 +124,62 @@ static void test_task_file(void)
 	bpf_iter_task_file__destroy(skel);
 }
=20
+static void test_tcp4(void)
+{
+	struct bpf_iter_tcp4 *skel;
+
+	skel =3D bpf_iter_tcp4__open_and_load();
+	if (CHECK(!skel, "bpf_iter_tcp4__open_and_load",
+		  "skeleton open_and_load failed\n"))
+		return;
+
+	do_dummy_read(skel->progs.dump_tcp4);
+
+	bpf_iter_tcp4__destroy(skel);
+}
+
+static void test_tcp6(void)
+{
+	struct bpf_iter_tcp6 *skel;
+
+	skel =3D bpf_iter_tcp6__open_and_load();
+	if (CHECK(!skel, "bpf_iter_tcp6__open_and_load",
+		  "skeleton open_and_load failed\n"))
+		return;
+
+	do_dummy_read(skel->progs.dump_tcp6);
+
+	bpf_iter_tcp6__destroy(skel);
+}
+
+static void test_udp4(void)
+{
+	struct bpf_iter_udp4 *skel;
+
+	skel =3D bpf_iter_udp4__open_and_load();
+	if (CHECK(!skel, "bpf_iter_udp4__open_and_load",
+		  "skeleton open_and_load failed\n"))
+		return;
+
+	do_dummy_read(skel->progs.dump_udp4);
+
+	bpf_iter_udp4__destroy(skel);
+}
+
+static void test_udp6(void)
+{
+	struct bpf_iter_udp6 *skel;
+
+	skel =3D bpf_iter_udp6__open_and_load();
+	if (CHECK(!skel, "bpf_iter_udp6__open_and_load",
+		  "skeleton open_and_load failed\n"))
+		return;
+
+	do_dummy_read(skel->progs.dump_udp6);
+
+	bpf_iter_udp6__destroy(skel);
+}
+
 /* The expected string is less than 16 bytes */
 static int do_read_with_fd(int iter_fd, const char *expected,
 			   bool read_one_char)
@@ -394,6 +454,14 @@ void test_bpf_iter(void)
 		test_task();
 	if (test__start_subtest("task_file"))
 		test_task_file();
+	if (test__start_subtest("tcp4"))
+		test_tcp4();
+	if (test__start_subtest("tcp6"))
+		test_tcp6();
+	if (test__start_subtest("udp4"))
+		test_udp4();
+	if (test__start_subtest("udp6"))
+		test_udp6();
 	if (test__start_subtest("anon"))
 		test_anon_iter(false);
 	if (test__start_subtest("anon-read-one-char"))
--=20
2.24.1

