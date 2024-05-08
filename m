Return-Path: <bpf+bounces-29068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 496628BFCB1
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 13:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B776F1F21D5A
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 11:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944E482D66;
	Wed,  8 May 2024 11:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKU1PLg6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0E182876;
	Wed,  8 May 2024 11:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715169217; cv=none; b=jJBduLK+Ev0H8/eZ6pLrIWa5048r3r4HSXVt9ifKXvYokihlHq5ev1WC1jQhDs7Q8JBi07vfCNqHgRKuqpPM/6FbB/DkDPIi1Q5y5/AZ8MuRFIBdp7ziLrU87DZicMn/+7auXfbOdMbGaBIGPUjJBn25hyDO+THWx3hyXpde924=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715169217; c=relaxed/simple;
	bh=wwYlQSFkpQ4bVOEdJuGODcDN5o3g/o0+11Y+wlXLVDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgWL8ti2csEPDFKOFnRVpmpBFOyO5LbUlmFG0URNwHLPu5W+sDUGGpiG3ZLOcZxaIfOmIn+rqeUdLJxAVANOieTP7IxYhcNHNwsdbIOyeYWfDzyN/M4N2Y2jyxcpb/g0lQFoJS6i95mtJaTs7NJbKyankKuxrnz5XEjj9lOb08w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKU1PLg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A876EC113CC;
	Wed,  8 May 2024 11:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715169216;
	bh=wwYlQSFkpQ4bVOEdJuGODcDN5o3g/o0+11Y+wlXLVDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MKU1PLg6W385eGrptF++XnqSbcL/CJBFOxjIGvr/hk1NQ11zDZ+MkGBUQuUE2e3Xm
	 BtLwCLhm8Se10UonejKGHT3ojkHPUJPUg8mgkZASH/x674GPsjJQK0aPV7Q5Mcdro4
	 bYSxkxGICDa6gmQ1kD2bWmtH/SE24KEG0wwgclH2KlI2B38zAxBJSSAiLhpVDLei6v
	 WUvvrmVLPJNHb/JP9cIEnsKGLGX3tDcciX4aaT6GcICmowU1oz3GQ3nBRpxYW05COu
	 Y1CQLfrMAeZF1OrsSe71hFowqGa9D2KRnaXDbCT5Gni5cJSBpwRwTiSTqMo/xvGbBT
	 IEtirfE4X67bw==
Date: Wed, 8 May 2024 13:53:30 +0200
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
Message-ID: <b5r55f2uan7qm5h34nfu2qmoap2gm3ox3dtp2kjpaxebjrzxvp@zqx23ecrnj4q>
References: <20240422-sleepable_array_progs-v1-1-7c46ccbaa6e2@kernel.org>
 <7344022a-6f59-7cbf-ee45-6b7d59114be6@iogearbox.net>
 <un4jw2ef45vu3vwojpjca3wezso7fdp5gih7np73f4pmsmhmaj@csm3ix2ygd5i>
 <35nbgxc7hqyef3iobfvhbftxtbxb3dfz574gbba4kwvbo6os4v@sya7ul5i6mmd>
 <CAADnVQJaG8kDaJr5LV29ces+gVpgARLAWiUvE9Ee5huuiW5X=Q@mail.gmail.com>
 <mhkzkf4e23uvljtmwizwcxyuyat2tmfxn33xb4t7waafgmsa66@mcrzpj3b6ssx>
 <CAADnVQLJ=nxp3bZYYMJd0yrUtMNx2DcvYXXmbGKBQAiG85kSLQ@mail.gmail.com>
 <xt2zckipzs24eur4ozdo64uoxfed6jm3qixxgnp3o2gogjmosc@723s2u7jbsaz>
 <CAADnVQK9qeMmzxE-aivmue-CF_hn1EFUTUAZyaMRqy2cW6j73A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQK9qeMmzxE-aivmue-CF_hn1EFUTUAZyaMRqy2cW6j73A@mail.gmail.com>

On May 07 2024, Alexei Starovoitov wrote:
> On Tue, May 7, 2024 at 6:32 AM Benjamin Tissoires <bentiss@kernel.org> wrote:
> >
> > Yes, exactly that. See [0] for my current WIP. I've just sent it, not
> > for reviews, but so you see what I meant here.
> 
> The patches helped to understand, for sure, and on surface
> they kind of make sense, but without seeing what is that
> hid specific kfunc that will use it
> it's hard to make a call.

I've posted my HID WIP on [1]. It probably won't compile as my local
original branch was having a merge of HID and bpf trees.

> The (u64)(long) casting concerns and prog lifetime are
> difficult to get right. The verifier won't help and it all
> will fall on code reviews.

yeah, this is a concern.

> So I'd rather not go this route.
> Let's explore first what exactly the goal here.
> We've talked about sleepable tail_calls, this async callbacks
> from hid kfuncs, and struct-ops.
> Maybe none of them fit well and we need something else.
> Could you please explain (maybe once again) what is the end goal?

right now I need 4 hooks in HID, the first 2 are already upstream:
- whenever I need to retrieve the report descriptor (this happens in a
  sleepable context, but non sleepable is fine)
- whenever I receive an event from a device (non sleepable context, this
  is coming from a hard IRQ context)
- whenever someone tries to write to the device through
  hid_hw_raw_request (original context is sleepable, and for being able
  to communicate with the device we need sleepable context in bpf)
- same but from hid_hw_output_report

Again, the first 2 are working just fine.

Implementing the latter twos requires sleepable context because we
might:

1. a request is made from user-space
2. we jump into hid-bpf
3. the bpf program "converts" the request from report ID 1 to 2 (because
we export a slightly different API)
4. the bpf program directly emits hid_bpf_raw_request (sleepable
operation)
5. the bpf program returns the correct value
6. hid-core doesn't attempt to communicate with the device as bpf
already did.

In the series, I also realized that I need sleepable and non sleepable
contexts for this kind of situation, because I want tracing and
firewalling available (non sleepable context), while still allowing to
communicate with the device. But when you communicate with the device
from bpf, the sleepable bpf program is not invoked or this allows
infinite loops.

> 
> > Last time I checked, I thought struct_ops were only for defining one set
> > of operations. And you could overwrite them exactly once.
> > But after reading more carefully how it was used in tcp_cong.c, it seems
> > we can have multiple programs which define the same struct_ops, and then
> > it's the kernel which will choose which one needs to be run.
> 
> struct-ops is pretty much a mechanism for kernel to define
> a set of callbacks and bpf prog to provide implementation for
> these callbacks. The kernel choses when to call them.
> tcp-bpf is one such user. sched_ext is another and more advanced.
> Currently struct-ops bpf prog loading/attaching mechanism
> only specifies the struct-ops. There is no device-id argument,
> but that can be extended and kernel can keep per-device a set
> of bpf progs.
> struct-ops is a bit of overkill if you have only one callback.
> It's typically for a set of callbacks.

In the end I have 4. However, I might have programs that overwrite twice
the same callback (see the 2 SEC("fmod_ret/hid_bpf_device_event") in
[2]).

> 
> > Last, I'm not entirely sure how I can specify which struct_ops needs to be
> > attached to which device, but it's worth a shot. I've already realized
> > that I would probably have to drop the current way of HID-BPF is running,
> > so now it's just technical bits to assemble :)
> 
> You need to call different bpf progs per device, right?

yes

> If indirect call is fine from performance pov,
> then tailcall or struct_ops+device_argument might fit.

performance is not a requirement. It's better if we have low latency but
we are not talking the same requirements than network.

> 
> If you want max perf with direct calls then
> we'd need to generalize xdp dispatcher.

I'll need to have a deeper look at it, yeah.

> 
> So far it sounds that tailcalls might be the best actually,
> since prog lifetime is handled by prog array map.
> Maybe instead of bpf_tail_call helper we should add a kfunc that
> will operate on prog array differently?
> (if current bpf_tail_call semantics don't fit).

Actually I'd like to remove bpf_tail_call entirely, because it requires
to pre-load a BPF program at boot, and in some situations (RHEL) this
creates issues. I haven't been able to debug what was happening, I
couldn't reproduce it myself, but removing that bit would be nice :)

Cheers,
Benjamin

[1] https://lore.kernel.org/bpf/20240508-hid_bpf_async_fun-v1-0-558375a25657@kernel.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/tree/drivers/hid/bpf/progs/XPPen__ArtistPro16Gen2.bpf.c?h=for-next

