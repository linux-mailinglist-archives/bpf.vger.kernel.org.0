Return-Path: <bpf+bounces-55294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1288DA7B3B9
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 02:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE4E1742E4
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 00:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27172201015;
	Fri,  4 Apr 2025 00:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcfHTHJZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95519200127;
	Fri,  4 Apr 2025 00:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725200; cv=none; b=hUskt89uLQCulALodkUEWOGwNg60u0Sb2gI8Jyc6fUwtv0zQ5q2FSRst5gxO5FtiMATVoI4qjOVpYRuNtpNaGEvmaS40wjTTTofKU1oV2z5aK0REsDTjNhft0mmWRcgq7n5ZMK5iBZ6lfgVUVx9S90WKzeb70yBLe3qNygxnrtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725200; c=relaxed/simple;
	bh=jQgFMtpvIfsLgbacEuyFXfCo0xTll4YBnX56vt9tXP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PN0KroseX/fo4tbxxaa9/5hSHDQYtzKG/3wrlHTTQ1PLTn06AGiv3TraqAFQJyvGfAfxks+78DeAIyM5rLbBK4P76GlJDSXUhgQ94nfD8xkq9ZsEVHa5yCj48B7eScbfsOdP+al7S1oOV+wbpejkIuHGmvyPDwNL529j/DvZ054=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcfHTHJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14ACFC4CEE5;
	Fri,  4 Apr 2025 00:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725200;
	bh=jQgFMtpvIfsLgbacEuyFXfCo0xTll4YBnX56vt9tXP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tcfHTHJZj/69OZbKPUt+v5lqJPaBwQxElWDIpm8BiIzAonfi/D3zaLcex7u1hytbn
	 wxD4r3Dsghp5dd8wg0iCGB4iwoO6xCrfcKJLHDLpwf2VCKgX7Rs3Nqelm25Pw5yrKS
	 mNW0Q9GJN8iQCfpP6R7syQuGwoaN+tSkEOFv0soyE7MHpGaA9nmJcgGu5CZPOPUHFH
	 Pr2T8g/K3GAlQWr5qZ3ggi9ErJOEgIxLKeQ06XECMCuDaGBZwSbNNTMoyvhussn2Z+
	 exr3u/uaY+DwdhXxNrZioZVXLKwmo6Ss54yYUwreLxjnovOWRtLHTw6OCrrQyxOdmJ
	 jtz78IT1ALKDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	song@kernel.org,
	daniel@iogearbox.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 06/16] bpf: Fix deadlock between rcu_tasks_trace and event_mutex.
Date: Thu,  3 Apr 2025 20:06:14 -0400
Message-Id: <20250404000624.2688940-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000624.2688940-1-sashal@kernel.org>
References: <20250404000624.2688940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
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
index 9d8f60e0cb554..eebdde66564ec 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -400,7 +400,7 @@ static const struct bpf_func_proto bpf_trace_printk_proto = {
 	.arg2_type	= ARG_CONST_SIZE,
 };
 
-static void __set_printk_clr_event(void)
+static void __set_printk_clr_event(struct work_struct *work)
 {
 	/*
 	 * This program might be calling bpf_trace_printk,
@@ -413,10 +413,11 @@ static void __set_printk_clr_event(void)
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
 
@@ -459,7 +460,7 @@ static const struct bpf_func_proto bpf_trace_vprintk_proto = {
 
 const struct bpf_func_proto *bpf_get_trace_vprintk_proto(void)
 {
-	__set_printk_clr_event();
+	schedule_work(&set_printk_work);
 	return &bpf_trace_vprintk_proto;
 }
 
-- 
2.39.5


