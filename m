Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0466DEA97
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 06:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjDLEeA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 12 Apr 2023 00:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjDLEdu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 00:33:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E788559FC
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 21:33:34 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 33BNTGTS027786
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 21:33:34 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3pwf9whthn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 21:33:33 -0700
Received: from twshared15216.17.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 11 Apr 2023 21:33:32 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 783802DCF45B3; Tue, 11 Apr 2023 21:33:29 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kpsingh@kernel.org>, <keescook@chromium.org>,
        <paul@paul-moore.com>
CC:     <linux-security-module@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 8/8] selftests/bpf: enhance lsm_map_create test with BTF LSM control
Date:   Tue, 11 Apr 2023 21:33:00 -0700
Message-ID: <20230412043300.360803-9-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230412043300.360803-1-andrii@kernel.org>
References: <20230412043300.360803-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ipPAalyieVPKzG0C2d6t-lgO855SC2Fo
X-Proofpoint-GUID: ipPAalyieVPKzG0C2d6t-lgO855SC2Fo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adjust and augment lsm_map_create selftest with bpf_btf_load_security
LSM hook and validate that BPF maps that require custom BTF are
succeeding even without privileged, as long as LSM policy allows both
BPF map and BTF object creation.

Further, add another subtest that uses libbpf's BPF skeleton to create
a bunch of maps declaratively. We also add read-only global variable to
validate that BPF_MAP_FREEZE command follows LSM policy as well.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/lsm_map_create.c | 89 ++++++++++++++++---
 tools/testing/selftests/bpf/progs/just_maps.c | 56 ++++++++++++
 .../selftests/bpf/progs/lsm_map_create.c      | 15 ++++
 3 files changed, 148 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/just_maps.c

diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_map_create.c b/tools/testing/selftests/bpf/prog_tests/lsm_map_create.c
index fee78b0448c3..497268d6febd 100644
--- a/tools/testing/selftests/bpf/prog_tests/lsm_map_create.c
+++ b/tools/testing/selftests/bpf/prog_tests/lsm_map_create.c
@@ -5,6 +5,7 @@
 #include <bpf/btf.h>
 #include "cap_helpers.h"
 #include "lsm_map_create.skel.h"
+#include "just_maps.skel.h"
 
 static int drop_priv_caps(__u64 *old_caps)
 {
@@ -19,7 +20,7 @@ static int restore_priv_caps(__u64 old_caps)
 	return cap_enable_effective(old_caps, NULL);
 }
 
-void test_lsm_map_create(void)
+static void subtest_map_create_probes(void)
 {
 	struct btf *btf = NULL;
 	struct lsm_map_create *skel = NULL;
@@ -59,6 +60,7 @@ void test_lsm_map_create(void)
 
 		if (map_type == BPF_MAP_TYPE_UNSPEC)
 			continue;
+		map_type = BPF_MAP_TYPE_SK_STORAGE;
 
 		/* this will show which map type we are working with in verbose log */
 		map_type_name = btf__str_by_offset(btf, e->name_off);
@@ -100,13 +102,6 @@ void test_lsm_map_create(void)
 		ret = libbpf_probe_bpf_map_type(map_type, NULL);
 		ASSERT_EQ(ret, 1, "default_priv_mode");
 
-		/* local storage needs custom BTF to be loaded, which we
-		 * currently can't do once we drop privileges, so skip few
-		 * checks for such maps
-		 */
-		if (needs_btf)
-			goto skip_if_needs_btf;
-
 		/* now let's drop privileges, and chech that unpriv maps are
 		 * still possible to create
 		 */
@@ -114,7 +109,11 @@ void test_lsm_map_create(void)
 			goto cleanup;
 
 		ret = libbpf_probe_bpf_map_type(map_type, NULL);
-		ASSERT_EQ(ret, is_map_priv ? 0 : 1,  "default_unpriv_mode");
+		/* maps that require custom BTF will fail with -EPERM */
+		if (needs_btf)
+			ASSERT_EQ(ret, -EPERM, "default_unpriv_mode");
+		else
+			ASSERT_EQ(ret, is_map_priv ? 0 : 1,  "default_unpriv_mode");
 
 		/* allow any map creation for our thread */
 		skel->bss->decision = 1;
@@ -124,20 +123,86 @@ void test_lsm_map_create(void)
 		/* reject any map creation for our thread */
 		skel->bss->decision = -1;
 		ret = libbpf_probe_bpf_map_type(map_type, NULL);
-		ASSERT_EQ(ret, 0, "lsm_reject_unpriv_mode");
+		/* maps that require custom BTF will fail with -EPERM */
+		if (needs_btf)
+			ASSERT_EQ(ret, -EPERM, "lsm_reject_unpriv_mode");
+		else
+			ASSERT_EQ(ret, 0, "lsm_reject_unpriv_mode");
 
 		/* restore privileges, but keep reject LSM policy */
 		if (!ASSERT_OK(restore_priv_caps(orig_caps), "restore_caps"))
 			goto cleanup;
 
-skip_if_needs_btf:
 		/* even with all caps map create will fail */
 		skel->bss->decision = -1;
 		ret = libbpf_probe_bpf_map_type(map_type, NULL);
-		ASSERT_EQ(ret, 0, "lsm_reject_priv_mode");
+		if (needs_btf)
+			ASSERT_EQ(ret, -EPERM, "lsm_reject_priv_mode");
+		else
+			ASSERT_EQ(ret, 0, "lsm_reject_priv_mode");
 	}
 
 cleanup:
 	btf__free(btf);
 	lsm_map_create__destroy(skel);
 }
+
+static void subtest_map_create_obj(void)
+{
+	struct lsm_map_create *skel = NULL;
+	struct just_maps *maps_skel = NULL;
+	struct bpf_map_info map_info;
+	__u32 map_info_sz = sizeof(map_info);
+	__u64 orig_caps;
+	int err, map_fd;
+
+	skel = lsm_map_create__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	skel->bss->my_tid = syscall(SYS_gettid);
+	skel->bss->decision = 0;
+
+	err = lsm_map_create__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	/* now let's drop privileges, and chech that unpriv maps are
+	 * still possible to create and they do have BTF associated with it
+	 */
+	if (!ASSERT_OK(drop_priv_caps(&orig_caps), "drop_caps"))
+		goto cleanup;
+
+	/* allow unprivileged BPF map and BTF obj creation */
+	skel->bss->decision = 1;
+
+	maps_skel = just_maps__open_and_load();
+	if (!ASSERT_OK_PTR(maps_skel, "maps_skel_open_and_load"))
+		goto restore_caps;
+
+	ASSERT_GT(bpf_object__btf_fd(maps_skel->obj), 0, "maps_btf_fd");
+
+	/* check that SK_LOCAL_STORAGE map has BTF info */
+	map_fd = bpf_map__fd(maps_skel->maps.sk_msg_netns_cookies);
+	memset(&map_info, 0, map_info_sz);
+	err = bpf_map_get_info_by_fd(map_fd, &map_info, &map_info_sz);
+	ASSERT_OK(err, "get_map_info_by_fd");
+
+	ASSERT_GT(map_info.btf_id, 0, "map_btf_id");
+	ASSERT_GT(map_info.btf_key_type_id, 0, "map_btf_key_type_id");
+	ASSERT_GT(map_info.btf_value_type_id, 0, "map_btf_value_type_id");
+
+restore_caps:
+	ASSERT_OK(restore_priv_caps(orig_caps), "restore_caps");
+cleanup:
+	just_maps__destroy(maps_skel);
+	lsm_map_create__destroy(skel);
+}
+
+void test_lsm_map_create(void)
+{
+	if (test__start_subtest("map_create_probes"))
+		subtest_map_create_probes();
+	if (test__start_subtest("map_create_obj"))
+		subtest_map_create_obj();
+}
diff --git a/tools/testing/selftests/bpf/progs/just_maps.c b/tools/testing/selftests/bpf/progs/just_maps.c
new file mode 100644
index 000000000000..9073a51da705
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/just_maps.c
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct array_map {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} array SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+	__array(values, struct array_map);
+} outer_arr SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
+	__uint(max_entries, 5);
+	__type(key, int);
+	__array(values, struct array_map);
+} outer_hash SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_REUSEPORT_SOCKARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} sockarr SEC(".maps");
+
+struct hmap_elem {
+	volatile int cnt;
+	struct bpf_spin_lock lock;
+	int test_padding;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct hmap_elem);
+} hmap SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, int);
+} sk_msg_netns_cookies SEC(".maps");
+
+/* .rodata to test BPF_MAP_FREEZE as well */
+const volatile int some_read_only_variable = 123;
diff --git a/tools/testing/selftests/bpf/progs/lsm_map_create.c b/tools/testing/selftests/bpf/progs/lsm_map_create.c
index 093825c68459..f3c8465c1ed0 100644
--- a/tools/testing/selftests/bpf/progs/lsm_map_create.c
+++ b/tools/testing/selftests/bpf/progs/lsm_map_create.c
@@ -30,3 +30,18 @@ int BPF_PROG(allow_unpriv_maps, union bpf_attr *attr)
 
 	return -EPERM;
 }
+
+SEC("lsm/bpf_btf_load_security")
+int BPF_PROG(allow_unpriv_btf, union bpf_attr *attr)
+{
+	if (!my_tid || (u32)bpf_get_current_pid_tgid() != my_tid)
+		return 0; /* keep processing LSM hooks */
+
+	if (decision == 0)
+		return 0;
+
+	if (decision > 0)
+		return 1; /* allow */
+
+	return -EPERM;
+}
-- 
2.34.1

