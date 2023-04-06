Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BD16D9DC0
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 18:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239649AbjDFQpj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 12:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239595AbjDFQpJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 12:45:09 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA5D59DE
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 09:45:07 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 336EAggm020139
        for <bpf@vger.kernel.org>; Thu, 6 Apr 2023 09:45:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=eEv/twIXq35XQ6ztceAFnDq3j0MpT7bDXvOSv5OXOQg=;
 b=KX7ASFpC21XguRYixNVAzuJQ3JbNOxMIuFy9N2J3r+v9caB/UGe73qBxWEL8+QvpDvMZ
 tMlOeTJdo+gfMPe8OW8C80InSI4wjvV3HWcFHuel6sbPp0D1PjCWMo5hm0efT+87f1g6
 fWS9sAvI4HTxm8jLQxpbd3fg7OdG2AGkBUI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3psym6h4xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 09:45:06 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 6 Apr 2023 09:44:56 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 36B561C5BEDEB; Thu,  6 Apr 2023 09:44:50 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 0/4] bpf: Improve verifier for cond_op and spilled loop index variables
Date:   Thu, 6 Apr 2023 09:44:50 -0700
Message-ID: <20230406164450.1044952-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: J2E23KysSJ6ljuwrXcPIjJbn3vQ2FW_B
X-Proofpoint-ORIG-GUID: J2E23KysSJ6ljuwrXcPIjJbn3vQ2FW_B
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
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

LLVM commit [1] introduced hoistMinMax optimization like
  (i < VIRTIO_MAX_SGS) && (i < out_sgs)
to
  upper =3D MIN(VIRTIO_MAX_SGS, out_sgs)
  ... i < upper ...
and caused the verification failure. Commit [2] workarounded the issue by
adding some bpf assembly code to prohibit the above optimization.
This patch improved verifier such that verification can succeed without
the above workaround.

Without [2], the current verifier will hit the following failures:
  ...
  119: (15) if r1 =3D=3D 0x0 goto pc+1
  The sequence of 8193 jumps is too complex.
  verification time 525829 usec
  stack depth 64
  processed 156616 insns (limit 1000000) max_states_per_insn 8 total_states=
 1754 peak_states 1712 mark_read 12
  -- END PROG LOAD LOG --
  libbpf: prog 'trace_virtqueue_add_sgs': failed to load: -14
  libbpf: failed to load object 'loop6.bpf.o'
  ...
The failure is due to verifier inadequately handling '<const> <cond_op> <no=
n_const>' which will
go through both pathes and generate the following verificaiton states:
  ...
  89: (07) r2 +=3D 1                      ; R2_w=3D5
  90: (79) r8 =3D *(u64 *)(r10 -48)       ; R8_w=3Dscalar() R10=3Dfp0
  91: (79) r1 =3D *(u64 *)(r10 -56)       ; R1_w=3Dscalar(umax=3D5,var_off=
=3D(0x0; 0x7)) R10=3Dfp0
  92: (ad) if r2 < r1 goto pc+41        ; R0_w=3Dscalar() R1_w=3Dscalar(umi=
n=3D6,umax=3D5,var_off=3D(0x4; 0x3))
      R2_w=3D5 R6_w=3Dscalar(id=3D385) R7_w=3D0 R8_w=3Dscalar() R9_w=3Dscal=
ar(umax=3D21474836475,var_off=3D(0x0; 0x7ffffffff))
      R10=3Dfp0 fp-8=3Dmmmmmmmm fp-16=3Dmmmmmmmm fp-24=3Dmmmm???? fp-32=3D =
fp-40_w=3D4 fp-48=3Dmmmmmmmm fp-56=3D fp-64=3Dmmmmmmmm
  ...
  89: (07) r2 +=3D 1                      ; R2_w=3D6
  90: (79) r8 =3D *(u64 *)(r10 -48)       ; R8_w=3Dscalar() R10=3Dfp0
  91: (79) r1 =3D *(u64 *)(r10 -56)       ; R1_w=3Dscalar(umax=3D5,var_off=
=3D(0x0; 0x7)) R10=3Dfp0
  92: (ad) if r2 < r1 goto pc+41        ; R0_w=3Dscalar() R1_w=3Dscalar(umi=
n=3D7,umax=3D5,var_off=3D(0x4; 0x3))
      R2_w=3D6 R6=3Dscalar(id=3D388) R7=3D0 R8_w=3Dscalar() R9_w=3Dscalar(u=
max=3D25769803770,var_off=3D(0x0; 0x7ffffffff))
      R10=3Dfp0 fp-8=3Dmmmmmmmm fp-16=3Dmmmmmmmm fp-24=3Dmmmm???? fp-32=3D =
fp-40=3D5 fp-48=3Dmmmmmmmm fp-56=3D fp-64=3Dmmmmmmmm
    ...
  89: (07) r2 +=3D 1                      ; R2_w=3D4088
  90: (79) r8 =3D *(u64 *)(r10 -48)       ; R8_w=3Dscalar() R10=3Dfp0
  91: (79) r1 =3D *(u64 *)(r10 -56)       ; R1_w=3Dscalar(umax=3D5,var_off=
=3D(0x0; 0x7)) R10=3Dfp0
  92: (ad) if r2 < r1 goto pc+41        ; R0=3Dscalar() R1=3Dscalar(umin=3D=
4089,umax=3D5,var_off=3D(0x0; 0x7))
      R2=3D4088 R6=3Dscalar(id=3D12634) R7=3D0 R8=3Dscalar() R9=3Dscalar(um=
ax=3D17557826301960,var_off=3D(0x0; 0xfffffffffff))
      R10=3Dfp0 fp-8=3Dmmmmmmmm fp-16=3Dmmmmmmmm fp-24=3Dmmmm???? fp-32=3D =
fp-40=3D4087 fp-48=3Dmmmmmmmm fp-56=3D fp-64=3Dmmmmmmmm

Patch 3 fixed the above issue by handling '<const> <cond_op> <non_const>' p=
roperly.
During developing selftests for Patch 3, I found some issues with bound ded=
uction with
BPF_EQ/BPF_NE and fixed the issue in Patch 1.

After the above issue is fixed, the second issue shows up.
  ...
  67: (07) r1 +=3D -16                    ; R1_w=3Dfp-16
  ; bpf_probe_read_kernel(&sgp, sizeof(sgp), sgs + i);
  68: (b4) w2 =3D 8                       ; R2_w=3D8
  69: (85) call bpf_probe_read_kernel#113       ; R0_w=3Dscalar() fp-16=3Dm=
mmmmmmm
  ; return sgp;
  70: (79) r6 =3D *(u64 *)(r10 -16)       ; R6=3Dscalar() R10=3Dfp0
  ; for (n =3D 0, sgp =3D get_sgp(sgs, i); sgp && (n < SG_MAX);
  71: (15) if r6 =3D=3D 0x0 goto pc-49      ; R6=3Dscalar()
  72: (b4) w1 =3D 0                       ; R1_w=3D0
  73: (05) goto pc-46
  ; for (i =3D 0; (i < VIRTIO_MAX_SGS) && (i < out_sgs); i++) {
  28: (bc) w7 =3D w1                      ; R1_w=3D0 R7_w=3D0
  ; bpf_probe_read_kernel(&len, sizeof(len), &sgp->length);
  ...
  23: (79) r3 =3D *(u64 *)(r10 -40)       ; R3_w=3D2 R10=3Dfp0
  ; for (i =3D 0; (i < VIRTIO_MAX_SGS) && (i < out_sgs); i++) {
  24: (07) r3 +=3D 1                      ; R3_w=3D3
  ; for (i =3D 0; (i < VIRTIO_MAX_SGS) && (i < out_sgs); i++) {
  25: (79) r1 =3D *(u64 *)(r10 -56)       ; R1_w=3Dscalar(umax=3D5,var_off=
=3D(0x0; 0x7)) R10=3Dfp0
  26: (ad) if r3 < r1 goto pc+34 61: R0=3Dscalar() R1_w=3Dscalar(umin=3D4,u=
max=3D5,var_off=3D(0x4; 0x1)) R3_w=3D3 R6=3Dscalar(id=3D1658)
     R7=3D0 R8=3Dscalar(id=3D1653) R9=3Dscalar(umax=3D4294967295,var_off=3D=
(0x0; 0xffffffff)) R10=3Dfp0 fp-8=3Dmmmmmmmm fp-16=3Dmmmmmmmm
     fp-24=3Dmmmm???? fp-32=3D fp-40=3D2 fp-56=3D fp-64=3Dmmmmmmmm
  ; if (sg_is_chain(&sg))
  61: (7b) *(u64 *)(r10 -40) =3D r3       ; R3_w=3D3 R10=3Dfp0 fp-40_w=3D3
    ...
  67: (07) r1 +=3D -16                    ; R1_w=3Dfp-16
  ; bpf_probe_read_kernel(&sgp, sizeof(sgp), sgs + i);
  68: (b4) w2 =3D 8                       ; R2_w=3D8
  69: (85) call bpf_probe_read_kernel#113       ; R0_w=3Dscalar() fp-16=3Dm=
mmmmmmm
  ; return sgp;
  70: (79) r6 =3D *(u64 *)(r10 -16)
  ; for (n =3D 0, sgp =3D get_sgp(sgs, i); sgp && (n < SG_MAX);
  infinite loop detected at insn 71
  verification time 90800 usec
  stack depth 64
  processed 25017 insns (limit 1000000) max_states_per_insn 20 total_states=
 491 peak_states 169 mark_read 12
  -- END PROG LOAD LOG --
  libbpf: prog 'trace_virtqueue_add_sgs': failed to load: -22
=20=20
Further analysis found the index variable 'i' is spilled but since it is no=
t marked as precise.
This is more tricky as identifying induction variable is not easy in verifi=
er. Although a heuristic
is possible, let us leave it for now.

  [1] https://reviews.llvm.org/D143726
  [2] Commit 3c2611bac08a ("selftests/bpf: Fix trace_virtqueue_add_sgs test=
 issue with LLVM 17.")

Yonghong Song (4):
  bpf: Improve verifier JEQ/JNE insn branch taken checking
  selftests/bpf: Add tests for non-constant cond_op NE/EQ bound
    deduction
  bpf: Improve handling of pattern '<const> <cond_op> <non_const>' in
    verifier
  selftests/bpf: Add verifier tests for code pattern '<const> <cond_op>
    <non_const>'

 kernel/bpf/verifier.c                         |  20 +
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../verifier_bounds_deduction_non_const.c     | 639 ++++++++++++++++++
 .../progs/verifier_bounds_mix_sign_unsign.c   |   2 +-
 4 files changed, 662 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bounds_deduc=
tion_non_const.c

--=20
2.34.1

