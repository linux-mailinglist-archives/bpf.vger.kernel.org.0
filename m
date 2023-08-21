Return-Path: <bpf+bounces-8174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8637830F2
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 21:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2B5280E94
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 19:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EAF1170F;
	Mon, 21 Aug 2023 19:33:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D62E5684
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 19:33:43 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E6811D
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 12:33:42 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 37LIcjRX008198
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 12:33:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=jURb7KFjE82xD7ljOJJzoTDAFfRxsZz0WMDVTQCNlkM=;
 b=IZw9o/u2xJ5h1k49SVtN5KpxkBisdq6pfefbqxsVDLhWBUBPq6H1+58cYyqBMiHue+nB
 yd8ZLyfI6IRtTS4ENq7wQf5Q13NbF4iZAnAoDjOOEbNNmIHXojzbFbrhbRHXL8llTZbu
 5pNgOscRgg4xM8uEE3h+8WDtQRxhZwLp+V8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3sjsdx7ggu-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 12:33:41 -0700
Received: from twshared7236.08.ash8.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 21 Aug 2023 12:33:22 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 342A02302405B; Mon, 21 Aug 2023 12:33:18 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>, <yonghong.song@linux.dev>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 4/7] bpf: Reenable bpf_refcount_acquire
Date: Mon, 21 Aug 2023 12:33:08 -0700
Message-ID: <20230821193311.3290257-5-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821193311.3290257-1-davemarchevsky@fb.com>
References: <20230821193311.3290257-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: TLUyzdpkqldhajpAiGVSbN8V1SwCdXgf
X-Proofpoint-ORIG-GUID: TLUyzdpkqldhajpAiGVSbN8V1SwCdXgf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_08,2023-08-18_01,2023-05-22_02
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c                         |  5 +---
 .../bpf/prog_tests/refcounted_kptr.c          | 26 +++++++++++++++++++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ebc1a44abb33..8db0afa5985c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11223,10 +11223,7 @@ static int check_kfunc_args(struct bpf_verifier_=
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


