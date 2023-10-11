Return-Path: <bpf+bounces-11964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 899F07C6067
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 00:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBEA282661
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 22:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F393924A18;
	Wed, 11 Oct 2023 22:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3BC38F
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 22:37:44 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A17E5
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:37:42 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39BLKAsh029918
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:37:41 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 3tnu04d8xp-20
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:37:41 -0700
Received: from twshared40933.03.prn6.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 11 Oct 2023 15:37:40 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 600C239951287; Wed, 11 Oct 2023 15:37:32 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 1/5] selftests/bpf: improve percpu_alloc test robustness
Date: Wed, 11 Oct 2023 15:37:24 -0700
Message-ID: <20231011223728.3188086-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011223728.3188086-1-andrii@kernel.org>
References: <20231011223728.3188086-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: iIjxBSz3x0j4x0vEbc2Rt76pNQlU7WJ_
X-Proofpoint-ORIG-GUID: iIjxBSz3x0j4x0vEbc2Rt76pNQlU7WJ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_18,2023-10-11_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Make these non-serial tests filter BPF programs by intended PID of
a test runner process. This makes it isolated from other parallel tests
that might interfere accidentally.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/percpu_alloc.c      | 3 +++
 tools/testing/selftests/bpf/progs/percpu_alloc_array.c     | 7 +++++++
 .../selftests/bpf/progs/percpu_alloc_cgrp_local_storage.c  | 4 ++++
 3 files changed, 14 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tool=
s/testing/selftests/bpf/prog_tests/percpu_alloc.c
index 9541e9b3a034..343da65864d6 100644
--- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
@@ -19,6 +19,7 @@ static void test_array(void)
 	bpf_program__set_autoload(skel->progs.test_array_map_3, true);
 	bpf_program__set_autoload(skel->progs.test_array_map_4, true);
=20
+	skel->bss->my_pid =3D getpid();
 	skel->rodata->nr_cpus =3D libbpf_num_possible_cpus();
=20
 	err =3D percpu_alloc_array__load(skel);
@@ -51,6 +52,7 @@ static void test_array_sleepable(void)
=20
 	bpf_program__set_autoload(skel->progs.test_array_map_10, true);
=20
+	skel->bss->my_pid =3D getpid();
 	skel->rodata->nr_cpus =3D libbpf_num_possible_cpus();
=20
 	err =3D percpu_alloc_array__load(skel);
@@ -85,6 +87,7 @@ static void test_cgrp_local_storage(void)
 	if (!ASSERT_OK_PTR(skel, "percpu_alloc_cgrp_local_storage__open"))
 		goto close_fd;
=20
+	skel->bss->my_pid =3D getpid();
 	skel->rodata->nr_cpus =3D libbpf_num_possible_cpus();
=20
 	err =3D percpu_alloc_cgrp_local_storage__load(skel);
diff --git a/tools/testing/selftests/bpf/progs/percpu_alloc_array.c b/too=
ls/testing/selftests/bpf/progs/percpu_alloc_array.c
index bbc45346e006..37c2d2608ec0 100644
--- a/tools/testing/selftests/bpf/progs/percpu_alloc_array.c
+++ b/tools/testing/selftests/bpf/progs/percpu_alloc_array.c
@@ -71,6 +71,7 @@ int BPF_PROG(test_array_map_2)
 }
=20
 int cpu0_field_d, sum_field_c;
+int my_pid;
=20
 /* Summarize percpu data */
 SEC("?fentry/bpf_fentry_test3")
@@ -81,6 +82,9 @@ int BPF_PROG(test_array_map_3)
 	struct val_t *v;
 	struct elem *e;
=20
+	if ((bpf_get_current_pid_tgid() >> 32) !=3D my_pid)
+		return 0;
+
 	e =3D bpf_map_lookup_elem(&array, &index);
 	if (!e)
 		return 0;
@@ -130,6 +134,9 @@ int BPF_PROG(test_array_map_10)
 	struct val_t *v;
 	struct elem *e;
=20
+	if ((bpf_get_current_pid_tgid() >> 32) !=3D my_pid)
+		return 0;
+
 	e =3D bpf_map_lookup_elem(&array, &index);
 	if (!e)
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/percpu_alloc_cgrp_local_st=
orage.c b/tools/testing/selftests/bpf/progs/percpu_alloc_cgrp_local_stora=
ge.c
index 1c36a241852c..a2acf9aa6c24 100644
--- a/tools/testing/selftests/bpf/progs/percpu_alloc_cgrp_local_storage.c
+++ b/tools/testing/selftests/bpf/progs/percpu_alloc_cgrp_local_storage.c
@@ -70,6 +70,7 @@ int BPF_PROG(test_cgrp_local_storage_2)
 }
=20
 int cpu0_field_d, sum_field_c;
+int my_pid;
=20
 /* Summarize percpu data collection */
 SEC("fentry/bpf_fentry_test3")
@@ -81,6 +82,9 @@ int BPF_PROG(test_cgrp_local_storage_3)
 	struct elem *e;
 	int i;
=20
+	if ((bpf_get_current_pid_tgid() >> 32) !=3D my_pid)
+		return 0;
+
 	task =3D bpf_get_current_task_btf();
 	e =3D bpf_cgrp_storage_get(&cgrp, task->cgroups->dfl_cgrp, 0, 0);
 	if (!e)
--=20
2.34.1


