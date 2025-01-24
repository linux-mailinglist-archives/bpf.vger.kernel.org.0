Return-Path: <bpf+bounces-49661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8B0A1B30E
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 10:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2D216BBDE
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 09:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE9421B19E;
	Fri, 24 Jan 2025 09:51:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C497D21ADC7;
	Fri, 24 Jan 2025 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737712291; cv=none; b=qaDBMCrP5GW/cUNJIAaVIbMSXxyB+MEfFLFFgz96ss0pnUSMSbU6dnLOI24xBchiO7smUxUzumjNrsUw+FHcOTbvZFJebVTm32Y11gFUhYx5tt4xeDyASNNq/NgQVlY4WED6DIMqqGNCMqz/7ZhiOQP/FlmEz38inf6oB02Rmiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737712291; c=relaxed/simple;
	bh=bZqbviDVo+tQX0MjkUCssfDZLo3PNezHrIUpjDcDf18=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rAmkwEz4MCNqFLqVvQjJLjcQEWByApo6/pxmKayxpZ31jQPaNlNC9Sc7TVUpda7fAY7+N/OHcoxi7kLFASp7b+dhnqIQIs+vDgvMIOdrS5NVzBhr05zmgtxrHj6b3Uiyfigph1/e0JTi8N3gjcQwFEtjvMxZ3FWDEXjIXVMmTU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YfY2g12bQz1JJ34;
	Fri, 24 Jan 2025 17:50:19 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id A8DEB1402C4;
	Fri, 24 Jan 2025 17:51:21 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 24 Jan
 2025 17:51:20 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <mhiramat@kernel.org>, <oleg@redhat.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <andrii.nakryiko@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH v5 1/2] uprobes: Remove redundant spinlock in uprobe_deny_signal()
Date: Fri, 24 Jan 2025 09:38:25 +0000
Message-ID: <20250124093826.2123675-2-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124093826.2123675-1-liaochang1@huawei.com>
References: <20250124093826.2123675-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200013.china.huawei.com (7.221.188.133)

Since clearing a bit in thread_info is an atomic operation, the spinlock
is redundant and can be removed, reducing lock contention is good for
performance.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 kernel/events/uprobes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index e421a5f2ec7d..7a3348dfedeb 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2298,9 +2298,7 @@ bool uprobe_deny_signal(void)
 	WARN_ON_ONCE(utask->state != UTASK_SSTEP);
 
 	if (task_sigpending(t)) {
-		spin_lock_irq(&t->sighand->siglock);
 		clear_tsk_thread_flag(t, TIF_SIGPENDING);
-		spin_unlock_irq(&t->sighand->siglock);
 
 		if (__fatal_signal_pending(t) || arch_uprobe_xol_was_trapped(t)) {
 			utask->state = UTASK_SSTEP_TRAPPED;
-- 
2.34.1


