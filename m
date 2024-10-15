Return-Path: <bpf+bounces-42096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7667799F900
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 23:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D71283CC4
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 21:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B1A1FBF72;
	Tue, 15 Oct 2024 21:24:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD531FAEFE;
	Tue, 15 Oct 2024 21:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729027445; cv=none; b=F6RxHPtjjmbmCduqHBcSU1wmaG/OCH4R91wFMLgX1H9K+8ptf1iag5GgBaJ4ggFGbQmgdpOiN94PeDHbrVQ+APWhncty+C0jV84ojAx/sKCxj/z2EDYd0+rwbs4mnR613ig8uzlqKu8lmJJ7GAGNkIm/LEjOF8oY5QBJImJLPgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729027445; c=relaxed/simple;
	bh=EYWUVATKArZD69rRd6A6/hL+eORzGSXJYgqfPoXLHCk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=cikfvqATM0KWlpy7RIuGYw+ptoTJntEaXwMdUS4N5QJ8DETSownxTqd07ujkPGUcJLtmI742BwgvybBWDdyg1nPOknVe6C/rEfa9gh+C4/eCx2jYmNpIaf0aYYdQPwkGSOHkYwId7QH8MZgsD01+ATwneVQRxnf9wakzFmCu0DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD63C4CECE;
	Tue, 15 Oct 2024 21:24:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t0p1k-00000003508-2WwM;
	Tue, 15 Oct 2024 17:24:24 -0400
Message-ID: <20241015212424.463508437@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 15 Oct 2024 17:24:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>
Subject: [for-next][PATCH 1/3] ftrace: Use arch_ftrace_regs() for ftrace_regs_*() macros
References: <20241015212408.300754469@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Since the arch_ftrace_get_regs(fregs) is only valid when the
FL_SAVE_REGS is set, we need to use `&arch_ftrace_regs()->regs` for
ftrace_regs_*() APIs because those APIs are for ftrace_regs, not
complete pt_regs.

Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Florent Revest <revest@chromium.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf <bpf@vger.kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/172895572290.107311.16057631001860177198.stgit@devnote2
Fixes: e4cf33ca4812 ("ftrace: Consolidate ftrace_regs accessor functions for archs using pt_regs")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace_regs.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/ftrace_regs.h b/include/linux/ftrace_regs.h
index dea6a0851b74..b78a0a60515b 100644
--- a/include/linux/ftrace_regs.h
+++ b/include/linux/ftrace_regs.h
@@ -17,17 +17,17 @@ struct __arch_ftrace_regs {
 struct ftrace_regs;
 
 #define ftrace_regs_get_instruction_pointer(fregs) \
-	instruction_pointer(arch_ftrace_get_regs(fregs))
+	instruction_pointer(&arch_ftrace_regs(fregs)->regs)
 #define ftrace_regs_get_argument(fregs, n) \
-	regs_get_kernel_argument(arch_ftrace_get_regs(fregs), n)
+	regs_get_kernel_argument(&arch_ftrace_regs(fregs)->regs, n)
 #define ftrace_regs_get_stack_pointer(fregs) \
-	kernel_stack_pointer(arch_ftrace_get_regs(fregs))
+	kernel_stack_pointer(&arch_ftrace_regs(fregs)->regs)
 #define ftrace_regs_return_value(fregs) \
-	regs_return_value(arch_ftrace_get_regs(fregs))
+	regs_return_value(&arch_ftrace_regs(fregs)->regs)
 #define ftrace_regs_set_return_value(fregs, ret) \
-	regs_set_return_value(arch_ftrace_get_regs(fregs), ret)
+	regs_set_return_value(&arch_ftrace_regs(fregs)->regs, ret)
 #define ftrace_override_function_with_return(fregs) \
-	override_function_with_return(arch_ftrace_get_regs(fregs))
+	override_function_with_return(&arch_ftrace_regs(fregs)->regs)
 #define ftrace_regs_query_register_offset(name) \
 	regs_query_register_offset(name)
 
-- 
2.45.2



