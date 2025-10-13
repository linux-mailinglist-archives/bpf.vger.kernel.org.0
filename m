Return-Path: <bpf+bounces-70806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3828BBD5464
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 18:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD106503CAC
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 16:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17E0243969;
	Mon, 13 Oct 2025 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="YvA3pS87"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F3E23F294
	for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760372972; cv=none; b=XdyO1F+LwKkuv3ptkNQVdOZN1DVl6u9Zx+5pnqn9/KxIrbUpRrmu460N3icyzzQAJqSoKxANvNOqC9NiGr58460yEeKhgvGgF4mQG+dosBoKegh3F6pMMaMtLPTnddaYOZ0ZPf/+uO9gE57UTP/jYdySioGH9Lo/CpuPkAmpvdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760372972; c=relaxed/simple;
	bh=NPqeS/xgQ+ugsO2vUERndaewe+g4Zf/7Lb3soxYdxXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KlPrDQmXWZpjS67F3xchODtvmLj9bpSGZ7dUjjrsJNHMpOOhE/Fp8Fm30/A0CsapULZh+6j9hlEF9wHM/54wl1oyOzWss7IAx9I50+cP/izA/EbhACrSI8H4fx9657thE9d65fnCIZYeG/cxvqgfhbOB/fLsRazGEclSPoM4p3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=YvA3pS87; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cljV710Wcz9thc;
	Mon, 13 Oct 2025 18:29:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1760372959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=woMg1csc5fex2jKsP23OCBUOiPYc9j/3r+xuaOIhYOM=;
	b=YvA3pS87x9WYXOT+IwZi3FBpDWHEexqeaEQ0dmmtI8GK+sMeZ+fPjvnzsZVXju+8/IGiOz
	FlI1Q1Ts9YEFTaI9DMqffAyd+JOuVc4x6BN7HCfejqFE7Mz9AjG0x/onvjFuV/DlMBj1OX
	W56z0bs4hczvpxoN+LE3agi0g34t63QNyGrlvqG66o7pXiNnsteOWNIvjivnyJQCf5Ch6K
	b0UTp+gUf/f0egKfdi77nmjGDidqVkebosJ2dfG1slP7hoeU/BY+gwubIVFNSZtLmuyE1v
	EehN8T2KTk09rz6MNUEAGhG4My6nC++qLcSiPF+RRUS++vyQK/5SgHbmJLOeMg==
From: Brahmajit Das <listout@listout.xyz>
To: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Cc: bpf@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: [PATCH] bpf: avoid sleeping in invalid context during sock_map_delete_elem path
Date: Mon, 13 Oct 2025 21:59:06 +0530
Message-ID: <20251013162906.1265465-1-listout@listout.xyz>
In-Reply-To: <68af9b2b.a00a0220.2929dc.0008.GAE@google.com>
References: <68af9b2b.a00a0220.2929dc.0008.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

#syz test

The syzkaller report exposed a BUG: “sleeping function called from
invalid context” in sock_map_delete_elem, which happens when
`bpf_test_timer_enter()` disables preemption but the delete path later
invokes a sleeping function while still in that context. Specifically:

- The crash trace shows `bpf_test_timer_enter()` acquiring a
  preempt_disable path (via t->mode == NO_PREEMPT), but the symmetric
  release path always calls migrate_enable(), mismatching the earlier
  disable.
- As a result, preemption remains disabled across the
  sock_map_delete_elem path, leading to a sleeping call under an invalid
  context. :contentReference[oaicite:0]{index=0}

To fix this, normalize the disable/enable pairing: always use
migrate_disable()/migrate_enable() regardless of t->mode. This ensures
that we never remain with preemption disabled unintentionally when
entering the delete path, and avoids invalid-context sleeping.

Reported-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 net/bpf/test_run.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index dfb03ee0bb62..92ff05821003 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2017 Facebook
  */
+#include "linux/rcupdate.h"
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
@@ -29,7 +30,6 @@
 #include <trace/events/bpf_test_run.h>
 
 struct bpf_test_timer {
-	enum { NO_PREEMPT, NO_MIGRATE } mode;
 	u32 i;
 	u64 time_start, time_spent;
 };
@@ -38,10 +38,8 @@ static void bpf_test_timer_enter(struct bpf_test_timer *t)
 	__acquires(rcu)
 {
 	rcu_read_lock();
-	if (t->mode == NO_PREEMPT)
-		preempt_disable();
-	else
-		migrate_disable();
+	/*migrate_disable();*/
+	rcu_read_lock_dont_migrate();
 
 	t->time_start = ktime_get_ns();
 }
@@ -51,10 +49,8 @@ static void bpf_test_timer_leave(struct bpf_test_timer *t)
 {
 	t->time_start = 0;
 
-	if (t->mode == NO_PREEMPT)
-		preempt_enable();
-	else
-		migrate_enable();
+	/*migrate_enable();*/
+	rcu_read_unlock_migrate();
 	rcu_read_unlock();
 }
 
@@ -374,7 +370,7 @@ static int bpf_test_run_xdp_live(struct bpf_prog *prog, struct xdp_buff *ctx,
 
 {
 	struct xdp_test_data xdp = { .batch_size = batch_size };
-	struct bpf_test_timer t = { .mode = NO_MIGRATE };
+	struct bpf_test_timer t = {};
 	int ret;
 
 	if (!repeat)
@@ -404,7 +400,7 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 	struct bpf_prog_array_item item = {.prog = prog};
 	struct bpf_run_ctx *old_ctx;
 	struct bpf_cg_run_ctx run_ctx;
-	struct bpf_test_timer t = { NO_MIGRATE };
+	struct bpf_test_timer t = {};
 	enum bpf_cgroup_storage_type stype;
 	int ret;
 
@@ -1377,7 +1373,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 				     const union bpf_attr *kattr,
 				     union bpf_attr __user *uattr)
 {
-	struct bpf_test_timer t = { NO_PREEMPT };
+	struct bpf_test_timer t = {};
 	u32 size = kattr->test.data_size_in;
 	struct bpf_flow_dissector ctx = {};
 	u32 repeat = kattr->test.repeat;
@@ -1445,7 +1441,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog, const union bpf_attr *kattr,
 				union bpf_attr __user *uattr)
 {
-	struct bpf_test_timer t = { NO_PREEMPT };
+	struct bpf_test_timer t = {};
 	struct bpf_prog_array *progs = NULL;
 	struct bpf_sk_lookup_kern ctx = {};
 	u32 repeat = kattr->test.repeat;
-- 
2.51.0


