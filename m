Return-Path: <bpf+bounces-14830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2F07E887A
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF31D1C20A69
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0463B5667;
	Sat, 11 Nov 2023 02:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5bweeqH"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1DF15B8
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:49:28 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483E14792;
	Fri, 10 Nov 2023 18:49:15 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b20a48522fso2406781b3a.1;
        Fri, 10 Nov 2023 18:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699670954; x=1700275754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bD8ob5BNi7w3H3s+MdLZYFCJKwnrms/yugpSK6PL8jU=;
        b=l5bweeqHQHlULvSk3QcHKCU6Y6D7BQbdf77P0aJdzj6AaK+zPr3nRPzTPu9wbz4BnF
         Xbf9Ixb9xKXrC7fYGPpTdKGnj5+k5SPO23HZrso7UVCViV5GW8X+jMeLaij4DVJsT2XS
         krBx5bwInvY4sfbunIaMWszAM/nccwirhgwOki+CKx0b0C6UaYEX/bW1NhtXP/2cVK3K
         ttzg+Ww92UCrL6lShbdqVKm2PS352oM4e2IF+8AFUXmCIwDlA6aRVC8f8o6htMUoEv7S
         8BA8JMMdmtgnCfkjn1YnzmCZZzjjlUsrRPTXXHc8RUU0oLMVIa8t6/0J9Oz3bpQjZIeE
         D7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670954; x=1700275754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bD8ob5BNi7w3H3s+MdLZYFCJKwnrms/yugpSK6PL8jU=;
        b=h0RIK8u829n3MpAzAu3mRa/x0PN84ocKCYXiYAxDgyH+2RCq4hE8uBpupJuA0vRsXD
         V3238DcEYelckj0YNzilMSjBd3fHWN0LRbkloNKTPHz9t4nPXeb2lgJouxKPjUgvej7Z
         oQFZxnJzadIQtgQCD+SZHE93L/lsc/6xSNFaePQSShJhCrXlyu13vqbHv5Yk2oNICvS7
         /YuIqMge0/pksr5Xgn1tP2UBpfRF44w+atXkXDcOhYJIgMM9fKs3H9L18dFV1VWGH+0i
         z/j4220KGeKn3/T3meCHhf9+sOjRvzQi6MQ9fvXG6z0ZDM3Y6QpwFstZagbftoas35in
         70Cw==
X-Gm-Message-State: AOJu0Yy7q0wxx/8sZtz4rE5Kvd6FruvZNl9Mwk/MP1gxTt5XnKVnuWuH
	v78UI7eEnjePpnjb+qME0pA=
X-Google-Smtp-Source: AGHT+IFlNuVPLn+JeqXi6sfrCuSUQaU8w9gn8p8zO/cJoDWMimQcZIsSwZAkrJ3gsU2Co558QwsnrQ==
X-Received: by 2002:a05:6a00:2d1a:b0:68f:dd50:aef8 with SMTP id fa26-20020a056a002d1a00b0068fdd50aef8mr973892pfb.4.1699670953992;
        Fri, 10 Nov 2023 18:49:13 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id b17-20020aa78711000000b006c046a60580sm394615pfo.21.2023.11.10.18.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:49:13 -0800 (PST)
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
	memxor@gmail.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 10/36] sched: Add normal_policy()
Date: Fri, 10 Nov 2023 16:47:36 -1000
Message-ID: <20231111024835.2164816-11-tj@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111024835.2164816-1-tj@kernel.org>
References: <20231111024835.2164816-1-tj@kernel.org>
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
index bd9ff4fa77b8..c9ad47f0ec1f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8147,7 +8147,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	 * Batch and idle tasks do not preempt non-idle tasks (their preemption
 	 * is driven by the tick):
 	 */
-	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
+	if (unlikely(!normal_policy(p->policy)) || !sched_feat(WAKEUP_PREEMPTION))
 		return;
 
 	find_matching_se(&se, &pse);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d02ea254aa87..8474448d4125 100644
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
2.42.0


