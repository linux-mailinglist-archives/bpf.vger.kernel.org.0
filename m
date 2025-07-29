Return-Path: <bpf+bounces-64642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CC8B15267
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 19:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1F53BE7D7
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 17:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F38298CA5;
	Tue, 29 Jul 2025 17:58:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1E3204863;
	Tue, 29 Jul 2025 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753811884; cv=none; b=clSY8IBpHcGKsBmNGtBqyfjxkxGGEwnDBCXUYXz0UOcIOxFqdhCflWNy1OpnQV2ijNRYhGspsBmB7zl/UmwxQUt7+ifZSagARXJlbSW5JGmg9VN6QxdKyIKZMAFNduL7R5MagYEVfn/fFwBZBLJa2+bMOg9wq19Besnv+/LBMhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753811884; c=relaxed/simple;
	bh=U/74mzNRUhQ2kOiWIB9iaSqV9T8z0T7jtPCPSrkVAsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7lpVe2l/DjMNXAilYUL1fAbYhV/47ys3mtVGyth5XbP/5WP/4zDmYNw5fP6dsmzJ+inhsXwGdi3rqVusoDVAmo+wFg1V7rECgjg6OM1c43hEf6PnXS6zQ5ZI/yHERNvNkSBDshOdp/kKRIXoRN57/7f3FtgDFOzN95JZKC/8hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D24E61516;
	Tue, 29 Jul 2025 10:57:52 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA4C33F5A1;
	Tue, 29 Jul 2025 10:57:57 -0700 (PDT)
Date: Tue, 29 Jul 2025 18:57:40 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Florent Revest <revest@google.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [RFC 00/10] ftrace,bpf: Use single direct ops for bpf trampolines
Message-ID: <aIkLlB7Z7V--BeGi@J2N7QTR9R3.cambridge.arm.com>
References: <20250729102813.1531457-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729102813.1531457-1-jolsa@kernel.org>

Hi Jiri,

[adding some powerpc and riscv folk, see below]

On Tue, Jul 29, 2025 at 12:28:03PM +0200, Jiri Olsa wrote:
> hi,
> while poking the multi-tracing interface I ended up with just one
> ftrace_ops object to attach all trampolines.
> 
> This change allows to use less direct API calls during the attachment
> changes in the future code, so in effect speeding up the attachment.

How important is that, and what sort of speedup does this result in? I
ask due to potential performance hits noted below, and I'm lacking
context as to why we want to do this in the first place -- what is this
intended to enable/improve?

> However having just single ftrace_ops object removes direct_call
> field from direct_call, which is needed by arm, so I'm not sure
> it's the right path forward.

It's also needed by powerpc and riscv since commits:

  a52f6043a2238d65 ("powerpc/ftrace: Add support for DYNAMIC_FTRACE_WITH_DIRECT_CALLS")
  b21cdb9523e5561b ("riscv: ftrace: support direct call using call_ops")

> Mark, Florent,
> any idea how hard would it be to for arm to get rid of direct_call field?

For architectures which follow the arm64 style of implementation, it's
pretty hard to get rid of it without introducing a performance hit to
the call and/or a hit to attachment/detachment/modification. It would
also end up being a fair amount more complicated.

There's some historical rationale at:

  https://lore.kernel.org/lkml/ZfBbxPDd0rz6FN2T@FVFF77S0Q05N/

... but the gist is that for several reasons we want the ops pointer in
the callsite, and for atomic modification of this to switch everything
dependent on that ops atomically, as this keeps the call logic and
attachment/detachment/modification logic simple and pretty fast.

If we remove the direct_call pointer from the ftrace_ops, then IIUC our
options include:

* Point the callsite pointer at some intermediate structure which points
  to the ops (e.g. the dyn_ftrace for the callsite). That introduces an
  additional dependent load per call that needs the ops, and introduces
  potential incoherency with other fields in that structure, requiring
  more synchronization overhead for attachment/detachment/modification.

* Point the callsite pointer at a trampoline which can generate the ops
  pointer. This requires that every ops has a trampoline even for
  non-direct usage, which then requires more memory / I$, has more
  potential failure points, and is generally more complicated. The
  performance here will vary by architecture and platform, on some this
  might be faster, on some it might be slower.

  Note that we probably still need to bounce through an intermediary
  trampoline here to actually load from the callsite pointer and
  indirectly branch to it.

... but I'm not really keen on either unless we really have to remove 
the ftrace_ops::direct_call field, since they come with a substantial
jump in complexity.

Mark.


> 
> thougts? thanks,
> jirka
> 
> 
> ---
> Jiri Olsa (10):
>       ftrace: Make alloc_and_copy_ftrace_hash direct friendly
>       ftrace: Add register_ftrace_direct_hash function
>       ftrace: Add unregister_ftrace_direct_hash function
>       ftrace: Add modify_ftrace_direct_hash function
>       ftrace: Export some of hash related functions
>       ftrace: Use direct hash interface in direct functions
>       bpf: Add trampoline ip hash table
>       ftrace: Factor ftrace_ops ops_func interface
>       bpf: Remove ftrace_ops from bpf_trampoline object
>       Revert "ftrace: Store direct called addresses in their ops"
> 
>  include/linux/bpf.h           |   8 +-
>  include/linux/ftrace.h        |  51 ++++++++++---
>  kernel/bpf/trampoline.c       |  94 +++++++++++++-----------
>  kernel/trace/ftrace.c         | 481 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------
>  kernel/trace/trace.h          |   8 --
>  kernel/trace/trace_selftest.c |   5 +-
>  6 files changed, 395 insertions(+), 252 deletions(-)

