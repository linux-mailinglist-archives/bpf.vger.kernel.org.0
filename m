Return-Path: <bpf+bounces-29137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640038C0751
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 00:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D971C20FAF
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 22:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BB21332A7;
	Wed,  8 May 2024 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q860DLMQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A01130E4B;
	Wed,  8 May 2024 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715207147; cv=none; b=g1xbDj8qOKVaQUCI+1bi0VvVuyxV5LIHIJLoNZcsQpj5gSise/LW6OGVUUtuPz/oFKDj8DUcKasz1f5KbHBE/efDcMjQn52cox/OsnJKf+hXAi70FgrWstcRqBSU828MBU2d7Zx65JvxulYdGZzwdqjNEDLh+YnNWNrNtL4OERY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715207147; c=relaxed/simple;
	bh=Iaqt7cI5LSs0Yy4oxTQR2YW3DueQdxMrZk9gsDgznmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iz6qttSpIeSCo3rXqiDrJJmnkJnex8KVCCcbUEHjF9DmCjXmXTNfuNYV97EgWbUXGbuMdQgWC8VZ5qVxSAJ9+Dn84OHfTijxEGWnR7XgngDoUehddo1NTgWO7p7wSJPpHscN0TWkzyxjO6ugXvQFy+O/aorF+WKnXjwpbb3rroY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q860DLMQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41f9ce16ed8so3129895e9.0;
        Wed, 08 May 2024 15:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715207144; x=1715811944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+l+oDWiSz2dter6uou4EZeP8lrM0thCQpHdtcg22Oc=;
        b=Q860DLMQnHEbG1OscS9QXAiLJRZ5wpL20GKMwcWcYN+f5pUjJsoDHvfVUPkmn5haSd
         bEWpLEfgN9p1W9gW3Qv9Y2XVkEPB6j5NaERVSCu2I+ve3d6PNtX1eS+4hrxioYuxBSYu
         AlnPOgJnZs2atKLSLkt+0Bw8ccveuSCpniX3a+Hi+oUn79lX1FdEUD1NJE7QKH+OmtSl
         iS/xLPA5ZVj2p7gJ1gGAA8gfsSNLqFFflg9lWY6TvtV27za8hYfO88SHjaCzn9T9dCif
         UZVfFTmGQzzQ9lP3BNLeGjAmmnDk058YpGM1jQGWd1GmoeooluXMMb4f7b7BeHoSh100
         2F0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715207144; x=1715811944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+l+oDWiSz2dter6uou4EZeP8lrM0thCQpHdtcg22Oc=;
        b=sa2isWLitmfSYn4DS7I3NcEcf3BGZQ374adnNEkjB2dc9LGde+3qtHE7c0BazngiOW
         JeNzN/feV5dbJeu2tjzi8p8o8o+eOmdzNOdh7REzG1aYQemKRbzoWyglua/QwkyC7pFr
         7rFqdLFdmzRYUrL/bJtEe7NknTgRzLd3wJ0KdA42S+HWC3O3FgrUYDbBPIQq46iVFMZb
         hXkSE8RbGqkSzdy/efyPfdZb8Oe/BDZTR1js6n7+M3a0plCtA5cHKK/73SnYZ7NS55ou
         PaYcm0o5HP+mVb/nekebygF7uokHR7DH6cuVV+PGSxsCkFYvyR/DCx8Cs9BJeQQHoNgm
         RiHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrMSOI/B8TlXFRZIU7TomwVn6ptDrT1jdJQ/Xe2RBkOa6zWE/JgFHPfgNP/jh1Xj2pBhVgA4ZG+Xvs570NHItoLWYk1HARFEhrg70LrDv1Zke03hz9ms/0iN0CSopIS3vW
X-Gm-Message-State: AOJu0Yxa/cAilAAmRnYonEJ2qpP+rI7NxeAKoCokLoXnfTfw1mFk9zu7
	Nfv4WZngB3aaHXXPwgWh9tAYxzmfMFkLWBSFnQg2QtLtJH5GknDcxqlvsjgvX5Fuu1wGiisauQ9
	BOalFL/Jyok7q+moZbErKynGcHqE=
X-Google-Smtp-Source: AGHT+IE1brzbuRTz9QQT/7/yj6R9Xy+cNUD7s5000JtPqTHGDnKg4ZjmAP83VYeEoFo4dMCijk17UxEKgn+EURDNrro=
X-Received: by 2002:a05:600c:45cf:b0:41b:e244:164a with SMTP id
 5b1f17b1804b1-41f71302db2mr42287715e9.6.1715207143761; Wed, 08 May 2024
 15:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422-sleepable_array_progs-v1-1-7c46ccbaa6e2@kernel.org>
 <7344022a-6f59-7cbf-ee45-6b7d59114be6@iogearbox.net> <un4jw2ef45vu3vwojpjca3wezso7fdp5gih7np73f4pmsmhmaj@csm3ix2ygd5i>
 <35nbgxc7hqyef3iobfvhbftxtbxb3dfz574gbba4kwvbo6os4v@sya7ul5i6mmd>
 <CAADnVQJaG8kDaJr5LV29ces+gVpgARLAWiUvE9Ee5huuiW5X=Q@mail.gmail.com>
 <mhkzkf4e23uvljtmwizwcxyuyat2tmfxn33xb4t7waafgmsa66@mcrzpj3b6ssx>
 <CAADnVQLJ=nxp3bZYYMJd0yrUtMNx2DcvYXXmbGKBQAiG85kSLQ@mail.gmail.com>
 <xt2zckipzs24eur4ozdo64uoxfed6jm3qixxgnp3o2gogjmosc@723s2u7jbsaz>
 <CAADnVQK9qeMmzxE-aivmue-CF_hn1EFUTUAZyaMRqy2cW6j73A@mail.gmail.com> <b5r55f2uan7qm5h34nfu2qmoap2gm3ox3dtp2kjpaxebjrzxvp@zqx23ecrnj4q>
In-Reply-To: <b5r55f2uan7qm5h34nfu2qmoap2gm3ox3dtp2kjpaxebjrzxvp@zqx23ecrnj4q>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 8 May 2024 15:25:31 -0700
Message-ID: <CAADnVQLxjW411h-Wr2shMFNi_D7FK661yBZjYj2pUTwwhafc-A@mail.gmail.com>
Subject: Re: [PATCH] bpf: verifier: allow arrays of progs to be used in
 sleepable context
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 4:53=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.o=
rg> wrote:
>
> On May 07 2024, Alexei Starovoitov wrote:
> > On Tue, May 7, 2024 at 6:32=E2=80=AFAM Benjamin Tissoires <bentiss@kern=
el.org> wrote:
> > >
> > > Yes, exactly that. See [0] for my current WIP. I've just sent it, not
> > > for reviews, but so you see what I meant here.
> >
> > The patches helped to understand, for sure, and on surface
> > they kind of make sense, but without seeing what is that
> > hid specific kfunc that will use it
> > it's hard to make a call.
>
> I've posted my HID WIP on [1]. It probably won't compile as my local
> original branch was having a merge of HID and bpf trees.

Thanks for this context.
Now it makes a lot more sense.
And the first patches look fine and simplification is impressive,
but this part:
+     SEC("syscall")
+     int name(struct attach_prog_args *ctx)
+     {
+       ctx->retval =3D hid_bpf_attach_prog_impl(ctx->hid,
+                                                 type,
+                                                 __##name,
+                           ctx->insert_head ? HID_BPF_FLAG_INSERT_HEAD :
+                                                 HID_BPF_FLAG_NONE,
+                                                 NULL);

is too odd.
Essentially you're adding a kfunc on hid side just to call it
from a temporary "syscall" program to register another prog.
A fake prog just to call a kfunc is a bit too much.

The overall mechanism is pretty much a customized struct-ops.

I think struct-ops infra provides better api-s, safety guarantees,
bpf_link support, prog management including reentrance check, etc.
It needs to be parametrized, so it's not just
SEC("struct_ops/kern_callback_name")
so that the skeleton loading phase can pass device id or something.

> > The (u64)(long) casting concerns and prog lifetime are
> > difficult to get right. The verifier won't help and it all
> > will fall on code reviews.
>
> yeah, this is a concern.

Not only that. The special kfunc does migrate_disable
before calling callback, but it needs rcu_lock or tracing lock,
plus reentrance checks.

>
> > So I'd rather not go this route.
> > Let's explore first what exactly the goal here.
> > We've talked about sleepable tail_calls, this async callbacks
> > from hid kfuncs, and struct-ops.
> > Maybe none of them fit well and we need something else.
> > Could you please explain (maybe once again) what is the end goal?
>
> right now I need 4 hooks in HID, the first 2 are already upstream:
> - whenever I need to retrieve the report descriptor (this happens in a
>   sleepable context, but non sleepable is fine)
> - whenever I receive an event from a device (non sleepable context, this
>   is coming from a hard IRQ context)
> - whenever someone tries to write to the device through
>   hid_hw_raw_request (original context is sleepable, and for being able
>   to communicate with the device we need sleepable context in bpf)
> - same but from hid_hw_output_report
>
> Again, the first 2 are working just fine.
>
> Implementing the latter twos requires sleepable context because we
> might:
>
> 1. a request is made from user-space
> 2. we jump into hid-bpf
> 3. the bpf program "converts" the request from report ID 1 to 2 (because
> we export a slightly different API)
> 4. the bpf program directly emits hid_bpf_raw_request (sleepable
> operation)
> 5. the bpf program returns the correct value
> 6. hid-core doesn't attempt to communicate with the device as bpf
> already did.
>
> In the series, I also realized that I need sleepable and non sleepable
> contexts for this kind of situation, because I want tracing and
> firewalling available (non sleepable context), while still allowing to
> communicate with the device. But when you communicate with the device
> from bpf, the sleepable bpf program is not invoked or this allows
> infinite loops.

I don't get the point about infinite loops.
fyi struct_ops already supports sleepable and non-sleepable callbacks.
See progs/dummy_st_ops_success.c
SEC(".struct_ops")
struct bpf_dummy_ops dummy_1 =3D {
        .test_1 =3D (void *)test_1,
        .test_2 =3D (void *)test_2,
        .test_sleepable =3D (void *)test_sleepable,
};

two callbacks are normal and another one is sleepable.

The generated bpf trampoline will have the right
__bpf_prog_enter* wrappers for all 3 progs,
so the kernel code will be just do ops->callback_name().

> >
> > > Last time I checked, I thought struct_ops were only for defining one =
set
> > > of operations. And you could overwrite them exactly once.
> > > But after reading more carefully how it was used in tcp_cong.c, it se=
ems
> > > we can have multiple programs which define the same struct_ops, and t=
hen
> > > it's the kernel which will choose which one needs to be run.
> >
> > struct-ops is pretty much a mechanism for kernel to define
> > a set of callbacks and bpf prog to provide implementation for
> > these callbacks. The kernel choses when to call them.
> > tcp-bpf is one such user. sched_ext is another and more advanced.
> > Currently struct-ops bpf prog loading/attaching mechanism
> > only specifies the struct-ops. There is no device-id argument,
> > but that can be extended and kernel can keep per-device a set
> > of bpf progs.
> > struct-ops is a bit of overkill if you have only one callback.
> > It's typically for a set of callbacks.
>
> In the end I have 4. However, I might have programs that overwrite twice
> the same callback (see the 2 SEC("fmod_ret/hid_bpf_device_event") in
> [2]).
>
> >
> > > Last, I'm not entirely sure how I can specify which struct_ops needs =
to be
> > > attached to which device, but it's worth a shot. I've already realize=
d
> > > that I would probably have to drop the current way of HID-BPF is runn=
ing,
> > > so now it's just technical bits to assemble :)
> >
> > You need to call different bpf progs per device, right?
>
> yes
>
> > If indirect call is fine from performance pov,
> > then tailcall or struct_ops+device_argument might fit.
>
> performance is not a requirement. It's better if we have low latency but
> we are not talking the same requirements than network.
>
> >
> > If you want max perf with direct calls then
> > we'd need to generalize xdp dispatcher.
>
> I'll need to have a deeper look at it, yeah.
>
> >
> > So far it sounds that tailcalls might be the best actually,
> > since prog lifetime is handled by prog array map.
> > Maybe instead of bpf_tail_call helper we should add a kfunc that
> > will operate on prog array differently?
> > (if current bpf_tail_call semantics don't fit).
>
> Actually I'd like to remove bpf_tail_call entirely, because it requires
> to pre-load a BPF program at boot, and in some situations (RHEL) this
> creates issues. I haven't been able to debug what was happening, I
> couldn't reproduce it myself, but removing that bit would be nice :)

We probably need to debug it anyway, since it sounds that it's
related to preloaded bpf skeleton and not tail_call logic itself.

After looking through all that it seems to me that
parametrized struct-ops is the way to go.

