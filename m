Return-Path: <bpf+bounces-1642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E6E71F861
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 04:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A331C21199
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 02:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F51715CB;
	Fri,  2 Jun 2023 02:27:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DE815A3
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 02:27:11 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C03192
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 19:27:09 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 351Nt5kx020789
	for <bpf@vger.kernel.org>; Thu, 1 Jun 2023 19:27:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=MfdQDA9uhS6eEkZuafW+fI3gyC3ZMjiWPTRJzziSk1E=;
 b=nYjEl2nOY00G5yWQHBg0YZBp11gSOT3HzsLxsmZv/NYBANHQjBxwaJUJ5Xb80US5DeM2
 3KvZTs7jI4hcpwnfiOj7cdYWcX3GEolCSE4GwrhToCBCPLB2nNUBTWHL7Pu69F6um/ne
 PLNCiNTJ02/r5gejqeQMaJGQpJtoCECvka4= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3qxawf46ye-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 01 Jun 2023 19:27:08 -0700
Received: from twshared8528.02.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 19:27:07 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 0B8561EF7C8F9; Thu,  1 Jun 2023 19:26:57 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 9/9] [DONOTAPPLY] Revert "selftests/bpf: Disable newly-added refcounted_kptr_races test"
Date: Thu, 1 Jun 2023 19:26:47 -0700
Message-ID: <20230602022647.1571784-10-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602022647.1571784-1-davemarchevsky@fb.com>
References: <20230602022647.1571784-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: zsKpKc_I5JoUliv9UHykg7KxBaRcMRrg
X-Proofpoint-GUID: zsKpKc_I5JoUliv9UHykg7KxBaRcMRrg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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


