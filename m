Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D78644F5D
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 00:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiLFXKb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 18:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiLFXK3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 18:10:29 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C35429AC
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 15:10:28 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2B6LhAMG013912
        for <bpf@vger.kernel.org>; Tue, 6 Dec 2022 15:10:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=AbOeVTPiDkhygRitG0ME7dPETq/dImrFr6jfY7hkL/8=;
 b=XG84iKE9fHOSBu9RbaBopIzRcURWEq5R51mg0Bbb705dHZAMl2jexOmLxJ8FjZjpo8o0
 fzs8h815ODzqOdzrzPaGENST0PIHhpLxYhhOConooiD+B+oL0pceCjxMkbp+XxSgJQp/
 1Jqa5sRwnfc9ywXIh5atEVtZo0rI6v58HsI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3m9s5q0c24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 15:10:28 -0800
Received: from twshared15216.17.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Dec 2022 15:10:26 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id E154A120B3768; Tue,  6 Dec 2022 15:10:03 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 03/13] bpf: Minor refactor of ref_set_release_on_unlock
Date:   Tue, 6 Dec 2022 15:09:50 -0800
Message-ID: <20221206231000.3180914-4-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221206231000.3180914-1-davemarchevsky@fb.com>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 4IoK4-7AJT2-aBCLMb8beEwuuW0xi-9c
X-Proofpoint-ORIG-GUID: 4IoK4-7AJT2-aBCLMb8beEwuuW0xi-9c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_12,2022-12-06_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is mostly a nonfunctional change. The verifier log message
"expected false release_on_unlock" was missing a newline, so add it and
move some checks around to reduce indentation level.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/verifier.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 67a13110bc22..6f0aac837d77 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8438,19 +8438,21 @@ static int ref_set_release_on_unlock(struct bpf_v=
erifier_env *env, u32 ref_obj_i
 		return -EFAULT;
 	}
 	for (i =3D 0; i < state->acquired_refs; i++) {
-		if (state->refs[i].id =3D=3D ref_obj_id) {
-			if (state->refs[i].release_on_unlock) {
-				verbose(env, "verifier internal error: expected false release_on_unl=
ock");
-				return -EFAULT;
-			}
-			state->refs[i].release_on_unlock =3D true;
-			/* Now mark everyone sharing same ref_obj_id as untrusted */
-			bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
-				if (reg->ref_obj_id =3D=3D ref_obj_id)
-					reg->type |=3D PTR_UNTRUSTED;
-			}));
-			return 0;
+		if (state->refs[i].id !=3D ref_obj_id)
+			continue;
+
+		if (state->refs[i].release_on_unlock) {
+			verbose(env, "verifier internal error: expected false release_on_unlo=
ck\n");
+			return -EFAULT;
 		}
+
+		state->refs[i].release_on_unlock =3D true;
+		/* Now mark everyone sharing same ref_obj_id as untrusted */
+		bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
+			if (reg->ref_obj_id =3D=3D ref_obj_id)
+				reg->type |=3D PTR_UNTRUSTED;
+		}));
+		return 0;
 	}
 	verbose(env, "verifier internal error: ref state missing for ref_obj_id=
\n");
 	return -EFAULT;
--=20
2.30.2

