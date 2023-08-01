Return-Path: <bpf+bounces-6616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA56476BE7F
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 22:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D882A1C2108E
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 20:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E93B235A2;
	Tue,  1 Aug 2023 20:36:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A27D4DC94
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 20:36:40 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5241FFD
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 13:36:39 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 371H604v021384
	for <bpf@vger.kernel.org>; Tue, 1 Aug 2023 13:36:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ft3GGhoTmtVMpt8zdYiXACLF1x8JCagOc1+iqszQdTQ=;
 b=UixGkx48fUaYMtGBWjJfPpF7arIfj2GzsxCAIQH39xf5aZssj6JflNQzO8a3RWniIpET
 LC7wvAtzRvxoLVUMT/kzQn8/Ily7aqYHKDU5RIu0I9n1362mE4GNrzFqWU4n4PIJs8wl
 tuWYOYbVBgQoL2QcqlS5MKHx+UGNPMUxjJ0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 3s6nx0gxa5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 13:36:38 -0700
Received: from twshared3345.02.ash8.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 13:36:37 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id BD7E12204867B; Tue,  1 Aug 2023 13:36:34 -0700 (PDT)
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
Subject: [PATCH v1 bpf-next 4/7] bpf: Reenable bpf_refcount_acquire
Date: Tue, 1 Aug 2023 13:36:27 -0700
Message-ID: <20230801203630.3581291-5-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801203630.3581291-1-davemarchevsky@fb.com>
References: <20230801203630.3581291-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 0TvjqJlK93cjvKPJEge2FmLRq2v1FDGo
X-Proofpoint-ORIG-GUID: 0TvjqJlK93cjvKPJEge2FmLRq2v1FDGo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_19,2023-08-01_01,2023-05-22_02
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Now that all reported issues are fixed, bpf_refcount_acquire can be
turned back on. Also reenable all bpf_refcount-related tests which were
disabled.

This a revert of:
 * commit f3514a5d6740 ("selftests/bpf: Disable newly-added 'owner' field=
 test until refcount re-enabled")
 * commit 7deca5eae833 ("bpf: Disable bpf_refcount_acquire kfunc calls un=
til race conditions are fixed")

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/verifier.c                         |  5 +---
 .../bpf/prog_tests/refcounted_kptr.c          | 26 +++++++++++++++++++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ec37e84a11c6..9014b469dd9d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11222,10 +11222,7 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
 				verbose(env, "arg#%d doesn't point to a type with bpf_refcount field=
\n", i);
 				return -EINVAL;
 			}
-			if (rec->refcount_off >=3D 0) {
-				verbose(env, "bpf_refcount_acquire calls are disabled for now\n");
-				return -EINVAL;
-			}
+
 			meta->arg_btf =3D reg->btf;
 			meta->arg_btf_id =3D reg->btf_id;
 			break;
diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c b/t=
ools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
index 7423983472c7..d6bd5e16e637 100644
--- a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
@@ -9,12 +9,38 @@
=20
 void test_refcounted_kptr(void)
 {
+	RUN_TESTS(refcounted_kptr);
 }
=20
 void test_refcounted_kptr_fail(void)
 {
+	RUN_TESTS(refcounted_kptr_fail);
 }
=20
 void test_refcounted_kptr_wrong_owner(void)
 {
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		    .data_in =3D &pkt_v4,
+		    .data_size_in =3D sizeof(pkt_v4),
+		    .repeat =3D 1,
+	);
+	struct refcounted_kptr *skel;
+	int ret;
+
+	skel =3D refcounted_kptr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "refcounted_kptr__open_and_load"))
+		return;
+
+	ret =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.rbtree_wrong=
_owner_remove_fail_a1), &opts);
+	ASSERT_OK(ret, "rbtree_wrong_owner_remove_fail_a1");
+	ASSERT_OK(opts.retval, "rbtree_wrong_owner_remove_fail_a1 retval");
+
+	ret =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.rbtree_wrong=
_owner_remove_fail_b), &opts);
+	ASSERT_OK(ret, "rbtree_wrong_owner_remove_fail_b");
+	ASSERT_OK(opts.retval, "rbtree_wrong_owner_remove_fail_b retval");
+
+	ret =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.rbtree_wrong=
_owner_remove_fail_a2), &opts);
+	ASSERT_OK(ret, "rbtree_wrong_owner_remove_fail_a2");
+	ASSERT_OK(opts.retval, "rbtree_wrong_owner_remove_fail_a2 retval");
+	refcounted_kptr__destroy(skel);
 }
--=20
2.34.1


