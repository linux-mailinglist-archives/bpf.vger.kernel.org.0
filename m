Return-Path: <bpf+bounces-32482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490DA90E130
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 03:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E4B51C21B3F
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 01:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6D579D2;
	Wed, 19 Jun 2024 01:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+0kfBfU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DEE6FB8
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 01:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718759949; cv=none; b=jtgBURLQYC1Rj+kCvhqAgUzz1xMFWt6XTQOCtMihmE/3kn25+ntICsnBbJ/yH0TiXgQd2SnZ0oEIaAyOunOPeDjCFLFPDEdGxMN8JQerA9xAxsGQE8QIb1+XloJkQ0VfxMwRnKvwnWN4u4GigCVFv3gTWXAWv/oQXu9IAs4Nm+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718759949; c=relaxed/simple;
	bh=b06cm/BNX4LeTHSmI513hw72QGfmUM0Jn61LXF74cD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GAvrTICwdxoqI/LRrFBdSuSwNKk9mS3MhtD8Z/NADRihwN3TEAPWFo853EwfX8xedHqlqLNEFI+iBRhXmgIeIpplBONRsrQDBLyANqiwXblRBN+8NcSTVo/thg5k9AZ0A0+cfGV0hb8IIPJxOPU6zLa3TSGfvFbY/OG6ov+gWWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+0kfBfU; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso4859592a12.2
        for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 18:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718759947; x=1719364747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOrMjixFcXovuBhfL6+XKJXigbxc8mG3H5zc4ZTAQBQ=;
        b=d+0kfBfUaJ3ra39rsyDsZtFHAjAXnv+/EqKqe78xbaV6E5o94cZfjHJLeqUXbmwQil
         0ut9I6scuer6VOCiCxq5/XPDbjhnbTrsQehGLrVA3k4z8lWsdAiJhwfWwoHbyT5+c3O6
         r9KzBMLm5mkRWblg72vSUkaULxnS+YqfsGCRk3m3ui4uGwZuppibor7nRYxc6y3CH1Tk
         kcLT/3IJJLCSf/OHttNCabkh7iT7iOnmk7FcIF0zCbzvkSCVeWsYNO/ySlQ7pojCqo1K
         eBQktuvPP/9LuUYa6DB2hWZMZFwqnPqLOg6q2EgACK/GF64vUom5bBpVpiBq9cPFar3b
         AmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718759947; x=1719364747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOrMjixFcXovuBhfL6+XKJXigbxc8mG3H5zc4ZTAQBQ=;
        b=dnmfP71dF9GVc0L1yv9cm9UFSxuzLOAFRs5DF6Rn3KGZOYc7MgJQvyBRal1YvY60ot
         3GWwtlVE78XtmkMZC0D1LzESwx23DBhd/XquoKnaDPyPwf9REY6GkvFCcy/4feUcsTMj
         Lw5udpIKYuaN3ejBhKP5ZIRib02Z/qqsnyT5StBVg48cM5kaRbm+ropv/3g1DM3fudgE
         ys6uPtJ8b5FTIJuHiyrnvgTggl3yUUbRRqf0PVasu/eO7VjmoI/9iO38+1hUkwiQ1TE5
         en0f4mIzkaAfknqWv9kaxZ1XM8H1faLt/TFlpFX84T70iBr9Be1J7Kf0HI84IE4Ec5Ma
         tnRw==
X-Gm-Message-State: AOJu0Yyp5KF412EZr5MJQzrI7waU9NK6DNviTIi7sP83lR5znBQudgET
	iwoHtI5DVn0UaQY4mKtN70Eqv/OfPxUCD3TugeY0urWVPv8QRk0+NYTlKA==
X-Google-Smtp-Source: AGHT+IFYRjxbqz2Vq+zwQ0crGN5ZLryPNagA8h7CgOQ+S+9whQhoaQH3+4De/5VMD9s7zoTMZSVqQw==
X-Received: by 2002:a05:6a20:2da9:b0:1b5:2c97:a88f with SMTP id adf61e73a8af0-1bcbb409a8emr1131608637.20.1718759946740;
        Tue, 18 Jun 2024 18:19:06 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:fc92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb770c3sm9525153b3a.182.2024.06.18.18.19.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Jun 2024 18:19:06 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	zacecob@protonmail.com,
	kernel-team@fb.com
Subject: [PATCH v2 bpf 2/2] selftests/bpf: Tests with may_goto and jumps to the 1st insn
Date: Tue, 18 Jun 2024 18:18:59 -0700
Message-Id: <20240619011859.79334-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240619011859.79334-1-alexei.starovoitov@gmail.com>
References: <20240619011859.79334-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add few tests with may_goto and jumps to the 1st insn.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/progs/verifier_iterating_callbacks.c  | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index bd676d7e615f..8885e5239d6b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -307,6 +307,100 @@ int iter_limit_bug(struct __sk_buff *skb)
 	return 0;
 }
 
+SEC("socket")
+__success __retval(0)
+__naked void ja_and_may_goto(void)
+{
+	asm volatile ("			\
+l0_%=:	.byte 0xe5; /* may_goto */	\
+	.byte 0; /* regs */		\
+	.short 1; /* off 1 */		\
+	.long 0; /* imm */		\
+	goto l0_%=;			\
+	r0 = 0;				\
+	exit;				\
+"	::: __clobber_common);
+}
+
+SEC("socket")
+__success __retval(0)
+__naked void ja_and_may_goto2(void)
+{
+	asm volatile ("			\
+l0_%=:	r0 = 0;				\
+	.byte 0xe5; /* may_goto */	\
+	.byte 0; /* regs */		\
+	.short 1; /* off 1 */		\
+	.long 0; /* imm */		\
+	goto l0_%=;			\
+	r0 = 0;				\
+	exit;				\
+"	::: __clobber_common);
+}
+
+SEC("socket")
+__success __retval(0)
+__naked void jlt_and_may_goto(void)
+{
+	asm volatile ("			\
+l0_%=:	call %[bpf_jiffies64];		\
+	.byte 0xe5; /* may_goto */	\
+	.byte 0; /* regs */		\
+	.short 1; /* off 1 */		\
+	.long 0; /* imm */		\
+	if r0 < 10 goto l0_%=;		\
+	r0 = 0;				\
+	exit;				\
+"	:: __imm(bpf_jiffies64)
+	: __clobber_all);
+}
+
+#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
+	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || \
+	defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) || \
+	defined(__TARGET_ARCH_loongarch)) && \
+	__clang_major__ >= 18
+SEC("socket")
+__success __retval(0)
+__naked void gotol_and_may_goto(void)
+{
+	asm volatile ("			\
+l0_%=:	r0 = 0;				\
+	.byte 0xe5; /* may_goto */	\
+	.byte 0; /* regs */		\
+	.short 1; /* off 1 */		\
+	.long 0; /* imm */		\
+	gotol l0_%=;			\
+	r0 = 0;				\
+	exit;				\
+"	::: __clobber_common);
+}
+#endif
+
+SEC("socket")
+__success __retval(0)
+__naked void ja_and_may_goto_subprog(void)
+{
+	asm volatile ("			\
+	call subprog_with_may_goto;	\
+	exit;				\
+"	::: __clobber_all);
+}
+
+static __naked __noinline __used
+void subprog_with_may_goto(void)
+{
+	asm volatile ("			\
+l0_%=:	.byte 0xe5; /* may_goto */	\
+	.byte 0; /* regs */		\
+	.short 1; /* off 1 */		\
+	.long 0; /* imm */		\
+	goto l0_%=;			\
+	r0 = 0;				\
+	exit;				\
+"	::: __clobber_all);
+}
+
 #define ARR_SZ 1000000
 int zero;
 char arr[ARR_SZ];
-- 
2.43.0


