Return-Path: <bpf+bounces-37263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F71952D77
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 13:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D021C237D6
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 11:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABA37DA65;
	Thu, 15 Aug 2024 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="SQZ1Yt56"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218EB7DA84
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 11:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723721297; cv=none; b=DS+CHnZwQeyPB8kKp6ZpkxZjQJZbtqqae3JKRMCpMiTLf2uxVdH37wqu1Y5tpRou3dZwyC34ZBRyzuUB7r3KYw9XeFLYyb/F90spdP/W3OpQMsekA3+cxwepbTnKweLqQakBAu+i/h6ba+itZaeDKRlfKiesnd2uxYvlm5r0NUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723721297; c=relaxed/simple;
	bh=7RFNXU5vDpAugXJKOWOsyJopZB5YUU/kpigSyuDm0Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irgRCyTQTnMqh9cgg8XNTrLpXMGKRwzZaRekLlXi/V10viEHayO7vtVOL09f/BkFZ+sYynaKg8H2pF689REDm4LFcLYDna+mYH47s97lrNz+CVdMSSFqEN/9+giDD4Ylbd0kzgtBeeg00daFJI2LXXny94kxBsboAFxYB752/ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=SQZ1Yt56; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1723721266; x=1724326066; i=linux@jordanrome.com;
	bh=tdhehY2n5wF78ENxZOUkz2WXqL8pPuuncK5F6rvpm28=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SQZ1Yt56C+AdZDAotyUa6bi31t9JEFsTwFv5B96Auz8SR8tkD+GKOrEM0E66AjhY
	 SL+Lu5qsP/+XvOIY0rkpCVJianN68yVKjnWWvNjacks7sjNL2F/wCphXUANHU7wDk
	 rvlOVsG+S95sWZJoT5LzzOb9rDn1caA+wJtKkvPH8q6gYAPmbUr8kZgHim3arnNv3
	 FDLUAbVsq3WF3exr1qDwJttQYficDIgqVbUHPUL/yUjGGQLROrNPkaOS6AqcTAVq7
	 gLjQ2wmuryfs2c2P+uLmKLNsmxBoGmboxv1H2XQggq7cebYQhvseYyrqyEZZQCdUr
	 jMsh+sj63PEKm/Q2SA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([173.252.127.114]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MnJ28-1rvHj33uBo-00fw9h; Thu, 15 Aug
 2024 13:27:46 +0200
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	sinquersw@gmail.com
Subject: [bpf-next v5 2/2] bpf: Add tests for bpf_copy_from_user_str kfunc
Date: Thu, 15 Aug 2024 04:27:33 -0700
Message-ID: <20240815112733.4100387-2-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240815112733.4100387-1-linux@jordanrome.com>
References: <20240815112733.4100387-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aSKEUaFLkjaK+ZjLm87JOTiY+DcE/DQeWmLd8J72Y8W7vexoR7s
 gcf+6e2mxliSrfK70PY+TUzGlx57A5wm1VCfyn7p9TnDM6x0xRD0HM8A2ffnCPHyI0Xnnt8
 6d62T8JaAeSYPMQAQTvC8Lucd2OwzErRF/cf+l4hfQOsIzCixP8GxU4CBThOxR/BaPeceE6
 SatXXRWdxMs2r5XUF4LGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AplZAfQCSlI=;U9ivRT73At/D3SAvmHtfwwI/A+G
 +ISY+d7yvEib1HCbUrQlI7z+YJMHZF40l2TGHrOmQHgcvYGuuYpHX3Xe7MRHLPzzkPv5T0oEF
 sUOhCFMdUDtpKqwOf2Jo54SlJ6dapbTTvSsk0NKqDzfFetZUICPVtoGdq003yMqd3+84b6RE7
 nBMOTSALk9MzG+jpDhKnJmJ1uUVswwyzIxJy6FQqS1R0KcI0EXMCMSm31NAWtgFe1Dp6WFeEW
 FP0bNoSQJEISJ2zPLgphiefvB+JuMXK45TX3gcTx2hvFl7oGvZXZP9/GDP00Q+5fPa/CWqvvG
 k+6dGwzpRrzmexL2rSgDtwElq1TGezMCFKzMp+lGr2t9bqaW9hStFyIIK8W/2n20SNUFdmlOe
 zysgLANuJzB/BuVKU5q2+gJGinlXiHmJlLcOImh6maLrNUcz9oBTxAXV1ZPpFO7Bjauo1BiT/
 0yB26pycaZHvr7fssudr2rqifxNbDzFCPtTQ5GEhHBOJWqJ9YeCJ6gRhih+o6yCyAMyJt1TEw
 hJzBr1Mr5VjQryAIvunpUPr8Vcw5bJlbaf9/Gg072Dff2Cq9qTyRy7gSzqsHMcp1+KpBibHHt
 VgdmFTOW3EJsIRjQlxPbComeH0xLdmITg36UwWnsTtDkhiTz47qY/liPIynqvoyMrMC6nWcDj
 lRCYZwdhPyD9JeGLFCYF1PRMRL1rMlCnBHpsBxzbE/tSadvBNdEICQzSn54WiW5hjGuyb/LaJ
 597n6cEpA8iNOAyx11CACsx0PYNwiyCwg==

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


