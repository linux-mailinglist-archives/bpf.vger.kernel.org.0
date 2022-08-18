Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2835986F3
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 17:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344042AbiHRPIR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 11:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344008AbiHRPIP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 11:08:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E57A9;
        Thu, 18 Aug 2022 08:08:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7196B821DF;
        Thu, 18 Aug 2022 15:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29975C433C1;
        Thu, 18 Aug 2022 15:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660835287;
        bh=Z0E77J+gWISuARNQ99PusSJ/HYf0+M8/ij/rvEJLC3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KI9Hs6XvNK3xMtSeuWpYgExJJFOh9oBS8J5/YJhtndNCUGqklFiD8UiIqxRTHTJQL
         DdOBBdv2ltu2/mlNEajfZaMK4sbEMdtQYXSePZjbX6rEBWNt/fKWguloPRO4jHg8Om
         EnSoc3iWtIX2AHVkAiWKydmZwZNNhQQ9cU+8Zrrk=
Date:   Thu, 18 Aug 2022 17:08:04 +0200
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
Message-ID: <Yv5V1KWOQa5mnktE@kroah.com>
References: <20220809094300.83116-1-hadess@hadess.net>
 <20220809094300.83116-3-hadess@hadess.net>
 <YvI5DJnOjhJbNnNO@kroah.com>
 <2cde406b4d59ddfe71a7cdc11a76913a0a168595.camel@hadess.net>
 <YvKMVjl6x38Hud6I@kroah.com>
 <fae7e35a920239fe2a35b6b967bd17e04af1e1b7.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fae7e35a920239fe2a35b6b967bd17e04af1e1b7.camel@hadess.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 09, 2022 at 07:27:11PM +0200, Bastien Nocera wrote:
> On Tue, 2022-08-09 at 18:33 +0200, Greg Kroah-Hartman wrote:
> > On Tue, Aug 09, 2022 at 04:31:04PM +0200, Bastien Nocera wrote:
> > > On Tue, 2022-08-09 at 12:38 +0200, Greg Kroah-Hartman wrote:
> > > > Now if you really really want to disable a device from under a
> > > > user,
> > > > without the file handle present, you can do that today, as root,
> > > > by
> > > > doing the 'unbind' hack through userspace and sysfs.  It's so
> > > > common
> > > > that this seems to be how virtual device managers handle virtual
> > > > machines, so it should be well tested by now.
> > > 
> > > The only thing I know that works that way is usbip, and it requires
> > > unbinding each of the interfaces:
> > > 
> > > https://sourceforge.net/p/usbip/git-windows/ci/master/tree/trunk/userspace/src/bind-driver.c#l157
> > 
> > virtio devices also use the api from what I recall.
> 
> I can't find any code that would reference
> /sys/bus/usb/drivers/usbfs/unbind or /sys/bus/usb/drivers/usbfs wrt
> virtio. Where's the host side code for that?

I mean the virtio code uses bind/unbind for it's devices, nothing to do
with USB other than the userspace interface involved.

thanks,

greg k-h
