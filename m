Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3D958DD2A
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 19:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245319AbiHIR1a convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 9 Aug 2022 13:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245302AbiHIR1Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 13:27:16 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E679A25589;
        Tue,  9 Aug 2022 10:27:15 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id F2297FF802;
        Tue,  9 Aug 2022 17:27:11 +0000 (UTC)
Message-ID: <fae7e35a920239fe2a35b6b967bd17e04af1e1b7.camel@hadess.net>
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
Date:   Tue, 09 Aug 2022 19:27:11 +0200
In-Reply-To: <YvKMVjl6x38Hud6I@kroah.com>
References: <20220809094300.83116-1-hadess@hadess.net>
         <20220809094300.83116-3-hadess@hadess.net> <YvI5DJnOjhJbNnNO@kroah.com>
         <2cde406b4d59ddfe71a7cdc11a76913a0a168595.camel@hadess.net>
         <YvKMVjl6x38Hud6I@kroah.com>
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

On Tue, 2022-08-09 at 18:33 +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 09, 2022 at 04:31:04PM +0200, Bastien Nocera wrote:
> > On Tue, 2022-08-09 at 12:38 +0200, Greg Kroah-Hartman wrote:
> > > Now if you really really want to disable a device from under a
> > > user,
> > > without the file handle present, you can do that today, as root,
> > > by
> > > doing the 'unbind' hack through userspace and sysfs.  It's so
> > > common
> > > that this seems to be how virtual device managers handle virtual
> > > machines, so it should be well tested by now.
> > 
> > The only thing I know that works that way is usbip, and it requires
> > unbinding each of the interfaces:
> > 
> > https://sourceforge.net/p/usbip/git-windows/ci/master/tree/trunk/userspace/src/bind-driver.c#l157
> 
> virtio devices also use the api from what I recall.

I can't find any code that would reference
/sys/bus/usb/drivers/usbfs/unbind or /sys/bus/usb/drivers/usbfs wrt
virtio. Where's the host side code for that?

> > That means that, for example, revoking access to the raw USB device
> > that OpenRGB used to blink colours across a keyboard would
> > disconnect
> > the keyboard from the HID device.
> 
> No, you unbind the usbfs driver, not the hid driver.

Honestly, I don't understand how this is supposed to work. The USB
device is bound to the usb_generic driver, usbfs doesn't have a link to
the devices it's supposed to handle.
