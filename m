Return-Path: <bpf+bounces-57018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03944AA3FDA
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 02:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A8A5A30E1
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 00:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E0D1854;
	Wed, 30 Apr 2025 00:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="crA10ciK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76902DC786
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 00:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745974279; cv=none; b=dkam8X7yFs0NyPT5LtvYjB1ME9aoQjhqXi+iGyuXqgzVdP3Ow3Z8pMYAECrfKSG6hLUHPWg8N3AlWh+gq+9f00F1ZUfG7w0S4zqX+z+YA/+L5FaYSnHfC5BxGePJWrRIn4SmTlJ89fW4+DIQou9Of7CxLTerDuBkQ6clWjCPSl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745974279; c=relaxed/simple;
	bh=eo8/NWSRZdvibySJNJLyDpSInhYAnhUfg5tVu4FW2V8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FhBaKw0mxqthGhfO18elTGp/bs+xI1fHoH6ct1G6jIZNZdWZkyCpfD0IqsTYGOv8dExcPK6CY05KnX8JW0fBJAmR7tzbizTSng474YmO4P0B/ABq5jqqFxieqmWMawczuNX9/p42JTimluCjjvHUEhB0KkhA7BwuqaM1YemD+A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=crA10ciK; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af59547f55bso3654920a12.0
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 17:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745974277; x=1746579077; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xxJ5TtWLxgaoejFEHtcTPy0MdITFEK7aLosZ4mTRA+Y=;
        b=crA10ciKad5y86w/pbFC567ZsaAIgDO5Kc0KBPwFB9ZGiT0Py4bHrmbhTv/PtwxE+d
         kyVekbX7cqbjWn3b7W1f9zXBB/11LU3cvGFSLW5WnghhFWvkaRP5R1IoLWjBSZx/TdRY
         1GEQgE6PMNTZwTtOHR5q+HX+HIy/lIeYrIBKpw51KZpRN51z3TK6kCB7Og/ObQrVEu88
         S9MJQ8lKcBL69bC7jjx25c7QKCqA07LtGb8Bz8462YhjDgUqt4TIrOy/hUCiIQG/E6PZ
         Jm/8vVvzQfhTJZJP6Nh8e9FRnvwPfRK8sK2oPZBTRtWIOJNbGIAYpO4D/IaymNjK0nGO
         0U0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745974277; x=1746579077;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xxJ5TtWLxgaoejFEHtcTPy0MdITFEK7aLosZ4mTRA+Y=;
        b=CKjOHb9HE7J2LRbigTJQNkhSZrXNrO+J/sTwQGSUTS8UazsTw68+wEKKQRWrm0AuDi
         NXTqNz51TpuTGR1oTHLBFOdxIJ7el/nY3gkqVcV8S6/PDWl5tLnq0WLi562zfuUjkDR3
         tmBz6gM2C3InhqXY33rZW13ZnAX4E23NtReOeMlOhV8+LPIfLyshIk4yuvZv7teKKNpK
         lQe7VkkVLqN7rD4FxuGjajZ5EZhqznDHF7xqB26ADMyvHckJGkgrYmhNp0bAKmyy7QWK
         cVYqoFCr85k3Kyz1UCFFQmrI30kOZszQvLqwvIQfDrmnjwlXSdZdf2vWnZ7gY+x2BA9w
         Hd5Q==
X-Gm-Message-State: AOJu0YzJ11oFCCxqi627EUCCA637JnDKAuHmPp1IERuJxXJ9YQfGOqM4
	cyMLMJAtVnY/diHfz0kr5JTNizYCwMPqBxAZwoxTpUxw3oIvIPbBODhoDzpTNa/buGm0ww4sOGS
	kCk6OFEW/sXzJCdNaLyN7M/jy/bmsQSXrzlnVFzvhljIqLdFxP9kIke6vq33G58Xb5v/vq7Afc3
	GRjF9WsOlIjXfhieIH3S0DG0DGBFLJ1q3pQn+GDiY=
X-Google-Smtp-Source: AGHT+IHFrghFeywSToDMfnV9sUQmryXM1veAHDARm5dT8I66D5TH9gpdsDeH+gy0UCH4r7Avq9x9SYzQtJdfIA==
X-Received: from pgcj4.prod.google.com ([2002:a05:6a02:5004:b0:af5:6108:71bc])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f301:b0:224:2717:7992 with SMTP id d9443c01a7336-22df5839ed8mr7240245ad.33.1745974277081;
 Tue, 29 Apr 2025 17:51:17 -0700 (PDT)
Date: Wed, 30 Apr 2025 00:51:10 +0000
In-Reply-To: <cover.1745970908.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1745970908.git.yepeilin@google.com>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <5f7e4c5ac5d254c0f42b4ba274437262e238a5cb.1745970908.git.yepeilin@google.com>
Subject: [PATCH bpf-next 6/8] selftests/bpf: Avoid passing out-of-range values
 to __retval()
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

Fixes: ff3afe5da998 ("selftests/bpf: Add selftests for load-acquire and store-release instructions")
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 .../bpf/progs/verifier_load_acquire.c         | 40 +++++++++++++------
 .../bpf/progs/verifier_store_release.c        | 32 +++++++++++----
 2 files changed, 52 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_load_acquire.c b/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
index 77698d5a19e4..a696ab84bfd6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
+++ b/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
@@ -10,65 +10,81 @@
 
 SEC("socket")
 __description("load-acquire, 8-bit")
-__success __success_unpriv __retval(0x12)
+__success __success_unpriv __retval(0)
 __naked void load_acquire_8(void)
 {
 	asm volatile (
+	"r0 = 0;"
 	"w1 = 0x12;"
 	"*(u8 *)(r10 - 1) = w1;"
-	".8byte %[load_acquire_insn];" // w0 = load_acquire((u8 *)(r10 - 1));
+	".8byte %[load_acquire_insn];" // w2 = load_acquire((u8 *)(r10 - 1));
+	"if r2 == r1 goto 1f;"
+	"r0 = 1;"
+"1:"
 	"exit;"
 	:
 	: __imm_insn(load_acquire_insn,
-		     BPF_ATOMIC_OP(BPF_B, BPF_LOAD_ACQ, BPF_REG_0, BPF_REG_10, -1))
+		     BPF_ATOMIC_OP(BPF_B, BPF_LOAD_ACQ, BPF_REG_2, BPF_REG_10, -1))
 	: __clobber_all);
 }
 
 SEC("socket")
 __description("load-acquire, 16-bit")
-__success __success_unpriv __retval(0x1234)
+__success __success_unpriv __retval(0)
 __naked void load_acquire_16(void)
 {
 	asm volatile (
+	"r0 = 0;"
 	"w1 = 0x1234;"
 	"*(u16 *)(r10 - 2) = w1;"
-	".8byte %[load_acquire_insn];" // w0 = load_acquire((u16 *)(r10 - 2));
+	".8byte %[load_acquire_insn];" // w2 = load_acquire((u16 *)(r10 - 2));
+	"if r2 == r1 goto 1f;"
+	"r0 = 1;"
+"1:"
 	"exit;"
 	:
 	: __imm_insn(load_acquire_insn,
-		     BPF_ATOMIC_OP(BPF_H, BPF_LOAD_ACQ, BPF_REG_0, BPF_REG_10, -2))
+		     BPF_ATOMIC_OP(BPF_H, BPF_LOAD_ACQ, BPF_REG_2, BPF_REG_10, -2))
 	: __clobber_all);
 }
 
 SEC("socket")
 __description("load-acquire, 32-bit")
-__success __success_unpriv __retval(0x12345678)
+__success __success_unpriv __retval(0)
 __naked void load_acquire_32(void)
 {
 	asm volatile (
+	"r0 = 0;"
 	"w1 = 0x12345678;"
 	"*(u32 *)(r10 - 4) = w1;"
-	".8byte %[load_acquire_insn];" // w0 = load_acquire((u32 *)(r10 - 4));
+	".8byte %[load_acquire_insn];" // w2 = load_acquire((u32 *)(r10 - 4));
+	"if r2 == r1 goto 1f;"
+	"r0 = 1;"
+"1:"
 	"exit;"
 	:
 	: __imm_insn(load_acquire_insn,
-		     BPF_ATOMIC_OP(BPF_W, BPF_LOAD_ACQ, BPF_REG_0, BPF_REG_10, -4))
+		     BPF_ATOMIC_OP(BPF_W, BPF_LOAD_ACQ, BPF_REG_2, BPF_REG_10, -4))
 	: __clobber_all);
 }
 
 SEC("socket")
 __description("load-acquire, 64-bit")
-__success __success_unpriv __retval(0x1234567890abcdef)
+__success __success_unpriv __retval(0)
 __naked void load_acquire_64(void)
 {
 	asm volatile (
+	"r0 = 0;"
 	"r1 = 0x1234567890abcdef ll;"
 	"*(u64 *)(r10 - 8) = r1;"
-	".8byte %[load_acquire_insn];" // r0 = load_acquire((u64 *)(r10 - 8));
+	".8byte %[load_acquire_insn];" // r2 = load_acquire((u64 *)(r10 - 8));
+	"if r2 == r1 goto 1f;"
+	"r0 = 1;"
+"1:"
 	"exit;"
 	:
 	: __imm_insn(load_acquire_insn,
-		     BPF_ATOMIC_OP(BPF_DW, BPF_LOAD_ACQ, BPF_REG_0, BPF_REG_10, -8))
+		     BPF_ATOMIC_OP(BPF_DW, BPF_LOAD_ACQ, BPF_REG_2, BPF_REG_10, -8))
 	: __clobber_all);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_store_release.c b/tools/testing/selftests/bpf/progs/verifier_store_release.c
index 7e456e2861b4..72f1eb006074 100644
--- a/tools/testing/selftests/bpf/progs/verifier_store_release.c
+++ b/tools/testing/selftests/bpf/progs/verifier_store_release.c
@@ -10,13 +10,17 @@
 
 SEC("socket")
 __description("store-release, 8-bit")
-__success __success_unpriv __retval(0x12)
+__success __success_unpriv __retval(0)
 __naked void store_release_8(void)
 {
 	asm volatile (
+	"r0 = 0;"
 	"w1 = 0x12;"
 	".8byte %[store_release_insn];" // store_release((u8 *)(r10 - 1), w1);
-	"w0 = *(u8 *)(r10 - 1);"
+	"w2 = *(u8 *)(r10 - 1);"
+	"if r2 == r1 goto 1f;"
+	"r0 = 1;"
+"1:"
 	"exit;"
 	:
 	: __imm_insn(store_release_insn,
@@ -26,13 +30,17 @@ __naked void store_release_8(void)
 
 SEC("socket")
 __description("store-release, 16-bit")
-__success __success_unpriv __retval(0x1234)
+__success __success_unpriv __retval(0)
 __naked void store_release_16(void)
 {
 	asm volatile (
+	"r0 = 0;"
 	"w1 = 0x1234;"
 	".8byte %[store_release_insn];" // store_release((u16 *)(r10 - 2), w1);
-	"w0 = *(u16 *)(r10 - 2);"
+	"w2 = *(u16 *)(r10 - 2);"
+	"if r2 == r1 goto 1f;"
+	"r0 = 1;"
+"1:"
 	"exit;"
 	:
 	: __imm_insn(store_release_insn,
@@ -42,13 +50,17 @@ __naked void store_release_16(void)
 
 SEC("socket")
 __description("store-release, 32-bit")
-__success __success_unpriv __retval(0x12345678)
+__success __success_unpriv __retval(0)
 __naked void store_release_32(void)
 {
 	asm volatile (
+	"r0 = 0;"
 	"w1 = 0x12345678;"
 	".8byte %[store_release_insn];" // store_release((u32 *)(r10 - 4), w1);
-	"w0 = *(u32 *)(r10 - 4);"
+	"w2 = *(u32 *)(r10 - 4);"
+	"if r2 == r1 goto 1f;"
+	"r0 = 1;"
+"1:"
 	"exit;"
 	:
 	: __imm_insn(store_release_insn,
@@ -58,13 +70,17 @@ __naked void store_release_32(void)
 
 SEC("socket")
 __description("store-release, 64-bit")
-__success __success_unpriv __retval(0x1234567890abcdef)
+__success __success_unpriv __retval(0)
 __naked void store_release_64(void)
 {
 	asm volatile (
+	"r0 = 0;"
 	"r1 = 0x1234567890abcdef ll;"
 	".8byte %[store_release_insn];" // store_release((u64 *)(r10 - 8), r1);
-	"r0 = *(u64 *)(r10 - 8);"
+	"r2 = *(u64 *)(r10 - 8);"
+	"if r2 == r1 goto 1f;"
+	"r0 = 1;"
+"1:"
 	"exit;"
 	:
 	: __imm_insn(store_release_insn,
-- 
2.49.0.901.g37484f566f-goog


