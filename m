Return-Path: <bpf+bounces-28242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 911008B6F02
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 12:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47ACA28296B
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 10:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9299C1292E6;
	Tue, 30 Apr 2024 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9LKk/4Q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178FD22618;
	Tue, 30 Apr 2024 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714471386; cv=none; b=Bs0X0X5u9X+JSdHCqIKr+zdmpYhzfTpT0GW5UlpYq3ZMUuaZ8T+FUNz/YUdtCSljVAWDLOw4lygVA9vbK4O2ShuQ/Q/hfA5eW/Bg8OuP/jrUlj0wvneeCiJTIoiXXnD/V7fFiNj4eO+0yQSLtmauH2pkxnRobFwjW/pfziwSYx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714471386; c=relaxed/simple;
	bh=/SRik2rorGSK8PYXkeWdVKUDcHGjQcY0rc2GwpwuuW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akwQ0DwANaemxEKOihDZiBMFSwkMjY2X9YcZtEFGQeD2s6s0WtKcAUq+atwBs3+NZsRWG/S5fpyGLFpKhjgiM0cfIDQPtu2R2QUq9MaO8w2/FVFxRjhp4O05yWQOWO5lMthKRpMFpb5IMpfgTYP9aeobNx9beeDuwVrQH1Q/Xp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9LKk/4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78E5C2BBFC;
	Tue, 30 Apr 2024 10:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714471385;
	bh=/SRik2rorGSK8PYXkeWdVKUDcHGjQcY0rc2GwpwuuW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S9LKk/4QVt5iPGdjKAEci8RD3tJP0WL0BKEtFlxcF9bSi+0i9GQ+FKKPD0UZWKpja
	 y4+9x5SvVkLBYXUQQZGAtgRCdWc6pmKAE04Vo5T9WP9JBARwGHsXNwV4CEt9omMFmS
	 hTbdbTK8L5AG7vN0s0+vYywHJMupyJMCoyqQLkDzdTLS0yNlJAiYAxsTBgCeZ2sXgg
	 RYTvYQNv8XZiXog0gljpdqpVH3WpPRklknQTfjtjjY5biKXeF09cGPppOvjrSO2p9I
	 buabG5BNLFDwmkQQshugrrjsQfRvjx+UoaQ1qreLeAWQ4ZnakfR4WKZLgt6bCV1o1R
	 qe+dWb/lvaUKg==
Date: Tue, 30 Apr 2024 12:02:59 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: verifier: allow arrays of progs to be used in
 sleepable context
Message-ID: <mhkzkf4e23uvljtmwizwcxyuyat2tmfxn33xb4t7waafgmsa66@mcrzpj3b6ssx>
References: <20240422-sleepable_array_progs-v1-1-7c46ccbaa6e2@kernel.org>
 <7344022a-6f59-7cbf-ee45-6b7d59114be6@iogearbox.net>
 <un4jw2ef45vu3vwojpjca3wezso7fdp5gih7np73f4pmsmhmaj@csm3ix2ygd5i>
 <35nbgxc7hqyef3iobfvhbftxtbxb3dfz574gbba4kwvbo6os4v@sya7ul5i6mmd>
 <CAADnVQJaG8kDaJr5LV29ces+gVpgARLAWiUvE9Ee5huuiW5X=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJaG8kDaJr5LV29ces+gVpgARLAWiUvE9Ee5huuiW5X=Q@mail.gmail.com>

On Apr 24 2024, Alexei Starovoitov wrote:
> On Wed, Apr 24, 2024 at 7:17 AM Benjamin Tissoires <bentiss@kernel.org> wrote:
> >
> > On Apr 22 2024, Benjamin Tissoires wrote:
> > > On Apr 22 2024, Daniel Borkmann wrote:
> > > > On 4/22/24 9:16 AM, Benjamin Tissoires wrote:
> > > > > Arrays of progs are underlying using regular arrays, but they can only
> > > > > be updated from a syscall.
> > > > > Therefore, they should be safe to use while in a sleepable context.
> > > > >
> > > > > This is required to be able to call bpf_tail_call() from a sleepable
> > > > > tracing bpf program.
> > > > >
> > > > > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > > > > ---
> > > > > Hi,
> > > > >
> > > > > a small patch to allow to have:
> > > > >
> > > > > ```
> > > > > SEC("fmod_ret.s/__hid_bpf_tail_call_sleepable")
> > > > > int BPF_PROG(hid_tail_call_sleepable, struct hid_bpf_ctx *hctx)
> > > > > {
> > > > >   bpf_tail_call(ctx, &hid_jmp_table, hctx->index);
> > > > >
> > > > >   return 0;
> > > > > }
> > > > > ```
> > > > >
> > > > > This should allow me to add bpf hooks to functions that communicate with
> > > > > the hardware.
> > > >
> > > > Could you also add selftests to it? In particular, I'm thinking that this is not
> > > > sufficient given also bpf_prog_map_compatible() needs to be extended to check on
> > > > prog->sleepable. For example we would need to disallow calling sleepable programs
> > > > in that map from non-sleepable context.
> > >
> > > Just to be sure, if I have to change bpf_prog_map_compatible(), that
> > > means that a prog array map can only have sleepable or non-sleepable
> > > programs, but not both at the same time?
> > >
> > > FWIW, indeed, I just tested and the BPF verifier/core is happy with this
> > > patch only if the bpf_tail_call is issued from a non-sleepable context
> > > (and crashes as expected).
> > >
> > > But that seems to be a different issue TBH: I can store a sleepable BPF
> > > program in a prog array and run it from a non sleepable context. I don't
> > > need the patch at all as bpf_tail_call() is normally declared. I assume
> > > your suggestion to change bpf_prog_map_compatible() will fix that part.
> > >
> > > I'll digg some more tomorrow.
> > >
> >
> > Quick update:
> > forcing the prog array to only contain sleepable programs or not seems
> > to do the trick, but I'm down a rabbit hole as when I return from my
> > trampoline, I get an invalid page fault, trying to execute NX-protected
> > page.
> >
> > I'll report if it's because of HID-BPF or if there are more work to be
> > doing for bpf_tail_call (which I suspect).
> 
> bpf_tail_call is an old mechanism.
> Instead of making it work for sleepable (which is ok to do)
> have you considered using "freplace" logic to "add bpf hooks to functions" ?
> You can have a global noinline function and replace it at run-time
> with another bpf program.
> Like:
> __attribute__ ((noinline))
> int get_constant(long val)
> {
>         return val - 122;
> }
> 
> in progs/test_pkt_access.c
> 
> is replaced with progs/freplace_get_constant.c
> 
> With freplace you can pass normal arguments, do the call and get
> return value, while with bpf_tail_call it's ctx only and no return.

This is interesting. Thanks!

However, I'm not sure that this would fit for my use case.

Basically, what I am doing is storing a list of bpf program I want to
run on a particular device for a given function.

Right now, what I am doing is (in simplified pseudo code):
- in a bpf program, the user calls hid_bpf_attach_prog(hid_device, program_fd)
  where program fd is a tracing program on a never executed function
  but this allows to know the type of program to run
- the kernel stores that program into a dedicated prog array bpf_map
  pre-loaded at boot time
- when a event comes in, the kernel walks through the list of attached
  programs, calls __hid_bpf_tail_call() and there is a tracing program
  attached to it that just do the bpf_tail_call.

This works and is simple enough from the user point of view, but is
rather inefficient and clunky from the kernel point of view IMO.

The freplace mechnism would definitely work if I had a tracing-like
function to call, where I need to run the program any time the function
gets called. But given that I want per-device filtering, I'm not sure
how I could make this work. But given that I need to enable or not the
bpf_program, I'm not sure how I could make it work from the kernel point
of view.

I tried using a simple bpf_prog_run() (which is exactly what I need in
the end) but I couldn't really convince the bpf verifier that the
provided context is a struct hid_bpf_ctx kernel pointer, and it felt not
quite right.

So after seeing how the bpf_wq worked internally, and how simple it is
now to call a bpf program from the kernel as a simple function call, I
played around with allowing kfunc to declare async callback functions.

I have a working prototype (probably not fully functional for all of the
cases), but I would like to know if you think it would be interesting to
have 3 new suffixes:
- "__async" for declaring an static bpf program that can be stored in
  the kernel and which would be non sleepable
- "__s_async" same as before, but for sleepable operations
- "__aux" (or "__prog_aux") for that extra parameter to
  bpf_wq_set_callback_impl() which contains the struct bpf_prog*.

(I still don't have the __aux yet FWIW)

The way I'm doing it is looking at the btf information to fetch the
signature of the parameters of the callback, this way we can declare any
callback without having to teach the verifier of is arguments (5 max).

Is this something you would be comfortable with or is there a simpler
mechanism already in place to call the bpf programs from the kernel
without the ctx limitations?

I can also easily switch the bpf_wq specific cases in the verifier with
those suffixes. There are still one or two wq specifics I haven't
implemented through __s_async, but that would still makes things more
generic.

Cheers,
Benjamin

