Return-Path: <bpf+bounces-70723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A31FBCC019
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 09:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85EFA1A64249
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 08:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DA6276041;
	Fri, 10 Oct 2025 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="no9oZeFC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA432275AF0
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760083178; cv=none; b=IqJGjLMaD54GeCBuhrPZjZqADVfttrI5Dqb03THq4z+nrLfacyttZoliRckMQC9h6V3Kpfbm1jSPweV0RGlVnWS9+5wyZGi2T7dp/szgViG222t0O8euDyXrW6bzpBQTk33CPerc4mm6OkQAzviXFjF+X6NteUt+SeYjaxwMXao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760083178; c=relaxed/simple;
	bh=EXuckxfVgYvKOH83wV0t7/h7kE2Y90X8nx1+TUoyFFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r8PxD+JtevKzvemtFiAt7GPwqrsvdriVh2rhtSFzRO3OVJLJxrfKD+qSltPW/zE+CS99cg3RzECU+Qc+MN5pkO7bOb7sSwhebRmJtRy2SGf6l2uA3RW7tJbSpT8JvWYntlAXn5gizibhHMs9VBZJiKvdWKbt6UENG2KoDW6inF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=no9oZeFC; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so1161804a12.0
        for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 00:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760083176; x=1760687976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i0LBEzbjSl7ybH0yo+ER/jCvHKntMwzQjfKv6KbEQQA=;
        b=no9oZeFC+DXWoDn3PVjCITgr4GILegEnaUyBgm7sTdy/rRj9inMY3GaYQZ7SE46zO+
         BmXHPPvK/350LEfbHRG4KOv1f0cw5KuVNwb5I8hLDM+LDDzCtgYtOSjnstUc/2QYEnUX
         KHMPj9K81C2pBiyvM8wxQUkkZ41paV3g8Kgrf4Ua7t+ftRZPUYolCA+62juQ97KCK159
         +2wbu5KjaGmYcmJrQqblGq/lZ34M4uOrSxZpb5jcG3ZKhIcm46B9FVJxOEiueJWYoyt1
         5gS1dFZomNjf+q/vdJj3r2lEHkZ+2WzbossfCoKO59FkIfsthJTZWovOZWINhq/uw/gd
         Lw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760083176; x=1760687976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0LBEzbjSl7ybH0yo+ER/jCvHKntMwzQjfKv6KbEQQA=;
        b=xOwUMaqFfTWbC2fWw+932084rEDEM2MeG/ftv+VmslQGmNyt2Ao0AfeWBw2Kcni08H
         S1gbJNPgBVGd2D9atOJnkROMwZjUeEgIjluqyfNWhSdF/9DA7vKo4gGLLPoDXhapeKIc
         ynIm5Z2ZuetvwZgZuCQ3fPawQsdqkBmdVxWy2DlDk7lhN+rPYV7GCVabPhleN3vFhudJ
         Jggo3aiETDCQ+CBNa03vRpntiWphZIF7T9lz2g4wpaO61xqQX7X4UohxaNiDwTI36zF4
         3CK44TN+RpCSueZ27jlyZiEychaUZOyKYfsxux2l5VmISKeU4QzO7il43MmGghHAe8lK
         qOnA==
X-Forwarded-Encrypted: i=1; AJvYcCUV4/eU3eIHJ9dbF5R8YHsldTjZe195F2YEMEYGvuUfbXbgUa28j2kcaoekgizK3vdGcq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmwFt4txDYchA0kVzpBn3DrMZCxlyyC2E58sk+2kWGFotx/NRk
	K+6Ffv+BGrcrQlgyX6oHM++TGdbor+nOKKdR0hbpcD7Iv1P1YNyHXwPx
X-Gm-Gg: ASbGncuTKt1bTSr4P2Z9IJqQbQwrHiWRC+HhBTqhMi0mcWyZI2fYKc4r+WOXvdCQUvl
	tzJNs4mIDtxg1Nn6jedBBjzKDxDscB1W2ISLAvt7GBwUwDS3Om9KPQCk51bjwglCSPmFFMHOCF8
	NsGFFDOeYQjtU80zHyoofWID10kOMu6sQ4ABvPu8EHUhsjz49CithzqehtXmSlCvqbO/U51buej
	R4DSEl6TzBaPsLqoe18321VcE/eS9iJgOm9TKKm1nqinLiLAcy+5H3FvXYMMZrZUDuMFfokTGmx
	SZ5ZAuIOg789YAcotv1KM3GB/UezRTT6qTt05S+gl97zLtlI0mSZvH9DPHn83lJyXgaFjgPa1c0
	ZC/ZKXyji+uYYYz601kNutVYBasT7r2glD+s3kcGKjaVct19YW+4NSiPhVyo+jisE+uBfD7MLc1
	6JxgYZ+pcQcuBrZkG4RwRlP3jWoSUB
X-Google-Smtp-Source: AGHT+IFDFb6PSeK8Nb9c05rCgLloyNtCQ1q5dqJWDMfsdnBamZSe/AhSqkpVrU1rVjdMS7A8JFNsPw==
X-Received: by 2002:a17:902:e787:b0:269:a2bc:799f with SMTP id d9443c01a7336-290272b54b6mr122095995ad.29.1760083175867;
        Fri, 10 Oct 2025 00:59:35 -0700 (PDT)
Received: from chandna.localdomain ([49.43.133.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f8f9e0sm49134345ad.120.2025.10.10.00.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 00:59:34 -0700 (PDT)
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
Subject: [PATCH v2] bpf: test_run: Use migrate_enable()/disable() universally
Date: Fri, 10 Oct 2025 13:29:23 +0530
Message-ID: <20251010075923.408195-1-chandna.linuxkernel@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The timer context can safely use migrate_disable()/migrate_enable()
universally instead of conditional preemption or migration disabling.
Previously, the timer was initialized in NO_PREEMPT mode by default,
which disabled preemption and forced execution in atomic context.
This caused issues on PREEMPT_RT configurations when invoking
spin_lock_bh() — a sleeping lock — leading to the following warning:

BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6107, name: syz.0.17
preempt_count: 1, expected: 0
RCU nest depth: 1, expected: 1
Preemption disabled at:
[<ffffffff891fce58>] bpf_test_timer_enter+0xf8/0x140 net/bpf/test_run.c:42

Reported-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8
Tested-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Signed-off-by: Sahil Chandna <chandna.linuxkernel@gmail.com>

---
Link to v1: https://lore.kernel.org/all/20251006054320.159321-1-chandna.linuxkernel@gmail.com/

Changes since v1:
- Dropped `enum { NO_PREEMPT, NO_MIGRATE } mode` from `struct bpf_test_timer`.
- Removed all conditional preempt/migrate disable logic.
- Unified timer handling to use `migrate_disable()` / `migrate_enable()` universally.

Testing:
- Reproduced syzbot bug locally using the provided reproducer.
- Observed `BUG: sleeping function called from invalid context` on v1.
- Confirmed bug disappears after applying this patch.
- Validated normal functionality of `bpf_prog_test_run_*` helpers with C
  reproducer.
---
 net/bpf/test_run.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index dfb03ee0bb62..b23bc93e738e 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -29,7 +29,6 @@
 #include <trace/events/bpf_test_run.h>
 
 struct bpf_test_timer {
-	enum { NO_PREEMPT, NO_MIGRATE } mode;
 	u32 i;
 	u64 time_start, time_spent;
 };
@@ -38,10 +37,7 @@ static void bpf_test_timer_enter(struct bpf_test_timer *t)
 	__acquires(rcu)
 {
 	rcu_read_lock();
-	if (t->mode == NO_PREEMPT)
-		preempt_disable();
-	else
-		migrate_disable();
+	migrate_disable();
 
 	t->time_start = ktime_get_ns();
 }
@@ -50,11 +46,7 @@ static void bpf_test_timer_leave(struct bpf_test_timer *t)
 	__releases(rcu)
 {
 	t->time_start = 0;
-
-	if (t->mode == NO_PREEMPT)
-		preempt_enable();
-	else
-		migrate_enable();
+	migrate_enable();
 	rcu_read_unlock();
 }
 
@@ -374,7 +366,7 @@ static int bpf_test_run_xdp_live(struct bpf_prog *prog, struct xdp_buff *ctx,
 
 {
 	struct xdp_test_data xdp = { .batch_size = batch_size };
-	struct bpf_test_timer t = { .mode = NO_MIGRATE };
+	struct bpf_test_timer t;
 	int ret;
 
 	if (!repeat)
@@ -404,7 +396,7 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 	struct bpf_prog_array_item item = {.prog = prog};
 	struct bpf_run_ctx *old_ctx;
 	struct bpf_cg_run_ctx run_ctx;
-	struct bpf_test_timer t = { NO_MIGRATE };
+	struct bpf_test_timer t;
 	enum bpf_cgroup_storage_type stype;
 	int ret;
 
@@ -1377,7 +1369,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 				     const union bpf_attr *kattr,
 				     union bpf_attr __user *uattr)
 {
-	struct bpf_test_timer t = { NO_PREEMPT };
+	struct bpf_test_timer t;
 	u32 size = kattr->test.data_size_in;
 	struct bpf_flow_dissector ctx = {};
 	u32 repeat = kattr->test.repeat;
@@ -1445,7 +1437,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog, const union bpf_attr *kattr,
 				union bpf_attr __user *uattr)
 {
-	struct bpf_test_timer t = { NO_PREEMPT };
+	struct bpf_test_timer t;
 	struct bpf_prog_array *progs = NULL;
 	struct bpf_sk_lookup_kern ctx = {};
 	u32 repeat = kattr->test.repeat;
-- 
2.50.1


