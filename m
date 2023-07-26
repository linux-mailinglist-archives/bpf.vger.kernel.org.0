Return-Path: <bpf+bounces-5941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BBF7636EA
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 15:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E4A281D91
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 13:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43D2BE67;
	Wed, 26 Jul 2023 13:00:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC76CCA4F
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 12:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539BBC433C7;
	Wed, 26 Jul 2023 12:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690376398;
	bh=qCZGKn1xSuw8bqgTgENy4mv3gBbzcDsXM+kRBp1p2pc=;
	h=From:To:Cc:Subject:Date:From;
	b=CajfpC+n/Ntcoxc6eX7AiPKHESntCL6bFmRiiQJpqHppVvw8HSCv+JKx9AZpaIZa2
	 LUdm1yzAvxPZJS1JxHxXbcrJp6UJyAZD3n0dUsnNujwiEDh6UcfUZdAJM6m/Xyl9MF
	 bJpIETWhqe63knc5HFdLvCTtKPS/rQ+wrUa8h8PESaDLszMHmM3ltfkJKN5Emi95tw
	 hKZcN2mrTjIw5xM4zx+I9pIy69E06ezh9PwGNWlfNpKWkkUW5K6CleoePOQ/+Ll1wa
	 cYfYWOmdXSV+cdwYm1yJC6H9Z6hwZYrEcmeyvl/KbXTp37m+lwEi7b5SdZwsScPeds
	 kAGnm/cLDpeQQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v3 0/9] tracing: Improbe BTF support on probe events
Date: Wed, 26 Jul 2023 21:59:53 +0900
Message-Id: <169037639315.607919.2613476171148037242.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is the 3rd version of series to improve the BTF support on probe events.
The previous series is here:

https://lore.kernel.org/all/168960739768.34107.15145201749042174448.stgit@devnote2/

The fixes patch in the previous version has been sent in different series.

https://lore.kernel.org/all/169024903018.395371.1006584451160707296.stgit@devnote2/

In this version, I added BTF support on module symbols (this will be the
biggest change) [1/9] and cleanup the btf APIs [2/9][3/9] according to
the comment. Also [5/9] introduce a query_btf_context() for simplifying
common fields in traceprobe_parse_context. [8/9] added more complex test
case for structure field access. And [9/9] update the documentation about
the mixture of '.' and '->'.

This series can be applied on top of "probes/core" branch of
https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/

You can also get this series from:

git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git topic/fprobe-event-ext

Thank you,

---

Masami Hiramatsu (Google) (9):
      tracing/probes: Support BTF argument on module functions
      bpf/btf: tracing: Move finding func-proto API and getting func-param API to BTF
      bpf/btf: Add a function to search a member of a struct/union
      tracing/probes: Support BTF based data structure field access
      tracing/probes: Support BTF field access from $retval
      tracing/probes: Add string type check with BTF
      tracing/fprobe-event: Assume fprobe is a return event by $retval
      selftests/ftrace: Add BTF fields access testcases
      Documentation: tracing: Update fprobe event example with BTF field


 Documentation/trace/fprobetrace.rst                |   64 ++-
 include/linux/btf.h                                |    8 
 kernel/bpf/btf.c                                   |   84 +++
 kernel/trace/trace_eprobe.c                        |    4 
 kernel/trace/trace_fprobe.c                        |   59 ++
 kernel/trace/trace_kprobe.c                        |    1 
 kernel/trace/trace_probe.c                         |  487 +++++++++++++++-----
 kernel/trace/trace_probe.h                         |   27 +
 kernel/trace/trace_uprobe.c                        |    1 
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   14 +
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    6 
 11 files changed, 582 insertions(+), 173 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

