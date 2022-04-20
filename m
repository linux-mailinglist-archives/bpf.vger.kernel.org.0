Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A68507D93
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 02:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238670AbiDTAYv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 20:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiDTAYu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 20:24:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E395C2ED7F
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 17:22:03 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23JMJGBK004433
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 17:22:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=YlyPbTKFmz+IwKCev/0pQxbGI0vvS+r/JI5hZuhW+X4=;
 b=PREmwBloURvqo4NIIC2pe1kgW5yPTEVzQaF2VshgjAH7+CAwbC3iHltktEXFoxi6mClK
 RBPEVUJPLBJ8e4JyVKYxb+dmpEJoTHtc3yn/veco+GbXZonmN10nBvlARIUxPJcYHNe1
 cH0UxpvmlA/T0x9K88Xd6LL0n4xb48h0tF8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fj36t1ttb-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 17:22:03 -0700
Received: from twshared13345.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 17:22:02 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id 89FF410F66432; Tue, 19 Apr 2022 17:21:59 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>, Tejun Heo <tj@kernel.org>,
        <kernel-team@fb.com>, Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 2/3] selftests/bpf: Add local_storage exclusive cache test
Date:   Tue, 19 Apr 2022 17:21:42 -0700
Message-ID: <20220420002143.1096548-3-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220420002143.1096548-1-davemarchevsky@fb.com>
References: <20220420002143.1096548-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 3w3NlO_D5ti9wMN-x-fa_COBbNwClLjM
X-Proofpoint-ORIG-GUID: 3w3NlO_D5ti9wMN-x-fa_COBbNwClLjM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-19_08,2022-04-15_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Validate local_storage exclusive caching functionality:

* Adding >BPF_LOCAL_STORAGE_CACHE_SIZE task_storage maps w/
  BPF_LOCAL_STORAGE_FORCE_CACHE results in failure to load program
  as there are free slots to claim.

* Adding BPF_LOCAL_STORAGE_CACHE_SIZE task_storage maps w/ FORCE_CACHE
  succeeds and results in a filled idx_bitmap for the cache. After first
  bpf_task_storage_get call for each map, the map's local storage data
  is in the cache slot. Subsequent bpf_task_storage_get calls to
  non-exclusive-cached maps don't replace exclusive-cached maps.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../test_local_storage_excl_cache.c           |  52 +++++++++
 .../bpf/progs/local_storage_excl_cache.c      | 100 ++++++++++++++++++
 .../bpf/progs/local_storage_excl_cache_fail.c |  36 +++++++
 3 files changed, 188 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_local_sto=
rage_excl_cache.c
 create mode 100644 tools/testing/selftests/bpf/progs/local_storage_excl_=
cache.c
 create mode 100644 tools/testing/selftests/bpf/progs/local_storage_excl_=
cache_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_local_storage_ex=
cl_cache.c b/tools/testing/selftests/bpf/prog_tests/test_local_storage_ex=
cl_cache.c
new file mode 100644
index 000000000000..a3742e69accb
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_local_storage_excl_cach=
e.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bitmap.h>
+#include <test_progs.h>
+
+#include "local_storage_excl_cache.skel.h"
+#include "local_storage_excl_cache_fail.skel.h"
+
+void test_test_local_storage_excl_cache(void)
+{
+	u64 cache_idx_exclusive, cache_idx_exclusive_expected;
+	struct local_storage_excl_cache_fail *skel_fail =3D NULL;
+	struct local_storage_excl_cache *skel =3D NULL;
+	u16 cache_size, i;
+	int err;
+
+	skel_fail =3D local_storage_excl_cache_fail__open_and_load();
+	ASSERT_ERR_PTR(skel_fail, "excl_cache_fail load should fail");
+	local_storage_excl_cache_fail__destroy(skel_fail);
+
+	skel =3D local_storage_excl_cache__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "excl_cache load should succeed"))
+		goto cleanup;
+
+	cache_size =3D skel->data->__BPF_LOCAL_STORAGE_CACHE_SIZE;
+
+	err =3D local_storage_excl_cache__attach(skel);
+	if (!ASSERT_OK(err, "excl_cache__attach"))
+		goto cleanup;
+
+	/* trigger tracepoint */
+	usleep(1);
+	cache_idx_exclusive =3D skel->data->out__cache_bitmap;
+	cache_idx_exclusive_expected =3D 0;
+	for (i =3D 0; i < cache_size; i++)
+		cache_idx_exclusive_expected |=3D (1U << i);
+
+	if (!ASSERT_EQ(cache_idx_exclusive & cache_idx_exclusive_expected,
+		       cache_idx_exclusive_expected, "excl cache bitmap should be full=
"))
+		goto cleanup;
+
+	usleep(1);
+	for (i =3D 0; i < cache_size; i++)
+		if (!ASSERT_EQ(skel->data->out__cache_smaps[i],
+			       skel->data->out__declared_smaps[i],
+			       "cached map not equal"))
+			goto cleanup;
+
+cleanup:
+	local_storage_excl_cache__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/local_storage_excl_cache.c=
 b/tools/testing/selftests/bpf/progs/local_storage_excl_cache.c
new file mode 100644
index 000000000000..003c866c9d0e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/local_storage_excl_cache.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+#define make_task_local_excl_map(name, num) \
+struct { \
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE); \
+	__uint(map_flags, BPF_F_NO_PREALLOC); \
+	__type(key, int); \
+	__type(value, __u32); \
+	__uint(map_extra, BPF_LOCAL_STORAGE_FORCE_CACHE); \
+} name ## num SEC(".maps");
+
+#define make_task_local_map(name, num) \
+struct { \
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE); \
+	__uint(map_flags, BPF_F_NO_PREALLOC); \
+	__type(key, int); \
+	__type(value, __u32); \
+} name ## num SEC(".maps");
+
+#define task_storage_get_excl(map, num) \
+({ \
+	bpf_task_storage_get(&map ## num, task, 0, BPF_LOCAL_STORAGE_GET_F_CREA=
TE); \
+	bpf_probe_read_kernel(&out__cache_smaps[num], \
+			sizeof(void *), \
+			&task->bpf_storage->cache[num]->smap); \
+	out__declared_smaps[num] =3D &map ## num; \
+})
+
+/* must match define in bpf_local_storage.h */
+#define BPF_LOCAL_STORAGE_CACHE_SIZE 16
+
+/* Try adding BPF_LOCAL_STORAGE_CACHE_SIZE task_storage maps w/ exclusiv=
e
+ * cache slot
+ */
+make_task_local_excl_map(task_storage_map, 0);
+make_task_local_excl_map(task_storage_map, 1);
+make_task_local_excl_map(task_storage_map, 2);
+make_task_local_excl_map(task_storage_map, 3);
+make_task_local_excl_map(task_storage_map, 4);
+make_task_local_excl_map(task_storage_map, 5);
+make_task_local_excl_map(task_storage_map, 6);
+make_task_local_excl_map(task_storage_map, 7);
+make_task_local_excl_map(task_storage_map, 8);
+make_task_local_excl_map(task_storage_map, 9);
+make_task_local_excl_map(task_storage_map, 10);
+make_task_local_excl_map(task_storage_map, 11);
+make_task_local_excl_map(task_storage_map, 12);
+make_task_local_excl_map(task_storage_map, 13);
+make_task_local_excl_map(task_storage_map, 14);
+make_task_local_excl_map(task_storage_map, 15);
+
+make_task_local_map(task_storage_map, 16);
+
+extern const void task_cache __ksym;
+__u64 __BPF_LOCAL_STORAGE_CACHE_SIZE =3D BPF_LOCAL_STORAGE_CACHE_SIZE;
+__u64 out__cache_bitmap =3D -1;
+void *out__cache_smaps[BPF_LOCAL_STORAGE_CACHE_SIZE] =3D { (void *)-1 };
+void *out__declared_smaps[BPF_LOCAL_STORAGE_CACHE_SIZE] =3D { (void *)-1=
 };
+
+SEC("raw_tp/sys_enter")
+int handler(const void *ctx)
+{
+	struct task_struct *task =3D bpf_get_current_task_btf();
+	__u32 *ptr;
+
+	bpf_probe_read_kernel(&out__cache_bitmap, sizeof(out__cache_bitmap),
+			      &task_cache +
+			      offsetof(struct bpf_local_storage_cache, idx_exclusive));
+
+	/* Get all BPF_LOCAL_STORAGE_CACHE_SIZE exclusive-cache maps into cache=
,
+	 * and one that shouldn't be cached
+	 */
+	task_storage_get_excl(task_storage_map, 0);
+	task_storage_get_excl(task_storage_map, 1);
+	task_storage_get_excl(task_storage_map, 2);
+	task_storage_get_excl(task_storage_map, 3);
+	task_storage_get_excl(task_storage_map, 4);
+	task_storage_get_excl(task_storage_map, 5);
+	task_storage_get_excl(task_storage_map, 6);
+	task_storage_get_excl(task_storage_map, 7);
+	task_storage_get_excl(task_storage_map, 8);
+	task_storage_get_excl(task_storage_map, 9);
+	task_storage_get_excl(task_storage_map, 10);
+	task_storage_get_excl(task_storage_map, 11);
+	task_storage_get_excl(task_storage_map, 12);
+	task_storage_get_excl(task_storage_map, 13);
+	task_storage_get_excl(task_storage_map, 14);
+	task_storage_get_excl(task_storage_map, 15);
+
+	bpf_task_storage_get(&task_storage_map16, task, 0,
+			     BPF_LOCAL_STORAGE_GET_F_CREATE);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/local_storage_excl_cache_f=
ail.c b/tools/testing/selftests/bpf/progs/local_storage_excl_cache_fail.c
new file mode 100644
index 000000000000..918b8c49da37
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/local_storage_excl_cache_fail.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+#define make_task_local_excl_map(name, num) \
+struct { \
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE); \
+	__uint(map_flags, BPF_F_NO_PREALLOC); \
+	__type(key, int); \
+	__type(value, __u32); \
+	__uint(map_extra, BPF_LOCAL_STORAGE_FORCE_CACHE); \
+} name ## num SEC(".maps");
+
+/* Try adding BPF_LOCAL_STORAGE_CACHE_SIZE+1 task_storage maps w/ exclus=
ive
+ * cache slot */
+make_task_local_excl_map(task_storage_map, 0);
+make_task_local_excl_map(task_storage_map, 1);
+make_task_local_excl_map(task_storage_map, 2);
+make_task_local_excl_map(task_storage_map, 3);
+make_task_local_excl_map(task_storage_map, 4);
+make_task_local_excl_map(task_storage_map, 5);
+make_task_local_excl_map(task_storage_map, 6);
+make_task_local_excl_map(task_storage_map, 7);
+make_task_local_excl_map(task_storage_map, 8);
+make_task_local_excl_map(task_storage_map, 9);
+make_task_local_excl_map(task_storage_map, 10);
+make_task_local_excl_map(task_storage_map, 11);
+make_task_local_excl_map(task_storage_map, 12);
+make_task_local_excl_map(task_storage_map, 13);
+make_task_local_excl_map(task_storage_map, 14);
+make_task_local_excl_map(task_storage_map, 15);
+make_task_local_excl_map(task_storage_map, 16);
--=20
2.30.2

