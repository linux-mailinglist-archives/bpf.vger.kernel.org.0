Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779936022F4
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 05:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiJRD5M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 17 Oct 2022 23:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiJRD5J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 23:57:09 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF31387F80
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 20:57:07 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 29HNdunO004402
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 20:57:06 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3k9abdxnry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 20:57:06 -0700
Received: from twshared66650.03.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 20:57:03 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 85EB52047203C; Mon, 17 Oct 2022 20:56:54 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/3] libbpf: add non-mmapable data section selftest
Date:   Mon, 17 Oct 2022 20:56:46 -0700
Message-ID: <20221018035646.1294873-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221018035646.1294873-1-andrii@kernel.org>
References: <20221018035646.1294873-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: KNcoZVg7CTHzGrbJ4hDETRM_8PH3xQTz
X-Proofpoint-ORIG-GUID: KNcoZVg7CTHzGrbJ4hDETRM_8PH3xQTz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add non-mmapable data section to test_skeleton selftest and make sure it
really isn't mmapable by trying to mmap() it anyways.

Also make sure that libbpf doesn't report BPF_F_MMAPABLE flag to users.

Additional, some more manual testing was performed that this feature
works as intended.

Looking at created map through bpftool shows that flags passed to kernel are
indeed zero:

  $ bpftool map show
  ...
  1782: array  name .data.non_mmapa  flags 0x0
          key 4B  value 16B  max_entries 1  memlock 4096B
          btf_id 1169
          pids test_progs(8311)
  ...

Checking BTF uploaded to kernel for this map shows that zero_key and
zero_value are indeed marked as static, even though zero_key is actually
original global (but STV_HIDDEN) variable:

  $ bpftool btf dump id 1169
  ...
  [51] VAR 'zero_key' type_id=2, linkage=static
  [52] VAR 'zero_value' type_id=7, linkage=static
  ...
  [62] DATASEC '.data.non_mmapable' size=16 vlen=2
          type_id=51 offset=0 size=4 (VAR 'zero_key')
          type_id=52 offset=4 size=12 (VAR 'zero_value')
  ...

And original BTF does have zero_key marked as linkage=global:

  $ bpftool btf dump file test_skeleton.bpf.linked3.o
  ...
  [51] VAR 'zero_key' type_id=2, linkage=global
  [52] VAR 'zero_value' type_id=7, linkage=static
  ...
  [62] DATASEC '.data.non_mmapable' size=16 vlen=2
          type_id=51 offset=0 size=4 (VAR 'zero_key')
          type_id=52 offset=4 size=12 (VAR 'zero_value')

Bpftool didn't require any changes at all because it checks whether internal
map is mmapable already, but just to double-check generated skeleton, we
see that .data.non_mmapable neither sets mmaped pointer nor has
a corresponding field in the skeleton:

  $ grep non_mmapable test_skeleton.skel.h
                  struct bpf_map *data_non_mmapable;
          s->maps[7].name = ".data.non_mmapable";
          s->maps[7].map = &obj->maps.data_non_mmapable;

But .data.read_mostly has all of those things:

  $ grep read_mostly test_skeleton.skel.h
                  struct bpf_map *data_read_mostly;
          struct test_skeleton__data_read_mostly {
                  int read_mostly_var;
          } *data_read_mostly;
          s->maps[6].name = ".data.read_mostly";
          s->maps[6].map = &obj->maps.data_read_mostly;
          s->maps[6].mmaped = (void **)&obj->data_read_mostly;
          _Static_assert(sizeof(s->data_read_mostly->read_mostly_var) == 4, "unexpected size of 'read_mostly_var'");

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/skeleton.c | 11 ++++++++++-
 .../testing/selftests/bpf/progs/test_skeleton.c | 17 +++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/skeleton.c b/tools/testing/selftests/bpf/prog_tests/skeleton.c
index 99dac5292b41..bc6817aee9aa 100644
--- a/tools/testing/selftests/bpf/prog_tests/skeleton.c
+++ b/tools/testing/selftests/bpf/prog_tests/skeleton.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2019 Facebook */
 
 #include <test_progs.h>
+#include <sys/mman.h>
 
 struct s {
 	int a;
@@ -22,7 +23,8 @@ void test_skeleton(void)
 	struct test_skeleton__kconfig *kcfg;
 	const void *elf_bytes;
 	size_t elf_bytes_sz = 0;
-	int i;
+	void *m;
+	int i, fd;
 
 	skel = test_skeleton__open();
 	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
@@ -124,6 +126,13 @@ void test_skeleton(void)
 
 	ASSERT_EQ(bss->huge_arr[ARRAY_SIZE(bss->huge_arr) - 1], 123, "huge_arr");
 
+	fd = bpf_map__fd(skel->maps.data_non_mmapable);
+	m = mmap(NULL, getpagesize(), PROT_READ, MAP_SHARED, fd, 0);
+	if (!ASSERT_EQ(m, MAP_FAILED, "unexpected_mmap_success"))
+		munmap(m, getpagesize());
+
+	ASSERT_EQ(bpf_map__map_flags(skel->maps.data_non_mmapable), 0, "non_mmap_flags");
+
 	elf_bytes = test_skeleton__elf_bytes(&elf_bytes_sz);
 	ASSERT_OK_PTR(elf_bytes, "elf_bytes");
 	ASSERT_GE(elf_bytes_sz, 0, "elf_bytes_sz");
diff --git a/tools/testing/selftests/bpf/progs/test_skeleton.c b/tools/testing/selftests/bpf/progs/test_skeleton.c
index 1a4e93f6d9df..adece9f91f58 100644
--- a/tools/testing/selftests/bpf/progs/test_skeleton.c
+++ b/tools/testing/selftests/bpf/progs/test_skeleton.c
@@ -53,6 +53,20 @@ int out_mostly_var;
 
 char huge_arr[16 * 1024 * 1024];
 
+/* non-mmapable custom .data section */
+
+struct my_value { int x, y, z; };
+
+__hidden int zero_key SEC(".data.non_mmapable");
+static struct my_value zero_value SEC(".data.non_mmapable");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct my_value);
+	__uint(max_entries, 1);
+} my_map SEC(".maps");
+
 SEC("raw_tp/sys_enter")
 int handler(const void *ctx)
 {
@@ -75,6 +89,9 @@ int handler(const void *ctx)
 
 	huge_arr[sizeof(huge_arr) - 1] = 123;
 
+	/* make sure zero_key and zero_value are not optimized out */
+	bpf_map_update_elem(&my_map, &zero_key, &zero_value, BPF_ANY);
+
 	return 0;
 }
 
-- 
2.30.2

