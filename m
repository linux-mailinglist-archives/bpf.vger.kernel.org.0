Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F8A54A2CB
	for <lists+bpf@lfdr.de>; Tue, 14 Jun 2022 01:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbiFMXfB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 19:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbiFMXe7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 19:34:59 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC003207C
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 16:34:57 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DFSOkk026869
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 16:34:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=ger9X5gKDs13t9VEIHqbJrv/huhTOZSgQhBWmvdBQU4=;
 b=MP96RUGjjSypGtDJp/QzT90GRmAkZV6OhU6ox9wSjNIi/jMZ0S4zzz/saCVd3G34AJsR
 O/IC7NDh3n6wkqZD9+NILuX8S9/dWL0Y8EuTsoWgAQJzoSv7CF4IgVw37PLEMDkgFnR5
 GA+lKVPnwm89A0MojO1eJsRKTDOdmFhWZeI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gmr5sc3ca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 16:34:57 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub101.TheFacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 13 Jun 2022 16:34:56 -0700
Received: from twshared22934.08.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 13 Jun 2022 16:34:56 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id EBE6AB91CCE3; Mon, 13 Jun 2022 16:34:49 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: Fix test_varlen verification failure with latest llvm
Date:   Mon, 13 Jun 2022 16:34:49 -0700
Message-ID: <20220613233449.2860753-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JG0_Piuzc11pyQlt1GhT25-PpuJ_XLNn
X-Proofpoint-GUID: JG0_Piuzc11pyQlt1GhT25-PpuJ_XLNn
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-13_09,2022-06-13_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With latest llvm15, test_varlen failed with the following verifier log:

  17: (85) call bpf_probe_read_kernel_str#115   ; R0_w=3Dscalar(smin=3D-409=
5,smax=3D256)
  18: (bf) r1 =3D r0                      ; R0_w=3Dscalar(id=3D1,smin=3D-40=
95,smax=3D256) R1_w=3Dscalar(id=3D1,smin=3D-4095,smax=3D256)
  19: (67) r1 <<=3D 32                    ; R1_w=3Dscalar(smax=3D1099511627=
776,umax=3D18446744069414584320,var_off=3D(0x0; 0xffffffff00000000),s32_min=
=3D0,s32_max=3D0,u32_max=3D)
  20: (bf) r2 =3D r1                      ; R1_w=3Dscalar(id=3D2,smax=3D109=
9511627776,umax=3D18446744069414584320,var_off=3D(0x0; 0xffffffff00000000),=
s32_min=3D0,s32_max=3D0,u32)
  21: (c7) r2 s>>=3D 32                   ; R2=3Dscalar(smin=3D-2147483648,=
smax=3D256)
  ; if (len >=3D 0) {
  22: (c5) if r2 s< 0x0 goto pc+7       ; R2=3Dscalar(umax=3D256,var_off=3D=
(0x0; 0x1ff))
  ; payload4_len1 =3D len;
  23: (18) r2 =3D 0xffffc90000167418      ; R2_w=3Dmap_value(off=3D1048,ks=
=3D4,vs=3D1572,imm=3D0)
  25: (63) *(u32 *)(r2 +0) =3D r0         ; R0=3Dscalar(id=3D1,smin=3D-4095=
,smax=3D256) R2_w=3Dmap_value(off=3D1048,ks=3D4,vs=3D1572,imm=3D0)
  26: (77) r1 >>=3D 32                    ; R1_w=3Dscalar(umax=3D4294967295=
,var_off=3D(0x0; 0xffffffff))
  ; payload +=3D len;
  27: (18) r6 =3D 0xffffc90000167424      ; R6_w=3Dmap_value(off=3D1060,ks=
=3D4,vs=3D1572,imm=3D0)
  29: (0f) r6 +=3D r1                     ; R1_w=3DPscalar(umax=3D429496729=
5,var_off=3D(0x0; 0xffffffff)) R6_w=3Dmap_value(off=3D1060,ks=3D4,vs=3D1572=
,umax=3D4294967295,var_off=3D(0)
  ; len =3D bpf_probe_read_kernel_str(payload, MAX_LEN, &buf_in2[0]);
  30: (bf) r1 =3D r6                      ; R1_w=3Dmap_value(off=3D1060,ks=
=3D4,vs=3D1572,umax=3D4294967295,var_off=3D(0x0; 0xffffffff)) R6_w=3Dmap_va=
lue(off=3D1060,ks=3D4,vs=3D1572,um)
  31: (b7) r2 =3D 256                     ; R2_w=3D256
  32: (18) r3 =3D 0xffffc90000164100      ; R3_w=3Dmap_value(off=3D256,ks=
=3D4,vs=3D1056,imm=3D0)
  34: (85) call bpf_probe_read_kernel_str#115
  R1 unbounded memory access, make sure to bounds check any such access
  processed 27 insns (limit 1000000) max_states_per_insn 0 total_states 2 p=
eak_states 2 mark_read 1
  -- END PROG LOAD LOG --
  libbpf: failed to load program 'handler32_signed'

The failure is due to
  20: (bf) r2 =3D r1                      ; R1_w=3Dscalar(id=3D2,smax=3D109=
9511627776,umax=3D18446744069414584320,var_off=3D(0x0; 0xffffffff00000000),=
s32_min=3D0,s32_max=3D0,u32)
  21: (c7) r2 s>>=3D 32                   ; R2=3Dscalar(smin=3D-2147483648,=
smax=3D256)
  22: (c5) if r2 s< 0x0 goto pc+7       ; R2=3Dscalar(umax=3D256,var_off=3D=
(0x0; 0x1ff))
  26: (77) r1 >>=3D 32                    ; R1_w=3Dscalar(umax=3D4294967295=
,var_off=3D(0x0; 0xffffffff))
  29: (0f) r6 +=3D r1                     ; R1_w=3DPscalar(umax=3D429496729=
5,var_off=3D(0x0; 0xffffffff)) R6_w=3Dmap_value(off=3D1060,ks=3D4,vs=3D1572=
,umax=3D4294967295,var_off=3D(0)
where r1 has conservative value range compared to r2 and r1 is used later.

In llvm, commit [1] triggered the above code generation and caused
verification failure.

It may take a while for llvm to address this issue. In the main time,
let us change the variable 'len' type to 'long' and adjust condition proper=
ly.
Tested with llvm14 and latest llvm15, both worked fine.

 [1] https://reviews.llvm.org/D126647

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/progs/test_varlen.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_varlen.c b/tools/testin=
g/selftests/bpf/progs/test_varlen.c
index 913acdffd90f..3987ff174f1f 100644
--- a/tools/testing/selftests/bpf/progs/test_varlen.c
+++ b/tools/testing/selftests/bpf/progs/test_varlen.c
@@ -41,20 +41,20 @@ int handler64_unsigned(void *regs)
 {
 	int pid =3D bpf_get_current_pid_tgid() >> 32;
 	void *payload =3D payload1;
-	u64 len;
+	long len;
=20
 	/* ignore irrelevant invocations */
 	if (test_pid !=3D pid || !capture)
 		return 0;
=20
 	len =3D bpf_probe_read_kernel_str(payload, MAX_LEN, &buf_in1[0]);
-	if (len <=3D MAX_LEN) {
+	if (len >=3D 0) {
 		payload +=3D len;
 		payload1_len1 =3D len;
 	}
=20
 	len =3D bpf_probe_read_kernel_str(payload, MAX_LEN, &buf_in2[0]);
-	if (len <=3D MAX_LEN) {
+	if (len >=3D 0) {
 		payload +=3D len;
 		payload1_len2 =3D len;
 	}
@@ -123,7 +123,7 @@ int handler32_signed(void *regs)
 {
 	int pid =3D bpf_get_current_pid_tgid() >> 32;
 	void *payload =3D payload4;
-	int len;
+	long len;
=20
 	/* ignore irrelevant invocations */
 	if (test_pid !=3D pid || !capture)
--=20
2.30.2

