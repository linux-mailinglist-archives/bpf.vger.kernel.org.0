Return-Path: <bpf+bounces-54622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFCFA6EA35
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 08:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914A1188B831
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 07:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A73234969;
	Tue, 25 Mar 2025 07:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+vvW9E1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B5718C92F;
	Tue, 25 Mar 2025 07:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742886891; cv=none; b=OJyU1HVEvS3Z8rtoqA/nY34cDoaF17/o6NYniZiRoAhiOfo3xbOysQLro4fMTo685ltT9W2DQ2Q1CSAzUPaD4y6Kg3//QcZTk4GHDmt8+1SBIuSk66wqxYTelA0Z5L06HW/Vb7FafpJOBjKhQQtfc4p+9ooiUOHOgeh3OT1Tlpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742886891; c=relaxed/simple;
	bh=1TWK6NEmpcH3Tnhy1DMaTugnC9yzYdJK+FhaUnOaf+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoeXML92347KCvXfYAOjeV26APYT5Dz4UE7mqROHKg0HKdwAQw6en0N7yJUFQtVY3gQwYtjRI8jeJCLR5iE3Z4P/OvD52IPCjJ585WiZ/TWBN5e5X7vjs+sqrsqkXILwPDYlkpB/3dhqVscrQ3R45AnnIMBlOQobt5w271TpE8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+vvW9E1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8873C4CEE8;
	Tue, 25 Mar 2025 07:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742886890;
	bh=1TWK6NEmpcH3Tnhy1DMaTugnC9yzYdJK+FhaUnOaf+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W+vvW9E1INkCFnuFICYOL75WUKw5cWaz7HZXJHR0tQ3VZspFw8SLwGpALyQRj8xw2
	 X3WK8q8q9hGyDIqJUBGH4HZ/dFqoUBbtDxHGIml2Yfi+cCdBCcnneiN7NqA7ARK3LZ
	 jpGUih43Ag4baQS3CNOEBoLkpkpA8sqwy76vSpH82Iu4K9bS9Cy9qbafKPDPlhMmAx
	 T2mzcyVjBMoFhMKAksOW/O43OO5Z0Fgf5C/42ylQ1IBrFSXrp9xkw/+wmw8TNZ6Hjx
	 Q38BNMqJaLglsWwH0eWi0l69R7kzCKdwpysmIeOC3GXd3q4P+tH8FRzpi86g81RmYc
	 P955aOIhJGtEA==
Date: Tue, 25 Mar 2025 08:14:44 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
	bpf@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
	Greg Thelen <gthelen@google.com>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3] x86/alternatives: remove false sharing in
 poke_int3_handler()
Message-ID: <Z-JX5ImltdTFoFgr@gmail.com>
References: <20250325043316.874518-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325043316.874518-1-edumazet@google.com>


* Eric Dumazet <edumazet@google.com> wrote:

> eBPF programs can be run 50,000,000 times per second on busy servers.
> 
> Whenever /proc/sys/kernel/bpf_stats_enabled is turned off,
> hundreds of calls sites are patched from text_poke_bp_batch()
> and we see a huge loss of performance due to false sharing
> on bp_desc.refs lasting up to three seconds.
> 
>    51.30%  server_bin       [kernel.kallsyms]           [k] poke_int3_handler
>             |
>             |--46.45%--poke_int3_handler
>             |          exc_int3
>             |          asm_exc_int3
>             |          |
>             |          |--24.26%--cls_bpf_classify
>             |          |          tcf_classify
>             |          |          __dev_queue_xmit
>             |          |          ip6_finish_output2
>             |          |          ip6_output
>             |          |          ip6_xmit
>             |          |          inet6_csk_xmit
>             |          |          __tcp_transmit_skb
> 
> Fix this by replacing bp_desc.refs with a per-cpu bp_refs.
> 
> Before the patch, on a host with 240 cores (480 threads):
> 
> sysctl -wq kernel.bpf_stats_enabled=0
> 
> text_poke_bp_batch(nr_entries=164) : Took 2655300 usec
> 
> bpftool prog | grep run_time_ns
> ...
> 105: sched_cls  name hn_egress  tag 699fc5eea64144e3  gpl run_time_ns
> 3009063719 run_cnt 82757845 : average cost is 36 nsec per call
> 
> After this patch:
> 
> sysctl -wq kernel.bpf_stats_enabled=0
> 
> text_poke_bp_batch(nr_entries=164) : Took 702 usec
> 
> $ bpftool prog | grep run_time_ns
> ...
> 105: sched_cls  name hn_egress  tag 699fc5eea64144e3  gpl run_time_ns
> 1928223019 run_cnt 67682728 : average cost is 28 nsec per call
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  arch/x86/kernel/alternative.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)

Thanks for the updates. I've further improved the changelog (see 
attached below), and have tentatively applied it to 
tip:x86/alternatives.

Thanks,

	Ingo

==============================>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Mar 2025 04:33:16 +0000
Subject: [PATCH] x86/alternatives: Improve code-patching scalability by removing false sharing in poke_int3_handler()

eBPF programs can be run 50,000,000 times per second on busy servers.

Whenever /proc/sys/kernel/bpf_stats_enabled is turned off,
hundreds of calls sites are patched from text_poke_bp_batch()
and we see a huge loss of performance due to false sharing
on bp_desc.refs lasting up to three seconds.

   51.30%  server_bin       [kernel.kallsyms]           [k] poke_int3_handler
            |
            |--46.45%--poke_int3_handler
            |          exc_int3
            |          asm_exc_int3
            |          |
            |          |--24.26%--cls_bpf_classify
            |          |          tcf_classify
            |          |          __dev_queue_xmit
            |          |          ip6_finish_output2
            |          |          ip6_output
            |          |          ip6_xmit
            |          |          inet6_csk_xmit
            |          |          __tcp_transmit_skb

Fix this by replacing bp_desc.refs with a per-cpu bp_refs.

Before the patch, on a host with 240 cores (480 threads):

  $ sysctl -wq kernel.bpf_stats_enabled=0

  text_poke_bp_batch(nr_entries=164) : Took 2655300 usec

  $ bpftool prog | grep run_time_ns
  ...
  105: sched_cls  name hn_egress  tag 699fc5eea64144e3  gpl run_time_ns
  3009063719 run_cnt 82757845 : average cost is 36 nsec per call

After this patch:

  $ sysctl -wq kernel.bpf_stats_enabled=0

  text_poke_bp_batch(nr_entries=164) : Took 702 usec

  $ bpftool prog | grep run_time_ns
  ...
  105: sched_cls  name hn_egress  tag 699fc5eea64144e3  gpl run_time_ns
  1928223019 run_cnt 67682728 : average cost is 28 nsec per call

Ie. text-patching performance improved 3700x: from 2.65 seconds
to 0.0007 seconds.

Since the atomic_cond_read_acquire(refs, !VAL) spin-loop was not triggered
even once in my tests, add an unlikely() annotation, because this appears
to be the common case.

[ mingo: Improved the changelog some more. ]

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250325043316.874518-1-edumazet@google.com


