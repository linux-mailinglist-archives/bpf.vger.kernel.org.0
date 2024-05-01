Return-Path: <bpf+bounces-28342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCBF8B8C92
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC71F283D58
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED07D13175A;
	Wed,  1 May 2024 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQXtWmHf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233CC13172B;
	Wed,  1 May 2024 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576423; cv=none; b=PNTie+wjK3QEuQYyQYiHR6P+7JPrWsrxwfCd0y4iJv4mSaRxL3dQD+wbgNptj6jaLq43J+W1vghiY4ONyw5uGyVKURYhYkOXEsKGdNZFwf7jSCWGrZAPOlAcKPQ9s0/CrRaybazj4BpgyTCxqD16webazgc4IgO3JFenVoEkhuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576423; c=relaxed/simple;
	bh=umYW4kgVZzhjRxdAvIvjder0SddTGsWPe+tkqV8xgc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRTAShAfJ3cf6oAYKYYoQTQR/CMjycCBkM78Buu+Uc3fkPeni5jiTW+7X5Ec8LXTbIglEp7j2PCLjEHczhU/NPprHERyBA9ivpMiotRA7LIc4OGZyqtElm2dOT3kiheTtjyYOKmNzLVrnE3hAk/t9f+KEL2wiqF9cAyGcLyl2Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQXtWmHf; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e9ffd3f96eso56155685ad.3;
        Wed, 01 May 2024 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576421; x=1715181221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+Xr7LOTbeBKdnIhloNSsZOexImckDjxZ7O5dDt1M8s=;
        b=CQXtWmHf0NPCgujVVRUT85C0ud+swKQh0VwbYeRhL68Pa4U7HUDo9Qcho/U1R7gLdD
         Db2Ngmm60kAkuktsUUpCKYEMaGcPx7y3ioRx9ttbnhOrjBzCRG8gtpMeezRKQEuqN9mF
         2U040cil5W/xYgCpJKuH+QnSUy8LLu9qL4ia9g2/1HfInFEW72LksxNiD6Fko2PF5FnT
         ShiIv7vbgosOoU4kd+Tb7QAElKbmXY4L7LNBubaVyvKXVXpSiYKspFPoWjymRUb8eGOL
         67l34h+ZrNWTfWD3yjEmMkqRh1TIIsi78ns/jQdJDC018t/OPRqSgv68lyS/aQJyF+78
         nM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576421; x=1715181221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z+Xr7LOTbeBKdnIhloNSsZOexImckDjxZ7O5dDt1M8s=;
        b=pXXftzOjgDxiERKZEcuEcqfaODyH77wFKGQ1HdaCnv0180TbYN10WxDjrYz08/C6ZO
         a3//46svHJ+ADfZLBKezsfGsDUb0Z+RblylArRoJHOLhMDiJHghUWHcWAK9o0RNQssm4
         ZkdG/dHMT8NiyNeFKm7XNGWgcT38En1SHIuZlMTJa24a5QseovlhwfZmNCLmnxcbhJ8N
         O9mhY4jVaYiXhsE957Khjjk+zqlKv8vGdSNp4+KOeS6DDJswQyOexKUUroRQG1c885aa
         eOAk2k9DfellRrHMcxhOXTnnbCwX6GpnwBYyBh+eesXYgGQeDcjGEXcTqQaXqsxVCp5L
         5IEg==
X-Forwarded-Encrypted: i=1; AJvYcCXb/3qKxfg5YOClaTVyObloeTtz/qgUwd1yXlsSykQ26vYHfTMiMIOlwe34habAS6uEHdLCU58RSX1T4Rz2wdzEEHYj
X-Gm-Message-State: AOJu0Yzd45mrTR9g2lIGYnQJCVLd+dil5Cm9ZLd6lTsQ/nG23cg5llYO
	oUHd4acXKDHosLMAcM/DMIipD+plM43K4FbCz6Ue8CSbNhK3xRMp
X-Google-Smtp-Source: AGHT+IHOCSVtJ4T6Au/O5pepeAJna0v6BFEIHeuSVuW7v40q6FIZ/rvfe/z6Vjb8a+O6KU+ZPPMuwQ==
X-Received: by 2002:a17:902:b497:b0:1e8:9f46:c1af with SMTP id y23-20020a170902b49700b001e89f46c1afmr2467653plr.63.1714576421322;
        Wed, 01 May 2024 08:13:41 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902db0200b001ea02c8412asm16099414plx.119.2024.05.01.08.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:13:40 -0700 (PDT)
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
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 12/39] sched: Add normal_policy()
Date: Wed,  1 May 2024 05:09:47 -1000
Message-ID: <20240501151312.635565-13-tj@kernel.org>
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

A new BPF extensible sched_class will need to dynamically change how a task
picks its sched_class. For example, if the loaded BPF scheduler progs fail,
the tasks will be forced back on CFS even if the task's policy is set to the
new sched_class. To support such mapping, add normal_policy() which wraps
testing for %SCHED_NORMAL. This doesn't cause any behavior changes.

v2: Update the description with more details on the expected use.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 kernel/sched/fair.c  | 2 +-
 kernel/sched/sched.h | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 51301ae13725..8a9b2e95d06b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8322,7 +8322,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	 * Batch and idle tasks do not preempt non-idle tasks (their preemption
 	 * is driven by the tick):
 	 */
-	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
+	if (unlikely(!normal_policy(p->policy)) || !sched_feat(WAKEUP_PREEMPTION))
 		return;
 
 	find_matching_se(&se, &pse);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ccf2fff0e2ae..11b4345d2638 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -171,9 +171,15 @@ static inline int idle_policy(int policy)
 {
 	return policy == SCHED_IDLE;
 }
+
+static inline int normal_policy(int policy)
+{
+	return policy == SCHED_NORMAL;
+}
+
 static inline int fair_policy(int policy)
 {
-	return policy == SCHED_NORMAL || policy == SCHED_BATCH;
+	return normal_policy(policy) || policy == SCHED_BATCH;
 }
 
 static inline int rt_policy(int policy)
-- 
2.44.0


