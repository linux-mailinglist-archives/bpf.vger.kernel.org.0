Return-Path: <bpf+bounces-69410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B89B96393
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E461C19C64C9
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E9D284885;
	Tue, 23 Sep 2025 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCS9U0Lh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDAE23D7E0;
	Tue, 23 Sep 2025 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637302; cv=none; b=Lof9QmSBuljSHODx94l+kMCNvkTAtjVcmKFHkCDG/7ztQOq0cqsJmfKHSTsbgEGn+jmXpsAiR4mRS95wdRfxcwVuVa93KJDG9NkO8v5gIMkKPKt1cxPgzfJ6Da+6wkc4vNVoZ0su206dhm+hQq1bpyVC3DdrNrYkL381LsJyWs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637302; c=relaxed/simple;
	bh=voJ4b6wMLOYakegASPWhkeR8X8Tsr/P1l+3ILgsYDF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pMu6JdsXFsICf41Gbb1qt5ok9dLs0GN8dAEHVSruv3nAY2ZT7ktq5XLSL0g/PN4+oeSDaprn0djXC9PBBI9Z2+fy3SAQojZzfQiKxlWB3vjNCOt4RDfACtTXdpcvQHwaHGg/M3Qj0nQ6V/+edJDN7/sQBDkm0EiS/1LWJM+3HTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCS9U0Lh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B28C19423;
	Tue, 23 Sep 2025 14:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637302;
	bh=voJ4b6wMLOYakegASPWhkeR8X8Tsr/P1l+3ILgsYDF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tCS9U0Lhi+elUXnefbj5rnsXjSzaHvGHocOzcXCFwTfuRQNVAlrl8woqLjEHd/zPc
	 VXM0CwQQtVbkB7B0sghWV07t6XXCkZFinn8xqMSaQK5v0qicAEQLY0uPcd6jmqdlvj
	 ou02Om4Jfpd2jyy1doGS3UpNHF4sFWxIxhOWkbH/Rok58Lq/koO8eMVJAf+z6MEnzG
	 WmwPjB09dHeXSlQbSXgkBatd6lgm3Yrr7p/CHkkIKP9vpFpGcWSdRjSYNqiLgbg3SA
	 wjGhIcH83gk8QA1Humouh2j8Hxj4j6fhnoPYzaXn55/FpYQNTlX/KZvHpqIPfGpvft
	 hjjk68iBHuhAw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 075D1CE16CE; Tue, 23 Sep 2025 07:20:38 -0700 (PDT)
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
Subject: [PATCH 26/34] rcutorture: Test rcu_tasks_trace_expedite_current()
Date: Tue, 23 Sep 2025 07:20:28 -0700
Message-Id: <20250923142036.112290-26-paulmck@kernel.org>
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

This commit adds a ->exp_current member to the tasks_tracing_ops structure
to test the rcu_tasks_trace_expedite_current() function.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/rcutorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 64803d09fc733a..2e3806b996a80a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1136,6 +1136,7 @@ static struct rcu_torture_ops tasks_tracing_ops = {
 	.deferred_free	= rcu_tasks_tracing_torture_deferred_free,
 	.sync		= synchronize_rcu_tasks_trace,
 	.exp_sync	= synchronize_rcu_tasks_trace,
+	.exp_current	= rcu_tasks_trace_expedite_current,
 	.call		= call_rcu_tasks_trace,
 	.cb_barrier	= rcu_barrier_tasks_trace,
 	.cbflood_max	= 50000,
-- 
2.40.1


