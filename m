Return-Path: <bpf+bounces-67765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5341FB49794
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CB577B4099
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 17:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05082313E19;
	Mon,  8 Sep 2025 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzMv/EDR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758F913C8E8;
	Mon,  8 Sep 2025 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757354024; cv=none; b=G5bn/fu3tVKFGFtueuETd1v5lT1mEV7JQujgCm037yjl5NBOZFZSxT56t7rXBlxXHrY9wPUod09chMTlGuHkENOTuXgLbq55eppSl4oBXkMoxjGQmrfDhtIb5pX/zEDllCLi0k/qLot/A3liPhy3DnQzNUMRWAc3DdiEROPq3lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757354024; c=relaxed/simple;
	bh=L4T7PdWR77h8wPb0TRSRQqBSx4nSQc+aT0+pK6PLhIw=;
	h=Message-ID:Date:From:To:Cc:Subject; b=HX+wKDGB1N3NwPUxsX35OquXTNt/jqb41G3JeCtbqFwEin/SVjeMsuR4eAnylHp+srgBOHAjPCSfhGukugq1m+I9yizLeGaazZFPvEYVcQaOBw7D7SVa3xYYGDCn0jSl9L9YNMuF6LueMmXfM2r2a8uBofLCLK/R6EifLR88sEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzMv/EDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D9EC4CEF1;
	Mon,  8 Sep 2025 17:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757354024;
	bh=L4T7PdWR77h8wPb0TRSRQqBSx4nSQc+aT0+pK6PLhIw=;
	h=Date:From:To:Cc:Subject:From;
	b=WzMv/EDRHTQQOF57dDwqnUl2sMfIcXy29UKLDgmNptRtlDvJW9aQAvjblc/bA9Ohc
	 f3xVCn+6OL+M7kBaAeHSvA/J3LhZQIJE6bA/9/bkNABf47PywHCmaM3Q2Qs5dmjq7H
	 nlpsFQdOZrakMCfm25l3VjS8OOMsiHOMXFXUI5ZxZJF+nzf2RpyPFv+GWiu0e53QN2
	 /nBKj3+CNn2TbatSCE1TrlDOvDJE9MKIBxoLGDSIEDsq1Y9ETqJxPvu6KFBPJ7yvqE
	 8c+GMQcpwPtHMiBM+2Hcc7dMbfQYtlqMEHtnYY7lv/yVad0Jy68cZTK1c3HaOpMBtQ
	 6r47wsPKB1R4w==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uvg4U-0000000769c-0Rpz;
	Mon, 08 Sep 2025 13:54:30 -0400
Message-ID: <20250908175319.841517121@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 08 Sep 2025 13:53:19 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>,
 Kees Cook <kees@kernel.org>,
 "Carlos O'Donell" <codonell@redhat.com>
Subject: [PATCH v16 0/4] perf tool: Support the deferred unwinding infrastructure
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>


This is the user space side of perf changes to handle deferred unwinding.
It is based on the kernel side of perf patch series here:

  https://lore.kernel.org/linux-trace-kernel/20250908171412.268168931@kernel.org/

Changes since v15: https://lore.kernel.org/linux-trace-kernel/20250825180638.877627656@kernel.org/

- Separate out the kernel changes from the user space changes of perf.

- Have the matching deferred code only skip when TID does not match.
  Otherwise, process the sample but do not merge if the cookies do not match.
  (Namhyung Kim)

Namhyung Kim (4):
      perf tools: Minimal CALLCHAIN_DEFERRED support
      perf record: Enable defer_callchain for user callchains
      perf script: Display PERF_RECORD_CALLCHAIN_DEFERRED
      perf tools: Merge deferred user callchains

----
 tools/lib/perf/include/perf/event.h       |  8 +++
 tools/perf/Documentation/perf-script.txt  |  5 ++
 tools/perf/builtin-script.c               | 92 +++++++++++++++++++++++++++++++
 tools/perf/util/callchain.c               | 24 ++++++++
 tools/perf/util/callchain.h               |  3 +
 tools/perf/util/event.c                   |  1 +
 tools/perf/util/evlist.c                  |  1 +
 tools/perf/util/evlist.h                  |  1 +
 tools/perf/util/evsel.c                   | 42 ++++++++++++++
 tools/perf/util/evsel.h                   |  1 +
 tools/perf/util/machine.c                 |  1 +
 tools/perf/util/perf_event_attr_fprintf.c |  1 +
 tools/perf/util/sample.h                  |  4 +-
 tools/perf/util/session.c                 | 81 +++++++++++++++++++++++++++
 tools/perf/util/tool.c                    |  2 +
 tools/perf/util/tool.h                    |  4 +-
 16 files changed, 269 insertions(+), 2 deletions(-)

