Return-Path: <bpf+bounces-57487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AACAABB21
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 09:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0823F16BDA4
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 07:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028071F4CAE;
	Tue,  6 May 2025 05:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZaSEZ2R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958A720A5F1
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 05:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746510939; cv=none; b=gUFWKMLYqAydtN4v4Zn6/rsT0R+OjFMIvjRXw/HVwHAHzE6g1JZDe6Kr1I+/tck6gQ2+RA7cy2lu1nIaIFT6+qFjC0yUwT9I7pmKaQHnn1CgOG9YPTwKXp4L9IDo8BHVNdx1CdjptaIFKviy9B6kS0WIG4Tt7iz0YlpuHiVpKto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746510939; c=relaxed/simple;
	bh=BMXBwSWzXVf9klOghQ+EmqxlW6KppmhXS16ku7jTrr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cs9mJ9qsuxNZvmBWgiyn6YBAtXlpWx9QbFn7AckDvnjkKXolw2b8R3htWPZmwzDVJ/4WZTTc9xhccrGUMgFUveOdmqA3vytEtQPqdVz+SYdxfZJN545bku59SEhj+rTSyjqDvY576w88268TvWdJgQz+9S+MfX0IjUYNAwCbeLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZaSEZ2R; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6fead015247so46958277b3.2
        for <bpf@vger.kernel.org>; Mon, 05 May 2025 22:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746510936; x=1747115736; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c3Ro5KrXqA9wFQDPhYscomJ7/Bl1ukkOlUsLk+x5Xv8=;
        b=ZZaSEZ2RJwCbqvW+uiH+0ivj8TV6sKKSX1dy7S/hfXCScqD0x7BupqFsvdfF/040H3
         rkvZ2n6CePexPk8p4ImBdLsr/EQ6ts7P0cgYfRwRoK6jckoziFRrrB0OcYfpo5yjMfwA
         g9xTHJmRvzDF1veVi27O2VN8wah7TyZuLo3M7PQKlmDVCsIkREmXDSN4MbVgYBtJ3BFi
         Mm4eRIK5F56o0KyOJcZOaazf7QtGwY0d0lzH3Vr5eMxtcbtv1UHDGRsnS0kVyvDXYb4E
         Hbxh0glp2al6qwBYpC6l0HyBlxgXkpYc548h+xUmCIHwfBka81wADUWdL3WcIA2o1Kto
         FXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746510936; x=1747115736;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c3Ro5KrXqA9wFQDPhYscomJ7/Bl1ukkOlUsLk+x5Xv8=;
        b=Qj3xWnZ4xewO5KRqvgj+d0mbvnq5AYv7nyF0eW4fN3WIeNzpCaGkPjiY1CsQERLFzq
         wrjjh0ZzuCN8uwvLJVQGYIo4tpX2a0Rs3BYlItscj7y1sYNV30FqGY+138Kl/C/MXxGB
         lAYNEXFEHGDxod1W872QHbvsNfxTc6+LaUwGxXTKAe738C/iU/lTctPPcMZ+39JhRCgO
         bov7T0iR3KI+kEvvm6yoRs7cTQJx+0RIZvDEnFdu2PxHTa4Sv6y6Dl6jjoIj90CHRa6I
         P9z+CVfA2+aPfmfPdRz6MqWBT626c45P5iz4SRHtIvk1Qi/rXE38xOnMT1IN9Jtf4DTd
         0u+g==
X-Gm-Message-State: AOJu0YyTyx0ZM17lVoZ9ZDHqu3jPbikWJ/Sah3+og724EICu6Wc0I1XR
	yMggJMtpOusEMxMT4Zy6Jk2MXRONHVauRtWkv91FzpZPmnK9Xavfgwl7tnVwmXo57xmJwkTpVL0
	vygh4cOOTu87oUs98k0FYsCQ6Dxc=
X-Gm-Gg: ASbGncs+0MhyXIVFqHs+xvj8x0kw+MaYgfNCl0QZMmNz79qflm3op7sJgNw8ACVp4nA
	nak1evbNChrcXtkKDnHZtemZWdr5kPMZXaQnd1JLAFBt78sfvzjGsH9Q6xi7USF//J8c7WLOpAg
	zxzO8jPs/KGagNcXSVho5ai66hrcH6HMNCbbc5wPago6byh8HcNnyKR58=
X-Google-Smtp-Source: AGHT+IGp6TEadT/Mjhkq3Bl0hoq3Ssii6Xs70zUKD1bw1PHzX81fMBfEQif/fAJoXbHhdzC4TFLnNlHLoYgL2/BWjHQ=
X-Received: by 2002:a05:690c:3690:b0:6ef:6536:bb6f with SMTP id
 00721157ae682-708eaf057c5mr133489587b3.22.1746510936277; Mon, 05 May 2025
 22:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420105524.2115690-1-rjsu26@gmail.com> <CAP01T75B87Vnq-kdq6gaNXj5xeOOiah-onm4weEZA=jm8W8JVQ@mail.gmail.com>
In-Reply-To: <CAP01T75B87Vnq-kdq6gaNXj5xeOOiah-onm4weEZA=jm8W8JVQ@mail.gmail.com>
From: Raj Sahu <rjsu26@gmail.com>
Date: Mon, 5 May 2025 22:55:20 -0700
X-Gm-Features: ATxdqUHUCRif2uAl5rg5kX3Rut-yBqGWAZm0CRm7DA_wL0SubOIH9fUEwUlu6fY
Message-ID: <CAM6KYsuk060Fv43Djp4q57AwBcmmkHBitGgfSsCJZwbGqRmQEA@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/4] bpf: Fast-Path approach for BPF program Termination
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, djwillia@vt.edu, 
	miloc@vt.edu, ericts@vt.edu, rahult@vt.edu, doniaghazy@vt.edu, 
	quanzhif@vt.edu, jinghao7@illinois.edu, sidchintamaneni@gmail.com
Content-Type: text/plain; charset="UTF-8"

<SNIP>
> Thanks for sending out the code and cover letter, much appreciated!
Thanks for taking out time and providing your feedback as well!

> I will keep aside opinions on which of 'fast execute' vs
> 'panic/unwind' feel semantically cleaner, since it's hard to have an
> objective discussion on that. One can argue about abstract concepts
> like complexity vs clean design either way.

> Instead just some questions/comments on the design.
>
> >
> > Existing termination approach like the BPF Exception or Runtime hooks [5] have
> > the issue of either lack of dynamism or having runtime overheads: BPF
> > Exceptions: Introduces bpf_throw() and exception callbacks, requiring stack
> > unwinding and exception state management.
>
> I feel there is an equal amount of state management here, it's just
> that it's not apparent directly, and not reified into tables etc.
> One of the (valid) concerns with unwinding is that preparing tables of
> objects that need to be released requires the verifier/runtime to be
> aware of each resource acquiring functions.
> Every time you add a new kfunc that acquires some resource, you'd have
> to update some place in the kernel to make sure it gets tracked for
> clean up too.
>
> But that would be equally true for this case:
> - The verifier must know which functions acquire resources, so that it
> can replace them with stubs in the cloned text.
> - Thus, every time a new kfunc is added, one must introduce its noop
> stub and add it to _some_ mapping to acquire kfuncs with their stubs.
>
> > Cleanup can only be done for pre-defined cancellation points.
>
> But can you terminate the program at any arbitrary point with this? It
> doesn't seem likely to me. You still have designated points where you
> stub empty calls instead of ones which return resources. You will jump
> to the return address into the cloned stub on return from an interrupt
> that gives you control of the CPU where the program is running. But
> apart from the stub functions, everything else would be kept the same.
>
> I think you are conflating the mechanism to clean up resources
> (unwinding, this (speed-run-to-exit/fast-execute), runtime log of
> resources), with the mechanism to enforce termination.
>
> Both are mutually exclusive, and any strategy (probing a memory
> location from the program with strategically placed instrumentation,
> watchdog timers, probing rdtsc to do more granular and precise
> accounting of time spent, etc.) can be combined with any mechanism to
> perform cleanup. There is no necessity to bind one with the other.
> Depending on different program types, we may need multiple strategies
> to terminate them with the right amount of precision.

We are trying to identify if the fast-path solution can serve certain use-cases
even slightly better or atleast complement the existing unwind approach.

> We may do something coarse for now (like watchdogs), but separation of
> concerns keeps doors open.

Right. That's something we have in mind too.

<SNIP>
> > TODOs:
> > - Termination support for nested BPF programs.
>
> What's the plan for this?

We explain what we currently know about nesting.
Currently, two scenarios are possible:
      1. A BPF prog got preempted by another program.
              - This shouldn't be a problem as the preempted BPF program
                 is not in running state.
      2. A BPF prog is attached to a function called by another BPF program.
             - This is the interesting case.

> What do you do if e.g. I attach to some kfunc that you don't stub out?
> E.g. you may stub out bpf_sk_lookup, but I can attach something to
> bpf_get_prandom_u32 called after it in the stub which is not stubbed
> out and stall.

We have thought of 2 components to deal with unintended nesting:
1. Have a per-CPU variable to indicate a termination is in-progress.
    If this is set, any new nesting won't occur.
2. Stub the entire nesting chain:
    For example,
    prog1
         -> prog2
                -> prog3

   Say prog3 is long-running and violates the runtime policy of prog2.
   The watchdog will be triggered for prog2, in that case we walk
through the stack
   and stub all BPF programs leading up to prog2 (In this case prog3
and prog2 will
   get stubbed).

> Will you stub out every kfunc with a noop? If so, how do we reason
> about correctness when the kfunc introduces side effects on program
> state?

Are you indicating about the sched_ext intended cgroup nesting case?

> > - Policy enforcements to control runtime of BPF programs in a system:
> > - Timer based termination (watchdog)
> >         - Userspace management to detect low-performing BPF program and
> >           terminated them
> >
>
> I think one of the things I didn't see reasoned about so far is how
> would you handle tail calls or extension programs?
> Or in general, control flow being extended dynamically by program attachments?
>
> Since you execute until the end of the program, someone could
> construct a chain of 32 chained programs that individually expire the
> watchdog timer, breaking your limit and inflating it by limit x 32
> etc.
>
> Perhaps you just fail direct/indirect calls? They're already something
> that can be skipped because of the recursion counter, so it probably
> won't break things.
>
> Extension programs are different, most likely they don't appear as
> attached when the program is loaded, so it's an empty global function
> call in the original program and the stub. So I presume you don't
> attach them to the stub and it's the original empty function that
> executes in the stub?

We did think about the tailcalls and freplace scenarios and will
address these in upcoming patches.

> It will be a more difficult question to answer once we have indirect
> function calls, and possibly allow calling from the BPF program to
> another as long as signatures match correctly.
> Say a hierarchical BPF scheduler, where indirect function calls are
> used to dispatch to leaves. Each indirect call target may be a
> separate program attached into the original one (say
> application-specific schedulers). By making the program continue
> executing, the second program invoked from the first one could begin
> to stall, and this could happen recursively, again breaching your
> limit on the parent that called into them.
>
> It doesn't have to be indirect calls, it may be a kernel function that
> does this propagation down the tree (like sched-ext plans to do now).
> Possibly will have to stub out these kfuncs as well. But then we have
> to be mindful if the program depends on side effects vs if they are
> pure.

Indirect calls are something which we didn't consider until now.
Thanks for pointing this out. We'll play around with the cgroup-based
hierarchical BPF scheduler.

> So I think the conclusion is that we need to reason about and stub all
> functions (apart from those that acquire resources) that can in turn
> invoke more BPF programs, so that the parent calling into them
> transitively isn't stalled while it's fast executing, which doesn't
> seem easy.
> It's the same problem as with nested program execution. On the path
> where we are terminating, we allow yet another program to come in and
> stall the kernel.
>
> I think it's just a consequence of "keep executing until exit" vs
> "stop executing and return" that such a problem would come up. It's
> much easier to reason about and notrace the few bits needed to unwind
> and return control to the kernel vs controlling it for every possible
> suffix of the program where the stub is invoked.
>
> But perhaps you have given thought to these question, and may have
> solutions in mind.
> Will it be some kind of bpf_prog_active() check that avoids invoking
> more programs on the 'fast-execute' path?
> It may interfere with other programs that interrupt the fast-execute
> termination and try to run (e.g. XDP in an interrupt where a
> fast-execute in task context was in progress) and lead to surprises.

True. This is infact a concern we have from the solution described above.
Will try to look around and see if something smarter and cleaner is possible.

<SNIP>
> All of this said, I think the patches need more work. The arch
> specific bits can be moved into arch/*/net/bpf_* files and you can
> dispatch to them using __weak functions in kernel/bpf/core.c. A
> complete version of stubbing that handles both kfuncs and helpers
> would be better.
Sure.

> I don't think bpftool support for termination is necessary, it should
> be kicked in by the kernel automatically once a stall is detected.
> So you can drop the bpf(2) syscall command being added.
Agreed. Since we were using it for testing our termination, we thought
of exposing it to userspace as well.

> For now, we can also keep the enforcement of termination bits out and
> just focus on termination bits, both can land separately (the
> enforcement will require more discussion, so it'd be better to keep
> focus on and not mix both IMO).
Makes sense. Will remove the bpftool part from patches for now.

Since some implementations need experimenting, it might take some time
before sending it out here.
Again, thanks for taking time to review and give feedback. We will push
new set of patches with the suggestions and future work.

