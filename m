Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED595B5D94
	for <lists+bpf@lfdr.de>; Mon, 12 Sep 2022 17:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiILPp4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Sep 2022 11:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiILPpz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Sep 2022 11:45:55 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DD62FFD9
        for <bpf@vger.kernel.org>; Mon, 12 Sep 2022 08:45:54 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 28CDijoV006368
        for <bpf@vger.kernel.org>; Mon, 12 Sep 2022 08:45:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=MjVHoKlYPCPjo4kyObMuxCuQcRU+smkvpftj4YDCAis=;
 b=WxzNaENDWcf5JSi1iPzBE1p6JGb+yDGiOFlN3NHYx4vAQ1+3cwvBhUWMzuexTFoIjBVq
 tp7WtX7WJB1o43mH8N+0NVH7bmdAOC19jiQ8rz/VELbCCrcCBjIemJ6cTMMqqNAKTONs
 FUF20ALl9yPOz9o32qgUYe9c6AP43wsv5cA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3jgp8xtyed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 12 Sep 2022 08:45:54 -0700
Received: from twshared3888.09.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 08:45:53 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 83D39D5CCB79; Mon, 12 Sep 2022 08:45:45 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next] bpf: Add verifier check for BPF_PTR_POISON retval and arg
Date:   Mon, 12 Sep 2022 08:45:44 -0700
Message-ID: <20220912154544.1398199-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Ovb3VKM0m7_As7WZQkwhq3i54_6qbvKA
X-Proofpoint-ORIG-GUID: Ovb3VKM0m7_As7WZQkwhq3i54_6qbvKA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_10,2022-09-12_02,2022-06-22_01
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
verifier will replace with a dynamically-determined btf_id at verificatio=
n
time.

This patch adds verifier 'poison' functionality to BPF_PTR_POISON in
order to prepare for expanded use of the value to poison ret- and
arg-btf_id in ongoing work, namely rbtree and linked list patchsets
[0, 1]. Specifically, when the verifier checks helper calls, it assumes
that BPF_PTR_POISON'ed ret type will be replaced with a valid type before
- or in lieu of - the default ret_btf_id logic. Similarly for arg btf_id.

If poisoned btf_id reaches default handling block for either, consider
this a verifier internal error and fail verification. Otherwise a helper
w/ poisoned btf_id but no verifier logic replacing the type will cause a
crash as the invalid pointer is dereferenced.

Also move BPF_PTR_POISON to existing include/linux/posion.h header and
remove unnecessary shift.

  [0]: lore.kernel.org/bpf/20220830172759.4069786-1-davemarchevsky@fb.com
  [1]: lore.kernel.org/bpf/20220904204145.3089-1-memxor@gmail.com

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
This patch was originally part of [0] and is used in [1]. Pulling out
and submitting separately as discussed in patch 18's thread in [1].

To validate, comment out the 'if' test and block preceding the 'else's
changed by this patch. (Either or both will work). The poisoned ret and
arg types for bpf_kptr_xchg are overwritten in these 'if's, so
commenting out the overwriting will result in the added behavior causing
progs which use bpf_kptr_xchg to fail to pass verifier. Can confirm by
doing './test_progs -t map_kptr' .

 include/linux/poison.h |  3 +++
 kernel/bpf/helpers.c   |  6 +++---
 kernel/bpf/verifier.c  | 30 +++++++++++++++++++++++-------
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/include/linux/poison.h b/include/linux/poison.h
index d62ef5a6b4e9..2d3249eb0e62 100644
--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -81,4 +81,7 @@
 /********** net/core/page_pool.c **********/
 #define PP_SIGNATURE		(0x40 + POISON_POINTER_DELTA)
=20
+/********** kernel/bpf/ **********/
+#define BPF_PTR_POISON ((void *)(0xeB9FUL + POISON_POINTER_DELTA))
+
 #endif
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index fc08035f14ed..41aeaf3862ec 100644
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
@@ -1376,10 +1377,9 @@ BPF_CALL_2(bpf_kptr_xchg, void *, map_value, void =
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
index c259d734f863..8c6fbcd0afaf 100644
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
@@ -5782,13 +5783,22 @@ static int check_reg_type(struct bpf_verifier_env=
 *env, u32 regno,
 		if (meta->func_id =3D=3D BPF_FUNC_kptr_xchg) {
 			if (map_kptr_match_type(env, meta->kptr_off_desc, reg, regno))
 				return -EACCES;
-		} else if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg=
->off,
-						 btf_vmlinux, *arg_btf_id,
-						 strict_type_match)) {
-			verbose(env, "R%d is of type %s but %s is expected\n",
-				regno, kernel_type_name(reg->btf, reg->btf_id),
-				kernel_type_name(btf_vmlinux, *arg_btf_id));
-			return -EACCES;
+		} else {
+			if (arg_btf_id =3D=3D BPF_PTR_POISON) {
+				verbose(env, "verifier internal error:");
+				verbose(env, "R%d has non-overwritten BPF_PTR_POISON type\n",
+					regno);
+				return -EACCES;
+			}
+
+			if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
+						  btf_vmlinux, *arg_btf_id,
+						  strict_type_match)) {
+				verbose(env, "R%d is of type %s but %s is expected\n",
+					regno, kernel_type_name(reg->btf, reg->btf_id),
+					kernel_type_name(btf_vmlinux, *arg_btf_id));
+				return -EACCES;
+			}
 		}
 	}
=20
@@ -7457,6 +7467,12 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 			ret_btf =3D meta.kptr_off_desc->kptr.btf;
 			ret_btf_id =3D meta.kptr_off_desc->kptr.btf_id;
 		} else {
+			if (fn->ret_btf_id =3D=3D BPF_PTR_POISON) {
+				verbose(env, "verifier internal error:");
+				verbose(env, "func %s has non-overwritten BPF_PTR_POISON return type=
\n",
+					func_id_name(func_id));
+				return -EINVAL;
+			}
 			ret_btf =3D btf_vmlinux;
 			ret_btf_id =3D *fn->ret_btf_id;
 		}
--=20
2.30.2

