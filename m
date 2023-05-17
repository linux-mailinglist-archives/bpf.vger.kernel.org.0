Return-Path: <bpf+bounces-802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F537707000
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 19:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B492815AB
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 17:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4BB31EED;
	Wed, 17 May 2023 17:51:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0A92106B
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 17:51:51 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29A4544AB;
	Wed, 17 May 2023 10:51:29 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3DF0D20F26A4;
	Wed, 17 May 2023 10:51:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3DF0D20F26A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1684345888;
	bh=qpe8jAdw/uTx0WBX7F2OU2VfCTXiTsm/V82/ZFGMen0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MiC4f/ygA75UgAvtPkYRmlbjAm7/lP4XmodFNURRXYZpXK8o+biLnVoXSHPqFH2AU
	 sb1nu3zsVJEhyPCeJFr/9SuB2ZsiOiAD4ctbky6yWgmVmNwo+1h9OhRY+mqtMFcIhA
	 cNr5Og8uycMMz8xQiAWhin7wo22poEJH8qLO3ew4=
Date: Wed, 17 May 2023 10:51:21 -0700
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	David Vernet <void@manifault.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	dthaler@microsoft.com, brauner@kernel.org, hch@infradead.org
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-ID: <20230517175121.GA200@W11-BEAU-MD.localdomain>
References: <20230508163751.841-1-beaub@linux.microsoft.com>
 <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
 <20230509130111.62d587f1@rorschach.local.home>
 <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
 <20230515192407.GA85@W11-BEAU-MD.localdomain>
 <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 16, 2023 at 05:36:28PM -0700, Alexei Starovoitov wrote:
> On Mon, May 15, 2023 at 12:24:07PM -0700, Beau Belgrave wrote:
> > > > 
> > > > 	ret = pin_user_pages_remote(mm->mm, uaddr, 1, FOLL_WRITE | FOLL_NOFAULT,
> > > > 				    &page, NULL, NULL);
> > > 
> > > ... which will call pin_user_pages_remote() in RCU CS.
> > > This looks buggy, since pin_user_pages_remote() may schedule.
> > > 
> > 
> > If it's possible to schedule, I can change this to cache the probe
> > callbacks under RCU then drop it. However, when would
> > pin_user_pages_remote() schedule with FOLL_NOFAULT? 
> 
> Are you saying that passing FOLL_NOFAULT makes it work in atomic context?
> Is this documented anywhere?
> 
> > I couldn't pick up
> > where it might schedule?
> 
> I think I see plenty of rw_semaphore access in the guts of GUP.
> 
> Have you tested user events with CONFIG_DEBUG_ATOMIC_SLEEP?
> 

This pops on ATOMIC_SLEEP, thanks for pointing this out. I missed that
the gup retry statement is a fallthrough. PROVE_RCU/LOCKING didn't catch
this, lesson learned.

[...]

> > 
> > I thought it being a GPL export symbol that this kind of stuff would be
> > documented somewhere if there are requirements to use the method. As it
> 
> EXPORT_SYMBOL_GPL(perf_trace_run_bpf_submit);
> does not mean that any arbitrary code in the kernel or GPL-ed module
> is free to call it whichever way they like.
> It's an export symbol only because modules expose tracepoints.
> It's an implementation detail of DECLARE_EVENT_CLASS macro and
> can change at any time including removal of export symbol.
> 

Ok, guess I'm looking for what best to do here that is least likely to
break and also allows potentially the BPF program to grab further user
memory within it (I guess this means using sleepable BPF, should I
follow what uprobes did?).

> > stands in the patch, the data that is sent to BPF is from the buffer
> > returned from perf_trace_buf_alloc() after it has been copied from the
> > user process.
> > 
> > If the process crashes, that shouldn't affect the actual data. The
> > tracepoint remains even upon a crash. If you try to unregister the
> > tracepoint while BPF is attached, it is prevented, as the tracepoints
> > are ref-counted and cannot be unregistered if anything is using it
> > (user processes, ftrace, perf/bpf).
> > 
> > We have been using libbpf to attach and monitor user_events with this
> > patch and haven't hit issues for what we plan to use it for (decode
> > the payload, aggregate, and track what's happening per-TID/PID). The
> > data we care about is already in kernel memory via the perf trace
> > buffer.
> 
> What bpf prog type do you use? How does libbpf attach it?
> You have to provide a patch for selftest/bpf/ for us to meaningfully review it.
> 

This is how I wired up libbpf via libbpf-bootstrap for the sample that's
checked in:
struct example {
    unsigned long long unused;
    int count;
};

SEC("tp/user_events/test")
int handle_tp(struct example *ctx)
{
        int pid = bpf_get_current_pid_tgid() >> 32;

        bpf_printk("BPF triggered from PID %d, count=%d.\n", pid, ctx->count);

        return 0;
}

I'm not sure if tp is referencing traditional tracepoint or not
(guessing it is).

> > 
> > > In general we don't want bpf to be called in various parts of the kernel
> > > just because bpf was used in similar parts elsewhere.
> > > bpf needs to provide real value for a particular kernel subsystem.
> > > 
> > 
> > For sure. I've had a lot of requests within Microsoft to wire up BPF to
> > user_events which prompted this patch. I've been in a few conversations
> > where we start talking about perf_event buffers and teams stop and ask
> > why it cannot go to BPF directly.
> 
> So you need perf_event buffers or ftrace ring buffer (aka trace_pipe) ?
> Which one do you want to use ?
> 

We use both, depending on the situation. Local debugging we typically
use ftrace since it's quite easy to use. In production we use perf_event
buffers mainly.

> > Yeah, keep consistent was more about using the GPL export symbol, which
> > the kernel tracepoints currently utilize. I wanted to avoid any special
> > casing BPF needed to add for user_events, and I also expect users would
> > like one way to write a BPF program for tracepoints/trace_events even
> > if they are from user processes vs kernel.
> 
> BPF progs have three ways to access kernel tracepoints:
> 1. traditional tracepoint
> 2. raw tracepoint
> 3. raw tracepoint with BTF
> 
> 1 was added first and now rarely used (only by old tools), since it's slow.
> 2 was added later to address performance concerns.
> 3 was added after BTF was introduced to provide accurate types.
> 
> 3 is the only one that bpf community recommends and is the one that is used most often.
> 
> As far as I know trace_events were never connected to bpf.
> Unless somebody sneaked the code in without us seeing it.
> 
> I think you're trying to model user_events+bpf as 1.
> Which means that you'll be repeating the same mistakes.
> 

See above, asking for guidance.

> > 
> > > Beau,
> > > please provide a detailed explanation of your use case and how bpf helps.
> > > 
> > 
> > There are teams that have existing BPF programs that want to also pull
> > in data from user processes in addition to the data they already collect
> > from the kernel.
> > 
> > We are also seeing a trend of teams wanting to drop buffering approaches
> > and move into non-buffered analysis of problems. An example is as soon
> > as a fault happens in a user-process, they would like the ability to see
> > what that thread has done, what the kernel did a bit before the error
> > (or other processes that have swapped in, etc).
> 
> Sounds like bpf prog would need to access user memory.
> What we've learned the hard way that you cannot do it cleanly from the kernel
> tracepoint/trace_event/perf_event (and user_event in your case).
> The only clean way to do it is from uprobe where it's user context and it is
> sleepable and fault-able. That's why we've added 'sleepable bpf uprobes'.
> 
> Just going with perf_trace_run_bpf_submit() you'll only have 'best effort' access
> to user data. Not recommended.
> 

Good to know, do you recommend then how uprobes did this? These are in
user context via write()/writev(). I don't see why I wouldn't pick
sleepable / faultable if it offers better options to folks.

[...]

> > We've used branch + syscall approaches in Windows for a long time and
> > have found them to work well in these locked down environments as well
> > as for JIT'd languages like C#.
> 
> Ok. Looks like we've got to the main reason for user_events.
> Re-phrasing above statement. User_events-like facility existed in Windows
> and we've decided to implement the same in Linux to have common framework
> to monitor applications in both OSes.
> Are you planning to extend bpf-for-windows to attach to window's equivalent
> of user_events ?
> If so, we can allow bpf progs to be attached to user_events in Linux.
> Please send a proper patch with [PATCH bpf-next] subject targeting bpf-next
> with selftest and clear explanation of the true reason.
> 

Happy to.

> Also think hard whether repeating our prior tracepoint+bpf mistakes is
> really want you want to do with user_events+bpf.

It sounds like I should look into sleepable BPF, which I will do, but
I'll wait to get you advice on this before sending a patch, etc.

Thanks,
-Beau

