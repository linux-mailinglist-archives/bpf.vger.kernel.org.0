Return-Path: <bpf+bounces-55276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3ECA7B2F0
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 02:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F471189B398
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 00:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0275191F6D;
	Fri,  4 Apr 2025 00:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwX2/86F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D08D18DB37;
	Fri,  4 Apr 2025 00:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725068; cv=none; b=R2mK8KlwLlUeVbUP88cNa6mSpU5FxBLsqf3C2n0SfdXU8LJNzXaKAraxMk0aEu2w6hJvumaTBQgnDtPXK27BdWy4KZ5Cv1dat7olMs4S8/aExSP8WAU+zjBobdHCvHijwfQ3NCP7lm4TaRrXj5znIGoQ7h76lARbdHdFiXDCSQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725068; c=relaxed/simple;
	bh=h8Y5gwjb+IBqDKPNN1tzYMAuRLBQHGrsKDnugg4LOvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hjxJj5gmoNG/aDAJe7G0P3dOG4VJ2+rT7J3NWjfYRpjZnbASHl+GnakVC4Xl8jdNiNjwKG4kwrXob4vMmm58fytaVxmenXyMK9ptQDN3+DnrNEs1O1D5Fo/nMETy39xuu0/OWKs7vPRiKc1/SY/GuczN/rML1tguCEPu05CFsCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwX2/86F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B49DC4CEE5;
	Fri,  4 Apr 2025 00:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725067;
	bh=h8Y5gwjb+IBqDKPNN1tzYMAuRLBQHGrsKDnugg4LOvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MwX2/86FQqzqk4W7Z5IL6+7krJpfYioBqkpQ0LNy8NjKdEnx6iNdwfoBxETQBNugm
	 tT1paKC0lptEgU7sG2tQ/PSl+T77c7l8ONPMpFNoyQejaI3Tk7NyXlX70PZCFBWrUn
	 WSelcjwDOZUfADDkOGDonhdskG2LUdhnsyLLdeNR4ww9fil3U0I1n/0P8IN/fLkmh1
	 G+DMiNRz706v91eLC2n0ycXGsmmPOr2BdlXtHbDgLODIDuN0lcVCfTfhAAtlbxFeXw
	 e0ZvGGcoRt4h7+c/V/2V79CEZSqYXgWQCYOR+Bg8ZYpax14eF/vrzGWIy2nBZMNnhj
	 0CKFBlrNEFAAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	daniel@iogearbox.net,
	song@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 11/23] bpf: Fix deadlock between rcu_tasks_trace and event_mutex.
Date: Thu,  3 Apr 2025 20:03:48 -0400
Message-Id: <20250404000402.2688049-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000402.2688049-1-sashal@kernel.org>
References: <20250404000402.2688049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
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
index adc947587eb81..2fbae86961d1f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -392,7 +392,7 @@ static const struct bpf_func_proto bpf_trace_printk_proto = {
 	.arg2_type	= ARG_CONST_SIZE,
 };
 
-static void __set_printk_clr_event(void)
+static void __set_printk_clr_event(struct work_struct *work)
 {
 	/*
 	 * This program might be calling bpf_trace_printk,
@@ -405,10 +405,11 @@ static void __set_printk_clr_event(void)
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
 
@@ -451,7 +452,7 @@ static const struct bpf_func_proto bpf_trace_vprintk_proto = {
 
 const struct bpf_func_proto *bpf_get_trace_vprintk_proto(void)
 {
-	__set_printk_clr_event();
+	schedule_work(&set_printk_work);
 	return &bpf_trace_vprintk_proto;
 }
 
-- 
2.39.5


