Return-Path: <bpf+bounces-16976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CAB807E2C
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 03:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C747B1C20B10
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 02:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F54D15C9;
	Thu,  7 Dec 2023 02:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZljeI4uY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D8BC3;
	Wed,  6 Dec 2023 18:05:23 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-286f8ee27aeso465977a91.3;
        Wed, 06 Dec 2023 18:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701914722; x=1702519522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qo8WdwTNE01KEbEBjzPvpUi0RD4zLVV6lNkHFrnKZ1g=;
        b=ZljeI4uYnVtEXHqiSv3/Exuoi+H8AEOOYQFeHqagHw8gJWMAgNixFhgNbQyyb61Gib
         yjyc+8uHFZNUl4JctNEJWWAEjASH0x8epGFro4Vyeyrg92OVl6zkMcQY4GDw2MBghktV
         S4Ghzqc7LKZNPHhBuCnTudm6qun43eilYyC+Etd6rxvFlwqRLxA4BQ5igydUGK5lCSTy
         3gd5inubmVmkzeUAXZG0tfSxCQQApfBsgx1hOq9lWSEQqKCTnGYQjYmcNOawvvo+PscB
         sQXTWZWZrUyDbawdee5ZEtYnjF0KtJFSL+R/1brPUJJB92kQPJqdMKDol1wooOGdBbPH
         NJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701914722; x=1702519522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qo8WdwTNE01KEbEBjzPvpUi0RD4zLVV6lNkHFrnKZ1g=;
        b=mnJwkQmFY2Q4ImbPJM7Gfw9s3j3AAmTvdGlW6uu3Td9vyo1kcO1ulWRtz/mkbgs62a
         EzCu66Ofzjl3S7nNWfmet4q+o5I5I6rRNd8qG/uzN2s0ldz+fdtP/ZCCl7uPg4cDntL1
         T4B3BM0TtSmR9MoOmWDF/vko5R8nwrnaaxwv+VDc2CWR6BJM46X8Zv+83/k+c/U17qDK
         nSmg/F9DoA2grMp/N4AHVV88ARbk7Yl9mgw0YwiBzpjA9Awj+Rl2dY06/Z4m7HpH0l+J
         SJoRwZEXVJjUYcZfnJoHD3I/ovQnbkLV/vjhmNk/sWcOAflN2OxsYn9xCHFc1Du/z84j
         grvw==
X-Gm-Message-State: AOJu0Yyjf0ZlNgNjL8qN+5LRyLB+LbM05+PcfQAd8pG8VzWjnCfJ+FHK
	3L99+RmoS5dJBbWtG5CkHyM=
X-Google-Smtp-Source: AGHT+IGYMVeRpcfNi8Y9ulOlJdsx/6z+qzU68LCGzzsOZ4/4C8xe5yon3k5U17LOU/GKs+aa3ZG2sQ==
X-Received: by 2002:a17:90b:4a4f:b0:285:ada5:956 with SMTP id lb15-20020a17090b4a4f00b00285ada50956mr1986916pjb.42.1701914722434;
        Wed, 06 Dec 2023 18:05:22 -0800 (PST)
Received: from localhost.localdomain ([61.253.179.202])
        by smtp.googlemail.com with ESMTPSA id u64-20020a17090a51c600b0028672a85808sm99011pjh.35.2023.12.06.18.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 18:05:22 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org
Cc: kernel-dev@igalia.com,
	andrea.righi@canonical.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	brho@google.com,
	bristot@redhat.com,
	bsegall@google.com,
	changwoo@igalia.com,
	daniel@iogearbox.net,
	derkling@google.com,
	dietmar.eggemann@arm.com,
	dschatzberg@meta.com,
	dskarlat@cs.cmu.edu,
	dvernet@meta.com,
	haoluo@google.com,
	himadrics@inria.fr,
	joshdon@google.com,
	juri.lelli@redhat.com,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	pjt@google.com,
	riel@surriel.com,
	rostedt@goodmis.org,
	torvalds@linux-foundation.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Subject: [PATCH] scx: set p->scx.ops_state using atomic_long_set_release
Date: Thu,  7 Dec 2023 11:04:59 +0900
Message-ID: <20231207020459.117365-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231111024835.2164816-13-tj@kernel.org>
References: <20231111024835.2164816-13-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

p->scx.ops_state should be updated using the release semantics,
atomic_long_set_release(), because it is read using
atomic_long_read_acquire() at ops_dequeue() and wait_ops_state().
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 53ee906aa2b6..3a40ca2007b6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -881,7 +881,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	qseq = rq->scx.ops_qseq++ << SCX_OPSS_QSEQ_SHIFT;
 
 	WARN_ON_ONCE(atomic_long_read(&p->scx.ops_state) != SCX_OPSS_NONE);
-	atomic_long_set(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);
+	atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);
 
 	ddsp_taskp = this_cpu_ptr(&direct_dispatch_task);
 	WARN_ON_ONCE(*ddsp_taskp);
-- 
2.43.0


