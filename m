Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4456371CB
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 06:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiKXFcU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Nov 2022 00:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKXFcS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Nov 2022 00:32:18 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125C3C1F60
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 21:32:17 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2ANHsCUU030197
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 21:32:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=5m/B39cycueel+lTz9FUc9hsDj8KwVE1wLGy8vvMvqY=;
 b=XfVOdot6L6UArgG6L/kUC+aGnS7c9MkINSNsUj6vxiTC2yeVQw9LJlv+xB6sO7CQvMum
 7lL/8Bfy902IZXDcccdfP8cAiY4MssuGdFdjZjyYgijmz4ODr9WXJ1oefb9PLbwa6Mt0
 L/OGh9n21aPp5FWQbyO4cVMvvlAefa+Sp98= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3m1c7rgd4k-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 21:32:17 -0800
Received: from twshared21592.39.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 21:32:14 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id CD11F12A41A27; Wed, 23 Nov 2022 21:32:11 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v10 2/4] bpf: Introduce might_sleep field in bpf_func_proto
Date:   Wed, 23 Nov 2022 21:32:11 -0800
Message-ID: <20221124053211.2373553-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221124053201.2372298-1-yhs@fb.com>
References: <20221124053201.2372298-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ykSrrj5JP00hNQ_klBjfdnZ4j2szPxn1
X-Proofpoint-ORIG-GUID: ykSrrj5JP00hNQ_klBjfdnZ4j2szPxn1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-24_03,2022-11-23_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce bpf_func_proto->might_sleep to indicate a particular helper
might sleep. This will make later check whether a helper might be
sleepable or not easier.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h      | 1 +
 kernel/bpf/bpf_lsm.c     | 6 ++++--
 kernel/bpf/helpers.c     | 2 ++
 kernel/bpf/verifier.c    | 5 +++++
 kernel/trace/bpf_trace.c | 4 ++--
 5 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c9eafa67f2a2..43fd7eeeeabb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -682,6 +682,7 @@ struct bpf_func_proto {
 	u64 (*func)(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 	bool gpl_only;
 	bool pkt_access;
+	bool might_sleep;
 	enum bpf_return_type ret_type;
 	union {
 		struct {
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index d6c9b3705f24..ae0267f150b5 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -151,6 +151,7 @@ BTF_ID_LIST_SINGLE(bpf_ima_inode_hash_btf_ids, struct=
, inode)
 static const struct bpf_func_proto bpf_ima_inode_hash_proto =3D {
 	.func		=3D bpf_ima_inode_hash,
 	.gpl_only	=3D false,
+	.might_sleep	=3D true,
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	=3D &bpf_ima_inode_hash_btf_ids[0],
@@ -169,6 +170,7 @@ BTF_ID_LIST_SINGLE(bpf_ima_file_hash_btf_ids, struct,=
 file)
 static const struct bpf_func_proto bpf_ima_file_hash_proto =3D {
 	.func		=3D bpf_ima_file_hash,
 	.gpl_only	=3D false,
+	.might_sleep	=3D true,
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	=3D &bpf_ima_file_hash_btf_ids[0],
@@ -221,9 +223,9 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const st=
ruct bpf_prog *prog)
 	case BPF_FUNC_bprm_opts_set:
 		return &bpf_bprm_opts_set_proto;
 	case BPF_FUNC_ima_inode_hash:
-		return prog->aux->sleepable ? &bpf_ima_inode_hash_proto : NULL;
+		return &bpf_ima_inode_hash_proto;
 	case BPF_FUNC_ima_file_hash:
-		return prog->aux->sleepable ? &bpf_ima_file_hash_proto : NULL;
+		return &bpf_ima_file_hash_proto;
 	case BPF_FUNC_get_attach_cookie:
 		return bpf_prog_has_trampoline(prog) ? &bpf_get_attach_cookie_proto : =
NULL;
 #ifdef CONFIG_NET
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 2299bb0d89e5..9296b654dbd7 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -661,6 +661,7 @@ BPF_CALL_3(bpf_copy_from_user, void *, dst, u32, size=
,
 const struct bpf_func_proto bpf_copy_from_user_proto =3D {
 	.func		=3D bpf_copy_from_user,
 	.gpl_only	=3D false,
+	.might_sleep	=3D true,
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_PTR_TO_UNINIT_MEM,
 	.arg2_type	=3D ARG_CONST_SIZE_OR_ZERO,
@@ -691,6 +692,7 @@ BPF_CALL_5(bpf_copy_from_user_task, void *, dst, u32,=
 size,
 const struct bpf_func_proto bpf_copy_from_user_task_proto =3D {
 	.func		=3D bpf_copy_from_user_task,
 	.gpl_only	=3D true,
+	.might_sleep	=3D true,
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_PTR_TO_UNINIT_MEM,
 	.arg2_type	=3D ARG_CONST_SIZE_OR_ZERO,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9528a066cfa5..068cc885903c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7516,6 +7516,11 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 		return -EINVAL;
 	}
=20
+	if (!env->prog->aux->sleepable && fn->might_sleep) {
+		verbose(env, "helper call might sleep in a non-sleepable prog\n");
+		return -EINVAL;
+	}
+
 	/* With LD_ABS/IND some JITs save/restore skb from r1. */
 	changes_data =3D bpf_helper_changes_pkt_data(fn->func);
 	if (changes_data && fn->arg1_type !=3D ARG_PTR_TO_CTX) {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 5b9008bc597b..3bbd3f0c810c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1485,9 +1485,9 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, co=
nst struct bpf_prog *prog)
 	case BPF_FUNC_get_task_stack:
 		return &bpf_get_task_stack_proto;
 	case BPF_FUNC_copy_from_user:
-		return prog->aux->sleepable ? &bpf_copy_from_user_proto : NULL;
+		return &bpf_copy_from_user_proto;
 	case BPF_FUNC_copy_from_user_task:
-		return prog->aux->sleepable ? &bpf_copy_from_user_task_proto : NULL;
+		return &bpf_copy_from_user_task_proto;
 	case BPF_FUNC_snprintf_btf:
 		return &bpf_snprintf_btf_proto;
 	case BPF_FUNC_per_cpu_ptr:
--=20
2.30.2

