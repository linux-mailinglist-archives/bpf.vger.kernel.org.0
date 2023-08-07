Return-Path: <bpf+bounces-7190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7565F772D72
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 20:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30510280233
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 18:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0F2156F8;
	Mon,  7 Aug 2023 17:57:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5889A156F0
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 17:57:42 +0000 (UTC)
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54111710
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 10:57:39 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id B6784245D532C; Mon,  7 Aug 2023 10:57:26 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add a movsx selftest for sign-extension of R10
Date: Mon,  7 Aug 2023 10:57:26 -0700
Message-Id: <20230807175726.672394-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807175721.671696-1-yonghong.song@linux.dev>
References: <20230807175721.671696-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_SOFTFAIL,
	TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

A movsx selftest is added for sign-extension of frame pointer R10.
The verification fails for both privileged and unprivileged
prog runs.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/progs/verifier_movsx.c      | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/t=
esting/selftests/bpf/progs/verifier_movsx.c
index 9568089932d7..be6f69a6b659 100644
--- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -198,6 +198,28 @@ l0_%=3D:							\
 	: __clobber_all);
 }
=20
+SEC("socket")
+__description("MOV64SX, S16, R10 Sign Extension")
+__failure __msg("R1 type=3Dscalar expected=3Dfp, pkt, pkt_meta, map_key,=
 map_value, mem, ringbuf_mem, buf, trusted_ptr_")
+__failure_unpriv __msg_unpriv("R10 sign-extension part of pointer")
+__naked void mov64sx_s16_r10(void)
+{
+	asm volatile ("					\
+	r1 =3D 553656332;					\
+	*(u32 *)(r10 - 8) =3D r1; 			\
+	r1 =3D (s16)r10;					\
+	r1 +=3D -8;					\
+	r2 =3D 3;						\
+	if r2 <=3D r1 goto l0_%=3D;				\
+l0_%=3D:							\
+	call %[bpf_trace_printk];			\
+	r0 =3D 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_trace_printk)
+	: __clobber_all);
+}
+
 #else
=20
 SEC("socket")
--=20
2.34.1


