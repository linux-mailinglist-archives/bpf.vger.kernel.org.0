Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C6152D056
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 12:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbiESKUm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 May 2022 06:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbiESKUX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 06:20:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F0A0A7757
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 03:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652955621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uTf4UazsnqFm1w0j9PjtulisgMFh6QzykfXouIHj8FI=;
        b=SkcW2gOgNwPOz6BytE92r6yPSBdEFSacYoH8+b/rVZRan0xnk6fXyaOIEVVoAt+heRF9yZ
        vFqTGxWyUycElQeUKUqG0FVV/x7KoKM6Ct/8gCwkmz0nzbwzyHz95anpfPbSMDoHlt11sy
        8EwGzEH8q0N2EdkRRPgq8Dv2/NxoHXk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-56XYEvRGPH-qZ-ySip2R7w-1; Thu, 19 May 2022 06:20:13 -0400
X-MC-Unique: 56XYEvRGPH-qZ-ySip2R7w-1
Received: by mail-pl1-f197.google.com with SMTP id e18-20020a170902ef5200b0016153d857a6so2397202plx.5
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 03:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uTf4UazsnqFm1w0j9PjtulisgMFh6QzykfXouIHj8FI=;
        b=MEzPvvQTYGIOqXrobO7djA2eNcKV8oQigOygUzPuLITSczdmp6o4uGY0o4w8FuTK21
         kiHbbRZdoFpLohLW3gT0y/+5ZgCOa2rTi9rMTadFNHgFE0U97Z93D4KebPNEyxLtJnTE
         0Eh58nHRxkBE61ckGXeoqEeG1VpgOpyHkMls/zkDD1nwTrdejpR7oiC+G4m3z7Erdx3x
         vgIqGQOuJbFmmWCvqBqMgfV/EQrUXsxGJEtMmj9FSwkDxa8HHkyYclMWbTo8hghbVaMs
         6PaN8WZu3sNtY7oHnumV9+tvPFVI21Ebxz3Nei7iita1FWp8Jsra9+eu+W38tAgdzUsH
         gHaw==
X-Gm-Message-State: AOAM533TGnD08Px84ajkEdMLLTJYjYH+zZhwxDXVi84HjpZFXVMMzCoL
        x7nNe0fiqxY7UcF6hWs6vVBpK5fat34uZgL6ICmPrOsSuNeVcrngi3P8gsa+mGlK1hxw3vnrfJ2
        JFIFVGGpMWA3YjAr2DVDd2Q1ZBGm2
X-Received: by 2002:a17:903:22c6:b0:15f:14e1:1518 with SMTP id y6-20020a17090322c600b0015f14e11518mr4080927plg.116.1652955612085;
        Thu, 19 May 2022 03:20:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyu2Gf5VTzOz90w3/G1De6zt6if/VLekZLdOYdtToYtFikUFmLdwo0CCwN8PGggiEKvMyPvE0o9jU6G39mZwzo=
X-Received: by 2002:a17:903:22c6:b0:15f:14e1:1518 with SMTP id
 y6-20020a17090322c600b0015f14e11518mr4080890plg.116.1652955611775; Thu, 19
 May 2022 03:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220518205924.399291-1-benjamin.tissoires@redhat.com>
 <YoX7iHddAd4FkQRQ@infradead.org> <YoX904CAFOAfWeJN@kroah.com> <YoYCIhYhzLmhIGxe@infradead.org>
In-Reply-To: <YoYCIhYhzLmhIGxe@infradead.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 19 May 2022 12:20:00 +0200
Message-ID: <CAO-hwJL4Pj4JaRquoXD1AtegcKnh22_T0Z0VY_peZ8FRko3kZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 00/17] Introduce eBPF support for HID devices
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joe Stringer <joe@cilium.io>, Jonathan Corbet <corbet@lwn.net>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 19, 2022 at 10:39 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, May 19, 2022 at 10:20:35AM +0200, Greg KH wrote:
> > > are written using a hip new VM?
> >
> > Ugh, don't mention UDI, that's a bad flashback...
>
> But that is very much what we are doing here.
>
> > I thought the goal here was to move a lot of the quirk handling and
> > "fixup the broken HID decriptors in this device" out of kernel .c code
> > and into BPF code instead, which this patchset would allow.

Yes, quirks are a big motivation for this work. Right now half of the
HID drivers are less than 100 lines of code, and are just trivial
fixes (one byte in the report descriptor, one key mapping, etc...).
Using eBPF for those would simplify the process from the user point of
view: you drop a "firmware fix" as an eBPF program in your system and
you can continue working on your existing kernel.

The other important aspect is being able to do filtering on the event
streams themselves.
This would mean for instance that you allow some applications to have
access to part of the device features and you reject some of them. The
main use case I have is to prevent applications to switch a device
into its bootloader mode and mess up with the firmware.

> >
> > So that would just be exception handling.  I don't think you can write a
> > real HID driver here at all, but I could be wrong as I have not read the
> > new patchset (older versions of this series could not do that.)

Well, to be fair, yes and no.
HID-BPF can only talk HID, and so we only act on arrays of bytes. You
can mess up with the report descriptor or the events themselves, but
you don't have access to other kernel APIs.
So no, you can not write a HID-BPF driver that would manually create
LEDs sysfs endpoints, input endpoints and battery endpoints.

However, HID is very versatile in how you can describe a device. And
the kernel now supports a lot of those features. So if you really
want, you can entirely change the look of the device (its report
descriptor), and rely on hid-core to export those LEDs, inputs and
battery endpoints.

But we already have this available by making use of hidraw+uhid. This
involves userspace and there are already projects (for handling
Corsair keyboard for example) which are doing exactly that, with a big
security whole in the middle because the application is reading *all*
events as they are flowing.

One of the most important things here is that this work allows for
context driven behavior. We can now control how a device is behaving
depending on the actual application without having to design and
maintain forever kernel APIs.
For example, the Surface Dial is a puck that can have some haptic
feedback when you turn it. However, when you enable the haptic
feedback you have to reduce the resolution to one event every 5
degrees or the haptic feedback feels just wrong. But the device is
capable of sub-degrees of event notifications. Which means you want
the high resolution mode without haptic, and low res with haptic.

Of course, you can use some new FF capabilities to enable/disable
haptic, but we have nothing to change the resolution on the fly of a
HID device, so we'll likely have to create another kernel API through
a sysfs node or a kernel parameter. But then we need to teach
userspace to use it and this kernel API is not standard, so it won't
be used outside of this particular device.
BPF in that case allows the application which needs it to do the
changes it requires depending on the context. And when I say
application, it is mostly either the compositor or a daemon, not gimp.

>
> And that "exception handling" is most of the driver.
>

Well, it depends. If hardware makers would not make crappy decisions
based on the fact that it somehow works under Windows, we wouldn't
have to do anything to support those devices.
But for half of the drivers, we are doing dumb things to fix those
devices in the kernel.

On the other hand, we do have generic protocols in HID that can not be
replaced by BPF.
For the exercise, I tried to think about what it would take to rewrite
the multitouch logic in eBPF, and trust me, you don't want that. The
code would be a lot of spaghetti and would require access to many
kernel APIs to handle it properly.

Cheers,
Benjamin

