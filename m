Return-Path: <bpf+bounces-32438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD0790DE21
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB2B1F249E2
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11AB1849EA;
	Tue, 18 Jun 2024 21:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiHvZT4z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F82D17E46A;
	Tue, 18 Jun 2024 21:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745674; cv=none; b=D0eDg57ynZ2dbyDvHacxZSFffh+Mv6Z4qRnDmvhFTi9HVXtCFP+7BSadfuy230GQXW6s6W4DctDlFUelgI++4rf7tA8DzwvYclXxec27Uf4el9L7M5anv0chcs4bz20quanUqHFV2ssPr3Nhk5jzNRlHvVhiheJMLF29nLbZ6DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745674; c=relaxed/simple;
	bh=/q05x3PQIw09HAyXrpqER+B290zZsLmFxaHB0REXLys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fBw22w+zSslZedmVbKJb6MWvL/GC+Cs+wSHX4eHX5prLGMSk0GpgqY/zyg1joH9NBkG8LCJQ7PeI0RTaKu1pY1dDfjME2e5SlzN1KyTNXwtdyfFd3Ik6mCoTyV+H0Fuozx+zjsfkPIHAh54X6XE18K/9bBnh/H5FIsjsMVjFgzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiHvZT4z; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70625e8860cso677215b3a.2;
        Tue, 18 Jun 2024 14:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745672; x=1719350472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/TyX3rBp+hROYkurulQRQnmDmJPUUwoUGDxz6l1d/s=;
        b=KiHvZT4zMaxM5mX73GmTr1C5EwomU0pn7vsV76XdrfeA8OGD1/boZdYPD7GW2VnTtz
         O4975rTy39s2/jD2tuM2F6UXLVri0rPGc3NY2K5xEMQRIsEG6lGwTse7HZP6/GwpHvIX
         sh+0cx39XchNAKEC4KrllXmQasnrIbu5dhtSgfv06LDKEMTmWDoFz3hf7CjETEt4U0Z6
         Z/tJ4SiQDgndic/ny27IegVx1hRkem3tW0U5VC8tvTN4zYmmN9Yr5uiKSttYi8Njl8Nt
         J71QPq8hJYs/9KjcLD7Kj1p5DBWBzIlpaZ32jn+pKbFSjfUfQAh/SZJG3Y/Zj5j8QAqU
         msug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745672; x=1719350472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d/TyX3rBp+hROYkurulQRQnmDmJPUUwoUGDxz6l1d/s=;
        b=n3fwbHOy7MJTpl00JX6HT+6MukHSjV0fIG6rtFCssvJ630KXNiPcBYL8l+nTq1GwhF
         Zh2DQx9+35nnuoY5rnDAE380LuuRMqgosiJfq/7AwFKX20lFSnN3ZTo7mLrrj/sPBv0s
         qMPiNccVmAEYMWnlUfAt1s5nGWrpZaqTnIGO9ET/3D8GKa7Mg47zCvQP5ZAlDhC0ZSBJ
         WfAV6EXzWwk2I49ilE/JW+CYik1q6rVJcY1UYypc0GSQduddR9mKITB+HhvUyyPXdsar
         fmE80YSKnI7xJlOn8kopKDclMmRXaEutrtp/+4CtPi1HH0b+IgUXzwyfZzoKKsqJt1p9
         TJzg==
X-Forwarded-Encrypted: i=1; AJvYcCVpF6fAlXbDl0L3Nh5FyNIew0pDuHxTwz38OEi3zuS8zyHXMjQgionnuch/W/dUePN6dgg6C+zaqlsJBRoRWcBqGe53
X-Gm-Message-State: AOJu0YwOrJ+bpgJd8OF4ysqWbI92fV8hgpOranW3wcz8Ind69H61ivw7
	PCXJbGPDUQNrqi/MAmTM2xpv/D7tIVreTsnqAKN0ZBTmlQauLupn
X-Google-Smtp-Source: AGHT+IG3hHCSyP6nqHjoLjz6GNtEK5vWJosV7hYpXHX5itAHIlGbB+eJgz+eIN9qAun3SQ/ggm75zA==
X-Received: by 2002:a05:6a00:982:b0:705:b0aa:a6bf with SMTP id d2e1a72fcca58-70629c1f982mr1032460b3a.2.1718745671834;
        Tue, 18 Jun 2024 14:21:11 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3d268sm9371355b3a.101.2024.06.18.14.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:21:11 -0700 (PDT)
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
Subject: [PATCH 04/30] sched: Add sched_class->switching_to() and expose check_class_changing/changed()
Date: Tue, 18 Jun 2024 11:17:19 -1000
Message-ID: <20240618212056.2833381-5-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618212056.2833381-1-tj@kernel.org>
References: <20240618212056.2833381-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a task switches to a new sched_class, the prev and new classes are
notified through ->switched_from() and ->switched_to(), respectively, after
the switching is done.

A new BPF extensible sched_class will have callbacks that allow the BPF
scheduler to keep track of relevant task states (like priority and cpumask).
Those callbacks aren't called while a task is on a different sched_class.
When a task comes back, we wanna tell the BPF progs the up-to-date state
before the task gets enqueued, so we need a hook which is called before the
switching is committed.

This patch adds ->switching_to() which is called during sched_class switch
through check_class_changing() before the task is restored. Also, this patch
exposes check_class_changing/changed() in kernel/sched/sched.h. They will be
used by the new BPF extensible sched_class to implement implicit sched_class
switching which is used e.g. when falling back to CFS when the BPF scheduler
fails or unloads.

This is a prep patch and doesn't cause any behavior changes. The new
operation and exposed functions aren't used yet.

v3: Refreshed on top of tip:sched/core.

v2: Improve patch description w/ details on planned use.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 kernel/sched/core.c     | 12 ++++++++++++
 kernel/sched/sched.h    |  3 +++
 kernel/sched/syscalls.c |  1 +
 3 files changed, 16 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 48f9d00d0666..b088fbeaf26d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2035,6 +2035,17 @@ inline int task_curr(const struct task_struct *p)
 	return cpu_curr(task_cpu(p)) == p;
 }
 
+/*
+ * ->switching_to() is called with the pi_lock and rq_lock held and must not
+ * mess with locking.
+ */
+void check_class_changing(struct rq *rq, struct task_struct *p,
+			  const struct sched_class *prev_class)
+{
+	if (prev_class != p->sched_class && p->sched_class->switching_to)
+		p->sched_class->switching_to(rq, p);
+}
+
 /*
  * switched_from, switched_to and prio_changed must _NOT_ drop rq->lock,
  * use the balance_callback list if you want balancing.
@@ -7021,6 +7032,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	}
 
 	__setscheduler_prio(p, prio);
+	check_class_changing(rq, p, prev_class);
 
 	if (queued)
 		enqueue_task(rq, p, queue_flag);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a2399ccf259a..0ed4271cedf5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2322,6 +2322,7 @@ struct sched_class {
 	 * cannot assume the switched_from/switched_to pair is serialized by
 	 * rq->lock. They are however serialized by p->pi_lock.
 	 */
+	void (*switching_to) (struct rq *this_rq, struct task_struct *task);
 	void (*switched_from)(struct rq *this_rq, struct task_struct *task);
 	void (*switched_to)  (struct rq *this_rq, struct task_struct *task);
 	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,
@@ -3608,6 +3609,8 @@ extern void set_load_weight(struct task_struct *p, bool update_load);
 extern void enqueue_task(struct rq *rq, struct task_struct *p, int flags);
 extern void dequeue_task(struct rq *rq, struct task_struct *p, int flags);
 
+extern void check_class_changing(struct rq *rq, struct task_struct *p,
+				 const struct sched_class *prev_class);
 extern void check_class_changed(struct rq *rq, struct task_struct *p,
 				const struct sched_class *prev_class,
 				int oldprio);
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index ae1b42775ef9..cf189bc3dd18 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -797,6 +797,7 @@ int __sched_setscheduler(struct task_struct *p,
 		__setscheduler_prio(p, newprio);
 	}
 	__setscheduler_uclamp(p, attr);
+	check_class_changing(rq, p, prev_class);
 
 	if (queued) {
 		/*
-- 
2.45.2


