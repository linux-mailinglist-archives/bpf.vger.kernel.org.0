Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6372B235140
	for <lists+bpf@lfdr.de>; Sat,  1 Aug 2020 10:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgHAIt6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Aug 2020 04:49:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38164 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728585AbgHAIt6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 1 Aug 2020 04:49:58 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0718fBHu018531
        for <bpf@vger.kernel.org>; Sat, 1 Aug 2020 01:49:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=z7vjiGAmkhwUcg5IYNZ76D5TPUyJPfJv4wlpMkbHcUc=;
 b=h6EFg7JwV4Qe3IGjYRDknj85WTv9VzvZnno079iMsQk6UHU0AGGDDLgqoTb8t2dnpMDN
 S1hKMXQ9sbyfKMXy2eBdaJ/alDcUqbbeZwf5hTB7UHOMNjvdqb+mRFiZgpK120tGeaZB
 JubI5kCzG4LraJlGMq9egZ+THrRSq7yX4X0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32m35fg2xx-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2020 01:49:57 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 1 Aug 2020 01:49:55 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id B2CAB62E53CF; Sat,  1 Aug 2020 01:47:31 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>,
        <brouer@redhat.com>, <dlxu@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 4/5] selftests/bpf: move two functions to test_progs.c
Date:   Sat, 1 Aug 2020 01:47:20 -0700
Message-ID: <20200801084721.1812607-5-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200801084721.1812607-1-songliubraving@fb.com>
References: <20200801084721.1812607-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-01_07:2020-07-31,2020-08-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008010067
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move time_get_ns() and get_base_addr() to test_progs.c, so they can be
used in other tests.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 21 -------------
 .../selftests/bpf/prog_tests/test_overhead.c  |  8 -----
 tools/testing/selftests/bpf/test_progs.c      | 30 +++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h      |  2 ++
 4 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tool=
s/testing/selftests/bpf/prog_tests/attach_probe.c
index a0ee87c8e1ea7..3bda8acbbafb5 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -2,27 +2,6 @@
 #include <test_progs.h>
 #include "test_attach_probe.skel.h"
=20
-ssize_t get_base_addr() {
-	size_t start, offset;
-	char buf[256];
-	FILE *f;
-
-	f =3D fopen("/proc/self/maps", "r");
-	if (!f)
-		return -errno;
-
-	while (fscanf(f, "%zx-%*x %s %zx %*[^\n]\n",
-		      &start, buf, &offset) =3D=3D 3) {
-		if (strcmp(buf, "r-xp") =3D=3D 0) {
-			fclose(f);
-			return start - offset;
-		}
-	}
-
-	fclose(f);
-	return -EINVAL;
-}
-
 void test_attach_probe(void)
 {
 	int duration =3D 0;
diff --git a/tools/testing/selftests/bpf/prog_tests/test_overhead.c b/too=
ls/testing/selftests/bpf/prog_tests/test_overhead.c
index 2702df2b23433..3fe32e9357c4b 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_overhead.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_overhead.c
@@ -7,14 +7,6 @@
=20
 #define MAX_CNT 100000
=20
-static __u64 time_get_ns(void)
-{
-	struct timespec ts;
-
-	clock_gettime(CLOCK_MONOTONIC, &ts);
-	return ts.tv_sec * 1000000000ull + ts.tv_nsec;
-}
-
 static int test_task_rename(const char *prog)
 {
 	int i, fd, duration =3D 0, err;
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index b1e4dadacd9b4..c9e6a5ad5b9a4 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -622,6 +622,36 @@ int cd_flavor_subdir(const char *exec_name)
 	return chdir(flavor);
 }
=20
+__u64 time_get_ns(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	return ts.tv_sec * 1000000000ull + ts.tv_nsec;
+}
+
+ssize_t get_base_addr(void)
+{
+	size_t start, offset;
+	char buf[256];
+	FILE *f;
+
+	f =3D fopen("/proc/self/maps", "r");
+	if (!f)
+		return -errno;
+
+	while (fscanf(f, "%zx-%*x %s %zx %*[^\n]\n",
+		      &start, buf, &offset) =3D=3D 3) {
+		if (strcmp(buf, "r-xp") =3D=3D 0) {
+			fclose(f);
+			return start - offset;
+		}
+	}
+
+	fclose(f);
+	return -EINVAL;
+}
+
 #define MAX_BACKTRACE_SZ 128
 void crash_handler(int signum)
 {
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/sel=
ftests/bpf/test_progs.h
index 6e09bf738473e..2d617201024bf 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -91,6 +91,8 @@ extern bool test__start_subtest(const char *name);
 extern void test__skip(void);
 extern void test__fail(void);
 extern int test__join_cgroup(const char *path);
+extern __u64 time_get_ns(void);
+extern ssize_t get_base_addr();
=20
 #define PRINT_FAIL(format...)                                           =
       \
 	({                                                                     =
\
--=20
2.24.1

