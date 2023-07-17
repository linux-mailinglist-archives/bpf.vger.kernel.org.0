Return-Path: <bpf+bounces-5100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E977567B8
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 17:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F97281210
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 15:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BCE253D9;
	Mon, 17 Jul 2023 15:23:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AC2253BB
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 15:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9639AC433C8;
	Mon, 17 Jul 2023 15:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689607402;
	bh=gHIJLgbVp3IPB3gkGkxy/IvawUhhWSjYF4p1wpvRtLU=;
	h=From:To:Cc:Subject:Date:From;
	b=fqXZ5t4I+z6d4b3GWRKAdh2i6bGmPXXT/2vJMQTEpeT7hjsTxU+8QV9HJS0cQbT1A
	 RbscXA8m+dEco03gEfPnVgQSbTbMrxAukoOy+008DndMQz4HqGAsSFCp7voeuytUhy
	 MYQSAhu7EB7Pv7F4UTIaiInLZXAUmiZm1rS3iqnRpirRbEUEK7vvmJyB737eYJpjI6
	 4IrF7TEByeiIWHET1Vtrd2LK9ZJoAhPXfRdcStA7fcpRpVIbNAvmDSlv4tCXK1s+Gi
	 jhNUfvREWP3N4lvl8zkVwDMgto29ttQrybvz/kmw4d5Duc5Xah9gfUkKIdke+ugdwZ
	 4pPMNoRjeC4Fg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v2 0/9] tracing: Improbe BTF support on probe events
Date: Tue, 18 Jul 2023 00:23:17 +0900
Message-Id: <168960739768.34107.15145201749042174448.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
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

Here is the 2nd version of series to improve the BTF support on probe events.
The previous series is here:

https://lore.kernel.org/linux-trace-kernel/168699521817.528797.13179901018528120324.stgit@mhiramat.roam.corp.google.com/

In this version, I added a NULL check fix patch [1/9] (which will go to
fixes branch) and move BTF related API to kernel/bpf/btf.c [2/9] and add
a new BTF API [3/9] so that anyone can reuse it.
Also I decided to use '$retval' directly instead of 'retval' pseudo BTF
variable for field access at [5/9] because I introduced an idea to choose
function 'exit' event automatically if '$retval' is used [7/9]. With that
change, we can not use 'retval' because if a function has 'retval'
argument, we can not decide 'f func retval' is function exit or entry.
Selftest test case [8/9] and document [9/9] are also updated according to
those changes.

This series can be applied on top of "v6.5-rc2" kernel.

You can also get this series from:

git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git topic/fprobe-event-ext


Thank you,

---

Masami Hiramatsu (Google) (9):
      tracing/probes: Fix to add NULL check for BTF APIs
      bpf/btf: tracing: Move finding func-proto API and getting func-param API to BTF
      bpf/btf: Add a function to search a member of a struct/union
      tracing/probes: Support BTF based data structure field access
      tracing/probes: Support BTF field access from $retval
      tracing/probes: Add string type check with BTF
      tracing/fprobe-event: Assume fprobe is a return event by $retval
      selftests/ftrace: Add BTF fields access testcases
      Documentation: tracing: Update fprobe event example with BTF field


 Documentation/trace/fprobetrace.rst                |   50 ++
 include/linux/btf.h                                |    7 
 kernel/bpf/btf.c                                   |   83 ++++
 kernel/trace/trace_fprobe.c                        |   58 ++-
 kernel/trace/trace_probe.c                         |  402 +++++++++++++++-----
 kernel/trace/trace_probe.h                         |   12 +
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   11 +
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    6 
 8 files changed, 503 insertions(+), 126 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

