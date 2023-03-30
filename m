Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894396CFB04
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 07:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjC3F4d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 01:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjC3F4b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 01:56:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AD0619C
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 22:56:29 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32TKh3G6016420
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 22:56:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=UbVCiGoXCwxLbsdAhlMoFHg32DY/nVf0gg3KJdFQsRk=;
 b=JsUW4TDWC9YzgRxM4QuRTEk4gVFV8hVdqC0jdHg5ug38UaVzgpVB7ZG26jgUA62INiyv
 7xFitC+fCTno6I4k6SzhVaEgxa0k2PGPEPxHyNqMacGaYZEOth75O/EdjUhkIxf1+GMT
 LxoND+Tb6Bs+DKwQSBUHO3OFLXMCe03Qa6o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pmvkmtndm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 22:56:29 -0700
Received: from twshared8568.05.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 29 Mar 2023 22:56:27 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id B8AC81BA2D821; Wed, 29 Mar 2023 22:56:20 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 4/7] selftests/bpf: Add verifier tests for code pattern '<const> <cond_op> <non_const>'
Date:   Wed, 29 Mar 2023 22:56:20 -0700
Message-ID: <20230330055620.91308-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330055600.86870-1-yhs@fb.com>
References: <20230330055600.86870-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Exg6Yt8RuxE7dn6TTa5PhQ5l0OTDuqct
X-Proofpoint-ORIG-GUID: Exg6Yt8RuxE7dn6TTa5PhQ5l0OTDuqct
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

Add various tests for code pattern '<const> <cond_op> <non_const>' to
exercise the previous verifier patch.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../verifier_bounds_deduction_non_const.c     | 460 ++++++++++++++++++
 1 file changed, 460 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_deduction_=
non_const.c b/tools/testing/selftests/bpf/progs/verifier_bounds_deduction=
_non_const.c
index c07af47c489e..3cb7763869bc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds_deduction_non_con=
st.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds_deduction_non_con=
st.c
@@ -90,4 +90,464 @@ l1_%=3D:							\
 	: __clobber_all);
 }
=20
+SEC("socket")
+__description("check deducing bounds from non-const, jmp64, <const> > <n=
on_const>, 1")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_5(void)
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
+__naked void deducing_bounds_from_non_const_6(void)
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
+__naked void deducing_bounds_from_non_const_7(void)
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
+__naked void deducing_bounds_from_non_const_8(void)
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
+__naked void deducing_bounds_from_non_const_9(void)
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
+__naked void deducing_bounds_from_non_const_10(void)
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
+__naked void deducing_bounds_from_non_const_11(void)
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
+__naked void deducing_bounds_from_non_const_12(void)
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
+__naked void deducing_bounds_from_non_const_13(void)
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
+__naked void deducing_bounds_from_non_const_14(void)
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
+__naked void deducing_bounds_from_non_const_15(void)
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
+__naked void deducing_bounds_from_non_const_16(void)
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
+__naked void deducing_bounds_from_non_const_17(void)
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
+__naked void deducing_bounds_from_non_const_18(void)
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
+__naked void deducing_bounds_from_non_const_19(void)
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
+__naked void deducing_bounds_from_non_const_20(void)
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
+__naked void deducing_bounds_from_non_const_21(void)
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
+__naked void deducing_bounds_from_non_const_22(void)
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
+__naked void deducing_bounds_from_non_const_23(void)
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
+__naked void deducing_bounds_from_non_const_24(void)
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
+__naked void deducing_bounds_from_non_const_25(void)
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
+__naked void deducing_bounds_from_non_const_26(void)
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

