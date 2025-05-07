Return-Path: <bpf+bounces-57607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FFEAAD31D
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 04:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B893A9EE4
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 02:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BA018A93C;
	Wed,  7 May 2025 02:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAagUVeS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049094A11
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 02:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746583889; cv=none; b=CRmcGfoSG87ZS6IWVm66O+wQVZVnhmXTIQg7uhLUh242SDXlUmGcRE9MlXgTMx7cuy/wvWGSOowJmmoHEYtSIb7mKYtDKiD2k8T37BFpVXDi3qniKA808Z1VXbK7yr04x5Xo2Otv50p35RWO0h2z6w+1mpW8Lhxb7aNf6PeMrYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746583889; c=relaxed/simple;
	bh=C7rPLtyqC9nVZgjbKMzkTQJrIFMhS8X4pwtQfOgKtrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jo692Pq23sATgGpsQ6bj1qahBmoVekgn4k1ZskA5sRY2Ivxl9kMFgrwUHgkAywBEb0qXpwBw4qq+yBqplahN3VJxU+LALOQQv/u+NyEhUzmfxCgdNWgdkUOaFlUEOJGQBXV6cPGOPMAzzjlT9aQp+pnkLlYYsvfW+/0MJyjTLmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAagUVeS; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ac339f53df9so1259336466b.1
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 19:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746583885; x=1747188685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4p8osoNsl0yZwCcTPd9uz9eV/u6NF0GoBb3O7opxQ40=;
        b=JAagUVeSbDktz16VzGwj7epee/RMhGoQk+DAi3h29aFNLOwxXtivAU+7M7CC9DeGFg
         nz37Jma1jCT3K0Il70jsEkArDwW2jIO2U0Xgtl47nrNYpOXqU4c74e0MbBUyD7YLFSY9
         S6qi8bvHuqx7Vk5JE9dhK75Fp8vIBorHE3WHL325aLjwYIDFDkKAtnpvZET/w4HBRXAT
         MzGEBJTRKK2Mf+l3/r2XBfY3YCLqif45EakuUw3SuFaPMMa0JQaYeqf3BZfzBNObkhqC
         Ey3TTGhcz18mCxLTu/vSVyTfZettAhWqv5uGJzOqEGHkfZUnMU6Td/WONjjOs9aa9pHV
         C8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746583885; x=1747188685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4p8osoNsl0yZwCcTPd9uz9eV/u6NF0GoBb3O7opxQ40=;
        b=nxGmwQbkCPKSCQg3kh+Z3kK5WJzXsiAbgGcxJM4plHuV7HRN8q3dpbRqn9Kvm+YFZm
         EJOfUEVkFthMNGSfufKHCrk9miMCLmzaTLwhWYLAcXaA6Yenre7Mo7gGF+3sK9ID2yM/
         au1YPM0/YSLdMihDitQiVyPvRoBajENkwc4Bbz6aj+QblhXj9CD16GyCgu0D+TwJ81bC
         Bp6rRrzF4jQFWBZGEnkgAgTFnlye9QHxiqRxa+kh3N1ft/+XFLbNtymg0sjWNWxWiZ43
         1LfjOej+/O45nMpvXNp3QOprrHduFpU8XNEGv0hw00sbJdwtlu12qEW7KqWdmNYVSGPz
         qodQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg9CPnhtKZvjR4dys6KtvKUvRxsCznS/Wi31rPY/5eBfF0I6PemP1xaQn8lSdGtxJUkp0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr0jOhCm3dQtKi09aNo3AeokVVpuMW1jhikreMj+DRYS8cwyec
	PVRTN2fH5iuyiflxlw87CshlvGODMkxVWTTS4Pk4Wrt47+rRa7cPtxv+Xys/eGYcV7YOV7rgO0i
	VPsZyA+tV1iFq0ik2kg2EHool0+U=
X-Gm-Gg: ASbGncsv5PoIe9slV+NEsfp5Q8TMxJAxRmf8n0HTVhHE0yVghtrmjp8I21EuM1V3rVO
	W0SdFYlI4SE4u+sh8EGa2/y92f+cf9zd63ExYYllqFhWnopjm3B2j4zXE1TScb4kB6HIVkuRCEd
	CAi4/FHKCXpT3LKGBNf8GPbpqWGtkant2+kcKvzMtPMTtiDYW/NECU0d+Aoy0wQPbwgt4=
X-Google-Smtp-Source: AGHT+IF5bZufqRZtSxsCibnJun/xIB9xLXXSwjVMV0kcgxISmWJFJc87P/JfOqfCp3huxrHh2YzxOuZ3GQMaSiZ2Vk0=
X-Received: by 2002:a17:907:c0d:b0:ace:cb59:6c59 with SMTP id
 a640c23a62f3a-ad1e8bf5341mr152545566b.32.1746583884884; Tue, 06 May 2025
 19:11:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420105524.2115690-1-rjsu26@gmail.com> <CAP01T75B87Vnq-kdq6gaNXj5xeOOiah-onm4weEZA=jm8W8JVQ@mail.gmail.com>
 <CAM6KYsuk060Fv43Djp4q57AwBcmmkHBitGgfSsCJZwbGqRmQEA@mail.gmail.com>
 <CAADnVQL_+5FiOwNEnaYZ-i52r4jDiStboWxA9VycARFboOjx6Q@mail.gmail.com>
 <CAP01T757KLkBx3FMAK8-7vYTO0v=RtWvkQpztS1Zugd8tHSnHA@mail.gmail.com>
 <CAADnVQKzgELtqZ_4pce7sOegE1i3azcija0w6Bn5OWH0LgpbQg@mail.gmail.com>
 <CAP01T75O90bgYeb1q1ot+=D9MxN3UXyji5T6mA+UsnPwQUF52g@mail.gmail.com> <CAADnVQKsjGFhqsZ6s8SRNbv=Fr3oU=o3GquvOwqg27S9m8B02w@mail.gmail.com>
In-Reply-To: <CAADnVQKsjGFhqsZ6s8SRNbv=Fr3oU=o3GquvOwqg27S9m8B02w@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 7 May 2025 04:10:48 +0200
X-Gm-Features: ATxdqUFXyjG86w9HeffgEnY4-V6NdCZCt3I15i_6Lm19cVTxu9FKvKrI02hG9bI
Message-ID: <CAP01T77bquNBKBRUC47bJkk-UvdWXeu7UPUhymuygLm0ojX7-g@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/4] bpf: Fast-Path approach for BPF program Termination
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Raj Sahu <rjsu26@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Dan Williams <djwillia@vt.edu>, miloc@vt.edu, ericts@vt.edu, rahult@vt.edu, 
	doniaghazy@vt.edu, quanzhif@vt.edu, Jinghao Jia <jinghao7@illinois.edu>, 
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 7 May 2025 at 03:15, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, May 6, 2025 at 5:39=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
> >
> > On Wed, 7 May 2025 at 02:33, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, May 6, 2025 at 4:00=E2=80=AFPM Kumar Kartikeya Dwivedi <memxo=
r@gmail.com> wrote:
> > > >
> > > > On Wed, 7 May 2025 at 00:45, Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Mon, May 5, 2025 at 10:55=E2=80=AFPM Raj Sahu <rjsu26@gmail.co=
m> wrote:
> > > > > >
> > > > > >       2. A BPF prog is attached to a function called by another=
 BPF program.
> > > > > >              - This is the interesting case.
> > > > > >
> > > > > > > What do you do if e.g. I attach to some kfunc that you don't =
stub out?
> > > > > > > E.g. you may stub out bpf_sk_lookup, but I can attach somethi=
ng to
> > > > > > > bpf_get_prandom_u32 called after it in the stub which is not =
stubbed
> > > > > > > out and stall.
> > > > > >
> > > > > > We have thought of 2 components to deal with unintended nesting=
:
> > > > > > 1. Have a per-CPU variable to indicate a termination is in-prog=
ress.
> > > > > >     If this is set, any new nesting won't occur.
> > > > > > 2. Stub the entire nesting chain:
> > > > > >     For example,
> > > > > >     prog1
> > > > > >          -> prog2
> > > > > >                 -> prog3
> > > > > >
> > > > > >    Say prog3 is long-running and violates the runtime policy of=
 prog2.
> > > > > >    The watchdog will be triggered for prog2, in that case we wa=
lk
> > > > > > through the stack
> > > > > >    and stub all BPF programs leading up to prog2 (In this case =
prog3
> > > > > > and prog2 will
> > > > > >    get stubbed).
> > > > >
> > > > > I feel that concerns about fentry/freplace consuming too much
> > > > > while parent prog is fast-exiting are overblown.
> > > > > If child prog is slow it will get flagged by the watchdog sooner =
or later.
> > > >
> > > > No, there's some difference:
> > > > It becomes more common because we're continuing to execute the suff=
ix
> > > > of the program in the stub.
> > > > Compared to stopping executing and returning control immediately.
> > > >
> > > > > But fentry and tailcall cases are good examples that highlight
> > > > > that fast-execute is a better path forward.
> > > > > Manual stack unwind through bpf trampoline and tail call logic
> > > > > is going to be quite complex, error prone, architecture specific
> > > > > and hard to keep consistent with changes.
> > > > > We have complicated lifetime rules for bpf trampoline.
> > > > > See comment in bpf_tramp_image_put().
> > > > > Doing that manually in stack unwinder is not practical.
> > > > > iirc bpf_throw() stops at the first non-bpf_prog frame including
> > > > > bpf trampoline.
> > > > > But if we want to, the fast execute approach can unwind through f=
entry.
> > > > > Say hw watchdog tells us that CPU is stuck in:
> > > > > bpf_prog_A
> > > > >    bpf_subprog_1
> > > > >      kfunc
> > > > >        fentry
> > > > >           bpf_prog_B
> > > > >
> > > > > since every bpf prog in the system will be cloned and prepared
> > > > > for fast execute we can replace return addresses everywhere
> > > > > in the above and fast execute will take us all the way to kernel =
proper.
> > > >
> > > > The same will be true for unwinding, we can just unwind all the way=
 to
> > > > the top of the stack trace in case of cancellation-triggered
> > > > unwinding.
> > > > If trampoline calls some program, it will see it as a return from t=
he
> > > > called BPF program just like stubs would return.
> > > >
> > > > You're essentially going to replace return addresses to jump contro=
l
> > > > to stubs, we can do that same for jumping into some unwinding code
> > > > that can continue the process.
> > > > Be it unwinding or stubs, once control goes back to kernel and clea=
n
> > > > up must continue, we will have to pass control back to code for bot=
h.
> > > >
> > > > Conceptually, both approaches are going to do something to clean up=
 resources,
> > > > that can be executing stub code or calling release handlers for
> > > > objects on stack.
> > >
> > > I feel you're missing my point.
> > > For unwinding to work through bpf trampoline the unwinder needs
> > > to execute very specific trampoline _exit_ procedure that is arch
> > > specific and hard coded during the generation of trampoline.
> > > That's a ton of extra complexity in unwinder.
> > > It's not just calling destructors for objects.
> > > Depending on trampoline and the progs in there it's one or more
> > > __bpf_prog_exit*, percpu_ref_put(),
> > > and extra headache due to bpf_stats_enabled_key(),
> > > and who knows what else that I'm forgetting.
> >
> > What I'm saying is that we don't have to do all that.
> > It's just overcomplication for the sake of it.
>
> So you discarded this use case because the unwind approach
> cannot deal with it?

At this point, I think we're talking past each other.
I haven't discarded anything.
I just rephrased what I said earlier.

When you have a stack trace interspersed with BPF and kernel frames,
control should bounce between BPF cleanup and kernel side (which will
be steered to return back to BPF side, eventually returning control to
kernel proper).

Be it stubs, be it unwinding.
It needs to work, but it won't be very different for both cases.
No support exists yet, so solution space must be explored, but it
won't be very different for both.
You're insisting "unwinding needs to unwind through kernel frames so
it's complex" but it's not.

When control goes back to the kernel, be it stubs or unwinding, it
will go back to the caller BPF program and then we continue the
cleanup, either through stubs or unwinding.

The flow of control from BPF to the kernel is through return from the
function call. Inside the program, we can destruct frames by just
letting it fast-execute or unwind.

> And then claim that within this limited scope they're equivalent?
> :)
> prog -> trampoline -> prog was just one example.
> unwinder is helpless when there is any kernel code between progs.
> sched-ext will have hierarchical scheds eventually.
> prog->kfunc->prog
> Unwinding inner prog only is imo broken, since we need to abort
> the whole thing.
> Even simpler case:
> prog->for_each->subprog_callback.
> That callback is likely tiny and unwinding into for_each kfunc
> doesn't really abort the prog.

I didn't say we'll only unwind the callback.

We will unwind the callback, return control into kfunc, it will clean
itself up and return to prog, and then we continue unwinding when it
returns into caller BPF program.
And we'll do exactly this with stubs as well.

Program stub callback will return to kfunc, kfunc will return to
program, and replaced return address causes jump into stub again.

> Unwind approach works in higher level languages because the compiler
> sees the whole control flow from main entry till the leaf.
> The verifier is blind to kernel code, so unwind is limited
> to progs only and doing it poorly.

We still model callbacks as direct calls in symbolic execution.
From the perspective of the virtual machine, kernel functions in the
middle are just setting up more context and hidden.
So we will still see the whole CFG and all possible reachable program paths=
.

Unwinding or stubs will work the same way.
Unwind / return using stubs from sequential contiguous sets of BPF
frames until the point where the kernel has called into them.
Kernel returns back into caller BPF context. Then continue if we need
to clean up the entire stacktrace until we get to kernel proper.

> We still don't have support
> for bpf_throw with object cleanup and at this point we should
> align all efforts into fast execute, since it's clearly the winner.

Well, it's not because of lack of trying.
I've implemented it, I've addressed feedback and concerns, I've even used i=
t in
interesting ways and hopefully demonstrated value.

But until we agree on the implementation, we cannot land it.
It's a chicken and egg issue.
If we add it, sched-ext will replace their MEMBER_VPTR and other
associated macro hacks.
https://github.com/sched-ext/scx/blob/main/scheds/include/scx/common.bpf.h#=
L227

bpf_printk() in bpf_arena_spin_lock implementation is similar.

> bpf_throw may stay as a kfunc with fast execute underneath or

Yes, by having users write clean up code which is what they are doing today=
.
Which defeats the whole point of supporting assertions.
Then it's a kfunc with a misleading name, it's
bpf_fail_everything_from_this_point().

> we may remove it, since it has no users anyway.

I think you misunderstand what bpf_throw/exceptions were supposed to achiev=
e.
The whole point of bpf_throw() was to support assertions, where one
does not write clean up code.

The path containing bpf_throw is _not_ explored.

You do bpf_assert(i < N) and don't write anything to handle the case
where i >=3D N, and arr[i] is not well-formed.
This is the benefit to program writers: they can assert something as
true and don't have to "appease" the verifier by writing alternative
paths in the program.
The program is aborted in case the assertion does not hold.

---

Just to summarize the discussion:

There are two classes of termination:
- Cooperative (bpf_throw()/assertions/panic).
- Non-cooperative (program is stuck and kernel needs to abort it).

BPF_EXIT is cooperative, but we statically enforce resource cleanup.

Both cases need to do something similar, perform program cleanup, so
infra for bpf_throw is reusable to do non-cooperative terminations.

Fast-execute and unwinding both work for the second case, as I've
described above.

They can work even when we have BPF -> kernel -> BPF -> kernel in the
stack trace and go all the way back to the kernel calling the first
BPF context.
Nature of the solution for both cases is the same, how they destruct
BPF frames is different.
If we're using stubs, we will execute stubs for the BPF portions and
return control into kernel and eventually get it back in caller BPF
prog.
With unwinding, we do the same, the frames are destructed and control
returns into kernel (e.g. a callback will return some value).
Eventually, we repeat it all the way up the stack trace and clean up everyt=
hing.

But we can only unwind for assertions, because by definition, the
program path taken when the assertion fails cannot be explored.
Does Rust keep executing the rest of the program when assert_eq!(x, y) fail=
s?
Whether we use tables to do it or have the compiler emit them or do
anything else (how) is immaterial to the basic requirement (what).

The virtual machine must stop/halt, ergo, when it is mapped to a real
architecture, we need to stop program execution and perform resource
cleanup.
Verifier won't explore the path where it hits bpf_throw further.

So we cannot use fast-execute to do assertions, because users are
forced to handle the case where bpf_assert() fails.
Then it is no better than an if condition, the verifier still explores
the supposedly. untaken branch.

Anyway, I don't think I can explain this more clearly.

I can only imagine three scenarios from this discussion.

- Assertions are unnecessary.
 - Then we don't have to continue discussing further, and we can just
focus on fast-execute, and phase out bpf_throw().
- They are useful, but not necessary now.
 - Then it is very likely we'll end up with two ways of doing
essentially the same thing.
- Fast-execute can do assertions, so above doesn't apply.
  - Then we just disagree about what "assertion" means.

