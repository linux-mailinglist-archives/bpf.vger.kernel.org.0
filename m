Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EFF58D809
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 13:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiHILab (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 07:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239475AbiHILaa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 07:30:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B46D22B01;
        Tue,  9 Aug 2022 04:30:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0954A60FEB;
        Tue,  9 Aug 2022 11:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20EFC433C1;
        Tue,  9 Aug 2022 11:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660044628;
        bh=XfhySSmsH8uICx0NjA1/KKsN6MU+N2ZxoYlzHdn8oe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NVd3eAgqKkx7VguRrb6SpCUZc6fXRD3SoNjdNB/h/ssDAR6VpnCpbkeZABaXNNUAT
         2T7B/ap2Jhw46krYymmJUUF1jCb6NsVuM+h0WpG7TwAF7FmOaGDylB2iDcuW+DNw+Q
         l9o8Uy8ppQy6TmeIHnhjR3ZaL2x2ObOvYeyMcISM=
Date:   Tue, 9 Aug 2022 13:30:25 +0200
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
Message-ID: <YvJFUWOw6vyU3tc4@kroah.com>
References: <20220809094300.83116-1-hadess@hadess.net>
 <20220809094300.83116-2-hadess@hadess.net>
 <YvI3rUTs/axBANHm@kroah.com>
 <8512a37ce2e54f2c44a4fe10b475d61334498c4f.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8512a37ce2e54f2c44a4fe10b475d61334498c4f.camel@hadess.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 09, 2022 at 01:15:50PM +0200, Bastien Nocera wrote:
> On Tue, 2022-08-09 at 12:32 +0200, Greg Kroah-Hartman wrote:
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
> > > 
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
> > 
> > We can't take "footnotes" after a signed-off-by line, you know this
> > :(
> 
> Where would I know this from?

To quote from our documentation:
	The sign-off is a simple line at the end of the explanation for the
	patch,

> checkpatch.pl doesn't warn about it.

Odd, it should.  Send a patch for that?  :)

thanks,

greg k-h
