Return-Path: <bpf+bounces-50304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19540A24EF5
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 17:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28663A52CF
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 16:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7CA1FBC91;
	Sun,  2 Feb 2025 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfBnw9bo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C024F1FAC4C;
	Sun,  2 Feb 2025 16:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738513784; cv=none; b=jQ5dO/LSwVHE11hjzOqOjatsf5YzZr4Pg0jg0HbJ/ZhlO8jicKkYccKzX1QhaV6/oFmCIk1z5BfxT9MCmJsbq9MZJISygPMGvPzAhP63HbfORzzR3bVctr1ds3RoNYgMdRF+Mo2XovP9y5s9grpj58cLmUbgpC7mSKzeXniax/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738513784; c=relaxed/simple;
	bh=DJOjJAib3xPmYMwKMrnuBAhhotohET0H46OhNfIpNP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnDsJbePAMkQjTvDMWg8qPSM6jw3vC/dpsDSpYLwk3A6IoVBxBGkzmldaHxxRkj9S6qued0l8kTswEr2H2l2tv9onhQfXZkveRr5KIAsh+J2bTKEZbQXzWLuacKpWq4OPRqHAOx8btzyEcEgTEdUoTx3Up6PIpopjoLCf1eRghU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfBnw9bo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21631789fcdso59830285ad.1;
        Sun, 02 Feb 2025 08:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738513782; x=1739118582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvsxKxgImbnRW7FslsUua3Q7/SJ6IMXeAO+TCBhIs8w=;
        b=FfBnw9boqvlVqLHXzmU5UBBBQze7VycgThcQ1ViLH9I2iJUDHOYBTdUHibyvY4rvI2
         ubeYRGcsqPaHvkv2i5URTwlqMlcvaTb1eHqbYfxsy+QqUFfkxjLYrDHmE82g3XmEEQ3X
         IwmafC9uitaas0ISfDt+RkP+d/9hU5zqJTgapPeMVPe/5eWePn3lNhgUj+0t9UUeTDSm
         nDLr5eSNq01whocuSGRxiq7PYxZVkZRT0nvfUB/UeHmTMUOBE9tGURcOe0nApIJ3eLsZ
         0/iiDWB1PKDpmgaUCRAZRcwY1K3yNhugsyq7++h6Cq7Yv3eCliYf0eEVP3VwNYGuMiVL
         muRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738513782; x=1739118582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvsxKxgImbnRW7FslsUua3Q7/SJ6IMXeAO+TCBhIs8w=;
        b=R5XZAeUjBVd9gRNybV1ayEHhVcOp86li7rROjyeR+41DOnVG10rmqPhSoVWkjEaLDJ
         UDpiholjIx80cwMQUZqX3aMYLHf2vBzRy4PtotGS59IfH+1bx1z+xeO5iG5JdwfiscP3
         oZLhgRVbz0a+Oqecuy6cYR1TbyoPOiZe/BbwsG9P1SQyuQTrEv5/8VICjo4qHD5HTMs0
         6JSKzzmDg5IkkxAlSNmfcyO3TDeLYALtWXeUPJfA11bDQ8B/N5SSeSIKJu8/LFjNXM/p
         BLitwyV5HweE2Kx1TaUgv38In6LX5Nv+juo/+ebHLj8xw5DAFehBz6FTNon5hZCm4zsb
         px/w==
X-Forwarded-Encrypted: i=1; AJvYcCUIuRQo4EM52eKJC1IsU6U3y/aDLdJ3R4mYAS7FGcbRzYN/vQGlsc5C1igov/l01S7wtrzUg5h/@vger.kernel.org, AJvYcCVQUVcjZWvKIFmtYKjRxbtbqc5KeFisQJ7OHPJyRKoHx62CWFApPfd6wpZtt429CuBPMZWlRGHzqSG7S2dShNFtxyr9@vger.kernel.org, AJvYcCVmN32Y+5xBgE+W1S9+f+LXRF3JSV8OkZOjVSc/Q7lDdJ+UQ6EPpW25A05Uyq+BwVcf2w2PSL+gjGIFXJh+@vger.kernel.org, AJvYcCWUG1r8aic2VH8jIHA4kxkmWA24zerDpldkCFqRPgUlYE3uVoaKsWJJIk9yrk2/aRBrKqg=@vger.kernel.org, AJvYcCWg/nLSf5m/ockcZV+5WqEkWxphM1WChtygz3HTmTghjB1UqVB5YoLnI1jZD+qSCK10UvdzNxOFIoAq@vger.kernel.org
X-Gm-Message-State: AOJu0YwloQSebrTiA/ccgTrygBpvCoO3PVh2TU17LcQtyBtre3PBrGz0
	XRrXlowfrh3UYAg60NjJXDIaKhXvNsN+HzdQ176DypkSe3AXHOc5
X-Gm-Gg: ASbGncsfV68grk+zcDMXkK35hqqSZPQrsqs+4p4Ds2CVTJ1hA2ugaisgPiriaYaApPi
	ezRPNSQxfBidAJa+sbVvQ5neQeSmCGhdt2E1UtNfNNycH9ix+h9I5f/yNXjnKpGqVmn783zG3Aa
	mj4ToISZGkPPgpxxKUT8rcpScH4H4/RgsUDcVcV7pVDBS45+TjA0AFsnzr+mELdKNbDh5CaTw06
	iFSc/oYv08LCZeVChzLk6hkMEqa6M0q6CIRp5EN2XMSKYhUyOFAndgauTWnF1wxsHDnYj+e6Pdy
	sg9wlnFXfLB5NaMBteNRZYyspV+AxeumwyfogjGMAyBKoHEbC5QeQIPaqNc6pSFs5RaKPw==
X-Google-Smtp-Source: AGHT+IHGNZw03kIB2WAsgxnuT9gi2Nyjwi+0kdXn9mXcm+PSFrTHv0a14vh+or34ruvVBDK032fNwQ==
X-Received: by 2002:a05:6a00:140e:b0:726:a820:921d with SMTP id d2e1a72fcca58-72fe2d5c46fmr23334956b3a.10.1738513781881;
        Sun, 02 Feb 2025 08:29:41 -0800 (PST)
Received: from localhost.localdomain (syn-104-035-026-140.res.spectrum.com. [104.35.26.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6a1ccd0sm6834671b3a.178.2025.02.02.08.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 08:29:41 -0800 (PST)
From: Eyal Birger <eyal.birger@gmail.com>
To: kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	oleg@redhat.com,
	mhiramat@kernel.org,
	andrii@kernel.org,
	jolsa@kernel.org
Cc: alexei.starovoitov@gmail.com,
	olsajiri@gmail.com,
	cyphar@cyphar.com,
	songliubraving@fb.com,
	yhs@fb.com,
	john.fastabend@gmail.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	bp@alien8.de,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii.nakryiko@gmail.com,
	rostedt@goodmis.org,
	rafi@rbk.io,
	shmulik.ladkani@gmail.com,
	bpf@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Eyal Birger <eyal.birger@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] seccomp: passthrough uretprobe systemcall without filtering
Date: Sun,  2 Feb 2025 08:29:20 -0800
Message-ID: <20250202162921.335813-2-eyal.birger@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250202162921.335813-1-eyal.birger@gmail.com>
References: <20250202162921.335813-1-eyal.birger@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When attaching uretprobes to processes running inside docker, the attached
process is segfaulted when encountering the retprobe.

The reason is that now that uretprobe is a system call the default seccomp
filters in docker block it as they only allow a specific set of known
syscalls. This is true for other userspace applications which use seccomp
to control their syscall surface.

Since uretprobe is a "kernel implementation detail" system call which is
not used by userspace application code directly, it is impractical and
there's very little point in forcing all userspace applications to
explicitly allow it in order to avoid crashing tracked processes.

Pass this systemcall through seccomp without depending on configuration.

Note: uretprobe isn't supported in i386 and __NR_ia32_rt_tgsigqueueinfo
uses the same number as __NR_uretprobe so the syscall isn't forced in the
compat bitmap.

Fixes: ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return probe")
Reported-by: Rafael Buchbinder <rafi@rbk.io>
Link: https://lore.kernel.org/lkml/CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com/
Link: https://lore.kernel.org/lkml/20250121182939.33d05470@gandalf.local.home/T/#me2676c378eff2d6a33f3054fed4a5f3afa64e65b
Link: https://lore.kernel.org/lkml/20250128145806.1849977-1-eyal.birger@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
---
v3: no change - deferring 32bit compat handling as there aren't plans to
    support this syscall in compat mode.
v2: use action_cache bitmap and mode1 array to check the syscall
---
 kernel/seccomp.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index f59381c4a2ff..09b6f8e6db51 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -734,13 +734,13 @@ seccomp_prepare_user_filter(const char __user *user_filter)
 
 #ifdef SECCOMP_ARCH_NATIVE
 /**
- * seccomp_is_const_allow - check if filter is constant allow with given data
+ * seccomp_is_filter_const_allow - check if filter is constant allow with given data
  * @fprog: The BPF programs
  * @sd: The seccomp data to check against, only syscall number and arch
  *      number are considered constant.
  */
-static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
-				   struct seccomp_data *sd)
+static bool seccomp_is_filter_const_allow(struct sock_fprog_kern *fprog,
+					  struct seccomp_data *sd)
 {
 	unsigned int reg_value = 0;
 	unsigned int pc;
@@ -812,6 +812,21 @@ static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
 	return false;
 }
 
+static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
+				   struct seccomp_data *sd)
+{
+#ifdef __NR_uretprobe
+	if (sd->nr == __NR_uretprobe
+#ifdef SECCOMP_ARCH_COMPAT
+	    && sd->arch != SECCOMP_ARCH_COMPAT
+#endif
+	   )
+		return true;
+#endif
+
+	return seccomp_is_filter_const_allow(fprog, sd);
+}
+
 static void seccomp_cache_prepare_bitmap(struct seccomp_filter *sfilter,
 					 void *bitmap, const void *bitmap_prev,
 					 size_t bitmap_size, int arch)
@@ -1023,6 +1038,9 @@ static inline void seccomp_log(unsigned long syscall, long signr, u32 action,
  */
 static const int mode1_syscalls[] = {
 	__NR_seccomp_read, __NR_seccomp_write, __NR_seccomp_exit, __NR_seccomp_sigreturn,
+#ifdef __NR_uretprobe
+	__NR_uretprobe,
+#endif
 	-1, /* negative terminated */
 };
 
-- 
2.43.0


