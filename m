Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290D758D780
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 12:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242439AbiHIKiP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 06:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237990AbiHIKiL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 06:38:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DBF2408B;
        Tue,  9 Aug 2022 03:38:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1B9EB8111F;
        Tue,  9 Aug 2022 10:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079A8C433C1;
        Tue,  9 Aug 2022 10:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660041487;
        bh=cZ3pSbTwzN2nuIXSO3zjQXGAS5gEZHuntOxhO36U/LI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wW8X1SJkxj9UBMrHfieoynJTdER+8MxiTANiu1Nep4ioiQApgPWlgvgN2JILtyt2a
         UpvhkLNR/FKtSnnlBDWcY01UDm/3jMOKrtaCcLY9EhJIJblzlWnbD9gDHDAMZRH8bR
         i0WK9A7G1EwjNkDOwh9vb/U/jkyLL/g4Fo6qU09o=
Date:   Tue, 9 Aug 2022 12:38:04 +0200
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
Message-ID: <YvI5DJnOjhJbNnNO@kroah.com>
References: <20220809094300.83116-1-hadess@hadess.net>
 <20220809094300.83116-3-hadess@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809094300.83116-3-hadess@hadess.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 09, 2022 at 11:43:00AM +0200, Bastien Nocera wrote:
> This functionality allows a sufficiently privileged user-space process
> to upload a BPF programme that will call to usb_revoke_device() as if
> it were a kernel API.
> 
> This functionality will be used by logind to revoke access to devices on
> fast user-switching to start with.
> 
> logind, and other session management software, does not have access to
> the file descriptor used by the application so other identifiers
> are used.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
>  drivers/usb/core/usb.c | 51 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> index 2f71636af6e1..ca394848a51e 100644
> --- a/drivers/usb/core/usb.c
> +++ b/drivers/usb/core/usb.c
> @@ -38,6 +38,8 @@
>  #include <linux/workqueue.h>
>  #include <linux/debugfs.h>
>  #include <linux/usb/of.h>
> +#include <linux/btf.h>
> +#include <linux/btf_ids.h>
>  
>  #include <asm/io.h>
>  #include <linux/scatterlist.h>
> @@ -438,6 +440,41 @@ static int usb_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
>  	return 0;
>  }
>  
> +struct usb_revoke_match {
> +	int busnum, devnum; /* -1 to match all devices */
> +	int euid; /* -1 to match all users */
> +};
> +
> +static int
> +__usb_revoke(struct usb_device *udev, void *data)
> +{
> +	struct usb_revoke_match *match = data;
> +
> +	if (match->devnum >= 0 && match->busnum >= 0) {
> +		if (match->busnum != udev->bus->busnum ||
> +		    match->devnum != udev->devnum) {
> +			return 0;
> +		}
> +	}
> +
> +	usb_revoke_for_euid(udev, match->euid);

How are you not racing with other devices being added and removed at the
same time?

Again, please stick with the file descriptor, that's the unique thing
you know you have that you want to revoke.

Now if you really really want to disable a device from under a user,
without the file handle present, you can do that today, as root, by
doing the 'unbind' hack through userspace and sysfs.  It's so common
that this seems to be how virtual device managers handle virtual
machines, so it should be well tested by now.

or does usbfs not bind to the device it opens?

thanks,

greg k-h
