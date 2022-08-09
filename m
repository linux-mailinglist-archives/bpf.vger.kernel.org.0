Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B321F58DC20
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 18:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244861AbiHIQdd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 12:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiHIQdc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 12:33:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2CA1E3FC;
        Tue,  9 Aug 2022 09:33:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A6EEB8162B;
        Tue,  9 Aug 2022 16:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF0CC433C1;
        Tue,  9 Aug 2022 16:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660062809;
        bh=8fxgktB6LFnIb5dP4SkWit1LLtIFgKBcYexKqyYW/uU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GyCaZ8Nu1dXBnMUv0bnuUQIeDO1IuLfcBM4qR2yV2IL+msxDF8WmGVcOqwox5c6rM
         HdPk9X4A30xyYkwcIdTTYdysMPCRQXOHQB7SrTXOYtUsYCaZ+P/hA0tGbiG6YKGqe8
         eSGfqIIJtYjQElaGqmCw+UeNXWk3II6uuDWP8hmw=
Date:   Tue, 9 Aug 2022 18:33:26 +0200
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
Message-ID: <YvKMVjl6x38Hud6I@kroah.com>
References: <20220809094300.83116-1-hadess@hadess.net>
 <20220809094300.83116-3-hadess@hadess.net>
 <YvI5DJnOjhJbNnNO@kroah.com>
 <2cde406b4d59ddfe71a7cdc11a76913a0a168595.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cde406b4d59ddfe71a7cdc11a76913a0a168595.camel@hadess.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 09, 2022 at 04:31:04PM +0200, Bastien Nocera wrote:
> On Tue, 2022-08-09 at 12:38 +0200, Greg Kroah-Hartman wrote:
> > Now if you really really want to disable a device from under a user,
> > without the file handle present, you can do that today, as root, by
> > doing the 'unbind' hack through userspace and sysfs.  It's so common
> > that this seems to be how virtual device managers handle virtual
> > machines, so it should be well tested by now.
> 
> The only thing I know that works that way is usbip, and it requires
> unbinding each of the interfaces:
> 
> https://sourceforge.net/p/usbip/git-windows/ci/master/tree/trunk/userspace/src/bind-driver.c#l157

virtio devices also use the api from what I recall.

> That means that, for example, revoking access to the raw USB device
> that OpenRGB used to blink colours across a keyboard would disconnect
> the keyboard from the HID device.

No, you unbind the usbfs driver, not the hid driver.

> Can you show me any other users of that "trick" that would keep the
> "hid" keyboard driver working while access to the /dev/bus/usb/* device
> node is revoked/closed/yanked/unbound?

Try unbinding usbfs from the device instead.

> And if you can't, I would appreciate some efforts being made trying to
> understand the use case, along with the limitations we're working
> against, so we can find a good solution to the problem, instead of
> retreading discussion points.

As you have not documented the use case well enough in these changelog
entries for me to understand it, the fact that I brought up things you
previously discussed seems to mean you didn't document it well enough
here for it not to come up again :)

thanks,

greg k-h
