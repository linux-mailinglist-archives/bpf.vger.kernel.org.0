Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D3058E060
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 21:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238331AbiHITo2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 15:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345020AbiHITni (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 15:43:38 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 83A8026572
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 12:43:36 -0700 (PDT)
Received: (qmail 815908 invoked by uid 1000); 9 Aug 2022 15:43:35 -0400
Date:   Tue, 9 Aug 2022 15:43:35 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, bpf@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH 1/2] USB: core: add a way to revoke access to open USB
 devices
Message-ID: <YvK4534521C04NEm@rowland.harvard.edu>
References: <20220809094300.83116-1-hadess@hadess.net>
 <20220809094300.83116-2-hadess@hadess.net>
 <YvI4em9fCdZgRPnY@kroah.com>
 <d2dc546d771060b0a95d663fb77158d63b75bb9b.camel@hadess.net>
 <YvJYmG/upX2NWRJJ@kroah.com>
 <b1af087bc41a47bc29a7192a5c268243ef54ad26.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1af087bc41a47bc29a7192a5c268243ef54ad26.camel@hadess.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 09, 2022 at 03:27:16PM +0200, Bastien Nocera wrote:
> On Tue, 2022-08-09 at 14:52 +0200, Greg Kroah-Hartman wrote:
> > On Tue, Aug 09, 2022 at 01:18:43PM +0200, Bastien Nocera wrote:
> > > > Revoke what exactly?
> > > 
> > > Access.
> > 
> > Access from what?
> 
> revoke access to the USB device by one or all users.
> 
> > > >   You should be revoking the file descriptor that is
> > > > open, not anything else as those are all transient and not
> > > > uniquely
> > > > identified and racy.
> > > 
> > > They're "unique enough" (tm). The 
> > 
> > Are you sure?
> > 
> > They are racy from what I can tell, especially as you have no locking
> > in
> > the patch that I noticed.
> 
> It does. It's not good locking because I rewrote that API at least 4
> different times.

> > > > How is this handling uid namespaces?
> > > 
> > > The caller is supposed to be outside namespaces. It's a BPF
> > > programme,
> > > so must be loaded by a privileged caller.
> > 
> > Where is "outside namespaces" defined anywhere?
> > 
> > And how is this tied to any bpf program?  I don't see that interface
> > anywhere in this series, where did I miss that?
> 
> It's in 2/2.
> 
> The link to the user-space programme is in the "RFC v2" version of the
> patch from last week. It calls into the kernel through that function
> which is exported through BPF.
> 
> > 
> > > > Again, just revoke the file descriptor, like the BSDs do for a
> > > > tiny
> > > > subset of device drivers.
> > > > 
> > > > This comes up ever so often, why does someone not just add real
> > > > revoke(2) support to Linux to handle it if they really really
> > > > want it
> > > > (I
> > > > tried a long time ago, but didn't have it in me as I had no real
> > > > users
> > > > for it...)
> > > 
> > > This was already explained twice,
> > 
> > Explained where?
> 
> https://www.spinics.net/lists/linux-usb/msg225448.html
> https://www.spinics.net/lists/linux-usb/msg229753.html
> 
> > > there's nothing to "hand out" those file descriptors,
> > 
> > The kernel already handed out one when the device was opened using
> > usbfs.
> > 
> > > so no one but
> > > the kernel and the programme itself
> > > have that file descriptor, so it can't be used as an identifier.
> > 
> > That's the only unique identifier that you want to revoke and "know"
> > it
> > is the device you are referring to.
> > 
> > That's why I recommend creating revoke(2), not just an odd "pause the
> > data to this device" api like this seems.  That's just going to
> > confuse
> > lots of people as to "why did my device stop working?"
> 
> "Why did my app stop working. Because you switched users and your app
> needs to be updated to take that into account."
> 
> I mean, ENODEV is returned on ioctls, it's just that the poll() doesn't
> HUP.

Bastien, maybe it would help if you explained to Greg and the mailing 
list exactly what you want to accomplish, both in more detail and from a 
higher-level viewpoint than you already have provided.  Also, give an 
example or two showing when this mechanism would be invoked, how it would 
work, and what it would do.

(Also, usbfs doesn't bind to USB devices but it does bind to USB 
interfaces; see claimintf() in devio.c.)

Greg, unbinding usbfs would do only part of what Bastien wants.  It would 
prevent a process from sending or receiving data over bulk, interrupt, or 
isochronous endpoints connected to interfaces that were already bound, 
but it would not prevent the process from accessing endpoint 0 or from 
re-binding to interfaces.  What Bastien wants is a lot more like the 
kernel pretending to the process that the USB device has been 
disconnected and therefore is totally inaccessible.

As for whether this is the best (or even the right) thing to do, or 
whether there are other ways to accomplish the ultimate goal of not 
allowing user programs to access certain local devices unless those 
programs belong to an active (console?) login session...  That's beyond 
my scope.  I'm also not clear on how namespaces figure into the whole 
discussion.

Alan Stern
