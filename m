Return-Path: <bpf+bounces-36757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8A694CA5D
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 08:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79521283F98
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 06:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C17016D30B;
	Fri,  9 Aug 2024 06:19:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA25B3D6D;
	Fri,  9 Aug 2024 06:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723184361; cv=none; b=ToQJzZBBbY+MfEr+M+5hT+BFbAhtX1WgA8MvgtNzrqqxiBR0pMh09PAnXSVn5xBqMwsQ5lkAFmFf8yJ+mglRgHtaO5UUd13/M5Inwx+D8zp29+agEVWPR2aXwtl9msuqV5cOSsqDTlM49DnQf5eYwxjaGX5zPgvUR4C6vHkzWH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723184361; c=relaxed/simple;
	bh=nj2pyoZqJqmHJU2rzvoQJXs0NBPBSP422jfhghGWovU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Prvzh1Tdpw2S35NfPQgRNf0sun8MwGR+W05LKFok2CyNAcBKZJWbJF7dG1V76oLq2FsMfWx94omh6vpIYkqJ6voL4fg5vSGr1r3J/EtnNkgi7CYoFkZUfKcR35oISkExuxjWmfXwVw2IxGdef2ku9xf5YED42cJwNUu8oxmMplk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WgDGZ1xZPz3743B;
	Fri,  9 Aug 2024 14:17:26 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 59A7718002B;
	Fri,  9 Aug 2024 14:19:15 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 9 Aug
 2024 14:19:14 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <mhiramat@kernel.org>, <oleg@redhat.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <andrii@kernel.org>, <rostedt@goodmis.org>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH v2 1/2] uprobes: Remove redundant spinlock in uprobe_deny_signal()
Date: Fri, 9 Aug 2024 06:10:03 +0000
Message-ID: <20240809061004.2112369-2-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809061004.2112369-1-liaochang1@huawei.com>
References: <20240809061004.2112369-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200013.china.huawei.com (7.221.188.133)

Since clearing a bit in thread_info is an atomic operation, the spinlock
is redundant and can be removed, reducing lock contention is good for
performance.

Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 kernel/events/uprobes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 73cc47708679..76a51a1f51e2 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1979,9 +1979,7 @@ bool uprobe_deny_signal(void)
 	WARN_ON_ONCE(utask->state != UTASK_SSTEP);
 
 	if (task_sigpending(t)) {
-		spin_lock_irq(&t->sighand->siglock);
 		clear_tsk_thread_flag(t, TIF_SIGPENDING);
-		spin_unlock_irq(&t->sighand->siglock);
 
 		if (__fatal_signal_pending(t) || arch_uprobe_xol_was_trapped(t)) {
 			utask->state = UTASK_SSTEP_TRAPPED;
-- 
2.34.1


