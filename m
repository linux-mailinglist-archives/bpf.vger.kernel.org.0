Return-Path: <bpf+bounces-26212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ED589CBAA
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 20:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 258F7B27656
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 18:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D191448ED;
	Mon,  8 Apr 2024 18:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6R45nAk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A5E1448C4;
	Mon,  8 Apr 2024 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712600674; cv=none; b=qZyTeIkM0+Xf4hZmqzhqWLLIlNeA1NLUqC0CyWjzwPZS8iTy1F2BQ4v8aseJuIvt5O0L2WMmiI/pRG6pDZNQKR1C6fywoXn3GJPBA3Lwy7qQyLlILPGcFqkO97XUoorqrol9QIBLGCaXbhOo+wA/WB7dhhBOhazqkS7iWFa0MQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712600674; c=relaxed/simple;
	bh=BjTJYz/b0W194uG3Dy5J9ActPboXh7mVQIpU2KFg/7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ha1uoXMmmUC8uPoi/hsZli/LfGMIwgRS8lK6sTEU1vE14fsLp8t7GirkEIb8RAJIVW0JfozF+wRTnClEPw6250syrDDP6xhyKFi9ixNc4n72b4gKm2T9C6Lk3MIkrTuwZNykWjaj3fzIwQ0lqUPbpy3a2a4XSuEpzbDeJ7mvnpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6R45nAk; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3442f4e098bso1220207f8f.1;
        Mon, 08 Apr 2024 11:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712600671; x=1713205471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cROCssBIV4xyuzdSD8dyeKutwvbC7vcc1U8PqfuQR6M=;
        b=W6R45nAkAaxSUwfQ6YOatTsqryM79ecst165M8IL4W+bb92MFdWRJ0673Z1XLiVUqk
         YpwpBqP2zyTBtjwVZeaVzehbL/cIDwDQQL3lE6cB091yccqj9llxQrFgizKGXOuas5+2
         ebFP+WNZa8IjwZ5ubPHkCIM71jQENlEU9aBgO5JGVCOf3zfAf/YWtPKv/QLS/9YBuUkm
         IDqvOUIG7L0eMA9YmvDMuw1arFyGrKD4TI1WLFdHeg205gSeljx33A1z8inm45G7cJxu
         6+jmm4H4FeKZVdKNKEsu4mfOkq4CgsngGqB6gIb4SRwqeUvejZSz+rSaTiuSvQ/PpefP
         1ACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712600671; x=1713205471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cROCssBIV4xyuzdSD8dyeKutwvbC7vcc1U8PqfuQR6M=;
        b=MLaTNE0BYvVYlBsJJCsZDk4DogF7z+cER62Y3uYXcBygV4VNRFlxk61Qxm8CUnbDUA
         VB0++9OBjMZiSWbepQZjPli9j5Xb/aWXt2Sm7y3Ud5Kcyjeua69+eQkBWb3TupMae0YB
         cBL1L4grJs+LgOmNqUydm5/C2qldxwBKQIKkpzjePAiVLMOaU1DbTALH3kAIDqRw3F+J
         cF6ug/zezPGY2Q3mAEBVkWccn304sIKeLgl53zdVMSOurS9vMh9gs/n4N6wHahdSTIGC
         9Y7t2EBbpgx3embYYJahJ+hx5yL5e2GSNy5o+QuE9Xl0DpWv7HEjNPS2n8dQauhS8XGI
         JE2g==
X-Forwarded-Encrypted: i=1; AJvYcCXa+Gr54IROaw9ip8O2lE7FWw4lhvPfKCFSUQVRqouhcrghU3EKVDfihkK1z3GMXcz5cIpQth7qEoslQduoXZf3lcJ9OkST0RU6r+PPO9GS3n/cCqFvXPN3qy28B7RnT8bMmUUjRC8MHzZvY2ZkKj+76OaCSg5HHkboIAqfVy8NCgVgWZMjbhvifhrGleW9fy1OzxL+t4puyvsHIPv+LoSS
X-Gm-Message-State: AOJu0Yx0UCbqC6kJIr3Fcqlc0aLvx/BJehTAwv9uUOt1/glNGFLE+qSr
	xvVsZ3StE15eq+r8OUueEjRWFIQhS+hT26pWYzEdw6Tquk9LmAQ1Kca2tcH6QDrGmI6mU++hycK
	TXNpo7IoiQn6xGIu89BWj31GhYcE=
X-Google-Smtp-Source: AGHT+IFmb2xMi3DwTGlhE6Fzn2e0lZiTlA2PS5kmTAv5uiYxZ5467CLILgQgbrqh45oGjtS+CQY5Q3oTQtSnXUJzHwE=
X-Received: by 2002:a05:6000:c8a:b0:343:c05b:e7dd with SMTP id
 dp10-20020a0560000c8a00b00343c05be7ddmr373462wrb.3.1712600671200; Mon, 08 Apr
 2024 11:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404190146.1898103-1-elver@google.com> <CAADnVQKc+Z39k9wbU2MHf-fPFma+9QsyOugmmmGq3ynQCTVfCw@mail.gmail.com>
 <CANpmjNN+rR1PWKbx6RBWhOjnmAP+jUDzc3TLcwTnmfd=ft03dg@mail.gmail.com>
 <CAEf4BzZCj=3hevf+Je=oed9Nisctotp_CX00NrLaO6_7+-0LSQ@mail.gmail.com> <CANpmjNMCJwCaGiUpMCukgruNJ9k120sJ8pVkrdpyo-Tonve2Sw@mail.gmail.com>
In-Reply-To: <CANpmjNMCJwCaGiUpMCukgruNJ9k120sJ8pVkrdpyo-Tonve2Sw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Apr 2024 11:24:19 -0700
Message-ID: <CAADnVQJ68X6NPYtEbQPXPM4pH1ZPg5iSrYi8c3EanL51SAW7zQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Introduce bpf_probe_write_user_registered()
To: Marco Elver <elver@google.com>
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

On Mon, Apr 8, 2024 at 2:30=E2=80=AFAM Marco Elver <elver@google.com> wrote=
:
>
> On Fri, 5 Apr 2024 at 22:28, Andrii Nakryiko <andrii.nakryiko@gmail.com> =
wrote:
> >
> > On Fri, Apr 5, 2024 at 1:28=E2=80=AFAM Marco Elver <elver@google.com> w=
rote:
> > >
> > > On Fri, 5 Apr 2024 at 01:23, Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> [...]
> > > > and the tasks can use mmaped array shared across all or unique to e=
ach
> > > > process.
> > > > And both bpf and user space can read/write them with a single instr=
uction.
> > >
> > > That's BPF_F_MMAPABLE, right?
> > >
> > > That does not work because the mmapped region is global. Our requirem=
ents are:

It sounds not like "requirements", but a description of the proposed
solution.
Pls share the actual use case.
This "tracing prog" sounds more like a ghost scheduler that
wants to interact with known user processes.

> > >
> > > 1. Single tracing BPF program.
> > >
> > > 2. Per-process (per VM) memory region (here it's per-thread, but each
> > > thread just registers the same process-wide region).  No sharing
> > > between processes.
> > >
> > > 3. From #2 it follows: exec unregisters the registered memory region;
> > > fork gets a cloned region.
> > >
> > > 4. Unprivileged processes can do prctl(REGISTER). Some of them might
> > > not be able to use the bpf syscall.
> > >
> > > The reason for #2 is that each user space process also writes to the
> > > memory region (read by the BPF program to make updates depending on
> > > what state it finds), and having shared state between processes
> > > doesn't work here.
> > >
> > > Is there any reasonable BPF facility that can do this today? (If
> > > BPF_F_MMAPABLE could do it while satisfying requirements 2-4, I'd be =
a
> > > happy camper.)
> >
> > You could simulate something like this with multi-element ARRAY +
> > BPF_F_MMAPABLE, though you'd need to pre-allocate up to max number of
> > processes, so it's not an exact fit.
>
> Right, for production use this is infeasible.

Last I heard, ghost agent and a few important tasks can mmap bpf array
and share it with bpf prog.
So quite feasible.

>
> > But what seems to be much closer is using BPF task-local storage, if
> > we support mmap()'ing its memory into user-space. We've had previous
> > discussions on how to achieve this (the simplest being that
> > mmap(task_local_map_fd, ...) maps current thread's part of BPF task
> > local storage). You won't get automatic cloning (you'd have to do that
> > from the BPF program on fork/exec tracepoint, for example), and within
> > the process you'd probably want to have just one thread (main?) to
> > mmap() initially and just share the pointer across all relevant
> > threads.
>
> In the way you imagine it, would that allow all threads sharing the
> same memory, despite it being task-local? Presumably each task's local
> storage would be mapped to just point to the same memory?
>
> > But this is a more generic building block, IMO. This relying
> > on BPF map also means pinning is possible and all the other BPF map
> > abstraction benefits.
>
> Deployment-wise it will make things harder because unprivileged
> processes still have to somehow get the map's shared fd somehow to
> mmap() it. Not unsolvable, and in general what you describe looks
> interesting, but I currently can't see how it will be simpler.

bpf map can be pinned into bpffs for any unpriv process to access.
Then any task can bpf_obj_get it and mmap it.
If you have few such tasks than bpf array will do.
If you have millions of tasks then use bpf arena which is a sparse array.
Use pid as an index or some other per-task id.
Both bpf prog and all tasks can read/write such shared memory
with normal load/store instructions.

> In absence of all that, is a safer "bpf_probe_write_user()" like I
> proposed in this patch ("bpf_probe_write_user_registered()") at all
> appealing?

To be honest, another "probe" variant is not appealing.
It's pretty much bpf_probe_write_user without pr_warn_ratelimited.
The main issue with bpf_probe_read/write_user() is their non-determinism.
They will error when memory is swapped out.
These helpers are ok-ish for observability when consumers understand
that some events might be lost, but for 24/7 production use
losing reads becomes a problem that bpf prog cannot mitigate.
What do bpf prog suppose to do when this safer bpf_probe_write_user errors?
Use some other mechanism to communicate with user space?
A mechanism with such builtin randomness in behavior is a footgun for
bpf users.
We have bpf_copy_from_user*() that don't have this non-determinism.
We can introduce bpf_copy_to_user(), but it will be usable
from sleepable bpf prog.
While it sounds you need it somewhere where scheduler makes decisions,
so I suspect bpf array or arena is a better fit.

Or something that extends bpf local storage map.
See long discussion:
https://lore.kernel.org/bpf/45878586-cc5f-435f-83fb-9a3c39824550@linux.dev/

I still like the idea to let user tasks register memory in
bpf local storage map, the kernel will pin such pages,
and then bpf prog can read/write these regions directly.
In bpf prog it will be:
ptr =3D bpf_task_storage_get(&map, task, ...);
if (ptr) { *ptr =3D ... }
and direct read/write into the same memory from user space.

