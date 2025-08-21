Return-Path: <bpf+bounces-66201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD08B2F89E
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 14:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3801A188961F
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 12:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700D4322C75;
	Thu, 21 Aug 2025 12:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rd2tNdTr"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FBD3112D7;
	Thu, 21 Aug 2025 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780170; cv=none; b=Elo2WXMiIkkfHuyFpqPcnjL/lLBz/odV6I3sq1BdFj2wH2q0YjpCOtZzCNkuqjp2in6AxSmT25SYNjOymS/OgYPj2kvnHDt1T3l7WcpaxDKxTMBJt/Fsn6lbIjBw262gfgcn1UWlIbQj02y2oUUx+ZbsoGjxtLKA4FbUDT3qXy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780170; c=relaxed/simple;
	bh=diK4GdqSYOrMkc1PLXgYj9NZFB7FD5b1HcE9HTWHCYg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=IrjjmDDeaDqZcw1WIgBhrakssKaxKYimB/E4RRo58KWmhBCg0PKd/colNroQ68IQNXZILfTj1ukZ2N9YEWrew/rBgv948nW4QsnF5VzLZiSito8jxxslW8Dmjn6t5Lixq6MNqWlTl2K5llYXlOkhGJOr+Ww0wvaK7INYblgiUaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rd2tNdTr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=nNty9DGaBRq1520f2c0+eIPDHwMGQWX/BIKoK9+6HOs=; b=rd2tNdTrVZnnAdrN8chRZLF18T
	Znxs3JqKnHHcPjUG2fLMN58eitM7CUQzByijcXFGMPNEzByj09bge9RUOd5pBsa3Cqj3DbPMUArwA
	JBwGlHCQykIL9bg+qIeo5Me5a5Lrx8X3JBymRiLRGsllCI6Iw/E2Kh7pvAxVDIHWuhKGt+CY7jHZC
	a0GN3UYq4QCfNZPJZ7LTbSl9kxRrtakz0DfIgLipKUwdUZFpqiYqP2XGQypjN4e5MJw8IOh54DUMP
	HoWaO/dQwk3FXJUrzVXad8+ySjiUF0Qad2otjoXuFs7K5dfk+4hSXWDS8r2hmIHHWCpiZMScwKjMo
	mN+GRjHg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up4co-000000075hP-1Q0x;
	Thu, 21 Aug 2025 12:42:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 9DFFD302EC2; Thu, 21 Aug 2025 14:42:37 +0200 (CEST)
Message-ID: <20250821123657.277506098@infradead.org>
User-Agent: quilt/0.68
Date: Thu, 21 Aug 2025 14:28:28 +0200
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
Subject: [PATCH 6/6] uprobes/x86: Add SLS mitigation to the trampolines
References: <20250821122822.671515652@infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

It is trivial; no reason not to.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/uprobes.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -336,6 +336,7 @@ asm (
 	 * call ret.
 	 */
 	"ret\n"
+	"int3\n"
 	".global uretprobe_trampoline_end\n"
 	"uretprobe_trampoline_end:\n"
 	".popsection\n"
@@ -891,6 +892,7 @@ asm (
 	"pop %r11\n"
 	"pop %rcx\n"
 	"ret\n"
+	"int3\n"
 	".balign " __stringify(PAGE_SIZE) "\n"
 	".popsection\n"
 );



