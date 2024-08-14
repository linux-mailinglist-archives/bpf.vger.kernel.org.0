Return-Path: <bpf+bounces-37132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFC5951121
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 02:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2896C1F23641
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 00:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64A38469;
	Wed, 14 Aug 2024 00:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="oqy3qmyv"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8B46138
	for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 00:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723596364; cv=none; b=NiM1qMVxyaXtW+f1/8fBon2VY0VlNgwDpYsUMeZvYsaoi5W+3DyGobJmnq4QgHRmGgPvLv9m+g/xLIYJi/twq2nganD0A/4LrcQUq4jY209DVbhtV6L30cN+ccljLQnfGOukkh/FpqH7J225q1XRvpFAoyGFFs6VIAAKbj+DFNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723596364; c=relaxed/simple;
	bh=7RFNXU5vDpAugXJKOWOsyJopZB5YUU/kpigSyuDm0Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FoPTKfcRB7AqSVRrNsVjtkAK4LjjpimJlNBo0zodX3RQpn3XN+usOqOgosi+Ldc5qEzWXh9Dw9TIX1MepsPnsOU3nQGtAHy9TlmRhO7Qdq1bC6Q2lz7jLoJmA3M4fTs7YkZo8EH903vkOzTMVP90b857FqJXvvi6R9OuYgoV77M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=oqy3qmyv; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1723596345; x=1724201145; i=linux@jordanrome.com;
	bh=tdhehY2n5wF78ENxZOUkz2WXqL8pPuuncK5F6rvpm28=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oqy3qmyvNT/oGud+9CVqdyOhwbfRCtaKoB3egXJT+4x8uhbJwl5R4pjywGoQkQ7e
	 hh51Qw16CDs49gJSaMfQ1GoCm87KVDRgWSBbmx+tsjMVfoBrvhnS9QMw6K7FtWpIi
	 j/i3apy3pHra4laaPF3Q83iz3HIBlt+6mRPz+OTe0leLDTW6bVsfsgNpYtJmbZXhi
	 Zv/et9QlHO7T88ZN0kG3oDCYmhzLZDiu5/B0Q+r0Z/Ytq5Wijb3mVfXmqHouitVkj
	 UJ0Gjzz/Elt1Zkrgh0RMTI2jvoz0De1fOZs6i4ze+4Vye1RwFWx1OOZujiRttYCaQ
	 aVNUdoLeo4/IQETrzQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([173.252.127.8]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MwxJ1-1sEmHr3083-011mpD; Wed, 14 Aug
 2024 02:45:44 +0200
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	sinquersw@gmail.com
Subject: [bpf-next v4 2/2] bpf: Add tests for bpf_copy_from_user_str kfunc
Date: Tue, 13 Aug 2024 17:45:31 -0700
Message-ID: <20240814004531.352157-2-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240814004531.352157-1-linux@jordanrome.com>
References: <20240814004531.352157-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VwPKl4ZCDeohcokh3RcUH30z79SD+KJalmVKCHMH8nHhiVb4MS5
 XX4eWiz+8jIeI3rC8HaXgc2sK21H5E50ARH/Qez4q5D9vbdoFhEbYIN7NHvMhHj64R6T6qV
 q3Fssh49b9Lm/bVOPMkhbIUd+08LUWNcRWDVUAEsnb1XLWeSFUjM/vu41GrHulITA7IdWb2
 NP3D6vtdm2Tmi+MwCTmBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xmmE9kURbdY=;tToZKpdFXpZzmpul8iw9/0IAtfY
 gQIE3Y9qMUNGRjER12DDJzoLWsZ5cNaarHdSulrrGj+laKZSadX+UvgFpM3vnH0D7IoLar/bk
 XZA071vCZBve9StKvz30Lo+tvG1p+vP45AtFxJjrdk1oOdDG+q6JWWL5h1KC9pn4RPM2k6mqX
 Rryx37/wC8lJjYPUb7JtlPA5cy75XycoAKoSQ1ACtr5aFWMQBoGGuOWkhHqhvG8sb5IxqZ5Za
 trMjU0o69s12eofLG2/ujf4aj7HwyiL6hkqy2mUe0oHJAynvgom3qhtUFHPF96vZYRlToS1YN
 7vSMJJHzOoDUm9Daq1Cfgyq2+mO4dwfDpcMT8XJNroS5tAWuc0Tvq10UjNDRhHs/CFGLDZ8S1
 jHWPTUCik1rR6EJN6+YwvQDEyfeCTct2Ne0Oih0r+cm8beqodOc7G7MC++kbf6D5Gsd+a7U46
 5Pf4TWsKsyoUx4D/v6OCcEG+H7E2ptNjI2QPHSttDEnHEvb2aEO6DJGV93zqQf9Efo1wvic5I
 1BcvIrmXThxOzkKkpXMj8QOZagLbFywVMuORV4NYBFux7goR5RJGzIvLkFm4VZ1SKjRzRjPnv
 IhPiw5YoBtvwNAkYX+C6f5YIgpDkyje+6WGBr2v+ywImERy4tkphcxIP0mfQkupeA6FRyyfZ5
 SL2y9fnkwMLcOS4lQRpeAAqh3UJw7W4c6UnIkw07AmzQRD+jIzZf+D7muiIwzaPt79vohtIcM
 PjAuxDPVz78rdNn2Fl5TM8vl1/UPItUxg==

This adds tests for both the happy path and
the error path.

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 .../selftests/bpf/prog_tests/attach_probe.c   |  8 ++--
 .../selftests/bpf/prog_tests/read_vsyscall.c  |  1 +
 .../selftests/bpf/progs/read_vsyscall.c       |  9 ++++-
 .../selftests/bpf/progs/test_attach_probe.c   | 38 +++++++++++++++++--
 4 files changed, 49 insertions(+), 7 deletions(-)

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
index 68466a6ad18c..705830d44101 100644
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

+int bpf_copy_from_user_str(void *dst, u32, const void *, u64) __weak __ks=
ym;
+
 SEC("ksyscall/nanosleep")
 int BPF_KSYSCALL(handle_kprobe_auto, struct __kernel_timespec *req, struc=
t __kernel_timespec *rem)
 {
@@ -87,11 +91,37 @@ static __always_inline bool verify_sleepable_user_copy=
(void)
 	return bpf_strncmp(data, sizeof(data), "test_data") =3D=3D 0;
 }

+static __always_inline bool verify_sleepable_user_copy_str(void)
+{
+	int ret;
+	char data_long[20];
+	char data_short[4];
+
+	ret =3D bpf_copy_from_user_str(data_short, sizeof(data_short), user_ptr,=
 0);
+
+	if (bpf_strncmp(data_short, 4, "tes\0") !=3D 0 || ret !=3D 4)
+		return false;
+
+	ret =3D bpf_copy_from_user_str(data_long, sizeof(data_long), user_ptr, B=
PF_ZERO_BUFFER);
+
+	if (bpf_strncmp(data_long, 10, "test_data\0") !=3D 0 || ret !=3D 10 || d=
ata_long[19] !=3D '\0')
+		return false;
+
+	ret =3D bpf_copy_from_user_str(data_long, sizeof(data_long), user_ptr, 0=
);
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

@@ -102,7 +132,7 @@ int handle_uprobe_byname3_sleepable(struct pt_regs *ct=
x)
 SEC("uprobe//proc/self/exe:trigger_func3")
 int handle_uprobe_byname3(struct pt_regs *ctx)
 {
-	uprobe_byname3_res =3D 10;
+	uprobe_byname3_res =3D 11;
 	return 0;
 }

@@ -110,14 +140,16 @@ SEC("uretprobe.s//proc/self/exe:trigger_func3")
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


