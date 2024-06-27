Return-Path: <bpf+bounces-33215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2487919CF5
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 03:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 699371F238C8
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 01:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B14E2139CE;
	Thu, 27 Jun 2024 01:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chlky8xv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36752360;
	Thu, 27 Jun 2024 01:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719451626; cv=none; b=WoyMANCOdjrcQxn4r5DGf5aCxKiGRcoluSgFUmp057i0TH8KIW3Xgv26FT8RLLH0j4isnVmonNrGpZIJZdPZXSjZm/Nst6BiR3XNKPXkvruo3pJ97Y5nDAlWVeddta9NYFSMyeqvqXsodUmaN/q+taARrE6JOOHKRBW1j/gwL0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719451626; c=relaxed/simple;
	bh=ldZw4/HlEuQqvl/f692vTc/Al4b/7sOMWc3j138ve6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGRyqV2MpZ2VGOAzXfhK3WR7zHz6mmcunJR+xPETx9t3lTFP/JeBII5toO0ChAV/fp+tEY/ZJmASK1QktcuXAZDlI/XuI1zSEQx1LIFmJA6MEjX6i+czkuBbQPw1bnLDS7IT6voAsps+FhBRhAESgbc5PeYhfS2wrtN3NZGMz88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chlky8xv; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6bce380eb9bso4477552a12.0;
        Wed, 26 Jun 2024 18:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719451624; x=1720056424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=haQdSQpOvWWPVDcFZ8m8tvOUtaNYuk1LuYxC2f7J048=;
        b=chlky8xvUciOG3+Tih6z3dBFfBUg/KV0lI+wY3YAQdERjyVbLbIQkBYSwxo6Y8qPsy
         vjF+cpF7VaNkzKQGZfDTroyV2pRckFBn4ngXFJgu/sNMULRvrnW4dvMm15F3j//WWx3f
         mijP7HblUnN16pgmihoX6heaDKHSdWTXEeifXD5bcrGLCWZjUuA1yekfSjw1lrsbcD4o
         a9qKROSNJbA9U5wlLlTPSmutzen3QrmbSRM+BbOn4hDYDJhft1MGnKFAs2YgWGqpw8uB
         nugylB3pGFu4rZLZqP7cGy3XqbrCxG+yD0eyVNS4A+fL1rubHArVMrghloEnKRFO2WdP
         1XFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719451624; x=1720056424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haQdSQpOvWWPVDcFZ8m8tvOUtaNYuk1LuYxC2f7J048=;
        b=Z7a6J6A0eupgTh/DxQkZ78irpBxmGft6nj+u1dAQ2unPfL0ic5ukxYpiBKRb7lavdw
         LxcVk17cJUsyZIgdHL1bfkeRozHoBeh9cDJ5MeL+iXrbPEgy2LBouS7tHspkWHWW4Ai5
         f05HMt8EbU1QLi5eIIY2ydDgrD6N8eCP4+ETglyEO2mQwFy7H6sRe8Qay+1PiuOOKYnF
         quh8uNU1YI57VXhwMbowrxs/OHdvbBMRGrufYR2q3NY65I4IhZD3mF5NoBJvaFipgGBD
         UwRnAbbyw8TfK5IlzmkNnlM688CWshJEGtx5HyRI/v7mazpFre3xWQRFNChRiS+K/tiS
         At5A==
X-Forwarded-Encrypted: i=1; AJvYcCWd0hQ9pcoTbQf/YTuOcOD1HGLyqPlkIBi5P0C7msE0fO0DJVeKgxUXe3MH5dabh2WnnO1ZPsq+SoOsEIUt3vQuVC9lukXR+GtJFJ0crIzoCn67C/27TYk4q0ZnZbC67ZYg
X-Gm-Message-State: AOJu0Yywc4dYGf6ctHni/RgR2gvTkhfwGQAaDJ9vLL/JlxfmaeCINBms
	daZODOm10zkAw+1U0EpT2HNme9JZbR6zdngGqq/cvvWTzy+6Glcr
X-Google-Smtp-Source: AGHT+IHP+hilRDwjxnxKrOiMQiKfTq9PbsGI1a2/5EP3IttiPmg14FcMVazNxICQp5uiS0lgvRAbqA==
X-Received: by 2002:a05:6a20:7b13:b0:1bd:2ba1:983b with SMTP id adf61e73a8af0-1bd2ba198e7mr3945437637.51.1719451624153;
        Wed, 26 Jun 2024 18:27:04 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac997d9csm1287375ad.215.2024.06.26.18.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 18:27:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 26 Jun 2024 15:27:02 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
	andrea.righi@canonical.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com, Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH sched_ext/for-6.11] sched_ext: Disallow loading BPF scheduler
 if isolcpus= domain isolation is in effect
Message-ID: <Zny_5syk1K74HP0D@slm.duckdns.org>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-10-tj@kernel.org>
 <20240624113212.GL31592@noisy.programming.kicks-ass.net>
 <ZnnijsMAQYgCnrZF@slm.duckdns.org>
 <20240625082926.GT31592@noisy.programming.kicks-ass.net>
 <ZntVjZ3a2k5IGbzE@slm.duckdns.org>
 <20240626082342.GY31592@noisy.programming.kicks-ass.net>
 <ZnxXej8h46lmzrAP@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnxXej8h46lmzrAP@slm.duckdns.org>

sched_domains regulate the load balancing for sched_classes. A machine can
be partitioned into multiple sections that are not load-balanced across
using either isolcpus= boot param or cpuset partitions. In such cases, tasks
that are in one partition are expected to stay within that partition.

cpuset configured partitions are always reflected in each member task's
cpumask. As SCX always honors the task cpumasks, the BPF scheduler is
automatically in compliance with the configured partitions.

However, for isolcpus= domain isolation, the isolated CPUs are simply
omitted from the top-level sched_domain[s] without further restrictions on
tasks' cpumasks, so, for example, a task currently running in an isolated
CPU may have more CPUs in its allowed cpumask while expected to remain on
the same CPU.

There is no straightforward way to enforce this partitioning preemptively on
BPF schedulers and erroring out after a violation can be surprising.
isolcpus= domain isolation is being replaced with cpuset partitions anyway,
so keep it simple and simply disallow loading a BPF scheduler if isolcpus=
domain isolation is in effect.

Signed-off-by: Tejun Heo <tj@kernel.org>
Link: http://lkml.kernel.org/r/20240626082342.GY31592@noisy.programming.kicks-ass.net
Cc: David Vernet <void@manifault.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/build_policy.c |    1 +
 kernel/sched/ext.c          |    6 ++++++
 2 files changed, 7 insertions(+)

--- a/kernel/sched/build_policy.c
+++ b/kernel/sched/build_policy.c
@@ -16,6 +16,7 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/cputime.h>
 #include <linux/sched/hotplug.h>
+#include <linux/sched/isolation.h>
 #include <linux/sched/posix-timers.h>
 #include <linux/sched/rt.h>
 
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4400,6 +4400,12 @@ static int scx_ops_enable(struct sched_e
 	unsigned long timeout;
 	int i, cpu, ret;
 
+	if (!cpumask_equal(housekeeping_cpumask(HK_TYPE_DOMAIN),
+			   cpu_possible_mask)) {
+		pr_err("sched_ext: Not compatible with \"isolcpus=\" domain isolation");
+		return -EINVAL;
+	}
+
 	mutex_lock(&scx_ops_enable_mutex);
 
 	if (!scx_ops_helper) {

