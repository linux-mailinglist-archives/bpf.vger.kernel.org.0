Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9681C5159FB
	for <lists+bpf@lfdr.de>; Sat, 30 Apr 2022 05:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382096AbiD3DE2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Apr 2022 23:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382113AbiD3DE0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Apr 2022 23:04:26 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0DF8C7F7;
        Fri, 29 Apr 2022 20:01:05 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id p6so8607170plf.9;
        Fri, 29 Apr 2022 20:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sJbeOZdGo/iGCzS2hb9T0p/O4FHAvUxSNhK6RnmmTD8=;
        b=hRv1rLL+Moem4XVZIiZT+It+KR15QdGjR5AYYIbIoHIu+Y+nsCyj1o++gdwJFwIkAu
         HsFQlTEN9s28kR6VXCE5gboa++uxnnZJTCKqyezC8hZYoZa4ormK5OHioWvWElKJEgXI
         YaCpZ/aaOCnvWJVGInDQ7Q5AHY4DtI2PxmGSxQckE9WYw9XFhQ1NxazMej/a3hYrhUN1
         VjVp+ZaShgksdN44x3xu/56s/ZVMbRSbwwm/ORq09+M/QAFI9V8mzemhcYG6juCLvF5C
         rH4y1eBB1ETym1s1C2vt9RySabeY/Deu7p8ZCZ/1wDns6/8WUz+qJE4xfwvdRTKt1AKR
         T8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sJbeOZdGo/iGCzS2hb9T0p/O4FHAvUxSNhK6RnmmTD8=;
        b=wmULrwwpD7KMh0eOqGXgPgAeqW2fgrvk0FYdmxWINqXVuDQflmDQNOGPqiySx/Db63
         GamcGG5iENdXck78dlFS0mOs2F6Ib0z6UOsw/QHJtcxVHZg/F1XHbcZb3kaEm9DXFqq8
         pDmScEA9CNEXqRdZD02SrCuOOURm82G3CqMVreVu03IMqr8QpNLjAp5WpY231hxFBAAm
         6EkG5MHVdHx3pxPSFSEjyAqZ5uM347HplPovG3Zc1TZHzJN7wvk/MloAFa0p5mBFBZdw
         FgxfalfW3gKyEUdQaqPjbufclH5UJ41xxCIVjrqzQxcKU2xDerNxrod+c/X6cI1kv75P
         n/MQ==
X-Gm-Message-State: AOAM531rA31Xj2VusD0CnB5+Plny+1df+DxCsobUAE2ltCtiXEAl9TLJ
        YjhQgTtz45g3/vjkw/6HjLu9fP4gAoBMcxWDZtw=
X-Google-Smtp-Source: ABdhPJyDXUMYezfyoEDxL3YEYwI2StMRhSXxB6zRjHH5aWYlZLvZ52SIFKGSvmPDLCN9leJowR9UgCy9OUWMoEYRgBA=
X-Received: by 2002:a17:902:d58a:b0:15d:1cf6:644c with SMTP id
 k10-20020a170902d58a00b0015d1cf6644cmr2181857plh.67.1651287665115; Fri, 29
 Apr 2022 20:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
 <20220426040314.ez3cdpv2w45vbgkk@MBP-98dd607d3435.dhcp.thefacebook.com> <CAO-hwJLziatB9n5Rut_EYRgfN94t2XX8Zx8B_Zmu2nucTw3k8g@mail.gmail.com>
In-Reply-To: <CAO-hwJLziatB9n5Rut_EYRgfN94t2XX8Zx8B_Zmu2nucTw3k8g@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 29 Apr 2022 20:00:54 -0700
Message-ID: <CAADnVQKN==eb3ASQhrJBg4yC8BuRdMQyY-OdRbXhdyv2P8L0-A@mail.gmail.com>
Subject: Re: [RFC bpf-next v4 0/7] Introduce eBPF support for HID devices (new attempt)
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 26, 2022 at 12:20 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Tue, Apr 26, 2022 at 6:03 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Apr 21, 2022 at 04:07:33PM +0200, Benjamin Tissoires wrote:
> > > Hi,
> > >
> > > so after the reviews from v3, and some discussion with Alexei, I am
> > > back with a new version of HID-BPF.
> > >
> > > This version is not complete (thus the RFC), but I'd like to share
> > > it now to get initial feedback, in case I am too far from the actual
> > > goal.
> > >
> > > FTR, the goal is to provide some changes in the core verifier/btf so
> > > that we can plug in HID-BPF independently from BPF core. This way we can
> > > extend it without having to care about bpf-next.
> >
> > Overall looks great. imo much cleaner, simpler and more extensible
> > than the earlier versions.
> > The bpf core extensions are nicely contained and HID side can be
> > worked on in parallel.
>
> \o/
>
> >
> > > The things I am not entirely sure are:
> > > - do we need only fentry/fexit/fmod_ret BPF program types or should
> > >   programs that modify the data stream use a different kind?
> >
> > Probably not. I'll reply in patch 2.
> >
> > > - patch 3/7 is probably not the correct approach (see comments in the
> > >   patch itself)
> > >
> > > We are missing quite a few bits here:
> > > - selftests for patches 1 to 4
> > > - add the ability to attach a program to a struct device, and run that
> > >   program only for that struct device
> >
> > yes. That is still to be figured out.
>
> I spent some time on that, and I don't think it makes a lot of sense
> to use the current trampoline approach if we want to keep on using
> fentry/fexit...
> - the trampoline is pretty nice, but it adds instructions before
> calling the actual function, meaning that adding a check on struct
> device will be quite hard to do ()we have no idea where the struct
> device is in the arguments) and will take more space on the trampoline
> itself
> - there is a limit on how many functions can be attached to a
> trampoline (38 IIRC), and we probably will explode that number quickly
> enough when we get more BPF programs to support HID devices.

Ohh. This is an obsolete limitation.
38 was the number since we used half page optimization
for bpf trampoline.
It's gone now. We can easily lift this max.

> So my chain of thoughts from yesterday was the following (completely
> untested of course):
> - instead of writing a new BPF API that might move in the future while
> things are settling, I can actually simply load a tracer BPF program
> from HID that monitors the BPF programs that are attached to a given
> function
> - I can also add a new API (a kfunc likely) that "registers" a given
> BPF program (through its fd) to a given HID device
> - when a device sends data, it hits hid_bpf_device_event() which will
> have a default BPF program (loaded by the kernel) that dispatches the
> registered BPF programs based on the HID device.
>
> This would solve the 2 issues above IMO, except that the kfunc to
> register a HID BPF program will suddenly be not standard.

Could you add more details to these ideas?
I thought you wanted bpf prog writers to be independent of each other.
They would tell some framework HID device id/pcie id that they need
and the rest would be automatic.
Maybe we can achieve that by adding another layer before libbpf
that would accept (bpf_prog, hid_id) tuple and insert
if (hid->id != hid_id) return -E..;
as the first insn into bpf_prog before loading into the kernel.
All such progs will be kfunc-s attached to the same hook.
The kernel will execute them sequentially.
The framework will provide demux by auto-inserting this 'if'.
This 'if (hid)' could be a part of sample code too.
We can simply ask prog writers to follow this style.

Another idea would be to do something like libxdp.
Attach a "dispatcher" bpf prog to the kfunc hook and use
some library to attach hid-specific progs as "freplace" kind of
programs. It's a more involved solution.

Another option is to use tail_calls.
If hid_id is a relatively small number. The "dispatcher" bpf prog
can do bpf_tail_call(prog_array, hid_id)
while hid specific progs insert itself into prog_array
instead of attaching to kfunc.

> >
> > > - when running through bpf_prog_test_run_opts, how can we ensure we are
> > >   talking to the correct device? (I have a feeling this is linked to the
> > >   previous point)
> > > - how can we reconnect the device when a report descriptor fixup BPF
> > >   program is loaded (would it make sense to allow some notifications on
> > >   when a BPF program is attached/detached to a device, and which
> > >   function have been traced?)
> >
> > Not sure I follow. What kind of notification do you have in mind?
> > To user space?
> >
>
> No, this is in-kernel notifications.
> What I want to do, is when I load a BPF program that changes the HID
> report descriptor, hid-core detects that and reconnects the attached
> device.
>
> But after a couple of days of thinking, and with the above approach
> where HID would preload a BPF program, I should be able to achieve
> that with the "register BPF through a HID kfunc call". When I see that
> we are attaching a HID report descriptor fixup to a given HID device,
> I can then reconnect the matching device.
>
> It would certainly be cleaner to have a general "notify me when a
> tracer is attached to this particular function", but we can hide that
> right now with a preloaded BPF program :)

There are few lsm hooks in bpf core. It probably wwill be eird
for hid core to hook into them. We can add a few tracepoints
at attach functions if that helps.
