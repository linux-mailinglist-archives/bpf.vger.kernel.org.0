Return-Path: <bpf+bounces-4788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9663B74F7AB
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 20:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50788281954
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 18:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564621E529;
	Tue, 11 Jul 2023 18:00:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C211E518
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 18:00:04 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A91310D2
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 11:00:03 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BHhfdO018505
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 11:00:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=mvkctxTLmtbzDrs7XXyOf3QyCOSGxvHotv7uF5HfKGM=;
 b=lgtomm0mwNyh39HrX372bTcCNzF4yrGyQgWfkE0yLiBKQ7EcUg5jgFikWaIg9tOPQ+Db
 EwjkjwBqxsQFwbqasFcst/QKfw7Ax2D9LRFCBlFO9o4ovIIRm3yaS1rnTEp6SbxVM5P1
 MSoLzs08Lz7cmcJEQoz6SLaoYe3MdZEhQlU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rs42mkssb-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 11:00:02 -0700
Received: from twshared52232.38.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Jul 2023 10:59:59 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 9974F20EAEED3; Tue, 11 Jul 2023 10:59:50 -0700 (PDT)
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
Subject: [PATCH bpf-next 5/6] selftests/bpf: Disable newly-added 'owner' field test until refcount re-enabled
Date: Tue, 11 Jul 2023 10:59:44 -0700
Message-ID: <20230711175945.3298231-6-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230711175945.3298231-1-davemarchevsky@fb.com>
References: <20230711175945.3298231-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 7rkKmgf9imfkgpLqlxhcNLTobZIgDG9X
X-Proofpoint-ORIG-GUID: 7rkKmgf9imfkgpLqlxhcNLTobZIgDG9X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_10,2023-07-11_01,2023-05-22_02
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The test added in previous patch will fail with bpf_refcount_acquire
disabled. Until all races are fixed and bpf_refcount_acquire is
re-enabled on bpf-next, disable the test so CI doesn't complain.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../bpf/prog_tests/refcounted_kptr.c          | 24 -------------------
 1 file changed, 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c b/t=
ools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
index d6bd5e16e637..f6b446512958 100644
--- a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
@@ -19,28 +19,4 @@ void test_refcounted_kptr_fail(void)
=20
 void test_refcounted_kptr_wrong_owner(void)
 {
-	LIBBPF_OPTS(bpf_test_run_opts, opts,
-		    .data_in =3D &pkt_v4,
-		    .data_size_in =3D sizeof(pkt_v4),
-		    .repeat =3D 1,
-	);
-	struct refcounted_kptr *skel;
-	int ret;
-
-	skel =3D refcounted_kptr__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "refcounted_kptr__open_and_load"))
-		return;
-
-	ret =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.rbtree_wrong=
_owner_remove_fail_a1), &opts);
-	ASSERT_OK(ret, "rbtree_wrong_owner_remove_fail_a1");
-	ASSERT_OK(opts.retval, "rbtree_wrong_owner_remove_fail_a1 retval");
-
-	ret =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.rbtree_wrong=
_owner_remove_fail_b), &opts);
-	ASSERT_OK(ret, "rbtree_wrong_owner_remove_fail_b");
-	ASSERT_OK(opts.retval, "rbtree_wrong_owner_remove_fail_b retval");
-
-	ret =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.rbtree_wrong=
_owner_remove_fail_a2), &opts);
-	ASSERT_OK(ret, "rbtree_wrong_owner_remove_fail_a2");
-	ASSERT_OK(opts.retval, "rbtree_wrong_owner_remove_fail_a2 retval");
-	refcounted_kptr__destroy(skel);
 }
--=20
2.34.1


