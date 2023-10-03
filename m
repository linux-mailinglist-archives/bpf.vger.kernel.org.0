Return-Path: <bpf+bounces-11282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFEA7B6CA8
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 17:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 841B81C20869
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 15:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B92347D7;
	Tue,  3 Oct 2023 15:09:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59FA347B7
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 15:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C82CC433CB
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 15:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696345763;
	bh=xili5ahztGCigSuWtN2klBzlj5tALq8D+QHJ5FTEeG8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ok+Zobs9ANL3MKJxt9DwwVfhBsX4CYzTA64QHQ4hV3p1Nh27dBWsyXFCuaIdB8TX0
	 hpRcO1Le/mp3BQaHsMn4kAg+GfY1lH1x7jG5w+UFCCOVb/i6n8p+E5ZGF6n5wa0VbS
	 QpMvLFgSNdK5Xh2ExAI+5gNLeOoRewAtK10OntisrpUSiNe6Gt/cKPGha2IpuqSZfU
	 OueGQRnjmlHToRy/R8ZtEA0fg7ATx7u9PXQmZ3d7xq+yraBba0iHfHamWYSqgAUyLK
	 wAEmUiyC0VXiImZ/JOg9F0xbTcr8bD9ipFalkaGLBpmT5SCRA7eZsD6U0ZhrXrz2ef
	 UPZF15Ueddpww==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-53639fb0ba4so1815147a12.0
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 08:09:23 -0700 (PDT)
X-Gm-Message-State: AOJu0YyLlcybKY3fbMpYfCYyw1flTEkaAa/nrgrbF+jd2XqNushpp4aT
	ZkIUGxXUXKkj1lKoB/2uQ3DwY5NxMquJxlIy4zuO/g==
X-Google-Smtp-Source: AGHT+IHI3ARey7PwaGYuDokjykmLRJO8o+a20vQHodc/VeYToF8aS6AdCE338+Jz53lL+HrCW7eBZBeS3+NMDhKQ8j4=
X-Received: by 2002:aa7:d5c4:0:b0:533:4f9b:67c8 with SMTP id
 d4-20020aa7d5c4000000b005334f9b67c8mr13137081eds.16.1696345761707; Tue, 03
 Oct 2023 08:09:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
 <CACYkzJ5k7oYxFgWp9bz1Wmp3n6LcU39Mh-HXFWTKnZnpY-Ef7w@mail.gmail.com>
 <153e7c39-d2e2-db31-68cd-cb05eb2d46db@I-love.SAKURA.ne.jp>
 <CACYkzJ79fvoQW5uqavdLV=N8zw6uern8m-6cM44YYFDhJF248A@mail.gmail.com> <f249c8f0-e053-066b-edc5-59a1a00a0868@I-love.SAKURA.ne.jp>
In-Reply-To: <f249c8f0-e053-066b-edc5-59a1a00a0868@I-love.SAKURA.ne.jp>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 3 Oct 2023 17:09:10 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7kzXGcjRdyaOWCaigPWcKXU7_KW_bFg9ptrnwAeJ2AgQ@mail.gmail.com>
Message-ID: <CACYkzJ7kzXGcjRdyaOWCaigPWcKXU7_KW_bFg9ptrnwAeJ2AgQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] LSM: Allow dynamically appendable LSM modules.
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module <linux-security-module@vger.kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>, bpf <bpf@vger.kernel.org>, 
	Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 3, 2023 at 4:28=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2023/10/01 23:43, KP Singh wrote:
> >>> Now, comes the question of whether we need dynamically loaded LSMs, I
> >>> am not in favor of this. Please share your limitations of BPF as you
> >>> mentioned and what's missing to implement dynamic LSMs. My question
> >>> still remains unanswered.
> >>>
> >>> Until I hear the real limitations of using BPF, it's a NAK from me.
> >>
> >> Simple questions that TOMOYO/AKARI/CaitSith LSMs depend:
> >>
> >>   Q1: How can the BPF allow allocating permanent memory (e.g. kmalloc(=
)) that remains
> >>       the lifetime of the kernel (e.g. before starting the global init=
 process till
> >>       the content of RAM is lost by stopping electric power supply) ?
> >
> > This is very much possible using global BPF maps. Maps can be "pinned"
> > so that they remain allocated until explicitly freed [or RAM is lost
> > by stopping electric power supply"]
> >
> > Here's an example of BPF program that allocates maps:
> >
> >     https://elixir.bootlin.com/linux/latest/source/tools/testing/selfte=
sts/bpf/progs/test_pinning.c#L26
> >
> > and the corresponding userspace code that does the pinning:
> >
> >     https://elixir.bootlin.com/linux/latest/source/tools/testing/selfte=
sts/bpf/prog_tests/pinning.c
>
> I know nothing about BPF. But that looks "allocate once" (i.e. almost "st=
atic char buf[SIZE]").

Happy to help you here!

> What I expected is "allocate memory where amount is determined at runtime=
" (e.g. alloc(), realloc()).

One can use dynamically sized allocations on the ring buffer with
dynamic pointers:

http://vger.kernel.org/bpfconf2022_material/lsfmmbpf2022-dynptr.pdf

Furthermore, there are some use cases that seemingly need dynamic
memory allocation but not really. e.g. there was a need to audit
command line arguments and while it seems dynamic and one can chunk
the allocation to finite sizes, put these on a ring buffer and process
the chunks.

It would be nice to see more details of where the dynamic allocation
is needed. Security blobs are allocated dynamically but have a fixed
size.

>
> >
> > Specifically for LSMs, we also added support for security blobs which
> > are tied to a particular object and are free with the object, have a
> > look at the storage which is allocated in the program:
> >
> >    https://elixir.bootlin.com/linux/latest/source/tools/testing/selftes=
ts/bpf/progs/local_storage.c#L79
> >
> > Again, code and context on what you want to do will let me help you mor=
e here.
>
> I don't have any BPF code.
> I have several LKM-based LSMs in https://osdn.net/projects/akari/scm/svn/=
tree/head/branches/ .

Thanks for the pointers, I will read through them.

>
> >
> >>
> >>   Q2: How can the BPF allow interacting with other process (e.g. inter=
 process communication
> >>       using read()/write()) which involves opening some file on the fi=
lesystem and sleeping
> >>       for arbitrary duration?
> >
> > The BPF program runs in the kernel context, so yes all of this is
> > possible. IPC can be done with the bpf_ring_buffer / maps and BPF also
> > has the ability to send signals. One can poll on the ring buffer on
> > events and data from the BPF program and do a lots of things.
>
> OK, BPF allows sleeping operations; that's good.
>
> Some of core requirements for implementing TOMOYO/AKARI/CaitSith-like pro=
grams
> using BPF will be:
>
>   The program registered cannot be stopped/removed by the root user.
>   This is made possible by either building the program into vmlinux or lo=
ading
>   the program as a LKM without module_exit() callback. Is it possible to =
guaranee
>   that a BPF program cannot be stopped/removed by user's operations?

Yes, there is a security_bpf hook where a BPF MAC policy can be
implemented and other LSMs do that already.

>
>   The program registered cannot be terminated by safety mechanisms (e.g. =
excessive
>   CPU time consumption). Are there mechanisms in BPF that wouldn't have t=
erminated
>   a program if the program were implemented as a LKM rather than a BPF pr=
ogram?
>

The kernel does not terminate BPF LSM programs, once a BPF program is
loaded and attached to the LSM hook, it's JITed into a native code.
From there onwards, as far as the kernel is concerned it's just like
any other kernel function.

>   Ideally, the BPF program is built into vmlinux and is started before th=
e global init
>   process starts. (But whether building into vmlinux is possible does not=
 matter here
>   because I have trouble building into vmlinux. As a fallback, when we ca=
n start matters.)
>   When is the earliest timing for starting a BPF program that must remain=
 till stopping

The kernel actually supports preloading certain BPF programs during early i=
nit.

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=
=3D0bc23a1d1c8a1b4a5e4b973a7a80a6d067bd3eef

This allows you to preload before init.


>   electric power supply? Is that when /init in a initramfs starts? Is tha=
t when init=3D
>   kernel command line option is processed? More later than when init=3D i=
s processed?

Also, It depends on whether you trust init or not (e.g. if the init
blob is somehow appraised and measured, then you can trust it to load
the right BPF LSM programs). and then you can choose to not preload
bpf programs in the kernel, rather load them sometime early in /init.

>
>   Amount of memory needed for managing data is not known at compile time.=
 Thus, I need
>   kmalloc()-like memory allocation mechanism rather than allocating from =
some pool, and
>   manage chunk of memory regions using linked list. Does BPF have kmalloc=
()-like memory
>   allocation mechanism that allows allocating up to 32KB (8 pages if PAGE=
_SIZE=3D4096).
>

You use the ring buffer as a large pool and use dynamic pointers to
carve chunks out of it, if truly dynamic memory is needed.

> And maybe somewhere documented question:
>
>   What kernel functions can a BPF program call / what kernel data can a B=
PF program access?

BPF programs can access kernel data dynamically (accesses relocated at
load time without needing a recompile) There are lot of good details
in:

https://nakryiko.com/posts/bpf-core-reference-guide/


>   The tools/testing/selftests/bpf/progs/test_d_path.c suggests that a BPF=
 program can call
>   d_path() defined in fs/d_path.c . But is that because d_path() is marke=
d as EXPORT_SYMBOL() ?
>   Or can a BPF program call almost all functions (like SystemTap script c=
an insert hooks into
>   almost all functions)? Even functions / data in LKM can be accessed by =
a BPF program?
>

It's not all kernel functions, but there is a wide range of helpers
and kfuncs (examples in tools/testing/selftests/bpf) and if there is
something missing, we will help you.

>
>
> On 2023/10/02 22:04, KP Singh wrote:
> >>> There are still a bunch of details (e.g. shared blobs) that it doesn'=
t
> >>> address. On the other hand, your memory management magic doesn't
> >>> address those issues either.
> >>
> >> Security is always trial-and-error. Just give all Linux users chances =
to continue
> >> trial-and-error. You don't need to forbid LKM-based LSMs just because =
blob management
> >> is not addressed. Please open the LSM infrastructure to anyone.
> >
> > It already is, the community is already using BPF LSM.
> >
> > e.g. https://github.com/linux-lock/bpflock
> >
>
> Thank you for an example. But the project says
>
>   bpflock is not a mandatory access control labeling solution, and it doe=
s not
>   intent to replace AppArmor, SELinux, and other MAC solutions. bpflock u=
ses a
>   simple declarative security profile.
>
> which is different from what I want to know (whether it is realistic to
> implement TOMOYO/AKARI/CaitSith-like programs using BPF).

Agreed, I was sharing it more as a code sample. There is an
interesting talk by Meta at LPC which I quite excited about in this
space:

https://lpc.events/event/17/contributions/1602/

These are just examples of flexible MAC implementations using BPF.

- KP

- KP
>

