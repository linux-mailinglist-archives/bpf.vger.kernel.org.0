Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269586E3CC6
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 01:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjDPX2Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 16 Apr 2023 19:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDPX2Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 16 Apr 2023 19:28:24 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD19619AF
        for <bpf@vger.kernel.org>; Sun, 16 Apr 2023 16:28:22 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33GMWsxl006396
        for <bpf@vger.kernel.org>; Sun, 16 Apr 2023 16:28:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=adqhj46ym2Nyw7Xqg8ZeZEUiXHTVVKZhSvetcTeSPYY=;
 b=TTkwJ9kuesP1OPnb5zUEx9HLbscdHQBYGDoFMZ22+aTTjanilpD3WjB63FGzewj1OMhq
 TkcYuBlannEQSXniV4l1fBhYAp7LHo8iXffrDDnjP6bH7VE0cgRi2yH/9sy2PrpqI7yM
 PkOjhpha7c1BNQ831H9KmpOKp9cmrlfeDkY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pysrwdwc8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 16 Apr 2023 16:28:21 -0700
Received: from twshared17808.08.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sun, 16 Apr 2023 16:28:19 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 200981D543436; Sun, 16 Apr 2023 16:28:08 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 1/2] bpf: Improve verifier u32 scalar equality checking
Date:   Sun, 16 Apr 2023 16:28:08 -0700
Message-ID: <20230416232808.2387432-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Laz8dJkjZ_fQSMoTNsZgAx841Q4XP53l
X-Proofpoint-GUID: Laz8dJkjZ_fQSMoTNsZgAx841Q4XP53l
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-16_14,2023-04-14_01,2023-02-09_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In [1], I tried to remove bpf-specific codes to prevent certain
llvm optimizations, and add llvm TTI (target transform info) hooks
to prevent those optimizations. During this process, I found
if I enable llvm SimplifyCFG:shouldFoldTwoEntryPHINode
transformation, I will hit the following verification failure with selftest=
s:

  ...
  8: (18) r1 =3D 0xffffc900001b2230       ; R1_w=3Dmap_value(off=3D560,ks=
=3D4,vs=3D564,imm=3D0)
  10: (61) r1 =3D *(u32 *)(r1 +0)         ; R1_w=3Dscalar(umax=3D4294967295=
,var_off=3D(0x0; 0xffffffff))
  ; if (skb->tstamp =3D=3D EGRESS_ENDHOST_MAGIC)
  11: (79) r2 =3D *(u64 *)(r6 +152)       ; R2_w=3Dscalar() R6=3Dctx(off=3D=
0,imm=3D0)
  ; if (skb->tstamp =3D=3D EGRESS_ENDHOST_MAGIC)
  12: (55) if r2 !=3D 0xb9fbeef goto pc+10        ; R2_w=3D195018479
  13: (bc) w2 =3D w1                      ; R1_w=3Dscalar(umax=3D4294967295=
,var_off=3D(0x0; 0xffffffff)) R2_w=3Dscalar(umax=3D4294967295,var_off=3D(0x=
0; 0xffffffff))
  ; if (test < __NR_TESTS)
  14: (a6) if w1 < 0x9 goto pc+1 16: R0=3D2 R1_w=3Dscalar(umax=3D8,var_off=
=3D(0x0; 0xf)) R2_w=3Dscalar(umax=3D4294967295,var_off=3D(0x0; 0xffffffff))=
 R6=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
  ;
  16: (27) r2 *=3D 28                     ; R2_w=3Dscalar(umax=3D1202590842=
60,var_off=3D(0x0; 0x1ffffffffc),s32_max=3D2147483644,u32_max=3D-4)
  17: (18) r3 =3D 0xffffc900001b2118      ; R3_w=3Dmap_value(off=3D280,ks=
=3D4,vs=3D564,imm=3D0)
  19: (0f) r3 +=3D r2                     ; R2_w=3Dscalar(umax=3D1202590842=
60,var_off=3D(0x0; 0x1ffffffffc),s32_max=3D2147483644,u32_max=3D-4) R3_w=3D=
map_value(off=3D280,ks=3D4,vs=3D564,umax=3D120259084260,var_off=3D(0x0; 0x1=
ffffffffc),s32_max=3D2147483644,u32_max=3D-4)
  20: (61) r2 =3D *(u32 *)(r3 +0)
  R3 unbounded memory access, make sure to bounds check any such access
  processed 97 insns (limit 1000000) max_states_per_insn 1 total_states 10 =
peak_states 10 mark_read 6
  -- END PROG LOAD LOG --
  libbpf: prog 'ingress_fwdns_prio100': failed to load: -13
  libbpf: failed to load object 'test_tc_dtime'
  libbpf: failed to load BPF skeleton 'test_tc_dtime': -13
  ...

At insn 14, with condition 'w1 < 9', register r1 is changed from an arbitra=
ry
u32 value to `scalar(umax=3D8,var_off=3D(0x0; 0xf))`. Register r2, however,=
 remains
as an arbitrary u32 value. Current verifier won't claim r1/r2 equality if
the previous mov is alu32 ('w2 =3D w1').

If r1 upper 32bit value is not 0, we indeed cannot clamin r1/r2 equality
after 'w2 =3D w1'. But in this particular case, we know r1 upper 32bit value
is 0, so it is safe to claim r1/r2 equality. This patch exactly did this.
For a 32bit subreg mov, if the src register upper 32bit is 0,
it is okay to claim equality between src and dst registers.

With this patch, the above verification sequence becomes

  ...
  8: (18) r1 =3D 0xffffc9000048e230       ; R1_w=3Dmap_value(off=3D560,ks=
=3D4,vs=3D564,imm=3D0)
  10: (61) r1 =3D *(u32 *)(r1 +0)         ; R1_w=3Dscalar(umax=3D4294967295=
,var_off=3D(0x0; 0xffffffff))
  ; if (skb->tstamp =3D=3D EGRESS_ENDHOST_MAGIC)
  11: (79) r2 =3D *(u64 *)(r6 +152)       ; R2_w=3Dscalar() R6=3Dctx(off=3D=
0,imm=3D0)
  ; if (skb->tstamp =3D=3D EGRESS_ENDHOST_MAGIC)
  12: (55) if r2 !=3D 0xb9fbeef goto pc+10        ; R2_w=3D195018479
  13: (bc) w2 =3D w1                      ; R1_w=3Dscalar(id=3D6,umax=3D429=
4967295,var_off=3D(0x0; 0xffffffff)) R2_w=3Dscalar(id=3D6,umax=3D4294967295=
,var_off=3D(0x0; 0xffffffff))
  ; if (test < __NR_TESTS)
  14: (a6) if w1 < 0x9 goto pc+1        ; R1_w=3Dscalar(id=3D6,umin=3D9,uma=
x=3D4294967295,var_off=3D(0x0; 0xffffffff))
  ...
  from 14 to 16: R0=3D2 R1_w=3Dscalar(id=3D6,umax=3D8,var_off=3D(0x0; 0xf))=
 R2_w=3Dscalar(id=3D6,umax=3D8,var_off=3D(0x0; 0xf)) R6=3Dctx(off=3D0,imm=
=3D0) R10=3Dfp0
  16: (27) r2 *=3D 28                     ; R2_w=3Dscalar(umax=3D224,var_of=
f=3D(0x0; 0xfc))
  17: (18) r3 =3D 0xffffc9000048e118      ; R3_w=3Dmap_value(off=3D280,ks=
=3D4,vs=3D564,imm=3D0)
  19: (0f) r3 +=3D r2
  20: (61) r2 =3D *(u32 *)(r3 +0)         ; R2_w=3Dscalar(umax=3D4294967295=
,var_off=3D(0x0; 0xffffffff)) R3_w=3Dmap_value(off=3D280,ks=3D4,vs=3D564,um=
ax=3D224,var_off=3D(0x0; 0xfc),s32_max=3D252,u32_max=3D252)
  ...

and eventually the bpf program can be verified successfully.

  [1] https://reviews.llvm.org/D147968

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d6db6de3e9ea..468f002d3248 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12409,12 +12409,17 @@ static int check_alu_op(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
 						insn->src_reg);
 					return -EACCES;
 				} else if (src_reg->type =3D=3D SCALAR_VALUE) {
+					bool is_src_reg_u32 =3D src_reg->umax_value <=3D U32_MAX;
+
+					if (is_src_reg_u32 && !src_reg->id)
+						src_reg->id =3D ++env->id_gen;
 					copy_register_state(dst_reg, src_reg);
-					/* Make sure ID is cleared otherwise
+					/* Make sure ID is cleared if src_reg is not in u32 range otherwise
 					 * dst_reg min/max could be incorrectly
 					 * propagated into src_reg by find_equal_scalars()
 					 */
-					dst_reg->id =3D 0;
+					if (!is_src_reg_u32)
+						dst_reg->id =3D 0;
 					dst_reg->live |=3D REG_LIVE_WRITTEN;
 					dst_reg->subreg_def =3D env->insn_idx + 1;
 				} else {
--=20
2.34.1

