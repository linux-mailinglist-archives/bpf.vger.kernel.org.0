Return-Path: <bpf+bounces-36979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C857E94FB11
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 03:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2537F1F22B71
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 01:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6770749C;
	Tue, 13 Aug 2024 01:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="x1n3NJ/o"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A4563A9
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 01:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723512373; cv=none; b=GYrjlRcaLoElDxaWGiOZLhL6izrHDTtxW2t0ncuGDBAWemI7B4otI9/GRDUq0m+bcOd5O0mx9LI3kbTDnNxvcGFpAln73rb+jqUZl7mII6LnYqXBTNfEFo9q9DC5eBbp7mgMAUsTT+axR9Jn1ppWsBthbTi1zKi9cZB9kFqWSg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723512373; c=relaxed/simple;
	bh=ezbQRe5cfmfxavSAMePVhwmifsUiq6beS3n+/DTKQM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwE3MaSBQtAMmt7KaOf6Owkl6aTDDpa95xK/Ax3b2YDNfdrJy7I2MIYyG1sTdKTfbToFwXJ7skpuZAefkP2ex+OvZkCbKa38BKMQbRW5XyHXIWoILXj5Pw7mQU4CyB+kdnkHGfgHZuIxPbT38Bo7BSz5ACK5/lYt7l+2NPgpMyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=x1n3NJ/o; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1723512342; x=1724117142; i=linux@jordanrome.com;
	bh=Ah3mjWN97pJ1LmoXj2S1ZCHJcRDuEJWaStXHPyw/5s8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=x1n3NJ/ohdRZDP756+m4RttOL8YecT6ZqOxxmj6PdxXAW0/d8YF/4VEOw0u0h/YL
	 1vDXfqKtNUxS3fGWDhLCuUCgZnBG5y6XDr9yASIuM+cMeQFwc4f13zd+hqog2Rwjj
	 zdEMDbVBaCLe/oX7YJzzTV0tb9SFTsNu+bc0KUNsRyY+w9WzkKYjofsqEd1WEzX/z
	 w8wr+udypP4/cqq4K77OxqoMK7EG7ibjpLNsnPJJZX1CYj6YENu5ODQdKI6u9AS1i
	 H8ElFDZbNdXVmH3G902UzSNN83n7q8dgsxznaC6w+W/RZ0XGlWag1k12VmsoWroM+
	 6KkYWKZPohNE3ibnhg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([173.252.127.13]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MGTcU-1sQQkg339E-00CpVB; Tue, 13 Aug
 2024 03:25:42 +0200
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	sinquersw@gmail.com
Subject: [bpf-next v3 2/2] bpf: Add tests for bpf_copy_from_user_str kfunc
Date: Mon, 12 Aug 2024 18:25:28 -0700
Message-ID: <20240813012528.3566133-2-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240813012528.3566133-1-linux@jordanrome.com>
References: <20240813012528.3566133-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zPEVd0N8toUjc3jtUQUAV3lVMlvZ1R/QUGmyuXJ2TZ8vuRPTE6F
 DzTYU6c5hCfOfJxGF4CIQ5/WJAQXu87ZIVhgDg23anSA3v/JUv/dC3HhUq/jM/tQuHjIi0O
 q3IBbzf/cpQTxfzVrLSQkfRiug5ylK9bCRAj0fyvvEEgDt/bRHaViF+N8vbN/O34AKoFmzn
 VkIMHX63ks069AetKkX2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZNoHqiQkIxg=;l3oh9dauIvtmJ17VDph1G/LaRHL
 PvAUtog2ollrMoj5oyDStkUiyV1L0xXGBsENZcmBfG99Se9x4r9l9DoVW5sHLx96pMwC0PVU0
 NUf/9OOHl+mdJHh5fe/D0CXYRagkmC20X0FTzV9he1kOgRUWdF2+NKAzm04Bfc0XovRICmrEk
 eMTYTzWT3vqE1N12qU9HOeXboUi6X5lvMvgzyThL6eKBx53keO5JbwihbLkMVrSrZLODMNfU1
 QEal0C8y32gvIArDu+8yW11mFykMOHWUOn26a1dsevBmONuPC1zGGJgx2cWEL/c5ptWeF3GQB
 F1UyN6rzKrVjZciJ8Q/bw9EFTQetPqGZjmngyxBkmiz46jB9Egc8b4jD2QtzCBBbwN0WJ77FR
 kZmmCRL9FFsuwCWmtRsaLQzoPzo6xYdYeY2HFIYzhF9NV4J9fkRUM41gwHRXvqWME5YKdcfRU
 IeVjVZahozfJcVv8elrEAZTJNZ1xx9wsrF59bCl39dUmargqs6iEQzavL4hEP0IuhTaA2Z9w0
 bOqbd6D9OhTa+R95zJ9B18wW656N35iQIZiGKnfGd/x1KoL2cbYAp1aQVo1LJtNsisli2ax1J
 3YxC5jn5CTlsa0fGjSUPFdDPlCEdmbUZmxrEZ+avaWSMwSMgjCgsNBn7aZd8ArpHREPGyxEuT
 ONoJGe9YOfmbSoWeXEXs8VUx62NnPHOWOu4wwwtmSkQU+T6InzxQpqBmhOFdwTxvZJ/AHSbLP
 lWiYzj2QjE37FLCxuZ2+QGg9eABxD7ojA==

This adds tests for both the happy path and
the error path.

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 .../selftests/bpf/prog_tests/attach_probe.c   |  8 +++--
 .../selftests/bpf/prog_tests/read_vsyscall.c  |  1 +
 .../selftests/bpf/progs/read_vsyscall.c       |  9 ++++-
 .../selftests/bpf/progs/test_attach_probe.c   | 33 +++++++++++++++++--
 4 files changed, 44 insertions(+), 7 deletions(-)

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
index 986f96687ae1..27de1e907754 100644
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
+int bpf_copy_from_user_str(void *dst, u32, const void *) __weak __ksym;
+
 SEC("fentry/" SYS_PREFIX "sys_nanosleep")
 int do_probe_read(void *ctx)
 {
@@ -40,6 +46,7 @@ int do_copy_from_user(void *ctx)
 	read_ret[6] =3D bpf_copy_from_user(buf, sizeof(buf), user_ptr);
 	read_ret[7] =3D bpf_copy_from_user_task(buf, sizeof(buf), user_ptr,
 					      bpf_get_current_task_btf(), 0);
+	read_ret[8] =3D bpf_copy_from_user_str((char *)buf, sizeof(buf), user_pt=
r);

 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/test_attach_probe.c b/tools=
/testing/selftests/bpf/progs/test_attach_probe.c
index 68466a6ad18c..bf59a5280776 100644
=2D-- a/tools/testing/selftests/bpf/progs/test_attach_probe.c
+++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
@@ -14,11 +14,15 @@ int uretprobe_byname_res =3D 0;
 int uprobe_byname2_res =3D 0;
 int uretprobe_byname2_res =3D 0;
 int uprobe_byname3_sleepable_res =3D 0;
+int uprobe_byname3_str_sleepable_res =3D 0;
 int uprobe_byname3_res =3D 0;
 int uretprobe_byname3_sleepable_res =3D 0;
+int uretprobe_byname3_str_sleepable_res =3D 0;
 int uretprobe_byname3_res =3D 0;
 void *user_ptr =3D 0;

+int bpf_copy_from_user_str(void *dst, u32, const void *) __weak __ksym;
+
 SEC("ksyscall/nanosleep")
 int BPF_KSYSCALL(handle_kprobe_auto, struct __kernel_timespec *req, struc=
t __kernel_timespec *rem)
 {
@@ -87,11 +91,32 @@ static __always_inline bool verify_sleepable_user_copy=
(void)
 	return bpf_strncmp(data, sizeof(data), "test_data") =3D=3D 0;
 }

+static __always_inline bool verify_sleepable_user_copy_str(void)
+{
+	int ret;
+	char data_long[20];
+	char data_short[4];
+
+	ret =3D bpf_copy_from_user_str(data_short, sizeof(data_short), user_ptr)=
;
+
+	if (bpf_strncmp(data_short, 4, "tes\0") !=3D 0 || ret !=3D 4)
+		return false;
+
+	ret =3D bpf_copy_from_user_str(data_long, sizeof(data_long), user_ptr);
+
+	if (bpf_strncmp(data_long, 10, "test_data\0") !=3D 0 || ret !=3D 10)
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

@@ -102,7 +127,7 @@ int handle_uprobe_byname3_sleepable(struct pt_regs *ct=
x)
 SEC("uprobe//proc/self/exe:trigger_func3")
 int handle_uprobe_byname3(struct pt_regs *ctx)
 {
-	uprobe_byname3_res =3D 10;
+	uprobe_byname3_res =3D 11;
 	return 0;
 }

@@ -110,14 +135,16 @@ SEC("uretprobe.s//proc/self/exe:trigger_func3")
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


