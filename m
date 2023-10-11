Return-Path: <bpf+bounces-11966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83357C6069
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 00:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D43F2824EF
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 22:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3F212E59;
	Wed, 11 Oct 2023 22:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCA8568B
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 22:37:49 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD1BC4
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:37:46 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BLKL9v011989
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:37:45 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tnu0qd6tt-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:37:45 -0700
Received: from twshared68648.02.prn6.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 11 Oct 2023 15:37:42 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 78BCA3995129F; Wed, 11 Oct 2023 15:37:36 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 3/5] selftests/bpf: make align selftests more robust
Date: Wed, 11 Oct 2023 15:37:26 -0700
Message-ID: <20231011223728.3188086-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011223728.3188086-1-andrii@kernel.org>
References: <20231011223728.3188086-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6Z6FW6rMPhigPYcU2iOuUQjtV1qEnaGa
X-Proofpoint-GUID: 6Z6FW6rMPhigPYcU2iOuUQjtV1qEnaGa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_18,2023-10-11_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Align subtest is very specific and finicky about expected verifier log
output and format. This is often completely unnecessary as in a bunch of
situations test actually cares about var_off part of register state. But
given how exact it is right now, any tiny verifier log changes can lead
to align tests failures, requiring constant adjustment.

This patch tries to make this a bit more robust by making logic first
search for specified register and then allowing to match only portion of
register state, not everything exactly. This will come handly with
follow up changes to SCALAR register output disambiguation.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/align.c  | 241 +++++++++---------
 1 file changed, 121 insertions(+), 120 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/testi=
ng/selftests/bpf/prog_tests/align.c
index b92770592563..465c1c3a3d3c 100644
--- a/tools/testing/selftests/bpf/prog_tests/align.c
+++ b/tools/testing/selftests/bpf/prog_tests/align.c
@@ -6,6 +6,7 @@
=20
 struct bpf_reg_match {
 	unsigned int line;
+	const char *reg;
 	const char *match;
 };
=20
@@ -39,13 +40,13 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{0, "R1=3Dctx(off=3D0,imm=3D0)"},
-			{0, "R10=3Dfp0"},
-			{0, "R3_w=3D2"},
-			{1, "R3_w=3D4"},
-			{2, "R3_w=3D8"},
-			{3, "R3_w=3D16"},
-			{4, "R3_w=3D32"},
+			{0, "R1", "ctx(off=3D0,imm=3D0)"},
+			{0, "R10", "fp0"},
+			{0, "R3_w", "2"},
+			{1, "R3_w", "4"},
+			{2, "R3_w", "8"},
+			{3, "R3_w", "16"},
+			{4, "R3_w", "32"},
 		},
 	},
 	{
@@ -67,19 +68,19 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{0, "R1=3Dctx(off=3D0,imm=3D0)"},
-			{0, "R10=3Dfp0"},
-			{0, "R3_w=3D1"},
-			{1, "R3_w=3D2"},
-			{2, "R3_w=3D4"},
-			{3, "R3_w=3D8"},
-			{4, "R3_w=3D16"},
-			{5, "R3_w=3D1"},
-			{6, "R4_w=3D32"},
-			{7, "R4_w=3D16"},
-			{8, "R4_w=3D8"},
-			{9, "R4_w=3D4"},
-			{10, "R4_w=3D2"},
+			{0, "R1", "ctx(off=3D0,imm=3D0)"},
+			{0, "R10", "fp0"},
+			{0, "R3_w", "1"},
+			{1, "R3_w", "2"},
+			{2, "R3_w", "4"},
+			{3, "R3_w", "8"},
+			{4, "R3_w", "16"},
+			{5, "R3_w", "1"},
+			{6, "R4_w", "32"},
+			{7, "R4_w", "16"},
+			{8, "R4_w", "8"},
+			{9, "R4_w", "4"},
+			{10, "R4_w", "2"},
 		},
 	},
 	{
@@ -96,14 +97,14 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{0, "R1=3Dctx(off=3D0,imm=3D0)"},
-			{0, "R10=3Dfp0"},
-			{0, "R3_w=3D4"},
-			{1, "R3_w=3D8"},
-			{2, "R3_w=3D10"},
-			{3, "R4_w=3D8"},
-			{4, "R4_w=3D12"},
-			{5, "R4_w=3D14"},
+			{0, "R1", "ctx(off=3D0,imm=3D0)"},
+			{0, "R10", "fp0"},
+			{0, "R3_w", "4"},
+			{1, "R3_w", "8"},
+			{2, "R3_w", "10"},
+			{3, "R4_w", "8"},
+			{4, "R4_w", "12"},
+			{5, "R4_w", "14"},
 		},
 	},
 	{
@@ -118,12 +119,12 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{0, "R1=3Dctx(off=3D0,imm=3D0)"},
-			{0, "R10=3Dfp0"},
-			{0, "R3_w=3D7"},
-			{1, "R3_w=3D7"},
-			{2, "R3_w=3D14"},
-			{3, "R3_w=3D56"},
+			{0, "R1", "ctx(off=3D0,imm=3D0)"},
+			{0, "R10", "fp0"},
+			{0, "R3_w", "7"},
+			{1, "R3_w", "7"},
+			{2, "R3_w", "14"},
+			{3, "R3_w", "56"},
 		},
 	},
=20
@@ -161,19 +162,19 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{6, "R0_w=3Dpkt(off=3D8,r=3D8,imm=3D0)"},
-			{6, "R3_w=3Dscalar(umax=3D255,var_off=3D(0x0; 0xff))"},
-			{7, "R3_w=3Dscalar(umax=3D510,var_off=3D(0x0; 0x1fe))"},
-			{8, "R3_w=3Dscalar(umax=3D1020,var_off=3D(0x0; 0x3fc))"},
-			{9, "R3_w=3Dscalar(umax=3D2040,var_off=3D(0x0; 0x7f8))"},
-			{10, "R3_w=3Dscalar(umax=3D4080,var_off=3D(0x0; 0xff0))"},
-			{12, "R3_w=3Dpkt_end(off=3D0,imm=3D0)"},
-			{17, "R4_w=3Dscalar(umax=3D255,var_off=3D(0x0; 0xff))"},
-			{18, "R4_w=3Dscalar(umax=3D8160,var_off=3D(0x0; 0x1fe0))"},
-			{19, "R4_w=3Dscalar(umax=3D4080,var_off=3D(0x0; 0xff0))"},
-			{20, "R4_w=3Dscalar(umax=3D2040,var_off=3D(0x0; 0x7f8))"},
-			{21, "R4_w=3Dscalar(umax=3D1020,var_off=3D(0x0; 0x3fc))"},
-			{22, "R4_w=3Dscalar(umax=3D510,var_off=3D(0x0; 0x1fe))"},
+			{6, "R0_w", "pkt(off=3D8,r=3D8,imm=3D0)"},
+			{6, "R3_w", "var_off=3D(0x0; 0xff)"},
+			{7, "R3_w", "var_off=3D(0x0; 0x1fe)"},
+			{8, "R3_w", "var_off=3D(0x0; 0x3fc)"},
+			{9, "R3_w", "var_off=3D(0x0; 0x7f8)"},
+			{10, "R3_w", "var_off=3D(0x0; 0xff0)"},
+			{12, "R3_w", "pkt_end(off=3D0,imm=3D0)"},
+			{17, "R4_w", "var_off=3D(0x0; 0xff)"},
+			{18, "R4_w", "var_off=3D(0x0; 0x1fe0)"},
+			{19, "R4_w", "var_off=3D(0x0; 0xff0)"},
+			{20, "R4_w", "var_off=3D(0x0; 0x7f8)"},
+			{21, "R4_w", "var_off=3D(0x0; 0x3fc)"},
+			{22, "R4_w", "var_off=3D(0x0; 0x1fe)"},
 		},
 	},
 	{
@@ -194,16 +195,16 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{6, "R3_w=3Dscalar(umax=3D255,var_off=3D(0x0; 0xff))"},
-			{7, "R4_w=3Dscalar(id=3D1,umax=3D255,var_off=3D(0x0; 0xff))"},
-			{8, "R4_w=3Dscalar(umax=3D255,var_off=3D(0x0; 0xff))"},
-			{9, "R4_w=3Dscalar(id=3D1,umax=3D255,var_off=3D(0x0; 0xff))"},
-			{10, "R4_w=3Dscalar(umax=3D510,var_off=3D(0x0; 0x1fe))"},
-			{11, "R4_w=3Dscalar(id=3D1,umax=3D255,var_off=3D(0x0; 0xff))"},
-			{12, "R4_w=3Dscalar(umax=3D1020,var_off=3D(0x0; 0x3fc))"},
-			{13, "R4_w=3Dscalar(id=3D1,umax=3D255,var_off=3D(0x0; 0xff))"},
-			{14, "R4_w=3Dscalar(umax=3D2040,var_off=3D(0x0; 0x7f8))"},
-			{15, "R4_w=3Dscalar(umax=3D4080,var_off=3D(0x0; 0xff0))"},
+			{6, "R3_w", "var_off=3D(0x0; 0xff)"},
+			{7, "R4_w", "var_off=3D(0x0; 0xff)"},
+			{8, "R4_w", "var_off=3D(0x0; 0xff)"},
+			{9, "R4_w", "var_off=3D(0x0; 0xff)"},
+			{10, "R4_w", "var_off=3D(0x0; 0x1fe)"},
+			{11, "R4_w", "var_off=3D(0x0; 0xff)"},
+			{12, "R4_w", "var_off=3D(0x0; 0x3fc)"},
+			{13, "R4_w", "var_off=3D(0x0; 0xff)"},
+			{14, "R4_w", "var_off=3D(0x0; 0x7f8)"},
+			{15, "R4_w", "var_off=3D(0x0; 0xff0)"},
 		},
 	},
 	{
@@ -234,14 +235,14 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{2, "R5_w=3Dpkt(off=3D0,r=3D0,imm=3D0)"},
-			{4, "R5_w=3Dpkt(off=3D14,r=3D0,imm=3D0)"},
-			{5, "R4_w=3Dpkt(off=3D14,r=3D0,imm=3D0)"},
-			{9, "R2=3Dpkt(off=3D0,r=3D18,imm=3D0)"},
-			{10, "R5=3Dpkt(off=3D14,r=3D18,imm=3D0)"},
-			{10, "R4_w=3Dscalar(umax=3D255,var_off=3D(0x0; 0xff))"},
-			{13, "R4_w=3Dscalar(umax=3D65535,var_off=3D(0x0; 0xffff))"},
-			{14, "R4_w=3Dscalar(umax=3D65535,var_off=3D(0x0; 0xffff))"},
+			{2, "R5_w", "pkt(off=3D0,r=3D0,imm=3D0)"},
+			{4, "R5_w", "pkt(off=3D14,r=3D0,imm=3D0)"},
+			{5, "R4_w", "pkt(off=3D14,r=3D0,imm=3D0)"},
+			{9, "R2", "pkt(off=3D0,r=3D18,imm=3D0)"},
+			{10, "R5", "pkt(off=3D14,r=3D18,imm=3D0)"},
+			{10, "R4_w", "var_off=3D(0x0; 0xff)"},
+			{13, "R4_w", "var_off=3D(0x0; 0xffff)"},
+			{14, "R4_w", "var_off=3D(0x0; 0xffff)"},
 		},
 	},
 	{
@@ -298,20 +299,20 @@ static struct bpf_align_test tests[] =3D {
 			/* Calculated offset in R6 has unknown value, but known
 			 * alignment of 4.
 			 */
-			{6, "R2_w=3Dpkt(off=3D0,r=3D8,imm=3D0)"},
-			{7, "R6_w=3Dscalar(umax=3D1020,var_off=3D(0x0; 0x3fc))"},
+			{6, "R2_w", "pkt(off=3D0,r=3D8,imm=3D0)"},
+			{7, "R6_w", "var_off=3D(0x0; 0x3fc)"},
 			/* Offset is added to packet pointer R5, resulting in
 			 * known fixed offset, and variable offset from R6.
 			 */
-			{11, "R5_w=3Dpkt(id=3D1,off=3D14,r=3D0,umax=3D1020,var_off=3D(0x0; 0x=
3fc))"},
+			{11, "R5_w", "pkt(id=3D1,off=3D14,"},
 			/* At the time the word size load is performed from R5,
 			 * it's total offset is NET_IP_ALIGN + reg->off (0) +
 			 * reg->aux_off (14) which is 16.  Then the variable
 			 * offset is considered using reg->aux_off_align which
 			 * is 4 and meets the load's requirements.
 			 */
-			{15, "R4=3Dpkt(id=3D1,off=3D18,r=3D18,umax=3D1020,var_off=3D(0x0; 0x3=
fc))"},
-			{15, "R5=3Dpkt(id=3D1,off=3D14,r=3D18,umax=3D1020,var_off=3D(0x0; 0x3=
fc))"},
+			{15, "R4", "var_off=3D(0x0; 0x3fc)"},
+			{15, "R5", "var_off=3D(0x0; 0x3fc)"},
 			/* Variable offset is added to R5 packet pointer,
 			 * resulting in auxiliary alignment of 4. To avoid BPF
 			 * verifier's precision backtracking logging
@@ -319,46 +320,46 @@ static struct bpf_align_test tests[] =3D {
 			 * instruction to validate R5 state. We also check
 			 * that R4 is what it should be in such case.
 			 */
-			{18, "R4_w=3Dpkt(id=3D2,off=3D0,r=3D0,umax=3D1020,var_off=3D(0x0; 0x3=
fc))"},
-			{18, "R5_w=3Dpkt(id=3D2,off=3D0,r=3D0,umax=3D1020,var_off=3D(0x0; 0x3=
fc))"},
+			{18, "R4_w", "var_off=3D(0x0; 0x3fc)"},
+			{18, "R5_w", "var_off=3D(0x0; 0x3fc)"},
 			/* Constant offset is added to R5, resulting in
 			 * reg->off of 14.
 			 */
-			{19, "R5_w=3Dpkt(id=3D2,off=3D14,r=3D0,umax=3D1020,var_off=3D(0x0; 0x=
3fc))"},
+			{19, "R5_w", "pkt(id=3D2,off=3D14,"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off
 			 * (14) which is 16.  Then the variable offset is 4-byte
 			 * aligned, so the total offset is 4-byte aligned and
 			 * meets the load's requirements.
 			 */
-			{24, "R4=3Dpkt(id=3D2,off=3D18,r=3D18,umax=3D1020,var_off=3D(0x0; 0x3=
fc))"},
-			{24, "R5=3Dpkt(id=3D2,off=3D14,r=3D18,umax=3D1020,var_off=3D(0x0; 0x3=
fc))"},
+			{24, "R4", "var_off=3D(0x0; 0x3fc)"},
+			{24, "R5", "var_off=3D(0x0; 0x3fc)"},
 			/* Constant offset is added to R5 packet pointer,
 			 * resulting in reg->off value of 14.
 			 */
-			{26, "R5_w=3Dpkt(off=3D14,r=3D8"},
+			{26, "R5_w", "pkt(off=3D14,r=3D8,"},
 			/* Variable offset is added to R5, resulting in a
 			 * variable offset of (4n). See comment for insn #18
 			 * for R4 =3D R5 trick.
 			 */
-			{28, "R4_w=3Dpkt(id=3D3,off=3D14,r=3D0,umax=3D1020,var_off=3D(0x0; 0x=
3fc))"},
-			{28, "R5_w=3Dpkt(id=3D3,off=3D14,r=3D0,umax=3D1020,var_off=3D(0x0; 0x=
3fc))"},
+			{28, "R4_w", "var_off=3D(0x0; 0x3fc)"},
+			{28, "R5_w", "var_off=3D(0x0; 0x3fc)"},
 			/* Constant is added to R5 again, setting reg->off to 18. */
-			{29, "R5_w=3Dpkt(id=3D3,off=3D18,r=3D0,umax=3D1020,var_off=3D(0x0; 0x=
3fc))"},
+			{29, "R5_w", "pkt(id=3D3,off=3D18,"},
 			/* And once more we add a variable; resulting var_off
 			 * is still (4n), fixed offset is not changed.
 			 * Also, we create a new reg->id.
 			 */
-			{31, "R4_w=3Dpkt(id=3D4,off=3D18,r=3D0,umax=3D2040,var_off=3D(0x0; 0x=
7fc)"},
-			{31, "R5_w=3Dpkt(id=3D4,off=3D18,r=3D0,umax=3D2040,var_off=3D(0x0; 0x=
7fc)"},
+			{31, "R4_w", "var_off=3D(0x0; 0x7fc)"},
+			{31, "R5_w", "var_off=3D(0x0; 0x7fc)"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off (18)
 			 * which is 20.  Then the variable offset is (4n), so
 			 * the total offset is 4-byte aligned and meets the
 			 * load's requirements.
 			 */
-			{35, "R4=3Dpkt(id=3D4,off=3D22,r=3D22,umax=3D2040,var_off=3D(0x0; 0x7=
fc)"},
-			{35, "R5=3Dpkt(id=3D4,off=3D18,r=3D22,umax=3D2040,var_off=3D(0x0; 0x7=
fc)"},
+			{35, "R4", "var_off=3D(0x0; 0x7fc)"},
+			{35, "R5", "var_off=3D(0x0; 0x7fc)"},
 		},
 	},
 	{
@@ -396,36 +397,36 @@ static struct bpf_align_test tests[] =3D {
 			/* Calculated offset in R6 has unknown value, but known
 			 * alignment of 4.
 			 */
-			{6, "R2_w=3Dpkt(off=3D0,r=3D8,imm=3D0)"},
-			{7, "R6_w=3Dscalar(umax=3D1020,var_off=3D(0x0; 0x3fc))"},
+			{6, "R2_w", "pkt(off=3D0,r=3D8,imm=3D0)"},
+			{7, "R6_w", "var_off=3D(0x0; 0x3fc)"},
 			/* Adding 14 makes R6 be (4n+2) */
-			{8, "R6_w=3Dscalar(umin=3D14,umax=3D1034,var_off=3D(0x2; 0x7fc))"},
+			{8, "R6_w", "var_off=3D(0x2; 0x7fc)"},
 			/* Packet pointer has (4n+2) offset */
-			{11, "R5_w=3Dpkt(id=3D1,off=3D0,r=3D0,umin=3D14,umax=3D1034,var_off=3D=
(0x2; 0x7fc)"},
-			{12, "R4=3Dpkt(id=3D1,off=3D4,r=3D0,umin=3D14,umax=3D1034,var_off=3D(=
0x2; 0x7fc)"},
+			{11, "R5_w", "var_off=3D(0x2; 0x7fc)"},
+			{12, "R4", "var_off=3D(0x2; 0x7fc)"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off (0)
 			 * which is 2.  Then the variable offset is (4n+2), so
 			 * the total offset is 4-byte aligned and meets the
 			 * load's requirements.
 			 */
-			{15, "R5=3Dpkt(id=3D1,off=3D0,r=3D4,umin=3D14,umax=3D1034,var_off=3D(=
0x2; 0x7fc)"},
+			{15, "R5", "var_off=3D(0x2; 0x7fc)"},
 			/* Newly read value in R6 was shifted left by 2, so has
 			 * known alignment of 4.
 			 */
-			{17, "R6_w=3Dscalar(umax=3D1020,var_off=3D(0x0; 0x3fc))"},
+			{17, "R6_w", "var_off=3D(0x0; 0x3fc)"},
 			/* Added (4n) to packet pointer's (4n+2) var_off, giving
 			 * another (4n+2).
 			 */
-			{19, "R5_w=3Dpkt(id=3D2,off=3D0,r=3D0,umin=3D14,umax=3D2054,var_off=3D=
(0x2; 0xffc)"},
-			{20, "R4=3Dpkt(id=3D2,off=3D4,r=3D0,umin=3D14,umax=3D2054,var_off=3D(=
0x2; 0xffc)"},
+			{19, "R5_w", "var_off=3D(0x2; 0xffc)"},
+			{20, "R4", "var_off=3D(0x2; 0xffc)"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off (0)
 			 * which is 2.  Then the variable offset is (4n+2), so
 			 * the total offset is 4-byte aligned and meets the
 			 * load's requirements.
 			 */
-			{23, "R5=3Dpkt(id=3D2,off=3D0,r=3D4,umin=3D14,umax=3D2054,var_off=3D(=
0x2; 0xffc)"},
+			{23, "R5", "var_off=3D(0x2; 0xffc)"},
 		},
 	},
 	{
@@ -458,18 +459,18 @@ static struct bpf_align_test tests[] =3D {
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.result =3D REJECT,
 		.matches =3D {
-			{3, "R5_w=3Dpkt_end(off=3D0,imm=3D0)"},
+			{3, "R5_w", "pkt_end(off=3D0,imm=3D0)"},
 			/* (ptr - ptr) << 2 =3D=3D unknown, (4n) */
-			{5, "R5_w=3Dscalar(smax=3D9223372036854775804,umax=3D1844674407370955=
1612,var_off=3D(0x0; 0xfffffffffffffffc)"},
+			{5, "R5_w", "var_off=3D(0x0; 0xfffffffffffffffc)"},
 			/* (4n) + 14 =3D=3D (4n+2).  We blow our bounds, because
 			 * the add could overflow.
 			 */
-			{6, "R5_w=3Dscalar(smin=3D-9223372036854775806,smax=3D922337203685477=
5806,umin=3D2,umax=3D18446744073709551614,var_off=3D(0x2; 0xfffffffffffff=
ffc)"},
+			{6, "R5_w", "var_off=3D(0x2; 0xfffffffffffffffc)"},
 			/* Checked s>=3D0 */
-			{9, "R5=3Dscalar(umin=3D2,umax=3D9223372036854775806,var_off=3D(0x2; =
0x7ffffffffffffffc)"},
+			{9, "R5", "var_off=3D(0x2; 0x7ffffffffffffffc)"},
 			/* packet pointer + nonnegative (4n+2) */
-			{11, "R6_w=3Dpkt(id=3D1,off=3D0,r=3D0,umin=3D2,umax=3D922337203685477=
5806,var_off=3D(0x2; 0x7ffffffffffffffc)"},
-			{12, "R4_w=3Dpkt(id=3D1,off=3D4,r=3D0,umin=3D2,umax=3D922337203685477=
5806,var_off=3D(0x2; 0x7ffffffffffffffc)"},
+			{11, "R6_w", "var_off=3D(0x2; 0x7ffffffffffffffc)"},
+			{12, "R4_w", "var_off=3D(0x2; 0x7ffffffffffffffc)"},
 			/* NET_IP_ALIGN + (4n+2) =3D=3D (4n), alignment is fine.
 			 * We checked the bounds, but it might have been able
 			 * to overflow if the packet pointer started in the
@@ -477,7 +478,7 @@ static struct bpf_align_test tests[] =3D {
 			 * So we did not get a 'range' on R6, and the access
 			 * attempt will fail.
 			 */
-			{15, "R6_w=3Dpkt(id=3D1,off=3D0,r=3D0,umin=3D2,umax=3D922337203685477=
5806,var_off=3D(0x2; 0x7ffffffffffffffc)"},
+			{15, "R6_w", "var_off=3D(0x2; 0x7ffffffffffffffc)"},
 		}
 	},
 	{
@@ -512,24 +513,23 @@ static struct bpf_align_test tests[] =3D {
 			/* Calculated offset in R6 has unknown value, but known
 			 * alignment of 4.
 			 */
-			{6, "R2_w=3Dpkt(off=3D0,r=3D8,imm=3D0)"},
-			{8, "R6_w=3Dscalar(umax=3D1020,var_off=3D(0x0; 0x3fc))"},
+			{6, "R2_w", "pkt(off=3D0,r=3D8,imm=3D0)"},
+			{8, "R6_w", "var_off=3D(0x0; 0x3fc)"},
 			/* Adding 14 makes R6 be (4n+2) */
-			{9, "R6_w=3Dscalar(umin=3D14,umax=3D1034,var_off=3D(0x2; 0x7fc))"},
+			{9, "R6_w", "var_off=3D(0x2; 0x7fc)"},
 			/* New unknown value in R7 is (4n) */
-			{10, "R7_w=3Dscalar(umax=3D1020,var_off=3D(0x0; 0x3fc))"},
+			{10, "R7_w", "var_off=3D(0x0; 0x3fc)"},
 			/* Subtracting it from R6 blows our unsigned bounds */
-			{11, "R6=3Dscalar(smin=3D-1006,smax=3D1034,umin=3D2,umax=3D1844674407=
3709551614,var_off=3D(0x2; 0xfffffffffffffffc)"},
+			{11, "R6", "var_off=3D(0x2; 0xfffffffffffffffc)"},
 			/* Checked s>=3D 0 */
-			{14, "R6=3Dscalar(umin=3D2,umax=3D1034,var_off=3D(0x2; 0x7fc))"},
+			{14, "R6", "var_off=3D(0x2; 0x7fc)"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off (0)
 			 * which is 2.  Then the variable offset is (4n+2), so
 			 * the total offset is 4-byte aligned and meets the
 			 * load's requirements.
 			 */
-			{20, "R5=3Dpkt(id=3D2,off=3D0,r=3D4,umin=3D2,umax=3D1034,var_off=3D(0=
x2; 0x7fc)"},
-
+			{20, "R5", "var_off=3D(0x2; 0x7fc)"},
 		},
 	},
 	{
@@ -566,23 +566,23 @@ static struct bpf_align_test tests[] =3D {
 			/* Calculated offset in R6 has unknown value, but known
 			 * alignment of 4.
 			 */
-			{6, "R2_w=3Dpkt(off=3D0,r=3D8,imm=3D0)"},
-			{9, "R6_w=3Dscalar(umax=3D60,var_off=3D(0x0; 0x3c))"},
+			{6, "R2_w", "pkt(off=3D0,r=3D8,imm=3D0)"},
+			{9, "R6_w", "var_off=3D(0x0; 0x3c)"},
 			/* Adding 14 makes R6 be (4n+2) */
-			{10, "R6_w=3Dscalar(umin=3D14,umax=3D74,var_off=3D(0x2; 0x7c))"},
+			{10, "R6_w", "var_off=3D(0x2; 0x7c)"},
 			/* Subtracting from packet pointer overflows ubounds */
-			{13, "R5_w=3Dpkt(id=3D2,off=3D0,r=3D8,umin=3D18446744073709551542,uma=
x=3D18446744073709551602,var_off=3D(0xffffffffffffff82; 0x7c)"},
+			{13, "R5_w", "var_off=3D(0xffffffffffffff82; 0x7c)"},
 			/* New unknown value in R7 is (4n), >=3D 76 */
-			{14, "R7_w=3Dscalar(umin=3D76,umax=3D1096,var_off=3D(0x0; 0x7fc))"},
+			{14, "R7_w", "var_off=3D(0x0; 0x7fc)"},
 			/* Adding it to packet pointer gives nice bounds again */
-			{16, "R5_w=3Dpkt(id=3D3,off=3D0,r=3D0,umin=3D2,umax=3D1082,var_off=3D=
(0x2; 0x7fc)"},
+			{16, "R5_w", "var_off=3D(0x2; 0x7fc)"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off (0)
 			 * which is 2.  Then the variable offset is (4n+2), so
 			 * the total offset is 4-byte aligned and meets the
 			 * load's requirements.
 			 */
-			{20, "R5=3Dpkt(id=3D3,off=3D0,r=3D4,umin=3D2,umax=3D1082,var_off=3D(0=
x2; 0x7fc)"},
+			{20, "R5", "var_off=3D(0x2; 0x7fc)"},
 		},
 	},
 };
@@ -635,6 +635,7 @@ static int do_test_single(struct bpf_align_test *test=
)
 		line_ptr =3D strtok(bpf_vlog_copy, "\n");
 		for (i =3D 0; i < MAX_MATCHES; i++) {
 			struct bpf_reg_match m =3D test->matches[i];
+			const char *p;
 			int tmp;
=20
 			if (!m.match)
@@ -649,8 +650,8 @@ static int do_test_single(struct bpf_align_test *test=
)
 				line_ptr =3D strtok(NULL, "\n");
 			}
 			if (!line_ptr) {
-				printf("Failed to find line %u for match: %s\n",
-				       m.line, m.match);
+				printf("Failed to find line %u for match: %s=3D%s\n",
+				       m.line, m.reg, m.match);
 				ret =3D 1;
 				printf("%s", bpf_vlog);
 				break;
@@ -667,15 +668,15 @@ static int do_test_single(struct bpf_align_test *te=
st)
 			 *   6: R0_w=3Dpkt(off=3D8,r=3D8,imm=3D0) R1=3Dctx(off=3D0,imm=3D0) R=
2_w=3Dpkt(off=3D0,r=3D8,imm=3D0) R3_w=3Dpkt_end(off=3D0,imm=3D0) R10=3Dfp=
0
 			 *   6: (71) r3 =3D *(u8 *)(r2 +0)           ; R2_w=3Dpkt(off=3D0,r=3D=
8,imm=3D0) R3_w=3Dscalar(umax=3D255,var_off=3D(0x0; 0xff))
 			 */
-			while (!strstr(line_ptr, m.match)) {
+			while (!(p =3D strstr(line_ptr, m.reg)) || !strstr(p, m.match)) {
 				cur_line =3D -1;
 				line_ptr =3D strtok(NULL, "\n");
 				sscanf(line_ptr ?: "", "%u: ", &cur_line);
 				if (!line_ptr || cur_line !=3D m.line)
 					break;
 			}
-			if (cur_line !=3D m.line || !line_ptr || !strstr(line_ptr, m.match)) =
{
-				printf("Failed to find match %u: %s\n", m.line, m.match);
+			if (cur_line !=3D m.line || !line_ptr || !(p =3D strstr(line_ptr, m.r=
eg)) || !strstr(p, m.match)) {
+				printf("Failed to find match %u: %s=3D%s\n", m.line, m.reg, m.match)=
;
 				ret =3D 1;
 				printf("%s", bpf_vlog);
 				break;
--=20
2.34.1


