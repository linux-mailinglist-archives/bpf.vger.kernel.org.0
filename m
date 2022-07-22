Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125A857E696
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 20:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbiGVSfD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 14:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbiGVSfC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 14:35:02 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3EB7D1D0
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:35:01 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MC8QaD022622
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:35:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=jqn5vwtwL09kaoTyW2RH9jm0IjV+NApjPiL6U3y5slE=;
 b=M35ZnRAglbchLkwNCD9rkiG5sxJbZKJw6QrgK7Ipe335F/b9IrofYyrljVLBuS9JUTjL
 LxFo8QDHor8dUCsahW3b0PglPlld0lVt08Y8U/NoNOfiJLsfgb06VBh8gTo82xaEX/V0
 IwivRifMOLxvK1fv1Mn4tUmcaPzSUxaRrQA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hf7fc10es-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:35:00 -0700
Received: from twshared22934.08.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 22 Jul 2022 11:34:59 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 256DFAB6F196; Fri, 22 Jul 2022 11:34:47 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFC PATCH bpf-next 02/11] bpf: Add verifier support for custom callback return range
Date:   Fri, 22 Jul 2022 11:34:29 -0700
Message-ID: <20220722183438.3319790-3-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220722183438.3319790-1-davemarchevsky@fb.com>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: udvVe_VaQrm_ktf-Nkqrjr2mlp44skz8
X-Proofpoint-ORIG-GUID: udvVe_VaQrm_ktf-Nkqrjr2mlp44skz8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
those added further in this series, add a callback_ret_range to
bpf_func_state. Verifier's helpers which set in_callback_fn will also
set the new field, which the verifier will later use to check return
value bounds.

Default to tnum_range(0, 1) instead of using tnum_unknown as a sentinel
value as the latter would prevent the valid range (0, U64_MAX) being
used.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf_verifier.h | 1 +
 kernel/bpf/verifier.c        | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 2e3bad8640dc..9c017575c034 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -237,6 +237,7 @@ struct bpf_func_state {
 	 */
 	u32 async_entry_cnt;
 	bool in_callback_fn;
+	struct tnum callback_ret_range;
 	bool in_async_callback_fn;
=20
 	/* The following fields should be last. See copy_func_state() */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c5fbaa9f025a..1f50becce141 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1745,6 +1745,7 @@ static void init_func_state(struct bpf_verifier_env=
 *env,
 	state->callsite =3D callsite;
 	state->frameno =3D frameno;
 	state->subprogno =3D subprogno;
+	state->callback_ret_range =3D tnum_range(0, 1);
 	init_reg_state(env, state);
 	mark_verifier_state_scratched(env);
 }
@@ -6880,6 +6881,7 @@ static int set_find_vma_callback_state(struct bpf_v=
erifier_env *env,
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_callback_fn =3D true;
+	callee->callback_ret_range =3D tnum_range(0, 1);
 	return 0;
 }
=20
@@ -6907,7 +6909,7 @@ static int prepare_func_exit(struct bpf_verifier_en=
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

