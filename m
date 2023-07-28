Return-Path: <bpf+bounces-6162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3441A7663D0
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 07:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB421C217E9
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 05:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1DBAD45;
	Fri, 28 Jul 2023 05:57:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922343D86
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 05:57:56 +0000 (UTC)
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7B226BC
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 22:57:54 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 3F7A223CA2676; Thu, 27 Jul 2023 22:57:40 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next 1/2] bpf: Fix compilation warning with -Wparentheses
Date: Thu, 27 Jul 2023 22:57:40 -0700
Message-Id: <20230728055740.2284534-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_SOFTFAIL,
	TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The kernel test robot reported compilation warnings when -Wparentheses is
added to KBUILD_CFLAGS with gcc compiler. The following is the error mess=
age:

  .../bpf-next/kernel/bpf/verifier.c: In function =E2=80=98coerce_reg_to_=
size_sx=E2=80=99:
  .../bpf-next/kernel/bpf/verifier.c:5901:14:
    error: suggest parentheses around comparison in operand of =E2=80=98=3D=
=3D=E2=80=99 [-Werror=3Dparentheses]
    if (s64_max >=3D 0 =3D=3D s64_min >=3D 0) {
        ~~~~~~~~^~~~
  .../bpf-next/kernel/bpf/verifier.c: In function =E2=80=98coerce_subreg_=
to_size_sx=E2=80=99:
  .../bpf-next/kernel/bpf/verifier.c:5965:14:
    error: suggest parentheses around comparison in operand of =E2=80=98=3D=
=3D=E2=80=99 [-Werror=3Dparentheses]
    if (s32_min >=3D 0 =3D=3D s32_max >=3D 0) {
        ~~~~~~~~^~~~

To fix the issue, add proper parentheses for the above '>=3D' condition
to silence the warning/error.

I tried a few clang compilers like clang16 and clang18 and they do not em=
it
such warnings with -Wparentheses.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307281133.wi0c4SqG-lkp@i=
ntel.com/
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/core.c     | 4 ++--
 kernel/bpf/verifier.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index db0b631908c2..baccdec22f19 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1877,7 +1877,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct =
bpf_insn *insn)
 		case 1:
 			AX =3D abs((s32)DST);
 			do_div(AX, abs((s32)SRC));
-			if ((s32)DST < 0 =3D=3D (s32)SRC < 0)
+			if (((s32)DST < 0) =3D=3D ((s32)SRC < 0))
 				DST =3D (u32)AX;
 			else
 				DST =3D (u32)-AX;
@@ -1904,7 +1904,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct =
bpf_insn *insn)
 		case 1:
 			AX =3D abs((s32)DST);
 			do_div(AX, abs((s32)IMM));
-			if ((s32)DST < 0 =3D=3D (s32)IMM < 0)
+			if (((s32)DST < 0) =3D=3D ((s32)IMM < 0))
 				DST =3D (u32)AX;
 			else
 				DST =3D (u32)-AX;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0b1ada93582b..e7b1af016841 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5898,7 +5898,7 @@ static void coerce_reg_to_size_sx(struct bpf_reg_st=
ate *reg, int size)
 	s64_min =3D min(init_s64_max, init_s64_min);
=20
 	/* both of s64_max/s64_min positive or negative */
-	if (s64_max >=3D 0 =3D=3D s64_min >=3D 0) {
+	if ((s64_max >=3D 0) =3D=3D (s64_min >=3D 0)) {
 		reg->smin_value =3D reg->s32_min_value =3D s64_min;
 		reg->smax_value =3D reg->s32_max_value =3D s64_max;
 		reg->umin_value =3D reg->u32_min_value =3D s64_min;
@@ -5962,7 +5962,7 @@ static void coerce_subreg_to_size_sx(struct bpf_reg=
_state *reg, int size)
 	s32_max =3D max(init_s32_max, init_s32_min);
 	s32_min =3D min(init_s32_max, init_s32_min);
=20
-	if (s32_min >=3D 0 =3D=3D s32_max >=3D 0) {
+	if ((s32_min >=3D 0) =3D=3D (s32_max >=3D 0)) {
 		reg->s32_min_value =3D s32_min;
 		reg->s32_max_value =3D s32_max;
 		reg->u32_min_value =3D (u32)s32_min;
--=20
2.34.1


