Return-Path: <bpf+bounces-32441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFC990DE27
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509F31C23865
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0141891C9;
	Tue, 18 Jun 2024 21:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJlDXZ+O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF90188CAE;
	Tue, 18 Jun 2024 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745679; cv=none; b=n0vVI/W1VH/6xZ4xg81kz4G9rdJGaC+Bs4B3NGi3hmNAWPus1FiwM3X+T/kruNc1HQ3BeQB1seQjsBGF75NTFXf+z+7CJAfolsv5FAysuhxU3eibPHd1b/4SDJJsOQH7sfLYePd0JHECOI89zqlRnLEaJTYa5lGuPyNP4/WNbfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745679; c=relaxed/simple;
	bh=eyLMzXThEEkL+4JrapxN4r9MJ/HT1Cr0O0HNmHuNNmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJ5p54e+62RFVgO5AVWdeBm1hRaJS23MTf4DnBbh4d3Pb0BWvBK5TqMdyYDlpikomk9NurGWsNnv80m7AxBPW9BSsIUbdlmiS7cMheQvQn2vGO7G6mwbqkGyYi1DjK9UeK1W7vH6uR8dqfJip3FH4M4Zepm40sI3EHEkvrIE9Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJlDXZ+O; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70627716174so569797b3a.3;
        Tue, 18 Jun 2024 14:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745677; x=1719350477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9Mlph+ybRoxy8YEhv8EcHvzRd97S3PGfjrOwAY3g70=;
        b=EJlDXZ+OBToODf4+VT0tTFZfc2p1A2zVifVxcTMXInZDx+13DLCZIPHBNVHdroKhZS
         p3wKaeo9cD5bQyYA9gl3+Gopj/YOnkRP7O00x5uVd3wW0v/oWjVAxTGbQw9pzArpHynM
         ytm0NYmxy/tY4P4vpNETH2mLeH5/2HkUt55dqTY22tQ8DcDub1uPaHjTCo3zcYyygFe1
         RCU0NQ+axXeqGN0InG91T54/pTPeeUlDmCnNjAM2LXeYCBMlM0uRgLIOUBpNeARM6964
         m7rRNuH86D1+YwMpCtPn21qfd7szXBXk6EavLporgnUKJ2miRNRWQuvlRhUnjV9/KJ8Q
         DOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745677; x=1719350477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v9Mlph+ybRoxy8YEhv8EcHvzRd97S3PGfjrOwAY3g70=;
        b=iJtGPbH+xRxI0BEN7IRZly1JT5rJOrOnMHT46Til4IvB5VBGA449V0k3YiFzEnhBEg
         ElLWOmsDyZ0RltgMqA8xYQzediI7L1tNHiR2vwN46Irm98q8ZukgWcyAbTtqfn185Eno
         gwNA7Io+pwOjrtkhgR/s6Mlpjb5iqZsQT6opJachRls8V/MneH9rzNVpdbYpM9r7f/uo
         a/wJcMpD9JkoZ2XFEUIucu1/A8EB7LRUk26+X3cJ7lPYprVfsUaRrW7Z5Cs6l2w206MA
         PXkqvgRDHj++Zil02sHypuMIOydwy+oixYuIjApQl29XyIuMEYXMP8q/Sy2hPuptUgFy
         X5sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVijpiX1H3LxzqCm4QmXUw8Wb/eToAjpRGimyuLKpMMC6GdksyiecAoPjldSzE7+kWCPPyGUMDp0qHoivl+fwrXFZJ3
X-Gm-Message-State: AOJu0YyJnjM7GjMhemHoXa/0O6fwL/CcnlJQ2l7WS2z7qTFNSOBX/IH4
	ZCF+SLHteahP0KbBYtiRGhAH+VjSt7Lj3ln2Kx0BXME7Va/aODFx
X-Google-Smtp-Source: AGHT+IHwi8oUILqAuL4JcQVz5GVpdKZadtC/lqj20w2m+o2fQWkJBEgjD1usMyADN2FR/Kj/fqfZLg==
X-Received: by 2002:aa7:8208:0:b0:705:d8f5:765e with SMTP id d2e1a72fcca58-70629c17a95mr889773b3a.5.1718745677252;
        Tue, 18 Jun 2024 14:21:17 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb99f4dsm9364371b3a.216.2024.06.18.14.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:21:17 -0700 (PDT)
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
Subject: [PATCH 07/30] sched: Add normal_policy()
Date: Tue, 18 Jun 2024 11:17:22 -1000
Message-ID: <20240618212056.2833381-8-tj@kernel.org>
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
 kernel/sched/sched.h | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 715d7c1f55df..d59537416865 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8391,7 +8391,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	 * Batch and idle tasks do not preempt non-idle tasks (their preemption
 	 * is driven by the tick):
 	 */
-	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
+	if (unlikely(!normal_policy(p->policy)) || !sched_feat(WAKEUP_PREEMPTION))
 		return;
 
 	find_matching_se(&se, &pse);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a5a4f59151db..25660dc9f639 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -192,9 +192,14 @@ static inline int idle_policy(int policy)
 	return policy == SCHED_IDLE;
 }
 
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
2.45.2


