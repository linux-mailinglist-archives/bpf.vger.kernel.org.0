Return-Path: <bpf+bounces-55283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 895E6A7B335
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 02:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C461881431
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 00:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B711EA7E1;
	Fri,  4 Apr 2025 00:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQ8hMeBt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C601E7C01;
	Fri,  4 Apr 2025 00:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725118; cv=none; b=tOPCfuKpX2KOJu7cCinGVhWbdP/F5k0+flSAHy6qucfqeWT80z1CPYzXFmOceVOj5lQ/kIXP+8sazYIpylbKtjcugdg0c8D4T8xvtEXEf69DrgZrmrtIA0HkE/XzCSjpmcw8p5dCOm/oaNUNCWMz1E+tRt0GjFlSwva9nH0Jnqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725118; c=relaxed/simple;
	bh=PFnM5LjoAR7cGmB0S9l3LZS4WvW7TOkVuyAIaMeuV10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I+ylAfvMMZXhc5q2kqtbpBu1vdmhweEJha3bGrdTZ1T8yx0QPmnhY1tPiSawBBmYMhfIlxV/drsQAlBApS5tj90+FiW1NexFDYV7+0FwX7g3K8AuwlPhVF691qvvc4tPcgvh8nrlsBW5SSvdqV/7Z4iPQxYOfbie1mhlNeU4TRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQ8hMeBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3040C4CEE3;
	Fri,  4 Apr 2025 00:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725118;
	bh=PFnM5LjoAR7cGmB0S9l3LZS4WvW7TOkVuyAIaMeuV10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IQ8hMeBt9LZ0DG4UqoR/53zeeAUsOP6rzu2czab3PrCLTBWg9lArI6o5eiKEEo72t
	 vbXQWwmuSlEwDavKwnf2BDZg2CpCJIIE94JoeXkTarcEQi6KBmdD2wGUBEV3xs90f4
	 hIRdneLAhTon8lK3yXhupHBPtAiLv1yR5b0gHu6I1zN9+4j/W3j5JBk4Cpr+TD7TsJ
	 YJ+vorvcWi8pdSM6ZVKCbxwwkX/QI6fB3DIh65rwtigpP5sRf+VwAVcFTD+q1n5S7b
	 inY8GpRWGkalKMi2jpRh7NHNyUGI1H7XoDpegka4fkJyD1lMm2E5QaZ+nbtQDVSmwZ
	 kNJKai5f+fQFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	song@kernel.org,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	daniel@iogearbox.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 11/22] bpf: Fix deadlock between rcu_tasks_trace and event_mutex.
Date: Thu,  3 Apr 2025 20:04:40 -0400
Message-Id: <20250404000453.2688371-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000453.2688371-1-sashal@kernel.org>
References: <20250404000453.2688371-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

[ Upstream commit 4580f4e0ebdf8dc8d506ae926b88510395a0c1d1 ]

Fix the following deadlock:
CPU A
_free_event()
  perf_kprobe_destroy()
    mutex_lock(&event_mutex)
      perf_trace_event_unreg()
        synchronize_rcu_tasks_trace()

There are several paths where _free_event() grabs event_mutex
and calls sync_rcu_tasks_trace. Above is one such case.

CPU B
bpf_prog_test_run_syscall()
  rcu_read_lock_trace()
    bpf_prog_run_pin_on_cpu()
      bpf_prog_load()
        bpf_tracing_func_proto()
          trace_set_clr_event()
            mutex_lock(&event_mutex)

Delegate trace_set_clr_event() to workqueue to avoid
such lock dependency.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20250224221637.4780-1-alexei.starovoitov@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/bpf_trace.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2c2205e91fee9..24479ef395d49 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -403,7 +403,7 @@ static const struct bpf_func_proto bpf_trace_printk_proto = {
 	.arg2_type	= ARG_CONST_SIZE,
 };
 
-static void __set_printk_clr_event(void)
+static void __set_printk_clr_event(struct work_struct *work)
 {
 	/*
 	 * This program might be calling bpf_trace_printk,
@@ -416,10 +416,11 @@ static void __set_printk_clr_event(void)
 	if (trace_set_clr_event("bpf_trace", "bpf_trace_printk", 1))
 		pr_warn_ratelimited("could not enable bpf_trace_printk events");
 }
+static DECLARE_WORK(set_printk_work, __set_printk_clr_event);
 
 const struct bpf_func_proto *bpf_get_trace_printk_proto(void)
 {
-	__set_printk_clr_event();
+	schedule_work(&set_printk_work);
 	return &bpf_trace_printk_proto;
 }
 
@@ -462,7 +463,7 @@ static const struct bpf_func_proto bpf_trace_vprintk_proto = {
 
 const struct bpf_func_proto *bpf_get_trace_vprintk_proto(void)
 {
-	__set_printk_clr_event();
+	schedule_work(&set_printk_work);
 	return &bpf_trace_vprintk_proto;
 }
 
-- 
2.39.5


