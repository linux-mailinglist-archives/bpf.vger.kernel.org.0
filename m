Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CDE64191F
	for <lists+bpf@lfdr.de>; Sat,  3 Dec 2022 21:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiLCUuE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Dec 2022 15:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiLCUuD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 3 Dec 2022 15:50:03 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB00A1B7AC
        for <bpf@vger.kernel.org>; Sat,  3 Dec 2022 12:50:02 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B3ExZH1016520
        for <bpf@vger.kernel.org>; Sat, 3 Dec 2022 12:50:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=H7JhGK/Xxa2E12QZVBil5Z3q+aLNsz+OTaUpWtnTTJw=;
 b=lBNwJrI6sbLi5OCsFt/jElVPLWek8YC7WYuHuePIFx/PQSlkDVIKDw65epANj5/h+zPi
 8K6wu9dAHEEdPjVTQJtO/srp3/ukywfFuEHCax3XHgbWuqZqtJDwMjksSKFXIwNU2V/Q
 FEWVnL0Sl8IlVvoIoHod/V/nCpFPMHAnECo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m84eyaxnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 03 Dec 2022 12:50:02 -0800
Received: from twshared41876.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 3 Dec 2022 12:50:01 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 887261321EFB6; Sat,  3 Dec 2022 12:49:54 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] bpf: Do not mark certain LSM hook arguments as trusted
Date:   Sat, 3 Dec 2022 12:49:54 -0800
Message-ID: <20221203204954.2043348-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: AxevAq2Ut-bvBaANN-sKKOTRAf8ZwwRD
X-Proofpoint-GUID: AxevAq2Ut-bvBaANN-sKKOTRAf8ZwwRD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-03_12,2022-12-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin mentioned that the verifier cannot assume arguments from
LSM hook sk_alloc_security being trusted since after the hook
is called, the sk ref_count is set to 1. This will overwrite
the ref_count changed by the bpf program and may cause ref_count
underflow later on.

I then further checked some other hooks. For example,
for bpf_lsm_file_alloc() hook in fs/file_table.c,

        f->f_cred =3D get_cred(cred);
        error =3D security_file_alloc(f);
        if (unlikely(error)) {
                file_free_rcu(&f->f_rcuhead);
                return ERR_PTR(error);
        }

        atomic_long_set(&f->f_count, 1);

The input parameter 'f' to security_file_alloc() cannot be trusted
as well.

Specifically, I investiaged bpf_map/bpf_prog/file/sk/task alloc/free
lsm hooks. Except bpf_map_alloc and task_alloc, arguments for all other
hooks should not be considered as trusted. This may not be a complete
list, but it covers common usage for sk and task.

Fixes: 3f00c5239344 ("bpf: Allow trusted pointers to be passed to KF_TRUS=
TED_ARGS kfuncs")
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf_lsm.h                          |  6 ++++++
 kernel/bpf/bpf_lsm.c                             | 16 ++++++++++++++++
 kernel/bpf/btf.c                                 |  2 ++
 .../selftests/bpf/prog_tests/task_kfunc.c        |  1 +
 .../selftests/bpf/progs/task_kfunc_failure.c     | 11 +++++++++++
 5 files changed, 36 insertions(+)

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 4bcf76a9bb06..1de7ece5d36d 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -28,6 +28,7 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 			const struct bpf_prog *prog);
=20
 bool bpf_lsm_is_sleepable_hook(u32 btf_id);
+bool bpf_lsm_is_trusted(const struct bpf_prog *prog);
=20
 static inline struct bpf_storage_blob *bpf_inode(
 	const struct inode *inode)
@@ -51,6 +52,11 @@ static inline bool bpf_lsm_is_sleepable_hook(u32 btf_i=
d)
 	return false;
 }
=20
+static inline bool bpf_lsm_is_trusted(const struct bpf_prog *prog)
+{
+	return false;
+}
+
 static inline int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 				      const struct bpf_prog *prog)
 {
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index ae0267f150b5..9ea42a45da47 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -345,11 +345,27 @@ BTF_ID(func, bpf_lsm_task_to_inode)
 BTF_ID(func, bpf_lsm_userns_create)
 BTF_SET_END(sleepable_lsm_hooks)
=20
+BTF_SET_START(untrusted_lsm_hooks)
+BTF_ID(func, bpf_lsm_bpf_map_free_security)
+BTF_ID(func, bpf_lsm_bpf_prog_alloc_security)
+BTF_ID(func, bpf_lsm_bpf_prog_free_security)
+BTF_ID(func, bpf_lsm_file_alloc_security)
+BTF_ID(func, bpf_lsm_file_free_security)
+BTF_ID(func, bpf_lsm_sk_alloc_security)
+BTF_ID(func, bpf_lsm_sk_free_security)
+BTF_ID(func, bpf_lsm_task_free)
+BTF_SET_END(untrusted_lsm_hooks)
+
 bool bpf_lsm_is_sleepable_hook(u32 btf_id)
 {
 	return btf_id_set_contains(&sleepable_lsm_hooks, btf_id);
 }
=20
+bool bpf_lsm_is_trusted(const struct bpf_prog *prog)
+{
+	return !btf_id_set_contains(&untrusted_lsm_hooks, prog->aux->attach_btf=
_id);
+}
+
 const struct bpf_prog_ops lsm_prog_ops =3D {
 };
=20
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index d11cbf8cece7..c80bd8709e69 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -19,6 +19,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
+#include <linux/bpf_lsm.h>
 #include <linux/skmsg.h>
 #include <linux/perf_event.h>
 #include <linux/bsearch.h>
@@ -5829,6 +5830,7 @@ static bool prog_args_trusted(const struct bpf_prog=
 *prog)
 	case BPF_PROG_TYPE_TRACING:
 		return atype =3D=3D BPF_TRACE_RAW_TP || atype =3D=3D BPF_TRACE_ITER;
 	case BPF_PROG_TYPE_LSM:
+		return bpf_lsm_is_trusted(prog);
 	case BPF_PROG_TYPE_STRUCT_OPS:
 		return true;
 	default:
diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/=
testing/selftests/bpf/prog_tests/task_kfunc.c
index ffd8ef4303c8..18848c31e36f 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
@@ -103,6 +103,7 @@ static struct {
 	{"task_kfunc_release_null", "arg#0 is ptr_or_null_ expected ptr_ or soc=
ket"},
 	{"task_kfunc_release_unacquired", "release kernel function bpf_task_rel=
ease expects"},
 	{"task_kfunc_from_pid_no_null_check", "arg#0 is ptr_or_null_ expected p=
tr_ or socket"},
+	{"task_kfunc_from_lsm_task_free", "reg type unsupported for arg#0 funct=
ion"},
 };
=20
 static void verify_fail(const char *prog_name, const char *expected_err_=
msg)
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/too=
ls/testing/selftests/bpf/progs/task_kfunc_failure.c
index e310473190d5..87fa1db9d9b5 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -271,3 +271,14 @@ int BPF_PROG(task_kfunc_from_pid_no_null_check, stru=
ct task_struct *task, u64 cl
=20
 	return 0;
 }
+
+SEC("lsm/task_free")
+int BPF_PROG(task_kfunc_from_lsm_task_free, struct task_struct *task)
+{
+	struct task_struct *acquired;
+
+	/* the argument of lsm task_free hook is untrusted. */
+	acquired =3D bpf_task_acquire(task);
+	bpf_task_release(acquired);
+	return 0;
+}
--=20
2.30.2

