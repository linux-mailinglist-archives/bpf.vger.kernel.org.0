Return-Path: <bpf+bounces-50648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C0DA2A67B
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 290987A069E
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 10:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A174230277;
	Thu,  6 Feb 2025 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBWdiLUu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0CB22FDFB;
	Thu,  6 Feb 2025 10:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839301; cv=none; b=JfiLWHgtX07wp581g0xKzhBbHdQYRZJA6A4okXYgkl+bY9ojrbMvapei2EOy1UKYm8WeC8pfEQPkh98xTGsg/Kgo01MzmczDu64nOSK2XmQIqkkBbVwsFJPbOhlSyQ+XGjB+n58fcAn2tCnyNqa3plqtms6OKXIZUdfYEv42pPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839301; c=relaxed/simple;
	bh=KNh5avXGN/NKqBUPvLsxJm4kx32ENpJMvZqaG5TMnX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vCFpnxRcEQ1g77VuAjMP4PdX5G+M0iHMnCgRQLPGvAoRoUB5NQyurupjBgmaSyq3C35Rhe2gs/D7/oMBfBV75BFw9fqvVZ+D/jqDzDXcfdqCgv1/d+b0GyvrwhlzHlzIc9loUxSPNZfAQ+qKI5rx4Z39YOKrfOzDCtD9240LNMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBWdiLUu; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso681232f8f.2;
        Thu, 06 Feb 2025 02:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738839297; x=1739444097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psIYVnoDnyqEhuF08gdBP5C/H1dDdxXA5if0bgYSupA=;
        b=fBWdiLUu7uh+kGgkufOXi21dQxwPUbb9iSZe6A5LSxxdv4jwL/o1us/UQztxsGba4A
         DyQfNkKwQQjVObIR7i6Nc95b94LPCYPTK8AO+WdQY9wG85Xv5jbm3lbzPR4oKUiTNS46
         goZgfusrczIcDvIYmBY6JaH4FlBIKQdw8GvPv2pUSZJ61vN60u+djNy8knmz/gMEQsWX
         ENKEPtP0frn2dIKtGsSdG2VfjKgPl5p/vqH6L3PlfFxckEnBmcIzvbdBfO4/4UoXOW0k
         CTl6x+0d0pKkndvPb4pVnkZrBxhoEdI0Nshq8Tj/Hvuck5fh24IUfYW9PYTMivWX8d7m
         2krA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839297; x=1739444097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psIYVnoDnyqEhuF08gdBP5C/H1dDdxXA5if0bgYSupA=;
        b=ksR1c4szVqWwDHohFWkWlsizHTvkblAt4x/s+KLheaWjht6gNb1MKD8Wgo+HWdOjAb
         CfK3wtcxkG74Eo4hQG9/XdtTo1a1828dC5rWyt1ubqWRLV/sjV/ybeyfb4r0mduL85Uu
         N0Y37gtbAkONTkpPP59+5pxb/9qpljvUxEwXaGywPJGQ1FRpIiDxzu5Ay7XnA+phrsD5
         F5gJMpiu1ffYMqGewUEYHKNRpyypmN+RSj6S74KA9mjki8WOlzVFCJvUwQnV+vjEJFSB
         y06uOrD9TewwBbwUb4sDT2ABaHVaPSqjvasf0t9QvJMieuMejKieYrkja9lFJ5r+7SfT
         TyGw==
X-Forwarded-Encrypted: i=1; AJvYcCWDWKwRMk7CsRYCP2tV0L+d2/ZAYFvvvDCB21sINubCUs+gjnOENsImuWoBseCL2uvhNa7uCoiF5H8kSUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR9hBHqeWCHmVWJcIN5tVHylgYpVE7OAxWCUvF6eY0KQ8STQ/x
	isuo0TI7A9XdmDv03Xv46/5o4YYvpReE81fsoiAjcEWS7cQpDm72uFjzk8DtwGw=
X-Gm-Gg: ASbGnctR5QL4eTz88RbtkzPbhlVis3pCOvnAiD2MFVLqDbBEBfXY0xHIqaqkY9uGJ4w
	ypAvZB2prJVJ4hMBQe3qdd09NP1YDP3WMs7sORX7beSxd0qyQ9OU/6DO1GfCLchFlhBfmPooE3K
	40K7O9T3IA4FvAuYCoiAgI62Dq8PD0FvG5hNvsmg6JV+TenIBon1uZBwKnukmI02yVIvKPl/ewK
	GFCnqBqfXErGYeEcZ+oWrZWb11OimEhOeFi4Wjacgj3p9Wy7d7t32aD5bXrfPIcbbYEkkf/lMBB
	3mAW0A==
X-Google-Smtp-Source: AGHT+IHkl/GEUHcQkAbl0ON/0qgQ/ymyQ9ZF0yYfkBQadmGYwFrDVox65cPqH2Wp5hAeoi4jk/bRwg==
X-Received: by 2002:a5d:584f:0:b0:38d:b907:373a with SMTP id ffacd0b85a97d-38db9073983mr3633804f8f.18.1738839296552;
        Thu, 06 Feb 2025 02:54:56 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:14::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dfc8a4asm15277955e9.32.2025.02.06.02.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 02:54:56 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 14/26] rqspinlock: Add helper to print a splat on timeout or deadlock
Date: Thu,  6 Feb 2025 02:54:22 -0800
Message-ID: <20250206105435.2159977-15-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206105435.2159977-1-memxor@gmail.com>
References: <20250206105435.2159977-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2125; h=from:subject; bh=KNh5avXGN/NKqBUPvLsxJm4kx32ENpJMvZqaG5TMnX8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnpJRmRlXvwB1hx8++BclgtcXSkYsvJvj0epYaDAgR caKTzLKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ6SUZgAKCRBM4MiGSL8Ryj/lEA CdyUwdOkuj69uW28N+HkwHcaKyNpxRWOwDuMUKnremt3PTIi1hrZRLDZ5EgKKnQdyKZY6t2nVrL373 lmuwFahN438dpl8Bk5tQbOhm6+4w+dE7fWr/DTpAuKuKYVZtr1/yiqqRdODy8wjoomvIzmS/in2A7C GF9o2x9dBdDcZ/k+DSqPjPQoebLQSloS3NlGu/AxxXu/YnaY7wvkbdiNj1GGZSKLX0Mf2zlShJbi46 v7mgNoevomx5zGXDhazsdU2klCu0ipaQUiKQlAbHB4LDaCfTJiw/FKqtjY4bmTlnVienNuoZwdcWqE BqCt7T9md4IJP+jH9aw6PAXZYlPYe/DGYUuOtCberxn54FV6sgZnEH03zTBFmJXKMxHisr9eXNr1zy /ciQUgfbnR0+tgIbFm8LWRpA1Wy+nerC5gB6EHuAIp0GJW/NIs85l39vDGshVBpbkh3T/NgrQOVYRc A+kNcL2FSKEXxRtiVw9nzH+exDCaJdx9Fb30gd31OENMeXf/QgUBlRKVdcyt9rD/H5L/01hPbSpwTq AxHFQVwdMLBxGzxGfpTUCDZHXq1BCR+fw5VT6cC3LSVeBC6Y7lEDJ0PPAdEPbxJe7DzjHFblZdRlsq EJfnrO5HAk3JyRiiqL+AbJN/On7peWMsf6ZNiz+g4rLFY2+PreoqERHpbkvw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Whenever a timeout and a deadlock occurs, we would want to print a
message to the dmesg console, including the CPU where the event
occurred, the list of locks in the held locks table, and the stack trace
of the caller, which allows determining where exactly in the slow path
the waiter timed out or detected a deadlock.

Splats are limited to atmost one per-CPU during machine uptime, and a
lock is acquired to ensure that no interleaving occurs when a concurrent
set of CPUs conflict and enter a deadlock situation and start printing
data.

Later patches will use this to inspect return value of rqspinlock API
and then report a violation if necessary.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/locking/rqspinlock.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
index 13d1759c9353..93f928bc4e9c 100644
--- a/kernel/locking/rqspinlock.c
+++ b/kernel/locking/rqspinlock.c
@@ -196,6 +196,35 @@ static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask,
 	return 0;
 }
 
+static DEFINE_PER_CPU(int, report_nest_cnt);
+static DEFINE_PER_CPU(bool, report_flag);
+static arch_spinlock_t report_lock;
+
+static void rqspinlock_report_violation(const char *s, void *lock)
+{
+	struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
+
+	if (this_cpu_inc_return(report_nest_cnt) != 1) {
+		this_cpu_dec(report_nest_cnt);
+		return;
+	}
+	if (this_cpu_read(report_flag))
+		goto end;
+	this_cpu_write(report_flag, true);
+	arch_spin_lock(&report_lock);
+
+	pr_err("CPU %d: %s", smp_processor_id(), s);
+	pr_info("Held locks: %d\n", rqh->cnt + 1);
+	pr_info("Held lock[%2d] = 0x%px\n", 0, lock);
+	for (int i = 0; i < min(RES_NR_HELD, rqh->cnt); i++)
+		pr_info("Held lock[%2d] = 0x%px\n", i + 1, rqh->locks[i]);
+	dump_stack();
+
+	arch_spin_unlock(&report_lock);
+end:
+	this_cpu_dec(report_nest_cnt);
+}
+
 static noinline int check_deadlock(rqspinlock_t *lock, u32 mask,
 				   struct rqspinlock_timeout *ts)
 {
-- 
2.43.5


