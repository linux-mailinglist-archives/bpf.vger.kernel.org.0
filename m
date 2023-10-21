Return-Path: <bpf+bounces-12900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A657D1DDA
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 17:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544A72820F4
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 15:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5502171CC;
	Sat, 21 Oct 2023 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofwQDabj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470C7DF4B
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 15:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEBFC433CA
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 15:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697901620;
	bh=0Gmd61gVU7OV3YQ4CdC1tFp5ZjI/yfun2/AA4yKUQn8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ofwQDabjnop143X1Ma1r9TGfS0it3pZz8d80plBFGPtcBUz+3iBkOWeoIwm03UVBw
	 lSxiJ99ukL7ZHMoU24vesBXawiYXzOTUxJ4lS8PWODQtSJvDn0P1tEzX1kgaReVj3S
	 CdQAHWtuQCEj9mdCO5wLjuNN6G7oOXFzEcR8bqB/pXFel/xby16/k4NwBqVRB7rDg+
	 w9Vyzn937OP105XcgCWxpXA0bSqajWIrTCDyUoGTN7XuHCzcjJvN4uBMVF+jVhbQYF
	 /qr2QE4qVcRdFhzuWOdSvyUOEXuwrzebzxpmkmDmTLEftGx3n7HfE0CnQix5xMdvsY
	 rx508mntkPd0Q==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-53f9af41444so2791710a12.1
        for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 08:20:20 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywd+OmQiBDUY2jWjC8Krvi3Xb6iZqQNTcSdm142vJE21eIst6oO
	vH2fpsvbymBkULw9V8RKGReskbLGzTt7rXVsOoxNGA==
X-Google-Smtp-Source: AGHT+IE20Xo6pHoho6fajct5r8/9HwJGbi2wxF8EWCRcozI+zZ8JbKmbMm7ZluTNXF/fnSeWrQ5j48PUtExd1rh3AEk=
X-Received: by 2002:a05:6402:26d2:b0:53e:94f8:85b0 with SMTP id
 x18-20020a05640226d200b0053e94f885b0mr4279905edd.13.1697901618959; Sat, 21
 Oct 2023 08:20:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
 <CACYkzJ5k7oYxFgWp9bz1Wmp3n6LcU39Mh-HXFWTKnZnpY-Ef7w@mail.gmail.com>
 <153e7c39-d2e2-db31-68cd-cb05eb2d46db@I-love.SAKURA.ne.jp>
 <CACYkzJ79fvoQW5uqavdLV=N8zw6uern8m-6cM44YYFDhJF248A@mail.gmail.com>
 <f249c8f0-e053-066b-edc5-59a1a00a0868@I-love.SAKURA.ne.jp>
 <CACYkzJ7kzXGcjRdyaOWCaigPWcKXU7_KW_bFg9ptrnwAeJ2AgQ@mail.gmail.com> <d060365e-7c87-451e-a92a-edb4904e77a7@I-love.SAKURA.ne.jp>
In-Reply-To: <d060365e-7c87-451e-a92a-edb4904e77a7@I-love.SAKURA.ne.jp>
From: KP Singh <kpsingh@kernel.org>
Date: Sat, 21 Oct 2023 17:20:08 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7S00K8f-H7EdDz3CFyxbfoQ1zQXDj7oWpY3dkDjFb0LA@mail.gmail.com>
Message-ID: <CACYkzJ7S00K8f-H7EdDz3CFyxbfoQ1zQXDj7oWpY3dkDjFb0LA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] LSM: Allow dynamically appendable LSM modules.
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module <linux-security-module@vger.kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>, bpf <bpf@vger.kernel.org>, 
	Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 21, 2023 at 4:19=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2023/10/04 0:09, KP Singh wrote:
> >> What I expected is "allocate memory where amount is determined at runt=
ime" (e.g. alloc(), realloc()).
> >
> > One can use dynamically sized allocations on the ring buffer with
> > dynamic pointers:
> >
> > http://vger.kernel.org/bpfconf2022_material/lsfmmbpf2022-dynptr.pdf
> >
> > Furthermore, there are some use cases that seemingly need dynamic
> > memory allocation but not really. e.g. there was a need to audit
> > command line arguments and while it seems dynamic and one can chunk
> > the allocation to finite sizes, put these on a ring buffer and process
> > the chunks.
> >
> > It would be nice to see more details of where the dynamic allocation
> > is needed. Security blobs are allocated dynamically but have a fixed
> > size.
>
> Dynamic allocation is not for security blobs. Dynamic allocation is for
> holding requested pathnames (short-lived allocation), holding audit logs
> (FIFO allocation), holding/appending access control rules (long-lived

This is a ring buffer, BPF already has one and used for the very use
case you mentioned (audit logs). Please read the original RFC and
patches for BPF LSM. We have deployed this at scale and it's very
efficient (memory and compute wise).

> allocation).

This is a map, not all maps need to be preallocated. An access control
rule can fundamentally be implemented as a map.

I recommend reading most of the BPF selftests to learn what can be
done / accomplished.

>
>
>
> >> Some of core requirements for implementing TOMOYO/AKARI/CaitSith-like =
programs
> >> using BPF will be:
> >>
> >>   The program registered cannot be stopped/removed by the root user.
> >>   This is made possible by either building the program into vmlinux or=
 loading
> >>   the program as a LKM without module_exit() callback. Is it possible =
to guaranee
> >>   that a BPF program cannot be stopped/removed by user's operations?
> >
> > Yes, there is a security_bpf hook where a BPF MAC policy can be
> > implemented and other LSMs do that already.
> >
> >>
> >>   The program registered cannot be terminated by safety mechanisms (e.=
g. excessive
> >>   CPU time consumption). Are there mechanisms in BPF that wouldn't hav=
e terminated
> >>   a program if the program were implemented as a LKM rather than a BPF=
 program?
> >>
> >
> > The kernel does not terminate BPF LSM programs, once a BPF program is
> > loaded and attached to the LSM hook, it's JITed into a native code.
> > From there onwards, as far as the kernel is concerned it's just like
> > any other kernel function.
>
> I was finally able to build and load tools/testing/selftests/bpf/progs/ls=
m.c and
> tools/testing/selftests/bpf/prog_tests/test_lsm.c , and I found fatal lim=
itation

Programs can also be pinned on /sys/bpf similar to maps, this allows
them to persist even after the loading program goes away.

Here's an example of a pinned program:

https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/bpf/=
flow_dissector_load.c#L39

> that the program registered is terminated when the file descriptor which =
refers to
> tools/testing/selftests/bpf/lsm.bpf.o is closed (due to e.g. process term=
ination).
> That is, eBPF programs are not reliable/robust enough to implement TOMOYO=
/AKARI/
> CaitSith-like programs. Re-registering when the file descriptor is closed=
 is racy

Not needed as programs can be pinned too.

> because some critical operations might fail to be traced/checked by the L=
SM hooks.
>
> Also, I think that automatic cleanup upon closing the file descriptor imp=
lies that
> allocating resources (or getting reference counts) that are not managed b=
y the BPF
> (e.g. files under /sys/kernel/securitytomoyo/ directory) is not permitted=
. That's
> very bad.
>
> >
> >>
> >>   Amount of memory needed for managing data is not known at compile ti=
me. Thus, I need
> >>   kmalloc()-like memory allocation mechanism rather than allocating fr=
om some pool, and
> >>   manage chunk of memory regions using linked list. Does BPF have kmal=
loc()-like memory
> >>   allocation mechanism that allows allocating up to 32KB (8 pages if P=
AGE_SIZE=3D4096).
> >>
> >
> > You use the ring buffer as a large pool and use dynamic pointers to
> > carve chunks out of it, if truly dynamic memory is needed.
>
> TOMOYO/AKARI/CaitSith-like programs do need dynamic memory allocation, as=
 max amount of
> memory varies from less than 1MB to more than 10MB. Preallocation is too =
much wasteful.
>
>
>
> >
> >> And maybe somewhere documented question:
> >>
> >>   What kernel functions can a BPF program call / what kernel data can =
a BPF program access?
> >
> > BPF programs can access kernel data dynamically (accesses relocated at
> > load time without needing a recompile) There are lot of good details
> > in:
> >
> > https://nakryiko.com/posts/bpf-core-reference-guide/
> >
> >
> >>   The tools/testing/selftests/bpf/progs/test_d_path.c suggests that a =
BPF program can call
> >>   d_path() defined in fs/d_path.c . But is that because d_path() is ma=
rked as EXPORT_SYMBOL() ?
> >>   Or can a BPF program call almost all functions (like SystemTap scrip=
t can insert hooks into
> >>   almost all functions)? Even functions / data in LKM can be accessed =
by a BPF program?
> >>
> >
> > It's not all kernel functions, but there is a wide range of helpers
> > and kfuncs (examples in tools/testing/selftests/bpf) and if there is
> > something missing, we will help you.
>
> I couldn't build tools/testing/selftests/bpf/progs/lsm.c with printk() ad=
ded.
> Sending to /sys/kernel/debug/tracing/trace_pipe via bpf_printk() is not e=
nough for
> reporting critical/urgent problems. Synchronous operation is important.

you cannot call any function from within BPF. If you need to call
something they need to be exported as a kfunc (you need to send
patches on the mailing list for it). This is because we want to ensure
that BPF programs can be verified.

>
> Since printk() is not callable, most of functions which TOMOYO/AKARI/Cait=
Sith-like
> programs use seem to be not callable.

It seems like you are trying to 1:1 re-implement an existing LSM's
code base in BPF, that's surely not going to work. You need to think
about the use-case / policy you are trying to implement and then write
the code in BPF independently. Please share concrete examples of the
policy you want to implement and we try to help you. Asking for
features where you want a 1:1 parity with kernel code without concrete
policy use-cases is not going to enable us to help you.

- KP

>

