Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773046F646D
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 07:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjEDFeP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 01:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjEDFeM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 01:34:12 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF24B2128
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 22:34:09 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3440qV83025505
        for <bpf@vger.kernel.org>; Wed, 3 May 2023 22:34:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=MfdQDA9uhS6eEkZuafW+fI3gyC3ZMjiWPTRJzziSk1E=;
 b=C1KmzyTE+wlr2n+vO+p7Lj+xv/rbORl/SpB5q0Fm5RmikpwhaW3zWGLjKqfe9JIISRag
 1b/08M0g6hWpQdwHWtEJs9uiTF64dV46+2YaWj00JQiUESeNEeXNPU0gpC8qu6WQIrYb
 PfZvZ3MdrabvzefWWyhG3iQTuwrQoIwlKKw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qbjd080mx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 22:34:08 -0700
Received: from twshared4902.04.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 3 May 2023 22:34:07 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 11D2D1D7BFC8F; Wed,  3 May 2023 22:33:58 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 9/9] [DONOTAPPLY] Revert "selftests/bpf: Disable newly-added refcounted_kptr_races test"
Date:   Wed, 3 May 2023 22:33:38 -0700
Message-ID: <20230504053338.1778690-10-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230504053338.1778690-1-davemarchevsky@fb.com>
References: <20230504053338.1778690-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: pVd0oLbKZBYlnAhhKNOIf5r7Z0YQZ7U9
X-Proofpoint-ORIG-GUID: pVd0oLbKZBYlnAhhKNOIf5r7Z0YQZ7U9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_02,2023-05-03_01,2023-02-09_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch reverts the previous patch's disabling of
refcounted_kptr_races selftest. It is included with the series so that
BPF CI will be able to run the test. This patch should not be applied -
followups which fix remaining bpf_refcount issues will re-enable this
test.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../bpf/prog_tests/refcounted_kptr.c          | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c b/t=
ools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
index 6a53f304f3e4..e7fcc1dd8864 100644
--- a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
@@ -18,3 +18,103 @@ void test_refcounted_kptr_fail(void)
 {
 	RUN_TESTS(refcounted_kptr_fail);
 }
+
+static void force_cpu(pthread_t thread, int cpunum)
+{
+	cpu_set_t cpuset;
+	int err;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(cpunum, &cpuset);
+	err =3D pthread_setaffinity_np(thread, sizeof(cpuset), &cpuset);
+	if (!ASSERT_OK(err, "pthread_setaffinity_np"))
+		return;
+}
+
+struct refcounted_kptr *skel;
+
+static void *run_unstash_acq_ref(void *unused)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 1,
+	);
+	long ret, unstash_acq_ref_fd;
+	force_cpu(pthread_self(), 1);
+
+	unstash_acq_ref_fd =3D bpf_program__fd(skel->progs.unstash_add_and_acqu=
ire_refcount);
+
+	ret =3D bpf_prog_test_run_opts(unstash_acq_ref_fd, &opts);
+	ASSERT_EQ(opts.retval, 0, "unstash_add_and_acquire_refcount retval");
+	ASSERT_EQ(skel->bss->ref_check_3, 2, "ref_check_3");
+	ASSERT_EQ(skel->bss->ref_check_4, 1, "ref_check_4");
+	ASSERT_EQ(skel->bss->ref_check_5, 0, "ref_check_5");
+	pthread_exit((void *)ret);
+}
+
+void test_refcounted_kptr_races(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 1,
+	);
+	int ref_acq_lock_fd, ref_acq_unlock_fd, rem_node_lock_fd;
+	int add_stash_fd, remove_tree_fd;
+	pthread_t thread_id;
+	int ret;
+
+	force_cpu(pthread_self(), 0);
+	skel =3D refcounted_kptr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "refcounted_kptr__open_and_load"))
+		return;
+
+	add_stash_fd =3D bpf_program__fd(skel->progs.add_refcounted_node_to_tre=
e_and_stash);
+	remove_tree_fd =3D bpf_program__fd(skel->progs.remove_refcounted_node_f=
rom_tree);
+	ref_acq_lock_fd =3D bpf_program__fd(skel->progs.unsafe_ref_acq_lock);
+	ref_acq_unlock_fd =3D bpf_program__fd(skel->progs.unsafe_ref_acq_unlock=
);
+	rem_node_lock_fd =3D bpf_program__fd(skel->progs.unsafe_rem_node_lock);
+
+	ret =3D bpf_prog_test_run_opts(rem_node_lock_fd, &opts);
+	if (!ASSERT_OK(ret, "rem_node_lock"))
+		return;
+
+	ret =3D bpf_prog_test_run_opts(ref_acq_lock_fd, &opts);
+	if (!ASSERT_OK(ret, "ref_acq_lock"))
+		return;
+
+	ret =3D bpf_prog_test_run_opts(add_stash_fd, &opts);
+	if (!ASSERT_OK(ret, "add_stash"))
+		return;
+	if (!ASSERT_OK(opts.retval, "add_stash retval"))
+		return;
+
+	ret =3D pthread_create(&thread_id, NULL, &run_unstash_acq_ref, NULL);
+	if (!ASSERT_OK(ret, "pthread_create"))
+		goto cleanup;
+
+	force_cpu(thread_id, 1);
+
+	/* This program will execute before unstash_acq_ref's refcount_acquire,=
 then
+	 * unstash_acq_ref can proceed after unsafe_unlock
+	 */
+	ret =3D bpf_prog_test_run_opts(remove_tree_fd, &opts);
+	if (!ASSERT_OK(ret, "remove_tree"))
+		goto cleanup;
+
+	ret =3D bpf_prog_test_run_opts(ref_acq_unlock_fd, &opts);
+	if (!ASSERT_OK(ret, "ref_acq_unlock"))
+		goto cleanup;
+
+	ret =3D pthread_join(thread_id, NULL);
+	if (!ASSERT_OK(ret, "pthread_join"))
+		goto cleanup;
+
+	refcounted_kptr__destroy(skel);
+	return;
+cleanup:
+	bpf_prog_test_run_opts(ref_acq_unlock_fd, &opts);
+	refcounted_kptr__destroy(skel);
+	return;
+}
--=20
2.34.1

