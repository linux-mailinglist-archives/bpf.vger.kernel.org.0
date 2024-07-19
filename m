Return-Path: <bpf+bounces-35086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 080E0937858
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 15:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4951F22C64
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 13:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9EA13F458;
	Fri, 19 Jul 2024 13:18:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0188085283;
	Fri, 19 Jul 2024 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721395090; cv=none; b=qiVXjWN2VvTUOqSdcoiMU1mHc2iXEy77c3sKYPzp9en4SzF4queOc/MyE8KmVr0cNUhc0DOkMbuZhg1J2gcrT3Io6dWrJJJqh4gH4mdcVQ1IMMP4tBJubmGtGo1Za7GmNOV+MyzkTccNnoeHlTrb5Dy0R8sidf/v3J542F3NYBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721395090; c=relaxed/simple;
	bh=6Yf1a4CqCvgyHibq+QJ66enVOigVRsT4lUW7P+j1EnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=IuXvfEBxbEm8quGldCS6y4AgQwXpXnlagy2udXuh/4E3btxKeATZN9R+31nyN+/RvNt+mFd1Kjpik14H+nrEcv54O0MDjH3JUgwGUzfEU0uyVLiZrZNCaJqw5gswsglQzSU8nNBSVultYUZH+7fdhiRCrUyGY6N42r13m6yrn8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 46JDH2Fn077284;
	Fri, 19 Jul 2024 22:17:02 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Fri, 19 Jul 2024 22:17:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 46JDH1Qj077278
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 19 Jul 2024 22:17:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <94c1499a-2325-4bbf-b7bc-04a1e9090488@I-love.SAKURA.ne.jp>
Date: Fri, 19 Jul 2024 22:17:01 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH (repost)] sched/core: defer printk() while rq lock is held
To: syzbot <syzbot+18cfb7f63482af8641df@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <0000000000008881c5061d28e041@google.com>
Content-Language: en-US
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        netdev@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net,
        Steven Rostedt <rostedt@goodmis.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0000000000008881c5061d28e041@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

syzbot is reporting circular locking dependency inside __bpf_prog_run()
when trace_sched_switch() hook is called from __schedule(), for fault
injection calls printk() despite rq lock is already held.

Since any debugging functionality such as lockdep, fault injection,
KASAN/KCSAN/KMSAN etc. might call printk(), guard the whole section
between raw_spin_rq_{lock,lock_nested,trylock}() and raw_spin_rq_unlock()
using printk_deferred_{enter,exit}().

Reported-by: syzbot <syzbot+18cfb7f63482af8641df@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=18cfb7f63482af8641df
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
This is a repost of https://lkml.kernel.org/r/b55e5f24-01ad-4a3d-94dc-e8a6bc15ac42@I-love.SAKURA.ne.jp .
Scheduler developers, can you agree with addressing this problem at locations where rq lock is held?

 kernel/sched/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bcf2c4cc0522..134f5196b9c4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -559,6 +559,7 @@ void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
 		raw_spin_lock_nested(&rq->__lock, subclass);
 		/* preempt_count *MUST* be > 1 */
 		preempt_enable_no_resched();
+		printk_deferred_enter();
 		return;
 	}
 
@@ -568,6 +569,7 @@ void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
 		if (likely(lock == __rq_lockp(rq))) {
 			/* preempt_count *MUST* be > 1 */
 			preempt_enable_no_resched();
+			printk_deferred_enter();
 			return;
 		}
 		raw_spin_unlock(lock);
@@ -584,6 +586,8 @@ bool raw_spin_rq_trylock(struct rq *rq)
 	if (sched_core_disabled()) {
 		ret = raw_spin_trylock(&rq->__lock);
 		preempt_enable();
+		if (ret)
+			printk_deferred_enter();
 		return ret;
 	}
 
@@ -592,6 +596,8 @@ bool raw_spin_rq_trylock(struct rq *rq)
 		ret = raw_spin_trylock(lock);
 		if (!ret || (likely(lock == __rq_lockp(rq)))) {
 			preempt_enable();
+			if (ret)
+				printk_deferred_enter();
 			return ret;
 		}
 		raw_spin_unlock(lock);
@@ -600,6 +606,7 @@ bool raw_spin_rq_trylock(struct rq *rq)
 
 void raw_spin_rq_unlock(struct rq *rq)
 {
+	printk_deferred_exit();
 	raw_spin_unlock(rq_lockp(rq));
 }
 
-- 
2.43.0


