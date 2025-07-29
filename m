Return-Path: <bpf+bounces-64646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C22EBB152A1
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 20:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D60418A5441
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 18:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565CF23B602;
	Tue, 29 Jul 2025 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyrbTl+w"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E48237180;
	Tue, 29 Jul 2025 18:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813430; cv=none; b=M3EWtmQc1lnYIqN5uEX+Sl2DEpW+a4fpWwxhvmviNx40rv2m8uhtBfiQi9tHbfxhZF0P9yWcxZvu1CWqEaZTNbrrr6Zrj4tyFQkIaPHzYuoyhiWyQmXqLUlFKQ4/xVqYnHOyGvUhaAd8hhfccZRfu8KSeiyfZjtV9FPKNflDnrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813430; c=relaxed/simple;
	bh=ZbMlIroQLoxj8A1deIEvJvS3q174J5TJ5+uln+kQ8oM=;
	h=Message-ID:Date:From:To:Cc:Subject; b=IKE3QeoE6UIGzR678a6mPJSofvZKOZuhC0YNcqwRWO//5pjgVi7jjKAMQpk6cv33eUeqY/8wXbMhWlULKc4MSXlHe6eIgCDlHGzGOxSI+/uuI271rN623uB09WQ7opUJuWK8Ilvc0tsV3CkYJ4iwYA1lEA6/LmSqpbEa9D3ghrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyrbTl+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402ABC4CEEF;
	Tue, 29 Jul 2025 18:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753813430;
	bh=ZbMlIroQLoxj8A1deIEvJvS3q174J5TJ5+uln+kQ8oM=;
	h=Date:From:To:Cc:Subject:From;
	b=NyrbTl+wAgkkei1BZ67guO2vltNHRcNLkdwpxgpKlo+ux9xpVnx2338WFkD0rwqtz
	 njnVNR/OyHHamAUL4aBdpS2GVv5ae4nC2r4hW4hU7Rq9Go071j4XFFtfzYhw7tCZyM
	 4HmBYFsTVBQRc83XQheDkH1/UV6wKkvWWu6F0TafrVJEXrYn4YxpdvRESzmpFmvB3c
	 ssmwPJEEBGcfSqq9HaC8BU3GSJanHAVceA01hQvyBxmQ73J3V3RclP+YHqvozVV9Zr
	 BzLkQsfrvXONjdfTxUoq8P9TpGT6eONXchZUN9K6Odml5JKcYMLOeV/Qh5VjW7Mc60
	 tHhoQLaJWNBZw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ugozc-000000054xw-3y87;
	Tue, 29 Jul 2025 14:24:04 -0400
Message-ID: <20250729182304.965835871@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 29 Jul 2025 14:23:04 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
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
Subject: [PATCH v16 00/10] unwind_user: Deferred unwinding infrastructure
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>


Jen Remus suggested some updates from v15:

  https://lore.kernel.org/linux-trace-kernel/20250725185512.673587297@kernel.org/

Those were:

- Make fp_frame into a constant

- Removed useless initializing ra variable to zero
    
  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
unwind/core

Head SHA1: cf079f0176cc16e937f0fd868f0ec2d649ad53dd


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

