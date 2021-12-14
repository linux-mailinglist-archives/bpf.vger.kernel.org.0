Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC90474C61
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 20:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237553AbhLNT7Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 14 Dec 2021 14:59:24 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10822 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230188AbhLNT7U (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Dec 2021 14:59:20 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BEIfCK0027602
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 11:59:20 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3cxnt3nj67-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 11:59:20 -0800
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 11:59:18 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 0F5D1D1E09A1; Tue, 14 Dec 2021 11:59:10 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v4 bpf-next 2/2] selftests/bpf: remove explicit setrlimit(RLIMIT_MEMLOCK) in main selftests
Date:   Tue, 14 Dec 2021 11:59:04 -0800
Message-ID: <20211214195904.1785155-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211214195904.1785155-1-andrii@kernel.org>
References: <20211214195904.1785155-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 6u39YKRIqk16n2vRAeH1aZVuI5eIIL5N
X-Proofpoint-GUID: 6u39YKRIqk16n2vRAeH1aZVuI5eIIL5N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_07,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140107
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As libbpf now is able to automatically take care of RLIMIT_MEMLOCK
increase (or skip it altogether on recent enough kernels), remove
explicit setrlimit() invocations in bench, test_maps, test_verifier, and
test_progs.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/bench.c              | 16 ----------------
 tools/testing/selftests/bpf/prog_tests/btf.c     |  1 -
 .../selftests/bpf/prog_tests/select_reuseport.c  |  1 -
 .../testing/selftests/bpf/prog_tests/sk_lookup.c |  1 -
 .../selftests/bpf/prog_tests/sock_fields.c       |  1 -
 tools/testing/selftests/bpf/test_maps.c          |  1 -
 tools/testing/selftests/bpf/test_progs.c         |  2 --
 tools/testing/selftests/bpf/test_verifier.c      |  4 +++-
 8 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index bbb42e2cee0c..f973320e6dbf 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -29,26 +29,10 @@ static int libbpf_print_fn(enum libbpf_print_level level,
 	return vfprintf(stderr, format, args);
 }
 
-static int bump_memlock_rlimit(void)
-{
-	struct rlimit rlim_new = {
-		.rlim_cur	= RLIM_INFINITY,
-		.rlim_max	= RLIM_INFINITY,
-	};
-
-	return setrlimit(RLIMIT_MEMLOCK, &rlim_new);
-}
-
 void setup_libbpf(void)
 {
-	int err;
-
 	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
 	libbpf_set_print(libbpf_print_fn);
-
-	err = bump_memlock_rlimit();
-	if (err)
-		fprintf(stderr, "failed to increase RLIMIT_MEMLOCK: %d", err);
 }
 
 void false_hits_report_progress(int iter, struct bench_res *res, long delta_ns)
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 01b776a7beeb..8ba53acf9eb4 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -22,7 +22,6 @@
 #include <bpf/libbpf.h>
 #include <bpf/btf.h>
 
-#include "bpf_rlimit.h"
 #include "bpf_util.h"
 #include "../test_btf.h"
 #include "test_progs.h"
diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
index 980ac0f2c0bb..1cbd8cd64044 100644
--- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
@@ -18,7 +18,6 @@
 #include <netinet/in.h>
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
-#include "bpf_rlimit.h"
 #include "bpf_util.h"
 
 #include "test_progs.h"
diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index 57846cc7ce36..597d0467a926 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -30,7 +30,6 @@
 #include <bpf/bpf.h>
 
 #include "test_progs.h"
-#include "bpf_rlimit.h"
 #include "bpf_util.h"
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
diff --git a/tools/testing/selftests/bpf/prog_tests/sock_fields.c b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
index fae40db4d81f..9fc040eaa482 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_fields.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
@@ -15,7 +15,6 @@
 #include "network_helpers.h"
 #include "cgroup_helpers.h"
 #include "test_progs.h"
-#include "bpf_rlimit.h"
 #include "test_sock_fields.skel.h"
 
 enum bpf_linum_array_idx {
diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index f4cd658bbe00..50f7e74ca0b9 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -23,7 +23,6 @@
 #include <bpf/libbpf.h>
 
 #include "bpf_util.h"
-#include "bpf_rlimit.h"
 #include "test_maps.h"
 #include "testing_helpers.h"
 
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 296928948bb9..2ecb73a65206 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -4,7 +4,6 @@
 #define _GNU_SOURCE
 #include "test_progs.h"
 #include "cgroup_helpers.h"
-#include "bpf_rlimit.h"
 #include <argp.h>
 #include <pthread.h>
 #include <sched.h>
@@ -1342,7 +1341,6 @@ int main(int argc, char **argv)
 
 	/* Use libbpf 1.0 API mode */
 	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
-
 	libbpf_set_print(libbpf_print_fn);
 
 	srand(time(NULL));
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index ad5d30bafd93..b0bd2a1f6d52 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -41,7 +41,6 @@
 #  define CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS 1
 # endif
 #endif
-#include "bpf_rlimit.h"
 #include "bpf_rand.h"
 #include "bpf_util.h"
 #include "test_btf.h"
@@ -1395,6 +1394,9 @@ int main(int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
+	/* Use libbpf 1.0 API mode */
+	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
+
 	bpf_semi_rand_init();
 	return do_test(unpriv, from, to);
 }
-- 
2.30.2

