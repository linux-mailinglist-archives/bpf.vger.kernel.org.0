Return-Path: <bpf+bounces-36800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFAC94D86D
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 23:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730711C21A4A
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 21:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C12626AE4;
	Fri,  9 Aug 2024 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="J2lk4erI"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ED017557
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723238941; cv=none; b=nn1OvX+6hZcxhQZh96XvnfSg+/ce86kW18kbGjSs4XNT0ZeYOqjHGSCQF20AsP1ETkTJ0tpBp3LdIPAROp2XUeYFrf8VyTzNGuTqkezwG8hpIiIlPNi1n3/l1W8PA2Lbwk9cR1l/evd0Hc1OL5KgiEAMt6uoIR+kRspbBYH4rRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723238941; c=relaxed/simple;
	bh=Keu+xKUGrE5wpo2CHuJL9pJMR08WeG+OpyChTI4ujiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FNUxoCz9X2b6zu5ZsIleKa/VYp5vaaqFHQf3UwtXZozYRmduQrw/InbC5RRh+R4Q2p9TLvpzvqirHCjftrATD/nHxaS5SkSx4s7z2dHI/cjtr8ngZ2BA3jWs40HOhRsnNjtWBL5IHPskb8L1lyDEUu1ybqGVq4eVOY8jWJLqcjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=J2lk4erI; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1723238935; x=1723843735; i=linux@jordanrome.com;
	bh=W0HTIEnecN5c+ryazzMpoCK8TO2u4Rz8kZSA8WFqhgU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=J2lk4erIyZ+WikR1id7a+YzcTP7Gy3SIUUxb6GpxRV/KT91iZSe8kZHTQZ+P+odD
	 SFWx8RST/AN+eHlqCtprcful3Ahv3QsrTjXuf+88tq4GFcjApvOK1ynPO6ACU73eT
	 JRBJUXtPk9u37qdLcGVT2jNY/Jyx/r/M9TVtD0xE1ArFDehb/EeWr9iV8p42RLSul
	 n6N03yciFXJWnXJeUx8+lnfpjAFEsZ6vjirWNCkG/7b+e7a1liG2y3T9084hz0nAD
	 GlKGH7nyVg2k5ihfNYBEFv3uka3fj+82uR8HQ1k4fxk5OkVwSlr9FgnwxpKMnDiNS
	 U0Gl7iJJd8K+Bg0jqQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([173.252.127.8]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MMTgu-1sYhKf1Iek-000Ryj; Fri, 09 Aug
 2024 23:23:15 +0200
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>
Subject: [bpf-next v1] bpf: Add bpf_copy_from_user_str kfunc
Date: Fri,  9 Aug 2024 14:23:01 -0700
Message-ID: <20240809212301.3782412-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qd7Q9T4Ig3RgUa0ZB1OnkV2Hxu/4RKqwuWmMpjXSrqIIu8/wI3l
 pCqvY87ZVTaffxLKTLphM+n0uCAo5cPgjJ123GLEQyAOO4JzqAKAeLcttbJQJd7mDGEniZM
 Jz8u3YsV0IDIlOh0jv3kOAA48aReoBYt69CSzKrTCX86nNI8+qC/itYuWZLpiRxMlyTUVDM
 zY9zYfV6IGwmq/mRTyYhg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oOKcJpVS/F8=;NLwo3HTlW45SIvrS/qMBh7MnYuz
 RTKmkZL39jOilvBZIEmCkB2jmgTLW6E1NjEgsb+apmjI25B2/shbNK7uON8A7GBrh23qtiYZC
 IE3MAotzcF2W3Tvdmb7/7h5jTRTcDnoIIqSouJEAl1JJU2rCCLn+l33BpMGygbHqNW4UB0OOr
 7SO3bdTujly0Gc0/tfrGMohYVtJJDaiLM3yMG0bDE7hmwq61mTO5h3ZwmDyY8cD4UEi+fJLJn
 Jg72cajcnmU4mSD5VbAjOdPSoyju6HFkuCftedWPcA6jdeiPExrk8wjTnqyQAQN2vGGTNBQuj
 jdOnNV9cOH/gisoFVx8LySqi2RZLUAYYhC7x3DSoB1nKPsdHkli7rf4cA5kcCpKD/mWeWTqPt
 KM1y2rfkRJdnf5xgQ4W/1mBe3I3CLvOfUoaoRfFq8UVAb/7DuwVQI5+aezm+iWt0n3OKy5y3Y
 v9RZGYEu8W6oPDRQzBggqcQ46qzKiTMGBvmsaG4UFfRLeGwQTzqcwCpOQXmGylUpwigISsfRM
 GHFeTjTTNtu/g/JfHahsBoDsqiTYX9otR/UkqT6lgc43ELOgbsovVMAQuylUsRk5lwycwi84j
 xnF++cGF59aJzahcgaH4TR2UsiUcBwzUB1pQf0KT6wrr/PQ/wYnw8DcbjuGJcGWuqN3SIDGgB
 8vJfxfDrvRF0t3n1f0jGq9uUDlVoEKUUfNDI+dXmyktqTT6EHrNgJH4gQo+qwkUzHQdssZV4Q
 mzmFrBoN8qDEP8KoAa58G4NQVXwNkGjnQ==

This adds a kfunc wrapper around strncpy_from_user,
which can be called from sleepable BPF programs.

This matches the non-sleepable 'bpf_probe_read_user_str'
helper.

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 kernel/bpf/helpers.c                          | 26 +++++++++++++++++++
 .../selftests/bpf/prog_tests/attach_probe.c   |  8 +++---
 .../selftests/bpf/prog_tests/read_vsyscall.c  |  1 +
 .../selftests/bpf/progs/read_vsyscall.c       |  9 ++++++-
 .../selftests/bpf/progs/test_attach_probe.c   | 24 ++++++++++++++---
 5 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d02ae323996b..455cac7b2631 100644
=2D-- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2939,6 +2939,31 @@ __bpf_kfunc void bpf_iter_bits_destroy(struct bpf_i=
ter_bits *it)
 	bpf_mem_free(&bpf_global_ma, kit->bits);
 }

+/**
+ * bpf_copy_from_user_str() - Copy a string from an unsafe user address
+ * @dst:             Destination address, in kernel space.  This buffer m=
ust be at
+ *                   least @dst__szk bytes long.
+ * @dst__szk:        Maximum number of bytes to copy, including the trail=
ing NUL.
+ * @unsafe_ptr__ign: Source address, in user space.
+ *
+ * Copies a NUL-terminated string from userspace to BPF space. If user st=
ring is
+ * too long this will still ensure zero termination in the dst buffer unl=
ess
+ * buffer size is 0.
+ */
+__bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__szk, const voi=
d __user *unsafe_ptr__ign)
+{
+	int ret;
+
+	if (unlikely(!dst__szk))
+		return 0;
+
+	ret =3D strncpy_from_user(dst, unsafe_ptr__ign, dst__szk);
+	if (unlikely(ret < 0))
+		memset(dst, 0, dst__szk);
+
+	return ret;
+}
+
 __bpf_kfunc_end_defs();

 BTF_KFUNCS_START(generic_btf_ids)
@@ -3024,6 +3049,7 @@ BTF_ID_FLAGS(func, bpf_preempt_enable)
 BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
 BTF_KFUNCS_END(common_btf_ids)

 static const struct btf_kfunc_id_set common_kfunc_set =3D {
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
index 68466a6ad18c..a90fa0bf103b 100644
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
+	char data[10];
+
+	ret =3D bpf_copy_from_user_str(data, sizeof(data), user_ptr);
+
+	return bpf_strncmp(data, sizeof(data), "test_data") =3D=3D 0 && ret =3D=
=3D 9;
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


