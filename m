Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0425F5A686E
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 18:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiH3Q2u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 30 Aug 2022 12:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiH3Q2j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 12:28:39 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56413D34C7;
        Tue, 30 Aug 2022 09:28:37 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 53AEEE0006;
        Tue, 30 Aug 2022 16:28:31 +0000 (UTC)
Message-ID: <71407e16e141ebc6e9eb042187a1448ad6cfa419.camel@hadess.net>
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
Date:   Tue, 30 Aug 2022 18:28:30 +0200
In-Reply-To: <Yw4ocSXDuWmlFkIg@kroah.com>
References: <20220809094300.83116-1-hadess@hadess.net>
         <20220809094300.83116-3-hadess@hadess.net> <YvI5DJnOjhJbNnNO@kroah.com>
         <2cde406b4d59ddfe71a7cdc11a76913a0a168595.camel@hadess.net>
         <YvKMVjl6x38Hud6I@kroah.com>
         <fae7e35a920239fe2a35b6b967bd17e04af1e1b7.camel@hadess.net>
         <Yv5V1KWOQa5mnktE@kroah.com>
         <31207cebad932bd9d943421d6528ad81877758a5.camel@hadess.net>
         <Yw4ocSXDuWmlFkIg@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-08-30 at 17:10 +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 30, 2022 at 04:44:52PM +0200, Bastien Nocera wrote:
> > On Thu, 2022-08-18 at 17:08 +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Aug 09, 2022 at 07:27:11PM +0200, Bastien Nocera wrote:
> > > > On Tue, 2022-08-09 at 18:33 +0200, Greg Kroah-Hartman wrote:
> > > > > On Tue, Aug 09, 2022 at 04:31:04PM +0200, Bastien Nocera
> > > > > wrote:
> > > > > > On Tue, 2022-08-09 at 12:38 +0200, Greg Kroah-Hartman
> > > > > > wrote:
> > > > > > > Now if you really really want to disable a device from
> > > > > > > under
> > > > > > > a
> > > > > > > user,
> > > > > > > without the file handle present, you can do that today,
> > > > > > > as
> > > > > > > root,
> > > > > > > by
> > > > > > > doing the 'unbind' hack through userspace and sysfs. 
> > > > > > > It's so
> > > > > > > common
> > > > > > > that this seems to be how virtual device managers handle
> > > > > > > virtual
> > > > > > > machines, so it should be well tested by now.
> > > > > > 
> > > > > > The only thing I know that works that way is usbip, and it
> > > > > > requires
> > > > > > unbinding each of the interfaces:
> > > > > > 
> > > > > > https://sourceforge.net/p/usbip/git-windows/ci/master/tree/trunk/userspace/src/bind-driver.c#l157
> > > > > 
> > > > > virtio devices also use the api from what I recall.
> > > > 
> > > > I can't find any code that would reference
> > > > /sys/bus/usb/drivers/usbfs/unbind or /sys/bus/usb/drivers/usbfs
> > > > wrt
> > > > virtio. Where's the host side code for that?
> > > 
> > > I mean the virtio code uses bind/unbind for it's devices, nothing
> > > to
> > > do
> > > with USB other than the userspace interface involved.
> > 
> > This is one big hammer that is really counterproductive in some
> > fairly
> > common use cases. It's fine for assigning a full USB device to a
> > VM, it
> > really isn't for gently removing "just that bit of interface" the
> > user
> > is using while leaving the rest running.
> 
> In USB, drivers are bound to interfaces, not to the device.

I did implement kernel drivers for devices all the way back in 2020, if
you remember.

> But as Alan pointed out, we don't ever really "bind" the usbfs code
> to
> the interface, so that will not work all that well :(

Right.
