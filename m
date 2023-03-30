Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596A16CFB05
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 07:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjC3F4h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 01:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjC3F4g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 01:56:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A078F619C
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 22:56:34 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32TKgYv0016122
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 22:56:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=fcePSt7c2hFO13Yz3R3N9A58Ir8KU6ClJlZGrMypPkU=;
 b=J8qslIA8HW2q5Q/CMnMzBBpOvDQDPD0/IH0X/WbHQKn8oq3w9zI2Du3RPRsL2BC9jp1n
 ywhLElGHi7TF7wIzTuHdVBDuMhPzv5+msdC+Q+eyDNvn1hOgvNYg8zXt+m9bWfQx0qQu
 IvZffZbxrGY/klNuvhr398JEysIFWdGvByU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pmvkmtndw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 22:56:34 -0700
Received: from twshared17808.08.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 29 Mar 2023 22:56:32 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id DBA8A1BA2D8DA; Wed, 29 Mar 2023 22:56:25 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 5/7] bpf: Mark potential spilled loop index variable as precise
Date:   Wed, 29 Mar 2023 22:56:25 -0700
Message-ID: <20230330055625.92148-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330055600.86870-1-yhs@fb.com>
References: <20230330055600.86870-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 8o4iY4nSG9nJXQOl4YB16R_azC2oGVKY
X-Proofpoint-ORIG-GUID: 8o4iY4nSG9nJXQOl4YB16R_azC2oGVKY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_02,2023-03-30_01,2023-02-09_01
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For a loop, if loop index variable is spilled and between loop
iterations, the only reg/spill state difference is spilled loop
index variable, then verifier may assume an infinite loop which
cause verification failure. In such cases, we should mark
spilled loop index variable as precise to differentiate states
between loop iterations.

Since verifier is not able to accurately identify loop index
variable, add a heuristic such that if both old reg state and
new reg state are consts, mark old reg state as precise which
will trigger constant value comparison later.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d070943a8ba1..d1aa2c7ae7c0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14850,6 +14850,23 @@ static bool stacksafe(struct bpf_verifier_env *e=
nv, struct bpf_func_state *old,
 		/* Both old and cur are having same slot_type */
 		switch (old->stack[spi].slot_type[BPF_REG_SIZE - 1]) {
 		case STACK_SPILL:
+			/* sometime loop index variable is spilled and the spill
+			 * is not marked as precise. If only state difference
+			 * between two iterations are spilled loop index, the
+			 * "infinite loop detected at insn" error will be hit.
+			 * Mark spilled constant as precise so it went through value
+			 * comparison.
+			 */
+			old_reg =3D &old->stack[spi].spilled_ptr;
+			cur_reg =3D &cur->stack[spi].spilled_ptr;
+			if (!old_reg->precise) {
+				if (old_reg->type =3D=3D SCALAR_VALUE &&
+				    cur_reg->type =3D=3D SCALAR_VALUE &&
+				    tnum_is_const(old_reg->var_off) &&
+				    tnum_is_const(cur_reg->var_off))
+					old_reg->precise =3D true;
+			}
+
 			/* when explored and current stack slot are both storing
 			 * spilled registers, check that stored pointers types
 			 * are the same as well.
@@ -14860,8 +14877,7 @@ static bool stacksafe(struct bpf_verifier_env *en=
v, struct bpf_func_state *old,
 			 * such verifier states are not equivalent.
 			 * return false to continue verification of this path
 			 */
-			if (!regsafe(env, &old->stack[spi].spilled_ptr,
-				     &cur->stack[spi].spilled_ptr, idmap))
+			if (!regsafe(env, old_reg, cur_reg, idmap))
 				return false;
 			break;
 		case STACK_DYNPTR:
--=20
2.34.1

