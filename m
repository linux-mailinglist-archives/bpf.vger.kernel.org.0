Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6298B58DC1A
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 18:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245029AbiHIQbv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 12:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiHIQbu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 12:31:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6634B192B4;
        Tue,  9 Aug 2022 09:31:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9B1C61309;
        Tue,  9 Aug 2022 16:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8352C433C1;
        Tue,  9 Aug 2022 16:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660062706;
        bh=uNw29mK1Mlh1KL7vZnOgkUs3nNrDx8EMzA3mp87viYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hr/NbRIS/Xbd65eaZlULA3ymti/BEggZHSLNg8HxAPiqm8xul7KcBoOqJV/ICgucg
         SjD3kUrrZx+kXwYmqaZ6X1QVdiagkmGVgz3IVDpd/zwVTSlNvlpsuTPidsrdUoXXCP
         sG0BUzQ4pxP5TOqjD2UKJqf2agXHblbQE0IDOLJY=
Date:   Tue, 9 Aug 2022 18:31:43 +0200
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
Message-ID: <YvKL79C4k7EpRaKh@kroah.com>
References: <20220809094300.83116-1-hadess@hadess.net>
 <20220809094300.83116-2-hadess@hadess.net>
 <YvI4em9fCdZgRPnY@kroah.com>
 <d2dc546d771060b0a95d663fb77158d63b75bb9b.camel@hadess.net>
 <YvJYmG/upX2NWRJJ@kroah.com>
 <b1af087bc41a47bc29a7192a5c268243ef54ad26.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1af087bc41a47bc29a7192a5c268243ef54ad26.camel@hadess.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 09, 2022 at 03:27:16PM +0200, Bastien Nocera wrote:
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

Please use lore.kernel.org.

Anyway, pointing to random old submissions of an RFC series does not
mean that you do not have to document and justify this design decision
in this patch submission.

Assume that reviewers have NO knowlege of previous submissions of your
patch series.  Because we usually do not, given how many changes we
review all the time.

Please resend this, as a v4, and update the changelog descriptions based
on the comments so far on this series and I will be glad to review it
sometime after -rc1 is out, as there's nothing I can do with it right
now.

thanks,

greg k-h
