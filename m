Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76615B29E2
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 01:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiIHXH2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 19:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIHXH1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 19:07:27 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F498F95D
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 16:07:26 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288Ml7Na026795
        for <bpf@vger.kernel.org>; Thu, 8 Sep 2022 16:07:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=Ha6ExWTWMfhOASyGilTuffSe7jIPqtH7U4eRfyEcK74=;
 b=jPg3rLSiIzYea+xq/sHHk1Xkp+xO+RWxipY2Rlk/OUUDOShbtHSwKSvoGlM8IfDmEmbh
 BMofS7VI8dRuKfZpK2WaQh73zDY6HiyOMLA0u3exif1CXuH3gwnzwYWKbTGOCsO1+VHf
 /tOTwRS3KaUCzJJONP/JL3eMnTFAiYL9vs8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jffdxcs9f-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 08 Sep 2022 16:07:26 -0700
Received: from twshared7509.08.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 16:07:23 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id E2985D2A734C; Thu,  8 Sep 2022 16:07:19 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next] bpf: Add verifier support for custom callback return range
Date:   Thu, 8 Sep 2022 16:07:16 -0700
Message-ID: <20220908230716.2751723-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: N6XbxTZ64K0HJdocsUOHSMtJ8KejfaqR
X-Proofpoint-ORIG-GUID: N6XbxTZ64K0HJdocsUOHSMtJ8KejfaqR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_12,2022-09-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Verifier logic to confirm that a callback function returns 0 or 1 was
added in commit 69c087ba6225b ("bpf: Add bpf_for_each_map_elem() helper")=
.
At the time, callback return value was only used to continue or stop
iteration.

In order to support callbacks with a broader return value range, such as
those added in rbtree series[0] and others, add a callback_ret_range to
bpf_func_state. Verifier's helpers which set in_callback_fn will also
set the new field, which the verifier will later use to check return
value bounds.

Default to tnum_range(0, 0) instead of using tnum_unknown as a sentinel
value as the latter would prevent the valid range (0, U64_MAX) being
used. Previous global default tnum_range(0, 1) is explicitly set for
extant callback helpers. The change to global default was made after
discussion around this patch in rbtree series [1], goal here is to make
it more obvious that callback_ret_range should be explicitly set.

  [0]: lore.kernel.org/bpf/20220830172759.4069786-1-davemarchevsky@fb.com=
/
  [1]: lore.kernel.org/bpf/20220830172759.4069786-2-davemarchevsky@fb.com=
/

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
Sending this separately from rbtree patchset as Joanne also needs this
change for her usecase.

 include/linux/bpf_verifier.h | 1 +
 kernel/bpf/verifier.c        | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b49a349cc6ae..e197f8fb27e2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -248,6 +248,7 @@ struct bpf_func_state {
 	 */
 	u32 async_entry_cnt;
 	bool in_callback_fn;
+	struct tnum callback_ret_range;
 	bool in_async_callback_fn;
=20
 	/* The following fields should be last. See copy_func_state() */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c0f175ac187a..ac0cb88e452a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1749,6 +1749,7 @@ static void init_func_state(struct bpf_verifier_env=
 *env,
 	state->callsite =3D callsite;
 	state->frameno =3D frameno;
 	state->subprogno =3D subprogno;
+	state->callback_ret_range =3D tnum_range(0, 0);
 	init_reg_state(env, state);
 	mark_verifier_state_scratched(env);
 }
@@ -6789,6 +6790,7 @@ static int set_map_elem_callback_state(struct bpf_v=
erifier_env *env,
 		return err;
=20
 	callee->in_callback_fn =3D true;
+	callee->callback_ret_range =3D tnum_range(0, 1);
 	return 0;
 }
=20
@@ -6810,6 +6812,7 @@ static int set_loop_callback_state(struct bpf_verif=
ier_env *env,
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
=20
 	callee->in_callback_fn =3D true;
+	callee->callback_ret_range =3D tnum_range(0, 1);
 	return 0;
 }
=20
@@ -6839,6 +6842,7 @@ static int set_timer_callback_state(struct bpf_veri=
fier_env *env,
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_async_callback_fn =3D true;
+	callee->callback_ret_range =3D tnum_range(0, 1);
 	return 0;
 }
=20
@@ -6866,6 +6870,7 @@ static int set_find_vma_callback_state(struct bpf_v=
erifier_env *env,
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_callback_fn =3D true;
+	callee->callback_ret_range =3D tnum_range(0, 1);
 	return 0;
 }
=20
@@ -6893,7 +6898,7 @@ static int prepare_func_exit(struct bpf_verifier_en=
v *env, int *insn_idx)
 	caller =3D state->frame[state->curframe];
 	if (callee->in_callback_fn) {
 		/* enforce R0 return value range [0, 1]. */
-		struct tnum range =3D tnum_range(0, 1);
+		struct tnum range =3D callee->callback_ret_range;
=20
 		if (r0->type !=3D SCALAR_VALUE) {
 			verbose(env, "R0 not a scalar value\n");
--=20
2.30.2

