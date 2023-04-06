Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126A66D9DBE
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 18:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239593AbjDFQpl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 12:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239614AbjDFQpT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 12:45:19 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4377155AE
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 09:45:18 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 336EBe1n022416
        for <bpf@vger.kernel.org>; Thu, 6 Apr 2023 09:45:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=wZi4kX+AuVHLRYnNvK+ZiQ4T1Krrg2Mv/jUvf3Wi6Mk=;
 b=fYglI4g4UHXthEDAW9qodbAoAwaS2yK2DlePxFdAfCr6PrPInQYdvbnP+5eZn5IeDyuA
 JA6QebceBt0QUdICSx0XGht2GBY/pVcG9unbiFIJjJs0FEJqCKqe5h8WnzimDoADC1ll
 ZXTvrQRMNGOgNrnYUXl5xxK6u1C8o9uaZYc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3psym6h50q-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 09:45:17 -0700
Received: from twshared16996.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 6 Apr 2023 09:45:16 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 03F981C5BEEB2; Thu,  6 Apr 2023 09:45:11 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Add verifier tests for code pattern '<const> <cond_op> <non_const>'
Date:   Thu, 6 Apr 2023 09:45:10 -0700
Message-ID: <20230406164510.1047757-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230406164450.1044952-1-yhs@fb.com>
References: <20230406164450.1044952-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 9FFLWURBWl4WW7RFvQ_6eA2S58sn1J3n
X-Proofpoint-ORIG-GUID: 9FFLWURBWl4WW7RFvQ_6eA2S58sn1J3n
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

Add various tests for code pattern '<const> <cond_op> <non_const>' to
exercise the previous verifier patch.

The following are veristat changed number of processed insns stat
comparing the previous patch vs. this patch:

File                                                   Program           =
                                    Insns (A)  Insns (B)  Insns  (DIFF)
-----------------------------------------------------  ------------------=
----------------------------------  ---------  ---------  -------------
test_seg6_loop.bpf.linked3.o                           __add_egr_x       =
                                        12423      12314  -109 (-0.88%)

Only one program is affected with minor change.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../verifier_bounds_deduction_non_const.c     | 460 ++++++++++++++++++
 1 file changed, 460 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_deduction_=
non_const.c b/tools/testing/selftests/bpf/progs/verifier_bounds_deduction=
_non_const.c
index fe570d866139..823f727cf210 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds_deduction_non_con=
st.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds_deduction_non_con=
st.c
@@ -176,4 +176,464 @@ l1_%=3D:							\
 	: __clobber_all);
 }
=20
+SEC("socket")
+__description("check deducing bounds from non-const, jmp64, <const> > <n=
on_const>, 1")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_9(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	r2 =3D 0;						\
+	if r2 > r0 goto l0_%=3D;				\
+	r0 =3D 0;						\
+	exit;						\
+l0_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp64, <const> > <n=
on_const>, 2")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_10(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if r0 < 4 goto l0_%=3D;				\
+	r2 =3D 4;						\
+	if r2 > r0 goto l1_%=3D;				\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp64, <const> >=3D=
 <non_const>")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_11(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if r0 < 4 goto l0_%=3D;				\
+	r2 =3D 3;						\
+	if r2 >=3D r0 goto l1_%=3D;				\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp64, <const> < <n=
on_const>")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_12(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if r0 > 4 goto l0_%=3D;				\
+	r2 =3D 4;						\
+	if r2 < r0 goto l1_%=3D;				\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp64, <const> <=3D=
 <non_const>")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_13(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if r0 >=3D 4 goto l0_%=3D;				\
+	r2 =3D 4;						\
+	if r2 <=3D r0 goto l1_%=3D;				\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp64, <const> =3D=3D=
 <non_const>")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_14(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if r0 < 3 goto l0_%=3D;				\
+	r2 =3D 2;						\
+	if r2 =3D=3D r0 goto l1_%=3D;				\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp64, <const> s> <=
non_const>")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_15(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if r0 s< 4 goto l0_%=3D;				\
+	r2 =3D 4;						\
+	if r2 s> r0 goto l1_%=3D;				\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp64, <const> s>=3D=
 <non_const>")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_16(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if r0 s< 4 goto l0_%=3D;				\
+	r2 =3D 3;						\
+	if r2 s>=3D r0 goto l1_%=3D;				\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp64, <const> s< <=
non_const>")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_17(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if r0 s> 4 goto l0_%=3D;				\
+	r2 =3D 4;						\
+	if r2 s< r0 goto l1_%=3D;				\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp64, <const> s<=3D=
 <non_const>")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_18(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if r0 s> 4 goto l0_%=3D;				\
+	r2 =3D 5;						\
+	if r2 s<=3D r0 goto l1_%=3D;				\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp64, <const> !=3D=
 <non_const>")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_19(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if r0 < 3 goto l0_%=3D;				\
+	r2 =3D 2;						\
+	if r2 !=3D r0 goto l0_%=3D;				\
+	goto l1_%=3D;					\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp32, <const> > <n=
on_const>, 1")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_20(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	w2 =3D 0;						\
+	if w2 > w0 goto l0_%=3D;				\
+	r0 =3D 0;						\
+	exit;						\
+l0_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp32, <const> > <n=
on_const>, 2")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_21(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if w0 < 4 goto l0_%=3D;				\
+	w2 =3D 4;						\
+	if w2 > w0 goto l1_%=3D;				\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp32, <const> >=3D=
 <non_const>")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_22(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if w0 < 4 goto l0_%=3D;				\
+	w2 =3D 3;						\
+	if w2 >=3D w0 goto l1_%=3D;				\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp32, <const> < <n=
on_const>")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_23(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if w0 > 4 goto l0_%=3D;				\
+	w2 =3D 4;						\
+	if w2 < w0 goto l1_%=3D;				\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp32, <const> <=3D=
 <non_const>")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_24(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if w0 >=3D 4 goto l0_%=3D;				\
+	w2 =3D 4;						\
+	if w2 <=3D w0 goto l1_%=3D;				\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp32, <const> =3D=3D=
 <non_const>")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_25(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if w0 < 4 goto l0_%=3D;				\
+	w2 =3D 3;						\
+	if w2 =3D=3D w0 goto l1_%=3D;				\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp32, <const> s> <=
non_const>")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_26(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if w0 s< 4 goto l0_%=3D;				\
+	w2 =3D 4;						\
+	if w2 s> w0 goto l1_%=3D;				\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp32, <const> s>=3D=
 <non_const>")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_27(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if w0 s< 4 goto l0_%=3D;				\
+	w2 =3D 3;						\
+	if w2 s>=3D w0 goto l1_%=3D;				\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp32, <const> s< <=
non_const>")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_28(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if w0 s> 4 goto l0_%=3D;				\
+	w2 =3D 5;						\
+	if w2 s< w0 goto l1_%=3D;				\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp32, <const> s<=3D=
 <non_const>")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_29(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if w0 s>=3D 4 goto l0_%=3D;				\
+	w2 =3D 4;						\
+	if w2 s<=3D w0 goto l1_%=3D;				\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp32, <const> !=3D=
 <non_const>")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_30(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if w0 < 3 goto l0_%=3D;				\
+	w2 =3D 2;						\
+	if w2 !=3D w0 goto l0_%=3D;				\
+	goto l1_%=3D;					\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.34.1

