Return-Path: <bpf+bounces-37437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74749955A78
	for <lists+bpf@lfdr.de>; Sun, 18 Aug 2024 02:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C9F1C20B29
	for <lists+bpf@lfdr.de>; Sun, 18 Aug 2024 00:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7FD2F37;
	Sun, 18 Aug 2024 00:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="wwlHlGwi"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCB42581
	for <bpf@vger.kernel.org>; Sun, 18 Aug 2024 00:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723940670; cv=none; b=ABKVu2QI5u+dkH34otjCj9Rx+g88ey3VALAvKKFdeZnu191R6laMGcY/rXMcg9IPCIrArvYYwBXzYYb83h+oOnZYLtkXfjde/nuzvon0Zf8dMRDsbjkygFvPZp6nsQLHE0rzD4VTKziCOd6FBxsUpZBQCGbFl6QFHoXsVp/G8sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723940670; c=relaxed/simple;
	bh=neIhTP3rZgZ3SwU8z9XBf1ru3ro++j1tuVshqB8nKNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABXjtGwakJn04XvS6hnrN3GlqElUZ4PPNcCFpXQujVy5+QxUaMXy6xXWPIkELBVpgWQNmR3m967OWMMfy2LFzoF9iO5Cse7NAp4mPGqifG0iK/itKbCYwyLupzFWuUw9OFOWRMr+35JmEmSCjrGFT8S0A4xdYozoTLPeBghNbho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=wwlHlGwi; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1723940640; x=1724545440; i=linux@jordanrome.com;
	bh=veK++EuIcGbBqPUJYg1cG7RMzdzCMHWLsNb/utAjsT4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wwlHlGwi/Y7VcJ2f7W0XjL9rRMesKYuxUvh+ycQzI1czP8EcCdRPCFrp6xVLEy+F
	 oV29XadrbkAKNWeNLx+K2FKMDnVPkGz5guCo95g+pe/kjJN0E8x9IgJwOkmYrtlKP
	 KSs+rhoRFZp1NYBCOZCxHWe2pSd27f/vs6aoLVz3ggpVPsw2aiH/SVMuLhwY5yT/M
	 vV3YSL6ztNMnBU1aQ4qyahkUHxW4l+u479wBekdQvdYjWQSMaCgmJxC4livg5uBbH
	 S7FwaVqnWODt7eVa9wY0EPyCVawOD5G/haFlEUvNOZnYygQfbSzxDzn385GlloD1k
	 a8r8yiXMniFtbvPKRQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([173.252.127.3]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LllV0-1s6Q0d3ang-00gXCc; Sun, 18 Aug
 2024 02:24:00 +0200
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	sinquersw@gmail.com
Subject: [bpf-next v6 2/2] bpf: Add tests for bpf_copy_from_user_str kfunc
Date: Sat, 17 Aug 2024 17:23:50 -0700
Message-ID: <20240818002350.1401842-2-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240818002350.1401842-1-linux@jordanrome.com>
References: <20240818002350.1401842-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8DTNOq4AHAwgQQcgjle6Nv4ta1RfalEKFxNgYtDeZy1umPXmTD+
 +fxxFCeeR2bTeHw750aMXiOJQM8NofMXmPbleG3RvsjiGdrwMVFgscgDoAq2abM+u2EkCgn
 TpkyH2ZjTveadFP/nW2/dkLje36N2QfVsXZMoxtE+cH8PJX7wbV8hRUDeg+j6wgTBPZgLcV
 iDlYiaq1sbvEY25E9+Uug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:emuEiy2GVrA=;6fnbN+8wXtqmULI6cMykjRd8bNW
 Uj0I2Igp5ptKE0dOm7LZFULP9LJ2mLd/rn6ZCXaiQSa86MXO+5X96ReM7OCP3we7YaGc7cwMk
 mi0lfhYl/vF2hUdJrFOBFXVBY2MgGjUZnuA3E9f0Wuvo252vghRxQL29x5DhIegNKpyKF7kty
 NKGi9tS0QOjyvLdRvqMZrm8ivdxtxuSXJf9221G8izfAzZ6UbzdLFhbdPZDUXaRhSnxgL8l3J
 P6G1G0HGaBHuPDTX/RXw0R7oarZFGaY0Dm3yqkwT1Iwgn/34+qYHjQG8NS5xlC8r0+KQXa0Rz
 8CaMo2my+slcYsS5AcJgetqbNQU0hbDXyAOq33q52jL0Cr02YDXw6VUy3PHRzVVdT5lV4ZaMP
 kcAfwsNGn27CiE53QAP+pofY04up/RTKA+jufKq49qHKphbz43t2XCpkIZyktNFvQ5CU7wpfv
 m1t2MmkgXlrnydMd9XwkbrMdi+SqhHA0RJXbHJ3JjvhWmf0o/+0kegYQT7Gs8/5EtA8LHKG9/
 u63l9yrLxDo8E+5Tnu7dOjIpGdh1C0/RrTwIa6eyZFLu9RhVNLP79g8k3BelM4unC8Rp+CAeX
 rccR5o6r3r0fAXNTGl94pz5JrCzaQgMf7HX4LAgomCgAiwji0QvqgaeR8GjGfEv8nmp0NOf8S
 HEcXC0F8uxCPGzEPNspseWI3+1Np0Yci7OGMdQRgxERO1Z9vEO7KNuJfuHjjTkFIJ2Vb/GOuI
 0f2X9X/DG9ZQg/pzRM6HNLUav5yGvvn4g==

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
index 68466a6ad18c..a40ef14a6614 100644
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
+	if (ret > 0 || data_long_err[9] !=3D '\0')
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


