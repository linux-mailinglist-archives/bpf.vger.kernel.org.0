Return-Path: <bpf+bounces-6163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE067663D1
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 07:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7066B282632
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 05:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286F1BA26;
	Fri, 28 Jul 2023 05:58:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046003D86
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 05:57:59 +0000 (UTC)
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB7126B2
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 22:57:58 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 6279323CA27A5; Thu, 27 Jul 2023 22:57:45 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Enable test test_progs-cpuv4 for gcc build kernel
Date: Thu, 27 Jul 2023 22:57:45 -0700
Message-Id: <20230728055745.2285202-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728055740.2284534-1-yonghong.song@linux.dev>
References: <20230728055740.2284534-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_SOFTFAIL,
	TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, test_progs-cpuv4 is generated with clang build kernel
when bpf cpu=3Dv4 is supported by the clang compiler.
Let us enable test_progs-cpuv4 for gcc build kernel as well.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
index 6a45719a8d47..73a6ca80fa16 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -36,11 +36,12 @@ LDLIBS +=3D -lelf -lz -lrt -lpthread
 ifneq ($(LLVM),)
 # Silence some warnings when compiled with clang
 CFLAGS +=3D -Wno-unused-command-line-argument
-# Check whether cpu=3Dv4 is supported or not by clang
+endif
+
+# Check whether bpf cpu=3Dv4 is supported or not by clang
 ifneq ($(shell $(CLANG) --target=3Dbpf -mcpu=3Dhelp 2>&1 | grep 'v4'),)
 CLANG_CPUV4 :=3D 1
 endif
-endif
=20
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS =3D test_verifier test_tag test_maps test_lru_map test_lp=
m_map test_progs \
--=20
2.34.1


