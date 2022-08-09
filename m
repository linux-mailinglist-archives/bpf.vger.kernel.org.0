Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4EF58D8F3
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 14:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243251AbiHIMws (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 08:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242937AbiHIMws (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 08:52:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AC212D28;
        Tue,  9 Aug 2022 05:52:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 37BE2CE16E4;
        Tue,  9 Aug 2022 12:52:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0923C433D7;
        Tue,  9 Aug 2022 12:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660049563;
        bh=SCi4simgGxgv/o4uumtGdKWS8F2ZsM5Q0PdjH8DfmHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ULHEjbz8o/KcBeSnnwS95MtH1wPx0/UsduLTiaEpgQ4FSr/jMCeHgODamCv5jRP7H
         8Dkl5wXSkxqi/KXwtEPued3v1eDlajCpqiLrVBku+fxbSS60uiHTEaGUab+bJFtdCj
         74i3yjY7NOXGBDkmWaMMkx3gcDB8hsyDP5x+fXqY=
Date:   Tue, 9 Aug 2022 14:52:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-usb@vger.kernel.org, bpf@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH 1/2] USB: core: add a way to revoke access to open USB
 devices
Message-ID: <YvJYmG/upX2NWRJJ@kroah.com>
References: <20220809094300.83116-1-hadess@hadess.net>
 <20220809094300.83116-2-hadess@hadess.net>
 <YvI4em9fCdZgRPnY@kroah.com>
 <d2dc546d771060b0a95d663fb77158d63b75bb9b.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2dc546d771060b0a95d663fb77158d63b75bb9b.camel@hadess.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 09, 2022 at 01:18:43PM +0200, Bastien Nocera wrote:
> On Tue, 2022-08-09 at 12:35 +0200, Greg Kroah-Hartman wrote:
> > On Tue, Aug 09, 2022 at 11:42:59AM +0200, Bastien Nocera wrote:
> > > There is a need for userspace applications to open USB devices
> > > directly,
> > > for all the USB devices without a kernel-level class driver[1], and
> > > implemented in user-space.
> > > 
> > > As not all devices are built equal, we want to be able to revoke
> > > access to those devices whether it's because the user isn't at the
> > > console anymore, or because the web browser, or sandbox doesn't
> > > want
> > > to allow access to that device.
> > > 
> > > This commit implements the internal API used to revoke access to
> > > USB
> > > devices, given either bus and device numbers, or/and a user's
> > > effective UID.
> > 
> > Revoke what exactly?
> 
> Access.

Access from what?

> >   You should be revoking the file descriptor that is
> > open, not anything else as those are all transient and not uniquely
> > identified and racy.
> 
> They're "unique enough" (tm). The 

Are you sure?

They are racy from what I can tell, especially as you have no locking in
the patch that I noticed.

> > > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > > 
> > > [1]:
> > > Non exhaustive list of devices and device types that need raw USB
> > > access:
> > > - all manners of single-board computers and programmable chips and
> > > devices (avrdude, STLink, sunxi bootloader, flashrom, etc.)
> > > - 3D printers
> > > - scanners
> > > - LCD "displays"
> > > - user-space webcam and still cameras
> > > - game controllers
> > > - video/audio capture devices
> > > - sensors
> > > - software-defined radios
> > > - DJ/music equipment
> > > - protocol analysers
> > > - Rio 500 music player
> > > ---
> > >  drivers/usb/core/devio.c | 79
> > > ++++++++++++++++++++++++++++++++++++++--
> > >  drivers/usb/core/usb.h   |  2 +
> > >  2 files changed, 77 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> > > index b5b85bf80329..d8d212ef581f 100644
> > > --- a/drivers/usb/core/devio.c
> > > +++ b/drivers/usb/core/devio.c
> > > @@ -78,6 +78,7 @@ struct usb_dev_state {
> > >         int not_yet_resumed;
> > >         bool suspend_allowed;
> > >         bool privileges_dropped;
> > > +       bool revoked;
> > >  };
> > >  
> > >  struct usb_memory {
> > > @@ -183,6 +184,13 @@ static int connected(struct usb_dev_state *ps)
> > >                         ps->dev->state != USB_STATE_NOTATTACHED);
> > >  }
> > >  
> > > +static int disconnected_or_revoked(struct usb_dev_state *ps)
> > > +{
> > > +       return (list_empty(&ps->list) ||
> > > +                       ps->dev->state == USB_STATE_NOTATTACHED ||
> > > +                       ps->revoked);
> > > +}
> > > +
> > >  static void dec_usb_memory_use_count(struct usb_memory *usbm, int
> > > *count)
> > >  {
> > >         struct usb_dev_state *ps = usbm->ps;
> > > @@ -237,6 +245,9 @@ static int usbdev_mmap(struct file *file,
> > > struct vm_area_struct *vma)
> > >         dma_addr_t dma_handle;
> > >         int ret;
> > >  
> > > +       if (disconnected_or_revoked(ps))
> > > +               return -ENODEV;
> > > +
> > >         ret = usbfs_increase_memory_usage(size + sizeof(struct
> > > usb_memory));
> > >         if (ret)
> > >                 goto error;
> > > @@ -310,7 +321,7 @@ static ssize_t usbdev_read(struct file *file,
> > > char __user *buf, size_t nbytes,
> > >  
> > >         pos = *ppos;
> > >         usb_lock_device(dev);
> > > -       if (!connected(ps)) {
> > > +       if (disconnected_or_revoked(ps)) {
> > >                 ret = -ENODEV;
> > >                 goto err;
> > >         } else if (pos < 0) {
> > > @@ -2315,7 +2326,7 @@ static int proc_ioctl(struct usb_dev_state
> > > *ps, struct usbdevfs_ioctl *ctl)
> > >         if (ps->privileges_dropped)
> > >                 return -EACCES;
> > >  
> > > -       if (!connected(ps))
> > > +       if (disconnected_or_revoked(ps))
> > >                 return -ENODEV;
> > >  
> > >         /* alloc buffer */
> > > @@ -2555,7 +2566,7 @@ static int proc_forbid_suspend(struct
> > > usb_dev_state *ps)
> > >  
> > >  static int proc_allow_suspend(struct usb_dev_state *ps)
> > >  {
> > > -       if (!connected(ps))
> > > +       if (disconnected_or_revoked(ps))
> > >                 return -ENODEV;
> > >  
> > >         WRITE_ONCE(ps->not_yet_resumed, 1);
> > > @@ -2580,6 +2591,66 @@ static int proc_wait_for_resume(struct
> > > usb_dev_state *ps)
> > >         return proc_forbid_suspend(ps);
> > >  }
> > >  
> > > +static int usbdev_revoke(struct usb_dev_state *ps)
> > > +{
> > > +       struct usb_device *dev = ps->dev;
> > > +       unsigned int ifnum;
> > > +       struct async *as;
> > > +
> > > +       if (ps->revoked) {
> > > +               usb_unlock_device(dev);
> > > +               return -ENODEV;
> > > +       }
> > > +
> > > +       snoop(&dev->dev, "%s: REVOKE by PID %d: %s\n", __func__,
> > > +             task_pid_nr(current), current->comm);
> > > +
> > > +       ps->revoked = true;
> > > +
> > > +       for (ifnum = 0; ps->ifclaimed && ifnum < 8*sizeof(ps-
> > > >ifclaimed);
> > > +                       ifnum++) {
> > > +               if (test_bit(ifnum, &ps->ifclaimed))
> > > +                       releaseintf(ps, ifnum);
> > > +       }
> > > +       destroy_all_async(ps);
> > > +
> > > +       as = async_getcompleted(ps);
> > > +       while (as) {
> > > +               free_async(as);
> > > +               as = async_getcompleted(ps);
> > > +       }
> > > +
> > > +       wake_up(&ps->wait);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +int usb_revoke_for_euid(struct usb_device *udev,
> > > +               int euid)
> > > +{
> > > +       struct usb_dev_state *ps;
> > > +
> > > +       usb_lock_device(udev);
> > > +
> > > +       list_for_each_entry(ps, &udev->filelist, list) {
> > > +               if (euid >= 0) {
> > > +                       kuid_t kuid;
> > > +
> > > +                       if (!ps || !ps->cred)
> > > +                               continue;
> > > +                       kuid = ps->cred->euid;
> > 
> > How is this handling uid namespaces?
> 
> The caller is supposed to be outside namespaces. It's a BPF programme,
> so must be loaded by a privileged caller.

Where is "outside namespaces" defined anywhere?

And how is this tied to any bpf program?  I don't see that interface
anywhere in this series, where did I miss that?

> > Again, just revoke the file descriptor, like the BSDs do for a tiny
> > subset of device drivers.
> > 
> > This comes up ever so often, why does someone not just add real
> > revoke(2) support to Linux to handle it if they really really want it
> > (I
> > tried a long time ago, but didn't have it in me as I had no real
> > users
> > for it...)
> 
> This was already explained twice,

Explained where?

> there's nothing to "hand out" those file descriptors,

The kernel already handed out one when the device was opened using
usbfs.

> so no one but
> the kernel and the programme itself
> have that file descriptor, so it can't be used as an identifier.

That's the only unique identifier that you want to revoke and "know" it
is the device you are referring to.

That's why I recommend creating revoke(2), not just an odd "pause the
data to this device" api like this seems.  That's just going to confuse
lots of people as to "why did my device stop working?"

thanks,

greg k-h
