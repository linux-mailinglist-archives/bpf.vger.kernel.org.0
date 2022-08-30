Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12395A6B31
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 19:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiH3Rts (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 13:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiH3RtU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 13:49:20 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F344C1123AA
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:46:26 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UG2DWc009515
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:28:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=JrlU6OIh7bZ7klwThyOor5d3ykS/HjCka7P7GPoOa6E=;
 b=JOl97JFRUs5dl72iRbZKDMYtpZgZNWTgJzYGct891ekCsAlsiK44mZl2oUng4i8PfnOz
 vw+qu95Z6/G9CyAsPW2EiU9pw/udhTjlIWb7waMsEL1zsmH0aJZ/ZrGgzu7ACP73Jpwa
 Zo68FYmBXkVdg9nq/D2Xlq8q4ncAHYGpl44= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j94gye1jk-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:28:17 -0700
Received: from twshared10711.09.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 10:28:16 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 4523ECAD074A; Tue, 30 Aug 2022 10:28:05 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFCv2 PATCH bpf-next 02/18] bpf: Add verifier check for BPF_PTR_POISON retval and arg
Date:   Tue, 30 Aug 2022 10:27:43 -0700
Message-ID: <20220830172759.4069786-3-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220830172759.4069786-1-davemarchevsky@fb.com>
References: <20220830172759.4069786-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 39KUiHcORC_M6e9oYytErrlz1x_9J25c
X-Proofpoint-GUID: 39KUiHcORC_M6e9oYytErrlz1x_9J25c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF_PTR_POISON was added in commit c0a5a21c25f37 ("bpf: Allow storing
referenced kptr in map") to denote a bpf_func_proto btf_id which the
verifier will replace with a dynamically-determined one at verification
time.

This patch adds 'poison' functionality to BPF_PTR_POISON in order to
prepare for expanded use of the value to poison ret- and arg-btf_id in
further patches of this series. Specifically, when the verifier checks
helper calls, it assumes that BPF_PTR_POISON'ed ret type will be
replaced with a valid type before - or in lieu of - the default
ret_btf_id logic. Similarly for argument btf_id.

If poisoned btf_id reaches default handling block for either, consider
this a verifier internal error and fail verification. Otherwise a helper
w/ poisoned btf_id but no verifier logic replacing the type will cause a
crash as the invalid pointer is dereferenced.

Also move BPF_PTR_POISON to existing <linux/posion.h> header and replace
the hardcoded value with something that looks slightly like BPF (0xB4F).

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/poison.h |  3 +++
 kernel/bpf/helpers.c   |  6 +++---
 kernel/bpf/verifier.c  | 28 ++++++++++++++++++++++------
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/include/linux/poison.h b/include/linux/poison.h
index d62ef5a6b4e9..599995d29fe4 100644
--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -81,4 +81,7 @@
 /********** net/core/page_pool.c **********/
 #define PP_SIGNATURE		(0x40 + POISON_POINTER_DELTA)
=20
+/********** kernel/bpf/ **********/
+#define BPF_PTR_POISON ((void *)(0xB4FUL + POISON_POINTER_DELTA))
+
 #endif
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 3c1b9bbcf971..6de4dedf45c0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -15,6 +15,7 @@
 #include <linux/ctype.h>
 #include <linux/jiffies.h>
 #include <linux/pid_namespace.h>
+#include <linux/poison.h>
 #include <linux/proc_ns.h>
 #include <linux/security.h>
 #include <linux/btf_ids.h>
@@ -1410,10 +1411,9 @@ BPF_CALL_2(bpf_kptr_xchg, void *, map_value, void =
*, ptr)
 }
=20
 /* Unlike other PTR_TO_BTF_ID helpers the btf_id in bpf_kptr_xchg()
- * helper is determined dynamically by the verifier.
+ * helper is determined dynamically by the verifier. Use BPF_PTR_POISON =
to
+ * denote type that verifier will determine.
  */
-#define BPF_PTR_POISON ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA)=
)
-
 static const struct bpf_func_proto bpf_kptr_xchg_proto =3D {
 	.func         =3D bpf_kptr_xchg,
 	.gpl_only     =3D false,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 68bfa7c28048..ee5b57140c73 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23,6 +23,7 @@
 #include <linux/error-injection.h>
 #include <linux/bpf_lsm.h>
 #include <linux/btf_ids.h>
+#include <linux/poison.h>
=20
 #include "disasm.h"
=20
@@ -5764,13 +5765,21 @@ static int check_reg_type(struct bpf_verifier_env=
 *env, u32 regno,
 		if (meta->func_id =3D=3D BPF_FUNC_kptr_xchg) {
 			if (map_kptr_match_type(env, meta->kptr_off_desc, reg, regno))
 				return -EACCES;
-		} else if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg=
->off,
+		} else {
+			if (arg_btf_id =3D=3D BPF_PTR_POISON) {
+				verbose(env, "verifier internal error: R%d has "
+					"non-overwritten BPF_PTR_POISON type\n", regno);
+				return -EACCES;
+			}
+
+			if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
 						 btf_vmlinux, *arg_btf_id,
 						 strict_type_match)) {
-			verbose(env, "R%d is of type %s but %s is expected\n",
-				regno, kernel_type_name(reg->btf, reg->btf_id),
-				kernel_type_name(btf_vmlinux, *arg_btf_id));
-			return -EACCES;
+				verbose(env, "R%d is of type %s but %s is expected\n",
+					regno, kernel_type_name(reg->btf, reg->btf_id),
+					kernel_type_name(btf_vmlinux, *arg_btf_id));
+				return -EACCES;
+			}
 		}
 	}
=20
@@ -7454,7 +7463,14 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 			ret_btf =3D meta.kptr_off_desc->kptr.btf;
 			ret_btf_id =3D meta.kptr_off_desc->kptr.btf_id;
 		} else {
-			ret_btf =3D btf_vmlinux;
+			if (fn->ret_btf_id =3D=3D BPF_PTR_POISON) {
+				verbose(env, "verifier internal error: func %s "
+					"has non-overwritten "
+					"BPF_PTR_POISON return type\n",
+					func_id_name(func_id));
+				return -EINVAL;
+			}
+		        ret_btf =3D btf_vmlinux;
 			ret_btf_id =3D *fn->ret_btf_id;
 		}
 		if (ret_btf_id =3D=3D 0) {
--=20
2.30.2

