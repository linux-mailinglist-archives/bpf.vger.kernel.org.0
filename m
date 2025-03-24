Return-Path: <bpf+bounces-54603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 841C9A6D901
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 12:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485A1189009A
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 11:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C747725DD04;
	Mon, 24 Mar 2025 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M4mRsw0L"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A423200CB;
	Mon, 24 Mar 2025 11:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742815114; cv=none; b=tgen2j2504b5jXMd06PlOG+8hG/kEpt7CJuF6v3jPj9OHsLcNUTjy8QM75F8xSpdTopg/GRcia+IXy30iAvdDhYRuhQmW/+zsvsB1tmyqx5dMk6dBWYNXVxXIhkLxQ1haPTJf67voMbNgRwv1tVorOQ7THm+tKtIH3di4wUU7mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742815114; c=relaxed/simple;
	bh=ZqmTOH9CHDOzfwbC26hEeO5uBkNA+EhZHNdOSUiJrzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfqsPakWLccaln0U3EBkM83XHXyh5WKZy+9LxBtAH9bPqFFCeOcR9R5dWG7R3ivhG1+rA9tvLtUxPyGCk283JZFas1sWH7aD7/MyV9QR42q2LYiJ7cc88p/rs00zhjMAwU3BQ5GRSf218Y1/mfidaMC9iGz2aPP7b/36vPlKnko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M4mRsw0L; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WTJEmzGsIeYqe9DjdoX+7aXEfA9POxMXhYB6XA9pUwc=; b=M4mRsw0LsjEyFxwErQy5o+Z0AZ
	Xn93TgmntiU2IByaWxuPsL5agskcaG1cfnJc7Q3qcO+DUShwX02HcI4iJUpQw5qDwP0whmoSsOHaX
	u4O4MhUUH+4vMisKrGkEXHmrXiIUjmx1BK6qypJrHltx54gn73U6cHRmyEbhvqnzruAQhe73ReGNY
	fbba8hdQUa4cbBYllMKFug0eBHtP7xK7KV0e1rGsZmFN8CI1FTBkaFWvg+JbWcKFNID+TRaLVpgkQ
	GcHfsdGYnnDIwVTpVh5BgbeUkvgIjBgHIk49bLxwGao23KyvEZFTZ9wI9+ZRx9OtcsHOSc5988jZf
	Ndx6CBdA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1twfow-00000005Dhi-2qcb;
	Mon, 24 Mar 2025 11:18:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 08A693004AF; Mon, 24 Mar 2025 12:18:18 +0100 (CET)
Date: Mon, 24 Mar 2025 12:18:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
	bpf@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
	Greg Thelen <gthelen@google.com>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] x86/alternatives: remove false sharing in
 poke_int3_handler()
Message-ID: <20250324111817.GA14944@noisy.programming.kicks-ass.net>
References: <20250324083051.3938815-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324083051.3938815-1-edumazet@google.com>

On Mon, Mar 24, 2025 at 08:30:51AM +0000, Eric Dumazet wrote:
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
>             |          |          |
>             |          |          |--9.00%--tcp_v6_do_rcv
>             |          |          |          tcp_v6_rcv
>             |          |          |          ip6_protocol_deliver_rcu
>             |          |          |          ip6_rcv_finish
>             |          |          |          ipv6_rcv
>             |          |          |          __netif_receive_skb
>             |          |          |          process_backlog
>             |          |          |          __napi_poll
>             |          |          |          net_rx_action
>             |          |          |          __softirqentry_text_start
>             |          |          |          asm_call_sysvec_on_stack
>             |          |          |          do_softirq_own_stack
> 
> Fix this by replacing bp_desc.refs with a per-cpu bp_refs.
> 
> Before the patch, on a host with 240 cores (480 threads):
> 
> $ bpftool prog | grep run_time_ns
> ...
> 105: sched_cls  name hn_egress  tag 699fc5eea64144e3  gpl run_time_ns
> 3009063719 run_cnt 82757845
> 
> -> average cost is 36 nsec per call
> 
> echo 0 >/proc/sys/kernel/bpf_stats_enabled
> text_poke_bp_batch(nr_entries=2)
>         text_poke_bp_batch+1
>         text_poke_finish+27
>         arch_jump_label_transform_apply+22
>         jump_label_update+98
>         __static_key_slow_dec_cpuslocked+64
>         static_key_slow_dec+31
>         bpf_stats_handler+236
>         proc_sys_call_handler+396
>         vfs_write+761
>         ksys_write+102
>         do_syscall_64+107
>         entry_SYSCALL_64_after_hwframe+103
> Took 324 usec
> 
> text_poke_bp_batch(nr_entries=164)
>         text_poke_bp_batch+1
>         text_poke_finish+27
>         arch_jump_label_transform_apply+22
>         jump_label_update+98
>         __static_key_slow_dec_cpuslocked+64
>         static_key_slow_dec+31
>         bpf_stats_handler+236
>         proc_sys_call_handler+396
>         vfs_write+761
>         ksys_write+102
>         do_syscall_64+107
>         entry_SYSCALL_64_after_hwframe+103
> Took 2655300 usec
> 
> After this patch:
> 
> $ bpftool prog | grep run_time_ns
> ...
> 105: sched_cls  name hn_egress  tag 699fc5eea64144e3  gpl run_time_ns
> 1928223019 run_cnt 67682728
> 
>  -> average cost is 28 nsec per call
> 
> echo 0 >/proc/sys/kernel/bpf_stats_enabled
> text_poke_bp_batch(nr_entries=2)
>         text_poke_bp_batch+1
>         text_poke_finish+27
>         arch_jump_label_transform_apply+22
>         jump_label_update+98
>         __static_key_slow_dec_cpuslocked+64
>         static_key_slow_dec+31
>         bpf_stats_handler+236
>         proc_sys_call_handler+396
>         vfs_write+761
>         ksys_write+102
>         do_syscall_64+107
>         entry_SYSCALL_64_after_hwframe+103
> Took 519 usec
> 
> text_poke_bp_batch(nr_entries=164)
>         text_poke_bp_batch+1
>         text_poke_finish+27
>         arch_jump_label_transform_apply+22
>         jump_label_update+98
>         __static_key_slow_dec_cpuslocked+64
>         static_key_slow_dec+31
>         bpf_stats_handler+236
>         proc_sys_call_handler+396
>         vfs_write+761
>         ksys_write+102
>         do_syscall_64+107
>         entry_SYSCALL_64_after_hwframe+103
> Took 702 usec

This is unreadable due to the amount of pointless repetition.

Also, urgh.

