Return-Path: <bpf+bounces-46217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 713A19E6226
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 01:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326C2282B74
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 00:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F0376048;
	Fri,  6 Dec 2024 00:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOcOKAPu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950E749641;
	Fri,  6 Dec 2024 00:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733444672; cv=none; b=kv5ySbflr+m4xu1G4STYJE+cAQnN/W+kWQJOl/PKTlwwLv0Xj9lf5Flu5eDiYToYhzKirtFUZgyuBRh8dDuYX4VQ3FB0Ic0yp6pZ4kOPiToNQxZXwDISeQxdvt5RAUk6DfvM1vKLoIbugreeOPD2RoUVX+u/jd0JOuo79SUqT3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733444672; c=relaxed/simple;
	bh=/AvOE79WU2t/nI/L+G7GYlCVJATmYhJV0HV3QQ3Ahjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgDKyMuG+rPZgBFCr+yWfeaeRPJ8CRdrSUTCYAxrQDiOAh8W0ctI2z/riCxGg7e9ejYYxGWpANMAeQeVTONZ13wllq64pSbvsZbFN5fBpQBT/W/l76IOlw9ceoZTsoP6rZel5xC9N4mtW4LzHBGA5Xp2xrslHWc1PVTYIxVAKwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOcOKAPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184ACC4CED1;
	Fri,  6 Dec 2024 00:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733444672;
	bh=/AvOE79WU2t/nI/L+G7GYlCVJATmYhJV0HV3QQ3Ahjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hOcOKAPudIvndCzU+/boZ7QcqQqafDfGtcZ+vyFF5M5Mmd5UDg4Cj/qATfFF948r6
	 +U0ITR6O5KPyu2iSwUsLecLao4fB1b8kjHbGOTfsXt/PjGlNuQ5/Ou/jABHwWE1UVv
	 g5BdzhCCJzvw6nTCaq6SYpFzuVCVt9sr1khaakZhiDNQOXcVJza/xfmXFMmdLhhYml
	 ZKXr2VW1pBSucXejxChLfIHk5Y+aSUl0QwzdJ8xGL8YoU1UUYgA+7r5WhOIhZIEcp/
	 O0rxvLoPUXAUDKgN4oUoJ+fqO3tTXSj6kX4vvM0at2XS7f4Rkx/LEOa7wINDw6ekj5
	 DWTimiijVtWTw==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	mingo@kernel.org
Cc: oleg@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	liaochang1@huawei.com,
	kernel-team@meta.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH perf/core 3/4] uprobes: ensure return_instance is detached from the list before freeing
Date: Thu,  5 Dec 2024 16:24:16 -0800
Message-ID: <20241206002417.3295533-4-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241206002417.3295533-1-andrii@kernel.org>
References: <20241206002417.3295533-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that by the time we call free_ret_instance() to clean up an
instance of struct return_instance it isn't reachable from
utask->return_instances anymore.

free_ret_instance() is called in a few different situations, all but one
of which already are fine w.r.t. return_instance visibility:
  - uprobe_free_utask() guarantees that ri_timer() won't be called
    (through timer_delete_sync() call), and so there is no need to
    unlink anything, because entire utask is being freed;
  - uprobe_handle_trampoline() is already unlinking to-be-freed
    return_instance with rcu_assign_pointer() before calling
    free_ret_instance().

Only cleanup_return_instances() violates this property, which so far is
not causing problems due to RCU-delayed freeing of return_instance,
which we'll change in the next patch. So make sure we unlink
return_instance before passing it into free_ret_instance(), as otherwise
reuse will be unsafe.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index cca1fe4a3fb1..2345aeb63d3b 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2116,12 +2116,12 @@ static void cleanup_return_instances(struct uprobe_task *utask, bool chained,
 
 	while (ri && !arch_uretprobe_is_alive(ri, ctx, regs)) {
 		ri_next = ri->next;
+		rcu_assign_pointer(utask->return_instances, ri_next);
 		utask->depth--;
 
 		free_ret_instance(ri, true /* cleanup_hprobe */);
 		ri = ri_next;
 	}
-	rcu_assign_pointer(utask->return_instances, ri);
 }
 
 static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs,
-- 
2.43.5


