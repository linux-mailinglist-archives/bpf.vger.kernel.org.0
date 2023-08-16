Return-Path: <bpf+bounces-7915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7FA77E717
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 18:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F967281B9B
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 16:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970DD16436;
	Wed, 16 Aug 2023 16:58:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785F010949
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 16:58:27 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFE026AB
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 09:58:25 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GGLirq025704
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 09:58:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Ny/aPnLyHknLajxKPp9MUq/SlXOb+HjKmhDeD8w6UJc=;
 b=k4WztM/i9Ljjr4KBI/aPiwQLLtXj37godYeqKSkGzhNOFm4sPPFcFPa1X+TGpgG1eRNk
 isfbSurXC8p3GVjualaRS1d4AV/vbwUEXQgu5STycg6CvOUnjxw2b5oNQPrspgwNWDor
 7nK7R/6bhv2nAvjUS6pmtFSwxGfR8Q3Lw84= 
Received: from maileast.thefacebook.com ([163.114.130.7])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3sgsw03k85-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 09:58:24 -0700
Received: from twshared0321.02.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 16 Aug 2023 09:58:20 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id A846F22C006DF; Wed, 16 Aug 2023 09:58:14 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Add CO-RE relocs kfunc flavors tests
Date: Wed, 16 Aug 2023 09:58:13 -0700
Message-ID: <20230816165813.3718580-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816165813.3718580-1-davemarchevsky@fb.com>
References: <20230816165813.3718580-1-davemarchevsky@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: KjTy5Fe4jhypF2uZIb5RVqtB-7eT0s4b
X-Proofpoint-ORIG-GUID: KjTy5Fe4jhypF2uZIb5RVqtB-7eT0s4b
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_17,2023-08-15_02,2023-05-22_02
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds selftests that exercise kfunc flavor relocation
functionality added in the previous patch. The actual kfunc defined in
kernel/bpf/helpers.c is

  struct task_struct *bpf_task_acquire(struct task_struct *p)

The following relocation behaviors are checked:

  struct task_struct *bpf_task_acquire___one(struct task_struct *name)
    * Should succeed despite differing param name

  struct task_struct *bpf_task_acquire___two(struct task_struct *p, void *c=
tx)
    * Should fail because there is no two-param bpf_task_acquire

  struct task_struct *bpf_task_acquire___three(void *ctx)
    * Should fail because, despite vmlinux's bpf_task_acquire having one pa=
ram,
      the types don't match

Changelog:
v1 -> v2: https://lore.kernel.org/bpf/20230811201346.3240403-2-davemarchevs=
ky@fb.com/
  * Change comment on bpf_task_acquire___two to more accurately reflect
    that it fails in same codepath as bpf_task_acquire___three, and to
    not mention dead code elimination as thats an implementation detail
    (Yonghong)

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../selftests/bpf/prog_tests/task_kfunc.c     |  1 +
 .../selftests/bpf/progs/task_kfunc_success.c  | 37 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/te=
sting/selftests/bpf/prog_tests/task_kfunc.c
index 740d5f644b40..99abb0350154 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
@@ -79,6 +79,7 @@ static const char * const success_tests[] =3D {
 	"test_task_from_pid_current",
 	"test_task_from_pid_invalid",
 	"task_kfunc_acquire_trusted_walked",
+	"test_task_kfunc_flavor_relo",
 };
=20
 void test_task_kfunc(void)
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_success.c b/tools=
/testing/selftests/bpf/progs/task_kfunc_success.c
index b09371bba204..ffbe3ff72639 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_success.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
@@ -18,6 +18,13 @@ int err, pid;
  */
=20
 struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym __weak;
+
+struct task_struct *bpf_task_acquire___one(struct task_struct *task) __ksy=
m __weak;
+/* The two-param bpf_task_acquire doesn't exist */
+struct task_struct *bpf_task_acquire___two(struct task_struct *p, void *ct=
x) __ksym __weak;
+/* Incorrect type for first param */
+struct task_struct *bpf_task_acquire___three(void *ctx) __ksym __weak;
+
 void invalid_kfunc(void) __ksym __weak;
 void bpf_testmod_test_mod_kfunc(int i) __ksym __weak;
=20
@@ -55,6 +62,36 @@ static int test_acquire_release(struct task_struct *task)
 	return 0;
 }
=20
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_task_kfunc_flavor_relo, struct task_struct *task, u64 cl=
one_flags)
+{
+	struct task_struct *acquired =3D NULL;
+	int fake_ctx =3D 42;
+
+	if (bpf_ksym_exists(bpf_task_acquire___one)) {
+		acquired =3D bpf_task_acquire___one(task);
+	} else if (bpf_ksym_exists(bpf_task_acquire___two)) {
+		/* Here, bpf_object__resolve_ksym_func_btf_id's find_ksym_btf_id
+		 * call will find vmlinux's bpf_task_acquire, but subsequent
+		 * bpf_core_types_are_compat will fail
+		 */
+		acquired =3D bpf_task_acquire___two(task, &fake_ctx);
+		err =3D 3;
+		return 0;
+	} else if (bpf_ksym_exists(bpf_task_acquire___three)) {
+		/* bpf_core_types_are_compat will fail similarly to above case */
+		acquired =3D bpf_task_acquire___three(&fake_ctx);
+		err =3D 4;
+		return 0;
+	}
+
+	if (acquired)
+		bpf_task_release(acquired);
+	else
+		err =3D 5;
+	return 0;
+}
+
 SEC("tp_btf/task_newtask")
 int BPF_PROG(test_task_acquire_release_argument, struct task_struct *task,=
 u64 clone_flags)
 {
--=20
2.34.1


