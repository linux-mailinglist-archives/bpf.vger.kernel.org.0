Return-Path: <bpf+bounces-36851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAA294E3E8
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 01:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE2B1C212C6
	for <lists+bpf@lfdr.de>; Sun, 11 Aug 2024 23:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E29165F01;
	Sun, 11 Aug 2024 23:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="prNVtFfW"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750391757E
	for <bpf@vger.kernel.org>; Sun, 11 Aug 2024 23:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723420522; cv=none; b=IJHGYi6HaOLOYCy8QdWBeZWu9HXFNL0H+X6YK2ti6rD0Qh1xAR9ShcxRHXRXZQmvWnCUNWR9brru0xAn1OJtWRdQ66xIVEbhwxcUBB0HBdQitgLJ/mJectAq7KCrfAZl5uqbmOzggui3XU4UR+jeexXQNMS60c6UTOfEDSvHuFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723420522; c=relaxed/simple;
	bh=j/iyd9Wj/CzwYujkJo5hvveJ5VOoORctIvVxB5DigxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gi4DPoIvzklKcbALL+eMp2JhY+IcM6jpRjfl6E6SrVjvoyh2p29VNWB2siaxpuzU1uUrUeCC1luUraObLlDCO0m0x0cZUUAhFHBl5hw0RhQqO05t0lVF4djTUBnFM+w+netRfOc1aFZXvH3gtu9ZWCqn4vA9Wg76iwIxKOna/UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=prNVtFfW; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1723420499; x=1724025299; i=linux@jordanrome.com;
	bh=H9rl89dQ6kKUY7fTAUpX4tnqcgks3UcLtRdapEqG0kc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=prNVtFfWj7iAQ/ms1cAWEd1qQtWgVuDtCtu2/6ag8afKfnbEVWfE2LnAszGkaa2m
	 5ZYtfKHGJut1FXXBe2TsOorItBMKus/apmRDKVaicMjdzUjyTzYLa2h+weDHwCfO+
	 SVogKQOz7L+dQEuRT33QUl4jVMe/CZ2knMLS6dXh30Z+bEmfsjUrHxahsQqSGDgmV
	 virHakEg7i8kgE73AlMTrMONhtErg1poAIMiZw/x5JhPa7rHgnLgb3waqiOSfvE8k
	 dIxJTo+dv4ftyKKx0g8zc6Ul2n4eN2oAwVpo4AuexpWT6ShzORJ5pWHqQ/DLaENXV
	 p/D0g1Y2BrCMqGr0lg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([173.252.127.2]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LjYVi-1s21m63QPg-00fGRm; Mon, 12 Aug
 2024 01:54:58 +0200
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	sinquersw@gmail.com
Subject: [bpf-next v2 2/2] bpf: Add tests for bpf_copy_from_user_str kfunc
Date: Sun, 11 Aug 2024 16:54:39 -0700
Message-ID: <20240811235439.1862495-2-linux@jordanrome.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240811235439.1862495-1-linux@jordanrome.com>
References: <20240811235439.1862495-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ss12znfmAchQkygViBjB9wB/hea6BvfpOEqh5zVNmGAGkJDi5v3
 IFeQflf6gMEwo0rCo2LWPOoHKkMfrjQIIk2Lc/QrGs8a5n1l51zFaApxayPvmdMBOz1huTc
 D8rvk0NiQokfpuWDjTrsh/AW0t1LE0A1JpG9RM3cGWDKW0JOAD6A7UbzrQzolYNOFErM/OT
 1wMcV11rjjWZyZskjy9Nw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ShJIiMhBmh0=;pRNysiXn9bXRbnIRxMizyvlZ7HM
 a6lu29joK88h6OsCbCDHTlyyoSSJRButxmbjfMwnH2T/xmotL7NSwa8nHJmmMptLQuORRSYzk
 4fyzChUxpoHOof/J85sUmt494gUnObNg4C2Zw5NhY25h8zBK4FdbJhZN49rvcuEjGuTllnCRq
 zI5HxxiHRp4dgt3miuMTQMP9GLei5jDHc6OeaFcG5suZtpxIXeJzwbdwAENitMJ8xle/gPlHS
 tQreY/k/c55ZhEqgt41NJyN8Op1UoT6jE2Y9erg3u43yhXXXYaxyvbaXmL9QE08SvefE9A164
 RS4ordLyFoZUZQTsC7tYCVKDAcUkiB+KgrjZdF1W2tllkzxjOd9qN6sWf9zLveishq1A7Z9UW
 VItqPmSSwr/WQ1Rd/AjDx5tqtCjdsgZM5SdYCb1g9FS7luLGZEo5Cbihiu/11HhajMFAChw7N
 PMANrPHEruTnoVlKPPt2+NtsRraA3b6VWRrOxAjC8mULizkvIp5J5A5HwjAPlXLs1GSmruxUb
 Kl/kLdm2CjfB+ok9UYKyWYyou5DvnRgX3/IMDgssd+2aqhFZL7rQDZuNa/V8x0WmdPckLqmCV
 a62Q+yj/NKIvWRFxdPLQ3HOQLCrjw7Fql9mBFWq/E7AOcRoK8R7irxal/sqUfFRQSg/vaYJrW
 mEoVbRag88anga0bBStKbY8TKmYIBiotydlwlh5lktiq+206PMf17BV5Z6JmAfg2GUeyTbZIW
 b3CtnthvXGhI0WfL19pc+Zkekl+BeEcfA==

This adds tests for both the happy path and
the error path.

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 .../selftests/bpf/prog_tests/attach_probe.c   |  8 ++++---
 .../selftests/bpf/prog_tests/read_vsyscall.c  |  1 +
 .../selftests/bpf/progs/read_vsyscall.c       |  9 ++++++-
 .../selftests/bpf/progs/test_attach_probe.c   | 24 ++++++++++++++++---
 4 files changed, 35 insertions(+), 7 deletions(-)

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
index 68466a6ad18c..8b63d9507625 100644
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
@@ -87,11 +91,23 @@ static __always_inline bool verify_sleepable_user_copy=
(void)
 	return bpf_strncmp(data, sizeof(data), "test_data") =3D=3D 0;
 }

+static __always_inline bool verify_sleepable_user_copy_str(void)
+{
+	int ret;
+	char data[4];
+
+	ret =3D bpf_copy_from_user_str(data, sizeof(data), user_ptr);
+
+	return bpf_strncmp(data, 3, "tes") =3D=3D 0 && ret =3D=3D 4 && data[3] =
=3D=3D '\0';
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

@@ -102,7 +118,7 @@ int handle_uprobe_byname3_sleepable(struct pt_regs *ct=
x)
 SEC("uprobe//proc/self/exe:trigger_func3")
 int handle_uprobe_byname3(struct pt_regs *ctx)
 {
-	uprobe_byname3_res =3D 10;
+	uprobe_byname3_res =3D 11;
 	return 0;
 }

@@ -110,14 +126,16 @@ SEC("uretprobe.s//proc/self/exe:trigger_func3")
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
2.44.1


