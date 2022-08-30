Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4405C5A668A
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 16:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiH3OpH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 30 Aug 2022 10:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiH3OpA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 10:45:00 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE503E0DD;
        Tue, 30 Aug 2022 07:44:57 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 11D24200002;
        Tue, 30 Aug 2022 14:44:52 +0000 (UTC)
Message-ID: <31207cebad932bd9d943421d6528ad81877758a5.camel@hadess.net>
Subject: Re: [PATCH 2/2] usb: Implement usb_revoke() BPF function
From:   Bastien Nocera <hadess@hadess.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, bpf@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Date:   Tue, 30 Aug 2022 16:44:52 +0200
In-Reply-To: <Yv5V1KWOQa5mnktE@kroah.com>
References: <20220809094300.83116-1-hadess@hadess.net>
         <20220809094300.83116-3-hadess@hadess.net> <YvI5DJnOjhJbNnNO@kroah.com>
         <2cde406b4d59ddfe71a7cdc11a76913a0a168595.camel@hadess.net>
         <YvKMVjl6x38Hud6I@kroah.com>
         <fae7e35a920239fe2a35b6b967bd17e04af1e1b7.camel@hadess.net>
         <Yv5V1KWOQa5mnktE@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2022-08-18 at 17:08 +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 09, 2022 at 07:27:11PM +0200, Bastien Nocera wrote:
> > On Tue, 2022-08-09 at 18:33 +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Aug 09, 2022 at 04:31:04PM +0200, Bastien Nocera wrote:
> > > > On Tue, 2022-08-09 at 12:38 +0200, Greg Kroah-Hartman wrote:
> > > > > Now if you really really want to disable a device from under
> > > > > a
> > > > > user,
> > > > > without the file handle present, you can do that today, as
> > > > > root,
> > > > > by
> > > > > doing the 'unbind' hack through userspace and sysfs.  It's so
> > > > > common
> > > > > that this seems to be how virtual device managers handle
> > > > > virtual
> > > > > machines, so it should be well tested by now.
> > > > 
> > > > The only thing I know that works that way is usbip, and it
> > > > requires
> > > > unbinding each of the interfaces:
> > > > 
> > > > https://sourceforge.net/p/usbip/git-windows/ci/master/tree/trunk/userspace/src/bind-driver.c#l157
> > > 
> > > virtio devices also use the api from what I recall.
> > 
> > I can't find any code that would reference
> > /sys/bus/usb/drivers/usbfs/unbind or /sys/bus/usb/drivers/usbfs wrt
> > virtio. Where's the host side code for that?
> 
> I mean the virtio code uses bind/unbind for it's devices, nothing to
> do
> with USB other than the userspace interface involved.

This is one big hammer that is really counterproductive in some fairly
common use cases. It's fine for assigning a full USB device to a VM, it
really isn't for gently removing "just that bit of interface" the user
is using while leaving the rest running.

If a USB device has 2 interfaces, and one of those interfaces is used
by a kernel driver, or a system-wide application, then the whole USB
device is made unavailable.

For example:
- a wireless headset, sound is handled by ALSA at the kernel-level,
battery status is monitored through another interface by the user
directly, unbinding the USB driver will disable both the sound driver
and the battery monitor
- a keyboard with RGB backlight, key presses are handled by the input
subsystem in the kernel, RGB backlight through another interface as a
normal user, unbinding the USB driver disconnects the keyboard
completely making it lose lock keys status, amongst other things
- a phone used for both network access and file access through MTP,
unbinding the USB driver will boot the computer off the network as well
as disconnecting the file access when we only wanted the latter to
happen

I'll explain those use cases in the commit message.

For those who want to reproduce the problem, tested with USB wireless
headset:
$ lsusb
Bus 001 Device 011: ID 1038:12b6 SteelSeries ApS SteelSeries Arctis 1 Wireless

# Using the bus and device IDs
$ grep -l 001/011 /sys/bus/usb/devices/*/uevent | sed 's,/sys/bus/usb/devices/,,' | sed 's,/uevent,,'
1-10

$ echo 1-10 > /sys/bus/usb/drivers/usb/unbind

Both the ALSA device:
Aug 30 16:19:07 classic pipewire[2061]: spa.alsa: hw:2: snd_pcm_drop No such device
Aug 30 16:19:07 classic pipewire[2061]: spa.alsa: hw:2: close failed: No such device
Aug 30 16:19:07 classic pipewire[2061]: spa.alsa: front:2: snd_pcm_drop No such device
Aug 30 16:19:07 classic pipewire[2061]: spa.alsa: front:2: close failed: No such device


and the battery script
(https://github.com/Sapd/HeadsetControl/pull/230) are gone.
