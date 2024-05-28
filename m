Return-Path: <bpf+bounces-30749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C428D1EBC
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 16:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D98E8B23628
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 14:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D0016FF47;
	Tue, 28 May 2024 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qm8HVB4l"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C41616F270;
	Tue, 28 May 2024 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906332; cv=none; b=p7/G59qks2ce3UymjpNXsbLK5DkCG6e+GLEEbtIJ0gJsj4U7WYGaZtMoLSbriyBezw6Rtc6KKHVh/eSdC8/5xc7+Gq123P/bxn4Cqrk+iGWnseEKGxJQEz1l0wt44p2mU52JWGaKc6spxH5dZdpkFGMNnyi4KdJZihZOE+xPZWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906332; c=relaxed/simple;
	bh=ItMtYBCPsZWNLQ/cRqRw4zUEWFdGuh4o3507mYgNBQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUUlGHa0KDU/J5bGIxUNK112EtUy8ka3zuDwXHKlG1kbxxm/2kjCYilztMrRNMQtguFc3lkVu//KYw0VRPEzMXMu6Qt1NtsyRUTOg44kWdYcWD7UD6vVmokFHdiVU7Wn7w90tHzO/aK2thATKjVprxFBf8jmsY8uLkaGdZ8Zz7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qm8HVB4l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48FEC3277B;
	Tue, 28 May 2024 14:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716906330;
	bh=ItMtYBCPsZWNLQ/cRqRw4zUEWFdGuh4o3507mYgNBQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qm8HVB4lJUqWpqpF/p8z0lsaY4vkCsE0c4JXecadzF423zEdyKK2LIcGyhYr/HyiY
	 9KQbiRSH1VPHYe+BsJa1wuFrAP3fdGX0usiaDp/D4EXt/U6hXDk+AhT47K0UiX8PF5
	 wIsKGKscW+wI28/iGLttf0iY3Tyc3FWhs86Fp/hHgaIQYTOnR0ZpQCEJjkN3YkxZpT
	 sL79GaZxbHbuZs566vtB/7UXdS0mq50gvc9+m6FK8R5yFMuGZnPE2UhHnBpKjy9ZzT
	 ciUKCq14JoZRq0RRT5czt/c04Yi8YDFOdQ6G51yLeos1nQL0PAdp2psekqApwhSI/Z
	 +wM+3k6y6FClQ==
Date: Tue, 28 May 2024 16:25:24 +0200
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
Message-ID: <uzx2i7mx6nqioafsfrbatgu4s4ojx2pmtawmv2fu3kffbmnk2g@6e2343kwpxfl>
References: <35nbgxc7hqyef3iobfvhbftxtbxb3dfz574gbba4kwvbo6os4v@sya7ul5i6mmd>
 <CAADnVQJaG8kDaJr5LV29ces+gVpgARLAWiUvE9Ee5huuiW5X=Q@mail.gmail.com>
 <mhkzkf4e23uvljtmwizwcxyuyat2tmfxn33xb4t7waafgmsa66@mcrzpj3b6ssx>
 <CAADnVQLJ=nxp3bZYYMJd0yrUtMNx2DcvYXXmbGKBQAiG85kSLQ@mail.gmail.com>
 <xt2zckipzs24eur4ozdo64uoxfed6jm3qixxgnp3o2gogjmosc@723s2u7jbsaz>
 <CAADnVQK9qeMmzxE-aivmue-CF_hn1EFUTUAZyaMRqy2cW6j73A@mail.gmail.com>
 <b5r55f2uan7qm5h34nfu2qmoap2gm3ox3dtp2kjpaxebjrzxvp@zqx23ecrnj4q>
 <CAADnVQLxjW411h-Wr2shMFNi_D7FK661yBZjYj2pUTwwhafc-A@mail.gmail.com>
 <ex6qpofzgl5arf2trs4c6rm7tectt6tpz63edkxvj62smpcxra@4e2yjyfbc34m>
 <CAADnVQKgmA7kVG_VbTdZAb6wN2ivdAoh28pfS+ZP4tnMje8vbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKgmA7kVG_VbTdZAb6wN2ivdAoh28pfS+ZP4tnMje8vbg@mail.gmail.com>

On May 10 2024, Alexei Starovoitov wrote:
> On Fri, May 10, 2024 at 3:04 AM Benjamin Tissoires <bentiss@kernel.org> wrote:
> >
> > On May 08 2024, Alexei Starovoitov wrote:
> > > On Wed, May 8, 2024 at 4:53 AM Benjamin Tissoires <bentiss@kernel.org> wrote:
> > > >
> > > > On May 07 2024, Alexei Starovoitov wrote:
> > > > > On Tue, May 7, 2024 at 6:32 AM Benjamin Tissoires <bentiss@kernel.org> wrote:
> > > > > >
> > > > > > Yes, exactly that. See [0] for my current WIP. I've just sent it, not
> > > > > > for reviews, but so you see what I meant here.
> > > > >
> > > > > The patches helped to understand, for sure, and on surface
> > > > > they kind of make sense, but without seeing what is that
> > > > > hid specific kfunc that will use it
> > > > > it's hard to make a call.
> > > >
> > > > I've posted my HID WIP on [1]. It probably won't compile as my local
> > > > original branch was having a merge of HID and bpf trees.
> > >
> > > Thanks for this context.
> > > Now it makes a lot more sense.
> > > And the first patches look fine and simplification is impressive,
> > > but this part:
> > > +     SEC("syscall")
> > > +     int name(struct attach_prog_args *ctx)
> > > +     {
> > > +       ctx->retval = hid_bpf_attach_prog_impl(ctx->hid,
> > > +                                                 type,
> > > +                                                 __##name,
> > > +                           ctx->insert_head ? HID_BPF_FLAG_INSERT_HEAD :
> > > +                                                 HID_BPF_FLAG_NONE,
> > > +                                                 NULL);
> > >
> > > is too odd.
> > > Essentially you're adding a kfunc on hid side just to call it
> > > from a temporary "syscall" program to register another prog.
> > > A fake prog just to call a kfunc is a bit too much.
> > >
> > > The overall mechanism is pretty much a customized struct-ops.
> > >
> > > I think struct-ops infra provides better api-s, safety guarantees,
> > > bpf_link support, prog management including reentrance check, etc.
> >
> > Ack!
> >
> > > It needs to be parametrized, so it's not just
> > > SEC("struct_ops/kern_callback_name")
> > > so that the skeleton loading phase can pass device id or something.
> >
> > I'm not sure how to parametrize staticaly. I can rely on the modalias,
> > but then that might not be ideal. Right now my loader gets called by a
> > udev rule, and then call a .probe syscall. If this returns success, then
> > the bpf programs are attached to the given hid device.
> >
> > I saw that the struct_ops can have "data" fields. If we can change the
> > static value before calling attach, I should have a register callback
> > being able to retrieve that hid id, and then attach the struct_ops to
> > the correct hid device in the jump table. Anyway, I'll test this later.
> 
> yep.
> 
> > Something along:
> >
> > SEC(".struct_ops")
> > struct hid_bpf_ops dummy_1 = {
> >         .input_event = (void *)test_1,
> >         .rdesc_fixup = (void *)test_2,
> >         .hw_raw_request = (void *)test_sleepable,
> >         .hid_id = 0,
> > };
> >
> > And in the loader, I call __load(), change the value ->hid_id, and then
> > __attach().
> 
> __open() then change hid_id then __load().
> 
> See prog_tests/test_struct_ops_module.c.
> 
> >
> > >
> > > > > The (u64)(long) casting concerns and prog lifetime are
> > > > > difficult to get right. The verifier won't help and it all
> > > > > will fall on code reviews.
> > > >
> > > > yeah, this is a concern.
> > >
> > > Not only that. The special kfunc does migrate_disable
> > > before calling callback, but it needs rcu_lock or tracing lock,
> > > plus reentrance checks.
> > >
> > > >
> > > > > So I'd rather not go this route.
> > > > > Let's explore first what exactly the goal here.
> > > > > We've talked about sleepable tail_calls, this async callbacks
> > > > > from hid kfuncs, and struct-ops.
> > > > > Maybe none of them fit well and we need something else.
> > > > > Could you please explain (maybe once again) what is the end goal?
> > > >
> > > > right now I need 4 hooks in HID, the first 2 are already upstream:
> > > > - whenever I need to retrieve the report descriptor (this happens in a
> > > >   sleepable context, but non sleepable is fine)
> > > > - whenever I receive an event from a device (non sleepable context, this
> > > >   is coming from a hard IRQ context)
> > > > - whenever someone tries to write to the device through
> > > >   hid_hw_raw_request (original context is sleepable, and for being able
> > > >   to communicate with the device we need sleepable context in bpf)
> > > > - same but from hid_hw_output_report
> > > >
> > > > Again, the first 2 are working just fine.
> > > >
> > > > Implementing the latter twos requires sleepable context because we
> > > > might:
> > > >
> > > > 1. a request is made from user-space
> > > > 2. we jump into hid-bpf
> > > > 3. the bpf program "converts" the request from report ID 1 to 2 (because
> > > > we export a slightly different API)
> > > > 4. the bpf program directly emits hid_bpf_raw_request (sleepable
> > > > operation)
> > > > 5. the bpf program returns the correct value
> > > > 6. hid-core doesn't attempt to communicate with the device as bpf
> > > > already did.
> > > >
> > > > In the series, I also realized that I need sleepable and non sleepable
> > > > contexts for this kind of situation, because I want tracing and
> > > > firewalling available (non sleepable context), while still allowing to
> > > > communicate with the device. But when you communicate with the device
> > > > from bpf, the sleepable bpf program is not invoked or this allows
> > > > infinite loops.
> > >
> > > I don't get the point about infinite loops.
> >
> > If I don´t put restrictions on how the bpf program communicate with the
> > device I might have:
> >
> > 1. someone calls hid_hw_raw_request from hidraw
> > 2. bpf jumps into filter for hid_hw_raw_request
> > 3. the bpf program calls hid_bpf_raw_request (which internally calls
> > hid_hw_raw_request)
> > 4. go back to 2.
> 
> sleepable progs also have recursion checks.
> So if it recurses into the same prog it will catch it.
> Ideally, of course, such loops are prevented statically.
> 
> > But again, not a big deal: if I do not allow entering a sleepable bpf
> > program from hid_bpf_raw_request (so from a bpf program), instead of 4.
> > above, we prevent entering the same bpf program as the program in 2.
> > needs to be sleepable.
> >
> > > fyi struct_ops already supports sleepable and non-sleepable callbacks.
> > > See progs/dummy_st_ops_success.c
> > > SEC(".struct_ops")
> > > struct bpf_dummy_ops dummy_1 = {
> > >         .test_1 = (void *)test_1,
> > >         .test_2 = (void *)test_2,
> > >         .test_sleepable = (void *)test_sleepable,
> > > };
> > >
> > > two callbacks are normal and another one is sleepable.
> > >
> > > The generated bpf trampoline will have the right
> > > __bpf_prog_enter* wrappers for all 3 progs,
> > > so the kernel code will be just do ops->callback_name().
> >
> > Great!
> >
> > So I think I have most of the pieces available... I just need to write
> > the code :)
> >
> > >
> > > > >
> > > > > > Last time I checked, I thought struct_ops were only for defining one set
> > > > > > of operations. And you could overwrite them exactly once.
> > > > > > But after reading more carefully how it was used in tcp_cong.c, it seems
> > > > > > we can have multiple programs which define the same struct_ops, and then
> > > > > > it's the kernel which will choose which one needs to be run.
> > > > >
> > > > > struct-ops is pretty much a mechanism for kernel to define
> > > > > a set of callbacks and bpf prog to provide implementation for
> > > > > these callbacks. The kernel choses when to call them.
> > > > > tcp-bpf is one such user. sched_ext is another and more advanced.
> > > > > Currently struct-ops bpf prog loading/attaching mechanism
> > > > > only specifies the struct-ops. There is no device-id argument,
> > > > > but that can be extended and kernel can keep per-device a set
> > > > > of bpf progs.
> > > > > struct-ops is a bit of overkill if you have only one callback.
> > > > > It's typically for a set of callbacks.
> > > >
> > > > In the end I have 4. However, I might have programs that overwrite twice
> > > > the same callback (see the 2 SEC("fmod_ret/hid_bpf_device_event") in
> > > > [2]).
> > > >
> > > > >
> > > > > > Last, I'm not entirely sure how I can specify which struct_ops needs to be
> > > > > > attached to which device, but it's worth a shot. I've already realized
> > > > > > that I would probably have to drop the current way of HID-BPF is running,
> > > > > > so now it's just technical bits to assemble :)
> > > > >
> > > > > You need to call different bpf progs per device, right?
> > > >
> > > > yes
> > > >
> > > > > If indirect call is fine from performance pov,
> > > > > then tailcall or struct_ops+device_argument might fit.
> > > >
> > > > performance is not a requirement. It's better if we have low latency but
> > > > we are not talking the same requirements than network.
> > > >
> > > > >
> > > > > If you want max perf with direct calls then
> > > > > we'd need to generalize xdp dispatcher.
> > > >
> > > > I'll need to have a deeper look at it, yeah.
> > > >
> > > > >
> > > > > So far it sounds that tailcalls might be the best actually,
> > > > > since prog lifetime is handled by prog array map.
> > > > > Maybe instead of bpf_tail_call helper we should add a kfunc that
> > > > > will operate on prog array differently?
> > > > > (if current bpf_tail_call semantics don't fit).
> > > >
> > > > Actually I'd like to remove bpf_tail_call entirely, because it requires
> > > > to pre-load a BPF program at boot, and in some situations (RHEL) this
> > > > creates issues. I haven't been able to debug what was happening, I
> > > > couldn't reproduce it myself, but removing that bit would be nice :)
> > >
> > > We probably need to debug it anyway, since it sounds that it's
> > > related to preloaded bpf skeleton and not tail_call logic itself.
> >
> > I really think this happens with RHEL because some part are backported and
> > some are not. So unless we get upstream reports, it's more likely a RHEL
> > only issue (which makes things even harder to debug for me).
> >
> > >
> > > After looking through all that it seems to me that
> > > parametrized struct-ops is the way to go.
> >
> > Yeah, I think so too. I'll proabbly start working on it next Monday.
> 
> A bunch of us will be at lsfmmbpf next week.
> So email traffic will be slow.

Patch series is finally out [0].

Writting the kernel code was actually much easier than expected, but I
took some more time to also work on the user space loader to have
compatibility with pre/post struct_ops.

Anyway, thanks a lot for the help here. I would appreciate any review
from the bpf folks on patch 3/13, as the rest is mostly HID plumbing,
conversion from the old tracing approach and docs.

Cheers,
Benjamin


[0] https://lore.kernel.org/linux-input/20240528-hid_bpf_struct_ops-v1-0-8c6663df27d8@kernel.org/T/#t

