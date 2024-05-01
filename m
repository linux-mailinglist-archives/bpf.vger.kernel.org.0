Return-Path: <bpf+bounces-28341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EB08B8C90
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD931C21CD0
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61940131735;
	Wed,  1 May 2024 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOtBdF4X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7D21311B6;
	Wed,  1 May 2024 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576421; cv=none; b=iPyJPb027Rx6MrczFzEkzC2Gp+1FIjW3Tx1akHwyOL6pIklkJUziHfUwcAYJz6RxZsY92DIFdin105MFW4iSGyz1V7HjQXPH5dqISCejpDksbia2zWqTXjP60Njql1j4Lf/UyedKjcUXHpjX2SrhI6R3kxojgV4vNOnqGTsKGBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576421; c=relaxed/simple;
	bh=UVJBlg1E80HF88FwUythpmvNcunKH0Z9gizWAA9cYKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmYzTtJP+LHlW9vMt65OD7/MLVn9eiLetuUFtRl+R7ce+CSe1LAXgVOD8lNfybZu0LIMpOXMPlFA2ajihwQJXM8h83dgqO59iCc1/RHc7HsO1TPDffwZKhkqyrrBwnq4etfIvZsVbnbL1p1sRWu5+Xo1BH5tymDLXBBhZLNxC4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOtBdF4X; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ec85c2f469so6589045ad.1;
        Wed, 01 May 2024 08:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576420; x=1715181220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egMQjv+C2ACOSGJGwERMU3JJelRVUGx5f2uXYjvIRCI=;
        b=ZOtBdF4XXQ73z83mBxzUUTmCUU0784h6KULV9SSgUiXDr20pR8dREuPlEajFF2IoeK
         rXHsSSmKSjjvVixiafTfjEstTOJEYlpkzhLQ7DDpm5jWBWZDhF1WI2EcwgfcjnhjlsMz
         hwPV9P5gRPgrX8JbSmcj5S4ICOHfK/t6eh+qJzndBPtGzlt/G0scsHf3G+eKasJ+OEvx
         WSBwfRo05uMVD5PWL5LLG/7GAbcTS+YNG8mvrChbljGmNbQIfEr8l1w2lr3yFAAod/Ye
         IPK35NmEDsFl9b2xIMN4Z4RsSFc9/wmnup55fVLR8RTUBEJ18Ch2K7cmW8p4oBd8/53u
         rH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576420; x=1715181220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=egMQjv+C2ACOSGJGwERMU3JJelRVUGx5f2uXYjvIRCI=;
        b=CB6yiz7bpAm76WZUWxBxL/9IGMq4EKfg6wVSwIGsizrIyt7KrpFtub2ZbVdH10/8WD
         VvXfWavMSBGsvRLLkxnb2MCteW3po22qfpnQNWTNDGYOo4SqKCVtBokjUAiRsJpIXERj
         G1nFaDpJBOJ/KbedMpuJEystK5KYnl6NBhiw+lOM97NX/1phazsN8Xni7hBkmd9jjSMX
         RJ9Ssfh7cMZvQX6k6Ft9ytKISPBmjnuGv5EnvEGHQ3QEqq4XCvQXJmsWdZUC8b1MOD3H
         Nm/MI24/tiT5OtRKs4eP4qdhavhHIP84kA9iWi6gSIEFVJNcv4vJ/dKmNETpV0GdYam4
         8S1w==
X-Forwarded-Encrypted: i=1; AJvYcCW6MV36rgizZVYakvMi3QoTJ5eGa3Blw5rSyCbYhUX1PMv36PXwJuIWlvR9bk2ctsX6Hm/6pBYo7/4A9C/7G3ieSbrM
X-Gm-Message-State: AOJu0Yy/UcdhXP+xFUOUDvnbdi1+3QwCX/q+126KgsH9XPOxuHtb7Z0o
	SJEHRytINwhVcCMPATjprY/+LH4NS4SuJZj4DrmN7K2hQePF1qjj
X-Google-Smtp-Source: AGHT+IFwm2kIGhcj2h40KEs4GPsvC97nTy4gGknFVSCfB2x3wQTqBcH13KRt8fzMNzTrUkHSIHCgWA==
X-Received: by 2002:a17:902:eacc:b0:1eb:d72e:8296 with SMTP id p12-20020a170902eacc00b001ebd72e8296mr3719278pld.10.1714576419525;
        Wed, 01 May 2024 08:13:39 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902a70300b001e83a718d87sm24349755plq.19.2024.05.01.08.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:13:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	joshdon@google.com,
	brho@google.com,
	pjt@google.com,
	derkling@google.com,
	haoluo@google.com,
	dvernet@meta.com,
	dschatzberg@meta.com,
	dskarlat@cs.cmu.edu,
	riel@surriel.com,
	changwoo@igalia.com,
	himadrics@inria.fr,
	memxor@gmail.com,
	andrea.righi@canonical.com,
	joel@joelfernandes.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 11/39] cpufreq_schedutil: Refactor sugov_cpu_is_busy()
Date: Wed,  1 May 2024 05:09:46 -1000
Message-ID: <20240501151312.635565-12-tj@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501151312.635565-1-tj@kernel.org>
References: <20240501151312.635565-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sugov_cpu_is_busy() is used to avoid decreasing performance level while the
CPU is busy and called by sugov_update_single_freq() and
sugov_update_single_perf(). Both callers repeat the same pattern to first
test for uclamp and then the business. Let's refactor so that the tests
aren't repeated.

The new helper is named sugov_hold_freq() and tests both the uclamp
exception and CPU business. No functional changes. This will make adding
more exception conditions easier.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/cpufreq_schedutil.c | 38 +++++++++++++++-----------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index eece6244f9d2..972b7dd65af2 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -325,16 +325,27 @@ static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
-static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
+static bool sugov_hold_freq(struct sugov_cpu *sg_cpu)
 {
-	unsigned long idle_calls = tick_nohz_get_idle_calls_cpu(sg_cpu->cpu);
-	bool ret = idle_calls == sg_cpu->saved_idle_calls;
+	unsigned long idle_calls;
+	bool ret;
+
+	/* if capped by uclamp_max, always update to be in compliance */
+	if (uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)))
+		return false;
+
+	/*
+	 * Maintain the frequency if the CPU has not been idle recently, as
+	 * reduction is likely to be premature.
+	 */
+	idle_calls = tick_nohz_get_idle_calls_cpu(sg_cpu->cpu);
+	ret = idle_calls == sg_cpu->saved_idle_calls;
 
 	sg_cpu->saved_idle_calls = idle_calls;
 	return ret;
 }
 #else
-static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
+static inline bool sugov_hold_freq(struct sugov_cpu *sg_cpu) { return false; }
 #endif /* CONFIG_NO_HZ_COMMON */
 
 /*
@@ -382,14 +393,8 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
 		return;
 
 	next_f = get_next_freq(sg_policy, sg_cpu->util, max_cap);
-	/*
-	 * Do not reduce the frequency if the CPU has not been idle
-	 * recently, as the reduction is likely to be premature then.
-	 *
-	 * Except when the rq is capped by uclamp_max.
-	 */
-	if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
-	    sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq &&
+
+	if (sugov_hold_freq(sg_cpu) && next_f < sg_policy->next_freq &&
 	    !sg_policy->need_freq_update) {
 		next_f = sg_policy->next_freq;
 
@@ -436,14 +441,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 	if (!sugov_update_single_common(sg_cpu, time, max_cap, flags))
 		return;
 
-	/*
-	 * Do not reduce the target performance level if the CPU has not been
-	 * idle recently, as the reduction is likely to be premature then.
-	 *
-	 * Except when the rq is capped by uclamp_max.
-	 */
-	if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
-	    sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
+	if (sugov_hold_freq(sg_cpu) && sg_cpu->util < prev_util)
 		sg_cpu->util = prev_util;
 
 	cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_min,
-- 
2.44.0


