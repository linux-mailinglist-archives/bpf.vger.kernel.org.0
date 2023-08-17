Return-Path: <bpf+bounces-8027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1B278014E
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 00:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954882807AF
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 22:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4CB19898;
	Thu, 17 Aug 2023 22:54:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EFDF9D5
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 22:54:37 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97712112
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 15:54:35 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HHmXRW028710
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 15:54:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=arwumQeqmpPVxOx8No4oDGQuUWOJBu5QBBBCtn2FybM=;
 b=iTj8vkSuaWbWKF8P629xAU4WwJGiQiej/QA3WSu2t84EKenN8oLdkl14VchmEJLasl2e
 NJyoMXsrOx0xlBQA7pV/DJAFF3s34vi8wIMLxESUZ4scXz7x9sT8lx6WMe2/8r/5DDUd
 uroxXMr+luqAGmRM98UEE5nPlrB8Mo9qbVU= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3shgk2q9yb-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 15:54:35 -0700
Received: from twshared7236.08.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 17 Aug 2023 15:54:05 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id A2F3E22D020DF; Thu, 17 Aug 2023 15:53:54 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 2/2] selftests/bpf: Add CO-RE relocs kfunc flavors tests
Date: Thu, 17 Aug 2023 15:53:53 -0700
Message-ID: <20230817225353.2570845-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817225353.2570845-1-davemarchevsky@fb.com>
References: <20230817225353.2570845-1-davemarchevsky@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: JV0c7HoYrAQ-mvOyHtE15s67qfTV0pXd
X-Proofpoint-ORIG-GUID: JV0c7HoYrAQ-mvOyHtE15s67qfTV0pXd
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
 definitions=2023-08-17_18,2023-08-17_02,2023-05-22_02
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

v2 -> v3: https://lore.kernel.org/bpf/20230816165813.3718580-2-davemarchevs=
ky@fb.com/
  * Add test demonstrating that resolution success / failure of
    one flavor variant is independent from success / failure of others,
    and that none need succeed (David Vernet)

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../selftests/bpf/prog_tests/task_kfunc.c     |  2 +
 .../selftests/bpf/progs/task_kfunc_success.c  | 51 +++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/te=
sting/selftests/bpf/prog_tests/task_kfunc.c
index 740d5f644b40..d4579f735398 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
@@ -79,6 +79,8 @@ static const char * const success_tests[] =3D {
 	"test_task_from_pid_current",
 	"test_task_from_pid_invalid",
 	"task_kfunc_acquire_trusted_walked",
+	"test_task_kfunc_flavor_relo",
+	"test_task_kfunc_flavor_relo_not_found",
 };
=20
 void test_task_kfunc(void)
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_success.c b/tools=
/testing/selftests/bpf/progs/task_kfunc_success.c
index b09371bba204..70df695312dc 100644
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
@@ -55,6 +62,50 @@ static int test_acquire_release(struct task_struct *task)
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
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_task_kfunc_flavor_relo_not_found, struct task_struct *ta=
sk, u64 clone_flags)
+{
+	/* Neither symbol should successfully resolve.
+	 * Success or failure of one ___flavor should not affect others
+	 */
+	if (bpf_ksym_exists(bpf_task_acquire___two))
+		err =3D 1;
+	else if (bpf_ksym_exists(bpf_task_acquire___three))
+		err =3D 2;
+
+	return 0;
+}
+
 SEC("tp_btf/task_newtask")
 int BPF_PROG(test_task_acquire_release_argument, struct task_struct *task,=
 u64 clone_flags)
 {
--=20
2.34.1


