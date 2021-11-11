Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4197E44D1B1
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 06:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhKKFjt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 11 Nov 2021 00:39:49 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28172 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229643AbhKKFjs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 00:39:48 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AB5anZB020691
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 21:37:00 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c8tfegq6n-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 21:36:59 -0800
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 10 Nov 2021 21:36:45 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id E408A8B105F5; Wed, 10 Nov 2021 21:36:39 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 7/9] selftests/bpf: update btf_dump__new() uses to v1.0+ variant
Date:   Wed, 10 Nov 2021 21:36:22 -0800
Message-ID: <20211111053624.190580-8-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211111053624.190580-1-andrii@kernel.org>
References: <20211111053624.190580-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: nYYcxdtDDWL6StNnHwUSmaoolKTL7lUd
X-Proofpoint-ORIG-GUID: nYYcxdtDDWL6StNnHwUSmaoolKTL7lUd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_01,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 spamscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111110029
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update to-be-deprecated forms of btf_dump__new().

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/btf_helpers.c     |  4 +--
 .../selftests/bpf/prog_tests/btf_dump.c       | 33 ++++++++-----------
 .../selftests/bpf/prog_tests/btf_split.c      |  4 +--
 3 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/bpf/btf_helpers.c b/tools/testing/selftests/bpf/btf_helpers.c
index 3d1a748d09d8..acb59202486d 100644
--- a/tools/testing/selftests/bpf/btf_helpers.c
+++ b/tools/testing/selftests/bpf/btf_helpers.c
@@ -238,7 +238,6 @@ const char *btf_type_c_dump(const struct btf *btf)
 	static char buf[16 * 1024];
 	FILE *buf_file;
 	struct btf_dump *d = NULL;
-	struct btf_dump_opts opts = {};
 	int err, i;
 
 	buf_file = fmemopen(buf, sizeof(buf) - 1, "w");
@@ -247,8 +246,7 @@ const char *btf_type_c_dump(const struct btf *btf)
 		return NULL;
 	}
 
-	opts.ctx = buf_file;
-	d = btf_dump__new(btf, NULL, &opts, btf_dump_printf);
+	d = btf_dump__new(btf, btf_dump_printf, buf_file, NULL);
 	if (libbpf_get_error(d)) {
 		fprintf(stderr, "Failed to create btf_dump instance: %ld\n", libbpf_get_error(d));
 		goto err_out;
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index a04961942dfa..d6272013a5a3 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -13,25 +13,23 @@ static struct btf_dump_test_case {
 	const char *name;
 	const char *file;
 	bool known_ptr_sz;
-	struct btf_dump_opts opts;
 } btf_dump_test_cases[] = {
-	{"btf_dump: syntax", "btf_dump_test_case_syntax", true, {}},
-	{"btf_dump: ordering", "btf_dump_test_case_ordering", false, {}},
-	{"btf_dump: padding", "btf_dump_test_case_padding", true, {}},
-	{"btf_dump: packing", "btf_dump_test_case_packing", true, {}},
-	{"btf_dump: bitfields", "btf_dump_test_case_bitfields", true, {}},
-	{"btf_dump: multidim", "btf_dump_test_case_multidim", false, {}},
-	{"btf_dump: namespacing", "btf_dump_test_case_namespacing", false, {}},
+	{"btf_dump: syntax", "btf_dump_test_case_syntax", true},
+	{"btf_dump: ordering", "btf_dump_test_case_ordering", false},
+	{"btf_dump: padding", "btf_dump_test_case_padding", true},
+	{"btf_dump: packing", "btf_dump_test_case_packing", true},
+	{"btf_dump: bitfields", "btf_dump_test_case_bitfields", true},
+	{"btf_dump: multidim", "btf_dump_test_case_multidim", false},
+	{"btf_dump: namespacing", "btf_dump_test_case_namespacing", false},
 };
 
-static int btf_dump_all_types(const struct btf *btf,
-			      const struct btf_dump_opts *opts)
+static int btf_dump_all_types(const struct btf *btf, void *ctx)
 {
 	size_t type_cnt = btf__type_cnt(btf);
 	struct btf_dump *d;
 	int err = 0, id;
 
-	d = btf_dump__new(btf, NULL, opts, btf_dump_printf);
+	d = btf_dump__new(btf, btf_dump_printf, ctx, NULL);
 	err = libbpf_get_error(d);
 	if (err)
 		return err;
@@ -88,8 +86,7 @@ static int test_btf_dump_case(int n, struct btf_dump_test_case *t)
 		goto done;
 	}
 
-	t->opts.ctx = f;
-	err = btf_dump_all_types(btf, &t->opts);
+	err = btf_dump_all_types(btf, f);
 	fclose(f);
 	close(fd);
 	if (CHECK(err, "btf_dump", "failure during C dumping: %d\n", err)) {
@@ -137,7 +134,6 @@ static void test_btf_dump_incremental(void)
 {
 	struct btf *btf = NULL;
 	struct btf_dump *d = NULL;
-	struct btf_dump_opts opts;
 	int id, err, i;
 
 	dump_buf_file = open_memstream(&dump_buf, &dump_buf_sz);
@@ -146,8 +142,7 @@ static void test_btf_dump_incremental(void)
 	btf = btf__new_empty();
 	if (!ASSERT_OK_PTR(btf, "new_empty"))
 		goto err_out;
-	opts.ctx = dump_buf_file;
-	d = btf_dump__new(btf, NULL, &opts, btf_dump_printf);
+	d = btf_dump__new(btf, btf_dump_printf, dump_buf_file, NULL);
 	if (!ASSERT_OK(libbpf_get_error(d), "btf_dump__new"))
 		goto err_out;
 
@@ -815,7 +810,6 @@ static void test_btf_datasec(struct btf *btf, struct btf_dump *d, char *str,
 static void test_btf_dump_datasec_data(char *str)
 {
 	struct btf *btf;
-	struct btf_dump_opts opts = { .ctx = str };
 	char license[4] = "GPL";
 	struct btf_dump *d;
 
@@ -823,7 +817,7 @@ static void test_btf_dump_datasec_data(char *str)
 	if (!ASSERT_OK_PTR(btf, "xdping_kern.o BTF not found"))
 		return;
 
-	d = btf_dump__new(btf, NULL, &opts, btf_dump_snprintf);
+	d = btf_dump__new(btf, btf_dump_snprintf, str, NULL);
 	if (!ASSERT_OK_PTR(d, "could not create BTF dump"))
 		goto out;
 
@@ -837,7 +831,6 @@ static void test_btf_dump_datasec_data(char *str)
 
 void test_btf_dump() {
 	char str[STRSIZE];
-	struct btf_dump_opts opts = { .ctx = str };
 	struct btf_dump *d;
 	struct btf *btf;
 	int i;
@@ -857,7 +850,7 @@ void test_btf_dump() {
 	if (!ASSERT_OK_PTR(btf, "no kernel BTF found"))
 		return;
 
-	d = btf_dump__new(btf, NULL, &opts, btf_dump_snprintf);
+	d = btf_dump__new(btf, btf_dump_snprintf, str, NULL);
 	if (!ASSERT_OK_PTR(d, "could not create BTF dump"))
 		return;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_split.c b/tools/testing/selftests/bpf/prog_tests/btf_split.c
index b1ffe61f2aa9..eef1158676ed 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_split.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_split.c
@@ -13,7 +13,6 @@ static void btf_dump_printf(void *ctx, const char *fmt, va_list args)
 }
 
 void test_btf_split() {
-	struct btf_dump_opts opts;
 	struct btf_dump *d = NULL;
 	const struct btf_type *t;
 	struct btf *btf1, *btf2;
@@ -68,8 +67,7 @@ void test_btf_split() {
 	dump_buf_file = open_memstream(&dump_buf, &dump_buf_sz);
 	if (!ASSERT_OK_PTR(dump_buf_file, "dump_memstream"))
 		return;
-	opts.ctx = dump_buf_file;
-	d = btf_dump__new(btf2, NULL, &opts, btf_dump_printf);
+	d = btf_dump__new(btf2, btf_dump_printf, dump_buf_file, NULL);
 	if (!ASSERT_OK_PTR(d, "btf_dump__new"))
 		goto cleanup;
 	for (i = 1; i < btf__type_cnt(btf2); i++) {
-- 
2.30.2

