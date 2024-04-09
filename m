Return-Path: <bpf+bounces-26258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA2D89D3DB
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 10:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6677D1F22C6D
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 08:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FEB7E78B;
	Tue,  9 Apr 2024 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0h0dJ29h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205507E107
	for <bpf@vger.kernel.org>; Tue,  9 Apr 2024 08:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712650293; cv=none; b=dBBgSOR92hrptai7HY2gV4gNWZiPyTNhCCSZ4MXHoUrzMaDfKO6BPS9WVZp/tIfuzhYQ/jwnkZmrC8qQGbDkaGGxK1Nq+0Gmp0N1tt/o0ycWDtKrs9qkrDqu5Me+20d1nthkd/I0uDijPNvhq1NwWzO4oPXvecGT0NaV/34NlEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712650293; c=relaxed/simple;
	bh=Sj7xWo6dggnBKWnwopkjcfoSOT+F+b/D4Pubow5TKx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMluD7ZelwYaddW81ogu6qwJE8O66Sm7MDjRnIFECAeQLQCY2u1w8j5YjK95LxqLpYoC1jqF/oY9JPSbqFUtegaC2w0D54IHWReqwEsVoClQ53LSYWEZzOaQRGSi0KNPG+cJSMfjGr5k9BKbQXH0hflE3j2mrpne5FuypqHHGro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0h0dJ29h; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4daab3cf090so2758088e0c.0
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 01:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712650291; x=1713255091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0nblBmM1/a+p1HrPFvTeMrGyNMRc47QQf0Yo+BcYZs=;
        b=0h0dJ29heE2qr9EdfMpearXEVBdflTFRu1ZtFiXFt2DB9mZAuqJDfHliFJ/PX745vm
         PqXBxjd6L9h1AUeLsIZ/lirSjEPCJ4xbFz7F26seBxIF1+hpMDwlTYOLE18Q+d/DKzIl
         d0UT43vpHftNS5yXCJSZKbq8Hdhdb6SbVXdvTHifBJEThYmzq3jMvKiEOZPT7k+pMT5f
         p3BGOX7jRnhVPYaMsYlz8CxFXs/ELzm+/bFR7JVwnJrGVFNLb0Wiwd0RowkhRRpk6k3v
         NC9S5ashIcKb09sIeetgmYIPdoyOhCFvTwArmCNi4SSVlGNUIPvbxqJm5cN+Xsq82Jol
         2kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712650291; x=1713255091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0nblBmM1/a+p1HrPFvTeMrGyNMRc47QQf0Yo+BcYZs=;
        b=lYqFz/vlaXD7B+d5PIDWedrEvuHP8VrnYOmdQVKot2ECSZAC3gsPK8zAeTbe09gucN
         3WyGItQq/00/9qDSyN4c/SXeOLQrYdaWq2HYsW8O61+u/WHTmkfUEvNY3ebapEXYRoK3
         NgThRCM+PRxiSCCIVaVWiwiBC5UyRbH6JyerJ5Lw2BtYVjClpRHpLtGcnXS+rc7ghZD1
         zIJJ6kRyUHadwpbD/BWz2EicI+yGTs7CcwUK11/ZptZJ/oGirwmCaTfNFTcS4pPro2jc
         g0QxspJwoJAYhqL3OhinJrD4B++o3KEW3d6AufCD/agW7azesOtiJDtr/Qanh8M+keug
         S8yw==
X-Forwarded-Encrypted: i=1; AJvYcCXWGYA9J2F+zy9qzgGTlmdF1A3FmZ1H/z7ELHKztDHYZEWDbD74Bb34vbljMwNTtRRumQYRao1q2O/IHjQD4QTYxipm
X-Gm-Message-State: AOJu0YzNyPamPAjMEFkh50JOOiX5X1U9W0S+7lbaRigRlaerN4vKOSqF
	m4k7/jtje+BPIy0McCHC04SCO/H+XqrX8lcmr62yjA+0/sZrTlStEdbFs8yQhH+VBaThUTvsM1w
	ZkOc8cwHjyjhab+cbKnFm0fWmx1BXhXv5uVbP
X-Google-Smtp-Source: AGHT+IHo3sayxxc3lpEm1Fm76MGBY1zYfOZ1vpEOlwm67dbXPRGyU26Bo6MFRjwdx3BD+yQ6vx/rvX5dUBr75D/IPdA=
X-Received: by 2002:a05:6122:264f:b0:4c7:7760:8f14 with SMTP id
 dr15-20020a056122264f00b004c777608f14mr1093930vkb.7.1712650290765; Tue, 09
 Apr 2024 01:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404190146.1898103-1-elver@google.com> <CAADnVQKc+Z39k9wbU2MHf-fPFma+9QsyOugmmmGq3ynQCTVfCw@mail.gmail.com>
 <CANpmjNN+rR1PWKbx6RBWhOjnmAP+jUDzc3TLcwTnmfd=ft03dg@mail.gmail.com>
 <CAEf4BzZCj=3hevf+Je=oed9Nisctotp_CX00NrLaO6_7+-0LSQ@mail.gmail.com>
 <CANpmjNMCJwCaGiUpMCukgruNJ9k120sJ8pVkrdpyo-Tonve2Sw@mail.gmail.com> <CAADnVQJ68X6NPYtEbQPXPM4pH1ZPg5iSrYi8c3EanL51SAW7zQ@mail.gmail.com>
In-Reply-To: <CAADnVQJ68X6NPYtEbQPXPM4pH1ZPg5iSrYi8c3EanL51SAW7zQ@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Tue, 9 Apr 2024 10:10:52 +0200
Message-ID: <CANpmjNO3m-f-Yg5EqTL3ktL2CqTw7v0EjHGVth7ssWJRnNz5xQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Introduce bpf_probe_write_user_registered()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf <bpf@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Apr 2024 at 20:24, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 8, 2024 at 2:30=E2=80=AFAM Marco Elver <elver@google.com> wro=
te:
> >
> > On Fri, 5 Apr 2024 at 22:28, Andrii Nakryiko <andrii.nakryiko@gmail.com=
> wrote:
> > >
> > > On Fri, Apr 5, 2024 at 1:28=E2=80=AFAM Marco Elver <elver@google.com>=
 wrote:
> > > >
> > > > On Fri, 5 Apr 2024 at 01:23, Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > [...]
> > > > > and the tasks can use mmaped array shared across all or unique to=
 each
> > > > > process.
> > > > > And both bpf and user space can read/write them with a single ins=
truction.
> > > >
> > > > That's BPF_F_MMAPABLE, right?
> > > >
> > > > That does not work because the mmapped region is global. Our requir=
ements are:
>
> It sounds not like "requirements", but a description of the proposed
> solution.

These requirements can also be implemented differently, e.g. with the
proposed task-local storage maps if done right (the devil appears to
be in the implementation-details - these details are currently beyond
my knowledge of the BPF subsystem internals). They really are the bare
minimum requirements for the use case. The proposed solution probably
happens to be the simplest one, and mapping requirements is relatively
straightforward for it.

> Pls share the actual use case.
> This "tracing prog" sounds more like a ghost scheduler that
> wants to interact with known user processes.

It's tcmalloc - we have a BPF program provide a simpler variant of the
"thread re-scheduling" notifications discussed here:
https://lore.kernel.org/all/CACT4Y+beLh1qnHF9bxhMUcva8KyuvZs7Mg_31SGK5xSoR=
=3D3m1A@mail.gmail.com/

Various synchronization algorithms can be optimized if they know about
scheduling events. This has been proposed in [1] to implement an
adaptive mutex. However, we think that there are many more
possibilities, but it really depends on the kind of scheduler state
being exposed ("thread on CPU" as in [1], or more details, like
details about which thread was switched in, which was switched out,
where was the thread migrated to, etc.). Committing to these narrow
use case ABIs and extending the main kernel with more and more such
information does not scale. Instead, BPF easily allows to expose this
information where it's required.

[1] https://lore.kernel.org/all/20230529191416.53955-1-mathieu.desnoyers@ef=
ficios.com/

> > > > 1. Single tracing BPF program.
> > > >
> > > > 2. Per-process (per VM) memory region (here it's per-thread, but ea=
ch
> > > > thread just registers the same process-wide region).  No sharing
> > > > between processes.
> > > >
> > > > 3. From #2 it follows: exec unregisters the registered memory regio=
n;
> > > > fork gets a cloned region.
> > > >
> > > > 4. Unprivileged processes can do prctl(REGISTER). Some of them migh=
t
> > > > not be able to use the bpf syscall.
> > > >
> > > > The reason for #2 is that each user space process also writes to th=
e
> > > > memory region (read by the BPF program to make updates depending on
> > > > what state it finds), and having shared state between processes
> > > > doesn't work here.
> > > >
> > > > Is there any reasonable BPF facility that can do this today? (If
> > > > BPF_F_MMAPABLE could do it while satisfying requirements 2-4, I'd b=
e a
> > > > happy camper.)
> > >
> > > You could simulate something like this with multi-element ARRAY +
> > > BPF_F_MMAPABLE, though you'd need to pre-allocate up to max number of
> > > processes, so it's not an exact fit.
> >
> > Right, for production use this is infeasible.
>
> Last I heard, ghost agent and a few important tasks can mmap bpf array
> and share it with bpf prog.
> So quite feasible.

Nothing related to ghost.

It's tcmalloc, i.e. every process running everywhere.

> > > But what seems to be much closer is using BPF task-local storage, if
> > > we support mmap()'ing its memory into user-space. We've had previous
> > > discussions on how to achieve this (the simplest being that
> > > mmap(task_local_map_fd, ...) maps current thread's part of BPF task
> > > local storage). You won't get automatic cloning (you'd have to do tha=
t
> > > from the BPF program on fork/exec tracepoint, for example), and withi=
n
> > > the process you'd probably want to have just one thread (main?) to
> > > mmap() initially and just share the pointer across all relevant
> > > threads.
> >
> > In the way you imagine it, would that allow all threads sharing the
> > same memory, despite it being task-local? Presumably each task's local
> > storage would be mapped to just point to the same memory?
> >
> > > But this is a more generic building block, IMO. This relying
> > > on BPF map also means pinning is possible and all the other BPF map
> > > abstraction benefits.
> >
> > Deployment-wise it will make things harder because unprivileged
> > processes still have to somehow get the map's shared fd somehow to
> > mmap() it. Not unsolvable, and in general what you describe looks
> > interesting, but I currently can't see how it will be simpler.
>
> bpf map can be pinned into bpffs for any unpriv process to access.
> Then any task can bpf_obj_get it and mmap it.
> If you have few such tasks than bpf array will do.
> If you have millions of tasks then use bpf arena which is a sparse array.
> Use pid as an index or some other per-task id.
> Both bpf prog and all tasks can read/write such shared memory
> with normal load/store instructions.
>
> > In absence of all that, is a safer "bpf_probe_write_user()" like I
> > proposed in this patch ("bpf_probe_write_user_registered()") at all
> > appealing?
>
> To be honest, another "probe" variant is not appealing.
> It's pretty much bpf_probe_write_user without pr_warn_ratelimited.

Fair enough.

> The main issue with bpf_probe_read/write_user() is their non-determinism.
> They will error when memory is swapped out.

Right. Although, user space mlock'ing and prefaulting the memory
solves it in the common case (some corner cases like after fork() are
still tricky).

> These helpers are ok-ish for observability when consumers understand
> that some events might be lost, but for 24/7 production use
> losing reads becomes a problem that bpf prog cannot mitigate.
> What do bpf prog suppose to do when this safer bpf_probe_write_user error=
s?
> Use some other mechanism to communicate with user space?

Right, for use cases where these errors aren't ok it does not work.
But if the algorithm is tolerant to lossy reads/writes from the BPF
program side, it's not an issue.

> A mechanism with such builtin randomness in behavior is a footgun for
> bpf users.
> We have bpf_copy_from_user*() that don't have this non-determinism.
> We can introduce bpf_copy_to_user(), but it will be usable
> from sleepable bpf prog.
> While it sounds you need it somewhere where scheduler makes decisions,
> so I suspect bpf array or arena is a better fit.

Correct, it can't sleep because it wants scheduler events.

> Or something that extends bpf local storage map.
> See long discussion:
> https://lore.kernel.org/bpf/45878586-cc5f-435f-83fb-9a3c39824550@linux.de=
v/
>
> I still like the idea to let user tasks register memory in
> bpf local storage map, the kernel will pin such pages,
> and then bpf prog can read/write these regions directly.
> In bpf prog it will be:
> ptr =3D bpf_task_storage_get(&map, task, ...);
> if (ptr) { *ptr =3D ... }
> and direct read/write into the same memory from user space.

I would certainly welcome something like this - I agree this looks
better than bpf_probe_read/write.

Thanks,
-- Marco

