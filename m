Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C1D494719
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 07:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbiATGFy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 20 Jan 2022 01:05:54 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19408 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358657AbiATGFy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Jan 2022 01:05:54 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K0eION025021
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 22:05:53 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dpad40cra-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 22:05:53 -0800
Received: from twshared2974.18.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 19 Jan 2022 22:05:51 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id E02A4FB9D57D; Wed, 19 Jan 2022 22:05:48 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 3/4] libbpf: deprecate legacy BPF map definitions
Date:   Wed, 19 Jan 2022 22:05:28 -0800
Message-ID: <20220120060529.1890907-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220120060529.1890907-1-andrii@kernel.org>
References: <20220120060529.1890907-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Inc23IqkgPYLSVTFTihW-Jd2h5FMGRkk
X-Proofpoint-ORIG-GUID: Inc23IqkgPYLSVTFTihW-Jd2h5FMGRkk
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_02,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 mlxlogscore=981
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200030
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Enact deprecation of legacy BPF map definition in SEC("maps") ([0]). For
the definitions themselves introduce LIBBPF_STRICT_MAP_DEFINITIONS flag
for libbpf strict mode. If it is set, error out on any struct
bpf_map_def-based map definition. If not set, libbpf will print out
a warning for each legacy BPF map to raise awareness that it goes away.

For any use of BPF_ANNOTATE_KV_PAIR() macro providing a legacy way to
associate BTF key/value type information with legacy BPF map definition,
warn through libbpf's pr_warn() error message (but don't fail BPF object
open).

BPF-side struct bpf_map_def is marked as deprecated. User-space struct
bpf_map_def has to be used internally in libbpf, so it is left
untouched. It should be enough for bpf_map__def() to be marked
deprecated to raise awareness that it goes away.

bpftool is an interesting case that utilizes libbpf to open BPF ELF
object to generate skeleton. As such, even though bpftool itself uses
full on strict libbpf mode (LIBBPF_STRICT_ALL), it has to relax it a bit
for BPF map definition handling to minimize unnecessary disruptions. So
opt-out of LIBBPF_STRICT_MAP_DEFINITIONS for bpftool. User's code that
will later use generated skeleton will make its own decision whether to
enforce LIBBPF_STRICT_MAP_DEFINITIONS or not.

There are few tests in selftests/bpf that are consciously using legacy
BPF map definitions to test libbpf functionality. For those, temporary
opt out of LIBBPF_STRICT_MAP_DEFINITIONS mode for the duration of those
tests.

  [0] Closes: https://github.com/libbpf/libbpf/issues/272

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/main.c                     | 9 ++++++++-
 tools/lib/bpf/bpf_helpers.h                  | 2 +-
 tools/lib/bpf/libbpf.c                       | 8 ++++++++
 tools/lib/bpf/libbpf_legacy.h                | 5 +++++
 tools/testing/selftests/bpf/prog_tests/btf.c | 4 ++++
 5 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 020e91a542d5..9d01fa9de033 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -478,7 +478,14 @@ int main(int argc, char **argv)
 	}
 
 	if (!legacy_libbpf) {
-		ret = libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
+		enum libbpf_strict_mode mode;
+
+		/* Allow legacy map definitions for skeleton generation.
+		 * It will still be rejected if users use LIBBPF_STRICT_ALL
+		 * mode for loading generated skeleton.
+		 */
+		mode = (__LIBBPF_STRICT_LAST - 1) & ~LIBBPF_STRICT_MAP_DEFINITIONS;
+		ret = libbpf_set_strict_mode(mode);
 		if (ret)
 			p_err("failed to enable libbpf strict mode: %d", ret);
 	}
diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 963b1060d944..44df982d2a5c 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -133,7 +133,7 @@ struct bpf_map_def {
 	unsigned int value_size;
 	unsigned int max_entries;
 	unsigned int map_flags;
-};
+} __attribute__((deprecated("use BTF-defined maps in .maps section")));
 
 enum libbpf_pin_type {
 	LIBBPF_PIN_NONE,
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fdb3536afa7d..fc6d530e20db 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1937,6 +1937,11 @@ static int bpf_object__init_user_maps(struct bpf_object *obj, bool strict)
 	if (obj->efile.maps_shndx < 0)
 		return 0;
 
+	if (libbpf_mode & LIBBPF_STRICT_MAP_DEFINITIONS) {
+		pr_warn("legacy map definitions in SEC(\"maps\") are not supported\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (!symbols)
 		return -EINVAL;
 
@@ -1999,6 +2004,8 @@ static int bpf_object__init_user_maps(struct bpf_object *obj, bool strict)
 			return -LIBBPF_ERRNO__FORMAT;
 		}
 
+		pr_warn("map '%s' (legacy): legacy map definitions are deprecated, use BTF-defined maps instead\n", map_name);
+
 		if (ELF64_ST_BIND(sym->st_info) == STB_LOCAL) {
 			pr_warn("map '%s' (legacy): static maps are not supported\n", map_name);
 			return -ENOTSUP;
@@ -4190,6 +4197,7 @@ static int bpf_map_find_btf_info(struct bpf_object *obj, struct bpf_map *map)
 		return 0;
 
 	if (!bpf_map__is_internal(map)) {
+		pr_warn("Use of BPF_ANNOTATE_KV_PAIR is deprecated, use BTF-defined maps in .maps section instead\n");
 		ret = btf__get_map_kv_tids(obj->btf, map->name, def->key_size,
 					   def->value_size, &key_type_id,
 					   &value_type_id);
diff --git a/tools/lib/bpf/libbpf_legacy.h b/tools/lib/bpf/libbpf_legacy.h
index 79131f761a27..3c2b281c2bc3 100644
--- a/tools/lib/bpf/libbpf_legacy.h
+++ b/tools/lib/bpf/libbpf_legacy.h
@@ -73,6 +73,11 @@ enum libbpf_strict_mode {
 	 * operation.
 	 */
 	LIBBPF_STRICT_AUTO_RLIMIT_MEMLOCK = 0x10,
+	/*
+	 * Error out on any SEC("maps") map definition, which are deprecated
+	 * in favor of BTF-defined map definitions in SEC(".maps").
+	 */
+	LIBBPF_STRICT_MAP_DEFINITIONS = 0x20,
 
 	__LIBBPF_STRICT_LAST,
 };
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 8ba53acf9eb4..14f9b6136794 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4560,6 +4560,8 @@ static void do_test_file(unsigned int test_num)
 	has_btf_ext = btf_ext != NULL;
 	btf_ext__free(btf_ext);
 
+	/* temporary disable LIBBPF_STRICT_MAP_DEFINITIONS to test legacy maps */
+	libbpf_set_strict_mode((__LIBBPF_STRICT_LAST - 1) & ~LIBBPF_STRICT_MAP_DEFINITIONS);
 	obj = bpf_object__open(test->file);
 	err = libbpf_get_error(obj);
 	if (CHECK(err, "obj: %d", err))
@@ -4684,6 +4686,8 @@ static void do_test_file(unsigned int test_num)
 	fprintf(stderr, "OK");
 
 done:
+	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
+
 	btf__free(btf);
 	free(func_info);
 	bpf_object__close(obj);
-- 
2.30.2

