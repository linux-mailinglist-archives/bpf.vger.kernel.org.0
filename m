Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3BA46DFBF
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 01:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241557AbhLIAxV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 8 Dec 2021 19:53:21 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21916 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229846AbhLIAxU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Dec 2021 19:53:20 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8Ia2E9029880
        for <bpf@vger.kernel.org>; Wed, 8 Dec 2021 16:49:48 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3ctsbn5wux-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 08 Dec 2021 16:49:48 -0800
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 16:49:46 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id B2101C523FB3; Wed,  8 Dec 2021 16:49:41 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 09/12] selftests/bpf: replace all uses of bpf_load_btf() with bpf_btf_load()
Date:   Wed, 8 Dec 2021 16:49:17 -0800
Message-ID: <20211209004920.4085377-10-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209004920.4085377-1-andrii@kernel.org>
References: <20211209004920.4085377-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: gFe1un9filSE0wrfkUQBhV-WNPLobnb-
X-Proofpoint-ORIG-GUID: gFe1un9filSE0wrfkUQBhV-WNPLobnb-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_08,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 mlxlogscore=866 lowpriorityscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112090002
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Switch all selftests uses of to-be-deprecated bpf_load_btf() with
equivalent bpf_btf_load() calls.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/map_tests/sk_storage_map.c  |  2 +-
 tools/testing/selftests/bpf/prog_tests/btf.c  | 50 +++++++++++--------
 tools/testing/selftests/bpf/test_verifier.c   |  2 +-
 3 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/map_tests/sk_storage_map.c b/tools/testing/selftests/bpf/map_tests/sk_storage_map.c
index 8eea4ffeb092..099eb4dfd4f7 100644
--- a/tools/testing/selftests/bpf/map_tests/sk_storage_map.c
+++ b/tools/testing/selftests/bpf/map_tests/sk_storage_map.c
@@ -136,7 +136,7 @@ static int load_btf(void)
 	memcpy(raw_btf + sizeof(btf_hdr) + sizeof(btf_raw_types),
 	       btf_str_sec, sizeof(btf_str_sec));
 
-	return bpf_load_btf(raw_btf, sizeof(raw_btf), 0, 0, 0);
+	return bpf_btf_load(raw_btf, sizeof(raw_btf), NULL);
 }
 
 static int create_sk_storage_map(void)
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index cab810bab593..01b776a7beeb 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4071,6 +4071,28 @@ static void *btf_raw_create(const struct btf_header *hdr,
 	return raw_btf;
 }
 
+static int load_raw_btf(const void *raw_data, size_t raw_size)
+{
+	LIBBPF_OPTS(bpf_btf_load_opts, opts);
+	int btf_fd;
+
+	if (always_log) {
+		opts.log_buf = btf_log_buf,
+		opts.log_size = BTF_LOG_BUF_SIZE,
+		opts.log_level = 1;
+	}
+
+	btf_fd = bpf_btf_load(raw_data, raw_size, &opts);
+	if (btf_fd < 0 && !always_log) {
+		opts.log_buf = btf_log_buf,
+		opts.log_size = BTF_LOG_BUF_SIZE,
+		opts.log_level = 1;
+		btf_fd = bpf_btf_load(raw_data, raw_size, &opts);
+	}
+
+	return btf_fd;
+}
+
 static void do_test_raw(unsigned int test_num)
 {
 	struct btf_raw_test *test = &raw_tests[test_num - 1];
@@ -4100,16 +4122,14 @@ static void do_test_raw(unsigned int test_num)
 	hdr->str_len = (int)hdr->str_len + test->str_len_delta;
 
 	*btf_log_buf = '\0';
-	btf_fd = bpf_load_btf(raw_btf, raw_btf_size,
-			      btf_log_buf, BTF_LOG_BUF_SIZE,
-			      always_log);
+	btf_fd = load_raw_btf(raw_btf, raw_btf_size);
 	free(raw_btf);
 
 	err = ((btf_fd < 0) != test->btf_load_err);
 	if (CHECK(err, "btf_fd:%d test->btf_load_err:%u",
 		  btf_fd, test->btf_load_err) ||
 	    CHECK(test->err_str && !strstr(btf_log_buf, test->err_str),
-		  "expected err_str:%s", test->err_str)) {
+		  "expected err_str:%s\n", test->err_str)) {
 		err = -1;
 		goto done;
 	}
@@ -4227,9 +4247,7 @@ static int test_big_btf_info(unsigned int test_num)
 		goto done;
 	}
 
-	btf_fd = bpf_load_btf(raw_btf, raw_btf_size,
-			      btf_log_buf, BTF_LOG_BUF_SIZE,
-			      always_log);
+	btf_fd = load_raw_btf(raw_btf, raw_btf_size);
 	if (CHECK(btf_fd < 0, "errno:%d", errno)) {
 		err = -1;
 		goto done;
@@ -4315,9 +4333,7 @@ static int test_btf_id(unsigned int test_num)
 		info[i].btf_size = raw_btf_size;
 	}
 
-	btf_fd[0] = bpf_load_btf(raw_btf, raw_btf_size,
-				 btf_log_buf, BTF_LOG_BUF_SIZE,
-				 always_log);
+	btf_fd[0] = load_raw_btf(raw_btf, raw_btf_size);
 	if (CHECK(btf_fd[0] < 0, "errno:%d", errno)) {
 		err = -1;
 		goto done;
@@ -4447,9 +4463,7 @@ static void do_test_get_info(unsigned int test_num)
 		goto done;
 	}
 
-	btf_fd = bpf_load_btf(raw_btf, raw_btf_size,
-			      btf_log_buf, BTF_LOG_BUF_SIZE,
-			      always_log);
+	btf_fd = load_raw_btf(raw_btf, raw_btf_size);
 	if (CHECK(btf_fd <= 0, "errno:%d", errno)) {
 		err = -1;
 		goto done;
@@ -5169,12 +5183,10 @@ static void do_test_pprint(int test_num)
 		return;
 
 	*btf_log_buf = '\0';
-	btf_fd = bpf_load_btf(raw_btf, raw_btf_size,
-			      btf_log_buf, BTF_LOG_BUF_SIZE,
-			      always_log);
+	btf_fd = load_raw_btf(raw_btf, raw_btf_size);
 	free(raw_btf);
 
-	if (CHECK(btf_fd < 0, "errno:%d", errno)) {
+	if (CHECK(btf_fd < 0, "errno:%d\n", errno)) {
 		err = -1;
 		goto done;
 	}
@@ -6538,9 +6550,7 @@ static void do_test_info_raw(unsigned int test_num)
 		return;
 
 	*btf_log_buf = '\0';
-	btf_fd = bpf_load_btf(raw_btf, raw_btf_size,
-			      btf_log_buf, BTF_LOG_BUF_SIZE,
-			      always_log);
+	btf_fd = load_raw_btf(raw_btf, raw_btf_size);
 	free(raw_btf);
 
 	if (CHECK(btf_fd < 0, "invalid btf_fd errno:%d", errno)) {
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 222cb063ddf4..07b88a8f504f 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -641,7 +641,7 @@ static int load_btf(void)
 	memcpy(ptr, btf_str_sec, hdr.str_len);
 	ptr += hdr.str_len;
 
-	btf_fd = bpf_load_btf(raw_btf, ptr - raw_btf, 0, 0, 0);
+	btf_fd = bpf_btf_load(raw_btf, ptr - raw_btf, NULL);
 	free(raw_btf);
 	if (btf_fd < 0)
 		return -1;
-- 
2.30.2

