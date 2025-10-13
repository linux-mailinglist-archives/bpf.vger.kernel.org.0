Return-Path: <bpf+bounces-70828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86269BD5732
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 19:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A2734F6114
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 17:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BE42C11D6;
	Mon, 13 Oct 2025 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeN7qF+l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20A52BE7DC
	for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375477; cv=none; b=lUibTEEEX3Iv5uOK/KDzzYdu9s3wYQgHDMfxyhV4o+jK1QYCIBjhW4rKpFScv04LthU08ic205xDgMqgNIhwed4fK6UK6+HxnY8lFTohzs1lEhBIPkRZl1gtnaxi/x2qlCHQoxhCtxNtzFwP0whzLXikc0m+AYorIijW+k6fBpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375477; c=relaxed/simple;
	bh=S2gIQP94lgffpY4CdKMCyczm6+A1tXicz6mTVuc1Joc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QduuyBgf1QgazAJiwfHVWq/ziDdj2a7EUd9hTzQEqbuHUJtOM7IpWI4+p+O5wircM0FYScTV3tX8yGGgeYcQFDz8FsxiRM59o7GJX7W7I5vXs+HJ9MhRmICqPa1tkjkd7XjU/gXhDJ5yAIdjruNl1/wiuDzjUUS2PMDhgiLPSGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeN7qF+l; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-781010ff051so3135915b3a.0
        for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 10:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760375474; x=1760980274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vNU/E/UrNDC/G0pLcdg/DKYe53UeEuOcIs6nSU8+lgY=;
        b=VeN7qF+lWkeOtd1YiRy10WCaODuPsakI6f5p+sTuUP9YQJoWT7Xtx8DmVq9GRvzNK5
         Tsi/WJLMBe8GuBob8bJXFtVGNAEiTmWUGq07Xs0ZlYGBgd6Ftjg2ktWzl2v/3czUFozS
         CCeEigUL4BHaeFCUZYKSW9ksIdUEEfxFs56Q8G5qLelE0eg0Ew0V+jh5sxj7tVadKyIB
         VKz0HSh2TvRtOP1WbCtNx1E+PFC7AZorlmC8idbXEQS0MTs48XBB4fr04Mu1U5TFbl15
         D3moql5bcwtkfvR/spj572cylgzWylB73P7ECjyrZ/9NItM1miAV9CidINU0MgkLeWOh
         22LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760375474; x=1760980274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vNU/E/UrNDC/G0pLcdg/DKYe53UeEuOcIs6nSU8+lgY=;
        b=NOBwYR53rzJaLdfL8PwNTzrlS4/TUEHEhjOZE+dUCYSLw6YLj//7ibnQH29zitpGjX
         +rQvv/h6J3xs5bxhSzH9xEDVethQPfl1qAyjoWc7p0mXc8potXC+rwzqoNHACYsTs54k
         /kn6y9/prPSYZTDpyYrGAIhVx4tHBVsaNPcq+yf6WGYFvcS5XEGlLLp6JrOT7Pf6PGuN
         t8e+kvOhVX8otsS/I6++XBRo+uhP2zBcnm0FtOu0GLviAA79dtsep9lLfxzWLBcQyXMo
         dHtoNHTfEOqFqDo5DyQ+9atu8euqCw/OjZypSQ6HQyfAdFRw/UkfOFSm+BxlwUFiBvwG
         n8XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTN6p8DriROP5g4SK9kLQ7Aib03hxK3Zrfie01XSqIU1PFgL2LifOLMA5x2C/ng8j+EQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3AZ3DUQU0bzjfZYlgTSzWP8BqAoHbLvrRWRiQRmQTGF81pD07
	IKv68zJCtizCVCanT1kGx1axbdMPzh+q+2zbe9bSxNHfg17dsC7Dn9Dr
X-Gm-Gg: ASbGncsY8CTTWZp6UnJz20HpP/9bOoBxBiXYANOXkpLDOEc8Lik6NXoO7pjkDNx8nqz
	tzAxa2J4/e21Y7rzrXq6n620ORkS6P5dRfnS2j0S9e6hf3c3oAANyGCUhBlQpPRR607KSMXb+at
	6o8How3CmLGfru4yPMoTaOeVQI96LKlcy0ylYhTOudse9J6iGPeTaY8S4/CB4QSkutUtW5lkDQX
	/6+z4X34QOIEcXV7CGwanXGvO1qHPpw1Mv0Nl7wL+pfuAjgJZL0Gvkr22d/uJxYh7wt1xqxz3Ty
	LYQOMuBIh647UC0WuiwCYO+vdk2LsMv6YdeQ6ZjOZL1EhmERr0MkwS4bVoaB/I96WVCZlzIiWth
	gj+Y5EKezSEKAB9r/iLTa7ThDd7SG7CVXaHFT4lyUxWsb1YFOK0PcwXR7W3cgJIIf3kPP/xee1h
	GaTSj5nlYC8CS+LABYFsgBFJaCyBBm5eZF
X-Google-Smtp-Source: AGHT+IFrdLCo/eZa8p+hiG7JwHLn3+CSG/njknEnKNZNV9VR+YEiYQEHF/YrPnjgWDnY3Yrqr5yvUA==
X-Received: by 2002:a05:6a00:8d5:b0:792:4e77:6ffa with SMTP id d2e1a72fcca58-79387834ed2mr20630907b3a.23.1760375474048;
        Mon, 13 Oct 2025 10:11:14 -0700 (PDT)
Received: from chandna.localdomain ([182.77.76.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e275csm12144012b3a.61.2025.10.13.10.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 10:11:13 -0700 (PDT)
From: Sahil Chandna <chandna.linuxkernel@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	john.fastabend@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	khalid@kernel.org,
	chandna.linuxkernel@gmail.com,
	syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Subject: [PATCH v3] bpf: test_run: fix atomic context in timer path causing sleep-in-atomic BUG
Date: Mon, 13 Oct 2025 22:41:04 +0530
Message-ID: <20251013171104.493153-1-chandna.linuxkernel@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The timer mode is initialized to NO_PREEMPT mode by default,
this disable preemption and force execution in atomic context
causing issue on PREEMPT_RT configurations when invoking
spin_lock_bh(), leading to the following warning:

BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6107, name: syz.0.17
preempt_count: 1, expected: 0
RCU nest depth: 1, expected: 1
Preemption disabled at:
[<ffffffff891fce58>] bpf_test_timer_enter+0xf8/0x140 net/bpf/test_run.c:42

Fix this, by removing NO_PREEMPT/NO_MIGRATE mode check.
Also, the test timer context no longer needs explicit calls to
migrate_disable()/migrate_enable() with rcu_read_lock()/rcu_read_unlock().
Use helpers rcu_read_lock_dont_migrate() and rcu_read_unlock_migrate()
instead.

Reported-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8
Tested-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Signed-off-by: Sahil Chandna <chandna.linuxkernel@gmail.com>

---
Changes since v2:
- Fix uninitialized struct bpf_test_timer

Changes since v1:
- Dropped `enum { NO_PREEMPT, NO_MIGRATE } mode` from `struct bpf_test_timer`.
- Removed all conditional preempt/migrate disable logic.
- Unified timer handling to use `migrate_disable()` / `migrate_enable()` universally.

Link to v2: https://lore.kernel.org/all/20251010075923.408195-1-chandna.linuxkernel@gmail.com/
Link to v1: https://lore.kernel.org/all/20251006054320.159321-1-chandna.linuxkernel@gmail.com/

Testing:
- Reproduced syzbot bug locally using the provided reproducer.
- Observed `BUG: sleeping function called from invalid context` on v1.
- Confirmed bug disappears after applying this patch.
- Validated normal functionality of `bpf_prog_test_run_*` helpers with C
  reproducer.
---
 net/bpf/test_run.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index dfb03ee0bb62..f1719ea7a037 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -29,7 +29,6 @@
 #include <trace/events/bpf_test_run.h>
 
 struct bpf_test_timer {
-	enum { NO_PREEMPT, NO_MIGRATE } mode;
 	u32 i;
 	u64 time_start, time_spent;
 };
@@ -37,12 +36,7 @@ struct bpf_test_timer {
 static void bpf_test_timer_enter(struct bpf_test_timer *t)
 	__acquires(rcu)
 {
-	rcu_read_lock();
-	if (t->mode == NO_PREEMPT)
-		preempt_disable();
-	else
-		migrate_disable();
-
+	rcu_read_lock_dont_migrate();
 	t->time_start = ktime_get_ns();
 }
 
@@ -50,12 +44,7 @@ static void bpf_test_timer_leave(struct bpf_test_timer *t)
 	__releases(rcu)
 {
 	t->time_start = 0;
-
-	if (t->mode == NO_PREEMPT)
-		preempt_enable();
-	else
-		migrate_enable();
-	rcu_read_unlock();
+	rcu_read_unlock_migrate();
 }
 
 static bool bpf_test_timer_continue(struct bpf_test_timer *t, int iterations,
@@ -374,7 +363,7 @@ static int bpf_test_run_xdp_live(struct bpf_prog *prog, struct xdp_buff *ctx,
 
 {
 	struct xdp_test_data xdp = { .batch_size = batch_size };
-	struct bpf_test_timer t = { .mode = NO_MIGRATE };
+	struct bpf_test_timer t = {};
 	int ret;
 
 	if (!repeat)
@@ -404,7 +393,7 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 	struct bpf_prog_array_item item = {.prog = prog};
 	struct bpf_run_ctx *old_ctx;
 	struct bpf_cg_run_ctx run_ctx;
-	struct bpf_test_timer t = { NO_MIGRATE };
+	struct bpf_test_timer t = {};
 	enum bpf_cgroup_storage_type stype;
 	int ret;
 
@@ -1377,7 +1366,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 				     const union bpf_attr *kattr,
 				     union bpf_attr __user *uattr)
 {
-	struct bpf_test_timer t = { NO_PREEMPT };
+	struct bpf_test_timer t = {};
 	u32 size = kattr->test.data_size_in;
 	struct bpf_flow_dissector ctx = {};
 	u32 repeat = kattr->test.repeat;
@@ -1445,7 +1434,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog, const union bpf_attr *kattr,
 				union bpf_attr __user *uattr)
 {
-	struct bpf_test_timer t = { NO_PREEMPT };
+	struct bpf_test_timer t = {};
 	struct bpf_prog_array *progs = NULL;
 	struct bpf_sk_lookup_kern ctx = {};
 	u32 repeat = kattr->test.repeat;
-- 
2.50.1


