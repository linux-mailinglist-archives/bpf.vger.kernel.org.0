Return-Path: <bpf+bounces-28827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E273C8BE494
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 15:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 058BDB2322E
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 13:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56A516C867;
	Tue,  7 May 2024 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJowaa4H"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDC515EFA6;
	Tue,  7 May 2024 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088742; cv=none; b=YVka85X51pQBmieWs3wZw12HgL6mWjNc6RsKL3dn5/wo9ejLAOSsrsEZ5M0l0EO+5MWys7zS+cgTPm+SELvmCH/0CTa+B4Yug2wEj04D+rQNF6nTGjRYK0ovOHLyK7Fd2A+w71J53eiDvVNTjh3MvEbET/kh8KX5oaxjqVh+wXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088742; c=relaxed/simple;
	bh=0aE1EB7OysxWT6vmQpIYxWU5IKQ/msWNTkadmkQXk0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJFlQA4s0g0zRZuegpcOV3qvCR4MEBU/eU5o8gb9ImgIYMZn2pw22A9iPTIo2XJMzb3dEXmNadORstM0c5SJQfvAap/rWoKY/kBlNBuqs6bZg4tEX0uPtY0zk+mvPY9kpedqQUuEsVekFu02RZihQJXkFktANrYBv/o764n6Wrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJowaa4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D0FC2BBFC;
	Tue,  7 May 2024 13:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715088741;
	bh=0aE1EB7OysxWT6vmQpIYxWU5IKQ/msWNTkadmkQXk0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TJowaa4HpPiXiwpJkzsdfPvj2TnvxtMvqqcYR+4K3UvqVK7Buvon+6gWB5RAhyfbQ
	 TiXtM0po6j0F9D6t29FO6JjVoTN3wJBHjoQ+3iofeq+Jy1TxSwx0mS3URvlwpE01/r
	 AiinZZoeD1nGMRCKtqlj0oKpRjfHNkvMEB5xA6Wx/Lx6L+zB7jSlIx57n8Mjhge/JS
	 4MYWDGjSYGRfRwcXaP08p/Ne8DKD3rlo01a1VYPCsRrk6XlmPTbA4rCBOVV97uGjSb
	 VERhzTS4Ehuoc/0JhfYpDxdCM3oy0n3T8CifhJa+ws1GWrcYdjbD4wpeg7tvg3fk/v
	 PbRJW/HVVo0Bg==
Date: Tue, 7 May 2024 15:32:15 +0200
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
Message-ID: <xt2zckipzs24eur4ozdo64uoxfed6jm3qixxgnp3o2gogjmosc@723s2u7jbsaz>
References: <20240422-sleepable_array_progs-v1-1-7c46ccbaa6e2@kernel.org>
 <7344022a-6f59-7cbf-ee45-6b7d59114be6@iogearbox.net>
 <un4jw2ef45vu3vwojpjca3wezso7fdp5gih7np73f4pmsmhmaj@csm3ix2ygd5i>
 <35nbgxc7hqyef3iobfvhbftxtbxb3dfz574gbba4kwvbo6os4v@sya7ul5i6mmd>
 <CAADnVQJaG8kDaJr5LV29ces+gVpgARLAWiUvE9Ee5huuiW5X=Q@mail.gmail.com>
 <mhkzkf4e23uvljtmwizwcxyuyat2tmfxn33xb4t7waafgmsa66@mcrzpj3b6ssx>
 <CAADnVQLJ=nxp3bZYYMJd0yrUtMNx2DcvYXXmbGKBQAiG85kSLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLJ=nxp3bZYYMJd0yrUtMNx2DcvYXXmbGKBQAiG85kSLQ@mail.gmail.com>

On May 06 2024, Alexei Starovoitov wrote:
> On Tue, Apr 30, 2024 at 3:03 AM Benjamin Tissoires <bentiss@kernel.org> wrote:
> >
> >
> > Right now, what I am doing is (in simplified pseudo code):
> > - in a bpf program, the user calls hid_bpf_attach_prog(hid_device, program_fd)
> >   where program fd is a tracing program on a never executed function
> >   but this allows to know the type of program to run
> > - the kernel stores that program into a dedicated prog array bpf_map
> >   pre-loaded at boot time
> > - when a event comes in, the kernel walks through the list of attached
> >   programs, calls __hid_bpf_tail_call() and there is a tracing program
> >   attached to it that just do the bpf_tail_call.
> >
> > This works and is simple enough from the user point of view, but is
> > rather inefficient and clunky from the kernel point of view IMO.
> >
> > The freplace mechnism would definitely work if I had a tracing-like
> > function to call, where I need to run the program any time the function
> > gets called. But given that I want per-device filtering, I'm not sure
> > how I could make this work. But given that I need to enable or not the
> > bpf_program, I'm not sure how I could make it work from the kernel point
> > of view.
> >
> > I tried using a simple bpf_prog_run() (which is exactly what I need in
> > the end) but I couldn't really convince the bpf verifier that the
> > provided context is a struct hid_bpf_ctx kernel pointer, and it felt not
> > quite right.
> >
> > So after seeing how the bpf_wq worked internally, and how simple it is
> > now to call a bpf program from the kernel as a simple function call, I
> > played around with allowing kfunc to declare async callback functions.
> >
> > I have a working prototype (probably not fully functional for all of the
> > cases), but I would like to know if you think it would be interesting to
> > have 3 new suffixes:
> > - "__async" for declaring an static bpf program that can be stored in
> >   the kernel and which would be non sleepable
> > - "__s_async" same as before, but for sleepable operations
> > - "__aux" (or "__prog_aux") for that extra parameter to
> >   bpf_wq_set_callback_impl() which contains the struct bpf_prog*.
> 
> Sorry for the delay. I've been traveling.

no worries. I'll be off myself the next few days too :)

> 
> I don't quite understand how these suffixes will work.
> You mean arguments of kfuncs to tell kfunc that an argument
> is a pointer to async callback?
> Sort-of generalization of is_async_callback_calling_kfunc() ?
> I cannot connect the dots.

Yes, exactly that. See [0] for my current WIP. I've just sent it, not
for reviews, but so you see what I meant here.

> 
> Feels dangerous to open up bpf prog calling to arbitrary kfuncs.
> wq/timer/others are calling progs with:
>         callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
> I feel we'll struggle to code review kfuncs that do such things.
> Plus all prog life time management concerns.
> wq/timer do careful bpf_prog_put/get dance.

That part is indeed painful.

> 
> > (I still don't have the __aux yet FWIW)
> >
> > The way I'm doing it is looking at the btf information to fetch the
> > signature of the parameters of the callback, this way we can declare any
> > callback without having to teach the verifier of is arguments (5 max).
> >
> > Is this something you would be comfortable with or is there a simpler
> > mechanism already in place to call the bpf programs from the kernel
> > without the ctx limitations?
> 
> "ctx limitations" you mean 5 args?

No, I was meaning the special context argument for bpf_prog_run. But
anyway, this is relatively moot if struct_ops that you mention below is
working :)

> Have you looked at struct_ops ?
> It can have any number of args.
> Maybe declare struct_ops in hid and let user space provide struct_ops progs?

Last time I checked, I thought struct_ops were only for defining one set
of operations. And you could overwrite them exactly once.
But after reading more carefully how it was used in tcp_cong.c, it seems
we can have multiple programs which define the same struct_ops, and then
it's the kernel which will choose which one needs to be run.

AFAICT there is no sleepable context concerns as well, it depends on how
the kernel starts the various ops.

Last, I'm not entirely sure how I can specify which struct_ops needs to be
attached to which device, but it's worth a shot. I've already realized
that I would probably have to drop the current way of HID-BPF is running,
so now it's just technical bits to assemble :)

> 
> > I can also easily switch the bpf_wq specific cases in the verifier with
> > those suffixes. There are still one or two wq specifics I haven't
> > implemented through __s_async, but that would still makes things more
> > generic.
> >

Cheers,
Benjamin

[0] https://lore.kernel.org/bpf/20240507-bpf_async-v1-0-b4df966096d8@kernel.org/T/#t

