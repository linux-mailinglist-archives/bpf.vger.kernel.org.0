Return-Path: <bpf+bounces-57370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D59AA9D06
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 22:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7601A80127
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 20:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45BE26F467;
	Mon,  5 May 2025 20:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxXJYa9Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202A634CF5
	for <bpf@vger.kernel.org>; Mon,  5 May 2025 20:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746476039; cv=none; b=mG6x4ZrVpNbtyu8RgCmccFtekq7A7liOsMTPPWEtQIyqxBBLYPRONw+D3VbYvKIvMP/vhE7ZElKjauXxuhRcTU+6VKov3sO72z3PRifZf3oeiV28mtKCyLYXhveLE4Va5vymmW21C6IPhdqny9Fxg9yjQYiU8P8ey44uSnBx0yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746476039; c=relaxed/simple;
	bh=y83qAev3wceKeMkxXL3aTqcx5UQtZ2qQrirquqrESzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qudBVrfuto1iAs7X2EYNVTzaPu0xl8OqBM1VX64QNcojLcfqVkB4UvVVlcphiv637M+tEikNuPwGjSbJphSEP0brjSscFYZYbCGgZjt+Pzx7yppbD00L0W+UlF+R8KhTxvtYCoSqFeRDCcGnuvZdSJtK6xysWkg3nKU1Pol6GHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxXJYa9Y; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ad1d1f57a01so84943966b.2
        for <bpf@vger.kernel.org>; Mon, 05 May 2025 13:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746476035; x=1747080835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLGH7LODGXFX7I8+tUIfnPKORxVjJrT+mvzf58pwyhU=;
        b=MxXJYa9YTy1dnxAtYk5YTI7rVIy6jPJL6j1YoS84g+AhzlrBdPaZbUipL2LpbdYVkv
         wzoEWYDVDRpW7lbxZjfwyUkH6zKJCHsqiX9ATdjbqDq9HIZ5rfR9WNCmw8t7YFNr0yv9
         nbKlOIhJ4SOVw7VqWO9+37y/fOi+Ky8AxGaignSHNTUSSd1UnsUe7kcCGcEPB6OYjg28
         KInJ3ot3cSCW4T71gmxKHwYf2CIJ0XfIf41tW0b9zYio5xZt219ehs5JZvXBdI+f0XX1
         TOGs3xUMGYT9qSI2AZYhaoyh7hUFkc5op+EKuBNcg4JtL0x6wO56topGqPoOzYAfPjwn
         uuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746476035; x=1747080835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLGH7LODGXFX7I8+tUIfnPKORxVjJrT+mvzf58pwyhU=;
        b=d4cEe2Z0f70bhaWuG6Yj/XD2rjdmnKbmpCcTiFlE6ac9+lVoo6fVLtn8hK/S1gM+m8
         1J5C029zmCnJJ/WTbanh+4ex+5x6st7m62kCAUAjTc+ItiMk96dQG/p2xVAYwLHtKXkw
         po5/OIT5TPCuAoxDFeLPPZneuzFX4ueokLjig5m0FU92V2ORbLNEqo8SaiztdOMw2aNV
         T4wYINgbzipJmflSU/l0pDxFazAj/iHoe6QQMTmMg9pGigub01sWDlhnOTEZRc8QsuuR
         xUfsbpcYufPpkXbG4894l+EjHuWOQyok+C2uNzULWIOB5rvk6bH+nFH+r9D+X+Quuavw
         3Lqw==
X-Gm-Message-State: AOJu0Yzp87H9uMCEcRTqqkCiZH4KSWL7H9S39CqxDwNxsJurROp9Cs/u
	KJs9Yepc/WqAh/weTW8CNKIIbqFGkx1wnH55wbFDZvf+H44qC48DWtg5W515SV+IpRUfFnuj0P/
	aJlukcWrRgbSyZTZW6BQe/s4p0o8=
X-Gm-Gg: ASbGncvMIllsTByB7WtDgsKcrsVKJdEY6JiLPUL4WPEDIfI68LdtvfnkvVry6Ow7VpU
	SEPkeMq/NEo9i9ZlNlOr69/+20E3xVHX1FqNvTUWLT4DEc3eu2ikYmVfavsNOohDbxLdiZzL67v
	aLtktpCq1tVFXPsGJToaL68Srhw1BrfzZccIt6GN5UG/ghZ5nyei1b7peG
X-Google-Smtp-Source: AGHT+IFTb40HhujQNeVgViwpGDk92ejoX+cIuhjNpl5TFc7wnzpSVK7n50+zuWbjTo0PoNAx4Q0Wj6ZmrzRFhSEUzhA=
X-Received: by 2002:a17:907:c04:b0:ac3:bd68:24f0 with SMTP id
 a640c23a62f3a-ad17b470a90mr1401118566b.7.1746476035035; Mon, 05 May 2025
 13:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420105524.2115690-1-rjsu26@gmail.com>
In-Reply-To: <20250420105524.2115690-1-rjsu26@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 5 May 2025 22:13:17 +0200
X-Gm-Features: ATxdqUELFVaCha6IpBdCwGAnIzDWNLneNabADliO6wdIABUjJaTBndp35g1diWU
Message-ID: <CAP01T75B87Vnq-kdq6gaNXj5xeOOiah-onm4weEZA=jm8W8JVQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/4] bpf: Fast-Path approach for BPF program Termination
To: Raj Sahu <rjsu26@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, djwillia@vt.edu, 
	miloc@vt.edu, ericts@vt.edu, rahult@vt.edu, doniaghazy@vt.edu, 
	quanzhif@vt.edu, jinghao7@illinois.edu, sidchintamaneni@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 20 Apr 2025 at 12:56, Raj Sahu <rjsu26@gmail.com> wrote:
>
> From: Raj <rjsu26@gmail.com>
>
> Motivation:
> We propose an enhancement to the BPF infrastructure to address the
> critical issue of long-running BPF programs [1,2,3,4]. While the verifier
> ensures termination by restricting instruction count and backward edges, =
the
> total execution time of BPF programs is not bounded. Certain helper funct=
ions
> and iterators can result in extended runtimes, affecting system performan=
ce.
>
> The existing BPF infrastructure verifies that programs will not indefinit=
ely
> loop or leak resources. However, helper functions such as `bpf_loop`,
> `bpf_for_each_map_elem`, and other iterative or expensive kernel interact=
ions
> can cause runtimes that significantly degrade system performance [6]. Cur=
rent
> detaching mechanisms do not immediately terminate running instances,
> monopolizing CPU. Therefore, a termination solution is necessary to swift=
ly
> terminate execution while safely releasing resources.

Thanks for sending out the code and cover letter, much appreciated!

I will keep aside opinions on which of 'fast execute' vs
'panic/unwind' feel semantically cleaner, since it's hard to have an
objective discussion on that. One can argue about abstract concepts
like complexity vs clean design either way.

Instead just some questions/comments on the design.

>
> Existing termination approach like the BPF Exception or Runtime hooks [5]=
 have
> the issue of either lack of dynamism or having runtime overheads: BPF
> Exceptions: Introduces bpf_throw() and exception callbacks, requiring sta=
ck
> unwinding and exception state management.

I feel there is an equal amount of state management here, it's just
that it's not apparent directly, and not reified into tables etc.
One of the (valid) concerns with unwinding is that preparing tables of
objects that need to be released requires the verifier/runtime to be
aware of each resource acquiring functions.
Every time you add a new kfunc that acquires some resource, you'd have
to update some place in the kernel to make sure it gets tracked for
clean up too.

But that would be equally true for this case:
- The verifier must know which functions acquire resources, so that it
can replace them with stubs in the cloned text.
- Thus, every time a new kfunc is added, one must introduce its noop
stub and add it to _some_ mapping to acquire kfuncs with their stubs.

> Cleanup can only be done for pre-defined cancellation points.

But can you terminate the program at any arbitrary point with this? It
doesn't seem likely to me. You still have designated points where you
stub empty calls instead of ones which return resources. You will jump
to the return address into the cloned stub on return from an interrupt
that gives you control of the CPU where the program is running. But
apart from the stub functions, everything else would be kept the same.

I think you are conflating the mechanism to clean up resources
(unwinding, this (speed-run-to-exit/fast-execute), runtime log of
resources), with the mechanism to enforce termination.

Both are mutually exclusive, and any strategy (probing a memory
location from the program with strategically placed instrumentation,
watchdog timers, probing rdtsc to do more granular and precise
accounting of time spent, etc.) can be combined with any mechanism to
perform cleanup. There is no necessity to bind one with the other.
Depending on different program types, we may need multiple strategies
to terminate them with the right amount of precision.

We may do something coarse for now (like watchdogs), but separation of
concerns keeps doors open.

> Design:
> We introduce the Fast-Path termination mechanism, leveraging the
> verifier's guarantees regarding control flow and resource management. The
> approach dynamically patches running BPF programs with a stripped-down ve=
rsion
> that accelerates termination. This can be used to terminate any given ins=
tance
> of a BPF execution. Key elements include:
>
> - Implicit Lifetime Management: Utilizing the verifier=E2=80=99s inherent=
 control flow
>   and resource cleanup paths encoded within the BPF program structure,
>   eliminating the need for explicit garbage collection or unwinding table=
s.
>
> - Dynamic Program Patching: At runtime, BPF programs are atomically patch=
ed,
>   replacing expensive helper calls with stubbed versions (fast fall-throu=
gh
>   implementations). This ensures swift termination without compromising s=
afety
>   or leaking resources.
>
> - Helper Function Adjustments: Certain helper functions (e.g., `bpf_loop`=
,
>   `bpf_for_each_map_elem`) include  mechanisms to facilitate early exits =
through
>   modified return values.
>
> TODOs:
> - Termination support for nested BPF programs.

What's the plan for this?
What do you do if e.g. I attach to some kfunc that you don't stub out?
E.g. you may stub out bpf_sk_lookup, but I can attach something to
bpf_get_prandom_u32 called after it in the stub which is not stubbed
out and stall.

Will you stub out every kfunc with a noop? If so, how do we reason
about correctness when the kfunc introduces side effects on program
state?

> - Policy enforcements to control runtime of BPF programs in a system:
> - Timer based termination (watchdog)
>         - Userspace management to detect low-performing BPF program and
>           terminated them
>

I think one of the things I didn't see reasoned about so far is how
would you handle tail calls or extension programs?
Or in general, control flow being extended dynamically by program attachmen=
ts?

Since you execute until the end of the program, someone could
construct a chain of 32 chained programs that individually expire the
watchdog timer, breaking your limit and inflating it by limit x 32
etc.

Perhaps you just fail direct/indirect calls? They're already something
that can be skipped because of the recursion counter, so it probably
won't break things.

Extension programs are different, most likely they don't appear as
attached when the program is loaded, so it's an empty global function
call in the original program and the stub. So I presume you don't
attach them to the stub and it's the original empty function that
executes in the stub?

It will be a more difficult question to answer once we have indirect
function calls, and possibly allow calling from the BPF program to
another as long as signatures match correctly.

Say a hierarchical BPF scheduler, where indirect function calls are
used to dispatch to leaves. Each indirect call target may be a
separate program attached into the original one (say
application-specific schedulers). By making the program continue
executing, the second program invoked from the first one could begin
to stall, and this could happen recursively, again breaching your
limit on the parent that called into them.

It doesn't have to be indirect calls, it may be a kernel function that
does this propagation down the tree (like sched-ext plans to do now).
Possibly will have to stub out these kfuncs as well. But then we have
to be mindful if the program depends on side effects vs if they are
pure.

So I think the conclusion is that we need to reason about and stub all
functions (apart from those that acquire resources) that can in turn
invoke more BPF programs, so that the parent calling into them
transitively isn't stalled while it's fast executing, which doesn't
seem easy.

It's the same problem as with nested program execution. On the path
where we are terminating, we allow yet another program to come in and
stall the kernel.

I think it's just a consequence of "keep executing until exit" vs
"stop executing and return" that such a problem would come up. It's
much easier to reason about and notrace the few bits needed to unwind
and return control to the kernel vs controlling it for every possible
suffix of the program where the stub is invoked.

But perhaps you have given thought to these question, and may have
solutions in mind.
Will it be some kind of bpf_prog_active() check that avoids invoking
more programs on the 'fast-execute' path?
It may interfere with other programs that interrupt the fast-execute
termination and try to run (e.g. XDP in an interrupt where a
fast-execute in task context was in progress) and lead to surprises.

> We haven=E2=80=99t added any selftests in the POC as this mail is mainly =
to get
> feedback on the design. Attaching link to sample BPF programs to
> validate the POC [7].  Styling will be taken care in next iteration.
>
> References:
> 1. https://lpc.events/event/17/contributions/1610/attachments/1229/2505/L=
PC_BPF_termination_Raj_Sahu.pdf
> 2. https://vtechworks.lib.vt.edu/server/api/core/bitstreams/f0749daa-4560=
-41c9-9f36-6aa618161665/content
> 3. https://lore.kernel.org/bpf/AM6PR03MB508011599420DB53480E8BF799F72@AM6=
PR03MB5080.eurprd03.prod.outlook.com/T/
> 4. https://vtechworks.lib.vt.edu/server/api/core/bitstreams/7fb70c04-0736=
-4e2d-b48b-2d8d012bacfc/content
> 5. https://lwn.net/ml/all/AM6PR03MB5080513BFAEB54A93CC70D4399FE2@AM6PR03M=
B5080.eurprd03.prod.outlook.com/#t
> 6. https://people.cs.vt.edu/djwillia/papers/ebpf23-runtime.pdf
> 7. https://github.com/sidchintamaneni/os-dev-env/tree/main/bpf-programs-c=
atalog/research/termination/patch_gen_testing
>
>  arch/x86/kernel/smp.c          |   4 +-
>  include/linux/bpf.h            |  18 ++
>  include/linux/filter.h         |  16 ++
>  include/linux/smp.h            |   2 +-
>  include/uapi/linux/bpf.h       |  13 ++
>  kernel/bpf/bpf_iter.c          |  65 ++++++
>  kernel/bpf/core.c              |  45 ++++
>  kernel/bpf/helpers.c           |   8 +
>  kernel/bpf/syscall.c           | 375 +++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c          |  16 +-
>  kernel/smp.c                   |  22 +-
>  tools/bpf/bpftool/prog.c       |  40 ++++
>  tools/include/uapi/linux/bpf.h |   5 +
>  tools/lib/bpf/bpf.c            |  15 ++
>  tools/lib/bpf/bpf.h            |  10 +
>  tools/lib/bpf/libbpf.map       |   1 +
>  16 files changed, 643 insertions(+), 12 deletions(-)
>

All of this said, I think the patches need more work. The arch
specific bits can be moved into arch/*/net/bpf_* files and you can
dispatch to them using __weak functions in kernel/bpf/core.c. A
complete version of stubbing that handles both kfuncs and helpers
would be better.

I don't think bpftool support for termination is necessary, it should
be kicked in by the kernel automatically once a stall is detected.
So you can drop the bpf(2) syscall command being added.

For now, we can also keep the enforcement of termination bits out and
just focus on termination bits, both can land separately (the
enforcement will require more discussion, so it'd be better to keep
focus on and not mix both IMO).


> --
> 2.43.0
>

