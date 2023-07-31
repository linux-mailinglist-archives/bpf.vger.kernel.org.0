Return-Path: <bpf+bounces-6408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD88A768EBE
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 09:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131761C20B40
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 07:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851A66132;
	Mon, 31 Jul 2023 07:30:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F05C468B
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 07:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D2CC433C8;
	Mon, 31 Jul 2023 07:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690788608;
	bh=aViYjhHwbZtY5aBTs3TkoJnQJ5YBfz5b0B+HKWNFQow=;
	h=From:To:Cc:Subject:Date:From;
	b=aZZURDXIAq2KKy3/Ab7ggwg2OuV/OXMnT0oo+ypOk0G8Kprom/dhLJWcSYlr1tqxb
	 kN60zV6Or2TSkn4FUB+yG6vwlWtczVMBRaVpwId8WAPvPGvQJJeS1qU3RLWWltF673
	 oHLYNwvq9002UcQHluTL/6ds5aNym5BIIEjLvuCu+NeBJx2xEg+FXFRq8a8esg4S7G
	 3jey/KaNE+1RKuLMQWbQTbHpXlunHGI4aksBtYhibG7a+9Y3xbFHcnhJgRisBFMTJS
	 dwFtW0U+UooPBQqqbVu06cTB258/IyPSL6D1BohWYbty6SIPT9vACfKrzR0evAf75n
	 ocV5Uju9H8BEw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v4 0/9] tracing: Improbe BTF support on probe events
Date: Mon, 31 Jul 2023 16:30:04 +0900
Message-Id: <169078860386.173706.3091034523220945605.stgit@devnote2>
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

Here is the 4th version of series to improve the BTF support on probe events.
The previous series is here:

https://lore.kernel.org/all/169037639315.607919.2613476171148037242.stgit@devnote2/

This version updates the btf_find_struct_member() to use a simple stack
to walk through the anonymous unions/structures instead of recursive call.
Also, returning int error code from query_btf_context()
if !CONFIG_PROBE_EVENTS_BTF_ARGS.

This series enables {f,k}probe events to access the members of data
structures using BTF from arguments and return value. This also adds
some new APIs to BTF so that other users can use BTF to find function
prototypes and the members of data structures.

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
 kernel/bpf/btf.c                                   |   89 ++++
 kernel/trace/trace_eprobe.c                        |    4 
 kernel/trace/trace_fprobe.c                        |   59 ++
 kernel/trace/trace_kprobe.c                        |    1 
 kernel/trace/trace_probe.c                         |  494 +++++++++++++++-----
 kernel/trace/trace_probe.h                         |   27 +
 kernel/trace/trace_uprobe.c                        |    1 
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   14 +
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    6 
 11 files changed, 593 insertions(+), 174 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

