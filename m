Return-Path: <bpf+bounces-66203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B32B2F891
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 14:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 897BF6031EB
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 12:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4FA322C98;
	Thu, 21 Aug 2025 12:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JqvNJyoX"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3538D320CCC;
	Thu, 21 Aug 2025 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780171; cv=none; b=ku3EVpWkYJDR2MRy5YF2/i+q5puqQkRfTDAONLiO3xsQDR6pfPA8qug4bjqE9MvzxAdVBNFiz1hNnsTi5XBXueDgl8h/hnRbfNIWKSG2eFOvRTZUsLbdDiLoWZ1xoBwHb7ARaV2en6Ika8D5RW2U7MQ1+oaYI6dufoRE7kUBtoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780171; c=relaxed/simple;
	bh=DSCxnBqXlAjwBet02afoRqk6AmGkoQ+vOU3nqICgQCg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Z5LQqlHm8L7MMLl/ZIpH3q2HOrZ9utzCOOoFkX3Z3JzhYYfvGlSSKng1CL1i4GlSfKw/b3PVwbJ0TdKMJvcGwWm5Gp9Ofdsmhb3UVs0nFUCSVIXVYs3SgmTAgjuzsMBP31Di5nAktbEwFR4M2pkWGzEMQF9W8f5rrQbuHdrN414=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JqvNJyoX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=sYpPlJumgdW96JxSCoblEXM9Ih3+Uh4D/QbsVncvLxw=; b=JqvNJyoXGsq7iDrp5ymVPpRqXy
	2oL0ohe1mGPge36DHEE5SjraK3DA0fi5zczWoNcnJ/8hb+Y0UL4V3Lzv/GSC+p8LSkZEPqANvCPJX
	jtnLqF1IfpwoOsX0xMpYVZNGnCgzXgiJ8TTWatAdXfCiGUxjqZy69MpYvXZMsuPqg/pLich4VSK+X
	MH875ssYb2X5CAKyGVFTvsA9Ip+/p1r8UnJ+jBTiW3Q7Vu2oQ9WxkUo8ypxkUpZXMa1wnjKjrNvwd
	+BM+WIm5nVd/QIAZnPvikVbu9w0hvfneiBrObHdfq5TGVZuuJXk3nwTkjsZDWaEG5EJudvwpBVLRZ
	o4viswqw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up4cn-000000075gS-2lF7;
	Thu, 21 Aug 2025 12:42:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 91D42302E5F; Thu, 21 Aug 2025 14:42:37 +0200 (CEST)
Message-ID: <20250821123656.935559566@infradead.org>
User-Agent: quilt/0.68
Date: Thu, 21 Aug 2025 14:28:25 +0200
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
Subject: [PATCH 3/6] uprobes/x86: Accept more NOP forms
References: <20250821122822.671515652@infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Instead of only accepting the x86_64 nop5 chosen by the kernel, accept
any x86_64 NOP or NOPL instruction that is 5 bytes.

Notably, the x86_64 nop5 pattern is valid in 32bit apps and could get
compiler generated when build for i686 (which introduced NOPL). Since
the trampoline is x86_64 only, make sure to limit to x86_64 code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/uprobes.c |   37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1157,10 +1157,37 @@ void arch_uprobe_optimize(struct arch_up
 	mmap_write_unlock(mm);
 }
 
-static bool can_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
+static bool insn_is_nop(struct insn *insn)
 {
-	if (memcmp(&auprobe->insn, x86_nops[5], 5))
+	return insn->opcode.nbytes == 1 && insn->opcode.bytes[0] == 0x90;
+}
+
+static bool insn_is_nopl(struct insn *insn)
+{
+	if (insn->opcode.nbytes != 2)
+		return false;
+
+	if (insn->opcode.bytes[0] != 0x0f || insn->opcode.bytes[1] != 0x1f)
+		return false;
+
+	if (!insn->modrm.nbytes)
+		return false;
+
+	if (X86_MODRM_REG(insn->modrm.bytes[0]) != 0)
+		return false;
+
+	/* 0f 1f /0 - NOPL */
+	return true;
+}
+
+static bool can_optimize(struct insn *insn, unsigned long vaddr)
+{
+	if (!insn->x86_64 || insn->length != 5)
 		return false;
+
+	if (!insn_is_nop(insn) && !insn_is_nopl(insn))
+		return false;
+
 	/* We can't do cross page atomic writes yet. */
 	return PAGE_SIZE - (vaddr & ~PAGE_MASK) >= 5;
 }
@@ -1177,7 +1204,7 @@ static void riprel_pre_xol(struct arch_u
 static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 {
 }
-static bool can_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
+static bool can_optimize(struct insn *insn, unsigned long vaddr)
 {
 	return false;
 }
@@ -1539,15 +1566,15 @@ static int push_setup_xol_ops(struct arc
  */
 int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long addr)
 {
-	struct insn insn;
 	u8 fix_ip_or_call = UPROBE_FIX_IP;
+	struct insn insn;
 	int ret;
 
 	ret = uprobe_init_insn(auprobe, &insn, is_64bit_mm(mm));
 	if (ret)
 		return ret;
 
-	if (can_optimize(auprobe, addr))
+	if (can_optimize(&insn, addr))
 		set_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags);
 
 	ret = branch_setup_xol_ops(auprobe, &insn);



