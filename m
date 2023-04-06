Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EB16D9DB9
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 18:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjDFQpi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 12:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239593AbjDFQpH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 12:45:07 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482C955AE
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 09:45:06 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336EQw2W008074
        for <bpf@vger.kernel.org>; Thu, 6 Apr 2023 09:45:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=NExDBiWxsVOGwNsECUFx7fbwTXuVpN72UB85Bd1PvlE=;
 b=HhNws0dc8IXandGsJRk+LFViguEad9Ypk/ys6g4xMh2vvI11EXfF+24LBDf7WoPgbpOu
 gxoIj0VFgwXzunFznROMS21BkTX9CfkEQnhefBoLU8fEKFlye8FIvn/kS9dEmlwqsMjj
 xlTqmKHGEpvzGv1+LOVF4CCce3B9DW+z3dM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3psyun0yy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 09:45:05 -0700
Received: from twshared8216.02.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 6 Apr 2023 09:45:05 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 584351C5BEE08; Thu,  6 Apr 2023 09:44:55 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 1/4] bpf: Improve verifier JEQ/JNE insn branch taken checking
Date:   Thu, 6 Apr 2023 09:44:55 -0700
Message-ID: <20230406164455.1045294-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230406164450.1044952-1-yhs@fb.com>
References: <20230406164450.1044952-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: OZkdI7IbtNtZG8lQg6trmlpMsl0cjEom
X-Proofpoint-ORIG-GUID: OZkdI7IbtNtZG8lQg6trmlpMsl0cjEom
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

Currently, for BPF_JEQ/BPF_JNE insn, verifier determines
whether the branch is taken or not only if both operands
are constants. Therefore, for the following code snippet,
  0: (85) call bpf_ktime_get_ns#5       ; R0_w=3Dscalar()
  1: (a5) if r0 < 0x3 goto pc+2         ; R0_w=3Dscalar(umin=3D3)
  2: (b7) r2 =3D 2                        ; R2_w=3D2
  3: (1d) if r0 =3D=3D r2 goto pc+2 6

At insn 3, since r0 is not a constant, verifier assumes both branch
can be taken which may lead inproper verification failure.

Add comparing umin/umax value and the constant. If the umin value
is greater than the constant, or umax value is smaller than the constant,
for JEQ the branch must be not-taken, and for JNE the branch must be take=
n.
The jmp32 mode JEQ/JNE branch taken checking is also handled similarly.

The following lists the veristat result w.r.t. changed number
of processes insns during verification:

File                                                   Program           =
                                    Insns (A)  Insns (B)  Insns    (DIFF)
-----------------------------------------------------  ------------------=
----------------------------------  ---------  ---------  ---------------
test_cls_redirect.bpf.linked3.o                        cls_redirect      =
                                        64980      73472  +8492 (+13.07%)
test_seg6_loop.bpf.linked3.o                           __add_egr_x       =
                                        12425      12423      -2 (-0.02%)
test_tcp_hdr_options.bpf.linked3.o                     estab             =
                                         2634       2558     -76 (-2.89%)
test_parse_tcp_hdr_opt.bpf.linked3.o                   xdp_ingress_v6    =
                                         1421       1420      -1 (-0.07%)
test_parse_tcp_hdr_opt_dynptr.bpf.linked3.o            xdp_ingress_v6    =
                                         1238       1237      -1 (-0.08%)
test_tc_dtime.bpf.linked3.o                            egress_fwdns_prio1=
00                                        414        411      -3 (-0.72%)

Mostly a small improvement but test_cls_redirect.bpf.linked3.o has a 13% =
regression.
I checked with verifier log and found it this is due to pruning.
For some JEQ/JNE branches impacted by this patch,
one branch is explored and the other has state equivalence and
pruned.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 56f569811f70..5c6b90e384a5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12651,10 +12651,14 @@ static int is_branch32_taken(struct bpf_reg_sta=
te *reg, u32 val, u8 opcode)
 	case BPF_JEQ:
 		if (tnum_is_const(subreg))
 			return !!tnum_equals_const(subreg, val);
+		else if (val < reg->u32_min_value || val > reg->u32_max_value)
+			return 0;
 		break;
 	case BPF_JNE:
 		if (tnum_is_const(subreg))
 			return !tnum_equals_const(subreg, val);
+		else if (val < reg->u32_min_value || val > reg->u32_max_value)
+			return 1;
 		break;
 	case BPF_JSET:
 		if ((~subreg.mask & subreg.value) & val)
@@ -12724,10 +12728,14 @@ static int is_branch64_taken(struct bpf_reg_sta=
te *reg, u64 val, u8 opcode)
 	case BPF_JEQ:
 		if (tnum_is_const(reg->var_off))
 			return !!tnum_equals_const(reg->var_off, val);
+		else if (val < reg->umin_value || val > reg->umax_value)
+			return 0;
 		break;
 	case BPF_JNE:
 		if (tnum_is_const(reg->var_off))
 			return !tnum_equals_const(reg->var_off, val);
+		else if (val < reg->umin_value || val > reg->umax_value)
+			return 1;
 		break;
 	case BPF_JSET:
 		if ((~reg->var_off.mask & reg->var_off.value) & val)
--=20
2.34.1

