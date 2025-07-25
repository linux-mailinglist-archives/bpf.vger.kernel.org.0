Return-Path: <bpf+bounces-64397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D967B12478
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 20:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB161CE4695
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 18:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77801259CB9;
	Fri, 25 Jul 2025 18:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxX5z84R"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA6324BCF5;
	Fri, 25 Jul 2025 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469854; cv=none; b=rjTg2l1UXpQeih+Z4i8Unt2DAsodi9JUOs7hypx9nOGx6hjzqWlUgBliWQjXow6HGWsU+rZruVXKMhVfsPjhbdBzKqNdSHCIGUFbQ4ytt+b1Fanggn9PHRYbuNGauat/5lLomfS8bz6f1Mwh4ZJlMlrex1qUPnOohSOILpYf++E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469854; c=relaxed/simple;
	bh=DCUUj3oPwbhE6GvHSHYoJfmAnmk4vqLGSK9Gd/SZil8=;
	h=Message-ID:Date:From:To:Cc:Subject; b=JVWBs4fMY3JItmE/pCmzOKE0jHRN6Vlx3r8/vx4SGFjbBT/Dz1Lr5MfBSo9CGkZgFeTSYkBTA1E06cGUgEcumiaDwXG8HVQfgsNbBROMe2BWtKYoFQwnvGsgrax11N2ysANlQP535lHnp8z6r8A3q+WXAo2rtnEXDUH3sUIKAdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxX5z84R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDBAC4CEE7;
	Fri, 25 Jul 2025 18:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753469853;
	bh=DCUUj3oPwbhE6GvHSHYoJfmAnmk4vqLGSK9Gd/SZil8=;
	h=Date:From:To:Cc:Subject:From;
	b=hxX5z84RAT+P7Vrlne33aI9DMJupXBDQRq2JjvFp3u5RUBA/r2x0KmewJcROe/1Qz
	 iCMwn+AOrQlRcIGH/QDoUULNoNe9FJKi2pxJovSsiSizFHQxSorOO6iy0Qk96EFtVD
	 b/IlmWRXKMXmZRAvhyniEV+zZzp+AokRqBfUERYj1QuXRsD7JKsG2fx+cGbh9ioTZi
	 EAmTjxHne2VUiN7RYSWT7ds9t4v1ELocxvKjl4kI1w6pYu8XyVDS36BkuOP1ZDKP1P
	 37nJho13Rwf5cnNz1EzOJRIumxXQtkj6m+RR0HyR1Ah4jb4uvr0WlJzE1XhnPv1TwN
	 XaAp83HXW2Oog==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufNbv-00000001N30-0rLf;
	Fri, 25 Jul 2025 14:57:39 -0400
Message-ID: <20250725185512.673587297@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 14:55:12 -0400
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
 Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>
Subject: [PATCH v15 00/10] unwind_user: Deferred unwinding infrastructure
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>


Leaving out the prologue about sframes and the rationale for this
change as is on the cover letter of v14.

Changse since v14: https://lore.kernel.org/linux-trace-kernel/20250717004910.297898999@kernel.org/

- Use normal SRCU instead of srcu_lite which is being deprecated
  (Paul McKenney)

- Removed the two x86 specific patches.

V14 should have all the changes to address Peter Zijlstras comments.
But Peter is now on vacation for a month, so I'm posting this without
the x86 patches. This only has the core deferred unwinding infrastructure.

The idea is to have this added to the up coming merge window as all
the other patch series rely on it. The reason I would like this patch
series in, is because those other patch series do not rely on each other
and it would be nice to develop them separately with a common code base
that happens to be upstream. Those patch series are:

- The two patches to implement x86:
  https://lore.kernel.org/linux-trace-kernel/20250717004958.260781923@kernel.org/
  https://lore.kernel.org/linux-trace-kernel/20250717004958.432327787@kernel.org/

- The s390 work:
  https://lore.kernel.org/linux-trace-kernel/20250710163522.3195293-1-jremus@linux.ibm.com/

- The perf work:
  https://lore.kernel.org/linux-trace-kernel/20250718164119.089692174@kernel.org/

- The ftrace work:
  https://patchwork.kernel.org/project/linux-trace-kernel/patch/20250424192612.505622711@goodmis.org/

- The sframe work:
  https://patchwork.kernel.org/project/linux-trace-kernel/cover/20250717012848.927473176@kernel.org/

And more is on the way.

Nothing enables this code without an architecture to enable it, but
similar to the PREEMPT_RT being added to the kernel before it was enabled,
it would be very useful to have this added as well. That will allow the
above code to be worked on in parallel and also stop the confusion of
releasing many series together for every iteration of this one.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
unwind/core

Head SHA1: ee18ef301d2ed23c405a9f55275cadd14ca47645


Josh Poimboeuf (3):
      unwind_user: Add user space unwinding API with frame pointer support
      unwind_user/deferred: Add unwind cache
      unwind_user/deferred: Add deferred unwinding interface

Steven Rostedt (7):
      unwind_user/deferred: Add unwind_user_faultable()
      unwind_user/deferred: Make unwind deferral requests NMI-safe
      unwind deferred: Use bitmask to determine which callbacks to call
      unwind deferred: Add unwind_completed mask to stop spurious callbacks
      unwind: Add USED bit to only have one conditional on way back to user space
      unwind deferred: Use SRCU unwind_deferred_task_work()
      unwind: Finish up unwind when a task exits

----
 MAINTAINERS                           |   8 +
 arch/Kconfig                          |   7 +
 include/asm-generic/Kbuild            |   1 +
 include/asm-generic/unwind_user.h     |   5 +
 include/linux/entry-common.h          |   2 +
 include/linux/sched.h                 |   5 +
 include/linux/unwind_deferred.h       |  81 ++++++++
 include/linux/unwind_deferred_types.h |  39 ++++
 include/linux/unwind_user.h           |  14 ++
 include/linux/unwind_user_types.h     |  44 +++++
 kernel/Makefile                       |   1 +
 kernel/exit.c                         |   2 +
 kernel/fork.c                         |   4 +
 kernel/unwind/Makefile                |   1 +
 kernel/unwind/deferred.c              | 362 ++++++++++++++++++++++++++++++++++
 kernel/unwind/user.c                  | 128 ++++++++++++
 16 files changed, 704 insertions(+)
 create mode 100644 include/asm-generic/unwind_user.h
 create mode 100644 include/linux/unwind_deferred.h
 create mode 100644 include/linux/unwind_deferred_types.h
 create mode 100644 include/linux/unwind_user.h
 create mode 100644 include/linux/unwind_user_types.h
 create mode 100644 kernel/unwind/Makefile
 create mode 100644 kernel/unwind/deferred.c
 create mode 100644 kernel/unwind/user.c

