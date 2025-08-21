Return-Path: <bpf+bounces-66204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26855B2F892
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 14:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40783603BC0
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 12:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A3E322DD9;
	Thu, 21 Aug 2025 12:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DeWNRATK"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F2C320CC7;
	Thu, 21 Aug 2025 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780171; cv=none; b=Bdnpz5ecsutESP9x6JhOqxDHfXLV9kRMLEk3tKpjXgy0oLFqGbA6g9uzJxDunk8XW6hrldXJSBBcsRvawa+udypMf7yhoM5i+y8Y7w3FMRae8oV6QiuxEOqMTLoMa6Q0yXuSfiU1WI0Cj3Dw8PVi3bUAzg99gDdpC9vjqWzDSyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780171; c=relaxed/simple;
	bh=TaRH99rt334n31pVTVnJJSZiKxpreeOtyJH2Uj+N3vU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=NaDjgY0dNONtFO8pqyLBh++c7S2Lyrbd7Oz2hcxMd6LaHgs/P7rqG/P2ckwEFB4ES0xNcpVw4PO3nHVdD29zTLjRsUaJ2QxvJAymA8pE0G4G2R3SWox43ya5tE/a7tyUzjMTC7oU7RoPCx0g0uVgaK2y1A/xas8Xs5AC+JvFB+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DeWNRATK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=v5IBmCyX7FHgg78Lka775Rmw7i2/O/zrHJ4DZcZBDXM=; b=DeWNRATK6vJLgggrQW6WLopcV2
	q8/brORqIuusc1quz7WXjwHH/PPPNMNw3ZLUE2W4xRAxMzgkOdWqgwK6j9D1FWevNI2VoE1kNqZrt
	qPo9HUKOfMJ+S4HD57z6ZiWqFSn2CurOTl42vX4UIIby1sun4/K3c1CssJA2qprhRPCMUoiUTDlzk
	RF+jfM7Jxdb4HmReLul+BZ738RW0T8oKJ6G1Z3PlJVC88mr2ArAPRFXs7SXMlSYeDihf23AAdT424
	/CkRHbd3Ysd8KObKtPpD3ZzJXbypIZe6vAH8dsKqEI+UOTvS6ankSOHh7Mj8Bbbpln45hOM6M5H/F
	5W/X/DKg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up4cn-000000075gQ-2lZA;
	Thu, 21 Aug 2025 12:42:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 8DCD1302DA9; Thu, 21 Aug 2025 14:42:37 +0200 (CEST)
Message-ID: <20250821123656.823296198@infradead.org>
User-Agent: quilt/0.68
Date: Thu, 21 Aug 2025 14:28:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: jolsa@kernel.org,
 oleg@redhat.com,
 andrii@kernel.org,
 mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 alx@kernel.org,
 eyal.birger@gmail.com,
 kees@kernel.org,
 bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 x86@kernel.org,
 songliubraving@fb.com,
 yhs@fb.com,
 john.fastabend@gmail.com,
 haoluo@google.com,
 rostedt@goodmis.org,
 alan.maguire@oracle.com,
 David.Laight@ACULAB.COM,
 thomas@t-8ch.de,
 mingo@kernel.org,
 rick.p.edgecombe@intel.com
Subject: [PATCH 2/6] uprobes/x86: Optimize is_optimize()
References: <20250821122822.671515652@infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Make is_optimized() return a tri-state and avoid return through
argument. This simplifies things a little.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/uprobes.c |   34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1047,7 +1047,7 @@ static bool __is_optimized(uprobe_opcode
 	return __in_uprobe_trampoline(vaddr + 5 + call->raddr);
 }
 
-static int is_optimized(struct mm_struct *mm, unsigned long vaddr, bool *optimized)
+static int is_optimized(struct mm_struct *mm, unsigned long vaddr)
 {
 	uprobe_opcode_t insn[5];
 	int err;
@@ -1055,8 +1055,7 @@ static int is_optimized(struct mm_struct
 	err = copy_from_vaddr(mm, vaddr, &insn, 5);
 	if (err)
 		return err;
-	*optimized = __is_optimized((uprobe_opcode_t *)&insn, vaddr);
-	return 0;
+	return __is_optimized((uprobe_opcode_t *)&insn, vaddr);
 }
 
 static bool should_optimize(struct arch_uprobe *auprobe)
@@ -1069,17 +1068,14 @@ int set_swbp(struct arch_uprobe *auprobe
 	     unsigned long vaddr)
 {
 	if (should_optimize(auprobe)) {
-		bool optimized = false;
-		int err;
-
 		/*
 		 * We could race with another thread that already optimized the probe,
 		 * so let's not overwrite it with int3 again in this case.
 		 */
-		err = is_optimized(vma->vm_mm, vaddr, &optimized);
-		if (err)
-			return err;
-		if (optimized)
+		int ret = is_optimized(vma->vm_mm, vaddr);
+		if (ret < 0)
+			return ret;
+		if (ret)
 			return 0;
 	}
 	return uprobe_write_opcode(auprobe, vma, vaddr, UPROBE_SWBP_INSN,
@@ -1090,17 +1086,13 @@ int set_orig_insn(struct arch_uprobe *au
 		  unsigned long vaddr)
 {
 	if (test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags)) {
-		struct mm_struct *mm = vma->vm_mm;
-		bool optimized = false;
-		int err;
-
-		err = is_optimized(mm, vaddr, &optimized);
-		if (err)
-			return err;
-		if (optimized) {
-			err = swbp_unoptimize(auprobe, vma, vaddr);
-			WARN_ON_ONCE(err);
-			return err;
+		int ret = is_optimized(vma->vm_mm, vaddr);
+		if (ret < 0)
+			return ret;
+		if (ret) {
+			ret = swbp_unoptimize(auprobe, vma, vaddr);
+			WARN_ON_ONCE(ret);
+			return ret;
 		}
 	}
 	return uprobe_write_opcode(auprobe, vma, vaddr, *(uprobe_opcode_t *)&auprobe->insn,



