Return-Path: <bpf+bounces-52950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92455A4A75B
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 02:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A318B16A04F
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 01:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0EA3EA83;
	Sat,  1 Mar 2025 01:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGt236Ax"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2258C14A82;
	Sat,  1 Mar 2025 01:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740792237; cv=none; b=o9oktXGP5+TPKrQmnj3erOxXfocdAoneNBKbfrjOmrorZkHddtYMdFrGR8lEc3XkAM5qpvQTjqSKswJm96h4mtEq9+TLRyLw9oXDm3/pZ1J0C6LZeHoq9Z9qLJG0JL6JG99RSm/WJuHp8oHNKmo1e04FC4FR6iX74c+Cb/eIfl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740792237; c=relaxed/simple;
	bh=b/oJdm6bjXZe85c9GwsNJLs7S7eyWrYSfVj/xJk++Ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQ6Oky2cLM0/40OugCp8TKKtWBcwSILidKtr0A0yoQ18hoBRRdLr0WRTDjHLh/QjX5m3vPyyyBoHjx/VKDeU8aWyhrlIsYm1svXbjGLPsyoOzHmT27EWGibyeEaxdCnoN+iFAn6OxfRIQVFi3HKrCu+WQjE2XzCkzofLgDYrqWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGt236Ax; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-abbdf897503so675123966b.0;
        Fri, 28 Feb 2025 17:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740792233; x=1741397033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/oJdm6bjXZe85c9GwsNJLs7S7eyWrYSfVj/xJk++Ig=;
        b=dGt236AxLNuo4WLjgp5ssqIsG2ZpNQcRNuVhaQBSQX8N+6Cl7uzzqqRS1Tw6eR5cD2
         /g57MMFC6Eg7xtu0HHmt2h7dQOi67QuZ6RBHniWVV/ReWqtKW5HWGVBnp3ZD5tOf8WEo
         7u0HHLoFf1/g74uiFedmb4xufLfHk2uJ7mb4n5F2HfnbzG8o7JAb/BxeslTgIOoRwgfi
         dekScUWvqGxVYloomw//zAqZ5hA+OVA/mP3xZTqO0QzVaJLH+mjL0TLWOfwYHNDBg2LJ
         4lJIPH13QjJoz7n9pf0mu46y/ylktG+J6pFIDEppPIX3/fWgebUec6hoj9o9KOn5UOZ2
         Qjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740792233; x=1741397033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/oJdm6bjXZe85c9GwsNJLs7S7eyWrYSfVj/xJk++Ig=;
        b=DZDRTY0RTRWpnYZdIibupYPs5dxqqKUVSYNKk/Krow0E883vkjSjDUabC6e86dK+25
         w8D50p4flMm9VDcI+j629FeCYBEuvuFC9QYTwIszkzogH1NVwjkNqATCKrYyUOGz7OVU
         BwKzox9oVbLmWnJnkO2R0tsByUWW1b/alfYet4VRGuWH+rOkv05poTSMOupi4kMXKmrJ
         mL1vC6EJaiupEZZN1qmgNpcGM/VVlcZnfN7KFq2DjTv5NYONgzlQPc3w4jiVR4g6fSbx
         rXN7UnkX7tCeKzUpfPPXlldfih2uiA4I79CiG+Iv24qctfj8pnvVeo9VniuV7cXC8D7K
         vwpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWEZ+2vCLQPx9HZJ2jFyuvNc4nH9Wpiw67EzmUSwkG7gYF+kgRvaMh+q2SKmXDpCVPlHM=@vger.kernel.org, AJvYcCVwVs8f8aG9lXdOnuxosVoIsLWGlVIQT1VIc8K+odCKhpJGlxpxKzvE/gqRmkmWQ9hGTVsDt11jtp6GbLKl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8OmiO4Pco4o73EGmoHlWofipDu8IggllWqvgmgySARZzWVbCd
	rgveXdlm5zOvhU9oE386D8XErxf6Uqbkl6BC5G/X6q4ub6baauJ9xhAVXi2R71+mPkjaOYwTy2U
	A1NEW6ipX/NxySKFBrgFyHvRDqf0=
X-Gm-Gg: ASbGnctO02B70Cp7q/1RbrPqoIyP93sJ6MuKc3kFAdcUhGD9jh925uqXQJPQ6s8asGl
	KazDo2qhhVhrbxG0sMSjLQ9K5vpiZx5K4HbMwFy0xmDToxlJqsBeYyBel6ZLK1G6lYox0KOHa3s
	+hu6Qvg5682OlanuJk3iZaR6yu7Bo=
X-Google-Smtp-Source: AGHT+IFKObYM3YgueqkWMDolNhSPNwztcgIsG4jMhFoy5JPSqsEUqCIb3ihURn8O+dY9SQmWbENCzXA8blCQQc67NyI=
X-Received: by 2002:a17:907:7fa6:b0:ab7:798:e16e with SMTP id
 a640c23a62f3a-abf2656df67mr466577466b.15.1740792233075; Fri, 28 Feb 2025
 17:23:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5080513BFAEB54A93CC70D4399FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080FFF4113C70F7862AAA5D99FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQLR0=L7xwh1SpDfcxRUhVE18k_L8g3Kx+Ykidt7f+=UhQ@mail.gmail.com>
 <AM6PR03MB50802FB7A70353605235806E99C32@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQ+TzLc=Z_Rp-UC6s9gg5hB1byd_w7oT807z44NuKC_TxA@mail.gmail.com>
 <AM6PR03MB508026B637117BD9E13C2F9299CD2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQ+cokog6j5RjO7qNwBWswXTbu-x2j4EoQEt405-2i5jXw@mail.gmail.com> <AM6PR03MB5080FC54F845102C913B596599CC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5080FC54F845102C913B596599CC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 1 Mar 2025 02:23:16 +0100
X-Gm-Features: AQ5f1JrRwwDAnpo9fm4HMTRfwiSniLMv1ZduTyuzbO3dYdt1Tw1gVs6R2Ary14s
Message-ID: <CAP01T76m7OP_u8C1hJMrpVqJGf77W00DE9qB-8Yq6Cd-BMQ=7g@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 4/6] bpf: Add bpf runtime hooks for tracking
 runtime acquire/release
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	snorcht@gmail.com, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Feb 2025 at 20:00, Juntong Deng <juntong.deng@outlook.com> wrote=
:
>
> On 2025/2/28 03:34, Alexei Starovoitov wrote:
> > On Thu, Feb 27, 2025 at 1:55=E2=80=AFPM Juntong Deng <juntong.deng@outl=
ook.com> wrote:
> >>
> >> I have an idea, though not sure if it is helpful.
> >>
> >> (This idea is for the previous problem of holding references too long)
> >>
> >> My idea is to add a new KF_FLAG, like KF_ACQUIRE_EPHEMERAL, as a
> >> special reference that can only be held for a short time.
> >>
> >> When a bpf program holds such a reference, the bpf program will not be
> >> allowed to enter any new logic with uncertain runtime, such as bpf_loo=
p
> >> and the bpf open coded iterator.
> >>
> >> (If the bpf program is already in a loop, then no problem, as long as
> >> the bpf program doesn't enter a new nested loop, since the bpf verifie=
r
> >> guarantees that references must be released in the loop body)
> >>
> >> In addition, such references can only be acquired and released between=
 a
> >> limited number of instructions, e.g., 300 instructions.
> >
> > Not much can be done with few instructions.
> > Number of insns is a coarse indicator of time. If there are calls
> > they can take a non-trivial amount of time.
>
> Yes, you are right, limiting the number of instructions is not
> a good idea.
>
> > People didn't like CRIB as a concept. Holding a _regular_ file refcnt f=
or
> > the duration of the program is not a problem.
> > Holding special files might be, since they're not supposed to be held.
> > Like, is it safe to get_file() userfaultfd ? It needs in-depth
> > analysis and your patch didn't provide any confidence that
> > such analysis was done.
> >
>
> I understand, I will try to analyze it in depth.
>
> > Speaking of more in-depth analysis of the problem.
> > In the cover letter you mentioned bpf_throw and exceptions as
> > one of the way to terminate the program, but there was another
> > proposal:
> > https://lpc.events/event/17/contributions/1610/
> >
> > aka accelerated execution or fast-execute.
> > After the talk at LPC there were more discussions and follow ups.
> >
> > Roughly the idea is the following,
> > during verification determine all kfuncs, helpers that
> > can be "speed up" and replace them with faster alternatives.
> > Like bpf_map_lookup_elem() can return NULL in the fast-execution versio=
n.
> > All KF_ACQUIRE | KF_RET_NULL can return NULL to.
> > bpf_loop() can end sooner.
> > bpf_*_iter_next() can return NULL,
> > etc
> >
> > Then at verification time create such a fast-execute
> > version of the program with 1-1 mapping of IPs / instructions.
> > When a prog needs to be cancelled replace return IP
> > to IP in fast-execute version.
> > Since all regs are the same, continuing in the fast-execute
> > version will release all currently held resources
> > and no need to have either run-time (like this patch set)
> > or exception style (resource descriptor collection of resources)
> > bookkeeping to release.
> > The program itself is going to release whatever it acquired.
> > bpf_throw does manual stack unwind right now.
> > No need for that either. Fast-execute will return back
> > all the way to the kernel hook via normal execution path.
> >
> > Instead of patching return IP in the stack,
> > we can text_poke_bp() the code of the original bpf prog to
> > jump to the fast-execute version at corresponding IP/insn.
> >
> > The key insight is that cancellation doesn't mean
> > that the prog stops completely. It continues, but with
> > an intent to finish as quickly as possible.
> > In practice it might be faster to do that
> > than walk your acquired hash table and call destructors.
> >
> > Another important bit is that control flow is unchanged.
> > Introducing new edge in a graph is tricky and error prone.
> >
> > All details need to be figured out, but so far it looks
> > to be the cleanest and least intrusive solution to program
> > cancellation.
> > Would you be interested in helping us design/implement it?
>
> This is an amazing idea.
>
> I am very interested in this.
>
> But I think we may not need a fast-execute version of the bpf program
> with 1-1 mapping.
>
> Since we are going to modify the code of the bpf program through
> text_poke_bp, we can directly modify all relevant CALL instructions in
> the bpf program, just like the BPF runtime hook does.

Cloning the text allows you to not make the modifications globally
visible, in case we want to support cancellations local to a CPU.
So there is a material difference

You can argue for and against local/global cancellations, therefore it
seems we should not bind early to one specific choice and keep options
open.
It is tied to how one views BPF program execution.
Whether a single execution of the program constitutes an isolated
invocation, or whether all invocations in parallel should be affected
due to a cancellation event.
The answer may lie in how the cancellation was triggered.

Here's an anecdote:
At least when I was (or am) using this, and when I have assertions in
the program (to prove some verification property, some runtime
condition, or simply for my program logic), it was better if the
cancellation was local (and triggered synchronously on a throw). In
comparison, when I did cancellations on page faults into arena/heap
loads, the program is clearly broken, so it seemed better to rip it
out (but in my case I still chose to do that as a separate step, to
not mess with parallel invocations of the program that may still be
functioning correctly).

Unlike user space which has a clear boundary against the kernel, BPF
programs have side effects and can influence the kernel's control
flow, so "crashing" them has a semantic implication for the kernel.

>
> For example, when we need to cancel the execution of a bpf program,
> we can "live patch" the bpf program and replace the target address
> in all CALL instructions that call KF_ACQUIRE and bpf_*_iter_next()
> with the address of a stub function that always returns NULL.
>
> During the JIT process, we can record the locations of all CALL
> instructions that may potentially be "live patched".
>
> This seems not difficult to do. The location (ip) of the CALL
> instruction can be obtained by image + addrs[i - 1].
>
> BPF_CALL ip =3D ffffffffc00195f1, kfunc name =3D bpf_task_from_pid
> bpf_task_from_pid return address =3D ffffffffc00195f6
>
> I did a simple experiment to verify the feasibility of this method.
> In the above results, the return address of bpf_task_from_pid is
> the location after the CALL instruction (ip), which means that the
> ip recorded during the JIT process is correct.
>
> After I complete a full proof of concept, I will send out the patch
> series and let's see what happens.

We should also think about whether removing the exceptions support makes se=
nse.
Since it's not complete upstream (in terms of releasing held resources), it
hasn't found much use (except whatever I tried to use it for).
There would be some exotic use cases (like using it to prove to the
verifier some precondition on some kernel resource), but that wouldn't
be a justification to keep it around.

One of the original use cases was asserting that a map return value is not =
NULL.
The most pressing case is already solved by making the verifier
smarter for array maps.

As such there may not be much value, so it might be better to just
drop that code altogether and simplify the verifier if this approach
seems viable and lands.
Since it's all exposed through kfuncs, there's no UAPI constraint.


>
> But it may take some time as I am busy with my university
> stuff recently.

