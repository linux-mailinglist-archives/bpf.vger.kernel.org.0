Return-Path: <bpf+bounces-7605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC0077984D
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 22:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58841C2174D
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 20:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C87D2AB50;
	Fri, 11 Aug 2023 20:14:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99D78468
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 20:14:07 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6B130ED
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 13:14:06 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BGMsZk016723
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 13:14:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=/IXfMgkPIbhY1b/mlUShV7LNHaq0AH2p4dmr3OLHeyA=;
 b=Tz7t+G0geHKLKKReVoctDkLYB9jyrncvk4iI7AjfQJFWCIWllTFMDzgK14ORZcFIgIOw
 OJHHpkjNsl2Gue/0pHKwyZr/JiT2DoZdGTTkIWlZodj1qmtu4HiFN2ovDBlHQY3JutrJ
 GQ+py/StVO8MjR0+hH749pIRtfvnTwUgaXQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3sd909huny-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 13:14:05 -0700
Received: from twshared6713.09.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 13:14:03 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id CE8C02282EDF3; Fri, 11 Aug 2023 13:13:57 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo
	<tj@kernel.org>,
        <dvernet@meta.com>, Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add CO-RE relocs kfunc flavors tests
Date: Fri, 11 Aug 2023 13:13:46 -0700
Message-ID: <20230811201346.3240403-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811201346.3240403-1-davemarchevsky@fb.com>
References: <20230811201346.3240403-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: NOq8gPCPVhwRDLI9Q-QsymkJ6LxqBy10
X-Proofpoint-ORIG-GUID: NOq8gPCPVhwRDLI9Q-QsymkJ6LxqBy10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_12,2023-08-10_01,2023-05-22_02
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

  struct task_struct *bpf_task_acquire___two(struct task_struct *p, void =
*ctx)
    * Should fail because there is no two-param bpf_task_acquire

  struct task_struct *bpf_task_acquire___three(void *ctx)
    * Should fail because, despite vmlinux's bpf_task_acquire having one =
param,
      the types don't match

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../selftests/bpf/prog_tests/task_kfunc.c     |  1 +
 .../selftests/bpf/progs/task_kfunc_success.c  | 41 +++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/=
testing/selftests/bpf/prog_tests/task_kfunc.c
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
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_success.c b/too=
ls/testing/selftests/bpf/progs/task_kfunc_success.c
index b09371bba204..33e1eb88874f 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_success.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
@@ -18,6 +18,13 @@ int err, pid;
  */
=20
 struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym __wea=
k;
+
+struct task_struct *bpf_task_acquire___one(struct task_struct *task) __k=
sym __weak;
+/* The two-param bpf_task_acquire doesn't exist */
+struct task_struct *bpf_task_acquire___two(struct task_struct *p, void *=
ctx) __ksym __weak;
+/* Incorrect type for first param */
+struct task_struct *bpf_task_acquire___three(void *ctx) __ksym __weak;
+
 void invalid_kfunc(void) __ksym __weak;
 void bpf_testmod_test_mod_kfunc(int i) __ksym __weak;
=20
@@ -55,6 +62,40 @@ static int test_acquire_release(struct task_struct *ta=
sk)
 	return 0;
 }
=20
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_task_kfunc_flavor_relo, struct task_struct *task, u64 =
clone_flags)
+{
+	struct task_struct *acquired =3D NULL;
+	int fake_ctx =3D 42;
+
+	if (bpf_ksym_exists(bpf_task_acquire___one)) {
+		acquired =3D bpf_task_acquire___one(task);
+	} else if (bpf_ksym_exists(bpf_task_acquire___two)) {
+		/* if verifier's dead code elimination doesn't remove this,
+		 * verification should fail due to return w/o bpf_task_release
+		 */
+		acquired =3D bpf_task_acquire___two(task, &fake_ctx);
+		err =3D 3;
+		return 0;
+	} else if (bpf_ksym_exists(bpf_task_acquire___three)) {
+		/* Here, bpf_object__resolve_ksym_func_btf_id's find_ksym_btf_id
+		 * call will find vmlinux's bpf_task_acquire, but subsequent
+		 * bpf_core_types_are_compat will fail
+		 *
+		 * Should be removed by dead code elimination similar to ___two
+		 */
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
 int BPF_PROG(test_task_acquire_release_argument, struct task_struct *tas=
k, u64 clone_flags)
 {
--=20
2.34.1


