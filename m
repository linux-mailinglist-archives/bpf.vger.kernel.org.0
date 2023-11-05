Return-Path: <bpf+bounces-14243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8197E1465
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 17:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 511CCB20E25
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 16:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FE71401C;
	Sun,  5 Nov 2023 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/CoB3R0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8495C125CB;
	Sun,  5 Nov 2023 16:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D602C433C8;
	Sun,  5 Nov 2023 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699200604;
	bh=6QXlcdrE6Vd0uevCRAQA5jRWA9Z4WkVDk80uAUwbJ/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c/CoB3R0PwHpStxpBdcBy486i6VbtYtAR1YYmvlMJgWlkvwAslfAM1MBCOHQznEuS
	 EKB3GpxYg2osZ0mbNEFlBtDFS7IVzI8nLjnyHdFfeaBzk/uPzEYKy3lm1Bh7rSay0R
	 qkBO9K4WnNjpxWMohFj5Bz6IizDWDIk+eYYnnzFX5DId19isCVydBj6Z1yGqVq2lxc
	 vsiYZsNeJERJi8N1ScBOr5UoHyCG75QN3HFIMfGa2X5DeJe5Y5ak8aag8MhZQpGBcn
	 kpy8+KCP3F7miOXW/IulJ9Y5Nh6snHUESFyYCkL2wO64KgRqRsaKfBZSyp+XcguuOu
	 wfUKgBO98l/PA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Guo Ren <guoren@kernel.org>
Subject: [RFC PATCH 17/32] function_graph: Fix to update curr_ret_stack with ARRAY entry size
Date: Mon,  6 Nov 2023 01:09:57 +0900
Message-Id: <169920059747.482486.11622923727523240888.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169920038849.482486.15796387219966662967.stgit@devnote2>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

__ftrace_return_to_handler() missed to update the curr_ret_stack when it
gets a FGRAPH_TYPE_ARRAY. Since that type entry will follows some data
words, it must update curr_ret_stack by entry size value (__get_index(val))
instead of 1.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fgraph.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 0f8e9f22e9e0..597250bd30dc 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -740,7 +740,8 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 		case FGRAPH_TYPE_ARRAY:
 			idx = __get_array(val);
 			fgraph_array[idx]->retfunc(&trace, fgraph_array[idx]);
-			fallthrough;
+			curr_ret_stack -= __get_index(val);
+			break;
 		case FGRAPH_TYPE_RESERVED:
 			curr_ret_stack--;
 			break;


