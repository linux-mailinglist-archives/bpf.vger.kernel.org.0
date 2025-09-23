Return-Path: <bpf+bounces-69417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA780B963B1
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B8F3A7822
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F66328571;
	Tue, 23 Sep 2025 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcSg25hh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B2123A98E;
	Tue, 23 Sep 2025 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637314; cv=none; b=trfyfwJpc+3XYddGjOpiANMfvjcTNh7z/87Up3822qjwerJYkeuvDtIoLsHhm7JITBiLDDAMxeD2cQWKgR3cCOvMFQNRNiVp+3FdpGd38Ut/Cl/hTCsue2MHM8lUV6Ju1XOJk3b/qW372Y2KtuFxbd1M3m6HU67gkKc3WTIkIUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637314; c=relaxed/simple;
	bh=FM7Dhz9Lrv6Pm3hueBcDMymUaOI0qleJ0d7VFIxSBSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=op8e436IPL30GcLsmHZmM6A37MVi/3+jQ0lbJ3djCXyfdT087pLPkn9+gG+nsQGLkWVgyGLwobprO8cBGJjF0zUAz9+l8c8hc7zQZeh9DupKthbOgSkxCK8uTd1WGceFDwRdEQ1RNdmqAm2ul3XpBC5Pu1UkfU/2qXw7rPLq0X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcSg25hh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B9CC116D0;
	Tue, 23 Sep 2025 14:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637314;
	bh=FM7Dhz9Lrv6Pm3hueBcDMymUaOI0qleJ0d7VFIxSBSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EcSg25hhBf6d8CkJJ7um9/Xmz9fJUx/RrHo97Sv7dyPX6Jzm88CzbzeL9xWYQ3XXt
	 GMx5KVyQUptFLPWFcvaXBiGQsa35TghWpzIdw95uyVmD2q/3WNn0dJxA/ChFAYbjxx
	 q84ostRBrhSBDI+FRMkIY42l4jW/tKRQk0Q51QkASM+3zXs/RdFob9QRCofGsrtv/E
	 +Vy2BsqqxpGBnj7rqunChvIbfCJ10Odu3ODrsG2wiFdm4q6HA2mhcChOow2mtSSChf
	 O/UTi2Ego0gOV+AKR2Mn4FovtzhQUsyymNajbrJ43fGqY7MJXQTeqhpw2oRbj3BKSz
	 p0FFQU3Cx0eqw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CC131CE130C; Tue, 23 Sep 2025 07:20:37 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org
Subject: [PATCH 09/34] rcu: Remove unused rcu_tasks_trace_lazy_ms and trc_stall_chk_rdr struct
Date: Tue, 23 Sep 2025 07:20:11 -0700
Message-Id: <20250923142036.112290-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rcupdate.rcu_tasks_trace_lazy_ms and trc_stall_chk_rdr structure
are no longer used, so this commit removes them.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 --------
 kernel/rcu/tasks.h                              | 10 ----------
 2 files changed, 18 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 747a55abf4946b..54d31a5e46e1cf 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6128,14 +6128,6 @@
 			of zero will disable batching.	Batching is
 			always disabled for synchronize_rcu_tasks().
 
-	rcupdate.rcu_tasks_trace_lazy_ms= [KNL]
-			Set timeout in milliseconds RCU Tasks
-			Trace asynchronous callback batching for
-			call_rcu_tasks_trace().  A negative value
-			will take the default.	A value of zero will
-			disable batching.  Batching is always disabled
-			for synchronize_rcu_tasks_trace().
-
 	rcupdate.rcu_self_test= [KNL]
 			Run the RCU early boot self tests
 
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 25dc49ebad251d..50f5c483e0e15a 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1467,16 +1467,6 @@ void __init rcu_tasks_trace_suppress_unused(void)
 	rcu_tasks_torture_stats_print_generic(NULL, NULL, NULL, NULL);
 }
 
-/* Communicate task state back to the RCU tasks trace stall warning request. */
-struct trc_stall_chk_rdr {
-	int nesting;
-	int ipi_to_cpu;
-	u8 needqs;
-};
-
-int rcu_tasks_trace_lazy_ms = -1;
-module_param(rcu_tasks_trace_lazy_ms, int, 0444);
-
 #if !defined(CONFIG_TINY_RCU)
 void show_rcu_tasks_trace_gp_kthread(void)
 {
-- 
2.40.1


