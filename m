Return-Path: <bpf+bounces-37988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE96495D640
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 21:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACBF828608A
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 19:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294A1192B65;
	Fri, 23 Aug 2024 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="qkrFlBkY"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC84013634A
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724442698; cv=none; b=GN13EKLSnrJepEF4fQss3RFt8VrLrb/GaW4EENRGGBZwbRFaJp8txI6rBgQhxSwH0JUq7GmkfPV+ofnZsd9II2Y83z7OR89Q6cbJd9PK9TeAk/DcfIzRLAandsS7gnb1zgckGyEjUWA/BBLIuY9lhMfSdqrkgYPkKVjJR2SZ9r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724442698; c=relaxed/simple;
	bh=UIWY8CUgR+ChXwgrY8eIrRpag+yHDXMUvGS8TimR7RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHs5ZS4UQ2ptxE2qA4PxHE2nhS3fk8ulXrNOY2z62NHMEjDy/OSSxgpO/H9HnMq0VJ0EAfoGEebwexMFhQjS81BsuzsmUwzFLDwX6/19AzZl4FnSmzmToH3kJzxYn5/E0+UvjPxGzkH9+vPkVbDb6Wm2vr42n+tVlMH4AiNBlII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=qkrFlBkY; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1724442670; x=1725047470; i=linux@jordanrome.com;
	bh=MsewBDRidr7nFmDzwg/oM7KefNCJ0MmdyCwQ7ligWhk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qkrFlBkY2KdwruJNEJd0s60XoleeHu13j32eCqxaFDAn5h/yzr/gEFV5EetpX4qC
	 NXP/MDm5zl4AVyM5QJnHxpgIN+wvm/7u9xcdSosBcSIH7eomnE8kjTlPAcA9e9r8y
	 J4q2lgQayqvSo3cYbyYBGzjFLakFHHgR07ZQDEh5YmjW0QT2/Ah+R8NnEt5pIYGvu
	 wumkzzW+6peJFQODWeAjhGQv19wMpn3GFl/rRsWJ04F8AfxmjZuHkwOJJiV5Qn8t2
	 IteJRh2rVvlb5/YwVE5IwP7bxDL+AQhBAtTbv3bFkWVDRFcJpVcID5DEpTfmEHpYS
	 cMzZ2/1dCy7tZVslLQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([173.252.127.27]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1Mrgkq-1sMXIf34eC-00owYg; Fri, 23 Aug
 2024 21:51:09 +0200
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	sinquersw@gmail.com
Subject: [bpf-next v10 2/2] bpf: Add tests for bpf_copy_from_user_str kfunc
Date: Fri, 23 Aug 2024 12:51:01 -0700
Message-ID: <20240823195101.3621028-2-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240823195101.3621028-1-linux@jordanrome.com>
References: <20240823195101.3621028-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UDiJl+qPbyKDBGs8yLTqkNOHyGuuZdV5rE0uVXIjtF6PEl05dhz
 cFKdFRWLyj/smJEoHGhsmkghY8IZLmctsh9xSuAzvbebQiK3zLpjPBEJL4Z3JwNGwsn6O2G
 su7nL0vJOb8LSaBXswb+6fLs/ZJ1jxFGDM4/TGx+/lHDWdwEhpz/nhQVE9ORPw5pcLd2DQ3
 lhbRYir9TOf7Ey3hi8CmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dKgfPvO1PhI=;Hkse0eiHJZIJ+9YIYoeBfupiD4d
 8FI4EOccmIwK52Os0R+dzU+GcYG8gMGxqNV6nlPVVH5kxAYD6ouHsrTnrULTiugn5a1IYMXeJ
 C8gBRIGPKECiKveOVuLV7GNSeEZ/dhavP2Ih3GDhDMvEUkvQcF3rwf/Fp8B6bk+7+hJXpmLMp
 uMjzTV24aaGzpqQzXFF+zOz9fTBsc1vQzdMmX0wBeUFzmLUHCG4PWNepmY63dbUNncchmT691
 V/yKROXbuwftxVuRqIusUhiw1tHh6uD1csiXcBtI2hKj/WAbTpP6YQa3W5fn+CWu1iMBD1uH6
 KAYDmmT2JcJneUNXt9Gw6vmVanWpO/OzSx4H15WFF2C15Lben9ISJCSjF9M4X1V74VzKigcau
 dWAGyNS5iT5Aeouubj612mRCi/KypuIDS9fVKzJykRhllCLsOV+8/lfNtNX5Vj2Vz4Jlu2XvJ
 mWDvaRCFkwWjYczl4iiA7FTDVeE4RV8ZAvUkN/o4f7oAHuUE+j1PIAfwgUL8kaVBXsfYOOjRP
 bkdZo/UgBMIts8uWTrrUn6BLUiUWocYWUeOxb8jBztXABq+oNjaqcQ9//U1TwR6DlnmI9Sv5e
 ATSaqMZOcqoVy+1wMrXJ1PYfG/VhUcF0OfueXYQJXncUztNAt7ydeZK/TSDZbJlt8WMqLGZct
 2buXgqCmgWBVELBaZ6NnLZ24RYgkTO7EbTLyiRrH0UneeH5/dVC8lacM42TYocEjrGmS6l+3P
 P754mAjLmY0TRS8wDm4esEnH5kxwDz/tw==

This adds tests for both the happy path and
the error path.

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 .../selftests/bpf/prog_tests/attach_probe.c   |  8 ++-
 .../selftests/bpf/prog_tests/read_vsyscall.c  |  1 +
 .../selftests/bpf/progs/read_vsyscall.c       |  9 ++-
 .../selftests/bpf/progs/test_attach_probe.c   | 64 ++++++++++++++++++-
 4 files changed, 75 insertions(+), 7 deletions(-)

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
index 68466a6ad18c..fb79e6cab932 100644
=2D-- a/tools/testing/selftests/bpf/progs/test_attach_probe.c
+++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
@@ -5,8 +5,10 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
+#include <errno.h>
 #include "bpf_misc.h"

+u32 dynamic_sz =3D 1;
 int kprobe2_res =3D 0;
 int kretprobe2_res =3D 0;
 int uprobe_byname_res =3D 0;
@@ -14,11 +16,15 @@ int uretprobe_byname_res =3D 0;
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
@@ -87,11 +93,61 @@ static __always_inline bool verify_sleepable_user_copy=
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
+	/* Make sure this passes the verifier */
+	ret =3D bpf_copy_from_user_str(data_long, dynamic_sz & sizeof(data_long)=
, user_ptr, 0);
+
+	if (ret !=3D 0)
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

@@ -102,7 +158,7 @@ int handle_uprobe_byname3_sleepable(struct pt_regs *ct=
x)
 SEC("uprobe//proc/self/exe:trigger_func3")
 int handle_uprobe_byname3(struct pt_regs *ctx)
 {
-	uprobe_byname3_res =3D 10;
+	uprobe_byname3_res =3D 11;
 	return 0;
 }

@@ -110,14 +166,16 @@ SEC("uretprobe.s//proc/self/exe:trigger_func3")
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


