Return-Path: <bpf+bounces-41619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2832999360
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 22:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86DE9282CE7
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 20:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B1B1D0432;
	Thu, 10 Oct 2024 20:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwA6t6oD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93AC1CF7CF;
	Thu, 10 Oct 2024 20:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728591004; cv=none; b=Mf7waCtMsH/tkN8X3rUUGnLQlIplPUFzfWtBRWw3mJPptI2aq/tw4SiHQW0EaAGnf7IO16dI6GttweM+7j8tMfSVoOf6/e0s/rnylB3Qs+zzSOYYGWmUcItNkcOiZzWQo/OimfNOUwIqMDiyPiF/2xCoYz7vCFnY70FNLMmXQ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728591004; c=relaxed/simple;
	bh=x8e2ILBwpZmzCxpX45Psnyob3wOlz2/6sCLppTDJwt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AwJNV0xvOWh9u/4c0CN6sXtgQsAmW7Tfyh2trCj33ZRrIjhHRARnzL1Ti2Oe+HuiIIzGiMiAKV9kWch9UO1xYYsKcNdjoP1qKOXS5RqSyLDPhXGQA0PNUVid6dQoWDZ4bokHiAsQrS8q2EHYkpaKs2NGkkLm/EJliZBq7Vpr13Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwA6t6oD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F1BC4CECD;
	Thu, 10 Oct 2024 20:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728591004;
	bh=x8e2ILBwpZmzCxpX45Psnyob3wOlz2/6sCLppTDJwt8=;
	h=From:To:Cc:Subject:Date:From;
	b=gwA6t6oDlVJEQQOT7Qi6oQvt7+/F6fF+dV21W5anTTrHU0yCAvQ0VaLNF8Z3TsDl2
	 5rd/NzjoPtPi0qRqzxTelTdm+vHAjbNZlJt0i6i0cw7nUbd5Zq0FSm8CNBtNZm7CcL
	 rI/LMxQRzALKQ+QQN8UkwBIrmPtZvn73YpEOcvZ46zLliSDnx1kSiT0B1zhEXzSwl0
	 w332Scqvh6ECYGoDwPGW2HzYLHorlA5ED/znqb7AWuosJuCirp5fayzLViEzB8z1MM
	 cNjMOcax6s633gjYp20zsvjL6gphYjsqhXoYoD9wOqgD1z7k42nF2swO6us+HB1Di6
	 yotGr+iqF5uDw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv6 bpf-next,perf/core 00/16] uprobe, bpf: Add session support
Date: Thu, 10 Oct 2024 22:09:41 +0200
Message-ID: <20241010200957.2750179-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
this patchset is adding support for session uprobe attachment and
using it through bpf link for bpf programs.

The session means that the uprobe consumer is executed on entry
and return of probed function with additional control:
  - entry callback can control execution of the return callback
  - entry and return callbacks can share data/cookie

On more details please see patch #2.

The patchset is based on Peter's perf/core [1] tree merged in bpf-next/master.

There's an proposal from Andrii how to get this merged in [2]:

> I think uprobe parts should stay in tip/perf/core (if that's where all
> uprobe code goes in), as we have a bunch of ongoing work that all will
> conflict a bit with each other, if it lands across multiple trees.
> 
> So that means that patches #1 and #2 ideally land in tip/perf/core.
> But you have a lot of BPF-specific things that would be inconvenient
> to route through tip, so I'd say those should go through bpf-next.
> 
> What we can do, if Ingo and Peter are OK with that, is to create a
> stable (non-rebaseable) branch off of your first two patches (applied
> in tip/perf/core), which we'll merge into bpf-next/master and land the
> rest of your patch set there. We've done that with recent struct fd
> changes, and there were few other similar cases in the past, and that
> all worked well.
> 
> Peter, Ingo, are you guys OK with that approach?


v6 changes:
  - added acks [Andrii, Oleg]
  - added missing Fixes tags
  - added fix to force uprobe bpf program to always return 0 [Andrii]
  - separated kprobe session verifier check for return value check
    and squashed similar uprobe session fix in patch 5 [Andrii]
  - move session return handler check for cookie data to handle_uretprobe_chain [Andrii]
  - added threads the session test to speed it up
  - several smaller fixes [Andrii]

thanks,
jirka


[1] git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core
[2] https://lore.kernel.org/bpf/CAEf4BzY8tGCstcD4BVBLPd0V92p--b_vUmQyWydObRJHZPgCLA@mail.gmail.com/
---
Jiri Olsa (16):
      uprobe: Add data pointer to consumer handlers
      uprobe: Add support for session consumer
      bpf: Allow return values 0 and 1 for kprobe session
      bpf: Force uprobe bpf program to always return 0
      bpf: Add support for uprobe multi session attach
      bpf: Add support for uprobe multi session context
      libbpf: Add support for uprobe multi session attach
      selftests/bpf: Add uprobe session test
      selftests/bpf: Add uprobe session cookie test
      selftests/bpf: Add uprobe session recursive test
      selftests/bpf: Add uprobe session verifier test for return value
      selftests/bpf: Add kprobe session verifier test for return value
      selftests/bpf: Add uprobe session single consumer test
      selftests/bpf: Scale down uprobe multi consumer test
      selftests/bpf: Add uprobe sessions to consumer test
      selftests/bpf: Add threads to consumer test

 include/linux/uprobes.h                                            |  25 ++++++-
 include/uapi/linux/bpf.h                                           |   1 +
 kernel/bpf/syscall.c                                               |   9 ++-
 kernel/bpf/verifier.c                                              |  10 +++
 kernel/events/uprobes.c                                            | 148 +++++++++++++++++++++++++++++--------
 kernel/trace/bpf_trace.c                                           |  63 +++++++++++-----
 kernel/trace/trace_uprobe.c                                        |  12 ++-
 tools/include/uapi/linux/bpf.h                                     |   1 +
 tools/lib/bpf/bpf.c                                                |   1 +
 tools/lib/bpf/libbpf.c                                             |  19 ++++-
 tools/lib/bpf/libbpf.h                                             |   4 +-
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c              |   2 +-
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c         |   2 +
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c         | 336 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 tools/testing/selftests/bpf/progs/kprobe_multi_verifier.c          |  31 ++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c         |   6 +-
 tools/testing/selftests/bpf/progs/uprobe_multi_session.c           |  71 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c    |  48 ++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c |  44 +++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session_single.c    |  44 +++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c          |  31 ++++++++
 21 files changed, 808 insertions(+), 100 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_verifier.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_single.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c

