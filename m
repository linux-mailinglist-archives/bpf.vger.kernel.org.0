Return-Path: <bpf+bounces-48111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC565A0417B
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 596EF165CC7
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F361F4704;
	Tue,  7 Jan 2025 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhTnDbhW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08811F192E;
	Tue,  7 Jan 2025 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258439; cv=none; b=ImwuDoZm5uUFfhhDIl0IwGmUU/5Va6j6mFPPL/A5q72s2VibLpmOYN6tVSqd2+lQ4AM8ZfkRKv4p3LWyu6//TgxelB5s1UL+k+O1sbsq/ZxfvAo4pjRWsQxx82wLKr94qT11WK6LVL8Y33BXsVrZf43VBMCU2wOmavnppgNNNR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258439; c=relaxed/simple;
	bh=+fj1yjje4sqeNTogpj3CK8ewZfnMI1iC7ebB8+PSGhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcmZPjdFcuIKyHCz6Igt9LennYj9eWkNTqEB2Yh1aaukiBxdvZT9lSUDvrSFwExa+2xBZLqyK2UO2+4jh/BPSOBKMeez3lxaPcpYeP9WDzKqBhCF9Qs8QiW+yalbRlApKGlZElszoKzwj+GyPLEW8reKw1AvLGChydrLGjYXANQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhTnDbhW; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso8269081f8f.3;
        Tue, 07 Jan 2025 06:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258432; x=1736863232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHfuQaN0Xplb/Xfp3iI4rOkeKsbB/lrTnm5fmzijsTk=;
        b=LhTnDbhWi1+pREVuZ3He9OtlX7w+kMQbtmaJ5PSP/QcmvdqZya0n/axJh1OIu7zKOt
         8buQmWkSN+EsyPJHSF8UUCY/T9w6Y5CrJY2L1uAD6MAiH2uDd2dyluDZSHkhREh+JNHF
         EjFiMDG00nYbxe6H5d1Z51xq8cELZlgwMlDAJOAGH/I/6oZ/YnR1bnLfSNosFXOdwQ2m
         4UrMdHlDiqZEQVMuDI55K0T4BlXplnQQ5VTF0KUSqVWM71rNNgtvKlpjRGol5FM8WmXI
         q0QXKxKpxgmoF6JFHNP/f4dDVS4ZW1INCcLnuOgBB82eOLdAU03vOtus+HO59KQpLTAE
         Uq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258432; x=1736863232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHfuQaN0Xplb/Xfp3iI4rOkeKsbB/lrTnm5fmzijsTk=;
        b=R0x1LcWVdk/65cqaYkFy9T9vZJ9E9408D9vJzPhXJBy5SVdrsY0x2uhlhlK7I0B/TV
         0fgitMMoMbhrUP+IOC2a1cNSz8hnav3jou7hKUvtTuE7XTh65JZf4MjOPZuTI0toRCHx
         JTZSH12geGF1c/dtcW5tQ68fx7/qw5X22Kp75oDKyCzPMAwOpVXEQ0RpvJblEgeX9VSr
         xoUk6e/Db3OkVp7roy9LI6w/jZvF9A/5IcFXRqsLzC9U+1TqaLCggzTZ1xkMKoDNj0Da
         413inuYMur9MfD/xoVchAFTgdIXgFMbjIQy8dHTMkW6ulp2bq1ZG1b7OVkBLP390ywbk
         7olQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpqm2qi0hG/5fd5JQt/o6dcSv+Z62iJ7uQJK7/ZHMFL1mgslhypSicUWgnjRD61U4rpMLHb4Ht6gEJO+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXH1YEzUMxYJHmE2XoQOMo29je88yvlrax2P8aZoLmkER5+ZtS
	meYsjabBbkQ2qBsYRcDNS+F155UZgqnZk3V331Vo0/p0Ey7Ag2TCOKVfQlZH69gPkA==
X-Gm-Gg: ASbGncv6lqwH2PoTEuNKClQ93/w/1NLOfp512an04yPsTqA3l3obcwjzM6v3uJuZV6g
	L5KB5lLd0fpKus41bjofRrKZIL/N812IMdwVd3ZweT+EgNVUKCKPxMD8d1HQyRKKzTPBPZFSY0w
	kmvYzNtrUICM3cXGk1FkTHxBD5QZMmfWNlQRiDTdOmMwjKNY/OAiQl58hb7EgamARYwi1vQMB6M
	kxhhrFuM9C/v2X6hwqoA1MO84jtQgFAsCcsLnUzBgt6N1E=
X-Google-Smtp-Source: AGHT+IFfdWUpv1TICRNd5gNjkfPAEVNtSWbX5T6TgxP/mRwQrqvZCVkhXUZ/INA9P9DEsp7+2W9Z/w==
X-Received: by 2002:adf:a350:0:b0:38a:82a3:395f with SMTP id ffacd0b85a97d-38a82a33b6bmr1521736f8f.9.1736258430286;
        Tue, 07 Jan 2025 06:00:30 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:1b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436840b35b5sm451688345e9.39.2025.01.07.06.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 06:00:29 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 13/22] rqspinlock: Add helper to print a splat on timeout or deadlock
Date: Tue,  7 Jan 2025 05:59:55 -0800
Message-ID: <20250107140004.2732830-14-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250107140004.2732830-1-memxor@gmail.com>
References: <20250107140004.2732830-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2133; h=from:subject; bh=+fj1yjje4sqeNTogpj3CK8ewZfnMI1iC7ebB8+PSGhM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnfTCd4d8tqFkNZ0bN8cnwm6Ynf6DhaNC/1azMoVg+ 1yeQzjGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ30wnQAKCRBM4MiGSL8Ryir8EA Cl0iezObINQRZH9QV5ns+3va7BzB7h1ZBd/UqkSe39Ia9jpf1FhtNawTtLydU7TRKkFgAOASvNJoX1 dqXJVBaga8FSazHXoxzm2tPn1hX9osVBFWUa1YYn8FUn8fW4d3OI5Sz4m5GsxGAw7z1CqTXHnSXTV+ KfpuQiOeFEKWmwfdnb41bNJX56CuzjMVO3FuCE0f/gMcep3r+ejV3Wg5Ktyo626sRwNwbSyY4ivya0 R22uw741U3ZDLtluXUEUraOajkTYT1c3eghZKhH+Vvj2jPx3ILrAXVMoBv2GE9SiX2o1CfZYsnZAqj +ZJ2WnovyGq17jNP/+QmfJs27MjDN3zG5C4FbgmvSK1cJ1M38DdGxht5RhDim/jvs4rt/M4MfdDjDf LOqbwApc5A6GzOt/h61EjMXBnLPLxLBs08m9ZoF3GL8boY7c/rtafSAOAQm/apB600f8OQhI2sbQWX 4+lBD492cC94lUev6uXu04UOIs4P1t3XeW6I1omWzi2mKg5H5Tb/XO86ugzy0XDvHgSxnUukXe/T2e urLCwP71eS1UeOXJ9BWL5lLRa3gJL0QmdgzecbCG4dqdIj8VsrdMs6uWlLaFw+16gKlM41Kqi6tGBu JEvvfpSPdzh8B/E2N3bvcn4/5TZt2Fa0KrRd95QiBC4sI5LLrxsPpgqUdchg==
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
index e397f91ebcf6..467336f6828e 100644
--- a/kernel/locking/rqspinlock.c
+++ b/kernel/locking/rqspinlock.c
@@ -187,6 +187,35 @@ static noinline int check_deadlock_ABBA(struct qspinlock *lock, u32 mask,
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
 static noinline int check_deadlock(struct qspinlock *lock, u32 mask,
 				   struct rqspinlock_timeout *ts)
 {
-- 
2.43.5


