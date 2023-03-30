Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB786CFB00
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 07:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjC3F4T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 01:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjC3F4S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 01:56:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A0C269A
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 22:56:14 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32U1jhp8022395
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 22:56:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=mVhXHl5wHY9CQaWQXWGIuKVWybjFWstqO85zQJ6hI0M=;
 b=Dak90szY0Xig/Xruf1DkZx9rESdwMAAXRjGDsXT2XAff/Jz6V05PPhDU+JaMOojWgX6q
 la7H1clMvYZ3/cJkbbYXl1ZCkWFsbvusDaMju+rtaBJSdMfdn6FVYuntaK5IMEq/tDgX
 hUEIRuFjfzfTEudwT+f+yGKKRFm1voOfcHw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pn11ss3g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 22:56:14 -0700
Received: from twshared0333.05.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 29 Mar 2023 22:56:13 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 3F26B1BA2D740; Wed, 29 Mar 2023 22:56:05 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 1/7] bpf: Improve verifier JEQ/JNE insn branch taken checking
Date:   Wed, 29 Mar 2023 22:56:05 -0700
Message-ID: <20230330055605.88807-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330055600.86870-1-yhs@fb.com>
References: <20230330055600.86870-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ijt7NZNBmV9y6H3S9zD0XZ0KnPLzGfT7
X-Proofpoint-GUID: ijt7NZNBmV9y6H3S9zD0XZ0KnPLzGfT7
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

Currently, for BPF_JEQ/BPF_JNE insn, verifier determines
whether the branch is taken or not only if both operands
are constants. Therefore, for the following code snippet,
  0: (85) call bpf_ktime_get_ns#5       ; R0_w=3Dscalar()
  1: (a5) if r0 < 0x3 goto pc+2         ; R0_w=3Dscalar(umin=3D3)
  2: (b7) r2 =3D 2                        ; R2_w=3D2
  3: (1d) if r0 =3D=3D r2 goto pc+2 6

At insn 3, since r0 is not a constant, verifier assumes both branch
can be taken which may lead inproper verification failure.

Add comparing umin value and the constant. If the umin value
is greater than the constant, for JEQ the branch must be
not-taken, and for JNE the branch must be taken.
The jmp32 mode JEQ/JNE branch taken checking is also
handled similarly.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 20eb2015842f..90bb6d25bc9c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12597,10 +12597,14 @@ static int is_branch32_taken(struct bpf_reg_sta=
te *reg, u32 val, u8 opcode)
 	case BPF_JEQ:
 		if (tnum_is_const(subreg))
 			return !!tnum_equals_const(subreg, val);
+		else if (reg->u32_min_value > val)
+			return 0;
 		break;
 	case BPF_JNE:
 		if (tnum_is_const(subreg))
 			return !tnum_equals_const(subreg, val);
+		else if (reg->u32_min_value > val)
+			return 1;
 		break;
 	case BPF_JSET:
 		if ((~subreg.mask & subreg.value) & val)
@@ -12670,10 +12674,14 @@ static int is_branch64_taken(struct bpf_reg_sta=
te *reg, u64 val, u8 opcode)
 	case BPF_JEQ:
 		if (tnum_is_const(reg->var_off))
 			return !!tnum_equals_const(reg->var_off, val);
+		else if (reg->umin_value > val)
+			return 0;
 		break;
 	case BPF_JNE:
 		if (tnum_is_const(reg->var_off))
 			return !tnum_equals_const(reg->var_off, val);
+		else if (reg->umin_value > val)
+			return 1;
 		break;
 	case BPF_JSET:
 		if ((~reg->var_off.mask & reg->var_off.value) & val)
--=20
2.34.1

