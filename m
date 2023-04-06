Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E526D9DC2
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 18:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239445AbjDFQpk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 12:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239602AbjDFQpS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 12:45:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F31559F
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 09:45:17 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 336EBe1l022416
        for <bpf@vger.kernel.org>; Thu, 6 Apr 2023 09:45:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=11irFytXWSzxWLE9NUf+/Mdolo1b5lxSUQwvxBsybPs=;
 b=iobgNAI/x8bH766CJ14LsiITTGK+Zw6nyegJiQkrLCzDpsTY5E1I98MTAUx6AFYsImnW
 nDl+p95NY5slAmS0CrwtdiGuzVp/IEgbKbdMXCZWoxfwsFEYJRvcJmg2SsaSu96PXCGL
 Nd1HpQTc+iveHcD4vMn6xkse6s99wfkxkwU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3psym6h50q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 09:45:16 -0700
Received: from twshared0333.05.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 6 Apr 2023 09:45:14 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id D2E8C1C5BEE7C; Thu,  6 Apr 2023 09:45:05 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 3/4] bpf: Improve handling of pattern '<const> <cond_op> <non_const>' in verifier
Date:   Thu, 6 Apr 2023 09:45:05 -0700
Message-ID: <20230406164505.1046801-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230406164450.1044952-1-yhs@fb.com>
References: <20230406164450.1044952-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: IBBvTQXAoY6-dDKkA_zQ77rMQXOKINHS
X-Proofpoint-ORIG-GUID: IBBvTQXAoY6-dDKkA_zQ77rMQXOKINHS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_10,2023-04-06_03,2023-02-09_01
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, the verifier does not handle '<const> <cond_op> <non_const>' w=
ell.
For example,
  ...
  10: (79) r1 =3D *(u64 *)(r10 -16)       ; R1_w=3Dscalar() R10=3Dfp0
  11: (b7) r2 =3D 0                       ; R2_w=3D0
  12: (2d) if r2 > r1 goto pc+2
  13: (b7) r0 =3D 0
  14: (95) exit
  15: (65) if r1 s> 0x1 goto pc+3
  16: (0f) r0 +=3D r1
  ...
At insn 12, verifier decides both true and false branch are possible, but
actually only false branch is possible.

Currently, the verifier already supports patterns '<non_const> <cond_op> =
<const>.
Add support for patterns '<const> <cond_op> <non_const>' in a similar way=
.

Also fix selftest 'verifier_bounds_mix_sign_unsign/bounds checks mixing s=
igned and unsigned, variant 10'
due to this change.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c                                | 12 ++++++++++++
 .../bpf/progs/verifier_bounds_mix_sign_unsign.c      |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5c6b90e384a5..3660b573048a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13356,6 +13356,18 @@ static int check_cond_jmp_op(struct bpf_verifier=
_env *env,
 				       src_reg->var_off.value,
 				       opcode,
 				       is_jmp32);
+	} else if (dst_reg->type =3D=3D SCALAR_VALUE &&
+		   is_jmp32 && tnum_is_const(tnum_subreg(dst_reg->var_off))) {
+		pred =3D is_branch_taken(src_reg,
+				       tnum_subreg(dst_reg->var_off).value,
+				       flip_opcode(opcode),
+				       is_jmp32);
+	} else if (dst_reg->type =3D=3D SCALAR_VALUE &&
+		   !is_jmp32 && tnum_is_const(dst_reg->var_off)) {
+		pred =3D is_branch_taken(src_reg,
+				       dst_reg->var_off.value,
+				       flip_opcode(opcode),
+				       is_jmp32);
 	} else if (reg_is_pkt_pointer_any(dst_reg) &&
 		   reg_is_pkt_pointer_any(src_reg) &&
 		   !is_jmp32) {
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_mix_sign_u=
nsign.c b/tools/testing/selftests/bpf/progs/verifier_bounds_mix_sign_unsi=
gn.c
index 91a66357896a..4f40144748a5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds_mix_sign_unsign.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds_mix_sign_unsign.c
@@ -354,7 +354,7 @@ __naked void signed_and_unsigned_variant_10(void)
 	call %[bpf_map_lookup_elem];			\
 	if r0 =3D=3D 0 goto l0_%=3D;				\
 	r1 =3D *(u64*)(r10 - 16);				\
-	r2 =3D 0;						\
+	r2 =3D -1;						\
 	if r2 > r1 goto l1_%=3D;				\
 	r0 =3D 0;						\
 	exit;						\
--=20
2.34.1

