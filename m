Return-Path: <bpf+bounces-53085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FDBA4C546
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 16:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 511D67A9699
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 15:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06522230BF9;
	Mon,  3 Mar 2025 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmHHiovI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED5A22E402;
	Mon,  3 Mar 2025 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015414; cv=none; b=hMbKWq04gZI43a/xoB6N/jt5+q7HnPPMimyEANKu8+ueZSmz0G96TkNygq8VgcK19uC+OaiUZN7VD0yqc89Ip9NzcDld1oSDjVz06eONIin392iP4kFBCzXTHqhYVnekD2FtMj0ggNohKZM1X5C2LoBwfXzJlU0zastE5AyERLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015414; c=relaxed/simple;
	bh=XzehY2DPwsFHlB5VuQsc3kNRx10DtgHBazvwnaqKM4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZtMh2OLNoAjAE3zIEnDpcSqBAzEXqWBSlUtlhu+AIJL8Jo3PL//f5GgNFM/ZUqFxZUYxHbJ7xlU9RLrLfPeRQMCQ4kyXa0Z3CI800RkUrU/ZbjeDSojj/UR73C+1s+Og+0yvwkm/hG3QfdAL/bHtO7ydA0hciGLQPuy3UhN0qwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmHHiovI; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43995b907cfso29199445e9.3;
        Mon, 03 Mar 2025 07:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741015409; x=1741620209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oib9X6F+jD32qthRhftfxOrIXcfGV0ymse+3a+fep28=;
        b=OmHHiovIYiqBqXja5o/ADuRyU/yF2u8LZyen7tD6rnTSZSpd0zeU3u0j8gOi0c8B4r
         rXfMjn6JNaMnMqm1WS89uFz+Fw5MNS2omOxIBUdbxmHkwRNbQfeYmCGvflsgybe4B33p
         133FUlXGCCI6bzHWz7znMNdFFEH4TdMc94VOdSwmJwpKssQJEfqJAhTC3omSyES10Ws5
         P36yD3/5ALeMX4aPR0no1mOcHPy94pHLRziDdewgdjR2eKtE7wi50lgw01ko9J8SSU5D
         B58U1zd/6EXJs0TgtbzhM95Gf1SQ16co2xlnPKpFvuvc5VWkWtNrCci4PhICRs/25Iao
         NngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015409; x=1741620209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oib9X6F+jD32qthRhftfxOrIXcfGV0ymse+3a+fep28=;
        b=VToX3WE3WC631tBwXCx88A6wfTLjx0Ia7Fx/K04vS5INXI4xZ84B567Zas7USsbUS1
         vMIsDwt+qof7cI8ofvA4hrBCatfQ50qSksabxowVMke5Y7e8CyPLQvs8Q9WG3VQoghSp
         373CbFxLoZRorly2bjlcY6c1j2+W0DIHPmNSws5q58wvPW4tdseue04Hf+3MO71C5nNP
         NGT2dcw3O8YRo8wfUO25TXeZJ1fkFnZVY2+begZptCM9vft8NxfqltDE4DUP1HWD5SFE
         KaVGOaEk81gaw3GUYRlUmqgsv24bO3PbIDCBOD1N0HpuOiJ5LUg7vu03p22JLs6lXeld
         TJ2A==
X-Forwarded-Encrypted: i=1; AJvYcCWEw2AC+RhQCzWoxv/Z6EA3vahXuNIXQKteZFCVW/AmL3jCmJ2aOuC8I1kca0vk94skpVKBipBmWsRvKts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWRVHw9i+rONpLzwp/xDqjca0WvLf5y59M9za9xSmshSRfSduc
	IX9JCUhvLb8w8ub45zuode+MYo4UYwQUTAyK8FXfPvV2ScL/vFUQOkptUpIQSJE=
X-Gm-Gg: ASbGncs+UYqzICcPGwkXz8CCJURjxtHhZgcvb0+R8qkjCUv69jJxmjEMZ40HwQVByx4
	WkvPBZVUJcvfq2B9g+uzS3GxXNqjR4ngK5sk0X5HKaEdztabQsBD0Fk/fmuUb5NaZxaIIO3lgij
	X/gWbjF7/YGHgB7jCh3iq8zSiqibermIbLlhhDlAlOekkCq20Ar7YUgLfL2lmV5AApj/vXpB3Z5
	bktSLxHunlgNasv+qvMIzNhkeOiyvXTSOoCGNVXQedG6DwTUigbmSjMOOhUtxCGkplJuVxhpysV
	tTEGM4H9++JSO+Y7cpugCGpVgakes6vs2yI=
X-Google-Smtp-Source: AGHT+IHK0E0NT4rN+IBrKPzoxmISlpoRx++6wRPzHRPKMbke27YkpGiSQnpSIDIa7J8yfk3LY6QLQA==
X-Received: by 2002:a05:600c:4e8b:b0:439:a1c7:7b29 with SMTP id 5b1f17b1804b1-43ba6703c35mr123515565e9.17.1741015409574;
        Mon, 03 Mar 2025 07:23:29 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:44::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485db82sm14510061f8f.88.2025.03.03.07.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:23:29 -0800 (PST)
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
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 15/25] rqspinlock: Add helper to print a splat on timeout or deadlock
Date: Mon,  3 Mar 2025 07:22:55 -0800
Message-ID: <20250303152305.3195648-16-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250303152305.3195648-1-memxor@gmail.com>
References: <20250303152305.3195648-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2125; h=from:subject; bh=XzehY2DPwsFHlB5VuQsc3kNRx10DtgHBazvwnaqKM4M=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxcWXYD8EVbB4Iydj+LTkfn6cdW8csGFE6TObIbKx E0nmgrCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8XFlwAKCRBM4MiGSL8RyrkJEA Ct9v2S2uZ5k2kQeAFIPGD+gS68B4nVheOj37Umc8z+EwrGBzZ82mY8MkklYthiJE2AQBdHrtWAwoqG tZbTvmL6+lzWfEYRZt2xi60n3hTJMO3dlntsG+nTWnBWpIQZX5PNvzwPOl1/8OQMO+69prEjQItSyu eMEd38+aF8KI6iN85h1WM0KeOubpLLpUWfdNufr7Gsq0Oi1qImSnF/ilMPpOkoWQnvjxBU2ZKp75De P5Whx7I1WBvsuPW2lX4rzXBrMWbAWPQpojlxod4Ls4y3A61yRekC7LremgMkSs6gvc7Tnw/Z9lQWCU CgtczCyFYGLMz+mNBIEEbLqTQdgdrvV3fFCY78DcBB7xUvGlqD6CIZGr6DZljaV2SoWRHRCmv5Ft8H gVx7H5tqZgvWVo2SoMK4dnjxpn4/df+FCKxss6T2T6c60eFLmTgvI0DME2DNvOKFHgBhQpy6p3Cxsl H4g6MJFPnCJsqycg5cOVJKjPPgeoTGZlXrmAyPL60whVruu8QiWcCAFv4taoKU7M5yTeAGfAYdFU8l 6Ws3FsgbVuQ7DFWtfrLU7462oedcdeEAj81i6KLZmyfucZ073rF8/ghmFeBJtrIiheHs7mCqctGJjH +MDX6Nid6DYpDuM6VXjrvhhN8QfGnRpqsnGqUV9O6Cf6rbVzKauRdtvFhKgA==
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
index b06256bb16f4..3b4fdb183588 100644
--- a/kernel/locking/rqspinlock.c
+++ b/kernel/locking/rqspinlock.c
@@ -195,6 +195,35 @@ static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask,
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


