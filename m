Return-Path: <bpf+bounces-37615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A469583FB
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 12:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C2E1F25B17
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 10:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6565218CC17;
	Tue, 20 Aug 2024 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="ratZBya6"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88C718CC0D
	for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149097; cv=none; b=cAx+ebEVnd3EW/j1Ot0+DYDBRCW5krCCHobuGv/VM/cmfzoPovz2R4S6E0q92Sn9XmmbTi+h3l64M+ugLswM3oYDZVTK+YXjNQiSAsrGVkhZPdywu95WHIw4uq4SlVzzfxADihs9QAtmDx327cUPIAZdYA2ptv5CwfIFjcLWAiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149097; c=relaxed/simple;
	bh=ftiCdK+HuM1djLlIQJCHxpKalyNiSzoY+iDHVh2EdEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3GQL93AiNzt83SXYVvn9wTsDTS4cRqT4dhFfwcWzklSU6wsJ941Oc9PYLtspNMrqHfXB7NZ4DnDyEMzf/LTAcqGjwNdQfQLHLetATgGjMOmTpXpwO0eQspJuZDorbnpLJg9m/TTq30HdxwPv4WcqdWyrL9+b5f7zUVwgP+qG40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=ratZBya6; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1724149067; x=1724753867; i=linux@jordanrome.com;
	bh=JAtM5HzXKWoEKkKhlpQuXZ5CfmOI1squcd2mbmSOjBY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ratZBya6LCMs8Cc4A6s1YFkub0uwmL9qKPNy0thsXZyQJd8kyOm32nkiBfj5bmDM
	 g2axpYtF38yPSfmPQXvJF/zc/7hHXmSH7wRlrnEZFXlx0KLoBcf+ro/xS3NcrN12z
	 6+uKUdVKs8ifsgQzcAwZVHV7LBygRAtn91wFOYVcYg+K0ocOz5c765dhF2T3+a22G
	 c1GaRZTSags2wCe933v+5ovViRlih639KWD/r2vi6Ws3Ot7sCzU+XDUUcX7TgvFty
	 rgE2mTBIgSjA9Y64o+Sp01910cRM3tA9InnBIKNv7Aryh+N5SdqzX4uVeILv9YL6m
	 fZ+VEbxSkTU8JmLSpg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([173.252.127.115]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MrPuF-1sKCHE1uFz-00pDMI; Tue, 20 Aug
 2024 12:17:47 +0200
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	sinquersw@gmail.com
Subject: [bpf-next v7 2/2] bpf: Add tests for bpf_copy_from_user_str kfunc
Date: Tue, 20 Aug 2024 03:17:25 -0700
Message-ID: <20240820101725.1629353-2-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240820101725.1629353-1-linux@jordanrome.com>
References: <20240820101725.1629353-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1deFl2NAkpzcmnCTZ5CI3nU0UYN425yjP0llTeSmHgxFFh1dYnq
 diVBjuvtbaM+IMPwaOGaSAx7Fwwx4ng1CMA+iB4N995hKqpOkyoiQLROEjCtal12Wm4dKAA
 FUy+whcDQ0H8HX2IEeL6WvdDoHFG/6FK/C6IqY8UJV26aZXmG+GEhotBwmrTH6tcpuyvm1O
 yfqhB0Tx7hQUEomgxvbIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ad1WTZ4IJo4=;71QpmsXeWb22dsrWd6iDJRf10PG
 kkvcFn/KGZwbAW9HSRs+kwSoTjFoCknO7l/jC3acEShHO7En/8vtGhNHdbB+Iw8SWnUebIFBf
 CHb5L71v601xQmaH46aWOfknYWF3H2FM6/noW/imNPEvO04z8Z0KhMgrc6iWiNPieBZxq9LbS
 sEzoF4jZoS9LtIr6ygI0TIAv4uJR6DOma2t6Ny618BnRnr4ITHxGgzGnr/r9iLuPkqfiph8hq
 d+b/zFBQVd9jc/bx8T3edXukNJsYYoGCEwCqj5e01ZlRe+bylH6x1CTs11bgnASHAYR8CAm4e
 LqXWlGGxamqxd/dbKR2Kswbh2kpbWU63hSXJORvKyzH3vTAOE4YkHfCSP6aQiqc08LwcaoMPP
 GoYMkymix3bF8mnwoYzgf5yVJzkhBxvFVsMG9Ex2DgzDF3PKVxrRJBfHr7XcJhMD1S1TPvdAz
 VLR/u5gDwMGhmq/3BvK1IjH0vDoow6gF77cg885UB/6UvLXXDpUfPg/ObK3Lv9ptxg5m2HMdh
 CmnUko5awfjkvVTzuiT3JY0ILg4l0LHf0abxNuk1s1G1+naB/ZowcfueMhAS0r1+KbjPRFCHY
 qN46rwJeqP8dDP48WwjwtmRgDLGAFj7K5bYXznc4GOh6tJ3H0+OLWSoyS7gOr48JfGCIk+Lzw
 7r2RiF52oAbNz9PU+WdVkDaJplkysIpVUWyPKfV6r1G5Sgar4Op3ZdJTSo0M2NEkaDmhu1G/W
 gxxL7Jyi/im5tM6yNSQSlkDepYNWfZl3Q==

This adds tests for both the happy path and
the error path.

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 .../selftests/bpf/prog_tests/attach_probe.c   |  8 ++-
 .../selftests/bpf/prog_tests/read_vsyscall.c  |  1 +
 .../selftests/bpf/progs/read_vsyscall.c       |  9 ++-
 .../selftests/bpf/progs/test_attach_probe.c   | 57 ++++++++++++++++++-
 4 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools=
/testing/selftests/bpf/prog_tests/attach_probe.c
index 7175af39134f..329c7862b52d 100644
=2D-- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -283,9 +283,11 @@ static void test_uprobe_sleepable(struct test_attach_=
probe *skel)
 	trigger_func3();

 	ASSERT_EQ(skel->bss->uprobe_byname3_sleepable_res, 9, "check_uprobe_byna=
me3_sleepable_res");
-	ASSERT_EQ(skel->bss->uprobe_byname3_res, 10, "check_uprobe_byname3_res")=
;
-	ASSERT_EQ(skel->bss->uretprobe_byname3_sleepable_res, 11, "check_uretpro=
be_byname3_sleepable_res");
-	ASSERT_EQ(skel->bss->uretprobe_byname3_res, 12, "check_uretprobe_byname3=
_res");
+	ASSERT_EQ(skel->bss->uprobe_byname3_str_sleepable_res, 10, "check_uprobe=
_byname3_str_sleepable_res");
+	ASSERT_EQ(skel->bss->uprobe_byname3_res, 11, "check_uprobe_byname3_res")=
;
+	ASSERT_EQ(skel->bss->uretprobe_byname3_sleepable_res, 12, "check_uretpro=
be_byname3_sleepable_res");
+	ASSERT_EQ(skel->bss->uretprobe_byname3_str_sleepable_res, 13, "check_ure=
tprobe_byname3_str_sleepable_res");
+	ASSERT_EQ(skel->bss->uretprobe_byname3_res, 14, "check_uretprobe_byname3=
_res");
 }

 void test_attach_probe(void)
diff --git a/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c b/tool=
s/testing/selftests/bpf/prog_tests/read_vsyscall.c
index 3405923fe4e6..c7b9ba8b1d06 100644
=2D-- a/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
@@ -23,6 +23,7 @@ struct read_ret_desc {
 	{ .name =3D "probe_read_user_str", .ret =3D -EFAULT },
 	{ .name =3D "copy_from_user", .ret =3D -EFAULT },
 	{ .name =3D "copy_from_user_task", .ret =3D -EFAULT },
+	{ .name =3D "copy_from_user_str", .ret =3D -EFAULT },
 };

 void test_read_vsyscall(void)
diff --git a/tools/testing/selftests/bpf/progs/read_vsyscall.c b/tools/tes=
ting/selftests/bpf/progs/read_vsyscall.c
index 986f96687ae1..39ebef430059 100644
=2D-- a/tools/testing/selftests/bpf/progs/read_vsyscall.c
+++ b/tools/testing/selftests/bpf/progs/read_vsyscall.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2024. Huawei Technologies Co., Ltd */
+#include "vmlinux.h"
 #include <linux/types.h>
 #include <bpf/bpf_helpers.h>

@@ -7,10 +8,15 @@

 int target_pid =3D 0;
 void *user_ptr =3D 0;
-int read_ret[8];
+int read_ret[9];

 char _license[] SEC("license") =3D "GPL";

+/*
+ * This is the only kfunc, the others are helpers
+ */
+int bpf_copy_from_user_str(void *dst, u32, const void *, u64) __weak __ks=
ym;
+
 SEC("fentry/" SYS_PREFIX "sys_nanosleep")
 int do_probe_read(void *ctx)
 {
@@ -40,6 +46,7 @@ int do_copy_from_user(void *ctx)
 	read_ret[6] =3D bpf_copy_from_user(buf, sizeof(buf), user_ptr);
 	read_ret[7] =3D bpf_copy_from_user_task(buf, sizeof(buf), user_ptr,
 					      bpf_get_current_task_btf(), 0);
+	read_ret[8] =3D bpf_copy_from_user_str((char *)buf, sizeof(buf), user_pt=
r, 0);

 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/test_attach_probe.c b/tools=
/testing/selftests/bpf/progs/test_attach_probe.c
index 68466a6ad18c..4959eda92479 100644
=2D-- a/tools/testing/selftests/bpf/progs/test_attach_probe.c
+++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
@@ -5,6 +5,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
+#include <errno.h>
 #include "bpf_misc.h"

 int kprobe2_res =3D 0;
@@ -14,11 +15,15 @@ int uretprobe_byname_res =3D 0;
 int uprobe_byname2_res =3D 0;
 int uretprobe_byname2_res =3D 0;
 int uprobe_byname3_sleepable_res =3D 0;
+int uprobe_byname3_str_sleepable_res =3D 0;
 int uprobe_byname3_res =3D 0;
 int uretprobe_byname3_sleepable_res =3D 0;
+int uretprobe_byname3_str_sleepable_res =3D 0;
 int uretprobe_byname3_res =3D 0;
 void *user_ptr =3D 0;

+int bpf_copy_from_user_str(void *dst, u32, const void *, u64) __weak __ks=
ym;
+
 SEC("ksyscall/nanosleep")
 int BPF_KSYSCALL(handle_kprobe_auto, struct __kernel_timespec *req, struc=
t __kernel_timespec *rem)
 {
@@ -87,11 +92,55 @@ static __always_inline bool verify_sleepable_user_copy=
(void)
 	return bpf_strncmp(data, sizeof(data), "test_data") =3D=3D 0;
 }

+static __always_inline bool verify_sleepable_user_copy_str(void)
+{
+	int ret;
+	char data_long[20];
+	char data_long_pad[20];
+	char data_long_err[20];
+	char data_short[4];
+	char data_short_pad[4];
+
+	ret =3D bpf_copy_from_user_str(data_short, sizeof(data_short), user_ptr,=
 0);
+
+	if (bpf_strncmp(data_short, 4, "tes\0") !=3D 0 || ret !=3D 4)
+		return false;
+
+	ret =3D bpf_copy_from_user_str(data_short_pad, sizeof(data_short_pad), u=
ser_ptr, BPF_F_PAD_ZEROS);
+
+	if (bpf_strncmp(data_short, 4, "tes\0") !=3D 0 || ret !=3D 4)
+		return false;
+
+	ret =3D bpf_copy_from_user_str(data_long, sizeof(data_long), user_ptr, 0=
);
+
+	if (bpf_strncmp(data_long, 10, "test_data\0") !=3D 0 || ret !=3D 10)
+		return false;
+
+	ret =3D bpf_copy_from_user_str(data_long_pad, sizeof(data_long_pad), use=
r_ptr, BPF_F_PAD_ZEROS);
+
+	if (bpf_strncmp(data_long_pad, 10, "test_data\0") !=3D 0 || ret !=3D 10 =
|| data_long_pad[19] !=3D '\0')
+		return false;
+
+	ret =3D bpf_copy_from_user_str(data_long_err, sizeof(data_long_err), (vo=
id *)data_long, BPF_F_PAD_ZEROS);
+
+	if (ret > 0 || data_long_err[19] !=3D '\0')
+		return false;
+
+	ret =3D bpf_copy_from_user_str(data_long, sizeof(data_long), user_ptr, 2=
);
+
+	if (ret !=3D -EINVAL)
+		return false;
+
+	return true;
+}
+
 SEC("uprobe.s//proc/self/exe:trigger_func3")
 int handle_uprobe_byname3_sleepable(struct pt_regs *ctx)
 {
 	if (verify_sleepable_user_copy())
 		uprobe_byname3_sleepable_res =3D 9;
+	if (verify_sleepable_user_copy_str())
+		uprobe_byname3_str_sleepable_res =3D 10;
 	return 0;
 }

@@ -102,7 +151,7 @@ int handle_uprobe_byname3_sleepable(struct pt_regs *ct=
x)
 SEC("uprobe//proc/self/exe:trigger_func3")
 int handle_uprobe_byname3(struct pt_regs *ctx)
 {
-	uprobe_byname3_res =3D 10;
+	uprobe_byname3_res =3D 11;
 	return 0;
 }

@@ -110,14 +159,16 @@ SEC("uretprobe.s//proc/self/exe:trigger_func3")
 int handle_uretprobe_byname3_sleepable(struct pt_regs *ctx)
 {
 	if (verify_sleepable_user_copy())
-		uretprobe_byname3_sleepable_res =3D 11;
+		uretprobe_byname3_sleepable_res =3D 12;
+	if (verify_sleepable_user_copy_str())
+		uretprobe_byname3_str_sleepable_res =3D 13;
 	return 0;
 }

 SEC("uretprobe//proc/self/exe:trigger_func3")
 int handle_uretprobe_byname3(struct pt_regs *ctx)
 {
-	uretprobe_byname3_res =3D 12;
+	uretprobe_byname3_res =3D 14;
 	return 0;
 }

=2D-
2.43.5


