Return-Path: <bpf+bounces-63089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B37B025C5
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 22:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2974F7ADB96
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 20:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408EC1F4181;
	Fri, 11 Jul 2025 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZty94Ez"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD71B1F3B83;
	Fri, 11 Jul 2025 20:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752265591; cv=none; b=M94BTcZPTO/ao9LSRhwEv/VKoiT8/iW3GNXV+z5zkgc/7xEViJOVRufkc6EcSj3G0ZyEy8QZiCc2M/hVjkY0wimuZ7xCidytOX0JigXhdp5krrrKJmYy225a5JH95bmnrMOAlS8ea3FT7HL5C8JebRiD167Oho959CizFYI7wVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752265591; c=relaxed/simple;
	bh=zKrzcOnCHUbj1zpcoKwKR8VG4KSswYK1nelmipRVgEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkHT2HCRAihdKqS0qxGjyypKcIemC5Dk3I2u2VlPPnxtWN8XEl4fxeBLwsXd0XIb9tU9Y/VE7kBhAx8kebYrbFoaN5eK4DgU7DyI+21xDlS+YwaQRYsJLrmrNqV89HnC8VrFRaLPF+W75t1U6LprW7xxJE36/OsVdFNj3WY7/a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZty94Ez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80926C4CEED;
	Fri, 11 Jul 2025 20:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752265591;
	bh=zKrzcOnCHUbj1zpcoKwKR8VG4KSswYK1nelmipRVgEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sZty94EzXu9ZGA3d79jnP7xeZIQ+FddaAmdFFBCuYZasAlqflfiw8zpn62X+Pu6oz
	 /SrDhdiyMvf/OIiQHoCdGr1KT32HAR0NSKMHca42W6xnOAC2vyOCb4/J87Ds1WgoRB
	 AUUp5w8dDMjBsfs5NNPJHG0mWVWYtkBXxnzlBLhYOKUX1DQKTmKqueeZ0B9nt9qhMi
	 tXvbd7wgK6K4nDKLIFWkYHoAKrGPBswnH/n6NDqs9G9a+a2R3+skjjSryVm4pHPhpF
	 sxNDzQo3Dz/+1avKMPQh1PeMGXV4sywDvrRNbJVCOHjGbUy/ce/ZXlncPfRN1XrPsC
	 dhRFQoYswVdog==
Date: Fri, 11 Jul 2025 13:26:28 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
	Sam James <sam@gentoo.org>
Subject: Re: [PATCH v13 00/11] perf: Support the deferred unwinding
 infrastructure
Message-ID: <aHFzdCv3-BRw9btW@google.com>
References: <20250708020003.565862284@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250708020003.565862284@kernel.org>

Hi Steve,

On Mon, Jul 07, 2025 at 10:00:03PM -0400, Steven Rostedt wrote:
> This is based on top of the deferred unwind core patch series:
> 
>  https://lore.kernel.org/linux-trace-kernel/20250708012239.268642741@kernel.org/
>    git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
>      unwind/core
> 
> This series implements the perf interface to use deferred user space stack
> tracing.
> 
> The code for this series is located here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> unwind/perf
> 
> Changes since v12: https://lore.kernel.org/linux-trace-kernel/20250701180410.755491417@goodmis.org/
> 
> - Also check against PF_USER_WORKER as io workers do not have PF_KTHREAD
>   set.
> 
> - Removed deferred_request_nmi() and have NMIs just use the normal
>   deferred_request() function. As Peter Zijlstra has stated, in_nmi() can
>   nest because some exceptions set in_nmi() and another NMI could come in.
> 
> - Removed use of timestamp. The deferred unwind has gone back to using
>   cookies, and perf doesn't use the cookie. This means the
>   struct perf_callchain_deferred_event is not modified.

What about adding the cookies in the records to handle lost data?  Even
if it's not necessary to match callchains to samples, it still needs to
reject invalid callchains across the losts.  Maybe it can just flush
pending samples when it sees LOST records and not try to match them but
having the cookies will handle it more accurately as some callchains may
be valid after the LOST.

Thanks,
Namhyung

> 
> Head SHA1: 3d88d03d533ede8d2d513942e768607aa9279c4b
> 
> 
> Josh Poimboeuf (5):
>       perf: Remove get_perf_callchain() init_nr argument
>       perf: Have get_perf_callchain() return NULL if crosstask and user are set
>       perf: Simplify get_perf_callchain() user logic
>       perf: Skip user unwind if the task is a kernel thread
>       perf: Support deferred user callchains
> 
> Namhyung Kim (4):
>       perf tools: Minimal CALLCHAIN_DEFERRED support
>       perf record: Enable defer_callchain for user callchains
>       perf script: Display PERF_RECORD_CALLCHAIN_DEFERRED
>       perf tools: Merge deferred user callchains
> 
> Steven Rostedt (2):
>       perf: Use current->flags & PF_KTHREAD|PF_USER_WORKER instead of current->mm == NULL
>       perf: Support deferred user callchains for per CPU events
> 
> ----
>  include/linux/perf_event.h                |  13 +-
>  include/uapi/linux/perf_event.h           |  19 +-
>  kernel/bpf/stackmap.c                     |   8 +-
>  kernel/events/callchain.c                 |  49 ++--
>  kernel/events/core.c                      | 407 +++++++++++++++++++++++++++++-
>  tools/include/uapi/linux/perf_event.h     |  19 +-
>  tools/lib/perf/include/perf/event.h       |   7 +
>  tools/perf/Documentation/perf-script.txt  |   5 +
>  tools/perf/builtin-script.c               |  92 +++++++
>  tools/perf/util/callchain.c               |  24 ++
>  tools/perf/util/callchain.h               |   3 +
>  tools/perf/util/event.c                   |   1 +
>  tools/perf/util/evlist.c                  |   1 +
>  tools/perf/util/evlist.h                  |   1 +
>  tools/perf/util/evsel.c                   |  39 +++
>  tools/perf/util/evsel.h                   |   1 +
>  tools/perf/util/machine.c                 |   1 +
>  tools/perf/util/perf_event_attr_fprintf.c |   1 +
>  tools/perf/util/sample.h                  |   3 +-
>  tools/perf/util/session.c                 |  78 ++++++
>  tools/perf/util/tool.c                    |   2 +
>  tools/perf/util/tool.h                    |   4 +-
>  22 files changed, 742 insertions(+), 36 deletions(-)

