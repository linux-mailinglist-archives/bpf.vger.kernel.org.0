Return-Path: <bpf+bounces-46305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECD49E7806
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 19:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4A0285BA8
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 18:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763C71FFC67;
	Fri,  6 Dec 2024 18:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O44/mMT9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270AC194120
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733509461; cv=none; b=qYrGh/4i6Z8ygWN0w1tMAK77gE9/HGbdi4RlV2ZqYWgvcU8BdzPtbsWzzq/1tJrsCUpEp6UBzRpOcpc500BhZ9Ibs03ehk1ot59WH2V3T6P6MrZ4/T7VnH7qa6GZeWeKYPJEyzVdDHHsqU20F6K/VE3u5ovkF6nckwfb+fmh1Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733509461; c=relaxed/simple;
	bh=0apnUX//+LAjxUc/AN77kX4ZTgOG0hjzE1FWYpXW2no=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dI4vPSAg6n5sYP+398N8n03elxfXKuz4vegs7V0XmQDkVDRPV1rLPcJgDIynkaj5fcEzVzeQJD2Kw8aj8p0aUqYAcaokZxorZgU/6gIRSfxtBl9H+sLfPy3qcRGvdBic9Q0elp4GLMYoiVfS6+01nQ3S8LJm8BJDZfDmKkQ6h2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O44/mMT9; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8e52so3707339a12.1
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 10:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733509457; x=1734114257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/mw4UQ5LKPH56cPyrALjRWD9RnEae8TK4ybqWADEBc=;
        b=O44/mMT9grZRB33rWzG+tkqE5kWx909cMnwEahlF1QnzzD9EhEllMShrulpPK5zUJe
         boYxXAF8bvOWOwX9wMDQKuvf4cQxT21pK4U53SXj7nyUoVY0fziLVkqN3XwsX22e5kef
         S7koMzoY3VHnB3qJs9J0K/ar0wONiw0X1XekEJ5whdXdHo7ZkyYyAES2tUFLbXtEN/St
         GEWhAE8pfOrCFCJplzPN6C/sKUDeV1L7fYDbVPWMbzcaRatL+UC8jDbmt6qspkUpvtwe
         D8KMnqLnxTMTp0g0WBWKMeH1FIDQO2GR5AiR/TBJeU6MDdP/Ve0IsR6WuItGWVMgF6f+
         t5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733509457; x=1734114257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/mw4UQ5LKPH56cPyrALjRWD9RnEae8TK4ybqWADEBc=;
        b=KonFaL4S3l/3s5aqqu2HgdU/JXF9wnsx5TiEk1xCmuDE1mus8AgvRRUI4b7jbL0uhg
         91LvboSDet4iPbXfluG6BmSpz4vSujTAyYqntfAoAjnBewcNabico2inSOWQGZsUa5N5
         OcHaV75tnIpRRDRyIOKt+vZxLnSW9F30c/zSweg+ehhTndLptVlZEtF1VbPQgma05Bjt
         x7xCZiouuOXebmXz//caJeVs0A9wAlhnjUSnf1iEhcrsqu26i/C0LgB5+oUiuM90G7S2
         qXxY7DJ7qsDY4XAZ6SSnzTDhTo+FdOY2ytyMeRYO0Qltw6TpNwSuFrCLwX5aijcXMk0m
         N4DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYbqAgAFGBpGJYcGC4L9Lc4WL08lYLj2Z/OZnE/0cY+1j1GZLSPFiwZy//X6k9rz+rkxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz82y02Zdw715jzNBd/X0gAE2IGWyuvQNTbr6CCE6kOrRL72E6S
	+qUh7PdvKDuBakymXSREdzXSuBi/LRPsemwxvnjAmEnbw6QoURSnBD5RzGy77lt94UW9PvN4Yxr
	gSxTEUt/fGN/srpJH7QUSNTu56DQ=
X-Gm-Gg: ASbGncsfpp1GJ9K1IinLAJAMByev+O7lQS7n6KUAnziLMmzgH8roAgByN9LA7YnZAhj
	yhXCcpfA96zyBpCSFo1PftFF+IYSwJJ7uJZD0WnmaZCuDzxEPo3dLqx7q961CLTvM
X-Google-Smtp-Source: AGHT+IEotSGzQRD2uTrjP5gf2jvLGeNdTvHPuVMOEIdEMnFneG3+zS/Lc6UeZ9U04FW3vF2VQaqeoM3BQMWkfjh8W2c=
X-Received: by 2002:a05:6402:5295:b0:5d0:c098:69 with SMTP id
 4fb4d7f45d1cf-5d3be6d2a34mr4747675a12.16.1733509457209; Fri, 06 Dec 2024
 10:24:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com>
 <1b8e139bd6983045c747f1b6d703aa6eabab2c82.camel@gmail.com>
 <47f2a827d4946208e984110541e4324e653338e0.camel@gmail.com>
 <CAEf4BzZBPp40E-_itj1jFT2_+VSL9QcqjK4OQvt6sy5=iJx8Yw@mail.gmail.com>
 <4bbdf595be6afbe52f44c362be6d7e4f22b8b00f.camel@gmail.com>
 <CAADnVQKscY7UC-5nAYxaEM4FQZGiFdLUv-27O+-qvQqQX0To5A@mail.gmail.com>
 <1f77772b8c8775b922ae577a6c3877f6ada4a0a1.camel@gmail.com>
 <CAEf4BzZybLU0bmYJqH2XJYG_g8Pvm+STRdHBtE1c5zbhHvtrcg@mail.gmail.com>
 <CAADnVQJ7WuFge8YZ-g07VK6XhmMCf1RHa0B64O0_S4TLzu0yUg@mail.gmail.com>
 <CAEf4BzZPFy1XXf=2mXVpdVw70rJjgUfPnDOzWb5ZXrJF1=XqUA@mail.gmail.com>
 <CAADnVQL-0SAvibeS45arBoZcwYjQjVnsrMeny=xzptOdUOwdjQ@mail.gmail.com> <CAEf4BzZF3ZrVC0j=s2SpCyRWzfxS8Gcmh1vXomX4X=VS-COxJw@mail.gmail.com>
In-Reply-To: <CAEf4BzZF3ZrVC0j=s2SpCyRWzfxS8Gcmh1vXomX4X=VS-COxJw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 6 Dec 2024 19:23:40 +0100
Message-ID: <CAP01T77rBvM9sTQMbJBk2Ku5SRYHzQgvGaNf36v=BA7=nHTmeA@mail.gmail.com>
Subject: Re: Packet pointer invalidation and subprograms
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, andrii <andrii@kernel.org>, Nick Zavaritsky <mejedi@gmail.com>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Dec 2024 at 18:42, Andrii Nakryiko <andrii.nakryiko@gmail.com> wr=
ote:
>
> On Fri, Dec 6, 2024 at 8:20=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Dec 6, 2024 at 8:13=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Dec 6, 2024 at 8:08=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Thu, Dec 5, 2024 at 10:23=E2=80=AFPM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Thu, Dec 5, 2024 at 8:07=E2=80=AFPM Eduard Zingerman <eddyz87@=
gmail.com> wrote:
> > > > > >
> > > > > > On Thu, 2024-12-05 at 17:44 -0800, Alexei Starovoitov wrote:
> > > > > > > On Thu, Dec 5, 2024 at 4:29=E2=80=AFPM Eduard Zingerman <eddy=
z87@gmail.com> wrote:
> > > > > > > >
> > > > > > > > so I went ahead and the fix does look simple:
> > > > > > > > https://github.com/eddyz87/bpf/tree/skb-pull-data-global-fu=
nc-bug
> > > > > > >
> > > > > > > Looks simple enough to me.
> > > > > > > Ship it for bpf tree.
> > > > > > > If we can come up with something better we can do it later in=
 bpf-next.
> > > > > > >
> > > > > > > I very much prefer to avoid complexity as much as possible.
> > > > > >
> > > > > > Sent the patch-set for "simple".
> > > > > > It is better then "dumb" by any metric anyways.
> > > > > > Will try what Andrii suggests, as allowing calling global sub-p=
rograms
> > > > > > from non-sleepable context sounds interesting.
> > > > > >
> > > > >
> > > > > I haven't looked at your patches yet, but keep in mind another go=
tcha
> > > > > with subprograms: they can be freplace'd by another BPF program
> > > > > (clearly freplace programs were a successful reduction of
> > > > > complexity... ;)
> > > > >
> > > > > What this means in practice is whatever deductions you get out of
> > > > > analyzing any specific original subprogram might be violated by
> > > > > freplace program if we don't enforce them during freplace attachm=
ent.
> > > > >
> > > > >
> > > > > Anyways, I came here to say that I think I have a much simpler
> > > > > solution that won't require big changes to the BPF verifier: tags=
. We
> > > > > can shift the burden to the user having to declare the intent upf=
ront
> > > > > through subprog tags. And then, during verification of that globa=
l
> > > > > subprog, the verifier can enforce that only explicitly declared s=
ide
> > > > > effects can be enacted by the subprogram's code (taking into acco=
unt
> > > > > lazy dead code detection logic).
> > > > >
> > > > > We already take advantage of declarative tags for global subprog =
args
> > > > > (__arg_trusted, etc), we can do the same for the function itself.=
 We
> > > > > can have __subprog_invalidates_all_pkt_pointers tag (and yes, I d=
o
> > > > > insist on this laconic name, of course), and during verification =
of
> > > > > subprogram we just make sure that subprog was annotated as such, =
if
> > > > > one of those fancy helpers is called directly in subprog itself o=
r
> > > > > transitively through any of *actually* called subprogs.
> > > >
> > > > tags for args was an aid to the verifier. Nothing is broken without=
 them.
> > > > Here it's about correctness.
> > > > So we cannot use tags to solve this case.
> > >
> > > Hm.. Just like without an arg tag, verifier would conservatively
> > > assume that `struct task_struct *task` global subprog argument is jus=
t
> > > some opaque memory, not really a task, and would verify that argument
> > > and code working with it as such. If a user did something that
> > > required extra task_struct semantics, then that would be a
> > > verification error. Unless the user added __arg_trusted, of course.
> > >
> > > Same thing here. We *assume* that global subprog doesn't have this
> > > packet pointers side effect. If later during verification it turns ou=
t
> > > it does have this effect -- this is an error and subprog gets
> > > rejected. Unless the user provided
> > > __subprog_invalidates_all_pkt_pointers, of course. Same thing.
> >
> > So depending on the order of walking the progs, compiler layout,
> > static vs global the extra tag is either mandatory or not.
>
> How so? If the verifier can *reach* one of those special helpers
> during verification, then this tag would be required *for global
> subprog*.
>
> Or, *importantly*, if user anticipates that "freplace-ment" BPF
> program for such subprog might need to invalidate packet pointers, but
> the default subprog implementation doesn't actually call any of those
> special helpers, user can just explicitly say that "yes, this subprog
> should be treated as such that invalidates pkt pointers". With your
> approach there is no way to even express this, unless you hack default
> subprog implementation to intentionally have reachable
> pkt-invalidating helper, but not really call it at runtime.
>
> Think about some more advanced XDP chainer approach, where replacement
> slots would need this pkt invalidation capabilities (but default
> subprogs just are no-ops).

I think Andrii has a good point here, this would be an entirely
plausible scenario,
and with summarization alone we would reject such freplace. Then, the user,
due to the lack of explicit tagging, will insert an extra helper call
that does nothing
just to indicate "invalidates all packets" side effect when it could
have been done explicitly.
So in effect they just explicitly declared their intent, not through a
tag, but through code.

It might be that we can have a mix of both automatic detection and
such tagging, I was actually considering that this might be better (it
avoids extra burden for the common case, and allows explicit tagging
where necessary),  but then if the preference is to contain complexity
in the verifier, one wonders why not just explicitly tag anyway and
not add extra code? The same can be done for sleepable case in theory.


>
> > That is horrible UX. I really don't like moving the burden to the user
> > when the verifier can see it all.
>
> I disagree, but it doesn't matter. It's being clear and explicit about
> functionality that global subprog (verified in isolation) needs right
> now or might need later (e.g., due to freplace-ment)
>
> > arg_ctx is different. The verifier just doesn't have the knowledge.
>
> No, it's not. It's conceptually absolutely the same. Verifier can
> derive that global subprog arg has to be a trusted pointer. It's just
> that with pkt invalidation it's trivial enough to detect (crudely and
> eagerly, but still) in check_cfg(), while for trusted pointers you
> can't take this shortcut.
>
> I don't like the check_cfg()-based approach, it's hacky and subpar
> workaround, and goes against all the lazy verification philosophy we
> pursued with BPF CO-RE. I'm happy to discuss this offline if that will
> be easier to get through all the nuance, but if you guys insist, so be
> it.

