Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D23D58D7F2
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 13:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237990AbiHILSg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 9 Aug 2022 07:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbiHILSf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 07:18:35 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C1021E3D;
        Tue,  9 Aug 2022 04:18:33 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 040D2FF809;
        Tue,  9 Aug 2022 11:18:27 +0000 (UTC)
Message-ID: <7cedc4e3a91a520c0c9f5dc65d84d3a0fffed67a.camel@hadess.net>
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
Date:   Tue, 09 Aug 2022 13:18:27 +0200
In-Reply-To: <YvI5DJnOjhJbNnNO@kroah.com>
References: <20220809094300.83116-1-hadess@hadess.net>
         <20220809094300.83116-3-hadess@hadess.net> <YvI5DJnOjhJbNnNO@kroah.com>
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

On Tue, 2022-08-09 at 12:38 +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 09, 2022 at 11:43:00AM +0200, Bastien Nocera wrote:
> > This functionality allows a sufficiently privileged user-space
> > process
> > to upload a BPF programme that will call to usb_revoke_device() as
> > if
> > it were a kernel API.
> > 
> > This functionality will be used by logind to revoke access to
> > devices on
> > fast user-switching to start with.
> > 
> > logind, and other session management software, does not have access
> > to
> > the file descriptor used by the application so other identifiers
> > are used.
> > 
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > ---
> >  drivers/usb/core/usb.c | 51
> > ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> > 
> > diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> > index 2f71636af6e1..ca394848a51e 100644
> > --- a/drivers/usb/core/usb.c
> > +++ b/drivers/usb/core/usb.c
> > @@ -38,6 +38,8 @@
> >  #include <linux/workqueue.h>
> >  #include <linux/debugfs.h>
> >  #include <linux/usb/of.h>
> > +#include <linux/btf.h>
> > +#include <linux/btf_ids.h>
> >  
> >  #include <asm/io.h>
> >  #include <linux/scatterlist.h>
> > @@ -438,6 +440,41 @@ static int usb_dev_uevent(struct device *dev,
> > struct kobj_uevent_env *env)
> >         return 0;
> >  }
> >  
> > +struct usb_revoke_match {
> > +       int busnum, devnum; /* -1 to match all devices */
> > +       int euid; /* -1 to match all users */
> > +};
> > +
> > +static int
> > +__usb_revoke(struct usb_device *udev, void *data)
> > +{
> > +       struct usb_revoke_match *match = data;
> > +
> > +       if (match->devnum >= 0 && match->busnum >= 0) {
> > +               if (match->busnum != udev->bus->busnum ||
> > +                   match->devnum != udev->devnum) {
> > +                       return 0;
> > +               }
> > +       }
> > +
> > +       usb_revoke_for_euid(udev, match->euid);
> 
> How are you not racing with other devices being added and removed at
> the
> same time?
> 
> Again, please stick with the file descriptor, that's the unique thing
> you know you have that you want to revoke.
> 
> Now if you really really want to disable a device from under a user,
> without the file handle present, you can do that today, as root, by
> doing the 'unbind' hack through userspace and sysfs.  It's so common
> that this seems to be how virtual device managers handle virtual
> machines, so it should be well tested by now.
> 
> or does usbfs not bind to the device it opens?

And how is this not racy, and clunky and slow?

It would lose all the PM setup the drive might have done, reset and
reprobe the device, and forcibly close the file descriptor the
programme had opened.

This revocation just "mutes" (with no possibility to unmute) the file
descriptor the programme has, so it can't talk to physical device
anymore.
