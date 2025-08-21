Return-Path: <bpf+bounces-66202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD837B2F88F
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 14:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005206059DF
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 12:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CB7322C86;
	Thu, 21 Aug 2025 12:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TNb+GwI3"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35414320CD0;
	Thu, 21 Aug 2025 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780171; cv=none; b=m3DPv9wKxRI4C9/Owim6W876lHEKSHDsM/DI9ODOCr0hL7GcSc5Da39uDYItl74bfAW+n97NPoubv/nUHTMIV/ERUDaMQ7zcS6OtsVtFWcwKdnrW3IMCqZjxDAVy4zjlsw1L3pS/JOC2H4SiDPI2NUfE7+0A6N9aaiWIT4wVpbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780171; c=relaxed/simple;
	bh=GKQWt6HCwxPBe3xBtOLxXC0NieLPfmFa+AwEWkXDNuE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=cH5vtYJHU3CsHBuvxBkC90KazXBwrw2mhdRKRozuayO58OleAOYddiRibRYOyi4oxGOY1q+2eLTpsa/dlx3UpoHeqOl4h0pkmGrmtsfiAAGedi3FNZHXEHaoXP4elhkLeoF8PGYAM8wvUSDt0vClMDlshE1yibB5zw3fKHIgjmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TNb+GwI3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=yHvX80/S5wM5H42vWbAlSWklnG143m/4pBgyGGy+vjM=; b=TNb+GwI3IqbDOi+JiexIZm0s+s
	Lsud/ypc5SSHcv4XhB+AAgj/0QmW2GRUh4RkVwmaf0zIK1YyNV8juKGR1QlZKbbA3QGwAD1awUrPq
	TrWpJezJ+CXRKAin7gLB7geEfbp56ivQssMxgD2kcvRwL+KNwGYnYwmIVL1t7DgDfMdDKtLinox4D
	11C3/vIIPNjQSkmo07LEJuUG9QwPsqAYwRMyb1uLo1fWTCWwfuAu0+A+X+300N3AwqUJECHJYhKK1
	ngyQc9DlyoCZzpqcAIAWbrsrbhHSWVhU0+SJA8LX93OkUmNL9cW7xwl1pZ2MSYj7JhoTcQP3uBH+E
	27v3OvKw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up4co-000000075hO-1RZI;
	Thu, 21 Aug 2025 12:42:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 99FF3302EA6; Thu, 21 Aug 2025 14:42:37 +0200 (CEST)
Message-ID: <20250821123657.163417243@infradead.org>
User-Agent: quilt/0.68
Date: Thu, 21 Aug 2025 14:28:27 +0200
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
Subject: [PATCH 5/6] uprobes/x86: Make asm style consistent
References: <20250821122822.671515652@infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

The asm syntax in uretprobe_trampoline and uprobe_trampoline differs
in the use of operand size suffixes. Make them consistent and remove
all size suffixes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/uprobes.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -321,21 +321,21 @@ asm (
 	".pushsection .rodata\n"
 	".global uretprobe_trampoline_entry\n"
 	"uretprobe_trampoline_entry:\n"
-	"pushq %rax\n"
-	"pushq %rcx\n"
-	"pushq %r11\n"
-	"movq $" __stringify(__NR_uretprobe) ", %rax\n"
+	"push %rax\n"
+	"push %rcx\n"
+	"push %r11\n"
+	"mov $" __stringify(__NR_uretprobe) ", %rax\n"
 	"syscall\n"
 	".global uretprobe_syscall_check\n"
 	"uretprobe_syscall_check:\n"
-	"popq %r11\n"
-	"popq %rcx\n"
+	"pop %r11\n"
+	"pop %rcx\n"
 	/*
 	 * The uretprobe syscall replaces stored %rax value with final
 	 * return address, so we don't restore %rax in here and just
 	 * call ret.
 	 */
-	"retq\n"
+	"ret\n"
 	".global uretprobe_trampoline_end\n"
 	"uretprobe_trampoline_end:\n"
 	".popsection\n"
@@ -885,7 +885,7 @@ asm (
 	"push %rcx\n"
 	"push %r11\n"
 	"push %rax\n"
-	"movq $" __stringify(__NR_uprobe) ", %rax\n"
+	"mov $" __stringify(__NR_uprobe) ", %rax\n"
 	"syscall\n"
 	"pop %rax\n"
 	"pop %r11\n"



