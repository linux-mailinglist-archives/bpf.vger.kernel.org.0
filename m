Return-Path: <bpf+bounces-57621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C25BAAD42C
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 05:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928C24A7F4F
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 03:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015001C3306;
	Wed,  7 May 2025 03:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bd4xpryO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC57E1B4257
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 03:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746589405; cv=none; b=VVub0RMNEzJNAxHkB71ThPlSBFapN8r6lxZqtJ5ZbNC5B9BgoFodeBHTQdKJ2UXv7sRcGlra9RFI8pl8U0B22szpKyUdFAkveVZv1tytt6lmI9iWGoAjpFVgCL4nAxwBq/COUZKONBLF2LHbYWjKxd3JjA0bBL0Q9aheEhyofOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746589405; c=relaxed/simple;
	bh=vhT4ebnDSOuGc/hBH0mR1WDRzKLAVqxH8K/LtHDqkZY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XAR9AI4Aqb+NGzyjZx45Nk1IjkMfw6hKP7B4g4Jax/xYD5EnCRrFEpVGzN+xPJ5T23rVOGo//2vMYdCSR5UKmmKBQwCwNA39UoT85V4MMeSjBq0AfB4PclkcLI0kxMMoWh/N8KK61DH1N1rsGshE68lO45SC94JUwKOJzhWT9b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bd4xpryO; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2da91df7a3dso6664874fac.1
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 20:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746589403; x=1747194203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HIjhaUFku2d30Onds8TPaHevH2XK2FGkuZ8H2DLrsm4=;
        b=Bd4xpryO0RpJJ7lNS3W8MsdRADVTzN0wdWH7k8Zsni7DbEaPiUAP6hjyBetIkOPwk3
         CS+NxeaCmKIyCSQKrVWpanj3G5q0iRTxyH1anMFe72EM4hjlTAT1MZB2LJfVWrOUFhK6
         N9agFgSDCJblpv5kJaKm30tRJgO5a6YwWN2Sb2pqMx6Za44L+q687jCBcqIu0KFHbwmu
         ez8AZA/mcmEKtNuPOiXegpjWibAFdamX4FYxSv3DhWJVLm4gBzrN+I1Wam0ZUwCsW45c
         /f3Hicd96GVZjVv6Du5LqGKB6FJh6AbuEPwY98bW5mXS7jS7lH33xtyK00Y3/6qXOMmv
         Vnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746589403; x=1747194203;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HIjhaUFku2d30Onds8TPaHevH2XK2FGkuZ8H2DLrsm4=;
        b=jgfIa4ZVJ8bV+5Vy0mUrD4KUz4q08cuXJXHrBn8cMxbNHTwLhU5+S3FbL0/sKu2JBY
         wA4+hpDDuzfF9C5NSQDol2Z+oRILdlpOsRRX7ViGArp62gm2wY8Q2N8Qud3cWQ9Sutcw
         y6ipB+a+CFy7m8F4+8gVsYemVfeUb7UdPc5adVC0qnvIbzt8bV24tuvDTPToCj3+L3k+
         9KTneHNofYLeNOvJz6iXAdFqXn4A9xoyZysIBoPw0BRlHwcTjA/Nr6JSxZok/yg2Qqfm
         ILP60V9FIdY6uB4+amSe8Tr8dqGfnlDpAtXR236P1YP8qNodUQJS6HxTJMo72A9f1hbW
         6bCA==
X-Gm-Message-State: AOJu0Yy3vq6kfIMwJSYZ230rjG3Hlw7xpqfM9laXF6jQP7tSgE6/IY3l
	OfrsQJu9sZLbVk83hArBVU5MPT/EPaJfmwLwYLdep+gilqvOOtn1ZGWgbciJswcnWyfEOBB/VaH
	TdFYfjnskjoH+JRtgNl3KgjsGCJTXfbLqOvHzJ3f2MMM37KuPupWEOq+QumX8kVI3dplXcN3c47
	khWEoyL9yqmnT338fUQDmvUIbB9IPkKVFavk2D1g4=
X-Google-Smtp-Source: AGHT+IEQ/bV1QgLKYOw74jiDCdQit/bsQIlhJxD6STisAverFe6J/w+Xjoafr+jCJijR7St5IPcQp76UWAePoA==
X-Received: from oabsk19.prod.google.com ([2002:a05:6871:8013:b0:2c2:5d77:108f])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:310:b0:29e:569a:f90d with SMTP id 586e51a60fabf-2db5c10ad14mr1022015fac.32.1746589402967;
 Tue, 06 May 2025 20:43:22 -0700 (PDT)
Date: Wed,  7 May 2025 03:43:19 +0000
In-Reply-To: <cover.1746588351.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1746588351.git.yepeilin@google.com>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <d67f4c6f6ee0d0388cbce1f4892ec4176ee2d604.1746588351.git.yepeilin@google.com>
Subject: [PATCH bpf-next v2 6/8] selftests/bpf: Avoid passing out-of-range
 values to __retval()
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org
Cc: Peilin Ye <yepeilin@google.com>, linux-riscv@lists.infradead.org, 
	Andrea Parri <parri.andrea@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@kernel.org>, Pu Lehui <pulehui@huawei.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, 
	Neel Natu <neelnatu@google.com>, Benjamin Segall <bsegall@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Currently, we pass 0x1234567890abcdef to __retval() for the following
two tests:

  verifier_load_acquire/load_acquire_64
  verifier_store_release/store_release_64

However, the upper 32 bits of that value are being ignored, since
__retval() expects an int.  Actually, the tests would still pass even if
I change '__retval(0x1234567890abcdef)' to e.g. '__retval(0x90abcdef)'.

Restructure the tests a bit to test the entire 64-bit values properly.
Do the same to their 8-, 16- and 32-bit variants as well to keep the
style consistent.

Fixes: ff3afe5da998 ("selftests/bpf: Add selftests for load-acquire and sto=
re-release instructions")
Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Reviewed-by: Pu Lehui <pulehui@huawei.com>
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com> # QEMU/RVA23
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 .../bpf/progs/verifier_load_acquire.c         | 40 +++++++++++++------
 .../bpf/progs/verifier_store_release.c        | 32 +++++++++++----
 2 files changed, 52 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_load_acquire.c b/to=
ols/testing/selftests/bpf/progs/verifier_load_acquire.c
index 77698d5a19e4..a696ab84bfd6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
+++ b/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
@@ -10,65 +10,81 @@
=20
 SEC("socket")
 __description("load-acquire, 8-bit")
-__success __success_unpriv __retval(0x12)
+__success __success_unpriv __retval(0)
 __naked void load_acquire_8(void)
 {
 	asm volatile (
+	"r0 =3D 0;"
 	"w1 =3D 0x12;"
 	"*(u8 *)(r10 - 1) =3D w1;"
-	".8byte %[load_acquire_insn];" // w0 =3D load_acquire((u8 *)(r10 - 1));
+	".8byte %[load_acquire_insn];" // w2 =3D load_acquire((u8 *)(r10 - 1));
+	"if r2 =3D=3D r1 goto 1f;"
+	"r0 =3D 1;"
+"1:"
 	"exit;"
 	:
 	: __imm_insn(load_acquire_insn,
-		     BPF_ATOMIC_OP(BPF_B, BPF_LOAD_ACQ, BPF_REG_0, BPF_REG_10, -1))
+		     BPF_ATOMIC_OP(BPF_B, BPF_LOAD_ACQ, BPF_REG_2, BPF_REG_10, -1))
 	: __clobber_all);
 }
=20
 SEC("socket")
 __description("load-acquire, 16-bit")
-__success __success_unpriv __retval(0x1234)
+__success __success_unpriv __retval(0)
 __naked void load_acquire_16(void)
 {
 	asm volatile (
+	"r0 =3D 0;"
 	"w1 =3D 0x1234;"
 	"*(u16 *)(r10 - 2) =3D w1;"
-	".8byte %[load_acquire_insn];" // w0 =3D load_acquire((u16 *)(r10 - 2));
+	".8byte %[load_acquire_insn];" // w2 =3D load_acquire((u16 *)(r10 - 2));
+	"if r2 =3D=3D r1 goto 1f;"
+	"r0 =3D 1;"
+"1:"
 	"exit;"
 	:
 	: __imm_insn(load_acquire_insn,
-		     BPF_ATOMIC_OP(BPF_H, BPF_LOAD_ACQ, BPF_REG_0, BPF_REG_10, -2))
+		     BPF_ATOMIC_OP(BPF_H, BPF_LOAD_ACQ, BPF_REG_2, BPF_REG_10, -2))
 	: __clobber_all);
 }
=20
 SEC("socket")
 __description("load-acquire, 32-bit")
-__success __success_unpriv __retval(0x12345678)
+__success __success_unpriv __retval(0)
 __naked void load_acquire_32(void)
 {
 	asm volatile (
+	"r0 =3D 0;"
 	"w1 =3D 0x12345678;"
 	"*(u32 *)(r10 - 4) =3D w1;"
-	".8byte %[load_acquire_insn];" // w0 =3D load_acquire((u32 *)(r10 - 4));
+	".8byte %[load_acquire_insn];" // w2 =3D load_acquire((u32 *)(r10 - 4));
+	"if r2 =3D=3D r1 goto 1f;"
+	"r0 =3D 1;"
+"1:"
 	"exit;"
 	:
 	: __imm_insn(load_acquire_insn,
-		     BPF_ATOMIC_OP(BPF_W, BPF_LOAD_ACQ, BPF_REG_0, BPF_REG_10, -4))
+		     BPF_ATOMIC_OP(BPF_W, BPF_LOAD_ACQ, BPF_REG_2, BPF_REG_10, -4))
 	: __clobber_all);
 }
=20
 SEC("socket")
 __description("load-acquire, 64-bit")
-__success __success_unpriv __retval(0x1234567890abcdef)
+__success __success_unpriv __retval(0)
 __naked void load_acquire_64(void)
 {
 	asm volatile (
+	"r0 =3D 0;"
 	"r1 =3D 0x1234567890abcdef ll;"
 	"*(u64 *)(r10 - 8) =3D r1;"
-	".8byte %[load_acquire_insn];" // r0 =3D load_acquire((u64 *)(r10 - 8));
+	".8byte %[load_acquire_insn];" // r2 =3D load_acquire((u64 *)(r10 - 8));
+	"if r2 =3D=3D r1 goto 1f;"
+	"r0 =3D 1;"
+"1:"
 	"exit;"
 	:
 	: __imm_insn(load_acquire_insn,
-		     BPF_ATOMIC_OP(BPF_DW, BPF_LOAD_ACQ, BPF_REG_0, BPF_REG_10, -8))
+		     BPF_ATOMIC_OP(BPF_DW, BPF_LOAD_ACQ, BPF_REG_2, BPF_REG_10, -8))
 	: __clobber_all);
 }
=20
diff --git a/tools/testing/selftests/bpf/progs/verifier_store_release.c b/t=
ools/testing/selftests/bpf/progs/verifier_store_release.c
index 7e456e2861b4..72f1eb006074 100644
--- a/tools/testing/selftests/bpf/progs/verifier_store_release.c
+++ b/tools/testing/selftests/bpf/progs/verifier_store_release.c
@@ -10,13 +10,17 @@
=20
 SEC("socket")
 __description("store-release, 8-bit")
-__success __success_unpriv __retval(0x12)
+__success __success_unpriv __retval(0)
 __naked void store_release_8(void)
 {
 	asm volatile (
+	"r0 =3D 0;"
 	"w1 =3D 0x12;"
 	".8byte %[store_release_insn];" // store_release((u8 *)(r10 - 1), w1);
-	"w0 =3D *(u8 *)(r10 - 1);"
+	"w2 =3D *(u8 *)(r10 - 1);"
+	"if r2 =3D=3D r1 goto 1f;"
+	"r0 =3D 1;"
+"1:"
 	"exit;"
 	:
 	: __imm_insn(store_release_insn,
@@ -26,13 +30,17 @@ __naked void store_release_8(void)
=20
 SEC("socket")
 __description("store-release, 16-bit")
-__success __success_unpriv __retval(0x1234)
+__success __success_unpriv __retval(0)
 __naked void store_release_16(void)
 {
 	asm volatile (
+	"r0 =3D 0;"
 	"w1 =3D 0x1234;"
 	".8byte %[store_release_insn];" // store_release((u16 *)(r10 - 2), w1);
-	"w0 =3D *(u16 *)(r10 - 2);"
+	"w2 =3D *(u16 *)(r10 - 2);"
+	"if r2 =3D=3D r1 goto 1f;"
+	"r0 =3D 1;"
+"1:"
 	"exit;"
 	:
 	: __imm_insn(store_release_insn,
@@ -42,13 +50,17 @@ __naked void store_release_16(void)
=20
 SEC("socket")
 __description("store-release, 32-bit")
-__success __success_unpriv __retval(0x12345678)
+__success __success_unpriv __retval(0)
 __naked void store_release_32(void)
 {
 	asm volatile (
+	"r0 =3D 0;"
 	"w1 =3D 0x12345678;"
 	".8byte %[store_release_insn];" // store_release((u32 *)(r10 - 4), w1);
-	"w0 =3D *(u32 *)(r10 - 4);"
+	"w2 =3D *(u32 *)(r10 - 4);"
+	"if r2 =3D=3D r1 goto 1f;"
+	"r0 =3D 1;"
+"1:"
 	"exit;"
 	:
 	: __imm_insn(store_release_insn,
@@ -58,13 +70,17 @@ __naked void store_release_32(void)
=20
 SEC("socket")
 __description("store-release, 64-bit")
-__success __success_unpriv __retval(0x1234567890abcdef)
+__success __success_unpriv __retval(0)
 __naked void store_release_64(void)
 {
 	asm volatile (
+	"r0 =3D 0;"
 	"r1 =3D 0x1234567890abcdef ll;"
 	".8byte %[store_release_insn];" // store_release((u64 *)(r10 - 8), r1);
-	"r0 =3D *(u64 *)(r10 - 8);"
+	"r2 =3D *(u64 *)(r10 - 8);"
+	"if r2 =3D=3D r1 goto 1f;"
+	"r0 =3D 1;"
+"1:"
 	"exit;"
 	:
 	: __imm_insn(store_release_insn,
--=20
2.49.0.967.g6a0df3ecc3-goog


