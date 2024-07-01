Return-Path: <bpf+bounces-33541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C043791EADF
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83DEB282DCE
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 22:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14483171E40;
	Mon,  1 Jul 2024 22:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buzDRbzE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8667D84A2B;
	Mon,  1 Jul 2024 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719873582; cv=none; b=sivWsXVAu80gNw7fxFtT1dx/xSqHSDCm6Tj+dmmzOJIITlkqekPteJMl4TzD3oxodXvC1NREdFFPA9JiVWYASKCz94z2bTXEfNHSNtJothNjeLhtMq0bh6NTCeuaXekHXJKVEUHw415DpYYClTJ7CfEakPs8wEMh2fS6qtxqJXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719873582; c=relaxed/simple;
	bh=z0ddvbF8FumBOjGC+wG+fQgjyM9XIIz6hh6DhuruuXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjNqlf/c3Z8f/sLL6TfLCkxUFEW8JUErXqL01aLIXNXOPC4UerlELZq4umpRXUlsnbdTFmDAZ7gYud1wH6iWze6N94xdeUpIqaYnLSy5YdRkzfkIb408Dd/UBh6+IyeUTeDqJ+qODGqZylZsmYzrlLDy5b0tAZT7qOv66b2QV+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buzDRbzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AAAC116B1;
	Mon,  1 Jul 2024 22:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719873582;
	bh=z0ddvbF8FumBOjGC+wG+fQgjyM9XIIz6hh6DhuruuXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=buzDRbzELZOFGyr55dgbjmdweAF0jX2IQYK1aZvVPDeZmCYuV9Ha3K3mdYuRF8IR/
	 FEhw4+FyG8BCCCMKLAnQw9aCotaoXaGW2xpKeTAbvuKdwCNIon62yEzZ2QzqoyVGPF
	 KWj//OK2Tngcsj5uQO6vuT++DfvYALMNg0ohwlZJAJuM8D8aAb9ISRIUEHy5QWfQyf
	 sOByHcp5mcnJ4WxidS5KK80dKL2rNpe+40ZE7A8/eGIlOcmU9TM58wRvgxF8jN6Zpv
	 ybArGgEu2+zBxSwxi+pgCvBajOMKb4dio6jaX+s8na0jjLe0Qm3E6Q3HuEK24q+tJt
	 uHQtIRDC1D4TA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	oleg@redhat.com
Cc: peterz@infradead.org,
	mingo@redhat.com,
	bpf@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	clm@meta.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 01/12] uprobes: update outdated comment
Date: Mon,  1 Jul 2024 15:39:24 -0700
Message-ID: <20240701223935.3783951-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701223935.3783951-1-andrii@kernel.org>
References: <20240701223935.3783951-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no task_struct passed into get_user_pages_remote() anymore,
drop the parts of comment mentioning NULL tsk, it's just confusing at
this point.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 99be2adedbc0..081821fd529a 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2030,10 +2030,8 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
 		goto out;
 
 	/*
-	 * The NULL 'tsk' here ensures that any faults that occur here
-	 * will not be accounted to the task.  'mm' *is* current->mm,
-	 * but we treat this as a 'remote' access since it is
-	 * essentially a kernel access to the memory.
+	 * 'mm' *is* current->mm, but we treat this as a 'remote' access since
+	 * it is essentially a kernel access to the memory.
 	 */
 	result = get_user_pages_remote(mm, vaddr, 1, FOLL_FORCE, &page, NULL);
 	if (result < 0)
-- 
2.43.0


