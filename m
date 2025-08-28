Return-Path: <bpf+bounces-66869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF67B3A975
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 20:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A844DA0239C
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 18:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6EF26CE2E;
	Thu, 28 Aug 2025 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHc8YGG2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422F9261581;
	Thu, 28 Aug 2025 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756404216; cv=none; b=DhEEQ37idlS6epGMvFtfCFgejd5kjCJ6kwkm1nUe3bEhYpifaWws7cPrF6e2M0PDO+JEmpgVQjQnd7wxp9oBhYTtl/U7AvdnmFbPfpxQNpOV3FT2G9UHTaHec3B4F6kABou97DyajtI0Js95Wb87BnFOhBKmKs52jdsFUKM5J50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756404216; c=relaxed/simple;
	bh=nr5fLsW9wRRZqiJlOLuUCjG60WO/RY0kea95ijoghhc=;
	h=Message-ID:Date:From:To:Cc:Subject; b=dQBONLiJOdJxJiI51tICo4SFxktRI9UtSJZ+NBnZfH3bXTF/c1F5RwfaajG5Hhhw3fEAGlHXlyyYrnSvmCyyAPKh+3dUrt8jyE/NeE5M5Jr/Bk+YhmSjZJHpyoEatE+cQATmTCAYfkDtOWN0XYveK7Y/OBGJipWdQ66PeNfTVh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHc8YGG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56DEC4CEEB;
	Thu, 28 Aug 2025 18:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756404215;
	bh=nr5fLsW9wRRZqiJlOLuUCjG60WO/RY0kea95ijoghhc=;
	h=Date:From:To:Cc:Subject:From;
	b=UHc8YGG25tv2TxLOcxUSVKQwPLJHWCXOrp7kE6Zom/MZDt/v0SPqnRsJc2404/1A2
	 u/fWDXGpkM/8DQiefxPl+g5Ei+7OlQYapRf1vixPdoCZEfwgmjMVzaccwHy0g+bK02
	 1bu44aYgIq7DnDeETX3aYk15IaJrKw3w/R4qog1Muhcu0dCJTeaq6C30JnebOOeXaq
	 n9C1nmtrclLkUwSOY860Bj0I7XY9VF3L/5mxPO3OljXkGWW+w6YQ/FUIIiWS+ICy00
	 qXz9cadVJmaN736uN4VuU34aMrbnTX9V6yuPUO4PGxxRY4qnUSlqVdecpsLtS8oEFU
	 j6+Z04t8QiDFg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1urgya-00000004GAo-2AcV;
	Thu, 28 Aug 2025 14:03:56 -0400
Message-ID: <20250828180300.591225320@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 28 Aug 2025 14:03:00 -0400
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
Subject: [PATCH v6 0/6] tracing: Deferred unwinding of user space stack traces
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>


This is the tracefs (ftrace) implementation of the deferred stack tracing.

This creates two new events that get set for every trace event when the new
"userstacktrace_delay" option is enabled. The first event happens at the time
of the request (after a trace event) that saves the cookie that represents the
current user space stack trace (it stays the same while the task is in the
kernel, as the user space stack doesn't change during this time). The second
event is where the user space stacktrace is recorded along with the cookie.

Since the callback is called in faultable context, it uses this opportunity
to look at the addresses in the stacktrace and convert them to where
they would be in the executable file (if found). It also records
the inode and device major/minor numbers into the trace, so that post
processing can find the exact location where the stacks are.

To simplify the finding of the files, a new "inode_cache" event is created
that gets triggered whenever a new inode/device is added to a new rhashtable.
It will then look up the path that represents that inode/device via the vma
descriptor. To keep the recording down to a minimum, this event is only
triggered when a new inode/device is added to the rhashtable. The rhashtable
is reset when certain changes occur in the tracefs system so that new readers
of this event can get the latest changes.

Changes since v5: https://lore.kernel.org/linux-trace-kernel/20250424192456.851953422@goodmis.org/

- Removed unwind infrastructure patches as they have already been merged.

- Also add check for PF_USER_WORKER to test for kernel thread

- Have the userstacktrace_delay option not depend on the userstacktrace
  option.

- Do not expose the userstacktrace_delay option if it's not supported.

- Set inode to -1L if vma is not found for that address to let user space
  know that, and differentiate from a vdso section.

- Added "inode_cache" to dsiplay inode/device paths when added to a stack trace

Steven Rostedt (6):
      tracing: Do not bother getting user space stacktraces for kernel threads
      tracing: Rename __dynamic_array() to __dynamic_field() for ftrace events
      tracing: Implement deferred user space stacktracing
      tracing: Have deferred user space stacktrace show file offsets
      tracing: Show inode and device major:minor in deferred user space stacktrace
      tracing: Add an event to map the inodes to their file names

----
 kernel/trace/Makefile            |   3 +
 kernel/trace/inode_cache.c       | 144 ++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace.c             | 146 ++++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace.h             |  32 ++++++++-
 kernel/trace/trace_entries.h     |  38 ++++++++--
 kernel/trace/trace_export.c      |  25 ++++++-
 kernel/trace/trace_inode_cache.h |  42 +++++++++++
 kernel/trace/trace_output.c      |  99 ++++++++++++++++++++++++++
 8 files changed, 520 insertions(+), 9 deletions(-)
 create mode 100644 kernel/trace/inode_cache.c
 create mode 100644 kernel/trace/trace_inode_cache.h

