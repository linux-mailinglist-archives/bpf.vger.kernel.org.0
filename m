Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B5A43586D
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 03:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhJUBrA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 20 Oct 2021 21:47:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22882 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230286AbhJUBrA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Oct 2021 21:47:00 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KN9oAO030590
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 18:44:45 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3btn2yvjpr-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 18:44:45 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 20 Oct 2021 18:44:43 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 9EFBC6E3E1E2; Wed, 20 Oct 2021 18:44:35 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v2 bpf-next 10/10] selftests/bpf: switch to ".bss"/".rodata"/".data" lookups for internal maps
Date:   Wed, 20 Oct 2021 18:44:04 -0700
Message-ID: <20211021014404.2635234-11-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021014404.2635234-1-andrii@kernel.org>
References: <20211021014404.2635234-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: Ole4E39yIgm8AYs_91a7BO59M573qkjR
X-Proofpoint-ORIG-GUID: Ole4E39yIgm8AYs_91a7BO59M573qkjR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_06,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210008
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Utilize libbpf's feature of allowing to lookup internal maps by their
ELF section names. No need to guess or calculate the exact truncated
prefix taken from the object name.

Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/core_autosize.c  |  2 +-
 tools/testing/selftests/bpf/prog_tests/core_reloc.c   |  2 +-
 tools/testing/selftests/bpf/prog_tests/global_data.c  | 11 +++++++++--
 .../selftests/bpf/prog_tests/global_data_init.c       |  2 +-
 tools/testing/selftests/bpf/prog_tests/kfree_skb.c    |  2 +-
 tools/testing/selftests/bpf/prog_tests/rdonly_maps.c  |  2 +-
 6 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_autosize.c b/tools/testing/selftests/bpf/prog_tests/core_autosize.c
index 3d4b2a358d47..2a0dac6394ef 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_autosize.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_autosize.c
@@ -163,7 +163,7 @@ void test_core_autosize(void)
 
 	usleep(1);
 
-	bss_map = bpf_object__find_map_by_name(skel->obj, "test_cor.bss");
+	bss_map = bpf_object__find_map_by_name(skel->obj, ".bss");
 	if (!ASSERT_OK_PTR(bss_map, "bss_map_find"))
 		goto cleanup;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index 763302e63a29..cc50f8feeca3 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -867,7 +867,7 @@ void test_core_reloc(void)
 			goto cleanup;
 		}
 
-		data_map = bpf_object__find_map_by_name(obj, "test_cor.bss");
+		data_map = bpf_object__find_map_by_name(obj, ".bss");
 		if (CHECK(!data_map, "find_data_map", "data map not found\n"))
 			goto cleanup;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/global_data.c b/tools/testing/selftests/bpf/prog_tests/global_data.c
index 9efa7e50eab2..afd8639f9a94 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data.c
@@ -103,11 +103,18 @@ static void test_global_data_struct(struct bpf_object *obj, __u32 duration)
 static void test_global_data_rdonly(struct bpf_object *obj, __u32 duration)
 {
 	int err = -ENOMEM, map_fd, zero = 0;
-	struct bpf_map *map;
+	struct bpf_map *map, *map2;
 	__u8 *buff;
 
 	map = bpf_object__find_map_by_name(obj, "test_glo.rodata");
-	if (CHECK_FAIL(!map || !bpf_map__is_internal(map)))
+	if (!ASSERT_OK_PTR(map, "map"))
+		return;
+	if (!ASSERT_TRUE(bpf_map__is_internal(map), "is_internal"))
+		return;
+
+	/* ensure we can lookup internal maps by their ELF names */
+	map2 = bpf_object__find_map_by_name(obj, ".rodata");
+	if (!ASSERT_EQ(map, map2, "same_maps"))
 		return;
 
 	map_fd = bpf_map__fd(map);
diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
index ee46b11f1f9a..1db86eab101b 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
@@ -16,7 +16,7 @@ void test_global_data_init(void)
 	if (CHECK_FAIL(err))
 		return;
 
-	map = bpf_object__find_map_by_name(obj, "test_glo.rodata");
+	map = bpf_object__find_map_by_name(obj, ".rodata");
 	if (CHECK_FAIL(!map || !bpf_map__is_internal(map)))
 		goto out;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c b/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
index 032a322d51f2..01e51d16c8b8 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
@@ -93,7 +93,7 @@ void serial_test_kfree_skb(void)
 	if (CHECK(!fexit, "find_prog", "prog eth_type_trans not found\n"))
 		goto close_prog;
 
-	global_data = bpf_object__find_map_by_name(obj2, "kfree_sk.bss");
+	global_data = bpf_object__find_map_by_name(obj2, ".bss");
 	if (CHECK(!global_data, "find global data", "not found\n"))
 		goto close_prog;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/rdonly_maps.c b/tools/testing/selftests/bpf/prog_tests/rdonly_maps.c
index 5f9eaa3ab584..fd5d2ddfb062 100644
--- a/tools/testing/selftests/bpf/prog_tests/rdonly_maps.c
+++ b/tools/testing/selftests/bpf/prog_tests/rdonly_maps.c
@@ -37,7 +37,7 @@ void test_rdonly_maps(void)
 	if (CHECK(err, "obj_load", "err %d errno %d\n", err, errno))
 		goto cleanup;
 
-	bss_map = bpf_object__find_map_by_name(obj, "test_rdo.bss");
+	bss_map = bpf_object__find_map_by_name(obj, ".bss");
 	if (CHECK(!bss_map, "find_bss_map", "failed\n"))
 		goto cleanup;
 
-- 
2.30.2

