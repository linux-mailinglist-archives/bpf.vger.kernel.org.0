Return-Path: <bpf+bounces-57627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A60EAAD4C8
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 07:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1641A1C07257
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 05:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E6A1DE2DC;
	Wed,  7 May 2025 05:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3XMzpqx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3E223CB
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 05:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746594318; cv=none; b=PyRrZICcSY6bVnDpVezBZN/CCogRmMmW2RhdNla9n877iSVT5Qeg6VDjG3BMJdO6ZXYSxRnA+CnXSl2qsqmZEADK1JMzSy1Om+DprDxVkpa874waVObbrbQFhsu0JMQITur0nQ5O5VXAIqha0wcSYsFGETb9N23C8/i9mhP9wGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746594318; c=relaxed/simple;
	bh=YtK+MQV3D2bvDGX7V1n27M6J2RbxvP1lrVY/5VKtTXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IMd0FtJf/V7SW7Ib0Q47w6WbuDRgUXWFpETRAK+ATup8qOMQZ86+tGWYclrY0FCtNBjHPjH+H9rEmm9hQDsvZS8x4FyzmRIyDwPxccPJLLfpyDWzytzGKU8EIKh+mxSUK+OmO5ao4/ivo+XyNm1wyGXl5LNBs74L8iM4lhwd1QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3XMzpqx; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-acbb85ce788so252553266b.3
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 22:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746594315; x=1747199115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7OZ+a+2/aAsuNZGoqE+ExwhZBgYFMm2yHKjdcfGqM8=;
        b=X3XMzpqxfC4U0Hhlyq2kZPcgDBM7iXZDDxsc5wtGqGBZLfoPq9e3sByU8oeSGSFlNs
         RnUXQ5P95Wo/giiVldXLrqUwAhCAQiDNYGixVRWkIOMlPKsdx6PfM+2EbZ84yBg0pMR6
         kaKsANpDKZp3sTkYQ6uIYsxdlAY+8RDiQ8LLbHoE+JL4OMYQVJw7/1L4CwWIu4STIIj2
         0sro0E0LafCD9XLq5C6YIRXzEuUQqoE1SXbMlO+NjASPvJ7bPkaKvgRkyTElj/5ZdPQl
         uCjW2fNTZ/bEzi1Sc6Al8L7iUCVeHzxPXyy6LetTm/8YjAyAlbVGyybrxI1aZY0KrLBU
         +FCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746594315; x=1747199115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r7OZ+a+2/aAsuNZGoqE+ExwhZBgYFMm2yHKjdcfGqM8=;
        b=eR7hTWjfdeuoiF7bVWz2kPtCZ/pYXknDS2fZtxfWV6nqmg0Ha4hiy7ItU+ngMFTLCZ
         9ezKiyHyvoYvSuGkF9V9r/o+DQJgaDmdJHPs+mH0SxzqKtOeEqWvn7rrK4JnSrdlBSqF
         GceEF58kF85hKVkES50oX4EnUHsE5obhOM3Y7mhmfmsCOndtiI3lKBn8uvV0oFkN1dUB
         aax4bHOL4aokQL42g2zY+wVLlDSdMuMAF5Xxw/baKSLF0xYLSF7tlxtQaRWKR/Rq9VAy
         c2ZaJVJjl7803MqqR8jRLr//li2QmHdzwD2ulkwPdu5mH9B0wbwDGuTpM+mCoRB1GQx5
         7IAg==
X-Forwarded-Encrypted: i=1; AJvYcCWOwL0yoO5M0ur1ODjUUKMbj8X/U7NYDouEobL07NchM/P3pB8mE2Tp/hu8XMw7dr2zoJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Ukk/W/cbN6Z4YuW3gCZ3+yw4KaaUcTUmEB5nuWl58HSRbarl
	dWRy4tC3hC8118ncJx901sD1Z4H3WC166oTOj1sUO+SGUV2njEvhCasHah7fqsTE1HGhcfJViTR
	dD45HkQ5AjGkAmL+iGxw3qWNIcTw=
X-Gm-Gg: ASbGnctXb8z83GX8cRWZY5Oumit5Ygob6sMK4oRJs5zDuqjVEhoF/aTrzMAoVYoQeMQ
	hPtULZDK7N91nki+IYNRDrn6/omq3u+TVM525+vQ5l+FMYjODiuUoPehgHDN7SEPd3ksSPdcTaT
	xPX1qCwWvtxoFwx1hEVG6de8fNK893zk/+Ptfk/RsfoeaRsQmeJCEeJ2cf
X-Google-Smtp-Source: AGHT+IE5zbRaAr+TAFeObGfJXNgGAaOpe5+yWh2PAjasVmiJuFij3ATK9+9huk5h16ypAZHQE/zG6SU2WHCcVZ9VxVw=
X-Received: by 2002:a17:907:3f98:b0:ace:9d3e:1502 with SMTP id
 a640c23a62f3a-ad1e8d70dd2mr161772766b.4.1746594314647; Tue, 06 May 2025
 22:05:14 -0700 (PDT)
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
 <CAP01T75O90bgYeb1q1ot+=D9MxN3UXyji5T6mA+UsnPwQUF52g@mail.gmail.com>
 <CAADnVQKsjGFhqsZ6s8SRNbv=Fr3oU=o3GquvOwqg27S9m8B02w@mail.gmail.com>
 <CAP01T77bquNBKBRUC47bJkk-UvdWXeu7UPUhymuygLm0ojX7-g@mail.gmail.com> <CAADnVQLauqDRatfDw=yCK+v86H3c2tfVGhXPb3bEPK3NSTM=dg@mail.gmail.com>
In-Reply-To: <CAADnVQLauqDRatfDw=yCK+v86H3c2tfVGhXPb3bEPK3NSTM=dg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 7 May 2025 07:04:37 +0200
X-Gm-Features: ATxdqUGxz3AXbsJaItvn9l_BX4LDaR7hXmvWHy4lQ8HuS6dpT9ZqIQJvUWytYVQ
Message-ID: <CAP01T75806WbxGdg_aJXFq99DeO49s21wnaiGV94yD3WLLhCvg@mail.gmail.com>
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

On Wed, 7 May 2025 at 05:36, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, May 6, 2025 at 7:11=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
> >
> > We will unwind the callback, return control into kfunc, it will clean
> > itself up and return to prog, and then we continue unwinding when it
> > returns into caller BPF program.
> > And we'll do exactly this with stubs as well.
> >
> > Program stub callback will return to kfunc, kfunc will return to
> > program, and replaced return address causes jump into stub again.
>
> Ok, so this is a new proposal where unwind would
> jump back into kfunc, but it will also replace the address
> where kfunc would have returned with a jump to 2nd phase
> of unwinder.

I don't see why it's new, but fine.
Even today, when we throw, we eventually return to the kernel with a retq.
In my mind it's the same thing we'll do intermediate unwinds.

Yes, we'll modify the return addresses to jump back into unwinder, but
it has to be done either way.
Even for stubs, you're rewriting the return address.

Back when this was added, we didn't add support for callback unwinding
because we were having a similar discussion.
Back then, the proposal was similar, a return value to let kernel
callback loops detect when to stop iterating and start returning.
And then you'd continue unwinding once in.
We decided we can table it for the time being since callbacks were
potentially less common users of whatever was being added.

We can argue about details but on a high level it's the same idea.

> So for
> prog A -> kern -> prog B -> kern -> prog C.
> In the first phase the unwinder will deal with C,
> then let kern continue as normal code, but the kernel
> will 'ret' back into unwinder machinery, so it can
> continue to unwind B, then another jump back to unwinder
> machinery to unwind A.

Yes, and stubs would work the same way.
In both cases you have the unwinder entry / stub entry, and modify all
return addresses in each BPF frame.

Then it finds and executes logic for that pc and unwinds frames until
it hits a boundary.
Or executes the rest of the program and returns.

Code that does this return address rewriting can be oblivious to the
underlying mechanism.
It does rewrite of return addresses in a loop and just relies on logic
being invoked.
Kernel will simply execute the rest of the logic and return, all the way up=
.

>
> Yes, it can be made to work, but this is quite complex,
> and it's really a combination of unwind and fast-execute
> through kernel bits.
>
> When the whole thing is fast executed there is only one
> step to adjust all return addresses on the stack, and then
> everything just flows to the kernel proper.
> Much simpler than going back to unwind machinery
> and without a seesaw pattern of stack usage.
>

Fine, I think I've said what I wanted to say.

> > If we add it, sched-ext will replace their MEMBER_VPTR and other
> > associated macro hacks.
> > https://github.com/sched-ext/scx/blob/main/scheds/include/scx/common.bp=
f.h#L227
>
> I really doubt it. It's fighting the verifier because the verifier
> needs to see that bounds check. That's why it's macro with asm.
>

Sure, it needs to see it. But that was the whole point.
That's the part we'll assert and not handle the other case, which
verifier forces us to handle.
Any complex program is littered with such cases.

> > > bpf_throw may stay as a kfunc with fast execute underneath or
> >
> > Yes, by having users write clean up code which is what they are doing t=
oday.
> > Which defeats the whole point of supporting assertions.
> > Then it's a kfunc with a misleading name, it's
> > bpf_fail_everything_from_this_point().
>
> Indeed. That's a better name. 'throw' has an incorrect analogy.
>
> > You do bpf_assert(i < N) and don't write anything to handle the case
> > where i >=3D N, and arr[i] is not well-formed.
> > This is the benefit to program writers: they can assert something as
> > true and don't have to "appease" the verifier by writing alternative
> > paths in the program.
>
> That indeed was the goal of assertions, but I think it was explored
> and it failed.
> #define bpf_assert(cond) if (!(cond)) bpf_throw(0);
>
> should have worked, but the compiler doesn't care about keeping
> "if (!(cond))" like that.
> All the asm volatile ("if .. were added
> in __bpf_assert() form and in bpf_cmp_likely().
> And they didn't succeed.
> They're too unnatural for C code.
> All uses remained in selftests.

Again, this is chicken and egg.
Resource cleanup doesn't happen so it cannot be used by anyone.
The verifier just rejects the program.

We have all other variants for integers doing things in assembly so
the compiler doesn't optimize things away.
And they work reliably, there are tests ensuring that.

"Didn't succeed" is the correct verdict when something was implemented
fully, put into the hands of people, and failed to gain traction.

The same goes for bpf_cmp_likely, success and failure is not intrinsic
to the concept alone.
Most people don't even know about the macro.
It's tucked somewhere deep in selftests with no visibility.
Most people don't know they need to copy bpf_experimental.h as part of
their BPF workflow to gain access to useful primitives.
We have no stdlib, so things go unnoticed.

There is no documentation or blog post describing when it's useful.
If they did and were told when it's useful, I'm sure people would make
use of it when they hit a related problem.
Unless you're an expert at following verifier output you're out of luck.
Most people are not even reading the mailing list, so they have no way
of catching up with all the new developments.

>
> > Does Rust keep executing the rest of the program when assert_eq!(x, y) =
fails?
> > Whether we use tables to do it or have the compiler emit them or do
> > anything else (how) is immaterial to the basic requirement (what).
>
> The high level language can do it, because it's done at a compiler level.
> rust->bpf compiler can be made to support it, but we deal with C and
> bpf_assert(i, <, 100);
> arr[i] =3D ..;
> didn't fly.
>
> > - Assertions are unnecessary.
> >  - Then we don't have to continue discussing further, and we can just
> > focus on fast-execute, and phase out bpf_throw().
> > - They are useful, but not necessary now.
>
> They could have been useful, but I think we already explored
> and concluded that it's very hard to do true C++like throw()
> in the verifier alone. Too many corner cases.

Sure, there are tradeoffs.
It's the same tradeoff of performing program analysis on compiled
low-level bytecode that the verifier deals with in general, much of
the program structure and semantics are lost.

The main problem was non-converging paths, but there were ways to fix
it without "merging" tables.

When Eduard and I discussed a compiler solution long back, the
conclusion was to do:
1) prep tables simply by tracking which resources are where, so map
verifier_state to a distilled struct.
2) fix non-convergence by spilling to unique locations in the stack.
No table merging complexity.
This works even when the compiler provides no support, so we make it
work for all existing programs.
And replace 1) with a table of compiler supplied landing pads when
provided by it.
The verifier will just explore if the landing pad did the right thing
(series of release kfunc calls) before terminating path exploration.

>
> I also doubt that we can go with a compiler assisted approach where
> the compiler will generate cleanup code for us.
> Ideally the users would write
> assert(i < 100);
> and the compiler will generate cleanup, but
> it cannot do it without explicit __attribute__((cleanup(..)
> And if the users have to write it then
> if (i < 100) return;
> is just more natural without any complexity.

But both statements are not the same.
It has no complexity only when you don't have to release anything.
So it's a misnomer.

If you have the compiler's assistance, you can make it do it for you.
I don't why explicit tagging is needed if we're lifting the compiler.

Resources which need to be released are initialized to a valid state before=
 use.
Objects on the stack which are acquired across a throw will have
themselves cleaned up (and initialized accordingly if necessary).
And we'll just generate a landing pad corresponding to the throw where
they are destroyed.
This landing pad is never reachable by normal code.
Just that we won't emit "destructor" for the normal code unless
explicitly tagged with attribute((cleanup(...))).

I think every other bytecode VM managed to figure it out, including
WASM (and they did end up adding support to llvm).
Many other languages do a more powerful shift/reset and layer exceptions on=
 top.
The nature of the problem is different for all of them than us, but
there's nothing special about our case that precludes a compiler
solution.

WG14 will sort of bake all this in the standard with panic and defer.
https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2589.pdf (slide 19)
When the thread panic's, everything tagged with defer statement will
have its clean up logic done.

Anyhow, I've made my point and I think the thread has run its course.
Let's just continue with this approach, and remove the half-baked
support we have right now for exceptions, while we're at it.
It's just dead code since we don't plan on supporting the feature.

