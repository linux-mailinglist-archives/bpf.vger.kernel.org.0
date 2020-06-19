Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881D2201CF2
	for <lists+bpf@lfdr.de>; Fri, 19 Jun 2020 23:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392091AbgFSVMa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jun 2020 17:12:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39696 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393160AbgFSVM3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Jun 2020 17:12:29 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05JKwSFP024890
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 14:12:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=OLANBWsSN66aoQIostAkmvM6prb1nORK2FsIowv0D4Q=;
 b=ZFd4FrdE/ExkvBg4VdUMvOi72H0+ex/2UWSiVvU1RM8C7557YUkC2Bh86P82FBR13gva
 2yvvLfypsVzPycbnWUuQ7rdPV84IuQgM7F5CRqz1qhL6VN6oU26nWjGGQn9GsWE/R8a3
 b2BCpG41akl5xn3QXUNQqFYVQdgq3oIvreY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31rg9k09f8-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 14:12:23 -0700
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 14:12:21 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 255303700BAE; Fri, 19 Jun 2020 14:12:21 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <andriin@fb.com>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 5/5] selftests/bpf: Test access to bpf map pointer
Date:   Fri, 19 Jun 2020 14:11:45 -0700
Message-ID: <139a6a17f8016491e39347849b951525335c6eb4.1592600985.git.rdna@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1592600985.git.rdna@fb.com>
References: <cover.1592600985.git.rdna@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_22:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 cotscore=-2147483648
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=13 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190150
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add selftests to test access to map pointers from bpf program for all
map types except struct_ops (that one would need additional work).

verifier test focuses mostly on scenarios that must be rejected.

prog_tests test focuses on accessing multiple fields both scalar and a
nested struct from bpf program and verifies that those fields have
expected values.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 .../selftests/bpf/prog_tests/map_ptr.c        |  32 +
 .../selftests/bpf/progs/map_ptr_kern.c        | 686 ++++++++++++++++++
 .../testing/selftests/bpf/verifier/map_ptr.c  |  62 ++
 3 files changed, 780 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_ptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_ptr_kern.c
 create mode 100644 tools/testing/selftests/bpf/verifier/map_ptr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/map_ptr.c b/tools/tes=
ting/selftests/bpf/prog_tests/map_ptr.c
new file mode 100644
index 000000000000..c230a573c373
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/map_ptr.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2020 Facebook
+
+#include <test_progs.h>
+#include <network_helpers.h>
+
+#include "map_ptr_kern.skel.h"
+
+void test_map_ptr(void)
+{
+	struct map_ptr_kern *skel;
+	__u32 duration =3D 0, retval;
+	char buf[128];
+	int err;
+
+	skel =3D map_ptr_kern__open_and_load();
+	if (CHECK(!skel, "skel_open_load", "open_load failed\n"))
+		return;
+
+	err =3D bpf_prog_test_run(bpf_program__fd(skel->progs.cg_skb), 1, &pkt_=
v4,
+				sizeof(pkt_v4), buf, NULL, &retval, NULL);
+
+	if (CHECK(err, "test_run", "err=3D%d errno=3D%d\n", err, errno))
+		goto cleanup;
+
+	if (CHECK(!retval, "retval", "retval=3D%d map_type=3D%u line=3D%u\n", r=
etval,
+		  skel->bss->g_map_type, skel->bss->g_line))
+		goto cleanup;
+
+cleanup:
+	map_ptr_kern__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/tes=
ting/selftests/bpf/progs/map_ptr_kern.c
new file mode 100644
index 000000000000..473665cac67e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
@@ -0,0 +1,686 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2020 Facebook
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+#define LOOP_BOUND 0xf
+#define MAX_ENTRIES 8
+#define HALF_ENTRIES (MAX_ENTRIES >> 1)
+
+_Static_assert(MAX_ENTRIES < LOOP_BOUND, "MAX_ENTRIES must be < LOOP_BOU=
ND");
+
+enum bpf_map_type g_map_type =3D BPF_MAP_TYPE_UNSPEC;
+__u32 g_line =3D 0;
+
+#define VERIFY_TYPE(type, func) ({	\
+	g_map_type =3D type;		\
+	if (!func())			\
+		return 0;		\
+})
+
+
+#define VERIFY(expr) ({		\
+	g_line =3D __LINE__;	\
+	if (!(expr))		\
+		return 0;	\
+})
+
+struct bpf_map_memory {
+	__u32 pages;
+} __attribute__((preserve_access_index));
+
+struct bpf_map {
+	enum bpf_map_type map_type;
+	__u32 key_size;
+	__u32 value_size;
+	__u32 max_entries;
+	__u32 id;
+	struct bpf_map_memory memory;
+} __attribute__((preserve_access_index));
+
+static inline int check_bpf_map_fields(struct bpf_map *map, __u32 key_si=
ze,
+				       __u32 value_size, __u32 max_entries)
+{
+	VERIFY(map->map_type =3D=3D g_map_type);
+	VERIFY(map->key_size =3D=3D key_size);
+	VERIFY(map->value_size =3D=3D value_size);
+	VERIFY(map->max_entries =3D=3D max_entries);
+	VERIFY(map->id > 0);
+	VERIFY(map->memory.pages > 0);
+
+	return 1;
+}
+
+static inline int check_bpf_map_ptr(struct bpf_map *indirect,
+				    struct bpf_map *direct)
+{
+	VERIFY(indirect->map_type =3D=3D direct->map_type);
+	VERIFY(indirect->key_size =3D=3D direct->key_size);
+	VERIFY(indirect->value_size =3D=3D direct->value_size);
+	VERIFY(indirect->max_entries =3D=3D direct->max_entries);
+	VERIFY(indirect->id =3D=3D direct->id);
+	VERIFY(indirect->memory.pages =3D=3D direct->memory.pages);
+
+	return 1;
+}
+
+static inline int check(struct bpf_map *indirect, struct bpf_map *direct=
,
+			__u32 key_size, __u32 value_size, __u32 max_entries)
+{
+	VERIFY(check_bpf_map_ptr(indirect, direct));
+	VERIFY(check_bpf_map_fields(indirect, key_size, value_size,
+				    max_entries));
+	return 1;
+}
+
+static inline int check_default(struct bpf_map *indirect,
+				struct bpf_map *direct)
+{
+	VERIFY(check(indirect, direct, sizeof(__u32), sizeof(__u32),
+		     MAX_ENTRIES));
+	return 1;
+}
+
+typedef struct {
+	int counter;
+} atomic_t;
+
+struct bpf_htab {
+	struct bpf_map map;
+	atomic_t count;
+	__u32 n_buckets;
+	__u32 elem_size;
+} __attribute__((preserve_access_index));
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC); /* to test bpf_htab.count */
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, __u32);
+	__type(value, __u32);
+} m_hash SEC(".maps");
+
+static inline int check_hash(void)
+{
+	struct bpf_htab *hash =3D (struct bpf_htab *)&m_hash;
+	struct bpf_map *map =3D (struct bpf_map *)&m_hash;
+	int i;
+
+	VERIFY(check_default(&hash->map, map));
+
+	VERIFY(hash->n_buckets =3D=3D MAX_ENTRIES);
+	VERIFY(hash->elem_size =3D=3D 64);
+
+	VERIFY(hash->count.counter =3D=3D 0);
+	for (i =3D 0; i < HALF_ENTRIES; ++i) {
+		const __u32 key =3D i;
+		const __u32 val =3D 1;
+
+		if (bpf_map_update_elem(hash, &key, &val, 0))
+			return 0;
+	}
+	VERIFY(hash->count.counter =3D=3D HALF_ENTRIES);
+
+	return 1;
+}
+
+struct bpf_array {
+	struct bpf_map map;
+	__u32 elem_size;
+} __attribute__((preserve_access_index));
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, __u32);
+	__type(value, __u32);
+} m_array SEC(".maps");
+
+static inline int check_array(void)
+{
+	struct bpf_array *array =3D (struct bpf_array *)&m_array;
+	struct bpf_map *map =3D (struct bpf_map *)&m_array;
+	int i, n_lookups =3D 0, n_keys =3D 0;
+
+	VERIFY(check_default(&array->map, map));
+
+	VERIFY(array->elem_size =3D=3D 8);
+
+	for (i =3D 0; i < array->map.max_entries && i < LOOP_BOUND; ++i) {
+		const __u32 key =3D i;
+		__u32 *val =3D bpf_map_lookup_elem(array, &key);
+
+		++n_lookups;
+		if (val)
+			++n_keys;
+	}
+
+	VERIFY(n_lookups =3D=3D MAX_ENTRIES);
+	VERIFY(n_keys =3D=3D MAX_ENTRIES);
+
+	return 1;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, __u32);
+	__type(value, __u32);
+} m_prog_array SEC(".maps");
+
+static inline int check_prog_array(void)
+{
+	struct bpf_array *prog_array =3D (struct bpf_array *)&m_prog_array;
+	struct bpf_map *map =3D (struct bpf_map *)&m_prog_array;
+
+	VERIFY(check_default(&prog_array->map, map));
+
+	return 1;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, __u32);
+	__type(value, __u32);
+} m_perf_event_array SEC(".maps");
+
+static inline int check_perf_event_array(void)
+{
+	struct bpf_array *perf_event_array =3D (struct bpf_array *)&m_perf_even=
t_array;
+	struct bpf_map *map =3D (struct bpf_map *)&m_perf_event_array;
+
+	VERIFY(check_default(&perf_event_array->map, map));
+
+	return 1;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_HASH);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, __u32);
+	__type(value, __u32);
+} m_percpu_hash SEC(".maps");
+
+static inline int check_percpu_hash(void)
+{
+	struct bpf_htab *percpu_hash =3D (struct bpf_htab *)&m_percpu_hash;
+	struct bpf_map *map =3D (struct bpf_map *)&m_percpu_hash;
+
+	VERIFY(check_default(&percpu_hash->map, map));
+
+	return 1;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, __u32);
+	__type(value, __u32);
+} m_percpu_array SEC(".maps");
+
+static inline int check_percpu_array(void)
+{
+	struct bpf_array *percpu_array =3D (struct bpf_array *)&m_percpu_array;
+	struct bpf_map *map =3D (struct bpf_map *)&m_percpu_array;
+
+	VERIFY(check_default(&percpu_array->map, map));
+
+	return 1;
+}
+
+struct bpf_stack_map {
+	struct bpf_map map;
+} __attribute__((preserve_access_index));
+
+struct {
+	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, __u32);
+	__type(value, __u64);
+} m_stack_trace SEC(".maps");
+
+static inline int check_stack_trace(void)
+{
+	struct bpf_stack_map *stack_trace =3D
+		(struct bpf_stack_map *)&m_stack_trace;
+	struct bpf_map *map =3D (struct bpf_map *)&m_stack_trace;
+
+	VERIFY(check(&stack_trace->map, map, sizeof(__u32), sizeof(__u64),
+		     MAX_ENTRIES));
+
+	return 1;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_CGROUP_ARRAY);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, __u32);
+	__type(value, __u32);
+} m_cgroup_array SEC(".maps");
+
+static inline int check_cgroup_array(void)
+{
+	struct bpf_array *cgroup_array =3D (struct bpf_array *)&m_cgroup_array;
+	struct bpf_map *map =3D (struct bpf_map *)&m_cgroup_array;
+
+	VERIFY(check_default(&cgroup_array->map, map));
+
+	return 1;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_LRU_HASH);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, __u32);
+	__type(value, __u32);
+} m_lru_hash SEC(".maps");
+
+static inline int check_lru_hash(void)
+{
+	struct bpf_htab *lru_hash =3D (struct bpf_htab *)&m_lru_hash;
+	struct bpf_map *map =3D (struct bpf_map *)&m_lru_hash;
+
+	VERIFY(check_default(&lru_hash->map, map));
+
+	return 1;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_LRU_PERCPU_HASH);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, __u32);
+	__type(value, __u32);
+} m_lru_percpu_hash SEC(".maps");
+
+static inline int check_lru_percpu_hash(void)
+{
+	struct bpf_htab *lru_percpu_hash =3D (struct bpf_htab *)&m_lru_percpu_h=
ash;
+	struct bpf_map *map =3D (struct bpf_map *)&m_lru_percpu_hash;
+
+	VERIFY(check_default(&lru_percpu_hash->map, map));
+
+	return 1;
+}
+
+struct lpm_trie {
+	struct bpf_map map;
+} __attribute__((preserve_access_index));
+
+struct lpm_key {
+	struct bpf_lpm_trie_key trie_key;
+	__u32 data;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_LPM_TRIE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, struct lpm_key);
+	__type(value, __u32);
+} m_lpm_trie SEC(".maps");
+
+static inline int check_lpm_trie(void)
+{
+	struct lpm_trie *lpm_trie =3D (struct lpm_trie *)&m_lpm_trie;
+	struct bpf_map *map =3D (struct bpf_map *)&m_lpm_trie;
+
+	VERIFY(check(&lpm_trie->map, map, sizeof(struct lpm_key), sizeof(__u32)=
,
+		     MAX_ENTRIES));
+
+	return 1;
+}
+
+struct inner_map {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} inner_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, __u32);
+	__type(value, __u32);
+	__array(values, struct {
+		__uint(type, BPF_MAP_TYPE_ARRAY);
+		__uint(max_entries, 1);
+		__type(key, __u32);
+		__type(value, __u32);
+	});
+} m_array_of_maps SEC(".maps") =3D {
+	.values =3D { (void *)&inner_map, 0, 0, 0, 0, 0, 0, 0, 0 },
+};
+
+static inline int check_array_of_maps(void)
+{
+	struct bpf_array *array_of_maps =3D (struct bpf_array *)&m_array_of_map=
s;
+	struct bpf_map *map =3D (struct bpf_map *)&m_array_of_maps;
+
+	VERIFY(check_default(&array_of_maps->map, map));
+
+	return 1;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, __u32);
+	__type(value, __u32);
+	__array(values, struct inner_map);
+} m_hash_of_maps SEC(".maps") =3D {
+	.values =3D {
+		[2] =3D &inner_map,
+	},
+};
+
+static inline int check_hash_of_maps(void)
+{
+	struct bpf_htab *hash_of_maps =3D (struct bpf_htab *)&m_hash_of_maps;
+	struct bpf_map *map =3D (struct bpf_map *)&m_hash_of_maps;
+
+	VERIFY(check_default(&hash_of_maps->map, map));
+
+	return 1;
+}
+
+struct bpf_dtab {
+	struct bpf_map map;
+} __attribute__((preserve_access_index));
+
+struct {
+	__uint(type, BPF_MAP_TYPE_DEVMAP);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, __u32);
+	__type(value, __u32);
+} m_devmap SEC(".maps");
+
+static inline int check_devmap(void)
+{
+	struct bpf_dtab *devmap =3D (struct bpf_dtab *)&m_devmap;
+	struct bpf_map *map =3D (struct bpf_map *)&m_devmap;
+
+	VERIFY(check_default(&devmap->map, map));
+
+	return 1;
+}
+
+struct bpf_stab {
+	struct bpf_map map;
+} __attribute__((preserve_access_index));
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, __u32);
+	__type(value, __u32);
+} m_sockmap SEC(".maps");
+
+static inline int check_sockmap(void)
+{
+	struct bpf_stab *sockmap =3D (struct bpf_stab *)&m_sockmap;
+	struct bpf_map *map =3D (struct bpf_map *)&m_sockmap;
+
+	VERIFY(check_default(&sockmap->map, map));
+
+	return 1;
+}
+
+struct bpf_cpu_map {
+	struct bpf_map map;
+} __attribute__((preserve_access_index));
+
+struct {
+	__uint(type, BPF_MAP_TYPE_CPUMAP);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, __u32);
+	__type(value, __u32);
+} m_cpumap SEC(".maps");
+
+static inline int check_cpumap(void)
+{
+	struct bpf_cpu_map *cpumap =3D (struct bpf_cpu_map *)&m_cpumap;
+	struct bpf_map *map =3D (struct bpf_map *)&m_cpumap;
+
+	VERIFY(check_default(&cpumap->map, map));
+
+	return 1;
+}
+
+struct xsk_map {
+	struct bpf_map map;
+} __attribute__((preserve_access_index));
+
+struct {
+	__uint(type, BPF_MAP_TYPE_XSKMAP);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, __u32);
+	__type(value, __u32);
+} m_xskmap SEC(".maps");
+
+static inline int check_xskmap(void)
+{
+	struct xsk_map *xskmap =3D (struct xsk_map *)&m_xskmap;
+	struct bpf_map *map =3D (struct bpf_map *)&m_xskmap;
+
+	VERIFY(check_default(&xskmap->map, map));
+
+	return 1;
+}
+
+struct bpf_shtab {
+	struct bpf_map map;
+} __attribute__((preserve_access_index));
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKHASH);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, __u32);
+	__type(value, __u32);
+} m_sockhash SEC(".maps");
+
+static inline int check_sockhash(void)
+{
+	struct bpf_shtab *sockhash =3D (struct bpf_shtab *)&m_sockhash;
+	struct bpf_map *map =3D (struct bpf_map *)&m_sockhash;
+
+	VERIFY(check_default(&sockhash->map, map));
+
+	return 1;
+}
+
+struct bpf_cgroup_storage_map {
+	struct bpf_map map;
+} __attribute__((preserve_access_index));
+
+struct {
+	__uint(type, BPF_MAP_TYPE_CGROUP_STORAGE);
+	__type(key, struct bpf_cgroup_storage_key);
+	__type(value, __u32);
+} m_cgroup_storage SEC(".maps");
+
+static inline int check_cgroup_storage(void)
+{
+	struct bpf_cgroup_storage_map *cgroup_storage =3D
+		(struct bpf_cgroup_storage_map *)&m_cgroup_storage;
+	struct bpf_map *map =3D (struct bpf_map *)&m_cgroup_storage;
+
+	VERIFY(check(&cgroup_storage->map, map,
+		     sizeof(struct bpf_cgroup_storage_key), sizeof(__u32), 0));
+
+	return 1;
+}
+
+struct reuseport_array {
+	struct bpf_map map;
+} __attribute__((preserve_access_index));
+
+struct {
+	__uint(type, BPF_MAP_TYPE_REUSEPORT_SOCKARRAY);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, __u32);
+	__type(value, __u32);
+} m_reuseport_sockarray SEC(".maps");
+
+static inline int check_reuseport_sockarray(void)
+{
+	struct reuseport_array *reuseport_sockarray =3D
+		(struct reuseport_array *)&m_reuseport_sockarray;
+	struct bpf_map *map =3D (struct bpf_map *)&m_reuseport_sockarray;
+
+	VERIFY(check_default(&reuseport_sockarray->map, map));
+
+	return 1;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
+	__type(key, struct bpf_cgroup_storage_key);
+	__type(value, __u32);
+} m_percpu_cgroup_storage SEC(".maps");
+
+static inline int check_percpu_cgroup_storage(void)
+{
+	struct bpf_cgroup_storage_map *percpu_cgroup_storage =3D
+		(struct bpf_cgroup_storage_map *)&m_percpu_cgroup_storage;
+	struct bpf_map *map =3D (struct bpf_map *)&m_percpu_cgroup_storage;
+
+	VERIFY(check(&percpu_cgroup_storage->map, map,
+		     sizeof(struct bpf_cgroup_storage_key), sizeof(__u32), 0));
+
+	return 1;
+}
+
+struct bpf_queue_stack {
+	struct bpf_map map;
+} __attribute__((preserve_access_index));
+
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(value, __u32);
+} m_queue SEC(".maps");
+
+static inline int check_queue(void)
+{
+	struct bpf_queue_stack *queue =3D (struct bpf_queue_stack *)&m_queue;
+	struct bpf_map *map =3D (struct bpf_map *)&m_queue;
+
+	VERIFY(check(&queue->map, map, 0, sizeof(__u32), MAX_ENTRIES));
+
+	return 1;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_STACK);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(value, __u32);
+} m_stack SEC(".maps");
+
+static inline int check_stack(void)
+{
+	struct bpf_queue_stack *stack =3D (struct bpf_queue_stack *)&m_stack;
+	struct bpf_map *map =3D (struct bpf_map *)&m_stack;
+
+	VERIFY(check(&stack->map, map, 0, sizeof(__u32), MAX_ENTRIES));
+
+	return 1;
+}
+
+struct bpf_sk_storage_map {
+	struct bpf_map map;
+} __attribute__((preserve_access_index));
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, __u32);
+	__type(value, __u32);
+} m_sk_storage SEC(".maps");
+
+static inline int check_sk_storage(void)
+{
+	struct bpf_sk_storage_map *sk_storage =3D
+		(struct bpf_sk_storage_map *)&m_sk_storage;
+	struct bpf_map *map =3D (struct bpf_map *)&m_sk_storage;
+
+	VERIFY(check(&sk_storage->map, map, sizeof(__u32), sizeof(__u32), 0));
+
+	return 1;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_DEVMAP_HASH);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, __u32);
+	__type(value, __u32);
+} m_devmap_hash SEC(".maps");
+
+static inline int check_devmap_hash(void)
+{
+	struct bpf_dtab *devmap_hash =3D (struct bpf_dtab *)&m_devmap_hash;
+	struct bpf_map *map =3D (struct bpf_map *)&m_devmap_hash;
+
+	VERIFY(check_default(&devmap_hash->map, map));
+
+	return 1;
+}
+
+struct bpf_ringbuf_map {
+	struct bpf_map map;
+} __attribute__((preserve_access_index));
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 1 << 12);
+} m_ringbuf SEC(".maps");
+
+static inline int check_ringbuf(void)
+{
+	struct bpf_ringbuf_map *ringbuf =3D (struct bpf_ringbuf_map *)&m_ringbu=
f;
+	struct bpf_map *map =3D (struct bpf_map *)&m_ringbuf;
+
+	VERIFY(check(&ringbuf->map, map, 0, 0, 1 << 12));
+
+	return 1;
+}
+
+SEC("cgroup_skb/egress")
+int cg_skb(void *ctx)
+{
+	VERIFY_TYPE(BPF_MAP_TYPE_HASH, check_hash);
+	VERIFY_TYPE(BPF_MAP_TYPE_ARRAY, check_array);
+	VERIFY_TYPE(BPF_MAP_TYPE_PROG_ARRAY, check_prog_array);
+	VERIFY_TYPE(BPF_MAP_TYPE_PERF_EVENT_ARRAY, check_perf_event_array);
+	VERIFY_TYPE(BPF_MAP_TYPE_PERCPU_HASH, check_percpu_hash);
+	VERIFY_TYPE(BPF_MAP_TYPE_PERCPU_ARRAY, check_percpu_array);
+	VERIFY_TYPE(BPF_MAP_TYPE_STACK_TRACE, check_stack_trace);
+	VERIFY_TYPE(BPF_MAP_TYPE_CGROUP_ARRAY, check_cgroup_array);
+	VERIFY_TYPE(BPF_MAP_TYPE_LRU_HASH, check_lru_hash);
+	VERIFY_TYPE(BPF_MAP_TYPE_LRU_PERCPU_HASH, check_lru_percpu_hash);
+	VERIFY_TYPE(BPF_MAP_TYPE_LPM_TRIE, check_lpm_trie);
+	VERIFY_TYPE(BPF_MAP_TYPE_ARRAY_OF_MAPS, check_array_of_maps);
+	VERIFY_TYPE(BPF_MAP_TYPE_HASH_OF_MAPS, check_hash_of_maps);
+	VERIFY_TYPE(BPF_MAP_TYPE_DEVMAP, check_devmap);
+	VERIFY_TYPE(BPF_MAP_TYPE_SOCKMAP, check_sockmap);
+	VERIFY_TYPE(BPF_MAP_TYPE_CPUMAP, check_cpumap);
+	VERIFY_TYPE(BPF_MAP_TYPE_XSKMAP, check_xskmap);
+	VERIFY_TYPE(BPF_MAP_TYPE_SOCKHASH, check_sockhash);
+	VERIFY_TYPE(BPF_MAP_TYPE_CGROUP_STORAGE, check_cgroup_storage);
+	VERIFY_TYPE(BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
+		    check_reuseport_sockarray);
+	VERIFY_TYPE(BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
+		    check_percpu_cgroup_storage);
+	VERIFY_TYPE(BPF_MAP_TYPE_QUEUE, check_queue);
+	VERIFY_TYPE(BPF_MAP_TYPE_STACK, check_stack);
+	VERIFY_TYPE(BPF_MAP_TYPE_SK_STORAGE, check_sk_storage);
+	VERIFY_TYPE(BPF_MAP_TYPE_DEVMAP_HASH, check_devmap_hash);
+	VERIFY_TYPE(BPF_MAP_TYPE_RINGBUF, check_ringbuf);
+
+	return 1;
+}
+
+__u32 _version SEC("version") =3D 1;
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/map_ptr.c b/tools/testi=
ng/selftests/bpf/verifier/map_ptr.c
new file mode 100644
index 000000000000..b52209db8250
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/map_ptr.c
@@ -0,0 +1,62 @@
+{
+	"bpf_map_ptr: read with negative offset rejected",
+	.insns =3D {
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, -8),
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b =3D { 1 },
+	.result_unpriv =3D REJECT,
+	.errstr_unpriv =3D "bpf_array access is allowed only to CAP_PERFMON and=
 CAP_SYS_ADMIN",
+	.result =3D REJECT,
+	.errstr =3D "R1 is bpf_array invalid negative access: off=3D-8",
+},
+{
+	"bpf_map_ptr: write rejected",
+	.insns =3D {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b =3D { 3 },
+	.result_unpriv =3D REJECT,
+	.errstr_unpriv =3D "bpf_array access is allowed only to CAP_PERFMON and=
 CAP_SYS_ADMIN",
+	.result =3D REJECT,
+	.errstr =3D "only read from bpf_array is supported",
+},
+{
+	"bpf_map_ptr: read non-existent field rejected",
+	.insns =3D {
+	BPF_MOV64_IMM(BPF_REG_6, 0),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1, 1),
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b =3D { 1 },
+	.result_unpriv =3D REJECT,
+	.errstr_unpriv =3D "bpf_array access is allowed only to CAP_PERFMON and=
 CAP_SYS_ADMIN",
+	.result =3D REJECT,
+	.errstr =3D "cannot access ptr member ops with moff 0 in struct bpf_map=
 with off 1 size 4",
+},
+{
+	"bpf_map_ptr: read ops field accepted",
+	.insns =3D {
+	BPF_MOV64_IMM(BPF_REG_6, 0),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b =3D { 1 },
+	.result_unpriv =3D REJECT,
+	.errstr_unpriv =3D "bpf_array access is allowed only to CAP_PERFMON and=
 CAP_SYS_ADMIN",
+	.result =3D ACCEPT,
+	.retval =3D 1,
+},
--=20
2.24.1

