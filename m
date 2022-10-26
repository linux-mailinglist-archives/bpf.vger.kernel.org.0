Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDAD60E45A
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 17:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbiJZPWu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 11:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbiJZPWt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 11:22:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D14187FAD;
        Wed, 26 Oct 2022 08:22:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE07461F84;
        Wed, 26 Oct 2022 15:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF91C433C1;
        Wed, 26 Oct 2022 15:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666797768;
        bh=93jSymFx20+8rupvLQVhGeALsg9ZVqpkHyrPk/9cPjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GuOWm29yoJbJtN1ClTuIatFCjpLbtkVW9FMb5EOwKCYxCOgHbpgnGTmclBKPz8RVn
         CS6MbFLNLA0kX0h72+6jgt08WZm80PuLcROWbNcWM5rMkY4Ho2/RfhcL2GizodcJzQ
         7kd7E64bS1I4Nfz7mvaHQIPP1WN1AlHZ8T+NbW0I=
Date:   Wed, 26 Oct 2022 17:22:45 +0200
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
Subject: Re: [PATCH 2/2] usb: Implement usb_revoke() BPF function
Message-ID: <Y1lQxVLgQopneFr0@kroah.com>
References: <20220809094300.83116-1-hadess@hadess.net>
 <20220809094300.83116-3-hadess@hadess.net>
 <48c37b1286e42eb5ee9308e74d7337950261ae7c.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48c37b1286e42eb5ee9308e74d7337950261ae7c.camel@hadess.net>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 26, 2022 at 05:00:35PM +0200, Bastien Nocera wrote:
> Hey,
> 
> On Tue, 2022-08-09 at 11:43 +0200, Bastien Nocera wrote:
> > This functionality allows a sufficiently privileged user-space
> > process
> > to upload a BPF programme that will call to usb_revoke_device() as if
> > it were a kernel API.
> > 
> > This functionality will be used by logind to revoke access to devices
> > on
> > fast user-switching to start with.
> > 
> > logind, and other session management software, does not have access
> > to
> > the file descriptor used by the application so other identifiers
> > are used.
> 
> Locally, I have a newer version of the code that I've been able to test
> successfully on some hardware, but I haven't been able to cover all of
> its branches.
> 
> So I've started writing some test application that would create devices
> with multiple interfaces using dummy_hcd, and client software that
> talks to those fake devices. I also have a version of the revoke tool.
> 
> My question is about all the dependencies that those test tools could
> use, and where to host it.
> 
> - Can I use libusb?

You could, but do you need to just to create a device?

> - Can I use libusbgx and raw-gadget?

raw-gadget is good, libusbgx I have found is pretty "thin", is it really
needed?

> - Can I use the GLib versions of those libraries?

That might be pushing it.

> - Do I need to have those tests as part of the kernel?

Ideally yes, why not?

> - Does it need to integrate with the kernel's compilation?

All kernel tests are in the tree, yes.

> - Can I use a Makefile? meson?

Makefile should be fine, look at all of the other examples we have.
Also tie into the other kernel test framework to provide the proper
results in the correct format so that tools can parse them correctly.

thanks,

greg k-h
