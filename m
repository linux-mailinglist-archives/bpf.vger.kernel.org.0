Return-Path: <bpf+bounces-66822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB98EB39BFA
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 13:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E86CC16A9FF
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 11:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F8030EF7F;
	Thu, 28 Aug 2025 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J90mXeI/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6091614EC73
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756381820; cv=none; b=YZui3uIBb74JNDSWZy9X9LJw8Tj6HpMQPFDDUBiET2hp8U/GrJLN9SeQvAmyjDFsot2aITD2NsrA92v+X4GlwLCCSTC6zVuoXrvoAoSCzTfMZiWQeh0wd8k1Vn+oo7vL4xf43Ocfthix+bx6epOP44aOSU4HTJ8CuYOHe5jya+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756381820; c=relaxed/simple;
	bh=kbGSPAMgxZf5tV9gvLx5eUQe1pQ7TTRkm3Q8PtH3S/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J40eZ/D8aQfDV27TPt9Vpj+BtiLoMxwrUCQKoXJn2KERW5Z2UR5yuEM/v9nGIPr922oEbgCV48kLkZsWZua6urTuV+W2mffV3vbenMopDTpnQAM+jzU7Jz5gjEKBfDovhVZmbKF9TgU5MHYGT5reYjWO3ENWCDVr+8KWKSu9eRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J90mXeI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA916C4CEEB;
	Thu, 28 Aug 2025 11:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756381819;
	bh=kbGSPAMgxZf5tV9gvLx5eUQe1pQ7TTRkm3Q8PtH3S/Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=J90mXeI/kS4OHWAy8fh6My25/W2bzqeFmeuLypkRoyuGtWA/9ynerRiBaywW74XZz
	 Qct0ghIthWQPQdzvmaPYUpdxgA/xTvGJkuIwS18lyl4fR12sl7vu9XiJI/MJsULvaB
	 qqGN/YJv8hV7YRS3kl90iIY+cJLAv06lzqh/KKZJkswr40jKysecjJJwXhtD6WmblB
	 eCwz6BD5EqAyCt6RQlC0Gbg1P6XCxhXSwxXir83bCpFTKy76PIQ8m7hVtLFNfRaJBu
	 DN4dAOWXAFAc6b6a9u9g9HCslpKEup/M3UuCDIpZrWITRNmI+6pR35QyJ28sw5kIy4
	 w/8Ya2sCCN8OA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 82FEDCE0D09; Thu, 28 Aug 2025 04:50:19 -0700 (PDT)
Date: Thu, 28 Aug 2025 04:50:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [BUG] Deadlock triggered by bpfsnoop funcgraph feature
Message-ID: <93e75cff-871f-4b49-868c-11fea0eec396@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a08c7c19-1831-481f-9160-0583d850347a@linux.dev>
 <CAADnVQJz9ekB_LjSjRzJLmM_fvdCbeA+pFY20xviJ-qgwFtXWw@mail.gmail.com>
 <8dcc144e-3142-4e0d-a852-155781e41eb4@linux.dev>
 <CAADnVQLDG=Oavh9He=ivXm9MPwsqWHttbTYQh1-EZuHpwujaBA@mail.gmail.com>
 <b3463ffa-c2cb-43c8-a0d2-92bad49e3c23@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3463ffa-c2cb-43c8-a0d2-92bad49e3c23@linux.dev>

On Thu, Aug 28, 2025 at 10:40:47AM +0800, Leon Hwang wrote:
> On 28/8/25 08:42, Alexei Starovoitov wrote:
> > On Tue, Aug 26, 2025 at 7:58 PM Leon Hwang <leon.hwang@linux.dev> wrote:
> >> On 27/8/25 10:23, Alexei Starovoitov wrote:
> >>> On Tue, Aug 26, 2025 at 7:13 PM Leon Hwang <leon.hwang@linux.dev> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> I’ve encountered a reproducible deadlock while developing the funcgraph
> >>>> feature for bpfsnoop [0].
> >>>
> >>> debug it pls.
> >>
> >> It’s quite difficult for me. I’ve tried debugging it but didn’t succeed.
> >>
> >>> Sounds like you're implying that the root cause is in bpf,
> >>> but why do you think so?
> >>>
> >>> You're attaching to things that shouldn't be attached to.
> >>> Like rcu_lockdep_current_cpu_online()
> >>> so effectively you're recursing in that lockdep code.
> >>> See big lock there. It will dead lock for sure.
> >>
> >> If a function that acquires a lock can be traced by a tracing program,
> >> bpfsnoop’s funcgraph will attempt to trace it as well. In such cases, a
> >> deadlock is highly likely to occur.
> >>
> >> With bpfsnoop I try my best to avoid such deadlock issues. But what
> >> about other bpf tracing tools? If they don’t handle this properly, the
> >> kernel is very likely to crash.
> > 
> > bpf infra is trying hard not to crash it, but debug kernel is a different
> > category. rcu_read_lock_held() doesn't exist in production kernels.
> > You can propose adding "notrace" for it, but in general that doesn't scale.
> > Same with rcu_lockdep_current_cpu_online().
> > It probably deserves "notrace" too.
> 
> Indeed, it doesn't scale.
> 
> When I run
> ./bpfsnoop -k "htab_*_elem" --output-fgraph --fgraph-debug
> --fgraph-exclude
> 'rcu_read_lock_*held,rcu_lockdep_current_cpu_online,*raw_spin_*lock*,kvfree,show_stack,put_task_stack',
> the kernel doesn’t panic, but the OS eventually stalls and becomes
> unresponsive to key presses.
> 
> It seems preferable to avoid running BPF programs continuously in such
> cases.

Agreed, when adding code to the Linux kernel, whether via a patch, via
a BPF program, or by whatever other means, you are taking responsibility
for the speed, scalability, and latency effects of that code.

Nevertheless, I am happy to add a few "notrace" modifiers
if needed.  Do you guys need them for rcu_read_lock_held() and
rcu_lockdep_current_cpu_online()?

							Thanx, Paul

