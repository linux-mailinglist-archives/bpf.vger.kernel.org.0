Return-Path: <bpf+bounces-42097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA89099F904
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 23:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C311C21D58
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 21:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CD81FE0E0;
	Tue, 15 Oct 2024 21:24:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5099F1FBF69;
	Tue, 15 Oct 2024 21:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729027445; cv=none; b=n6q4Ya+jgTpIFLCpGaeWdRoL9ZXguHta4373YN/JHJWN8pen8LZWy8dTUn/QzxugzmjyUOph0MsbAtui2LH4vp4VxB0lYnvSzdLkfpUdX6PaiDpOZrn9k7cQBOrqy+axTNMIkiK20OxY7ia8sP7IuXBRCoZHO4B9TbD3ALB9Ylc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729027445; c=relaxed/simple;
	bh=7CjrsLcdS425VLUPINBWwbx7Xhs+Zszb1auA7UaZTbg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fN+7kZMc5RMRTfQtwwdMkK+TZ4Pxjz2Giwz8veWxhE1hWCe+eyP2WivH2GRVx5QW6y65M/E+DUKXTPdAcObkzIW2bG5ewTEmAJ8deSbgKMKjBICY1h+OJvecfKgGfk4QDe59ZrkMPeyd31q2mL9YYtBYr07G09OOuS4AyLV+sZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E1BC4CED5;
	Tue, 15 Oct 2024 21:24:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t0p1k-00000003517-3sp9;
	Tue, 15 Oct 2024 17:24:24 -0400
Message-ID: <20241015212424.785004334@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 15 Oct 2024 17:24:11 -0400
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
Subject: [for-next][PATCH 3/3] ftrace: Rename ftrace_regs_return_value to
 ftrace_regs_get_return_value
References: <20241015212408.300754469@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Rename ftrace_regs_return_value to ftrace_regs_get_return_value as same as
other ftrace_regs_get/set_* APIs. arm64 and riscv are already using this
new name.

Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Florent Revest <revest@chromium.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf <bpf@vger.kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>
Link: https://lore.kernel.org/172895573350.107311.7564634260652361511.stgit@devnote2
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ftrace_regs.h b/include/linux/ftrace_regs.h
index b78a0a60515b..be1ed0c891d0 100644
--- a/include/linux/ftrace_regs.h
+++ b/include/linux/ftrace_regs.h
@@ -22,7 +22,7 @@ struct ftrace_regs;
 	regs_get_kernel_argument(&arch_ftrace_regs(fregs)->regs, n)
 #define ftrace_regs_get_stack_pointer(fregs) \
 	kernel_stack_pointer(&arch_ftrace_regs(fregs)->regs)
-#define ftrace_regs_return_value(fregs) \
+#define ftrace_regs_get_return_value(fregs) \
 	regs_return_value(&arch_ftrace_regs(fregs)->regs)
 #define ftrace_regs_set_return_value(fregs, ret) \
 	regs_set_return_value(&arch_ftrace_regs(fregs)->regs, ret)
-- 
2.45.2



