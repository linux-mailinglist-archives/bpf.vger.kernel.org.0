Return-Path: <bpf+bounces-37971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F7C95D583
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 20:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1293A1C226A1
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 18:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018D6192B98;
	Fri, 23 Aug 2024 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="eyocGSdI"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CADA1925B9
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 18:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724438946; cv=none; b=b2iI482/TC7zwJkVLz15yxcnnNIqfjv9+sKozCgCw2q5eK//UHKGD7xn7HP9MVcneLhAbnh5VCo3GiIm22Nu9MBHidrvNoxGffJ0urszZ52/Hm5wK4u35M8y3+HiumTh4t0LetN9jDOTlWKqKOzT+fV/3b1hxnopdTm+ioQdRWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724438946; c=relaxed/simple;
	bh=NQPN4W6/rLTlef9kXZtkOL2YDXoMAchcbZzQZ7M5zSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guE3z4Qx5T45yOSx3wyqLcfcWUnaJhiKaeUVu+SNTAb6budVVX0JSfcZ8RBF1ZVFaYbISXP/ZqRz/8dxzuhxaEoOS7ocdGAam5mvMyyddSdK8I56ZnKdURt9gg2UsVwyLiKp5TNiuPgToMPDv/i4Emqffe1DyrSQX5UMT9tzz0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=eyocGSdI; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1724438927; x=1725043727; i=linux@jordanrome.com;
	bh=dhohmZQQKi8SDS9l0p25MKao6cZ1ghMcWn8pOREp6Rc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eyocGSdIGxGSLvrGmGb/gfarpW9puZNInXiJG0qiT9BGTMplwCaxM3lHP5yYpUdy
	 nr+j1KPancwu6QQ5g7BiXA/znVwJSuS9ceKkKsS55MA9kdUjou/OUosuz/MwGA0b8
	 STpD/Lnzmqh5hA+ZTJswyt0MCv0uZkEgkZTSo/jvvIYOqyaTe04TfUXxblmqNEzEt
	 XhxqdMNelIF3YTPonGbvpopJB0SCDE746ykA8y2F9dJgiW5KN/rSwmRl450RGzcNf
	 XYX6maeMNNagk3dpIri7MOmUtjNzLWPlAq3Y40I91OKxjcmra3TwZ2a7JppKXP+4j
	 gmxVD5qohrEhl4AC8A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([173.252.127.11]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MH1qm-1svKzk3vxS-008hX8; Fri, 23 Aug
 2024 20:48:47 +0200
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	sinquersw@gmail.com
Subject: [bpf-next v9 2/2] bpf: Add tests for bpf_copy_from_user_str kfunc
Date: Fri, 23 Aug 2024 11:48:23 -0700
Message-ID: <20240823184823.3236004-2-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240823184823.3236004-1-linux@jordanrome.com>
References: <20240823184823.3236004-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x+LB955B1CxBVMLWQFdhI+tTS4eLaHc7vldn7SPGBx0goAhIDb7
 Pw7AVvDC9nnXhOFt0gdN75LbpfRfkb4v8arWJNrt72/mCfVqkn6m3wY2/R8ASK5ErftaEks
 3Y0MDAymvEysW2NZ0zRO1FJnowvcjIEzMa+p/r2C6kOqyZu15Inj0ebQBxB/d1KoWiYSxVK
 H1NPoaoz2381nrpVLeyGg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:96bNlISd0GE=;W/mj1Yc8EemRBprIXMgBlrQPUtd
 8xCx7EA53/zigvq+uUGXl58P/oe6gNny7uY2Irwrf7tIU4GA47GWc+G5enI0t1Vy9fgcOWRB9
 Hg1kq1CWncKDv8UcJ5AcYxGkoI+XOlGzrT1Px3XnbTNl3lNylXniv9PD90c0dIw40bZhgzChV
 fe7x1PA5ja55HOfyv5V6TQJlgAfsxrr0kK+/EKhCHByUxCjRwls9d5Xhd0Z2lmkwV1/fYMn9d
 0mibPRR2A5rrTZ6Y0QlWrvx/aKJacj+CxEGXmxuIAMMbsiqtbtj3WCBABcPQKYTFKe7YZ6jCe
 CWWppH1GE5LG1loSAtIi0UdqXywY4bLCxMAZYti1QKR9sB4uG9bdo+eS0QclfBfGl1gn2671c
 nbcNiah9DTjUxcEImcELCXAkMJwtpzVzf9TBooToyuJRiUyRsYolXIA9LWKV7bSEfVGidclsl
 /A+wUHUV2M+kfAWZjpv9J7y9fSVE7qBqGcnm1r7bao8kvVrjjl0LWl0WngCM7xlSAO1hdgMki
 RiQi5NATXeJw+FU7WV2X2XnDYzgssi+CS6zdCN1hkiji9yXzSVQ+Y5cdJNxGmMFNH2jVEoX3E
 /JOSGKcdxx9qBSdeNv0U5ylmrYBwJdh2K7SulKyeb4UD/sG5WEQ5kBINed+uB4dbFZxuOoyKk
 yzFhLSNODp2s4xpF7YG7CyxETJsCZjkSC5JIrP9a0djvBq6pvhylQSqddFUjNZlt/krTaVl6J
 TdX3NkaWnFWDuhku0Cu6UXno5U9Y8nuUg==

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
index 68466a6ad18c..0b16502726f8 100644
=2D-- a/tools/testing/selftests/bpf/progs/test_attach_probe.c
+++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
@@ -5,6 +5,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
+#include <errno.h>
 #include "bpf_misc.h"

 int kprobe2_res =3D 0;
@@ -14,10 +15,15 @@ int uretprobe_byname_res =3D 0;
 int uprobe_byname2_res =3D 0;
 int uretprobe_byname2_res =3D 0;
 int uprobe_byname3_sleepable_res =3D 0;
+int uprobe_byname3_str_sleepable_res =3D 0;
 int uprobe_byname3_res =3D 0;
 int uretprobe_byname3_sleepable_res =3D 0;
+int uretprobe_byname3_str_sleepable_res =3D 0;
 int uretprobe_byname3_res =3D 0;
 void *user_ptr =3D 0;
+u32 dynamic_sz =3D 1;
+
+int bpf_copy_from_user_str(void *dst, u32, const void *, u64) __weak __ks=
ym;

 SEC("ksyscall/nanosleep")
 int BPF_KSYSCALL(handle_kprobe_auto, struct __kernel_timespec *req, struc=
t __kernel_timespec *rem)
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
+	// Make sure this passes the verifier
+	ret =3D bpf_copy_from_user_str(data_long, dynamic_sz &=3D sizeof(data_lo=
ng), user_ptr, 0);
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


