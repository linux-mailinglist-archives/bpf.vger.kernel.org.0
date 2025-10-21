Return-Path: <bpf+bounces-71636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA01BF8E24
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 23:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88357460285
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 21:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865CE285CAE;
	Tue, 21 Oct 2025 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvUZQPXE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033A4280A5A;
	Tue, 21 Oct 2025 21:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080637; cv=none; b=Vi/NPqC5/GeHpFeHHWDo51imo27YfgQABH8EqLc9ie6ak6nvdHozCgKTTAbqaWXLqipytEJvqsRGCYz2VvBTAqgsO3Ruh397GU1y254aCqLQeFmqIIh3UFA5HkbLDZoxt0bxgrYhyQXdlki6CXuXh38U54US6cE6dt+uy1ns0M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080637; c=relaxed/simple;
	bh=hCFMoH+hhI+7AG/TEmtDulxgHOW23trUba08i6NoZVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jfq8+irEyXx1SClpYqVO6T3H5OKt8fXw5POfw/4QoFIcJcpROpxz8sAlwzPwyohaWwKMdV2P+iPGUHGBvPnnluf9I4o6huHADcTNibIFM8ybZt0eOoSJcOG0sEgTTZeDyfHx3MCFL9XGGSbt5x/hX0c+cVDJhh6kI+ereMROgzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvUZQPXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A16FC113D0;
	Tue, 21 Oct 2025 21:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761080636;
	bh=hCFMoH+hhI+7AG/TEmtDulxgHOW23trUba08i6NoZVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LvUZQPXEtCDwbZytbDDR3fxUNgi1ku77F1dxfexfkOoQjOTw6J7cG7PLTbqixK4QV
	 bBXzbo9jvVEvaK0KJnd2fXJZbnkuyw5oGrqUBZs+pPsLjNBd633zcDL3Er58WPZ3i/
	 u2fLQn21Pg2tZasmH5i8VWiHZGpSmjYwzb0unn1K2nrpkch6AM0tIzmJdsHVB6QRZ8
	 cPBIrh9YuQ5BYlaNsR8/Um8Sfd/sUvhd8TzOrm8tCEQTv1DiZQ5DwK+pCF/c4mubvH
	 q08uKUF8JXpVGl/lQQZGq0RMxGfdio4BGYpYUed4tzgTetOieMs1FmA8Kplah2IwHL
	 enqjQrk3e/E1g==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: sched_ext: Don't kick CPUs running higher classes
Date: Tue, 21 Oct 2025 11:03:53 -1000
Message-ID: <20251021210354.89570-2-tj@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251021210354.89570-1-tj@kernel.org>
References: <20251021210354.89570-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a sched_ext scheduler tries to kick a CPU, the CPU may be running a
higher class task. sched_ext has no control over such CPUs. A sched_ext
scheduler couldn't have expected to get access to the CPU after kicking it
anyway. Skip kicking when the target CPU is running a higher class.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5122,18 +5122,23 @@ static bool kick_one_cpu(s32 cpu, struct
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct scx_rq *this_scx = &this_rq->scx;
+	const struct sched_class *cur_class;
 	bool should_wait = false;
 	unsigned long flags;
 
 	raw_spin_rq_lock_irqsave(rq, flags);
+	cur_class = rq->curr->sched_class;
 
 	/*
 	 * During CPU hotplug, a CPU may depend on kicking itself to make
-	 * forward progress. Allow kicking self regardless of online state.
+	 * forward progress. Allow kicking self regardless of online state. If
+	 * @cpu is running a higher class task, we have no control over @cpu.
+	 * Skip kicking.
 	 */
-	if (cpu_online(cpu) || cpu == cpu_of(this_rq)) {
+	if ((cpu_online(cpu) || cpu == cpu_of(this_rq)) &&
+	    !sched_class_above(cur_class, &ext_sched_class)) {
 		if (cpumask_test_cpu(cpu, this_scx->cpus_to_preempt)) {
-			if (rq->curr->sched_class == &ext_sched_class)
+			if (cur_class == &ext_sched_class)
 				rq->curr->scx.slice = 0;
 			cpumask_clear_cpu(cpu, this_scx->cpus_to_preempt);
 		}

