Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BA563C6EE
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 19:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbiK2SAu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 13:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236611AbiK2SAs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 13:00:48 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D446B392
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 10:00:46 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id x66so14432856pfx.3
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 10:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TSI5hG4OpJqGbtaBgdMep1PH+0f8Fx62v+X9xZ1Fl94=;
        b=PVqG6QzEOT3S84aLFS3ebN/+dcswywiw+Tx6QqHnhwexLip1a+xdTIutTPQLHGODOE
         HUMJxl4i7tyn0wbyWEwmwvBAV5fXYIPCYh+PZ86ivuFF+Z2Evwdp8at1oPYfaqoo67JH
         DfFuCRaP2xlxa/ergCj0mErkRDRutP8j+PmWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSI5hG4OpJqGbtaBgdMep1PH+0f8Fx62v+X9xZ1Fl94=;
        b=dC9KJHckPjC8foE0Uf1PmkHmO7bY7GaqrVeMVyyJzSa7CtWw1V7/HD2fuVrBX61R/G
         3nV7x6uUkKh120rKk10fdygfEfjPobkgamSKTP0fbQv9/fF0xP1jz2LKMGAfaWU6rz1x
         uWNxQf0Y3PpmqzKcdmEaSUlGzuKxczWV7S9O1erVGJ9jZXLQ8uax/xo+fK+wPEm0//Ja
         oIKOk/ZjeDgoaHJ+dRktFuxgN6TDzgngqZvoasWOp1sohVZsmczic4hZtjQpEHjqN3KP
         dKv2W60TxIXZUyMvAX6x07/Fh8sUftg9q9hkYIkk5k+pMoYLwz020ZqBDxKIZBooFadK
         mxDQ==
X-Gm-Message-State: ANoB5pkylSbedRlroPRY/OoF1HfdNSiH0qzrEvjtYLjDnaaFKCV1DSqN
        8uugRcPSA8wtuyDF5tObijDnFuir3knN/RdNfn+sMQ==
X-Google-Smtp-Source: AA0mqf7u65cBqunX27gIoaEd70af4bgJCUl4C12pXRT79B5hou0hUEMAqHi1rrceJLd5hJK9hxM6ue6EB8yz9NAAWV8=
X-Received: by 2002:a63:180a:0:b0:470:63e5:5c59 with SMTP id
 y10-20020a63180a000000b0047063e55c59mr32417999pgl.172.1669744846086; Tue, 29
 Nov 2022 10:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20221103155756.687789-1-benjamin.tissoires@redhat.com>
 <20221103155756.687789-4-benjamin.tissoires@redhat.com> <ff1a0b34-71f2-cebe-a6ef-675936b276eb@nvidia.com>
 <CAO-hwJJZxgeTT8mLwFrYynSVASva=o7qL9Kr4xOywV3KDUu2GA@mail.gmail.com>
 <CAADnVQ+kE+EJ9LAfwge9ksC0LR8r+ShQNYi5g-MDajufXq8Yxw@mail.gmail.com> <CAO-hwJJGxvrLRGSt7g0T1rYiuCCigVzQ-L6yKLM1-44EpYqmsQ@mail.gmail.com>
In-Reply-To: <CAO-hwJJGxvrLRGSt7g0T1rYiuCCigVzQ-L6yKLM1-44EpYqmsQ@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 29 Nov 2022 19:00:35 +0100
Message-ID: <CABRcYmKyRchQhabi1Vd9RcMQFCcb=EtWyEbFDFRTc-L-U8WhgA@mail.gmail.com>
Subject: Re: [PATCH hid v12 03/15] HID: initial BPF implementation
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        KP Singh <kpsingh@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 24, 2022 at 4:50 PM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Wed, Nov 23, 2022 at 9:14 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Nov 23, 2022 at 6:53 AM Benjamin Tissoires
> > <benjamin.tissoires@redhat.com> wrote:
> > >
> > > Hi Jon,
> > >
> > > On Wed, Nov 23, 2022 at 2:25 PM Jon Hunter <jonathanh@nvidia.com> wrote:
> > > >
> > > > We have a kernel test that checks for new warning and error messages on
> > > > boot and with this change I am now seeing the following error message on
> > > > our Tegra platforms ...
> > > >
> > > >   WARNING KERN hid_bpf: error while preloading HID BPF dispatcher: -13
> > > >
> > > > I have a quick look at the code, but I can't say I am familiar with
> > > > this. So I wanted to ask if a way to fix this or avoid this? I see the
> > > > code returns 0, so one option would be to make this an informational or
> > > > debug print.
> > >
> > > I am not in favor of debug in that case, because I suspect it'll hide
> > > too much when getting a bug report. Informational could do, yes.
> > >
> > > However, before that, I'd like to dig a little bit more on why it is
> > > failing. I thought arm64 now has support of tracing bpf programs, so I
> > > would not expect this to fail.

We have BPF trampolines on arm64 already but no ftrace direct calls
right now. (so trampolines get jitted but don't get called eheh :)) So
indeed BPF tracing programs (fentry/fexit/fmod_ret) do not work on
arm64 at the moment.

> > Unfortunately the patches to add support for such tracing bpf progs got stuck.
> > Florent/Mark can probably share the latest status.

We are working on an implementation of ftrace direct calls that would
fit within the constraints of arm64 and play nice with the other users
of the ftrace call site. Hopefully we have a patch to share in the
next couple of weeks I'd say!

> Oh... I noticed Jon's config was lacking CONFIG_FTRACE. So should I
> also add a depends on CONFIG_FTRACE to enable HID-BPF?

If HID-BPF fundamentally depends on a fmod_ret program being attached
to function, it seems to me that it should depend on both:
    CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS (CONFIG_FTRACE or even
CONFIG_DYNAMIC_FTRACE aren't enough, there can be architectures that
do not support direct calls. here you noticed it on arm64 which
luckily should get fixed someday soon but there could be other
architectures with that issue too)
and
    CONFIG_FUNCTION_ERROR_INJECTION (since [1] error injection needs
to be explicitly opted-in, it's easy to miss it and fail to attach
fmod_ret programs in mysterious ways)

I'm thinking that maybe encoding these two dependencies in the
CONFIG_HID_BPF is leaking too much of the bpf tracing abstraction to
the user. Maybe the BPF Kconfig could provide "proxy" configs like
HAVE_BPF_FENTRY_FEXIT, HAVE_BPF_FMOD_RET (naming is hard) to expose
these dependencies better ?

1: https://lore.kernel.org/lkml/20221121104403.1545f9b5@gandalf.local.home/
