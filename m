Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FD96F646E
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 07:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjEDFe2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 01:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjEDFe1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 01:34:27 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCB31BEB
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 22:34:26 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3440qY3w010485
        for <bpf@vger.kernel.org>; Wed, 3 May 2023 22:34:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=XWrSlb+AG1qaHY7bnOaCSLx8bqGpMVGegcEPyDdpsRg=;
 b=RbQwNueuSMDDapeKtppTAjhL3v/gv3r99BTEud1f3mOCk1M2DUEKaJNfAx76vEJhn2uH
 edWcRppmOmdLoTSndoZNvMnEEx3Kkn/pmIhYedT3XYLDQU7ZJCIcECfWl7pRsMfz9cI4
 b7TVilDoIkfWwc7lhjiJIUu4ghQeV8vLLF0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qc1ua9jdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 22:34:25 -0700
Received: from twshared35445.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 3 May 2023 22:34:13 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 28BAA1D7BFC88; Wed,  3 May 2023 22:33:55 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 8/9] selftests/bpf: Disable newly-added refcounted_kptr_races test
Date:   Wed, 3 May 2023 22:33:37 -0700
Message-ID: <20230504053338.1778690-9-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230504053338.1778690-1-davemarchevsky@fb.com>
References: <20230504053338.1778690-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UzeuhV0Kkat3ln9eTV5WGUdavadTRV8v
X-Proofpoint-GUID: UzeuhV0Kkat3ln9eTV5WGUdavadTRV8v
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

The previous patch added a new test exercising a race condition which
was fixed earlier in the series. Similarly to other tests in this file,
the new test should not run while bpf_refcount_acquire is disabled as it
requires that kfunc.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../bpf/prog_tests/refcounted_kptr.c          | 100 ------------------
 1 file changed, 100 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c b/t=
ools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
index e7fcc1dd8864..6a53f304f3e4 100644
--- a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
@@ -18,103 +18,3 @@ void test_refcounted_kptr_fail(void)
 {
 	RUN_TESTS(refcounted_kptr_fail);
 }
-
-static void force_cpu(pthread_t thread, int cpunum)
-{
-	cpu_set_t cpuset;
-	int err;
-
-	CPU_ZERO(&cpuset);
-	CPU_SET(cpunum, &cpuset);
-	err =3D pthread_setaffinity_np(thread, sizeof(cpuset), &cpuset);
-	if (!ASSERT_OK(err, "pthread_setaffinity_np"))
-		return;
-}
-
-struct refcounted_kptr *skel;
-
-static void *run_unstash_acq_ref(void *unused)
-{
-	LIBBPF_OPTS(bpf_test_run_opts, opts,
-		.data_in =3D &pkt_v4,
-		.data_size_in =3D sizeof(pkt_v4),
-		.repeat =3D 1,
-	);
-	long ret, unstash_acq_ref_fd;
-	force_cpu(pthread_self(), 1);
-
-	unstash_acq_ref_fd =3D bpf_program__fd(skel->progs.unstash_add_and_acqu=
ire_refcount);
-
-	ret =3D bpf_prog_test_run_opts(unstash_acq_ref_fd, &opts);
-	ASSERT_EQ(opts.retval, 0, "unstash_add_and_acquire_refcount retval");
-	ASSERT_EQ(skel->bss->ref_check_3, 2, "ref_check_3");
-	ASSERT_EQ(skel->bss->ref_check_4, 1, "ref_check_4");
-	ASSERT_EQ(skel->bss->ref_check_5, 0, "ref_check_5");
-	pthread_exit((void *)ret);
-}
-
-void test_refcounted_kptr_races(void)
-{
-	LIBBPF_OPTS(bpf_test_run_opts, opts,
-		.data_in =3D &pkt_v4,
-		.data_size_in =3D sizeof(pkt_v4),
-		.repeat =3D 1,
-	);
-	int ref_acq_lock_fd, ref_acq_unlock_fd, rem_node_lock_fd;
-	int add_stash_fd, remove_tree_fd;
-	pthread_t thread_id;
-	int ret;
-
-	force_cpu(pthread_self(), 0);
-	skel =3D refcounted_kptr__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "refcounted_kptr__open_and_load"))
-		return;
-
-	add_stash_fd =3D bpf_program__fd(skel->progs.add_refcounted_node_to_tre=
e_and_stash);
-	remove_tree_fd =3D bpf_program__fd(skel->progs.remove_refcounted_node_f=
rom_tree);
-	ref_acq_lock_fd =3D bpf_program__fd(skel->progs.unsafe_ref_acq_lock);
-	ref_acq_unlock_fd =3D bpf_program__fd(skel->progs.unsafe_ref_acq_unlock=
);
-	rem_node_lock_fd =3D bpf_program__fd(skel->progs.unsafe_rem_node_lock);
-
-	ret =3D bpf_prog_test_run_opts(rem_node_lock_fd, &opts);
-	if (!ASSERT_OK(ret, "rem_node_lock"))
-		return;
-
-	ret =3D bpf_prog_test_run_opts(ref_acq_lock_fd, &opts);
-	if (!ASSERT_OK(ret, "ref_acq_lock"))
-		return;
-
-	ret =3D bpf_prog_test_run_opts(add_stash_fd, &opts);
-	if (!ASSERT_OK(ret, "add_stash"))
-		return;
-	if (!ASSERT_OK(opts.retval, "add_stash retval"))
-		return;
-
-	ret =3D pthread_create(&thread_id, NULL, &run_unstash_acq_ref, NULL);
-	if (!ASSERT_OK(ret, "pthread_create"))
-		goto cleanup;
-
-	force_cpu(thread_id, 1);
-
-	/* This program will execute before unstash_acq_ref's refcount_acquire,=
 then
-	 * unstash_acq_ref can proceed after unsafe_unlock
-	 */
-	ret =3D bpf_prog_test_run_opts(remove_tree_fd, &opts);
-	if (!ASSERT_OK(ret, "remove_tree"))
-		goto cleanup;
-
-	ret =3D bpf_prog_test_run_opts(ref_acq_unlock_fd, &opts);
-	if (!ASSERT_OK(ret, "ref_acq_unlock"))
-		goto cleanup;
-
-	ret =3D pthread_join(thread_id, NULL);
-	if (!ASSERT_OK(ret, "pthread_join"))
-		goto cleanup;
-
-	refcounted_kptr__destroy(skel);
-	return;
-cleanup:
-	bpf_prog_test_run_opts(ref_acq_unlock_fd, &opts);
-	refcounted_kptr__destroy(skel);
-	return;
-}
--=20
2.34.1

